Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263589AbUCYT6S (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 25 Mar 2004 14:58:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263592AbUCYT6R
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 25 Mar 2004 14:58:17 -0500
Received: from ztxmail04.ztx.compaq.com ([161.114.1.208]:16652 "EHLO
	ztxmail04.ztx.compaq.com") by vger.kernel.org with ESMTP
	id S263589AbUCYT6N (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 25 Mar 2004 14:58:13 -0500
Date: Thu, 25 Mar 2004 14:10:57 -0600
From: mike.miller@hp.com
To: axboe@suse.de, jgarzik@pobox.com
Cc: linux-kernel@vger.kernel.org
Subject: cciss update to replace 1 of 2 earlier patches
Message-ID: <20040325201057.GC4456@beardog.cca.cpqcorp.net>
Reply-To: mike.miller@hp.com
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4.2i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This patch is meant to replace the patch from earlier that mask off SATA drives. After Arjan's question about one for 2.6 I got back in the code and realized this has to be done in 2 places for the 2.4.x driver, but only in one place for 2.6.
Also, to answer Jeff's question: if it's not a SCSI tape we don't care.

This change is required to support the new MSA30 storage enclosure.
If you do a SCSI inquiry to a SATA disk bad things happen. This patch prevents the inquiry from going to SATA disks.

 cciss_scsi.c |    3 +++
 1 files changed, 3 insertions(+)
------------------------------------------------------------------------------
diff -burpN lx2425.orig/drivers/block/cciss_scsi.c lx2425/drivers/block/cciss_scsi.c
--- lx2425.orig/drivers/block/cciss_scsi.c	2003-11-28 12:26:19.000000000 -0600
+++ lx2425/drivers/block/cciss_scsi.c	2004-03-25 13:45:47.000000000 -0600
@@ -589,6 +589,8 @@ cciss_find_non_disk_devices(int cntl_num
 
 	for(i=0; i<num_luns; i++) {
 		/* Execute an inquiry to figure the device type */
+		/* Skip over masked devices */
+		if (ld_buff->LUN[i][3] & 0xC0) continue;
 		memset(inq_buff, 0, sizeof(InquiryData_struct));
 		memcpy(scsi3addr, ld_buff->LUN[i], 8); /* ugly... */
 		return_code = sendcmd(CISS_INQUIRY, cntl_num, inq_buff,
@@ -1148,6 +1150,7 @@ cciss_update_non_disk_devices(int cntl_n
 		int devtype;
 
 		/* for each physical lun, do an inquiry */
+		if (ld_buff->LUN[i][3] & 0xC0) continue;
 		memset(inq_buff, 0, sizeof(InquiryData_struct));
 		memcpy(&scsi3addr[0], &ld_buff->LUN[i][0], 8);
 
