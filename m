Return-Path: <linux-kernel-owner+akpm=40zip.com.au-S1751047AbWFFDHh@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751047AbWFFDHh (ORCPT <rfc822;akpm@zip.com.au>);
	Mon, 5 Jun 2006 23:07:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751042AbWFFDHh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 5 Jun 2006 23:07:37 -0400
Received: from smtp.osdl.org ([65.172.181.4]:6028 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1751095AbWFFDHg (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 5 Jun 2006 23:07:36 -0400
Date: Mon, 5 Jun 2006 20:07:27 -0700
From: Andrew Morton <akpm@osdl.org>
To: Martin Bligh <mbligh@google.com>
Cc: apw@shadowen.org, linux-kernel@vger.kernel.org
Subject: Re: sparsemem panic in 2.6.17-rc5-mm1 and -mm2
Message-Id: <20060605200727.374cbf05.akpm@osdl.org>
In-Reply-To: <4484D174.7080902@google.com>
References: <4484D174.7080902@google.com>
X-Mailer: Sylpheed version 2.2.4 (GTK+ 2.8.17; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 05 Jun 2006 17:51:00 -0700
Martin Bligh <mbligh@google.com> wrote:

> http://test.kernel.org/abat/34264/debug/console.log
> 
> Only seems to happen on the sparsemem runs. Possibly a side-effect
> of the page migration stuff, manifesting itself differently?
> Or maybe not?
> 
> Out of Memory: Kill process 1 (idle) score 0 and children.
> divide error: 0000 [#1]
> SMP
> last sysfs file:
> CPU:    0
> EIP:    0060:[<c013be6a>]    Not tainted VLI
> EFLAGS: 00010246   (2.6.17-rc5-mm2-autokern1 #1)
> EIP is at shrink_active_list+0x5b/0x382
> eax: 00000000   ebx: 00000064   ecx: 00000000   edx: 00000000
> esi: c0474500   edi: c03a8e64   ebp: c03a8dbc   esp: c03a8d9c
> ds: 007b   es: 007b   ss: 0068
> Process idle (pid: 1, threadinfo=c03a8000 task=c0769000)
> Stack: 00000000 00000000 00000020 00000004 c03a8dac c03a8dac c03a8db4 
> c03a8db4
>         c03a8dbc c03a8dbc c03a8dfc c0137a14 00000000 c0137a37 c03a8df8 
> c03a8df4
>         c0474000 00000000 00000000 c03a8e64 c0137c5a 00000000 00028028 
> 000dc0e0
> Call Trace:
>   <c0137a14> get_writeback_state+0x30/0x35  <c0137a37> 
> get_dirty_limits+0x1e/0xc4
>   <c0137c5a> throttle_vm_writeout+0x18/0x53  <c013c221> 
> shrink_zone+0x90/0xc1
>   <c013c29f> shrink_zones+0x4d/0x5e  <c013c39d> try_to_free_pages+0xed/0x1a8
>   <c0136a91> __alloc_pages+0x16e/0x26a  <c014e6c9> kmem_getpages+0x5b/0xac
>   <c014f42c> cache_grow+0xb5/0x147  <c014f655> 
> cache_alloc_refill+0x197/0x1d3
>   <c014fad0> kmem_cache_alloc+0x4f/0x5e  <c0276dd8> sk_alloc+0x15/0x63
>   <c02bb9e0> inet_create+0xfb/0x21a  <c027546d> __sock_create+0xc0/0xea
>   <c02754b0> sock_create_kern+0xb/0xe  <c03c413b> icmp_init+0x3a/0xc3
>   <c03c445c> inet_init+0x12b/0x174  <c03aa7f6> do_initcalls+0x53/0xe4
>   <c01320d8> register_irq_proc+0x6a/0x90  <c0180000> 
> xlate_proc_name+0x87/0x90
>   <c0100349> init+0x41/0xdc  <c0100308> init+0x0/0xdc
>   <c01009d5> kernel_thread_helper+0x5/0xb
> Code: 04 24 00 00 00 00 8d 44 24 10 89 44 24 10 89 44 24 14 83 79 10 00 
> 74 38 8b 8a bc 01 00 00 6b 47 04 64 bb 64 00 00 00 31 d2 d3 fb <f7> 35 
> 0c 6f 45 c0 ba 02 00 00 00 89 d1 99 f7 f9 01 d8 03 47 18
> EIP: [<c013be6a>] shrink_active_list+0x5b/0x382 SS:ESP 0068:c03a8d9c

rofl.  Certainly someone's broken something.  I assume the divide-by-zero
is due to total_memory being zero.

We shouldn't be running kswapd_init() as an initcall because sometimes when
things are broken we will run page reclaim during boot.

So I'd assume there's something wrong in the memory setup which is causing
us to enter page reclaim far too early.

Something like this should prevent the immediate oops...

diff -puN mm/vmscan.c~run-kswapd_init-earlier mm/vmscan.c
--- devel/mm/vmscan.c~run-kswapd_init-earlier	2006-06-05 20:02:53.000000000 -0700
+++ devel-akpm/mm/vmscan.c	2006-06-05 20:03:12.000000000 -0700
@@ -1346,7 +1346,7 @@ static int cpu_callback(struct notifier_
 }
 #endif /* CONFIG_HOTPLUG_CPU */
 
-static int __init kswapd_init(void)
+int __init kswapd_init(void)
 {
 	pg_data_t *pgdat;
 
@@ -1365,8 +1365,6 @@ static int __init kswapd_init(void)
 	return 0;
 }
 
-module_init(kswapd_init)
-
 #ifdef CONFIG_NUMA
 /*
  * Zone reclaim mode
diff -puN include/linux/swap.h~run-kswapd_init-earlier include/linux/swap.h
--- devel/include/linux/swap.h~run-kswapd_init-earlier	2006-06-05 20:02:53.000000000 -0700
+++ devel-akpm/include/linux/swap.h	2006-06-05 20:03:51.000000000 -0700
@@ -176,6 +176,7 @@ extern unsigned long try_to_free_pages(s
 extern unsigned long shrink_all_memory(unsigned long nr_pages);
 extern int vm_swappiness;
 extern int remove_mapping(struct address_space *mapping, struct page *page);
+extern int kswapd_init(void);
 
 /* possible outcome of pageout() */
 typedef enum {
diff -puN init/main.c~run-kswapd_init-earlier init/main.c
--- devel/init/main.c~run-kswapd_init-earlier	2006-06-05 20:02:53.000000000 -0700
+++ devel-akpm/init/main.c	2006-06-05 20:04:15.000000000 -0700
@@ -50,6 +50,7 @@
 #include <linux/mempolicy.h>
 #include <linux/key.h>
 #include <linux/root_dev.h>
+#include <linux/swap.h>
 
 #include <asm/io.h>
 #include <asm/bugs.h>
@@ -523,6 +524,7 @@ asmlinkage void __init start_kernel(void
 	kmem_cache_init();
 	setup_per_cpu_pageset();
 	numa_policy_init();
+	kswapd_init();
 	if (late_time_init)
 		late_time_init();
 	calibrate_delay();
_

