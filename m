Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316602AbSE0NEQ>; Mon, 27 May 2002 09:04:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316604AbSE0NEQ>; Mon, 27 May 2002 09:04:16 -0400
Received: from atrey.karlin.mff.cuni.cz ([195.113.31.123]:22544 "EHLO
	atrey.karlin.mff.cuni.cz") by vger.kernel.org with ESMTP
	id <S316602AbSE0NEM>; Mon, 27 May 2002 09:04:12 -0400
Date: Mon, 27 May 2002 15:04:13 +0200
From: Jan Kara <jack@suse.cz>
To: torvalds@transmeta.com
Cc: dalecki@evision-ventures.com,
        Nathan Scott <nathans@wobbly.melbourne.sgi.com>,
        linux-kernel@vger.kernel.org
Subject: [PATCH] 1/2 Quota changes
Message-ID: <20020527130413.GA17926@atrey.karlin.mff.cuni.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

  Hi,

  here I'm sending a bit altered (finally I decided to add
'version' field) Martin's patch which moves quota info from
proc to sysctl... Please apply.

						Honza

-- 
Jan Kara <jack@suse.cz>
SuSE CR Labs


diff -ruNX /home/jack/.kerndiffexclude linux-2.5.17-1-makefix/fs/dquot.c linux-2.5.17-2-procfix/fs/dquot.c
--- linux-2.5.17-1-makefix/fs/dquot.c	Sat May 25 14:28:17 2002
+++ linux-2.5.17-2-procfix/fs/dquot.c	Sat May 25 14:59:20 2002
@@ -118,11 +118,11 @@
  * list is used for the sync and invalidate operations, which must look
  * at every dquot.
  *
- * Unused dquots (dq_count == 0) are added to the free_dquots list when
- * freed, and this list is searched whenever we need an available dquot.
- * Dquots are removed from the list as soon as they are used again, and
- * nr_free_dquots gives the number of dquots on the list. When dquot is
- * invalidated it's completely released from memory.
+ * Unused dquots (dq_count == 0) are added to the free_dquots list when freed,
+ * and this list is searched whenever we need an available dquot.  Dquots are
+ * removed from the list as soon as they are used again, and
+ * dqstats_array[DQSTATS_FREE] gives the number of dquots on the list. When
+ * dquot is invalidated it's completely released from memory.
  *
  * Dquots with a specific identity (device, type and id) are placed on
  * one of the dquot_hash[] hash chains. The provides an efficient search
@@ -148,7 +148,7 @@
 static LIST_HEAD(free_dquots);
 static struct list_head dquot_hash[NR_DQHASH];
 
-struct dqstats dqstats;
+__u32 dqstats_array[DQSTATS_SIZE];
 
 static void dqput(struct dquot *);
 static struct dquot *dqduplicate(struct dquot *);
@@ -207,14 +207,14 @@
 static inline void put_dquot_head(struct dquot *dquot)
 {
 	list_add(&dquot->dq_free, &free_dquots);
-	nr_free_dquots++;
+	++dqstats_array[DQSTATS_FREE];
 }
 
 /* Add a dquot to the tail of the free list */
 static inline void put_dquot_last(struct dquot *dquot)
 {
 	list_add(&dquot->dq_free, free_dquots.prev);
-	nr_free_dquots++;
+	++dqstats_array[DQSTATS_FREE];
 }
 
 /* Move dquot to the head of free list (it must be already on it) */
@@ -230,7 +230,7 @@
 		return;
 	list_del(&dquot->dq_free);
 	INIT_LIST_HEAD(&dquot->dq_free);
-	nr_free_dquots--;
+	--dqstats_array[DQSTATS_FREE];
 }
 
 static inline void put_inuse(struct dquot *dquot)
@@ -238,12 +238,12 @@
 	/* We add to the back of inuse list so we don't have to restart
 	 * when traversing this list and we block */
 	list_add(&dquot->dq_inuse, inuse_list.prev);
-	nr_dquots++;
+	++dqstats_array[DQSTATS_ALLOCATED];
 }
 
 static inline void remove_inuse(struct dquot *dquot)
 {
-	nr_dquots--;
+	--dqstats_array[DQSTATS_ALLOCATED];
 	list_del(&dquot->dq_inuse);
 }
 
@@ -403,7 +403,8 @@
 	for (cnt = 0; cnt < MAXQUOTAS; cnt++)
 		if ((cnt == type || type == -1) && sb_has_quota_enabled(sb, cnt) && info_dirty(&dqopt->info[cnt]))
 			dqopt->ops[cnt]->write_file_info(sb, cnt);
-	dqstats.syncs++;
+	++dqstats_array[DQSTATS_SYNCS];
+
 	return 0;
 }
 
@@ -490,7 +491,7 @@
 	int count = 0;
 
 	lock_kernel();
-	count = nr_free_dquots / priority;
+	count = dqstats_array[DQSTATS_FREE] / priority;
 	prune_dqcache(count);
 	unlock_kernel();
 	kmem_cache_shrink(dquot_cachep);
@@ -516,7 +517,7 @@
 	}
 #endif
 
-	dqstats.drops++;
+	++dqstats_array[DQSTATS_DROPS];
 we_slept:
 	if (dquot->dq_dup_ref && dquot->dq_count - dquot->dq_dup_ref <= 1) {	/* Last unduplicated reference? */
 		__wait_dup_drop(dquot);
@@ -588,15 +589,15 @@
 			goto we_slept;
 		}
 		dquot = empty;
-        	dquot->dq_id = id;
+		dquot->dq_id = id;
 		/* hash it first so it can be found */
 		insert_dquot_hash(dquot);
-        	read_dqblk(dquot);
+		read_dqblk(dquot);
 	} else {
 		if (!dquot->dq_count)
 			remove_free_dquot(dquot);
 		get_dquot_ref(dquot);
-		dqstats.cache_hits++;
+		++dqstats_array[DQSTATS_CACHE_HITS];
 		wait_on_dquot(dquot);
 		if (empty)
 			dqput(empty);
@@ -607,8 +608,8 @@
 		dqput(dquot);
 		return NODQUOT;
 	}
-	dquot->dq_referenced++;
-	dqstats.lookups++;
+	++dquot->dq_referenced;
+	++dqstats_array[DQSTATS_LOOKUPS];
 
 	return dquot;
 }
@@ -628,7 +629,8 @@
 		printk(KERN_ERR "VFS: dqduplicate(): Locked quota to be duplicated!\n");
 	get_dquot_dup_ref(dquot);
 	dquot->dq_referenced++;
-	dqstats.lookups++;
+	++dqstats_array[DQSTATS_LOOKUPS];
+
 	return dquot;
 }
 
@@ -643,7 +645,7 @@
 	if (!dquot->dq_dup_ref)
 		wake_up(&dquot->dq_wait_free);
 	put_dquot_ref(dquot);
-	dqstats.drops++;
+	++dqstats_array[DQSTATS_DROPS];
 }
 
 static int dqinit_needed(struct inode *inode, int type)
@@ -1277,7 +1279,7 @@
 		dqopt->info[cnt].dqi_igrace = 0;
 		dqopt->info[cnt].dqi_bgrace = 0;
 		dqopt->ops[cnt] = NULL;
-	}	
+	}
 	up(&dqopt->dqoff_sem);
 out:
 	unlock_kernel();
@@ -1461,41 +1463,6 @@
 	return 0;
 }
 
-#ifdef CONFIG_PROC_FS
-static int read_stats(char *buffer, char **start, off_t offset, int count, int *eof, void *data)
-{
-	int len;
-	struct quota_format_type *actqf;
-
-	dqstats.allocated_dquots = nr_dquots;
-	dqstats.free_dquots = nr_free_dquots;
-
-	len = sprintf(buffer, "Version %u\n", __DQUOT_NUM_VERSION__);
-	len += sprintf(buffer + len, "Formats");
-	lock_kernel();
-	for (actqf = quota_formats; actqf; actqf = actqf->qf_next)
-		len += sprintf(buffer + len, " %u", actqf->qf_fmt_id);
-	unlock_kernel();
-	len += sprintf(buffer + len, "\n%u %u %u %u %u %u %u %u\n",
-			dqstats.lookups, dqstats.drops,
-			dqstats.reads, dqstats.writes,
-			dqstats.cache_hits, dqstats.allocated_dquots,
-			dqstats.free_dquots, dqstats.syncs);
-
-	if (offset >= len) {
-		*start = buffer;
-		*eof = 1;
-		return 0;
-	}
-	*start = buffer + offset;
-	if ((len -= offset) > count)
-		return count;
-	*eof = 1;
-
-	return len;
-}
-#endif
-
 struct quotactl_ops vfs_quotactl_ops = {
 	quota_on:	vfs_quota_on,
 	quota_off:	vfs_quota_off,
@@ -1507,8 +1474,7 @@
 };
 
 static ctl_table fs_table[] = {
-	{FS_NRDQUOT, "dquot-nr", &nr_dquots, 2*sizeof(int),
-	 0444, NULL, &proc_dointvec},
+	{FS_DQSTATS, "dqstats", dqstats_array, sizeof(dqstats_array), 0444, NULL, &proc_dointvec},
 	{},
 };
 
@@ -1522,16 +1488,15 @@
 	int i;
 
 	register_sysctl_table(dquot_table, 0);
+	dqstats_array[DQSTATS_VERSION] = __DQUOT_NUM_VERSION__;
 	for (i = 0; i < NR_DQHASH; i++)
 		INIT_LIST_HEAD(dquot_hash + i);
-	printk(KERN_NOTICE "VFS: Diskquotas version %s initialized\n", __DQUOT_VERSION__);
-#ifdef CONFIG_PROC_FS
-	create_proc_read_entry("fs/quota", 0, 0, read_stats, NULL);
-#endif
+	printk(KERN_NOTICE "VFS: Disk quotas v%s\n", __DQUOT_VERSION__);
+
 	return 0;
 }
 __initcall(dquot_init);
 
 EXPORT_SYMBOL(register_quota_format);
 EXPORT_SYMBOL(unregister_quota_format);
-EXPORT_SYMBOL(dqstats);
+EXPORT_SYMBOL(dqstats_array);
diff -ruNX /home/jack/.kerndiffexclude linux-2.5.17-1-makefix/fs/quota.c linux-2.5.17-2-procfix/fs/quota.c
--- linux-2.5.17-1-makefix/fs/quota.c	Sat May 25 14:25:33 2002
+++ linux-2.5.17-2-procfix/fs/quota.c	Sat May 25 14:32:32 2002
@@ -16,8 +16,6 @@
 #endif
 
 
-int nr_dquots, nr_free_dquots;
-
 /* Check validity of quotactl */
 static int check_quotactl_valid(struct super_block *sb, int type, int cmd, qid_t id)
 {
@@ -411,7 +409,7 @@
 
 static void v1_get_stats(struct v1c_dqstats *dst)
 {
-	memcpy(dst, &dqstats, sizeof(dqstats));
+	memcpy(dst, &dqstats_array, sizeof(dqstats_array));
 }
 #endif
 
@@ -490,7 +488,7 @@
 
 static void v2_get_stats(struct v2c_dqstats *dst)
 {
-	memcpy(dst, &dqstats, sizeof(dqstats));
+	memcpy(dst, &dqstats_array, sizeof(dqstats_array));
 	dst->version = __DQUOT_NUM_VERSION__;
 }
 #endif
diff -ruNX /home/jack/.kerndiffexclude linux-2.5.17-1-makefix/fs/quota_v1.c linux-2.5.17-2-procfix/fs/quota_v1.c
--- linux-2.5.17-1-makefix/fs/quota_v1.c	Sat May 25 14:25:33 2002
+++ linux-2.5.17-2-procfix/fs/quota_v1.c	Sat May 25 14:32:32 2002
@@ -57,7 +57,8 @@
 	if (dquot->dq_dqb.dqb_bhardlimit == 0 && dquot->dq_dqb.dqb_bsoftlimit == 0 &&
 	    dquot->dq_dqb.dqb_ihardlimit == 0 && dquot->dq_dqb.dqb_isoftlimit == 0)
 		dquot->dq_flags |= DQ_FAKE;
-	dqstats.reads++;
+	++dqstats_array[DQSTATS_READS];
+
 	return 0;
 }
 
@@ -100,7 +101,8 @@
 
 out:
 	set_fs(fs);
-	dqstats.writes++;
+	++dqstats_array[DQSTATS_WRITES];
+
 	return ret;
 }
 
diff -ruNX /home/jack/.kerndiffexclude linux-2.5.17-1-makefix/fs/quota_v2.c linux-2.5.17-2-procfix/fs/quota_v2.c
--- linux-2.5.17-1-makefix/fs/quota_v2.c	Sat May 25 14:25:33 2002
+++ linux-2.5.17-2-procfix/fs/quota_v2.c	Sat May 25 14:32:32 2002
@@ -430,7 +430,8 @@
 	}
 	else
 		ret = 0;
-	dqstats.writes++;
+	++dqstats_array[DQSTATS_WRITES];
+
 	return ret;
 }
 
@@ -644,7 +645,8 @@
 		set_fs(fs);
 		disk2memdqb(&dquot->dq_dqb, &ddquot);
 	}
-	dqstats.reads++;
+	++dqstats_array[DQSTATS_READS];
+
 	return ret;
 }
 
diff -ruNX /home/jack/.kerndiffexclude linux-2.5.17-1-makefix/include/linux/quota.h linux-2.5.17-2-procfix/include/linux/quota.h
--- linux-2.5.17-1-makefix/include/linux/quota.h	Sat May 25 14:25:34 2002
+++ linux-2.5.17-2-procfix/include/linux/quota.h	Sat May 25 15:02:53 2002
@@ -132,6 +132,22 @@
 	__u32 dqi_valid;
 };
 
+/*
+ * Statistics about disc quota.
+ */
+enum {
+	DQSTATS_VERSION,
+	DQSTATS_LOOKUPS,
+	DQSTATS_DROPS,
+	DQSTATS_READS,
+	DQSTATS_WRITES,
+	DQSTATS_CACHE_HITS,
+	DQSTATS_ALLOCATED,
+	DQSTATS_FREE,
+	DQSTATS_SYNCS,
+	DQSTATS_SIZE
+};
+
 #ifdef __KERNEL__
 
 #include <linux/xqm.h>
@@ -184,20 +200,7 @@
 
 #define sb_dqopt(sb) (&(sb)->s_dquot)
 
-extern int nr_dquots, nr_free_dquots;
-
-struct dqstats {
-	__u32 lookups;
-	__u32 drops;
-	__u32 reads;
-	__u32 writes;
-	__u32 cache_hits;
-	__u32 allocated_dquots;
-	__u32 free_dquots;
-	__u32 syncs;
-};
-
-extern struct dqstats dqstats;
+extern __u32 dqstats_array[DQSTATS_SIZE];
 
 #define NR_DQHASH 43            /* Just an arbitrary number */
 
diff -ruNX /home/jack/.kerndiffexclude linux-2.5.17-1-makefix/include/linux/sysctl.h linux-2.5.17-2-procfix/include/linux/sysctl.h
--- linux-2.5.17-1-makefix/include/linux/sysctl.h	Sat May 18 17:57:06 2002
+++ linux-2.5.17-2-procfix/include/linux/sysctl.h	Sat May 25 14:44:43 2002
@@ -544,6 +544,7 @@
 	FS_LEASES=13,	/* int: leases enabled */
 	FS_DIR_NOTIFY=14,	/* int: directory notification enabled */
 	FS_LEASE_TIME=15,	/* int: maximum time to wait for a lease break */
+	FS_DQSTATS=16,	/* int: disc quota suage statistics */
 };
 
 /* CTL_DEBUG names: */
