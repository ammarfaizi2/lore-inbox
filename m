Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263204AbVGOE2G@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263204AbVGOE2G (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 15 Jul 2005 00:28:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263205AbVGOE2G
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 15 Jul 2005 00:28:06 -0400
Received: from mx1.redhat.com ([66.187.233.31]:19903 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S263204AbVGOE1k (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 15 Jul 2005 00:27:40 -0400
Date: Thu, 14 Jul 2005 21:27:30 -0700
From: Pete Zaitcev <zaitcev@redhat.com>
To: greg@kroah.com
Cc: zaitcev@redhat.com, linux-usb-devel@lists.sourceforge.net,
       linux-kernel@vger.kernel.org
Subject: Patch for ub and blank CDs in 2.6.12
Message-Id: <20050714212730.6cacc02f.zaitcev@redhat.com>
Organization: Red Hat, Inc.
X-Mailer: Sylpheed version 2.0.0beta3 (GTK+ 2.6.7; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This patch fixes a microcode lockup in my CD-ROM adapters when a blank
CD is inserted. However, do not try to burn CDs yet! I'm pretty sure
that trying it will end in coasters.

 - Fix a few cases where we were unable to resynchronize with replies
   for previous commands. The main thing is to keep reading replies
   in case of a stall. This is done with the new state CLRRS.
 - Since I am forgetting the basic state machine already, document it.
 - Move counter increments in the looping path in its own function.
 - Fix a harmless buglet in case CSW read fails to submit: do not
   override state.
 - Implement the Alan Stern's idea for adaptive signature checking.

Signed-off-by: Pete Zaitcev <zaitcev@yahoo.com>

diff -urp -X dontdiff linux-2.6.12/drivers/block/ub.c linux-2.6.12-lem/drivers/block/ub.c
--- linux-2.6.12/drivers/block/ub.c	2005-06-21 12:58:18.000000000 -0700
+++ linux-2.6.12-lem/drivers/block/ub.c	2005-07-14 21:25:03.000000000 -0700
@@ -23,6 +23,7 @@
  *  -- Exterminate P3 printks
  *  -- Resove XXX's
  *  -- Redo "benh's retries", perhaps have spin-up code to handle them. V:D=?
+ *  -- CLEAR, CLR2STS, CLRRS seem to be ripe for refactoring.
  */
 #include <linux/kernel.h>
 #include <linux/module.h>
@@ -38,6 +39,73 @@
 #define UB_MAJOR 180
 
 /*
+ * The command state machine is the key model for understanding of this driver.
+ *
+ * The general rule is that all transitions are done towards the bottom
+ * of the diagram, thus preventing any loops.
+ *
+ * An exception to that is how the STAT state is handled. A counter allows it
+ * to be re-entered along the path marked with [C].
+ *
+ *       +--------+
+ *       ! INIT   !
+ *       +--------+
+ *           !
+ *        ub_scsi_cmd_start fails ->--------------------------------------\
+ *           !                                                            !
+ *           V                                                            !
+ *       +--------+                                                       !
+ *       ! CMD    !                                                       !
+ *       +--------+                                                       !
+ *           !                                            +--------+      !
+ *         was -EPIPE -->-------------------------------->! CLEAR  !      !
+ *           !                                            +--------+      !
+ *           !                                                !           !
+ *         was error -->------------------------------------- ! --------->\
+ *           !                                                !           !
+ *  /--<-- cmd->dir == NONE ?                                 !           !
+ *  !        !                                                !           !
+ *  !        V                                                !           !
+ *  !    +--------+                                           !           !
+ *  !    ! DATA   !                                           !           !
+ *  !    +--------+                                           !           !
+ *  !        !                           +---------+          !           !
+ *  !      was -EPIPE -->--------------->! CLR2STS !          !           !
+ *  !        !                           +---------+          !           !
+ *  !        !                                !               !           !
+ *  !        !                              was error -->---- ! --------->\
+ *  !      was error -->--------------------- ! ------------- ! --------->\
+ *  !        !                                !               !           !
+ *  !        V                                !               !           !
+ *  \--->+--------+                           !               !           !
+ *       ! STAT   !<--------------------------/               !           !
+ *  /--->+--------+                                           !           !
+ *  !        !                                                !           !
+ * [C]     was -EPIPE -->-----------\                         !           !
+ *  !        !                      !                         !           !
+ *  +<---- len == 0                 !                         !           !
+ *  !        !                      !                         !           !
+ *  !      was error -->--------------------------------------!---------->\
+ *  !        !                      !                         !           !
+ *  +<---- bad CSW                  !                         !           !
+ *  +<---- bad tag                  !                         !           !
+ *  !        !                      V                         !           !
+ *  !        !                 +--------+                     !           !
+ *  !        !                 ! CLRRS  !                     !           !
+ *  !        !                 +--------+                     !           !
+ *  !        !                      !                         !           !
+ *  \------- ! --------------------[C]--------\               !           !
+ *           !                                !               !           !
+ *         cmd->error---\                +--------+           !           !
+ *           !          +--------------->! SENSE  !<----------/           !
+ *         STAT_FAIL----/                +--------+                       !
+ *           !                                !                           V
+ *           !                                V                      +--------+
+ *           \--------------------------------\--------------------->! DONE   !
+ *                                                                   +--------+
+ */
+
+/*
  * Definitions which have to be scattered once we understand the layout better.
  */
 
@@ -91,8 +159,6 @@ struct bulk_cs_wrap {
 
 #define US_BULK_CS_WRAP_LEN	13
 #define US_BULK_CS_SIGN		0x53425355	/* spells out 'USBS' */
-/* This is for Olympus Camedia digital cameras */
-#define US_BULK_CS_OLYMPUS_SIGN	0x55425355	/* spells out 'USBU' */
 #define US_BULK_STAT_OK		0
 #define US_BULK_STAT_FAIL	1
 #define US_BULK_STAT_PHASE	2
@@ -135,6 +201,7 @@ enum ub_scsi_cmd_state {
 	UB_CMDST_CLR2STS,		/* Clearing before requesting status */
 	UB_CMDST_STAT,			/* Status phase */
 	UB_CMDST_CLEAR,			/* Clearing a stall (halt, actually) */
+	UB_CMDST_CLRRS,			/* Clearing before retrying status */
 	UB_CMDST_SENSE,			/* Sending Request Sense */
 	UB_CMDST_DONE			/* Final state */
 };
@@ -146,6 +213,7 @@ static char *ub_scsi_cmd_stname[] = {
 	"c2s",
 	"sts",
 	"clr",
+	"crs",
 	"Sen",
 	"fin"
 };
@@ -316,6 +384,7 @@ struct ub_dev {
 	struct urb work_urb;
 	struct timer_list work_timer;
 	int last_pipe;			/* What might need clearing */
+	__le32 signature;		/* Learned signature */
 	struct bulk_cb_wrap work_bcb;
 	struct bulk_cs_wrap work_bcs;
 	struct usb_ctrlrequest work_cr;
@@ -339,8 +408,9 @@ static void ub_scsi_action(unsigned long
 static void ub_scsi_dispatch(struct ub_dev *sc);
 static void ub_scsi_urb_compl(struct ub_dev *sc, struct ub_scsi_cmd *cmd);
 static void ub_state_done(struct ub_dev *sc, struct ub_scsi_cmd *cmd, int rc);
-static void __ub_state_stat(struct ub_dev *sc, struct ub_scsi_cmd *cmd);
+static int __ub_state_stat(struct ub_dev *sc, struct ub_scsi_cmd *cmd);
 static void ub_state_stat(struct ub_dev *sc, struct ub_scsi_cmd *cmd);
+static void ub_state_stat_counted(struct ub_dev *sc, struct ub_scsi_cmd *cmd);
 static void ub_state_sense(struct ub_dev *sc, struct ub_scsi_cmd *cmd);
 static int ub_submit_clear_stall(struct ub_dev *sc, struct ub_scsi_cmd *cmd,
     int stalled_pipe);
@@ -1085,6 +1155,28 @@ static void ub_scsi_urb_compl(struct ub_
 
 		ub_state_stat(sc, cmd);
 
+	} else if (cmd->state == UB_CMDST_CLRRS) {
+		if (urb->status == -EPIPE) {
+			/*
+			 * STALL while clearning STALL.
+			 * The control pipe clears itself - nothing to do.
+			 * XXX Might try to reset the device here and retry.
+			 */
+			printk(KERN_NOTICE "%s: stall on control pipe\n",
+			    sc->name);
+			goto Bad_End;
+		}
+
+		/*
+		 * We ignore the result for the halt clear.
+		 */
+
+		/* reset the endpoint toggle */
+		usb_settoggle(sc->dev, usb_pipeendpoint(sc->last_pipe),
+			usb_pipeout(sc->last_pipe), 0);
+
+		ub_state_stat_counted(sc, cmd);
+
 	} else if (cmd->state == UB_CMDST_CMD) {
 		if (urb->status == -EPIPE) {
 			rc = ub_submit_clear_stall(sc, cmd, sc->last_pipe);
@@ -1190,52 +1282,57 @@ static void ub_scsi_urb_compl(struct ub_
 				 */
 				goto Bad_End;
 			}
-			cmd->state = UB_CMDST_CLEAR;
+
+			/*
+			 * Having a stall when getting CSW is an error, so
+			 * make sure uppper levels are not oblivious to it.
+			 */
+			cmd->error = -EIO;		/* A cheap trick... */
+
+			cmd->state = UB_CMDST_CLRRS;
 			ub_cmdtr_state(sc, cmd);
 			return;
 		}
+		if (urb->status == -EOVERFLOW) {
+			/*
+			 * XXX We are screwed here. Retrying is pointless,
+			 * because the pipelined data will not get in until
+			 * we read with a big enough buffer. We must reset XXX.
+			 */
+			goto Bad_End;
+		}
 		if (urb->status != 0)
 			goto Bad_End;
 
 		if (urb->actual_length == 0) {
-			/*
-			 * Some broken devices add unnecessary zero-length
-			 * packets to the end of their data transfers.
-			 * Such packets show up as 0-length CSWs. If we
-			 * encounter such a thing, try to read the CSW again.
-			 */
-			if (++cmd->stat_count >= 4) {
-				printk(KERN_NOTICE "%s: unable to get CSW\n",
-				    sc->name);
-				goto Bad_End;
-			}
-			__ub_state_stat(sc, cmd);
+			ub_state_stat_counted(sc, cmd);
 			return;
 		}
 
 		/*
 		 * Check the returned Bulk protocol status.
+		 * The status block has to be validated first.
 		 */
 
 		bcs = &sc->work_bcs;
-		rc = le32_to_cpu(bcs->Residue);
-		if (rc != cmd->len - cmd->act_len) {
+
+		if (sc->signature == cpu_to_le32(0)) {
 			/*
-			 * It is all right to transfer less, the caller has
-			 * to check. But it's not all right if the device
-			 * counts disagree with our counts.
+			 * This is the first reply, so do not perform the check.
+			 * Instead, remember the signature the device uses
+			 * for future checks. But do not allow a nul.
 			 */
-			/* P3 */ printk("%s: resid %d len %d act %d\n",
-			    sc->name, rc, cmd->len, cmd->act_len);
-			goto Bad_End;
-		}
-
-#if 0
-		if (bcs->Signature != cpu_to_le32(US_BULK_CS_SIGN) &&
-		    bcs->Signature != cpu_to_le32(US_BULK_CS_OLYMPUS_SIGN)) {
-			/* Windows ignores signatures, so do we. */
+			sc->signature = bcs->Signature;
+			if (sc->signature == cpu_to_le32(0)) {
+				ub_state_stat_counted(sc, cmd);
+				return;
+			}
+		} else {
+			if (bcs->Signature != sc->signature) {
+				ub_state_stat_counted(sc, cmd);
+				return;
+			}
 		}
-#endif
 
 		if (bcs->Tag != cmd->tag) {
 			/*
@@ -1245,16 +1342,22 @@ static void ub_scsi_urb_compl(struct ub_
 			 * commands and reply at commands we timed out before.
 			 * Without flushing these replies we loop forever.
 			 */
-			if (++cmd->stat_count >= 4) {
-				printk(KERN_NOTICE "%s: "
-				    "tag mismatch orig 0x%x reply 0x%x\n",
-				    sc->name, cmd->tag, bcs->Tag);
-				goto Bad_End;
-			}
-			__ub_state_stat(sc, cmd);
+			ub_state_stat_counted(sc, cmd);
 			return;
 		}
 
+		rc = le32_to_cpu(bcs->Residue);
+		if (rc != cmd->len - cmd->act_len) {
+			/*
+			 * It is all right to transfer less, the caller has
+			 * to check. But it's not all right if the device
+			 * counts disagree with our counts.
+			 */
+			/* P3 */ printk("%s: resid %d len %d act %d\n",
+			    sc->name, rc, cmd->len, cmd->act_len);
+			goto Bad_End;
+		}
+
 		switch (bcs->Status) {
 		case US_BULK_STAT_OK:
 			break;
@@ -1272,6 +1375,10 @@ static void ub_scsi_urb_compl(struct ub_
 		}
 
 		/* Not zeroing error to preserve a babble indicator */
+		if (cmd->error != 0) {
+			ub_state_sense(sc, cmd);
+			return;
+		}
 		cmd->state = UB_CMDST_DONE;
 		ub_cmdtr_state(sc, cmd);
 		ub_cmdq_pop(sc);
@@ -1310,7 +1417,7 @@ static void ub_state_done(struct ub_dev 
  * Factorization helper for the command state machine:
  * Submit a CSW read.
  */
-static void __ub_state_stat(struct ub_dev *sc, struct ub_scsi_cmd *cmd)
+static int __ub_state_stat(struct ub_dev *sc, struct ub_scsi_cmd *cmd)
 {
 	int rc;
 
@@ -1328,11 +1435,12 @@ static void __ub_state_stat(struct ub_de
 		/* XXX Clear stalls */
 		ub_complete(&sc->work_done);
 		ub_state_done(sc, cmd, rc);
-		return;
+		return -1;
 	}
 
 	sc->work_timer.expires = jiffies + UB_STAT_TIMEOUT;
 	add_timer(&sc->work_timer);
+	return 0;
 }
 
 /*
@@ -1341,7 +1449,9 @@ static void __ub_state_stat(struct ub_de
  */
 static void ub_state_stat(struct ub_dev *sc, struct ub_scsi_cmd *cmd)
 {
-	__ub_state_stat(sc, cmd);
+
+	if (__ub_state_stat(sc, cmd) != 0)
+		return;
 
 	cmd->stat_count = 0;
 	cmd->state = UB_CMDST_STAT;
@@ -1350,6 +1460,25 @@ static void ub_state_stat(struct ub_dev 
 
 /*
  * Factorization helper for the command state machine:
+ * Submit a CSW read and go to STAT state with counter (along [C] path).
+ */
+static void ub_state_stat_counted(struct ub_dev *sc, struct ub_scsi_cmd *cmd)
+{
+
+	if (++cmd->stat_count >= 4) {
+		ub_state_sense(sc, cmd);
+		return;
+	}
+
+	if (__ub_state_stat(sc, cmd) != 0)
+		return;
+
+	cmd->state = UB_CMDST_STAT;
+	ub_cmdtr_state(sc, cmd);
+}
+
+/*
+ * Factorization helper for the command state machine:
  * Submit a REQUEST SENSE and go to SENSE state.
  */
 static void ub_state_sense(struct ub_dev *sc, struct ub_scsi_cmd *cmd)
