Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262673AbTCPO7Z>; Sun, 16 Mar 2003 09:59:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262674AbTCPO7Z>; Sun, 16 Mar 2003 09:59:25 -0500
Received: from comtv.ru ([217.10.32.4]:7607 "EHLO comtv.ru")
	by vger.kernel.org with ESMTP id <S262673AbTCPO7V>;
	Sun, 16 Mar 2003 09:59:21 -0500
To: linux-kernel <linux-kernel@vger.kernel.org>
Cc: ext2-devel@lists.sourceforge.net, Andrew Morton <akpm@digeo.com>
Subject: [PATCH] distributed counters for ext2 to avoid group scaning
From: Alex Tomas <bzzz@tmi.comex.ru>
Organization: HOME
Date: 16 Mar 2003 18:01:55 +0300
Message-ID: <m3el5773to.fsf@lexa.home.net>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.2
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

hi!

ext2 with concurrent balloc/ialloc doesn't maintain global free inodes/blocks counters.
this is due to badness of spinlocks and atomic_t from big iron's viewpoint. therefore,
to know these values we should scan all group descriptors.  there are 81 groups for
10G fs. I believe there is method to avoid scaning and decrease memory footprint. 

problem:
1) we have to maintain something like global counter
2) we do not want to use spinlock/atomic because of cache ping-pong badness
3) it's possible to fluctuate for some counters
   for example, free blocks counter in ext2

solution:
lets have some base value of counter and diff value for each cpu. every time, someone
wants to change (increase/decrease) counter, he increases/decreases diff value for current
cpu. value of global counter may be calculated as sum of base value and all diffs. in
order to prevent diff overflow, we need sometime to 'resyn' diff with base value. this
resync needs to be serialized by seqlock. I called it 'distributed counter'.

this schema have been tested with ext2 on dual P3-1GHz.

here is the patch against _2.5.64-mm8_. would be happy to see any comments/suggestions!


diff -uNr linux/fs/ext2/balloc.c edited/fs/ext2/balloc.c
--- linux/fs/ext2/balloc.c	Sun Mar 16 17:21:33 2003
+++ edited/fs/ext2/balloc.c	Sun Mar 16 17:29:45 2003
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
+++ edited/fs/ext2/ialloc.c	Sun Mar 16 17:32:16 2003
@@ -92,6 +92,7 @@
 		desc->bg_used_dirs_count =
 			cpu_to_le16(le16_to_cpu(desc->bg_used_dirs_count) + 1);
 	spin_unlock(&EXT2_SB(sb)->s_bgi[group].ialloc_lock);
+	dcounter_add(&EXT2_SB(sb)->free_inodes_dc, -1);
 	sb->s_dirt = 1;
 	mark_buffer_dirty(bh);
 }
@@ -115,6 +116,7 @@
 		desc->bg_used_dirs_count =
 			cpu_to_le16(le16_to_cpu(desc->bg_used_dirs_count) - 1);
 	spin_unlock(&EXT2_SB(sb)->s_bgi[group].ialloc_lock);
+	dcounter_add(&EXT2_SB(sb)->free_inodes_dc, 1);
 	sb->s_dirt = 1;
 	mark_buffer_dirty(bh);
 }
@@ -624,7 +626,12 @@
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
+++ edited/fs/ext2/super.c	Sun Mar 16 17:26:10 2003
@@ -35,6 +35,8 @@
 			    struct ext2_super_block *es);
 static int ext2_remount (struct super_block * sb, int * flags, char * data);
 static int ext2_statfs (struct super_block * sb, struct statfs * buf);
+unsigned long ext2_count_free_inodes_old(struct super_block *sb);
+unsigned long ext2_count_free_blocks_old (struct super_block * sb);
 
 static char error_buf[1024];
 
@@ -508,9 +510,10 @@
 		gdp++;
 	}
 	
-	/* restore free blocks counter in SB -bzzz */
-	es->s_free_blocks_count = total_free = ext2_count_free_blocks(sb);
-	es->s_free_inodes_count = cpu_to_le32(ext2_count_free_inodes(sb));
+	total_free = le32_to_cpu (es->s_free_blocks_count);
+	dcounter_init(&EXT2_SB(sb)->free_blocks_dc, total_free, 1);
+	dcounter_init(&EXT2_SB(sb)->free_inodes_dc,
+			le32_to_cpu (es->s_free_inodes_count), 1);
 
 	/* distribute reserved blocks over groups -bzzz */
 	for(i = sbi->s_groups_count-1; reserved && total_free && i >= 0; i--) {
@@ -870,8 +873,18 @@
 
 static void ext2_sync_super(struct super_block *sb, struct ext2_super_block *es)
 {
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
@@ -900,8 +913,20 @@
 			ext2_debug ("setting valid to 0\n");
 			es->s_state = cpu_to_le16(le16_to_cpu(es->s_state) &
 						  ~EXT2_VALID_FS);
-			es->s_free_blocks_count = cpu_to_le32(ext2_count_free_blocks(sb));
-			es->s_free_inodes_count = cpu_to_le32(ext2_count_free_inodes(sb));
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
+++ edited/include/linux/dcounter.h	Sun Mar 16 17:32:35 2003
@@ -0,0 +1,80 @@
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
+struct dcounter {
+	int base;
+	int min;
+	int diff[NR_CPUS];
+	seqlock_t lock;
+};
+
+static inline void dcounter_init(struct dcounter *dc, int value, int min)
+{
+	seqlock_init(&dc->lock);
+	dc->base = value;
+	dc->min = min;
+	memset(dc->diff, 0, sizeof(int) * NR_CPUS);
+}
+
+static inline int dcounter_value(struct dcounter *dc)
+{
+	int i;
+	int counter;
+	int seq;
+
+	do {
+		seq = read_seqbegin(&dc->lock);
+		counter = dc->base;
+		for (i = 0; i < NR_CPUS; i++)
+			counter += dc->diff[i];
+	} while (read_seqretry(&dc->lock, seq));
+
+	if (counter < dc->min)
+		counter = dc->min;	
+	return counter;
+}
+
+static inline void dcounter_add(struct dcounter *dc, int value)
+{
+	int cpu;
+	
+	preempt_disable();
+	cpu = smp_processor_id();
+	dc->diff[cpu] += value;
+	if (dc->diff[cpu] > DCOUNTER_MAX_DIFF || dc->diff[cpu] < -DCOUNTER_MAX_DIFF) {
+		write_seqlock(&dc->lock);
+		dc->base += dc->diff[cpu];
+		dc->diff[cpu] = 0;
+		write_sequnlock(&dc->lock);
+	}
+	preempt_enable();
+}
+
+#endif /* _DCOUNTER_H_ */
+
diff -uNr linux/include/linux/ext2_fs_sb.h edited/include/linux/ext2_fs_sb.h
--- linux/include/linux/ext2_fs_sb.h	Sun Mar 16 17:21:34 2003
+++ edited/include/linux/ext2_fs_sb.h	Sun Mar 16 17:33:44 2003
@@ -16,6 +16,8 @@
 #ifndef _LINUX_EXT2_FS_SB
 #define _LINUX_EXT2_FS_SB
 
+#include <linux/dcounter.h>
+
 struct ext2_bg_info {
 	u8 debts;
 	spinlock_t balloc_lock;
@@ -52,6 +54,8 @@
 	u32 s_next_generation;
 	unsigned long s_dir_count;
 	struct ext2_bg_info *s_bgi;
+	struct dcounter free_blocks_dc;
+	struct dcounter free_inodes_dc;
 };
 
 #endif	/* _LINUX_EXT2_FS_SB */

