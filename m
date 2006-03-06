Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1752046AbWCFXyo@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752046AbWCFXyo (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 6 Mar 2006 18:54:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752053AbWCFXyQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 6 Mar 2006 18:54:16 -0500
Received: from e34.co.us.ibm.com ([32.97.110.152]:62359 "EHLO
	e34.co.us.ibm.com") by vger.kernel.org with ESMTP id S1752046AbWCFXxB
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 6 Mar 2006 18:53:01 -0500
Subject: [RFC][PATCH 5/6] sysvshm: containerize
To: linux-kernel@vger.kernel.org
Cc: serue@us.ibm.com, frankeh@watson.ibm.com, clg@fr.ibm.com,
       Herbert Poetzl <herbert@13thfloor.at>, Sam Vilain <sam@vilain.net>,
       Dave Hansen <haveblue@us.ibm.com>
From: Dave Hansen <haveblue@us.ibm.com>
Date: Mon, 06 Mar 2006 15:52:52 -0800
References: <20060306235248.20842700@localhost.localdomain>
In-Reply-To: <20060306235248.20842700@localhost.localdomain>
Message-Id: <20060306235252.1514C348@localhost.localdomain>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Same thing as sems and msgs.

Take all of the global sysv shm context and put it inside of
a special structure.  This allows future work to give different
containers completely different views into the sysv space.

Signed-off-by: Dave Hansen <haveblue@us.ibm.com>
---

 work-dave/ipc/shm.c  |  197 +++++++++++++++++++++++++++------------------------
 work-dave/ipc/util.c |    3 
 work-dave/ipc/util.h |    9 ++
 3 files changed, 118 insertions(+), 91 deletions(-)

diff -puN include/linux/sched.h~sysvshm-container include/linux/sched.h
diff -puN ipc/shm.c~sysvshm-container ipc/shm.c
--- work/ipc/shm.c~sysvshm-container	2006-03-06 15:41:59.000000000 -0800
+++ work-dave/ipc/shm.c	2006-03-06 15:41:59.000000000 -0800
@@ -38,15 +38,17 @@
 static struct file_operations shm_file_operations;
 static struct vm_operations_struct shm_vm_ops;
 
-static struct ipc_ids shm_ids;
+#define shm_lock(context, id)		\
+	((struct shmid_kernel*)ipc_lock(&context->ids,id))
+#define shm_unlock(context, shp)	\
+	ipc_unlock(&(shp)->shm_perm)
+#define shm_get(context, id)\
+	((struct shmid_kernel*)ipc_get(&context->ids,id))
+#define shm_buildid(context, id, seq) \
+	ipc_buildid(&context->ids, id, seq)
 
-#define shm_lock(id)	((struct shmid_kernel*)ipc_lock(&shm_ids,id))
-#define shm_unlock(shp)	ipc_unlock(&(shp)->shm_perm)
-#define shm_get(id)	((struct shmid_kernel*)ipc_get(&shm_ids,id))
-#define shm_buildid(id, seq) \
-	ipc_buildid(&shm_ids, id, seq)
-
-static int newseg (key_t key, int shmflg, size_t size);
+static int newseg (struct ipc_shm_context *context,
+		   key_t key, int shmflg, size_t size);
 static void shm_open (struct vm_area_struct *shmd);
 static void shm_close (struct vm_area_struct *shmd);
 #ifdef CONFIG_PROC_FS
@@ -57,51 +59,53 @@ size_t	shm_ctlmax = SHMMAX;
 size_t 	shm_ctlall = SHMALL;
 int 	shm_ctlmni = SHMMNI;
 
-static int shm_tot; /* total number of shared memory pages */
-
-void __init shm_init (void)
+void __init shm_init (struct ipc_shm_context *context)
 {
-	ipc_init_ids(&shm_ids, 1);
+	ipc_init_ids(&context->ids, 1);
 	ipc_init_proc_interface("sysvipc/shm",
 				"       key      shmid perms       size  cpid  lpid nattch   uid   gid  cuid  cgid      atime      dtime      ctime\n",
-				&shm_ids,
+				&context->ids,
 				sysvipc_shm_proc_show);
 }
 
-static inline int shm_checkid(struct shmid_kernel *s, int id)
+static inline int shm_checkid(struct ipc_shm_context *context,
+			      struct shmid_kernel *s, int id)
 {
-	if (ipc_checkid(&shm_ids,&s->shm_perm,id))
+	if (ipc_checkid(&context->ids,&s->shm_perm,id))
 		return -EIDRM;
 	return 0;
 }
 
-static inline struct shmid_kernel *shm_rmid(int id)
+static inline
+struct shmid_kernel *shm_rmid(struct ipc_shm_context *context, int id)
 {
-	return (struct shmid_kernel *)ipc_rmid(&shm_ids,id);
+	return (struct shmid_kernel *)ipc_rmid(&context->ids,id);
 }
 
-static inline int shm_addid(struct shmid_kernel *shp)
+static inline
+int shm_addid(struct ipc_shm_context *context, struct shmid_kernel *shp)
 {
-	return ipc_addid(&shm_ids, &shp->shm_perm, shm_ctlmni);
+	return ipc_addid(&context->ids, &shp->shm_perm, shm_ctlmni);
 }
 
 
 
-static inline void shm_inc (int id) {
+static inline void shm_inc (struct ipc_shm_context *context, int id) {
 	struct shmid_kernel *shp;
 
-	if(!(shp = shm_lock(id)))
+	if(!(shp = shm_lock(context, id)))
 		BUG();
 	shp->shm_atim = get_seconds();
 	shp->shm_lprid = current->tgid;
 	shp->shm_nattch++;
-	shm_unlock(shp);
+	shm_unlock(context, shp);
 }
 
 /* This is called by fork, once for every shm attach. */
 static void shm_open (struct vm_area_struct *shmd)
 {
-	shm_inc (shmd->vm_file->f_dentry->d_inode->i_ino);
+	struct ipc_shm_context *context = shmd->vm_private_data;
+	shm_inc (context, shmd->vm_file->f_dentry->d_inode->i_ino);
 }
 
 /*
@@ -109,14 +113,15 @@ static void shm_open (struct vm_area_str
  *
  * @shp: struct to free
  *
- * It has to be called with shp and shm_ids.sem locked,
+ * It has to be called with shp and context->ids.sem locked,
  * but returns with shp unlocked and freed.
  */
-static void shm_destroy (struct shmid_kernel *shp)
+static void shm_destroy (struct ipc_shm_context *context,
+			 struct shmid_kernel *shp)
 {
-	shm_tot -= (shp->shm_segsz + PAGE_SIZE - 1) >> PAGE_SHIFT;
-	shm_rmid (shp->id);
-	shm_unlock(shp);
+	context->tot -= (shp->shm_segsz + PAGE_SIZE - 1) >> PAGE_SHIFT;
+	shm_rmid (context, shp->id);
+	shm_unlock(context, shp);
 	if (!is_file_hugepages(shp->shm_file))
 		shmem_lock(shp->shm_file, 0, shp->mlock_user);
 	else
@@ -138,30 +143,39 @@ static void shm_close (struct vm_area_st
 	struct file * file = shmd->vm_file;
 	int id = file->f_dentry->d_inode->i_ino;
 	struct shmid_kernel *shp;
+	struct ipc_shm_context *context = shmd->vm_private_data;
 
-	down (&shm_ids.sem);
+	down (&context->ids.sem);
 	/* remove from the list of attaches of the shm segment */
-	if(!(shp = shm_lock(id)))
+	if(!(shp = shm_lock(context, id)))
 		BUG();
 	shp->shm_lprid = current->tgid;
 	shp->shm_dtim = get_seconds();
 	shp->shm_nattch--;
 	if(shp->shm_nattch == 0 &&
 	   shp->shm_perm.mode & SHM_DEST)
-		shm_destroy (shp);
+		shm_destroy (context, shp);
 	else
-		shm_unlock(shp);
-	up (&shm_ids.sem);
+		shm_unlock(context, shp);
+	up (&context->ids.sem);
 }
 
 static int shm_mmap(struct file * file, struct vm_area_struct * vma)
 {
 	int ret;
+	struct ipc_shm_context *context = current->ipc_shm_context;
 
 	ret = shmem_mmap(file, vma);
 	if (ret == 0) {
 		vma->vm_ops = &shm_vm_ops;
-		shm_inc(file->f_dentry->d_inode->i_ino);
+		/*
+		 * This implies that the shm context can not change
+		 * while a task is running because this mmap's
+		 * context would change underneath it.
+		 * -- You many only change shm context at exec()
+		 */
+		vma->vm_private_data = context;
+		shm_inc(context, file->f_dentry->d_inode->i_ino);
 	}
 
 	return ret;
@@ -184,7 +198,8 @@ static struct vm_operations_struct shm_v
 #endif
 };
 
-static int newseg (key_t key, int shmflg, size_t size)
+static int newseg (struct ipc_shm_context *context,
+		   key_t key, int shmflg, size_t size)
 {
 	int error;
 	struct shmid_kernel *shp;
@@ -196,7 +211,7 @@ static int newseg (key_t key, int shmflg
 	if (size < SHMMIN || size > shm_ctlmax)
 		return -EINVAL;
 
-	if (shm_tot + numpages >= shm_ctlall)
+	if (context->tot + numpages >= shm_ctlall)
 		return -ENOSPC;
 
 	shp = ipc_rcu_alloc(sizeof(*shp));
@@ -235,7 +250,7 @@ static int newseg (key_t key, int shmflg
 		goto no_file;
 
 	error = -ENOSPC;
-	id = shm_addid(shp);
+	id = shm_addid(context, shp);
 	if(id == -1) 
 		goto no_id;
 
@@ -245,7 +260,7 @@ static int newseg (key_t key, int shmflg
 	shp->shm_ctim = get_seconds();
 	shp->shm_segsz = size;
 	shp->shm_nattch = 0;
-	shp->id = shm_buildid(id,shp->shm_perm.seq);
+	shp->id = shm_buildid(context, id,shp->shm_perm.seq);
 	shp->shm_file = file;
 	file->f_dentry->d_inode->i_ino = shp->id;
 
@@ -253,8 +268,8 @@ static int newseg (key_t key, int shmflg
 	if (!(shmflg & SHM_HUGETLB))
 		file->f_op = &shm_file_operations;
 
-	shm_tot += numpages;
-	shm_unlock(shp);
+	context->tot += numpages;
+	shm_unlock(context, shp);
 	return shp->id;
 
 no_id:
@@ -269,19 +284,20 @@ asmlinkage long sys_shmget (key_t key, s
 {
 	struct shmid_kernel *shp;
 	int err, id = 0;
+	struct ipc_shm_context *context = current->ipc_shm_context;
 
-	down(&shm_ids.sem);
+	down(&context->ids.sem);
 	if (key == IPC_PRIVATE) {
-		err = newseg(key, shmflg, size);
-	} else if ((id = ipc_findkey(&shm_ids, key)) == -1) {
+		err = newseg(context, key, shmflg, size);
+	} else if ((id = ipc_findkey(&context->ids, key)) == -1) {
 		if (!(shmflg & IPC_CREAT))
 			err = -ENOENT;
 		else
-			err = newseg(key, shmflg, size);
+			err = newseg(context, key, shmflg, size);
 	} else if ((shmflg & IPC_CREAT) && (shmflg & IPC_EXCL)) {
 		err = -EEXIST;
 	} else {
-		shp = shm_lock(id);
+		shp = shm_lock(context, id);
 		if(shp==NULL)
 			BUG();
 		if (shp->shm_segsz < size)
@@ -289,14 +305,14 @@ asmlinkage long sys_shmget (key_t key, s
 		else if (ipcperms(&shp->shm_perm, shmflg))
 			err = -EACCES;
 		else {
-			int shmid = shm_buildid(id, shp->shm_perm.seq);
+			int shmid = shm_buildid(context, id, shp->shm_perm.seq);
 			err = security_shm_associate(shp, shmflg);
 			if (!err)
 				err = shmid;
 		}
-		shm_unlock(shp);
+		shm_unlock(context, shp);
 	}
-	up(&shm_ids.sem);
+	up(&context->ids.sem);
 
 	return err;
 }
@@ -392,18 +408,19 @@ static inline unsigned long copy_shminfo
 	}
 }
 
-static void shm_get_stat(unsigned long *rss, unsigned long *swp) 
+static void shm_get_stat(struct ipc_shm_context *context,
+			 unsigned long *rss, unsigned long *swp)
 {
 	int i;
 
 	*rss = 0;
 	*swp = 0;
 
-	for (i = 0; i <= shm_ids.max_id; i++) {
+	for (i = 0; i <= context->ids.max_id; i++) {
 		struct shmid_kernel *shp;
 		struct inode *inode;
 
-		shp = shm_get(i);
+		shp = shm_get(context, i);
 		if(!shp)
 			continue;
 
@@ -427,6 +444,7 @@ asmlinkage long sys_shmctl (int shmid, i
 	struct shm_setbuf setbuf;
 	struct shmid_kernel *shp;
 	int err, version;
+	struct ipc_shm_context *context = current->ipc_shm_context;
 
 	if (cmd < 0 || shmid < 0) {
 		err = -EINVAL;
@@ -453,7 +471,7 @@ asmlinkage long sys_shmctl (int shmid, i
 		if(copy_shminfo_to_user (buf, &shminfo, version))
 			return -EFAULT;
 		/* reading a integer is always atomic */
-		err= shm_ids.max_id;
+		err= context->ids.max_id;
 		if(err<0)
 			err = 0;
 		goto out;
@@ -467,14 +485,14 @@ asmlinkage long sys_shmctl (int shmid, i
 			return err;
 
 		memset(&shm_info,0,sizeof(shm_info));
-		down(&shm_ids.sem);
-		shm_info.used_ids = shm_ids.in_use;
-		shm_get_stat (&shm_info.shm_rss, &shm_info.shm_swp);
-		shm_info.shm_tot = shm_tot;
+		down(&context->ids.sem);
+		shm_info.used_ids = context->ids.in_use;
+		shm_get_stat (context, &shm_info.shm_rss, &shm_info.shm_swp);
+		shm_info.shm_tot = context->tot;
 		shm_info.swap_attempts = 0;
 		shm_info.swap_successes = 0;
-		err = shm_ids.max_id;
-		up(&shm_ids.sem);
+		err = context->ids.max_id;
+		up(&context->ids.sem);
 		if(copy_to_user (buf, &shm_info, sizeof(shm_info))) {
 			err = -EFAULT;
 			goto out;
@@ -489,17 +507,17 @@ asmlinkage long sys_shmctl (int shmid, i
 		struct shmid64_ds tbuf;
 		int result;
 		memset(&tbuf, 0, sizeof(tbuf));
-		shp = shm_lock(shmid);
+		shp = shm_lock(context, shmid);
 		if(shp==NULL) {
 			err = -EINVAL;
 			goto out;
 		} else if(cmd==SHM_STAT) {
 			err = -EINVAL;
-			if (shmid > shm_ids.max_id)
+			if (shmid > context->ids.max_id)
 				goto out_unlock;
-			result = shm_buildid(shmid, shp->shm_perm.seq);
+			result = shm_buildid(context, shmid, shp->shm_perm.seq);
 		} else {
-			err = shm_checkid(shp,shmid);
+			err = shm_checkid(context,shp,shmid);
 			if(err)
 				goto out_unlock;
 			result = 0;
@@ -521,7 +539,7 @@ asmlinkage long sys_shmctl (int shmid, i
 			tbuf.shm_nattch	= shp->shm_nattch;
 		else
 			tbuf.shm_nattch = file_count(shp->shm_file) - 1;
-		shm_unlock(shp);
+		shm_unlock(context, shp);
 		if(copy_shmid_to_user (buf, &tbuf, version))
 			err = -EFAULT;
 		else
@@ -531,12 +549,12 @@ asmlinkage long sys_shmctl (int shmid, i
 	case SHM_LOCK:
 	case SHM_UNLOCK:
 	{
-		shp = shm_lock(shmid);
+		shp = shm_lock(context, shmid);
 		if(shp==NULL) {
 			err = -EINVAL;
 			goto out;
 		}
-		err = shm_checkid(shp,shmid);
+		err = shm_checkid(context,shp,shmid);
 		if(err)
 			goto out_unlock;
 
@@ -568,7 +586,7 @@ asmlinkage long sys_shmctl (int shmid, i
 			shp->shm_perm.mode &= ~SHM_LOCKED;
 			shp->mlock_user = NULL;
 		}
-		shm_unlock(shp);
+		shm_unlock(context, shp);
 		goto out;
 	}
 	case IPC_RMID:
@@ -583,12 +601,12 @@ asmlinkage long sys_shmctl (int shmid, i
 		 *	Instead we set a destroyed flag, and then blow
 		 *	the name away when the usage hits zero.
 		 */
-		down(&shm_ids.sem);
-		shp = shm_lock(shmid);
+		down(&context->ids.sem);
+		shp = shm_lock(context, shmid);
 		err = -EINVAL;
 		if (shp == NULL) 
 			goto out_up;
-		err = shm_checkid(shp, shmid);
+		err = shm_checkid(context, shp, shmid);
 		if(err)
 			goto out_unlock_up;
 
@@ -607,10 +625,10 @@ asmlinkage long sys_shmctl (int shmid, i
 			shp->shm_perm.mode |= SHM_DEST;
 			/* Do not find it any more */
 			shp->shm_perm.key = IPC_PRIVATE;
-			shm_unlock(shp);
+			shm_unlock(context, shp);
 		} else
-			shm_destroy (shp);
-		up(&shm_ids.sem);
+			shm_destroy (context, shp);
+		up(&context->ids.sem);
 		goto out;
 	}
 
@@ -622,12 +640,12 @@ asmlinkage long sys_shmctl (int shmid, i
 		}
 		if ((err = audit_ipc_perms(0, setbuf.uid, setbuf.gid, setbuf.mode)))
 			return err;
-		down(&shm_ids.sem);
-		shp = shm_lock(shmid);
+		down(&context->ids.sem);
+		shp = shm_lock(context, shmid);
 		err=-EINVAL;
 		if(shp==NULL)
 			goto out_up;
-		err = shm_checkid(shp,shmid);
+		err = shm_checkid(context,shp,shmid);
 		if(err)
 			goto out_unlock_up;
 		err=-EPERM;
@@ -656,12 +674,12 @@ asmlinkage long sys_shmctl (int shmid, i
 
 	err = 0;
 out_unlock_up:
-	shm_unlock(shp);
+	shm_unlock(context, shp);
 out_up:
-	up(&shm_ids.sem);
+	up(&context->ids.sem);
 	goto out;
 out_unlock:
-	shm_unlock(shp);
+	shm_unlock(context, shp);
 out:
 	return err;
 }
@@ -675,6 +693,7 @@ out:
  */
 long do_shmat(int shmid, char __user *shmaddr, int shmflg, ulong *raddr)
 {
+	struct ipc_shm_context *context = current->ipc_shm_context;
 	struct shmid_kernel *shp;
 	unsigned long addr;
 	unsigned long size;
@@ -725,32 +744,32 @@ long do_shmat(int shmid, char __user *sh
 	 * We cannot rely on the fs check since SYSV IPC does have an
 	 * additional creator id...
 	 */
-	shp = shm_lock(shmid);
+	shp = shm_lock(context, shmid);
 	if(shp == NULL) {
 		err = -EINVAL;
 		goto out;
 	}
-	err = shm_checkid(shp,shmid);
+	err = shm_checkid(context,shp,shmid);
 	if (err) {
-		shm_unlock(shp);
+		shm_unlock(context, shp);
 		goto out;
 	}
 	if (ipcperms(&shp->shm_perm, acc_mode)) {
-		shm_unlock(shp);
+		shm_unlock(context, shp);
 		err = -EACCES;
 		goto out;
 	}
 
 	err = security_shm_shmat(shp, shmaddr, shmflg);
 	if (err) {
-		shm_unlock(shp);
+		shm_unlock(context, shp);
 		return err;
 	}
 		
 	file = shp->shm_file;
 	size = i_size_read(file->f_dentry->d_inode);
 	shp->shm_nattch++;
-	shm_unlock(shp);
+	shm_unlock(context, shp);
 
 	down_write(&current->mm->mmap_sem);
 	if (addr && !(shmflg & SHM_REMAP)) {
@@ -771,16 +790,16 @@ long do_shmat(int shmid, char __user *sh
 invalid:
 	up_write(&current->mm->mmap_sem);
 
-	down (&shm_ids.sem);
-	if(!(shp = shm_lock(shmid)))
+	down (&context->ids.sem);
+	if(!(shp = shm_lock(context, shmid)))
 		BUG();
 	shp->shm_nattch--;
 	if(shp->shm_nattch == 0 &&
 	   shp->shm_perm.mode & SHM_DEST)
-		shm_destroy (shp);
+		shm_destroy (context, shp);
 	else
-		shm_unlock(shp);
-	up (&shm_ids.sem);
+		shm_unlock(context, shp);
+	up (&context->ids.sem);
 
 	*raddr = (unsigned long) user_addr;
 	err = 0;
diff -puN ipc/util.c~sysvshm-container ipc/util.c
--- work/ipc/util.c~sysvshm-container	2006-03-06 15:41:59.000000000 -0800
+++ work-dave/ipc/util.c	2006-03-06 15:41:59.000000000 -0800
@@ -46,6 +46,7 @@ struct ipc_proc_iface {
  *	memory are initialised
  */
 
+struct ipc_shm_context *ipc_shm_context;
 static int __init ipc_init(void)
 {
 	init_task.ipc_context = kzalloc(sizeof(*ipc_context), GFP_KERNEL);
@@ -54,7 +55,7 @@ static int __init ipc_init(void)
 
 	sem_init(&init_task.ipc_context->sem);
 	msg_init(&init_task.ipc_context->msg);
-	shm_init();
+	shm_init(&init_task.ipc_context->shm);
 	return 0;
 }
 __initcall(ipc_init);
diff -puN ipc/util.h~sysvshm-container ipc/util.h
--- work/ipc/util.h~sysvshm-container	2006-03-06 15:41:59.000000000 -0800
+++ work-dave/ipc/util.h	2006-03-06 15:41:59.000000000 -0800
@@ -44,14 +44,21 @@ struct ipc_sem_context {
 	int nr_used;
 };
 
+struct ipc_shm_context {
+	struct ipc_ids ids;
+
+	int tot; /* total number of shared memory pages */
+};
+
 struct ipc_context {
 	struct ipc_msg_context msg;
 	struct ipc_sem_context sem;
+	struct ipc_shm_context shm;
 };
 
 void sem_init (struct ipc_sem_context *context);
 void msg_init (struct ipc_msg_context *context);
-void shm_init (void);
+void shm_init (struct ipc_shm_context *context);
 
 struct seq_file;
 void __init ipc_init_ids(struct ipc_ids* ids, int size);
_
