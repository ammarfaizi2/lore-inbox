Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261486AbTBLLat>; Wed, 12 Feb 2003 06:30:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267032AbTBLLat>; Wed, 12 Feb 2003 06:30:49 -0500
Received: from tom.hrz.tu-chemnitz.de ([134.109.132.38]:6081 "EHLO
	tom.hrz.tu-chemnitz.de") by vger.kernel.org with ESMTP
	id <S261486AbTBLLar>; Wed, 12 Feb 2003 06:30:47 -0500
Date: Wed, 12 Feb 2003 11:05:00 +0100
From: Ingo Oeser <ingo.oeser@informatik.tu-chemnitz.de>
To: Luben Tuikov <luben@splentec.com>
Cc: Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Linux 2.5.60
Message-ID: <20030212110500.A665@nightmaster.csn.tu-chemnitz.de>
References: <Pine.LNX.4.44.0302101103570.1348-100000@penguin.transmeta.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2i
In-Reply-To: <Pine.LNX.4.44.0302101103570.1348-100000@penguin.transmeta.com>; from torvalds@transmeta.com on Mon, Feb 10, 2003 at 11:08:28AM -0800
X-Spam-Score: -4.2 (----)
X-Scanner: exiscan for exim4 (http://duncanthrax.net/exiscan/) *18ivFi-0001Yy-00*ejOVDagafF6*
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Luben,
hi LKML,

On Mon, Feb 10, 2003 at 11:08:28AM -0800, Linus Torvalds wrote:
> Luben Tuikov <luben@splentec.com>:
>   o [SCSI] Move cmd->{lun, target, channel} to cmd->device->{lun, id,
>     channel}
>   o [SCSI] Move cmd->host to cmd->device->host
>   o cmd_alloc54-3.patch [3/3]
>   o [SCSI] add commands at the tail of cmd_list

it would be nice, if you would propagate those simple changes
into the drivers.

imm.c breaks now.

Fix is attached.

Regards

Ingo Oeser


--- linux-2.5.60-editted/drivers/scsi/imm.c	Wed Feb 12 12:00:41 2003
+++ linux-2.5.60/drivers/scsi/imm.c	Tue Feb 11 20:00:59 2003
@@ -733,7 +733,7 @@
 
 static inline int imm_send_command(Scsi_Cmnd * cmd)
 {
-    int host_no = cmd->host->unique_id;
+    int host_no = cmd->device->host->unique_id;
     int k;
 
     /* NOTE: IMM uses byte pairs */
@@ -758,7 +758,7 @@
      *  0     Told to schedule
      *  1     Finished data transfer
      */
-    int host_no = cmd->host->unique_id;
+    int host_no = cmd->device->host->unique_id;
     unsigned short ppb = IMM_BASE(host_no);
     unsigned long start_jiffies = jiffies;
 
@@ -845,7 +845,7 @@
 int imm_command(Scsi_Cmnd * cmd)
 {
     static int first_pass = 1;
-    int host_no = cmd->host->unique_id;
+    int host_no = cmd->device->host->unique_id;
 
     if (first_pass) {
 	printk("imm: using non-queuing interface\n");
@@ -867,7 +867,7 @@
 	schedule();
 
     if (cmd->SCp.phase)		/* Only disconnect if we have connected */
-	imm_disconnect(cmd->host->unique_id);
+	imm_disconnect(cmd->device->host->unique_id);
 
     imm_pb_release(host_no);
     imm_hosts[host_no].cur_cmd = 0;
@@ -883,7 +883,7 @@
 {
     imm_struct *tmp = (imm_struct *) data;
     Scsi_Cmnd *cmd = tmp->cur_cmd;
-    struct Scsi_Host *host = cmd->host;
+    struct Scsi_Host *host = cmd->device->host;
     unsigned long flags;
 
     if (!cmd) {
@@ -930,9 +930,9 @@
 #endif
 
     if (cmd->SCp.phase > 1)
-	imm_disconnect(cmd->host->unique_id);
+	imm_disconnect(cmd->device->host->unique_id);
     if (cmd->SCp.phase > 0)
-	imm_pb_release(cmd->host->unique_id);
+	imm_pb_release(cmd->device->host->unique_id);
 
     spin_lock_irqsave(host->host_lock, flags);
     tmp->cur_cmd = 0;
@@ -943,7 +943,7 @@
 
 static int imm_engine(imm_struct * tmp, Scsi_Cmnd * cmd)
 {
-    int host_no = cmd->host->unique_id;
+    int host_no = cmd->device->host->unique_id;
     unsigned short ppb = IMM_BASE(host_no);
     unsigned char l = 0, h = 0;
     int retv, x;
@@ -972,7 +972,7 @@
 
 	/* Phase 2 - We are now talking to the scsi bus */
     case 2:
-	if (!imm_select(host_no, cmd->target)) {
+	if (!imm_select(host_no, cmd->device->id)) {
 	    imm_fail(host_no, DID_NO_CONNECT);
 	    return 0;
 	}
@@ -1082,7 +1082,7 @@
 
 int imm_queuecommand(Scsi_Cmnd * cmd, void (*done) (Scsi_Cmnd *))
 {
-    int host_no = cmd->host->unique_id;
+    int host_no = cmd->device->host->unique_id;
 
     if (imm_hosts[host_no].cur_cmd) {
 	printk("IMM: bug in imm_queuecommand\n");
@@ -1125,7 +1125,7 @@
 
 int imm_abort(Scsi_Cmnd * cmd)
 {
-    int host_no = cmd->host->unique_id;
+    int host_no = cmd->device->host->unique_id;
     /*
      * There is no method for aborting commands since Iomega
      * have tied the SCSI_MESSAGE line high in the interface
@@ -1157,7 +1157,7 @@
 
 int imm_reset(Scsi_Cmnd * cmd)
 {
-    int host_no = cmd->host->unique_id;
+    int host_no = cmd->device->host->unique_id;
 
     if (cmd->SCp.phase)
 	imm_disconnect(host_no);



-- 
Science is what we can tell a computer. Art is everything else. --- D.E.Knuth
