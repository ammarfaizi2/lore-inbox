Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263375AbUD2EsM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263375AbUD2EsM (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 29 Apr 2004 00:48:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263355AbUD2EsM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 29 Apr 2004 00:48:12 -0400
Received: from fw.osdl.org ([65.172.181.6]:2451 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S263375AbUD2EsF (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 29 Apr 2004 00:48:05 -0400
Date: Wed, 28 Apr 2004 21:47:41 -0700
From: Andrew Morton <akpm@osdl.org>
To: busterbcook@yahoo.com
Cc: linux-kernel@vger.kernel.org
Subject: Re: pdflush eating a lot of CPU on heavy NFS I/O
Message-Id: <20040428214741.7d5b3ae1.akpm@osdl.org>
In-Reply-To: <Pine.LNX.4.58.0404282330390.13783@ozma.hauschen>
References: <Pine.LNX.4.58.0404280009300.28371@ozma.hauschen>
	<20040427230203.1e4693ac.akpm@osdl.org>
	<Pine.LNX.4.58.0404280826070.31093@ozma.hauschen>
	<20040428124809.418e005d.akpm@osdl.org>
	<Pine.LNX.4.58.0404281534110.3044@ozma.hauschen>
	<20040428182443.6747e34b.akpm@osdl.org>
	<Pine.LNX.4.58.0404282244280.13311@ozma.hauschen>
	<20040428210214.31efe911.akpm@osdl.org>
	<Pine.LNX.4.58.0404282330390.13783@ozma.hauschen>
X-Mailer: Sylpheed version 0.9.7 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Brent Cook <busterbcook@yahoo.com> wrote:
>
> On Wed, 28 Apr 2004, Andrew Morton wrote:
> 
>  > Brent Cook <busterbcook@yahoo.com> wrote:
>  > >
>  > > sync_sb_inodes: write inode c55d25bc
>  > >  __sync_single_inode: writepages in nr_pages:25 nr_to_write:949
>  > >  pages_skipped:0 en:0
>  > >  __sync_single_inode: writepages in nr_pages:25 nr_to_write:949
>  > >  pages_skipped:0 en:0
>  >
>  > uh-huh.
>  >
>  > Does this fix it?
> 
>  I'm going to run a compile/load test overnight, but the test that
>  triggered it every time previously failed to do so with this patch.

OK, thanks.  A better patch would be:


diff -puN fs/fs-writeback.c~writeback-livelock-fix-2 fs/fs-writeback.c
--- 25/fs/fs-writeback.c~writeback-livelock-fix-2	2004-04-28 21:19:32.779061976 -0700
+++ 25-akpm/fs/fs-writeback.c	2004-04-28 21:20:11.080239312 -0700
@@ -176,11 +176,12 @@ __sync_single_inode(struct inode *inode,
 			if (wbc->for_kupdate) {
 				/*
 				 * For the kupdate function we leave the inode
-				 * where it is on sb_dirty so it will get more
+				 * at the head of sb_dirty so it will get more
 				 * writeout as soon as the queue becomes
 				 * uncongested.
 				 */
 				inode->i_state |= I_DIRTY_PAGES;
+				list_move_tail(&inode->i_list, &sb->s_dirty);
 			} else {
 				/*
 				 * Otherwise fully redirty the inode so that

_

>  pdflush is behaving so far, and I'll say you've figured it out for now,
>  with the final verdict in about 8 hours.
> 
>  Does this mean that, if there were too many dirty pages and not enough
>  time to write them all back, that the dirty page list just stopped being
>  traversed, stuck on a single page?

No..  There's all sorts of livelock avoidance code in there and I keep on
forgetting that sometimes writepage won't write the dang page at all -
instead it just redirties the page (and hence the inode).

Now, that redirtying of the inode _should_ have moved the inode off the
s_io list and onto the s_dirty list.  But for some reason it looks like it
didn't, so we get stuck in a loop.  I need to think about it a bit more.
