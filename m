Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267623AbTAXKWq>; Fri, 24 Jan 2003 05:22:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267624AbTAXKWq>; Fri, 24 Jan 2003 05:22:46 -0500
Received: from packet.digeo.com ([12.110.80.53]:4038 "EHLO packet.digeo.com")
	by vger.kernel.org with ESMTP id <S267623AbTAXKWo>;
	Fri, 24 Jan 2003 05:22:44 -0500
Date: Fri, 24 Jan 2003 02:32:13 -0800
From: Andrew Morton <akpm@digeo.com>
To: Oleg Drokin <green@namesys.com>
Cc: linux-kernel@vger.kernel.org, Christoph Hellwig <hch@lst.de>
Subject: Re: ext2 FS corruption with 2.5.59.
Message-Id: <20030124023213.63d93156.akpm@digeo.com>
In-Reply-To: <20030123153832.A860@namesys.com>
References: <20030123153832.A860@namesys.com>
X-Mailer: Sylpheed version 0.8.9 (GTK+ 1.2.10; i586-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 24 Jan 2003 10:31:49.0527 (UTC) FILETIME=[CD824270:01C2C393]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Oleg Drokin <green@namesys.com> wrote:
>
> Hello!
> 
>     While doing my usual quick tests I pass all my reiserfs patches through,
>     I accidentally forgot to mount reiserfs partition and all the tests
>     were performed on ext2 instead.
>     So I found that first of all fsx (freebsd nfs testing tool)
>     breaks if there are parallel writers (no matter if they write to this
>     same partition or not). i_blocks value becomes negative on truncate
>     (and then it is written to disk). fsx log attached.
>     Also subsequent fsck found lots of other corruptions.
>     (previously fs was checked and no corruptions were found).
>     Excerpts from e2fsck output are attached.
> 
>     My test consists of running "fsx -c 1234 testfile", "iozone -a",
>     "dbench 60", "fsstress -p10 -n1000000 -d ." at the same time on the
>     tested FS.
>     fsx usually breaks just when dbench is finished.
> 
>     Host is dual athlon 1700+, 1G RAM, SMP kernel, Highmem support, no preemt.
> 
>     I reproduced this behaviour on vanilla 2.5.59. (and It is easily
>     reproducable) 
> 

In 2.5.52 I broke sys_sync in subtle ways.  It seems that fsstress hits
sync() hard enough to trigger the failure.

sys_sync() will set mapping->dirtied_when non-zero against a clean inode. 
Later, in (say) __iget(), that inode gets moved over to inode_unused or
inode_in_use.  But because it has non-zero ->dirtied_when,
__mark_inode_dirty() thinks that the inode must still be on sb->s_dirty.

But it isn't.  It's on inode_in_use.  It (and its pages) never get written
out and the data gets thrown away on unmount.  Christoph has hit the same
thing.  I bet he was running fsstress too.  Sorry about that.

The below patch should fix it up - please test that.

So that's the umount problem.  I don't know why you're getting the fsx-linux
failure - I was unable to hit it in an hour's run of the above workload on
4-way.  Against both scsi and IDE.  So please look further into that, thanks.



diff -puN fs/fs-writeback.c~sync-fix fs/fs-writeback.c
--- 25/fs/fs-writeback.c~sync-fix	2003-01-24 02:14:23.000000000 -0800
+++ 25-akpm/fs/fs-writeback.c	2003-01-24 02:17:12.000000000 -0800
@@ -67,6 +67,7 @@ void __mark_inode_dirty(struct inode *in
 
 	spin_lock(&inode_lock);
 	if ((inode->i_state & flags) != flags) {
+		const int was_dirty = inode->i_state & I_DIRTY;
 		struct address_space *mapping = inode->i_mapping;
 
 		inode->i_state |= flags;
@@ -90,7 +91,7 @@ void __mark_inode_dirty(struct inode *in
 		 * If the inode was already on s_dirty or s_io, don't
 		 * reposition it (that would break s_dirty time-ordering).
 		 */
-		if (!mapping->dirtied_when) {
+		if (!was_dirty) {
 			mapping->dirtied_when = jiffies|1; /* 0 is special */
 			list_move(&inode->i_list, &sb->s_dirty);
 		}
@@ -280,7 +281,7 @@ sync_sb_inodes(struct super_block *sb, s
 		__iget(inode);
 		__writeback_single_inode(inode, really_sync, wbc);
 		if (wbc->sync_mode == WB_SYNC_HOLD) {
-			mapping->dirtied_when = jiffies;
+			mapping->dirtied_when = jiffies|1;
 			list_move(&inode->i_list, &sb->s_dirty);
 		}
 		if (current_is_pdflush())

_

