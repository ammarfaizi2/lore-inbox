Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S133072AbRDRK3F>; Wed, 18 Apr 2001 06:29:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S133073AbRDRK24>; Wed, 18 Apr 2001 06:28:56 -0400
Received: from leibniz.math.psu.edu ([146.186.130.2]:7382 "EHLO math.psu.edu")
	by vger.kernel.org with ESMTP id <S133072AbRDRK2r>;
	Wed, 18 Apr 2001 06:28:47 -0400
Date: Wed, 18 Apr 2001 06:28:45 -0400 (EDT)
From: Alexander Viro <viro@math.psu.edu>
To: Linus Torvalds <torvalds@transmeta.com>
cc: linux-kernel@vger.kernel.org
Subject: [PATCH] d_flags races
Message-ID: <Pine.GSO.4.21.0104180623320.12027-100000@weyl.math.psu.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

	Linus, we need to make access to bits of ->d_flags atomic.
That used to be protected by BKL, but since we've got DCACHE_REFERENCED
it's no longer true - prune_dcache() and d_lookup() are not under BKL
and while they are safe wrt each other (both are under dcache_lock)
they race with every place in filesystems that touches ->d_flags.
Solution: use set_bit/clear_bit/test_bit.
	Patch follows. Please, apply.
						A:

diff -urN S4-pre4/fs/autofs/root.c S4-pre4-d_flags/fs/autofs/root.c
--- S4-pre4/fs/autofs/root.c	Fri Feb 16 17:28:15 2001
+++ S4-pre4-d_flags/fs/autofs/root.c	Wed Apr 18 06:17:59 2001
@@ -94,7 +94,7 @@
 			/* Turn this into a real negative dentry? */
 			if (status == -ENOENT) {
 				dentry->d_time = jiffies + AUTOFS_NEGATIVE_TIMEOUT;
-				dentry->d_flags &= ~DCACHE_AUTOFS_PENDING;
+				clear_bit(D_Autofs_Pending, &dentry->d_flags);
 				return 1;
 			} else if (status) {
 				/* Return a negative dentry, but leave it "pending" */
@@ -129,7 +129,7 @@
 		autofs_update_usage(&sbi->dirhash,ent);
 	}
 
-	dentry->d_flags &= ~DCACHE_AUTOFS_PENDING;
+	clear_bit(D_Autofs_Pending, &dentry->d_flags);
 	return 1;
 }
 
@@ -152,7 +152,7 @@
 	sbi = autofs_sbi(dir->i_sb);
 
 	/* Pending dentry */
-	if ( dentry->d_flags & DCACHE_AUTOFS_PENDING ) {
+	if (test_bit(D_Autofs_Pending, &dentry->d_flags))
 		if (autofs_oz_mode(sbi))
 			res = 1;
 		else
@@ -219,7 +219,7 @@
 	 * We need to do this before we release the directory semaphore.
 	 */
 	dentry->d_op = &autofs_dentry_operations;
-	dentry->d_flags |= DCACHE_AUTOFS_PENDING;
+	set_bit(D_Autofs_Pending, &dentry->d_flags);
 	d_add(dentry, NULL);
 
 	up(&dir->i_sem);
@@ -230,7 +230,7 @@
 	 * If we are still pending, check if we had to handle
 	 * a signal. If so we can force a restart..
 	 */
-	if (dentry->d_flags & DCACHE_AUTOFS_PENDING) {
+	if (test_bit(D_Autofs_Pending, &dentry->d_flags)) {
 		if (signal_pending(current))
 			return ERR_PTR(-ERESTARTNOINTR);
 	}
diff -urN S4-pre4/fs/autofs4/autofs_i.h S4-pre4-d_flags/fs/autofs4/autofs_i.h
--- S4-pre4/fs/autofs4/autofs_i.h	Fri Feb 16 22:52:15 2001
+++ S4-pre4-d_flags/fs/autofs4/autofs_i.h	Wed Apr 18 06:17:59 2001
@@ -119,7 +119,7 @@
 {
 	struct autofs_info *inf = autofs4_dentry_ino(dentry);
 
-	return (dentry->d_flags & DCACHE_AUTOFS_PENDING) ||
+	return (test_bit(D_Autofs_Pending, &dentry->d_flags)) ||
 		(inf != NULL && inf->flags & AUTOFS_INF_EXPIRING);
 }
 
diff -urN S4-pre4/fs/autofs4/expire.c S4-pre4-d_flags/fs/autofs4/expire.c
--- S4-pre4/fs/autofs4/expire.c	Fri Feb 16 19:36:08 2001
+++ S4-pre4-d_flags/fs/autofs4/expire.c	Wed Apr 18 06:17:59 2001
@@ -194,7 +194,7 @@
 		}
 
 		/* No point expiring a pending mount */
-		if (dentry->d_flags & DCACHE_AUTOFS_PENDING)
+		if (test_bit(D_Autofs_Pending, &dentry->d_flags))
 			continue;
 
 		if (!do_now) {
diff -urN S4-pre4/fs/autofs4/root.c S4-pre4-d_flags/fs/autofs4/root.c
--- S4-pre4/fs/autofs4/root.c	Fri Feb 16 19:36:08 2001
+++ S4-pre4-d_flags/fs/autofs4/root.c	Wed Apr 18 06:17:59 2001
@@ -82,7 +82,7 @@
 	if (de_info && (de_info->flags & AUTOFS_INF_EXPIRING)) {
 		DPRINTK(("try_to_fill_entry: waiting for expire %p name=%.*s, flags&PENDING=%s de_info=%p de_info->flags=%x\n",
 			 dentry, dentry->d_name.len, dentry->d_name.name, 
-			 dentry->d_flags & DCACHE_AUTOFS_PENDING?"t":"f",
+			 test_bit(D_Autofs_Pending, &dentry->d_flags)?"t":"f",
 			 de_info, de_info?de_info->flags:0));
 		status = autofs4_wait(sbi, &dentry->d_name, NFY_NONE);
 		
@@ -109,7 +109,7 @@
 		/* Turn this into a real negative dentry? */
 		if (status == -ENOENT) {
 			dentry->d_time = jiffies + AUTOFS_NEGATIVE_TIMEOUT;
-			dentry->d_flags &= ~DCACHE_AUTOFS_PENDING;
+			clear_bit(D_Autofs_Pending, &dentry->d_flags);
 			return 1;
 		} else if (status) {
 			/* Return a negative dentry, but leave it "pending" */
@@ -134,7 +134,7 @@
 	if (!autofs4_oz_mode(sbi))
 		autofs4_update_usage(dentry);
 
-	dentry->d_flags &= ~DCACHE_AUTOFS_PENDING;
+	clear_bit(D_Autofs_Pending, &dentry->d_flags);
 	return 1;
 }
 
@@ -277,7 +277,7 @@
 	dentry->d_op = &autofs4_root_dentry_operations;
 
 	if (!oz_mode)
-		dentry->d_flags |= DCACHE_AUTOFS_PENDING;
+		set_bit(D_Autofs_Pending, &dentry->d_flags);
 	dentry->d_fsdata = NULL;
 	d_add(dentry, NULL);
 
@@ -291,7 +291,7 @@
 	 * If we are still pending, check if we had to handle
 	 * a signal. If so we can force a restart..
 	 */
-	if (dentry->d_flags & DCACHE_AUTOFS_PENDING) {
+	if (test_bit(D_Autofs_Pending, &dentry->d_flags)) {
 		if (signal_pending(current))
 			return ERR_PTR(-ERESTARTNOINTR);
 	}
diff -urN S4-pre4/fs/dcache.c S4-pre4-d_flags/fs/dcache.c
--- S4-pre4/fs/dcache.c	Tue Apr 17 23:40:32 2001
+++ S4-pre4-d_flags/fs/dcache.c	Wed Apr 18 06:19:09 2001
@@ -337,8 +337,7 @@
 		dentry = list_entry(tmp, struct dentry, d_lru);
 
 		/* If the dentry was recently referenced, don't free it. */
-		if (dentry->d_flags & DCACHE_REFERENCED) {
-			dentry->d_flags &= ~DCACHE_REFERENCED;
+		if (test_and_clear_bit(D_Referenced, &dentry->d_flags)) {
 			list_add(&dentry->d_lru, &dentry_unused);
 			continue;
 		}
@@ -733,7 +732,7 @@
 				continue;
 		}
 		__dget_locked(dentry);
-		dentry->d_flags |= DCACHE_REFERENCED;
+		set_bit(D_Referenced, &dentry->d_flags);
 		spin_unlock(&dcache_lock);
 		return dentry;
 	}
diff -urN S4-pre4/fs/nfs/dir.c S4-pre4-d_flags/fs/nfs/dir.c
--- S4-pre4/fs/nfs/dir.c	Sun Apr  1 23:57:20 2001
+++ S4-pre4-d_flags/fs/nfs/dir.c	Wed Apr 18 06:17:59 2001
@@ -567,7 +567,7 @@
 		dentry->d_parent->d_name.name, dentry->d_name.name,
 		dentry->d_flags);
 
-	if (dentry->d_flags & DCACHE_NFSFS_RENAMED) {
+	if (test_bit(D_NFS_Renamed, &dentry->d_flags)) {
 		/* Unhash it, so that ->d_iput() would be called */
 		return 1;
 	}
@@ -581,7 +581,7 @@
  */
 static void nfs_dentry_iput(struct dentry *dentry, struct inode *inode)
 {
-	if (dentry->d_flags & DCACHE_NFSFS_RENAMED) {
+	if (test_bit(D_NFS_Renamed, &dentry->d_flags)) {
 		lock_kernel();
 		nfs_complete_unlink(dentry);
 		unlock_kernel();
@@ -785,7 +785,7 @@
 	 * We don't allow a dentry to be silly-renamed twice.
 	 */
 	error = -EBUSY;
-	if (dentry->d_flags & DCACHE_NFSFS_RENAMED)
+	if (test_bit(D_NFS_Renamed, &dentry->d_flags))
 		goto out;
 
 	sprintf(silly, ".nfs%*.*lx",
@@ -859,7 +859,7 @@
 	}
 
 	/* If the dentry was sillyrenamed, we simply call d_delete() */
-	if (dentry->d_flags & DCACHE_NFSFS_RENAMED) {
+	if (test_bit(D_NFS_Renamed, &dentry->d_flags)) {
 		error = 0;
 		goto out_delete;
 	}
diff -urN S4-pre4/fs/nfs/unlink.c S4-pre4-d_flags/fs/nfs/unlink.c
--- S4-pre4/fs/nfs/unlink.c	Fri Feb 16 22:52:05 2001
+++ S4-pre4-d_flags/fs/nfs/unlink.c	Wed Apr 18 06:17:59 2001
@@ -179,7 +179,7 @@
 	task->tk_action = nfs_async_unlink_init;
 	task->tk_release = nfs_async_unlink_release;
 
-	dentry->d_flags |= DCACHE_NFSFS_RENAMED;
+	set_bit(D_NFS_Renamed, &dentry->d_flags);
 	data->cred = rpcauth_lookupcred(clnt->cl_auth, 0);
 
 	rpc_sleep_on(&nfs_delete_queue, task, NULL, NULL);
@@ -209,7 +209,7 @@
 		return;
 	data->count++;
 	nfs_copy_dname(dentry, data);
-	dentry->d_flags &= ~DCACHE_NFSFS_RENAMED;
+	clear_bit(D_NFS_Renamed, &dentry->d_flags);
 	if (data->task.tk_rpcwait == &nfs_delete_queue)
 		rpc_wake_up_task(&data->task);
 	nfs_put_unlinkdata(data);
diff -urN S4-pre4/fs/nfsd/nfsfh.c S4-pre4-d_flags/fs/nfsd/nfsfh.c
--- S4-pre4/fs/nfsd/nfsfh.c	Fri Feb 16 22:52:09 2001
+++ S4-pre4-d_flags/fs/nfsd/nfsfh.c	Wed Apr 18 06:20:22 2001
@@ -154,7 +154,7 @@
 	spin_lock(&dcache_lock);
 	for (lp = inode->i_dentry.next; lp != &inode->i_dentry ; lp=lp->next) {
 		result = list_entry(lp,struct dentry, d_alias);
-		if (! (result->d_flags & DCACHE_NFSD_DISCONNECTED)) {
+		if (!test_bit(D_Disconnected, &result->d_flags)) {
 			dget_locked(result);
 			spin_unlock(&dcache_lock);
 			iput(inode);
@@ -167,7 +167,7 @@
 		iput(inode);
 		return ERR_PTR(-ENOMEM);
 	}
-	result->d_flags |= DCACHE_NFSD_DISCONNECTED;
+	set_bit(D_Disconnected, &result->d_flags);
 	d_rehash(result); /* so a dput won't loose it */
 	return result;
 }
@@ -182,7 +182,7 @@
 #ifdef NFSD_PARANOIA
 	if (!IS_ROOT(target))
 		printk("nfsd: d_splice with no-root target: %s/%s\n", parent->d_name.name, name->name);
-	if (!(target->d_flags & DCACHE_NFSD_DISCONNECTED))
+	if (!test_bit(D_Disconnected, &target->d_flags))
 		printk("nfsd: d_splice with non-DISCONNECTED target: %s/%s\n", parent->d_name.name, name->name);
 #endif
 	name->hash = full_name_hash(name->name, name->len);
@@ -205,9 +205,9 @@
 	 * the children are connected, but it must be a singluar (non-forking)
 	 * branch
 	 */
-	if (!(parent->d_flags & DCACHE_NFSD_DISCONNECTED)) {
+	if (!test_bit(D_Disconnected, &parent->d_flags)) {
 		while (target) {
-			target->d_flags &= ~DCACHE_NFSD_DISCONNECTED;
+			clear_bit(D_Disconnected, &target->d_flags);
 			parent = target;
 			spin_lock(&dcache_lock);
 			if (list_empty(&parent->d_subdirs))
@@ -266,7 +266,7 @@
 		if (pdentry == NULL) {
 			pdentry = d_alloc_root(igrab(tdentry->d_inode));
 			if (pdentry) {
-				pdentry->d_flags |= DCACHE_NFSD_DISCONNECTED;
+				set_bit(D_Disconnected, &pdentry->d_flags);
 				d_rehash(pdentry);
 			}
 		}
@@ -363,14 +363,14 @@
 	down(&sb->s_nfsd_free_path_sem);
 	result = nfsd_iget(sb, ino, generation);
 	if (IS_ERR(result)
-	    || !(result->d_flags & DCACHE_NFSD_DISCONNECTED)
+	    || !test_bit(D_Disconnected, &result->d_flags)
 	    || (!S_ISDIR(result->d_inode->i_mode) && ! needpath)) {
 		up(&sb->s_nfsd_free_path_sem);
 	    
 		err = PTR_ERR(result);
 		if (IS_ERR(result))
 			goto err_out;
-		if ((result->d_flags & DCACHE_NFSD_DISCONNECTED))
+		if (test_bit(D_Disconnected, &result->d_flags))
 			nfsdstats.fh_anon++;
 		return result;
 	}
@@ -396,7 +396,7 @@
 			    || !S_ISDIR(dentry->d_inode->i_mode)) {
 				goto err_dentry;
 			}
-			if (!(dentry->d_flags & DCACHE_NFSD_DISCONNECTED))
+			if (!test_bit(D_Disconnected, &dentry->d_flags))
 				found = 1;
 			tmp = splice(result, dentry);
 			err = PTR_ERR(tmp);
@@ -434,7 +434,7 @@
 			goto err_dentry;
 		}
 
-		if (!(dentry->d_flags & DCACHE_NFSD_DISCONNECTED))
+		if (!test_bit(D_Disconnected, &dentry->d_flags))
 			found = 1;
 
 		tmp = splice(dentry, pdentry);
@@ -603,7 +603,7 @@
 		}
 #ifdef NFSD_PARANOIA
 		if (S_ISDIR(dentry->d_inode->i_mode) &&
-		    (dentry->d_flags & DCACHE_NFSD_DISCONNECTED)) {
+		    test_bit(D_Disconnected, &dentry->d_flags)) {
 			printk("nfsd: find_fh_dentry returned a DISCONNECTED directory: %s/%s\n",
 			       dentry->d_parent->d_name.name, dentry->d_name.name);
 		}
diff -urN S4-pre4/include/linux/dcache.h S4-pre4-d_flags/include/linux/dcache.h
--- S4-pre4/include/linux/dcache.h	Sun Apr  1 23:57:20 2001
+++ S4-pre4-d_flags/include/linux/dcache.h	Wed Apr 18 06:17:59 2001
@@ -65,7 +65,7 @@
 
 struct dentry {
 	atomic_t d_count;
-	unsigned int d_flags;
+	unsigned long d_flags;
 	struct inode  * d_inode;	/* Where the name belongs to - NULL is negative */
 	struct dentry * d_parent;	/* parent directory */
 	struct list_head d_vfsmnt;
@@ -111,18 +111,20 @@
  */
 
 /* d_flags entries */
-#define DCACHE_AUTOFS_PENDING 0x0001    /* autofs: "under construction" */
-#define DCACHE_NFSFS_RENAMED  0x0002    /* this dentry has been "silly
-					 * renamed" and has to be
-					 * deleted on the last dput()
-					 */
-#define	DCACHE_NFSD_DISCONNECTED 0x0004	/* This dentry is not currently connected to the
-					 * dcache tree. Its parent will either be itself,
-					 * or will have this flag as well.
-					 * If this dentry points to a directory, then
-					 * s_nfsd_free_path semaphore will be down
-					 */
-#define DCACHE_REFERENCED	0x0008  /* Recently used, don't discard. */
+enum {
+	D_Autofs_Pending,	/* autofs: "under construction" */
+	D_NFS_Renamed,		/* this dentry has been "silly
+				 * renamed" and has to be
+				 * deleted on the last dput()
+				 */
+	D_Disconnected,		/* This dentry is not currently connected to
+				 * the dcache tree. Its parent will either be
+				 * itself, or will have this flag as well.
+				 * If this dentry points to a directory, then
+				 * s_nfsd_free_path semaphore will be down
+				 */
+	D_Referenced,		/* Recently used, don't discard. */
+};
 
 extern spinlock_t dcache_lock;
 

