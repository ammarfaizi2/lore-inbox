Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267493AbTBNVki>; Fri, 14 Feb 2003 16:40:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267484AbTBNUyK>; Fri, 14 Feb 2003 15:54:10 -0500
Received: from lightning.swansea.linux.org.uk ([194.168.151.1]:19978 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S267432AbTBNUxi>; Fri, 14 Feb 2003 15:53:38 -0500
Subject: PATCH: fix scsi parts of iph5526
To: torvalds@transmeta.com, linux-kernel@vger.kernel.org
Date: Fri, 14 Feb 2003 21:03:34 +0000 (GMT)
X-Mailer: ELM [version 2.5 PL6]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E18jmze-0005fU-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

diff -u --new-file --recursive --exclude-from /usr/src/exclude linux-2.5.60-ref/drivers/net/fc/iph5526.c linux-2.5.60-ac1/drivers/net/fc/iph5526.c
--- linux-2.5.60-ref/drivers/net/fc/iph5526.c	2003-02-14 21:45:55.000000000 +0000
+++ linux-2.5.60-ac1/drivers/net/fc/iph5526.c	2003-02-14 19:23:45.000000000 +0000
@@ -3913,9 +3913,9 @@
 int int_required = 0;
 u_int r_ctl = FC4_DEVICE_DATA | UNSOLICITED_COMMAND;
 u_int type = TYPE_FCP | SEQUENCE_INITIATIVE;
-u_int frame_class = Cmnd->target;
+u_int frame_class = Cmnd->device->id;
 u_short ox_id = OX_ID_FIRST_SEQUENCE;
-struct Scsi_Host *host = Cmnd->host;
+struct Scsi_Host *host = Cmnd->device->host;
 struct iph5526_hostdata *hostdata = (struct iph5526_hostdata*)host->hostdata;
 struct fc_info *fi = hostdata->fi;
 struct fc_node_info *q;
@@ -3937,9 +3937,9 @@
 				hostdata->cmnd.fcp_cntl = FCP_CNTL_QTYPE_ORDERED;
 				break;
 			default:
-				if ((jiffies - hostdata->tag_ages[Cmnd->target]) > (5 * HZ)) {
+				if ((jiffies - hostdata->tag_ages[Cmnd->device->id]) > (5 * HZ)) {
 					hostdata->cmnd.fcp_cntl = FCP_CNTL_QTYPE_ORDERED;
-					hostdata->tag_ages[Cmnd->target] = jiffies;
+					hostdata->tag_ages[Cmnd->device->id] = jiffies;
 				}
 				else
 					hostdata->cmnd.fcp_cntl = FCP_CNTL_QTYPE_SIMPLE;
@@ -3953,7 +3953,7 @@
 	hostdata->cmnd.fcp_addr[3] = 0;
 	hostdata->cmnd.fcp_addr[2] = 0;
 	hostdata->cmnd.fcp_addr[1] = 0;
-	hostdata->cmnd.fcp_addr[0] = htons(Cmnd->lun);
+	hostdata->cmnd.fcp_addr[0] = htons(Cmnd->device->lun);
 
 	memcpy(&hostdata->cmnd.fcp_cdb, Cmnd->cmnd, Cmnd->cmd_len);
 	hostdata->cmnd.fcp_data_len = htonl(Cmnd->request_bufflen);
@@ -3985,7 +3985,7 @@
 	
 	memcpy(fi->q.ptr_fcp_cmnd[fi->q.fcp_cmnd_indx], &(hostdata->cmnd), sizeof(fcp_cmd));	
 	
-	q = resolve_target(fi, Cmnd->target);
+	q = resolve_target(fi, Cmnd->device->id);
 
 	if (q == NULL) {
 	u_int bad_id = fi->g.my_ddaa | 0xFE;
@@ -4022,7 +4022,7 @@
 
 int iph5526_abort(Scsi_Cmnd *Cmnd)
 {
-struct Scsi_Host *host = Cmnd->host;
+struct Scsi_Host *host = Cmnd->device->host;
 struct iph5526_hostdata *hostdata = (struct iph5526_hostdata *)host->hostdata;
 struct fc_info *fi = hostdata->fi;
 struct fc_node_info *q;
@@ -4036,7 +4036,7 @@
 	
 	spin_lock_irqsave(&fi->fc_lock, flags);
 	
-	q = resolve_target(fi, Cmnd->target);
+	q = resolve_target(fi, Cmnd->device->id);
 	if (q == NULL) {
 	u_int bad_id = fi->g.my_ddaa | 0xFE;
 		/* This should not happen as we should always be able to
