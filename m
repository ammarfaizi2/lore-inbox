Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267418AbUHDVBx@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267418AbUHDVBx (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 4 Aug 2004 17:01:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267422AbUHDVBx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 4 Aug 2004 17:01:53 -0400
Received: from fw.osdl.org ([65.172.181.6]:42128 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S267418AbUHDVBH (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 4 Aug 2004 17:01:07 -0400
Date: Wed, 4 Aug 2004 14:01:02 -0700
From: Chris Wright <chrisw@osdl.org>
To: Rik van Riel <riel@redhat.com>
Cc: Andrew Morton <akpm@osdl.org>, Arjan Van de Ven <arjanv@redhat.com>,
       linux-kernel@vger.kernel.org, Chris Wright <chrisw@osdl.org>
Subject: Re: [PATCH] mlock-as-user for 2.6.8-rc2-mm2
Message-ID: <20040804140102.O1924@build.pdx.osdl.net>
References: <Pine.LNX.4.44.0408041328240.9630-100000@dhcp83-102.boston.redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <Pine.LNX.4.44.0408041328240.9630-100000@dhcp83-102.boston.redhat.com>; from riel@redhat.com on Wed, Aug 04, 2004 at 01:55:19PM -0400
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

* Rik van Riel (riel@redhat.com) wrote:
> Hi Andrew,
> 
> here is the last agreed-on patch that lets normal users mlock
> pages up to their rlimit.  This patch addresses all the issues
> brought up by Chris and Andrea.
> 
> Please apply this patch for your next release.

Couple more nits.

The default lockable amount is one page now (first patch is was 0).
Why don't we keep it as 0, with the CAP_IPC_LOCK overrides in place?
That way nothing is changed from user perspective, and the rest of the
policy can be done by userspace as it should.

This patch breaks in one scenario.  When ulimit == 0, process has
CAP_IPC_LOCK, and does SHM_LOCK.  The subsequent unlock or destroy will
corrupt the locked_shm count.

It's also inconsistent in handling user_can_mlock/CAP_IPC_LOCK
interaction betwen shm_lock and shm_hugetlb.

SHM_HUGETLB can now only be done by the shm_group or CAP_IPC_LOCK.
Not any can_do_mlock() user.

Double check of can_do_mlock isn't needed in SHM_LOCK path.

Interface names user_can_mlock and user_substract_mlock could be better.

Incremental update below.  Ran some simple sanity tests on this plus my
patch below and didn't find any problems.

thanks,
-chris
-- 

* Make default RLIM_MEMLOCK limit 0.
* Move CAP_IPC_LOCK check into user_can_mlock to be consistent
  and fix but with ulimit == 0 && CAP_IPC_LOCK with SHM_LOCK.
* Allow can_do_mlock() user to try SHM_HUGETLB setup.
* Remove unecessary extra can_do_mlock() test in shmem_lock().
* Rename user_can_mlock to user_shm_lock and user_subtract_mlock
  to user_shm_unlock.
* Use user instead of current->user to fit in 80 cols on SHM_LOCK.

--- linus-2.5/fs/hugetlbfs/inode.c~mlock_rlimit	2004-08-04 12:44:19.000000000 -0700
+++ linus-2.5/fs/hugetlbfs/inode.c	2004-08-04 13:21:53.000000000 -0700
@@ -721,7 +721,8 @@
 static int can_do_hugetlb_shm(void)
 {
 	return likely(capable(CAP_IPC_LOCK) ||
-			in_group_p(sysctl_hugetlb_shm_group));
+			in_group_p(sysctl_hugetlb_shm_group) ||
+			can_do_mlock());
 }
 
 struct file *hugetlb_zero_setup(size_t size)
@@ -739,7 +740,7 @@
 	if (!is_hugepage_mem_enough(size))
 		return ERR_PTR(-ENOMEM);
 
-	if (!user_can_mlock(size, current->user))
+	if (!user_shm_lock(size, current->user))
 		return ERR_PTR(-ENOMEM);
 
 	root = hugetlbfs_vfsmount->mnt_root;
@@ -749,7 +750,7 @@
 	quick_string.hash = 0;
 	dentry = d_alloc(root, &quick_string);
 	if (!dentry)
-		goto out_subtract_mlock;
+		goto out_shm_unlock;
 
 	error = -ENFILE;
 	file = get_empty_filp();
@@ -776,8 +777,8 @@
 	put_filp(file);
 out_dentry:
 	dput(dentry);
-out_subtract_mlock:
-	user_subtract_mlock(size, current->user);
+out_shm_unlock:
+	user_shm_unlock(size, current->user);
 	return ERR_PTR(error);
 }
 
--- linus-2.5/include/asm-alpha/resource.h~mlock_rlimit	2004-08-04 12:33:48.000000000 -0700
+++ linus-2.5/include/asm-alpha/resource.h	2004-08-04 12:34:40.000000000 -0700
@@ -41,7 +41,7 @@
     {INR_OPEN, INR_OPEN},			/* RLIMIT_NOFILE */	\
     {LONG_MAX, LONG_MAX},			/* RLIMIT_AS */		\
     {LONG_MAX, LONG_MAX},			/* RLIMIT_NPROC */	\
-    {PAGE_SIZE, PAGE_SIZE},			/* RLIMIT_MEMLOCK */	\
+    {0, 	0	},			/* RLIMIT_MEMLOCK */	\
     {LONG_MAX, LONG_MAX},			/* RLIMIT_LOCKS */	\
     {MAX_SIGPENDING, MAX_SIGPENDING},		/* RLIMIT_SIGPENDING */ \
     {MQ_BYTES_MAX, MQ_BYTES_MAX},		/* RLIMIT_MSGQUEUE */	\
--- linus-2.5/include/asm-arm/resource.h~mlock_rlimit	2004-08-04 12:33:48.000000000 -0700
+++ linus-2.5/include/asm-arm/resource.h	2004-08-04 12:34:40.000000000 -0700
@@ -39,7 +39,7 @@
 	{ RLIM_INFINITY, RLIM_INFINITY },	\
 	{ 0,             0             },	\
 	{ INR_OPEN,      INR_OPEN      },	\
-	{ PAGE_SIZE,      PAGE_SIZE    },	\
+	{ 0,		 0	       },	\
 	{ RLIM_INFINITY, RLIM_INFINITY },	\
 	{ RLIM_INFINITY, RLIM_INFINITY },	\
 	{ MAX_SIGPENDING, MAX_SIGPENDING},	\
--- linus-2.5/include/asm-cris/resource.h~mlock_rlimit	2004-08-04 12:33:48.000000000 -0700
+++ linus-2.5/include/asm-cris/resource.h	2004-08-04 12:34:40.000000000 -0700
@@ -39,7 +39,7 @@
 	{ RLIM_INFINITY, RLIM_INFINITY },		\
 	{             0,             0 },		\
 	{      INR_OPEN,     INR_OPEN  },		\
-	{     PAGE_SIZE,    PAGE_SIZE  },               \
+	{             0,             0 },               \
 	{ RLIM_INFINITY, RLIM_INFINITY },		\
 	{ RLIM_INFINITY, RLIM_INFINITY },		\
 	{ MAX_SIGPENDING, MAX_SIGPENDING },		\
--- linus-2.5/include/asm-h8300/resource.h~mlock_rlimit	2004-08-04 12:33:48.000000000 -0700
+++ linus-2.5/include/asm-h8300/resource.h	2004-08-04 12:34:41.000000000 -0700
@@ -39,7 +39,7 @@
 	{ RLIM_INFINITY, RLIM_INFINITY },		\
 	{             0,             0 },		\
 	{      INR_OPEN,     INR_OPEN  },		\
-	{ PAGE_SIZE,     PAGE_SIZE     },		\
+	{             0,             0 },		\
 	{ RLIM_INFINITY, RLIM_INFINITY },		\
 	{ RLIM_INFINITY, RLIM_INFINITY },		\
 	{ MAX_SIGPENDING, MAX_SIGPENDING },		\
--- linus-2.5/include/asm-i386/resource.h~mlock_rlimit	2004-08-04 12:33:48.000000000 -0700
+++ linus-2.5/include/asm-i386/resource.h	2004-08-04 12:34:41.000000000 -0700
@@ -40,7 +40,7 @@
 	{ RLIM_INFINITY, RLIM_INFINITY },		\
 	{             0,             0 },		\
 	{      INR_OPEN,     INR_OPEN  },		\
-	{ PAGE_SIZE,     PAGE_SIZE     },		\
+	{             0,             0 },		\
 	{ RLIM_INFINITY, RLIM_INFINITY },		\
 	{ RLIM_INFINITY, RLIM_INFINITY },		\
 	{ MAX_SIGPENDING, MAX_SIGPENDING },		\
--- linus-2.5/include/asm-ia64/resource.h~mlock_rlimit	2004-08-04 12:33:48.000000000 -0700
+++ linus-2.5/include/asm-ia64/resource.h	2004-08-04 12:34:41.000000000 -0700
@@ -46,7 +46,7 @@
 	{ RLIM_INFINITY, RLIM_INFINITY },		\
 	{             0,             0 },		\
 	{      INR_OPEN,     INR_OPEN  },		\
-	{ PAGE_SIZE,     PAGE_SIZE     },		\
+	{             0,             0 },		\
 	{ RLIM_INFINITY, RLIM_INFINITY },		\
 	{ RLIM_INFINITY, RLIM_INFINITY },		\
 	{ MAX_SIGPENDING, MAX_SIGPENDING },		\
--- linus-2.5/include/asm-m68k/resource.h~mlock_rlimit	2004-08-04 12:33:48.000000000 -0700
+++ linus-2.5/include/asm-m68k/resource.h	2004-08-04 12:34:41.000000000 -0700
@@ -39,7 +39,7 @@
 	{ RLIM_INFINITY, RLIM_INFINITY },		\
 	{             0,             0 },		\
 	{      INR_OPEN,     INR_OPEN  },		\
-	{ PAGE_SIZE,     PAGE_SIZE     },		\
+	{             0,             0 },		\
 	{ RLIM_INFINITY, RLIM_INFINITY },		\
 	{ RLIM_INFINITY, RLIM_INFINITY },		\
 	{ MAX_SIGPENDING, MAX_SIGPENDING },		\
--- linus-2.5/include/asm-parisc/resource.h~mlock_rlimit	2004-08-04 12:33:48.000000000 -0700
+++ linus-2.5/include/asm-parisc/resource.h	2004-08-04 12:34:41.000000000 -0700
@@ -39,7 +39,7 @@
 	{ RLIM_INFINITY, RLIM_INFINITY },		\
 	{             0,             0 },		\
 	{      INR_OPEN,     INR_OPEN  },		\
-	{ PAGE_SIZE,     PAGE_SIZE     },		\
+	{             0,             0 },		\
 	{ RLIM_INFINITY, RLIM_INFINITY },		\
 	{ RLIM_INFINITY, RLIM_INFINITY },		\
 	{ MAX_SIGPENDING, MAX_SIGPENDING },		\
--- linus-2.5/include/asm-ppc/resource.h~mlock_rlimit	2004-08-04 12:33:48.000000000 -0700
+++ linus-2.5/include/asm-ppc/resource.h	2004-08-04 12:34:41.000000000 -0700
@@ -36,7 +36,7 @@
 	{ RLIM_INFINITY, RLIM_INFINITY },		\
 	{             0,             0 },		\
 	{      INR_OPEN,     INR_OPEN  },		\
-	{ PAGE_SIZE,     PAGE_SIZE     },		\
+	{             0,             0 },		\
 	{ RLIM_INFINITY, RLIM_INFINITY },		\
 	{ RLIM_INFINITY, RLIM_INFINITY },		\
 	{ MAX_SIGPENDING, MAX_SIGPENDING },		\
--- linus-2.5/include/asm-ppc64/resource.h~mlock_rlimit	2004-08-04 12:33:48.000000000 -0700
+++ linus-2.5/include/asm-ppc64/resource.h	2004-08-04 12:34:41.000000000 -0700
@@ -45,7 +45,7 @@
 	{ RLIM_INFINITY, RLIM_INFINITY },		\
 	{             0,             0 },		\
 	{      INR_OPEN,     INR_OPEN  },		\
-	{ PAGE_SIZE,     PAGE_SIZE     },		\
+	{             0,             0 },		\
 	{ RLIM_INFINITY, RLIM_INFINITY },		\
 	{ RLIM_INFINITY, RLIM_INFINITY },		\
 	{ MAX_SIGPENDING, MAX_SIGPENDING },		\
--- linus-2.5/include/asm-s390/resource.h~mlock_rlimit	2004-08-04 12:33:48.000000000 -0700
+++ linus-2.5/include/asm-s390/resource.h	2004-08-04 12:34:41.000000000 -0700
@@ -47,7 +47,7 @@
 	{ RLIM_INFINITY, RLIM_INFINITY },		\
 	{             0,             0 },		\
 	{ INR_OPEN, INR_OPEN },                         \
-	{ PAGE_SIZE,     PAGE_SIZE     },		\
+	{             0,             0 },		\
 	{ RLIM_INFINITY, RLIM_INFINITY },		\
 	{ RLIM_INFINITY, RLIM_INFINITY },		\
 	{ MAX_SIGPENDING, MAX_SIGPENDING },		\
--- linus-2.5/include/asm-sh/resource.h~mlock_rlimit	2004-08-04 12:33:48.000000000 -0700
+++ linus-2.5/include/asm-sh/resource.h	2004-08-04 12:34:41.000000000 -0700
@@ -39,7 +39,7 @@
 	{ RLIM_INFINITY, RLIM_INFINITY },		\
 	{             0,             0 },		\
 	{      INR_OPEN,     INR_OPEN  },		\
-	{ PAGE_SIZE,     PAGE_SIZE     },		\
+	{             0,             0 },		\
 	{ RLIM_INFINITY, RLIM_INFINITY },		\
 	{ RLIM_INFINITY, RLIM_INFINITY },		\
 	{ MAX_SIGPENDING, MAX_SIGPENDING },		\
--- linus-2.5/include/asm-sparc/resource.h~mlock_rlimit	2004-08-04 12:33:48.000000000 -0700
+++ linus-2.5/include/asm-sparc/resource.h	2004-08-04 12:34:41.000000000 -0700
@@ -44,7 +44,7 @@
     {       0, RLIM_INFINITY},		\
     {RLIM_INFINITY, RLIM_INFINITY},	\
     {INR_OPEN, INR_OPEN}, {0, 0},	\
-    {PAGE_SIZE, PAGE_SIZE},	\
+    {0, 	     0},	\
     {RLIM_INFINITY, RLIM_INFINITY},	\
     {RLIM_INFINITY, RLIM_INFINITY},	\
     {MAX_SIGPENDING, MAX_SIGPENDING},	\
--- linus-2.5/include/asm-sparc64/resource.h~mlock_rlimit	2004-08-04 12:33:48.000000000 -0700
+++ linus-2.5/include/asm-sparc64/resource.h	2004-08-04 12:34:41.000000000 -0700
@@ -43,7 +43,7 @@
     {       0, RLIM_INFINITY},		\
     {RLIM_INFINITY, RLIM_INFINITY},	\
     {INR_OPEN, INR_OPEN}, {0, 0},	\
-    {PAGE_SIZE,     PAGE_SIZE    },	\
+    {0, 	     0	          },	\
     {RLIM_INFINITY, RLIM_INFINITY},	\
     {RLIM_INFINITY, RLIM_INFINITY},	\
     {MAX_SIGPENDING, MAX_SIGPENDING},	\
--- linus-2.5/include/asm-v850/resource.h~mlock_rlimit	2004-08-04 12:33:48.000000000 -0700
+++ linus-2.5/include/asm-v850/resource.h	2004-08-04 12:34:41.000000000 -0700
@@ -39,7 +39,7 @@
 	{ RLIM_INFINITY, RLIM_INFINITY },		\
 	{             0,             0 },		\
 	{      INR_OPEN,     INR_OPEN  },		\
-	{ PAGE_SIZE, PAGE_SIZE  },		\
+	{             0,             0 },		\
 	{ RLIM_INFINITY, RLIM_INFINITY },		\
 	{ RLIM_INFINITY, RLIM_INFINITY },		\
 	{ MAX_SIGPENDING, MAX_SIGPENDING },		\
--- linus-2.5/include/asm-x86_64/resource.h~mlock_rlimit	2004-08-04 12:33:48.000000000 -0700
+++ linus-2.5/include/asm-x86_64/resource.h	2004-08-04 12:34:41.000000000 -0700
@@ -39,7 +39,7 @@
 	{ RLIM_INFINITY, RLIM_INFINITY },		\
 	{             0,             0 },		\
 	{      INR_OPEN,     INR_OPEN  },		\
-	{ PAGE_SIZE , PAGE_SIZE  },		\
+	{             0,             0 },		\
 	{ RLIM_INFINITY, RLIM_INFINITY },		\
 	{ RLIM_INFINITY, RLIM_INFINITY },		\
 	{ MAX_SIGPENDING, MAX_SIGPENDING },		\
--- linus-2.5/include/linux/mm.h~mlock_rlimit	2004-08-04 12:43:32.000000000 -0700
+++ linus-2.5/include/linux/mm.h	2004-08-04 12:44:03.000000000 -0700
@@ -507,8 +507,8 @@
 		return 1;
 	return 0;
 }
-extern int user_can_mlock(size_t, struct user_struct *);
-extern void user_subtract_mlock(size_t, struct user_struct *);
+extern int user_shm_lock(size_t, struct user_struct *);
+extern void user_shm_unlock(size_t, struct user_struct *);
 
 /*
  * Parameter block passed down to zap_pte_range in exceptional cases.
--- linus-2.5/include/asm-arm26/resource.h~mlock_rlimit	2004-08-04 12:33:48.000000000 -0700
+++ linus-2.5/include/asm-arm26/resource.h	2004-08-04 12:34:40.000000000 -0700
@@ -39,7 +39,7 @@
 	{ RLIM_INFINITY, RLIM_INFINITY },	\
 	{ 0,             0             },	\
 	{ INR_OPEN,      INR_OPEN      },	\
-	{ PAGE_SIZE,     PAGE_SIZE     },	\
+	{ 0,	         0	       },	\
 	{ RLIM_INFINITY, RLIM_INFINITY },	\
 	{ RLIM_INFINITY, RLIM_INFINITY },	\
 	{ MAX_SIGPENDING, MAX_SIGPENDING},	\
--- linus-2.5/ipc/shm.c~mlock_rlimit	2004-08-04 12:37:39.000000000 -0700
+++ linus-2.5/ipc/shm.c	2004-08-04 13:03:46.000000000 -0700
@@ -116,7 +116,7 @@
 	if (!is_file_hugepages(shp->shm_file))
 		shmem_lock(shp->shm_file, 0, shp->mlock_user);
 	else
-		user_subtract_mlock(shp->shm_file->f_dentry->d_inode->i_size,
+		user_shm_unlock(shp->shm_file->f_dentry->d_inode->i_size,
 						shp->mlock_user);
 	fput (shp->shm_file);
 	security_shm_free(shp);
@@ -531,7 +531,7 @@
 		if(cmd==SHM_LOCK) {
 			struct user_struct * user = current->user;
 			if (!is_file_hugepages(shp->shm_file)) {
-				err = shmem_lock(shp->shm_file, 1, current->user);
+				err = shmem_lock(shp->shm_file, 1, user);
 				if (!err) {
 					shp->shm_flags |= SHM_LOCKED;
 					shp->mlock_user = user;
--- linus-2.5/mm/mlock.c~mlock_rlimit	2004-08-04 13:39:43.483698800 -0700
+++ linus-2.5/mm/mlock.c	2004-08-04 13:39:59.681236400 -0700
@@ -195,34 +195,34 @@
 }
 
 /*
- * Objects with different lifetime than processes (mlocked shm segments
- * and hugetlb files) get accounted against the user_struct instead. 
+ * Objects with different lifetime than processes (SHM_LOCK and SHM_HUGETLB
+ * shm segments) get accounted against the user_struct instead. 
  */
-static spinlock_t mlock_user_lock = SPIN_LOCK_UNLOCKED;
+static spinlock_t shmlock_user_lock = SPIN_LOCK_UNLOCKED;
 
-int user_can_mlock(size_t size, struct user_struct * user)
+int user_shm_lock(size_t size, struct user_struct * user)
 {
 	unsigned long lock_limit, locked;
 	int allowed = 0;
 
-	spin_lock(&mlock_user_lock);
+	spin_lock(&shmlock_user_lock);
 	locked = size >> PAGE_SHIFT;
 	lock_limit = current->rlim[RLIMIT_MEMLOCK].rlim_cur;
 	lock_limit >>= PAGE_SHIFT;
-	if (locked + user->locked_shm > lock_limit)
+	if (locked + user->locked_shm > lock_limit && !capable(CAP_IPC_LOCK))
 		goto out;
 	get_uid(user);
 	user->locked_shm += locked;
 	allowed = 1;
 out:
-	spin_unlock(&mlock_user_lock);
+	spin_unlock(&shmlock_user_lock);
 	return allowed;
 }
 
-void user_subtract_mlock(size_t size, struct user_struct * user)
+void user_shm_unlock(size_t size, struct user_struct * user)
 {
-	spin_lock(&mlock_user_lock);
+	spin_lock(&shmlock_user_lock);
 	user->locked_shm -= (size >> PAGE_SHIFT);
-	spin_unlock(&mlock_user_lock);
+	spin_unlock(&shmlock_user_lock);
 	free_uid(user);
 }
--- linus-2.5/mm/shmem.c~mlock_rlimit	2004-08-04 12:38:01.000000000 -0700
+++ linus-2.5/mm/shmem.c	2004-08-04 12:40:06.000000000 -0700
@@ -1157,17 +1157,14 @@
 	struct shmem_inode_info *info = SHMEM_I(inode);
 	int retval = -ENOMEM;
 
-	if (lock && !can_do_mlock())
-		return -EPERM;
-
 	spin_lock(&info->lock);
 	if (lock && !(info->flags & VM_LOCKED)) {
-		if (!user_can_mlock(inode->i_size, user) && !capable(CAP_IPC_LOCK))
+		if (!user_shm_lock(inode->i_size, user))
 			goto out_nomem;
 		info->flags |= VM_LOCKED;
 	}
 	if (!lock && (info->flags & VM_LOCKED) && user) {
-		user_subtract_mlock(inode->i_size, user);
+		user_shm_unlock(inode->i_size, user);
 		info->flags &= ~VM_LOCKED;
 	}
 	retval = 0;
