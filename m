Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S268274AbTAMHQl>; Mon, 13 Jan 2003 02:16:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S268276AbTAMHQl>; Mon, 13 Jan 2003 02:16:41 -0500
Received: from dp.samba.org ([66.70.73.150]:3714 "EHLO lists.samba.org")
	by vger.kernel.org with ESMTP id <S268274AbTAMHQa>;
	Mon, 13 Jan 2003 02:16:30 -0500
From: Rusty Russell <rusty@rustcorp.com.au>
To: akpm@zip.com.au, davem@redhat.com, torvalds@transmeta.com
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH] __cacheline_aligned_in_smp?
Date: Mon, 13 Jan 2003 18:24:40 +1100
Message-Id: <20030113072521.74B842C104@lists.samba.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Dave: Anton suggested you might have a justification for
__cacheline_aligned doing something on UP?

I think I'd prefer __cacheline_aligned to be the same as
__cacheline_aligned_in_smp, and have a new __cacheline_aligned_always
for those who REALLY want it (if any).

Thoughts?
Rusty.

diff -urpN --exclude TAGS -X /home/rusty/devel/kernel/kernel-patches/current-dontdiff --minimal linux-2.5-bk/drivers/cdrom/sbpcd.c working-2.5-bk-cacheline-nosmp/drivers/cdrom/sbpcd.c
--- linux-2.5-bk/drivers/cdrom/sbpcd.c	2003-01-02 12:45:18.000000000 +1100
+++ working-2.5-bk-cacheline-nosmp/drivers/cdrom/sbpcd.c	2003-01-13 18:19:08.000000000 +1100
@@ -462,7 +462,7 @@ static int sbpcd[] =
 /*
  * Protects access to global structures etc.
  */
-static spinlock_t sbpcd_lock __cacheline_aligned = SPIN_LOCK_UNLOCKED;
+static spinlock_t sbpcd_lock __cacheline_aligned_in_smp = SPIN_LOCK_UNLOCKED;
 static struct request_queue sbpcd_queue;
 
 MODULE_PARM(sbpcd, "2i");
diff -urpN --exclude TAGS -X /home/rusty/devel/kernel/kernel-patches/current-dontdiff --minimal linux-2.5-bk/drivers/char/random.c working-2.5-bk-cacheline-nosmp/drivers/char/random.c
--- linux-2.5-bk/drivers/char/random.c	2003-01-02 14:47:58.000000000 +1100
+++ working-2.5-bk-cacheline-nosmp/drivers/char/random.c	2003-01-13 18:18:57.000000000 +1100
@@ -2050,7 +2050,7 @@ static struct keydata {
 	time_t rekey_time;
 	__u32	count;		// already shifted to the final position
 	__u32	secret[12];
-} ____cacheline_aligned ip_keydata[2];
+} ____cacheline_aligned_in_smp ip_keydata[2];
 
 static spinlock_t ip_lock = SPIN_LOCK_UNLOCKED;
 static unsigned int ip_cnt;
diff -urpN --exclude TAGS -X /home/rusty/devel/kernel/kernel-patches/current-dontdiff --minimal linux-2.5-bk/drivers/oprofile/cpu_buffer.c working-2.5-bk-cacheline-nosmp/drivers/oprofile/cpu_buffer.c
--- linux-2.5-bk/drivers/oprofile/cpu_buffer.c	2003-01-02 12:47:01.000000000 +1100
+++ working-2.5-bk-cacheline-nosmp/drivers/oprofile/cpu_buffer.c	2003-01-13 18:19:21.000000000 +1100
@@ -24,7 +24,7 @@
 #include "cpu_buffer.h"
 #include "oprof.h"
 
-struct oprofile_cpu_buffer cpu_buffer[NR_CPUS] __cacheline_aligned;
+struct oprofile_cpu_buffer cpu_buffer[NR_CPUS] __cacheline_aligned_in_smp;
 
 static unsigned long buffer_size;
  
diff -urpN --exclude TAGS -X /home/rusty/devel/kernel/kernel-patches/current-dontdiff --minimal linux-2.5-bk/drivers/oprofile/cpu_buffer.h working-2.5-bk-cacheline-nosmp/drivers/oprofile/cpu_buffer.h
--- linux-2.5-bk/drivers/oprofile/cpu_buffer.h	2003-01-02 12:45:22.000000000 +1100
+++ working-2.5-bk-cacheline-nosmp/drivers/oprofile/cpu_buffer.h	2003-01-13 18:19:50.000000000 +1100
@@ -39,7 +39,7 @@ struct oprofile_cpu_buffer {
 	unsigned long sample_lost_locked;
 	unsigned long sample_lost_overflow;
 	unsigned long sample_lost_task_exit;
-} ____cacheline_aligned;
+} ____cacheline_aligned_in_smp;
 
 extern struct oprofile_cpu_buffer cpu_buffer[];
 
diff -urpN --exclude TAGS -X /home/rusty/devel/kernel/kernel-patches/current-dontdiff --minimal linux-2.5-bk/drivers/scsi/scsi.c working-2.5-bk-cacheline-nosmp/drivers/scsi/scsi.c
--- linux-2.5-bk/drivers/scsi/scsi.c	2003-01-02 12:47:02.000000000 +1100
+++ working-2.5-bk-cacheline-nosmp/drivers/scsi/scsi.c	2003-01-13 18:19:03.000000000 +1100
@@ -104,7 +104,7 @@ struct softscsi_data {
 	Scsi_Cmnd *tail;
 };
 
-static struct softscsi_data softscsi_data[NR_CPUS] __cacheline_aligned;
+static struct softscsi_data softscsi_data[NR_CPUS] __cacheline_aligned_in_smp;
 
 /*
  * List of all highlevel drivers.
diff -urpN --exclude TAGS -X /home/rusty/devel/kernel/kernel-patches/current-dontdiff --minimal linux-2.5-bk/include/linux/dcache.h working-2.5-bk-cacheline-nosmp/include/linux/dcache.h
--- linux-2.5-bk/include/linux/dcache.h	2003-01-02 12:36:08.000000000 +1100
+++ working-2.5-bk-cacheline-nosmp/include/linux/dcache.h	2003-01-13 18:17:28.000000000 +1100
@@ -89,7 +89,7 @@ struct dentry {
 	void * d_fsdata;		/* fs-specific data */
 	struct dcookie_struct * d_cookie; /* cookie, if any */
 	unsigned char d_iname[DNAME_INLINE_LEN_MIN]; /* small names */
-} ____cacheline_aligned;
+} ____cacheline_aligned_in_smp;
 
 #define DNAME_INLINE_LEN	(sizeof(struct dentry)-offsetof(struct dentry,d_iname))
  
diff -urpN --exclude TAGS -X /home/rusty/devel/kernel/kernel-patches/current-dontdiff --minimal linux-2.5-bk/include/linux/module.h working-2.5-bk-cacheline-nosmp/include/linux/module.h
--- linux-2.5-bk/include/linux/module.h	2003-01-13 16:56:29.000000000 +1100
+++ working-2.5-bk-cacheline-nosmp/include/linux/module.h	2003-01-13 18:17:25.000000000 +1100
@@ -155,7 +155,7 @@ void *__symbol_get_gpl(const char *symbo
 struct module_ref
 {
 	atomic_t count;
-} ____cacheline_aligned;
+} ____cacheline_aligned_in_smp;
 
 enum module_state
 {
diff -urpN --exclude TAGS -X /home/rusty/devel/kernel/kernel-patches/current-dontdiff --minimal linux-2.5-bk/include/linux/netdevice.h working-2.5-bk-cacheline-nosmp/include/linux/netdevice.h
--- linux-2.5-bk/include/linux/netdevice.h	2003-01-10 10:55:43.000000000 +1100
+++ working-2.5-bk-cacheline-nosmp/include/linux/netdevice.h	2003-01-13 18:17:22.000000000 +1100
@@ -163,7 +163,7 @@ struct netif_rx_stats
 	unsigned fastroute_deferred_out;
 	unsigned fastroute_latency_reduction;
 	unsigned cpu_collision;
-} ____cacheline_aligned;
+} ____cacheline_aligned_in_smp;
 
 extern struct netif_rx_stats netdev_rx_stat[];
 
@@ -508,7 +508,7 @@ struct softnet_data
 	struct sk_buff		*completion_queue;
 
 	struct net_device	backlog_dev;	/* Sorry. 8) */
-} ____cacheline_aligned;
+} ____cacheline_aligned_in_smp;
 
 
 extern struct softnet_data softnet_data[NR_CPUS];
diff -urpN --exclude TAGS -X /home/rusty/devel/kernel/kernel-patches/current-dontdiff --minimal linux-2.5-bk/include/linux/netfilter_bridge/ebtables.h working-2.5-bk-cacheline-nosmp/include/linux/netfilter_bridge/ebtables.h
--- linux-2.5-bk/include/linux/netfilter_bridge/ebtables.h	2003-01-02 12:32:48.000000000 +1100
+++ working-2.5-bk-cacheline-nosmp/include/linux/netfilter_bridge/ebtables.h	2003-01-13 18:17:52.000000000 +1100
@@ -243,7 +243,7 @@ struct ebt_table_info
 	// room to maintain the stack used for jumping from and into udc
 	struct ebt_chainstack **chainstack;
 	char *entries;
-	struct ebt_counter counters[0] ____cacheline_aligned;
+	struct ebt_counter counters[0] ____cacheline_aligned_in_smp;
 };
 
 struct ebt_table
diff -urpN --exclude TAGS -X /home/rusty/devel/kernel/kernel-patches/current-dontdiff --minimal linux-2.5-bk/kernel/acct.c working-2.5-bk-cacheline-nosmp/kernel/acct.c
--- linux-2.5-bk/kernel/acct.c	2003-01-02 14:48:01.000000000 +1100
+++ working-2.5-bk-cacheline-nosmp/kernel/acct.c	2003-01-13 18:16:51.000000000 +1100
@@ -83,7 +83,7 @@ struct acct_glbs {
 	struct timer_list	timer;
 };
 
-static struct acct_glbs acct_globals __cacheline_aligned = {SPIN_LOCK_UNLOCKED};
+static struct acct_glbs acct_globals __cacheline_aligned_in_smp = {SPIN_LOCK_UNLOCKED};
 
 /*
  * Called whenever the timer says to check the free space.
diff -urpN --exclude TAGS -X /home/rusty/devel/kernel/kernel-patches/current-dontdiff --minimal linux-2.5-bk/kernel/fork.c working-2.5-bk-cacheline-nosmp/kernel/fork.c
--- linux-2.5-bk/kernel/fork.c	2003-01-13 16:56:30.000000000 +1100
+++ working-2.5-bk-cacheline-nosmp/kernel/fork.c	2003-01-13 18:16:36.000000000 +1100
@@ -48,14 +48,14 @@ int nr_threads;
 int max_threads;
 unsigned long total_forks;	/* Handle normal Linux uptimes. */
 
-rwlock_t tasklist_lock __cacheline_aligned = RW_LOCK_UNLOCKED;  /* outer */
+rwlock_t tasklist_lock __cacheline_aligned_in_smp = RW_LOCK_UNLOCKED;  /* outer */
 
 /*
  * A per-CPU task cache - this relies on the fact that
  * the very last portion of sys_exit() is executed with
  * preemption turned off.
  */
-static task_t *task_cache[NR_CPUS] __cacheline_aligned;
+static task_t *task_cache[NR_CPUS] __cacheline_aligned_in_smp;
 
 void __put_task_struct(struct task_struct *tsk)
 {
diff -urpN --exclude TAGS -X /home/rusty/devel/kernel/kernel-patches/current-dontdiff --minimal linux-2.5-bk/kernel/sched.c working-2.5-bk-cacheline-nosmp/kernel/sched.c
--- linux-2.5-bk/kernel/sched.c	2003-01-13 16:56:30.000000000 +1100
+++ working-2.5-bk-cacheline-nosmp/kernel/sched.c	2003-01-13 18:16:16.000000000 +1100
@@ -158,9 +158,9 @@ struct runqueue {
 	struct list_head migration_queue;
 
 	atomic_t nr_iowait;
-} ____cacheline_aligned;
+} ____cacheline_aligned_in_smp;
 
-static struct runqueue runqueues[NR_CPUS] __cacheline_aligned;
+static struct runqueue runqueues[NR_CPUS] __cacheline_aligned_in_smp;
 
 #define cpu_rq(cpu)		(runqueues + (cpu))
 #define this_rq()		cpu_rq(smp_processor_id())
diff -urpN --exclude TAGS -X /home/rusty/devel/kernel/kernel-patches/current-dontdiff --minimal linux-2.5-bk/kernel/softirq.c working-2.5-bk-cacheline-nosmp/kernel/softirq.c
--- linux-2.5-bk/kernel/softirq.c	2003-01-02 12:32:49.000000000 +1100
+++ working-2.5-bk-cacheline-nosmp/kernel/softirq.c	2003-01-13 18:16:39.000000000 +1100
@@ -32,7 +32,7 @@
    - Tasklets: serialized wrt itself.
  */
 
-irq_cpustat_t irq_stat[NR_CPUS] ____cacheline_aligned;
+irq_cpustat_t irq_stat[NR_CPUS] ____cacheline_aligned_in_smp;
 
 static struct softirq_action softirq_vec[32] __cacheline_aligned_in_smp;
 
diff -urpN --exclude TAGS -X /home/rusty/devel/kernel/kernel-patches/current-dontdiff --minimal linux-2.5-bk/kernel/workqueue.c working-2.5-bk-cacheline-nosmp/kernel/workqueue.c
--- linux-2.5-bk/kernel/workqueue.c	2003-01-02 12:29:33.000000000 +1100
+++ working-2.5-bk-cacheline-nosmp/kernel/workqueue.c	2003-01-13 18:16:55.000000000 +1100
@@ -42,7 +42,7 @@ struct cpu_workqueue_struct {
 	task_t *thread;
 	struct completion exit;
 
-} ____cacheline_aligned;
+} ____cacheline_aligned_in_smp;
 
 /*
  * The externally visible workqueue abstraction is an array of
diff -urpN --exclude TAGS -X /home/rusty/devel/kernel/kernel-patches/current-dontdiff --minimal linux-2.5-bk/mm/rmap.c working-2.5-bk-cacheline-nosmp/mm/rmap.c
--- linux-2.5-bk/mm/rmap.c	2003-01-10 10:55:43.000000000 +1100
+++ working-2.5-bk-cacheline-nosmp/mm/rmap.c	2003-01-13 18:17:14.000000000 +1100
@@ -50,7 +50,7 @@
 struct pte_chain {
 	struct pte_chain *next;
 	pte_addr_t ptes[NRPTE];
-} ____cacheline_aligned;
+} ____cacheline_aligned_in_smp;
 
 kmem_cache_t	*pte_chain_cache;
 
diff -urpN --exclude TAGS -X /home/rusty/devel/kernel/kernel-patches/current-dontdiff --minimal linux-2.5-bk/net/core/dev.c working-2.5-bk-cacheline-nosmp/net/core/dev.c
--- linux-2.5-bk/net/core/dev.c	2003-01-13 16:56:30.000000000 +1100
+++ working-2.5-bk-cacheline-nosmp/net/core/dev.c	2003-01-13 18:18:32.000000000 +1100
@@ -194,7 +194,7 @@ static struct notifier_block *netdev_cha
  *	Device drivers call our routines to queue packets here. We empty the
  *	queue in the local softnet handler.
  */
-struct softnet_data softnet_data[NR_CPUS] __cacheline_aligned;
+struct softnet_data softnet_data[NR_CPUS] __cacheline_aligned_in_smp;
 
 #ifdef CONFIG_NET_FASTROUTE
 int netdev_fastroute;
diff -urpN --exclude TAGS -X /home/rusty/devel/kernel/kernel-patches/current-dontdiff --minimal linux-2.5-bk/net/ipv4/netfilter/ip_tables.c working-2.5-bk-cacheline-nosmp/net/ipv4/netfilter/ip_tables.c
--- linux-2.5-bk/net/ipv4/netfilter/ip_tables.c	2003-01-02 12:26:22.000000000 +1100
+++ working-2.5-bk-cacheline-nosmp/net/ipv4/netfilter/ip_tables.c	2003-01-13 18:18:48.000000000 +1100
@@ -97,7 +97,7 @@ struct ipt_table_info
 	unsigned int underflow[NF_IP_NUMHOOKS];
 
 	/* ipt_entry tables: one per CPU */
-	char entries[0] ____cacheline_aligned;
+	char entries[0] ____cacheline_aligned_in_smp;
 };
 
 static LIST_HEAD(ipt_target);
diff -urpN --exclude TAGS -X /home/rusty/devel/kernel/kernel-patches/current-dontdiff --minimal linux-2.5-bk/net/ipv4/tcp_ipv4.c working-2.5-bk-cacheline-nosmp/net/ipv4/tcp_ipv4.c
--- linux-2.5-bk/net/ipv4/tcp_ipv4.c	2003-01-11 14:44:41.000000000 +1100
+++ working-2.5-bk-cacheline-nosmp/net/ipv4/tcp_ipv4.c	2003-01-13 18:18:42.000000000 +1100
@@ -85,7 +85,7 @@ static struct socket *tcp_socket;
 void tcp_v4_send_check(struct sock *sk, struct tcphdr *th, int len,
 		       struct sk_buff *skb);
 
-struct tcp_hashinfo __cacheline_aligned tcp_hashinfo = {
+struct tcp_hashinfo __cacheline_aligned_in_smp tcp_hashinfo = {
 	.__tcp_lhash_lock =   RW_LOCK_UNLOCKED,
 	.__tcp_lhash_users =  ATOMIC_INIT(0),
 	.__tcp_lhash_wait
diff -urpN --exclude TAGS -X /home/rusty/devel/kernel/kernel-patches/current-dontdiff --minimal linux-2.5-bk/net/ipv4/xfrm_policy.c working-2.5-bk-cacheline-nosmp/net/ipv4/xfrm_policy.c
--- linux-2.5-bk/net/ipv4/xfrm_policy.c	2003-01-11 14:44:41.000000000 +1100
+++ working-2.5-bk-cacheline-nosmp/net/ipv4/xfrm_policy.c	2003-01-13 18:18:52.000000000 +1100
@@ -50,7 +50,7 @@ static inline u32 flow_hash(struct flowi
 static int flow_lwm = 2*FLOWCACHE_HASH_SIZE;
 static int flow_hwm = 4*FLOWCACHE_HASH_SIZE;
 
-static int flow_number[NR_CPUS] __cacheline_aligned;
+static int flow_number[NR_CPUS] __cacheline_aligned_in_smp;
 
 #define flow_count(cpu)		(flow_number[cpu])
 

--
  Anyone who quotes me in their sig is an idiot. -- Rusty Russell.
