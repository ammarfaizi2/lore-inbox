Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751872AbWCIMAR@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751872AbWCIMAR (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 9 Mar 2006 07:00:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751880AbWCIMAR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 9 Mar 2006 07:00:17 -0500
Received: from mailhub.sw.ru ([195.214.233.200]:53591 "EHLO relay.sw.ru")
	by vger.kernel.org with ESMTP id S1751872AbWCIMAP (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 9 Mar 2006 07:00:15 -0500
Message-ID: <4410199D.1050505@sw.ru>
Date: Thu, 09 Mar 2006 15:03:41 +0300
From: Kirill Korotaev <dev@sw.ru>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; ru-RU; rv:1.2.1) Gecko/20030426
X-Accept-Language: ru-ru, en
MIME-Version: 1.0
To: Neil Brown <neilb@suse.de>
CC: Kirill Korotaev <dev@openvz.org>, linux-kernel@vger.kernel.org,
       Andrew Morton <akpm@osdl.org>, Olaf Hering <olh@suse.de>,
       Jan Blunck <jblunck@suse.de>, Al Viro <viro@ftp.linux.org.uk>
Subject: Re: [PATCH] Busy inodes after unmount, be more verbose in generic_shutdown_super
References: <17414.38749.886125.282255@cse.unsw.edu.au>	<17419.53761.295044.78549@cse.unsw.edu.au>	<440C236A.90700@openvz.org>	<17420.59753.598191.388029@cse.unsw.edu.au>	<440D2633.4070301@sw.ru> <17422.5456.875119.579068@cse.unsw.edu.au>
In-Reply-To: <17422.5456.875119.579068@cse.unsw.edu.au>
Content-Type: multipart/mixed;
 boundary="------------080509010704050708080805"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------080509010704050708080805
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit

>>>>In general your patch is still does what mine do, so I will be happy if 
>>>>any of this is commited mainstream. In future, please, keep the 
>>>>reference to original authors, this will also make sure that I'm on CC 
>>>>if something goes wrong.
>>>
>>>
>>>Sorry: which 'original author' did I miss ?
>>
>>I mean, it is better to mention original author 
>>(http://marc.theaimsgroup.com/?l=linux-kernel&m=114123870406751&w=2) in 
>>patch description, as it makes sure that he will be on CC if this patch 
>>will be discussed later again. My patch fixing this race was in -mm tree 
>>for half a year already.
> 
> 
> Which patch is that?  The race still seems to be present in -mm.
I attached you my latest patch for 2.6.16-rc5

in -mm tree these patch was until the discussion arose again recently:
ftp://ftp.kernel.org/pub/linux/kernel/people/akpm/patches/2.6/2.6.14/2.6.14-mm2/broken-out/fix-of-dcache-race-leading-to-busy-inodes-on-umount.patch

Thanks,
Kirill

--------------080509010704050708080805
Content-Type: text/plain;
 name="diff-ms-dcache-race-20060303"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="diff-ms-dcache-race-20060303"

--- linux-2.6.15.orig/fs/dcache.c	2006-01-03 06:21:10.000000000 +0300
+++ linux-2.6.15-025stab015-dcache-race/fs/dcache.c	2006-03-03 16:22:38.862706448 +0300
@@ -114,6 +114,75 @@ static inline void dentry_iput(struct de
 	}
 }
 
+struct dcache_shrinker {
+	struct list_head list;
+	struct dentry *dentry;
+};
+
+DECLARE_WAIT_QUEUE_HEAD(dcache_shrinker_wq);
+
+/* called under dcache_lock */
+static void dcache_shrinker_add(struct dcache_shrinker *ds,
+		struct dentry *parent, struct dentry *dentry)
+{
+	struct super_block *sb;
+
+	sb = parent->d_sb;
+	ds->dentry = parent;
+	list_add(&ds->list, &sb->s_dshrinkers);
+}
+
+/* called under dcache_lock */
+static void dcache_shrinker_del(struct dcache_shrinker *ds)
+{
+	if (ds == NULL || list_empty(&ds->list))
+		return;
+
+	list_del_init(&ds->list);
+	wake_up_all(&dcache_shrinker_wq);
+}
+
+/* called under dcache_lock, drops inside */
+static void dcache_shrinker_wait(struct super_block *sb)
+{
+	DECLARE_WAITQUEUE(wq, current);
+
+	__set_current_state(TASK_UNINTERRUPTIBLE);
+	add_wait_queue(&dcache_shrinker_wq, &wq);
+	spin_unlock(&dcache_lock);
+
+	schedule();
+	remove_wait_queue(&dcache_shrinker_wq, &wq);
+	__set_current_state(TASK_RUNNING);
+}
+
+void dcache_shrinker_wait_sb(struct super_block *sb)
+{
+	/* the root dentry can be held in dput_recursive */
+	spin_lock(&dcache_lock);
+	while (!list_empty(&sb->s_dshrinkers)) {
+		dcache_shrinker_wait(sb);
+		spin_lock(&dcache_lock);
+	}
+	spin_unlock(&dcache_lock);
+}
+
+/* dcache_lock protects shrinker's list */
+static void shrink_dcache_racecheck(struct dentry *parent, int *racecheck)
+{
+	struct super_block *sb;
+	struct dcache_shrinker *ds;
+
+	sb = parent->d_sb;
+	list_for_each_entry(ds, &sb->s_dshrinkers, list) {
+		/* is one of dcache shrinkers working on the dentry? */
+		if (ds->dentry == parent) {
+			*racecheck = 1;
+			break;
+		}
+	}
+}
+
 /* 
  * This is dput
  *
@@ -132,8 +201,9 @@ static inline void dentry_iput(struct de
  */
 
 /*
- * dput - release a dentry
- * @dentry: dentry to release 
+ * dput_recursive - go upward through the dentry tree and release dentries
+ * @dentry: starting dentry
+ * @ds: shrinker to be added to active list (see shrink_dcache_parent)
  *
  * Release a dentry. This will drop the usage count and if appropriate
  * call the dentry unlink method as well as removing it from the queues and
@@ -142,18 +212,15 @@ static inline void dentry_iput(struct de
  *
  * no dcache lock, please.
  */
-
-void dput(struct dentry *dentry)
+static void dput_recursive(struct dentry *dentry, struct dcache_shrinker *ds)
 {
-	if (!dentry)
-		return;
-
-repeat:
 	if (atomic_read(&dentry->d_count) == 1)
 		might_sleep();
 	if (!atomic_dec_and_lock(&dentry->d_count, &dcache_lock))
 		return;
+	dcache_shrinker_del(ds);
 
+repeat:
 	spin_lock(&dentry->d_lock);
 	if (atomic_read(&dentry->d_count)) {
 		spin_unlock(&dentry->d_lock);
@@ -185,6 +252,7 @@ unhash_it:
 
 kill_it: {
 		struct dentry *parent;
+		struct dcache_shrinker lds;
 
 		/* If dentry was on d_lru list
 		 * delete it from there
@@ -194,18 +262,47 @@ kill_it: {
   			dentry_stat.nr_unused--;
   		}
   		list_del(&dentry->d_u.d_child);
+		parent = dentry->d_parent;
+		dcache_shrinker_add(&lds, parent, dentry);
 		dentry_stat.nr_dentry--;	/* For d_free, below */
 		/*drops the locks, at that point nobody can reach this dentry */
 		dentry_iput(dentry);
-		parent = dentry->d_parent;
 		d_free(dentry);
-		if (dentry == parent)
+		if (unlikely(dentry == parent)) {
+			spin_lock(&dcache_lock);
+			dcache_shrinker_del(&lds);
+			spin_unlock(&dcache_lock);
 			return;
+		}
 		dentry = parent;
-		goto repeat;
+		spin_lock(&dcache_lock);
+		dcache_shrinker_del(&lds);
+		if (atomic_dec_and_test(&dentry->d_count))
+			goto repeat;
+		spin_unlock(&dcache_lock);
 	}
 }
 
+/*
+ * dput - release a dentry
+ * @dentry: dentry to release 
+ *
+ * Release a dentry. This will drop the usage count and if appropriate
+ * call the dentry unlink method as well as removing it from the queues and
+ * releasing its resources. If the parent dentries were scheduled for release
+ * they too may now get deleted.
+ *
+ * no dcache lock, please.
+ */
+
+void dput(struct dentry *dentry)
+{
+	if (!dentry)
+		return;
+
+	dput_recursive(dentry, NULL);
+}
+
 /**
  * d_invalidate - invalidate a dentry
  * @dentry: dentry to invalidate
@@ -362,19 +459,23 @@ restart:
  * removed.
  * Called with dcache_lock, drops it and then regains.
  */
-static inline void prune_one_dentry(struct dentry * dentry)
+static void prune_one_dentry(struct dentry * dentry)
 {
 	struct dentry * parent;
+	struct dcache_shrinker ds;
 
 	__d_drop(dentry);
 	list_del(&dentry->d_u.d_child);
+	parent = dentry->d_parent;
+	dcache_shrinker_add(&ds, parent, dentry);
 	dentry_stat.nr_dentry--;	/* For d_free, below */
 	dentry_iput(dentry);
 	parent = dentry->d_parent;
 	d_free(dentry);
 	if (parent != dentry)
-		dput(parent);
+		dput_recursive(parent, &ds);
 	spin_lock(&dcache_lock);
+	dcache_shrinker_del(&ds);
 }
 
 /**
@@ -557,13 +658,12 @@ positive:
  * drop the lock and return early due to latency
  * constraints.
  */
-static int select_parent(struct dentry * parent)
+static int select_parent(struct dentry * parent, int * racecheck)
 {
 	struct dentry *this_parent = parent;
 	struct list_head *next;
 	int found = 0;
 
-	spin_lock(&dcache_lock);
 repeat:
 	next = this_parent->d_subdirs.next;
 resume:
@@ -605,6 +705,9 @@ dentry->d_parent->d_name.name, dentry->d
 #endif
 			goto repeat;
 		}
+
+		if (!found && racecheck != NULL)
+			shrink_dcache_racecheck(dentry, racecheck);
 	}
 	/*
 	 * All done at this level ... ascend and resume the search.
@@ -619,7 +722,6 @@ this_parent->d_parent->d_name.name, this
 		goto resume;
 	}
 out:
-	spin_unlock(&dcache_lock);
 	return found;
 }
 
@@ -632,10 +734,66 @@ out:
  
 void shrink_dcache_parent(struct dentry * parent)
 {
-	int found;
+	int found, r;
 
-	while ((found = select_parent(parent)) != 0)
+	while (1) {
+		spin_lock(&dcache_lock);
+		found = select_parent(parent, NULL);
+		if (found)
+			goto found;
+
+		/*
+		 * try again with a dput_recursive() race check.
+		 * it returns quickly if everything was really shrinked
+		 */
+		r = 0;
+		found = select_parent(parent, &r);
+		if (found)
+			goto found;
+		if (!r)
+			break;
+
+		/* drops the lock inside */
+		dcache_shrinker_wait(parent->d_sb);
+		continue;
+
+found:
+		spin_unlock(&dcache_lock);
 		prune_dcache(found);
+	}
+	spin_unlock(&dcache_lock);
+}
+
+/*
+ * Move any unused anon dentries to the end of the unused list.
+ * called under dcache_lock
+ */
+static int select_anon(struct hlist_head *head, int *racecheck)
+{
+	struct hlist_node *lp;
+	int found = 0;
+
+	hlist_for_each(lp, head) {
+		struct dentry *this = hlist_entry(lp, struct dentry, d_hash);
+		if (!list_empty(&this->d_lru)) {
+			dentry_stat.nr_unused--;
+			list_del_init(&this->d_lru);
+		}
+
+		/* 
+		 * move only zero ref count dentries to the end 
+		 * of the unused list for prune_dcache
+		 */
+		if (!atomic_read(&this->d_count)) {
+			list_add_tail(&this->d_lru, &dentry_unused);
+			dentry_stat.nr_unused++;
+			found++;
+		}
+
+		if (!found && racecheck != NULL)
+			shrink_dcache_racecheck(this, racecheck);
+	}
+	return found;
 }
 
 /**
@@ -648,33 +806,36 @@ void shrink_dcache_parent(struct dentry 
  * done under dcache_lock.
  *
  */
-void shrink_dcache_anon(struct hlist_head *head)
+void shrink_dcache_anon(struct super_block *sb)
 {
-	struct hlist_node *lp;
-	int found;
-	do {
-		found = 0;
+	int found, r;
+
+	while (1) {
 		spin_lock(&dcache_lock);
-		hlist_for_each(lp, head) {
-			struct dentry *this = hlist_entry(lp, struct dentry, d_hash);
-			if (!list_empty(&this->d_lru)) {
-				dentry_stat.nr_unused--;
-				list_del_init(&this->d_lru);
-			}
+		found = select_anon(&sb->s_anon, NULL);
+		if (found)
+			goto found;
 
-			/* 
-			 * move only zero ref count dentries to the end 
-			 * of the unused list for prune_dcache
-			 */
-			if (!atomic_read(&this->d_count)) {
-				list_add_tail(&this->d_lru, &dentry_unused);
-				dentry_stat.nr_unused++;
-				found++;
-			}
-		}
+		/*
+		 * try again with a dput_recursive() race check.
+		 * it returns quickly if everything was really shrinked
+		 */
+		r = 0;
+		found = select_anon(&sb->s_anon, &r);
+		if (found)
+			goto found;
+		if (!r)
+			break;
+
+		/* drops the lock inside */
+		dcache_shrinker_wait(sb);
+		continue;
+
+found:
 		spin_unlock(&dcache_lock);
 		prune_dcache(found);
-	} while(found);
+	}
+	spin_unlock(&dcache_lock);
 }
 
 /*
--- linux-2.6.15.orig/fs/super.c	2006-01-03 06:21:10.000000000 +0300
+++ linux-2.6.15-025stab015-dcache-race/fs/super.c	2006-03-03 16:22:38.841709640 +0300
@@ -69,6 +69,7 @@ static struct super_block *alloc_super(v
 		INIT_LIST_HEAD(&s->s_io);
 		INIT_LIST_HEAD(&s->s_files);
 		INIT_LIST_HEAD(&s->s_instances);
+		INIT_LIST_HEAD(&s->s_dshrinkers);
 		INIT_HLIST_HEAD(&s->s_anon);
 		INIT_LIST_HEAD(&s->s_inodes);
 		init_rwsem(&s->s_umount);
@@ -231,8 +232,9 @@ void generic_shutdown_super(struct super
 	if (root) {
 		sb->s_root = NULL;
 		shrink_dcache_parent(root);
-		shrink_dcache_anon(&sb->s_anon);
+		shrink_dcache_anon(sb);
 		dput(root);
+		dcache_shrinker_wait_sb(sb);
 		fsync_super(sb);
 		lock_super(sb);
 		sb->s_flags &= ~MS_ACTIVE;
--- linux-2.6.15.orig/include/linux/dcache.h	2006-01-03 06:21:10.000000000 +0300
+++ linux-2.6.15-025stab015-dcache-race/include/linux/dcache.h	2006-03-03 16:22:38.843709336 +0300
@@ -209,7 +209,8 @@ extern struct dentry * d_alloc_anon(stru
 extern struct dentry * d_splice_alias(struct inode *, struct dentry *);
 extern void shrink_dcache_sb(struct super_block *);
 extern void shrink_dcache_parent(struct dentry *);
-extern void shrink_dcache_anon(struct hlist_head *);
+extern void shrink_dcache_anon(struct super_block *);
+extern void dcache_shrinker_wait_sb(struct super_block *sb);
 extern int d_invalidate(struct dentry *);
 
 /* only used at mount-time */
--- linux-2.6.15.orig/include/linux/fs.h	2006-01-03 06:21:10.000000000 +0300
+++ linux-2.6.15-025stab015-dcache-race/include/linux/fs.h	2006-03-03 16:22:38.821712680 +0300
@@ -803,6 +803,7 @@ struct super_block {
 	struct list_head	s_io;		/* parked for writeback */
 	struct hlist_head	s_anon;		/* anonymous dentries for (nfs) exporting */
 	struct list_head	s_files;
+	struct list_head	s_dshrinkers;	/* active dcache shrinkers */
 
 	struct block_device	*s_bdev;
 	struct list_head	s_instances;

--------------080509010704050708080805--

