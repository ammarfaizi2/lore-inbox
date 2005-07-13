Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262838AbVGMX7E@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262838AbVGMX7E (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 13 Jul 2005 19:59:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262790AbVGMX5G
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 13 Jul 2005 19:57:06 -0400
Received: from smtp.osdl.org ([65.172.181.4]:39576 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S262779AbVGMXnZ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 13 Jul 2005 19:43:25 -0400
Subject: [rfc patch 2/2] direct-io: remove address alignment check
From: Daniel McNeil <daniel@osdl.org>
To: "linux-aio@kvack.org" <linux-aio@kvack.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain
Message-Id: <1121298112.6025.21.camel@ibm-c.pdx.osdl.net>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 
Date: Wed, 13 Jul 2005 16:43:21 -0700
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This patch relaxes the direct i/o alignment check so that user addresses
do not have to be a multiple of the device block size.

I've done some preliminary testing and it mostly works on an ext3
file system on a ide disk.  I have seen trouble when the user address
is on an odd byte boundary.  Sometimes the data is read back incorrectly
on read and sometimes I get these kernel error messages:
	hda: dma_timer_expiry: dma status == 0x60
	hda: DMA timeout retry
	hda: timeout waiting for DMA
	hda: status error: status=0x58 { DriveReady SeekComplete DataRequest }
	ide: failed opcode was: unknown
	hda: drive not ready for command

Doing direct-io with user addresses on even, non-512 boundaries appears
to be working correctly.

Any additional testing and/or comments welcome.

Signed-off-by: Daniel McNeil <daniel@osdl.org>

--- linux-2.6.12.orig/fs/direct-io.c	2005-06-28 16:39:39.000000000 -0700
+++ linux-2.6.12/fs/direct-io.c	2005-06-28 16:39:59.000000000 -0700
@@ -1147,7 +1147,9 @@ __blockdev_direct_IO(int rw, struct kioc
 			goto out;
 	}
 
-	/* Check the memory alignment.  Blocks cannot straddle pages */
+	/*
+	 * Check the i/o.  It must be a multiple of device block size.
+	 */
 	for (seg = 0; seg < nr_segs; seg++) {
 		addr = (unsigned long)iov[seg].iov_base;
 		size = iov[seg].iov_len;
@@ -1156,7 +1158,7 @@ __blockdev_direct_IO(int rw, struct kioc
 			if (bdev)
 				 blkbits = bdev_blkbits;
 			blocksize_mask = (1 << blkbits) - 1;
-			if ((addr & blocksize_mask) || (size & blocksize_mask))
+			if (size & blocksize_mask)
 				goto out;
 		}
 	}


