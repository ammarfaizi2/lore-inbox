Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264704AbUHMWMW@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264704AbUHMWMW (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 13 Aug 2004 18:12:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267615AbUHMWMV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 13 Aug 2004 18:12:21 -0400
Received: from ztxmail04.ztx.compaq.com ([161.114.1.208]:16658 "EHLO
	ztxmail04.ztx.compaq.com") by vger.kernel.org with ESMTP
	id S267610AbUHMWI3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 13 Aug 2004 18:08:29 -0400
Date: Fri, 13 Aug 2004 17:07:50 -0500
From: mikem <mikem@beardog.cca.cpqcorp.net>
To: marcelo.tosatti@cyclades.com, axboe@suse.de
Cc: linux-kernel@vger.kernel.org
Subject: cciss update [4/5] fix for HP utilities
Message-ID: <20040813220750.GD1016@beardog.cca.cpqcorp.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Patch 4 of 5.
This patch fixes a problem with HP utilities. If a system has
a combination of SCSI and SATA or SAS drives the utils can 
become confused and return bogus info.
Applies to 2.4.27. Please consider this for inclusion.

Thanks,
mikem
-----------------------------------------------------------------------------
diff -burNp lx2427-p003/drivers/block/cciss.c lx2427/drivers/block/cciss.c
--- lx2427-p003/drivers/block/cciss.c	2004-08-13 15:49:37.062028000 -0500
+++ lx2427/drivers/block/cciss.c	2004-08-13 15:57:06.040773272 -0500
@@ -942,6 +942,8 @@ static int cciss_ioctl(struct inode *ino
 			{
 				kfree(buff);
 				return -EFAULT;
+			} else {
+				memset(buff, 0, iocommand.buf_size);
 			}
 		}
 		if ((c = cmd_alloc(h , 0)) == NULL) {
@@ -1060,12 +1062,15 @@ static int cciss_ioctl(struct inode *ino
 					goto cleanup1;
 				}
 				if (iocommand.Request.Type.Direction == 
-						XFER_WRITE)
+						XFER_WRITE) {
 				   /* Copy the data into the buffer created */
 				   if (copy_from_user(buff[sg_used], data_ptr, 
 						buff_size[sg_used])) {
 					status = -ENOMEM;
 					goto cleanup1;			
+				   } else {
+					memset(buff[sg_used], 0, buff_size[sg_used]);
+				   }
 				   }
 				size_left_alloc -= buff_size[sg_used];
 				data_ptr += buff_size[sg_used];
