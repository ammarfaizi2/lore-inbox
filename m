Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269470AbUJLGA0@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269470AbUJLGA0 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 12 Oct 2004 02:00:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269471AbUJLGA0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 12 Oct 2004 02:00:26 -0400
Received: from e1.ny.us.ibm.com ([32.97.182.101]:33012 "EHLO e1.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S269470AbUJLGAJ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 12 Oct 2004 02:00:09 -0400
Subject: Re: [PATCH] i386 CPU hotplug updated for -mm
From: Nathan Lynch <nathanl@austin.ibm.com>
To: Zwane Mwaikambo <zwane@linuxpower.ca>
Cc: Andrew Morton <akpm@osdl.org>, Ingo Molnar <mingo@elte.hu>,
       Linux Kernel <linux-kernel@vger.kernel.org>,
       Rusty Russell <rusty@rustcorp.com.au>
In-Reply-To: <Pine.LNX.4.61.0410102302170.2745@musoma.fsmlabs.com>
References: <20041001204533.GA18684@elte.hu>
	 <20041001204642.GA18750@elte.hu> <20041001143332.7e3a5aba.akpm@osdl.org>
	 <Pine.LNX.4.61.0410091550300.2870@musoma.fsmlabs.com>
	 <Pine.LNX.4.61.0410102302170.2745@musoma.fsmlabs.com>
Content-Type: text/plain
Message-Id: <1097560787.6557.99.camel@biclops>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 
Date: Tue, 12 Oct 2004 00:59:47 -0500
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2004-10-11 at 03:19, Zwane Mwaikambo wrote:
> Hi Andrew,
> 	Find attached the i386 cpu hotplug patch updated for Ingo's latest 
> round of goodies. In order to avoid dumping cpu hotplug code into 
> kernel/irq/* i dropped the cpu_online check in do_IRQ() by modifying 
> fixup_irqs(). The difference being that on cpu offline, fixup_irqs() is 
> called before we clear the cpu from cpu_online_map and a long delay in 
> order to ensure that we never have any queued external interrupts on the 
> APICs. Due to my usual test victims being in boxes a continent away this 
> hasn't been tested, but i'll cover bug reports (nudge, Nathan! ;)

Had to apply the patch to 2.6.9-rc4-mm1 (2.6.9-rc3-mm3 doesn't detect my
scsi controller).  Tested on a dual Pentium 3.  Simple offline/online
tests seem ok, except I see these warnings when taking a cpu down:

using smp_processor_id() in preemptible code: bash/3436
 [<c0106f37>] dump_stack+0x17/0x20
 [<c011a087>] smp_processor_id+0x87/0xa0
 [<c0134d54>] cpu_down+0x134/0x240
 [<c02770d9>] store_online+0x39/0x70
 [<c0274487>] sysdev_store+0x37/0x50
 [<c019339e>] flush_write_buffer+0x2e/0x40
 [<c0193427>] sysfs_write_file+0x77/0x90
 [<c015aa20>] vfs_write+0xe0/0x120
 [<c015ab0d>] sys_write+0x3d/0x70
 [<c0106123>] syscall_call+0x7/0xb

using smp_processor_id() in preemptible code: ksoftirqd/1/5233
 [<c0106f37>] dump_stack+0x17/0x20
 [<c011a087>] smp_processor_id+0x87/0xa0
 [<c0124128>] ksoftirqd+0x68/0x140
 [<c0133326>] kthread+0x96/0xe0
 [<c0104275>] kernel_thread_helper+0x5/0x10

Under load (unpacking a kernel source tree while continuous
online/offline of a cpu) I got a panic within a couple of minutes:

Unable to handle kernel NULL pointer dereference at virtual address 00000004
 printing eip:
c0145703
*pde = 00000000
Oops: 0000 [#1]
PREEMPT SMP
Modules linked in:
CPU:    1
EIP:    0060:[<c0145703>]    Not tainted VLI
EFLAGS: 00010082   (2.6.9-rc4-mm1i386cpuhp)
EIP is at kmem_cache_free+0x33/0x70
eax: cba2cd98   ebx: 00000000   ecx: 00000000   edx: cba2cd98
esi: c1561ac0   edi: cba2cd98   ebp: c058be8c   esp: c058be7c
ds: 007b   es: 007b   ss: 0068
Process swapper (pid: 0, threadinfo=c058b000 task=dff88540)
Stack: 00000082 c1559920 00001000 cba2cd9c c058bea4 c013e491 00000000 cf4abee0
       00001000 c015f050 c058beb0 c015f92c cf4abee0 c058beb8 c015fbac c058bec4
       c015f07d cf4abee0 c058beec c0160819 c0271a48 c0127c11 00000001 00000002
Call Trace:
 [<c0106f0a>] show_stack+0x7a/0x90
 [<c0107096>] show_registers+0x156/0x1d0
 [<c01072b4>] die+0xf4/0x180
 [<c0116bd7>] do_page_fault+0x457/0x66d
 [<c0106b8d>] error_code+0x2d/0x38
 [<c013e491>] mempool_free+0x81/0x90
 [<c015f92c>] bio_destructor+0x3c/0x60
 [<c015fbac>] bio_put+0x2c/0x40
 [<c015f07d>] end_bio_bh_io_sync+0x2d/0x60
 [<c0160819>] bio_endio+0x59/0x90
 [<c027c578>] __end_that_request_first+0x188/0x250
 [<c029db14>] __ide_end_request+0x54/0x150
 [<c029dc68>] ide_end_request+0x58/0xc0
 [<c02a3fe1>] task_end_request+0x31/0x70
 [<c02a418b>] task_out_intr+0x7b/0x100
 [<c029f6cd>] ide_intr+0xbd/0x160
 [<c0139d44>] handle_IRQ_event+0x34/0x70
 [<c0139e6c>] __do_IRQ+0xec/0x170
 [<c0108570>] do_IRQ+0x60/0xa0
 =======================
 [<c0106a90>] common_interrupt+0x18/0x20
 [<00000000>] 0x0
 [<dff84fbc>] 0xdff84fbc
Code: f8 89 c6 89 5d f4 89 7d fc 9c 8f 45 f0 fa 89 d7 e8 13 49 fd ff 8b 1c 86 e8 6b ea ff ff 8b 4d 04 89 fa 89 f0 e8 2f f3 ff ff 89 c7 <8b> 43 04 39 03 73 20 f0 ff 86 c4 00 00 00 8b 03 89 7c 83 10 ff
 <0>Kernel panic - not syncing: Fatal exception in interrupt

I fixed up the warning in cpu_down with the following patch and now am
running with that + 2.6.9-rc4-mm1 + your patch while doing continuous
online/offline and make -j8.  It's been running for about 45 minutes and
I haven't seen the panic yet, although I'm at a loss to explain why the
change would fix it.  Will let it run overnight and report back...

Nathan

--

Fix (harmless?) smp_processor_id() usage in preemptible section of
cpu_down.

Signed-off-by: Nathan Lynch <nathanl@austin.ibm.com>
---

 2.6.9-rc4-mm1-nathanl/kernel/cpu.c |    3 ++-
 1 files changed, 2 insertions(+), 1 deletion(-)

diff -puN kernel/cpu.c~cpu_down-fix-smp_processor_id-warning kernel/cpu.c
--- 2.6.9-rc4-mm1/kernel/cpu.c~cpu_down-fix-smp_processor_id-warning	2004-10-11 23:28:47.000000000 -0500
+++ 2.6.9-rc4-mm1-nathanl/kernel/cpu.c	2004-10-11 23:34:36.000000000 -0500
@@ -129,7 +129,8 @@ int cpu_down(unsigned int cpu)
 	__cpu_die(cpu);
 
 	/* Move it here so it can run. */
-	kthread_bind(p, smp_processor_id());
+	kthread_bind(p, get_cpu());
+	put_cpu();
 
 	/* CPU is completely dead: tell everyone.  Too late to complain. */
 	if (notifier_call_chain(&cpu_chain, CPU_DEAD, (void *)(long)cpu)
_


