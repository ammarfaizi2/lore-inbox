Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267930AbUHFBgN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267930AbUHFBgN (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 5 Aug 2004 21:36:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268003AbUHFBgM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 5 Aug 2004 21:36:12 -0400
Received: from fw.osdl.org ([65.172.181.6]:21974 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S267930AbUHFBgG (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 5 Aug 2004 21:36:06 -0400
Date: Thu, 5 Aug 2004 18:34:15 -0700
From: Andrew Morton <akpm@osdl.org>
To: Nathan Scott <nathans@sgi.com>
Cc: lkml@tlinx.org, helge.hafting@hist.no, linux-kernel@vger.kernel.org
Subject: Re: XFS: how to NOT null files on fsck?
Message-Id: <20040805183415.56230dce.akpm@osdl.org>
In-Reply-To: <20040806011059.GA774@frodo>
References: <200407050247.53743.norberto+linux-kernel@bensa.ath.cx>
	<40EEC9DC.8080501@tlinx.org>
	<20040729013049.GE800@frodo>
	<410FDA19.9020805@tlinx.org>
	<4111ECC2.4040301@hist.no>
	<20040806011059.GA774@frodo>
X-Mailer: Sylpheed version 0.9.7 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Nathan Scott <nathans@sgi.com> wrote:
>
>  On Thu, Aug 05, 2004 at 10:16:02AM +0200, Helge Hafting wrote:
>  > L A Walsh wrote:
>  > >Now I know it takes a while before data may end up on disk and that it
>  > >may not go out to disk in an ordered fashion, but 2-3 days?  
>  > 
>  > Seems strange to me, but the amount of delay is entirely up to the 
>  > filesystem.
> 
>  The flushing of dirty file data is actually performed by
>  kernel threads outside of the individual filesystems.
> 
>  I cannot explain a 2/3 day wait for data to get flushed,
>  something really strange going on for you there.

Well there was a writeback bug which could cause files to not get written
back ever.  Perhaps an unmount would cause writeback but nothing else would.

It was fixed by the below patch.  The situation will only arise with a
combination of a race and a data-synchronising writeback (O_SYNC, fsync,
etc).

It's unlikely that this is the cause of this report though.




From: Miklos Szeredi <miklos@szeredi.hu>

This patch fixes a hard-to-trigger condition, where the inode is on the
inode_in_use list while it's state is dirty.  In this state dirty pages are
not written back in sync() or from kupdate, only from direct page reclaim. 
And this causes a livelock in balance_dirty_pages after a while.

The actual sequence of events required to get into this state is:

thread   function                             inode state         inode list
----------------------------------------------------------------------------
1 __sync_single_inode (background)            I_DIRTY             sb->s_io
1 do_writepages ...                           I_LOCKED
2 __writeback_single_inode (sync) sleeps      I_LOCKED
1 __sync_single_inode (background) finish     0                   inode_in_use
2 __writeback_single_inode (sync) wakeup      0
2 __sync_single_inode (sync)                  0  
2 do_writepages ...                           I_LOCKED
3 __mark_inode_dirty                          I_LOCKED | I_DIRTY
2 __sync_single_inode (sync) finish           I_DIRTY             left on
                                                                  inode_in_use

Signed-off-by: Miklos Szeredi <miklos@szeredi.hu>
Signed-off-by: Andrew Morton <akpm@osdl.org>
---

 25-akpm/fs/fs-writeback.c |    3 ++-
 1 files changed, 2 insertions(+), 1 deletion(-)

diff -puN fs/fs-writeback.c~fix-inode-state-corruption-268-rc1-bk1 fs/fs-writeback.c
--- 25/fs/fs-writeback.c~fix-inode-state-corruption-268-rc1-bk1	Fri Jul 16 15:06:57 2004
+++ 25-akpm/fs/fs-writeback.c	Fri Jul 16 15:06:57 2004
@@ -213,8 +213,9 @@ __sync_single_inode(struct inode *inode,
 		} else if (inode->i_state & I_DIRTY) {
 			/*
 			 * Someone redirtied the inode while were writing back
-			 * the pages: nothing to do.
+			 * the pages.
 			 */
+			list_move(&inode->i_list, &sb->s_dirty);
 		} else if (atomic_read(&inode->i_count)) {
 			/*
 			 * The inode is clean, inuse
_

