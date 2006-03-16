Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750871AbWCPP3S@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750871AbWCPP3S (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 16 Mar 2006 10:29:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751979AbWCPP3S
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 16 Mar 2006 10:29:18 -0500
Received: from e4.ny.us.ibm.com ([32.97.182.144]:21661 "EHLO e4.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S1750871AbWCPP3R (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 16 Mar 2006 10:29:17 -0500
Date: Thu, 16 Mar 2006 20:58:48 +0530
From: Srivatsa Vaddagiri <vatsa@in.ibm.com>
To: linux-kernel@vger.kernel.org
Cc: pj@sgi.com
Subject: cpu_exclusive feature of cpuset broken?
Message-ID: <20060316152848.GA6548@in.ibm.com>
Reply-To: vatsa@in.ibm.com
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,
	I was testing cpuset in 2.6.16-rc6 and found that I cant create
exclusive cpusets. As soon as I make a cpuset exclusive, it locks up.
Basically here's what I did to see the lockup:

	# mkdir /dev/cpuset
	# mount -t cpuset none /dev/cpuset
	# cd /dev/cpuset
	# mkdir a
	# /bin/echo 7 > cpus
	# /bin/echo 1 > cpu_exclusive
		<System locks up here>

I saw this problem on two machines (4way x86-64 box and another 8way x86 box)
but didnt see the lockup on another 4way x86 box. I am puzzled. Before
I start digging further, wanted to check if anyone else has seen the
problem.

When the lockup happened on x86-64 box, NMI watchdog caught it and
spit these messages:



llm17:~ # NMI Watchdog detected LOCKUP on CPU 2
CPU 2 
Modules linked in:
Pid: 0, comm: swapper Not tainted 2.6.16-rc6 #5
RIP: 0010:[<ffffffff80128fcb>] <ffffffff80128fcb>{find_busiest_group+316}
RSP: 0018:ffff810237ce3e80  EFLAGS: 00000046
RAX: 0000000000000000 RBX: 0000000000000003 RCX: 0000000000000000
RDX: 0000000000000000 RSI: ffff810008c8e400 RDI: ffff810008c876e0
RBP: ffff810237ce3ef8 R08: 0000000000000000 R09: ffff810008c876e0
R10: 0000000000000000 R11: 0000000000000000 R12: ffffffff80588338
R13: 0000000000000000 R14: 0000000000000001 R15: 0000000000000000
FS:  0000000000000000(0000) GS:ffff810237c772c0(0000) knlGS:0000000000000000
CS:  0010 DS: 0018 ES: 0018 CR0: 000000008005003b
CR2: 00002ad5fdb7b190 CR3: 0000000000101000 CR4: 00000000000006e0
Process swapper (pid: 0, threadinfo ffff810237cdc000, task ffff810237c99180)
Stack: 0000000000000000 0000000000000000 ffff810008c87660 0000000000000000 
       ffff810237ce3f38 ffff810237ce3f30 0000000230e97d08 ffffffff80588320 
       0000000129da210c 0000000000000000 
Call Trace: <IRQ> <ffffffff8012c2af>{rebalance_tick+340}
       <ffffffff80139bec>{update_process_times+92} <ffffffff80118567>{smp_local_timer_interrupt+35}
       <ffffffff80118bfd>{smp_apic_timer_interrupt+65} <ffffffff801098b6>{mwait_idle+0}
       <ffffffff8010b382>{apic_timer_interrupt+98} <EOI> <ffffffff801098ec>{mwait_idle+54}
       <ffffffff80109893>{cpu_idle+151} <ffffffff80118383>{start_secondary+1120}

Code: 48 0f 46 d1 49 01 d5 49 8b 54 24 08 8d 4b 01 48 d3 ea b9 20 
console shuts up ...
 NMI Watchdog detected LOCKUP on CPU 0
CPU 0 
Modules linked in:
Pid: 0, comm: swapper Not tainted 2.6.16-rc6 #5
RIP: 0010:[<ffffffff80128fee>] <ffffffff80128fee>{find_busiest_group+351}
RSP: 0018:ffffffff80572e80  EFLAGS: 00000046
RAX: 000000000000001c RBX: 0000000000000003 RCX: 0000000000000020
RDX: 0000000000000000 RSI: ffff810008c8e400 RDI: ffff810008c776e0
RBP: ffffffff80572ef8 R08: 0000000000000000 R09: ffff810008c776e0
R10: 0000000000000000 R11: 0000000000000000 R12: ffffffff80588338
R13: 0000000000000000 R14: 0000000000000001 R15: 0000000000000000
FS:  0000000000000000(0000) GS:ffffffff805fc000(0000) knlGS:0000000000000000
CS:  0010 DS: 0018 ES: 0018 CR0: 000000008005003b
CR2: 00002b8140ddf000 CR3: 000000022ea52000 CR4: 00000000000006e0
Process swapper (pid: 0, threadinfo ffffffff8060e000, task ffffffff8048a340)
Stack: 0000000000000000 0000000000000000 ffff810008c77660 0000000000000000 
       ffffffff80572f38 ffffffff80572f30 0000000080139648 ffffffff80588320 
       0000000124ae798c 0000000000000000 
Call Trace: <IRQ> <ffffffff8012c2af>{rebalance_tick+340}
       <ffffffff80139bec>{update_process_times+92} <ffffffff80118567>{smp_local_timer_interrupt+35}
       <ffffffff80118bfd>{smp_apic_timer_interrupt+65} <ffffffff801098b6>{mwait_idle+0}
       <ffffffff8010b382>{apic_timer_interrupt+98} <EOI> <ffffffff801098ec>{mwait_idle+54}
       <ffffffff80109893>{cpu_idle+151} <ffffffff8061076c>{start_kernel+465}
       <ffffffff80610296>{_sinittext+662}

Code: 48 0f 44 f0 8d 5c 33 01 83 fb 20 0f 4f d9 83 fb 1f 0f 8e 18 
console shuts up ...
 <0>Kernel panic - not syncing: Aiee, killing interrupt handler!


-- 
Regards,
vatsa
