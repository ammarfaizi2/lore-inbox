Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267582AbUHTGXe@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267582AbUHTGXe (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 20 Aug 2004 02:23:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267587AbUHTGXe
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 20 Aug 2004 02:23:34 -0400
Received: from fw.osdl.org ([65.172.181.6]:21209 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S267582AbUHTGXc (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 20 Aug 2004 02:23:32 -0400
Date: Thu, 19 Aug 2004 23:21:45 -0700
From: Andrew Morton <akpm@osdl.org>
To: Marcelo Tosatti <marcelo.tosatti@cyclades.com>
Cc: jbarnes@engr.sgi.com, linux-kernel@vger.kernel.org
Subject: Re: remove dentry_open::file_ra_init_state() duplicated memset was
 Re: kernbench on 512p
Message-Id: <20040819232145.2fd5c54a.akpm@osdl.org>
In-Reply-To: <20040820005654.GC6374@logos.cnet>
References: <200408191216.33667.jbarnes@engr.sgi.com>
	<20040820005654.GC6374@logos.cnet>
X-Mailer: Sylpheed version 0.9.7 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Marcelo Tosatti <marcelo.tosatti@cyclades.com> wrote:
>
> So this patch creates a __file_ra_state_init() function, which initializes
>  the file_ra_state fields, without the memset. 
> 
>  file_ra_state_init() does the memset + its __ counterpart. 

Seems unnecessarily fiddly.  How about this?

--- 25/mm/readahead.c~file_ra_state_init-speedup	2004-08-19 23:20:11.695876032 -0700
+++ 25-akpm/mm/readahead.c	2004-08-19 23:20:42.077257360 -0700
@@ -28,12 +28,12 @@ struct backing_dev_info default_backing_
 EXPORT_SYMBOL_GPL(default_backing_dev_info);
 
 /*
- * Initialise a struct file's readahead state
+ * Initialise a struct file's readahead state.  Assumes that the caller has
+ * memset *ra to zero.
  */
 void
 file_ra_state_init(struct file_ra_state *ra, struct address_space *mapping)
 {
-	memset(ra, 0, sizeof(*ra));
 	ra->ra_pages = mapping->backing_dev_info->ra_pages;
 	ra->average = ra->ra_pages / 2;
 }
diff -puN fs/nfsd/vfs.c~file_ra_state_init-speedup fs/nfsd/vfs.c
--- 25/fs/nfsd/vfs.c~file_ra_state_init-speedup	2004-08-19 23:20:11.713873296 -0700
+++ 25-akpm/fs/nfsd/vfs.c	2004-08-19 23:21:05.721662864 -0700
@@ -771,6 +771,7 @@ nfsd_get_raparms(dev_t dev, ino_t ino, s
 	ra = *frap;
 	ra->p_dev = dev;
 	ra->p_ino = ino;
+	memset(&ra->p_ra, 0, sizeof(ra->p_ra));
 	file_ra_state_init(&ra->p_ra, mapping);
 found:
 	if (rap != &raparm_cache) {
_

