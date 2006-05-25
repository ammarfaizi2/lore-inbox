Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964824AbWEYMn3@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964824AbWEYMn3 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 25 May 2006 08:43:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965142AbWEYMn3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 25 May 2006 08:43:29 -0400
Received: from TYO201.gate.nec.co.jp ([202.32.8.193]:38052 "EHLO
	tyo201.gate.nec.co.jp") by vger.kernel.org with ESMTP
	id S964824AbWEYMn2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 25 May 2006 08:43:28 -0400
To: adilger@clusterfs.com, cmm@us.ibm.com, jitendra@linsyssoft.com
Cc: ext2-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org
Subject: [UPDATE][3/24]ext3 add new percpu_counter
Message-Id: <20060525214320sho@rifu.tnes.nec.co.jp>
Mime-Version: 1.0
X-Mailer: WeMail32[2.51] ID:1K0086
From: sho@tnes.nec.co.jp
Date: Thu, 25 May 2006 21:43:20 +0900
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Summary of this patch:
  [3/24]  add percpu_llcounter for ext3
          - The number of blocks and inodes are counted using
            percpu_counter whose entry for counter is long type, so it
            can only have less than 2G-1.  Then I add percpu_llcounter
            whose entry for counter is long long type in ext3.


Signed-off-by: Takashi Sato sho@tnes.nec.co.jp
---
diff -upNr -X linux-2.6.17-rc4/Documentation/dontdiff linux-2.6.17-rc4/fs/ext3/balloc.c linux-2.6.17-rc4.tmp/fs/ext3/balloc.c
--- linux-2.6.17-rc4/fs/ext3/balloc.c	2006-05-25 16:30:19.452872477 +0900
+++ linux-2.6.17-rc4.tmp/fs/ext3/balloc.c	2006-05-25 16:30:25.655020839 +0900
@@ -467,7 +467,7 @@ do_more:
 		cpu_to_le16(le16_to_cpu(desc->bg_free_blocks_count) +
 			group_freed);
 	spin_unlock(sb_bgl_lock(sbi, block_group));
-	percpu_counter_mod(&sbi->s_freeblocks_counter, count);
+	percpu_llcounter_mod(&sbi->s_freeblocks_counter, count);
 
 	/* We dirtied the bitmap block */
 	BUFFER_TRACE(bitmap_bh, "dirtied bitmap block");
@@ -1168,7 +1168,7 @@ static int ext3_has_free_blocks(struct e
 {
 	unsigned long free_blocks, root_blocks;
 
-	free_blocks = percpu_counter_read_positive(&sbi->s_freeblocks_counter);
+	free_blocks = percpu_llcounter_read_positive(&sbi->s_freeblocks_counter);
 	root_blocks = le32_to_cpu(sbi->s_es->s_r_blocks_count);
 	if (free_blocks < root_blocks + 1 && !capable(CAP_SYS_RESOURCE) &&
 		sbi->s_resuid != current->fsuid &&
@@ -1431,7 +1431,7 @@ allocated:
 	gdp->bg_free_blocks_count =
 			cpu_to_le16(le16_to_cpu(gdp->bg_free_blocks_count) - num);
 	spin_unlock(sb_bgl_lock(sbi, group_no));
-	percpu_counter_mod(&sbi->s_freeblocks_counter, -num);
+	percpu_llcounter_mod(&sbi->s_freeblocks_counter, -(long long)num);
 
 	BUFFER_TRACE(gdp_bh, "journal_dirty_metadata for group descriptor");
 	err = ext3_journal_dirty_metadata(handle, gdp_bh);
diff -upNr -X linux-2.6.17-rc4/Documentation/dontdiff linux-2.6.17-rc4/fs/ext3/ialloc.c linux-2.6.17-rc4.tmp/fs/ext3/ialloc.c
--- linux-2.6.17-rc4/fs/ext3/ialloc.c	2006-05-25 16:30:19.453849040 +0900
+++ linux-2.6.17-rc4.tmp/fs/ext3/ialloc.c	2006-05-25 16:30:25.655997401 +0900
@@ -170,9 +170,9 @@ void ext3_free_inode (handle_t *handle, 
 				gdp->bg_used_dirs_count = cpu_to_le16(
 				  le16_to_cpu(gdp->bg_used_dirs_count) - 1);
 			spin_unlock(sb_bgl_lock(sbi, block_group));
-			percpu_counter_inc(&sbi->s_freeinodes_counter);
+			percpu_llcounter_inc(&sbi->s_freeinodes_counter);
 			if (is_directory)
-				percpu_counter_dec(&sbi->s_dirs_counter);
+				percpu_llcounter_dec(&sbi->s_dirs_counter);
 
 		}
 		BUFFER_TRACE(bh2, "call ext3_journal_dirty_metadata");
@@ -207,7 +207,7 @@ static int find_group_dir(struct super_b
 	struct buffer_head *bh;
 	int group, best_group = -1;
 
-	freei = percpu_counter_read_positive(&EXT3_SB(sb)->s_freeinodes_counter);
+	freei = percpu_llcounter_read_positive(&EXT3_SB(sb)->s_freeinodes_counter);
 	avefreei = freei / ngroups;
 
 	for (group = 0; group < ngroups; group++) {
@@ -269,11 +269,11 @@ static int find_group_orlov(struct super
 	struct ext3_group_desc *desc;
 	struct buffer_head *bh;
 
-	freei = percpu_counter_read_positive(&sbi->s_freeinodes_counter);
+	freei = percpu_llcounter_read_positive(&sbi->s_freeinodes_counter);
 	avefreei = freei / ngroups;
-	freeb = percpu_counter_read_positive(&sbi->s_freeblocks_counter);
+	freeb = percpu_llcounter_read_positive(&sbi->s_freeblocks_counter);
 	avefreeb = freeb / ngroups;
-	ndirs = percpu_counter_read_positive(&sbi->s_dirs_counter);
+	ndirs = percpu_llcounter_read_positive(&sbi->s_dirs_counter);
 
 	if ((parent == sb->s_root->d_inode) ||
 	    (EXT3_I(parent)->i_flags & EXT3_TOPDIR_FL)) {
@@ -539,9 +539,9 @@ got:
 	err = ext3_journal_dirty_metadata(handle, bh2);
 	if (err) goto fail;
 
-	percpu_counter_dec(&sbi->s_freeinodes_counter);
+	percpu_llcounter_dec(&sbi->s_freeinodes_counter);
 	if (S_ISDIR(mode))
-		percpu_counter_inc(&sbi->s_dirs_counter);
+		percpu_llcounter_inc(&sbi->s_dirs_counter);
 	sb->s_dirt = 1;
 
 	inode->i_uid = current->fsuid;
diff -upNr -X linux-2.6.17-rc4/Documentation/dontdiff linux-2.6.17-rc4/fs/ext3/resize.c linux-2.6.17-rc4.tmp/fs/ext3/resize.c
--- linux-2.6.17-rc4/fs/ext3/resize.c	2006-05-25 16:30:19.456778727 +0900
+++ linux-2.6.17-rc4.tmp/fs/ext3/resize.c	2006-05-25 16:30:25.656973964 +0900
@@ -870,9 +870,9 @@ int ext3_group_add(struct super_block *s
 		input->reserved_blocks);
 
 	/* Update the free space counts */
-	percpu_counter_mod(&sbi->s_freeblocks_counter,
+	percpu_llcounter_mod(&sbi->s_freeblocks_counter,
 			   input->free_blocks_count);
-	percpu_counter_mod(&sbi->s_freeinodes_counter,
+	percpu_llcounter_mod(&sbi->s_freeinodes_counter,
 			   EXT3_INODES_PER_GROUP(sb));
 
 	ext3_journal_dirty_metadata(handle, sbi->s_sbh);
diff -upNr -X linux-2.6.17-rc4/Documentation/dontdiff linux-2.6.17-rc4/fs/ext3/super.c linux-2.6.17-rc4.tmp/fs/ext3/super.c
--- linux-2.6.17-rc4/fs/ext3/super.c	2006-05-25 16:18:35.858154534 +0900
+++ linux-2.6.17-rc4.tmp/fs/ext3/super.c	2006-05-25 16:30:25.658927089 +0900
@@ -403,9 +403,9 @@ static void ext3_put_super (struct super
 	for (i = 0; i < sbi->s_gdb_count; i++)
 		brelse(sbi->s_group_desc[i]);
 	kfree(sbi->s_group_desc);
-	percpu_counter_destroy(&sbi->s_freeblocks_counter);
-	percpu_counter_destroy(&sbi->s_freeinodes_counter);
-	percpu_counter_destroy(&sbi->s_dirs_counter);
+	percpu_llcounter_destroy(&sbi->s_freeblocks_counter);
+	percpu_llcounter_destroy(&sbi->s_freeinodes_counter);
+	percpu_llcounter_destroy(&sbi->s_dirs_counter);
 	brelse(sbi->s_sbh);
 #ifdef CONFIG_QUOTA
 	for (i = 0; i < MAXQUOTAS; i++)
@@ -1579,9 +1579,9 @@ static int ext3_fill_super (struct super
 		goto failed_mount;
 	}
 
-	percpu_counter_init(&sbi->s_freeblocks_counter);
-	percpu_counter_init(&sbi->s_freeinodes_counter);
-	percpu_counter_init(&sbi->s_dirs_counter);
+	percpu_llcounter_init(&sbi->s_freeblocks_counter);
+	percpu_llcounter_init(&sbi->s_freeinodes_counter);
+	percpu_llcounter_init(&sbi->s_dirs_counter);
 	bgl_lock_init(&sbi->s_blockgroup_lock);
 
 	for (i = 0; i < db_count; i++) {
@@ -1723,11 +1723,11 @@ static int ext3_fill_super (struct super
 		test_opt(sb,DATA_FLAGS) == EXT3_MOUNT_ORDERED_DATA ? "ordered":
 		"writeback");
 
-	percpu_counter_mod(&sbi->s_freeblocks_counter,
+	percpu_llcounter_mod(&sbi->s_freeblocks_counter,
 		ext3_count_free_blocks(sb));
-	percpu_counter_mod(&sbi->s_freeinodes_counter,
+	percpu_llcounter_mod(&sbi->s_freeinodes_counter,
 		ext3_count_free_inodes(sb));
-	percpu_counter_mod(&sbi->s_dirs_counter,
+	percpu_llcounter_mod(&sbi->s_dirs_counter,
 		ext3_count_dirs(sb));
 
 	lock_kernel();
@@ -2363,12 +2363,12 @@ static int ext3_statfs (struct super_blo
 	buf->f_type = EXT3_SUPER_MAGIC;
 	buf->f_bsize = sb->s_blocksize;
 	buf->f_blocks = le32_to_cpu(es->s_blocks_count) - overhead;
-	buf->f_bfree = percpu_counter_sum(&sbi->s_freeblocks_counter);
+	buf->f_bfree = percpu_llcounter_sum(&sbi->s_freeblocks_counter);
 	buf->f_bavail = buf->f_bfree - le32_to_cpu(es->s_r_blocks_count);
 	if (buf->f_bfree < le32_to_cpu(es->s_r_blocks_count))
 		buf->f_bavail = 0;
 	buf->f_files = le32_to_cpu(es->s_inodes_count);
-	buf->f_ffree = percpu_counter_sum(&sbi->s_freeinodes_counter);
+	buf->f_ffree = percpu_llcounter_sum(&sbi->s_freeinodes_counter);
 	buf->f_namelen = EXT3_NAME_LEN;
 	return 0;
 }
diff -upNr -X linux-2.6.17-rc4/Documentation/dontdiff linux-2.6.17-rc4/include/linux/ext3_fs_sb.h linux-2.6.17-rc4.tmp/include/linux/ext3_fs_sb.h
--- linux-2.6.17-rc4/include/linux/ext3_fs_sb.h	2006-03-20 14:53:29.000000000 +0900
+++ linux-2.6.17-rc4.tmp/include/linux/ext3_fs_sb.h	2006-05-25 16:30:25.658927089 +0900
@@ -20,7 +20,7 @@
 #include <linux/timer.h>
 #include <linux/wait.h>
 #include <linux/blockgroup_lock.h>
-#include <linux/percpu_counter.h>
+#include <linux/percpu_llcounter.h>
 #endif
 #include <linux/rbtree.h>
 
@@ -54,9 +54,9 @@ struct ext3_sb_info {
 	u32 s_next_generation;
 	u32 s_hash_seed[4];
 	int s_def_hash_version;
-	struct percpu_counter s_freeblocks_counter;
-	struct percpu_counter s_freeinodes_counter;
-	struct percpu_counter s_dirs_counter;
+	struct percpu_llcounter s_freeblocks_counter;
+	struct percpu_llcounter s_freeinodes_counter;
+	struct percpu_llcounter s_dirs_counter;
 	struct blockgroup_lock s_blockgroup_lock;
 
 	/* root of the per fs reservation window tree */
diff -upNr -X linux-2.6.17-rc4/Documentation/dontdiff linux-2.6.17-rc4/include/linux/percpu_llcounter.h linux-2.6.17-rc4.tmp/include/linux/percpu_llcounter.h
--- linux-2.6.17-rc4/include/linux/percpu_llcounter.h	1970-01-01 09:00:00.000000000 +0900
+++ linux-2.6.17-rc4.tmp/include/linux/percpu_llcounter.h	2006-05-25 16:30:25.659903651 +0900
@@ -0,0 +1,113 @@
+#ifndef _LINUX_LLPERCPU_COUNTER_H
+#define _LINUX_LLPERCPU_COUNTER_H
+/*
+ * A simple "approximate counter" for use in ext2 and ext3 superblocks.
+ *
+ * WARNING: these things are HUGE.  4 kbytes per counter on 32-way P4.
+ */
+
+#include <linux/config.h>
+#include <linux/spinlock.h>
+#include <linux/smp.h>
+#include <linux/threads.h>
+#include <linux/percpu.h>
+
+#ifdef CONFIG_SMP
+
+struct percpu_llcounter {
+	spinlock_t lock;
+	long long count;
+	long long *counters;
+};
+
+#if NR_CPUS >= 16
+#define FBC_BATCH	(NR_CPUS*2)
+#else
+#define FBC_BATCH	(NR_CPUS*4)
+#endif
+
+static inline void percpu_llcounter_init(struct percpu_llcounter *fbc)
+{
+	spin_lock_init(&fbc->lock);
+	fbc->count = 0;
+	fbc->counters = alloc_percpu(long long);
+}
+
+static inline void percpu_llcounter_destroy(struct percpu_llcounter *fbc)
+{
+	free_percpu(fbc->counters);
+}
+
+void percpu_llcounter_mod(struct percpu_llcounter *fbc, long long amount);
+long long percpu_llcounter_sum(struct percpu_llcounter *fbc);
+
+static inline long long percpu_llcounter_read(struct percpu_llcounter *fbc)
+{
+	return fbc->count;
+}
+
+/*
+ * It is possible for the percpu_llcounter_read() to return a small negative
+ * number for some counter which should never be negative.
+ */
+static inline long long percpu_llcounter_read_positive(struct percpu_llcounter *fbc)
+{
+	long long ret = fbc->count;
+
+	barrier();		/* Prevent reloads of fbc->count */
+	if (ret > 0)
+		return ret;
+	return 1;
+}
+
+#else
+
+struct percpu_llcounter {
+	long long count;
+};
+
+static inline void percpu_llcounter_init(struct percpu_llcounter *fbc)
+{
+	fbc->count = 0;
+}
+
+static inline void percpu_llcounter_destroy(struct percpu_llcounter *fbc)
+{
+}
+
+static inline void
+percpu_llcounter_mod(struct percpu_llcounter *fbc, long long amount)
+{
+	preempt_disable();
+	fbc->count += amount;
+	preempt_enable();
+}
+
+static inline long long percpu_llcounter_read(struct percpu_llcounter *fbc)
+{
+	return fbc->count;
+}
+
+static inline long long percpu_llcounter_read_positive(struct percpu_llcounter *fbc)
+{
+	return fbc->count;
+}
+
+static inline long long percpu_llcounter_sum(struct percpu_llcounter *fbc)
+{
+	return percpu_llcounter_read_positive(fbc);
+}
+
+#endif	/* CONFIG_SMP */
+
+static inline void percpu_llcounter_inc(struct percpu_llcounter *fbc)
+{
+	percpu_llcounter_mod(fbc, 1);
+}
+
+static inline void percpu_llcounter_dec(struct percpu_llcounter *fbc)
+{
+	percpu_llcounter_mod(fbc, -1);
+}
+
+#endif /* _LINUX_LLPERCPU_COUNTER_H */
diff -upNr -X linux-2.6.17-rc4/Documentation/dontdiff linux-2.6.17-rc4/mm/swap.c linux-2.6.17-rc4.tmp/mm/swap.c
--- linux-2.6.17-rc4/mm/swap.c	2006-05-25 16:18:36.925537333 +0900
+++ linux-2.6.17-rc4.tmp/mm/swap.c	2006-05-25 16:30:25.660880214 +0900
@@ -26,6 +26,7 @@
 #include <linux/buffer_head.h>	/* for try_to_release_page() */
 #include <linux/module.h>
 #include <linux/percpu_counter.h>
+#include <linux/percpu_llcounter.h>
 #include <linux/percpu.h>
 #include <linux/cpu.h>
 #include <linux/notifier.h>
@@ -501,6 +502,26 @@ void percpu_counter_mod(struct percpu_co
 }
 EXPORT_SYMBOL(percpu_counter_mod);
 
+void percpu_llcounter_mod(struct percpu_llcounter *fbc, long long amount)
+{
+	long long count;
+	long long *pcount;
+	int cpu = get_cpu();
+
+	pcount = per_cpu_ptr(fbc->counters, cpu);
+	count = *pcount + amount;
+	if (count >= FBC_BATCH || count <= -FBC_BATCH) {
+		spin_lock(&fbc->lock);
+		fbc->count += count;
+		*pcount = 0;
+		spin_unlock(&fbc->lock);
+	} else {
+		*pcount = count;
+	}
+	put_cpu();
+}
+EXPORT_SYMBOL(percpu_llcounter_mod);
+
 /*
  * Add up all the per-cpu counts, return the result.  This is a more accurate
  * but much slower version of percpu_counter_read_positive()
@@ -520,6 +541,26 @@ long percpu_counter_sum(struct percpu_co
 	return ret < 0 ? 0 : ret;
 }
 EXPORT_SYMBOL(percpu_counter_sum);
+
+/*
+ * Add up all the per-cpu counts, return the result.  This is a more accurate
+ * but much slower version of percpu_llcounter_read_positive()
+ */
+long long percpu_llcounter_sum(struct percpu_llcounter *fbc)
+{
+	long long ret;
+	int cpu;
+
+	spin_lock(&fbc->lock);
+	ret = fbc->count;
+	for_each_cpu(cpu) {
+		long long *pcount = per_cpu_ptr(fbc->counters, cpu);
+		ret += *pcount;
+	}
+	spin_unlock(&fbc->lock);
+	return ret < 0 ? 0 : ret;
+}
+EXPORT_SYMBOL(percpu_llcounter_sum);
 #endif
 
 /*

