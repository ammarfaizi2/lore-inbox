Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964999AbWBGHmc@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964999AbWBGHmc (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 7 Feb 2006 02:42:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964998AbWBGHmb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 7 Feb 2006 02:42:31 -0500
Received: from omx2-ext.sgi.com ([192.48.171.19]:18080 "EHLO omx2.sgi.com")
	by vger.kernel.org with ESMTP id S964996AbWBGHma (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 7 Feb 2006 02:42:30 -0500
Date: Tue, 7 Feb 2006 18:42:13 +1100
From: David Chinner <dgc@sgi.com>
To: Andrew Morton <akpm@osdl.org>
Cc: David Chinner <dgc@sgi.com>, linux-kernel@vger.kernel.org,
       linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH] Prevent large file writeback starvation
Message-ID: <20060207074213.GX58731470@melbourne.sgi.com>
References: <20060206040027.GI43335175@melbourne.sgi.com> <20060205202733.48a02dbe.akpm@osdl.org> <20060206054815.GJ43335175@melbourne.sgi.com> <20060205222215.313f30a9.akpm@osdl.org> <20060206115500.GK43335175@melbourne.sgi.com> <20060206151435.731b786c.akpm@osdl.org> <20060207003410.GS43335175@melbourne.sgi.com> <20060206170411.360f3a97.akpm@osdl.org> <20060207013157.GU43335175@melbourne.sgi.com> <20060206212750.2126ca8c.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060206212750.2126ca8c.akpm@osdl.org>
User-Agent: Mutt/1.4.2.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Feb 06, 2006 at 09:27:50PM -0800, Andrew Morton wrote:
> David Chinner <dgc@sgi.com> wrote:
> >
> > > We don't want to get in a situation where continuous
> > > overwriting of a large file causes other files on that fs to never be
> > > written out.
> > 
> > Agreed. That's why i proposed the s_more_io queue - it works on those inodes
> > that need more work only after all the other inodes have been written out.
> > That prevents starvation, and makes large inode flushes background work (i.e.
> > occur when there is nothing else to do). it will get much better disk
> > utilisation than the method I originally proposed, as well, because it'll keep
> > the disk near congestion levels until the data is written out...
> > 
> 
> Yes, s_more_io does make sense.  So now dirty inodes can be on one of three
> lists.  It'll be fun writing the changelog for this one.  And we'll need a
> big fat comment describing what the locks do, and the protocol for handling
> them.
>
> We need to be extra-careful to not break sys_sync(), umount, etc.  I guess
> if !for_kupdate, we splice s_dirty and s_more_io onto s_io and go for it.

I've done that slightly differently - s_more_io remains a separate list that
we don't splice - we process it after s_io using the same logic. Clunky, but
good for a test.

> So the protocol would be:
> 
> s_io: contains expired and non-expired dirty inodes, with expired ones at
> the head.  Unexpired ones (at least) are in time order.
> 
> s_more_io: contains dirty expired inodes which haven't been fully written. 
> Ordering doesn't matter (unless someone goes and changes
> dirty_expire_centisecs - but as long as we don't do anything really bad in
> response to this we'll be OK).
> 
> s_dirty: contains expired and non-expired dirty inodes.  The non-expired
> ones are in time-of-dirtying order.

Yup, that's pretty much it.

> I wonder if it would be saner to have separate lists for expired and
> unexpired inodes.  If when writing an expired inode we don't write it all
> out, just rotate it to the back of the expired inode list.  On entry to
> sync_sb_inodes, do a walk of s_dirty, moving expired inodes onto the
> expired list.

That is also a possibility - it would mean that we only are attempting to
write out inodes that have expired. 

I've also discovered another wrinkle -  we hit a different case if the inode
log I/o (from allocation) completes during writeback (do_writepages()). On
XFS, that calls mark_inode_dirty_sync(), so we take the I_DIRTY path in the
logic at the end of __sync_single_inode() and move the inode to the dirty
list. This is why the writeback has been terminating at 70-80k pages written
back in my testing.

Unfortunately, a quick test to move leave the inode on the s_more_io list here
as well when this happens opens us up to overwrite-leads-to-endless-writeout -
we keep dirtying the inode, it's forever expired, and it always remains on the
more_io list, so it always writes out data because it's got data to write out.

So, if we leave the inode on the "more to do" list, we need to prevent
overwrite from monopolising writeout because the only thing stopping it
now is the fact the inode gets shoved to the dirty list by chance.....

I'm going to have a bit more of a think about this. Current
patch attached below.

Signed-of-by: Dave Chinner <dgc@sgi.com>


Index: 2.6.x-xfs-new/fs/fs-writeback.c
===================================================================
--- 2.6.x-xfs-new.orig/fs/fs-writeback.c	2006-02-07 17:27:47.200582770 +1100
+++ 2.6.x-xfs-new/fs/fs-writeback.c	2006-02-07 17:58:20.256182092 +1100
@@ -195,13 +195,12 @@ __sync_single_inode(struct inode *inode,
 			 */
 			if (wbc->for_kupdate) {
 				/*
-				 * For the kupdate function we leave the inode
-				 * at the head of sb_dirty so it will get more
-				 * writeout as soon as the queue becomes
-				 * uncongested.
+				 * For the kupdate function we move the inode
+				 * to the more_io list so that we continue to
+				 * service it after writing other inodes back.
 				 */
 				inode->i_state |= I_DIRTY_PAGES;
-				list_move_tail(&inode->i_list, &sb->s_dirty);
+				list_move(&inode->i_list, &sb->s_more_io);
 			} else {
 				/*
 				 * Otherwise fully redirty the inode so that
@@ -217,9 +216,13 @@ __sync_single_inode(struct inode *inode,
 		} else if (inode->i_state & I_DIRTY) {
 			/*
 			 * Someone redirtied the inode while were writing back
-			 * the pages.
+			 * the pages. Do more work if it's kupdate that is
+			 * writing back.
 			 */
-			list_move(&inode->i_list, &sb->s_dirty);
+			if (wbc->for_kupdate)
+				list_move(&inode->i_list, &sb->s_more_io);
+			else
+				list_move(&inode->i_list, &sb->s_dirty);
 		} else if (atomic_read(&inode->i_count)) {
 			/*
 			 * The inode is clean, inuse
@@ -307,12 +310,15 @@ static void
 sync_sb_inodes(struct super_block *sb, struct writeback_control *wbc)
 {
 	const unsigned long start = jiffies;	/* livelock avoidance */
+	struct list_head *head = &sb->s_io;
 
-	if (!wbc->for_kupdate || list_empty(&sb->s_io))
+	if (!wbc->for_kupdate || list_empty(&sb->s_io)) {
 		list_splice_init(&sb->s_dirty, &sb->s_io);
+	}
 
-	while (!list_empty(&sb->s_io)) {
-		struct inode *inode = list_entry(sb->s_io.prev,
+more:
+	while (!list_empty(head)) {
+		struct inode *inode = list_entry(head->prev,
 						struct inode, i_list);
 		struct address_space *mapping = inode->i_mapping;
 		struct backing_dev_info *bdi = mapping->backing_dev_info;
@@ -351,8 +357,9 @@ sync_sb_inodes(struct super_block *sb, s
 		}
 
 		/* Was this inode dirtied after sync_sb_inodes was called? */
-		if (time_after(inode->dirtied_when, start))
+		if (time_after(inode->dirtied_when, start)) {
 			break;
+		}
 
 		/* Was this inode dirtied too recently? */
 		if (wbc->older_than_this && time_after(inode->dirtied_when,
@@ -389,6 +396,12 @@ sync_sb_inodes(struct super_block *sb, s
 		if (wbc->nr_to_write <= 0)
 			break;
 	}
+
+	/* Do we have inodes that need more I/O? */
+	if (head == &sb->s_io && !list_empty(&sb->s_more_io)) {
+		head = &sb->s_more_io;
+		goto more;
+	}
 	return;		/* Leave any unwritten inodes on s_io */
 }
 
@@ -421,7 +434,9 @@ writeback_inodes(struct writeback_contro
 restart:
 	sb = sb_entry(super_blocks.prev);
 	for (; sb != sb_entry(&super_blocks); sb = sb_entry(sb->s_list.prev)) {
-		if (!list_empty(&sb->s_dirty) || !list_empty(&sb->s_io)) {
+		if (!list_empty(&sb->s_dirty) ||
+		    !list_empty(&sb->s_io) ||
+		    !list_empty(&sb->s_more_io)) {
 			/* we're making our own get_super here */
 			sb->s_count++;
 			spin_unlock(&sb_lock);
Index: 2.6.x-xfs-new/fs/super.c
===================================================================
--- 2.6.x-xfs-new.orig/fs/super.c	2006-02-07 17:27:47.200582770 +1100
+++ 2.6.x-xfs-new/fs/super.c	2006-02-07 17:31:24.706456190 +1100
@@ -67,6 +67,7 @@ static struct super_block *alloc_super(v
 		}
 		INIT_LIST_HEAD(&s->s_dirty);
 		INIT_LIST_HEAD(&s->s_io);
+		INIT_LIST_HEAD(&s->s_more_io);
 		INIT_LIST_HEAD(&s->s_files);
 		INIT_LIST_HEAD(&s->s_instances);
 		INIT_HLIST_HEAD(&s->s_anon);
Index: 2.6.x-xfs-new/include/linux/fs.h
===================================================================
--- 2.6.x-xfs-new.orig/include/linux/fs.h	2006-02-07 17:27:47.200582770 +1100
+++ 2.6.x-xfs-new/include/linux/fs.h	2006-02-07 17:31:24.708409044 +1100
@@ -828,6 +828,7 @@ struct super_block {
 	struct list_head	s_inodes;	/* all inodes */
 	struct list_head	s_dirty;	/* dirty inodes */
 	struct list_head	s_io;		/* parked for writeback */
+	struct list_head	s_more_io;	/* parked for background writeback */
 	struct hlist_head	s_anon;		/* anonymous dentries for (nfs) exporting */
 	struct list_head	s_files;
 

-- 
Dave Chinner
R&D Software Enginner
SGI Australian Software Group
