Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266838AbUHCU5y@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266838AbUHCU5y (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 3 Aug 2004 16:57:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266737AbUHCU5x
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 3 Aug 2004 16:57:53 -0400
Received: from mx1.redhat.com ([66.187.233.31]:40109 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S266845AbUHCUz7 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 3 Aug 2004 16:55:59 -0400
Date: Tue, 3 Aug 2004 16:55:49 -0400 (EDT)
From: Rik van Riel <riel@redhat.com>
X-X-Sender: riel@dhcp83-102.boston.redhat.com
To: Chris Wright <chrisw@osdl.org>
cc: Arjan van de Ven <arjanv@redhat.com>, <linux-kernel@vger.kernel.org>,
       <akpm@osdl.org>, <andrea@suse.de>
Subject: Re: [patch] mlock-as-nonroot revisted
In-Reply-To: <20040729185215.Q1973@build.pdx.osdl.net>
Message-ID: <Pine.LNX.4.44.0408031654290.5948-100000@dhcp83-102.boston.redhat.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 29 Jul 2004, Chris Wright wrote:

> 1) hugetlb accounting is not done. so it's only simple change to checking
> permission, but the acutal usage is not tracked

This patch should fix that.  It's incremental with Arjan's
patch and the "set shp->mlock_user" patch I just sent.

Are you ok with how this is implemented ?

Please shoot holes in it, so I can make this better... ;)

--- linux-2.6.7/include/linux/mm.h.htlb	2004-08-03 16:29:07.362393143 -0400
+++ linux-2.6.7/include/linux/mm.h	2004-08-03 16:31:20.179095875 -0400
@@ -509,7 +509,8 @@
 		return 1;
 	return 0;
 }
-
+extern int user_can_mlock(size_t, struct user_struct *);
+extern void user_subtract_mlock(size_t, struct user_struct *);
 
 /*
  * Parameter block passed down to zap_pte_range in exceptional cases.
--- linux-2.6.7/fs/hugetlbfs/inode.c.htlb	2004-08-03 13:33:26.433750664 -0400
+++ linux-2.6.7/fs/hugetlbfs/inode.c	2004-08-03 14:08:43.636761209 -0400
@@ -718,7 +718,7 @@
 
 struct file *hugetlb_zero_setup(size_t size)
 {
-	int error;
+	int error = -ENOMEM;
 	struct file *file;
 	struct inode *inode;
 	struct dentry *dentry, *root;
@@ -731,6 +731,9 @@
 	if (!is_hugepage_mem_enough(size))
 		return ERR_PTR(-ENOMEM);
 
+	if (!user_can_mlock(size, current->user))
+		return ERR_PTR(-ENOMEM);
+
 	root = hugetlbfs_vfsmount->mnt_root;
 	snprintf(buf, 16, "%lu", hugetlbfs_counter());
 	quick_string.name = buf;
@@ -738,7 +741,7 @@
 	quick_string.hash = 0;
 	dentry = d_alloc(root, &quick_string);
 	if (!dentry)
-		return ERR_PTR(-ENOMEM);
+		goto out_subtract_mlock;
 
 	error = -ENFILE;
 	file = get_empty_filp();
@@ -765,6 +768,8 @@
 	put_filp(file);
 out_dentry:
 	dput(dentry);
+out_subtract_mlock:
+	user_subtract_mlock(size, current->user);
 	return ERR_PTR(error);
 }
 
--- linux-2.6.7/ipc/shm.c.htlb	2004-08-03 11:46:08.383363603 -0400
+++ linux-2.6.7/ipc/shm.c	2004-08-03 16:48:26.150674657 -0400
@@ -115,6 +115,9 @@
 	shm_unlock(shp);
 	if (!is_file_hugepages(shp->shm_file))
 		shmem_lock(shp->shm_file, 0, shp->mlock_user);
+	else
+		user_subtract_mlock(shp->shm_file->f_dentry->d_inode->i_size,
+						shp->mlock_user);
 	fput (shp->shm_file);
 	security_shm_free(shp);
 	ipc_rcu_free(shp, sizeof(struct shmid_kernel));
@@ -198,9 +201,11 @@
 		return error;
 	}
 
-	if (shmflg & SHM_HUGETLB)
+	if (shmflg & SHM_HUGETLB) {
+		/* hugetlb_zero_setup takes care of mlock user accounting */
 		file = hugetlb_zero_setup(size);
-	else {
+		shp->mlock_user = current->user;
+	} else {
 		sprintf (name, "SYSV%08x", key);
 		file = shmem_file_setup(name, size, VM_ACCOUNT);
 	}
--- linux-2.6.7/mm/shmem.c.htlb	2004-08-03 14:08:49.277094888 -0400
+++ linux-2.6.7/mm/shmem.c	2004-08-03 16:32:41.215119384 -0400
@@ -1151,41 +1151,27 @@
 }
 #endif
 
-/* Protects current->user->locked_shm from concurrent access */
-static spinlock_t shmem_lock_user = SPIN_LOCK_UNLOCKED;
-
 int shmem_lock(struct file *file, int lock, struct user_struct * user)
 {
 	struct inode *inode = file->f_dentry->d_inode;
 	struct shmem_inode_info *info = SHMEM_I(inode);
-	unsigned long lock_limit, locked;
 	int retval = -ENOMEM;
 
+	if (!can_do_mlock())
+		return -EPERM;
+
 	spin_lock(&info->lock);
-	spin_lock(&shmem_lock_user);
 	if (lock && !(info->flags & VM_LOCKED)) {
-		locked = inode->i_size >> PAGE_SHIFT;
-		locked += user->locked_shm;
-		lock_limit = current->rlim[RLIMIT_MEMLOCK].rlim_cur;
-		lock_limit >>= PAGE_SHIFT;
-		if ((locked > lock_limit) && !capable(CAP_IPC_LOCK))
+		if (!user_can_mlock(inode->i_size, user) && !capable(CAP_IPC_LOCK))
 			goto out_nomem;
-		/* for this branch user == current->user so it won't go away under us */
-		atomic_inc(&user->__count);
-		user->locked_shm = locked;
+		info->flags |= VM_LOCKED;
 	}
 	if (!lock && (info->flags & VM_LOCKED) && user) {
-		locked = inode->i_size >> PAGE_SHIFT;
-		user->locked_shm -= locked;
-		free_uid(user);
-	}
-	if (lock)
-		info->flags |= VM_LOCKED;
-	else
+		user_subtract_mlock(inode->i_size, user);
 		info->flags &= ~VM_LOCKED;
+	}
 	retval = 0;
 out_nomem:
-	spin_unlock(&shmem_lock_user);
 	spin_unlock(&info->lock);
 	return retval;
 }
--- linux-2.6.7/mm/mlock.c.htlb	2004-08-03 14:27:35.270370974 -0400
+++ linux-2.6.7/mm/mlock.c	2004-08-03 16:32:05.650641994 -0400
@@ -193,3 +193,38 @@
 	up_write(&current->mm->mmap_sem);
 	return ret;
 }
+
+/*
+ * Objects with different lifetime than processes (mlocked shm segments
+ * and hugetlb files) get accounted against the user_struct instead. 
+ */
+static spinlock_t mlock_user_lock = SPIN_LOCK_UNLOCKED;
+
+int user_can_mlock(size_t size, struct user_struct * user)
+{
+	unsigned long lock_limit, locked;
+	int allowed = 0;
+
+	spin_lock(&mlock_user_lock);
+	locked = size >> PAGE_SHIFT;
+	lock_limit = current->rlim[RLIMIT_MEMLOCK].rlim_cur;
+	lock_limit >>= PAGE_SHIFT;
+	if (locked + user->locked_shm > lock_limit)
+		goto out;
+	atomic_inc(&user->__count);
+	user->locked_shm += locked;
+	allowed = 1;
+out:
+	spin_unlock(&mlock_user_lock);
+	return allowed;
+}
+
+void user_subtract_mlock(size_t size, struct user_struct * user)
+{
+	if (user) {
+		spin_lock(&mlock_user_lock);
+		user->locked_shm -= (size >> PAGE_SHIFT);
+		spin_unlock(&mlock_user_lock);
+		free_uid(user);
+	}
+}

