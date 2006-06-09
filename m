Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965076AbWFIBVV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965076AbWFIBVV (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 8 Jun 2006 21:21:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965078AbWFIBVU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 8 Jun 2006 21:21:20 -0400
Received: from e31.co.us.ibm.com ([32.97.110.149]:22438 "EHLO
	e31.co.us.ibm.com") by vger.kernel.org with ESMTP id S965076AbWFIBVR
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 8 Jun 2006 21:21:17 -0400
Subject: [RFC 1/13] extents and 48bit ext3: percpu count data type changes
From: Mingming Cao <cmm@us.ibm.com>
Reply-To: cmm@us.ibm.com
To: linux-kernel@vger.kernel.org,
       ext2-devel <ext2-devel@lists.sourceforge.net>,
       linux-fsdevel@vger.kernel.org
Content-Type: text/plain
Organization: IBM LTC
Date: Thu, 08 Jun 2006 18:21:14 -0700
Message-Id: <1149816074.4066.61.camel@dyn9047017069.beaverton.ibm.com>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.4 (2.0.4-7) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The percpu counter data type are changed in this set of patches to
support more users like ext3 who need more than 32 bit to store the free
blocks total in the filesystem.

This patch includes:
 - Generic perpcu counters data type changes. The size of the global
counter and local counter were explictly specified using s64 and s32
 The global counter is changed from long to s64,  while the local counter
is changed from long to s32, so we could avoid doing 64 bit update in most
cases.

 - Make use of the new percpu_counter_init() in the applications
 of percpu counters, to able to pass the initial value of the global counter.

Signed-Off-By: Mingming Cao <cmm@us.ibm.com>


---

 linux-2.6.16-ming/fs/ext2/super.c                |   25 ++++++++-------
 linux-2.6.16-ming/fs/ext3/super.c                |   36 ++++++++++++-----------
 linux-2.6.16-ming/fs/file_table.c                |    2 -
 linux-2.6.16-ming/include/linux/percpu_counter.h |   36 +++++++++++------------
 linux-2.6.16-ming/mm/swap.c                      |   12 +++----
 5 files changed, 57 insertions(+), 54 deletions(-)

diff -puN fs/ext2/super.c~percpu_counter_longlong fs/ext2/super.c
--- linux-2.6.16/fs/ext2/super.c~percpu_counter_longlong	2006-06-07 15:41:55.000000000 -0700
+++ linux-2.6.16-ming/fs/ext2/super.c	2006-06-07 15:41:55.000000000 -0700
@@ -834,9 +834,6 @@ static int ext2_fill_super(struct super_
 		printk ("EXT2-fs: not enough memory\n");
 		goto failed_mount;
 	}
-	percpu_counter_init(&sbi->s_freeblocks_counter);
-	percpu_counter_init(&sbi->s_freeinodes_counter);
-	percpu_counter_init(&sbi->s_dirs_counter);
 	bgl_lock_init(&sbi->s_blockgroup_lock);
 	sbi->s_debts = kmalloc(sbi->s_groups_count * sizeof(*sbi->s_debts),
 			       GFP_KERNEL);
@@ -863,6 +860,13 @@ static int ext2_fill_super(struct super_
 	sbi->s_gdb_count = db_count;
 	get_random_bytes(&sbi->s_next_generation, sizeof(u32));
 	spin_lock_init(&sbi->s_next_gen_lock);
+
+	percpu_counter_init(&sbi->s_freeblocks_counter,
+				ext2_count_free_blocks(sb));
+	percpu_counter_init(&sbi->s_freeinodes_counter,
+				ext2_count_free_inodes(sb));
+	percpu_counter_init(&sbi->s_dirs_counter,
+				ext2_count_dirs(sb));
 	/*
 	 * set up enough so that it can read an inode
 	 */
@@ -874,24 +878,18 @@ static int ext2_fill_super(struct super_
 	if (!sb->s_root) {
 		iput(root);
 		printk(KERN_ERR "EXT2-fs: get root inode failed\n");
-		goto failed_mount2;
+		goto failed_mount3;
 	}
 	if (!S_ISDIR(root->i_mode) || !root->i_blocks || !root->i_size) {
 		dput(sb->s_root);
 		sb->s_root = NULL;
 		printk(KERN_ERR "EXT2-fs: corrupt root inode, run e2fsck\n");
-		goto failed_mount2;
+		goto failed_mount3;
 	}
 	if (EXT2_HAS_COMPAT_FEATURE(sb, EXT3_FEATURE_COMPAT_HAS_JOURNAL))
 		ext2_warning(sb, __FUNCTION__,
 			"mounting ext3 filesystem as ext2");
 	ext2_setup_super (sb, es, sb->s_flags & MS_RDONLY);
-	percpu_counter_mod(&sbi->s_freeblocks_counter,
-				ext2_count_free_blocks(sb));
-	percpu_counter_mod(&sbi->s_freeinodes_counter,
-				ext2_count_free_inodes(sb));
-	percpu_counter_mod(&sbi->s_dirs_counter,
-				ext2_count_dirs(sb));
 	return 0;
 
 cantfind_ext2:
@@ -899,7 +897,10 @@ cantfind_ext2:
 		printk("VFS: Can't find an ext2 filesystem on dev %s.\n",
 		       sb->s_id);
 	goto failed_mount;
-
+failed_mount3:
+	percpu_counter_destroy(&sbi->s_freeblocks_counter);
+	percpu_counter_destroy(&sbi->s_freeinodes_counter);
+	percpu_counter_destroy(&sbi->s_dirs_counter);
 failed_mount2:
 	for (i = 0; i < db_count; i++)
 		brelse(sbi->s_group_desc[i]);
diff -puN fs/ext3/super.c~percpu_counter_longlong fs/ext3/super.c
--- linux-2.6.16/fs/ext3/super.c~percpu_counter_longlong	2006-06-07 15:41:55.000000000 -0700
+++ linux-2.6.16-ming/fs/ext3/super.c	2006-06-08 16:50:09.966532209 -0700
@@ -1579,9 +1579,6 @@ static int ext3_fill_super (struct super
 		goto failed_mount;
 	}
 
-	percpu_counter_init(&sbi->s_freeblocks_counter);
-	percpu_counter_init(&sbi->s_freeinodes_counter);
-	percpu_counter_init(&sbi->s_dirs_counter);
 	bgl_lock_init(&sbi->s_blockgroup_lock);
 
 	for (i = 0; i < db_count; i++) {
@@ -1601,6 +1598,14 @@ static int ext3_fill_super (struct super
 	sbi->s_gdb_count = db_count;
 	get_random_bytes(&sbi->s_next_generation, sizeof(u32));
 	spin_lock_init(&sbi->s_next_gen_lock);
+
+	percpu_counter_init(&sbi->s_freeblocks_counter,
+		ext3_count_free_blocks(sb));
+	percpu_counter_init(&sbi->s_freeinodes_counter,
+		ext3_count_free_inodes(sb));
+	percpu_counter_init(&sbi->s_dirs_counter,
+		ext3_count_dirs(sb));
+
 	/* per fileystem reservation list head & lock */
 	spin_lock_init(&sbi->s_rsv_window_lock);
 	sbi->s_rsv_window_root = RB_ROOT;
@@ -1639,16 +1644,16 @@ static int ext3_fill_super (struct super
 	if (!test_opt(sb, NOLOAD) &&
 	    EXT3_HAS_COMPAT_FEATURE(sb, EXT3_FEATURE_COMPAT_HAS_JOURNAL)) {
 		if (ext3_load_journal(sb, es, journal_devnum))
-			goto failed_mount2;
+			goto failed_mount3;
 	} else if (journal_inum) {
 		if (ext3_create_journal(sb, es, journal_inum))
-			goto failed_mount2;
+			goto failed_mount3;
 	} else {
 		if (!silent)
 			printk (KERN_ERR
 				"ext3: No journal on filesystem on %s\n",
 				sb->s_id);
-		goto failed_mount2;
+		goto failed_mount3;
 	}
 
 	/* We have now updated the journal if required, so we can
@@ -1671,7 +1676,7 @@ static int ext3_fill_super (struct super
 		    (sbi->s_journal, 0, 0, JFS_FEATURE_INCOMPAT_REVOKE)) {
 			printk(KERN_ERR "EXT3-fs: Journal does not support "
 			       "requested data journaling mode\n");
-			goto failed_mount3;
+			goto failed_mount4;
 		}
 	default:
 		break;
@@ -1694,13 +1699,13 @@ static int ext3_fill_super (struct super
 	if (!sb->s_root) {
 		printk(KERN_ERR "EXT3-fs: get root inode failed\n");
 		iput(root);
-		goto failed_mount3;
+		goto failed_mount4;
 	}
 	if (!S_ISDIR(root->i_mode) || !root->i_blocks || !root->i_size) {
 		dput(sb->s_root);
 		sb->s_root = NULL;
 		printk(KERN_ERR "EXT3-fs: corrupt root inode, run e2fsck\n");
-		goto failed_mount3;
+		goto failed_mount4;
 	}
 
 	ext3_setup_super (sb, es, sb->s_flags & MS_RDONLY);
@@ -1723,13 +1728,6 @@ static int ext3_fill_super (struct super
 		test_opt(sb,DATA_FLAGS) == EXT3_MOUNT_ORDERED_DATA ? "ordered":
 		"writeback");
 
-	percpu_counter_mod(&sbi->s_freeblocks_counter,
-		ext3_count_free_blocks(sb));
-	percpu_counter_mod(&sbi->s_freeinodes_counter,
-		ext3_count_free_inodes(sb));
-	percpu_counter_mod(&sbi->s_dirs_counter,
-		ext3_count_dirs(sb));
-
 	lock_kernel();
 	return 0;
 
@@ -1739,8 +1737,12 @@ cantfind_ext3:
 		       sb->s_id);
 	goto failed_mount;
 
-failed_mount3:
+failed_mount4:
 	journal_destroy(sbi->s_journal);
+failed_mount3:
+	percpu_counter_destroy(&sbi->s_freeblocks_counter);
+	percpu_counter_destroy(&sbi->s_freeinodes_counter);
+	percpu_counter_destroy(&sbi->s_dirs_counter);
 failed_mount2:
 	for (i = 0; i < db_count; i++)
 		brelse(sbi->s_group_desc[i]);
diff -puN fs/file_table.c~percpu_counter_longlong fs/file_table.c
--- linux-2.6.16/fs/file_table.c~percpu_counter_longlong	2006-06-07 15:41:55.000000000 -0700
+++ linux-2.6.16-ming/fs/file_table.c	2006-06-07 15:41:55.000000000 -0700
@@ -300,5 +300,5 @@ void __init files_init(unsigned long mem
 	if (files_stat.max_files < NR_FILE)
 		files_stat.max_files = NR_FILE;
 	files_defer_init();
-	percpu_counter_init(&nr_files);
+	percpu_counter_init(&nr_files, 0);
 } 
diff -puN include/linux/percpu_counter.h~percpu_counter_longlong include/linux/percpu_counter.h
--- linux-2.6.16/include/linux/percpu_counter.h~percpu_counter_longlong	2006-06-07 15:41:55.000000000 -0700
+++ linux-2.6.16-ming/include/linux/percpu_counter.h	2006-06-07 15:41:55.000000000 -0700
@@ -16,8 +16,8 @@
 
 struct percpu_counter {
 	spinlock_t lock;
-	long count;
-	long *counters;
+	s64 count;
+	s32 *counters;
 };
 
 #if NR_CPUS >= 16
@@ -26,11 +26,11 @@ struct percpu_counter {
 #define FBC_BATCH	(NR_CPUS*4)
 #endif
 
-static inline void percpu_counter_init(struct percpu_counter *fbc)
+static inline void percpu_counter_init(struct percpu_counter *fbc, s64 amount)
 {
 	spin_lock_init(&fbc->lock);
-	fbc->count = 0;
-	fbc->counters = alloc_percpu(long);
+	fbc->count = amount;
+	fbc->counters = alloc_percpu(s32);
 }
 
 static inline void percpu_counter_destroy(struct percpu_counter *fbc)
@@ -38,10 +38,10 @@ static inline void percpu_counter_destro
 	free_percpu(fbc->counters);
 }
 
-void percpu_counter_mod(struct percpu_counter *fbc, long amount);
-long percpu_counter_sum(struct percpu_counter *fbc);
+void percpu_counter_mod(struct percpu_counter *fbc, s32 amount);
+s64 percpu_counter_sum(struct percpu_counter *fbc);
 
-static inline long percpu_counter_read(struct percpu_counter *fbc)
+static inline s64 percpu_counter_read(struct percpu_counter *fbc)
 {
 	return fbc->count;
 }
@@ -50,12 +50,12 @@ static inline long percpu_counter_read(s
  * It is possible for the percpu_counter_read() to return a small negative
  * number for some counter which should never be negative.
  */
-static inline long percpu_counter_read_positive(struct percpu_counter *fbc)
+static inline s64 percpu_counter_read_positive(struct percpu_counter *fbc)
 {
-	long ret = fbc->count;
+	s64 ret = fbc->count;
 
 	barrier();		/* Prevent reloads of fbc->count */
-	if (ret > 0)
+	if (ret >= 0)
 		return ret;
 	return 1;
 }
@@ -63,12 +63,12 @@ static inline long percpu_counter_read_p
 #else
 
 struct percpu_counter {
-	long count;
+	s64 count;
 };
 
-static inline void percpu_counter_init(struct percpu_counter *fbc)
+static inline void percpu_counter_init(struct percpu_counter *fbc, s64 amount)
 {
-	fbc->count = 0;
+	fbc->count = amount;
 }
 
 static inline void percpu_counter_destroy(struct percpu_counter *fbc)
@@ -76,24 +76,24 @@ static inline void percpu_counter_destro
 }
 
 static inline void
-percpu_counter_mod(struct percpu_counter *fbc, long amount)
+percpu_counter_mod(struct percpu_counter *fbc, s32 amount)
 {
 	preempt_disable();
 	fbc->count += amount;
 	preempt_enable();
 }
 
-static inline long percpu_counter_read(struct percpu_counter *fbc)
+static inline s64 percpu_counter_read(struct percpu_counter *fbc)
 {
 	return fbc->count;
 }
 
-static inline long percpu_counter_read_positive(struct percpu_counter *fbc)
+static inline s64 percpu_counter_read_positive(struct percpu_counter *fbc)
 {
 	return fbc->count;
 }
 
-static inline long percpu_counter_sum(struct percpu_counter *fbc)
+static inline s64 percpu_counter_sum(struct percpu_counter *fbc)
 {
 	return percpu_counter_read_positive(fbc);
 }
diff -puN mm/swap.c~percpu_counter_longlong mm/swap.c
--- linux-2.6.16/mm/swap.c~percpu_counter_longlong	2006-06-07 15:41:55.000000000 -0700
+++ linux-2.6.16-ming/mm/swap.c	2006-06-07 15:41:55.000000000 -0700
@@ -481,10 +481,10 @@ static int cpu_swap_callback(struct noti
 #endif /* CONFIG_SMP */
 
 #ifdef CONFIG_SMP
-void percpu_counter_mod(struct percpu_counter *fbc, long amount)
+void percpu_counter_mod(struct percpu_counter *fbc, s32 amount)
 {
-	long count;
-	long *pcount;
+	s64 count;
+	s32 *pcount;
 	int cpu = get_cpu();
 
 	pcount = per_cpu_ptr(fbc->counters, cpu);
@@ -505,15 +505,15 @@ EXPORT_SYMBOL(percpu_counter_mod);
  * Add up all the per-cpu counts, return the result.  This is a more accurate
  * but much slower version of percpu_counter_read_positive()
  */
-long percpu_counter_sum(struct percpu_counter *fbc)
+s64 percpu_counter_sum(struct percpu_counter *fbc)
 {
-	long ret;
+	s64 ret;
 	int cpu;
 
 	spin_lock(&fbc->lock);
 	ret = fbc->count;
 	for_each_possible_cpu(cpu) {
-		long *pcount = per_cpu_ptr(fbc->counters, cpu);
+		s32 *pcount = per_cpu_ptr(fbc->counters, cpu);
 		ret += *pcount;
 	}
 	spin_unlock(&fbc->lock);

_


