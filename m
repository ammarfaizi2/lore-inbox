Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030339AbVIIWNe@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030339AbVIIWNe (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 9 Sep 2005 18:13:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030720AbVIIWNe
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 9 Sep 2005 18:13:34 -0400
Received: from atlrel7.hp.com ([156.153.255.213]:20952 "EHLO atlrel7.hp.com")
	by vger.kernel.org with ESMTP id S1030718AbVIIWNd (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 9 Sep 2005 18:13:33 -0400
Date: Fri, 9 Sep 2005 17:13:12 -0500
From: mike.miller@hp.com
To: akpm@osdl.org, axboe@suse.de
Cc: linux-kernel@vger.kernel.org, linux-scsi@vger.kernel.org
Subject: [PATCH 8/8] cciss: SCSI tape info for /proc
Message-ID: <20050909221312.GH4616@beardog.cca.cpqcorp.net>
Reply-To: mikem@beardog.cca.cpqcorp.net
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Patch 8 of 8
Add SCSI host and device info not elsewhere available to /proc/scsi/cciss/*
Namely, connect cciss device instance with scsi host number, and
give scsi host number, bus, target, lun, devicetype, and 8-byte cciss LUNID
for each tapedrive/medium changer attached to a controller

For instance:

# cat /proc/scsi/cciss/2
cciss0: SCSI host: 2
c2b0t0l0 01 0x0000000000000001

Signed-off-by: Stephen M. Cameron <steve.cameron@hp.com>
Signed-off-by: Mike Miller <mike.miller@hp.com>

 cciss_scsi.c |   25 +++++++++++++++++++++++--
 1 files changed, 23 insertions(+), 2 deletions(-)
--------------------------------------------------------------------------------
diff -burNp lx2613-p007/drivers/block/cciss_scsi.c lx2613/drivers/block/cciss_scsi.c
--- lx2613-p007/drivers/block/cciss_scsi.c	2005-09-09 16:20:35.292948000 -0500
+++ lx2613/drivers/block/cciss_scsi.c	2005-09-09 16:24:43.948146824 -0500
@@ -1144,6 +1144,7 @@ cciss_scsi_proc_info(struct Scsi_Host *s
 
 	int buflen, datalen;
 	ctlr_info_t *ci;
+	int i;
 	int cntl_num;
 
 
@@ -1154,8 +1155,28 @@ cciss_scsi_proc_info(struct Scsi_Host *s
 	cntl_num = ci->ctlr;	/* Get our index into the hba[] array */
 
 	if (func == 0) {	/* User is reading from /proc/scsi/ciss*?/?*  */
-		buflen = sprintf(buffer, "hostnum=%d\n", sh->host_no); 	
+		buflen = sprintf(buffer, "cciss%d: SCSI host: %d\n", 
+				cntl_num, sh->host_no); 	
 
+		/* this information is needed by apps to know which cciss 
+		   device corresponds to which scsi host number without 
+		   having to open a scsi target device node.  The device 
+		   information is not a duplicate of /proc/scsi/scsi because 
+		   the two may be out of sync due to scsi hotplug, rather 
+		   this info is for an app to be able to use to know how to 
+		   get them back in sync. */
+
+		for (i=0;i<ccissscsi[cntl_num].ndevices;i++) {
+			struct cciss_scsi_dev_t *sd = &ccissscsi[cntl_num].dev[i];
+			buflen += sprintf(&buffer[buflen], "c%db%dt%dl%d %02d "
+				"0x%02x%02x%02x%02x%02x%02x%02x%02x\n",
+				sh->host_no, sd->bus, sd->target, sd->lun, 
+				sd->devtype,
+				sd->scsi3addr[0], sd->scsi3addr[1], 
+				sd->scsi3addr[2], sd->scsi3addr[3],
+				sd->scsi3addr[4], sd->scsi3addr[5], 
+				sd->scsi3addr[6], sd->scsi3addr[7]);
+		}
 		datalen = buflen - offset;
 		if (datalen < 0) { 	/* they're reading past EOF. */
 			datalen = 0;
@@ -1417,7 +1438,7 @@ cciss_proc_tape_report(int ctlr, unsigne
 
 	CPQ_TAPE_LOCK(ctlr, flags);
 	size = sprintf(buffer + *len, 
-		"       Sequential access devices: %d\n\n",
+		"Sequential access devices: %d\n\n",
 			ccissscsi[ctlr].ndevices);
 	CPQ_TAPE_UNLOCK(ctlr, flags);
 	*pos += size; *len += size;
