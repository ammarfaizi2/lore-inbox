Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262524AbSI0QLC>; Fri, 27 Sep 2002 12:11:02 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262525AbSI0QLC>; Fri, 27 Sep 2002 12:11:02 -0400
Received: from mx2.elte.hu ([157.181.151.9]:34982 "HELO mx2.elte.hu")
	by vger.kernel.org with SMTP id <S262524AbSI0QKg>;
	Fri, 27 Sep 2002 12:10:36 -0400
Date: Fri, 27 Sep 2002 18:24:40 +0200 (CEST)
From: Ingo Molnar <mingo@elte.hu>
Reply-To: Ingo Molnar <mingo@elte.hu>
To: Linus Torvalds <torvalds@transmeta.com>
Cc: Andrew Morton <akpm@zip.com.au>, Rusty Russell <rusty@rustcorp.com.au>,
       <linux-kernel@vger.kernel.org>
Subject: [patch] 'virtual => physical page mapping cache', vcache-2.5.38-B8
Message-ID: <Pine.LNX.4.44.0209271812450.15069-100000@localhost.localdomain>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


the attached patch implements the virtual => physical cache. Right now
only the COW code calls the invalidation function, because futexes do not
need notification on unmap.

I have fixed a new futex bug as well: pin_page() alone does not guarantee
that the mapping does not change magically, only taking the MM semaphore
in write-mode does.

this also enables us to avoid taking the vcache_lock in the COW fastpath,
so the overhead should be pretty low, unless there are futexes in the
given hash-list, in which case we obviously have to take the vcache_lock.

with this patch applied to BK-curr all our fork testcases pass just fine.

taking the MM write-lock is a bit strong, but i found no good way to avoid
it - we have to hold on to the pte mapping. get_user_pages() without the
mm lock taken is pretty meaningless - any other thread could in parallel
COW the given page and fault in a completely different page. Are other
get_user_page() users [such as direct-IO] protected against this scenario?

	Ingo

--- linux/include/linux/vcache.h.orig	Fri Sep 27 15:05:33 2002
+++ linux/include/linux/vcache.h	Fri Sep 27 16:07:42 2002
@@ -0,0 +1,26 @@
+/*
+ * virtual => physical mapping cache support.
+ */
+#ifndef _LINUX_VCACHE_H
+#define _LINUX_VCACHE_H
+
+typedef struct vcache_s {
+	unsigned long address;
+	struct mm_struct *mm;
+	struct list_head hash_entry;
+	void (*callback)(struct vcache_s *data, struct page *new_page);
+} vcache_t;
+
+extern spinlock_t vcache_lock;
+
+extern void __attach_vcache(vcache_t *vcache,
+		unsigned long address,
+		struct mm_struct *mm,
+		void (*callback)(struct vcache_s *data, struct page *new_page));
+
+extern void detach_vcache(vcache_t *vcache);
+
+extern void invalidate_vcache(unsigned long address, struct mm_struct *mm,
+				struct page *new_page);
+
+#endif
--- linux/include/linux/futex.h.orig	Fri Sep 27 16:14:10 2002
+++ linux/include/linux/futex.h	Fri Sep 27 16:14:16 2002
@@ -6,6 +6,6 @@
 #define FUTEX_WAKE (1)
 #define FUTEX_FD (2)
 
-extern asmlinkage int sys_futex(void *uaddr, int op, int val, struct timespec *utime);
+extern asmlinkage int sys_futex(unsigned long uaddr, int op, int val, struct timespec *utime);
 
 #endif
--- linux/kernel/futex.c.orig	Fri Sep 20 17:20:21 2002
+++ linux/kernel/futex.c	Fri Sep 27 18:11:14 2002
@@ -31,6 +31,7 @@
 #include <linux/init.h>
 #include <linux/fs.h>
 #include <linux/futex.h>
+#include <linux/vcache.h>
 #include <linux/highmem.h>
 #include <linux/time.h>
 #include <linux/pagemap.h>
@@ -38,7 +39,6 @@
 #include <linux/poll.h>
 #include <linux/file.h>
 #include <linux/dcache.h>
-#include <asm/uaccess.h>
 
 /* Simple "sleep if unchanged" interface. */
 
@@ -55,9 +55,14 @@
 struct futex_q {
 	struct list_head list;
 	wait_queue_head_t waiters;
+
 	/* Page struct and offset within it. */
 	struct page *page;
 	unsigned int offset;
+
+	/* the virtual => physical cache */
+	vcache_t vcache;
+
 	/* For fd, sigio sent using these. */
 	int fd;
 	struct file *filp;
@@ -87,9 +92,6 @@
 
 static inline void unpin_page(struct page *page)
 {
-	/* Avoid releasing the page which is on the LRU list.  I don't
-           know if this is correct, but it stops the BUG() in
-           __free_pages_ok(). */
 	page_cache_release(page);
 }
 
@@ -113,31 +115,61 @@
 		}
 	}
 	spin_unlock(&futex_lock);
+
+	up_write(&current->mm->mmap_sem);
+
 	return num_woken;
 }
 
+static void futex_vcache_callback(vcache_t *vcache, struct page *new_page)
+{
+	struct futex_q *q = container_of(vcache, struct futex_q, vcache);
+	struct list_head *head;
+
+	spin_lock(&futex_lock);
+
+	q->page = new_page;
+	head = hash_futex(new_page, q->offset);
+	BUG_ON(list_empty(&q->list));
+	list_del_init(&q->list);
+	list_add_tail(&q->list, head);
+
+	spin_unlock(&futex_lock);
+}
+
 /* Add at end to avoid starvation */
 static inline void queue_me(struct list_head *head,
 			    struct futex_q *q,
 			    struct page *page,
 			    unsigned int offset,
 			    int fd,
-			    struct file *filp)
+			    struct file *filp,
+			    unsigned long uaddr)
 {
 	q->page = page;
 	q->offset = offset;
 	q->fd = fd;
 	q->filp = filp;
 
+	spin_lock(&vcache_lock);
+	/*
+	 * We register a futex callback to this virtual address,
+	 * to make sure a COW properly rehashes the futex-queue.
+	 */
+	__attach_vcache(&q->vcache, uaddr, current->mm, futex_vcache_callback);
+
 	spin_lock(&futex_lock);
 	list_add_tail(&q->list, head);
 	spin_unlock(&futex_lock);
+	spin_unlock(&vcache_lock);
 }
 
 /* Return 1 if we were still queued (ie. 0 means we were woken) */
 static inline int unqueue_me(struct futex_q *q)
 {
 	int ret = 0;
+
+	detach_vcache(&q->vcache);
 	spin_lock(&futex_lock);
 	if (!list_empty(&q->list)) {
 		list_del(&q->list);
@@ -151,17 +183,15 @@
 static struct page *pin_page(unsigned long page_start)
 {
 	struct mm_struct *mm = current->mm;
-	struct page *page;
+	struct page *page = NULL;
 	int err;
 
-	down_read(&mm->mmap_sem);
 	err = get_user_pages(current, mm, page_start,
 			     1 /* one page */,
-			     0 /* writable not important */,
+			     1 /* writable */,
 			     0 /* don't force */,
 			     &page,
 			     NULL /* don't return vmas */);
-	up_read(&mm->mmap_sem);
 
 	if (err < 0)
 		return ERR_PTR(err);
@@ -172,8 +202,8 @@
 		      struct page *page,
 		      int offset,
 		      int val,
-		      int *uaddr,
-		      unsigned long time)
+		      unsigned long time,
+		      unsigned long uaddr)
 {
 	int curval;
 	struct futex_q q;
@@ -183,10 +213,12 @@
 	set_current_state(TASK_INTERRUPTIBLE);
 	init_waitqueue_head(&q.waiters);
 	add_wait_queue(&q.waiters, &wait);
-	queue_me(head, &q, page, offset, -1, NULL);
+	queue_me(head, &q, page, offset, -1, NULL, uaddr);
+
+	up_write(&current->mm->mmap_sem);
 
 	/* Page is pinned, but may no longer be in this address space. */
-	if (get_user(curval, uaddr) != 0) {
+	if (get_user(curval, (int *)uaddr) != 0) {
 		ret = -EFAULT;
 		goto out;
 	}
@@ -254,22 +286,25 @@
 static int futex_fd(struct list_head *head,
 		    struct page *page,
 		    int offset,
-		    int signal)
+		    int signal,
+		    unsigned long uaddr)
 {
-	int fd;
 	struct futex_q *q;
 	struct file *filp;
+	int fd;
 
+	fd = -EINVAL;
 	if (signal < 0 || signal > _NSIG)
-		return -EINVAL;
+		goto out;
 
 	fd = get_unused_fd();
 	if (fd < 0)
-		return fd;
+		goto out;
 	filp = get_empty_filp();
 	if (!filp) {
 		put_unused_fd(fd);
-		return -ENFILE;
+		fd = -ENFILE;
+		goto out;
 	}
 	filp->f_op = &futex_fops;
 	filp->f_vfsmnt = mntget(futex_mnt);
@@ -282,7 +317,8 @@
 		if (ret) {
 			put_unused_fd(fd);
 			put_filp(filp);
-			return ret;
+			fd = ret;
+			goto out;
 		}
 		filp->f_owner.signum = signal;
 	}
@@ -291,26 +327,29 @@
 	if (!q) {
 		put_unused_fd(fd);
 		put_filp(filp);
-		return -ENOMEM;
+		fd = -ENOMEM;
+		goto out;
 	}
 
 	/* Initialize queue structure, and add to hash table. */
 	filp->private_data = q;
 	init_waitqueue_head(&q->waiters);
-	queue_me(head, q, page, offset, fd, filp);
+	queue_me(head, q, page, offset, fd, filp, uaddr);
 
 	/* Now we map fd to filp, so userspace can access it */
 	fd_install(fd, filp);
+out:
+	up_write(&current->mm->mmap_sem);
 	return fd;
 }
 
-asmlinkage int sys_futex(void *uaddr, int op, int val, struct timespec *utime)
+asmlinkage int sys_futex(unsigned long uaddr, int op, int val, struct timespec *utime)
 {
-	int ret;
+	unsigned long time = MAX_SCHEDULE_TIMEOUT;
 	unsigned long pos_in_page;
 	struct list_head *head;
 	struct page *page;
-	unsigned long time = MAX_SCHEDULE_TIMEOUT;
+	int ret;
 
 	if (utime) {
 		struct timespec t;
@@ -319,38 +358,43 @@
 		time = timespec_to_jiffies(&t) + 1;
 	}
 
-	pos_in_page = ((unsigned long)uaddr) % PAGE_SIZE;
+	pos_in_page = uaddr % PAGE_SIZE;
 
 	/* Must be "naturally" aligned, and not on page boundary. */
 	if ((pos_in_page % __alignof__(int)) != 0
 	    || pos_in_page + sizeof(int) > PAGE_SIZE)
 		return -EINVAL;
 
-	/* Simpler if it doesn't vanish underneath us. */
-	page = pin_page((unsigned long)uaddr - pos_in_page);
-	if (IS_ERR(page))
-		return PTR_ERR(page);
+	/* Simpler if it mappings do not change underneath us. */
+	down_write(&current->mm->mmap_sem);
+
+	page = pin_page(uaddr - pos_in_page);
+	ret = IS_ERR(page);
+	if (ret)
+		goto out;
 
 	head = hash_futex(page, pos_in_page);
 	switch (op) {
 	case FUTEX_WAIT:
-		ret = futex_wait(head, page, pos_in_page, val, uaddr, time);
+		ret = futex_wait(head, page, pos_in_page, val, time, uaddr);
 		break;
 	case FUTEX_WAKE:
 		ret = futex_wake(head, page, pos_in_page, val);
 		break;
 	case FUTEX_FD:
 		/* non-zero val means F_SETOWN(getpid()) & F_SETSIG(val) */
-		ret = futex_fd(head, page, pos_in_page, val);
+		ret = futex_fd(head, page, pos_in_page, val, uaddr);
 		if (ret >= 0)
 			/* Leave page pinned (attached to fd). */
-			return ret;
+			goto out;
 		break;
 	default:
+		up_write(&current->mm->mmap_sem);
 		ret = -EINVAL;
 	}
 	unpin_page(page);
 
+out:
 	return ret;
 }
 
--- linux/kernel/fork.c.orig	Fri Sep 27 16:20:01 2002
+++ linux/kernel/fork.c	Fri Sep 27 16:20:22 2002
@@ -381,7 +381,7 @@
 		 * not set up a proper pointer then tough luck.
 		 */
 		put_user(0, tsk->user_tid);
-		sys_futex(tsk->user_tid, FUTEX_WAKE, 1, NULL);
+		sys_futex((unsigned long)tsk->user_tid, FUTEX_WAKE, 1, NULL);
 	}
 }
 
--- linux/mm/memory.c.orig	Fri Sep 20 17:20:25 2002
+++ linux/mm/memory.c	Fri Sep 27 16:48:12 2002
@@ -43,6 +43,7 @@
 #include <linux/iobuf.h>
 #include <linux/highmem.h>
 #include <linux/pagemap.h>
+#include <linux/vcache.h>
 
 #include <asm/pgalloc.h>
 #include <asm/rmap.h>
@@ -973,6 +974,7 @@
 static inline void break_cow(struct vm_area_struct * vma, struct page * new_page, unsigned long address, 
 		pte_t *page_table)
 {
+	invalidate_vcache(address, vma->vm_mm, new_page);
 	flush_page_to_ram(new_page);
 	flush_cache_page(vma, address);
 	establish_pte(vma, address, page_table, pte_mkwrite(pte_mkdirty(mk_pte(new_page, vma->vm_page_prot))));
--- linux/mm/vcache.c.orig	Fri Sep 27 14:58:10 2002
+++ linux/mm/vcache.c	Fri Sep 27 18:11:07 2002
@@ -0,0 +1,93 @@
+/*
+ *  linux/mm/vcache.c
+ *
+ *  virtual => physical page mapping cache. Users of this mechanism
+ *  register callbacks for a given (virt,mm,phys) page mapping, and
+ *  the kernel guarantees to call back when this mapping is invalidated.
+ *  (ie. upon COW or unmap.)
+ *
+ *  Started by Ingo Molnar, Copyright (C) 2002
+ */
+
+#include <linux/mm.h>
+#include <linux/init.h>
+#include <linux/hash.h>
+#include <linux/vcache.h>
+
+#define VCACHE_HASHBITS 8
+#define VCACHE_HASHSIZE (1 << VCACHE_HASHBITS)
+
+spinlock_t vcache_lock = SPIN_LOCK_UNLOCKED;
+
+static struct list_head hash[VCACHE_HASHSIZE];
+
+static struct list_head *hash_vcache(unsigned long address,
+					struct mm_struct *mm)
+{
+        return &hash[hash_long(address + (unsigned long)mm, VCACHE_HASHBITS)];
+}
+
+void __attach_vcache(vcache_t *vcache,
+		unsigned long address,
+		struct mm_struct *mm,
+		void (*callback)(struct vcache_s *data, struct page *new))
+{
+	struct list_head *hash_head;
+
+	address &= PAGE_MASK;
+	vcache->address = address;
+	vcache->mm = mm;
+	vcache->callback = callback;
+
+	hash_head = hash_vcache(address, mm);
+
+	list_add(&vcache->hash_entry, hash_head);
+}
+
+void detach_vcache(vcache_t *vcache)
+{
+	spin_lock(&vcache_lock);
+	list_del(&vcache->hash_entry);
+	spin_unlock(&vcache_lock);
+}
+
+void invalidate_vcache(unsigned long address, struct mm_struct *mm,
+				struct page *new_page)
+{
+	struct list_head *l, *hash_head;
+	vcache_t *vcache;
+
+	address &= PAGE_MASK;
+
+	hash_head = hash_vcache(address, mm);
+	/*
+	 * This is safe, because this path is called with the mm
+	 * semaphore read-held, and the add/remove path calls with the
+	 * mm semaphore write-held. So while other mm's might add new
+	 * entries in parallel, and *this* mm is locked out, so if the
+	 * list is empty now then we do not have to take the vcache
+	 * lock to see it's really empty.
+	 */
+	if (likely(list_empty(hash_head)))
+		return;
+
+	spin_lock(&vcache_lock);
+	list_for_each(l, hash_head) {
+		vcache = list_entry(l, vcache_t, hash_entry);
+		if (vcache->address != address || vcache->mm != mm)
+			continue;
+		vcache->callback(vcache, new_page);
+	}
+	spin_unlock(&vcache_lock);
+}
+
+static int __init vcache_init(void)
+{
+        unsigned int i;
+
+	for (i = 0; i < VCACHE_HASHSIZE; i++)
+		INIT_LIST_HEAD(hash + i);
+	return 0;
+}
+__initcall(vcache_init);
+
--- linux/mm/Makefile.orig	Fri Sep 27 15:03:25 2002
+++ linux/mm/Makefile	Fri Sep 27 15:03:31 2002
@@ -9,6 +9,6 @@
 	    vmalloc.o slab.o bootmem.o swap.o vmscan.o page_io.o \
 	    page_alloc.o swap_state.o swapfile.o numa.o oom_kill.o \
 	    shmem.o highmem.o mempool.o msync.o mincore.o readahead.o \
-	    pdflush.o page-writeback.o rmap.o madvise.o
+	    pdflush.o page-writeback.o rmap.o madvise.o vcache.o
 
 include $(TOPDIR)/Rules.make

