Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267781AbTBNU6u>; Fri, 14 Feb 2003 15:58:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267529AbTBNU4v>; Fri, 14 Feb 2003 15:56:51 -0500
Received: from lightning.swansea.linux.org.uk ([194.168.151.1]:24330 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S267528AbTBNUzM>; Fri, 14 Feb 2003 15:55:12 -0500
Subject: PATCH: fix ppa for new scsi
To: torvalds@transmeta.com, linux-kernel@vger.kernel.org
Date: Fri, 14 Feb 2003 21:05:09 +0000 (GMT)
X-Mailer: ELM [version 2.5 PL6]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E18jn1B-0005gQ-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

diff -u --new-file --recursive --exclude-from /usr/src/exclude linux-2.5.60-ref/drivers/scsi/ppa.c linux-2.5.60-ac1/drivers/scsi/ppa.c
--- linux-2.5.60-ref/drivers/scsi/ppa.c	2003-02-14 21:21:36.000000000 +0000
+++ linux-2.5.60-ac1/drivers/scsi/ppa.c	2003-02-14 20:36:01.000000000 +0000
@@ -148,7 +148,7 @@
 		      "pardevice is owning the port for too longtime!\n",
 			   i);
 		    parport_unregister_device(ppa_hosts[i].dev);
-		    spin_lock_irq(ppa_hosts[i].cur_cmd->host->host_lock);
+		    spin_lock_irq(ppa_hosts[i].cur_cmd->device->host->host_lock);
 		    return 0;
 		}
 	    }
@@ -635,7 +635,7 @@
 
 static inline int ppa_send_command(Scsi_Cmnd * cmd)
 {
-    int host_no = cmd->host->unique_id;
+    int host_no = cmd->device->host->unique_id;
     int k;
 
     w_ctr(PPA_BASE(host_no), 0x0c);
@@ -661,7 +661,7 @@
      *  0     Told to schedule
      *  1     Finished data transfer
      */
-    int host_no = cmd->host->unique_id;
+    int host_no = cmd->device->host->unique_id;
     unsigned short ppb = PPA_BASE(host_no);
     unsigned long start_jiffies = jiffies;
 
@@ -752,7 +752,7 @@
 int ppa_command(Scsi_Cmnd * cmd)
 {
     static int first_pass = 1;
-    int host_no = cmd->host->unique_id;
+    int host_no = cmd->device->host->unique_id;
 
     if (first_pass) {
 	printk("ppa: using non-queuing interface\n");
@@ -774,7 +774,7 @@
 	schedule();
 
     if (cmd->SCp.phase)		/* Only disconnect if we have connected */
-	ppa_disconnect(cmd->host->unique_id);
+	ppa_disconnect(cmd->device->host->unique_id);
 
     ppa_pb_release(host_no);
     ppa_hosts[host_no].cur_cmd = 0;
@@ -807,7 +807,7 @@
     case DID_OK:
 	break;
     case DID_NO_CONNECT:
-	printk("ppa: no device at SCSI ID %i\n", cmd->target);
+	printk("ppa: no device at SCSI ID %i\n", cmd->device->target);
 	break;
     case DID_BUS_BUSY:
 	printk("ppa: BUS BUSY - EPP timeout detected\n");
@@ -836,21 +836,21 @@
 #endif
 
     if (cmd->SCp.phase > 1)
-	ppa_disconnect(cmd->host->unique_id);
+	ppa_disconnect(cmd->device->host->unique_id);
     if (cmd->SCp.phase > 0)
-	ppa_pb_release(cmd->host->unique_id);
+	ppa_pb_release(cmd->device->host->unique_id);
 
     tmp->cur_cmd = 0;
     
-    spin_lock_irqsave(cmd->host->host_lock, flags);
+    spin_lock_irqsave(cmd->device->host->host_lock, flags);
     cmd->scsi_done(cmd);
-    spin_unlock_irqrestore(cmd->host->host_lock, flags);
+    spin_unlock_irqrestore(cmd->device->host->host_lock, flags);
     return;
 }
 
 static int ppa_engine(ppa_struct * tmp, Scsi_Cmnd * cmd)
 {
-    int host_no = cmd->host->unique_id;
+    int host_no = cmd->device->host->unique_id;
     unsigned short ppb = PPA_BASE(host_no);
     unsigned char l = 0, h = 0;
     int retv;
@@ -900,7 +900,7 @@
 	}
 
     case 2:			/* Phase 2 - We are now talking to the scsi bus */
-	if (!ppa_select(host_no, cmd->target)) {
+	if (!ppa_select(host_no, cmd->device->id)) {
 	    ppa_fail(host_no, DID_NO_CONNECT);
 	    return 0;
 	}
@@ -966,7 +966,7 @@
 
 int ppa_queuecommand(Scsi_Cmnd * cmd, void (*done) (Scsi_Cmnd *))
 {
-    int host_no = cmd->host->unique_id;
+    int host_no = cmd->device->host->unique_id;
 
     if (ppa_hosts[host_no].cur_cmd) {
 	printk("PPA: bug in ppa_queuecommand\n");
@@ -1011,7 +1011,7 @@
 
 int ppa_abort(Scsi_Cmnd * cmd)
 {
-    int host_no = cmd->host->unique_id;
+    int host_no = cmd->device->host->unique_id;
     /*
      * There is no method for aborting commands since Iomega
      * have tied the SCSI_MESSAGE line high in the interface
@@ -1039,7 +1039,7 @@
 
 int ppa_reset(Scsi_Cmnd * cmd)
 {
-    int host_no = cmd->host->unique_id;
+    int host_no = cmd->device->host->unique_id;
 
     if (cmd->SCp.phase)
 	ppa_disconnect(host_no);
