Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S268884AbRG0Qdi>; Fri, 27 Jul 2001 12:33:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S268885AbRG0Qd3>; Fri, 27 Jul 2001 12:33:29 -0400
Received: from vasquez.zip.com.au ([203.12.97.41]:9747 "EHLO
	vasquez.zip.com.au") by vger.kernel.org with ESMTP
	id <S268884AbRG0QdR>; Fri, 27 Jul 2001 12:33:17 -0400
Message-ID: <3B619956.6AA072F9@zip.com.au>
Date: Sat, 28 Jul 2001 02:39:50 +1000
From: Andrew Morton <akpm@zip.com.au>
X-Mailer: Mozilla 4.76 [en] (X11; U; Linux 2.4.7 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Joshua Schmidlkofer <menion@srci.iwpsd.org>
CC: Hans Reiser <reiser@namesys.com>, kernel <linux-kernel@vger.kernel.org>
Subject: Re: ReiserFS / 2.4.6 / Data Corruption
In-Reply-To: <Pine.LNX.4.33.0107271515200.10139-100000@devel.blackstar.nl>,
			<Pine.LNX.4.33.0107271515200.10139-100000@devel.blackstar.nl> <0107270818120A.06707@widmers.oce.srci.oce.int>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org
Original-Recipient: rfc822;linux-kernel-outgoing

Joshua Schmidlkofer wrote:
> 
> I've almost quit using reiser, because everytime I have a power outage, the
> last 2 or three files that I've editted, even ones that I haven't touched in
> a while, will usually be hopelessly corrupted.  The '<file>~' that Emacs
> makes is usually fine though.

It's a matter of timing.  There is a lengthy window where the metadata
is written, but its data is not.  If you crash in this window, the files
contain old data.

You can narrow the window of exposure by fiddling with the
parameters in /proc/sys/vm/bdflush - force a full flush every
five seconds, say.

>   It seems to be that any open file is
> in danger.  I don't know if this is normal, or not, but I switched to XFS on
> several machines.  I have nothing against reiser.  I assumed that these
> problems were due to immaturity....

I'm under the impression that XFS also leaves data in the hands
of the kernel's normal writeback mechanisms and will thus be
exposed to the same problem.  I may be wrong about this.


Here's a ten-minute hack which gives reiserfs a simple `ordered data'
mode.  It simply pushes all the dirty buffers and pages out to disk
before running a commit.  Performance is still OK.

I hit reset partway through a massive file tree copy and every
file which had been copied came up peachy - which is very different
from the behaviour without the patch.  Interestingly, there were
zero truncated files as well.  hmmm...






--- linux-2.4.7/include/linux/fs.h	Sat Jul 21 12:37:14 2001
+++ lk-ext3/include/linux/fs.h	Sat Jul 28 02:37:43 2001
@@ -1061,6 +1061,7 @@ extern int fs_may_remount_ro(struct supe
 extern int try_to_free_buffers(struct page *, unsigned int);
 extern void refile_buffer(struct buffer_head * buf);
 extern void end_buffer_io_sync(struct buffer_head *bh, int uptodate);
+extern int flush_all_but_supers(kdev_t dev);
 
 /* reiserfs_writepage needs this */
 extern void set_buffer_async_io(struct buffer_head *bh) ;
--- linux-2.4.7/include/linux/reiserfs_fs_sb.h	Sat Jul 21 12:37:14 2001
+++ lk-ext3/include/linux/reiserfs_fs_sb.h	Sat Jul 28 02:37:43 2001
@@ -289,6 +289,8 @@ struct reiserfs_sb_info
 				/* To be obsoleted soon by per buffer seals.. -Hans */
     atomic_t s_generation_counter; // increased by one every time the
     // tree gets re-balanced
+
+    int no_sync;
     
     /* session statistics */
     int s_kmallocs;
--- linux-2.4.7/fs/reiserfs/journal.c	Sat Jul 21 12:37:14 2001
+++ lk-ext3/fs/reiserfs/journal.c	Sat Jul 28 02:37:43 2001
@@ -2719,6 +2719,9 @@ static int do_journal_end(struct reiserf
   reiserfs_discard_all_prealloc(th); /* it should not involve new blocks into
 				      * the transaction */
 #endif
+
+  if (!p_s_sb->u.reiserfs_sb.no_sync)
+	flush_all_but_supers(p_s_sb->s_dev);
   
   rs = SB_DISK_SUPER_BLOCK(p_s_sb) ;
   /* setup description block */
--- linux-2.4.7/fs/reiserfs/super.c	Wed Jul  4 18:21:31 2001
+++ lk-ext3/fs/reiserfs/super.c	Sat Jul 28 02:37:43 2001
@@ -116,7 +116,9 @@ void reiserfs_put_super (struct super_bl
   /* note, journal_release checks for readonly mount, and can decide not
   ** to do a journal_end
   */
+  s->u.reiserfs_sb.no_sync = 1;
   journal_release(&th, s) ;
+  s->u.reiserfs_sb.no_sync = 0;
 
   for (i = 0; i < SB_BMAP_NR (s); i ++)
     brelse (SB_AP_BITMAP (s)[i]);
--- linux-2.4.7/fs/buffer.c	Sat Jul 21 12:37:14 2001
+++ lk-ext3/fs/buffer.c	Sat Jul 28 02:37:43 2001
@@ -333,6 +333,18 @@ int fsync_dev(kdev_t dev)
 	return sync_buffers(dev, 1);
 }
 
+int flush_all_but_supers(kdev_t dev)
+{
+	sync_buffers(dev, 0);
+
+	lock_kernel();
+	sync_inodes(dev);
+	DQUOT_SYNC(dev);
+	unlock_kernel();
+
+	return sync_buffers(dev, 1);
+}
+
 /*
  * There's no real reason to pretend we should
  * ever do anything differently
--- linux-2.4.7/kernel/ksyms.c	Sat Jul 21 12:37:14 2001
+++ lk-ext3/kernel/ksyms.c	Sat Jul 28 02:37:43 2001
@@ -161,6 +161,7 @@ EXPORT_SYMBOL(d_lookup);
 EXPORT_SYMBOL(__d_path);
 EXPORT_SYMBOL(mark_buffer_dirty);
 EXPORT_SYMBOL(set_buffer_async_io); /* for reiserfs_writepage */
+EXPORT_SYMBOL(flush_all_but_supers);
 EXPORT_SYMBOL(__mark_buffer_dirty);
 EXPORT_SYMBOL(__mark_inode_dirty);
 EXPORT_SYMBOL(get_empty_filp);
