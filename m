Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316795AbSG3VvS>; Tue, 30 Jul 2002 17:51:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316821AbSG3VvS>; Tue, 30 Jul 2002 17:51:18 -0400
Received: from to-velocet.redhat.com ([216.138.202.10]:25846 "EHLO
	touchme.toronto.redhat.com") by vger.kernel.org with ESMTP
	id <S316795AbSG3Vu6>; Tue, 30 Jul 2002 17:50:58 -0400
Date: Tue, 30 Jul 2002 17:54:21 -0400
From: Benjamin LaHaise <bcrl@redhat.com>
To: Andrea Arcangeli <andrea@suse.de>
Cc: Linus Torvalds <torvalds@transmeta.com>, linux-kernel@vger.kernel.org,
       linux-aio@kvack.org
Subject: [rfc] aio-core for 2.5.29 (Re: async-io API registration for 2.5.29)
Message-ID: <20020730175421.J10315@redhat.com>
References: <20020730054111.GA1159@dualathlon.random> <20020730084939.A8978@redhat.com> <20020730214116.GN1181@dualathlon.random>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <20020730214116.GN1181@dualathlon.random>; from andrea@suse.de on Tue, Jul 30, 2002 at 11:41:16PM +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 30, 2002 at 11:41:16PM +0200, Andrea Arcangeli wrote:
> Can you point me out to a patch with the new cancellation API that you
> agree with for merging in 2.5 so I can synchronize? I'm reading your
> very latest patch loaded on some site in June. that will be really
> helpful, many thanks!

Here is what I've got for the aio core that has the cancellation 
change to return the completion event.  The other slight change that 
I meant to get in before going into the mainstream is to have the 
timeout io_getevents takes be an absolute timeout, which helps for 
applications that have specific deadlines they are attempting to 
schedule to (think video playback).  This drop is untested, but I'd 
like it if people could provide comments on it.

		-ben
-- 
"You will be reincarnated as a toad; and you will be much happier."

:r ~/patches/v2.5/v2.5.29-aio-core-A0.diff
diff -urN v2.5.29/arch/i386/kernel/entry.S aio-v2.5.29.diff/arch/i386/kernel/entry.S
--- v2.5.29/arch/i386/kernel/entry.S	Tue Jul 30 10:24:32 2002
+++ aio-v2.5.29.diff/arch/i386/kernel/entry.S	Tue Jul 30 17:23:04 2002
@@ -753,6 +753,11 @@
 	.long sys_sched_setaffinity
 	.long sys_sched_getaffinity
 	.long sys_set_thread_area
+	.long sys_io_setup
+	.long sys_io_destroy	/* 245 */
+	.long sys_io_getevents_abs
+	.long sys_io_submit
+	.long sys_io_cancel
 
 	.rept NR_syscalls-(.-sys_call_table)/4
 		.long sys_ni_syscall
diff -urN v2.5.29/fs/Makefile aio-v2.5.29.diff/fs/Makefile
--- v2.5.29/fs/Makefile	Tue Jul 30 09:46:21 2002
+++ aio-v2.5.29.diff/fs/Makefile	Tue Jul 30 10:33:45 2002
@@ -8,14 +8,14 @@
 O_TARGET := fs.o
 
 export-objs :=	filesystems.o open.o dcache.o buffer.o bio.o inode.o dquot.o \
-		mpage.o
+		mpage.o aio.o
 
 obj-y :=	open.o read_write.o devices.o file_table.o buffer.o \
 		bio.o super.o block_dev.o char_dev.o stat.o exec.o pipe.o \
 		namei.o fcntl.o ioctl.o readdir.o select.o fifo.o locks.o \
 		dcache.o inode.o attr.o bad_inode.o file.o iobuf.o dnotify.o \
 		filesystems.o namespace.o seq_file.o xattr.o libfs.o \
-		fs-writeback.o mpage.o direct-io.o
+		fs-writeback.o mpage.o direct-io.o aio.o
 
 ifneq ($(CONFIG_NFSD),n)
 ifneq ($(CONFIG_NFSD),)
diff -urN v2.5.29/fs/aio.c aio-v2.5.29.diff/fs/aio.c
--- v2.5.29/fs/aio.c	Wed Dec 31 19:00:00 1969
+++ aio-v2.5.29.diff/fs/aio.c	Tue Jul 30 17:22:43 2002
@@ -0,0 +1,1160 @@
+/* fs/aio.c
+ *	An async IO implementation for Linux
+ *	Written by Benjamin LaHaise <bcrl@redhat.com>
+ *
+ *	Implements an efficient asynchronous io interface.
+ *
+ *	Copyright 2000, 2001, 2002 Red Hat, Inc.  All Rights Reserved.
+ *
+ *   This program is free software; you can redistribute it and/or modify
+ *   it under the terms of the GNU General Public License as published by
+ *   the Free Software Foundation; either version 2 of the License, or
+ *   (at your option) any later version.
+ *
+ *   This program is distributed in the hope that it will be useful,
+ *   but WITHOUT ANY WARRANTY; without even the implied warranty of
+ *   MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ *   GNU General Public License for more details.
+ *
+ *   You should have received a copy of the GNU General Public License along
+ *   with this program; if not, write to the Free Software Foundation, Inc.,
+ *   59 Temple Place, Suite 330, Boston, MA  02111-1307  USA
+ *
+ */
+//#define DEBUG 1
+
+#include <linux/sched.h>
+#include <linux/fs.h>
+#include <linux/file.h>
+#include <linux/mm.h>
+#include <linux/mman.h>
+#include <linux/vmalloc.h>
+#include <linux/iobuf.h>
+#include <linux/slab.h>
+#include <linux/timer.h>
+#include <linux/brlock.h>
+#include <linux/aio.h>
+#include <linux/smp_lock.h>
+#include <linux/compiler.h>
+#include <linux/brlock.h>
+#include <linux/module.h>
+
+#include <asm/uaccess.h>
+#include <linux/highmem.h>
+
+#if DEBUG > 1
+#define dprintk		printk
+#else
+#define dprintk(x...)	do { ; } while (0)
+#endif
+
+/*------ sysctl variables----*/
+atomic_t aio_nr = ATOMIC_INIT(0);	/* current system wide number of aio requests */
+unsigned aio_max_nr = 0x10000;	/* system wide maximum number of aio requests */
+/*----end sysctl variables---*/
+
+static kmem_cache_t	*kiocb_cachep;
+static kmem_cache_t	*kioctx_cachep;
+
+/* Used for rare fput completion. */
+static void aio_fput_routine(void *);
+static struct tq_struct	fput_tqueue = {
+	routine:	aio_fput_routine,
+};
+
+static spinlock_t	fput_lock = SPIN_LOCK_UNLOCKED;
+LIST_HEAD(fput_head);
+
+/* aio_setup
+ *	Creates the slab caches used by the aio routines, panic on
+ *	failure as this is done early during the boot sequence.
+ */
+static int __init aio_setup(void)
+{
+	kiocb_cachep = kmem_cache_create("kiocb", sizeof(struct kiocb),
+				0, SLAB_HWCACHE_ALIGN, NULL, NULL);
+	if (!kiocb_cachep)
+		panic("unable to create kiocb cache\n");
+
+	kioctx_cachep = kmem_cache_create("kioctx", sizeof(struct kioctx),
+				0, SLAB_HWCACHE_ALIGN, NULL, NULL);
+	if (!kioctx_cachep)
+		panic("unable to create kioctx cache");
+
+	printk(KERN_NOTICE "aio_setup: sizeof(struct page) = %d\n", (int)sizeof(struct page));
+
+	return 0;
+}
+
+static void ioctx_free_reqs(struct kioctx *ctx)
+{
+	struct list_head *pos, *next;
+	list_for_each_safe(pos, next, &ctx->free_reqs) {
+		struct kiocb *iocb = list_kiocb(pos);
+		list_del(&iocb->ki_list);
+		kmem_cache_free(kiocb_cachep, iocb);
+	}
+}
+
+static void aio_free_ring(struct kioctx *ctx)
+{
+	struct aio_ring_info *info = &ctx->ring_info;
+	long i;
+
+	for (i=0; i<info->nr_pages; i++)
+		put_page(info->ring_pages[i]);
+
+	if (info->mmap_size) {
+		down_write(&ctx->mm->mmap_sem);
+		do_munmap(ctx->mm, info->mmap_base, info->mmap_size);
+		up_write(&ctx->mm->mmap_sem);
+	}
+
+	if (info->ring_pages && info->ring_pages != info->internal_pages)
+		kfree(info->ring_pages);
+	info->ring_pages = NULL;
+	info->nr = 0;
+}
+
+static int aio_setup_ring(struct kioctx *ctx)
+{
+	struct aio_ring *ring;
+	struct aio_ring_info *info = &ctx->ring_info;
+	unsigned nr_reqs = ctx->max_reqs;
+	unsigned long size;
+	int nr_pages;
+
+	/* Compensate for the ring buffer's head/tail overlap entry */
+	nr_reqs += 2;	/* 1 is required, 2 for good luck */
+
+	size = sizeof(struct aio_ring);
+	size += sizeof(struct io_event) * nr_reqs;
+	nr_pages = (size + PAGE_SIZE-1) >> PAGE_SHIFT;
+
+	if (nr_pages < 0)
+		return -EINVAL;
+
+	info->nr_pages = nr_pages;
+
+	nr_reqs = (PAGE_SIZE * nr_pages - sizeof(struct aio_ring)) / sizeof(struct io_event);
+
+	info->nr = 0;
+	info->ring_pages = info->internal_pages;
+	if (nr_pages > AIO_RING_PAGES) {
+		info->ring_pages = kmalloc(sizeof(struct page *) * nr_pages, GFP_KERNEL);
+		if (!info->ring_pages)
+			return -ENOMEM;
+		memset(info->ring_pages, 0, sizeof(struct page *) * nr_pages);
+	}
+
+	info->mmap_size = nr_pages * PAGE_SIZE;
+	dprintk("attempting mmap of %lu bytes\n", info->mmap_size);
+	down_write(&ctx->mm->mmap_sem);
+	info->mmap_base = do_mmap(NULL, 0, info->mmap_size, 
+				  PROT_READ|PROT_WRITE, MAP_ANON|MAP_PRIVATE,
+				  0);
+	if (IS_ERR((void *)info->mmap_base)) {
+		up_write(&ctx->mm->mmap_sem);
+		printk("mmap err: %ld\n", -info->mmap_base);
+		info->mmap_size = 0;
+		aio_free_ring(ctx);
+		return -EAGAIN;
+	}
+
+	dprintk("mmap address: 0x%08lx\n", info->mmap_base);
+	info->nr_pages = get_user_pages(current, ctx->mm,
+					info->mmap_base, info->mmap_size, 
+					1, 0, info->ring_pages, NULL);
+	up_write(&ctx->mm->mmap_sem);
+
+	if (unlikely(info->nr_pages != nr_pages)) {
+		aio_free_ring(ctx);
+		return -EAGAIN;
+	}
+
+	ctx->user_id = info->mmap_base;
+
+	info->nr = nr_reqs;		/* trusted copy */
+
+	ring = kmap_atomic(info->ring_pages[0], KM_USER0);
+	ring->nr = nr_reqs;	/* user copy */
+	ring->id = ctx->user_id;
+	ring->head = ring->tail = 0;
+	ring->magic = AIO_RING_MAGIC;
+	ring->compat_features = AIO_RING_COMPAT_FEATURES;
+	ring->incompat_features = AIO_RING_INCOMPAT_FEATURES;
+	ring->header_length = sizeof(struct aio_ring);
+	kunmap_atomic(ring, KM_USER0);
+
+	return 0;
+}
+
+/* aio_ring_event: returns a pointer to the event at the given index from
+ * kmap_atomic(, km).  Release the pointer with put_aio_ring_event();
+ */
+static inline struct io_event *aio_ring_event(struct aio_ring_info *info, int nr, enum km_type km)
+{
+	struct io_event *events;
+#define AIO_EVENTS_PER_PAGE	(PAGE_SIZE / sizeof(struct io_event))
+#define AIO_EVENTS_FIRST_PAGE	((PAGE_SIZE - sizeof(struct aio_ring)) / sizeof(struct io_event))
+
+	if (nr < AIO_EVENTS_FIRST_PAGE) {
+		struct aio_ring *ring;
+		ring = kmap_atomic(info->ring_pages[0], km);
+		return &ring->io_events[nr];
+	}
+	nr -= AIO_EVENTS_FIRST_PAGE;
+
+	events = kmap_atomic(info->ring_pages[1 + nr / AIO_EVENTS_PER_PAGE], km);
+
+	return events + (nr % AIO_EVENTS_PER_PAGE);
+}
+
+static inline void put_aio_ring_event(struct io_event *event, enum km_type km)
+{
+	void *p = (void *)((unsigned long)event & PAGE_MASK);
+	kunmap_atomic(p, km);
+}
+
+/* ioctx_alloc
+ *	Allocates and initializes an ioctx.  Returns an ERR_PTR if it failed.
+ */
+static struct kioctx *ioctx_alloc(unsigned nr_reqs)
+{
+	struct mm_struct *mm;
+	struct kioctx *ctx;
+	unsigned i;
+
+	/* Prevent overflows */
+	if ((nr_reqs > (0x10000000U / sizeof(struct io_event))) ||
+	    (nr_reqs > (0x10000000U / sizeof(struct kiocb)))) {
+		pr_debug("ENOMEM: nr_reqs too high\n");
+		return ERR_PTR(-EINVAL);
+	}
+
+	if (nr_reqs > aio_max_nr)
+		return ERR_PTR(-EAGAIN);
+
+	ctx = kmem_cache_alloc(kioctx_cachep, GFP_KERNEL);
+	if (!ctx)
+		return ERR_PTR(-ENOMEM);
+
+	memset(ctx, 0, sizeof(*ctx));
+	ctx->max_reqs = nr_reqs;
+	mm = ctx->mm = current->mm;
+	atomic_inc(&mm->mm_count);
+
+	atomic_set(&ctx->users, 1);
+	spin_lock_init(&ctx->ctx_lock);
+	spin_lock_init(&ctx->ring_info.ring_lock);
+	init_waitqueue_head(&ctx->wait);
+
+	INIT_LIST_HEAD(&ctx->free_reqs);
+	INIT_LIST_HEAD(&ctx->active_reqs);
+
+	if (aio_setup_ring(ctx) < 0)
+		goto out_freectx;
+
+	/* Allocate nr_reqs iocbs for io.  Free iocbs are on the 
+	 * ctx->free_reqs list.  When active they migrate to the 
+	 * active_reqs list.  During completion and cancellation 
+	 * the request may temporarily not be on any list.
+	 */
+	for (i=0; i<nr_reqs; i++) {
+		struct kiocb *iocb = kmem_cache_alloc(kiocb_cachep, GFP_KERNEL);
+		if (!iocb)
+			goto out_freering;
+		memset(iocb, 0, sizeof(*iocb));
+		iocb->ki_key = i;
+		iocb->ki_users = 0;
+		list_add(&iocb->ki_list, &ctx->free_reqs);
+	}
+
+	/* now link into global list.  kludge.  FIXME */
+	atomic_add(ctx->max_reqs, &aio_nr);	/* undone by __put_ioctx */
+	if (unlikely(atomic_read(&aio_nr) > aio_max_nr))
+		goto out_cleanup;
+	write_lock(&mm->ioctx_list_lock);
+	ctx->next = mm->ioctx_list;
+	mm->ioctx_list = ctx;
+	write_unlock(&mm->ioctx_list_lock);
+
+	dprintk("aio: allocated ioctx %p[%ld]: mm=%p mask=0x%x\n",
+		ctx, ctx->user_id, current->mm, ctx->ring_info.ring->nr);
+	return ctx;
+
+out_cleanup:
+	atomic_sub(ctx->max_reqs, &aio_nr);	/* undone by __put_ioctx */
+	ctx->max_reqs = 0;	/* prevent __put_ioctx from sub'ing aio_nr */
+	__put_ioctx(ctx);
+	return ERR_PTR(-EAGAIN);
+
+out_freering:
+	aio_free_ring(ctx);
+	ioctx_free_reqs(ctx);
+out_freectx:
+	kmem_cache_free(kioctx_cachep, ctx);
+	ctx = ERR_PTR(-ENOMEM);
+
+	dprintk("aio: error allocating ioctx %p\n", ctx);
+	return ctx;
+}
+
+/* aio_cancel_all
+ *	Cancels all outstanding aio requests on an aio context.  Used 
+ *	when the processes owning a context have all exited to encourage 
+ *	the rapid destruction of the kioctx.
+ */
+static void aio_cancel_all(struct kioctx *ctx)
+{
+	int (*cancel)(struct kiocb *, struct io_event *);
+	struct io_event res;
+	spin_lock_irq(&ctx->ctx_lock);
+	ctx->dead = 1;
+	while (!list_empty(&ctx->active_reqs)) {
+		struct list_head *pos = ctx->active_reqs.next;
+		struct kiocb *iocb = list_kiocb(pos);
+		list_del_init(&iocb->ki_list);
+		cancel = iocb->ki_cancel;
+		if (cancel)
+			iocb->ki_users++;
+		spin_unlock_irq(&ctx->ctx_lock);
+		if (cancel)
+			cancel(iocb, &res);
+		spin_lock_irq(&ctx->ctx_lock);
+	}
+	spin_unlock_irq(&ctx->ctx_lock);
+}
+
+void wait_for_all_aios(struct kioctx *ctx)
+{
+	struct task_struct *tsk = current;
+	DECLARE_WAITQUEUE(wait, tsk);
+
+	if (!ctx->reqs_active)
+		return;
+
+	add_wait_queue(&ctx->wait, &wait);
+	set_task_state(tsk, TASK_UNINTERRUPTIBLE);
+	while (ctx->reqs_active) {
+		printk("ctx->reqs_active = %d\n", ctx->reqs_active);
+		schedule();
+		set_task_state(tsk, TASK_UNINTERRUPTIBLE);
+	}
+	set_task_state(tsk, TASK_RUNNING);
+	remove_wait_queue(&ctx->wait, &wait);
+}
+
+/* exit_aio: called when the last user of mm goes away.  At this point, 
+ * there is no way for any new requests to be submited or any of the 
+ * io_* syscalls to be called on the context.  However, there may be 
+ * outstanding requests which hold references to the context; as they 
+ * go away, they will call put_ioctx and release any pinned memory
+ * associated with the request (held via struct page * references).
+ */
+void exit_aio(struct mm_struct *mm)
+{
+	struct kioctx *ctx = mm->ioctx_list;
+	mm->ioctx_list = NULL;
+	while (ctx) {
+		struct kioctx *next = ctx->next;
+		ctx->next = NULL;
+		aio_cancel_all(ctx);
+
+		wait_for_all_aios(ctx);
+
+		if (1 != atomic_read(&ctx->users))
+			printk(KERN_DEBUG
+				"exit_aio:ioctx still alive: %d %d %d\n",
+				atomic_read(&ctx->users), ctx->dead,
+				ctx->reqs_active);
+		put_ioctx(ctx);
+		ctx = next;
+	}
+}
+
+/* __put_ioctx
+ *	Called when the last user of an aio context has gone away,
+ *	and the struct needs to be freed.
+ */
+void __put_ioctx(struct kioctx *ctx)
+{
+	unsigned nr_reqs = ctx->max_reqs;
+
+	if (unlikely(ctx->reqs_active))
+		BUG();
+
+	aio_free_ring(ctx);
+	mmdrop(ctx->mm);
+	ctx->mm = NULL;
+	pr_debug("__put_ioctx: freeing %p\n", ctx);
+	ioctx_free_reqs(ctx);
+	kmem_cache_free(kioctx_cachep, ctx);
+
+	atomic_sub(nr_reqs, &aio_nr);
+}
+
+/* aio_get_req
+ *	Allocate a slot for an aio request.  Increments the users count
+ * of the kioctx so that the kioctx stays around until all requests are
+ * complete.  Returns -EAGAIN if no requests are free.
+ */
+static struct kiocb *FASTCALL(__aio_get_req(struct kioctx *ctx));
+static struct kiocb *__aio_get_req(struct kioctx *ctx)
+{
+	struct kiocb *req = NULL;
+	struct aio_ring *ring;
+
+	/* Check if the completion queue has enough free space to
+	 * accept an event from this io.
+	 */
+	spin_lock_irq(&ctx->ctx_lock);
+	ring = kmap_atomic(ctx->ring_info.ring_pages[0], KM_USER0);
+	if (likely(!list_empty(&ctx->free_reqs) &&
+	    (ctx->reqs_active < aio_ring_avail(&ctx->ring_info, ring)))) {
+		req = list_kiocb(ctx->free_reqs.next);
+		list_del(&req->ki_list);
+		list_add(&req->ki_list, &ctx->active_reqs);
+		ctx->reqs_active++;
+		req->ki_user_obj = NULL;
+		get_ioctx(ctx);
+
+		if (unlikely(req->ki_ctx != NULL))
+			BUG();
+		req->ki_ctx = ctx;
+		if (unlikely(req->ki_users))
+			BUG();
+		req->ki_users = 1;
+	}
+	kunmap_atomic(ring, KM_USER0);
+	spin_unlock_irq(&ctx->ctx_lock);
+
+	return req;
+}
+
+static inline struct kiocb *aio_get_req(struct kioctx *ctx)
+{
+	struct kiocb *req;
+	/* Handle a potential starvation case -- should be exceedingly rare as 
+	 * requests will be stuck on fput_head only if the aio_fput_routine is 
+	 * delayed and the requests were the last user of the struct file.
+	 */
+	req = __aio_get_req(ctx);
+	if (unlikely(NULL == req)) {
+		aio_fput_routine(NULL);
+		req = __aio_get_req(ctx);
+	}
+	return req;
+}
+
+static inline void really_put_req(struct kioctx *ctx, struct kiocb *req)
+{
+	req->ki_ctx = NULL;
+	req->ki_filp = NULL;
+	req->ki_user_obj = NULL;
+	ctx->reqs_active--;
+	list_add(&req->ki_list, &ctx->free_reqs);
+
+	if (unlikely(!ctx->reqs_active && ctx->dead))
+		wake_up(&ctx->wait);
+}
+
+static void aio_fput_routine(void *data)
+{
+	spin_lock_irq(&fput_lock);
+	while (likely(!list_empty(&fput_head))) {
+		struct kiocb *req = list_kiocb(fput_head.next);
+		struct kioctx *ctx = req->ki_ctx;
+
+		list_del(&req->ki_list);
+		spin_unlock_irq(&fput_lock);
+
+		/* Complete the fput */
+		__fput(req->ki_filp);
+
+		/* Link the iocb into the context's free list */
+		spin_lock_irq(&ctx->ctx_lock);
+		really_put_req(ctx, req);
+		spin_unlock_irq(&ctx->ctx_lock);
+
+		put_ioctx(ctx);
+		spin_lock_irq(&fput_lock);
+	}
+	spin_unlock_irq(&fput_lock);
+}
+
+/* __aio_put_req
+ *	Returns true if this put was the last user of the request.
+ */
+static inline int __aio_put_req(struct kioctx *ctx, struct kiocb *req)
+{
+	dprintk(KERN_DEBUG "aio_put(%p): f_count=%d\n",
+		req, atomic_read(&req->ki_filp->f_count));
+
+	req->ki_users --;
+	if (unlikely(req->ki_users < 0))
+		BUG();
+	if (likely(req->ki_users))
+		return 0;
+	list_del(&req->ki_list);		/* remove from active_reqs */
+	req->ki_cancel = NULL;
+
+	/* Must be done under the lock to serialise against cancellation.
+	 * Call this aio_fput as it duplicates fput via the fput_tqueue.
+	 */
+	if (unlikely(atomic_dec_and_test(&req->ki_filp->f_count))) {
+		get_ioctx(ctx);
+		spin_lock(&fput_lock);
+		list_add(&req->ki_list, &fput_head);
+		spin_unlock(&fput_lock);
+		schedule_task(&fput_tqueue);
+	} else
+		really_put_req(ctx, req);
+	return 1;
+}
+
+/* aio_put_req
+ *	Returns true if this put was the last user of the kiocb,
+ *	false if the request is still in use.
+ */
+int aio_put_req(struct kiocb *req)
+{
+	struct kioctx *ctx = req->ki_ctx;
+	int ret;
+	spin_lock_irq(&ctx->ctx_lock);
+	ret = __aio_put_req(ctx, req);
+	spin_unlock_irq(&ctx->ctx_lock);
+	if (ret)
+		put_ioctx(ctx);
+	return ret;
+}
+
+/*	Lookup an ioctx id.  ioctx_list is lockless for reads.
+ *	FIXME: this is O(n) and is only suitable for development.
+ */
+static inline struct kioctx *lookup_ioctx(unsigned long ctx_id)
+{
+	struct kioctx *ioctx;
+	struct mm_struct *mm;
+
+	mm = current->mm;
+	read_lock(&mm->ioctx_list_lock);
+	for (ioctx = mm->ioctx_list; ioctx; ioctx = ioctx->next)
+		if (likely(ioctx->user_id == ctx_id && !ioctx->dead)) {
+			get_ioctx(ioctx);
+			break;
+		}
+	read_unlock(&mm->ioctx_list_lock);
+
+	return ioctx;
+}
+
+/* aio_complete
+ *	Called when the io request on the given iocb is complete.
+ *	Returns true if this is the last user of the request.  The 
+ *	only other user of the request can be the cancellation code.
+ */
+int aio_complete(struct kiocb *iocb, long res, long res2)
+{
+	struct kioctx	*ctx = iocb->ki_ctx;
+	struct aio_ring_info	*info = &ctx->ring_info;
+	struct aio_ring	*ring;
+	struct io_event	*event;
+	unsigned long	flags;
+	unsigned long	tail;
+	int		ret;
+
+	/* add a completion event to the ring buffer.
+	 * must be done holding ctx->ctx_lock to prevent
+	 * other code from messing with the tail
+	 * pointer since we might be called from irq
+	 * context.
+	 */
+	spin_lock_irqsave(&ctx->ctx_lock, flags);
+
+	ring = kmap_atomic(info->ring_pages[0], KM_IRQ1);
+
+	tail = info->tail;
+	event = aio_ring_event(info, tail, KM_IRQ0);
+	tail = (tail + 1) % info->nr;
+
+	event->obj = (u64)(unsigned long)iocb->ki_user_obj;
+	event->data = iocb->ki_user_data;
+	event->res = res;
+	event->res2 = res2;
+
+	dprintk("aio_complete: %p[%lu]: %p: %p %Lx %lx %lx\n",
+		ctx, tail, iocb, iocb->ki_user_obj, iocb->ki_user_data,
+		res, res2);
+
+	/* after flagging the request as done, we
+	 * must never even look at it again
+	 */
+	barrier();
+
+	info->tail = tail;
+	ring->tail = tail;
+
+	wmb();
+	put_aio_ring_event(event, KM_IRQ0);
+	kunmap_atomic(ring, KM_IRQ1);
+
+	pr_debug("added to ring %p at [%lu]\n", iocb, tail);
+
+	/* everything turned out well, dispose of the aiocb. */
+	ret = __aio_put_req(ctx, iocb);
+
+	spin_unlock_irqrestore(&ctx->ctx_lock, flags);
+
+	if (waitqueue_active(&ctx->wait))
+		wake_up(&ctx->wait);
+
+	if (ret)
+		put_ioctx(ctx);
+
+	return ret;
+}
+
+/* aio_read_evt
+ *	Pull an event off of the ioctx's event ring.  Returns the number of 
+ *	events fetched (0 or 1 ;-)
+ *	FIXME: make this use cmpxchg.
+ *	TODO: make the ringbuffer user mmap()able (requires FIXME).
+ */
+static int aio_read_evt(struct kioctx *ioctx, struct io_event *ent)
+{
+	struct aio_ring_info *info = &ioctx->ring_info;
+	struct aio_ring *ring;
+	unsigned long head;
+	int ret = 0;
+
+	ring = kmap_atomic(info->ring_pages[0], KM_USER0);
+	dprintk("in aio_read_evt h%lu t%lu m%lu\n",
+		 (unsigned long)ring->head, (unsigned long)ring->tail,
+		 (unsigned long)ring->nr);
+	barrier();
+	if (ring->head == ring->tail)
+		goto out;
+
+	spin_lock(&info->ring_lock);
+
+	head = ring->head % info->nr;
+	if (head != ring->tail) {
+		struct io_event *evp = aio_ring_event(info, head, KM_USER1);
+		*ent = *evp;
+		head = (head + 1) % info->nr;
+		barrier();
+		ring->head = head;
+		ret = 1;
+		put_aio_ring_event(evp, KM_USER1);
+	}
+	spin_unlock(&info->ring_lock);
+
+out:
+	kunmap_atomic(ring, KM_USER0);
+	dprintk("leaving aio_read_evt: %d  h%lu t%lu\n", ret,
+		 (unsigned long)ring->head, (unsigned long)ring->tail);
+	return ret;
+}
+
+struct timeout {
+	struct timer_list	timer;
+	int			timed_out;
+	struct task_struct	*p;
+};
+
+static void timeout_func(unsigned long data)
+{
+	struct timeout *to = (struct timeout *)data;
+
+	to->timed_out = 1;
+	wake_up_process(to->p);
+}
+
+static inline void init_timeout(struct timeout *to)
+{
+	init_timer(&to->timer);
+	to->timer.data = (unsigned long)to;
+	to->timer.function = timeout_func;
+	to->timed_out = 0;
+	to->p = current;
+}
+
+static inline void ts_subtract_now(struct timespec *ts)
+{
+	struct timeval tv;
+	do_gettimeofday(&tv);
+	ts->tv_sec -= tv.tv_sec;
+	ts->tv_nsec -= tv.tv_usec * 1000;
+	if (ts->tv_nsec < 0) {
+		ts->tv_nsec += 1000000000;
+		ts->tv_sec --;
+	}
+}
+
+static inline void set_timeout(struct timeout *to, const struct timespec *ts)
+{
+	unsigned long how_long;
+
+	if (ts->tv_sec < 0 || (!ts->tv_sec && !ts->tv_nsec)) {
+		to->timed_out = 1;
+		return;
+	}
+
+	how_long = ts->tv_sec * HZ;
+#define HZ_NS (1000000000 / HZ)
+	how_long += (ts->tv_nsec + HZ_NS - 1) / HZ_NS;
+	
+	to->timer.expires = jiffies + how_long;
+	add_timer(&to->timer);
+}
+
+static inline void clear_timeout(struct timeout *to)
+{
+	del_timer_sync(&to->timer);
+}
+
+static int read_events(struct kioctx *ctx, int nr, struct io_event *event,
+			const struct timespec *timeout)
+{
+	struct task_struct	*tsk = current;
+	DECLARE_WAITQUEUE(wait, tsk);
+	int			ret;
+	int			i = 0;
+	struct io_event		ent;
+	struct timeout		to;
+
+	/* needed to zero any padding within an entry (there shouldn't be 
+	 * any, but C is fun!
+	 */
+	memset(&ent, 0, sizeof(ent));
+	ret = 0;
+
+	while (likely(i < nr)) {
+		ret = aio_read_evt(ctx, &ent);
+		if (unlikely(ret <= 0))
+			break;
+
+		dprintk("read event: %Lx %Lx %Lx %Lx\n",
+			ent.data, ent.obj, ent.res, ent.res2);
+
+		/* Could we split the check in two? */
+		ret = -EFAULT;
+		if (unlikely(copy_to_user(event, &ent, sizeof(ent)))) {
+			dprintk("aio: lost an event due to EFAULT.\n");
+			break;
+		}
+		ret = 0;
+
+		/* Good, event copied to userland, update counts. */
+		event ++;
+		i ++;
+	}
+
+	if (i)
+		return i;
+	if (ret)
+		return ret;
+
+	/* End fast path */
+
+	if (timeout) {
+		struct timespec	ts;
+		ret = -EFAULT;
+		if (unlikely(copy_from_user(&ts, timeout, sizeof(ts))))
+			goto out;
+
+		ts_subtract_now(&ts);
+		init_timeout(&to);
+		set_timeout(&to, &ts);
+		if (to.timed_out)
+			timeout = 0;
+	}
+
+	while (likely(i < nr)) {
+		add_wait_queue_exclusive(&ctx->wait, &wait);
+		do {
+			set_task_state(tsk, TASK_INTERRUPTIBLE);
+
+			ret = aio_read_evt(ctx, &ent);
+			if (ret)
+				break;
+			if (i)
+				break;
+			ret = 0;
+			if (to.timed_out)	/* Only check after read evt */
+				break;
+			schedule();
+			if (signal_pending(tsk)) {
+				ret = -EINTR;
+				break;
+			}
+			/*ret = aio_read_evt(ctx, &ent);*/
+		} while (1) ;
+
+		set_task_state(tsk, TASK_RUNNING);
+		remove_wait_queue(&ctx->wait, &wait);
+
+		if (unlikely(ret <= 0))
+			break;
+
+		ret = -EFAULT;
+		if (unlikely(copy_to_user(event, &ent, sizeof(ent)))) {
+			dprintk("aio: lost an event due to EFAULT.\n");
+			break;
+		}
+
+		/* Good, event copied to userland, update counts. */
+		event ++;
+		i ++;
+	}
+
+	if (timeout)
+		clear_timeout(&to);
+out:
+	return i ? i : ret;
+}
+
+/* Take an ioctx and remove it from the list of ioctx's.  Protects 
+ * against races with itself via ->dead.
+ */
+static void io_destroy(struct kioctx *ioctx)
+{
+	struct mm_struct *mm = current->mm;
+	struct kioctx **tmp;
+	int was_dead;
+
+	/* delete the entry from the list is someone else hasn't already */
+	write_lock(&mm->ioctx_list_lock);
+	was_dead = ioctx->dead;
+	ioctx->dead = 1;
+	for (tmp = &mm->ioctx_list; *tmp && *tmp != ioctx;
+	     tmp = &(*tmp)->next)
+		;
+	if (*tmp)
+		*tmp = ioctx->next;
+	write_unlock(&mm->ioctx_list_lock);
+
+	dprintk("aio_release(%p)\n", ioctx);
+	if (likely(!was_dead))
+		put_ioctx(ioctx);	/* twice for the list */
+
+	aio_cancel_all(ioctx);
+	wait_for_all_aios(ioctx);
+	put_ioctx(ioctx);	/* once for the lookup */
+}
+
+asmlinkage long sys_io_setup(unsigned nr_reqs, aio_context_t *ctxp)
+{
+	struct kioctx *ioctx = NULL;
+	unsigned long ctx;
+	long ret;
+
+	ret = get_user(ctx, ctxp);
+	if (unlikely(ret))
+		goto out;
+
+	ret = -EINVAL;
+	if (unlikely(ctx || !nr_reqs || (int)nr_reqs < 0)) {
+		pr_debug("EINVAL: io_setup: ctx or nr_reqs > max\n");
+		goto out;
+	}
+
+	ioctx = ioctx_alloc(nr_reqs);
+	ret = PTR_ERR(ioctx);
+	if (!IS_ERR(ioctx)) {
+		ret = put_user(ioctx->user_id, ctxp);
+		if (!ret)
+			return 0;
+		io_destroy(ioctx);
+	}
+
+out:
+	return ret;
+}
+
+/* aio_release
+ *	Release the kioctx associated with the userspace handle.
+ */
+asmlinkage long sys_io_destroy(aio_context_t ctx)
+{
+	struct kioctx *ioctx = lookup_ioctx(ctx);
+	if (likely(NULL != ioctx)) {
+		io_destroy(ioctx);
+		return 0;
+	}
+	pr_debug("EINVAL: io_destroy: invalid context id\n");
+	return -EINVAL;
+}
+
+static int FASTCALL(io_submit_one(struct kioctx *ctx, struct iocb *user_iocb,
+				  struct iocb *iocb));
+static int io_submit_one(struct kioctx *ctx, struct iocb *user_iocb,
+			 struct iocb *iocb)
+{
+	struct kiocb *req;
+	struct file *file;
+	ssize_t ret;
+	char *buf;
+
+	/* enforce forwards compatibility on users */
+	if (unlikely(iocb->aio_reserved1 || iocb->aio_reserved2 ||
+		     iocb->aio_reserved3)) {
+		pr_debug("EINVAL: io_submit: reserve field set\n");
+		return -EINVAL;
+	}
+
+	/* prevent overflows */
+	if (unlikely(
+	    (iocb->aio_buf != (unsigned long)iocb->aio_buf) ||
+	    (iocb->aio_nbytes != (size_t)iocb->aio_nbytes) ||
+	    ((ssize_t)iocb->aio_nbytes < 0)
+	   )) {
+		pr_debug("EINVAL: io_submit: overflow check\n");
+		return -EINVAL;
+	}
+
+	file = fget(iocb->aio_fildes);
+	if (unlikely(!file))
+		return -EBADF;
+
+	req = aio_get_req(ctx);
+	if (unlikely(!req)) {
+		fput(file);
+		return -EAGAIN;
+	}
+
+	req->ki_filp = file;
+	iocb->aio_key = req->ki_key;
+	ret = put_user(iocb->aio_key, &user_iocb->aio_key);
+	if (unlikely(ret)) {
+		dprintk("EFAULT: aio_key\n");
+		goto out_put_req;
+	}
+
+	req->ki_user_obj = user_iocb;
+	req->ki_user_data = iocb->aio_data;
+
+	buf = (char *)(unsigned long)iocb->aio_buf;
+
+	switch (iocb->aio_lio_opcode) {
+	case IOCB_CMD_PREAD:
+		ret = -EBADF;
+		if (unlikely(!(file->f_mode & FMODE_READ)))
+			goto out_put_req;
+		ret = -EFAULT;
+		if (unlikely(!access_ok(VERIFY_WRITE, buf, iocb->aio_nbytes)))
+			goto out_put_req;
+		ret = -EINVAL;
+		if (file->f_op->aio_write)
+			ret = file->f_op->aio_read(req, buf,
+					iocb->aio_nbytes, iocb->aio_offset);
+		break;
+	case IOCB_CMD_PWRITE:
+		ret = -EBADF;
+		if (unlikely(!(file->f_mode & FMODE_WRITE)))
+			goto out_put_req;
+		ret = -EFAULT;
+		if (unlikely(!access_ok(VERIFY_READ, buf, iocb->aio_nbytes)))
+			goto out_put_req;
+		ret = -EINVAL;
+		if (file->f_op->aio_write)
+			ret = file->f_op->aio_write(req, buf,
+					iocb->aio_nbytes, iocb->aio_offset);
+		break;
+	case IOCB_CMD_FDSYNC:
+		ret = -EINVAL;
+		if (file->f_op->aio_fsync)
+			ret = file->f_op->aio_fsync(req, 1);
+		break;
+	case IOCB_CMD_FSYNC:
+		ret = -EINVAL;
+		if (file->f_op->aio_fsync)
+			ret = file->f_op->aio_fsync(req, 0);
+		break;
+	default:
+		dprintk("EINVAL: io_submit: no operation provided\n");
+		ret = -EINVAL;
+	}
+
+	if (likely(EIOCBQUEUED == ret))
+		return 0;
+	if (ret >= 0) {
+		aio_complete(req, ret, 0);
+		return 0;
+	}
+
+out_put_req:
+	aio_put_req(req);
+	return ret;
+}
+
+/* sys_io_submit
+ *	Copy an aiocb from userspace into kernel space, then convert it to
+ *	a kiocb, submit and repeat until done.  Error codes on copy/submit
+ *	only get returned for the first aiocb copied as otherwise the size
+ *	of aiocbs copied is returned (standard write sematics).
+ */
+asmlinkage long sys_io_submit(aio_context_t ctx_id, long nr, struct iocb **iocbpp)
+{
+	struct kioctx *ctx;
+	long ret = 0;
+	int i;
+
+	if (unlikely(nr < 0))
+		return -EINVAL;
+
+	if (unlikely(!access_ok(VERIFY_READ, iocbpp, (nr*sizeof(*iocbpp)))))
+		return -EFAULT;
+
+	ctx = lookup_ioctx(ctx_id);
+	if (unlikely(!ctx)) {
+		pr_debug("EINVAL: io_submit: invalid context id\n");
+		return -EINVAL;
+	}
+
+	for (i=0; i<nr; i++) {
+		struct iocb *user_iocb, tmp;
+
+		if (unlikely(__get_user(user_iocb, iocbpp + i))) {
+			ret = -EFAULT;
+			break;
+		}
+
+		if (unlikely(__copy_from_user(&tmp, user_iocb, sizeof(tmp)))) {
+			ret = -EFAULT;
+			break;
+		}
+
+		ret = io_submit_one(ctx, user_iocb, &tmp);
+		if (ret)
+			break;
+	}
+
+	put_ioctx(ctx);
+	return i ? i : ret;
+}
+
+/* lookup_kiocb
+ *	Finds a given iocb for cancellation.
+ *	MUST be called with ctx->ctx_lock held.
+ */
+struct kiocb *lookup_kiocb(struct kioctx *ctx, struct iocb *iocb, u32 key)
+{
+	struct list_head *pos;
+	/* TODO: use a hash or array, this sucks. */
+	list_for_each(pos, &ctx->free_reqs) {
+		struct kiocb *kiocb = list_kiocb(pos);
+		if (kiocb->ki_user_obj == iocb && kiocb->ki_key == key)
+			return kiocb;
+	}
+	return NULL;
+}
+
+/* sys_io_cancel
+ *	Cancels the io previously submitted via iocb.  If successful,
+ *	returns 0 and places the resulting event in res.  Otherwise, 
+ *	return -somerror.
+ */
+asmlinkage long sys_io_cancel(aio_context_t ctx_id, struct iocb *iocb,
+				struct io_event *u_res)
+{
+	int (*cancel)(struct kiocb *iocb, struct io_event *res);
+	struct kioctx *ctx;
+	struct kiocb *kiocb;
+	struct io_event result;
+	u32 key;
+	int ret;
+
+	ret = get_user(key, &iocb->aio_key);
+	if (unlikely(ret))
+		return -EFAULT;
+
+	ctx = lookup_ioctx(ctx_id);
+	if (unlikely(!ctx))
+		return -EINVAL;
+
+	spin_lock_irq(&ctx->ctx_lock);
+	ret = -EAGAIN;
+	kiocb = lookup_kiocb(ctx, iocb, key);
+	if (kiocb && kiocb->ki_cancel) {
+		cancel = kiocb->ki_cancel;
+		kiocb->ki_users ++;
+	} else
+		cancel = NULL;
+	spin_unlock_irq(&ctx->ctx_lock);
+
+	if (NULL != cancel) {
+		printk("calling cancel\n");
+		ret = cancel(kiocb, &result);
+		if (!ret) {
+			/* Cancellation succeeded -- copy the result
+			 * into the user's buffer.
+			 */
+			if (copy_to_user(u_res, &result, sizeof(result)))
+				ret = -EFAULT;
+		}
+	} else
+		printk(KERN_DEBUG "iocb has no cancel operation\n");
+
+	put_ioctx(ctx);
+
+	return ret;
+}
+
+/* sys_io_getevnts:
+ *	Reads at most nr completion events into the array pointed to by
+ *	events from the io context ctx_id.  
+ */
+asmlinkage long sys_io_getevents_abs(aio_context_t ctx_id,
+				 long nr,
+				 struct io_event *events,
+				 const struct timespec *when)
+{
+	struct kioctx *ioctx = lookup_ioctx(ctx_id);
+	long ret = -EINVAL;
+
+	if (likely(NULL != ioctx)) {
+		ret = read_events(ioctx, nr, events, when);
+		put_ioctx(ioctx);
+	}
+
+	return ret;
+}
+
+/* vsys_io_getevents: runs in userspace to fetch what io events are 
+ * available.
+ */
+#if 0
+__attribute__((section(".vsyscall_text")))
+asmlinkage long vsys_io_getevents(aio_context_t ctx_id,
+				   long nr,
+				   struct io_event *events,
+				   const struct timespec *when)
+{
+	struct aio_ring	*ring = (struct aio_ring *)ctx_id;
+	long i = 0;
+
+	while (i < nr) {
+		unsigned head;
+
+		head = ring->head;
+		if (head == ring->tail)
+			break;
+
+		*events++ = ring->io_events[head];
+		head = (head + 1) % ring->nr;
+		ring->head = head;
+		i++;
+	}
+
+	if (i)
+		return i;
+	return vsys_io_getevents_slow(ctx_id, nr, events, when);
+}
+#endif
+
+__initcall(aio_setup);
+
+EXPORT_SYMBOL(aio_complete);
+EXPORT_SYMBOL(aio_put_req);
diff -urN v2.5.29/include/asm-i386/kmap_types.h aio-v2.5.29.diff/include/asm-i386/kmap_types.h
--- v2.5.29/include/asm-i386/kmap_types.h	Tue Jun 18 23:22:22 2002
+++ aio-v2.5.29.diff/include/asm-i386/kmap_types.h	Tue Jul 30 10:38:30 2002
@@ -19,7 +19,9 @@
 D(6)	KM_BIO_DST_IRQ,
 D(7)	KM_PTE0,
 D(8)	KM_PTE1,
-D(9)	KM_TYPE_NR
+D(9)	KM_IRQ0,
+D(10)	KM_IRQ1,
+D(11)	KM_TYPE_NR
 };
 
 #undef D
diff -urN v2.5.29/include/asm-i386/unistd.h aio-v2.5.29.diff/include/asm-i386/unistd.h
--- v2.5.29/include/asm-i386/unistd.h	Thu Jun  6 00:35:32 2002
+++ aio-v2.5.29.diff/include/asm-i386/unistd.h	Tue Jul 30 17:22:47 2002
@@ -247,6 +247,12 @@
 #define __NR_futex		240
 #define __NR_sched_setaffinity	241
 #define __NR_sched_getaffinity	242
+#define __NR_set_thread_area	243
+#define __NR_io_setup		244
+#define __NR_io_destroy		245
+#define __NR_io_getevents_abs	246
+#define __NR_io_submit		247
+#define __NR_io_cancel		248
 
 /* user-visible error numbers are in the range -1 - -124: see <asm-i386/errno.h> */
 
diff -urN v2.5.29/include/linux/aio.h aio-v2.5.29.diff/include/linux/aio.h
--- v2.5.29/include/linux/aio.h	Wed Dec 31 19:00:00 1969
+++ aio-v2.5.29.diff/include/linux/aio.h	Tue Jul 30 17:40:17 2002
@@ -0,0 +1,118 @@
+#ifndef __LINUX__AIO_H
+#define __LINUX__AIO_H
+
+#include <linux/tqueue.h>
+#include <linux/list.h>
+#include <asm/atomic.h>
+
+#include <linux/aio_abi.h>
+
+#define AIO_MAXSEGS		4
+#define AIO_KIOGRP_NR_ATOMIC	8
+
+struct kioctx;
+
+/* Notes on cancelling a kiocb:
+ *	If a kiocb is cancelled, aio_complete may return 0 to indicate 
+ *	that cancel has not yet disposed of the kiocb.  All cancel 
+ *	operations *must* call aio_put_req to dispose of the kiocb 
+ *	to guard against races with the completion code.
+ */
+#define KIOCB_C_CANCELLED	0x01
+#define KIOCB_C_COMPLETE	0x02
+
+struct kiocb {
+	struct list_head	ki_list;
+
+	struct file		*ki_filp;
+	void			*ki_data;	/* for use by the the file */
+
+	struct kioctx		*ki_ctx;
+	int			ki_users;
+
+	void			*ki_user_obj;
+	__u64			ki_user_data;
+
+	unsigned		ki_key;		/* id of this request */
+	int			(*ki_cancel)(struct kiocb *, struct io_event *);
+};
+
+#define AIO_RING_MAGIC			0xa10a10a1
+#define AIO_RING_COMPAT_FEATURES	1
+#define AIO_RING_INCOMPAT_FEATURES	0
+struct aio_ring {
+	unsigned	id;	/* kernel internal index number */
+	unsigned	nr;	/* number of io_events */
+	unsigned	head;
+	unsigned	tail;
+
+	unsigned	magic;
+	unsigned	compat_features;
+	unsigned	incompat_features;
+	unsigned	header_length;	/* size of aio_ring */
+
+
+	struct io_event		io_events[0];
+}; /* 128 bytes + ring size */
+
+#define aio_ring_avail(info, ring)	(((ring)->head + (info)->nr - 1 - (ring)->tail) % (info)->nr)
+
+#define AIO_RING_PAGES	8
+struct aio_ring_info {
+	unsigned long		mmap_base;
+	unsigned long		mmap_size;
+
+	struct page		**ring_pages;
+	spinlock_t		ring_lock;
+	long			nr_pages;
+
+	unsigned		nr, tail;
+
+	struct page		*internal_pages[AIO_RING_PAGES];
+};
+
+struct kioctx {
+	atomic_t		users;
+	int			dead;
+	struct mm_struct	*mm;
+
+	/* This needs improving */
+	unsigned long		user_id;
+	struct kioctx		*next;
+
+	wait_queue_head_t	wait;
+
+	spinlock_t		ctx_lock;
+
+	int			reqs_active;
+	struct list_head	free_reqs;
+	struct list_head	active_reqs;	/* used for cancellation */
+
+	unsigned		max_reqs;
+
+	struct aio_ring_info	ring_info;
+};
+
+/* prototypes */
+extern unsigned aio_max_size;
+
+extern int FASTCALL(aio_put_req(struct kiocb *iocb));
+extern int FASTCALL(aio_complete(struct kiocb *iocb, long res, long res2));
+extern void FASTCALL(__put_ioctx(struct kioctx *ctx));
+struct mm_struct;
+extern void FASTCALL(exit_aio(struct mm_struct *mm));
+
+#define get_ioctx(kioctx)	do { if (unlikely(atomic_read(&(kioctx)->users) <= 0)) BUG(); atomic_inc(&(kioctx)->users); } while (0)
+#define put_ioctx(kioctx)	do { if (unlikely(atomic_dec_and_test(&(kioctx)->users))) __put_ioctx(kioctx); else if (unlikely(atomic_read(&(kioctx)->users) < 0)) BUG(); } while (0)
+
+#include <linux/aio_abi.h>
+
+static inline struct kiocb *list_kiocb(struct list_head *h)
+{
+	return list_entry(h, struct kiocb, ki_list);
+}
+
+/* for sysctl: */
+extern unsigned aio_max_nr, aio_max_size, aio_max_pinned;
+
+#endif /* __LINUX__AIO_H */
diff -urN v2.5.29/include/linux/aio_abi.h aio-v2.5.29.diff/include/linux/aio_abi.h
--- v2.5.29/include/linux/aio_abi.h	Wed Dec 31 19:00:00 1969
+++ aio-v2.5.29.diff/include/linux/aio_abi.h	Tue Jul 30 17:37:40 2002
@@ -0,0 +1,89 @@
+/* linux/aio_abi.h
+ *
+ * Copyright 2000,2001,2002 Red Hat.
+ *
+ * Written by Benjamin LaHaise <bcrl@redhat.com>
+ *
+ * Permission to use, copy, modify, and distribute this software and its
+ * documentation is hereby granted, provided that the above copyright
+ * notice appears in all copies.  This software is provided without any
+ * warranty, express or implied.  Red Hat makes no representations about
+ * the suitability of this software for any purpose.
+ *
+ * IN NO EVENT SHALL RED HAT BE LIABLE TO ANY PARTY FOR DIRECT, INDIRECT,
+ * SPECIAL, INCIDENTAL, OR CONSEQUENTIAL DAMAGES ARISING OUT OF THE USE OF
+ * THIS SOFTWARE AND ITS DOCUMENTATION, EVEN IF RED HAT HAS BEEN ADVISED
+ * OF THE POSSIBILITY OF SUCH DAMAGE.
+ *
+ * RED HAT DISCLAIMS ANY WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE
+ * IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR
+ * PURPOSE.  THE SOFTWARE PROVIDED HEREUNDER IS ON AN "AS IS" BASIS, AND
+ * RED HAT HAS NO OBLIGATION TO PROVIDE MAINTENANCE, SUPPORT, UPDATES,
+ * ENHANCEMENTS, OR MODIFICATIONS.
+ */
+#ifndef __LINUX__AIO_ABI_H
+#define __LINUX__AIO_ABI_H
+
+#include <asm/byteorder.h>
+
+typedef unsigned long	aio_context_t;
+
+enum {
+	IOCB_CMD_PREAD = 0,
+	IOCB_CMD_PWRITE = 1,
+	IOCB_CMD_FSYNC = 2,
+	IOCB_CMD_FDSYNC = 3,
+	/* These two are experimental.
+	 * IOCB_CMD_PREADX = 4,
+	 * IOCB_CMD_POLL = 5,
+	 */
+	IOCB_CMD_NOOP = 6,
+};
+
+/* read() from /dev/aio returns these structures. */
+struct io_event {
+	__u64		data;		/* the data field from the iocb */
+	__u64		obj;		/* what iocb this event came from */
+	__s64		res;		/* result code for this event */
+	__s64		res2;		/* secondary result */
+};
+
+#if defined(__LITTLE_ENDIAN)
+#define PADDED(x,y)	x, y
+#elif defined(__BIG_ENDIAN)
+#define PADDED(x,y)	y, x
+#else
+#error edit for your odd byteorder.
+#endif
+
+/*
+ * we always use a 64bit off_t when communicating
+ * with userland.  its up to libraries to do the
+ * proper padding and aio_error abstraction
+ */
+
+struct iocb {
+	/* these are internal to the kernel/libc. */
+	__u64	aio_data;	/* data to be returned in event's data */
+	__u32	PADDED(aio_key, aio_reserved1);
+				/* the kernel sets aio_key to the req # */
+
+	/* common fields */
+	__u16	aio_lio_opcode;	/* see IOCB_CMD_ above */
+	__s16	aio_reqprio;
+	__u32	aio_fildes;
+
+	__u64	aio_buf;
+	__u64	aio_nbytes;
+	__s64	aio_offset;
+
+	/* extra parameters */
+	__u64	aio_reserved2;	/* TODO: use this for a (struct sigevent *) */
+	__u64	aio_reserved3;
+}; /* 64 bytes */
+
+#undef IFBIG
+#undef IFLITTLE
+
+#endif /* __LINUX__AIO_ABI_H */
+
diff -urN v2.5.29/include/linux/errno.h aio-v2.5.29.diff/include/linux/errno.h
--- v2.5.29/include/linux/errno.h	Fri Feb  9 17:46:13 2001
+++ aio-v2.5.29.diff/include/linux/errno.h	Tue Jul 30 14:36:09 2002
@@ -10,6 +10,7 @@
 #define ERESTARTNOINTR	513
 #define ERESTARTNOHAND	514	/* restart if no handler.. */
 #define ENOIOCTLCMD	515	/* No ioctl command */
+#define EIOCBQUEUED	516	/* Async operation is queued. */
 
 /* Defined for the NFSv3 protocol */
 #define EBADHANDLE	521	/* Illegal NFS file handle */
diff -urN v2.5.29/include/linux/fs.h aio-v2.5.29.diff/include/linux/fs.h
--- v2.5.29/include/linux/fs.h	Tue Jul 30 10:24:33 2002
+++ aio-v2.5.29.diff/include/linux/fs.h	Tue Jul 30 10:32:38 2002
@@ -740,6 +740,7 @@
  * read, write, poll, fsync, readv, writev can be called
  *   without the big kernel lock held in all filesystems.
  */
+struct kiocb;
 struct file_operations {
 	struct module *owner;
 	loff_t (*llseek) (struct file *, loff_t, int);
@@ -759,6 +760,12 @@
 	ssize_t (*writev) (struct file *, const struct iovec *, unsigned long, loff_t *);
 	ssize_t (*sendpage) (struct file *, struct page *, int, size_t, loff_t *, int);
 	unsigned long (*get_unmapped_area)(struct file *, unsigned long, unsigned long, unsigned long, unsigned long);
+
+	ssize_t (*aio_read)(struct kiocb *, char *, size_t, loff_t);
+	ssize_t (*aio_write)(struct kiocb *, const char *, size_t, loff_t);
+	int (*aio_fsync)(struct kiocb *, int datasync);
+
+	struct kmem_cache_s *kiocb_slab;
 };
 
 struct inode_operations {
diff -urN v2.5.29/include/linux/sched.h aio-v2.5.29.diff/include/linux/sched.h
--- v2.5.29/include/linux/sched.h	Tue Jul 30 10:24:33 2002
+++ aio-v2.5.29.diff/include/linux/sched.h	Tue Jul 30 10:32:38 2002
@@ -166,6 +166,7 @@
 /* Maximum number of active map areas.. This is a random (large) number */
 #define MAX_MAP_COUNT	(65536)
 
+struct kioctx;
 struct mm_struct {
 	struct vm_area_struct * mmap;		/* list of VMAs */
 	rb_root_t mm_rb;
@@ -194,6 +195,11 @@
 
 	/* Architecture-specific MM context */
 	mm_context_t context;
+
+	/* aio bits that have to be shared between threads */
+	rwlock_t	ioctx_list_lock;
+	struct kioctx	*ioctx_list;
+	unsigned long	new_ioctx_id;
 };
 
 extern int mmlist_nr;
diff -urN v2.5.29/kernel/fork.c aio-v2.5.29.diff/kernel/fork.c
--- v2.5.29/kernel/fork.c	Tue Jul 30 10:24:19 2002
+++ aio-v2.5.29.diff/kernel/fork.c	Tue Jul 30 12:13:00 2002
@@ -25,6 +25,7 @@
 #include <linux/binfmts.h>
 #include <linux/fs.h>
 #include <linux/security.h>
+#include <linux/aio.h>
 
 #include <asm/pgtable.h>
 #include <asm/pgalloc.h>
@@ -265,6 +266,7 @@
 	atomic_set(&mm->mm_count, 1);
 	init_rwsem(&mm->mmap_sem);
 	mm->page_table_lock = SPIN_LOCK_UNLOCKED;
+	rwlock_init(&mm->ioctx_list_lock);
 	mm->pgd = pgd_alloc(mm);
 	if (mm->pgd)
 		return mm;
@@ -310,6 +312,12 @@
 		list_del(&mm->mmlist);
 		mmlist_nr--;
 		spin_unlock(&mmlist_lock);
+		exit_aio(mm);	/* This is partially wrong: it should be called
+				 * when the last thread in a group exits to
+				 * block exit until all IOs are cancelled.
+				 * Here, we could block some random /proc user
+				 * instead.  Yuck.  FIXME.
+				 */
 		exit_mmap(mm);
 		mmdrop(mm);
 	}
