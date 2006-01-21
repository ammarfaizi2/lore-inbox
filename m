Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750790AbWAUCaY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750790AbWAUCaY (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 20 Jan 2006 21:30:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750793AbWAUCaY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 20 Jan 2006 21:30:24 -0500
Received: from gateway-1237.mvista.com ([63.81.120.158]:21239 "EHLO
	hermes.mvista.com") by vger.kernel.org with ESMTP id S1750790AbWAUCaX
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 20 Jan 2006 21:30:23 -0500
In-Reply-To: <20060120141801.71d842f7.akpm@osdl.org>
References: <43C84D4B.70407@mvista.com> <F3EB614C-8892-11DA-AF83-000A959BB91E@mvista.com> <20060118212256.1553b0ec.akpm@osdl.org> <200601201841.24565.ioe-lkml@rameria.de> <20060120141801.71d842f7.akpm@osdl.org>
Mime-Version: 1.0 (Apple Message framework v619)
Content-Type: multipart/mixed; boundary=Apple-Mail-2-589630603
Message-Id: <DE0F3C2E-8A25-11DA-8977-000A959BB91E@mvista.com>
Cc: Ingo Oeser <ioe-lkml@rameria.de>, mingo@elte.hu,
       linux-kernel@vger.kernel.org, drepper@gmail.com
From: david singleton <dsingleton@mvista.com>
Subject: Re: [robust-futex-4] futex: robust futex support
Date: Fri, 20 Jan 2006 18:30:20 -0800
To: Andrew Morton <akpm@osdl.org>
X-Mailer: Apple Mail (2.619)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--Apple-Mail-2-589630603
Content-Transfer-Encoding: 7bit
Content-Type: text/plain;
	charset=US-ASCII;
	format=flowed


On Jan 20, 2006, at 2:18 PM, Andrew Morton wrote:

> Ingo Oeser <ioe-lkml@rameria.de> wrote:
>>
>>>> +	list_for_each_entry_safe(this, next, head, list) {
>>>> +		list_del(&this->list);
>>>> +		kmem_cache_free(robust_futex_cachep, this);
>>>> +	}
>>>
>>> If we're throwing away the entire contents of the list, there's no 
>>> need to
>>> detach items as we go.
>>
>> Couldn't even detach the list elements first by
>>
>> list_splice_init(&mapping->robust_head->robust_list, head);
>>
>> and free the list from "head" after releasing the mutex?
>> This would reduce lock contention, no?
>
> Yes, it would reduce lock contention nicely.
>

         Incorporated changes suggested by Andrew Morton and Ingo Oeser.

  fs/inode.c            |    2
  include/linux/fs.h    |    4
  include/linux/futex.h |   33 ++++
  init/Kconfig          |    9 +
  kernel/exit.c         |    2
  kernel/futex.c        |  399 
++++++++++++++++++++++++++++++++++++++++++++++++++
  6 files changed, 449 insertions(+)



David




--Apple-Mail-2-589630603
Content-Transfer-Encoding: 7bit
Content-Type: application/octet-stream;
	x-unix-mode=0644;
	name="robust-futex-6"
Content-Disposition: attachment;
	filename=robust-futex-6

Signed-off-by: David Singleton <dsingleton@mvista.com>

	Incorporated changes suggested by Andrew Morton and Ingo Oeser.

 fs/inode.c            |    2 
 include/linux/fs.h    |    4 
 include/linux/futex.h |   33 ++++
 init/Kconfig          |    9 +
 kernel/exit.c         |    2 
 kernel/futex.c        |  401 ++++++++++++++++++++++++++++++++++++++++++++++++++
 6 files changed, 451 insertions(+)

Index: linux-2.6.15/include/linux/fs.h
===================================================================
--- linux-2.6.15.orig/include/linux/fs.h
+++ linux-2.6.15/include/linux/fs.h
@@ -9,6 +9,7 @@
 #include <linux/config.h>
 #include <linux/limits.h>
 #include <linux/ioctl.h>
+#include <linux/futex.h>
 
 /*
  * It's silly to have NR_OPEN bigger than NR_FILE, but you can change
@@ -383,6 +384,9 @@ struct address_space {
 	spinlock_t		private_lock;	/* for use by the address_space */
 	struct list_head	private_list;	/* ditto */
 	struct address_space	*assoc_mapping;	/* ditto */
+#ifdef CONFIG_ROBUST_FUTEX
+	struct futex_head	*robust_head;	/* list of robust futexes */
+#endif
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
+#define FUTEX_WAITERS				0x80000000
+#define FUTEX_OWNER_DIED			0x40000000
+#define FUTEX_NOT_RECOVERABLE			0x20000000
+#define FUTEX_FLAGS (FUTEX_WAITERS | FUTEX_OWNER_DIED | FUTEX_NOT_RECOVERABLE)
+#define FUTEX_PID                             ~(FUTEX_FLAGS)
+
+#define FUTEX_ATTR_SHARED                       0x10000000
+
+#ifdef __KERNEL__
+#include <linux/list.h>
+#include <linux/mutex.h>
+
+#ifdef CONFIG_ROBUST_FUTEX
+
+struct futex_head {
+	struct list_head robust_list;
+	struct mutex robust_mutex;
+};
+
+struct inode;
+struct task_struct;
+extern void futex_free_robust_list(struct inode *inode);
+extern void exit_futex(struct task_struct *tsk);
+#else
+# define futex_free_robust_list(a)	do { } while (0)
+# define exit_futex(b)			do { } while (0)
+#define futex_init_inode(a)		do { } while (0)
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
@@ -40,7 +43,9 @@
 #include <linux/pagemap.h>
 #include <linux/syscalls.h>
 #include <linux/signal.h>
+#include <linux/mutex.h>
 #include <asm/futex.h>
+#include <asm/uaccess.h>
 
 #define FUTEX_HASHBITS (CONFIG_BASE_SMALL ? 4 : 8)
 
@@ -829,6 +834,385 @@ error:
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
+static kmem_cache_t *robust_futex_cachep;
+static kmem_cache_t *file_futex_cachep;
+/*
+ * Used to track registered robust futexes. Attached to linked list in inodes.
+ */
+struct futex_robust {
+	struct list_head list;
+	union futex_key key;
+};
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
+	struct address_space *mapping = inode->i_mapping;
+ 	struct futex_robust *this, *next;
+	struct futex_head *futex_head = NULL;
+	struct list_head head;
+
+	futex_head = mapping->robust_head;
+
+	if (futex_head == NULL)
+		return;
+
+	if (list_empty(&futex_head->robust_list))
+		return;
+
+	INIT_LIST_HEAD(&head);
+	mutex_lock(&futex_head->robust_mutex);
+	list_splice_init(&futex_head->robust_list, &head);
+	mutex_unlock(&futex_head->robust_mutex);
+
+	list_for_each_entry_safe(this, next, &head, list) {
+		kmem_cache_free(robust_futex_cachep, this);
+	}
+
+	kmem_cache_free(file_futex_cachep, futex_head);
+	mapping->robust_head = NULL;
+
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
+ * release_owned_futex - find futexes owned by the current task
+ * @tsk: task that is exiting
+ * @vma: vma containing robust futexes
+ * @head: list head for list of robust futexes
+ * @mutex: mutex that protects the list
+ *
+ * Walk the list of registered robust futexes for this @vma,
+ * setting the %FUTEX_OWNER_DIED flag on those futexes owned
+ * by the current, exiting task.
+ */
+static void
+release_owned_futex(struct task_struct *tsk, struct vm_area_struct *vma,
+		    struct futex_head *robust)
+{
+	struct futex_robust *this, *next;
+	struct mutex *mutex = &robust->robust_mutex;
+	struct list_head *head = &robust->robust_list;
+ 	unsigned long uaddr;
+	int value;
+
+	mutex_lock(mutex);
+
+	list_for_each_entry_safe(this, next, head, list) {
+
+		uaddr = get_futex_uaddr(&this->key, vma);
+		if (uaddr == 0)
+			continue;
+
+		mutex_unlock(mutex);
+		up_read(&tsk->mm->mmap_sem);
+		get_user(value, (int __user *)uaddr);
+		if ((value & FUTEX_PID) == tsk->pid) {
+			value |= FUTEX_OWNER_DIED;
+			put_user(value, (int *__user)uaddr);
+			futex_wake(uaddr, 1);
+		}
+		down_read(&tsk->mm->mmap_sem);
+		mutex_lock(mutex);
+	}
+
+	mutex_unlock(mutex);
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
+	struct mm_struct *mm = tsk->mm;
+	struct list_head *robust;
+	struct futex_head *head;
+	struct vm_area_struct *vma;
+	struct address_space *addr;
+
+	if (mm == NULL)
+		return;
+
+	down_read(&mm->mmap_sem);
+
+	for (vma = mm->mmap; vma != NULL; vma = vma->vm_next) {
+		if (vma->vm_file == NULL)
+			continue;
+
+		addr = vma->vm_file->f_mapping;
+		if (addr == NULL)
+			continue;
+
+		if (addr->robust_head == NULL)
+			continue;
+
+		head = addr->robust_head;
+		robust = &head->robust_list;
+
+		if (list_empty(robust))
+			continue;
+
+		release_owned_futex(tsk, vma, head);
+	}
+
+	up_read(&mm->mmap_sem);
+}
+
+static void init_robust_list(struct address_space *f, struct futex_head *head)
+{
+	f->robust_head = head;
+	INIT_LIST_HEAD(&f->robust_head->robust_list);
+	mutex_init(&f->robust_head->robust_mutex);
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
+	int ret = 0;
+	struct futex_robust *robust;
+	struct mm_struct *mm = current->mm;
+	struct vm_area_struct *vma;
+	struct address_space *addr = NULL;
+	struct list_head *head = NULL;
+	struct mutex *mutex = NULL;
+	struct futex_head *rb, *file_futex = NULL;
+
+	if ((attr & FUTEX_ATTR_SHARED) == 0)
+		return -EADDRNOTAVAIL;
+
+	down_read(&mm->mmap_sem);
+
+	vma = find_extend_vma(mm, uaddr);
+
+	if (vma->vm_file) {
+		addr = vma->vm_file->f_mapping;
+		if (addr == NULL) {
+			ret = -EADDRNOTAVAIL;
+			goto out;
+		}
+		rb = addr->robust_head;
+		robust = kmem_cache_alloc(robust_futex_cachep, GFP_KERNEL);
+		if (!robust) {
+			ret = -ENOMEM;
+			goto out;
+		}
+		if (rb == NULL) {
+			file_futex = kmem_cache_alloc(file_futex_cachep, GFP_KERNEL);
+			if (!file_futex) {
+				kmem_cache_free(robust_futex_cachep, robust);
+				ret = -ENOMEM;
+				goto out;
+			}
+			init_robust_list(addr, file_futex);
+			rb = addr->robust_head;
+		}
+		head = &rb->robust_list;
+		mutex = &rb->robust_mutex;
+	} else {
+		ret = -EADDRNOTAVAIL;
+		goto out;
+	}
+
+	mutex_lock(mutex);
+	list_add_tail(&robust->list, head);
+	mutex_unlock(mutex);
+
+out:
+	up_read(&mm->mmap_sem);
+
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
+	struct mutex *mutex = NULL;
+	struct vm_area_struct *vma;
+	struct address_space *addr;
+	struct futex_head *robust;
+	struct futex_robust *this, *next;
+	int ret;
+
+	down_read(&mm->mmap_sem);
+
+	ret = get_futex_key(uaddr, &key);
+	if (unlikely(ret != 0))
+		goto out;
+	vma = find_extend_vma(mm, uaddr);
+	if (vma->vm_file) {
+		addr = vma->vm_file->f_mapping;
+		if (addr) {
+			robust = addr->robust_head;
+			mutex = &robust->robust_mutex;
+			head = &robust->robust_list;
+		}
+	}
+	if (head == NULL) {
+		ret = -EINVAL;
+		goto out;
+	}
+
+	mutex_lock(mutex);
+
+	list_for_each_entry_safe(this, next, head, list) {
+		if (match_futex(&this->key, &key)) {
+			futex_wake(uaddr, 1);
+			list_del(&this->list);
+			kmem_cache_free(robust_futex_cachep, this);
+			break;
+		}
+	}
+
+	mutex_unlock(mutex);
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
+
+	down_read(&current->mm->mmap_sem);
+	ret = get_futex_key(uaddr, &key);
+	up_read(&current->mm->mmap_sem);
+	if (ret != 0)
+		return ret;
+
+	if (get_user(value, (int *__user)uaddr))
+		return ret;
+
+	value &= ~FUTEX_OWNER_DIED;
+	return put_user(value, (int *__user)uaddr);
+}
+#endif
+
 long do_futex(unsigned long uaddr, int op, int val, unsigned long timeout,
 		unsigned long uaddr2, int val2, int val3)
 {
@@ -854,6 +1238,17 @@ long do_futex(unsigned long uaddr, int o
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
@@ -901,6 +1296,12 @@ static int __init init(void)
 {
 	unsigned int i;
 
+#ifdef CONFIG_ROBUST_FUTEX
+	robust_futex_cachep = kmem_cache_create("robust_futex",
+			       sizeof(struct futex_robust), 0, 0, NULL, NULL);
+	file_futex_cachep = kmem_cache_create("file_futex",
+			       sizeof(struct futex_head), 0, 0, NULL, NULL);
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
@@ -175,6 +176,7 @@ void destroy_inode(struct inode *inode) 
 	if (inode_has_buffers(inode))
 		BUG();
 	security_inode_free(inode);
+	futex_free_robust_list(inode);
 	if (inode->i_sb->s_op->destroy_inode)
 		inode->i_sb->s_op->destroy_inode(inode);
 	else

--Apple-Mail-2-589630603--

