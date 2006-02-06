Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964860AbWBFXMd@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964860AbWBFXMd (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 6 Feb 2006 18:12:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932418AbWBFXMc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 6 Feb 2006 18:12:32 -0500
Received: from smtp.osdl.org ([65.172.181.4]:12435 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S932363AbWBFXMb (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 6 Feb 2006 18:12:31 -0500
Date: Mon, 6 Feb 2006 15:14:35 -0800
From: Andrew Morton <akpm@osdl.org>
To: David Chinner <dgc@sgi.com>
Cc: dgc@sgi.com, linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH] Prevent large file writeback starvation
Message-Id: <20060206151435.731b786c.akpm@osdl.org>
In-Reply-To: <20060206115500.GK43335175@melbourne.sgi.com>
References: <20060206040027.GI43335175@melbourne.sgi.com>
	<20060205202733.48a02dbe.akpm@osdl.org>
	<20060206054815.GJ43335175@melbourne.sgi.com>
	<20060205222215.313f30a9.akpm@osdl.org>
	<20060206115500.GK43335175@melbourne.sgi.com>
X-Mailer: Sylpheed version 1.0.0 (GTK+ 1.2.10; i386-vine-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

David Chinner <dgc@sgi.com> wrote:
>
>     306 static void
>     307 sync_sb_inodes(struct super_block *sb, struct writeback_control *wbc)
>     308 {
>     309         const unsigned long start = jiffies;    /* livelock avoidance */
>     310
>     311         if (!wbc->for_kupdate || list_empty(&sb->s_io))
>     312                 list_splice_init(&sb->s_dirty, &sb->s_io);
>     313
>     314         while (!list_empty(&sb->s_io)) {
> 
> Correct me if I'm wrong, but my reading of this is that for
> wb_kupdate, we only ever move s_dirty to s_io when s_io is empty.
> then we iterate over s_io until all inodes are moved off this list
> or we hit someother termination criteria. This is why i left the
> large inode on the head of the s_io list until congestion was
> encountered - so that wb_kupdate returned to it first in it's next
> pass.
> 
> So when we get to a young inode on the s_io list, we abort the
> writeback loop for that filesystem with wbc->nr_to_write > 0 and
> return to wb_kupdate....
> 
> However, we still have an inode with lots of dirty data on the head of
> s_dirty, which we can do nothing with until s_io is emptied by
> wb_kupdate.

That sounds right.  I guess what is happening is that we get into the state
where your big-dirty-file is on s_dirty and there are a few
small-dirty-files on s_io.  sync_sb_inodes() writes the small files,
returns "small number of pages written" and that causes wb_kupdate() to
terminate.

I think the problem here is that the wb_kupdate() termination test is wrong
- it should just keep going.

We have another bug due to this: if you create a large number of
zero-length files on a traditional filesystem (ext2, minix, ...), the
writeout of these inodes doesn't work correctly - it takes ages.  Because
the wb_kupdate logic is driven by "number of dirty pages", and all those
dirty inodes have zero dirty pages associated with them.  wb_kupdate says
"oh, nothing to do" and gives up.

So to fix both these problems we need to be smarter about terminating the
wb_kupdate() loop.  Something like "loop until no expired inodes have been
written".

Wildly untested patch:


diff -puN include/linux/writeback.h~wb_kupdate-fix-termination-condition include/linux/writeback.h
--- 25/include/linux/writeback.h~wb_kupdate-fix-termination-condition	Mon Feb  6 15:09:32 2006
+++ 25-akpm/include/linux/writeback.h	Mon Feb  6 15:10:33 2006
@@ -58,6 +58,7 @@ struct writeback_control {
 	unsigned for_kupdate:1;		/* A kupdate writeback */
 	unsigned for_reclaim:1;		/* Invoked from the page allocator */
 	unsigned for_writepages:1;	/* This is a writepages() call */
+	unsigned wrote_expired_inode:1;	/* 1 or more expired inodes written */
 };
 
 /*
diff -puN fs/fs-writeback.c~wb_kupdate-fix-termination-condition fs/fs-writeback.c
--- 25/fs/fs-writeback.c~wb_kupdate-fix-termination-condition	Mon Feb  6 15:09:32 2006
+++ 25-akpm/fs/fs-writeback.c	Mon Feb  6 15:11:58 2006
@@ -367,6 +367,8 @@ sync_sb_inodes(struct super_block *sb, s
 		__iget(inode);
 		pages_skipped = wbc->pages_skipped;
 		__writeback_single_inode(inode, wbc);
+		if (unlikely(wbc->wrote_expired_inode == 0))
+			wbc->wrote_expired_inode = 1;
 		if (wbc->sync_mode == WB_SYNC_HOLD) {
 			inode->dirtied_when = jiffies;
 			list_move(&inode->i_list, &sb->s_dirty);
diff -puN mm/page-writeback.c~wb_kupdate-fix-termination-condition mm/page-writeback.c
--- 25/mm/page-writeback.c~wb_kupdate-fix-termination-condition	Mon Feb  6 15:09:32 2006
+++ 25-akpm/mm/page-writeback.c	Mon Feb  6 15:12:43 2006
@@ -414,8 +414,9 @@ static void wb_kupdate(unsigned long arg
 	while (nr_to_write > 0) {
 		wbc.encountered_congestion = 0;
 		wbc.nr_to_write = MAX_WRITEBACK_PAGES;
+		wbc.wrote_expired_inode = 0;
 		writeback_inodes(&wbc);
-		if (wbc.nr_to_write > 0) {
+		if (wbc.wrote_expired_inode == 0) {
 			if (wbc.encountered_congestion)
 				blk_congestion_wait(WRITE, HZ/10);
 			else
_

