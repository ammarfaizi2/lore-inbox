Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264966AbUGJAQQ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264966AbUGJAQQ (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 9 Jul 2004 20:16:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264991AbUGJAQQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 9 Jul 2004 20:16:16 -0400
Received: from mail-relay-2.tiscali.it ([212.123.84.92]:65156 "EHLO
	mail-relay-2.tiscali.it") by vger.kernel.org with ESMTP
	id S264966AbUGJAQO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 9 Jul 2004 20:16:14 -0400
Date: Sat, 10 Jul 2004 02:16:00 +0200
From: Andrea Arcangeli <andrea@suse.de>
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org, torvalds@osdl.org, mason@suse.com
Subject: Re: writepage fs corruption fixes
Message-ID: <20040710001600.GT20947@dualathlon.random>
References: <20040709040151.GB20947@dualathlon.random> <20040708212923.406135f0.akpm@osdl.org> <20040709044205.GF20947@dualathlon.random> <20040708215645.16d0f227.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040708215645.16d0f227.akpm@osdl.org>
X-GPG-Key: 1024D/68B9CB43 13D9 8355 295F 4823 7C49  C012 DFA1 686E 68B9 CB43
X-PGP-Key: 1024R/CB4660B9 CC A0 71 81 F4 A0 63 AC  C0 4B 81 1D 8C 15 C8 E5
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jul 08, 2004 at 09:56:45PM -0700, Andrew Morton wrote:
> Andrea Arcangeli <andrea@suse.de> wrote:
> >
> > BTW, the new mpage code looks great,
> 
> You should have seen the first version!  But after all the bugs were fixed
> and the real world hit it, some spaghetti got in there.

fun ;)

> Unfortunately it's hard to use mpage_writepages() even in ext3's writeback
> mode, because ext3_get_block() assumes that it is called with a transaction
> open.  Not impossible though I guess - use a different get_block() which
> opens a transaction for itself...  But only open it if the page isn't
> already mapped to disk.  (/me gets itchy fingers)

it would be great to enable it. at least readpages already works.

Unfortunately I wasn't reproducing this bug (despite the bug was real),
infact it should trigger only near oom.

So I returning back into debugging, and  am I right this is the real fix
I was looking for? Think i_size == 4097, this buggy below code was used
to write only 1 block, but it should write _two_ of them. This also
explains why it only triggers on ia64 with page_size > 4k and not on x86 :).

I hope this time I'm done with it.

--- sles/fs/mpage.c.~1~	2004-07-09 23:48:33.233205496 +0200
+++ sles/fs/mpage.c	2004-07-10 02:11:59.922789800 +0200
@@ -460,7 +460,7 @@ mpage_writepage(struct bio *bio, struct 
 	 */
 	BUG_ON(!PageUptodate(page));
 	block_in_file = page->index << (PAGE_CACHE_SHIFT - blkbits);
-	last_block = (i_size_read(inode) - 1) >> blkbits;
+	last_block = (i_size_read(inode) + (1 << blkbits) - 1) >> blkbits;
 	map_bh.b_page = page;
 	for (page_block = 0; page_block < blocks_per_page; ) {
 
