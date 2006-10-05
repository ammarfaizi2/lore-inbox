Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751416AbWJES1O@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751416AbWJES1O (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 5 Oct 2006 14:27:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751493AbWJES1N
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 5 Oct 2006 14:27:13 -0400
Received: from cantor.suse.de ([195.135.220.2]:45696 "EHLO mx1.suse.de")
	by vger.kernel.org with ESMTP id S1751044AbWJES1K (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 5 Oct 2006 14:27:10 -0400
From: Andi Kleen <ak@suse.de>
To: Steve Fox <drfickle@us.ibm.com>
Subject: Re: 2.6.18-mm2 boot failure on x86-64
Date: Thu, 5 Oct 2006 20:27:02 +0200
User-Agent: KMail/1.9.3
Cc: Badari Pulavarty <pbadari@us.ibm.com>, Martin Bligh <mbligh@mbligh.org>,
       vgoyal@in.ibm.com, Andrew Morton <akpm@osdl.org>,
       lkml <linux-kernel@vger.kernel.org>, netdev@vger.kernel.org,
       kmannth@us.ibm.com, Andy Whitcroft <apw@shadowen.org>
References: <20060928014623.ccc9b885.akpm@osdl.org> <200610051740.58511.ak@suse.de> <1160071032.29690.19.camel@flooterbu>
In-Reply-To: <1160071032.29690.19.camel@flooterbu>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200610052027.02208.ak@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thursday 05 October 2006 19:57, Steve Fox wrote:
> On Thu, 2006-10-05 at 17:40 +0200, Andi Kleen wrote:
> 
> > Please don't snip the Code: line. It is fairly important.
> 
> Sorry about that. The remote console I was using appears to overwrite
> some text after I force the reboot. Here's a clean one.
> 
> global ffffffffffffffff

Ok that definitely shouldn't be in there.

I guess we need to track when it gets corrupted. Can you send the full
boot log with this patch applied?


-Andi

Index: linux-2.6.19-rc1-hack/init/main.c
===================================================================
--- linux-2.6.19-rc1-hack.orig/init/main.c
+++ linux-2.6.19-rc1-hack/init/main.c
@@ -75,6 +75,9 @@
 
 static int init(void *);
 
+extern void bugcheck(char *, int);
+#define CHECK bugcheck(__FILE__, __LINE__)
+
 extern void init_IRQ(void);
 extern void fork_init(unsigned long);
 extern void mca_init(void);
@@ -480,6 +483,8 @@ asmlinkage void __init start_kernel(void
 	char * command_line;
 	extern struct kernel_param __start___param[], __stop___param[];
 
+	CHECK;
+
 	smp_setup_processor_id();
 
 	/*
@@ -502,7 +507,9 @@ asmlinkage void __init start_kernel(void
 	page_address_init();
 	printk(KERN_NOTICE);
 	printk(linux_banner);
+	CHECK;
 	setup_arch(&command_line);
+	CHECK;
 	setup_per_cpu_areas();
 	smp_prepare_boot_cpu();	/* arch-specific boot-cpu hooks */
 
@@ -517,6 +524,7 @@ asmlinkage void __init start_kernel(void
 	 * fragile until we cpu_idle() for the first time.
 	 */
 	preempt_disable();
+	CHECK;
 	build_all_zonelists();
 	page_alloc_init();
 	printk(KERN_NOTICE "Kernel command line: %s\n", saved_command_line);
@@ -525,6 +533,7 @@ asmlinkage void __init start_kernel(void
 		   __stop___param - __start___param,
 		   &unknown_bootoption);
 	sort_main_extable();
+	CHECK;
 	trap_init();
 	rcu_init();
 	init_IRQ();
@@ -533,8 +542,10 @@ asmlinkage void __init start_kernel(void
 	hrtimers_init();
 	softirq_init();
 	timekeeping_init();
+	CHECK;
 	time_init();
 	profile_init();
+	CHECK;
 	if (!irqs_disabled())
 		printk("start_kernel(): bug: interrupts were enabled early\n");
 	early_boot_irqs_on();
@@ -568,7 +579,9 @@ asmlinkage void __init start_kernel(void
 #endif
 	vfs_caches_init_early();
 	cpuset_init_early();
+	CHECK;
 	mem_init();
+	CHECK;
 	kmem_cache_init();
 	setup_per_cpu_pageset();
 	numa_policy_init();
@@ -577,6 +590,7 @@ asmlinkage void __init start_kernel(void
 	calibrate_delay();
 	pidmap_init();
 	pgtable_cache_init();
+	CHECK;
 	prio_tree_init();
 	anon_vma_init();
 #ifdef CONFIG_X86
@@ -586,12 +600,14 @@ asmlinkage void __init start_kernel(void
 	fork_init(num_physpages);
 	proc_caches_init();
 	buffer_init();
+	CHECK;
 	unnamed_dev_init();
 	key_init();
 	security_init();
 	vfs_caches_init(num_physpages);
 	radix_tree_init();
 	signals_init();
+	CHECK;
 	/* rootfs populating might need page-writeback */
 	page_writeback_init();
 #ifdef CONFIG_PROC_FS
@@ -599,6 +615,7 @@ asmlinkage void __init start_kernel(void
 #endif
 	cpuset_init();
 	taskstats_init_early();
+	CHECK;
 	delayacct_init();
 
 	check_bugs();
@@ -609,7 +626,7 @@ asmlinkage void __init start_kernel(void
 	rest_init();
 }
 
-static int __initdata initcall_debug;
+static int __initdata initcall_debug = 1;
 
 static int __init initcall_debug_setup(char *str)
 {
@@ -639,7 +656,11 @@ static void __init do_initcalls(void)
 			printk("\n");
 		}
 
+		CHECK;
+
 		result = (*call)();
+		
+		CHECK;
 
 		if (result && result != -ENODEV && initcall_debug) {
 			sprintf(msgbuf, "error code %d", result);
@@ -725,21 +746,32 @@ static int init(void * unused)
 
 	smp_prepare_cpus(max_cpus);
 
+	CHECK;
+
 	do_pre_smp_initcalls();
 
 	smp_init();
+
+	CHECK;
+
 	sched_init_smp();
 
 	cpuset_init_smp();
 
+	CHECK;
+
 	/*
 	 * Do this before initcalls, because some drivers want to access
 	 * firmware files.
 	 */
 	populate_rootfs();
 
+	CHECK;
+
 	do_basic_setup();
 
+	CHECK;
+
 	/*
 	 * check if there is an early userspace init.  If yes, let it do all
 	 * the work
Index: linux-2.6.19-rc1-hack/net/xfrm/xfrm_policy.c
===================================================================
--- linux-2.6.19-rc1-hack.orig/net/xfrm/xfrm_policy.c
+++ linux-2.6.19-rc1-hack/net/xfrm/xfrm_policy.c
@@ -39,6 +39,16 @@ EXPORT_SYMBOL(xfrm_policy_count);
 static DEFINE_RWLOCK(xfrm_policy_afinfo_lock);
 static struct xfrm_policy_afinfo *xfrm_policy_afinfo[NPROTO];
 
+void bugcheck(char *where, int line)
+{
+	int i;
+	for (i = 0; i < NPROTO; i++)
+		if (xfrm_policy_afinfo[i] == (void *)-1UL) {
+			printk("afinfo corrupted at %s:%d\n",where,line);
+			return;
+		}
+}
+
 static kmem_cache_t *xfrm_dst_cache __read_mostly;
 
 static struct work_struct xfrm_policy_gc_work;
