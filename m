Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266983AbUAXSOI (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 24 Jan 2004 13:14:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266985AbUAXSOI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 24 Jan 2004 13:14:08 -0500
Received: from modemcable178.89-70-69.mc.videotron.ca ([69.70.89.178]:40064
	"EHLO montezuma.fsmlabs.com") by vger.kernel.org with ESMTP
	id S266983AbUAXSN7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 24 Jan 2004 13:13:59 -0500
Date: Sat, 24 Jan 2004 13:12:30 -0500 (EST)
From: Zwane Mwaikambo <zwane@arm.linux.org.uk>
To: Linux Kernel <linux-kernel@vger.kernel.org>
cc: Nick Piggin <piggin@cyberone.com.au>
Subject: [PATCH][2.6-mm] Fix CONFIG_SMT oops on UP
Message-ID: <Pine.LNX.4.58.0401241303070.26103@montezuma.fsmlabs.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This fixes an oops due to cpu_sibling_map being uninitialised when a
system with no MP table (most UP boxen) boots a CONFIG_SMT kernel. What
also happens is that the cpu_group lists end up not being terminated
properly, but this oops kills it first. Patch tested on UP w/o MP table,
2x P2 and UP Xeon w/ no siblings.

Unable to handle kernel paging request at virtual address 15c79c
 printing eip:
0211f861
*pde = 0004e063
Oops: 0000 [#1]
PREEMPT SMP DEBUG_PAGEALLOC
CPU:    0
EIP:    0060:[<0211f861>]    Not tainted VLI
EFLAGS: 00010006
EIP is at find_busiest_group+0x71/0x2f4
eax: 00000000   ebx: 15c79048   ecx: 15c79048   edx: 29f94000
esi: 00000000   edi: 29f94000   ebp: 29f95d78   esp: 29f95d24
ds: 007b   es: 007b   ss: 0068
Process swapper (pid: 1, threadinfo=29f94000 task=03a77980)
Stack: 00000000 00000246 0211d19e 0363ee08 29f94000 026c0834 29f94000 00000000
       15c79048 00000000 00000000 00000000 00000000 00000001 00000000 00000000
       00000001 00000000 0364acc0 00000000 29f94000 29f95dc4 0211fc40 0364a060
Call Trace:
 [<0211d19e>] change_page_attr+0xa2/0xd4
 [<0211fc40>] load_balance+0x4c/0x428
 [<02120571>] rebalance_tick+0xa9/0xc4
 [<02120693>] scheduler_tick+0x107/0x6cc
 [<0210c97b>] handle_IRQ_event+0x2f/0x58
 [<0212f1f2>] update_process_times+0x2a/0x30
 [<02118805>] smp_apic_timer_interrupt+0x141/0x148
 [<0233367c>] serial8250_console_write+0xac/0x4ec
 [<02126d93>] __call_console_drivers+0x4f/0x54
 [<02126e82>] call_console_drivers+0x82/0x108
 [<021272cf>] release_console_sem+0x8b/0x178
 [<0212713a>] printk+0x1ca/0x278
 [<02676fbc>] arch_init_sched_domains+0x3d8/0x738
 [<02107109>] init+0x51/0x19c
 [<021070b8>] init+0x0/0x19c
 [<02108e61>] kernel_thread_helper+0x5/0xc

Code: 00 0f 84 ee 01 00 00 31 c0 83 7d 14 02 0f 95 c0 ba 00 e0 ff ff 21 e2
89 45 e0 89 55 b

Index: linux-2.6.2-rc1-mm2/arch/i386/kernel/smpboot.c
===================================================================
RCS file: /home/cvsroot/linux-2.6.2-rc1-mm2/arch/i386/kernel/smpboot.c,v
retrieving revision 1.1.1.1
diff -u -p -B -r1.1.1.1 smpboot.c
--- linux-2.6.2-rc1-mm2/arch/i386/kernel/smpboot.c	23 Jan 2004 22:22:46 -0000	1.1.1.1
+++ linux-2.6.2-rc1-mm2/arch/i386/kernel/smpboot.c	24 Jan 2004 17:54:29 -0000
@@ -951,6 +951,8 @@ static void __init smp_boot_cpus(unsigne

 	current_thread_info()->cpu = 0;
 	smp_tune_scheduling();
+	cpu_sibling_map[0] = CPU_MASK_NONE;
+	cpu_set(0, cpu_sibling_map[0]);

 	/*
 	 * If we couldn't find an SMP configuration at boot time,
