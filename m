Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S268469AbTBNVdg>; Fri, 14 Feb 2003 16:33:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S268144AbTBNVLR>; Fri, 14 Feb 2003 16:11:17 -0500
Received: from 24-168-145-62.nj.rr.com ([24.168.145.62]:2604 "EHLO
	mail.larvalstage.com") by vger.kernel.org with ESMTP
	id <S268046AbTBNVIf>; Fri, 14 Feb 2003 16:08:35 -0500
Date: Fri, 14 Feb 2003 16:18:07 -0500 (EST)
From: John Kim <john@larvalstage.com>
To: linux-kernel@vger.kernel.org
Subject: [PATCH 2.5.60-bk4] fix compile breakage on drivers/scsi/NCR53C9x.c
Message-ID: <Pine.LNX.4.53.0302141614250.21601@quinn.larvalstage.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


This fixes compile breakage due to recent changes to scsi.h



--- linux-2.5.60-bk4/drivers/scsi/NCR53C9x.c	2003-02-10 13:38:03.000000000 -0500
+++ linux-2.5.60-bk4-new/drivers/scsi/NCR53C9x.c	2003-02-14 16:03:57.000000000 -0500
@@ -356,7 +356,7 @@
 	Scsi_Cmnd *ptr, *prev;
 
 	for(ptr = *SC, prev = NULL;
-	    ptr && ((ptr->target != target) || (ptr->lun != lun));
+	    ptr && ((ptr->device->id != target) || (ptr->device->lun != lun));
 	    prev = ptr, ptr = (Scsi_Cmnd *) ptr->host_scribble)
 		;
 	if(ptr) {
@@ -946,7 +946,7 @@
 
 static void esp_restore_pointers(struct NCR_ESP *esp, Scsi_Cmnd *sp)
 {
-	struct esp_pointers *ep = &esp->data_pointers[sp->target];
+	struct esp_pointers *ep = &esp->data_pointers[sp->device->id];
 
 	sp->SCp.ptr = ep->saved_ptr;
 	sp->SCp.buffer = ep->saved_buffer;
@@ -956,7 +956,7 @@
 
 static void esp_save_pointers(struct NCR_ESP *esp, Scsi_Cmnd *sp)
 {
-	struct esp_pointers *ep = &esp->data_pointers[sp->target];
+	struct esp_pointers *ep = &esp->data_pointers[sp->device->id];
 
 	ep->saved_ptr = sp->SCp.ptr;
 	ep->saved_buffer = sp->SCp.buffer;
@@ -1037,8 +1037,8 @@
 
 	SDptr = SCptr->device;
 	esp_dev = SDptr->hostdata;
-	lun = SCptr->lun;
-	target = SCptr->target;
+	lun = SCptr->device->lun;
+	target = SCptr->device->id;
 
 	esp->snip = 0;
 	esp->msgout_len = 0;
@@ -1249,7 +1249,7 @@
 	SCpnt->scsi_done = done;
 	SCpnt->SCp.phase = not_issued;
 
-	esp = (struct NCR_ESP *) SCpnt->host->hostdata;
+	esp = (struct NCR_ESP *) SCpnt->device->host->hostdata;
 
 	if(esp->dma_led_on)
 		esp->dma_led_on(esp);
@@ -1285,7 +1285,7 @@
 int esp_command(Scsi_Cmnd *SCpnt)
 {
 #ifdef DEBUG_ESP
-	struct NCR_ESP *esp = (struct NCR_ESP *) SCpnt->host->hostdata;
+	struct NCR_ESP *esp = (struct NCR_ESP *) SCpnt->device->host->hostdata;
 #endif
 
 	ESPLOG(("esp%d: esp_command() called...\n", esp->esp_id));
@@ -1297,7 +1297,7 @@
 {
 	ESPLOG(("[tgt<%02x> lun<%02x> "
 		"pphase<%s> cphase<%s>]",
-		SCptr->target, SCptr->lun,
+		SCptr->device->id, SCptr->device->lun,
 		phase_string(SCptr->SCp.sent_command),
 		phase_string(SCptr->SCp.phase)));
 }
@@ -1358,7 +1358,7 @@
 /* Abort a command.  The host_lock is acquired by caller. */
 int esp_abort(Scsi_Cmnd *SCptr)
 {
-	struct NCR_ESP *esp = (struct NCR_ESP *) SCptr->host->hostdata;
+	struct NCR_ESP *esp = (struct NCR_ESP *) SCptr->device->host->hostdata;
 	struct ESP_regs *eregs = esp->eregs;
 	int don;
 
@@ -1486,7 +1486,7 @@
  */
 int esp_reset(Scsi_Cmnd *SCptr)
 {
-	struct NCR_ESP *esp = (struct NCR_ESP *) SCptr->host->hostdata;
+	struct NCR_ESP *esp = (struct NCR_ESP *) SCptr->device->host->hostdata;
 
 	(void) esp_do_resetbus(esp, esp->eregs);
 
@@ -1716,13 +1716,13 @@
 	if(esp->prev_soff  != esp_dev->sync_max_offset ||
 	   esp->prev_stp   != esp_dev->sync_min_period ||
 	   (esp->erev > esp100a &&
-	    esp->prev_cfg3 != esp->config3[sp->target])) {
+	    esp->prev_cfg3 != esp->config3[sp->device->id])) {
 		esp->prev_soff = esp_dev->sync_max_offset;
 		esp_write(eregs->esp_soff, esp->prev_soff);
 		esp->prev_stp = esp_dev->sync_min_period;
 		esp_write(eregs->esp_stp, esp->prev_stp);
 		if(esp->erev > esp100a) {
-			esp->prev_cfg3 = esp->config3[sp->target];
+			esp->prev_cfg3 = esp->config3[sp->device->id];
 			esp_write(eregs->esp_cfg3, esp->prev_cfg3);
 		} 
 	}
@@ -2117,7 +2117,7 @@
 			esp->esp_id,
 			SCptr->use_sg, SCptr->SCp.ptr, SCptr->SCp.this_residual));
 		ESPLOG(("esp%d: Forcing async for target %d\n", esp->esp_id, 
-			SCptr->target));
+			SCptr->device->id));
 		SCptr->device->borken = 1;
 		esp_dev->sync = 0;
 		bytes_sent = 0;
@@ -2225,7 +2225,7 @@
 
 		if(SCptr->SCp.Status != GOOD &&
 		   SCptr->SCp.Status != CONDITION_GOOD &&
-		   ((1<<SCptr->target) & esp->targets_present) &&
+		   ((1<<SCptr->device->id) & esp->targets_present) &&
 		   esp_dev->sync && esp_dev->sync_max_offset) {
 			/* SCSI standard says that the synchronous capabilities
 			 * should be renegotiated at this point.  Most likely
@@ -2283,21 +2283,21 @@
 	sp = esp->issue_SC;
 	ESPLOG(("esp%d: issue_SC[", esp->esp_id));
 	while(sp) {
-		ESPLOG(("<%02x,%02x>", sp->target, sp->lun));
+		ESPLOG(("<%02x,%02x>", sp->device->id, sp->device->lun));
 		sp = (Scsi_Cmnd *) sp->host_scribble;
 	}
 	ESPLOG(("]\n"));
 	sp = esp->current_SC;
 	ESPLOG(("esp%d: current_SC[", esp->esp_id));
 	while(sp) {
-		ESPLOG(("<%02x,%02x>", sp->target, sp->lun));
+		ESPLOG(("<%02x,%02x>", sp->device->id, sp->device->lun));
 		sp = (Scsi_Cmnd *) sp->host_scribble;
 	}
 	ESPLOG(("]\n"));
 	sp = esp->disconnected_SC;
 	ESPLOG(("esp%d: disconnected_SC[", esp->esp_id));
 	while(sp) {
-		ESPLOG(("<%02x,%02x>", sp->target, sp->lun));
+		ESPLOG(("<%02x,%02x>", sp->device->id, sp->device->lun));
 		sp = (Scsi_Cmnd *) sp->host_scribble;
 	}
 	ESPLOG(("]\n"));
@@ -2617,7 +2617,7 @@
 	 */
 	if(esp->ireg == (ESP_INTR_FDONE | ESP_INTR_BSERV)) {
 		/* target speaks... */
-		esp->targets_present |= (1<<SCptr->target);
+		esp->targets_present |= (1<<SCptr->device->id);
 
 		/* What if the target ignores the sdtr? */
 		if(esp->snip)
@@ -2646,7 +2646,7 @@
 			 * XXX for synchronous transfers.
 			 */
 			ESPLOG(("esp%d: STEP_ASEL for tgt %d\n",
-				esp->esp_id, SCptr->target));
+				esp->esp_id, SCptr->device->id));
 
 		case ESP_STEP_SID:
 			/* Arbitration won, target selected, went
@@ -2763,14 +2763,14 @@
 		if(esp->disconnected_SC)
 			esp_cmd(esp, eregs, ESP_CMD_ESEL);
 
-		if(((1<<SCptr->target) & esp->targets_present) &&
+		if(((1<<SCptr->device->id) & esp->targets_present) &&
 		   esp->seqreg && esp->cur_msgout[0] == EXTENDED_MESSAGE &&
 		   (SCptr->SCp.phase == in_slct_msg ||
 		    SCptr->SCp.phase == in_slct_stop)) {
 			/* shit */
 			esp->snip = 0;
 			ESPLOG(("esp%d: Failed synchronous negotiation for target %d "
-				"lun %d\n", esp->esp_id, SCptr->target, SCptr->lun));
+				"lun %d\n", esp->esp_id, SCptr->device->id, SCptr->device->lun));
 			esp_dev->sync_max_offset = 0;
 			esp_dev->sync_min_period = 0;
 			esp_dev->sync = 1; /* so we don't negotiate again */
@@ -2796,9 +2796,9 @@
 		 * or whenever when we are scanning the bus for targets.
 		 * But first make sure that is really what is happening.
 		 */
-		if(((1<<SCptr->target) & esp->targets_present)) {
+		if(((1<<SCptr->device->id) & esp->targets_present)) {
 			ESPLOG(("esp%d: Warning, live target %d not responding to "
-				"selection.\n", esp->esp_id, SCptr->target));
+				"selection.\n", esp->esp_id, SCptr->device->id));
 
 			/* This _CAN_ happen.  The SCSI standard states that
 			 * the target is to _not_ respond to selection if
@@ -2892,7 +2892,7 @@
 
 	case NOP:
 		ESPLOG(("esp%d: target %d sends a nop\n", esp->esp_id,
-			esp->current_SC->target));
+			esp->current_SC->device->id));
 		return 0;
 
 	case RESTORE_POINTERS:
@@ -2985,7 +2985,7 @@
 		 * sibling call optimization.  -DaveM
 		 */
 		ESPLOG((KERN_INFO "esp%d: target %d ",
-			esp->esp_id, esp->current_SC->target));
+			esp->esp_id, esp->current_SC->device->id));
 		ESPLOG(("[period %dns offset %d %d.%02dMHz ",
 			(int) msg3 * 4, (int) msg4,
 			integer, fraction));
@@ -2993,7 +2993,7 @@
 			(((msg3 * 4) < 200) ? "-II" : "")));
 	} else {
 		ESPLOG((KERN_INFO "esp%d: target %d asynchronous\n",
-			esp->esp_id, esp->current_SC->target));
+			esp->esp_id, esp->current_SC->device->id));
 	}
 }
 
@@ -3070,10 +3070,10 @@
 				else
 					bit = ESP_CONFIG3_FSCSI;
 				if(period < 50)
-					esp->config3[SCptr->target] |= bit;
+					esp->config3[SCptr->device->id] |= bit;
 				else
-					esp->config3[SCptr->target] &= ~bit;
-				esp->prev_cfg3 = esp->config3[SCptr->target];
+					esp->config3[SCptr->device->id] &= ~bit;
+				esp->prev_cfg3 = esp->config3[SCptr->device->id];
 				esp_write(eregs->esp_cfg3, esp->prev_cfg3);
 			}
 			esp->prev_soff = esp_dev->sync_min_period;
@@ -3103,8 +3103,8 @@
 					bit = ESP_CONFIG3_FAST;
 				else
 					bit = ESP_CONFIG3_FSCSI;
-				esp->config3[SCptr->target] &= ~bit;
-				esp->prev_cfg3 = esp->config3[SCptr->target];
+				esp->config3[SCptr->device->id] &= ~bit;
+				esp->prev_cfg3 = esp->config3[SCptr->device->id];
 				esp_write(eregs->esp_cfg3, esp->prev_cfg3);
 			}
 		}
@@ -3493,7 +3493,7 @@
 			 * a nexus is alive on the bus.
 			 */
 			ESPLOG(("esp%d: Forcing async and disabling disconnect for "
-				"target %d\n", esp->esp_id, SCptr->target));
+				"target %d\n", esp->esp_id, SCptr->device->id));
 			SCptr->device->borken = 1; /* foo on you */
 		}
 
