Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932264AbWHBWAo@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932264AbWHBWAo (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 2 Aug 2006 18:00:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932255AbWHBWAn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 2 Aug 2006 18:00:43 -0400
Received: from hera.kernel.org ([140.211.167.34]:5063 "EHLO hera.kernel.org")
	by vger.kernel.org with ESMTP id S932261AbWHBWAX (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 2 Aug 2006 18:00:23 -0400
To: linux-kernel@vger.kernel.org
From: Stephen Hemminger <shemminger@osdl.org>
Subject: WARN_ON causes recursive unwind panic
Date: Wed, 2 Aug 2006 14:59:45 -0700
Organization: OSDL
Message-ID: <20060802145945.5d24e126@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Trace: build.pdx.osdl.net 1154555985 26855 10.8.0.54 (2 Aug 2006 21:59:45 GMT)
X-Complaints-To: abuse@osdl.org
NNTP-Posting-Date: Wed, 2 Aug 2006 21:59:45 +0000 (UTC)
X-Newsreader: Sylpheed-Claws 2.1.0 (GTK+ 2.8.18; i486-pc-linux-gnu)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

A simple WARN_ON tripped but the dwarf unwinder in 2.6.18-rc3 on x86_64
made it a panic by recursively gagging on itself.

[ 4202.444190] BUG: warning at net/sched/sch_htb.c:397/htb_safe_rb_erase()
[ 4202.463979] 
[ 4202.463980] Call Trace:
[ 4202.475889]  [<ffffffff8100ae89>] show_trace+0xae/0x31f
[ 4202.491521]  [<ffffffff8100b10f>] dump_stack+0x15/0x17
[ 4202.506902]  [<ffffffff88130171>] :sch_htb:htb_safe_rb_erase+0x3b/0x55
[ 4202.526421]  [<ffffffff881304d6>] :sch_htb:htb_deactivate_prios+0x174/0x1ce
[ 4202.547254]  [<ffffffff8813149e>] :sch_htb:htb_dequeue+0x4ef/0x88a
[ 4202.547261]  [<ffffffff811fac3d>] __qdisc_run+0x41/0x1e5
[ 4202.582173]  [<ffffffff811eee34>] dev_queue_xmit+0x134/0x258
[ 4202.599608]  [<ffffffff81229d00>] arp_xmit+0x4e/0x50
[ 4202.614998]  [<ffffffff8122a6de>] arp_send+0x28/0x2a
[ 4202.630372]  [<ffffffff8122afce>] arp_solicit+0x19a/0x1ab
[ 4202.647046]  [<ffffffff811f4d3e>] neigh_timer_handler+0x31f/0x361
[ 4202.665764]  [<ffffffff8103440e>] run_timer_softirq+0x147/0x1d0
[ 4202.683541]  [<ffffffff81030bc0>] __do_softirq+0x67/0xf4
[ 4202.699506]  [<ffffffff8100ab66>] call_softirq+0x1e/0x28
[ 4202.715402] DWARF2 unwinder stuck at call_softirq+0x1e/0x28
[ 4202.732064] Leftover inexact backtrace:
[ 4202.743542]  <IRQ> [<ffffffff8100c0a6>] do_softirq+0x39/0x9f
[ 4202.760533]  [<ffffffff81030b4d>] irq_exit+0x4e/0x5a
[ 4202.775389]  [<ffffffff81014e38>] smp_apic_timer_interrupt+0x54/0x58
[ 4202.794399]  [<ffffffff81008783>] default_idle+0x0/0x69
[ 4202.810035]  [<ffffffff8100a4da>] apic_timer_interrupt+0x6a/0x70
[ 4202.828005]  <EOI> [<ffffffff810037f1>] level3_kernel_pgt+0x7f1/0x1000
[ 4203.123107]  [<ffffffff81007ed8>] do_arch_prctl+0x269/0x3a9
[ 4203.143835]  [<ffffffff81004003>] level2_ident_pgt+0x3/0xa0
[ 4203.309028]  [<ffffffff81004005>] level2_ident_pgt+0x5/0xa0
[ 4203.326018]  [<ffffffff81004005>] level2_ident_pgt+0x5/0xa0
[ 4203.342840]  [<ffffffff81004005>] level2_ident_pgt+0x5/0xa0
[ 4203.359668]  [<ffffffff81004005>] level2_ident_pgt+0x5/0xa0
[ 4203.376499]  [<ffffffff81004005>] level2_ident_pgt+0x5/0xa0
[ 4203.393318]  [<ffffffff81004005>] level2_ident_pgt+0x5/0xa0
[ 4203.437207]  [<ffffffff81006485>] level3_physmem_pgt+0x485/0x1000
[ 4203.455425]  [<ffffffff81007bc6>] dump_task_regs+0x162/0x19c
[ 4203.484531]  [<ffffffff810062ad>] level3_physmem_pgt+0x2ad/0x1000
[ 4203.517836]  [<ffffffff810061a2>] level3_physmem_pgt+0x1a2/0x1000
[ 4203.536089]  [<ffffffff81002db8>] level3_ident_pgt+0xdb8/0x1000
[ 4203.553953]  [<ffffffff81007ec9>] do_arch_prctl+0x25a/0x3a9
[ 4203.570670]  [<ffffffff81007f16>] do_arch_prctl+0x2a7/0x3a9
[ 4203.589997]  [<ffffffff81007ee1>] do_arch_prctl+0x272/0x3a9
[ 4204.103898] Unable to handle kernel paging request at ffffffff82800000 RIP: 
[ 4204.117720]  [<ffffffff8100b095>] show_trace+0x2ba/0x31f
[ 4204.140990] PGD 1003027 PUD 1005027 PMD 0 
[ 4204.153404] Oops: 0000 [1] PREEMPT SMP 
[ 4204.165041] CPU 0 
[ 4204.171117] Modules linked in: cls_u32 sch_sfq sch_red sch_htb ipv6 autofs4 sunrpc binfmt_misc video thermal processor fan button battery asus_acpi ac tcp_cubic sg ehci_hcd ohci_hcd i2c_amd8111 sky2 tg3 amd_rng i2c_amd756 usbcore
[ 4204.233349] Pid: 0, comm: swapper Not tainted 2.6.18-rc3-htb #2
[ 4204.251061] RIP: 0010:[<ffffffff8100b095>]  [<ffffffff8100b095>] show_trace+0x2ba/0x31f
[ 4204.275061] RSP: 0018:ffffffff8141db90  EFLAGS: 00010206
[ 4204.290956] RAX: 0000000000000000 RBX: 0000000000000000 RCX: 000000000000f854
[ 4204.312304] RDX: ffffffff8141db80 RSI: 0000000000000000 RDI: 0000000000000001
[ 4204.333653] RBP: ffffffff8141dc80 R08: ffffffff8141db20 R09: 0000000000000001
[ 4204.355005] R10: ffffffff810496c0 R11: ffffffff810496c0 R12: ffffffff827ffffa
[ 4204.376354] R13: ffffffff8141dba0 R14: 0000000000000000 R15: 0000000000000000
[ 4204.397703] FS:  00002aee03c7d760(0000) GS:ffffffff816c5000(0000) knlGS:0000000000000000
[ 4204.421909] CS:  0010 DS: 0018 ES: 0018 CR0: 000000008005003b
[ 4204.439103] CR2: ffffffff82800000 CR3: 00000000704be000 CR4: 00000000000006e0
[ 4204.460452] Process swapper (pid: 0, threadinfo ffffffff816d4000, task ffffffff813508e0)
[ 4204.484656] Stack:  0000000000000086 0000000000000000 0000000000000000 0000000000000000
[ 4204.508862]  0000000000000000 0000000000000000 ffffffff8141df80 0000000000000046
[ 4204.531198]  0000000000000000 0000000000000000 0000000000000000 0000000000000000
[ 4204.552965] Call Trace:
[ 4204.560878]  [<ffffffff8100b10f>] dump_stack+0x15/0x17
[ 4204.576253]  [<ffffffff88130171>] :sch_htb:htb_safe_rb_erase+0x3b/0x55
[ 4204.595776]  [<ffffffff881304d6>] :sch_htb:htb_deactivate_prios+0x174/0x1ce
[ 4204.616601]  [<ffffffff8813149e>] :sch_htb:htb_dequeue+0x4ef/0x88a
[ 4204.635094]  [<ffffffff811fac3d>] __qdisc_run+0x41/0x1e5
[ 4204.651527]  [<ffffffff811eee34>] dev_queue_xmit+0x134/0x258
[ 4204.668961]  [<ffffffff81229d00>] arp_xmit+0x4e/0x50
[ 4204.684352]  [<ffffffff8122a6de>] arp_send+0x28/0x2a
[ 4204.699724]  [<ffffffff8122afce>] arp_solicit+0x19a/0x1ab
[ 4204.716400]  [<ffffffff811f4d3e>] neigh_timer_handler+0x31f/0x361
[ 4204.735116]  [<ffffffff8103440e>] run_timer_softirq+0x147/0x1d0
[ 4204.752894]  [<ffffffff81030bc0>] __do_softirq+0x67/0xf4
[ 4204.768832]  [<ffffffff8100ab66>] call_softirq+0x1e/0x28
[ 4204.784728] DWARF2 unwinder stuck at call_softirq+0x1e/0x28
[ 4204.801389] Leftover inexact backtrace:
[ 4204.812870]  <IRQ> [<ffffffff8100c0a6>] do_softirq+0x39/0x9f
[ 4204.829859]  [<ffffffff81030b4d>] irq_exit+0x4e/0x5a
[ 4204.844716]  [<ffffffff81014e38>] smp_apic_timer_interrupt+0x54/0x58
[ 4204.863725]  [<ffffffff81008783>] default_idle+0x0/0x69
[ 4204.879362]  [<ffffffff8100a4da>] apic_timer_interrupt+0x6a/0x70
[ 4204.897332]  <EOI> [<ffffffff810037f1>] level3_kernel_pgt+0x7f1/0x1000
[ 4205.166202]  [<ffffffff81007ed8>] do_arch_prctl+0x269/0x3a9
[ 4205.186515]  [<ffffffff81004003>] level2_ident_pgt+0x3/0xa0
[ 4205.337294]  [<ffffffff81004005>] level2_ident_pgt+0x5/0xa0
[ 4205.354250]  [<ffffffff81004005>] level2_ident_pgt+0x5/0xa0
[ 4205.371061]  [<ffffffff81004005>] level2_ident_pgt+0x5/0xa0
[ 4205.387865]  [<ffffffff81004005>] level2_ident_pgt+0x5/0xa0
[ 4205.404670]  [<ffffffff81004005>] level2_ident_pgt+0x5/0xa0
[ 4205.421462]  [<ffffffff81004005>] level2_ident_pgt+0x5/0xa0
[ 4205.462728]  [<ffffffff81006270>] level3_physmem_pgt+0x270/0x1000
[ 4205.480961]  [<ffffffff81007bc6>] dump_task_regs+0x162/0x19c
[ 4205.508898]  [<ffffffff810062ad>] level3_physmem_pgt+0x2ad/0x1000
[ 4205.540752]  [<ffffffff810061a2>] level3_physmem_pgt+0x1a2/0x1000
[ 4205.559133]  [<ffffffff81007ec9>] do_arch_prctl+0x25a/0x3a9
[ 4205.575865]  [<ffffffff81007f16>] do_arch_prctl+0x2a7/0x3a9
[ 4205.594942]  [<ffffffff81007ee1>] do_arch_prctl+0x272/0x3a9
[ 4206.060619] Unable to handle kernel paging request at ffffffff82800000 RIP: 
[ 4206.074430]  [<ffffffff8100b095>] show_trace+0x2ba/0x31f
[ 4206.097700] PGD 1003027 PUD 1005027 PMD 0 
[ 4206.110115] Oops: 0000 [2] PREEMPT SMP 
[ 4206.121751] CPU 0 
[ 4206.127829] Modules linked in: cls_u32 sch_sfq sch_red sch_htb ipv6 autofs4 sunrpc binfmt_misc video thermal processor fan button battery asus_acpi ac tcp_cubic sg ehci_hcd ohci_hcd i2c_amd8111 sky2 tg3 amd_rng i2c_amd756 usbcore
[ 4206.190061] Pid: 0, comm: swapper Not tainted 2.6.18-rc3-htb #2
[ 4206.207773] RIP: 0010:[<ffffffff8100b095>]  [<ffffffff8100b095>] show_trace+0x2ba/0x31f
[ 4206.231772] RSP: 0018:ffffffff8141d828  EFLAGS: 00010006
[ 4206.247666] RAX: 0000000000000000 RBX: 0000000000000000 RCX: 000000000000f854
[ 4206.269016] RDX: ffffffff813508e0 RSI: 0000000000000000 RDI: 0000000000000001
[ 4206.290366] RBP: ffffffff8141d918 R08: ffffffff8141d7b8 R09: 0000000000000001
[ 4206.311715] R10: ffffffff810496c0 R11: ffffffff810496c0 R12: ffffffff827ffffa
[ 4206.333064] R13: ffffffff8141dae8 R14: 0000000000000000 R15: 0000000000000000
[ 4206.354414] FS:  00002aee03c7d760(0000) GS:ffffffff816c5000(0000) knlGS:0000000000000000
[ 4206.378620] CS:  0010 DS: 0018 ES: 0018 CR0: 000000008005003b
[ 4206.395813] CR2: ffffffff82800000 CR3: 00000000704be000 CR4: 00000000000006e0
[ 4206.417162] Process swapper (pid: 0, threadinfo ffffffff816d4000, task ffffffff813508e0)
[ 4206.441369] Stack:  0000000000000000 000000000000000c 0000000000000000 0000000000000000
[ 4206.465573]  0000000000000000 0000000000000000 ffffffff8141df80 0000000000000046
[ 4206.487911]  ffffffff810496c0 ffffffff810496c0 0000000000000001 ffffffff8141db20
[ 4206.509675] Call Trace:
[ 4206.517586]  [<ffffffff8100b1f3>] _show_stack+0xe2/0xf1
[ 4206.533218]  [<ffffffff8100b28e>] show_registers+0x8c/0x100
[ 4206.549895]  [<ffffffff81251ae3>] __die+0xa8/0xfc
[ 4206.563970]  [<ffffffff812535aa>] do_page_fault+0x701/0x7fd
[ 4206.580681]  [<ffffffff8100a63d>] error_exit+0x0/0x96
[ 4206.595807] DWARF2 unwinder stuck at error_exit+0x0/0x96
[ 4206.611695] Leftover inexact backtrace:
[ 4206.623176]  <IRQ> [<ffffffff810496c0>] module_text_address+0x16/0x3b
[ 4206.642500]  [<ffffffff810496c0>] module_text_address+0x16/0x3b
[ 4206.660215]  [<ffffffff8100b095>] show_trace+0x2ba/0x31f
[ 4206.676115]  [<ffffffff8100ab66>] call_softirq+0x1e/0x28
[ 4206.692008]  [<ffffffff8100b10f>] dump_stack+0x15/0x17
[ 4206.707384]  [<ffffffff88130171>] :sch_htb:htb_safe_rb_erase+0x3b/0x55
[ 4206.726914]  [<ffffffff881304d6>] :sch_htb:htb_deactivate_prios+0x174/0x1ce
[ 4206.747744]  [<ffffffff8813149e>] :sch_htb:htb_dequeue+0x4ef/0x88a
[ 4206.766238]  [<ffffffff88130b3b>] :sch_htb:htb_activate_prios+0xe2/0xf3
[ 4206.786026]  [<ffffffff811fac3d>] __qdisc_run+0x41/0x1e5
[ 4206.801920]  [<ffffffff811eee34>] dev_queue_xmit+0x134/0x258
[ 4206.818854]  [<ffffffff81229d00>] arp_xmit+0x4e/0x50
[ 4206.833709]  [<ffffffff8122a6de>] arp_send+0x28/0x2a
[ 4206.848566]  [<ffffffff8122afce>] arp_solicit+0x19a/0x1ab
[ 4206.864722]  [<ffffffff811f4d3e>] neigh_timer_handler+0x31f/0x361
[ 4206.882954]  [<ffffffff811f4a1f>] neigh_timer_handler+0x0/0x361
[ 4206.900668]  [<ffffffff8103440e>] run_timer_softirq+0x147/0x1d0
[ 4206.918382]  [<ffffffff81030bc0>] __do_softirq+0x67/0xf4
[ 4206.934277]  [<ffffffff8100ab66>] call_softirq+0x1e/0x28
[ 4206.950171]  [<ffffffff8100c0a6>] do_softirq+0x39/0x9f
[ 4206.965545]  [<ffffffff81030b4d>] irq_exit+0x4e/0x5a
[ 4206.980402]  [<ffffffff81014e38>] smp_apic_timer_interrupt+0x54/0x58
[ 4206.999412]  [<ffffffff81008783>] default_idle+0x0/0x69
[ 4207.015049]  [<ffffffff8100a4da>] apic_timer_interrupt+0x6a/0x70
[ 4207.033021]  <EOI> [<ffffffff810037f1>] level3_kernel_pgt+0x7f1/0x1000
[ 4207.301701]  [<ffffffff81007ed8>] do_arch_prctl+0x269/0x3a9
[ 4207.322013]  [<ffffffff81004003>] level2_ident_pgt+0x3/0xa0
[ 4207.472520]  [<ffffffff81004005>] level2_ident_pgt+0x5/0xa0
[ 4207.489494]  [<ffffffff81004005>] level2_ident_pgt+0x5/0xa0
[ 4207.506308]  [<ffffffff81004005>] level2_ident_pgt+0x5/0xa0
[ 4207.523112]  [<ffffffff81004005>] level2_ident_pgt+0x5/0xa0
[ 4207.539917]  [<ffffffff81004005>] level2_ident_pgt+0x5/0xa0
[ 4207.556709]  [<ffffffff81004005>] level2_ident_pgt+0x5/0xa0
[ 4207.597924]  [<ffffffff81006270>] level3_physmem_pgt+0x270/0x1000
[ 4207.616155]  [<ffffffff81007bc6>] dump_task_regs+0x162/0x19c
[ 4207.644066]  [<ffffffff810062ad>] level3_physmem_pgt+0x2ad/0x1000
[ 4207.675892]  [<ffffffff810061a2>] level3_physmem_pgt+0x1a2/0x1000
[ 4207.694275]  [<ffffffff81007ec9>] do_arch_prctl+0x25a/0x3a9
[ 4207.711007]  [<ffffffff81007f16>] do_arch_prctl+0x2a7/0x3a9
[ 4207.730080]  [<ffffffff81007ee1>] do_arch_prctl+0x272/0x3a9
[ 4208.194824] Unable to handle kernel paging request at ffffffff82800000 RIP: 
[ 4208.208638]  [<ffffffff8100b095>] show_trace+0x2ba/0x31f
[ 4208.231908] PGD 1003027 PUD 1005027 PMD 0 
[ 4208.244323] Oops: 0000 [3] PREEMPT SMP 
[ 4208.255959] CPU 0 
[ 4208.262036] Modules linked in: cls_u32 sch_sfq sch_red sch_htb ipv6 autofs4 sunrpc binfmt_misc video thermal processor fan button battery asus_acpi ac tcp_cubic sg ehci_hcd ohci_hcd i2c_amd8111 sky2 tg3 amd_rng i2c_amd756 usbcore
[ 4208.324266] Pid: 0, comm: swapper Not tainted 2.6.18-rc3-htb #2
[ 4208.341980] RIP: 0010:[<ffffffff8100b095>]  [<ffffffff8100b095>] show_trace+0x2ba/0x31f
[ 4208.365978] RSP: 0018:ffffffff8141d4b8  EFLAGS: 00010006
[ 4208.381872] RAX: 0000000000000000 RBX: 0000000000000000 RCX: 000000000000f854
[ 4208.403222] RDX: ffffffff813508e0 RSI: 0000000000000000 RDI: 0000000000000001
[ 4208.424572] RBP: ffffffff8141d5a8 R08: ffffffff8141d448 R09: 0000000000000001
[ 4208.445921] R10: ffffffff810496c0 R11: ffffffff810496c0 R12: ffffffff827ffffa
[ 4208.467270] R13: ffffffff8141d778 R14: 0000000000000000 R15: 0000000000000000
[ 4208.488621] FS:  00002aee03c7d760(0000) GS:ffffffff816c5000(0000) knlGS:0000000000000000
[ 4208.512826] CS:  0010 DS: 0018 ES: 0018 CR0: 000000008005003b
[ 4208.530020] CR2: ffffffff82800000 CR3: 00000000704be000 CR4: 00000000000006e0
[ 4208.551370] Process swapper (pid: 0, threadinfo ffffffff816d4000, task ffffffff813508e0)
[ 4208.575574] Stack:  0000000000000000 000000000000000c 0000000000000000 0000000000000000
[ 4208.599781]  ffffffff8141dba0 ffffffff827ffffa 0000000081009e4b 0000000000000001
[ 4208.622118]  ffffffff810496c0 ffffffff810496c0 0000000000000001 ffffffff8141d7b8
[ 4208.643883] Call Trace:
[ 4208.651793]  [<ffffffff8100b1f3>] _show_stack+0xe2/0xf1
[ 4208.667425]  [<ffffffff8100b28e>] show_registers+0x8c/0x100
[ 4208.684103]  [<ffffffff81251ae3>] __die+0xa8/0xfc
[ 4208.698177]  [<ffffffff812535aa>] do_page_fault+0x701/0x7fd
[ 4208.714886]  [<ffffffff8100a63d>] error_exit+0x0/0x96
[ 4208.730016] DWARF2 unwinder stuck at error_exit+0x0/0x96
[ 4208.745902] Leftover inexact backtrace:
[ 4208.757382]  <IRQ> [<ffffffff810496c0>] module_text_address+0x16/0x3b
[ 4208.776707]  [<ffffffff810496c0>] module_text_address+0x16/0x3b
[ 4208.794424]  [<ffffffff8100b095>] show_trace+0x2ba/0x31f
[ 4208.810315]  [<ffffffff8100b0a1>] show_trace+0x2c6/0x31f
[ 4208.826213]  [<ffffffff810496c0>] module_text_address+0x16/0x3b
[ 4208.843924]  [<ffffffff810496c0>] module_text_address+0x16/0x3b
[ 4208.861640]  [<ffffffff8100ab66>] call_softirq+0x1e/0x28
[ 4208.877534]  [<ffffffff8100b1f3>] _show_stack+0xe2/0xf1
[ 4208.893171]  [<ffffffff8100b28e>] show_registers+0x8c/0x100
[ 4208.909843]  [<ffffffff81251ae3>] __die+0xa8/0xfc
[ 4208.923921]  [<ffffffff812535aa>] do_page_fault+0x701/0x7fd
[ 4208.940597]  [<ffffffff81034e0d>] update_process_times+0x70/0x78
[ 4208.958566]  [<ffffffff81250634>] trace_hardirqs_on_thunk+0x35/0x37
[ 4208.977318]  [<ffffffff810496c0>] module_text_address+0x16/0x3b
[ 4208.995031]  [<ffffffff810496c0>] module_text_address+0x16/0x3b
[ 4209.012748]  [<ffffffff8100a63d>] error_exit+0x0/0x96
[ 4209.027861]  [<ffffffff810496c0>] module_text_address+0x16/0x3b
[ 4209.045574]  [<ffffffff810496c0>] module_text_address+0x16/0x3b
[ 4209.063290]  [<ffffffff8100b095>] show_trace+0x2ba/0x31f
[ 4209.079187]  [<ffffffff8100ab66>] call_softirq+0x1e/0x28
[ 4209.095081]  [<ffffffff8100b10f>] dump_stack+0x15/0x17
[ 4209.110458]  [<ffffffff88130171>] :sch_htb:htb_safe_rb_erase+0x3b/0x55
[ 4209.129987]  [<ffffffff881304d6>] :sch_htb:htb_deactivate_prios+0x174/0x1ce
[ 4209.150818]  [<ffffffff8813149e>] :sch_htb:htb_dequeue+0x4ef/0x88a
[ 4209.169312]  [<ffffffff88130b3b>] :sch_htb:htb_activate_prios+0xe2/0xf3
[ 4209.189100]  [<ffffffff811fac3d>] __qdisc_run+0x41/0x1e5
[ 4209.204996]  [<ffffffff811eee34>] dev_queue_xmit+0x134/0x258
[ 4209.221929]  [<ffffffff81229d00>] arp_xmit+0x4e/0x50
[ 4209.236782]  [<ffffffff8122a6de>] arp_send+0x28/0x2a
[ 4209.251639]  [<ffffffff8122afce>] arp_solicit+0x19a/0x1ab
[ 4209.267797]  [<ffffffff811f4d3e>] neigh_timer_handler+0x31f/0x361
[ 4209.286027]  [<ffffffff811f4a1f>] neigh_timer_handler+0x0/0x361
[ 4209.303741]  [<ffffffff8103440e>] run_timer_softirq+0x147/0x1d0
[ 4209.321455]  [<ffffffff81030bc0>] __do_softirq+0x67/0xf4
[ 4209.337349]  [<ffffffff8100ab66>] call_softirq+0x1e/0x28
[ 4209.353243]  [<ffffffff8100c0a6>] do_softirq+0x39/0x9f
[ 4209.368618]  [<ffffffff81030b4d>] irq_exit+0x4e/0x5a
[ 4209.383476]  [<ffffffff81014e38>] smp_apic_timer_interrupt+0x54/0x58
[ 4209.402488]  [<ffffffff81008783>] default_idle+0x0/0x69
[ 4209.418122]  [<ffffffff8100a4da>] apic_timer_interrupt+0x6a/0x70
[ 4209.436093]  <EOI> [<ffffffff810037f1>] level3_kernel_pgt+0x7f1/0x1000
[ 4209.704133]  [<ffffffff81007ed8>] do_arch_prctl+0x269/0x3a9
[ 4209.724444]  [<ffffffff81004003>] level2_ident_pgt+0x3/0xa0
[ 4209.874945]  [<ffffffff81004005>] level2_ident_pgt+0x5/0xa0
[ 4209.891918]  [<ffffffff81004005>] level2_ident_pgt+0x5/0xa0
[ 4209.908732]  [<ffffffff81004005>] level2_ident_pgt+0x5/0xa0
[ 4209.925535]  [<ffffffff81004005>] level2_ident_pgt+0x5/0xa0
[ 4209.942339]  [<ffffffff81004005>] level2_ident_pgt+0x5/0xa0
[ 4209.959133]  [<ffffffff81004005>] level2_ident_pgt+0x5/0xa0
[ 4210.000346]  [<ffffffff81006270>] level3_physmem_pgt+0x270/0x1000
[ 4210.018579]  [<ffffffff81007bc6>] dump_task_regs+0x162/0x19c
[ 4210.046492]  [<ffffffff810062ad>] level3_physmem_pgt+0x2ad/0x1000
[ 4210.078341]  [<ffffffff810061a2>] level3_physmem_pgt+0x1a2/0x1000
[ 4210.096724]  [<ffffffff81007ec9>] do_arch_prctl+0x25a/0x3a9
[ 4210.113458]  [<ffffffff81007f16>] do_arch_prctl+0x2a7/0x3a9
[ 4210.132529]  [<ffffffff81007ee1>] do_arch_prctl+0x272/0x3a9
