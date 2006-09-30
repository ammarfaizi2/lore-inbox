Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751814AbWI3T5v@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751814AbWI3T5v (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 30 Sep 2006 15:57:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751817AbWI3T5v
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 30 Sep 2006 15:57:51 -0400
Received: from smtp.osdl.org ([65.172.181.4]:46825 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1751814AbWI3T5t (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 30 Sep 2006 15:57:49 -0400
Date: Sat, 30 Sep 2006 12:54:21 -0700 (PDT)
From: Linus Torvalds <torvalds@osdl.org>
To: Eric Rannaud <eric.rannaud@gmail.com>
cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Ingo Molnar <mingo@elte.hu>, Andrew Morton <akpm@osdl.org>,
       nagar@watson.ibm.com, Chandra Seetharaman <sekharan@us.ibm.com>,
       Andi Kleen <ak@suse.de>, Jan Beulich <jbeulich@novell.com>
Subject: Re: BUG-lockdep and freeze (was: Arrr! Linux 2.6.18)
In-Reply-To: <5f3c152b0609301220p7a487c7dw456d007298578cd7@mail.gmail.com>
Message-ID: <Pine.LNX.4.64.0609301237460.3952@g5.osdl.org>
References: <5f3c152b0609301220p7a487c7dw456d007298578cd7@mail.gmail.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Sat, 30 Sep 2006, Eric Rannaud wrote:
> 
> (2) is introduced by d94a041519f3ab1ac023bf917619cd8c4a7d3c01
> [PATCH] taskstats: free skb, avoid returns in send_cpu_listeners,
> Signed-off-by: Shailabh Nagar.
> The kernel freezes after a BUG (no sysrq magic).

This one looks like the real problem is that totally broken stack unwinder 
again. 

The lockdep warning in itself is probably valid, but the reason for the 
_hang_ is the

	[  138.831385] Unable to handle kernel paging request at ffffffff82800000 RIP:
	[  138.831439]  [<ffffffff8020b491>] show_trace+0x311/0x380  

and that code is just a total mess. 

Andi, I really think that Dwarf unwinder needs to go. The code is totally 
unreadable, and it's clearly fragile as hell. It doesn't check that the 
pointers it gets are even remotely valid, but just follows them as if they 
were.

The whole unwinder seems buggier than any bug it can ever unwind would be. 
Really. Let's go back to the sane "try our best, don't guarantee anything, 
but at least don't make things worse!" old code.

The people who wrote that crap (and yes, Andi, I mean apparently you and 
Jan Beulich) really _have_ to get his act together. It's not just 
unreadable and obviously buggy, it's so scarily that it's hard to even 
talk about it. Lookie here:

	#define HANDLE_STACK(cond) \
	        do while (cond) { \
	                unsigned long addr = *stack++; \

What the F*CK! "do while(cond) {" ???? 

Please. Somebody just rip out all this crap. I beg of you.

We need Al Viro here to put this kind of code into perspective. I _think_ 
he would have some choice words for code that is meant to "help" 
debugging, and is this horrible.

		Linus

----
> 
> ---- netconsole for (2) with numa=noacpi
> [  138.430672] BUG: warning at kernel/lockdep.c:565/print_infinite_recursion_bug()
> [  138.430710] powernow-k8: MP systems not supported by PSB BIOS structure
> [  138.430752] powernow-k8: MP systems not supported by PSB BIOS structure
> [  138.430782] powernow-k8: MP systems not supported by PSB BIOS structure
> [  138.430814] powernow-k8: MP systems not supported by PSB BIOS structure
> [  138.430972]
> [  138.430973] Call Trace:
> [  138.431190]  [<ffffffff8020b22d>] show_trace+0xad/0x380
> [  138.431264]  [<ffffffff8020b745>] dump_stack+0x15/0x20
> [  138.431337]  [<ffffffff8024bc1d>] print_infinite_recursion_bug+0x3d/0x50
> [  138.431465]  [<ffffffff8024bd2f>] find_usage_backwards+0x2f/0xd0
> [  138.431591]  [<ffffffff8024bd93>] find_usage_backwards+0x93/0xd0
> [  138.431718]  [<ffffffff8024bd93>] find_usage_backwards+0x93/0xd0
> [  138.431844]  [<ffffffff8024bd93>] find_usage_backwards+0x93/0xd0
> [  138.431970]  [<ffffffff8024bd93>] find_usage_backwards+0x93/0xd0
> [  138.432097]  [<ffffffff8024bd93>] find_usage_backwards+0x93/0xd0
> [  138.432223]  [<ffffffff8024bd93>] find_usage_backwards+0x93/0xd0
> [  138.432349]  [<ffffffff8024bd93>] find_usage_backwards+0x93/0xd0
> [  138.432475]  [<ffffffff8024bd93>] find_usage_backwards+0x93/0xd0
> [  138.432602]  [<ffffffff8024bd93>] find_usage_backwards+0x93/0xd0
> [  138.432728]  [<ffffffff8024bd93>] find_usage_backwards+0x93/0xd0
> [  138.432855]  [<ffffffff8024bd93>] find_usage_backwards+0x93/0xd0
> [  138.432982]  [<ffffffff8024bd93>] find_usage_backwards+0x93/0xd0
> [  138.433111]  [<ffffffff8024bd93>] find_usage_backwards+0x93/0xd0
> [  138.433237]  [<ffffffff8024bd93>] find_usage_backwards+0x93/0xd0
> [  138.433362]  [<ffffffff8024bd93>] find_usage_backwards+0x93/0xd0
> [  138.433488]  [<ffffffff8024bd93>] find_usage_backwards+0x93/0xd0
> [  138.433613]  [<ffffffff8024bd93>] find_usage_backwards+0x93/0xd0
> [  138.433739]  [<ffffffff8024bd93>] find_usage_backwards+0x93/0xd0
> [  138.433865]  [<ffffffff8024bd93>] find_usage_backwards+0x93/0xd0
> [  138.433992]  [<ffffffff8024bd93>] find_usage_backwards+0x93/0xd0
> [  138.434120]  [<ffffffff8024c740>] check_usage+0x40/0x2b0
> [  138.434246]  [<ffffffff8024e010>] __lock_acquire+0xa50/0xd20
> [  138.434371]  [<ffffffff8024e66b>] lock_acquire+0x8b/0xc0
> [  138.434501]  [<ffffffff804ac065>] _spin_lock+0x25/0x40
> [  138.434631]  [<ffffffff80227d30>] double_rq_lock+0x40/0x50
> [  138.434730]  [<ffffffff8022ceca>] rebalance_tick+0x19a/0x340
> [  138.434831]  [<ffffffff8022d0ef>] scheduler_tick+0x7f/0x390
> [  138.434933]  [<ffffffff8023afe3>] update_process_times+0x73/0x90
> [  138.435046]  [<ffffffff8021636b>] smp_local_timer_interrupt+0x2b/0x60
> [  138.435133]  [<ffffffff80216b28>] smp_apic_timer_interrupt+0x58/0x70
> [  138.435217]  [<ffffffff8020a76e>] apic_timer_interrupt+0x6a/0x70
> [  138.435284]  [<ffffffff802086b2>] default_idle+0x42/0x80
> [  138.435348]  [<ffffffff8020875a>] cpu_idle+0x6a/0x90
> [  138.435414]  [<ffffffff8094d94c>] start_secondary+0x4fc/0x510
> [  138.435494]  <IRQ> [<ffffffff8024bd93>] find_usage_backwards+0x93/0xd0
> [  138.435597]  [<ffffffff8024bc1d>] print_infinite_recursion_bug+0x3d/0x50
> [  138.435659]  [<ffffffff8024bd2f>] find_usage_backwards+0x2f/0xd0
> [  138.435721]  [<ffffffff8024bd93>] find_usage_backwards+0x93/0xd0
> [  138.435782]  [<ffffffff8024bd93>] find_usage_backwards+0x93/0xd0
> [  138.435844]  [<ffffffff8024bd93>] find_usage_backwards+0x93/0xd0
> [  138.435906]  [<ffffffff8024bd93>] find_usage_backwards+0x93/0xd0
> [  138.435967]  [<ffffffff8024bd93>] find_usage_backwards+0x93/0xd0
> [  138.436029]  [<ffffffff8024bd93>] find_usage_backwards+0x93/0xd0
> [  138.436093]  [<ffffffff8024bd93>] find_usage_backwards+0x93/0xd0
> [  138.436155]  [<ffffffff8024bd93>] find_usage_backwards+0x93/0xd0
> [  138.436216]  [<ffffffff8024bd93>] find_usage_backwards+0x93/0xd0
> [  138.436277]  [<ffffffff8024bd93>] find_usage_backwards+0x93/0xd0
> [  138.436339]  [<ffffffff8024bd93>] find_usage_backwards+0x93/0xd0
> [  138.436400]  [<ffffffff8024bd93>] find_usage_backwards+0x93/0xd0
> [  138.436462]  [<ffffffff8024bd93>] find_usage_backwards+0x93/0xd0
> [  138.436523]  [<ffffffff8024bd93>] find_usage_backwards+0x93/0xd0
> [  138.436585]  [<ffffffff8024bd93>] find_usage_backwards+0x93/0xd0
> [  138.436647]  [<ffffffff8024bd93>] find_usage_backwards+0x93/0xd0
> [  138.436708]  [<ffffffff8024bd93>] find_usage_backwards+0x93/0xd0
> [  138.436770]  [<ffffffff8024bd93>] find_usage_backwards+0x93/0xd0
> [  138.436831]  [<ffffffff8024bd93>] find_usage_backwards+0x93/0xd0
> [  138.436893]  [<ffffffff8024bd93>] find_usage_backwards+0x93/0xd0
> [  138.436954]  [<ffffffff8024c740>] check_usage+0x40/0x2b0
> [  138.437016]  [<ffffffff8024e010>] __lock_acquire+0xa50/0xd20
> [  138.437080]  [<ffffffff80227d30>] double_rq_lock+0x40/0x50
> [  138.437141]  [<ffffffff8024e66b>] lock_acquire+0x8b/0xc0
> [  138.437202]  [<ffffffff80227d30>] double_rq_lock+0x40/0x50
> [  138.437264]  [<ffffffff804ac065>] _spin_lock+0x25/0x40
> [  138.437325]  [<ffffffff80227d30>] double_rq_lock+0x40/0x50
> [  138.437385]  [<ffffffff8022ceca>] rebalance_tick+0x19a/0x340
> [  138.437446]  [<ffffffff804ac54b>] _spin_unlock_irq+0x2b/0x40
> [  138.437508]  [<ffffffff8022d0ef>] scheduler_tick+0x7f/0x390
> [  138.437569]  [<ffffffff8023afe3>] update_process_times+0x73/0x90
> [  138.437631]  [<ffffffff8021636b>] smp_local_timer_interrupt+0x2b/0x60
> [  138.437694]  [<ffffffff80216b28>] smp_apic_timer_interrupt+0x58/0x70
> [  138.437756]  [<ffffffff802086b0>] default_idle+0x40/0x80
> [  138.437815]  [<ffffffff80208670>] default_idle+0x0/0x80
> [  138.437875]  [<ffffffff8020a76e>] apic_timer_interrupt+0x6a/0x70
> [  138.437936]  <EOI> [<ffffffff8045c7ff>] ipq_kill+0x5f/0xa0
> [  138.751237]  [<ffffffff8021ed29>] flush_kernel_map+0x39/0x40
> [  138.751306]  [<ffffffff8021ecc0>] search_extable+0x40/0x70
> [  138.763697]  [<ffffffff8020efeb>] show_cpuinfo+0x18b/0x360
> [  138.763765]  [<ffffffff8020efef>] show_cpuinfo+0x18f/0x360
> [  138.763828]  [<ffffffff8020f0e6>] show_cpuinfo+0x286/0x360
> [  138.763889]  [<ffffffff8020f0ed>] show_cpuinfo+0x28d/0x360
> [  138.764152]  [<ffffffff8021de9f>] show_mem+0xbf/0x170
> [  138.764211]  [<ffffffff8021dea1>] show_mem+0xc1/0x170
> [  138.764275]  [<ffffffff8021dec0>] show_mem+0xe0/0x170
> [  138.764334]  [<ffffffff8021dec2>] show_mem+0xe2/0x170
> [  138.764394]  [<ffffffff8021ded7>] show_mem+0xf7/0x170
> [  138.764453]  [<ffffffff8021ded9>] show_mem+0xf9/0x170
> [  138.764514]  [<ffffffff8021dfc0>] __add_pages+0x40/0xd0
> [  138.764576]  [<ffffffff8021e089>] vmalloc_sync_all+0x39/0x170
> [  138.799966]  [<ffffffff8049ee60>] xfrm_state_netlink+0x0/0xa0
> [  138.800034]  [<ffffffff8049ee69>] xfrm_state_netlink+0x9/0xa0
> [  138.800100]  [<ffffffff8049ee86>] xfrm_state_netlink+0x26/0xa0
> [  138.800161]  [<ffffffff8049ee8f>] xfrm_state_netlink+0x2f/0xa0
> [  138.800230]  [<ffffffff8049f182>] xfrm_send_state_notify+0x282/0x6c0
> [  138.800292]  [<ffffffff8049f195>] xfrm_send_state_notify+0x295/0x6c0
> [  138.800370]  [<ffffffff8022ad33>] find_busiest_group+0x5d3/0x6f0
> [  138.800431]  [<ffffffff8022ad3c>] find_busiest_group+0x5dc/0x6f0
> [  138.800499]  [<ffffffff8049f23c>] xfrm_send_state_notify+0x33c/0x6c0
> [  138.800562]  [<ffffffff8049f243>] xfrm_send_state_notify+0x343/0x6c0
> [  138.800628]  [<ffffffff8022ae75>] migration_thread+0x25/0x2e0
> [  138.800689]  [<ffffffff8022ae7e>] migration_thread+0x2e/0x2e0
> [  138.800752]  [<ffffffff8022aea0>] migration_thread+0x50/0x2e0
> [  138.800813]  [<ffffffff8022aea9>] migration_thread+0x59/0x2e0
> [  138.831385] Unable to handle kernel paging request at ffffffff82800000 RIP:
> [  138.831439]  [<ffffffff8020b491>] show_trace+0x311/0x380
> [  138.831598] PGD 203027 PUD 205027 PMD 0
> [  138.831762] Oops: 0000 [1] SMP
> [  138.831889] CPU 15
> [  138.831978] Modules linked in:
> [  138.832073] Pid: 0, comm: swapper Not tainted 2.6.18-rc3rannaud-gd94a0415 #36
> [  138.832137] RIP: 0010:[<ffffffff8020b491>]  [<ffffffff8020b491>] show_trace+0x311/0x380
> [  138.832252] RSP: 0018:ffff8102238e7810  EFLAGS: 00010002
> [  138.832312] RAX: 0000000000000000 RBX: 0000000000000000 RCX: 0000000000000001
> [  138.832375] RDX: 0000000000000000 RSI: 0000000000000001 RDI: ffffffff805b9940
> [  138.832439] RBP: ffff8102238e7900 R08: 0000000000000002 R09: ffffffff80256580
> [  138.832501] R10: ffffffffffffffff R11: 0000000000000000 R12: ffffffff827ffffe
> [  138.832564] R13: 0000000000000000 R14: 000000000000000f R15: ffffffff8097f000
> [  138.832627] FS:  00000000005a6860(0000) GS:ffff810223894ac0(0000) knlGS:0000000000000000
> [  138.832705] CS:  0010 DS: 0018 ES: 0018 CR0: 000000008005003b
> [  138.832766] CR2: ffffffff82800000 CR3: 00000002217c0000 CR4: 00000000000006e0
> [  138.832830] Process swapper (pid: 0, threadinfo ffff8102238e2000, task ffff81022389b100)
> [  138.832909] Stack:  0000000080838210 ffffffff808a1ca8 0000000000000000 0000000000000000
> [  138.833169]  0000000000000000 0000000000000000 0000000000000000 0000000000000d07
> [  138.833387]  0000000000000001 0000000000000000 0000000000000001 0000000000000001
> [  138.833556] Call Trace:
> [  138.833676]  [<ffffffff8020b745>] dump_stack+0x15/0x20
> [  138.833748]  [<ffffffff8024bc1d>] print_infinite_recursion_bug+0x3d/0x50
> [  138.833894]  [<ffffffff8024bd2f>] find_usage_backwards+0x2f/0xd0
> [  138.834020]  [<ffffffff8024bd93>] find_usage_backwards+0x93/0xd0
> [  138.834146]  [<ffffffff8024bd93>] find_usage_backwards+0x93/0xd0
> [  138.834273]  [<ffffffff8024bd93>] find_usage_backwards+0x93/0xd0
> [  138.834399]  [<ffffffff8024bd93>] find_usage_backwards+0x93/0xd0
> [  138.834527]  [<ffffffff8024bd93>] find_usage_backwards+0x93/0xd0
> [  138.834652]  [<ffffffff8024bd93>] find_usage_backwards+0x93/0xd0
> [  138.834777]  [<ffffffff8024bd93>] find_usage_backwards+0x93/0xd0
> [  138.834902]  [<ffffffff8024bd93>] find_usage_backwards+0x93/0xd0
> [  138.835029]  [<ffffffff8024bd93>] find_usage_backwards+0x93/0xd0
> [  138.835154]  [<ffffffff8024bd93>] find_usage_backwards+0x93/0xd0
> [  138.835279]  [<ffffffff8024bd93>] find_usage_backwards+0x93/0xd0
> [  138.835404]  [<ffffffff8024bd93>] find_usage_backwards+0x93/0xd0
> [  138.835533]  [<ffffffff8024bd93>] find_usage_backwards+0x93/0xd0
> [  138.835658]  [<ffffffff8024bd93>] find_usage_backwards+0x93/0xd0
> [  138.835784]  [<ffffffff8024bd93>] find_usage_backwards+0x93/0xd0
> [  138.835909]  [<ffffffff8024bd93>] find_usage_backwards+0x93/0xd0
> [  138.836034]  [<ffffffff8024bd93>] find_usage_backwards+0x93/0xd0
> [  138.836159]  [<ffffffff8024bd93>] find_usage_backwards+0x93/0xd0
> [  138.836285]  [<ffffffff8024bd93>] find_usage_backwards+0x93/0xd0
> [  138.836411]  [<ffffffff8024bd93>] find_usage_backwards+0x93/0xd0
> [  138.836539]  [<ffffffff8024c740>] check_usage+0x40/0x2b0
> [  138.836664]  [<ffffffff8024e010>] __lock_acquire+0xa50/0xd20
> [  138.836790]  [<ffffffff8024e66b>] lock_acquire+0x8b/0xc0
> [  138.836919]  [<ffffffff804ac065>] _spin_lock+0x25/0x40
> [  138.837049]  [<ffffffff80227d30>] double_rq_lock+0x40/0x50
> [  138.837148]  [<ffffffff8022ceca>] rebalance_tick+0x19a/0x340
> [  138.837249]  [<ffffffff8022d0ef>] scheduler_tick+0x7f/0x390
> [  138.837351]  [<ffffffff8023afe3>] update_process_times+0x73/0x90
> [  138.837464]  [<ffffffff8021636b>] smp_local_timer_interrupt+0x2b/0x60
> [  138.837549]  [<ffffffff80216b28>] smp_apic_timer_interrupt+0x58/0x70
> [  138.837633]  [<ffffffff8020a76e>] apic_timer_interrupt+0x6a/0x70
> [  138.837702]  [<ffffffff802086b2>] default_idle+0x42/0x80
> [  138.837766]  [<ffffffff8020875a>] cpu_idle+0x6a/0x90
> [  138.837832]  [<ffffffff8094d94c>] start_secondary+0x4fc/0x510
> [  138.837912]  <IRQ> [<ffffffff8020b745>] dump_stack+0x15/0x20
> [  138.838015]  [<ffffffff8024bd93>] find_usage_backwards+0x93/0xd0
> [  138.838077]  [<ffffffff8024bc1d>] print_infinite_recursion_bug+0x3d/0x50
> [  138.838140]  [<ffffffff8024bd2f>] find_usage_backwards+0x2f/0xd0
> [  138.838203]  [<ffffffff8024bd93>] find_usage_backwards+0x93/0xd0
> [  138.839444]  [<ffffffff8024bd93>] find_usage_backwards+0x93/0xd0
> [  138.839506]  [<ffffffff8024bd93>] find_usage_backwards+0x93/0xd0
> [  138.839569]  [<ffffffff8024bd93>] find_usage_backwards+0x93/0xd0
> [  138.839631]  [<ffffffff8024bd93>] find_usage_backwards+0x93/0xd0
> [  138.839694]  [<ffffffff8024bd93>] find_usage_backwards+0x93/0xd0
> [  138.839756]  [<ffffffff8024bd93>] find_usage_backwards+0x93/0xd0
> [  138.839819]  [<ffffffff8024bd93>] find_usage_backwards+0x93/0xd0
> [  138.839881]  [<ffffffff8024bd93>] find_usage_backwards+0x93/0xd0
> [  138.839943]  [<ffffffff8024bd93>] find_usage_backwards+0x93/0xd0
> [  138.840006]  [<ffffffff8024bd93>] find_usage_backwards+0x93/0xd0
> [  138.840068]  [<ffffffff8024bd93>] find_usage_backwards+0x93/0xd0
> [  138.840130]  [<ffffffff8024bd93>] find_usage_backwards+0x93/0xd0
> [  138.840193]  [<ffffffff8024bd93>] find_usage_backwards+0x93/0xd0
> [  138.840255]  [<ffffffff8024bd93>] find_usage_backwards+0x93/0xd0
> [  138.840316]  [<ffffffff8024bd93>] find_usage_backwards+0x93/0xd0
> [  138.840378]  [<ffffffff8024bd93>] find_usage_backwards+0x93/0xd0
> [  138.840439]  [<ffffffff8024bd93>] find_usage_backwards+0x93/0xd0
> [  138.840502]  [<ffffffff8024bd93>] find_usage_backwards+0x93/0xd0
> [  138.840564]  [<ffffffff8024bd93>] find_usage_backwards+0x93/0xd0
> [  138.840625]  [<ffffffff8024c740>] check_usage+0x40/0x2b0
> [  138.840687]  [<ffffffff8024e010>] __lock_acquire+0xa50/0xd20
> [  138.840749]  [<ffffffff80227d30>] double_rq_lock+0x40/0x50
> [  138.840811]  [<ffffffff8024e66b>] lock_acquire+0x8b/0xc0
> [  138.840871]  [<ffffffff80227d30>] double_rq_lock+0x40/0x50
> [  138.840933]  [<ffffffff804ac065>] _spin_lock+0x25/0x40
> [  138.840993]  [<ffffffff80227d30>] double_rq_lock+0x40/0x50
> [  138.841054]  [<ffffffff8022ceca>] rebalance_tick+0x19a/0x340
> [  138.841116]  [<ffffffff804ac54b>] _spin_unlock_irq+0x2b/0x40
> [  138.841179]  [<ffffffff8022d0ef>] scheduler_tick+0x7f/0x390
> [  138.841239]  [<ffffffff8023afe3>] update_process_times+0x73/0x90
> [  138.841301]  [<ffffffff8021636b>] smp_local_timer_interrupt+0x2b/0x60
> [  138.841363]  [<ffffffff80216b28>] smp_apic_timer_interrupt+0x58/0x70
> [  138.841425]  [<ffffffff802086b0>] default_idle+0x40/0x80
> [  138.841485]  [<ffffffff80208670>] default_idle+0x0/0x80
> [  138.841544]  [<ffffffff8020a76e>] apic_timer_interrupt+0x6a/0x70
> [  138.841605]  <EOI> [<ffffffff8045c7ff>] ipq_kill+0x5f/0xa0
> [  139.154267]  [<ffffffff8021ed29>] flush_kernel_map+0x39/0x40
> [  139.154336]  [<ffffffff8021ecc0>] search_extable+0x40/0x70
> [  139.166705]  [<ffffffff8020efeb>] show_cpuinfo+0x18b/0x360
> [  139.166774]  [<ffffffff8020efef>] show_cpuinfo+0x18f/0x360
> [  139.166837]  [<ffffffff8020f0e6>] show_cpuinfo+0x286/0x360
> [  139.166898]  [<ffffffff8020f0ed>] show_cpuinfo+0x28d/0x360
> [  139.167161]  [<ffffffff8021de9f>] show_mem+0xbf/0x170
> [  139.167225]  [<ffffffff8021dea1>] show_mem+0xc1/0x170
> [  139.167285]  [<ffffffff8021dec0>] show_mem+0xe0/0x170
> [  139.167345]  [<ffffffff8021dec2>] show_mem+0xe2/0x170
> [  139.167407]  [<ffffffff8021ded7>] show_mem+0xf7/0x170
> [  139.167467]  [<ffffffff8021ded9>] show_mem+0xf9/0x170
> [  139.167528]  [<ffffffff8021dfc0>] __add_pages+0x40/0xd0
> [  139.167588]  [<ffffffff8021e089>] vmalloc_sync_all+0x39/0x170
> [  139.202919]  [<ffffffff8049ee60>] xfrm_state_netlink+0x0/0xa0
> [  139.202993]  [<ffffffff8049ee69>] xfrm_state_netlink+0x9/0xa0
> [  139.203055]  [<ffffffff8049ee86>] xfrm_state_netlink+0x26/0xa0
> [  139.203116]  [<ffffffff8049ee8f>] xfrm_state_netlink+0x2f/0xa0
> [  139.203187]  [<ffffffff8049f182>] xfrm_send_state_notify+0x282/0x6c0
> [  139.203250]  [<ffffffff8049f195>] xfrm_send_state_notify+0x295/0x6c0
> [  139.203329]  [<ffffffff8022ad33>] find_busiest_group+0x5d3/0x6f0
> [  139.203389]  [<ffffffff8022ad3c>] find_busiest_group+0x5dc/0x6f0
> [  139.203457]  [<ffffffff8049f23c>] xfrm_send_state_notify+0x33c/0x6c0
> [  139.203519]  [<ffffffff8049f243>] xfrm_send_state_notify+0x343/0x6c0
> [  139.203582]  [<ffffffff8022ae75>] migration_thread+0x25/0x2e0
> [  139.203644]  [<ffffffff8022ae7e>] migration_thread+0x2e/0x2e0
> [  139.203707]  [<ffffffff8022aea0>] migration_thread+0x50/0x2e0
> [  139.203767]  [<ffffffff8022aea9>] migration_thread+0x59/0x2e0
> [  139.234201] Unable to handle kernel paging request at ffffffff82800000 RIP:
> [  139.234255]  [<ffffffff8020b491>] show_trace+0x311/0x380
> [  139.234412] PGD 203027 PUD 205027 PMD 0
> [  139.234574] Oops: 0000 [2] SMP
> [  139.234699] CPU 15
> [  139.234789] Modules linked in:
> [  139.234880] Pid: 0, comm: swapper Not tainted 2.6.18-rc3rannaud-gd94a0415 #36
> [  139.234942] RIP: 0010:[<ffffffff8020b491>]  [<ffffffff8020b491>] show_trace+0x311/0x380
> [  139.235057] RSP: 0018:ffff8102238e7488  EFLAGS: 00010002
> [  139.235117] RAX: 0000000000000000 RBX: 0000000000000000 RCX: 0000000000000001
> [  139.235180] RDX: 0000000000000000 RSI: 0000000000000001 RDI: ffffffff805b9940
> [  139.235243] RBP: ffff8102238e7578 R08: 0000000000000002 R09: ffffffff80256580
> [  139.235306] R10: ffffffffffffffff R11: 0000000000000000 R12: ffffffff827ffffe
> [  139.235368] R13: 0000000000000000 R14: 000000000000000f R15: ffffffff8097f000
> [  139.235431] FS:  00000000005a6860(0000) GS:ffff810223894ac0(0000) knlGS:0000000000000000
> [  139.235509] CS:  0010 DS: 0018 ES: 0018 CR0: 000000008005003b
> [  139.235569] CR2: ffffffff82800000 CR3: 00000002217c0000 CR4: 00000000000006e0
> [  139.235634] Process swapper (pid: 0, threadinfo ffff8102238e2000, task ffff81022389b100)
> [  139.235711] Stack:  00000000238e3fc0 0000000000000000 0000000000000000 0000000000000000
> [  139.235970]  0000000000000000 0000000000000000 0000000000000000 0000000000000d07
> [  139.236187]  0000000000000001 0000000000000000 0000000000000001 0000000000000001
> [  139.236358] Call Trace:
> [  139.236476]  [<ffffffff8020b5fe>] _show_stack+0xfe/0x110
> [  139.236545]  [<ffffffff8020b69e>] show_registers+0x8e/0x110
> [  139.236616]  [<ffffffff804ad11a>] __die+0x9a/0xe0
> [  139.236684]  [<ffffffff804aee07>] do_page_fault+0x837/0x960
> [  139.236785]  [<ffffffff8020a8d1>] error_exit+0x0/0x96
> [  139.236852]  [<ffffffff8020b491>] show_trace+0x311/0x380
> [  139.236923]  [<ffffffff8020b745>] dump_stack+0x15/0x20
> [  139.236995]  [<ffffffff8024bc1d>] print_infinite_recursion_bug+0x3d/0x50
> [  139.237133]  [<ffffffff8024bd2f>] find_usage_backwards+0x2f/0xd0
> [  139.237259]  [<ffffffff8024bd93>] find_usage_backwards+0x93/0xd0
> [  139.237384]  [<ffffffff8024bd93>] find_usage_backwards+0x93/0xd0
> [  139.237510]  [<ffffffff8024bd93>] find_usage_backwards+0x93/0xd0
> [  139.237637]  [<ffffffff8024bd93>] find_usage_backwards+0x93/0xd0
> [  139.237763]  [<ffffffff8024bd93>] find_usage_backwards+0x93/0xd0
> [  139.237889]  [<ffffffff8024bd93>] find_usage_backwards+0x93/0xd0
> [  139.238015]  [<ffffffff8024bd93>] find_usage_backwards+0x93/0xd0
> [  139.238140]  [<ffffffff8024bd93>] find_usage_backwards+0x93/0xd0
> [  139.238266]  [<ffffffff8024bd93>] find_usage_backwards+0x93/0xd0
> [  139.238391]  [<ffffffff8024bd93>] find_usage_backwards+0x93/0xd0
> [  139.238517]  [<ffffffff8024bd93>] find_usage_backwards+0x93/0xd0
> [  139.238642]  [<ffffffff8024bd93>] find_usage_backwards+0x93/0xd0
> [  139.238768]  [<ffffffff8024bd93>] find_usage_backwards+0x93/0xd0
> [  139.238896]  [<ffffffff8024bd93>] find_usage_backwards+0x93/0xd0
> [  139.239022]  [<ffffffff8024bd93>] find_usage_backwards+0x93/0xd0
> [  139.239147]  [<ffffffff8024bd93>] find_usage_backwards+0x93/0xd0
> [  139.239273]  [<ffffffff8024bd93>] find_usage_backwards+0x93/0xd0
> [  139.239399]  [<ffffffff8024bd93>] find_usage_backwards+0x93/0xd0
> [  139.239527]  [<ffffffff8024bd93>] find_usage_backwards+0x93/0xd0
> [  139.239653]  [<ffffffff8024bd93>] find_usage_backwards+0x93/0xd0
> [  139.239780]  [<ffffffff8024c740>] check_usage+0x40/0x2b0
> [  139.239907]  [<ffffffff8024e010>] __lock_acquire+0xa50/0xd20
> [  139.240034]  [<ffffffff8024e66b>] lock_acquire+0x8b/0xc0
> [  139.240161]  [<ffffffff804ac065>] _spin_lock+0x25/0x40
> [  139.240293]  [<ffffffff80227d30>] double_rq_lock+0x40/0x50
> [  139.240392]  [<ffffffff8022ceca>] rebalance_tick+0x19a/0x340
> [  139.240493]  [<ffffffff8022d0ef>] scheduler_tick+0x7f/0x390
> [  139.240595]  [<ffffffff8023afe3>] update_process_times+0x73/0x90
> [  139.240707]  [<ffffffff8021636b>] smp_local_timer_interrupt+0x2b/0x60
> [  139.240795]  [<ffffffff80216b28>] smp_apic_timer_interrupt+0x58/0x70
> [  139.240880]  [<ffffffff8020a76e>] apic_timer_interrupt+0x6a/0x70
> [  139.240947]  [<ffffffff802086b2>] default_idle+0x42/0x80
> [  139.241011]  [<ffffffff8020875a>] cpu_idle+0x6a/0x90
> [  139.241079]  [<ffffffff8094d94c>] start_secondary+0x4fc/0x510
> [  139.241160]  <IRQ> [<ffffffff8020b5fe>] _show_stack+0xfe/0x110
> [  139.241260]  [<ffffffff8020b69e>] show_registers+0x8e/0x110
> [  139.241321]  [<ffffffff804ad11a>] __die+0x9a/0xe0
> [  139.241381]  [<ffffffff804aee07>] do_page_fault+0x837/0x960
> [  139.241442]  [<ffffffff80231f97>] printk+0x67/0x70
> [  139.241501]  [<ffffffff8022aea9>] migration_thread+0x59/0x2e0
> [  139.241564]  [<ffffffff80256af0>] kallsyms_lookup+0xd0/0x1f0
> [  139.241626]  [<ffffffff8020a8d1>] error_exit+0x0/0x96
> [  139.241687]  [<ffffffff80256580>] module_text_address+0x20/0x50
> [  139.241748]  [<ffffffff8020b491>] show_trace+0x311/0x380
> [  139.241812]  [<ffffffff8020b745>] dump_stack+0x15/0x20
> [  139.241873]  [<ffffffff8024bd93>] find_usage_backwards+0x93/0xd0
> [  139.241934]  [<ffffffff8024bc1d>] print_infinite_recursion_bug+0x3d/0x50
> [  139.241999]  [<ffffffff8024bd2f>] find_usage_backwards+0x2f/0xd0
> [  139.242061]  [<ffffffff8024bd93>] find_usage_backwards+0x93/0xd0
> [  139.242123]  [<ffffffff8024bd93>] find_usage_backwards+0x93/0xd0
> [  139.242185]  [<ffffffff8024bd93>] find_usage_backwards+0x93/0xd0
> [  139.242247]  [<ffffffff8024bd93>] find_usage_backwards+0x93/0xd0
> [  139.242310]  [<ffffffff8024bd93>] find_usage_backwards+0x93/0xd0
> [  139.242373]  [<ffffffff8024bd93>] find_usage_backwards+0x93/0xd0
> [  139.242434]  [<ffffffff8024bd93>] find_usage_backwards+0x93/0xd0
> [  139.242497]  [<ffffffff8024bd93>] find_usage_backwards+0x93/0xd0
> [  139.242558]  [<ffffffff8024bd93>] find_usage_backwards+0x93/0xd0
> [  139.242620]  [<ffffffff8024bd93>] find_usage_backwards+0x93/0xd0
> [  139.242681]  [<ffffffff8024bd93>] find_usage_backwards+0x93/0xd0
> [  139.242742]  [<ffffffff8024bd93>] find_usage_backwards+0x93/0xd0
> [  139.242805]  [<ffffffff8024bd93>] find_usage_backwards+0x93/0xd0
> [  139.242867]  [<ffffffff8024bd93>] find_usage_backwards+0x93/0xd0
> [  139.242930]  [<ffffffff8024bd93>] find_usage_backwards+0x93/0xd0
> [  139.242992]  [<ffffffff8024bd93>] find_usage_backwards+0x93/0xd0
> [  139.243054]  [<ffffffff8024bd93>] find_usage_backwards+0x93/0xd0
> [  139.243116]  [<ffffffff8024bd93>] find_usage_backwards+0x93/0xd0
> [  139.243178]  [<ffffffff8024bd93>] find_usage_backwards+0x93/0xd0
> [  139.243241]  [<ffffffff8024bd93>] find_usage_backwards+0x93/0xd0
> [  139.243304]  [<ffffffff8024c740>] check_usage+0x40/0x2b0
> [  139.243365]  [<ffffffff8024e010>] __lock_acquire+0xa50/0xd20
> [  139.243427]  [<ffffffff80227d30>] double_rq_lock+0x40/0x50
> [  139.243488]  [<ffffffff8024e66b>] lock_acquire+0x8b/0xc0
> [  139.243549]  [<ffffffff80227d30>] double_rq_lock+0x40/0x50
> [  139.243610]  [<ffffffff804ac065>] _spin_lock+0x25/0x40
> [  139.243670]  [<ffffffff80227d30>] double_rq_lock+0x40/0x50
> [  139.243730]  [<ffffffff8022ceca>] rebalance_tick+0x19a/0x340
> [  139.243792]  [<ffffffff804ac54b>] _spin_unlock_irq+0x2b/0x40
> [  139.243855]  [<ffffffff8022d0ef>] scheduler_tick+0x7f/0x390
> [  139.243916]  [<ffffffff8023afe3>] update_process_times+0x73/0x90
> [  139.245151]  [<ffffffff8021636b>] smp_local_timer_interrupt+0x2b/0x60
> [  139.245214]  [<ffffffff80216b28>] smp_apic_timer_interrupt+0x58/0x70
> [  139.245277]  [<ffffffff802086b0>] default_idle+0x40/0x80
> [  139.245336]  [<ffffffff80208670>] default_idle+0x0/0x80
> [  139.245397]  [<ffffffff8020a76e>] apic_timer_interrupt+0x6a/0x70
> [  139.245458]  <EOI> [<ffffffff8045c7ff>] ipq_kill+0x5f/0xa0
> [  139.559005]  [<ffffffff8021ed29>] flush_kernel_map+0x39/0x40
> [  139.559075]  [<ffffffff8021ecc0>] search_extable+0x40/0x70
> [  139.571503]  [<ffffffff8020efeb>] show_cpuinfo+0x18b/0x360
> [  139.571572]  [<ffffffff8020efef>] show_cpuinfo+0x18f/0x360
> [  139.571635]  [<ffffffff8020f0e6>] show_cpuinfo+0x286/0x360
> [  139.571696]  [<ffffffff8020f0ed>] show_cpuinfo+0x28d/0x360
> [  139.571965]  [<ffffffff8021de9f>] show_mem+0xbf/0x170
> [  139.572024]  [<ffffffff8021dea1>] show_mem+0xc1/0x170
> [  139.572084]  [<ffffffff8021dec0>] show_mem+0xe0/0x170
> [  139.572144]  [<ffffffff8021dec2>] show_mem+0xe2/0x170
> [  139.572204]  [<ffffffff8021ded7>] show_mem+0xf7/0x170
> [  139.572263]  [<ffffffff8021ded9>] show_mem+0xf9/0x170
> [  139.572325]  [<ffffffff8021dfc0>] __add_pages+0x40/0xd0
> [  139.572386]  [<ffffffff8021e089>] vmalloc_sync_all+0x39/0x170
> [  139.607781]  [<ffffffff8049ee60>] xfrm_state_netlink+0x0/0xa0
> [  139.607850]  [<ffffffff8049ee69>] xfrm_state_netlink+0x9/0xa0
> [  139.607912]  [<ffffffff8049ee86>] xfrm_state_netlink+0x26/0xa0
> [  139.607973]  [<ffffffff8049ee8f>] xfrm_state_netlink+0x2f/0xa0
> [  139.608044]  [<ffffffff8049f182>] xfrm_send_state_notify+0x282/0x6c0
> [  139.608105]  [<ffffffff8049f195>] xfrm_send_state_notify+0x295/0x6c0
> [  139.608185]  [<ffffffff8022ad33>] find_busiest_group+0x5d3/0x6f0
> [  139.608250]  [<ffffffff8022ad3c>] find_busiest_group+0x5dc/0x6f0
> [  139.608320]  [<ffffffff8049f23c>] xfrm_send_state_notify+0x33c/0x6c0
> [  139.608382]  [<ffffffff8049f243>] xfrm_send_state_notify+0x343/0x6c0
> [  139.608446]  [<ffffffff8022ae75>] migration_thread+0x25/0x2e0
> [  139.608506]  [<ffffffff8022ae7e>] migration_thread+0x2e/0x2e0
> [  139.608569]  [<ffffffff8022aea0>] migration_thread+0x50/0x2e0
> [  139.608630]  [<ffffffff8022aea9>] migration_thread+0x59/0x2e0
> [  139.639155] Unable to handle kernel paging request at ffffffff82800000 RIP:
> [  139.639209]  [<ffffffff8020b491>] show_trace+0x311/0x380
> [  139.639366] PGD 203027 PUD 205027 PMD 0
> [  139.639531] Oops: 0000 [3] SMP
> [  139.639657] CPU 15
> [  139.639745] Modules linked in:
> [  139.639836] Pid: 0, comm: swapper Not tainted 2.6.18-rc3rannaud-gd94a0415 #36
> [  139.639899] RIP: 0010:[<ffffffff8020b491>]  [<ffffffff8020b491>] show_trace+0x311/0x380
> [  139.572325]  [<ffffffff8021dfc0>] __add_pages+0x40/0xd0
> [  139.572386]  [<ffffffff8021e089>] vmalloc_sync_all+0x39/0x170
> [  139.607781]  [<ffffffff8049ee60>] xfrm_state_netlink+0x0/0xa0
> [  139.607850]  [<ffffffff8049ee69>] xfrm_state_netlink+0x9/0xa0
> [  139.607912]  [<ffffffff8049ee86>] xfrm_state_netlink+0x26/0xa0
> [  139.607973]  [<ffffffff8049ee8f>] xfrm_state_netlink+0x2f/0xa0
> [  139.608044]  [<ffffffff8049f182>] xfrm_send_state_notify+0x282/0x6c0
> [  139.608105]  [<ffffffff8049f195>] xfrm_send_state_notify+0x295/0x6c0
> [  139.608185]  [<ffffffff8022ad33>] find_busiest_group+0x5d3/0x6f0
> [  139.608250]  [<ffffffff8022ad3c>] find_busiest_group+0x5dc/0x6f0
> [  139.608320]  [<ffffffff8049f23c>] xfrm_send_state_notify+0x33c/0x6c0
> [  139.608382]  [<ffffffff8049f243>] xfrm_send_state_notify+0x343/0x6c0
> [  139.608446]  [<ffffffff8022ae75>] migration_thread+0x25/0x2e0
> [  139.608506]  [<ffffffff8022ae7e>] migration_thread+0x2e/0x2e0
> [  139.608569]  [<ffffffff8022aea0>] migration_thread+0x50/0x2e0
> [  139.608630]  [<ffffffff8022aea9>] migration_thread+0x59/0x2e0
> [  139.639155] Unable to handle kernel paging request at ffffffff82800000 RIP:
> [  139.639209]  [<ffffffff8020b491>] show_trace+0x311/0x380
> [  139.639366] PGD 203027 PUD 205027 PMD 0
> [  139.639531] Oops: 0000 [3] SMP
> [  139.639657] CPU 15
> [  139.639745] Modules linked in:
> [  139.639836] Pid: 0, comm: swapper Not tainted 2.6.18-rc3rannaud-gd94a0415
> #36
> [  139.639899] RIP: 0010:[<ffffffff8020b491>]  [<ffffffff8020b491>]
> show_trace+0x311/0x380
> [  139.640016] RSP: 0018:ffff8102238e70f8  EFLAGS: 00010002
> [  139.640075] RAX: 0000000000000000 RBX: 0000000000000000 RCX:
> 0000000000000001
> [  139.640138] RDX: 0000000000000000 RSI: 0000000000000001 RDI:
> ffffffff805b9940
> [  139.640202] RBP: ffff8102238e71e8 R08: 0000000000000002 R09:
> ffffffff80256580
> [  139.640265] R10: ffffffffffffffff R11: 0000000000000000 R12:
> ffffffff827ffffe
> [  139.640329] R13: 0000000000000000 R14: 000000000000000f R15:
> ffffffff8097f000
> [  139.640392] FS:  00000000005a6860(0000) GS:ffff810223894ac0(0000)
> knlGS:0000000000000000
> [  139.640470] CS:  0010 DS: 0018 ES: 0018 CR0: 000000008005003b
> [  139.640532] CR2: ffffffff82800000 CR3: 00000002217c0000 CR4:
> 00000000000006e0
> [  139.640596] Process swapper (pid: 0, threadinfo ffff8102238e2000,
> task ffff81022389b100)
> [  139.640674] Stack:  00000000238e3fc0 0000000000000000
> 0000000000000000 0000000000000000
> [  139.640933]  0000000000000000 0000000000000000 0000000000000000
> 0000000000000d07
> [  139.641151]  0000000000000001 0000000000000000 0000000000000001
> 0000000000000001
> [  139.641321] Call Trace:
> [  139.641438]  [<ffffffff8020b5fe>] _show_stack+0xfe/0x110
> [  139.641508]  [<ffffffff8020b69e>] show_registers+0x8e/0x110
> [  139.641579]  [<ffffffff804ad11a>] __die+0x9a/0xe0
> [  139.641648]  [<ffffffff804aee07>] do_page_fault+0x837/0x960
> [  139.641750]  [<ffffffff8020a8d1>] error_exit+0x0/0x96
> [  139.641817]  [<ffffffff8020b491>] show_trace+0x311/0x380
> [  139.641886]  [<ffffffff8020b5fe>] _show_stack+0xfe/0x110
> [  139.641955]  [<ffffffff8020b69e>] show_registers+0x8e/0x110
> [  139.642025]  [<ffffffff804ad11a>] __die+0x9a/0xe0
> [  139.642093]  [<ffffffff804aee07>] do_page_fault+0x837/0x960
> [  139.642186]  [<ffffffff8020a8d1>] error_exit+0x0/0x96
> [  139.642252]  [<ffffffff8020b491>] show_trace+0x311/0x380
> [  139.642322]  [<ffffffff8020b745>] dump_stack+0x15/0x20
> [  139.642395]  [<ffffffff8024bc1d>] print_infinite_recursion_bug+0x3d/0x50
> [  139.642534]  [<ffffffff8024bd2f>] find_usage_backwards+0x2f/0xd0
> [  139.642662]  [<ffffffff8024bd93>] find_usage_backwards+0x93/0xd0
> [  139.642789]  [<ffffffff8024bd93>] find_usage_backwards+0x93/0xd0
> [  139.642917]  [<ffffffff8024bd93>] find_usage_backwards+0x93/0xd0
> [  139.643044]  [<ffffffff8024bd93>] find_usage_backwards+0x93/0xd0
> [  139.643172]  [<ffffffff8024bd93>] find_usage_backwards+0x93/0xd0
> [  139.643300]  [<ffffffff8024bd93>] find_usage_backwards+0x93/0xd0
> [  139.643429]  [<ffffffff8024bd93>] find_usage_backwards+0x93/0xd0
> [  139.643557]  [<ffffffff8024bd93>] find_usage_backwards+0x93/0xd0
> [  139.643685]  [<ffffffff8024bd93>] find_usage_backwards+0x93/0xd0
> [  139.643812]  [<ffffffff8024bd93>] find_usage_backwards+0x93/0xd0
> [  139.643940]  [<ffffffff8024bd93>] find_usage_backwards+0x93/0xd0
> [  139.644067]  [<ffffffff8024bd93>] find_usage_backwards+0x93/0xd0
> [  139.644194]  [<ffffffff8024bd93>] find_usage_backwards+0x93/0xd0
> [  139.644321]  [<ffffffff8024bd93>] find_usage_backwards+0x93/0xd0
> [  139.644450]  [<ffffffff8024bd93>] find_usage_backwards+0x93/0xd0
> [  139.644577]  [<ffffffff8024bd93>] find_usage_backwards+0x93/0xd0
> [  139.644705]  [<ffffffff8024bd93>] find_usage_backwards+0x93/0xd0
> [  139.644832]  [<ffffffff8024bd93>] find_usage_backwards+0x93/0xd0
> ---- (a bit more on console)
> 
> 
> ---- netconsole for v2.6.18 with numa=noacpi
> [  320.125317] BUG: warning at
> kernel/lockdep.c:565/print_infinite_recursion_bug()
> [  320.125380]
> [  320.125381] Call Trace:
> [  320.125550]  [<ffffffff8100b22d>] show_trace+0xad/0x3b0
> [  320.125604]  [<ffffffff8100b775>] dump_stack+0x15/0x20
> [  320.125659]  [<ffffffff8104c23d>] print_infinite_recursion_bug+0x3d/0x50
> [  320.125771]  [<ffffffff8104c41f>] check_noncircular+0x2f/0xe0
> [  320.125880]  [<ffffffff8104c473>] check_noncircular+0x83/0xe0
> [  320.125993]  [<ffffffff8104c473>] check_noncircular+0x83/0xe0
> [  320.126103]  [<ffffffff8104c473>] check_noncircular+0x83/0xe0
> [  320.126213]  [<ffffffff8104c473>] check_noncircular+0x83/0xe0
> [  320.126336]  [<ffffffff8104c473>] check_noncircular+0x83/0xe0
> [  320.126459]  [<ffffffff8104c473>] check_noncircular+0x83/0xe0
> [  320.126582]  [<ffffffff8104c473>] check_noncircular+0x83/0xe0
> [  320.126705]  [<ffffffff8104c473>] check_noncircular+0x83/0xe0
> [  320.126828]  [<ffffffff8104c473>] check_noncircular+0x83/0xe0
> [  320.126953]  [<ffffffff8104c473>] check_noncircular+0x83/0xe0
> [  320.127078]  [<ffffffff8104c473>] check_noncircular+0x83/0xe0
> [  320.127201]  [<ffffffff8104c473>] check_noncircular+0x83/0xe0
> [  320.127325]  [<ffffffff8104c473>] check_noncircular+0x83/0xe0
> [  320.127448]  [<ffffffff8104c473>] check_noncircular+0x83/0xe0
> [  320.127571]  [<ffffffff8104c473>] check_noncircular+0x83/0xe0
> [  320.127694]  [<ffffffff8104c473>] check_noncircular+0x83/0xe0
> [  320.127816]  [<ffffffff8104c473>] check_noncircular+0x83/0xe0
> [  320.127940]  [<ffffffff8104c473>] check_noncircular+0x83/0xe0
> [  320.128063]  [<ffffffff8104c473>] check_noncircular+0x83/0xe0
> [  320.128186]  [<ffffffff8104c473>] check_noncircular+0x83/0xe0
> [  320.128309]  [<ffffffff8104e5da>] __lock_acquire+0x9fa/0xd20
> [  320.128432]  [<ffffffff8104ec8b>] lock_acquire+0x8b/0xc0
> [  320.128559]  [<ffffffff812cadf7>] __mutex_lock_slowpath+0xd7/0x250
> [  320.128681]  [<ffffffff812caf95>] mutex_lock+0x25/0x30
> [  320.128799]  [<ffffffff81115613>] elevator_exit+0x23/0x60
> [  320.129066]  [<ffffffff811180f5>] blk_cleanup_queue+0x45/0x60
> [  320.129319]  [<ffffffff811e5fd9>] scsi_free_queue+0x9/0x10
> [  320.129717]  [<ffffffff811eae86>]
> scsi_device_dev_release_usercontext+0x106/0x160
> [  320.130119]  [<ffffffff81043e3b>] execute_in_process_context+0x2b/0x70
> [  320.130237]  [<ffffffff811e9dfa>] scsi_device_dev_release+0x1a/0x20
> [  320.130617]  [<ffffffff8119e84c>] device_release+0x1c/0x70
> [  320.130959]  [<ffffffff811270e3>] kobject_cleanup+0x63/0xa0
> [  320.131220]  [<ffffffff8112712d>] kobject_release+0xd/0x10
> [  320.131481]  [<ffffffff811276ef>] kref_put+0x6f/0x90
> [  320.131741]  [<ffffffff81126979>] kobject_put+0x19/0x20
> [  320.131999]  [<ffffffff8119eb45>] put_device+0x15/0x20
> [  320.132339]  [<ffffffff811e8f68>] scsi_probe_and_add_lun+0xb58/0xba0
> [  320.132721]  [<ffffffff811e9082>] __scsi_scan_target+0xd2/0x690
> [  320.133102]  [<ffffffff811e9695>] scsi_scan_channel+0x55/0xa0
> [  320.133482]  [<ffffffff811e97bd>] scsi_scan_host_selected+0xdd/0x130
> [  320.133865]  [<ffffffff811e9825>] scsi_scan_host+0x15/0x20
> [  320.134247]  [<ffffffff811f00f0>] megaraid_probe_one+0x1110/0x11c0
> [  320.134634]  [<ffffffff81136e43>] pci_device_probe+0xf3/0x170
> [  320.134908]  [<ffffffff811a0fc7>] driver_probe_device+0x67/0xe0
> [  320.135251]  [<ffffffff811a1177>] __driver_attach+0x97/0xf0
> [  320.135593]  [<ffffffff811a014f>] bus_for_each_dev+0x4f/0x80
> [  320.135936]  [<ffffffff811a0e1c>] driver_attach+0x1c/0x20
> [  320.136279]  [<ffffffff811a0598>] bus_add_driver+0x88/0x180
> [  320.136621]  [<ffffffff811a16c3>] driver_register+0x93/0xa0
> [  320.136965]  [<ffffffff811368a3>] __pci_register_driver+0x63/0x90
> [  320.137242]  [<ffffffff818a3290>] megaraid_init+0x70/0xa0
> [  320.137621]  [<ffffffff810071c4>] init+0x164/0x350
> [  320.137679]  [<ffffffff8100aaa0>] child_rip+0xa/0x12
> [  320.137741]
> [  320.137742] -> #20 (&rq->rq_lock_key#16){++..}:
> [  320.137977]        [<ffffffff8104ec8a>] lock_acquire+0x8a/0xc0
> [  320.138296]        [<ffffffff812cc404>] _spin_lock+0x24/0x40
> [  320.138615]        [<ffffffff8102860f>] double_rq_lock+0x3f/0x50
> [  320.138934]        [<ffffffff8102d789>] rebalance_tick+0x199/0x340
> [  320.139254]        [<ffffffff8102d9ae>] scheduler_tick+0x7e/0x390
> [  320.139572]        [<ffffffff8103b7a2>] update_process_times+0x72/0x90
> [  320.139894]        [<ffffffff8101639a>] smp_local_timer_interrupt+0x2a/0x60
> [  320.140215]        [<ffffffff81016b57>] smp_apic_timer_interrupt+0x57/0x70
> [  320.140535]        [<ffffffff8100a76e>] apic_timer_interrupt+0x6a/0x70
> [  320.140854]
> [  320.140855] -> #19 (&rq->rq_lock_key#15){++..}:
> [  320.141088]        [<ffffffff8104ec8a>] lock_acquire+0x8a/0xc0
> [  320.141405]        [<ffffffff812cc404>] _spin_lock+0x24/0x40
> [  320.141722]        [<ffffffff810285fa>] double_rq_lock+0x2a/0x50
> [  320.142040]        [<ffffffff8102b93a>] migration_thread+0x22a/0x2e0
> [  320.142359]        [<ffffffff81047589>] kthread+0xd9/0x110
> [  320.142676]        [<ffffffff8100aa9f>] child_rip+0x9/0x12
> [  320.142992]
> [  320.142993] -> #18 (&rq->rq_lock_key#14){++..}:
> [  320.143226]        [<ffffffff8104ec8a>] lock_acquire+0x8a/0xc0
> [  320.143543]        [<ffffffff812cc404>] _spin_lock+0x24/0x40
> [  320.143863]        [<ffffffff810285fa>] double_rq_lock+0x2a/0x50
> [  320.144182]        [<ffffffff8102b93a>] migration_thread+0x22a/0x2e0
> [  320.144501]        [<ffffffff81047589>] kthread+0xd9/0x110
> [  320.144818]        [<ffffffff8100aa9f>] child_rip+0x9/0x12
> [  320.145135]
> [  320.145135] -> #17 (&rq->rq_lock_key#13){++..}:
> [  320.145369]        [<ffffffff8104ec8a>] lock_acquire+0x8a/0xc0
> [  320.145686]        [<ffffffff812cc404>] _spin_lock+0x24/0x40
> [  320.146004]        [<ffffffff810285fa>] double_rq_lock+0x2a/0x50
> [  320.146323]        [<ffffffff8102b93a>] migration_thread+0x22a/0x2e0
> [  320.146642]        [<ffffffff81047589>] kthread+0xd9/0x110
> [  320.146959]        [<ffffffff8100aa9f>] child_rip+0x9/0x12
> [  320.147275]
> [  320.147276] -> #16 (&rq->rq_lock_key#12){++..}:
> [  320.147508]        [<ffffffff8104ec8a>] lock_acquire+0x8a/0xc0
> [  320.147826]        [<ffffffff812cc404>] _spin_lock+0x24/0x40
> [  320.148141]        [<ffffffff810285fa>] double_rq_lock+0x2a/0x50
> [  320.148460]        [<ffffffff8102b93a>] migration_thread+0x22a/0x2e0
> [  320.148778]        [<ffffffff81047589>] kthread+0xd9/0x110
> [  320.149096]        [<ffffffff8100aa9f>] child_rip+0x9/0x12
> [  320.149411]
> [  320.149412] -> #15 (&rq->rq_lock_key#11){++..}:
> [  320.149645]        [<ffffffff8104ec8a>] lock_acquire+0x8a/0xc0
> [  320.149962]        [<ffffffff812cc404>] _spin_lock+0x24/0x40
> [  320.150280]        [<ffffffff810285fa>] double_rq_lock+0x2a/0x50
> [  320.150598]        [<ffffffff8102b93a>] migration_thread+0x22a/0x2e0
> [  320.150917]        [<ffffffff81047589>] kthread+0xd9/0x110
> [  320.151235]        [<ffffffff8100aa9f>] child_rip+0x9/0x12
> [  320.151551]
> [  320.151552] -> #14 (&rq->rq_lock_key#10){++..}:
> [  320.151785]        [<ffffffff8104ec8a>] lock_acquire+0x8a/0xc0
> [  320.152102]        [<ffffffff812cc404>] _spin_lock+0x24/0x40
> [  320.152421]        [<ffffffff810285fa>] double_rq_lock+0x2a/0x50
> [  320.152741]        [<ffffffff8102b93a>] migration_thread+0x22a/0x2e0
> [  320.153060]
> -----
> (there was slightly more info on the local console, but it locked up)
> 
> 
> 
> ----- /proc/cpuinfo
> processor       : 15
> vendor_id       : AuthenticAMD
> cpu family      : 15
> model           : 33
> model name      : Dual Core AMD Opteron(tm) Processor 880
> stepping        : 2
> cpu MHz         : 2411.123
> cache size      : 1024 KB
> physical id     : 7
> siblings        : 2
> core id         : 1
> cpu cores       : 2
> fpu             : yes
> fpu_exception   : yes
> cpuid level     : 1
> wp              : yes
> flags           : fpu vme de pse tsc msr pae mce cx8 apic sep mtrr pge
> mca cmov pat pse36 clflush mmx fxsr sse sse2 ht syscall nx mmxext
> fxsr_opt lm 3dnowext 3dnow pni lahf_lm cmp_legacy
> bogomips        : 4822.64
> TLB size        : 1024 4K pages
> clflush size    : 64
> cache_alignment : 64
> address sizes   : 40 bits physical, 48 bits virtual
> power management: ts fid vid ttp
> --
> 
> 
> 
> ---- lspci -vvv
> http://engm.ath.cx/liw64-lspci.txt
> ----
> 
