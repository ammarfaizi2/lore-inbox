Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261925AbVEKIU1@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261925AbVEKIU1 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 11 May 2005 04:20:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261923AbVEKIU1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 11 May 2005 04:20:27 -0400
Received: from fire.osdl.org ([65.172.181.4]:62850 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S261922AbVEKIUK (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 11 May 2005 04:20:10 -0400
Date: Wed, 11 May 2005 01:19:16 -0700
From: Andrew Morton <akpm@osdl.org>
To: fs <fs@ercist.iscas.ac.cn>
Cc: viro@parcelfarce.linux.theplanet.co.uk, linux-fsdevel@vger.kernel.org,
       iscas-linaccident@intellilink.co.jp, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] VFS mmap wrong behavior when I/O failure occurs
Message-Id: <20050511011916.611486e7.akpm@osdl.org>
In-Reply-To: <1115837231.3599.55.camel@CoolQ>
References: <1115837231.3599.55.camel@CoolQ>
X-Mailer: Sylpheed version 1.0.0 (GTK+ 1.2.10; i386-vine-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

fs <fs@ercist.iscas.ac.cn> wrote:
>
> --- linux-2.6.11.8-orig/fs/buffer.c     2005-05-11 14:41:03.000000000
>  -0400

Your email client wordwrapped the patch.  Please fix it.

>  +++ linux-2.6.11.8/fs/buffer.c  2005-05-11 14:38:55.000000000 -0400
>  @@ -2105,7 +2105,6 @@ int block_read_full_page(struct page *pa
>                                  memset(kaddr + i * blocksize, 0,
>  blocksize);
>                                  flush_dcache_page(page);
>                                  kunmap_atomic(kaddr, KM_USER0);
>  -                               set_buffer_uptodate(bh);
>                                  continue;
>                          }
>                          /*

This patch will break the kernel's regular handling of file holes -
!buffer_mapped() means that there was no disk mapping for this buffer: it
sits over a hole in the file.  Zeroing out the buffer and marking it
uptodate is correct behaviour.

You probably want something like this:

--- 25/fs/buffer.c~a	2005-05-11 01:15:13.000000000 -0700
+++ 25-akpm/fs/buffer.c	2005-05-11 01:16:39.000000000 -0700
@@ -2094,9 +2094,12 @@ int block_read_full_page(struct page *pa
 			continue;
 
 		if (!buffer_mapped(bh)) {
+			int err = 0;
+
 			fully_mapped = 0;
 			if (iblock < lblock) {
-				if (get_block(inode, iblock, bh, 0))
+				err = get_block(inode, iblock, bh, 0);
+				if (err)
 					SetPageError(page);
 			}
 			if (!buffer_mapped(bh)) {
@@ -2104,7 +2107,8 @@ int block_read_full_page(struct page *pa
 				memset(kaddr + i * blocksize, 0, blocksize);
 				flush_dcache_page(page);
 				kunmap_atomic(kaddr, KM_USER0);
-				set_buffer_uptodate(bh);
+				if (!err)
+					set_buffer_uptodate(bh);
 				continue;
 			}
 			/*
_


