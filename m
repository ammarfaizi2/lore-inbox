Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964848AbWEaGup@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964848AbWEaGup (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 31 May 2006 02:50:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964846AbWEaGup
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 31 May 2006 02:50:45 -0400
Received: from [203.144.27.9] ([203.144.27.9]:27153 "EHLO surfers.oz.agile.tv")
	by vger.kernel.org with ESMTP id S964848AbWEaGuo (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 31 May 2006 02:50:44 -0400
Message-ID: <447D3CBF.7030506@agile.tv>
Date: Wed, 31 May 2006 16:50:39 +1000
From: Tony Griffiths <tonyg@agile.tv>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.12) Gecko/20060202 Fedora/1.7.12-1.5.2
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: "Eric W. Biederman" <ebiederm@xmission.com>
Cc: linux-kernel@vger.kernel.org, Andrew Morton <akpm@osdl.org>
Subject: Re: PROBLEM: /proc (procfs) task exit race condition causes a kernel
 crash
References: <44764F35.9050002@agile.tv> <m1irnq6tzq.fsf@ebiederm.dsl.xmission.com>
In-Reply-To: <m1irnq6tzq.fsf@ebiederm.dsl.xmission.com>
Content-Type: multipart/mixed;
 boundary="------------000005000004030602020808"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------000005000004030602020808
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

Eric,

I've attached a patch file which rolls up a set of patches to dcache.c 
along with a few changed I made to locking symantics.  So far a 2.6.16 
(+ -mm2) with the patch applied survives the harshest testing I can 
throw at it!

Note that I've also made some minor changes to exit.c [preempt 
disable/enable during task exit] and truncate.c [BUG_ON check of 
'private' page].  The testing I've done is with a kernel built without 
preemption, and one built with voluntary preemption.  A kernel built 
with forced preemption and with spinlock debugging enabled did NOT work 
very well!!!  Also, the performance of a kernel  built with voluntary 
preemption and with the cond_resched_lock() calls in dcache.c was 
surprisingly *BAD*, with the system going into a wheel-spin for a long 
period [high system cpu of 87%+] when I fired up a number of large 
cpu+memory hungry tasks.  This might need to be looked at more closely?!

Eric W. Biederman wrote:

>I have tried to reproduce this.  The circumstances weren't the most
>controlled but they did overlap with what you described and I haven't seen
>anything.
>
>So I am guessing that you are having memory corruption from some source.
>Either bad ram or a bad module.
>
>I'm off on vacation for a week, so I won't be able to follow up.
>
>
>Eric
>  
>


--------------000005000004030602020808
Content-Type: text/x-patch;
 name="post-2.6.16-mm2-dcache.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="post-2.6.16-mm2-dcache.patch"

diff -urpN linux-2.6.16-mm2/fs/dcache.c linux-2.6.16/fs/dcache.c
--- linux-2.6.16-mm2/fs/dcache.c	2006-05-31 16:30:13.000000000 +1000
+++ linux-2.6.16/fs/dcache.c	2006-05-31 16:25:53.000000000 +1000
@@ -36,12 +36,10 @@
 
 
 int sysctl_vfs_cache_pressure __read_mostly = 100;
-EXPORT_SYMBOL_GPL(sysctl_vfs_cache_pressure);
 
  __cacheline_aligned_in_smp DEFINE_SPINLOCK(dcache_lock);
 static seqlock_t rename_lock __cacheline_aligned_in_smp = SEQLOCK_UNLOCKED;
 
-EXPORT_SYMBOL(dcache_lock);
 
 static kmem_cache_t *dentry_cache __read_mostly;
 
@@ -142,21 +140,18 @@ static void dentry_iput(struct dentry * 
  * no dcache lock, please.
  */
 
-void dput(struct dentry *dentry)
+static void dput_locked(struct dentry *dentry, struct list_head *list)
 {
 	if (!dentry)
 		return;
 
-repeat:
-	if (atomic_read(&dentry->d_count) == 1)
-		might_sleep();
-	if (!atomic_dec_and_lock(&dentry->d_count, &dcache_lock))
+	if (!atomic_dec_and_test(&dentry->d_count))
 		return;
 
+repeat:
 	spin_lock(&dentry->d_lock);
 	if (atomic_read(&dentry->d_count)) {
 		spin_unlock(&dentry->d_lock);
-		spin_unlock(&dcache_lock);
 		return;
 	}
 
@@ -176,33 +171,59 @@ repeat:
   		dentry_stat.nr_unused++;
   	}
  	spin_unlock(&dentry->d_lock);
-	spin_unlock(&dcache_lock);
 	return;
 
 unhash_it:
 	__d_drop(dentry);
 
 kill_it: {
-		struct dentry *parent;
-
 		/* If dentry was on d_lru list
 		 * delete it from there
 		 */
   		if (!list_empty(&dentry->d_lru)) {
-  			list_del(&dentry->d_lru);
+  			list_del_init(&dentry->d_lru);
   			dentry_stat.nr_unused--;
   		}
   		list_del(&dentry->d_u.d_child);
 		dentry_stat.nr_dentry--;	/* For d_free, below */
-		/*drops the locks, at that point nobody can reach this dentry */
-		dentry_iput(dentry);
-		parent = dentry->d_parent;
-		d_free(dentry);
-		if (dentry == parent)
+		/* at this point nobody can reach this dentry */
+		list_add(&dentry->d_lru, list);
+		spin_unlock(&dentry->d_lock);
+		if (dentry == dentry->d_parent)
 			return;
-		dentry = parent;
-		goto repeat;
+		dentry = dentry->d_parent;
+		if (atomic_dec_and_test(&dentry->d_count))
+			goto repeat;
+		/* out */
+	}
+}
+
+void dput(struct dentry *dentry)
+{
+	LIST_HEAD(free_list);
+
+	if (!dentry)
+		goto do_return;
+
+	if (atomic_add_unless(&dentry->d_count, -1, 1))
+		goto do_return;
+
+	spin_lock(&dcache_lock);			/* While we hold the dcache_lock */
+	dput_locked(dentry, &free_list);		/* Put ALL free-able dentry's onto 'free_list' */
+
+	if (!list_empty(&free_list)) {			/* Then process as a single batch! */
+		struct dentry *dentry, *p;
+		list_for_each_entry_safe(dentry, p, &free_list, d_lru) {
+			spin_lock(&dentry->d_lock);	/* Lock dentry while also holding dcache_lock! */
+			list_del(&dentry->d_lru);
+			dentry_iput(dentry);		/* Enter with locks held; Exit with no locks! */
+			d_free(dentry);
+			spin_lock(&dcache_lock);	/* Assume we will iterate again so ... */
+		}
 	}
+	spin_unlock(&dcache_lock);			/* There *MUST* be a better way of doing this?! */
+do_return:
+	return;
 }
 
 /**
@@ -219,13 +240,15 @@ kill_it: {
  
 int d_invalidate(struct dentry * dentry)
 {
+	int	ret = 0;
+
 	/*
 	 * If it's already been dropped, return OK.
 	 */
 	spin_lock(&dcache_lock);
 	if (d_unhashed(dentry)) {
 		spin_unlock(&dcache_lock);
-		return 0;
+		goto do_return;
 	}
 	/*
 	 * Check whether to do a partial shrink_dcache
@@ -252,14 +275,16 @@ int d_invalidate(struct dentry * dentry)
 		if (dentry->d_inode && S_ISDIR(dentry->d_inode->i_mode)) {
 			spin_unlock(&dentry->d_lock);
 			spin_unlock(&dcache_lock);
-			return -EBUSY;
+			ret = -EBUSY;
+			goto do_return;
 		}
 	}
 
 	__d_drop(dentry);
 	spin_unlock(&dentry->d_lock);
 	spin_unlock(&dcache_lock);
-	return 0;
+do_return:
+	return ret;
 }
 
 /* This should be called _only_ with dcache_lock held */
@@ -276,7 +301,10 @@ static inline struct dentry * __dget_loc
 
 struct dentry * dget_locked(struct dentry *dentry)
 {
-	return __dget_locked(dentry);
+	struct dentry*	ret;
+
+	ret = __dget_locked(dentry);
+	return ret;
 }
 
 /**
@@ -366,22 +394,39 @@ restart:
  */
 static inline void prune_one_dentry(struct dentry * dentry)
 {
-	struct dentry * parent;
+	LIST_HEAD(free_list);
 
 	__d_drop(dentry);
 	list_del(&dentry->d_u.d_child);
 	dentry_stat.nr_dentry--;	/* For d_free, below */
-	dentry_iput(dentry);
-	parent = dentry->d_parent;
+
+	/* dput the parent here before we release dcache_lock */
+	if (dentry != dentry->d_parent)
+		dput_locked(dentry->d_parent, &free_list);
+
+	dentry_iput(dentry);		/* drop locks */
 	d_free(dentry);
-	if (parent != dentry)
-		dput(parent);
+
+	if (!list_empty(&free_list)) {
+		struct dentry *tmp, *p;
+
+		list_for_each_entry_safe(tmp, p, &free_list, d_lru) {
+			spin_lock(&dcache_lock);	/* All of this locking/unlocking  */
+			spin_lock(&tmp->d_lock);	/* is so incredibly UGLY!!! */
+			list_del(&tmp->d_lru);
+			dentry_iput(tmp);
+			d_free(tmp);
+		}
+	}
+
 	spin_lock(&dcache_lock);
 }
 
 /**
  * prune_dcache - shrink the dcache
  * @count: number of entries to try and free
+ * @sb: if given, ignore dentries for other superblocks
+ *         which are being unmounted.
  *
  * Shrink the dcache. This is done when we need
  * more memory, or simply when we need to unmount
@@ -392,16 +437,30 @@ static inline void prune_one_dentry(stru
  * all the dentries are in use.
  */
  
-static void prune_dcache(int count)
+static void prune_dcache(int count, struct super_block *sb)
 {
 	spin_lock(&dcache_lock);
 	for (; count ; count--) {
 		struct dentry *dentry;
 		struct list_head *tmp;
+		struct rw_semaphore *s_umount;
 
-		cond_resched_lock(&dcache_lock);
+		/*cond_resched_lock(&dcache_lock);	** ?BAD PERFORMANCE? **   */
 
 		tmp = dentry_unused.prev;
+		if (unlikely(sb)) {
+			/* Try to find a dentry for this sb, but don't try
+			 * too hard, if they aren't near the tail they will
+			 * be moved down again soon
+			 */
+			int skip = count;
+			while (skip &&
+			       tmp != &dentry_unused &&
+			       list_entry(tmp, struct dentry, d_lru)->d_sb != sb) {
+				skip--;
+				tmp = tmp->prev;
+			}
+		}
 		if (tmp == &dentry_unused)
 			break;
 		list_del_init(tmp);
@@ -427,7 +486,45 @@ static void prune_dcache(int count)
  			spin_unlock(&dentry->d_lock);
 			continue;
 		}
-		prune_one_dentry(dentry);
+		/*
+		 * If the dentry is not DCACHED_REFERENCED, it is time
+		 * to remove it from the dcache, provided the super block is
+		 * NULL (which means we are trying to reclaim memory)
+		 * or this dentry belongs to the same super block that
+		 * we want to shrink.
+		 */
+		/*
+		 * If this dentry is for "my" filesystem, then I can prune it
+		 * without taking the s_umount lock (I already hold it).
+		 */
+		if (sb && dentry->d_sb == sb) {
+			prune_one_dentry(dentry);
+			continue;
+		}
+		/*
+		 * ...otherwise we need to be sure this filesystem isn't being
+		 * unmounted, otherwise we could race with
+		 * generic_shutdown_super(), and end up holding a reference to
+		 * an inode while the filesystem is unmounted.
+		 * So we try to get s_umount, and make sure s_root isn't NULL.
+		 * (Take a local copy of s_umount to avoid a use-after-free of
+		 * `dentry').
+		 */
+		s_umount = &dentry->d_sb->s_umount;
+		if (down_read_trylock(s_umount)) {
+			if (dentry->d_sb->s_root != NULL) {
+				prune_one_dentry(dentry);
+				up_read(s_umount);
+				continue;
+			}
+			up_read(s_umount);
+		}
+		spin_unlock(&dentry->d_lock);
+		/* Cannot remove the first dentry, and it isn't appropriate
+		 * to move it to the head of the list, so give up, and try
+		 * later
+		 */
+		break;
 	}
 	spin_unlock(&dcache_lock);
 }
@@ -481,14 +578,14 @@ repeat:
 		if (dentry->d_sb != sb)
 			continue;
 		dentry_stat.nr_unused--;
-		list_del_init(tmp);
 		spin_lock(&dentry->d_lock);
+		list_del_init(tmp);
 		if (atomic_read(&dentry->d_count)) {
 			spin_unlock(&dentry->d_lock);
 			continue;
 		}
 		prune_one_dentry(dentry);
-		cond_resched_lock(&dcache_lock);
+		/*cond_resched_lock(&dcache_lock);	** ?BAD PERFORMANCE? **   */
 		goto repeat;
 	}
 	spin_unlock(&dcache_lock);
@@ -512,6 +609,7 @@ int have_submounts(struct dentry *parent
 {
 	struct dentry *this_parent = parent;
 	struct list_head *next;
+	int	ret = 1;
 
 	spin_lock(&dcache_lock);
 	if (d_mountpoint(parent))
@@ -539,11 +637,10 @@ resume:
 		this_parent = this_parent->d_parent;
 		goto resume;
 	}
-	spin_unlock(&dcache_lock);
-	return 0; /* No mount points found in tree */
+	ret = 0; /* No mount points found in tree */
 positive:
 	spin_unlock(&dcache_lock);
-	return 1;
+	return ret;
 }
 
 /*
@@ -630,7 +727,7 @@ void shrink_dcache_parent(struct dentry 
 	int found;
 
 	while ((found = select_parent(parent)) != 0)
-		prune_dcache(found);
+		prune_dcache(found, parent->d_sb);
 }
 
 /**
@@ -643,9 +740,10 @@ void shrink_dcache_parent(struct dentry 
  * done under dcache_lock.
  *
  */
-void shrink_dcache_anon(struct hlist_head *head)
+void shrink_dcache_anon(struct super_block *sb)
 {
 	struct hlist_node *lp;
+	struct hlist_head *head = &sb->s_anon;
 	int found;
 	do {
 		found = 0;
@@ -668,7 +766,7 @@ void shrink_dcache_anon(struct hlist_hea
 			}
 		}
 		spin_unlock(&dcache_lock);
-		prune_dcache(found);
+		prune_dcache(found, sb);
 	} while(found);
 }
 
@@ -686,12 +784,16 @@ void shrink_dcache_anon(struct hlist_hea
  */
 static int shrink_dcache_memory(int nr, gfp_t gfp_mask)
 {
+	int	ret = -1;
+
 	if (nr) {
 		if (!(gfp_mask & __GFP_FS))
-			return -1;
-		prune_dcache(nr);
+			goto do_return;
+		prune_dcache(nr, NULL);
 	}
-	return (dentry_stat.nr_unused / 100) * sysctl_vfs_cache_pressure;
+	ret = (dentry_stat.nr_unused / 100) * sysctl_vfs_cache_pressure;
+do_return:
+	return ret;
 }
 
 /**
@@ -711,13 +813,14 @@ struct dentry *d_alloc(struct dentry * p
 
 	dentry = kmem_cache_alloc(dentry_cache, GFP_KERNEL); 
 	if (!dentry)
-		return NULL;
+		goto do_return;
 
 	if (name->len > DNAME_INLINE_LEN-1) {
 		dname = kmalloc(name->len + 1, GFP_KERNEL);
 		if (!dname) {
 			kmem_cache_free(dentry_cache, dentry); 
-			return NULL;
+			dentry = NULL;
+			goto do_return;
 		}
 	} else  {
 		dname = dentry->d_iname;
@@ -758,18 +861,20 @@ struct dentry *d_alloc(struct dentry * p
 		list_add(&dentry->d_u.d_child, &parent->d_subdirs);
 	dentry_stat.nr_dentry++;
 	spin_unlock(&dcache_lock);
-
+do_return:
 	return dentry;
 }
 
 struct dentry *d_alloc_name(struct dentry *parent, const char *name)
 {
 	struct qstr q;
+	struct dentry * ret;
 
 	q.name = name;
 	q.len = strlen(name);
 	q.hash = full_name_hash(q.name, q.len);
-	return d_alloc(parent, &q);
+	ret = d_alloc(parent, &q);
+	return ret;
 }
 
 /**
@@ -817,7 +922,7 @@ void d_instantiate(struct dentry *entry,
  */
 struct dentry *d_instantiate_unique(struct dentry *entry, struct inode *inode)
 {
-	struct dentry *alias;
+	struct dentry *alias = NULL;
 	int len = entry->d_name.len;
 	const char *name = entry->d_name.name;
 	unsigned int hash = entry->d_name.hash;
@@ -841,7 +946,7 @@ struct dentry *d_instantiate_unique(stru
 		spin_unlock(&dcache_lock);
 		BUG_ON(!d_unhashed(alias));
 		iput(inode);
-		return alias;
+		goto do_return;
 	}
 	list_add(&entry->d_alias, &inode->i_dentry);
 do_negative:
@@ -849,9 +954,10 @@ do_negative:
 	fsnotify_d_instantiate(entry, inode);
 	spin_unlock(&dcache_lock);
 	security_d_instantiate(entry, inode);
-	return NULL;
+	alias = NULL;
+do_return:
+	return alias;
 }
-EXPORT_SYMBOL(d_instantiate_unique);
 
 /**
  * d_alloc_root - allocate root dentry
@@ -915,12 +1021,14 @@ struct dentry * d_alloc_anon(struct inod
 
 	if ((res = d_find_alias(inode))) {
 		iput(inode);
-		return res;
+		goto do_return;
 	}
 
 	tmp = d_alloc(NULL, &anonstring);
-	if (!tmp)
-		return NULL;
+	if (!tmp) {
+		res = NULL;
+		goto do_return;
+	}
 
 	tmp->d_parent = tmp; /* make sure dput doesn't croak */
 	
@@ -948,6 +1056,7 @@ struct dentry * d_alloc_anon(struct inod
 		iput(inode);
 	if (tmp)
 		dput(tmp);
+do_return:
 	return res;
 }
 
@@ -1142,6 +1251,7 @@ int d_validate(struct dentry *dentry, st
 {
 	struct hlist_head *base;
 	struct hlist_node *lhp;
+	int		   ret = 0;
 
 	/* Check whether the ptr might be valid at all.. */
 	if (!kmem_ptr_validate(dentry_cache, dentry))
@@ -1159,12 +1269,13 @@ int d_validate(struct dentry *dentry, st
 		if (dentry == hlist_entry(lhp, struct dentry, d_hash)) {
 			__dget_locked(dentry);
 			spin_unlock(&dcache_lock);
-			return 1;
+			ret = 1;
+			goto out;
 		}
 	}
 	spin_unlock(&dcache_lock);
 out:
-	return 0;
+	return ret;
 }
 
 /*
@@ -1191,6 +1302,7 @@ out:
 void d_delete(struct dentry * dentry)
 {
 	int isdir = 0;
+
 	/*
 	 * Are we the only user?
 	 */
@@ -1203,7 +1315,7 @@ void d_delete(struct dentry * dentry)
 
 		dentry_iput(dentry);
 		fsnotify_nameremove(dentry, isdir);
-		return;
+		goto do_return;
 	}
 
 	if (!d_unhashed(dentry))
@@ -1213,6 +1325,8 @@ void d_delete(struct dentry * dentry)
 	spin_unlock(&dcache_lock);
 
 	fsnotify_nameremove(dentry, isdir);
+do_return:
+	return;
 }
 
 static void __d_rehash(struct dentry * entry, struct hlist_head *list)
@@ -1497,13 +1611,13 @@ char * d_path(struct dentry *dentry, str
  */
 asmlinkage long sys_getcwd(char __user *buf, unsigned long size)
 {
-	int error;
+	int error = -ENOMEM;
 	struct vfsmount *pwdmnt, *rootmnt;
 	struct dentry *pwd, *root;
 	char *page = (char *) __get_free_page(GFP_USER);
 
 	if (!page)
-		return -ENOMEM;
+		goto do_return;
 
 	read_lock(&current->fs->lock);
 	pwdmnt = mntget(current->fs->pwdmnt);
@@ -1542,6 +1656,7 @@ out:
 	dput(root);
 	mntput(rootmnt);
 	free_page((unsigned long) page);
+do_return:
 	return error;
 }
 
@@ -1729,7 +1844,6 @@ kmem_cache_t *names_cachep __read_mostly
 /* SLAB cache for file structures */
 kmem_cache_t *filp_cachep __read_mostly;
 
-EXPORT_SYMBOL(d_genocide);
 
 extern void bdev_cache_init(void);
 extern void chrdev_init(void);
@@ -1764,6 +1878,10 @@ void __init vfs_caches_init(unsigned lon
 	chrdev_init();
 }
 
+EXPORT_SYMBOL_GPL(sysctl_vfs_cache_pressure);
+EXPORT_SYMBOL(dcache_lock);
+EXPORT_SYMBOL(d_instantiate_unique);
+EXPORT_SYMBOL(d_genocide);
 EXPORT_SYMBOL(d_alloc);
 EXPORT_SYMBOL(d_alloc_anon);
 EXPORT_SYMBOL(d_alloc_root);
diff -urpN linux-2.6.16-mm2/kernel/exit.c linux-2.6.16/kernel/exit.c
--- linux-2.6.16-mm2/kernel/exit.c	2006-05-31 16:30:14.000000000 +1000
+++ linux-2.6.16/kernel/exit.c	2006-05-30 14:49:35.000000000 +1000
@@ -136,6 +136,7 @@ void release_task(struct task_struct * p
 {
 	int zap_leader;
 	task_t *leader;
+	preempt_disable();	// ** Cleanup as fast as we can! **
 repeat:
 	atomic_dec(&p->user->processes);
 	write_lock_irq(&tasklist_lock);
@@ -173,6 +174,7 @@ repeat:
 	p = leader;
 	if (unlikely(zap_leader))
 		goto repeat;
+	preempt_enable();	// ** OK to give other tasks some cycles now **
 }
 
 /*
diff -urpN linux-2.6.16-mm2/mm/truncate.c linux-2.6.16/mm/truncate.c
--- linux-2.6.16-mm2/mm/truncate.c	2006-05-31 16:30:14.000000000 +1000
+++ linux-2.6.16/mm/truncate.c	2006-05-28 17:22:46.000000000 +1000
@@ -80,7 +80,7 @@ invalidate_complete_page(struct address_
 		return 0;
 	}
 
-	BUG_ON(PagePrivate(page));
+	BUG_ON(PagePrivate(page) && (page_private(page) != 0));
 	__remove_from_page_cache(page);
 	write_unlock_irq(&mapping->tree_lock);
 	ClearPageUptodate(page);

--------------000005000004030602020808--
