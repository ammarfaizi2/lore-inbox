Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267899AbUHTIms@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267899AbUHTIms (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 20 Aug 2004 04:42:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267893AbUHTIk4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 20 Aug 2004 04:40:56 -0400
Received: from fw.osdl.org ([65.172.181.6]:38091 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S267899AbUHTIgC (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 20 Aug 2004 04:36:02 -0400
Date: Fri, 20 Aug 2004 01:34:18 -0700
From: Andrew Morton <akpm@osdl.org>
To: Marcelo Tosatti <marcelo.tosatti@cyclades.com>
Cc: jbarnes@engr.sgi.com, linux-kernel@vger.kernel.org
Subject: Re: remove dentry_open::file_ra_init_state() duplicated memset was
 Re: kernbench on 512p
Message-Id: <20040820013418.2a178ea0.akpm@osdl.org>
In-Reply-To: <20040820072847.GA8205@logos.cnet>
References: <200408191216.33667.jbarnes@engr.sgi.com>
	<20040820005654.GC6374@logos.cnet>
	<20040819232145.2fd5c54a.akpm@osdl.org>
	<20040820072847.GA8205@logos.cnet>
X-Mailer: Sylpheed version 0.9.7 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Marcelo Tosatti <marcelo.tosatti@cyclades.com> wrote:
>
>  On Thu, Aug 19, 2004 at 11:21:45PM -0700, Andrew Morton wrote:
>  > Marcelo Tosatti <marcelo.tosatti@cyclades.com> wrote:
>  > >
>  > > So this patch creates a __file_ra_state_init() function, which initializes
>  > >  the file_ra_state fields, without the memset. 
>  > > 
>  > >  file_ra_state_init() does the memset + its __ counterpart. 
>  > 
>  > Seems unnecessarily fiddly.  How about this?
> 
>  Thats cleaner yep. :)

It got even cleaner - Neil has just nuked the NFS callsite.


--- 25/mm/readahead.c~file_ra_state_init-speedup	2004-08-20 00:03:19.979397128 -0700
+++ 25-akpm/mm/readahead.c	2004-08-20 00:04:25.159488248 -0700
@@ -28,16 +28,15 @@ struct backing_dev_info default_backing_
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
-EXPORT_SYMBOL(file_ra_state_init);
 
 /*
  * Return max readahead size for this inode in number-of-pages.
_

