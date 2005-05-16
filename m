Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261890AbVEPVUU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261890AbVEPVUU (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 16 May 2005 17:20:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261887AbVEPVSG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 16 May 2005 17:18:06 -0400
Received: from atlrel7.hp.com ([156.153.255.213]:60873 "EHLO atlrel7.hp.com")
	by vger.kernel.org with ESMTP id S261905AbVEPVQE (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 16 May 2005 17:16:04 -0400
Date: Mon, 16 May 2005 15:16:31 -0500
From: mike.miller@hp.com
To: marcelo.tosatti@cyclades.com, axboe@suse.de
Cc: linux-kernel@vger.kernel.org, linux-scsi@vger.kernel.org
Subject: [PATCH 2.4] cciss: fix for passthru ioctls
Message-ID: <20050516201631.GA6725@beardog.cca.cpqcorp.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The following patch fixes a problem in our passthru ioctls. I added a memset to
zero out buffers before doing a read. Seems like I had a curly brace out of place.

Thanks to Stanislav Semakin for pointing this out.

Please consider this for inclusion.

Signed-off-by: Mike Miller <mike.miller@hp.com>
---------------------------------------------------------------------------------------
diff -burNp lx2431-pre2.orig/drivers/block/cciss.c lx2431-pre2/drivers/block/cciss.c
--- lx2431-pre2.orig/drivers/block/cciss.c	2004-11-17 05:54:21.000000000 -0600
+++ lx2431-pre2/drivers/block/cciss.c	2005-05-16 14:08:18.189638408 -0500
@@ -975,10 +975,10 @@ static int cciss_ioctl(struct inode *ino
 			{
 				kfree(buff);
 				return -EFAULT;
-			} else {
-				memset(buff, 0, iocommand.buf_size);
 			}
 		}
+		else 
+			memset(buff, 0, iocommand.buf_size);
 		if ((c = cmd_alloc(h , 0)) == NULL) {
 			kfree(buff);
 			return -ENOMEM;
@@ -1099,12 +1099,12 @@ static int cciss_ioctl(struct inode *ino
 				   /* Copy the data into the buffer created */
 				   if (copy_from_user(buff[sg_used], data_ptr, 
 						buff_size[sg_used])) {
-					status = -ENOMEM;
+					status = -EFAULT;
 					goto cleanup1;			
-				   } else {
-					memset(buff[sg_used], 0, buff_size[sg_used]);
 				   }
 				   }
+				else
+					memset(buff[sg_used], 0, buff_size[sg_used]);
 				size_left_alloc -= buff_size[sg_used];
 				data_ptr += buff_size[sg_used];
 				sg_used++;
