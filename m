Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266124AbUF2WgG@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266124AbUF2WgG (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 29 Jun 2004 18:36:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266127AbUF2WgF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 29 Jun 2004 18:36:05 -0400
Received: from fw.osdl.org ([65.172.181.6]:32482 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S266124AbUF2We7 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 29 Jun 2004 18:34:59 -0400
Date: Tue, 29 Jun 2004 15:34:52 -0700
From: Stephen Hemminger <shemminger@osdl.org>
To: "Marcelo W. Tosatti" <marcelo.tosatti@cyclades.com.br>
Cc: linux-kernel@vger.kernel.org
Subject: [RFC] building linux-2.4 with gcc 3.3.3
Message-Id: <20040629153452.5a03ab5e@dell_ss3.pdx.osdl.net>
Organization: Open Source Development Lab
X-Mailer: Sylpheed version 0.9.10claws (GTK+ 1.2.10; i386-redhat-linux-gnu)
X-Face: &@E+xe?c%:&e4D{>f1O<&U>2qwRREG5!}7R4;D<"NO^UI2mJ[eEOA2*3>(`Th.yP,VDPo9$
 /`~cw![cmj~~jWe?AHY7D1S+\}5brN0k*NE?pPh_'_d>6;XGG[\KDRViCfumZT3@[
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

It appears linux-2.4 won't build with gcc 3.3.3 (SuSe) because it is picky about
the attributes matching the prototype which shows up on the FASTCALL() usage.

gcc -D__KERNEL__ -I/home/shemminger/linux-2.4/include -Wall -Wstrict-prototypes -Wno-trigraphs -O2 -fno-strict-aliasing -fno-common -fomit-frame-pointer -pipe -mpreferred-stack-boundary=2 -march=i686   -DKBUILD_BASENAME=main -c -o init/main.o init/main.c
In file included from /home/shemminger/linux-2.4/include/linux/sched.h:23,
                 from /home/shemminger/linux-2.4/include/linux/mm.h:4,
                 from /home/shemminger/linux-2.4/include/linux/slab.h:14,
                 from /home/shemminger/linux-2.4/include/linux/proc_fs.h:5,
                 from init/main.c:15:
/home/shemminger/linux-2.4/include/linux/smp.h:29: error: conflicting types for `smp_send_reschedule'
/home/shemminger/linux-2.4/include/asm/smp.h:42: error: previous declaration of `smp_send_reschedule'

----------
diff -Nru a/arch/i386/kernel/process.c b/arch/i386/kernel/process.c
--- a/arch/i386/kernel/process.c	2004-06-29 15:31:58 -07:00
+++ b/arch/i386/kernel/process.c	2004-06-29 15:31:58 -07:00
@@ -644,7 +644,7 @@
  * More important, however, is the fact that this allows us much
  * more flexibility.
  */
-void __switch_to(struct task_struct *prev_p, struct task_struct *next_p)
+fastcall void __switch_to(struct task_struct *prev_p, struct task_struct *next_p)
 {
 	struct thread_struct *prev = &prev_p->thread,
 				 *next = &next_p->thread;
diff -Nru a/arch/i386/kernel/signal.c b/arch/i386/kernel/signal.c
--- a/arch/i386/kernel/signal.c	2004-06-29 15:31:58 -07:00
+++ b/arch/i386/kernel/signal.c	2004-06-29 15:31:58 -07:00
@@ -581,7 +581,7 @@
  * want to handle. Thus you cannot kill init even with a SIGKILL even by
  * mistake.
  */
-int do_signal(struct pt_regs *regs, sigset_t *oldset)
+fastcall int do_signal(struct pt_regs *regs, sigset_t *oldset)
 {
 	siginfo_t info;
 	struct k_sigaction *ka;
diff -Nru a/arch/i386/kernel/smp.c b/arch/i386/kernel/smp.c
--- a/arch/i386/kernel/smp.c	2004-06-29 15:31:58 -07:00
+++ b/arch/i386/kernel/smp.c	2004-06-29 15:31:58 -07:00
@@ -150,7 +150,7 @@
 	apic_write_around(APIC_ICR, cfg);
 }
 
-void send_IPI_self(int vector)
+fastcall void send_IPI_self(int vector)
 {
 	__send_IPI_shortcut(APIC_DEST_SELF, vector);
 }
@@ -497,7 +497,7 @@
  * anything. Worst case is that we lose a reschedule ...
  */
 
-void smp_send_reschedule(int cpu)
+fastcall void smp_send_reschedule(int cpu)
 {
 	send_IPI_mask(1 << cpu, RESCHEDULE_VECTOR);
 }
diff -Nru a/arch/i386/kernel/vm86.c b/arch/i386/kernel/vm86.c
--- a/arch/i386/kernel/vm86.c	2004-06-29 15:31:58 -07:00
+++ b/arch/i386/kernel/vm86.c	2004-06-29 15:31:58 -07:00
@@ -91,7 +91,7 @@
 #define VM86_REGS_SIZE2 (sizeof(struct kernel_vm86_regs) - VM86_REGS_SIZE1)
 
 struct pt_regs * FASTCALL(save_v86_state(struct kernel_vm86_regs * regs));
-struct pt_regs * save_v86_state(struct kernel_vm86_regs * regs)
+fastcall struct pt_regs * save_v86_state(struct kernel_vm86_regs * regs)
 {
 	struct tss_struct *tss;
 	struct pt_regs *ret;
diff -Nru a/fs/buffer.c b/fs/buffer.c
--- a/fs/buffer.c	2004-06-29 15:31:58 -07:00
+++ b/fs/buffer.c	2004-06-29 15:31:58 -07:00
@@ -160,7 +160,7 @@
 	ll_rw_block(WRITE, 1, &bh);
 }
 
-void unlock_buffer(struct buffer_head *bh)
+fastcall void unlock_buffer(struct buffer_head *bh)
 {
 	clear_bit(BH_Wait_IO, &bh->b_state);
 	clear_bit(BH_Launder, &bh->b_state);
@@ -649,7 +649,7 @@
 	return bh;
 }
 
-void buffer_insert_list(struct buffer_head *bh, struct list_head *list)
+fastcall void buffer_insert_list(struct buffer_head *bh, struct list_head *list)
 {
 	spin_lock(&lru_list_lock);
 	if (buffer_attached(bh))
@@ -1092,7 +1092,7 @@
 }
 EXPORT_SYMBOL(balance_dirty);
 
-inline void __mark_dirty(struct buffer_head *bh)
+fastcall void __mark_dirty(struct buffer_head *bh)
 {
 	bh->b_flushtime = jiffies + bdf_prm.b_un.age_buffer;
 	refile_buffer(bh);
@@ -1100,13 +1100,13 @@
 
 /* atomic version, the user must call balance_dirty() by hand
    as soon as it become possible to block */
-void __mark_buffer_dirty(struct buffer_head *bh)
+fastcall void __mark_buffer_dirty(struct buffer_head *bh)
 {
 	if (!atomic_set_buffer_dirty(bh))
 		__mark_dirty(bh);
 }
 
-void mark_buffer_dirty(struct buffer_head *bh)
+fastcall void mark_buffer_dirty(struct buffer_head *bh)
 {
 	if (!atomic_set_buffer_dirty(bh)) {
 		if (block_dump)
@@ -2730,7 +2730,7 @@
  *       obtain a reference to a buffer head within a page.  So we must
  *	 lock out all of these paths to cleanly toss the page.
  */
-int try_to_free_buffers(struct page * page, unsigned int gfp_mask)
+fastcall int try_to_free_buffers(struct page * page, unsigned int gfp_mask)
 {
 	struct buffer_head * tmp, * bh = page->buffers;
 
diff -Nru a/fs/file_table.c b/fs/file_table.c
--- a/fs/file_table.c	2004-06-29 15:31:58 -07:00
+++ b/fs/file_table.c	2004-06-29 15:31:58 -07:00
@@ -97,7 +97,7 @@
 		return 0;
 }
 
-void fput(struct file * file)
+fastcall void fput(struct file * file)
 {
 	struct dentry * dentry = file->f_dentry;
 	struct vfsmount * mnt = file->f_vfsmnt;
@@ -126,7 +126,7 @@
 	}
 }
 
-struct file * fget(unsigned int fd)
+fastcall struct file * fget(unsigned int fd)
 {
 	struct file * file;
 	struct files_struct *files = current->files;
diff -Nru a/fs/namei.c b/fs/namei.c
--- a/fs/namei.c	2004-06-29 15:31:58 -07:00
+++ b/fs/namei.c	2004-06-29 15:31:58 -07:00
@@ -447,7 +447,7 @@
  *
  * We expect 'base' to be positive and a directory.
  */
-int link_path_walk(const char * name, struct nameidata *nd)
+fastcall int link_path_walk(const char * name, struct nameidata *nd)
 {
 	struct dentry *dentry;
 	struct inode *inode;
@@ -653,7 +653,7 @@
 	return err;
 }
 
-int path_walk(const char * name, struct nameidata *nd)
+fastcall int path_walk(const char * name, struct nameidata *nd)
 {
 	current->total_link_count = 0;
 	return link_path_walk(name, nd);
@@ -741,7 +741,7 @@
 }
 
 /* SMP-safe */
-int path_lookup(const char *path, unsigned flags, struct nameidata *nd)
+fastcall int path_lookup(const char *path, unsigned flags, struct nameidata *nd)
 {
 	int error = 0;
 	if (path_init(path, flags, nd))
@@ -751,7 +751,7 @@
 
 
 /* SMP-safe */
-int path_init(const char *name, unsigned int flags, struct nameidata *nd)
+fastcall int path_init(const char *name, unsigned int flags, struct nameidata *nd)
 {
 	nd->last_type = LAST_ROOT; /* if there are only slashes... */
 	nd->flags = flags;
@@ -847,7 +847,7 @@
  * that namei follows links, while lnamei does not.
  * SMP-safe
  */
-int __user_walk(const char *name, unsigned flags, struct nameidata *nd)
+fastcall int __user_walk(const char *name, unsigned flags, struct nameidata *nd)
 {
 	char *tmp;
 	int err;
diff -Nru a/include/asm-i386/smp.h b/include/asm-i386/smp.h
--- a/include/asm-i386/smp.h	2004-06-29 15:31:58 -07:00
+++ b/include/asm-i386/smp.h	2004-06-29 15:31:58 -07:00
@@ -39,7 +39,7 @@
 
 extern void smp_flush_tlb(void);
 extern void smp_message_irq(int cpl, void *dev_id, struct pt_regs *regs);
-extern void smp_send_reschedule(int cpu);
+extern void FASTCALL(smp_send_reschedule(int cpu));
 extern void smp_invalidate_rcv(void);		/* Process an NMI */
 extern void (*mtrr_hook) (void);
 extern void zap_low_mappings (void);
diff -Nru a/include/linux/kernel.h b/include/linux/kernel.h
--- a/include/linux/kernel.h	2004-06-29 15:31:58 -07:00
+++ b/include/linux/kernel.h	2004-06-29 15:31:58 -07:00
@@ -51,8 +51,10 @@
 
 #ifdef __i386__
 #define FASTCALL(x)	x __attribute__((regparm(3)))
+#define fastcall	__attribute__((regparm(3)))
 #else
 #define FASTCALL(x)	x
+#define fastcall
 #endif
 
 struct completion;
diff -Nru a/kernel/fork.c b/kernel/fork.c
--- a/kernel/fork.c	2004-06-29 15:31:58 -07:00
+++ b/kernel/fork.c	2004-06-29 15:31:58 -07:00
@@ -39,7 +39,7 @@
 
 struct task_struct *pidhash[PIDHASH_SZ];
 
-void add_wait_queue(wait_queue_head_t *q, wait_queue_t * wait)
+void fastcall add_wait_queue(wait_queue_head_t *q, wait_queue_t * wait)
 {
 	unsigned long flags;
 
@@ -49,7 +49,7 @@
 	wq_write_unlock_irqrestore(&q->lock, flags);
 }
 
-void add_wait_queue_exclusive(wait_queue_head_t *q, wait_queue_t * wait)
+void fastcall add_wait_queue_exclusive(wait_queue_head_t *q, wait_queue_t * wait)
 {
 	unsigned long flags;
 
@@ -59,7 +59,7 @@
 	wq_write_unlock_irqrestore(&q->lock, flags);
 }
 
-void remove_wait_queue(wait_queue_head_t *q, wait_queue_t * wait)
+void fastcall remove_wait_queue(wait_queue_head_t *q, wait_queue_t * wait)
 {
 	unsigned long flags;
 
@@ -264,7 +264,7 @@
  * is dropped: either by a lazy thread or by
  * mmput. Free the page directory and the mm.
  */
-inline void __mmdrop(struct mm_struct *mm)
+inline fastcall void __mmdrop(struct mm_struct *mm)
 {
 	BUG_ON(mm == &init_mm);
 	pgd_free(mm->pgd);
diff -Nru a/kernel/sched.c b/kernel/sched.c
--- a/kernel/sched.c	2004-06-29 15:31:58 -07:00
+++ b/kernel/sched.c	2004-06-29 15:31:58 -07:00
@@ -209,7 +209,7 @@
  */
 static FASTCALL(void reschedule_idle(struct task_struct * p));
 
-static void reschedule_idle(struct task_struct * p)
+static void fastcall reschedule_idle(struct task_struct * p)
 {
 #ifdef CONFIG_SMP
 	int this_cpu = smp_processor_id();
@@ -367,7 +367,7 @@
 	return success;
 }
 
-inline int wake_up_process(struct task_struct * p)
+int fastcall wake_up_process(struct task_struct * p)
 {
 	return try_to_wake_up(p, 0);
 }
@@ -405,7 +405,7 @@
  *
  * In all cases the return value is guaranteed to be non-negative.
  */
-signed long schedule_timeout(signed long timeout)
+signed long fastcall schedule_timeout(signed long timeout)
 {
 	struct timer_list timer;
 	unsigned long expire;
@@ -735,7 +735,7 @@
 	}
 }
 
-void __wake_up(wait_queue_head_t *q, unsigned int mode, int nr)
+void fastcall __wake_up(wait_queue_head_t *q, unsigned int mode, int nr)
 {
 	if (q) {
 		unsigned long flags;
@@ -745,7 +745,7 @@
 	}
 }
 
-void __wake_up_sync(wait_queue_head_t *q, unsigned int mode, int nr)
+void fastcall __wake_up_sync(wait_queue_head_t *q, unsigned int mode, int nr)
 {
 	if (q) {
 		unsigned long flags;
@@ -755,7 +755,7 @@
 	}
 }
 
-void complete(struct completion *x)
+void fastcall complete(struct completion *x)
 {
 	unsigned long flags;
 
@@ -765,7 +765,7 @@
 	spin_unlock_irqrestore(&x->wait.lock, flags);
 }
 
-void wait_for_completion(struct completion *x)
+void fastcall wait_for_completion(struct completion *x)
 {
 	spin_lock_irq(&x->wait.lock);
 	if (!x->done) {
@@ -800,7 +800,7 @@
 	__remove_wait_queue(q, &wait);				\
 	wq_write_unlock_irqrestore(&q->lock,flags);
 
-void interruptible_sleep_on(wait_queue_head_t *q)
+void fastcall interruptible_sleep_on(wait_queue_head_t *q)
 {
 	SLEEP_ON_VAR
 
@@ -811,7 +811,7 @@
 	SLEEP_ON_TAIL
 }
 
-long interruptible_sleep_on_timeout(wait_queue_head_t *q, long timeout)
+long fastcall interruptible_sleep_on_timeout(wait_queue_head_t *q, long timeout)
 {
 	SLEEP_ON_VAR
 
@@ -824,7 +824,7 @@
 	return timeout;
 }
 
-void sleep_on(wait_queue_head_t *q)
+void fastcall sleep_on(wait_queue_head_t *q)
 {
 	SLEEP_ON_VAR
 	
@@ -835,7 +835,7 @@
 	SLEEP_ON_TAIL
 }
 
-long sleep_on_timeout(wait_queue_head_t *q, long timeout)
+long fastcall sleep_on_timeout(wait_queue_head_t *q, long timeout)
 {
 	SLEEP_ON_VAR
 	
diff -Nru a/kernel/softirq.c b/kernel/softirq.c
--- a/kernel/softirq.c	2004-06-29 15:31:58 -07:00
+++ b/kernel/softirq.c	2004-06-29 15:31:58 -07:00
@@ -111,7 +111,7 @@
 /*
  * This function must run with irq disabled!
  */
-inline void cpu_raise_softirq(unsigned int cpu, unsigned int nr)
+fastcall void cpu_raise_softirq(unsigned int cpu, unsigned int nr)
 {
 	__cpu_raise_softirq(cpu, nr);
 
@@ -128,7 +128,7 @@
 		wakeup_softirqd(cpu);
 }
 
-void raise_softirq(unsigned int nr)
+fastcall void raise_softirq(unsigned int nr)
 {
 	unsigned long flags;
 
@@ -149,7 +149,7 @@
 struct tasklet_head tasklet_vec[NR_CPUS] __cacheline_aligned;
 struct tasklet_head tasklet_hi_vec[NR_CPUS] __cacheline_aligned;
 
-void __tasklet_schedule(struct tasklet_struct *t)
+void fastcall __tasklet_schedule(struct tasklet_struct *t)
 {
 	int cpu = smp_processor_id();
 	unsigned long flags;
@@ -161,7 +161,7 @@
 	local_irq_restore(flags);
 }
 
-void __tasklet_hi_schedule(struct tasklet_struct *t)
+void fastcall __tasklet_hi_schedule(struct tasklet_struct *t)
 {
 	int cpu = smp_processor_id();
 	unsigned long flags;
diff -Nru a/lib/brlock.c b/lib/brlock.c
--- a/lib/brlock.c	2004-06-29 15:31:58 -07:00
+++ b/lib/brlock.c	2004-06-29 15:31:58 -07:00
@@ -20,7 +20,7 @@
 brlock_read_lock_t __brlock_array[NR_CPUS][__BR_IDX_MAX] =
    { [0 ... NR_CPUS-1] = { [0 ... __BR_IDX_MAX-1] = RW_LOCK_UNLOCKED } };
 
-void __br_write_lock (enum brlock_indices idx)
+fastcall void __br_write_lock (enum brlock_indices idx)
 {
 	int i;
 
@@ -28,7 +28,7 @@
 		write_lock(&__brlock_array[cpu_logical_map(i)][idx]);
 }
 
-void __br_write_unlock (enum brlock_indices idx)
+fastcall void __br_write_unlock (enum brlock_indices idx)
 {
 	int i;
 
diff -Nru a/lib/rwsem.c b/lib/rwsem.c
--- a/lib/rwsem.c	2004-06-29 15:31:58 -07:00
+++ b/lib/rwsem.c	2004-06-29 15:31:58 -07:00
@@ -160,7 +160,7 @@
 /*
  * wait for the read lock to be granted
  */
-struct rw_semaphore *rwsem_down_read_failed(struct rw_semaphore *sem)
+fastcall struct rw_semaphore *rwsem_down_read_failed(struct rw_semaphore *sem)
 {
 	struct rwsem_waiter waiter;
 
@@ -176,7 +176,7 @@
 /*
  * wait for the write lock to be granted
  */
-struct rw_semaphore *rwsem_down_write_failed(struct rw_semaphore *sem)
+fastcall struct rw_semaphore *rwsem_down_write_failed(struct rw_semaphore *sem)
 {
 	struct rwsem_waiter waiter;
 
@@ -193,7 +193,7 @@
  * handle waking up a waiter on the semaphore
  * - up_read has decremented the active part of the count if we come here
  */
-struct rw_semaphore *rwsem_wake(struct rw_semaphore *sem)
+fastcall struct rw_semaphore *rwsem_wake(struct rw_semaphore *sem)
 {
 	rwsemtrace(sem,"Entering rwsem_wake");
 
diff -Nru a/mm/filemap.c b/mm/filemap.c
--- a/mm/filemap.c	2004-06-29 15:31:58 -07:00
+++ b/mm/filemap.c	2004-06-29 15:31:58 -07:00
@@ -68,7 +68,7 @@
 #define CLUSTER_OFFSET(x)	(((x) >> page_cluster) << page_cluster)
 
 static void FASTCALL(add_page_to_hash_queue(struct page * page, struct page **p));
-static void add_page_to_hash_queue(struct page * page, struct page **p)
+static fastcall void add_page_to_hash_queue(struct page * page, struct page **p)
 {
 	struct page *next = *p;
 
@@ -151,7 +151,7 @@
 /*
  * Add a page to the dirty page list.
  */
-void set_page_dirty(struct page *page)
+void fastcall set_page_dirty(struct page *page)
 {
 	if (!test_and_set_bit(PG_dirty, &page->flags)) {
 		struct address_space *mapping = page->mapping;
@@ -260,7 +260,7 @@
 }
 
 static int FASTCALL(truncate_list_pages(struct list_head *, unsigned long, unsigned *));
-static int truncate_list_pages(struct list_head *head, unsigned long start, unsigned *partial)
+static fastcall int truncate_list_pages(struct list_head *head, unsigned long start, unsigned *partial)
 {
 	struct list_head *curr;
 	struct page * page;
@@ -382,7 +382,7 @@
 }
 
 static int FASTCALL(invalidate_list_pages2(struct list_head *));
-static int invalidate_list_pages2(struct list_head *head)
+static fastcall int invalidate_list_pages2(struct list_head *head)
 {
 	struct list_head *curr;
 	struct page * page;
@@ -755,7 +755,7 @@
  * and schedules an I/O to read in its contents from disk.
  */
 static int FASTCALL(page_cache_read(struct file * file, unsigned long offset));
-static int page_cache_read(struct file * file, unsigned long offset)
+static fastcall int page_cache_read(struct file * file, unsigned long offset)
 {
 	struct address_space *mapping = file->f_dentry->d_inode->i_mapping;
 	struct page **hash = page_hash(mapping, offset);
@@ -790,7 +790,7 @@
  */
 static int FASTCALL(read_cluster_nonblocking(struct file * file, unsigned long offset,
 					     unsigned long filesize));
-static int read_cluster_nonblocking(struct file * file, unsigned long offset,
+static fastcall int read_cluster_nonblocking(struct file * file, unsigned long offset,
 	unsigned long filesize)
 {
 	unsigned long pages = CLUSTER_PAGES;
@@ -871,7 +871,7 @@
  * callbacks that would result into the blkdev layer waking
  * up the page after a queue unplug.
  */
-void wakeup_page_waiters(struct page * page)
+void fastcall wakeup_page_waiters(struct page * page)
 {
 	wait_queue_head_t * head;
 
@@ -927,7 +927,7 @@
  * of the waiters for all of the pages in the appropriate
  * wait queue are woken.
  */
-void unlock_page(struct page *page)
+void fastcall unlock_page(struct page *page)
 {
 	wait_queue_head_t *waitqueue = page_waitqueue(page);
 	ClearPageLaunder(page);
@@ -974,7 +974,7 @@
  * Get an exclusive lock on the page, optimistically
  * assuming it's not locked..
  */
-void lock_page(struct page *page)
+void fastcall lock_page(struct page *page)
 {
 	if (TryLockPage(page))
 		__lock_page(page);
@@ -1025,7 +1025,7 @@
  * during blocking operations..
  */
 static struct page * FASTCALL(__find_lock_page_helper(struct address_space *, unsigned long, struct page *));
-static struct page * __find_lock_page_helper(struct address_space *mapping,
+static fastcall struct page * __find_lock_page_helper(struct address_space *mapping,
 					unsigned long offset, struct page *hash)
 {
 	struct page *page;
@@ -1388,7 +1388,7 @@
  * If it was already so marked, move it to the active queue and drop
  * the referenced bit.  Otherwise, just mark it for future action..
  */
-void mark_page_accessed(struct page *page)
+void fastcall mark_page_accessed(struct page *page)
 {
 	if (!PageActive(page) && PageReferenced(page)) {
 		activate_page(page);
diff -Nru a/mm/memory.c b/mm/memory.c
--- a/mm/memory.c	2004-06-29 15:31:58 -07:00
+++ b/mm/memory.c	2004-06-29 15:31:58 -07:00
@@ -1396,7 +1396,7 @@
  * On a two-level page table, this ends up actually being entirely
  * optimized away.
  */
-pmd_t *__pmd_alloc(struct mm_struct *mm, pgd_t *pgd, unsigned long address)
+fastcall pmd_t *_pmd_alloc(struct mm_struct *mm, pgd_t *pgd, unsigned long address)
 {
 	pmd_t *new;
 
@@ -1430,7 +1430,7 @@
  * We've already handled the fast-path in-line, and we own the
  * page table lock.
  */
-pte_t *pte_alloc(struct mm_struct *mm, pmd_t *pmd, unsigned long address)
+fastcall pte_t *pte_alloc(struct mm_struct *mm, pmd_t *pmd, unsigned long address)
 {
 	if (pmd_none(*pmd)) {
 		pte_t *new;
diff -Nru a/mm/page_alloc.c b/mm/page_alloc.c
--- a/mm/page_alloc.c	2004-06-29 15:31:58 -07:00
+++ b/mm/page_alloc.c	2004-06-29 15:31:58 -07:00
@@ -111,7 +111,7 @@
  * -- wli
  */
 
-static void __free_pages_ok (struct page *page, unsigned int order)
+static fastcall void __free_pages_ok (struct page *page, unsigned int order)
 {
 	unsigned long index, page_idx, mask, flags;
 	free_area_t *area;
@@ -241,7 +241,7 @@
 }
 
 static FASTCALL(struct page * rmqueue(zone_t *zone, unsigned int order));
-static struct page * rmqueue(zone_t *zone, unsigned int order)
+static fastcall struct page * rmqueue(zone_t *zone, unsigned int order)
 {
 	free_area_t * area = zone->free_area + order;
 	unsigned int curr_order = order;
@@ -287,7 +287,7 @@
 }
 
 #ifndef CONFIG_DISCONTIGMEM
-struct page *_alloc_pages(unsigned int gfp_mask, unsigned int order)
+fastcall struct page *_alloc_pages(unsigned int gfp_mask, unsigned int order)
 {
 	return __alloc_pages(gfp_mask, order,
 		contig_page_data.node_zonelists+(gfp_mask & GFP_ZONEMASK));
@@ -295,7 +295,7 @@
 #endif
 
 static struct page * FASTCALL(balance_classzone(zone_t *, unsigned int, unsigned int, int *));
-static struct page * balance_classzone(zone_t * classzone, unsigned int gfp_mask, unsigned int order, int * freed)
+static fastcall struct page * balance_classzone(zone_t * classzone, unsigned int gfp_mask, unsigned int order, int * freed)
 {
 	struct page * page = NULL;
 	int __freed;
@@ -373,7 +373,7 @@
 /*
  * This is the 'heart' of the zoned buddy allocator:
  */
-struct page * __alloc_pages(unsigned int gfp_mask, unsigned int order, zonelist_t *zonelist)
+fastcall struct page * __alloc_pages(unsigned int gfp_mask, unsigned int order, zonelist_t *zonelist)
 {
 	zone_t **zone, * classzone;
 	struct page * page;
@@ -486,7 +486,7 @@
 /*
  * Common helper functions.
  */
-unsigned long __get_free_pages(unsigned int gfp_mask, unsigned int order)
+fastcall unsigned long __get_free_pages(unsigned int gfp_mask, unsigned int order)
 {
 	struct page * page;
 
@@ -496,7 +496,7 @@
 	return (unsigned long) page_address(page);
 }
 
-unsigned long get_zeroed_page(unsigned int gfp_mask)
+fastcall unsigned long get_zeroed_page(unsigned int gfp_mask)
 {
 	struct page * page;
 
@@ -509,13 +509,13 @@
 	return 0;
 }
 
-void __free_pages(struct page *page, unsigned int order)
+fastcall void __free_pages(struct page *page, unsigned int order)
 {
 	if (!PageReserved(page) && put_page_testzero(page))
 		__free_pages_ok(page, order);
 }
 
-void free_pages(unsigned long addr, unsigned int order)
+fastcall void free_pages(unsigned long addr, unsigned int order)
 {
 	if (addr != 0)
 		__free_pages(virt_to_page(addr), order);
diff -Nru a/mm/slab.c b/mm/slab.c
--- a/mm/slab.c	2004-06-29 15:31:58 -07:00
+++ b/mm/slab.c	2004-06-29 15:31:58 -07:00
@@ -1735,7 +1735,7 @@
  *
  * Called from do_try_to_free_pages() and __alloc_pages()
  */
-int kmem_cache_reap (int gfp_mask)
+int fastcall kmem_cache_reap (int gfp_mask)
 {
 	slab_t *slabp;
 	kmem_cache_t *searchp;
diff -Nru a/mm/swap.c b/mm/swap.c
--- a/mm/swap.c	2004-06-29 15:31:58 -07:00
+++ b/mm/swap.c	2004-06-29 15:31:58 -07:00
@@ -36,7 +36,7 @@
 /*
  * Move an inactive page to the active list.
  */
-static inline void activate_page_nolock(struct page * page)
+static fastcall void activate_page_nolock(struct page * page)
 {
 	if (PageLRU(page) && !PageActive(page)) {
 		del_page_from_inactive_list(page);
@@ -44,7 +44,7 @@
 	}
 }
 
-void activate_page(struct page * page)
+fastcall void activate_page(struct page * page)
 {
 	spin_lock(&pagemap_lru_lock);
 	activate_page_nolock(page);
@@ -55,7 +55,7 @@
  * lru_cache_add: add a page to the page lists
  * @page: the page to add
  */
-void lru_cache_add(struct page * page)
+void fastcall lru_cache_add(struct page * page)
 {
 	if (!PageLRU(page)) {
 		spin_lock(&pagemap_lru_lock);
@@ -72,7 +72,7 @@
  * This function is for when the caller already holds
  * the pagemap_lru_lock.
  */
-void __lru_cache_del(struct page * page)
+void fastcall __lru_cache_del(struct page * page)
 {
 	if (TestClearPageLRU(page)) {
 		if (PageActive(page)) {
@@ -87,7 +87,7 @@
  * lru_cache_del: remove a page from the page lists
  * @page: the page to remove
  */
-void lru_cache_del(struct page * page)
+void fastcall lru_cache_del(struct page * page)
 {
 	spin_lock(&pagemap_lru_lock);
 	__lru_cache_del(page);
diff -Nru a/mm/swapfile.c b/mm/swapfile.c
--- a/mm/swapfile.c	2004-06-29 15:31:58 -07:00
+++ b/mm/swapfile.c	2004-06-29 15:31:58 -07:00
@@ -256,7 +256,7 @@
  * work, but we opportunistically check whether
  * we need to get all the locks first..
  */
-int can_share_swap_page(struct page *page)
+fastcall int can_share_swap_page(struct page *page)
 {
 	int retval = 0;
 
@@ -284,7 +284,7 @@
  * Work out if there are any other processes sharing this
  * swap cache page. Free it if you can. Return success.
  */
-int remove_exclusive_swap_page(struct page *page)
+fastcall int remove_exclusive_swap_page(struct page *page)
 {
 	int retval;
 	struct swap_info_struct * p;
diff -Nru a/mm/vmscan.c b/mm/vmscan.c
--- a/mm/vmscan.c	2004-06-29 15:31:58 -07:00
+++ b/mm/vmscan.c	2004-06-29 15:31:58 -07:00
@@ -323,7 +323,7 @@
 }
 
 static int FASTCALL(swap_out(zone_t * classzone));
-static int swap_out(zone_t * classzone)
+static int fastcall swap_out(zone_t * classzone)
 {
 	int counter, nr_pages = SWAP_CLUSTER_MAX;
 	struct mm_struct *mm;
@@ -366,7 +366,7 @@
 
 static void FASTCALL(refill_inactive(int nr_pages, zone_t * classzone));
 static int FASTCALL(shrink_cache(int nr_pages, zone_t * classzone, unsigned int gfp_mask, int * failed_swapout));
-static int shrink_cache(int nr_pages, zone_t * classzone, unsigned int gfp_mask, int * failed_swapout)
+static int fastcall shrink_cache(int nr_pages, zone_t * classzone, unsigned int gfp_mask, int * failed_swapout)
 {
 	struct list_head * entry;
 	int max_scan = (classzone->nr_inactive_pages + classzone->nr_active_pages) / vm_cache_scan_ratio;
@@ -577,7 +577,7 @@
  * We move them the other way when we see the
  * reference bit on the page.
  */
-static void refill_inactive(int nr_pages, zone_t * classzone)
+static fastcall void refill_inactive(int nr_pages, zone_t * classzone)
 {
 	struct list_head * entry;
 	unsigned long ratio;
@@ -610,7 +610,7 @@
 }
 
 static int FASTCALL(shrink_caches(zone_t * classzone, unsigned int gfp_mask, int nr_pages, int * failed_swapout));
-static int shrink_caches(zone_t * classzone, unsigned int gfp_mask, int nr_pages, int * failed_swapout)
+static fastcall int shrink_caches(zone_t * classzone, unsigned int gfp_mask, int nr_pages, int * failed_swapout)
 {
 	nr_pages -= kmem_cache_reap(gfp_mask);
 	if (nr_pages <= 0)
@@ -627,7 +627,7 @@
 
 static int check_classzone_need_balance(zone_t * classzone);
 
-int try_to_free_pages_zone(zone_t *classzone, unsigned int gfp_mask)
+fastcall int try_to_free_pages_zone(zone_t *classzone, unsigned int gfp_mask)
 {
 	gfp_mask = pf_gfp_mask(gfp_mask);
 
@@ -665,7 +665,7 @@
 	return 0;
 }
 
-int try_to_free_pages(unsigned int gfp_mask)
+fastcall int try_to_free_pages(unsigned int gfp_mask)
 {
 	pg_data_t *pgdat;
 	zonelist_t *zonelist;
