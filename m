Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261868AbTJRVj3 (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 18 Oct 2003 17:39:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261873AbTJRVj3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 18 Oct 2003 17:39:29 -0400
Received: from rwcrmhc11.comcast.net ([204.127.198.35]:3264 "EHLO
	rwcrmhc11.comcast.net") by vger.kernel.org with ESMTP
	id S261868AbTJRVjH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 18 Oct 2003 17:39:07 -0400
To: torvalds@osdl.org, akpm@osdl.org
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: [PATCH] Linux 2.6.0-test8 __might_sleep warnings on boot
X-Message-Flag: Warning: May contain useful information
X-Priority: 1
X-MSMail-Priority: High
From: Roland Dreier <roland@digitalvampire.org>
Date: 18 Oct 2003 14:38:09 -0700
Message-ID: <87he26p6pq.fsf@love-shack.home.digitalvampire.org>
User-Agent: Gnus/5.0808 (Gnus v5.8.8) XEmacs/21.4 (Common Lisp)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I'm seeing the following on boot (and I've seen at least one other
similar report on lkml):

    Detected 930.391 MHz processor.
    Console: colour VGA+ 80x25
    Debug: sleeping function called from invalid context at include/asm/semaphore.h:119
    in_atomic():1, irqs_disabled():1
    Call Trace:
     [<c011a67d>] __might_sleep+0x9d/0xb0
     [<c011cdf2>] acquire_console_sem+0x2a/0x48
     [<c011d05d>] register_console+0x109/0x178
     [<c03b8a70>] con_init+0x1e0/0x1ec
     [<c0105000>] _stext+0x0/0x50
     [<c03b8184>] console_init+0x24/0x34
     [<c03aa575>] start_kernel+0xa5/0x17c
     [<c03aa3c4>] unknown_bootoption+0x0/0xdc

    Memory: 515040k/524032k available (1801k kernel code, 8244k reserved, 912k data, 132k init, 0k highmem)
    Debug: sleeping function called from invalid context at mm/slab.c:1857
    in_atomic():1, irqs_disabled():0
    Call Trace:
     [<c011a67d>] __might_sleep+0x9d/0xb0
     [<c01386b3>] kmem_cache_alloc+0x1f/0x54
     [<c0137a0c>] kmem_cache_create+0x6c/0x438
     [<c0105000>] _stext+0x0/0x50
     [<c03b6076>] kmem_cache_init+0xf6/0x23c
     [<c0105000>] _stext+0x0/0x50
     [<c03aa5c0>] start_kernel+0xf0/0x17c

    Calibrating delay loop... 1839.10 BogoMIPS

These were probably always there but are just getting exposed because
of the fix for printing __might_sleep warnings before the jiffies
wrap (which went in between -test7 and -test8).

I can see what's going on -- in init/main.c, we have:

        console_init();
        profile_init();
        local_irq_enable();

        /* ... deletia ... */

        kmem_cache_init();

        /* ... deletia ... */

        init_idle(current, smp_processor_id());

irqs_disabled() is true until the local_irq_enable() and in_atomic()
is true until init_idle().

I guess the fix is something like the patch below (tested and working
in my setup), which just disables __might_sleep warnings until after
init_idle().

(Another alternative might be to add functions like
"i_know_its_safe_to_call_functions_that_might_sleep()" and
"done_with_functions_that_might_sleep()" and add them everywhere
appropriate, but that seems a lot harder)

 - Roland

--- linux-2.6.0-test8/kernel/sched.c~early_might_sleep	Sat Oct 18 11:54:24 2003
+++ linux-2.6.0-test8/kernel/sched.c	Sat Oct 18 12:16:57 2003
@@ -38,6 +38,10 @@
 #include <linux/cpu.h>
 #include <linux/percpu.h>
 
+/* we need to know when init_idle() is done so that we don't print
+   spurious __might_sleep warnings on boot. */
+static int init_idle_done;
+
 #ifdef CONFIG_NUMA
 #define cpu_to_node_mask(cpu) node_to_cpumask(cpu_to_node(cpu))
 #else
@@ -2538,6 +2542,9 @@ void __init init_idle(task_t *idle, int 
 #else
 	idle->thread_info->preempt_count = 0;
 #endif
+
+	/* __might_sleep checks now make sense */
+	init_idle_done = 1;
 }
 
 #ifdef CONFIG_SMP
@@ -2848,7 +2855,7 @@ void __might_sleep(char *file, int line)
 #if defined(in_atomic)
 	static unsigned long prev_jiffy;	/* ratelimiting */
 
-	if (in_atomic() || irqs_disabled()) {
+	if (init_idle_done && (in_atomic() || irqs_disabled())) {
 		if (time_before(jiffies, prev_jiffy + HZ) && prev_jiffy)
 			return;
 		prev_jiffy = jiffies;

