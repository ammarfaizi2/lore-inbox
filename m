Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266451AbUHUOHL@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266451AbUHUOHL (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 21 Aug 2004 10:07:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266453AbUHUOHK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 21 Aug 2004 10:07:10 -0400
Received: from dragnfire.mtl.istop.com ([66.11.160.179]:35046 "EHLO
	dsl.commfireservices.com") by vger.kernel.org with ESMTP
	id S266451AbUHUOGl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 21 Aug 2004 10:06:41 -0400
Date: Sat, 21 Aug 2004 10:10:52 -0400 (EDT)
From: Zwane Mwaikambo <zwane@fsmlabs.com>
To: Linux Kernel <linux-kernel@vger.kernel.org>
Cc: Andrew Morton <akpm@osdl.org>, Rusty Russell <rusty@rustcorp.com.au>,
       Nathan Lynch <nathanl@austin.ibm.com>,
       Srivatsa Vaddagiri <vatsa@in.ibm.com>
Subject: [PATCH][2.6] Hotplug cpu: Fix APIC queued timer vector race
Message-ID: <Pine.LNX.4.58.0408210923570.27390@montezuma.fsmlabs.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Some timer interrupt vectors were queued on the Local APIC and were being
serviced when we enabled interrupts again in fixup_irqs(), so we need to
mask the APIC timer, enable interrupts so that any queued interrupts get
processed whilst the processor is still on the online map and then clear
ourselves from the online map. 1ms is a nice safe number even under heavy
interrupt load with higher priority vectors queued. Andrew this is
the patch i promised, Rusty, i'm not sure if you find
__attribute__((weak)) offensive...

Unable to handle kernel NULL pointer dereference at virtual address 00000008
 printing eip:
*pde = 00000000
Oops: 0000 [#1]
PREEMPT SMP
Modules linked in:
CPU:    1
EIP:    0060:[<c01200cd>]    Not tainted VLI
EFLAGS: 00010006   (2.6.8.1-mm2)
EIP is at find_busiest_group+0x1cd/0x350
eax: ddca7ef0   ebx: 00000000   ecx: 00000080   edx: 00000000
esi: 0000007d   edi: c05e3460   ebp: ddca7ec8   esp: ddca7e7c
ds: 007b   es: 007b   ss: 0068
Process kstopmachine (pid: 29711, threadinfo=ddca7000 task=de688250)
Stack: ddca7e9c c013b2f1 c05c7000 00000000 00000001 00000080 00000000 00008000
       00000100 c05e346c 00000000 c05e3460 ddca7ef0 00000001 c14119e0 00000001
       c14119e0 c1410f60 00000001 ddca7f00 c0120350 00000001 00800f00 00007410
Call Trace:
 [<c01082ea>] show_stack+0x7a/0x90
 [<c0108472>] show_registers+0x152/0x1c0
 [<c01086a0>] die+0x110/0x200
 [<c011d0f5>] do_page_fault+0x235/0x5d3
 [<c0107ed9>] error_code+0x2d/0x38
 [<c0120350>] load_balance+0x40/0x2c0
 [<c0120961>] rebalance_tick+0xa1/0xb0
 [<c0119722>] smp_apic_timer_interrupt+0xf2/0x100
 [<c0107e5e>] apic_timer_interrupt+0x1a/0x20
 [<c0241adc>] __delay+0xc/0x10
 [<c010afd3>] fixup_irqs+0xe3/0x130
 [<c0118f66>] __cpu_disable+0x16/0x30
 [<c0140bb4>] take_cpu_down+0x24/0x50
 [<c01472f3>] do_stop+0x63/0x70
 [<c013f715>] kthread+0xa5/0xb0
 [<c0105375>] kernel_thread_helper+0x5/0x10
Code: 02 0f af d6 39 d0 0f 86 05 01 00 00 8b 5d cc 89 ca 8b 45 d4 29 da 29 c8 3

Signed-off-by: Zwane Mwaikambo <zwane@fsmlabs.com>

Index: linux-2.6.8.1-mm2/kernel/cpu.c
===================================================================
RCS file: /home/cvsroot/linux-2.6.8.1-mm2/kernel/cpu.c,v
retrieving revision 1.1.1.1
diff -u -p -B -r1.1.1.1 cpu.c
--- linux-2.6.8.1-mm2/kernel/cpu.c	19 Aug 2004 20:52:08 -0000	1.1.1.1
+++ linux-2.6.8.1-mm2/kernel/cpu.c	21 Aug 2004 14:10:18 -0000
@@ -84,11 +84,18 @@ static int cpu_run_sbin_hotplug(unsigned
 	return call_usermodehelper(argv[0], argv, envp, 0);
 }

+void __attribute__((weak)) __cpu_prep_disable(void)
+{
+}
+
 /* Take this CPU down. */
 static int take_cpu_down(void *unused)
 {
 	int err;

+	/* Prepatory work before clearing the cpu off the online map */
+	__cpu_prep_disable();
+
 	/* Take offline: makes arch_cpu_down somewhat easier. */
 	cpu_clear(smp_processor_id(), cpu_online_map);

Index: linux-2.6.8.1-mm2/arch/i386/kernel/smpboot.c
===================================================================
RCS file: /home/cvsroot/linux-2.6.8.1-mm2/arch/i386/kernel/smpboot.c,v
retrieving revision 1.1.1.1
diff -u -p -B -r1.1.1.1 smpboot.c
--- linux-2.6.8.1-mm2/arch/i386/kernel/smpboot.c	19 Aug 2004 20:51:36 -0000	1.1.1.1
+++ linux-2.6.8.1-mm2/arch/i386/kernel/smpboot.c	21 Aug 2004 12:56:52 -0000
@@ -1159,6 +1159,18 @@ static int __devinit cpu_enable(unsigned
 	return 0;
 }

+void __cpu_prep_disable(void)
+{
+	/* We enable the timer again on the exit path of the death loop */
+	if (smp_processor_id() != 0) {
+		disable_APIC_timer();
+		/* Allow any queued timer interrupts to get serviced */
+		local_irq_enable();
+		mdelay(1);
+		local_irq_disable();
+	}
+}
+
 int __cpu_disable(void)
 {
 	/*
@@ -1173,9 +1185,6 @@ int __cpu_disable(void)
 		return -EBUSY;

 	fixup_irqs();
-
-	/* We enable the timer again on the exit path of the death loop */
-	disable_APIC_timer();
 	return 0;
 }

