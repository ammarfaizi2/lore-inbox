Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262770AbTCPVwt>; Sun, 16 Mar 2003 16:52:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262771AbTCPVwt>; Sun, 16 Mar 2003 16:52:49 -0500
Received: from comtv.ru ([217.10.32.4]:41406 "EHLO comtv.ru")
	by vger.kernel.org with ESMTP id <S262770AbTCPVwo>;
	Sun, 16 Mar 2003 16:52:44 -0500
X-Comment-To: Andreas Dilger
To: Andreas Dilger <adilger@clusterfs.com>
Cc: linux-kernel <linux-kernel@vger.kernel.org>,
       ext2-devel@lists.sourceforge.net, Andrew Morton <akpm@digeo.com>
Subject: Re: [Ext2-devel] [PATCH] distributed counters for ext2 to avoid group scaning
References: <m3el5773to.fsf@lexa.home.net>
	<20030316104447.D12806@schatzie.adilger.int>
From: Alex Tomas <bzzz@tmi.comex.ru>
Organization: HOME
Date: 17 Mar 2003 00:55:17 +0300
In-Reply-To: <20030316104447.D12806@schatzie.adilger.int>
Message-ID: <m3bs0bugca.fsf@lexa.home.net>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.2
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


hi!

>>>>> Andreas Dilger (AD) writes:
> > +	dcounter_init(&EXT2_SB(sb)->free_blocks_dc, total_free, 1);
> > +	dcounter_init(&EXT2_SB(sb)->free_inodes_dc,
> > +			le32_to_cpu (es->s_free_inodes_count), 1);
>
> So, why is it that the minimum free blocks/inodes is 1?

damn! it's my mistake. thank you.

> > +struct dcounter {
> > +	int base;
> > +	int min;
> > +	int diff[NR_CPUS];
> > +	seqlock_t lock;
> > +};
>
> For a generic struct, it probably makes more sense to make these fields
> "long" instead of "int".

fixed

> Also, while your goal is to reduce cache ping-pong between CPUs, we will
> now have cache ping-pong for the "diff" array.  We need to do per-cpu
> values or make each value cacheline aligned to avoid ping-pong.

yes, you're right. fixed

> Just for sanity's sake, it would be good to call these fields something
> other than "min" and "lock", since that makes life just hell with tags
> (it always bugs me when structs have fields called list_head, list_entry,
> page, inode, etc).
>
> Maybe something like "dc_min", "dc_lock", etc. would be much nicer?
> The same goes for the fields in the block group info - it would be nice
> if they had a "bgi_" prefix.

it makes sense. I've corrected this for dcounters and hope to correct for
block group info in future cleanups. 

again, corrected patch is against 2.5.64-mm8.

with best regards, Alex

diff -uNr linux/fs/ext2/balloc.c edited/fs/ext2/balloc.c
--- linux/fs/ext2/balloc.c	Sun Mar 16 17:21:33 2003
+++ edited/fs/ext2/balloc.c	Sun Mar 16 17:40:28 2003
@@ -138,6 +138,7 @@
 	desc->bg_free_blocks_count = cpu_to_le16(free_blocks - count);
 
 	spin_unlock(&bgi->balloc_lock);
+	dcounter_add(&EXT2_SB(sb)->free_blocks_dc, -count);
 	sb->s_dirt = 1;
 	mark_buffer_dirty(bh);
 	return count;
@@ -156,6 +157,7 @@
 		desc->bg_free_blocks_count = cpu_to_le16(free_blocks + count);
 
 		spin_unlock(&bgi->balloc_lock);
+		dcounter_add(&EXT2_SB(sb)->free_blocks_dc, count);
 		sb->s_dirt = 1;
 		mark_buffer_dirty(bh);
 	}
@@ -491,7 +493,12 @@
 	goto out_release;
 }
 
-unsigned long ext2_count_free_blocks (struct super_block * sb)
+unsigned long ext2_count_free_blocks(struct super_block *sb)
+{
+	return dcounter_value(&EXT2_SB(sb)->free_blocks_dc);
+}
+
+unsigned long ext2_count_free_blocks_old(struct super_block *sb)
 {
 	struct ext2_group_desc * desc;
 	unsigned long desc_count = 0;
diff -uNr linux/fs/ext2/ialloc.c edited/fs/ext2/ialloc.c
--- linux/fs/ext2/ialloc.c	Sun Mar 16 17:21:33 2003
+++ edited/fs/ext2/ialloc.c	Mon Mar 17 00:29:25 2003
@@ -88,10 +88,13 @@
 	spin_lock(&EXT2_SB(sb)->s_bgi[group].ialloc_lock);
 	desc->bg_free_inodes_count =
 		cpu_to_le16(le16_to_cpu(desc->bg_free_inodes_count) - 1);
-	if (dir)
+	if (dir) {
 		desc->bg_used_dirs_count =
 			cpu_to_le16(le16_to_cpu(desc->bg_used_dirs_count) + 1);
+		dcounter_add(&EXT2_SB(sb)->dirs_dc, 1);
+	}
 	spin_unlock(&EXT2_SB(sb)->s_bgi[group].ialloc_lock);
+	dcounter_add(&EXT2_SB(sb)->free_inodes_dc, -1);
 	sb->s_dirt = 1;
 	mark_buffer_dirty(bh);
 }
@@ -111,10 +114,13 @@
 	spin_lock(&EXT2_SB(sb)->s_bgi[group].ialloc_lock);
 	desc->bg_free_inodes_count =
 		cpu_to_le16(le16_to_cpu(desc->bg_free_inodes_count) + 1);
-	if (dir)
+	if (dir) {
 		desc->bg_used_dirs_count =
 			cpu_to_le16(le16_to_cpu(desc->bg_used_dirs_count) - 1);
+		dcounter_add(&EXT2_SB(sb)->dirs_dc, -1);
+	}
 	spin_unlock(&EXT2_SB(sb)->s_bgi[group].ialloc_lock);
+	dcounter_add(&EXT2_SB(sb)->free_inodes_dc, 1);
 	sb->s_dirt = 1;
 	mark_buffer_dirty(bh);
 }
@@ -317,7 +323,7 @@
 	int free_blocks = ext2_count_free_blocks(sb);
 	int avefreeb = free_blocks / ngroups;
 	int blocks_per_dir;
-	int ndirs = ext2_count_dirs(sb);
+	int ndirs = dcounter_value(&sbi->dirs_dc);
 	int max_debt, max_dirs, min_blocks, min_inodes;
 	int group = -1, i;
 	struct ext2_group_desc *desc;
@@ -624,7 +630,12 @@
 	goto repeat;
 }
 
-unsigned long ext2_count_free_inodes (struct super_block * sb)
+unsigned long ext2_count_free_inodes(struct super_block *sb)
+{
+	return dcounter_value(&EXT2_SB(sb)->free_inodes_dc);
+}
+
+unsigned long ext2_count_free_inodes_old(struct super_block *sb)
 {
 	struct ext2_group_desc *desc;
 	unsigned long desc_count = 0;
diff -uNr linux/fs/ext2/super.c edited/fs/ext2/super.c
--- linux/fs/ext2/super.c	Sun Mar 16 17:21:33 2003
+++ edited/fs/ext2/super.c	Mon Mar 17 00:30:35 2003
@@ -35,6 +35,8 @@
 			    struct ext2_super_block *es);
 static int ext2_remount (struct super_block * sb, int * flags, char * data);
 static int ext2_statfs (struct super_block * sb, struct statfs * buf);
+unsigned long ext2_count_free_inodes_old(struct super_block *sb);
+unsigned long ext2_count_free_blocks_old (struct super_block * sb);
 
 static char error_buf[1024];
 
@@ -508,9 +510,11 @@
 		gdp++;
 	}
 	
-	/* restore free blocks counter in SB -bzzz */
-	es->s_free_blocks_count = total_free = ext2_count_free_blocks(sb);
-	es->s_free_inodes_count = cpu_to_le32(ext2_count_free_inodes(sb));
+	total_free = le32_to_cpu (es->s_free_blocks_count);
+	dcounter_init(&EXT2_SB(sb)->free_blocks_dc, total_free, 0);
+	dcounter_init(&EXT2_SB(sb)->free_inodes_dc,
+			le32_to_cpu (es->s_free_inodes_count), 0);
+	dcounter_init(&EXT2_SB(sb)->dirs_dc, ext2_count_dirs(sb), 1);
 
 	/* distribute reserved blocks over groups -bzzz */
 	for(i = sbi->s_groups_count-1; reserved && total_free && i >= 0; i--) {
@@ -870,8 +874,22 @@
 
 static void ext2_sync_super(struct super_block *sb, struct ext2_super_block *es)
 {
+	if (dcounter_value(&EXT2_SB(sb)->dirs_dc) != ext2_count_dirs(sb))
+		printk("EXT2-fs: invalid dirs_dc %d (real %d)\n",
+				(int) dcounter_value(&EXT2_SB(sb)->dirs_dc),
+				(int) ext2_count_dirs(sb));
+	if (ext2_count_free_blocks(sb) != ext2_count_free_blocks_old(sb))
+		printk("EXT2-fs: invalid free blocks dcounter %d (real %d)\n",
+				(int) ext2_count_free_blocks(sb),
+				(int) ext2_count_free_blocks_old(sb));
 	es->s_free_blocks_count = cpu_to_le32(ext2_count_free_blocks(sb));
+
+	if (ext2_count_free_inodes(sb) != ext2_count_free_inodes_old(sb))
+		printk("EXT2-fs: invalid free inodes dcounter %d (real %d)\n",
+			(int) ext2_count_free_inodes(sb),
+			(int) ext2_count_free_inodes_old(sb));
 	es->s_free_inodes_count = cpu_to_le32(ext2_count_free_inodes(sb));
+
 	es->s_wtime = cpu_to_le32(get_seconds());
 	mark_buffer_dirty(EXT2_SB(sb)->s_sbh);
 	sync_dirty_buffer(EXT2_SB(sb)->s_sbh);
@@ -900,8 +918,25 @@
 			ext2_debug ("setting valid to 0\n");
 			es->s_state = cpu_to_le16(le16_to_cpu(es->s_state) &
 						  ~EXT2_VALID_FS);
-			es->s_free_blocks_count = cpu_to_le32(ext2_count_free_blocks(sb));
-			es->s_free_inodes_count = cpu_to_le32(ext2_count_free_inodes(sb));
+			if (dcounter_value(&EXT2_SB(sb)->dirs_dc) != ext2_count_dirs(sb))
+				printk("EXT2-fs: invalid dirs_dc %d (real %d)\n",
+					(int) dcounter_value(&EXT2_SB(sb)->dirs_dc),
+					(int) ext2_count_dirs(sb));
+
+			es->s_free_blocks_count =
+				cpu_to_le32(ext2_count_free_blocks(sb));
+			if (ext2_count_free_blocks(sb) != ext2_count_free_blocks_old(sb)) 
+				printk("EXT2-fs: invalid free blocks dcounter %d (real %d)\n",
+					(int)ext2_count_free_blocks(sb),
+					(int)ext2_count_free_blocks_old(sb));
+
+			es->s_free_inodes_count =
+				cpu_to_le32(ext2_count_free_inodes(sb));
+			if (ext2_count_free_inodes(sb) != ext2_count_free_inodes_old(sb))
+				 printk("EXT2-fs: invalid free inodes dcounter %d (real %d)\n",
+					(int)ext2_count_free_inodes(sb),
+					(int)ext2_count_free_inodes_old(sb));
+
 			es->s_mtime = cpu_to_le32(get_seconds());
 			ext2_sync_super(sb, es);
 		} else
diff -uNr linux/include/linux/dcounter.h edited/include/linux/dcounter.h
--- linux/include/linux/dcounter.h	Thu Jan  1 03:00:00 1970
+++ edited/include/linux/dcounter.h	Mon Mar 17 00:28:25 2003
@@ -0,0 +1,85 @@
+#ifndef _DCOUNTER_H_
+#define _DCOUNTER_H_
+/*
+ * Distrubuted counters:
+ * 
+ * Problem:
+ *   1) we have to support global counter for some subsystems
+ *      for example, ext2
+ *   2) we do not want to use spinlocks/atomic_t because of cache ping-pong
+ *   3) counter may have some fluctuation
+ *      for example, number of free blocks in ext2
+ *
+ * Solution:
+ *   1) there is 'base' counter
+ *   2) each CPU supports own 'diff'
+ *   3) global value calculated as sum of base and all diff'es
+ *   4) sometimes diff goes to base in order to prevent int overflow.
+ *      this 'syncronization' uses seqlock
+ *   
+ *
+ *   written by Alex Tomas <bzzz@tmi.comex.ru>
+ */
+
+#include <linux/smp.h>
+#include <linux/seqlock.h>
+#include <linux/string.h>
+
+#define DCOUNTER_MAX_DIFF	((1 << 31) / NR_CPUS - 1000)
+
+struct dcounter_diff {
+	long dd_value; 
+} ____cacheline_aligned_in_smp;
+
+struct dcounter {
+	long dc_base;
+	long dc_min;
+	struct dcounter_diff dc_diff[NR_CPUS];
+	seqlock_t dc_lock;
+};
+
+static inline void dcounter_init(struct dcounter *dc, int value, int min)
+{
+	seqlock_init(&dc->dc_lock);
+	dc->dc_base = value;
+	dc->dc_min = min;
+	memset(dc->dc_diff, 0, sizeof(struct dcounter_diff) * NR_CPUS);
+}
+
+static inline int dcounter_value(struct dcounter *dc)
+{
+	int i;
+	int counter;
+	int seq;
+
+	do {
+		seq = read_seqbegin(&dc->dc_lock);
+		counter = dc->dc_base;
+		for (i = 0; i < NR_CPUS; i++)
+			counter += dc->dc_diff[i].dd_value;
+	} while (read_seqretry(&dc->dc_lock, seq));
+
+	if (counter < dc->dc_min)
+		counter = dc->dc_min;	
+	return counter;
+}
+
+static inline void dcounter_add(struct dcounter *dc, int value)
+{
+	int cpu;
+	
+	preempt_disable();
+	cpu = smp_processor_id();
+	dc->dc_diff[cpu].dd_value += value;
+	if (dc->dc_diff[cpu].dd_value > DCOUNTER_MAX_DIFF ||
+		dc->dc_diff[cpu].dd_value < -DCOUNTER_MAX_DIFF) {
+		write_seqlock(&dc->dc_lock);
+		dc->dc_base += dc->dc_diff[cpu].dd_value;
+		dc->dc_diff[cpu].dd_value = 0;
+		write_sequnlock(&dc->dc_lock);
+	}
+	preempt_enable();
+}
+
+#endif /* _DCOUNTER_H_ */
+
diff -uNr linux/include/linux/ext2_fs_sb.h edited/include/linux/ext2_fs_sb.h
--- linux/include/linux/ext2_fs_sb.h	Sun Mar 16 17:21:34 2003
+++ edited/include/linux/ext2_fs_sb.h	Mon Mar 17 00:12:00 2003
@@ -16,6 +16,8 @@
 #ifndef _LINUX_EXT2_FS_SB
 #define _LINUX_EXT2_FS_SB
 
+#include <linux/dcounter.h>
+
 struct ext2_bg_info {
 	u8 debts;
 	spinlock_t balloc_lock;
@@ -52,6 +54,9 @@
 	u32 s_next_generation;
 	unsigned long s_dir_count;
 	struct ext2_bg_info *s_bgi;
+	struct dcounter free_blocks_dc;
+	struct dcounter free_inodes_dc;
+	struct dcounter dirs_dc;
 };
 
 #endif	/* _LINUX_EXT2_FS_SB */


