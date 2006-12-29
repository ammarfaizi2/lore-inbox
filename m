Return-Path: <linux-kernel-owner+w=401wt.eu-S1754420AbWL2EDY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754420AbWL2EDY (ORCPT <rfc822;w@1wt.eu>);
	Thu, 28 Dec 2006 23:03:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754515AbWL2EDY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 28 Dec 2006 23:03:24 -0500
Received: from gateway-1237.mvista.com ([63.81.120.158]:20443 "EHLO
	gateway-1237.mvista.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754420AbWL2EDX (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 28 Dec 2006 23:03:23 -0500
Subject: BUG: soft lockup detected / list_add corruption
From: Daniel Walker <dwalker@mvista.com>
To: linux-kernel@vger.kernel.org
Content-Type: text/plain
Date: Thu, 28 Dec 2006 20:02:37 -0800
Message-Id: <1167364957.14081.62.camel@imap.mvista.com>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.3 (2.6.3-1.fc5.5) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Got this while trying to mount a ext3 block device. The host was running nfs root 

[  929.130331] nfs: server 10.0.13.21 not responding, still trying
[  931.346289] BUG: soft lockup detected on CPU#3!
[  931.350860]  [<c0105206>] show_trace_log_lvl+0x1a/0x2f
[  931.356081]  [<c01057cf>] show_trace+0x12/0x14
[  931.360590]  [<c0105853>] dump_stack+0x16/0x18
[  931.365124]  [<c0165efd>] softlockup_tick+0xca/0xdc
[  931.370069]  [<c013aeca>] run_local_timers+0x12/0x14
[  931.375092]  [<c013b16f>] update_process_times+0x3e/0x63
[  931.380456]  [<c01482d2>] hrtimer_sched_tick+0x6c/0xb3
[  931.385686]  [<c01488cd>] hrtimer_interrupt+0x132/0x1cd
[  931.390983]  [<c011dc91>] local_apic_timer_interrupt+0x41/0x46
[  931.396924]  [<c011e5d6>] smp_apic_timer_interrupt+0x2d/0x3c
[  931.402626]  [<c0104cdb>] apic_timer_interrupt+0x33/0x38
[  931.408013]  [<c0135d54>] on_each_cpu+0x1a/0x46
[  931.412593]  [<c010dbee>] mce_work_fn+0x1e/0x2f
[  931.417198]  [<c0141565>] run_workqueue+0x9a/0x174
[  931.422066]  [<c01420bc>] worker_thread+0xf8/0x124
[  931.426900]  [<c0144abb>] kthread+0xb5/0xde
[  931.431125]  [<c0104e7b>] kernel_thread_helper+0x7/0x10


... Then a few seconds later , got this,


[  931.905246] NETDEV WATCHDOG: eth0: transmit timed out
[  937.894061] NETDEV WATCHDOG: eth0: transmit timed out
[  941.217545] nfs: server 10.0.13.21 not responding, still trying
[  943.882880] NETDEV WATCHDOG: eth0: transmit timed out
[  946.881281] list_add corruption. prev->next should be next (c3cb9ed8), but was c3e16af8. (prev=c3e16af8).
[  946.891028] ------------[ cut here ]------------
[  946.895661] kernel BUG at lib/list_debug.c:33!
[  946.900178] invalid opcode: 0000 [#1]
[  946.903886] SMP
[  946.905771] last sysfs file: /kernel/uevent_seqnum
[  946.910605] Modules linked in:
[  946.913697] CPU:    3
[  946.913698] EIP:    0060:[<c05bacd1>]    Not tainted VLI
[  946.913700] EFLAGS: 00010082   (2.6.20-rc2-mm1 #20)
[  946.926397] EIP is at __list_add+0x73/0x89
[  946.930521] eax: 00000070   ebx: c3cb9ed8   ecx: c1a91c74   edx: 00000001
[  946.937362] esi: c3e16af8   edi: c3e16af8   ebp: c3cefe24   esp: c3cefe08
[  946.944196] ds: 007b   es: 007b   fs: 00d8  gs: 0000  ss: 0068
[  946.950097] Process events/3 (pid: 17, ti=c3cee000 task=c3cea270 task.ti=c3cee000)
[  946.957571] Stack: c17d1af5 c3cb9ed8 c3e16af8 c3e16af8 c3cb9eb4 c3e16af4 00000282 c3cefe3c
[  946.966120]        c01416bc c013a5c6 c3c5dcf4 00000003 c3e16af4 c3cefe50 c0141727 c3e16af4
[  946.974706]        00000100 c3cda000 c3cefe80 c013a5d5 c01416e7 c3e16b20 c3cefe80 c014e305
[  946.983259] Call Trace:
[  946.985905]  [<c0105206>] show_trace_log_lvl+0x1a/0x2f
[  946.991135]  [<c01052b8>] show_stack_log_lvl+0x9d/0xac
[  946.996363]  [<c0105479>] show_registers+0x1b2/0x288
[  947.001411]  [<c0105676>] die+0x127/0x23f
[  947.005473]  [<c134a6e1>] do_trap+0x7f/0x99
[  947.009661]  [<c0105bfa>] do_invalid_op+0x97/0xa1
[  947.014457]  [<c134a4ac>] error_code+0x7c/0x84
[  947.018968]  [<c01416bc>] __queue_work+0x48/0x73
[  947.023637]  [<c0141727>] delayed_work_timer_fn+0x40/0x45
[  947.029064]  [<c013a5d5>] run_timer_softirq+0x121/0x189
[  947.034374]  [<c01362f5>] __do_softirq+0x78/0xf8
[  947.039068]  [<c01363c0>] do_softirq+0x4b/0x77
[  947.043571]  [<c013698b>] irq_exit+0x47/0x8b
[  947.047899]  [<c011e5db>] smp_apic_timer_interrupt+0x32/0x3c
[  947.053655]  [<c0104cdb>] apic_timer_interrupt+0x33/0x38
[  947.059005]  [<c0135d54>] on_each_cpu+0x1a/0x46
[  947.063605]  [<c010dbee>] mce_work_fn+0x1e/0x2f
[  947.068228]  [<c0141565>] run_workqueue+0x9a/0x174
[  947.073076]  [<c01420bc>] worker_thread+0xf8/0x124
[  947.077937]  [<c0144abb>] kthread+0xb5/0xde
[  947.082187]  [<c0104e7b>] kernel_thread_helper+0x7/0x10
[  947.087485]  =======================
[  947.091125] Code: 1d b5 c1 39 1e 0f 95 c2 e8 65 76 00 00 85 c0 74 1e 8b 06 89 74 24 0c 89 5c 24 04 c7 04 24 f5 1a 7d c1 89 44 24
[  947.111085] EIP: [<c05bacd1>] __list_add+0x73/0x89 SS:ESP 0068:c3cefe08
[  947.125703]  <0>Kernel panic - not syncing: Fatal exception in interrupt


