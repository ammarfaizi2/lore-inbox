Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265517AbUFIDXP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265517AbUFIDXP (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 8 Jun 2004 23:23:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264283AbUFIDXP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 8 Jun 2004 23:23:15 -0400
Received: from fw.osdl.org ([65.172.181.6]:61368 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S265517AbUFIDXF (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 8 Jun 2004 23:23:05 -0400
Date: Tue, 8 Jun 2004 20:22:17 -0700
From: Andrew Morton <akpm@osdl.org>
To: Chris Mason <mason@suse.com>
Cc: mika.penttila@kolumbus.fi, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] writeback_inodes can race with unmount
Message-Id: <20040608202217.0b7a6371.akpm@osdl.org>
In-Reply-To: <1086744565.10973.192.camel@watt.suse.com>
References: <1086722523.10973.157.camel@watt.suse.com>
	<40C61A20.4000906@kolumbus.fi>
	<1086725926.10973.161.camel@watt.suse.com>
	<20040608145627.0191c026.akpm@osdl.org>
	<1086744565.10973.192.camel@watt.suse.com>
X-Mailer: Sylpheed version 0.9.7 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Chris Mason <mason@suse.com> wrote:
>
> On Tue, 2004-06-08 at 17:56, Andrew Morton wrote:
> > Chris Mason <mason@suse.com> wrote:
> 
> > > > Why don't we have the same race in the sync() path as well? Moving the 
> > > > locking to sync_sb_inodes() itself would fix it also.
> > > 
> > > In the sync() path we're already taking a read lock on s_umount sem. 
> > > Moving the locking into sync_sb_inodes would be tricky, it is sometimes
> > > called with the write lock on s_umount_sem held and sometimes with a
> > > read lock.
> > > 
> > 
> > Plus we'd be dead if we had to do the above.  If that read_trylock() fails
> > the sync() will forget to sync stuff.
> > 
> > And, contra your description, we'll fail the trylock relatively frequently
> > - when some other process is writing back this superblock.
> 
> The write lock is taken much less frequently.  Should be just on
> mount/unmount no?

OK.

> So, it looks like we get this:
> 
> CPU 0				CPU 1
> writeback_inodes		generic_shutdown_super
> sync_sb_inodes			
> iget(inode)
> spin_unlock(&inode_lock)
> 				sop->put_super(sb)
> iput(inode)
> generic_delete_inode()

We really shouldn't have got to ->put_super() when there are still live
inodes around.  I'd say that the problem lies on the umount path.  2.4
might have the same problem, but it'll be much harder to hit.

Something like this?  If so, we should probably lock the inode in
prune_icache() and remove iprune_sem.


--- 25/fs/inode.c~a	2004-06-08 20:06:41.905455400 -0700
+++ 25-akpm/fs/inode.c	2004-06-08 20:19:40.300121424 -0700
@@ -294,10 +294,11 @@ static void dispose_list(struct list_hea
 /*
  * Invalidate all inodes for a device.
  */
-static int invalidate_list(struct list_head *head, struct super_block * sb, struct list_head * dispose)
+static int invalidate_list(struct list_head *head, struct super_block *sb,
+				struct list_head *dispose)
 {
 	struct list_head *next;
-	int busy = 0, count = 0;
+	int ret = 0, count = 0;
 
 	next = head->next;
 	for (;;) {
@@ -311,6 +312,17 @@ static int invalidate_list(struct list_h
 		if (inode->i_sb != sb)
 			continue;
 		invalidate_inode_buffers(inode);
+		if (inode->i_state & I_LOCK) {
+			__iget(inode);
+			inodes_stat.nr_unused -= count;
+			count = 0;
+			spin_unlock(&inode_lock);
+			wait_on_inode(inode);
+			iput(inode);
+			ret = 2;
+			spin_lock(&inode_lock);
+			break;
+		}
 		if (!atomic_read(&inode->i_count)) {
 			hlist_del_init(&inode->i_hash);
 			list_move(&inode->i_list, dispose);
@@ -318,11 +330,11 @@ static int invalidate_list(struct list_h
 			count++;
 			continue;
 		}
-		busy = 1;
+		ret = 1;
 	}
 	/* only unused inodes may be cached with i_count zero */
 	inodes_stat.nr_unused -= count;
-	return busy;
+	return ret;
 }
 
 /*
@@ -343,21 +355,23 @@ static int invalidate_list(struct list_h
  */
 int invalidate_inodes(struct super_block * sb)
 {
-	int busy;
+	int state;
 	LIST_HEAD(throw_away);
 
 	down(&iprune_sem);
 	spin_lock(&inode_lock);
-	busy = invalidate_list(&inode_in_use, sb, &throw_away);
-	busy |= invalidate_list(&inode_unused, sb, &throw_away);
-	busy |= invalidate_list(&sb->s_dirty, sb, &throw_away);
-	busy |= invalidate_list(&sb->s_io, sb, &throw_away);
+	do {
+		state = invalidate_list(&inode_in_use, sb, &throw_away);
+		state |= invalidate_list(&inode_unused, sb, &throw_away);
+		state |= invalidate_list(&sb->s_dirty, sb, &throw_away);
+		state |= invalidate_list(&sb->s_io, sb, &throw_away);
+	} while (state & 2);
 	spin_unlock(&inode_lock);
 
 	dispose_list(&throw_away);
 	up(&iprune_sem);
 
-	return busy;
+	return state;
 }
 
 EXPORT_SYMBOL(invalidate_inodes);
_

