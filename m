Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262514AbUCLUjX (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 12 Mar 2004 15:39:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262511AbUCLUhx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 12 Mar 2004 15:37:53 -0500
Received: from ns.suse.de ([195.135.220.2]:50597 "EHLO Cantor.suse.de")
	by vger.kernel.org with ESMTP id S262345AbUCLUbj (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 12 Mar 2004 15:31:39 -0500
Subject: Re: [PATCH] per-backing dev unplugging #2
From: Chris Mason <mason@suse.com>
To: Jens Axboe <axboe@suse.de>
Cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org,
       kenneth.w.chen@intel.com
In-Reply-To: <20040312200253.GA16880@suse.de>
References: <20040311083619.GH6955@suse.de>
	 <1079121113.4181.189.camel@watt.suse.com>
	 <20040312120322.0108a437.akpm@osdl.org>  <20040312200253.GA16880@suse.de>
Content-Type: text/plain
Message-Id: <1079123647.4186.211.camel@watt.suse.com>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.5 
Date: Fri, 12 Mar 2004 15:34:07 -0500
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2004-03-12 at 15:02, Jens Axboe wrote:
> On Fri, Mar 12 2004, Andrew Morton wrote:
> > Chris Mason <mason@suse.com> wrote:
> > >
> > > During a mixed load test including fsx-linux and a bunch of procs
> > > running cp/read/rm loops, I got a null pointer deref with the call
> > > trace:
> > > 
> > > __lock_page->sync_page->block_sync_page
> > > 
> > > I don't see how we can trust page->mapping in this path, can't it
> > > disappear?  If so, it would be a bug without Jens' patch too, just
> > > harder to hit.

Here's my guess, it took a few hours to trigger the first time, so it'll
be a while before I can say if it makes a difference.  I'm not convinced
this will help, but it's all I can think of so far...

-chris

Index: linux.t/fs/buffer.c
===================================================================
--- linux.t.orig/fs/buffer.c	2004-03-12 13:13:45.000000000 -0500
+++ linux.t/fs/buffer.c	2004-03-12 15:21:44.635262192 -0500
@@ -2939,7 +2939,10 @@ EXPORT_SYMBOL(try_to_free_buffers);
 
 int block_sync_page(struct page *page)
 {
-	blk_run_address_space(page->mapping);
+	struct address_space *mapping;
+	smp_mb();
+	mapping = page->mapping;
+	blk_run_address_space(mapping);
 	return 0;
 }
 
Index: linux.t/mm/filemap.c
===================================================================
--- linux.t.orig/mm/filemap.c	2004-03-12 13:13:45.000000000 -0500
+++ linux.t/mm/filemap.c	2004-03-12 15:23:00.216089824 -0500
@@ -121,8 +121,10 @@ void remove_from_page_cache(struct page 
 
 static inline int sync_page(struct page *page)
 {
-	struct address_space *mapping = page->mapping;
-
+	struct address_space *mapping;
+	
+	smp_mb();
+	mapping = page->mapping;
 	if (mapping && mapping->a_ops && mapping->a_ops->sync_page)
 		return mapping->a_ops->sync_page(page);
 	return 0;


