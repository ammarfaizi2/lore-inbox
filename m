Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264830AbTBTWqb>; Thu, 20 Feb 2003 17:46:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264834AbTBTWqa>; Thu, 20 Feb 2003 17:46:30 -0500
Received: from pat.uio.no ([129.240.130.16]:54469 "EHLO pat.uio.no")
	by vger.kernel.org with ESMTP id <S264830AbTBTWqW>;
	Thu, 20 Feb 2003 17:46:22 -0500
To: Andrea Arcangeli <andrea@suse.de>
Cc: Andrew Morton <akpm@digeo.com>,
       Marc-Christian Petersen <m.c.p@wolk-project.de>, t.baetzler@bringe.com,
       linux-kernel@vger.kernel.org, marcelo@conectiva.com.br
Subject: Re: xdr nfs highmem deadlock fix [Re: filesystem access slowing system to a crawl]
References: <A1FE021ABD24D411BE2D0050DA450B925EEA6C@MERKUR>
	<200302191742.02275.m.c.p@wolk-project.de>
	<20030219174940.GJ14633@x30.suse.de>
	<200302201629.51374.m.c.p@wolk-project.de>
	<20030220103543.7c2d250c.akpm@digeo.com>
	<20030220215457.GV31480@x30.school.suse.de>
From: Trond Myklebust <trond.myklebust@fys.uio.no>
Date: 20 Feb 2003 23:56:14 +0100
In-Reply-To: <20030220215457.GV31480@x30.school.suse.de>
Message-ID: <shs1y22zhm9.fsf@charged.uio.no>
User-Agent: Gnus/5.0808 (Gnus v5.8.8) XEmacs/21.4 (Honest Recruiter)
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="=-=-="
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--=-=-=

>>>>> " " == Andrea Arcangeli <andrea@suse.de> writes:

     > 2.5.62 has the very same deadlock condition in xdr triggered by
     >        nfs too.
     > Andrew, if you're forward porting it yourself like with the
     > filebacked vma merging feature just let me know so we make sure
     > not to duplicate effort.

For 2.5.x we should rather fix MSG_MORE so that it actually works
instead of messing with hacks to kmap().

For 2.4.x, Hirokazu Takahashi had a patch which allowed for a safe
kmap of > 1 page in one call. Appended here as an attachment FYI
(Marcelo do *not* apply!).

Cheers,
  Trond


--=-=-=
Content-Disposition: attachment;
  filename=va02-kmap-multplepages-2.5.7.patch

--- linux/include/linux/csem.h.CSEMORG	Mon Apr  8 06:38:03 2002
+++ linux/include/linux/csem.h	Mon Apr  8 08:13:00 2002
@@ -0,0 +1,45 @@
+/* 
+ * csem.h: Count semaphores, public interface
+ * Written by Hirokazu Takahashi (taka@valinux.co.jp).
+ */
+
+#ifndef _LINUX_CNTSEM_H
+#define _LINUX_CNTSEM_H
+
+#ifdef __KERNEL__
+
+#include <linux/config.h>
+#include <linux/types.h>
+#include <linux/sched.h>
+#include <asm/system.h>
+#include <asm/atomic.h>
+
+
+struct csemaphore {
+	spinlock_t	lock;
+	atomic_t	count;
+	wait_queue_head_t wait;
+};
+
+#define __CSEMAPHORE_INITIALIZER(name, count) \
+	{ SPIN_LOCK_UNLOCKED,  ATOMIC_INIT(count), \
+	__WAIT_QUEUE_HEAD_INITIALIZER((name).wait) }
+
+#define __DECLARE_CSEMAPHORE_GENERIC(name,count) \
+	struct csemaphore name = __CSEMAPHORE_INITIALIZER(name,count)
+
+extern void _down_count(struct csemaphore * , int);
+extern void _up_count(struct csemaphore * , int);
+
+static inline void down_count(struct csemaphore *sem, int cnt)
+{
+	if (cnt) _down_count(sem, cnt);
+}
+
+static inline void up_count(struct csemaphore *sem, int cnt)
+{
+	if (cnt) _up_count(sem, cnt);
+}
+
+#endif /* __KERNEL__ */
+#endif /* _LINUX_CNTSEM_H */
--- linux/lib/csem.c.CSEMORG	Mon Apr  8 06:35:41 2002
+++ linux/lib/csem.c	Mon Apr  8 08:04:55 2002
@@ -0,0 +1,55 @@
+/*
+ * csem.c: Count semaphores: contention handling generic functions
+ *         You can get one or more counts at once.
+ * Written by Hirokazu Takahashi (taka@valinux.co.jp).
+ */
+
+#include <linux/csem.h>
+#include <linux/sched.h>
+#include <linux/module.h>
+
+
+void _down_count(struct csemaphore *sem, int n)
+{
+	struct task_struct *tsk = current;
+	DECLARE_WAITQUEUE(wait, tsk);
+
+	spin_lock(&sem->lock);
+	if (!waitqueue_active(&sem->wait) && atomic_read(&sem->count) >= n) {
+		atomic_sub(n, &sem->count);
+		spin_unlock(&sem->lock);
+		return;
+	}
+	tsk->state = TASK_UNINTERRUPTIBLE;
+	add_wait_queue_exclusive(&sem->wait, &wait);
+wait:
+	spin_unlock(&sem->lock);
+	schedule();
+	spin_lock(&sem->lock);
+	if (atomic_read(&sem->count) < n) {
+		tsk->state = TASK_UNINTERRUPTIBLE;
+		goto wait;
+	}
+	atomic_sub(n, &sem->count);
+	remove_wait_queue(&sem->wait, &wait);
+	tsk->state = TASK_RUNNING;
+	if (waitqueue_active(&sem->wait) && atomic_read(&sem->count)) {
+		wake_up(&sem->wait);
+	}
+	spin_unlock(&sem->lock);
+}
+
+
+void _up_count(struct csemaphore *sem, int n)
+{
+	spin_lock(&sem->lock);
+	atomic_add(n, &sem->count);
+	if (waitqueue_active(&sem->wait)) {
+		wake_up(&sem->wait);
+	}
+	spin_unlock(&sem->lock);
+}
+
+EXPORT_SYMBOL(_down_count);
+EXPORT_SYMBOL(_up_count);
+
--- linux/lib/Makefile.CSEMORG	Mon Apr  8 06:35:28 2002
+++ linux/lib/Makefile	Mon Apr  8 06:36:30 2002
@@ -8,9 +8,9 @@
 
 L_TARGET := lib.a
 
-export-objs := cmdline.o dec_and_lock.o rwsem-spinlock.o rwsem.o crc32.o
+export-objs := cmdline.o dec_and_lock.o rwsem-spinlock.o rwsem.o crc32.o csem.o
 
-obj-y := errno.o ctype.o string.o vsprintf.o brlock.o cmdline.o bust_spinlocks.o rbtree.o
+obj-y := errno.o ctype.o string.o vsprintf.o brlock.o cmdline.o bust_spinlocks.o rbtree.o csem.o
 
 obj-$(CONFIG_RWSEM_GENERIC_SPINLOCK) += rwsem-spinlock.o
 obj-$(CONFIG_RWSEM_XCHGADD_ALGORITHM) += rwsem.o
--- linux/include/asm-i386/highmem.h.CSEMORG	Mon Apr  8 06:01:42 2002
+++ linux/include/asm-i386/highmem.h	Mon Apr  8 06:02:39 2002
@@ -50,8 +50,8 @@
 #define PKMAP_NR(virt)  ((virt-PKMAP_BASE) >> PAGE_SHIFT)
 #define PKMAP_ADDR(nr)  (PKMAP_BASE + ((nr) << PAGE_SHIFT))
 
-extern void * FASTCALL(kmap_high(struct page *page));
-extern void FASTCALL(kunmap_high(struct page *page));
+extern void * FASTCALL(kmap_highpages(struct page **page, int cnt));
+extern void FASTCALL(kunmap_highpages(struct page **page, int cnt));
 
 static inline void *kmap(struct page *page)
 {
@@ -59,7 +59,8 @@
 		BUG();
 	if (page < highmem_start_page)
 		return page_address(page);
-	return kmap_high(page);
+	kmap_highpages(&page, 1);
+	return page_address(page);
 }
 
 static inline void kunmap(struct page *page)
@@ -68,7 +69,7 @@
 		BUG();
 	if (page < highmem_start_page)
 		return;
-	kunmap_high(page);
+	kunmap_highpages(&page, 1);
 }
 
 /*
--- linux/include/linux/highmem.h.CSEMORG	Mon Apr  8 12:01:36 2002
+++ linux/include/linux/highmem.h	Mon Apr  8 12:06:27 2002
@@ -71,6 +71,9 @@
 
 #define kunmap(page) do { } while (0)
 
+#define kmap_highpages(pagep,cnt)	do { } while (0)
+#define kunmap_highpages(pagep,cnt)	do { } while (0)
+
 #define kmap_atomic(page,idx)		kmap(page)
 #define kunmap_atomic(page,idx)		kunmap(page)
 
--- linux/kernel/ksyms.c.CSEMORG	Mon Apr  8 06:02:00 2002
+++ linux/kernel/ksyms.c	Mon Apr  8 06:02:39 2002
@@ -118,8 +118,8 @@
 EXPORT_SYMBOL(init_mm);
 EXPORT_SYMBOL(create_bounce);
 #ifdef CONFIG_HIGHMEM
-EXPORT_SYMBOL(kmap_high);
-EXPORT_SYMBOL(kunmap_high);
+EXPORT_SYMBOL(kmap_highpages);
+EXPORT_SYMBOL(kunmap_highpages);
 EXPORT_SYMBOL(highmem_start_page);
 EXPORT_SYMBOL(kmap_prot);
 EXPORT_SYMBOL(kmap_pte);
--- linux/mm/highmem.c.CSEMORG	Mon Apr  8 06:02:11 2002
+++ linux/mm/highmem.c	Mon Apr  8 06:49:06 2002
@@ -20,6 +20,7 @@
 #include <linux/pagemap.h>
 #include <linux/mempool.h>
 #include <linux/blkdev.h>
+#include <linux/csem.h>
 #include <asm/pgalloc.h>
 
 static mempool_t *page_pool, *isa_page_pool;
@@ -51,7 +52,7 @@
 
 pte_t * pkmap_page_table;
 
-static DECLARE_WAIT_QUEUE_HEAD(pkmap_map_wait);
+static __DECLARE_CSEMAPHORE_GENERIC(pkmap_sem, LAST_PKMAP);
 
 static void flush_all_zero_pkmaps(void)
 {
@@ -96,7 +97,6 @@
 	unsigned long vaddr;
 	int count;
 
-start:
 	count = LAST_PKMAP;
 	/* Find an empty entry */
 	for (;;) {
@@ -110,26 +110,7 @@
 		if (--count)
 			continue;
 
-		/*
-		 * Sleep for somebody else to unmap their entries
-		 */
-		{
-			DECLARE_WAITQUEUE(wait, current);
-
-			current->state = TASK_UNINTERRUPTIBLE;
-			add_wait_queue(&pkmap_map_wait, &wait);
-			spin_unlock(&kmap_lock);
-			schedule();
-			remove_wait_queue(&pkmap_map_wait, &wait);
-			spin_lock(&kmap_lock);
-
-			/* Somebody else might have mapped it while we slept */
-			if (page->virtual)
-				return (unsigned long) page->virtual;
-
-			/* Re-start */
-			goto start;
-		}
+		panic("kmap: failed to allocate a entry.\n");
 	}
 	vaddr = PKMAP_ADDR(last_pkmap_nr);
 	set_pte(&(pkmap_page_table[last_pkmap_nr]), mk_pte(page, kmap_prot));
@@ -140,10 +121,16 @@
 	return vaddr;
 }
 
-void *kmap_high(struct page *page)
+void *kmap_highpages(struct page **page, int cnt)
 {
 	unsigned long vaddr;
-
+	int	hcnt = 0;
+	int	mapped = 0;
+	int	i;
+
+	for (i = 0; i < cnt; i++)
+		if (page[i] >= highmem_start_page) hcnt++;
+	down_count(&pkmap_sem , hcnt);
 	/*
 	 * For highmem pages, we can't trust "virtual" until
 	 * after we have the lock.
@@ -151,54 +138,65 @@
 	 * We cannot call this from interrupts, as it may block
 	 */
 	spin_lock(&kmap_lock);
-	vaddr = (unsigned long) page->virtual;
-	if (!vaddr)
-		vaddr = map_new_virtual(page);
-	pkmap_count[PKMAP_NR(vaddr)]++;
-	if (pkmap_count[PKMAP_NR(vaddr)] < 2)
-		BUG();
+	for (i = 0; i < cnt; i++) {
+		if (page[i] < highmem_start_page)
+			continue;
+		vaddr = (unsigned long) page[i]->virtual;
+		if (!vaddr)
+			vaddr = map_new_virtual(page[i]);
+		if (pkmap_count[PKMAP_NR(vaddr)] == 1)
+			mapped++;
+		pkmap_count[PKMAP_NR(vaddr)]++;
+		if (pkmap_count[PKMAP_NR(vaddr)] < 2)
+			BUG();
+	}
+	if (hcnt != mapped)
+		up_count(&pkmap_sem, hcnt - mapped);
 	spin_unlock(&kmap_lock);
 	return (void*) vaddr;
 }
 
-void kunmap_high(struct page *page)
+void kunmap_highpages(struct page **page, int cnt)
 {
 	unsigned long vaddr;
 	unsigned long nr;
-	int need_wakeup;
+	int release_cnt = 0;
+	int i;
 
 	spin_lock(&kmap_lock);
-	vaddr = (unsigned long) page->virtual;
-	if (!vaddr)
-		BUG();
-	nr = PKMAP_NR(vaddr);
+	for (i = 0; i < cnt; i++) {
+		if (page[i] < highmem_start_page)
+			continue;
+		vaddr = (unsigned long) page[i]->virtual;
+		if (!vaddr)
+			BUG();
+		nr = PKMAP_NR(vaddr);
 
-	/*
-	 * A count must never go down to zero
-	 * without a TLB flush!
-	 */
-	need_wakeup = 0;
-	switch (--pkmap_count[nr]) {
-	case 0:
-		BUG();
-	case 1:
 		/*
-		 * Avoid an unnecessary wake_up() function call.
-		 * The common case is pkmap_count[] == 1, but
-		 * no waiters.
-		 * The tasks queued in the wait-queue are guarded
-		 * by both the lock in the wait-queue-head and by
-		 * the kmap_lock.  As the kmap_lock is held here,
-		 * no need for the wait-queue-head's lock.  Simply
-		 * test if the queue is empty.
+		 * A count must never go down to zero
+		 * without a TLB flush!
 		 */
-		need_wakeup = waitqueue_active(&pkmap_map_wait);
+		switch (--pkmap_count[nr]) {
+		case 0:
+			BUG();
+		case 1:
+			/*
+			 * Avoid an unnecessary wake_up() function call.
+			 * The common case is pkmap_count[] == 1, but
+			 * no waiters.
+			 * The tasks queued in the wait-queue are guarded
+			 * by both the lock in the wait-queue-head and by
+			 * the kmap_lock.  As the kmap_lock is held here,
+			 * no need for the wait-queue-head's lock.  Simply
+			 * test if the queue is empty.
+			 */
+			release_cnt++;
+		}
 	}
 	spin_unlock(&kmap_lock);
 
 	/* do wake-up, if needed, race-free outside of the spin lock */
-	if (need_wakeup)
-		wake_up(&pkmap_map_wait);
+	up_count(&pkmap_sem , release_cnt);
 }
 
 #define POOL_SIZE	64
--- linux/net/sunrpc/svcsock.c.CSEMORG	Mon Apr  8 06:02:26 2002
+++ linux/net/sunrpc/svcsock.c	Mon Apr  8 07:59:57 2002
@@ -338,10 +338,12 @@
 	 */
 	msg.msg_flags	= 0;
 
-	/* Danger!: multiple kmap() calls may cause deadlock */
-	for (i = 1; i < bufp->nriov; i++) {
-		if (bufp->page[i])
-			bufp->iov[i].iov_base += (unsigned int)kmap(bufp->page[i]);
+	if (bufp->nriov > 1) {
+		kmap_highpages(&bufp->page[1], bufp->nriov - 1);
+		for (i = 1; i < bufp->nriov; i++) {
+			if (bufp->page[i])
+				bufp->iov[i].iov_base += (unsigned int)page_address(bufp->page[i]);
+		}
 	}
 
 	/* TODO: Sendpage mechanism will work good than sock_sendmsg() */
@@ -349,12 +351,13 @@
 	len = sock_sendmsg(sock, &msg, buflen);
 	set_fs(oldfs);
 
-	for (i = 1; i < bufp->nriov; i++) {
-		struct page *page = bufp->page[i];
-		if (page) {
-			kunmap(page);
-			page_cache_release(page);
-			bufp->page[i] = NULL;
+	if (bufp->nriov > 1) {
+		kunmap_highpages(&bufp->page[1], bufp->nriov - 1);
+		for (i = 1; i < bufp->nriov; i++) {
+			if (bufp->page[i]) {
+				page_cache_release(bufp->page[i]);
+				bufp->page[i] = NULL;
+			}
 		}
 	}
 	dprintk("svc: socket %p sendto([%p %Zu... ], %d, %d) = %d\n",

--=-=-=--
