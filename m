Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030471AbVIBEHb@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030471AbVIBEHb (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 2 Sep 2005 00:07:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030596AbVIBEHb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 2 Sep 2005 00:07:31 -0400
Received: from smtp.osdl.org ([65.172.181.4]:39139 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1030471AbVIBEHb (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 2 Sep 2005 00:07:31 -0400
Date: Thu, 1 Sep 2005 21:05:51 -0700
From: Andrew Morton <akpm@osdl.org>
To: Moses Leslie <marmoset@malformed.org>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.6.13 lockup at boot after/at cpu initialization
Message-Id: <20050901210551.5d5aa53b.akpm@osdl.org>
In-Reply-To: <20050901164145.Q7547@fincher.users.accretive-networks.net>
References: <20050901164145.Q7547@fincher.users.accretive-networks.net>
X-Mailer: Sylpheed version 1.0.4 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Moses Leslie <marmoset@malformed.org> wrote:
>
> On some older hardware I'm trying to use, 2.6.13 (and 2.6.12.3, the only
>  other 2.6 kernel tested on this hardware)  lock up right after boot, there
>  are no indications about what specifically is wrong.  The last few lines
>  before the lockup are:
> 
>  382MB LOWMEM available
>  DMI 2.3 present
>  Allocating PCI resources starting at <some numbers>
>  Built 1 zonelists
>  Kernel command line: root=/dev/hda1 ro
>  Initialing CPU#0
> 
>  I can get the numbers if needed.
> 
>  2.4.31 works without problems.

Well that sucks.

You may get some more output if you add `earlyprintk=vga' to the kernel
boot command line.

To narrow down where it's hanging we'll need to start sprinkling printk()s.
Something like this: 


diff -puN init/main.c~a init/main.c
--- devel/init/main.c~a	2005-09-01 21:03:50.000000000 -0700
+++ devel-akpm/init/main.c	2005-09-01 21:05:28.000000000 -0700
@@ -53,6 +53,8 @@
 #include <asm/setup.h>
 #include <asm/sections.h>
 
+#define D() do { printk("%s:%d\n", __FILE__, __LINE__); } while (0)
+
 /*
  * This is one of the first .c files built. Error out early
  * if we have compiler trouble..
@@ -467,13 +469,21 @@ asmlinkage void __init start_kernel(void
 		   __stop___param - __start___param,
 		   &unknown_bootoption);
 	sort_main_extable();
+	D();
 	trap_init();
+	D();
 	rcu_init();
+	D();
 	init_IRQ();
+	D();
 	pidhash_init();
+	D();
 	init_timers();
+	D();
 	softirq_init();
+	D();
 	time_init();
+	D();
 
 	/*
 	 * HACK ALERT! This is early. We're enabling the console before
@@ -481,10 +491,14 @@ asmlinkage void __init start_kernel(void
 	 * this. But we do want output early, in case something goes wrong.
 	 */
 	console_init();
+	D();
 	if (panic_later)
 		panic(panic_later, panic_param);
+	D();
 	profile_init();
+	D();
 	local_irq_enable();
+	D();
 #ifdef CONFIG_BLK_DEV_INITRD
 	if (initrd_start && !initrd_below_start_ok &&
 			initrd_start < min_low_pfn << PAGE_SHIFT) {
@@ -493,41 +507,68 @@ asmlinkage void __init start_kernel(void
 		initrd_start = 0;
 	}
 #endif
+	D();
 	vfs_caches_init_early();
+	D();
 	mem_init();
+	D();
 	kmem_cache_init();
+	D();
 	setup_per_cpu_pageset();
+	D();
 	numa_policy_init();
+	D();
 	if (late_time_init)
 		late_time_init();
+	D();
 	calibrate_delay();
+	D();
 	pidmap_init();
+	D();
 	pgtable_cache_init();
+	D();
 	prio_tree_init();
+	D();
 	anon_vma_init();
+	D();
 #ifdef CONFIG_X86
 	if (efi_enabled)
 		efi_enter_virtual_mode();
 #endif
+	D();
 	fork_init(num_physpages);
+	D();
 	proc_caches_init();
+	D();
 	buffer_init();
+	D();
 	unnamed_dev_init();
+	D();
 	key_init();
+	D();
 	security_init();
+	D();
 	vfs_caches_init(num_physpages);
+	D();
 	radix_tree_init();
+	D();
 	signals_init();
+	D();
 	/* rootfs populating might need page-writeback */
 	page_writeback_init();
+	D();
 #ifdef CONFIG_PROC_FS
 	proc_root_init();
 #endif
+	D();
 	cpuset_init();
+	D();
 
 	check_bugs();
+	D();
 
 	acpi_early_init(); /* before LAPIC and SMP init */
+	D();
 
 	/* Do the rest non-__init'ed, we're now alive */
 	rest_init();
_

