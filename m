Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262560AbSI0SkM>; Fri, 27 Sep 2002 14:40:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262558AbSI0SkM>; Fri, 27 Sep 2002 14:40:12 -0400
Received: from mx1.elte.hu ([157.181.1.137]:6594 "HELO mx1.elte.hu")
	by vger.kernel.org with SMTP id <S262560AbSI0SkC>;
	Fri, 27 Sep 2002 14:40:02 -0400
Date: Fri, 27 Sep 2002 20:54:31 +0200 (CEST)
From: Ingo Molnar <mingo@elte.hu>
Reply-To: Ingo Molnar <mingo@elte.hu>
To: Linus Torvalds <torvalds@transmeta.com>
Cc: Andrew Morton <akpm@zip.com.au>, Rusty Russell <rusty@rustcorp.com.au>,
       <linux-kernel@vger.kernel.org>
Subject: [patch] 'virtual => physical page mapping cache' take #2, vcache-2.5.38-C4
In-Reply-To: <Pine.LNX.4.44.0209271047340.14939-100000@home.transmeta.com>
Message-ID: <Pine.LNX.4.44.0209272043260.17678-100000@localhost.localdomain>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Fri, 27 Sep 2002, Linus Torvalds wrote:

> > pin_page() calls get_user_pages(), which might block in handle_mm_fault().
> 
> Ok, I admit that sucks. Maybe that damn writable down() is the right
> thing to do after all. And let's hope most futexes don't block.

i think my plan works too - see the attached patch. The method is to do a
cheap physpage lookup (ie. only the read-lock is taken, the page is forced
writable), but we insert it into the vcache and futex hash atomically:

        spin_lock(&vcache_lock);
        spin_lock(&futex_lock);
        spin_lock(&current->mm->page_table_lock);

        /*
         * Has the mapping changed meanwhile?
         */
        tmp = follow_page(current->mm, uaddr, 0);

        if (tmp == page) {
                q->page = page;
                list_add_tail(&q->list, head);
                /*
                 * We register a futex callback to this virtual address,
                 * to make sure a COW properly rehashes the futex-queue.
                 */
                __attach_vcache(&q->vcache, uaddr, current->mm, futex_vcache_callback);
        } else
                ret = 1;

        spin_unlock(&current->mm->page_table_lock);
        spin_unlock(&futex_lock);
        spin_unlock(&vcache_lock);

follow_page() is completely lock-less and it's lightweight.

if we race then we release the page and re-do the pin_page call. (should
be very rare.) This is conceptually similar to other race avoidance code
in the VM layer.

this method should also work fine if a futex wait is initiated *after* the
COW - the mapping is not forced writable and we'll be properly notified
once the COW happens. Ie. a nonintrusive futex-wait will not cause extra
COW-copying if a fork()+exec() [or fork()+exit()] happens, where the
FUTEX_WAIT is between the fork() and the exit(), and the FUTEX_WAKE is
after the exit().

in fact this means that futex wakeups can be done across fork(), as long
as the page is not COW-ed in. (glibc could perhaps make use of this
somewhere.)

so every scenario i can think of works fine in the common case and it
should scale well. I had to reorganize the futex code significantly, but
all the testcases pass now so it should be fine.

the futex 'slow path' is in fact one of our major scheduling points for
threaded apps that have userspace synchronization objects, so i think it's
worth the effort trying to improve it.

	Ingo

--- linux/include/linux/vcache.h.orig	Fri Sep 27 15:05:33 2002
+++ linux/include/linux/vcache.h	Fri Sep 27 20:33:30 2002
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
--- linux/include/linux/mm.h.orig	Fri Sep 27 20:40:56 2002
+++ linux/include/linux/mm.h	Fri Sep 27 20:41:06 2002
@@ -374,6 +374,7 @@
 extern int make_pages_present(unsigned long addr, unsigned long end);
 extern int access_process_vm(struct task_struct *tsk, unsigned long addr, void *buf, int len, int write);
 
+extern struct page * follow_page(struct mm_struct *mm, unsigned long address, int write);
 int get_user_pages(struct task_struct *tsk, struct mm_struct *mm, unsigned long start,
 		int len, int write, int force, struct page **pages, struct vm_area_struct **vmas);
 
--- linux/include/linux/futex.h.orig	Fri Sep 27 16:14:10 2002
+++ linux/include/linux/futex.h	Fri Sep 27 16:14:16 2002
@@ -6,6 +6,6 @@
 #define FUTEX_WAKE (1)
 #define FUTEX_FD (2)
 
-extern asmlinkage int sys_futex(void *uaddr, int op, int val, struct timespec *utime);
+extern asmlinkage int sys_futex(unsigned long uaddr, int op, int val, struct timespec *utime);
 
 #endif
--- linux/kernel/futex.c.orig	Fri Sep 20 17:20:21 2002
+++ linux/kernel/futex.c	Fri Sep 27 20:43:08 2002
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
@@ -85,21 +90,43 @@
 		send_sigio(&q->filp->f_owner, q->fd, POLL_IN);
 }
 
+/* Get kernel address of the user page and pin it. */
+static struct page *pin_page(unsigned long page_start)
+{
+	struct mm_struct *mm = current->mm;
+	struct page *page = NULL;
+	int err;
+
+	down_read(&mm->mmap_sem);
+
+	err = get_user_pages(current, mm, page_start,
+			     1 /* one page */,
+			     0 /* not writable */,
+			     0 /* don't force */,
+			     &page,
+			     NULL /* don't return vmas */);
+	up_read(&mm->mmap_sem);
+	if (err < 0)
+		return ERR_PTR(err);
+	return page;
+}
+
 static inline void unpin_page(struct page *page)
 {
-	/* Avoid releasing the page which is on the LRU list.  I don't
-           know if this is correct, but it stops the BUG() in
-           __free_pages_ok(). */
 	page_cache_release(page);
 }
 
-static int futex_wake(struct list_head *head,
-		      struct page *page,
-		      unsigned int offset,
-		      int num)
+static int futex_wake(unsigned long uaddr, unsigned int offset, int num)
 {
-	struct list_head *i, *next;
-	int num_woken = 0;
+	struct list_head *i, *next, *head;
+	struct page *page;
+	int ret;
+
+	page = pin_page(uaddr - offset);
+	ret = IS_ERR(page);
+	if (ret)
+		goto out;
+	head = hash_futex(page, offset);
 
 	spin_lock(&futex_lock);
 	list_for_each_safe(i, next, head) {
@@ -108,36 +135,81 @@
 		if (this->page == page && this->offset == offset) {
 			list_del_init(i);
 			tell_waiter(this);
-			num_woken++;
-			if (num_woken >= num) break;
+			ret++;
+			if (ret >= num)
+				break;
 		}
 	}
 	spin_unlock(&futex_lock);
-	return num_woken;
+	unpin_page(page);
+out:
+	return ret;
+}
+
+static void futex_vcache_callback(vcache_t *vcache, struct page *new_page)
+{
+	struct futex_q *q = container_of(vcache, struct futex_q, vcache);
+	struct list_head *head = hash_futex(new_page, q->offset);
+
+	BUG_ON(list_empty(&q->list));
+
+	spin_lock(&futex_lock);
+
+	q->page = new_page;
+	list_del_init(&q->list);
+	list_add_tail(&q->list, head);
+
+	spin_unlock(&futex_lock);
 }
 
 /* Add at end to avoid starvation */
-static inline void queue_me(struct list_head *head,
+static inline int queue_me(struct list_head *head,
 			    struct futex_q *q,
 			    struct page *page,
 			    unsigned int offset,
 			    int fd,
-			    struct file *filp)
+			    struct file *filp,
+			    unsigned long uaddr)
 {
-	q->page = page;
+	struct page *tmp;
+	int ret = 0;
+
 	q->offset = offset;
 	q->fd = fd;
 	q->filp = filp;
 
+	spin_lock(&vcache_lock);
 	spin_lock(&futex_lock);
-	list_add_tail(&q->list, head);
+	spin_lock(&current->mm->page_table_lock);
+
+	/*
+	 * Has the mapping changed meanwhile?
+	 */
+	tmp = follow_page(current->mm, uaddr, 0);
+
+	if (tmp == page) {
+		q->page = page;
+		list_add_tail(&q->list, head);
+		/*
+		 * We register a futex callback to this virtual address,
+		 * to make sure a COW properly rehashes the futex-queue.
+		 */
+		__attach_vcache(&q->vcache, uaddr, current->mm, futex_vcache_callback);
+	} else
+		ret = 1;
+
+	spin_unlock(&current->mm->page_table_lock);
 	spin_unlock(&futex_lock);
+	spin_unlock(&vcache_lock);
+
+	return ret;
 }
 
 /* Return 1 if we were still queued (ie. 0 means we were woken) */
 static inline int unqueue_me(struct futex_q *q)
 {
 	int ret = 0;
+
 	spin_lock(&futex_lock);
 	if (!list_empty(&q->list)) {
 		list_del(&q->list);
@@ -147,46 +219,34 @@
 	return ret;
 }
 
-/* Get kernel address of the user page and pin it. */
-static struct page *pin_page(unsigned long page_start)
-{
-	struct mm_struct *mm = current->mm;
-	struct page *page;
-	int err;
-
-	down_read(&mm->mmap_sem);
-	err = get_user_pages(current, mm, page_start,
-			     1 /* one page */,
-			     0 /* writable not important */,
-			     0 /* don't force */,
-			     &page,
-			     NULL /* don't return vmas */);
-	up_read(&mm->mmap_sem);
-
-	if (err < 0)
-		return ERR_PTR(err);
-	return page;
-}
-
-static int futex_wait(struct list_head *head,
-		      struct page *page,
+static int futex_wait(unsigned long uaddr,
 		      int offset,
 		      int val,
-		      int *uaddr,
 		      unsigned long time)
 {
-	int curval;
-	struct futex_q q;
 	DECLARE_WAITQUEUE(wait, current);
-	int ret = 0;
+	struct list_head *head;
+	int ret = 0, curval;
+	struct page *page;
+	struct futex_q q;
+
+repeat_lookup:
+	page = pin_page(uaddr - offset);
+	ret = IS_ERR(page);
+	if (ret)
+		goto out;
+	head = hash_futex(page, offset);
 
 	set_current_state(TASK_INTERRUPTIBLE);
 	init_waitqueue_head(&q.waiters);
 	add_wait_queue(&q.waiters, &wait);
-	queue_me(head, &q, page, offset, -1, NULL);
+	if (queue_me(head, &q, page, offset, -1, NULL, uaddr)) {
+		unpin_page(page);
+		goto repeat_lookup;
+	}
 
 	/* Page is pinned, but may no longer be in this address space. */
-	if (get_user(curval, uaddr) != 0) {
+	if (get_user(curval, (int *)uaddr) != 0) {
 		ret = -EFAULT;
 		goto out;
 	}
@@ -204,11 +264,15 @@
 		ret = -EINTR;
 		goto out;
 	}
- out:
+out:
+	detach_vcache(&q.vcache);
 	set_current_state(TASK_RUNNING);
 	/* Were we woken up anyway? */
 	if (!unqueue_me(&q))
-		return 0;
+		ret = 0;
+	if (page)
+		unpin_page(page);
+
 	return ret;
 }
 
@@ -251,25 +315,26 @@
 
 /* Signal allows caller to avoid the race which would occur if they
    set the sigio stuff up afterwards. */
-static int futex_fd(struct list_head *head,
-		    struct page *page,
-		    int offset,
-		    int signal)
+static int futex_fd(unsigned long uaddr, int offset, int signal)
 {
-	int fd;
+	struct page *page = NULL;
+	struct list_head *head;
 	struct futex_q *q;
 	struct file *filp;
+	int ret;
 
+	ret = -EINVAL;
 	if (signal < 0 || signal > _NSIG)
-		return -EINVAL;
+		goto out;
 
-	fd = get_unused_fd();
-	if (fd < 0)
-		return fd;
+	ret = get_unused_fd();
+	if (ret < 0)
+		goto out;
 	filp = get_empty_filp();
 	if (!filp) {
-		put_unused_fd(fd);
-		return -ENFILE;
+		put_unused_fd(ret);
+		ret = -ENFILE;
+		goto out;
 	}
 	filp->f_op = &futex_fops;
 	filp->f_vfsmnt = mntget(futex_mnt);
@@ -280,37 +345,55 @@
 		
 		ret = f_setown(filp, current->tgid, 1);
 		if (ret) {
-			put_unused_fd(fd);
+			put_unused_fd(ret);
 			put_filp(filp);
-			return ret;
+			goto out;
 		}
 		filp->f_owner.signum = signal;
 	}
 
 	q = kmalloc(sizeof(*q), GFP_KERNEL);
 	if (!q) {
-		put_unused_fd(fd);
+		put_unused_fd(ret);
+		put_filp(filp);
+		ret = -ENOMEM;
+		goto out;
+	}
+
+repeat_lookup:
+	page = pin_page(uaddr - offset);
+	ret = IS_ERR(page);
+	if (ret) {
+		put_unused_fd(ret);
 		put_filp(filp);
-		return -ENOMEM;
+		kfree(q);
+		page = NULL;
+		goto out;
 	}
+	head = hash_futex(page, offset);
 
 	/* Initialize queue structure, and add to hash table. */
 	filp->private_data = q;
 	init_waitqueue_head(&q->waiters);
-	queue_me(head, q, page, offset, fd, filp);
+	if (queue_me(head, q, page, offset, ret, filp, uaddr)) {
+		unpin_page(page);
+		goto repeat_lookup;
+	}
 
 	/* Now we map fd to filp, so userspace can access it */
-	fd_install(fd, filp);
-	return fd;
+	fd_install(ret, filp);
+	page = NULL;
+out:
+	if (page)
+		unpin_page(page);
+	return ret;
 }
 
-asmlinkage int sys_futex(void *uaddr, int op, int val, struct timespec *utime)
+asmlinkage int sys_futex(unsigned long uaddr, int op, int val, struct timespec *utime)
 {
-	int ret;
-	unsigned long pos_in_page;
-	struct list_head *head;
-	struct page *page;
 	unsigned long time = MAX_SCHEDULE_TIMEOUT;
+	unsigned long pos_in_page;
+	int ret;
 
 	if (utime) {
 		struct timespec t;
@@ -319,38 +402,27 @@
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
-
-	head = hash_futex(page, pos_in_page);
 	switch (op) {
 	case FUTEX_WAIT:
-		ret = futex_wait(head, page, pos_in_page, val, uaddr, time);
+		ret = futex_wait(uaddr, pos_in_page, val, time);
 		break;
 	case FUTEX_WAKE:
-		ret = futex_wake(head, page, pos_in_page, val);
+		ret = futex_wake(uaddr, pos_in_page, val);
 		break;
 	case FUTEX_FD:
 		/* non-zero val means F_SETOWN(getpid()) & F_SETSIG(val) */
-		ret = futex_fd(head, page, pos_in_page, val);
-		if (ret >= 0)
-			/* Leave page pinned (attached to fd). */
-			return ret;
+		ret = futex_fd(uaddr, pos_in_page, val);
 		break;
 	default:
 		ret = -EINVAL;
 	}
-	unpin_page(page);
-
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
+++ linux/mm/memory.c	Fri Sep 27 20:40:52 2002
@@ -43,6 +43,7 @@
 #include <linux/iobuf.h>
 #include <linux/highmem.h>
 #include <linux/pagemap.h>
+#include <linux/vcache.h>
 
 #include <asm/pgalloc.h>
 #include <asm/rmap.h>
@@ -463,7 +464,7 @@
  * Do a quick page-table lookup for a single page.
  * mm->page_table_lock must be held.
  */
-static inline struct page *
+struct page *
 follow_page(struct mm_struct *mm, unsigned long address, int write) 
 {
 	pgd_t *pgd;
@@ -494,7 +495,7 @@
 	}
 
 out:
-	return 0;
+	return NULL;
 }
 
 /* 
@@ -973,6 +974,7 @@
 static inline void break_cow(struct vm_area_struct * vma, struct page * new_page, unsigned long address, 
 		pte_t *page_table)
 {
+	invalidate_vcache(address, vma->vm_mm, new_page);
 	flush_page_to_ram(new_page);
 	flush_cache_page(vma, address);
 	establish_pte(vma, address, page_table, pte_mkwrite(pte_mkdirty(mk_pte(new_page, vma->vm_page_prot))));
--- linux/mm/vcache.c.orig	Fri Sep 27 14:58:10 2002
+++ linux/mm/vcache.c	Fri Sep 27 20:33:22 2002
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

