Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1757409AbWKWQel@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757409AbWKWQel (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 23 Nov 2006 11:34:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757410AbWKWQel
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 23 Nov 2006 11:34:41 -0500
Received: from mx2.mail.elte.hu ([157.181.151.9]:51658 "EHLO mx2.mail.elte.hu")
	by vger.kernel.org with ESMTP id S1757409AbWKWQek (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 23 Nov 2006 11:34:40 -0500
Date: Thu, 23 Nov 2006 17:33:09 +0100
From: Ingo Molnar <mingo@elte.hu>
To: Jiri Kosina <jkosina@suse.cz>
Cc: Andi Kleen <ak@suse.de>, linux-kernel@vger.kernel.org,
       Reuben Farrelly <reuben-linuxkernel@reub.net>,
       Andrew Morton <akpm@osdl.org>
Subject: Re: [PATCH] x86_64: fix build without HOTPLUG_CPU (was Re: 2.6.19-rc6-mm1)
Message-ID: <20061123163309.GA31708@elte.hu>
References: <20061123021703.8550e37e.akpm@osdl.org> <45657A41.2040400@reub.net> <Pine.LNX.4.64.0611231503520.8069@twin.jikos.cz> <p731wnu42vt.fsf@bingen.suse.de> <Pine.LNX.4.64.0611231611510.8069@twin.jikos.cz> <20061123152734.GG29738@bingen.suse.de> <Pine.LNX.4.64.0611231634090.8069@twin.jikos.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.64.0611231634090.8069@twin.jikos.cz>
User-Agent: Mutt/1.4.2.2i
X-ELTE-SpamScore: -4.5
X-ELTE-SpamLevel: 
X-ELTE-SpamCheck: no
X-ELTE-SpamVersion: ELTE 2.0 
X-ELTE-SpamCheck-Details: score=-4.5 required=5.9 tests=ALL_TRUSTED,AWL,BAYES_00 autolearn=no SpamAssassin version=3.0.3
	-3.3 ALL_TRUSTED            Did not pass through any untrusted hosts
	-2.6 BAYES_00               BODY: Bayesian spam probability is 0 to 1%
	[score: 0.0000]
	1.4 AWL                    AWL: From: address is in the auto white-list
X-ELTE-VirusStatus: clean
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


* Jiri Kosina <jkosina@suse.cz> wrote:

> On Thu, 23 Nov 2006, Andi Kleen wrote:
> 
> > > Well, is it really? 6b3d1a95ba714bfb1cc81362f7f3e01b7654b4f3 adds the 
> > > ifdef around the cpu_vsyscall_notifier() declaration, but later it's 
> > > passed as parameter to hotcpu_notifier() unconditionally. This is fixed by 
> > > the patch I sent.
> > hotcpu_notifier is a macro that expands to nothing for !CONFIG_HOTPLUG_CPU
> 
> Now I see where does the confusion come from. 2.6.19-rc6-mm1 has 
> hotplug-cpu-clean-up-hotcpu_notifier-use.patch from Ingo (CC added), which 
> does this, among other things:
> 
> -#define hotcpu_notifier(fn, pri)       do { } while (0)
> -#define register_hotcpu_notifier(nb)   do { } while (0)
> -#define unregister_hotcpu_notifier(nb) do { } while (0)
> +#define hotcpu_notifier(fn, pri)       do { (void)(fn); } while (0)
> +#define register_hotcpu_notifier(nb)   do { (void)(nb); } while (0)
> +#define unregister_hotcpu_notifier(nb) do { (void)(nb); } while (0)

here's the one i have in my tree, it's:

 26 files changed, 8 insertions(+), 58 deletions(-)

while in Andrew's tree it's:

 23 files changed, 8 insertions(+), 52 deletions(-)

so i guess Andrew should update to the one below?

	Ingo

---------------->
Subject: [patch] hotplug CPU: clean up hotcpu_notifier() use
From: Ingo Molnar <mingo@elte.hu>

There was lots of #ifdef noise in the kernel due to
hotcpu_notifier(fn, prio) not correctly marking 'fn'
as used in the !HOTPLUG_CPU case, and thus generating
compiler warnings of unused symbols, hence forcing
people to add #ifdefs.

the compiler can skip truly unused functions just fine:

   text    data     bss     dec     hex filename
1624412  728710 3674856 6027978  5bfaca vmlinux.before
1624412  728710 3674856 6027978  5bfaca vmlinux.after

Signed-off-by: Ingo Molnar <mingo@elte.hu>
---
 arch/i386/kernel/cpu/mcheck/therm_throt.c |    2 --
 arch/i386/kernel/cpuid.c                  |    2 --
 arch/i386/kernel/microcode.c              |    2 --
 arch/i386/kernel/msr.c                    |    2 --
 arch/ia64/kernel/palinfo.c                |    2 --
 arch/ia64/kernel/salinfo.c                |    2 --
 arch/s390/appldata/appldata_base.c        |    2 --
 arch/x86_64/kernel/mce.c                  |    2 --
 arch/x86_64/kernel/mce_amd.c              |    2 --
 arch/x86_64/kernel/vsyscall.c             |    2 --
 block/ll_rw_blk.c                         |    4 ----
 drivers/cpufreq/cpufreq.c                 |    2 --
 fs/buffer.c                               |    2 --
 fs/xfs/xfs_mount.c                        |    4 +---
 include/linux/cpu.h                       |    6 +++---
 kernel/cpuset.c                           |    4 ----
 kernel/fork.c                             |    2 +-
 kernel/profile.c                          |    3 +--
 kernel/sched.c                            |    3 ---
 kernel/workqueue.c                        |    2 --
 lib/radix-tree.c                          |    2 --
 mm/page_alloc.c                           |    4 ----
 mm/swap.c                                 |    2 ++
 mm/vmscan.c                               |    2 --
 net/core/dev.c                            |    2 --
 net/core/flow.c                           |    2 --
 26 files changed, 8 insertions(+), 58 deletions(-)

Index: linux/arch/i386/kernel/cpu/mcheck/therm_throt.c
===================================================================
--- linux.orig/arch/i386/kernel/cpu/mcheck/therm_throt.c
+++ linux/arch/i386/kernel/cpu/mcheck/therm_throt.c
@@ -115,7 +115,6 @@ static __cpuinit int thermal_throttle_ad
 	return sysfs_create_group(&sys_dev->kobj, &thermal_throttle_attr_group);
 }
 
-#ifdef CONFIG_HOTPLUG_CPU
 static __cpuinit void thermal_throttle_remove_dev(struct sys_device *sys_dev)
 {
 	return sysfs_remove_group(&sys_dev->kobj, &thermal_throttle_attr_group);
@@ -152,7 +151,6 @@ static struct notifier_block thermal_thr
 {
 	.notifier_call = thermal_throttle_cpu_callback,
 };
-#endif /* CONFIG_HOTPLUG_CPU */
 
 static __init int thermal_throttle_init_device(void)
 {
Index: linux/arch/i386/kernel/cpuid.c
===================================================================
--- linux.orig/arch/i386/kernel/cpuid.c
+++ linux/arch/i386/kernel/cpuid.c
@@ -167,7 +167,6 @@ static int cpuid_class_device_create(int
 	return err;
 }
 
-#ifdef CONFIG_HOTPLUG_CPU
 static int cpuid_class_cpu_callback(struct notifier_block *nfb, unsigned long action, void *hcpu)
 {
 	unsigned int cpu = (unsigned long)hcpu;
@@ -187,7 +186,6 @@ static struct notifier_block __cpuinitda
 {
 	.notifier_call = cpuid_class_cpu_callback,
 };
-#endif /* !CONFIG_HOTPLUG_CPU */
 
 static int __init cpuid_init(void)
 {
Index: linux/arch/i386/kernel/microcode.c
===================================================================
--- linux.orig/arch/i386/kernel/microcode.c
+++ linux/arch/i386/kernel/microcode.c
@@ -703,7 +703,6 @@ static struct sysdev_driver mc_sysdev_dr
 	.resume = mc_sysdev_resume,
 };
 
-#ifdef CONFIG_HOTPLUG_CPU
 static __cpuinit int
 mc_cpu_callback(struct notifier_block *nb, unsigned long action, void *hcpu)
 {
@@ -726,7 +725,6 @@ mc_cpu_callback(struct notifier_block *n
 static struct notifier_block mc_cpu_notifier = {
 	.notifier_call = mc_cpu_callback,
 };
-#endif
 
 static int __init microcode_init (void)
 {
Index: linux/arch/i386/kernel/msr.c
===================================================================
--- linux.orig/arch/i386/kernel/msr.c
+++ linux/arch/i386/kernel/msr.c
@@ -250,7 +250,6 @@ static int msr_class_device_create(int i
 	return err;
 }
 
-#ifdef CONFIG_HOTPLUG_CPU
 static int msr_class_cpu_callback(struct notifier_block *nfb,
 				unsigned long action, void *hcpu)
 {
@@ -271,7 +270,6 @@ static struct notifier_block __cpuinitda
 {
 	.notifier_call = msr_class_cpu_callback,
 };
-#endif
 
 static int __init msr_init(void)
 {
Index: linux/arch/ia64/kernel/palinfo.c
===================================================================
--- linux.orig/arch/ia64/kernel/palinfo.c
+++ linux/arch/ia64/kernel/palinfo.c
@@ -952,7 +952,6 @@ remove_palinfo_proc_entries(unsigned int
 	}
 }
 
-#ifdef CONFIG_HOTPLUG_CPU
 static int palinfo_cpu_callback(struct notifier_block *nfb,
 					unsigned long action, void *hcpu)
 {
@@ -974,7 +973,6 @@ static struct notifier_block palinfo_cpu
 	.notifier_call = palinfo_cpu_callback,
 	.priority = 0,
 };
-#endif
 
 static int __init
 palinfo_init(void)
Index: linux/arch/ia64/kernel/salinfo.c
===================================================================
--- linux.orig/arch/ia64/kernel/salinfo.c
+++ linux/arch/ia64/kernel/salinfo.c
@@ -575,7 +575,6 @@ static struct file_operations salinfo_da
 	.write   = salinfo_log_write,
 };
 
-#ifdef	CONFIG_HOTPLUG_CPU
 static int __devinit
 salinfo_cpu_callback(struct notifier_block *nb, unsigned long action, void *hcpu)
 {
@@ -620,7 +619,6 @@ static struct notifier_block salinfo_cpu
 	.notifier_call = salinfo_cpu_callback,
 	.priority = 0,
 };
-#endif	/* CONFIG_HOTPLUG_CPU */
 
 static int __init
 salinfo_init(void)
Index: linux/arch/s390/appldata/appldata_base.c
===================================================================
--- linux.orig/arch/s390/appldata/appldata_base.c
+++ linux/arch/s390/appldata/appldata_base.c
@@ -561,7 +561,6 @@ appldata_offline_cpu(int cpu)
 	spin_unlock(&appldata_timer_lock);
 }
 
-#ifdef CONFIG_HOTPLUG_CPU
 static int __cpuinit
 appldata_cpu_notify(struct notifier_block *self,
 		    unsigned long action, void *hcpu)
@@ -582,7 +581,6 @@ appldata_cpu_notify(struct notifier_bloc
 static struct notifier_block appldata_nb = {
 	.notifier_call = appldata_cpu_notify,
 };
-#endif
 
 /*
  * appldata_init()
Index: linux/arch/x86_64/kernel/mce.c
===================================================================
--- linux.orig/arch/x86_64/kernel/mce.c
+++ linux/arch/x86_64/kernel/mce.c
@@ -641,7 +641,6 @@ static __cpuinit int mce_create_device(u
 	return err;
 }
 
-#ifdef CONFIG_HOTPLUG_CPU
 static void mce_remove_device(unsigned int cpu)
 {
 	int i;
@@ -674,7 +673,6 @@ mce_cpu_callback(struct notifier_block *
 static struct notifier_block mce_cpu_notifier = {
 	.notifier_call = mce_cpu_callback,
 };
-#endif
 
 static __init int mce_init_device(void)
 {
Index: linux/arch/x86_64/kernel/mce_amd.c
===================================================================
--- linux.orig/arch/x86_64/kernel/mce_amd.c
+++ linux/arch/x86_64/kernel/mce_amd.c
@@ -551,7 +551,6 @@ out:
 	return err;
 }
 
-#ifdef CONFIG_HOTPLUG_CPU
 /*
  * let's be hotplug friendly.
  * in case of multiple core processors, the first core always takes ownership
@@ -658,7 +657,6 @@ static int threshold_cpu_callback(struct
 static struct notifier_block threshold_cpu_notifier = {
 	.notifier_call = threshold_cpu_callback,
 };
-#endif /* CONFIG_HOTPLUG_CPU */
 
 static __init int threshold_init_device(void)
 {
Index: linux/arch/x86_64/kernel/vsyscall.c
===================================================================
--- linux.orig/arch/x86_64/kernel/vsyscall.c
+++ linux/arch/x86_64/kernel/vsyscall.c
@@ -274,7 +274,6 @@ static void __cpuinit cpu_vsyscall_init(
 	vsyscall_set_cpu(raw_smp_processor_id());
 }
 
-#ifdef CONFIG_HOTPLUG_CPU
 static int __cpuinit
 cpu_vsyscall_notifier(struct notifier_block *n, unsigned long action, void *arg)
 {
@@ -283,7 +282,6 @@ cpu_vsyscall_notifier(struct notifier_bl
 		smp_call_function_single(cpu, cpu_vsyscall_init, NULL, 0, 1);
 	return NOTIFY_DONE;
 }
-#endif
 
 static void __init map_vsyscall(void)
 {
Index: linux/block/ll_rw_blk.c
===================================================================
--- linux.orig/block/ll_rw_blk.c
+++ linux/block/ll_rw_blk.c
@@ -3374,8 +3374,6 @@ static void blk_done_softirq(struct soft
 	}
 }
 
-#ifdef CONFIG_HOTPLUG_CPU
-
 static int blk_cpu_notify(struct notifier_block *self, unsigned long action,
 			  void *hcpu)
 {
@@ -3401,8 +3399,6 @@ static struct notifier_block __devinitda
 	.notifier_call	= blk_cpu_notify,
 };
 
-#endif /* CONFIG_HOTPLUG_CPU */
-
 /**
  * blk_complete_request - end I/O on a request
  * @req:      the request being processed
Index: linux/drivers/cpufreq/cpufreq.c
===================================================================
--- linux.orig/drivers/cpufreq/cpufreq.c
+++ linux/drivers/cpufreq/cpufreq.c
@@ -1535,7 +1535,6 @@ int cpufreq_update_policy(unsigned int c
 }
 EXPORT_SYMBOL(cpufreq_update_policy);
 
-#ifdef CONFIG_HOTPLUG_CPU
 static int cpufreq_cpu_callback(struct notifier_block *nfb,
 					unsigned long action, void *hcpu)
 {
@@ -1575,7 +1574,6 @@ static struct notifier_block __cpuinitda
 {
     .notifier_call = cpufreq_cpu_callback,
 };
-#endif /* CONFIG_HOTPLUG_CPU */
 
 /*********************************************************************
  *               REGISTER / UNREGISTER CPUFREQ DRIVER                *
Index: linux/fs/buffer.c
===================================================================
--- linux.orig/fs/buffer.c
+++ linux/fs/buffer.c
@@ -2972,7 +2972,6 @@ init_buffer_head(void *data, kmem_cache_
 	}
 }
 
-#ifdef CONFIG_HOTPLUG_CPU
 static void buffer_exit_cpu(int cpu)
 {
 	int i;
@@ -2994,7 +2993,6 @@ static int buffer_cpu_notify(struct noti
 		buffer_exit_cpu((unsigned long)hcpu);
 	return NOTIFY_OK;
 }
-#endif /* CONFIG_HOTPLUG_CPU */
 
 void __init buffer_init(void)
 {
Index: linux/fs/xfs/xfs_mount.c
===================================================================
--- linux.orig/fs/xfs/xfs_mount.c
+++ linux/fs/xfs/xfs_mount.c
@@ -1704,7 +1704,6 @@ xfs_mount_log_sbunit(
  * is present to prevent thrashing).
  */
 
-#ifdef CONFIG_HOTPLUG_CPU
 /*
  * hot-plug CPU notifier support.
  *
@@ -1761,7 +1760,6 @@ xfs_icsb_cpu_notify(
 
 	return NOTIFY_OK;
 }
-#endif /* CONFIG_HOTPLUG_CPU */
 
 int
 xfs_icsb_init_counters(
@@ -1777,8 +1775,8 @@ xfs_icsb_init_counters(
 #ifdef CONFIG_HOTPLUG_CPU
 	mp->m_icsb_notifier.notifier_call = xfs_icsb_cpu_notify;
 	mp->m_icsb_notifier.priority = 0;
-	register_hotcpu_notifier(&mp->m_icsb_notifier);
 #endif /* CONFIG_HOTPLUG_CPU */
+	register_hotcpu_notifier(&mp->m_icsb_notifier);
 
 	for_each_online_cpu(i) {
 		cntp = (xfs_icsb_cnts_t *)per_cpu_ptr(mp->m_sb_cnts, i);
Index: linux/include/linux/cpu.h
===================================================================
--- linux.orig/include/linux/cpu.h
+++ linux/include/linux/cpu.h
@@ -81,9 +81,9 @@ int cpu_down(unsigned int cpu);
 #define lock_cpu_hotplug()	do { } while (0)
 #define unlock_cpu_hotplug()	do { } while (0)
 #define lock_cpu_hotplug_interruptible() 0
-#define hotcpu_notifier(fn, pri)	do { } while (0)
-#define register_hotcpu_notifier(nb)	do { } while (0)
-#define unregister_hotcpu_notifier(nb)	do { } while (0)
+#define hotcpu_notifier(fn, pri)	do { (void)(fn); } while (0)
+#define register_hotcpu_notifier(nb)	do { (void)(nb); } while (0)
+#define unregister_hotcpu_notifier(nb)	do { (void)(nb); } while (0)
 
 /* CPUs don't go offline once they're online w/o CONFIG_HOTPLUG_CPU */
 static inline int cpu_is_offline(int cpu) { return 0; }
Index: linux/kernel/cpuset.c
===================================================================
--- linux.orig/kernel/cpuset.c
+++ linux/kernel/cpuset.c
@@ -2045,7 +2045,6 @@ out:
 	return err;
 }
 
-#if defined(CONFIG_HOTPLUG_CPU) || defined(CONFIG_MEMORY_HOTPLUG)
 /*
  * If common_cpu_mem_hotplug_unplug(), below, unplugs any CPUs
  * or memory nodes, we need to walk over the cpuset hierarchy,
@@ -2109,9 +2108,7 @@ static void common_cpu_mem_hotplug_unplu
 	mutex_unlock(&callback_mutex);
 	mutex_unlock(&manage_mutex);
 }
-#endif
 
-#ifdef CONFIG_HOTPLUG_CPU
 /*
  * The top_cpuset tracks what CPUs and Memory Nodes are online,
  * period.  This is necessary in order to make cpusets transparent
@@ -2128,7 +2125,6 @@ static int cpuset_handle_cpuhp(struct no
 	common_cpu_mem_hotplug_unplug();
 	return 0;
 }
-#endif
 
 #ifdef CONFIG_MEMORY_HOTPLUG
 /*
Index: linux/kernel/fork.c
===================================================================
--- linux.orig/kernel/fork.c
+++ linux/kernel/fork.c
@@ -66,7 +66,7 @@ int max_threads;		/* tunable limit on nr
 
 DEFINE_PER_CPU(unsigned long, process_counts) = 0;
 
-__cacheline_aligned DEFINE_RWLOCK(tasklist_lock);  /* outer */
+DEFINE_RWLOCK(tasklist_lock);  /* outer */
 
 int nr_processes(void)
 {
Index: linux/kernel/profile.c
===================================================================
--- linux.orig/kernel/profile.c
+++ linux/kernel/profile.c
@@ -298,7 +298,6 @@ out:
 	put_cpu();
 }
 
-#ifdef CONFIG_HOTPLUG_CPU
 static int __devinit profile_cpu_callback(struct notifier_block *info,
 					unsigned long action, void *__cpu)
 {
@@ -351,10 +350,10 @@ static int __devinit profile_cpu_callbac
 	}
 	return NOTIFY_OK;
 }
-#endif /* CONFIG_HOTPLUG_CPU */
 #else /* !CONFIG_SMP */
 #define profile_flip_buffers()		do { } while (0)
 #define profile_discard_flip_buffers()	do { } while (0)
+#define profile_cpu_callback		NULL
 
 void profile_hit(int type, void *__pc)
 {
Index: linux/kernel/sched.c
===================================================================
--- linux.orig/kernel/sched.c
+++ linux/kernel/sched.c
@@ -6742,8 +6742,6 @@ SYSDEV_ATTR(sched_smt_power_savings, 064
 	    sched_smt_power_savings_store);
 #endif
 
-
-#ifdef CONFIG_HOTPLUG_CPU
 /*
  * Force a reinitialization of the sched domains hierarchy.  The domains
  * and groups cannot be updated in place without racing with the balancing
@@ -6776,7 +6774,6 @@ static int update_sched_domains(struct n
 
 	return NOTIFY_OK;
 }
-#endif
 
 void __init sched_init_smp(void)
 {
Index: linux/kernel/workqueue.c
===================================================================
--- linux.orig/kernel/workqueue.c
+++ linux/kernel/workqueue.c
@@ -609,7 +609,6 @@ int current_is_keventd(void)
 
 }
 
-#ifdef CONFIG_HOTPLUG_CPU
 /* Take the work from this (downed) CPU. */
 static void take_over_work(struct workqueue_struct *wq, unsigned int cpu)
 {
@@ -692,7 +691,6 @@ static int __devinit workqueue_cpu_callb
 
 	return NOTIFY_OK;
 }
-#endif
 
 void init_workqueues(void)
 {
Index: linux/lib/radix-tree.c
===================================================================
--- linux.orig/lib/radix-tree.c
+++ linux/lib/radix-tree.c
@@ -869,7 +869,6 @@ static __init void radix_tree_init_maxin
 		height_to_maxindex[i] = __maxindex(i);
 }
 
-#ifdef CONFIG_HOTPLUG_CPU
 static int radix_tree_callback(struct notifier_block *nfb,
                             unsigned long action,
                             void *hcpu)
@@ -889,7 +888,6 @@ static int radix_tree_callback(struct no
        }
        return NOTIFY_OK;
 }
-#endif /* CONFIG_HOTPLUG_CPU */
 
 void __init radix_tree_init(void)
 {
Index: linux/mm/page_alloc.c
===================================================================
--- linux.orig/mm/page_alloc.c
+++ linux/mm/page_alloc.c
@@ -700,7 +700,6 @@ void drain_node_pages(int nodeid)
 }
 #endif
 
-#if defined(CONFIG_PM) || defined(CONFIG_HOTPLUG_CPU)
 static void __drain_pages(unsigned int cpu)
 {
 	unsigned long flags;
@@ -722,7 +721,6 @@ static void __drain_pages(unsigned int c
 		}
 	}
 }
-#endif /* CONFIG_PM || CONFIG_HOTPLUG_CPU */
 
 #ifdef CONFIG_PM
 
@@ -2736,7 +2734,6 @@ void __init free_area_init(unsigned long
 			__pa(PAGE_OFFSET) >> PAGE_SHIFT, NULL);
 }
 
-#ifdef CONFIG_HOTPLUG_CPU
 static int page_alloc_cpu_notify(struct notifier_block *self,
 				 unsigned long action, void *hcpu)
 {
@@ -2751,7 +2748,6 @@ static int page_alloc_cpu_notify(struct 
 	}
 	return NOTIFY_OK;
 }
-#endif /* CONFIG_HOTPLUG_CPU */
 
 void __init page_alloc_init(void)
 {
Index: linux/mm/swap.c
===================================================================
--- linux.orig/mm/swap.c
+++ linux/mm/swap.c
@@ -514,5 +514,7 @@ void __init swap_setup(void)
 	 * Right now other parts of the system means that we
 	 * _really_ don't want to cluster much more
 	 */
+#ifdef CONFIG_HOTPLUG_CPU
 	hotcpu_notifier(cpu_swap_callback, 0);
+#endif
 }
Index: linux/mm/vmscan.c
===================================================================
--- linux.orig/mm/vmscan.c
+++ linux/mm/vmscan.c
@@ -1508,7 +1508,6 @@ out:
 }
 #endif
 
-#ifdef CONFIG_HOTPLUG_CPU
 /* It's optimal to keep kswapds on the same CPUs as their memory, but
    not required for correctness.  So if the last cpu in a node goes
    away, we get changed to run anywhere: as the first one comes back,
@@ -1529,7 +1528,6 @@ static int __devinit cpu_callback(struct
 	}
 	return NOTIFY_OK;
 }
-#endif /* CONFIG_HOTPLUG_CPU */
 
 /*
  * This kswapd start function will be called by init and node-hot-add.
Index: linux/net/core/dev.c
===================================================================
--- linux.orig/net/core/dev.c
+++ linux/net/core/dev.c
@@ -3361,7 +3361,6 @@ void unregister_netdev(struct net_device
 
 EXPORT_SYMBOL(unregister_netdev);
 
-#ifdef CONFIG_HOTPLUG_CPU
 static int dev_cpu_callback(struct notifier_block *nfb,
 			    unsigned long action,
 			    void *ocpu)
@@ -3405,7 +3404,6 @@ static int dev_cpu_callback(struct notif
 
 	return NOTIFY_OK;
 }
-#endif /* CONFIG_HOTPLUG_CPU */
 
 #ifdef CONFIG_NET_DMA
 /**
Index: linux/net/core/flow.c
===================================================================
--- linux.orig/net/core/flow.c
+++ linux/net/core/flow.c
@@ -340,7 +340,6 @@ static void __devinit flow_cache_cpu_pre
 	tasklet_init(tasklet, flow_cache_flush_tasklet, 0);
 }
 
-#ifdef CONFIG_HOTPLUG_CPU
 static int flow_cache_cpu(struct notifier_block *nfb,
 			  unsigned long action,
 			  void *hcpu)
@@ -349,7 +348,6 @@ static int flow_cache_cpu(struct notifie
 		__flow_cache_shrink((unsigned long)hcpu, 0);
 	return NOTIFY_OK;
 }
-#endif /* CONFIG_HOTPLUG_CPU */
 
 static int __init flow_cache_init(void)
 {
