Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030428AbWCTVry@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030428AbWCTVry (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 20 Mar 2006 16:47:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964989AbWCTVry
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 20 Mar 2006 16:47:54 -0500
Received: from mgw1.diku.dk ([130.225.96.91]:50143 "EHLO mgw1.diku.dk")
	by vger.kernel.org with ESMTP id S964995AbWCTVrx (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 20 Mar 2006 16:47:53 -0500
Date: Mon, 20 Mar 2006 22:44:21 +0100 (CET)
From: Jesper Dangaard Brouer <hawk@diku.dk>
To: Robert Olsson <Robert.Olsson@data.slu.se>, jens.laas@data.slu.se,
       hans.liss@its.uu.se
Cc: linux-net@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Kernel panic: Route cache, RCU, possibly FIB trie.
Message-ID: <Pine.LNX.4.61.0603202234400.27140@ask.diku.dk>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Kernel panic report.

Have experienced some kernel panic's on a production Linux box acting
as a router for a large number of customers.

I have tried to track down the problem, and I think I have narrowed it
a bit down.  My theory is that it is related to the route cache
(ip_dst_cache) or FIB, which cannot dealloacate route cache slab
elements (maybe RCU related).  (I have seen my route cache increase to
around 520k entries using rtstat, before dying).

I'm using the FIB trie system/algorithm (CONFIG_IP_FIB_TRIE). Think
that the error might be cause by the "fib_trie" code.  See the syslog,
output below.

Below are some kernel panic outputs from the console and some
interesting errors found in syslog.

Happy bug hunting...

Greetings
   Jesper Brouer

--
-------------------------------------------------------------------
MSc. Master of Computer Science, Cand. scient datalog
Dept. of Computer Science, University of Copenhagen
-------------------------------------------------------------------



Kernel version:
   2.6.15.1 SMP PREEMPT

Patched with:
   Netfiler patch-o-magic, layer7 filter and kernel debugger.

System:
   HP server DL380, with two Intel Xeon CPU's


Syslog#1 (indicating a problem with the fib trie)
--------
Mar 20 18:00:04 hostname kernel: Debug: sleeping function called from invalid context at mm/slab.c:2472
Mar 20 18:00:04 hostname kernel: in_atomic():1, irqs_disabled():0
Mar 20 18:00:04 hostname kernel:  [<c0103d9f>] dump_stack+0x1e/0x22
Mar 20 18:00:04 hostname kernel:  [<c011cbe1>] __might_sleep+0xa6/0xae
Mar 20 18:00:04 hostname kernel:  [<c014f3e9>] __kmalloc+0xd9/0xf3
Mar 20 18:00:04 hostname kernel:  [<c014f5a4>] kzalloc+0x23/0x50
Mar 20 18:00:04 hostname kernel:  [<c030ecd1>] tnode_alloc+0x3c/0x82
Mar 20 18:00:04 hostname kernel:  [<c030edf6>] tnode_new+0x26/0x91
Mar 20 18:00:04 hostname kernel:  [<c030f757>] halve+0x43/0x31d
Mar 20 18:00:04 hostname kernel:  [<c030f090>] resize+0x118/0x27e
Mar 20 18:00:04 hostname kernel:  [<c030fca1>] trie_rebalance+0x90/0x115
Mar 20 18:00:04 hostname kernel:  [<c0310a58>] trie_leaf_remove+0x123/0x1c7
Mar 20 18:00:04 hostname kernel:  [<c031101d>] fn_trie_flush+0x5c/0x84
Mar 20 18:00:04 hostname kernel:  [<c030bb06>] fib_flush+0x2a/0x4c
Mar 20 18:00:04 hostname kernel:  [<c030c905>] fib_disable_ip+0x47/0x49
Mar 20 18:00:04 hostname kernel:  [<c030c9fb>] fib_netdev_event+0x87/0x94
Mar 20 18:00:04 hostname kernel:  [<c012d15a>] notifier_call_chain+0x27/0x3f
Mar 20 18:00:04 hostname kernel:  [<c02c02f2>] dev_close+0x6f/0x8d
Mar 20 18:00:04 hostname kernel:  [<c02c19e0>] dev_change_flags+0x56/0x127
Mar 20 18:00:04 hostname kernel:  [<f8b60806>] vlan_device_event+0x16b/0x16d [8021q]
Mar 20 18:00:04 hostname kernel:  [<c012d15a>] notifier_call_chain+0x27/0x3f
Mar 20 18:00:04 hostname kernel:  [<c02c02f2>] dev_close+0x6f/0x8d
Mar 20 18:00:04 hostname kernel:  [<c02c19e0>] dev_change_flags+0x56/0x127
Mar 20 18:00:04 hostname kernel:  [<c0304b95>] devinet_ioctl+0x232/0x5a2
Mar 20 18:00:04 hostname kernel:  [<c0306e75>] inet_ioctl+0x5a/0x97
Mar 20 18:00:04 hostname kernel:  [<c02b6c4f>] sock_ioctl+0xb0/0x236
Mar 20 18:00:04 hostname kernel:  [<c0178473>] do_ioctl+0x7b/0x8b
Mar 20 18:00:04 hostname kernel:  [<c017861d>] vfs_ioctl+0x62/0x1c1
Mar 20 18:00:04 hostname kernel:  [<c01787bd>] sys_ioctl+0x41/0x64
Mar 20 18:00:04 hostname kernel:  [<c0102ef9>] syscall_call+0x7/0xb



Kernel panic#1
--------------
EIP is at _stext+0x3feffd68/0x49
eax: d9d07f00   ebx: 00000000   ecx: 00000100   edx: 00000000
esi: c190a1a0   edi: 00000010   ebp: f6d15f10   esp: f6d15efc
ds: 007b   es: 007b   ss: 0068
Process named (pid: 2122, threadinfo=f6d14000 task=f7e61570)
Stack: c012fc85 d9d07f00 c190a1a0 c036db80 c036dc80 f6d15f30 c012fe7b c190a1a0
        c036dc80 c190a1a0 c190a1a0 c03fd020 c03f9130 f6d15f4c c012feff c036db80
        c036dc80 c190a1a0 c190a1d8 00000000 f6d15f68 c0124578 00000000 c03f7380
Call Trace:
  [<c0103cc7>] show_stack+0x80/0x96
  [<c0103e60>] show_registers+0x161/0x1c5
  [<c0104057>] die+0x107/0x186
  [<c0116c5f>] do_page_fault+0x2c6/0x57d
  [<c0103997>] error_code+0x4f/0x54
  [<c012fe7b>] __rcu_process_callbacks+0xaa/0xd3
  [<c012feff>] rcu_process_callbacks+0x5b/0x65
  [<c0124578>] tasklet_action+0x77/0xc9
  [<c01241f1>] __do_softirq+0xc1/0xd6
  [<c0124251>] do_softirq+0x4b/0x4d
  [<c012433b>] irq_exit+0x47/0x49
  [<c010533b>] do_IRQ+0x2b/0x3b
  [<c010383e>] common_interrupt+0x1a/0x20
Code:  Bad EIP value.
  <0>Kernel panic - not syncing: Fatal exception in interrupt


Kernel panic#2 with KDB
--------------
  [<c0103f04>] show_registers+0x161/0x1c5
  [<c010410b>] die+0x117/0x1b3
  [<c01171eb>] do_page_fault+0x300/0x59c
  [<c0103a1f>] error_code+0x4f/0x54
  [<c0129344>] run_timer_softirq+0xd4/0x1c2
  [<c0125115>] __do_softirq+0xc1/0xd6
  [<c0125175>] do_softirq+0x4b/0x4d
  [<c012525f>] irq_exit+0x47/0x49
  [<c01139cc>] smp_apic_timer_interrupt+0x6f/0xee
  [<c0103954>] apic_timer_interrupt+0x1c/0x24
  [<c0100e10>] cpu_idle+0x89/0x9f
  [<c01126fa>] start_secondary+0x17f/0x2ef
  [<00000000>] 0x0
  [<c1dbffb4>] 0xc1dbffb4 
Code: 24 04 e8 6e 02 e5 ff 83 c4 28 5b 5e 5f 5d c3 8b 45 ec 25 ff 03 00 00 6b c0
  14 03 05 28 3b 49 c0 e8 2c de 04 00 8b 1e 85 db 74 1b <8b> 43 20 85 c0 0f 84 a6
  00 00 00 3b 45 e4 78 34 d1 6d e0 89 de

Entering kdb (current=0xc1db0aa0, pid 0) on processor 1 Oops: Oops 
due to oops @ 0xc02d8a85 
eax = 0x00000000 ebx = 0xccacef04 ecx = 0x00000000 edx = 0xccacff04 
esi = 0xccacff04 edi = 0x0001dd08 esp = 0xc1dbfe7c eip = 0xc02d8a85
ebp = 0xc1dbfeb0 xss = 0xc02b0068 xcs = 0x00000060 eflags = 0x00010282 
xds = 0xccac007b xes = 0x0000007b origeax = 0xffffffff &regs = 0xc1dbfe48
[1]kdb>


Kernel panic#3 with KDB
--------------
(tried to increase the route cache flush interval...)

  [<c01171eb>] do_page_fault+0x300/0x59c
  [<c0103a1f>] error_code+0x4f/0x54
  [<c02d8d07>] rt_cache_flush+0xf5/0xfe
  [<c02d8d2b>] rt_secret_rebuild+0x1b/0x38
  [<c0129344>] run_timer_softirq+0xd4/0x1c2
  [<c0125115>] __do_softirq+0xc1/0xd6
  [<c0125175>] do_softirq+0x4b/0x4d
  [<c012525f>] irq_exit+0x47/0x49
  [<c01139cc>] smp_apic_timer_interrupt+0x6f/0xee
  [<c0103954>] apic_timer_interrupt+0x1c/0x24
  [<c0100e10>] cpu_idle+0x89/0x9f
  [<c01002dd>] _stext+0x45/0x49
  [<c041aa3c>] start_kernel+0x1b5/0x1f6
  [<c0100210>] 0xc0100210
Code: 01 f0 e8 40 de 04 00 a1 2c 3b 49 c0 8b 1c b8 85 db 74 07 c7 04 b8 00 00 00
  00 03 35 28 3b 49 c0 89 f0 e8 d8 e1 04 00 85 db 74 37 <0f> b7 83 92 00 00 00 8b
  33 8b 04 85 50 58 49 c0 85 c0 74 0d 8b

Entering kdb (current=0xc0392ba0, pid 0) on processor 0 Oops: Oops
due to oops @ 0xc02d8bc6 
eax = 0xd8b62f84 ebx = 0xd9d75f04 ecx = 0x00000100 edx = 0xc02dda2e
esi = 0xd9d75f04 edi = 0x000077fc esp = 0xc0419e94 eip = 0xc02d8bc6
ebp = 0xc0419ea8 xss = 0xc02b0068 xcs = 0x00000060 eflags = 0x00010282
xds = 0xc02d007b xes = 0xc010007b origeax = 0xffffffff &regs = 0xc0419e60
[0]kdb>


[0]kdb> bt

Stack traceback for pid 0 
0xc0392ba0        0        0  1    0   R  0xc0392d80 *swapper
EBP        EIP        Function (args)
0xc0419ea8 0xc02d8bc6 rt_run_flush+0x6b (0x0, 0xc0394ce4, 0x0, 0xc42ee, 0x102)
0xc0419ec8 0xc02d8d07 rt_cache_flush+0xf5 (0x0, 0xc0326d81, 0x0)
0xc0419edc 0xc02d8d2b rt_secret_rebuild+0x1b (0x0, 0xc1c0c520, 0x0, 0xc42ee, 0xc
0419f00) 
0xc0419f18 0xc0129344 run_timer_softirq+0xd4 (0xc040f308, 0x0, 0xa, 0xc1c0b2e0, 
0x46) 
0xc0419f38 0xc0125115 __do_softirq+0xc1 (0xc1c0b2e0, 0x0)
0xc0419f48 0xc0125175 do_softirq+0x4b (0xc044d98c) 
0xc0419f54 0xc012525f irq_exit+0x47 (0x0, 0xc0419f7c, 0xc044d988, 0xc0100d19, 0x
c0418000) 
0xc0419f74 0xc01139cc smp_apic_timer_interrupt+0x6f (0xc0100d19, 0x1, 0xc0418000
, 0xc0418000, 0xc044d380) 
0xc0419fb0 0xc0103954 apic_timer_interrupt+0x1c (0x602080b, 0x9f300, 0xc040c800)
            0xc0100e10 cpu_idle+0x89 
0xc0419fd8 0xc01002dd _stext+0x45

