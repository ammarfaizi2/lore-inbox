Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264550AbUGIMqT@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264550AbUGIMqT (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 9 Jul 2004 08:46:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264628AbUGIMqT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 9 Jul 2004 08:46:19 -0400
Received: from cantor.suse.de ([195.135.220.2]:26496 "EHLO Cantor.suse.de")
	by vger.kernel.org with ESMTP id S264550AbUGIMqQ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 9 Jul 2004 08:46:16 -0400
Subject: Re: writepage fs corruption fixes
From: Chris Mason <mason@suse.com>
To: Andrew Morton <akpm@osdl.org>
Cc: Andrea Arcangeli <andrea@suse.de>, linux-kernel@vger.kernel.org,
       torvalds@osdl.org
In-Reply-To: <20040708215645.16d0f227.akpm@osdl.org>
References: <20040709040151.GB20947@dualathlon.random>
	 <20040708212923.406135f0.akpm@osdl.org>
	 <20040709044205.GF20947@dualathlon.random>
	 <20040708215645.16d0f227.akpm@osdl.org>
Content-Type: text/plain
Message-Id: <1089376996.3956.141.camel@watt.suse.com>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 
Date: Fri, 09 Jul 2004 08:43:17 -0400
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2004-07-09 at 00:56, Andrew Morton wrote:
> Andrea Arcangeli <andrea@suse.de> wrote:
> >
> > BTW, the new mpage code looks great,
> 
> You should have seen the first version!  But after all the bugs were fixed
> and the real world hit it, some spaghetti got in there.
> 
> > it's a pity that reiserfs and ext3 don't use it yet.
> 
> JFS, hfs, hfsplus and ext2 are using it.
> 
> Unfortunately it's hard to use mpage_writepages() even in ext3's writeback
> mode, because ext3_get_block() assumes that it is called with a transaction
> open.  Not impossible though I guess - use a different get_block() which
> opens a transaction for itself...  But only open it if the page isn't
> already mapped to disk.  (/me gets itchy fingers)

Thanks Andrea!  

The real problem for ext3 and reiserfs using writepages isn't the
transaction I thought, but the data=ordered buffer based writeback.  The
page lock and page writeback bit are critical to the writepages locking,
which we don't take when doing data=ordered writes.

Since we're fixing writepages, here's a much more minor fix.  When the
page has buffers, and fs blocksize is < then the page size, and file eof
falls in the second to last buffer in the page, we will goto
page_is_mapped, which doesn't zero the bytes past eof.

The fix is to move up page_is_mapped slightly.

-chris

Index: linux.t/fs/mpage.c
===================================================================
--- linux.t.orig/fs/mpage.c	2004-07-01 11:07:17.000000000 -0400
+++ linux.t/fs/mpage.c	2004-07-08 12:51:44.915892528 -0400
@@ -490,6 +489,8 @@ mpage_writepage(struct bio *bio, struct 
 
 	first_unmapped = page_block;
 
+page_is_mapped:
+
 	end_index = i_size_read(inode) >> PAGE_CACHE_SHIFT;
 	if (page->index >= end_index) {
 		unsigned offset = i_size_read(inode) & (PAGE_CACHE_SIZE - 1);
@@ -503,8 +504,6 @@ mpage_writepage(struct bio *bio, struct 
 		kunmap_atomic(kaddr, KM_USER0);
 	}
 
-page_is_mapped:
-
 	/*
 	 * This page will go to BIO.  Do we need to send this BIO off first?
 	 */



