Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261935AbVEKJZM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261935AbVEKJZM (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 11 May 2005 05:25:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261188AbVEKJZM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 11 May 2005 05:25:12 -0400
Received: from ercist.iscas.ac.cn ([159.226.5.94]:11788 "EHLO
	ercist.iscas.ac.cn") by vger.kernel.org with ESMTP id S261935AbVEKJYe
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 11 May 2005 05:24:34 -0400
Subject: Re: [PATCH] VFS mmap wrong behavior when I/O failure occurs
From: fs <fs@ercist.iscas.ac.cn>
To: Andrew Morton <akpm@osdl.org>
Cc: iscas-linaccident <iscas-linaccident@intellilink.co.jp>,
       linux-kernel <linux-kernel@vger.kernel.org>,
       linux-fsdevel <linux-fsdevel@vger.kernel.org>,
       viro VFS <viro@parcelfarce.linux.theplanet.co.uk>
In-Reply-To: <20050511011916.611486e7.akpm@osdl.org>
References: <1115837231.3599.55.camel@CoolQ>
	 <20050511011916.611486e7.akpm@osdl.org>
Content-Type: text/plain
Organization: iscas
Message-Id: <1115843517.2999.16.camel@CoolQ>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 (1.4.6-2) 
Date: Wed, 11 May 2005 16:31:57 -0400
Content-Transfer-Encoding: 7bit
X-ArGoMail-Authenticated: fs@ercist.iscas.ac.cn
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2005-05-11 at 04:19, Andrew Morton wrote:
> fs <fs@ercist.iscas.ac.cn> wrote:
> >
> > --- linux-2.6.11.8-orig/fs/buffer.c     2005-05-11 14:41:03.000000000
> >  -0400
> 
> Your email client wordwrapped the patch.  Please fix it.
> 
> >  +++ linux-2.6.11.8/fs/buffer.c  2005-05-11 14:38:55.000000000 -0400
> >  @@ -2105,7 +2105,6 @@ int block_read_full_page(struct page *pa
> >                                  memset(kaddr + i * blocksize, 0,
> >  blocksize);
> >                                  flush_dcache_page(page);
> >                                  kunmap_atomic(kaddr, KM_USER0);
> >  -                               set_buffer_uptodate(bh);
> >                                  continue;
> >                          }
> >                          /*
> 
> This patch will break the kernel's regular handling of file holes -
> !buffer_mapped() means that there was no disk mapping for this buffer: it
> sits over a hole in the file.  Zeroing out the buffer and marking it
> uptodate is correct behaviour.
> 
> You probably want something like this:
Yes, you make the point, that is what I really want.
> 
> --- 25/fs/buffer.c~a	2005-05-11 01:15:13.000000000 -0700
> +++ 25-akpm/fs/buffer.c	2005-05-11 01:16:39.000000000 -0700
> @@ -2094,9 +2094,12 @@ int block_read_full_page(struct page *pa
>  			continue;
>  
>  		if (!buffer_mapped(bh)) {
> +			int err = 0;
> +
>  			fully_mapped = 0;
>  			if (iblock < lblock) {
> -				if (get_block(inode, iblock, bh, 0))
> +				err = get_block(inode, iblock, bh, 0);
> +				if (err)
>  					SetPageError(page);
>  			}
>  			if (!buffer_mapped(bh)) {
> @@ -2104,7 +2107,8 @@ int block_read_full_page(struct page *pa
>  				memset(kaddr + i * blocksize, 0, blocksize);
>  				flush_dcache_page(page);
>  				kunmap_atomic(kaddr, KM_USER0);
> -				set_buffer_uptodate(bh);
> +				if (!err)
> +					set_buffer_uptodate(bh);
>  				continue;
>  			}
>  			/*
> _
> 
So the final patch will be like above:
P.S. my mail client is a little buggy, i can't handle it correctly :(

diff -uNp linux-2.6.11.8-orig/fs/buffer.c linux-2.6.11.8/fs/buffer.c
--- linux-2.6.11.8-orig/fs/buffer.c	2005-05-11 14:41:03.000000000 -0400
+++ linux-2.6.11.8/fs/buffer.c	2005-05-11 16:20:40.000000000 -0400
@@ -2095,17 +2095,21 @@ int block_read_full_page(struct page *pa
 			continue;
 
 		if (!buffer_mapped(bh)) {
+			int err = 0;
+			
 			fully_mapped = 0;
 			if (iblock < lblock) {
-				if (get_block(inode, iblock, bh, 0))
-					SetPageError(page);
+				err = get_block(inode, iblock, bh, 0)
+					if(err)
+						SetPageError(page);
 			}
 			if (!buffer_mapped(bh)) {
 				void *kaddr = kmap_atomic(page, KM_USER0);
 				memset(kaddr + i * blocksize, 0, blocksize);
 				flush_dcache_page(page);
 				kunmap_atomic(kaddr, KM_USER0);
-				set_buffer_uptodate(bh);
+				if(!err)
+					set_buffer_uptodate(bh);
 				continue;
 			}
 			/*


