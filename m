Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964863AbWAWXyj@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964863AbWAWXyj (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 23 Jan 2006 18:54:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964855AbWAWXyj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 23 Jan 2006 18:54:39 -0500
Received: from smtp.osdl.org ([65.172.181.4]:52126 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S964863AbWAWXyi (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 23 Jan 2006 18:54:38 -0500
Date: Mon, 23 Jan 2006 15:54:01 -0800
From: Andrew Morton <akpm@osdl.org>
To: jmoyer@redhat.com
Cc: linux-kernel@vger.kernel.org, Badari Pulavarty <pbadari@us.ibm.com>
Subject: Re: [patch] fix O_DIRECT read of last block in a sparse file
Message-Id: <20060123155401.62f7b756.akpm@osdl.org>
In-Reply-To: <17365.11127.860256.702246@segfault.boston.redhat.com>
References: <17365.11127.860256.702246@segfault.boston.redhat.com>
X-Mailer: Sylpheed version 1.0.4 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jeff Moyer <jmoyer@redhat.com> wrote:
>
> Currently, if you open a file O_DIRECT, truncate it to a size that is not a
>  multiple of the disk block size, and then try to read the last block in the
>  file, the read will return 0.  The problem is in do_direct_IO, here:
> 
>          /* Handle holes */
>          if (!buffer_mapped(map_bh)) {
>                  char *kaddr;
> 
>  		...
> 
>                  if (dio->block_in_file >=
>                          i_size_read(dio->inode)>>blkbits) {
>                          /* We hit eof */
>                          page_cache_release(page);
>                          goto out;
>                  }
> 
>  We shift off any remaining bytes in the final block of the I/O, resulting
>  in a 0-sized read.  I've attached a patch that fixes this.  I'm not happy
>  about how ugly the math is getting, so suggestions are more than welcome.
> 
>  I've tested this with a simple program that performs the steps outlined for
>  reproducing the problem above.  Without the patch, we get a 0-sized result
>  from read.  With the patch, we get the correct return value from the short
>  read.

OK.  We do have some helper functions to make the math a little clearer. 
How does this look?

--- devel/fs/direct-io.c~fix-o_direct-read-of-last-block-in-a-sparse-file	2006-01-23 15:42:31.000000000 -0800
+++ devel-akpm/fs/direct-io.c	2006-01-23 15:51:14.000000000 -0800
@@ -857,6 +857,7 @@ do_holes:
 			/* Handle holes */
 			if (!buffer_mapped(map_bh)) {
 				char *kaddr;
+				loff_t i_size_aligned;
 
 				/* AKPM: eargh, -ENOTBLK is a hack */
 				if (dio->rw == WRITE) {
@@ -864,8 +865,14 @@ do_holes:
 					return -ENOTBLK;
 				}
 
+				/*
+				 * Be sure to account for a partial block as the
+				 * last block in the file
+				 */
+				i_size_aligned = ALIGN(i_size_read(dio->inode),
+							1 << blkbits);
 				if (dio->block_in_file >=
-					i_size_read(dio->inode)>>blkbits) {
+						i_size_aligned >> blkbits) {
 					/* We hit eof */
 					page_cache_release(page);
 					goto out;
_

