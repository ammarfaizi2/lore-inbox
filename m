Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268505AbUH3Pqn@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268505AbUH3Pqn (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 30 Aug 2004 11:46:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268502AbUH3Pqm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 30 Aug 2004 11:46:42 -0400
Received: from mx1.redhat.com ([66.187.233.31]:40838 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S268505AbUH3PpU (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 30 Aug 2004 11:45:20 -0400
Date: Mon, 30 Aug 2004 08:44:55 -0700
From: Pete Zaitcev <zaitcev@redhat.com>
To: greg@kroah.com
Cc: zaitcev@redhat.com, linux-kernel@vger.kernel.org,
       linux-usb-devel@lists.sourceforge.net
Subject: Fixes for ub in 2.4.9-rc1 from Oliver and Pat
Message-Id: <20040830084455.54cfcc87@lembas.zaitcev.lan>
Organization: Red Hat, Inc.
X-Mailer: Sylpheed version 0.9.11claws (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

- Set the allocation size in REQUEST SENSE (Pat LaVarre)
- Move add_timer invocations to safer places (Oliver Neukum)

-- Pete

--- linux-2.6.9-rc1-mm1-ub/drivers/block/ub.c	2004-08-30 08:37:59.880881584 -0700
+++ linux-2.6.9-rc1-ub/drivers/block/ub.c	2004-08-27 12:24:25.000000000 -0700
@@ -786,17 +786,16 @@ static int ub_scsi_cmd_start(struct ub_d
 	sc->work_urb.error_count = 0;
 	sc->work_urb.status = 0;
 
-	sc->work_timer.expires = jiffies + UB_URB_TIMEOUT;
-	add_timer(&sc->work_timer);
-
 	if ((rc = usb_submit_urb(&sc->work_urb, GFP_ATOMIC)) != 0) {
 		/* XXX Clear stalls */
 		printk("ub: cmd #%d start failed (%d)\n", cmd->tag, rc); /* P3 */
-		del_timer(&sc->work_timer);
 		ub_complete(&sc->work_done);
 		return rc;
 	}
 
+	sc->work_timer.expires = jiffies + UB_URB_TIMEOUT;
+	add_timer(&sc->work_timer);
+
 	cmd->state = UB_CMDST_CMD;
 	ub_cmdtr_state(sc, cmd);
 	return 0;
@@ -968,18 +967,17 @@ static void ub_scsi_urb_compl(struct ub_
 		sc->work_urb.error_count = 0;
 		sc->work_urb.status = 0;
 
-		sc->work_timer.expires = jiffies + UB_URB_TIMEOUT;
-		add_timer(&sc->work_timer);
-
 		if ((rc = usb_submit_urb(&sc->work_urb, GFP_ATOMIC)) != 0) {
 			/* XXX Clear stalls */
 			printk("ub: data #%d submit failed (%d)\n", cmd->tag, rc); /* P3 */
-			del_timer(&sc->work_timer);
 			ub_complete(&sc->work_done);
 			ub_state_done(sc, cmd, rc);
 			return;
 		}
 
+		sc->work_timer.expires = jiffies + UB_URB_TIMEOUT;
+		add_timer(&sc->work_timer);
+
 		cmd->state = UB_CMDST_DATA;
 		ub_cmdtr_state(sc, cmd);
 
@@ -1063,19 +1061,18 @@ static void ub_scsi_urb_compl(struct ub_
 			sc->work_urb.error_count = 0;
 			sc->work_urb.status = 0;
 
-			sc->work_timer.expires = jiffies + UB_URB_TIMEOUT;
-			add_timer(&sc->work_timer);
-
 			rc = usb_submit_urb(&sc->work_urb, GFP_ATOMIC);
 			if (rc != 0) {
 				/* XXX Clear stalls */
 				printk("%s: CSW #%d submit failed (%d)\n",
 				   sc->name, cmd->tag, rc); /* P3 */
-				del_timer(&sc->work_timer);
 				ub_complete(&sc->work_done);
 				ub_state_done(sc, cmd, rc);
 				return;
 			}
+
+			sc->work_timer.expires = jiffies + UB_URB_TIMEOUT;
+			add_timer(&sc->work_timer);
 			return;
 		}
 
@@ -1186,18 +1183,17 @@ static void ub_state_stat(struct ub_dev 
 	sc->work_urb.error_count = 0;
 	sc->work_urb.status = 0;
 
-	sc->work_timer.expires = jiffies + UB_URB_TIMEOUT;
-	add_timer(&sc->work_timer);
-
 	if ((rc = usb_submit_urb(&sc->work_urb, GFP_ATOMIC)) != 0) {
 		/* XXX Clear stalls */
 		printk("ub: CSW #%d submit failed (%d)\n", cmd->tag, rc); /* P3 */
-		del_timer(&sc->work_timer);
 		ub_complete(&sc->work_done);
 		ub_state_done(sc, cmd, rc);
 		return;
 	}
 
+	sc->work_timer.expires = jiffies + UB_URB_TIMEOUT;
+	add_timer(&sc->work_timer);
+
 	cmd->stat_count = 0;
 	cmd->state = UB_CMDST_STAT;
 	ub_cmdtr_state(sc, cmd);
@@ -1217,9 +1213,17 @@ static void ub_state_sense(struct ub_dev
 		goto error;
 	}
 
+	/*
+	 * ``If the allocation length is eighteen or greater, and a device
+	 * server returns less than eithteen bytes of data, the application
+	 * client should assume that the bytes not transferred would have been
+	 * zeroes had the device server returned those bytes.''
+	 */
 	memset(&sc->top_sense, 0, UB_SENSE_SIZE);
+
 	scmd = &sc->top_rqs_cmd;
 	scmd->cdb[0] = REQUEST_SENSE;
+	scmd->cdb[4] = UB_SENSE_SIZE;
 	scmd->cdb_len = 6;
 	scmd->dir = UB_DIR_READ;
 	scmd->state = UB_CMDST_INIT;
@@ -1271,14 +1275,13 @@ static int ub_submit_clear_stall(struct 
 	sc->work_urb.error_count = 0;
 	sc->work_urb.status = 0;
 
-	sc->work_timer.expires = jiffies + UB_CTRL_TIMEOUT;
-	add_timer(&sc->work_timer);
-
 	if ((rc = usb_submit_urb(&sc->work_urb, GFP_ATOMIC)) != 0) {
-		del_timer(&sc->work_timer);
 		ub_complete(&sc->work_done);
 		return rc;
 	}
+
+	sc->work_timer.expires = jiffies + UB_CTRL_TIMEOUT;
+	add_timer(&sc->work_timer);
 	return 0;
 }
 
@@ -1289,6 +1292,9 @@ static void ub_top_sense_done(struct ub_
 	unsigned char *sense = scmd->data;
 	struct ub_scsi_cmd *cmd;
 
+	/*
+	 * Ignoring scmd->act_len, because the buffer was pre-zeroed.
+	 */
 	ub_cmdtr_sense(sc, scmd, sense);
 
 	if ((cmd = ub_cmdq_peek(sc)) == NULL) {
@@ -1725,19 +1731,18 @@ static int ub_probe_clear_stall(struct u
 	sc->work_urb.error_count = 0;
 	sc->work_urb.status = 0;
 
-	init_timer(&timer);
-	timer.function = ub_probe_timeout;
-	timer.data = (unsigned long) &compl;
-	timer.expires = jiffies + UB_CTRL_TIMEOUT;
-	add_timer(&timer);
-
 	if ((rc = usb_submit_urb(&sc->work_urb, GFP_KERNEL)) != 0) {
 		printk(KERN_WARNING
 		     "%s: Unable to submit a probe clear (%d)\n", sc->name, rc);
-		del_timer_sync(&timer);
 		return rc;
 	}
 
+	init_timer(&timer);
+	timer.function = ub_probe_timeout;
+	timer.data = (unsigned long) &compl;
+	timer.expires = jiffies + UB_CTRL_TIMEOUT;
+	add_timer(&timer);
+
 	wait_for_completion(&compl);
 
 	del_timer_sync(&timer);
