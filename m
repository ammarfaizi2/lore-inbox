Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261785AbVAHFVY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261785AbVAHFVY (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 8 Jan 2005 00:21:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261787AbVAHFVX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 8 Jan 2005 00:21:23 -0500
Received: from mx1.redhat.com ([66.187.233.31]:62386 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S261785AbVAHFVE (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 8 Jan 2005 00:21:04 -0500
Date: Fri, 7 Jan 2005 21:20:55 -0800
From: Pete Zaitcev <zaitcev@redhat.com>
To: greg@kroah.com
Cc: linux-kernel@vger.kernel.org, linux-usb-devel@lists.sourceforge.net,
       zaitcev@redhat.com
Subject: Patch to fix ub looping with a tag mismatch
Message-ID: <20050107212055.3592fcde@lembas.zaitcev.lan>
Organization: Red Hat, Inc.
X-Mailer: Sylpheed-Claws 0.9.12cvs126.2 (GTK+ 2.4.14; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

If a command times out, we resubmit a retry. Some devices, however, buffer
everything we send and then eventually reply to a command we have timed out
already. We receive a bad tag, send a new command, device replies to the
one sent before, and so on without end.

The fix is to flush pending replies if tags mismatch (by reading them).

Signed-off-by: Pete Zaitcev

diff -urp -X dontdiff linux-2.6.10/drivers/block/ub.c linux-2.6.10-ub/drivers/block/ub.c
--- linux-2.6.10/drivers/block/ub.c	2005-01-05 00:37:35.000000000 -0800
+++ linux-2.6.10-ub/drivers/block/ub.c	2005-01-07 21:10:12.901318978 -0800
@@ -108,7 +108,8 @@ struct ub_dev;
  */
 #define UB_URB_TIMEOUT	(HZ*2)
 #define UB_DATA_TIMEOUT	(HZ*5)	/* ZIP does spin-ups in the data phase */
-#define UB_CTRL_TIMEOUT	(HZ/2) /* 500ms ought to be enough to clear a stall */
+#define UB_STAT_TIMEOUT	(HZ*5)	/* Same spinups and eject for a dataless cmd. */
+#define UB_CTRL_TIMEOUT	(HZ/2)	/* 500ms ought to be enough to clear a stall */
 
 /*
  * An instance of a SCSI command in transit.
@@ -307,6 +308,7 @@ static void ub_scsi_action(unsigned long
 static void ub_scsi_dispatch(struct ub_dev *sc);
 static void ub_scsi_urb_compl(struct ub_dev *sc, struct ub_scsi_cmd *cmd);
 static void ub_state_done(struct ub_dev *sc, struct ub_scsi_cmd *cmd, int rc);
+static void __ub_state_stat(struct ub_dev *sc, struct ub_scsi_cmd *cmd);
 static void ub_state_stat(struct ub_dev *sc, struct ub_scsi_cmd *cmd);
 static void ub_state_sense(struct ub_dev *sc, struct ub_scsi_cmd *cmd);
 static int ub_submit_clear_stall(struct ub_dev *sc, struct ub_scsi_cmd *cmd,
@@ -894,7 +896,7 @@ static void ub_scsi_urb_compl(struct ub_
 		if (urb->status == -EPIPE) {
 			/*
 			 * STALL while clearning STALL.
-			 * A STALL is illegal on a control pipe!
+			 * The control pipe clears itself - nothing to do.
 			 * XXX Might try to reset the device here and retry.
 			 */
 			printk(KERN_NOTICE "%s: "
@@ -917,7 +919,7 @@ static void ub_scsi_urb_compl(struct ub_
 		if (urb->status == -EPIPE) {
 			/*
 			 * STALL while clearning STALL.
-			 * A STALL is illegal on a control pipe!
+			 * The control pipe clears itself - nothing to do.
 			 * XXX Might try to reset the device here and retry.
 			 */
 			printk(KERN_NOTICE "%s: "
@@ -941,7 +943,8 @@ static void ub_scsi_urb_compl(struct ub_
 			rc = ub_submit_clear_stall(sc, cmd, sc->last_pipe);
 			if (rc != 0) {
 				printk(KERN_NOTICE "%s: "
-				    "unable to submit clear for device %u (%d)\n",
+				    "unable to submit clear for device %u"
+				    " (code %d)\n",
 				    sc->name, sc->dev->devnum, rc);
 				/*
 				 * This is typically ENOMEM or some other such shit.
@@ -1001,7 +1004,8 @@ static void ub_scsi_urb_compl(struct ub_
 			rc = ub_submit_clear_stall(sc, cmd, sc->last_pipe);
 			if (rc != 0) {
 				printk(KERN_NOTICE "%s: "
-				    "unable to submit clear for device %u (%d)\n",
+				    "unable to submit clear for device %u"
+				    " (code %d)\n",
 				    sc->name, sc->dev->devnum, rc);
 				/*
 				 * This is typically ENOMEM or some other such shit.
@@ -1033,7 +1037,8 @@ static void ub_scsi_urb_compl(struct ub_
 			rc = ub_submit_clear_stall(sc, cmd, sc->last_pipe);
 			if (rc != 0) {
 				printk(KERN_NOTICE "%s: "
-				    "unable to submit clear for device %u (%d)\n",
+				    "unable to submit clear for device %u"
+				    " (code %d)\n",
 				    sc->name, sc->dev->devnum, rc);
 				/*
 				 * This is typically ENOMEM or some other such shit.
@@ -1061,33 +1066,7 @@ static void ub_scsi_urb_compl(struct ub_
 				    sc->name, sc->dev->devnum);
 				goto Bad_End;
 			}
-
-			/*
-			 * ub_state_stat only not dropping the count...
-			 */
-			UB_INIT_COMPLETION(sc->work_done);
-
-			sc->last_pipe = sc->recv_bulk_pipe;
-			usb_fill_bulk_urb(&sc->work_urb, sc->dev,
-			    sc->recv_bulk_pipe, &sc->work_bcs,
-			    US_BULK_CS_WRAP_LEN, ub_urb_complete, sc);
-			sc->work_urb.transfer_flags = URB_ASYNC_UNLINK;
-			sc->work_urb.actual_length = 0;
-			sc->work_urb.error_count = 0;
-			sc->work_urb.status = 0;
-
-			rc = usb_submit_urb(&sc->work_urb, GFP_ATOMIC);
-			if (rc != 0) {
-				/* XXX Clear stalls */
-				printk("%s: CSW #%d submit failed (%d)\n",
-				   sc->name, cmd->tag, rc); /* P3 */
-				ub_complete(&sc->work_done);
-				ub_state_done(sc, cmd, rc);
-				return;
-			}
-
-			sc->work_timer.expires = jiffies + UB_URB_TIMEOUT;
-			add_timer(&sc->work_timer);
+			__ub_state_stat(sc, cmd);
 			return;
 		}
 
@@ -1108,17 +1087,31 @@ static void ub_scsi_urb_compl(struct ub_
 			goto Bad_End;
 		}
 
+#if 0
 		if (bcs->Signature != cpu_to_le32(US_BULK_CS_SIGN) &&
 		    bcs->Signature != cpu_to_le32(US_BULK_CS_OLYMPUS_SIGN)) {
-			/* XXX Rate-limit, even for P3 tagged */
-			/* P3 */ printk("ub: signature 0x%x\n", bcs->Signature);
 			/* Windows ignores signatures, so do we. */
 		}
+#endif
 
 		if (bcs->Tag != cmd->tag) {
-			/* P3 */ printk("%s: tag orig 0x%x reply 0x%x\n",
-			    sc->name, cmd->tag, bcs->Tag);
-			goto Bad_End;
+			/*
+			 * This usually happens when we disagree with the
+			 * device's microcode about something. For instance,
+			 * a few of them throw this after timeouts. They buffer
+			 * commands and reply at commands we timed out before.
+			 * Without flushing these replies we loop forever.
+			 */
+			if (++cmd->stat_count >= 4) {
+				printk(KERN_NOTICE "%s: "
+				    "tag mismatch orig 0x%x reply 0x%x "
+				    "on device %u\n",
+				    sc->name, cmd->tag, bcs->Tag,
+				    sc->dev->devnum);
+				goto Bad_End;
+			}
+			__ub_state_stat(sc, cmd);
+			return;
 		}
 
 		switch (bcs->Status) {
@@ -1174,9 +1167,9 @@ static void ub_state_done(struct ub_dev 
 
 /*
  * Factorization helper for the command state machine:
- * Submit a CSW read and go to STAT state.
+ * Submit a CSW read.
  */
-static void ub_state_stat(struct ub_dev *sc, struct ub_scsi_cmd *cmd)
+static void __ub_state_stat(struct ub_dev *sc, struct ub_scsi_cmd *cmd)
 {
 	int rc;
 
@@ -1192,14 +1185,23 @@ static void ub_state_stat(struct ub_dev 
 
 	if ((rc = usb_submit_urb(&sc->work_urb, GFP_ATOMIC)) != 0) {
 		/* XXX Clear stalls */
-		printk("ub: CSW #%d submit failed (%d)\n", cmd->tag, rc); /* P3 */
+		printk("%s: CSW #%d submit failed (%d)\n", sc->name, cmd->tag, rc); /* P3 */
 		ub_complete(&sc->work_done);
 		ub_state_done(sc, cmd, rc);
 		return;
 	}
 
-	sc->work_timer.expires = jiffies + UB_URB_TIMEOUT;
+	sc->work_timer.expires = jiffies + UB_STAT_TIMEOUT;
 	add_timer(&sc->work_timer);
+}
+
+/*
+ * Factorization helper for the command state machine:
+ * Submit a CSW read and go to STAT state.
+ */
+static void ub_state_stat(struct ub_dev *sc, struct ub_scsi_cmd *cmd)
+{
+	__ub_state_stat(sc, cmd);
 
 	cmd->stat_count = 0;
 	cmd->state = UB_CMDST_STAT;
