Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932405AbWCUKcg@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932405AbWCUKcg (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 21 Mar 2006 05:32:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932407AbWCUKcf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 21 Mar 2006 05:32:35 -0500
Received: from mgw1.diku.dk ([130.225.96.91]:33231 "EHLO mgw1.diku.dk")
	by vger.kernel.org with ESMTP id S932404AbWCUKce (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 21 Mar 2006 05:32:34 -0500
Date: Tue, 21 Mar 2006 11:29:16 +0100 (CET)
From: Jesper Dangaard Brouer <hawk@diku.dk>
To: Dipankar Sarma <dipankar@in.ibm.com>
Cc: Robert Olsson <Robert.Olsson@data.slu.se>, jens.laas@data.slu.se,
       hans.liss@its.uu.se, linux-net@vger.kernel.org,
       linux-kernel@vger.kernel.org
Subject: Re: Kernel panic: Route cache, RCU, possibly FIB trie.
In-Reply-To: <20060320220956.GA24792@in.ibm.com>
Message-ID: <Pine.LNX.4.61.0603211113550.15500@ask.diku.dk>
References: <Pine.LNX.4.61.0603202234400.27140@ask.diku.dk>
 <20060320220956.GA24792@in.ibm.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Tue, 21 Mar 2006, Dipankar Sarma wrote:

> On Mon, Mar 20, 2006 at 10:44:21PM +0100, Jesper Dangaard Brouer wrote:
>>
>> Kernel panic report.
>>
>> Have experienced some kernel panic's on a production Linux box acting
>> as a router for a large number of customers.
>>
>> I have tried to track down the problem, and I think I have narrowed it
>> a bit down.  My theory is that it is related to the route cache
>> (ip_dst_cache) or FIB, which cannot dealloacate route cache slab
>> elements (maybe RCU related).  (I have seen my route cache increase to
>> around 520k entries using rtstat, before dying).
>>
>> I'm using the FIB trie system/algorithm (CONFIG_IP_FIB_TRIE). Think
>> that the error might be cause by the "fib_trie" code.  See the syslog,
>> output below.
>>
>> Below are some kernel panic outputs from the console and some
>> interesting errors found in syslog.
>>
>> Kernel panic#1
>> --------------
>> EIP is at _stext+0x3feffd68/0x49
>>        c03f7380
>> Call Trace:
>>  [<c0103cc7>] show_stack+0x80/0x96
>>  [<c0103e60>] show_registers+0x161/0x1c5
>>  [<c0104057>] die+0x107/0x186
>>  [<c0116c5f>] do_page_fault+0x2c6/0x57d
>>  [<c0103997>] error_code+0x4f/0x54
>>  [<c012fe7b>] __rcu_process_callbacks+0xaa/0xd3
>>  [<c012feff>] rcu_process_callbacks+0x5b/0x65
>>  [<c0124578>] tasklet_action+0x77/0xc9
>>  [<c01241f1>] __do_softirq+0xc1/0xd6
>>  [<c0124251>] do_softirq+0x4b/0x4d
>>  [<c012433b>] irq_exit+0x47/0x49
>>  [<c010533b>] do_IRQ+0x2b/0x3b
>>  [<c010383e>] common_interrupt+0x1a/0x20
>> Code:  Bad EIP value.
>>  <0>Kernel panic - not syncing: Fatal exception in interrupt
>
> Bad eip in processing rcu callback often indicates that the object
> that embeds the rcu_head has already been freed. Can you enable
> slab debugging and see if this can be detected there in a different
> path ?

I have enabled slab debugging (CONFIG_DEBUG_SLAB=y) on my kernel with the 
KDB patch applied (and all of the other debugging options I could find).

If you look (in my original mail and below) on the output from "Kernel 
panic#3", there is a different code path which also fail.  Related to 
route cache flushing.


Do you have an explaination of the syslog listing, showing yet another 
code path sleeping/failing??.  In the fib_trie code. (I have recorded 12 
of these).

Hilsen
   Jesper Brouer

--
-------------------------------------------------------------------
Cand. scient datalog
Dept. of Computer Science, University of Copenhagen
-------------------------------------------------------------------


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



Kernel panic#3 with KDB
--------------
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
0xc0419edc 0xc02d8d2b rt_secret_rebuild+0x1b (0x0, 0xc1c0c520, 0x0, 0xc42ee, 0xc0419f00)
0xc0419f18 0xc0129344 run_timer_softirq+0xd4 (0xc040f308, 0x0, 0xa, 0xc1c0b2e0,0x46)
0xc0419f38 0xc0125115 __do_softirq+0xc1 (0xc1c0b2e0, 0x0)
0xc0419f48 0xc0125175 do_softirq+0x4b (0xc044d98c)
0xc0419f54 0xc012525f irq_exit+0x47 (0x0, 0xc0419f7c, 0xc044d988, 0xc0100d19, 0xc0418000)
0xc0419f74 0xc01139cc smp_apic_timer_interrupt+0x6f (0xc0100d19, 0x1, 0xc0418000, 0xc0418000, 0xc044d380)
0xc0419fb0 0xc0103954 apic_timer_interrupt+0x1c (0x602080b, 0x9f300, 0xc040c800)
            0xc0100e10 cpu_idle+0x89
0xc0419fd8 0xc01002dd _stext+0x45


