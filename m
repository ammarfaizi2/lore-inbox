Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S268336AbTBNVSK>; Fri, 14 Feb 2003 16:18:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S268237AbTBNVQs>; Fri, 14 Feb 2003 16:16:48 -0500
Received: from 24-168-145-62.nj.rr.com ([24.168.145.62]:21036 "EHLO
	mail.larvalstage.com") by vger.kernel.org with ESMTP
	id <S268046AbTBNVQV>; Fri, 14 Feb 2003 16:16:21 -0500
Date: Fri, 14 Feb 2003 16:25:53 -0500 (EST)
From: John Kim <john@larvalstage.com>
To: linux-kernel@vger.kernel.org
Subject: [PATCH 2.5.60-bk4] fix compile breakage on drivers/scsi/ibmmca.c
Message-ID: <Pine.LNX.4.53.0302141624420.21601@quinn.larvalstage.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


This fixes compile breakage due to recent changes to scsi.h

John Kim


--- linux-2.5.60-bk4/drivers/scsi/ibmmca.c	2003-02-10 13:37:58.000000000 -0500
+++ linux-2.5.60-bk4-new/drivers/scsi/ibmmca.c	2003-02-14 16:10:27.000000000 -0500
@@ -1824,7 +1824,7 @@
 	int i;
 	struct scatterlist *sl;
 
-	shpnt = cmd->host;
+	shpnt = cmd->device->host;
 	/* search for the right hostadapter */
 	for (host_index = 0; hosts[host_index] && hosts[host_index]->host_no != shpnt->host_no; host_index++);
 
@@ -1836,16 +1836,16 @@
 	}
 	max_pun = subsystem_maxid(host_index);
 	if (ibm_ansi_order) {
-		target = max_pun - 1 - cmd->target;
-		if ((target <= subsystem_pun(host_index)) && (cmd->target <= subsystem_pun(host_index)))
+		target = max_pun - 1 - cmd->device->id;
+		if ((target <= subsystem_pun(host_index)) && (cmd->device->id <= subsystem_pun(host_index)))
 			target--;
-		else if ((target >= subsystem_pun(host_index)) && (cmd->target >= subsystem_pun(host_index)))
+		else if ((target >= subsystem_pun(host_index)) && (cmd->device->id >= subsystem_pun(host_index)))
 			target++;
 	} else
-		target = cmd->target;
+		target = cmd->device->id;
 
 	/* if (target,lun) is NO LUN or not existing at all, return error */
-	if ((get_scsi(host_index)[target][cmd->lun] == TYPE_NO_LUN) || (get_scsi(host_index)[target][cmd->lun] == TYPE_NO_DEVICE)) {
+	if ((get_scsi(host_index)[target][cmd->device->lun] == TYPE_NO_LUN) || (get_scsi(host_index)[target][cmd->device->lun] == TYPE_NO_DEVICE)) {
 		cmd->result = DID_NO_CONNECT << 16;
 		if (done)
 			done(cmd);
@@ -1853,7 +1853,7 @@
 	}
 
 	/*if (target,lun) unassigned, do further checks... */
-	ldn = get_ldn(host_index)[target][cmd->lun];
+	ldn = get_ldn(host_index)[target][cmd->device->lun];
 	if (ldn >= MAX_LOG_DEV) {	/* on invalid ldn do special stuff */
 		if (ldn > MAX_LOG_DEV) {	/* dynamical remapping if ldn unassigned */
 			current_ldn = next_ldn(host_index);	/* stop-value for one circle */
@@ -1864,7 +1864,7 @@
 					next_ldn(host_index) = 7;
 				if (current_ldn == next_ldn(host_index)) {	/* One circle done ? */
 					/* no non-processing ldn found */
-					printk("IBM MCA SCSI: Cannot assign SCSI-device dynamically!\n" "              On ldn 7-14 SCSI-commands everywhere in progress.\n" "              Reporting DID_NO_CONNECT for device (%d,%d).\n", target, cmd->lun);
+					printk("IBM MCA SCSI: Cannot assign SCSI-device dynamically!\n" "              On ldn 7-14 SCSI-commands everywhere in progress.\n" "              Reporting DID_NO_CONNECT for device (%d,%d).\n", target, cmd->device->lun);
 					cmd->result = DID_NO_CONNECT << 16;	/* return no connect */
 					if (done)
 						done(cmd);
@@ -1884,26 +1884,26 @@
 			/* set reduced interrupt_handler-mode for checking */
 			local_checking_phase_flag(host_index) = 1;
 			/* map found ldn to pun,lun */
-			get_ldn(host_index)[target][cmd->lun] = next_ldn(host_index);
+			get_ldn(host_index)[target][cmd->device->lun] = next_ldn(host_index);
 			/* change ldn to the right value, that is now next_ldn */
 			ldn = next_ldn(host_index);
 			/* unassign all ldns (pun,lun,ldn does not matter for remove) */
 			immediate_assign(host_index, 0, 0, 0, REMOVE_LDN);
 			/* set only LDN for remapped device */
-			immediate_assign(host_index, target, cmd->lun, ldn, SET_LDN);
+			immediate_assign(host_index, target, cmd->device->lun, ldn, SET_LDN);
 			/* get device information for ld[ldn] */
 			if (device_exists(host_index, ldn, &ld(host_index)[ldn].block_length, &ld(host_index)[ldn].device_type)) {
 				ld(host_index)[ldn].cmd = NULL;	/* To prevent panic set 0, because
 								   devices that were not assigned,
 								   should have nothing in progress. */
-				get_scsi(host_index)[target][cmd->lun] = ld(host_index)[ldn].device_type;
+				get_scsi(host_index)[target][cmd->device->lun] = ld(host_index)[ldn].device_type;
 				/* increase assignment counters for statistics in /proc */
 				IBM_DS(host_index).dynamical_assignments++;
 				IBM_DS(host_index).ldn_assignments[ldn]++;
 			} else
 				/* panic here, because a device, found at boottime has
 				   vanished */
-				panic("IBM MCA SCSI: ldn=0x%x, SCSI-device on (%d,%d) vanished!\n", ldn, target, cmd->lun);
+				panic("IBM MCA SCSI: ldn=0x%x, SCSI-device on (%d,%d) vanished!\n", ldn, target, cmd->device->lun);
 			/* unassign again all ldns (pun,lun,ldn does not matter for remove) */
 			immediate_assign(host_index, 0, 0, 0, REMOVE_LDN);
 			/* remap all ldns, as written in the pun/lun table */
@@ -2141,7 +2141,7 @@
 	printk("IBM MCA SCSI: Abort subroutine called...\n");
 #endif
 
-	shpnt = cmd->host;
+	shpnt = cmd->device->host;
 	/* search for the right hostadapter */
 	for (host_index = 0; hosts[host_index] && hosts[host_index]->host_no != shpnt->host_no; host_index++);
 
@@ -2149,7 +2149,7 @@
 		cmd->result = DID_NO_CONNECT << 16;
 		if (cmd->scsi_done)
 			(cmd->scsi_done) (cmd);
-		shpnt = cmd->host;
+		shpnt = cmd->device->host;
 #ifdef IM_DEBUG_PROBE
 		printk(KERN_DEBUG "IBM MCA SCSI: Abort adapter selection failed!\n");
 #endif
@@ -2157,17 +2157,17 @@
 	}
 	max_pun = subsystem_maxid(host_index);
 	if (ibm_ansi_order) {
-		target = max_pun - 1 - cmd->target;
-		if ((target <= subsystem_pun(host_index)) && (cmd->target <= subsystem_pun(host_index)))
+		target = max_pun - 1 - cmd->device->id;
+		if ((target <= subsystem_pun(host_index)) && (cmd->device->id <= subsystem_pun(host_index)))
 			target--;
-		else if ((target >= subsystem_pun(host_index)) && (cmd->target >= subsystem_pun(host_index)))
+		else if ((target >= subsystem_pun(host_index)) && (cmd->device->id >= subsystem_pun(host_index)))
 			target++;
 	} else
-		target = cmd->target;
+		target = cmd->device->id;
 
 	/* get logical device number, and disable system interrupts */
-	printk(KERN_WARNING "IBM MCA SCSI: Sending abort to device pun=%d, lun=%d.\n", target, cmd->lun);
-	ldn = get_ldn(host_index)[target][cmd->lun];
+	printk(KERN_WARNING "IBM MCA SCSI: Sending abort to device pun=%d, lun=%d.\n", target, cmd->device->lun);
+	ldn = get_ldn(host_index)[target][cmd->device->lun];
 
 	/*if cmd for this ldn has already finished, no need to abort */
 	if (!ld(host_index)[ldn].cmd) {
@@ -2242,7 +2242,7 @@
 		BUG();
 
 	ticks = IM_RESET_DELAY * HZ;
-	shpnt = cmd->host;
+	shpnt = cmd->device->host;
 	/* search for the right hostadapter */
 	for (host_index = 0; hosts[host_index] && hosts[host_index]->host_no != shpnt->host_no; host_index++);
 
