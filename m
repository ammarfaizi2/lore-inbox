Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S272661AbRITHOW>; Thu, 20 Sep 2001 03:14:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S274224AbRITHOM>; Thu, 20 Sep 2001 03:14:12 -0400
Received: from ljbc.wa.edu.au ([203.59.143.14]:10746 "HELO gamma.ljbc")
	by vger.kernel.org with SMTP id <S272661AbRITHOD>;
	Thu, 20 Sep 2001 03:14:03 -0400
Date: Thu, 20 Sep 2001 15:12:44 +0800 (WST)
From: Beau Kuiper <kuib-kl@ljbc.wa.edu.au>
To: <linux-kernel@vger.kernel.org>
Cc: <tovarlds@transmeta.com>
Subject: [PATCH] Significant performace improvements on reiserfs systems,
 kupdated bugfixes
Message-ID: <Pine.LNX.4.30.0109201445170.13543-100000@gamma.student.ljbc>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

Resierfs on 2.4 has always been bog slow.

I have identified kupdated as the culprit, and have 3 patches that fix the
peformance problems I have had been suffering.

I would like these patches to be reviewed an put into the mainline kernel
so that others can testthe changes.

Patch 1.

This patch fixes reiserfs to use the kupdated code path when told to
resync its super block, like it did in 2.2.19. This is the culpit for bad
reiserfs performace in 2.4. Unfortunately, this fix relies on the second
patch to work properly.

Patch 2

This patch implements a simple mechinism to ensure that each superblock
only gets told to be flushed once. With reiserfs and the first patch, the
superblock is still dirty after being told to sync (probably becasue it
doesn't want to write out the entire journal every 5 seconds when kupdate
calls it). This caused an infinite loop because sync_supers would
always find the reiserfs superblock dirty when called from kupdated. I am
not convinced that this patch is the best one for this problem
(suggestions?)

Patch 3

This patch was generated as I was exploring the buffer cache, wondering
why reiserfs was so slow on 2.4. I found that kupdated may write buffers
that are not actually old back to disk. Eg

Imagine that there are 20 dirty buffers. 16 of them are more that 30
seconds old (and should be written back), but the other 4 are younger than
30 seconds. The current code would force all 20 out to disk, interrupting
programs still using the young 4 until the disk write was complete.

I know that it isn't a major problem, but I found it and I have written
the patch for it :-)

Please try out these patches and give comments about style, performace
ect. They fixed my problems, sliced almost a minute off 2.2.19 kernel
compile time on my duron 700 (from 4min 30sec to 3min 45sec)

Thanks
Beau Kuiper
kuib-kl@ljbc.wa.edu.au

------------------------- PATCH 1:

--- linux-2.4.10pre11/fs/reiserfs/journal.c	Fri Sep 21 14:35:25 2001
+++ linux/fs/reiserfs/journal.c	Fri Sep 21 11:04:36 2001
@@ -2388,7 +2388,7 @@
   if (SB_JOURNAL_LIST_INDEX(p_s_sb) < 0) {
     return 0  ;
   }
-  if (!strcmp(current->comm, "kupdate")) {
+  if (!strcmp(current->comm, "kupdated")) {
     immediate = 0 ;
     keep_dirty = 1 ;
   }

------------------------- PATCH 2:

--- linux-2.4.10pre11/fs/super.c	Fri Sep 21 14:35:25 2001
+++ linux/fs/super.c	Fri Sep 21 12:15:12 2001
@@ -708,11 +708,14 @@
 		return;
 	}
 restart:
+	// since reiserfs does not garrentee super is not dirty (journal may
+	// be dirty still with kupdated), have to do this the hard way
 	spin_lock(&sb_lock);
 	sb = sb_entry(super_blocks.next);
 	while (sb != sb_entry(&super_blocks))
-		if (sb->s_dirt) {
+		if (sb->s_dirt && !(sb->s_flushed)) {
 			sb->s_count++;
+			sb->s_flushed = 1;
 			spin_unlock(&sb_lock);
 			down_read(&sb->s_umount);
 			write_super(sb);
@@ -720,6 +723,16 @@
 			goto restart;
 		} else
 			sb = sb_entry(sb->s_list.next);
+
+	// now unflush all supers
+
+	sb = sb_entry(super_blocks.next);
+	while (sb != sb_entry(&super_blocks))
+	{
+		sb->s_flushed = 0;
+		sb = sb_entry(sb->s_list.next);
+	}
+
 	spin_unlock(&sb_lock);
 }

@@ -805,6 +818,7 @@
 		sema_init(&s->s_dquot.dqio_sem, 1);
 		sema_init(&s->s_dquot.dqoff_sem, 1);
 		s->s_maxbytes = MAX_NON_LFS;
+		s->s_flushed = 0;
 	}
 	return s;
 }
--- linux-2.4.10pre11/include/linux/fs.h	Fri Sep 21 14:35:31 2001
+++ linux/include/linux/fs.h	Fri Sep 21 12:11:49 2001
@@ -689,6 +689,7 @@
 	unsigned long		s_blocksize;
 	unsigned char		s_blocksize_bits;
 	unsigned char		s_dirt;
+	unsigned char		s_flushed;
 	unsigned long long	s_maxbytes;	/* Max file size */
 	struct file_system_type	*s_type;
 	struct super_operations	*s_op;

----------------------- PATCH 3

--- linux-2.4.10pre11/fs/buffer.c	Fri Sep 21 14:35:23 2001
+++ linux/fs/buffer.c	Fri Sep 21 12:05:06 2001
@@ -201,7 +201,7 @@
  * return without it!
  */
 #define NRSYNC (32)
-static int write_some_buffers(kdev_t dev)
+static int write_some_buffers(kdev_t dev, int oldonly)
 {
 	struct buffer_head *next;
 	struct buffer_head *array[NRSYNC];
@@ -217,6 +217,8 @@

 		if (dev && bh->b_dev != dev)
 			continue;
+		if (oldonly && time_before(jiffies, bh->b_flushtime))
+			break;
 		if (test_and_set_bit(BH_Lock, &bh->b_state))
 			continue;
 		if (atomic_set_buffer_clean(bh)) {
@@ -247,7 +249,7 @@
 {
 	do {
 		spin_lock(&lru_list_lock);
-	} while (write_some_buffers(dev));
+	} while (write_some_buffers(dev, 0));
 	run_task_queue(&tq_disk);
 }

@@ -1239,7 +1241,7 @@

 	/* If we're getting into imbalance, start write-out */
 	spin_lock(&lru_list_lock);
-	write_some_buffers(NODEV);
+	write_some_buffers(NODEV, 0);

 	/*
 	 * And if we're _really_ out of balance, wait for
@@ -2768,7 +2770,7 @@
 		bh = lru_list[BUF_DIRTY];
 		if (!bh || time_before(jiffies, bh->b_flushtime))
 			break;
-		if (write_some_buffers(NODEV))
+		if (write_some_buffers(NODEV, 1))
 			continue;
 		return 0;
 	}
@@ -2867,7 +2869,7 @@
 		CHECK_EMERGENCY_SYNC

 		spin_lock(&lru_list_lock);
-		if (!write_some_buffers(NODEV) || balance_dirty_state() < 0) {
+		if (!write_some_buffers(NODEV, 0) || balance_dirty_state() < 0) {
 			wait_for_some_buffers(NODEV);
 			interruptible_sleep_on(&bdflush_wait);
 		}


