Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S274570AbRITRXg>; Thu, 20 Sep 2001 13:23:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S274572AbRITRX0>; Thu, 20 Sep 2001 13:23:26 -0400
Received: from roc-24-169-102-121.rochester.rr.com ([24.169.102.121]:48806
	"EHLO roc-24-169-102-121.rochester.rr.com") by vger.kernel.org
	with ESMTP id <S274570AbRITRXX>; Thu, 20 Sep 2001 13:23:23 -0400
Date: Thu, 20 Sep 2001 13:23:43 -0400
From: Chris Mason <mason@suse.com>
To: Beau Kuiper <kuib-kl@ljbc.wa.edu.au>
cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Significant performace improvements on reiserfs systems, kupdated bugfixes
Message-ID: <781760000.1001006623@tiny>
X-Mailer: Mulberry/2.1.0 (Linux/x86)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Thursday, September 20, 2001 11:20:26 PM +0800 Beau Kuiper <kuib-kl@ljbc.wa.edu.au> wrote:

> I don't think that this could happen until 2.5.x though, as either
> solution touches every file system. However, if we added an extra methed,
> we could do this while only slightly touching the other filesystems (where
> kupdated sync == real sync) Simply see if the method exists (is non-null)
> and call that instead with a kupdate sync instead of the normal
> super_sync. Are you interested in me writing a patch to do this?

If the patch below doesn't fix things for you, I've got another one
that adds a new super_operation.

> 
> 
>> 
>> It is possible to get almost the same behaviour as 2.2.x by changing the
>> metadata sync interval in bdflush to 30 seconds.
>> 
> 
> But then kupdate doesn't flush normal data as regularly as it should, plus
> it is almost as messy as Patch 1 :-)

Tuning through /proc/sys/vm/bdflush is much nicer than doing a
strcmp on the current process name.

The real problem is probably the way commits are done.  When there 
are other FS writers, the commits are done outside the journal
lock, but if you hit things at just the wrong time, you might
trigger writing the commit blocks inside the lock, which slows
things down.  The patch below tries harder to keep log block io outside
the journal lock.

This way you can play with the kupdate interval to find the right
balance for your workload.

> 
>> > 
>> > Patch 2
>> > 
>> > This patch implements a simple mechinism to ensure that each superblock
>> > only gets told to be flushed once. With reiserfs and the first patch,
>> > the superblock is still dirty after being told to sync (probably
>> > becasue it doesn't want to write out the entire journal every 5
>> > seconds when kupdate calls it). This caused an infinite loop because
>> > sync_supers would always find the reiserfs superblock dirty when
>> > called from kupdated. I am not convinced that this patch is the best
>> > one for this problem (suggestions?)
>> 
>> It is ok to leave the superblock dirty, after all, since the commit
>> wasn't done, the super is still dirty.  If the checks from
>> reiserfs_write_super are actually slowing things down, then it is
>> probably best to fix the checks.
> 
> I meant, there might be better wway to prevent the endless loop than
> adding an extra field to the superblock data structure. I beleive (I
> havn't explored reiserfs code much) the slowdown is caused by the journal
> being synced with the superblock, thus causing:

The dirty bit is cleared by reiserfs_write_super when something has
actually been written to disk.  When reiserfs_write_super doesn't
do the commit, it leaves the super dirty, which is important because
sys_sync and other people rely on the dirty bit.

> 
> 1) Too much contention for disk resources.
> 2) A huge increase in the number of times programs must be suspended to
> wait for the disk
> 3) Poor CPU utilization in code that uses the filesystem regularly (like
> compiling)

The way to avoid these is to not call write_super until you really
want to see things on disk ;-)

> Patch 1 makes a huge difference because it stops reiserfs from reacting
> badly on a kupdated.

-chris

--- linux/fs/reiserfs/journal.c	Sat Sep  8 08:05:32 2001
+++ linux/fs/reiserfs/journal.c	Thu Sep 20 13:15:04 2001
@@ -2872,17 +2872,12 @@
   /* write any buffers that must hit disk before this commit is done */
   fsync_inode_buffers(&(SB_JOURNAL(p_s_sb)->j_dummy_inode)) ;
 
-  /* honor the flush and async wishes from the caller */
+  /* honor the flush wishes from the caller, simple commits can
+  ** be done outside the journal lock, they are done below
+  */
   if (flush) {
-  
     flush_commit_list(p_s_sb, SB_JOURNAL_LIST(p_s_sb) + orig_jindex, 1) ;
     flush_journal_list(p_s_sb,  SB_JOURNAL_LIST(p_s_sb) + orig_jindex , 1) ;  
-  } else if (commit_now) {
-    if (wait_on_commit) {
-      flush_commit_list(p_s_sb, SB_JOURNAL_LIST(p_s_sb) + orig_jindex, 1) ;
-    } else {
-      commit_flush_async(p_s_sb, orig_jindex) ; 
-    }
   }
 
   /* reset journal values for the next transaction */
@@ -2944,6 +2939,16 @@
   atomic_set(&(SB_JOURNAL(p_s_sb)->j_jlock), 0) ;
   /* wake up any body waiting to join. */
   wake_up(&(SB_JOURNAL(p_s_sb)->j_join_wait)) ;
+  
+  if (!flush && commit_now) {
+    if (current->need_resched)
+      schedule() ;
+    if (wait_on_commit) {
+      flush_commit_list(p_s_sb, SB_JOURNAL_LIST(p_s_sb) + orig_jindex, 1) ;
+    } else {
+      commit_flush_async(p_s_sb, orig_jindex) ; 
+    }
+  }
   return 0 ;
 }
 



