Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267443AbUG2KHX@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267443AbUG2KHX (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 29 Jul 2004 06:07:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267439AbUG2KHA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 29 Jul 2004 06:07:00 -0400
Received: from mx1.redhat.com ([66.187.233.31]:35241 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S267425AbUG2KD4 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 29 Jul 2004 06:03:56 -0400
Date: Thu, 29 Jul 2004 12:03:08 +0200
From: Arjan van de Ven <arjanv@redhat.com>
To: linux-kernel@vger.kernel.org
Cc: riel@redhat.com, akpm@osdl.org
Subject: [patch] mlock-as-nonroot revisted
Message-ID: <20040729100307.GA23571@devserv.devel.redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

Hi,
                                                                                                             
Below is a fixed up patch to allow non-root to mlock memory (but only if the
rlimit allows it, which defaults to 0). This is needed/useful for oracle and
co to be allowed to mlock/use hugetlb fs running as non-privileged user.
Also setting the limit to 4Kb can be very useful for gnupg and similar apps.
                                                                                                             
Compared to the previous revision of this patch; shm accounting has been
changed to be per user struct, while keeping track of which user struct
allocated the shm segment in the first place. This is done in order to avoid
the security bug where one process/user could mlock and another munlock
which would screw up the accounting.

Greetings,
    Arjan van de Ven

diff -purN linux-2.6.7/fs/hugetlbfs/inode.c linux/fs/hugetlbfs/inode.c
--- linux-2.6.7/fs/hugetlbfs/inode.c	2004-07-29 11:36:55.744448953 +0200
+++ linux/fs/hugetlbfs/inode.c	2004-07-29 11:38:04.292595263 +0200
@@ -722,7 +722,7 @@ struct file *hugetlb_zero_setup(size_t s
 	struct qstr quick_string;
 	char buf[16];
 
-	if (!capable(CAP_IPC_LOCK))
+	if (!can_do_mlock())
 		return ERR_PTR(-EPERM);
 
 	if (!is_hugepage_mem_enough(size))
diff -purN linux-2.6.7/include/asm-alpha/resource.h linux/include/asm-alpha/resource.h
--- linux-2.6.7/include/asm-alpha/resource.h	2004-07-29 11:36:46.344513294 +0200
+++ linux/include/asm-alpha/resource.h	2004-07-29 11:38:04.310593182 +0200
@@ -41,7 +41,7 @@
     {INR_OPEN, INR_OPEN},			/* RLIMIT_NOFILE */	\
     {LONG_MAX, LONG_MAX},			/* RLIMIT_AS */		\
     {LONG_MAX, LONG_MAX},			/* RLIMIT_NPROC */	\
-    {LONG_MAX, LONG_MAX},			/* RLIMIT_MEMLOCK */	\
+    {0, 	0	},			/* RLIMIT_MEMLOCK */	\
     {LONG_MAX, LONG_MAX},			/* RLIMIT_LOCKS */	\
     {MAX_SIGPENDING, MAX_SIGPENDING},		/* RLIMIT_SIGPENDING */ \
     {MQ_BYTES_MAX, MQ_BYTES_MAX},		/* RLIMIT_MSGQUEUE */	\
diff -purN linux-2.6.7/include/asm-arm/resource.h linux/include/asm-arm/resource.h
--- linux-2.6.7/include/asm-arm/resource.h	2004-07-29 11:36:46.380509225 +0200
+++ linux/include/asm-arm/resource.h	2004-07-29 11:38:04.292595263 +0200
@@ -39,7 +39,7 @@
 	{ RLIM_INFINITY, RLIM_INFINITY },	\
 	{ 0,             0             },	\
 	{ INR_OPEN,      INR_OPEN      },	\
-	{ RLIM_INFINITY, RLIM_INFINITY },	\
+	{ 0,		 0	       },	\
 	{ RLIM_INFINITY, RLIM_INFINITY },	\
 	{ RLIM_INFINITY, RLIM_INFINITY },	\
 	{ MAX_SIGPENDING, MAX_SIGPENDING},	\
diff -purN linux-2.6.7/include/asm-arm26/resource.h linux/include/asm-arm26/resource.h
--- linux-2.6.7/include/asm-arm26/resource.h	2004-07-29 11:36:46.383508886 +0200
+++ linux/include/asm-arm26/resource.h	2004-07-29 11:38:04.293595148 +0200
@@ -39,7 +39,7 @@
 	{ RLIM_INFINITY, RLIM_INFINITY },	\
 	{ 0,             0             },	\
 	{ INR_OPEN,      INR_OPEN      },	\
-	{ RLIM_INFINITY, RLIM_INFINITY },	\
+	{ 0,	         0	       },	\
 	{ RLIM_INFINITY, RLIM_INFINITY },	\
 	{ RLIM_INFINITY, RLIM_INFINITY },	\
 	{ MAX_SIGPENDING, MAX_SIGPENDING},	\
diff -purN linux-2.6.7/include/asm-cris/resource.h linux/include/asm-cris/resource.h
--- linux-2.6.7/include/asm-cris/resource.h	2004-07-29 11:36:46.384508773 +0200
+++ linux/include/asm-cris/resource.h	2004-07-29 11:38:04.310593182 +0200
@@ -39,7 +39,7 @@
 	{ RLIM_INFINITY, RLIM_INFINITY },		\
 	{             0,             0 },		\
 	{      INR_OPEN,     INR_OPEN  },		\
-	{ RLIM_INFINITY, RLIM_INFINITY },               \
+	{             0,             0 },               \
 	{ RLIM_INFINITY, RLIM_INFINITY },		\
 	{ RLIM_INFINITY, RLIM_INFINITY },		\
 	{ MAX_SIGPENDING, MAX_SIGPENDING },		\
diff -purN linux-2.6.7/include/asm-h8300/resource.h linux/include/asm-h8300/resource.h
--- linux-2.6.7/include/asm-h8300/resource.h	2004-07-29 11:36:46.389508207 +0200
+++ linux/include/asm-h8300/resource.h	2004-07-29 11:38:04.294595032 +0200
@@ -39,7 +39,7 @@
 	{ RLIM_INFINITY, RLIM_INFINITY },		\
 	{             0,             0 },		\
 	{      INR_OPEN,     INR_OPEN  },		\
-	{ RLIM_INFINITY, RLIM_INFINITY },		\
+	{             0,             0 },		\
 	{ RLIM_INFINITY, RLIM_INFINITY },		\
 	{ RLIM_INFINITY, RLIM_INFINITY },		\
 	{ MAX_SIGPENDING, MAX_SIGPENDING },		\
diff -purN linux-2.6.7/include/asm-i386/resource.h linux/include/asm-i386/resource.h
--- linux-2.6.7/include/asm-i386/resource.h	2004-07-29 11:36:46.409505947 +0200
+++ linux/include/asm-i386/resource.h	2004-07-29 11:38:04.295594916 +0200
@@ -40,7 +40,7 @@
 	{ RLIM_INFINITY, RLIM_INFINITY },		\
 	{             0,             0 },		\
 	{      INR_OPEN,     INR_OPEN  },		\
-	{ RLIM_INFINITY, RLIM_INFINITY },		\
+	{             0,             0 },		\
 	{ RLIM_INFINITY, RLIM_INFINITY },		\
 	{ RLIM_INFINITY, RLIM_INFINITY },		\
 	{ MAX_SIGPENDING, MAX_SIGPENDING },		\
diff -purN linux-2.6.7/include/asm-ia64/resource.h linux/include/asm-ia64/resource.h
--- linux-2.6.7/include/asm-ia64/resource.h	2004-07-29 11:36:46.418504929 +0200
+++ linux/include/asm-ia64/resource.h	2004-07-29 11:38:04.295594916 +0200
@@ -46,7 +46,7 @@
 	{ RLIM_INFINITY, RLIM_INFINITY },		\
 	{             0,             0 },		\
 	{      INR_OPEN,     INR_OPEN  },		\
-	{ RLIM_INFINITY, RLIM_INFINITY },		\
+	{             0,             0 },		\
 	{ RLIM_INFINITY, RLIM_INFINITY },		\
 	{ RLIM_INFINITY, RLIM_INFINITY },		\
 	{ MAX_SIGPENDING, MAX_SIGPENDING },		\
diff -purN linux-2.6.7/include/asm-m68k/resource.h linux/include/asm-m68k/resource.h
--- linux-2.6.7/include/asm-m68k/resource.h	2004-07-29 11:36:46.425504138 +0200
+++ linux/include/asm-m68k/resource.h	2004-07-29 11:38:04.296594801 +0200
@@ -39,7 +39,7 @@
 	{ RLIM_INFINITY, RLIM_INFINITY },		\
 	{             0,             0 },		\
 	{      INR_OPEN,     INR_OPEN  },		\
-	{ RLIM_INFINITY, RLIM_INFINITY },		\
+	{             0,             0 },		\
 	{ RLIM_INFINITY, RLIM_INFINITY },		\
 	{ RLIM_INFINITY, RLIM_INFINITY },		\
 	{ MAX_SIGPENDING, MAX_SIGPENDING },		\
diff -purN linux-2.6.7/include/asm-parisc/resource.h linux/include/asm-parisc/resource.h
--- linux-2.6.7/include/asm-parisc/resource.h	2004-07-29 11:36:46.447501651 +0200
+++ linux/include/asm-parisc/resource.h	2004-07-29 11:38:04.297594685 +0200
@@ -39,7 +39,7 @@
 	{ RLIM_INFINITY, RLIM_INFINITY },		\
 	{             0,             0 },		\
 	{      INR_OPEN,     INR_OPEN  },		\
-	{ RLIM_INFINITY, RLIM_INFINITY },		\
+	{             0,             0 },		\
 	{ RLIM_INFINITY, RLIM_INFINITY },		\
 	{ RLIM_INFINITY, RLIM_INFINITY },		\
 	{ MAX_SIGPENDING, MAX_SIGPENDING },		\
diff -purN linux-2.6.7/include/asm-ppc/resource.h linux/include/asm-ppc/resource.h
--- linux-2.6.7/include/asm-ppc/resource.h	2004-07-29 11:36:46.462499955 +0200
+++ linux/include/asm-ppc/resource.h	2004-07-29 11:38:04.298594570 +0200
@@ -36,7 +36,7 @@
 	{ RLIM_INFINITY, RLIM_INFINITY },		\
 	{             0,             0 },		\
 	{      INR_OPEN,     INR_OPEN  },		\
-	{ RLIM_INFINITY, RLIM_INFINITY },		\
+	{             0,             0 },		\
 	{ RLIM_INFINITY, RLIM_INFINITY },		\
 	{ RLIM_INFINITY, RLIM_INFINITY },		\
 	{ MAX_SIGPENDING, MAX_SIGPENDING },		\
diff -purN linux-2.6.7/include/asm-ppc64/resource.h linux/include/asm-ppc64/resource.h
--- linux-2.6.7/include/asm-ppc64/resource.h	2004-07-29 11:36:46.472498825 +0200
+++ linux/include/asm-ppc64/resource.h	2004-07-29 11:38:04.298594570 +0200
@@ -45,7 +45,7 @@
 	{ RLIM_INFINITY, RLIM_INFINITY },		\
 	{             0,             0 },		\
 	{      INR_OPEN,     INR_OPEN  },		\
-	{ RLIM_INFINITY, RLIM_INFINITY },		\
+	{             0,             0 },		\
 	{ RLIM_INFINITY, RLIM_INFINITY },		\
 	{ RLIM_INFINITY, RLIM_INFINITY },		\
 	{ MAX_SIGPENDING, MAX_SIGPENDING },		\
diff -purN linux-2.6.7/include/asm-s390/resource.h linux/include/asm-s390/resource.h
--- linux-2.6.7/include/asm-s390/resource.h	2004-07-29 11:36:46.479498034 +0200
+++ linux/include/asm-s390/resource.h	2004-07-29 11:38:04.299594454 +0200
@@ -47,7 +47,7 @@
 	{ RLIM_INFINITY, RLIM_INFINITY },		\
 	{             0,             0 },		\
 	{ INR_OPEN, INR_OPEN },                         \
-	{ RLIM_INFINITY, RLIM_INFINITY },		\
+	{             0,             0 },		\
 	{ RLIM_INFINITY, RLIM_INFINITY },		\
 	{ RLIM_INFINITY, RLIM_INFINITY },		\
 	{ MAX_SIGPENDING, MAX_SIGPENDING },		\
diff -purN linux-2.6.7/include/asm-sh/resource.h linux/include/asm-sh/resource.h
--- linux-2.6.7/include/asm-sh/resource.h	2004-07-29 11:36:46.491496677 +0200
+++ linux/include/asm-sh/resource.h	2004-07-29 11:38:04.300594338 +0200
@@ -39,7 +39,7 @@
 	{ RLIM_INFINITY, RLIM_INFINITY },		\
 	{             0,             0 },		\
 	{      INR_OPEN,     INR_OPEN  },		\
-	{ RLIM_INFINITY, RLIM_INFINITY },		\
+	{             0,             0 },		\
 	{ RLIM_INFINITY, RLIM_INFINITY },		\
 	{ RLIM_INFINITY, RLIM_INFINITY },		\
 	{ MAX_SIGPENDING, MAX_SIGPENDING },		\
diff -purN linux-2.6.7/include/asm-sparc/resource.h linux/include/asm-sparc/resource.h
--- linux-2.6.7/include/asm-sparc/resource.h	2004-07-29 11:36:46.537491477 +0200
+++ linux/include/asm-sparc/resource.h	2004-07-29 11:38:04.300594338 +0200
@@ -44,7 +44,7 @@
     {       0, RLIM_INFINITY},		\
     {RLIM_INFINITY, RLIM_INFINITY},	\
     {INR_OPEN, INR_OPEN}, {0, 0},	\
-    {RLIM_INFINITY, RLIM_INFINITY},	\
+    {0, 	     0},	\
     {RLIM_INFINITY, RLIM_INFINITY},	\
     {RLIM_INFINITY, RLIM_INFINITY},	\
     {MAX_SIGPENDING, MAX_SIGPENDING},	\
diff -purN linux-2.6.7/include/asm-sparc64/resource.h linux/include/asm-sparc64/resource.h
--- linux-2.6.7/include/asm-sparc64/resource.h	2004-07-29 11:36:46.545490573 +0200
+++ linux/include/asm-sparc64/resource.h	2004-07-29 11:38:04.301594223 +0200
@@ -43,7 +43,7 @@
     {       0, RLIM_INFINITY},		\
     {RLIM_INFINITY, RLIM_INFINITY},	\
     {INR_OPEN, INR_OPEN}, {0, 0},	\
-    {RLIM_INFINITY, RLIM_INFINITY},	\
+    {0, 	     0	          },	\
     {RLIM_INFINITY, RLIM_INFINITY},	\
     {RLIM_INFINITY, RLIM_INFINITY},	\
     {MAX_SIGPENDING, MAX_SIGPENDING},	\
diff -purN linux-2.6.7/include/asm-v850/resource.h linux/include/asm-v850/resource.h
--- linux-2.6.7/include/asm-v850/resource.h	2004-07-29 11:36:46.548490234 +0200
+++ linux/include/asm-v850/resource.h	2004-07-29 11:38:04.302594107 +0200
@@ -39,7 +39,7 @@
 	{ RLIM_INFINITY, RLIM_INFINITY },		\
 	{             0,             0 },		\
 	{      INR_OPEN,     INR_OPEN  },		\
-	{ RLIM_INFINITY, RLIM_INFINITY },		\
+	{             0,             0 },		\
 	{ RLIM_INFINITY, RLIM_INFINITY },		\
 	{ RLIM_INFINITY, RLIM_INFINITY },		\
 	{ MAX_SIGPENDING, MAX_SIGPENDING },		\
diff -purN linux-2.6.7/include/asm-x86_64/resource.h linux/include/asm-x86_64/resource.h
--- linux-2.6.7/include/asm-x86_64/resource.h	2004-07-29 11:36:46.553489668 +0200
+++ linux/include/asm-x86_64/resource.h	2004-07-29 11:38:04.303593991 +0200
@@ -39,7 +39,7 @@
 	{ RLIM_INFINITY, RLIM_INFINITY },		\
 	{             0,             0 },		\
 	{      INR_OPEN,     INR_OPEN  },		\
-	{ RLIM_INFINITY, RLIM_INFINITY },		\
+	{             0,             0 },		\
 	{ RLIM_INFINITY, RLIM_INFINITY },		\
 	{ RLIM_INFINITY, RLIM_INFINITY },		\
 	{ MAX_SIGPENDING, MAX_SIGPENDING },		\
diff -purN linux-2.6.7/include/linux/mm.h linux/include/linux/mm.h
--- linux-2.6.7/include/linux/mm.h	2004-07-29 11:36:56.044414936 +0200
+++ linux/include/linux/mm.h	2004-07-29 11:38:04.310593182 +0200
@@ -496,9 +496,19 @@ int shmem_set_policy(struct vm_area_stru
 struct mempolicy *shmem_get_policy(struct vm_area_struct *vma,
 					unsigned long addr);
 struct file *shmem_file_setup(char * name, loff_t size, unsigned long flags);
-void shmem_lock(struct file * file, int lock);
+int shmem_lock(struct file * file, int lock, struct user_struct *);
 int shmem_zero_setup(struct vm_area_struct *);
 
+static inline int can_do_mlock(void)
+{
+	if (capable(CAP_IPC_LOCK))
+		return 1;
+	if (current->rlim[RLIMIT_MEMLOCK].rlim_cur != 0)
+		return 1;
+	return 0;
+}
+
+
 /*
  * Parameter block passed down to zap_pte_range in exceptional cases.
  */
diff -purN linux-2.6.7/include/linux/sched.h linux/include/linux/sched.h
--- linux-2.6.7/include/linux/sched.h	2004-07-29 11:36:55.954425142 +0200
+++ linux/include/linux/sched.h	2004-07-29 11:38:04.311593066 +0200
@@ -331,6 +331,7 @@ struct user_struct {
 	atomic_t sigpending;	/* How many pending signals does this user have? */
 	/* protected by mq_lock	*/
 	unsigned long mq_bytes;	/* How many bytes can be allocated to mqueue? */
+	unsigned long locked_shm; /* How many pages of mlocked shm ? */
 
 	/* Hash table maintenance information */
 	struct list_head uidhash_list;
diff -purN linux-2.6.7/include/linux/shm.h linux/include/linux/shm.h
--- linux-2.6.7/include/linux/shm.h	2004-06-16 07:19:43.000000000 +0200
+++ linux/include/linux/shm.h	2004-07-29 11:38:04.313592835 +0200
@@ -84,6 +84,7 @@ struct shmid_kernel /* private to the ke
 	time_t			shm_ctim;
 	pid_t			shm_cprid;
 	pid_t			shm_lprid;
+	struct user_struct *	mlock_user;
 };
 
 /* shm_mode upper byte flags */
diff -purN linux-2.6.7/ipc/shm.c linux/ipc/shm.c
--- linux-2.6.7/ipc/shm.c	2004-07-29 11:36:55.137517777 +0200
+++ linux/ipc/shm.c	2004-07-29 11:38:04.313592835 +0200
@@ -114,7 +114,7 @@ static void shm_destroy (struct shmid_ke
 	shm_rmid (shp->id);
 	shm_unlock(shp);
 	if (!is_file_hugepages(shp->shm_file))
-		shmem_lock(shp->shm_file, 0);
+		shmem_lock(shp->shm_file, 0, shp->mlock_user);
 	fput (shp->shm_file);
 	security_shm_free(shp);
 	ipc_rcu_free(shp, sizeof(struct shmid_kernel));
@@ -221,6 +221,7 @@ static int newseg (key_t key, int shmflg
 	shp->shm_nattch = 0;
 	shp->id = shm_buildid(id,shp->shm_perm.seq);
 	shp->shm_file = file;
+	shp->mlock_user = NULL;
 	file->f_dentry->d_inode->i_ino = shp->id;
 	if (shmflg & SHM_HUGETLB)
 		set_file_hugepages(file);
@@ -504,14 +505,11 @@ asmlinkage long sys_shmctl (int shmid, i
 	case SHM_LOCK:
 	case SHM_UNLOCK:
 	{
-/* Allow superuser to lock segment in memory */
-/* Should the pages be faulted in here or leave it to user? */
-/* need to determine interaction with current->swappable */
-		if (!capable(CAP_IPC_LOCK)) {
+		/* Allow superuser to lock segment in memory */
+		if (!can_do_mlock()) {
 			err = -EPERM;
 			goto out;
 		}
-
 		shp = shm_lock(shmid);
 		if(shp==NULL) {
 			err = -EINVAL;
@@ -526,12 +524,14 @@ asmlinkage long sys_shmctl (int shmid, i
 			goto out_unlock;
 		
 		if(cmd==SHM_LOCK) {
-			if (!is_file_hugepages(shp->shm_file))
-				shmem_lock(shp->shm_file, 1);
-			shp->shm_flags |= SHM_LOCKED;
+			if (!is_file_hugepages(shp->shm_file)) {
+				err = shmem_lock(shp->shm_file, 1, current->user);
+				if (!err)
+					shp->shm_flags |= SHM_LOCKED;
+			}
 		} else {
 			if (!is_file_hugepages(shp->shm_file))
-				shmem_lock(shp->shm_file, 0);
+				shmem_lock(shp->shm_file, 0, shp->mlock_user);
 			shp->shm_flags &= ~SHM_LOCKED;
 		}
 		shm_unlock(shp);
diff -purN linux-2.6.7/ipc/util.c linux/ipc/util.c
--- linux-2.6.7/ipc/util.c	2004-07-29 11:36:55.137517777 +0200
+++ linux/ipc/util.c	2004-07-29 11:38:04.306593644 +0200
@@ -392,8 +392,11 @@ int ipcperms (struct kern_ipc_perm *ipcp
 		granted_mode >>= 3;
 	/* is there some bit set in requested_mode but not in granted_mode? */
 	if ((requested_mode & ~granted_mode & 0007) && 
-	    !capable(CAP_IPC_OWNER))
-		return -1;
+	    !capable(CAP_IPC_OWNER)) {
+		if (!can_do_mlock())  {
+			return -1;
+		}
+	}	
 
 	return security_ipc_permission(ipcp, flag);
 }
diff -purN linux-2.6.7/kernel/user.c linux/kernel/user.c
--- linux-2.6.7/kernel/user.c	2004-07-29 11:36:55.155515736 +0200
+++ linux/kernel/user.c	2004-07-29 11:38:04.314592719 +0200
@@ -32,7 +32,8 @@ struct user_struct root_user = {
 	.processes	= ATOMIC_INIT(1),
 	.files		= ATOMIC_INIT(0),
 	.sigpending	= ATOMIC_INIT(0),
-	.mq_bytes	= 0
+	.mq_bytes	= 0,
+	.locked_shm     = 0
 };
 
 /*
@@ -113,6 +114,7 @@ struct user_struct * alloc_uid(uid_t uid
 		atomic_set(&new->sigpending, 0);
 
 		new->mq_bytes = 0;
+		new->locked_shm = 0;
 
 		/*
 		 * Before adding this, check whether we raced
diff -purN linux-2.6.7/mm/mlock.c linux/mm/mlock.c
--- linux-2.6.7/mm/mlock.c	2004-06-16 07:18:57.000000000 +0200
+++ linux/mm/mlock.c	2004-07-29 11:38:04.306593644 +0200
@@ -60,7 +60,7 @@ static int do_mlock(unsigned long start,
 	struct vm_area_struct * vma, * next;
 	int error;
 
-	if (on && !capable(CAP_IPC_LOCK))
+	if (on && !can_do_mlock())
 		return -EPERM;
 	len = PAGE_ALIGN(len);
 	end = start + len;
@@ -118,7 +118,7 @@ asmlinkage long sys_mlock(unsigned long 
 	lock_limit >>= PAGE_SHIFT;
 
 	/* check against resource limits */
-	if (locked <= lock_limit)
+	if ( (locked <= lock_limit) || capable(CAP_IPC_LOCK))
 		error = do_mlock(start, len, 1);
 	up_write(&current->mm->mmap_sem);
 	return error;
@@ -142,7 +142,7 @@ static int do_mlockall(int flags)
 	unsigned int def_flags;
 	struct vm_area_struct * vma;
 
-	if (!capable(CAP_IPC_LOCK))
+	if (!can_do_mlock())
 		return -EPERM;
 
 	def_flags = 0;
@@ -177,7 +177,7 @@ asmlinkage long sys_mlockall(int flags)
 	lock_limit >>= PAGE_SHIFT;
 
 	ret = -ENOMEM;
-	if (current->mm->total_vm <= lock_limit)
+	if ((current->mm->total_vm <= lock_limit) || capable(CAP_IPC_LOCK))
 		ret = do_mlockall(flags);
 out:
 	up_write(&current->mm->mmap_sem);
diff -purN linux-2.6.7/mm/mmap.c linux/mm/mmap.c
--- linux-2.6.7/mm/mmap.c	2004-07-29 11:36:55.950425596 +0200
+++ linux/mm/mmap.c	2004-07-29 11:38:04.307593529 +0200
@@ -806,15 +806,17 @@ unsigned long do_mmap_pgoff(struct file 
 			mm->def_flags | VM_MAYREAD | VM_MAYWRITE | VM_MAYEXEC;
 
 	if (flags & MAP_LOCKED) {
-		if (!capable(CAP_IPC_LOCK))
+		if (!can_do_mlock())
 			return -EPERM;
 		vm_flags |= VM_LOCKED;
 	}
 	/* mlock MCL_FUTURE? */
 	if (vm_flags & VM_LOCKED) {
-		unsigned long locked = mm->locked_vm << PAGE_SHIFT;
+		unsigned long locked, lock_limit;
+		locked = mm->locked_vm << PAGE_SHIFT;
+		lock_limit = current->rlim[RLIMIT_MEMLOCK].rlim_cur;
 		locked += len;
-		if (locked > current->rlim[RLIMIT_MEMLOCK].rlim_cur)
+		if (locked > lock_limit && !capable(CAP_IPC_LOCK))
 			return -EAGAIN;
 	}
 
@@ -1746,9 +1748,11 @@ unsigned long do_brk(unsigned long addr,
 	 * mlock MCL_FUTURE?
 	 */
 	if (mm->def_flags & VM_LOCKED) {
-		unsigned long locked = mm->locked_vm << PAGE_SHIFT;
+		unsigned long locked, lock_limit;
+		locked = mm->locked_vm << PAGE_SHIFT;
+		lock_limit = current->rlim[RLIMIT_MEMLOCK].rlim_cur;
 		locked += len;
-		if (locked > current->rlim[RLIMIT_MEMLOCK].rlim_cur)
+		if (locked > lock_limit && !capable(CAP_IPC_LOCK))
 			return -EAGAIN;
 	}
 
diff -purN linux-2.6.7/mm/mremap.c linux/mm/mremap.c
--- linux-2.6.7/mm/mremap.c	2004-07-29 11:36:55.169514149 +0200
+++ linux/mm/mremap.c	2004-07-29 11:38:04.308593413 +0200
@@ -324,10 +324,12 @@ unsigned long do_mremap(unsigned long ad
 			goto out;
 	}
 	if (vma->vm_flags & VM_LOCKED) {
-		unsigned long locked = current->mm->locked_vm << PAGE_SHIFT;
+		unsigned long locked, lock_limit;
+		locked = current->mm->locked_vm << PAGE_SHIFT;
+		lock_limit = current->rlim[RLIMIT_MEMLOCK].rlim_cur;
 		locked += new_len - old_len;
 		ret = -EAGAIN;
-		if (locked > current->rlim[RLIMIT_MEMLOCK].rlim_cur)
+		if (locked > lock_limit && !capable(CAP_IPC_LOCK))
 			goto out;
 	}
 	ret = -ENOMEM;
diff -purN linux-2.6.7/mm/shmem.c linux/mm/shmem.c
--- linux-2.6.7/mm/shmem.c	2004-07-29 11:36:55.640460745 +0200
+++ linux/mm/shmem.c	2004-07-29 11:38:04.315592604 +0200
@@ -1151,17 +1151,43 @@ shmem_get_policy(struct vm_area_struct *
 }
 #endif
 
-void shmem_lock(struct file *file, int lock)
+/* Protects current->user->locked_shm from concurrent access */
+static spinlock_t shmem_lock_user = SPIN_LOCK_UNLOCKED;
+
+int shmem_lock(struct file *file, int lock, struct user_struct * user)
 {
 	struct inode *inode = file->f_dentry->d_inode;
 	struct shmem_inode_info *info = SHMEM_I(inode);
+	unsigned long lock_limit, locked;
+	int retval = -ENOMEM;
 
 	spin_lock(&info->lock);
+	spin_lock(&shmem_lock_user);
+	if (lock && !(info->flags & VM_LOCKED)) {
+		locked = inode->i_size >> PAGE_SHIFT;
+		locked += user->locked_shm;
+		lock_limit = current->rlim[RLIMIT_MEMLOCK].rlim_cur;
+		lock_limit >>= PAGE_SHIFT;
+		if ((locked > lock_limit) && !capable(CAP_IPC_LOCK))
+			goto out_nomem;
+		/* for this branch user == current->user so it won't go away under us */
+		atomic_inc(&user->__count);
+		user->locked_shm = locked;
+	}
+	if (!lock && (info->flags & VM_LOCKED) && user) {
+		locked = inode->i_size >> PAGE_SHIFT;
+		user->locked_shm -= locked;
+		free_uid(user);
+	}
 	if (lock)
 		info->flags |= VM_LOCKED;
 	else
 		info->flags &= ~VM_LOCKED;
+	retval = 0;
+out_nomem:
+	spin_unlock(&shmem_lock_user);
 	spin_unlock(&info->lock);
+	return retval;
 }
 
 static int shmem_mmap(struct file *file, struct vm_area_struct *vma)

