Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751322AbWE2VYK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751322AbWE2VYK (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 29 May 2006 17:24:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751333AbWE2VXq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 29 May 2006 17:23:46 -0400
Received: from mx3.mail.elte.hu ([157.181.1.138]:4280 "EHLO mx3.mail.elte.hu")
	by vger.kernel.org with ESMTP id S1751322AbWE2VXh (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 29 May 2006 17:23:37 -0400
Date: Mon, 29 May 2006 23:23:54 +0200
From: Ingo Molnar <mingo@elte.hu>
To: linux-kernel@vger.kernel.org
Cc: Arjan van de Ven <arjan@infradead.org>, Andrew Morton <akpm@osdl.org>
Subject: [patch 10/61] lock validator: locking init debugging improvement
Message-ID: <20060529212354.GJ3155@elte.hu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060529212109.GA2058@elte.hu>
User-Agent: Mutt/1.4.2.1i
X-ELTE-SpamScore: 0.0
X-ELTE-SpamLevel: 
X-ELTE-SpamCheck: no
X-ELTE-SpamVersion: ELTE 2.0 
X-ELTE-SpamCheck-Details: score=0.0 required=5.9 tests=AWL autolearn=no SpamAssassin version=3.0.3
	0.0 AWL                    AWL: From: address is in the auto white-list
X-ELTE-VirusStatus: clean
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Ingo Molnar <mingo@elte.hu>

locking init improvement:

 - introduce and use __SPIN_LOCK_UNLOCKED for array initializations,
   to pass in the name string of locks, used by debugging

Signed-off-by: Ingo Molnar <mingo@elte.hu>
Signed-off-by: Arjan van de Ven <arjan@linux.intel.com>
---
 arch/x86_64/kernel/smpboot.c   |    3 +++
 arch/x86_64/kernel/vsyscall.c  |    2 +-
 block/ll_rw_blk.c              |    1 +
 drivers/char/random.c          |    6 +++---
 drivers/ide/ide-io.c           |    2 ++
 drivers/scsi/libata-core.c     |    2 ++
 drivers/spi/spi.c              |    1 +
 fs/dcache.c                    |    2 +-
 include/linux/idr.h            |    2 +-
 include/linux/init_task.h      |   10 +++++-----
 include/linux/notifier.h       |    2 +-
 include/linux/seqlock.h        |   12 ++++++++++--
 include/linux/spinlock_types.h |   15 +++++++++------
 include/linux/wait.h           |    2 +-
 kernel/kmod.c                  |    2 ++
 kernel/rcupdate.c              |    4 ++--
 kernel/timer.c                 |    2 +-
 mm/swap_state.c                |    2 +-
 net/ipv4/tcp_ipv4.c            |    2 +-
 net/ipv4/tcp_minisocks.c       |    2 +-
 net/ipv4/xfrm4_policy.c        |    4 ++--
 21 files changed, 51 insertions(+), 29 deletions(-)

Index: linux/arch/x86_64/kernel/smpboot.c
===================================================================
--- linux.orig/arch/x86_64/kernel/smpboot.c
+++ linux/arch/x86_64/kernel/smpboot.c
@@ -771,8 +771,11 @@ static int __cpuinit do_boot_cpu(int cpu
 		.cpu = cpu,
 		.done = COMPLETION_INITIALIZER(c_idle.done),
 	};
+
 	DECLARE_WORK(work, do_fork_idle, &c_idle);
 
+	init_completion(&c_idle.done);
+
 	/* allocate memory for gdts of secondary cpus. Hotplug is considered */
 	if (!cpu_gdt_descr[cpu].address &&
 		!(cpu_gdt_descr[cpu].address = get_zeroed_page(GFP_KERNEL))) {
Index: linux/arch/x86_64/kernel/vsyscall.c
===================================================================
--- linux.orig/arch/x86_64/kernel/vsyscall.c
+++ linux/arch/x86_64/kernel/vsyscall.c
@@ -37,7 +37,7 @@
 #define __vsyscall(nr) __attribute__ ((unused,__section__(".vsyscall_" #nr)))
 
 int __sysctl_vsyscall __section_sysctl_vsyscall = 1;
-seqlock_t __xtime_lock __section_xtime_lock = SEQLOCK_UNLOCKED;
+__section_xtime_lock DEFINE_SEQLOCK(__xtime_lock);
 
 #include <asm/unistd.h>
 
Index: linux/block/ll_rw_blk.c
===================================================================
--- linux.orig/block/ll_rw_blk.c
+++ linux/block/ll_rw_blk.c
@@ -2529,6 +2529,7 @@ int blk_execute_rq(request_queue_t *q, s
 	char sense[SCSI_SENSE_BUFFERSIZE];
 	int err = 0;
 
+	init_completion(&wait);
 	/*
 	 * we need an extra reference to the request, so we can look at
 	 * it after io completion
Index: linux/drivers/char/random.c
===================================================================
--- linux.orig/drivers/char/random.c
+++ linux/drivers/char/random.c
@@ -417,7 +417,7 @@ static struct entropy_store input_pool =
 	.poolinfo = &poolinfo_table[0],
 	.name = "input",
 	.limit = 1,
-	.lock = SPIN_LOCK_UNLOCKED,
+	.lock = __SPIN_LOCK_UNLOCKED(&input_pool.lock),
 	.pool = input_pool_data
 };
 
@@ -426,7 +426,7 @@ static struct entropy_store blocking_poo
 	.name = "blocking",
 	.limit = 1,
 	.pull = &input_pool,
-	.lock = SPIN_LOCK_UNLOCKED,
+	.lock = __SPIN_LOCK_UNLOCKED(&blocking_pool.lock),
 	.pool = blocking_pool_data
 };
 
@@ -434,7 +434,7 @@ static struct entropy_store nonblocking_
 	.poolinfo = &poolinfo_table[1],
 	.name = "nonblocking",
 	.pull = &input_pool,
-	.lock = SPIN_LOCK_UNLOCKED,
+	.lock = __SPIN_LOCK_UNLOCKED(&nonblocking_pool.lock),
 	.pool = nonblocking_pool_data
 };
 
Index: linux/drivers/ide/ide-io.c
===================================================================
--- linux.orig/drivers/ide/ide-io.c
+++ linux/drivers/ide/ide-io.c
@@ -1700,6 +1700,8 @@ int ide_do_drive_cmd (ide_drive_t *drive
 	int where = ELEVATOR_INSERT_BACK, err;
 	int must_wait = (action == ide_wait || action == ide_head_wait);
 
+	init_completion(&wait);
+
 	rq->errors = 0;
 	rq->rq_status = RQ_ACTIVE;
 
Index: linux/drivers/scsi/libata-core.c
===================================================================
--- linux.orig/drivers/scsi/libata-core.c
+++ linux/drivers/scsi/libata-core.c
@@ -994,6 +994,8 @@ unsigned ata_exec_internal(struct ata_de
 	unsigned int err_mask;
 	int rc;
 
+	init_completion(&wait);
+
 	spin_lock_irqsave(&ap->host_set->lock, flags);
 
 	/* no internal command while frozen */
Index: linux/drivers/spi/spi.c
===================================================================
--- linux.orig/drivers/spi/spi.c
+++ linux/drivers/spi/spi.c
@@ -512,6 +512,7 @@ int spi_sync(struct spi_device *spi, str
 	DECLARE_COMPLETION(done);
 	int status;
 
+	init_completion(&done);
 	message->complete = spi_complete;
 	message->context = &done;
 	status = spi_async(spi, message);
Index: linux/fs/dcache.c
===================================================================
--- linux.orig/fs/dcache.c
+++ linux/fs/dcache.c
@@ -39,7 +39,7 @@ int sysctl_vfs_cache_pressure __read_mos
 EXPORT_SYMBOL_GPL(sysctl_vfs_cache_pressure);
 
  __cacheline_aligned_in_smp DEFINE_SPINLOCK(dcache_lock);
-static seqlock_t rename_lock __cacheline_aligned_in_smp = SEQLOCK_UNLOCKED;
+static __cacheline_aligned_in_smp DEFINE_SEQLOCK(rename_lock);
 
 EXPORT_SYMBOL(dcache_lock);
 
Index: linux/include/linux/idr.h
===================================================================
--- linux.orig/include/linux/idr.h
+++ linux/include/linux/idr.h
@@ -66,7 +66,7 @@ struct idr {
 	.id_free	= NULL,					\
 	.layers 	= 0,					\
 	.id_free_cnt	= 0,					\
-	.lock		= SPIN_LOCK_UNLOCKED,			\
+	.lock		= __SPIN_LOCK_UNLOCKED(name.lock),	\
 }
 #define DEFINE_IDR(name)	struct idr name = IDR_INIT(name)
 
Index: linux/include/linux/init_task.h
===================================================================
--- linux.orig/include/linux/init_task.h
+++ linux/include/linux/init_task.h
@@ -22,7 +22,7 @@
 	.count		= ATOMIC_INIT(1), 		\
 	.fdt		= &init_files.fdtab, 		\
 	.fdtab		= INIT_FDTABLE,			\
-	.file_lock	= SPIN_LOCK_UNLOCKED, 		\
+	.file_lock	= __SPIN_LOCK_UNLOCKED(init_task.file_lock), \
 	.next_fd	= 0, 				\
 	.close_on_exec_init = { { 0, } }, 		\
 	.open_fds_init	= { { 0, } }, 			\
@@ -37,7 +37,7 @@
 	.user_id	= 0,				\
 	.next		= NULL,				\
 	.wait		= __WAIT_QUEUE_HEAD_INITIALIZER(name.wait), \
-	.ctx_lock	= SPIN_LOCK_UNLOCKED,		\
+	.ctx_lock	= __SPIN_LOCK_UNLOCKED(name.ctx_lock), \
 	.reqs_active	= 0U,				\
 	.max_reqs	= ~0U,				\
 }
@@ -49,7 +49,7 @@
 	.mm_users	= ATOMIC_INIT(2), 			\
 	.mm_count	= ATOMIC_INIT(1), 			\
 	.mmap_sem	= __RWSEM_INITIALIZER(name.mmap_sem),	\
-	.page_table_lock =  SPIN_LOCK_UNLOCKED, 		\
+	.page_table_lock =  __SPIN_LOCK_UNLOCKED(name.page_table_lock),	\
 	.mmlist		= LIST_HEAD_INIT(name.mmlist),		\
 	.cpu_vm_mask	= CPU_MASK_ALL,				\
 }
@@ -78,7 +78,7 @@ extern struct nsproxy init_nsproxy;
 #define INIT_SIGHAND(sighand) {						\
 	.count		= ATOMIC_INIT(1), 				\
 	.action		= { { { .sa_handler = NULL, } }, },		\
-	.siglock	= SPIN_LOCK_UNLOCKED, 				\
+	.siglock	= __SPIN_LOCK_UNLOCKED(sighand.siglock),	\
 }
 
 extern struct group_info init_groups;
@@ -129,7 +129,7 @@ extern struct group_info init_groups;
 		.list = LIST_HEAD_INIT(tsk.pending.list),		\
 		.signal = {{0}}},					\
 	.blocked	= {{0}},					\
-	.alloc_lock	= SPIN_LOCK_UNLOCKED,				\
+	.alloc_lock	= __SPIN_LOCK_UNLOCKED(tsk.alloc_lock),		\
 	.journal_info	= NULL,						\
 	.cpu_timers	= INIT_CPU_TIMERS(tsk.cpu_timers),		\
 	.fs_excl	= ATOMIC_INIT(0),				\
Index: linux/include/linux/notifier.h
===================================================================
--- linux.orig/include/linux/notifier.h
+++ linux/include/linux/notifier.h
@@ -65,7 +65,7 @@ struct raw_notifier_head {
 	} while (0)
 
 #define ATOMIC_NOTIFIER_INIT(name) {				\
-		.lock = SPIN_LOCK_UNLOCKED,			\
+		.lock = __SPIN_LOCK_UNLOCKED(name.lock),	\
 		.head = NULL }
 #define BLOCKING_NOTIFIER_INIT(name) {				\
 		.rwsem = __RWSEM_INITIALIZER((name).rwsem),	\
Index: linux/include/linux/seqlock.h
===================================================================
--- linux.orig/include/linux/seqlock.h
+++ linux/include/linux/seqlock.h
@@ -38,9 +38,17 @@ typedef struct {
  * These macros triggered gcc-3.x compile-time problems.  We think these are
  * OK now.  Be cautious.
  */
-#define SEQLOCK_UNLOCKED { 0, SPIN_LOCK_UNLOCKED }
-#define seqlock_init(x)	do { *(x) = (seqlock_t) SEQLOCK_UNLOCKED; } while (0)
+#define __SEQLOCK_UNLOCKED(lockname) \
+		 { 0, __SPIN_LOCK_UNLOCKED(lockname) }
 
+#define SEQLOCK_UNLOCKED \
+		 __SEQLOCK_UNLOCKED(old_style_seqlock_init)
+
+#define seqlock_init(x) \
+		do { *(x) = (seqlock_t) __SEQLOCK_UNLOCKED(x); } while (0)
+
+#define DEFINE_SEQLOCK(x) \
+		seqlock_t x = __SEQLOCK_UNLOCKED(x)
 
 /* Lock out other writers and update the count.
  * Acts like a normal spin_lock/unlock.
Index: linux/include/linux/spinlock_types.h
===================================================================
--- linux.orig/include/linux/spinlock_types.h
+++ linux/include/linux/spinlock_types.h
@@ -44,24 +44,27 @@ typedef struct {
 #define SPINLOCK_OWNER_INIT	((void *)-1L)
 
 #ifdef CONFIG_DEBUG_SPINLOCK
-# define SPIN_LOCK_UNLOCKED						\
+# define __SPIN_LOCK_UNLOCKED(lockname)					\
 	(spinlock_t)	{	.raw_lock = __RAW_SPIN_LOCK_UNLOCKED,	\
 				.magic = SPINLOCK_MAGIC,		\
 				.owner = SPINLOCK_OWNER_INIT,		\
 				.owner_cpu = -1 }
-#define RW_LOCK_UNLOCKED						\
+#define __RW_LOCK_UNLOCKED(lockname)					\
 	(rwlock_t)	{	.raw_lock = __RAW_RW_LOCK_UNLOCKED,	\
 				.magic = RWLOCK_MAGIC,			\
 				.owner = SPINLOCK_OWNER_INIT,		\
 				.owner_cpu = -1 }
 #else
-# define SPIN_LOCK_UNLOCKED \
+# define __SPIN_LOCK_UNLOCKED(lockname) \
 	(spinlock_t)	{	.raw_lock = __RAW_SPIN_LOCK_UNLOCKED }
-#define RW_LOCK_UNLOCKED \
+#define __RW_LOCK_UNLOCKED(lockname) \
 	(rwlock_t)	{	.raw_lock = __RAW_RW_LOCK_UNLOCKED }
 #endif
 
-#define DEFINE_SPINLOCK(x)	spinlock_t x = SPIN_LOCK_UNLOCKED
-#define DEFINE_RWLOCK(x)	rwlock_t x = RW_LOCK_UNLOCKED
+#define SPIN_LOCK_UNLOCKED	__SPIN_LOCK_UNLOCKED(old_style_spin_init)
+#define RW_LOCK_UNLOCKED	__RW_LOCK_UNLOCKED(old_style_rw_init)
+
+#define DEFINE_SPINLOCK(x)	spinlock_t x = __SPIN_LOCK_UNLOCKED(x)
+#define DEFINE_RWLOCK(x)	rwlock_t x = __RW_LOCK_UNLOCKED(x)
 
 #endif /* __LINUX_SPINLOCK_TYPES_H */
Index: linux/include/linux/wait.h
===================================================================
--- linux.orig/include/linux/wait.h
+++ linux/include/linux/wait.h
@@ -68,7 +68,7 @@ struct task_struct;
 	wait_queue_t name = __WAITQUEUE_INITIALIZER(name, tsk)
 
 #define __WAIT_QUEUE_HEAD_INITIALIZER(name) {				\
-	.lock		= SPIN_LOCK_UNLOCKED,				\
+	.lock		= __SPIN_LOCK_UNLOCKED(name.lock),		\
 	.task_list	= { &(name).task_list, &(name).task_list } }
 
 #define DECLARE_WAIT_QUEUE_HEAD(name) \
Index: linux/kernel/kmod.c
===================================================================
--- linux.orig/kernel/kmod.c
+++ linux/kernel/kmod.c
@@ -246,6 +246,8 @@ int call_usermodehelper_keys(char *path,
 	};
 	DECLARE_WORK(work, __call_usermodehelper, &sub_info);
 
+	init_completion(&done);
+
 	if (!khelper_wq)
 		return -EBUSY;
 
Index: linux/kernel/rcupdate.c
===================================================================
--- linux.orig/kernel/rcupdate.c
+++ linux/kernel/rcupdate.c
@@ -53,13 +53,13 @@
 static struct rcu_ctrlblk rcu_ctrlblk = {
 	.cur = -300,
 	.completed = -300,
-	.lock = SPIN_LOCK_UNLOCKED,
+	.lock = __SPIN_LOCK_UNLOCKED(&rcu_ctrlblk.lock),
 	.cpumask = CPU_MASK_NONE,
 };
 static struct rcu_ctrlblk rcu_bh_ctrlblk = {
 	.cur = -300,
 	.completed = -300,
-	.lock = SPIN_LOCK_UNLOCKED,
+	.lock = __SPIN_LOCK_UNLOCKED(&rcu_bh_ctrlblk.lock),
 	.cpumask = CPU_MASK_NONE,
 };
 
Index: linux/kernel/timer.c
===================================================================
--- linux.orig/kernel/timer.c
+++ linux/kernel/timer.c
@@ -1142,7 +1142,7 @@ unsigned long wall_jiffies = INITIAL_JIF
  * playing with xtime and avenrun.
  */
 #ifndef ARCH_HAVE_XTIME_LOCK
-seqlock_t xtime_lock __cacheline_aligned_in_smp = SEQLOCK_UNLOCKED;
+__cacheline_aligned_in_smp DEFINE_SEQLOCK(xtime_lock);
 
 EXPORT_SYMBOL(xtime_lock);
 #endif
Index: linux/mm/swap_state.c
===================================================================
--- linux.orig/mm/swap_state.c
+++ linux/mm/swap_state.c
@@ -39,7 +39,7 @@ static struct backing_dev_info swap_back
 
 struct address_space swapper_space = {
 	.page_tree	= RADIX_TREE_INIT(GFP_ATOMIC|__GFP_NOWARN),
-	.tree_lock	= RW_LOCK_UNLOCKED,
+	.tree_lock	= __RW_LOCK_UNLOCKED(swapper_space.tree_lock),
 	.a_ops		= &swap_aops,
 	.i_mmap_nonlinear = LIST_HEAD_INIT(swapper_space.i_mmap_nonlinear),
 	.backing_dev_info = &swap_backing_dev_info,
Index: linux/net/ipv4/tcp_ipv4.c
===================================================================
--- linux.orig/net/ipv4/tcp_ipv4.c
+++ linux/net/ipv4/tcp_ipv4.c
@@ -90,7 +90,7 @@ static struct socket *tcp_socket;
 void tcp_v4_send_check(struct sock *sk, int len, struct sk_buff *skb);
 
 struct inet_hashinfo __cacheline_aligned tcp_hashinfo = {
-	.lhash_lock	= RW_LOCK_UNLOCKED,
+	.lhash_lock	= __RW_LOCK_UNLOCKED(tcp_hashinfo.lhash_lock),
 	.lhash_users	= ATOMIC_INIT(0),
 	.lhash_wait	= __WAIT_QUEUE_HEAD_INITIALIZER(tcp_hashinfo.lhash_wait),
 };
Index: linux/net/ipv4/tcp_minisocks.c
===================================================================
--- linux.orig/net/ipv4/tcp_minisocks.c
+++ linux/net/ipv4/tcp_minisocks.c
@@ -41,7 +41,7 @@ int sysctl_tcp_abort_on_overflow;
 struct inet_timewait_death_row tcp_death_row = {
 	.sysctl_max_tw_buckets = NR_FILE * 2,
 	.period		= TCP_TIMEWAIT_LEN / INET_TWDR_TWKILL_SLOTS,
-	.death_lock	= SPIN_LOCK_UNLOCKED,
+	.death_lock	= __SPIN_LOCK_UNLOCKED(tcp_death_row.death_lock),
 	.hashinfo	= &tcp_hashinfo,
 	.tw_timer	= TIMER_INITIALIZER(inet_twdr_hangman, 0,
 					    (unsigned long)&tcp_death_row),
Index: linux/net/ipv4/xfrm4_policy.c
===================================================================
--- linux.orig/net/ipv4/xfrm4_policy.c
+++ linux/net/ipv4/xfrm4_policy.c
@@ -17,7 +17,7 @@
 static struct dst_ops xfrm4_dst_ops;
 static struct xfrm_policy_afinfo xfrm4_policy_afinfo;
 
-static struct xfrm_type_map xfrm4_type_map = { .lock = RW_LOCK_UNLOCKED };
+static struct xfrm_type_map xfrm4_type_map = { .lock = __RW_LOCK_UNLOCKED(xfrm4_type_map.lock) };
 
 static int xfrm4_dst_lookup(struct xfrm_dst **dst, struct flowi *fl)
 {
@@ -299,7 +299,7 @@ static struct dst_ops xfrm4_dst_ops = {
 
 static struct xfrm_policy_afinfo xfrm4_policy_afinfo = {
 	.family = 		AF_INET,
-	.lock = 		RW_LOCK_UNLOCKED,
+	.lock = 		__RW_LOCK_UNLOCKED(xfrm4_policy_afinfo.lock),
 	.type_map = 		&xfrm4_type_map,
 	.dst_ops =		&xfrm4_dst_ops,
 	.dst_lookup =		xfrm4_dst_lookup,
