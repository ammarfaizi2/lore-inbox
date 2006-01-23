Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964896AbWAWTQW@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964896AbWAWTQW (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 23 Jan 2006 14:16:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964897AbWAWTQW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 23 Jan 2006 14:16:22 -0500
Received: from mx1.redhat.com ([66.187.233.31]:64955 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S964896AbWAWTQW (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 23 Jan 2006 14:16:22 -0500
From: Jeff Moyer <jmoyer@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <17365.11127.860256.702246@segfault.boston.redhat.com>
Date: Mon, 23 Jan 2006 14:16:07 -0500
To: linux-kernel@vger.kernel.org
CC: akpm@osdl.org
Subject: [patch] fix O_DIRECT read of last block in a sparse file
X-Mailer: VM 7.17 under 21.4 (patch 15) "Security Through Obscurity" XEmacs Lucid
Reply-To: jmoyer@redhat.com
X-PGP-KeyID: 1F78E1B4
X-PGP-CertKey: F6FE 280D 8293 F72C 65FD  5A58 1FF8 A7CA 1F78 E1B4
X-PCLoadLetter: What the f**k does that mean?
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

Currently, if you open a file O_DIRECT, truncate it to a size that is not a
multiple of the disk block size, and then try to read the last block in the
file, the read will return 0.  The problem is in do_direct_IO, here:

        /* Handle holes */
        if (!buffer_mapped(map_bh)) {
                char *kaddr;

		...

                if (dio->block_in_file >=
                        i_size_read(dio->inode)>>blkbits) {
                        /* We hit eof */
                        page_cache_release(page);
                        goto out;
                }

We shift off any remaining bytes in the final block of the I/O, resulting
in a 0-sized read.  I've attached a patch that fixes this.  I'm not happy
about how ugly the math is getting, so suggestions are more than welcome.

I've tested this with a simple program that performs the steps outlined for
reproducing the problem above.  Without the patch, we get a 0-sized result
from read.  With the patch, we get the correct return value from the short
read.

Thanks,

Jeff

Signed-off-by: Jeff Moyer <jmoyer@redhat.com>

--- linux-2.6.16-rc1-mm1/fs/direct-io.c.orig	2006-01-19 15:45:50.000000000 -0500
+++ linux-2.6.16-rc1-mm1/fs/direct-io.c	2006-01-19 16:09:33.000000000 -0500
@@ -857,6 +857,7 @@ do_holes:
 			/* Handle holes */
 			if (!buffer_mapped(map_bh)) {
 				char *kaddr;
+				loff_t i_size = i_size_read(dio->inode);
 
 				/* AKPM: eargh, -ENOTBLK is a hack */
 				if (dio->rw == WRITE) {
@@ -864,8 +865,10 @@ do_holes:
 					return -ENOTBLK;
 				}
 
-				if (dio->block_in_file >=
-					i_size_read(dio->inode)>>blkbits) {
+				/* Be sure to account for a partial block as
+				 * the last block in the file */
+				if (dio->block_in_file >= i_size >> blkbits &&
+					!(i_size & ~((1<<blkbits)-1))) {
 					/* We hit eof */
 					page_cache_release(page);
 					goto out;
