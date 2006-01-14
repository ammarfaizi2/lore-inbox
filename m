Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1945910AbWANBAH@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1945910AbWANBAH (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 13 Jan 2006 20:00:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1945911AbWANBAH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 13 Jan 2006 20:00:07 -0500
Received: from [63.81.120.158] ([63.81.120.158]:51951 "EHLO hermes.mvista.com")
	by vger.kernel.org with ESMTP id S1945910AbWANBAF (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 13 Jan 2006 20:00:05 -0500
Message-ID: <43C84D4B.70407@mvista.com>
Date: Fri, 13 Jan 2006 17:00:59 -0800
From: David Singleton <dsingleton@mvista.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.8) Gecko/20050513 Fedora/1.7.8-2
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: akpm@osdl.org, linux-kernel@vger.kernel.org
Cc: mingo@elte.hu, drepper@gmail.com
Subject: [robust-futex-1] futex: robust futex support
Content-Type: multipart/mixed;
 boundary="------------040408030600020101000104"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------040408030600020101000104
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

Andrew,

      


--------------040408030600020101000104
Content-Type: text/plain;
 name="robust-futex-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="robust-futex-1"

Signed-off-by: David Singleton <dsingleton@mvista.com>

	The original code for this patch was supplied by Todd Kneisel.

	Robust futexes provide a locking mechanism that can be shared between
	user mode processes. The major difference between robust futexes and
	regular futexes is that when the owner of a robust futex dies, the
	next task waiting on the futex will be awakened, will get ownership
	of the futex lock, and will receive the error status EOWNERDEAD.

	Robust futexes allow the system to gracefuly continue if an application
	dies while holding a futex, without leaving waiting threads hung or
	requiring the system to be rebooted to clear the hang.

	Robust futexes are structures hung on a linked list on the inode.
	The list is scanned at exit time to find any futexes still held
	by the dying thread.  The structures backing the futex are removed
	when a dentry reference count drops to zero.  The exit path cleans
	up and locked futexes and the dentry reference count handles cleaning
	up robust futex resources.

	This implimentation supports shared pthread_mutexes, pthread_mutexes
	mmapped either in a file or in mmapped anonymous memory.

	Ulrich Drepper has a glibc that handles non-shared (malloc'd
	pthread_mutexes) all in user space.  This patch returns
	-ENOTSHARED from register futex if it is not a shared futex so his
	glibc can handle the non-shared pthread_mutexes without kernel support.

	The structure for robustness has its own slab cache, making
	it easy track how many robust futexes are in the system through
	/proc/slabinfo.
	
	Robust futexes have been tested fairly well in the community using
	realtime-preempt patch, which supports both robust and priority 
	inheriting pthread_mutexes.  There is a simple test suite, originally
	also supplied by Todd Kneisel, that tests basic robustness using
	regular futexes that have robust attribute applied.  They've also
	been tested using the fusyn posix test suite, with minor modifications
	to make the fusyn tests run with the NPTL libraries.


 fs/dcache.c                 |    2 
 fs/inode.c                  |    4 
 include/asm-generic/errno.h |    1 
 include/linux/fs.h          |    2 
 include/linux/futex.h       |   33 +++
 init/Kconfig                |    9 
 kernel/exit.c               |    2 
 kernel/futex.c              |  426 +++++++++++++++++++++++++++++++++++++++++++-
 8 files changed, 471 insertions(+), 8 deletions(-)

Index: linux-2.6.15/fs/dcache.c
===================================================================
--- linux-2.6.15.orig/fs/dcache.c
+++ linux-2.6.15/fs/dcache.c
@@ -33,6 +33,7 @@
 #include <linux/seqlock.h>
 #include <linux/swap.h>
 #include <linux/bootmem.h>
+#include <linux/futex.h>
 
 /* #define DCACHE_DEBUG 1 */
 
@@ -161,6 +162,7 @@ repeat:
 		return;
 	}
 
+	futex_free_robust_list(dentry->d_inode);
 	/*
 	 * AV: ->d_delete() is _NOT_ allowed to block now.
 	 */
Index: linux-2.6.15/fs/inode.c
===================================================================
--- linux-2.6.15.orig/fs/inode.c
+++ linux-2.6.15/fs/inode.c
@@ -23,6 +23,7 @@
 #include <linux/bootmem.h>
 #include <linux/inotify.h>
 #include <linux/mount.h>
+#include <linux/futex.h>
 
 /*
  * This is needed for the following functions:
@@ -208,6 +209,9 @@ void inode_init_once(struct inode *inode
 	INIT_LIST_HEAD(&inode->inotify_watches);
 	sema_init(&inode->inotify_sem, 1);
 #endif
+#ifdef CONFIG_ROBUST_FUTEX
+	futex_init_inode(inode);
+#endif
 }
 
 EXPORT_SYMBOL(inode_init_once);
Index: linux-2.6.15/include/linux/fs.h
===================================================================
--- linux-2.6.15.orig/include/linux/fs.h
+++ linux-2.6.15/include/linux/fs.h
@@ -383,6 +383,8 @@ struct address_space {
 	spinlock_t		private_lock;	/* for use by the address_space */
 	struct list_head	private_list;	/* ditto */
 	struct address_space	*assoc_mapping;	/* ditto */
+	struct list_head	robust_list;	/* list of robust futexes */
+	struct semaphore	robust_sem;	/* semaphore for robust */
 } __attribute__((aligned(sizeof(long))));
 	/*
 	 * On most architectures that alignment is already the case; but
Index: linux-2.6.15/include/linux/futex.h
===================================================================
--- linux-2.6.15.orig/include/linux/futex.h
+++ linux-2.6.15/include/linux/futex.h
@@ -10,6 +10,38 @@
 #define FUTEX_REQUEUE		3
 #define FUTEX_CMP_REQUEUE	4
 #define FUTEX_WAKE_OP		5
+#define FUTEX_REGISTER          6
+#define FUTEX_DEREGISTER        7
+#define FUTEX_RECOVER           8
+
+#ifdef __KERNEL__
+
+#ifdef CONFIG_ROBUST_FUTEX
+
+#define FUTEX_WAITERS				0x80000000
+#define FUTEX_OWNER_DIED			0x40000000
+#define FUTEX_NOT_RECOVERABLE			0x20000000
+#define FUTEX_FLAGS (FUTEX_WAITERS | FUTEX_OWNER_DIED | FUTEX_NOT_RECOVERABLE)
+#define FUTEX_PID                             ~(FUTEX_FLAGS)
+
+#define FUTEX_ATTR_SHARED                       0x10000000
+
+/*
+ * Used to track registered robust futexes. Attached to linked list in inodes.
+ */
+static inline void futex_init_inode(struct inode *inode)
+{
+        INIT_LIST_HEAD(&inode->i_data.robust_list);
+        init_MUTEX(&inode->i_data.robust_sem);
+}
+
+extern void futex_free_robust_list(struct inode *inode);
+extern void exit_futex(struct task_struct *tsk);
+#else
+# define futex_free_robust_list(a)      do { } while (0)
+# define exit_futex(b)                  do { } while (0)
+#define futex_init_inode(a) 		do { } while (0)
+#endif
 
 long do_futex(unsigned long uaddr, int op, int val,
 		unsigned long timeout, unsigned long uaddr2, int val2,
@@ -41,3 +73,4 @@ long do_futex(unsigned long uaddr, int o
    | ((oparg & 0xfff) << 12) | (cmparg & 0xfff))
 
 #endif
+#endif
Index: linux-2.6.15/kernel/exit.c
===================================================================
--- linux-2.6.15.orig/kernel/exit.c
+++ linux-2.6.15/kernel/exit.c
@@ -31,6 +31,7 @@
 #include <linux/signal.h>
 #include <linux/cn_proc.h>
 #include <linux/mutex.h>
+#include <linux/futex.h>
 
 #include <asm/uaccess.h>
 #include <asm/unistd.h>
@@ -847,6 +848,7 @@ fastcall NORET_TYPE void do_exit(long co
 		exit_itimers(tsk->signal);
 		acct_process(code);
 	}
+	exit_futex(tsk);
 	exit_mm(tsk);
 
 	exit_sem(tsk);
Index: linux-2.6.15/kernel/futex.c
===================================================================
--- linux-2.6.15.orig/kernel/futex.c
+++ linux-2.6.15/kernel/futex.c
@@ -8,6 +8,9 @@
  *  Removed page pinning, fix privately mapped COW pages and other cleanups
  *  (C) Copyright 2003, 2004 Jamie Lokier
  *
+ *  Robust futexes added by Todd Kneisel
+ *  (C) Copyright 2005, Bull HN.
+ *
  *  Thanks to Ben LaHaise for yelling "hashed waitqueues" loudly
  *  enough at me, Linus for the original (flawed) idea, Matthew
  *  Kirkwood for proof-of-concept implementation.
@@ -107,6 +110,9 @@ static struct futex_hash_bucket futex_qu
 /* Futex-fs vfsmount entry: */
 static struct vfsmount *futex_mnt;
 
+#ifdef CONFIG_ROBUST_FUTEX
+static kmem_cache_t *robust_futex_cachep;
+#endif
 /*
  * We hash on the keys returned from get_futex_key (see below).
  */
@@ -140,7 +146,8 @@ static inline int match_futex(union fute
  *
  * Should be called with &current->mm->mmap_sem but NOT any spinlocks.
  */
-static int get_futex_key(unsigned long uaddr, union futex_key *key)
+static int get_futex_key(unsigned long uaddr, union futex_key *key,
+			struct list_head **list, struct semaphore **sem)
 {
 	struct mm_struct *mm = current->mm;
 	struct vm_area_struct *vma;
@@ -163,6 +170,14 @@ static int get_futex_key(unsigned long u
 	if (unlikely(!vma))
 		return -EFAULT;
 
+	if (vma->vm_file && vma->vm_file->f_mapping) {
+		*list = &vma->vm_file->f_mapping->robust_list;
+		*sem = &vma->vm_file->f_mapping->robust_sem;
+	} else {
+		*sem = NULL;
+		*list = NULL;
+	}
+
 	/*
 	 * Permissions.
 	 */
@@ -290,11 +305,12 @@ static int futex_wake(unsigned long uadd
 	struct futex_hash_bucket *bh;
 	struct list_head *head;
 	struct futex_q *this, *next;
+	struct semaphore *sem;
 	int ret;
 
 	down_read(&current->mm->mmap_sem);
 
-	ret = get_futex_key(uaddr, &key);
+	ret = get_futex_key(uaddr, &key, &head, &sem);
 	if (unlikely(ret != 0))
 		goto out;
 
@@ -325,16 +341,17 @@ static int futex_wake_op(unsigned long u
 	union futex_key key1, key2;
 	struct futex_hash_bucket *bh1, *bh2;
 	struct list_head *head;
+	struct semaphore *sem;
 	struct futex_q *this, *next;
 	int ret, op_ret, attempt = 0;
 
 retryfull:
 	down_read(&current->mm->mmap_sem);
 
-	ret = get_futex_key(uaddr1, &key1);
+	ret = get_futex_key(uaddr1, &key1, &head, &sem);
 	if (unlikely(ret != 0))
 		goto out;
-	ret = get_futex_key(uaddr2, &key2);
+	ret = get_futex_key(uaddr2, &key2, &head, &sem);
 	if (unlikely(ret != 0))
 		goto out;
 
@@ -450,16 +467,17 @@ static int futex_requeue(unsigned long u
 	union futex_key key1, key2;
 	struct futex_hash_bucket *bh1, *bh2;
 	struct list_head *head1;
+	struct semaphore *sem;
 	struct futex_q *this, *next;
 	int ret, drop_count = 0;
 
  retry:
 	down_read(&current->mm->mmap_sem);
 
-	ret = get_futex_key(uaddr1, &key1);
+	ret = get_futex_key(uaddr1, &key1, &head1, &sem);
 	if (unlikely(ret != 0))
 		goto out;
-	ret = get_futex_key(uaddr2, &key2);
+	ret = get_futex_key(uaddr2, &key2, &head1, &sem);
 	if (unlikely(ret != 0))
 		goto out;
 
@@ -624,11 +642,13 @@ static int futex_wait(unsigned long uadd
 	int ret, curval;
 	struct futex_q q;
 	struct futex_hash_bucket *bh;
+	struct list_head *head;
+	struct semaphore *sem;
 
  retry:
 	down_read(&current->mm->mmap_sem);
 
-	ret = get_futex_key(uaddr, &q.key);
+	ret = get_futex_key(uaddr, &q.key, &head, &sem);
 	if (unlikely(ret != 0))
 		goto out_release_sem;
 
@@ -766,6 +786,8 @@ static int futex_fd(unsigned long uaddr,
 {
 	struct futex_q *q;
 	struct file *filp;
+	struct list_head *head;
+	struct semaphore *sem;
 	int ret, err;
 
 	ret = -EINVAL;
@@ -801,7 +823,7 @@ static int futex_fd(unsigned long uaddr,
 	}
 
 	down_read(&current->mm->mmap_sem);
-	err = get_futex_key(uaddr, &q->key);
+	err = get_futex_key(uaddr, &q->key, &head, &sem);
 
 	if (unlikely(err != 0)) {
 		up_read(&current->mm->mmap_sem);
@@ -829,6 +851,380 @@ error:
 	goto out;
 }
 
+#ifdef CONFIG_ROBUST_FUTEX
+/*
+ * Robust futexes provide a locking mechanism that can be shared between
+ * user mode processes. The major difference between robust futexes and
+ * regular futexes is that when the owner of a robust futex dies, the
+ * next task waiting on the futex will be awakened, will get ownership
+ * of the futex lock, and will receive the error status EOWNERDEAD.
+ *
+ * A robust futex is a 32 bit integer stored in user mode shared memory.
+ * Bit 31 indicates that there are tasks waiting on the futex.
+ * Bit 30 indicates that the task that owned the futex has died.
+ * Bit 29 indicates that the futex is not recoverable and cannot be used.
+ * Bits 0-28 are the pid of the task that owns the futex lock, or zero if
+ * the futex is not locked.
+ */
+
+/*
+ * Used to track registered robust futexes. Attached to linked list in inodes.
+ */
+struct futex_robust {
+	struct list_head list;
+	union futex_key key;
+};
+
+/*
+ * there really isn't an atomic page fault, so we're going to
+ * put the burden on the user. If either futex_get_user or futex_put_user
+ * return -EFAULT, it really means it's avoiding a race condition
+ * and the user will have to try again.
+ */
+static int futex_put_user(int value, unsigned long uaddr)
+{
+	int ret = 0;
+
+	if ((put_user(value, (int __user *)uaddr)) != 0)
+		if ((put_user(value, (int __user *)uaddr)) != 0)
+			ret = -EFAULT;
+	return ret;
+}
+
+static int futex_get_user(unsigned long uaddr)
+{
+	int value = 0;
+
+	if (get_user(value, (int __user *)uaddr))
+		if (get_user(value, (int __user *)uaddr))
+			value = -EFAULT;
+	return value;
+}
+
+/**
+ * futex_free_robust_list - release the list of registered futexes.
+ * @inode: inode that may be a memory mapped file
+ *
+ * Called from dput() when a dentry reference count reaches zero.
+ * If the dentry is associated with a memory mapped file, then
+ * release the list of registered robust futexes that are contained
+ * in that mapping.
+ */
+void futex_free_robust_list(struct inode *inode)
+{
+	struct address_space *mapping;
+	struct list_head *head;
+ 	struct futex_robust *this, *next;
+
+	if (inode == NULL)
+		return;
+
+	mapping = inode->i_mapping;
+	if (mapping == NULL)
+		return;
+
+	if (list_empty(&mapping->robust_list))
+		return;
+
+	down(&mapping->robust_sem);
+
+	head = &mapping->robust_list;
+
+	list_for_each_entry_safe(this, next, head, list) {
+		list_del(&this->list);
+		kmem_cache_free(robust_futex_cachep, this);
+	}
+
+	up(&mapping->robust_sem);
+	return;
+}
+
+/**
+ * get_private_uaddr - convert a private futex_key to a user addr
+ * @key: the futex_key that identifies a futex.
+ *
+ * Private futex_keys identify a futex that is in non-shared memory.
+ * Robust futexes should never result in private futex_keys, but keep
+ * this code for completeness.
+ * Returns zero if futex is not contained in current task's mm
+ */
+static unsigned long get_private_uaddr(union futex_key *key)
+{
+	unsigned long uaddr = 0;
+
+	if (key->private.mm == current->mm)
+		uaddr = key->private.uaddr;
+	return uaddr;
+}
+
+/**
+ * get_shared_uaddr - convert a shared futex_key to a user addr.
+ * @key: a futex_key that identifies a futex.
+ * @vma: a vma that may contain the futex
+ *
+ * Shared futex_keys identify a futex that is contained in a vma,
+ * and so may be shared.
+ * Returns zero if futex is not contained in @vma
+ */
+static unsigned long get_shared_uaddr(union futex_key *key,
+				      struct vm_area_struct *vma)
+{
+	unsigned long uaddr = 0;
+	unsigned long tmpaddr;
+	struct address_space *mapping;
+
+	mapping = vma->vm_file->f_mapping;
+	if (key->shared.inode == mapping->host) {
+		tmpaddr = ((key->shared.pgoff - vma->vm_pgoff) << PAGE_SHIFT)
+				+ (key->shared.offset & ~0x1)
+				+ vma->vm_start;
+		if (tmpaddr >= vma->vm_start && tmpaddr < vma->vm_end)
+			uaddr = tmpaddr;
+	}
+
+	return uaddr;
+}
+
+/**
+ * get_futex_uaddr - convert a futex_key to a user addr.
+ * @key: futex_key that identifies a futex
+ * @vma: vma that may contain the futex
+ *
+ * Converts both shared and private futex_keys.
+ * Returns zero if futex is not contained in @vma or in the current
+ * task's mm.
+ */
+static unsigned long get_futex_uaddr(union futex_key *key,
+				     struct vm_area_struct *vma)
+{
+	unsigned long uaddr;
+
+	if ((key->both.offset & 0x1) == 0)
+		uaddr = get_private_uaddr(key);
+	else
+		uaddr = get_shared_uaddr(key,vma);
+
+	return uaddr;
+}
+
+/**
+ * find_owned_futex - find futexes owned by the current task
+ * @vma: the vma to search for futexes
+ * @head: list head for list of robust futexes
+ * @sem: semaphore that protects the list
+ *
+ * Walk the list of registered robust futexes for this @vma,
+ * setting the %FUTEX_OWNER_DIED flag on those futexes owned
+ * by the current, exiting task.
+ */
+static void find_owned_futex(struct vm_area_struct *vma, struct list_head *head,
+				struct semaphore *sem)
+{
+	struct futex_robust *this, *next;
+ 	unsigned long uaddr;
+	int value;
+
+	down(sem);
+
+	list_for_each_entry_safe(this, next, head, list) {
+
+		uaddr = get_futex_uaddr(&this->key, vma);
+		if (uaddr == 0)
+			continue;
+
+		up(sem);
+		up_read(&current->mm->mmap_sem);
+		value = futex_get_user(uaddr);
+		if ((value & FUTEX_PID) == current->pid) {
+			value |= FUTEX_OWNER_DIED;
+			futex_wake(uaddr, 1);
+			futex_put_user(value, uaddr);
+		}
+		down(sem);
+		down_read(&current->mm->mmap_sem);
+	}
+
+	up(sem);
+}
+
+/**
+ * exit_futex - futex processing when a task exits.
+ *
+ * Called from do_exit() when a task exits. Mark all robust futexes
+ * that are owned by the current terminating task as %FUTEX_OWNER_DIED.
+ */
+
+void exit_futex(struct task_struct *tsk)
+{
+	struct mm_struct *mm;
+	struct vm_area_struct *vma;
+	struct list_head *robust;
+	struct semaphore *sem;
+
+	if (tsk==NULL)
+		return;
+
+	mm = current->mm;
+	if (mm==NULL)
+		return;
+
+	down_read(&mm->mmap_sem);
+
+	for (vma = mm->mmap; vma != NULL; vma = vma->vm_next) {
+		if (vma->vm_file == NULL)
+			continue;
+
+		if (vma->vm_file->f_mapping == NULL)
+			continue;
+
+		robust = &vma->vm_file->f_mapping->robust_list;
+		sem = &vma->vm_file->f_mapping->robust_sem;
+		if (list_empty(robust))
+			continue;
+
+		find_owned_futex(vma, robust, sem);
+	}
+
+	up_read(&mm->mmap_sem);
+}
+
+/**
+ * futex_register - Record the existence of a robust futex in a vma.
+ * @uaddr: user space address of the robust futex
+ *
+ * Called from user space (through sys_futex syscall) when a robust
+ * futex is created. Looks up the vma that contains the futex and
+ * adds an entry to the list of all robust futexes in the vma.
+ */
+static int futex_register(unsigned long uaddr, unsigned int attr)
+{
+	int ret;
+	struct futex_robust *robust;
+	struct mm_struct *mm = current->mm;
+	struct vm_area_struct *vma;
+	struct list_head *head = NULL;
+	struct semaphore *sem = NULL;
+
+	if ((attr & FUTEX_ATTR_SHARED) == 0)
+		return -ENOTSHARED;
+
+	robust = kmem_cache_alloc(robust_futex_cachep, GFP_KERNEL);
+	if (!robust) {
+		ret = -ENOMEM;
+		goto out;
+	}
+
+	down_read(&current->mm->mmap_sem);
+
+	ret = get_futex_key(uaddr, &robust->key, &head, &sem);
+	if (unlikely(ret != 0))	{
+		kmem_cache_free(robust_futex_cachep, robust);
+		goto out_unlock;
+	}
+
+	vma = find_extend_vma(mm, uaddr);
+	if (unlikely(!vma)) {
+		ret = -EFAULT;
+		kmem_cache_free(robust_futex_cachep, robust);
+		goto out_unlock;
+	}
+
+	if (vma->vm_file && vma->vm_file->f_mapping) {
+		head = &vma->vm_file->f_mapping->robust_list;
+		sem = &vma->vm_file->f_mapping->robust_sem;
+	} else {
+		ret = -ENOTSHARED;
+		kmem_cache_free(robust_futex_cachep, robust);
+		goto out_unlock;
+	}
+
+	down(sem);
+	list_add_tail(&robust->list, head);
+	up(sem);
+
+out_unlock:
+	up_read(&current->mm->mmap_sem);
+out:
+	return ret;
+}
+
+/**
+ * futex_deregister - Delete robust futex registration from a vma
+ * @uaddr: user space address of the robust futex
+ *
+ * Called from user space (through sys_futex syscall) when a robust
+ * futex is destroyed. Looks up the vma that contains the futex and
+ * removes the futex entry from the list of all robust futexes in
+ * the vma.
+ */
+static int futex_deregister(unsigned long uaddr)
+{
+	union futex_key key;
+	struct mm_struct *mm = current->mm;
+	struct list_head *head = NULL;
+	struct semaphore *sem = NULL;
+	struct futex_robust *this, *next;
+	int ret;
+
+	down_read(&mm->mmap_sem);
+
+	ret = get_futex_key(uaddr, &key, &head, &sem);
+	if (unlikely(ret != 0))
+		goto out;
+	if (head == NULL) {
+		ret = -EINVAL;
+		goto out;
+	}
+
+	down(sem);
+
+	list_for_each_entry_safe(this, next, head, list) {
+		if (match_futex (&this->key, &key)) {
+			futex_wake(uaddr, 1);
+			list_del(&this->list);
+			kmem_cache_free(robust_futex_cachep, this);
+			break;
+		}
+	}
+
+	up(sem);
+out:
+	up_read(&mm->mmap_sem);
+	return ret;
+}
+
+/**
+ * futex_recover - Recover a futex after its owner died
+ * @uaddr: user space address of the robust futex
+ *
+ * Called from user space (through sys_futex syscall).
+ * When a task dies while owning a robust futex, the futex is
+ * marked with %FUTEX_OWNER_DIED and ownership is transferred
+ * to the next waiting task. That task can choose to restore
+ * the futex to a useful state by calling this function.
+ */
+static int futex_recover(unsigned long uaddr)
+{
+	int ret = 0;
+	int value = 0;
+	union futex_key key;
+	struct list_head *head = NULL;
+	struct semaphore *sem = NULL;
+
+	down_read(&current->mm->mmap_sem);
+	ret = get_futex_key(uaddr, &key, &head, &sem);
+	up_read(&current->mm->mmap_sem);
+	if (ret != 0)
+		return ret;
+
+	if ((value = futex_get_user(uaddr)) == -EFAULT)
+		return ret;
+
+	value &= ~FUTEX_OWNER_DIED;
+	return futex_put_user(value, uaddr);
+}
+#endif
+
 long do_futex(unsigned long uaddr, int op, int val, unsigned long timeout,
 		unsigned long uaddr2, int val2, int val3)
 {
@@ -854,6 +1250,17 @@ long do_futex(unsigned long uaddr, int o
 	case FUTEX_WAKE_OP:
 		ret = futex_wake_op(uaddr, uaddr2, val, val2, val3);
 		break;
+#ifdef CONFIG_ROBUST_FUTEX
+	case FUTEX_REGISTER:
+		ret = futex_register(uaddr, val);
+		break;
+	case FUTEX_DEREGISTER:
+		ret = futex_deregister(uaddr);
+		break;
+	case FUTEX_RECOVER:
+		ret = futex_recover(uaddr);
+		break;
+#endif
 	default:
 		ret = -ENOSYS;
 	}
@@ -901,6 +1308,9 @@ static int __init init(void)
 {
 	unsigned int i;
 
+#ifdef CONFIG_ROBUST_FUTEX
+	robust_futex_cachep = kmem_cache_create("robust_futex", sizeof(struct futex_robust), 0, 0, NULL, NULL);
+#endif
 	register_filesystem(&futex_fs_type);
 	futex_mnt = kern_mount(&futex_fs_type);
 
Index: linux-2.6.15/init/Kconfig
===================================================================
--- linux-2.6.15.orig/init/Kconfig
+++ linux-2.6.15/init/Kconfig
@@ -348,6 +348,15 @@ config FUTEX
 	  support for "fast userspace mutexes".  The resulting kernel may not
 	  run glibc-based applications correctly.
 
+config ROBUST_FUTEX
+	bool "Enable robust futex support"
+	depends on FUTEX
+	default y
+	help
+	  Enable this option if you want to use robust user space mutexes.
+	  Enabling this option slows down the exit path of the kernel for
+	  all processes.  Robust futexes will run glibc-based applications correctly.
+
 config EPOLL
 	bool "Enable eventpoll support" if EMBEDDED
 	default y
Index: linux-2.6.15/include/asm-generic/errno.h
===================================================================
--- linux-2.6.15.orig/include/asm-generic/errno.h
+++ linux-2.6.15/include/asm-generic/errno.h
@@ -105,5 +105,6 @@
 /* for robust mutexes */
 #define	EOWNERDEAD	130	/* Owner died */
 #define	ENOTRECOVERABLE	131	/* State not recoverable */
+#define ENOTSHARED	132	/* no pshared attribute */
 
 #endif

--------------040408030600020101000104--
