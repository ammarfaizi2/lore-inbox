Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315420AbSE2OpQ>; Wed, 29 May 2002 10:45:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315423AbSE2OpP>; Wed, 29 May 2002 10:45:15 -0400
Received: from atrey.karlin.mff.cuni.cz ([195.113.31.123]:51981 "EHLO
	atrey.karlin.mff.cuni.cz") by vger.kernel.org with ESMTP
	id <S315420AbSE2OpI>; Wed, 29 May 2002 10:45:08 -0400
Date: Wed, 29 May 2002 16:45:10 +0200
From: Jan Kara <jack@suse.cz>
To: torvalds@transmeta.com
Cc: Nathan Scott <nathans@wobbly.melbourne.sgi.com>,
        linux-kernel@vger.kernel.org
Subject: [PATCH] 2/3 Quota changes ported to 2.5.18
Message-ID: <20020529144510.GB9503@atrey.karlin.mff.cuni.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

  This second patch changes sysctl interface to use reasonable names in
/proc/sys/fs/quota/

								Honza

-- 
Jan Kara <jack@suse.cz>
SuSE CR Labs


diff -ruNX /home/jack/.kerndiffexclude linux-2.5.18-1-makefix/fs/dquot.c linux-2.5.18-2-procfix/fs/dquot.c
--- linux-2.5.18-1-makefix/fs/dquot.c	Tue May 28 23:41:30 2002
+++ linux-2.5.18-2-procfix/fs/dquot.c	Tue May 28 23:50:06 2002
@@ -121,7 +121,7 @@
  * Unused dquots (dq_count == 0) are added to the free_dquots list when freed,
  * and this list is searched whenever we need an available dquot.  Dquots are
  * removed from the list as soon as they are used again, and
- * dqstats_array[DQSTATS_FREE] gives the number of dquots on the list. When
+ * dqstats.free_dquots gives the number of dquots on the list. When
  * dquot is invalidated it's completely released from memory.
  *
  * Dquots with a specific identity (device, type and id) are placed on
@@ -148,7 +148,7 @@
 static LIST_HEAD(free_dquots);
 static struct list_head dquot_hash[NR_DQHASH];
 
-__u32 dqstats_array[DQSTATS_SIZE];
+struct dqstats dqstats;
 
 static void dqput(struct dquot *);
 static struct dquot *dqduplicate(struct dquot *);
@@ -207,14 +207,14 @@
 static inline void put_dquot_head(struct dquot *dquot)
 {
 	list_add(&dquot->dq_free, &free_dquots);
-	++dqstats_array[DQSTATS_FREE];
+	dqstats.free_dquots++;
 }
 
 /* Add a dquot to the tail of the free list */
 static inline void put_dquot_last(struct dquot *dquot)
 {
 	list_add(&dquot->dq_free, free_dquots.prev);
-	++dqstats_array[DQSTATS_FREE];
+	dqstats.free_dquots++;
 }
 
 /* Move dquot to the head of free list (it must be already on it) */
@@ -230,7 +230,7 @@
 		return;
 	list_del(&dquot->dq_free);
 	INIT_LIST_HEAD(&dquot->dq_free);
-	--dqstats_array[DQSTATS_FREE];
+	dqstats.free_dquots--;
 }
 
 static inline void put_inuse(struct dquot *dquot)
@@ -238,12 +238,12 @@
 	/* We add to the back of inuse list so we don't have to restart
 	 * when traversing this list and we block */
 	list_add(&dquot->dq_inuse, inuse_list.prev);
-	++dqstats_array[DQSTATS_ALLOCATED];
+	dqstats.allocated_dquots++;
 }
 
 static inline void remove_inuse(struct dquot *dquot)
 {
-	--dqstats_array[DQSTATS_ALLOCATED];
+	dqstats.allocated_dquots--;
 	list_del(&dquot->dq_inuse);
 }
 
@@ -403,7 +403,7 @@
 	for (cnt = 0; cnt < MAXQUOTAS; cnt++)
 		if ((cnt == type || type == -1) && sb_has_quota_enabled(sb, cnt) && info_dirty(&dqopt->info[cnt]))
 			dqopt->ops[cnt]->write_file_info(sb, cnt);
-	++dqstats_array[DQSTATS_SYNCS];
+	dqstats.syncs++;
 
 	return 0;
 }
@@ -491,7 +491,7 @@
 	int count = 0;
 
 	lock_kernel();
-	count = dqstats_array[DQSTATS_FREE] / priority;
+	count = dqstats.free_dquots / priority;
 	prune_dqcache(count);
 	unlock_kernel();
 	kmem_cache_shrink(dquot_cachep);
@@ -517,7 +517,7 @@
 	}
 #endif
 
-	++dqstats_array[DQSTATS_DROPS];
+	dqstats.drops++;
 we_slept:
 	if (dquot->dq_dup_ref && dquot->dq_count - dquot->dq_dup_ref <= 1) {	/* Last unduplicated reference? */
 		__wait_dup_drop(dquot);
@@ -597,7 +597,7 @@
 		if (!dquot->dq_count)
 			remove_free_dquot(dquot);
 		get_dquot_ref(dquot);
-		++dqstats_array[DQSTATS_CACHE_HITS];
+		dqstats.cache_hits++;
 		wait_on_dquot(dquot);
 		if (empty)
 			dqput(empty);
@@ -609,7 +609,7 @@
 		return NODQUOT;
 	}
 	++dquot->dq_referenced;
-	++dqstats_array[DQSTATS_LOOKUPS];
+	dqstats.lookups++;
 
 	return dquot;
 }
@@ -629,7 +629,7 @@
 		printk(KERN_ERR "VFS: dqduplicate(): Locked quota to be duplicated!\n");
 	get_dquot_dup_ref(dquot);
 	dquot->dq_referenced++;
-	++dqstats_array[DQSTATS_LOOKUPS];
+	dqstats.lookups++;
 
 	return dquot;
 }
@@ -645,7 +645,7 @@
 	if (!dquot->dq_dup_ref)
 		wake_up(&dquot->dq_wait_free);
 	put_dquot_ref(dquot);
-	++dqstats_array[DQSTATS_DROPS];
+	dqstats.drops++;
 }
 
 static int dqinit_needed(struct inode *inode, int type)
@@ -1473,12 +1473,24 @@
 	set_dqblk:	vfs_set_dqblk
 };
 
+static ctl_table fs_dqstats_table[] = {
+	{FS_DQ_LOOKUPS, "lookups", &dqstats.lookups, sizeof(int), 0444, NULL, &proc_dointvec},
+	{FS_DQ_DROPS, "drops", &dqstats.drops, sizeof(int), 0444, NULL, &proc_dointvec},
+	{FS_DQ_READS, "reads", &dqstats.reads, sizeof(int), 0444, NULL, &proc_dointvec},
+	{FS_DQ_WRITES, "writes", &dqstats.writes, sizeof(int), 0444, NULL, &proc_dointvec},
+	{FS_DQ_CACHE_HITS, "cache_hits", &dqstats.cache_hits, sizeof(int), 0444, NULL, &proc_dointvec},
+	{FS_DQ_ALLOCATED, "allocated_dquots", &dqstats.allocated_dquots, sizeof(int), 0444, NULL, &proc_dointvec},
+	{FS_DQ_FREE, "free_dquots", &dqstats.free_dquots, sizeof(int), 0444, NULL, &proc_dointvec},
+	{FS_DQ_SYNCS, "syncs", &dqstats.syncs, sizeof(int), 0444, NULL, &proc_dointvec},
+	{},
+};
+
 static ctl_table fs_table[] = {
-	{FS_DQSTATS, "dqstats", dqstats_array, sizeof(dqstats_array), 0444, NULL, &proc_dointvec},
+	{FS_DQSTATS, "quota", NULL, 0, 0555, fs_dqstats_table},
 	{},
 };
 
-static ctl_table dquot_table[] = {
+static ctl_table sys_table[] = {
 	{CTL_FS, "fs", NULL, 0, 0555, fs_table},
 	{},
 };
@@ -1487,7 +1499,7 @@
 {
 	int i;
 
-	register_sysctl_table(dquot_table, 0);
+	register_sysctl_table(sys_table, 0);
 	for (i = 0; i < NR_DQHASH; i++)
 		INIT_LIST_HEAD(dquot_hash + i);
 	printk(KERN_NOTICE "VFS: Disk quotas v%s\n", __DQUOT_VERSION__);
@@ -1498,4 +1510,4 @@
 
 EXPORT_SYMBOL(register_quota_format);
 EXPORT_SYMBOL(unregister_quota_format);
-EXPORT_SYMBOL(dqstats_array);
+EXPORT_SYMBOL(dqstats);
diff -ruNX /home/jack/.kerndiffexclude linux-2.5.18-1-makefix/fs/quota.c linux-2.5.18-2-procfix/fs/quota.c
--- linux-2.5.18-1-makefix/fs/quota.c	Tue May 28 23:41:31 2002
+++ linux-2.5.18-2-procfix/fs/quota.c	Tue May 28 23:50:31 2002
@@ -11,7 +11,6 @@
 #include <asm/uaccess.h>
 #include <linux/kernel.h>
 #include <linux/smp_lock.h>
-#include <linux/namei.h>
 #ifdef CONFIG_QIFACE_COMPAT
 #include <linux/quotacompat.h>
 #endif
@@ -410,7 +409,7 @@
 
 static void v1_get_stats(struct v1c_dqstats *dst)
 {
-	memcpy(dst, &dqstats_array, sizeof(dqstats_array));
+	memcpy(dst, &dqstats, sizeof(dqstats));
 }
 #endif
 
@@ -489,7 +488,7 @@
 
 static void v2_get_stats(struct v2c_dqstats *dst)
 {
-	memcpy(dst, &dqstats_array, sizeof(dqstats_array));
+	memcpy(dst, &dqstats, sizeof(dqstats));
 	dst->version = __DQUOT_NUM_VERSION__;
 }
 #endif
diff -ruNX /home/jack/.kerndiffexclude linux-2.5.18-1-makefix/fs/quota_v1.c linux-2.5.18-2-procfix/fs/quota_v1.c
--- linux-2.5.18-1-makefix/fs/quota_v1.c	Tue May 28 23:41:31 2002
+++ linux-2.5.18-2-procfix/fs/quota_v1.c	Tue May 28 23:51:09 2002
@@ -57,7 +57,7 @@
 	if (dquot->dq_dqb.dqb_bhardlimit == 0 && dquot->dq_dqb.dqb_bsoftlimit == 0 &&
 	    dquot->dq_dqb.dqb_ihardlimit == 0 && dquot->dq_dqb.dqb_isoftlimit == 0)
 		dquot->dq_flags |= DQ_FAKE;
-	++dqstats_array[DQSTATS_READS];
+	dqstats.reads++;
 
 	return 0;
 }
@@ -101,7 +101,7 @@
 
 out:
 	set_fs(fs);
-	++dqstats_array[DQSTATS_WRITES];
+	dqstats.writes++;
 
 	return ret;
 }
@@ -233,6 +233,8 @@
 {
         unregister_quota_format(&v1_quota_format);
 }
+
+EXPORT_NO_SYMBOLS;
 
 module_init(init_v1_quota_format);
 module_exit(exit_v1_quota_format);
diff -ruNX /home/jack/.kerndiffexclude linux-2.5.18-1-makefix/fs/quota_v2.c linux-2.5.18-2-procfix/fs/quota_v2.c
--- linux-2.5.18-1-makefix/fs/quota_v2.c	Tue May 28 23:41:31 2002
+++ linux-2.5.18-2-procfix/fs/quota_v2.c	Tue May 28 23:51:05 2002
@@ -430,7 +430,7 @@
 	}
 	else
 		ret = 0;
-	++dqstats_array[DQSTATS_WRITES];
+	dqstats.writes++;
 
 	return ret;
 }
@@ -645,7 +645,7 @@
 		set_fs(fs);
 		disk2memdqb(&dquot->dq_dqb, &ddquot);
 	}
-	++dqstats_array[DQSTATS_READS];
+	dqstats.reads++;
 
 	return ret;
 }
@@ -685,6 +685,8 @@
 {
 	unregister_quota_format(&v2_quota_format);
 }
+
+EXPORT_NO_SYMBOLS;
 
 module_init(init_v2_quota_format);
 module_exit(exit_v2_quota_format);
diff -ruNX /home/jack/.kerndiffexclude linux-2.5.18-1-makefix/include/linux/quota.h linux-2.5.18-2-procfix/include/linux/quota.h
--- linux-2.5.18-1-makefix/include/linux/quota.h	Tue May 28 23:41:33 2002
+++ linux-2.5.18-2-procfix/include/linux/quota.h	Tue May 28 23:58:14 2002
@@ -184,22 +184,18 @@
 
 #define sb_dqopt(sb) (&(sb)->s_dquot)
 
-/*
- * Statistics about disc quota.
- */
-enum {
-	DQSTATS_LOOKUPS,
-	DQSTATS_DROPS,
-	DQSTATS_READS,
-	DQSTATS_WRITES,
-	DQSTATS_CACHE_HITS,
-	DQSTATS_ALLOCATED,
-	DQSTATS_FREE,
-	DQSTATS_SYNCS,
-	DQSTATS_SIZE
+struct dqstats {
+	int lookups;
+	int drops;
+	int reads;
+	int writes;
+	int cache_hits;
+	int allocated_dquots;
+	int free_dquots;
+	int syncs;
 };
 
-extern __u32 dqstats_array[DQSTATS_SIZE];
+extern struct dqstats dqstats;
 
 #define NR_DQHASH 43            /* Just an arbitrary number */
 
diff -ruNX /home/jack/.kerndiffexclude linux-2.5.18-1-makefix/include/linux/sysctl.h linux-2.5.18-2-procfix/include/linux/sysctl.h
--- linux-2.5.18-1-makefix/include/linux/sysctl.h	Tue May 28 23:41:33 2002
+++ linux-2.5.18-2-procfix/include/linux/sysctl.h	Tue May 28 23:58:38 2002
@@ -544,7 +544,19 @@
 	FS_LEASES=13,	/* int: leases enabled */
 	FS_DIR_NOTIFY=14,	/* int: directory notification enabled */
 	FS_LEASE_TIME=15,	/* int: maximum time to wait for a lease break */
-	FS_DQSTATS=16,	/* int: disc quota suage statistics */
+	FS_DQSTATS=16,	/* disc quota usage statistics */
+};
+
+/* /proc/sys/fs/quota/ */
+enum {
+	FS_DQ_LOOKUPS = 1,
+	FS_DQ_DROPS = 2,
+	FS_DQ_READS = 3,
+	FS_DQ_WRITES = 4,
+	FS_DQ_CACHE_HITS = 5,
+	FS_DQ_ALLOCATED = 6,
+	FS_DQ_FREE = 7,
+	FS_DQ_SYNCS = 8,
 };
 
 /* CTL_DEBUG names: */
