Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750805AbWCMNtU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750805AbWCMNtU (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 13 Mar 2006 08:49:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750813AbWCMNtT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 13 Mar 2006 08:49:19 -0500
Received: from zproxy.gmail.com ([64.233.162.197]:53834 "EHLO zproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1750805AbWCMNtQ convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 13 Mar 2006 08:49:16 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=Uy0M0IX/+s6q0F8p678iilRwwfCdvSpruFSLZdBfSLkydZAmrOEYdHUqwkrZ08CHnkx38G1xweCGZLxQYAqxxPoPCmr5WvOvKFxp9fbvecyF7jpanbJZ520bGsfHq6OMBQbm83Ke8Gq2UUMl6hLZJIZ9GwzCudzFGiBndmCrpaQ=
Message-ID: <6bffcb0e0603130549v468d1d6fn@mail.gmail.com>
Date: Mon, 13 Mar 2006 14:49:15 +0100
From: "Michal Piotrowski" <michal.k.k.piotrowski@gmail.com>
To: "Ingo Molnar" <mingo@elte.hu>
Subject: Re: 2.6.16-rc6-rt1
Cc: linux-kernel@vger.kernel.org, tb10alj@tglx.de, tglx@linutronix.de
In-Reply-To: <20060313092501.GA10931@elte.hu>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <20060312220218.GA3469@elte.hu>
	 <6bffcb0e0603121517s79f6a0e9i@mail.gmail.com>
	 <20060313092501.GA10931@elte.hu>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 13/03/06, Ingo Molnar <mingo@elte.hu> wrote:
> ok - i have applied Jan Altenberg's patch (which should fix this
> problem), and have released 2.6.16-rc6-rt2.
>
>         Ingo
>

Thanks!

[1.] One line summary of the problem:
BUG: scheduling while atomic + OOPS

[4.] Kernel version (from /proc/version):
Linux version 2.6.16-rc6-rt2 (michal@ltg01-sid) (gcc version 4.1.0
(Debian 4.1.0-0)) #7 SMP PREEMPT Mon Mar 13 14:11:11 CET 2006

[5.] Most recent kernel version which did not have the bug:
2.6.15-rt21, 2.6.16-rc6

[6.] Output of Oops
Time: tsc clocksource has been installed.
BUG: scheduling while atomic: softirq-timer/0/0x00000001/4
caller is schedule+0xdb/0x101
 [<c10044f9>] show_trace+0x18/0x1d (20)
 [<c1004555>] dump_stack+0x1d/0x21 (20)
 [<c11bcf77>] __schedule+0x71/0xfd3 (156)
 [<c11be101>] schedule+0xdb/0x101 (20)
 [<c11bee24>] rt_lock_slowlock+0x126/0x1c5 (96)
 [<c11bf4b7>] rt_lock+0x10/0x12 (8)
 [<c105c279>] __kmalloc_track_caller+0xa7/0x112 (32)
 [<c10e96c9>] soft_cursor+0x55/0x170 (56)
 [<c10e958b>] bit_cursor+0x471/0x486 (156)
 [<c10e4b24>] fbcon_cursor+0x218/0x24d (68)
 [<c1124c83>] hide_cursor+0x22/0x61 (20)
 [<c1128713>] vt_console_print+0x91/0x207 (28)
 [<c101b7b4>] __call_console_drivers+0x42/0x59 (32)
 [<c101b829>] _call_console_drivers+0x5e/0x67 (24)
 [<c101bd4c>] release_console_sem+0x110/0x1da (40)
 [<c101bab9>] vprintk+0x278/0x2ad (116)
 [<c101bb08>] printk+0x1a/0x1c (20)
 [<c103941b>] timeofday_periodic_hook+0x4db/0x772 (140)
 [<c1023cb8>] run_timer_softirq+0x313/0x39a (40)
 [<c1020c38>] ksoftirqd+0x109/0x199 (32)
 [<c102d2ba>] kthread+0xa7/0xd5 (36)
 [<c1000dd5>] kernel_thread_helper+0x5/0xb (1030828060)
---------------------------
| preempt count: 00000001 ]
| 1-level deep critical section nesting:
----------------------------------------
.. [<c11bf646>] .... _raw_spin_lock+0x12/0x26
.....[<c1038f6b>] ..   ( <= timeofday_periodic_hook+0x2b/0x772)

------------------------------
| showing all locks held by: |  (softirq-timer/0/4 [c28eb8c0,  98]):
------------------------------

#001:             [c1217204] {console_sem.lock}
... acquired at:               rt_down_trylock+0x16/0x3c

BUG: scheduling while atomic: softirq-timer/0/0x00000001/4
caller is schedule+0xdb/0x101
 [<c10044f9>] show_trace+0x18/0x1d (20)
 [<c1004555>] dump_stack+0x1d/0x21 (20)
 [<c11bcf77>] __schedule+0x71/0xfd3 (156)
 [<c11be101>] schedule+0xdb/0x101 (20)
 [<c11bee24>] rt_lock_slowlock+0x126/0x1c5 (96)
 [<c11bf4b7>] rt_lock+0x10/0x12 (8)
 [<c105cdf7>] kfree+0x36/0x88 (24)
 [<c10e97d7>] soft_cursor+0x163/0x170 (76)
 [<c10e958b>] bit_cursor+0x471/0x486 (156)
 [<c10e4b24>] fbcon_cursor+0x218/0x24d (68)
 [<c1124c83>] hide_cursor+0x22/0x61 (20)
 [<c1128713>] vt_console_print+0x91/0x207 (28)
 [<c101b7b4>] __call_console_drivers+0x42/0x59 (32)
 [<c101b829>] _call_console_drivers+0x5e/0x67 (24)
 [<c101bd4c>] release_console_sem+0x110/0x1da (40)
 [<c101bab9>] vprintk+0x278/0x2ad (116)
 [<c101bb08>] printk+0x1a/0x1c (20)
 [<c103941b>] timeofday_periodic_hook+0x4db/0x772 (140)
 [<c1023cb8>] run_timer_softirq+0x313/0x39a (40)
 [<c1020c38>] ksoftirqd+0x109/0x199 (32)
 [<c102d2ba>] kthread+0xa7/0xd5 (36)
 [<c1000dd5>] kernel_thread_helper+0x5/0xb (1030828060)
---------------------------
| preempt count: 00000001 ]
| 1-level deep critical section nesting:
----------------------------------------
.. [<c11bf646>] .... _raw_spin_lock+0x12/0x26
.....[<c10422cf>] ..   ( <= __do_IRQ+0xb0/0xfe)

------------------------------
| showing all locks held by: |  (softirq-timer/0/4 [c28eb8c0,  98]):
------------------------------

#001:             [c1217204] {console_sem.lock}
... acquired at:               rt_down_trylock+0x16/0x3c

BUG: scheduling while atomic: softirq-timer/0/0x00000001/4
caller is schedule+0xdb/0x101
 [<c10044f9>] show_trace+0x18/0x1d (20)
 [<c1004555>] dump_stack+0x1d/0x21 (20)
 [<c11bcf77>] __schedule+0x71/0xfd3 (156)
 [<c11be101>] schedule+0xdb/0x101 (20)
 [<c11bee24>] rt_lock_slowlock+0x126/0x1c5 (96)
 [<c11bf4b7>] rt_lock+0x10/0x12 (8)
 [<c105c279>] __kmalloc_track_caller+0xa7/0x112 (32)
 [<c10e96c9>] soft_cursor+0x55/0x170 (56)
 [<c10e958b>] bit_cursor+0x471/0x486 (156)
 [<c10e4b24>] fbcon_cursor+0x218/0x24d (68)
 [<c10e7c1b>] fbcon_scroll+0xb09/0xb26 (68)
 [<c1124e8e>] scrup+0x51/0xb9 (40)
 [<c1124f19>] lf+0x23/0x45 (28)
 [<c11287c2>] vt_console_print+0x140/0x207 (28)
 [<c101b7b4>] __call_console_drivers+0x42/0x59 (32)
 [<c101b829>] _call_console_drivers+0x5e/0x67 (24)
 [<c101bd4c>] release_console_sem+0x110/0x1da (40)
 [<c101bab9>] vprintk+0x278/0x2ad (116)
 [<c101bb08>] printk+0x1a/0x1c (20)
 [<c103941b>] timeofday_periodic_hook+0x4db/0x772 (140)
 [<c1023cb8>] run_timer_softirq+0x313/0x39a (40)
 [<c1020c38>] ksoftirqd+0x109/0x199 (32)
 [<c102d2ba>] kthread+0xa7/0xd5 (36)
 [<c1000dd5>] kernel_thread_helper+0x5/0xb (1030828060)
---------------------------
| preempt count: 00000001 ]
| 1-level deep critical section nesting:
----------------------------------------
.. [<c11bf646>] .... _raw_spin_lock+0x12/0x26
.....[<c10422cf>] ..   ( <= __do_IRQ+0xb0/0xfe)

------------------------------
| showing all locks held by: |  (softirq-timer/0/4 [c28eb8c0,  98]):
------------------------------

#001:             [c1217204] {console_sem.lock}
... acquired at:               rt_down_trylock+0x16/0x3c

BUG: scheduling while atomic: softirq-timer/0/0x00000001/4
caller is schedule+0xdb/0x101
 [<c10044f9>] show_trace+0x18/0x1d (20)
 [<c1004555>] dump_stack+0x1d/0x21 (20)
 [<c11bcf77>] __schedule+0x71/0xfd3 (156)
 [<c11be101>] schedule+0xdb/0x101 (20)
 [<c11bee24>] rt_lock_slowlock+0x126/0x1c5 (96)
 [<c11bf4b7>] rt_lock+0x10/0x12 (8)
 [<c105c279>] __kmalloc_track_caller+0xa7/0x112 (32)
 [<c10e96c9>] soft_cursor+0x55/0x170 (56)
 [<c10e958b>] bit_cursor+0x471/0x486 (156)
 [<c10e4b24>] fbcon_cursor+0x218/0x24d (68)
 [<c10e7c1b>] fbcon_scroll+0xb09/0xb26 (68)
 [<c1124e8e>] scrup+0x51/0xb9 (40)
 [<c1124f19>] lf+0x23/0x45 (28)
 [<c11287c2>] vt_console_print+0x140/0x207 (28)
 [<c101b7b4>] __call_console_drivers+0x42/0x59 (32)
 [<c101b829>] _call_console_drivers+0x5e/0x67 (24)
 [<c101bd4c>] release_console_sem+0x110/0x1da (40)
 [<c101bab9>] vprintk+0x278/0x2ad (116)
 [<c101bb08>] printk+0x1a/0x1c (20)
 [<c103941b>] timeofday_periodic_hook+0x4db/0x772 (140)
 [<c1023cb8>] run_timer_softirq+0x313/0x39a (40)
 [<c1020c38>] ksoftirqd+0x109/0x199 (32)
 [<c102d2ba>] kthread+0xa7/0xd5 (36)
 [<c1000dd5>] kernel_thread_helper+0x5/0xb (1030828060)
---------------------------
| preempt count: 00000001 ]
| 1-level deep critical section nesting:
----------------------------------------
.. [<c11bf646>] .... _raw_spin_lock+0x12/0x26
.....[<c10422cf>] ..   ( <= __do_IRQ+0xb0/0xfe)

------------------------------
| showing all locks held by: |  (softirq-timer/0/4 [c28eb8c0,  98]):
------------------------------

#001:             [c1217204] {console_sem.lock}
... acquired at:               rt_down_trylock+0x16/0x3c

BUG: scheduling while atomic: softirq-timer/0/0x00000001/4
caller is schedule+0xdb/0x101
 [<c10044f9>] show_trace+0x18/0x1d (20)
 [<c1004555>] dump_stack+0x1d/0x21 (20)
 [<c11bcf77>] __schedule+0x71/0xfd3 (156)
 [<c11be101>] schedule+0xdb/0x101 (20)
 [<c11bee24>] rt_lock_slowlock+0x126/0x1c5 (96)
 [<c11bf4b7>] rt_lock+0x10/0x12 (8)
 [<c105cdf7>] kfree+0x36/0x88 (24)
 [<c10e97d7>] soft_cursor+0x163/0x170 (76)
 [<c10e958b>] bit_cursor+0x471/0x486 (156)
 [<c10e4b24>] fbcon_cursor+0x218/0x24d (68)
 [<c10e7c1b>] fbcon_scroll+0xb09/0xb26 (68)
 [<c1124e8e>] scrup+0x51/0xb9 (40)
 [<c1124f19>] lf+0x23/0x45 (28)
 [<c11287c2>] vt_console_print+0x140/0x207 (28)
 [<c101b7b4>] __call_console_drivers+0x42/0x59 (32)
 [<c101b829>] _call_console_drivers+0x5e/0x67 (24)
 [<c101bd4c>] release_console_sem+0x110/0x1da (40)
 [<c101bab9>] vprintk+0x278/0x2ad (116)
 [<c101bb08>] printk+0x1a/0x1c (20)
 [<c103941b>] timeofday_periodic_hook+0x4db/0x772 (140)
 [<c1023cb8>] run_timer_softirq+0x313/0x39a (40)
 [<c1020c38>] ksoftirqd+0x109/0x199 (32)
 [<c102d2ba>] kthread+0xa7/0xd5 (36)
 [<c1000dd5>] kernel_thread_helper+0x5/0xb (1030828060)
---------------------------
| preempt count: 00000001 ]
| 1-level deep critical section nesting:
----------------------------------------
.. [<c11bf646>] .... _raw_spin_lock+0x12/0x26
.....[<c10422cf>] ..   ( <= __do_IRQ+0xb0/0xfe)

------------------------------
| showing all locks held by: |  (softirq-timer/0/4 [c28eb8c0,  98]):
------------------------------

#001:             [c1217204] {console_sem.lock}
... acquired at:               rt_down_trylock+0x16/0x3c

BUG: scheduling while atomic: softirq-timer/0/0x00000001/4
caller is schedule+0xdb/0x101
 [<c10044f9>] show_trace+0x18/0x1d (20)
 [<c1004555>] dump_stack+0x1d/0x21 (20)
 [<c11bcf77>] __schedule+0x71/0xfd3 (156)
 [<c11be101>] schedule+0xdb/0x101 (20)
 [<c11bee24>] rt_lock_slowlock+0x126/0x1c5 (96)
 [<c11bf4b7>] rt_lock+0x10/0x12 (8)
 [<c105cdf7>] kfree+0x36/0x88 (24)
 [<c10e97d7>] soft_cursor+0x163/0x170 (76)
 [<c10e958b>] bit_cursor+0x471/0x486 (156)
 [<c10e4b24>] fbcon_cursor+0x218/0x24d (68)
 [<c10e7c1b>] fbcon_scroll+0xb09/0xb26 (68)
 [<c1124e8e>] scrup+0x51/0xb9 (40)
 [<c1124f19>] lf+0x23/0x45 (28)
 [<c11287c2>] vt_console_print+0x140/0x207 (28)
 [<c101b7b4>] __call_console_drivers+0x42/0x59 (32)
 [<c101b829>] _call_console_drivers+0x5e/0x67 (24)
 [<c101bd4c>] release_console_sem+0x110/0x1da (40)
 [<c101bab9>] vprintk+0x278/0x2ad (116)
 [<c101bb08>] printk+0x1a/0x1c (20)
 [<c103941b>] timeofday_periodic_hook+0x4db/0x772 (140)
 [<c1023cb8>] run_timer_softirq+0x313/0x39a (40)
 [<c1020c38>] ksoftirqd+0x109/0x199 (32)
 [<c102d2ba>] kthread+0xa7/0xd5 (36)
 [<c1000dd5>] kernel_thread_helper+0x5/0xb (1030828060)
---------------------------
| preempt count: 00000001 ]
| 1-level deep critical section nesting:
----------------------------------------
.. [<c11bf646>] .... _raw_spin_lock+0x12/0x26
.....[<c10422cf>] ..   ( <= __do_IRQ+0xb0/0xfe)

------------------------------
| showing all locks held by: |  (softirq-timer/0/4 [c28eb8c0,  98]):
------------------------------

#001:             [c1217204] {console_sem.lock}
... acquired at:               rt_down_trylock+0x16/0x3c


This is from klog. System hangs on that.

Mar 13 14:31:37 ltg01-sid kernel: BUG: Unable to handle kernel NULL
pointer dereference at virtual address 00000054
Mar 13 14:31:37 ltg01-sid kernel:  printing eip:
Mar 13 14:31:37 ltg01-sid kernel: c10308d5
Mar 13 14:31:37 ltg01-sid kernel: *pde = 00000000
Mar 13 14:31:37 ltg01-sid kernel: Oops: 0002 [#1]
Mar 13 14:31:37 ltg01-sid kernel: PREEMPT SMP DEBUG_PAGEALLOC
Mar 13 14:31:37 ltg01-sid kernel: Modules linked in: thermal fan
processor evdev snd_intel8x0 snd_ac97_codec snd_ac97_bus snd_pcm_oss
snd_mixe
r_oss snd_pcm snd_timer snd 8250_pnp 8250 serial_core parport_pc
parport rtc soundcore snd_page_alloc sk98lin skge hw_random i2c_i801
ide_cd c
drom intel_agp agpgart unix
Mar 13 14:31:37 ltg01-sid kernel: CPU:    0
Mar 13 14:31:37 ltg01-sid kernel: EIP:    0060:[unqueue_me+113/312]   
Not tainted VLI
Mar 13 14:31:37 ltg01-sid kernel: EFLAGS: 00010202   (2.6.16-rc6-rt2 #7)
Mar 13 14:31:37 ltg01-sid kernel: EIP is at unqueue_me+0x71/0x138
Mar 13 14:31:37 ltg01-sid kernel: eax: c136dbc4   ebx: 00000008   ecx:
00000202   edx: c136dbc4
Mar 13 14:31:37 ltg01-sid kernel: esi: f15deec8   edi: c136db80   ebp:
f15dede4   esp: f15dedd4
Mar 13 14:31:37 ltg01-sid kernel: ds: 007b   es: 007b   ss: 0068  
preempt: 00000001
Mar 13 14:31:37 ltg01-sid kernel: Process firefox-bin (pid: 2737,
threadinfo=f15de000 task=f12998c0 stack_left=3488 worst_left=-1)
Mar 13 14:31:37 ltg01-sid kernel: Stack: <0>c1023f23 00000000 f15de000
f15deec8 f15def7c c1031229 f15deec8 00000000
Mar 13 14:31:37 ltg01-sid kernel:        f12998c0 00000000 00000000
00000000 00000000 00000000 00000000 00000000
Mar 13 14:31:37 ltg01-sid kernel:        00000000 00000000 00000000
00000000 00000000 00000000 00000000 00000000
Mar 13 14:31:37 ltg01-sid kernel: Call Trace:
Mar 13 14:31:37 ltg01-sid kernel:  [show_stack_log_lvl+173/184]
show_stack_log_lvl+0xad/0xb8 (44)
Mar 13 14:31:37 ltg01-sid kernel:  [show_registers+349/473]
show_registers+0x15d/0x1d9 (68)
Mar 13 14:31:37 ltg01-sid kernel:  [die+359/497] die+0x167/0x1f1 (60)
Mar 13 14:31:37 ltg01-sid kernel:  [do_page_fault+902/1177]
do_page_fault+0x386/0x499 (72)
Mar 13 14:31:37 ltg01-sid kernel:  [error_code+79/84] error_code+0x4f/0x54 (76)
Mar 13 14:31:37 ltg01-sid kernel:  [do_futex+479/3658]
do_futex+0x1df/0xe4a (408)
Mar 13 14:31:37 ltg01-sid kernel:  [sys_futex+179/194] sys_futex+0xb3/0xc2 (56)
Mar 13 14:31:37 ltg01-sid kernel:  [syscall_call+7/11]
syscall_call+0x7/0xb (-4020)
Mar 13 14:31:37 ltg01-sid kernel: ---------------------------
Mar 13 14:31:37 ltg01-sid kernel: | preempt count: 00000001 ]
Mar 13 14:31:37 ltg01-sid kernel: | 1-level deep critical section nesting:
Mar 13 14:31:37 ltg01-sid kernel: ----------------------------------------
Mar 13 14:31:37 ltg01-sid kernel: .. [_raw_spin_lock+18/38] ....
_raw_spin_lock+0x12/0x26
Mar 13 14:31:37 ltg01-sid kernel: .....[__do_IRQ+176/254] ..   ( <=
__do_IRQ+0xb0/0xfe)

Mar 13 14:31:37 ltg01-sid kernel:
Mar 13 14:31:37 ltg01-sid kernel: ------------------------------
Mar 13 14:31:37 ltg01-sid kernel: | showing all locks held by: | 
(firefox-bin/2737 [f12998c0, 116]):
Mar 13 14:31:37 ltg01-sid kernel: ------------------------------
Mar 13 14:31:37 ltg01-sid kernel:
Mar 13 14:31:37 ltg01-sid kernel: #001:             [c136db80]
{&futex_queues[i].lock}
Mar 13 14:31:37 ltg01-sid kernel: ... acquired at:              
unqueue_me+0x26/0x138
Mar 13 14:31:37 ltg01-sid kernel:
Mar 13 14:31:37 ltg01-sid kernel: Code: c1 e8 a2 bb fe ff 83 c4 0c 8b
16 8b 46 04 89 42 04 89 10 c7 06 00 01 10 00 c7 46 04 00 02 20 00 8b
5e
6c 85 db 0f 84 a1 00 00 00 <f0> ff 4b 4c 0f 94 c0 84 c0 0f 84 92 00 00
00 8b 43 4c 85 c0 74
Mar 13 14:31:37 ltg01-sid kernel:  BUG: nonzero lock count 1 at exit time?
Mar 13 14:31:37 ltg01-sid kernel:      firefox-bin: 2737 [f12998c0, 116]
Mar 13 14:31:37 ltg01-sid kernel:  [show_trace+24/29] show_trace+0x18/0x1d (20)
Mar 13 14:31:37 ltg01-sid kernel:  [dump_stack+29/33] dump_stack+0x1d/0x21 (20)
Mar 13 14:31:37 ltg01-sid kernel: 
[rt_mutex_debug_check_no_locks_held+95/693]
rt_mutex_debug_check_no_locks_held+0x5f/0x2b5 (44)
Mar 13 14:31:37 ltg01-sid kernel:  [do_exit+2056/2183] do_exit+0x808/0x887 (52)
Mar 13 14:31:37 ltg01-sid kernel:  [show_stack+0/29] show_stack+0x0/0x1d (44)
Mar 13 14:31:37 ltg01-sid kernel:  [do_page_fault+902/1177]
do_page_fault+0x386/0x499 (72)
Mar 13 14:31:37 ltg01-sid kernel:  [error_code+79/84] error_code+0x4f/0x54 (76)
Mar 13 14:31:37 ltg01-sid kernel:  [do_futex+479/3658]
do_futex+0x1df/0xe4a (408)
Mar 13 14:31:37 ltg01-sid kernel:  [sys_futex+179/194] sys_futex+0xb3/0xc2 (56)
Mar 13 14:31:37 ltg01-sid kernel:  [syscall_call+7/11]
syscall_call+0x7/0xb (-4020)
Mar 13 14:31:37 ltg01-sid kernel: ---------------------------
Mar 13 14:31:37 ltg01-sid kernel: | preempt count: 00000000 ]
Mar 13 14:31:37 ltg01-sid kernel: | 0-level deep critical section nesting:
Mar 13 14:31:37 ltg01-sid kernel: ----------------------------------------
Mar 13 14:31:37 ltg01-sid kernel:
Mar 13 14:31:37 ltg01-sid kernel: ------------------------------
Mar 13 14:31:37 ltg01-sid kernel: | showing all locks held by: | 
(firefox-bin/2737 [f12998c0, 116]):
Mar 13 14:31:37 ltg01-sid kernel: ------------------------------
Mar 13 14:31:37 ltg01-sid kernel:
Mar 13 14:31:37 ltg01-sid kernel: #001:             [c136db80]
{&futex_queues[i].lock}
Mar 13 14:31:37 ltg01-sid kernel: ... acquired at:              
unqueue_me+0x26/0x138
Mar 13 14:31:37 ltg01-sid kernel:
Mar 13 14:31:37 ltg01-sid kernel: BUG: firefox-bin/2737, lock held at
task exit time!
Mar 13 14:31:37 ltg01-sid kernel:  [c136db80] {&futex_queues[i].lock}
Mar 13 14:31:37 ltg01-sid kernel: .. ->owner: f12998c0
Mar 13 14:31:37 ltg01-sid kernel: .. held by:       firefox-bin: 2737
[f12998c0, 116]
Mar 13 14:31:38 ltg01-sid kernel: ... acquired at:              
unqueue_me+0x26/0x138
Mar 13 14:31:45 ltg01-sid kernel: Could not allocate 4 bytes percpu data


[9.] Config file
#
# Automatically generated make config: don't edit
# Linux kernel version: 2.6.16-rc6-rt2
# Mon Mar 13 13:53:57 2006
#
CONFIG_X86_32=y
CONFIG_GENERIC_TIME=y
CONFIG_SEMAPHORE_SLEEPERS=y
CONFIG_X86=y
CONFIG_MMU=y
CONFIG_GENERIC_ISA_DMA=y
CONFIG_GENERIC_IOMAP=y
CONFIG_ARCH_MAY_HAVE_PC_FDC=y
CONFIG_DMI=y

#
# Code maturity level options
#
CONFIG_EXPERIMENTAL=y
CONFIG_LOCK_KERNEL=y
CONFIG_INIT_ENV_ARG_LIMIT=32

#
# General setup
#
CONFIG_LOCALVERSION=""
CONFIG_LOCALVERSION_AUTO=y
CONFIG_SWAP=y
CONFIG_SYSVIPC=y
CONFIG_POSIX_MQUEUE=y
CONFIG_BSD_PROCESS_ACCT=y
CONFIG_BSD_PROCESS_ACCT_V3=y
CONFIG_SYSCTL=y
CONFIG_AUDIT=y
CONFIG_AUDITSYSCALL=y
CONFIG_IKCONFIG=y
CONFIG_IKCONFIG_PROC=y
# CONFIG_CPUSETS is not set
CONFIG_INITRAMFS_SOURCE=""
CONFIG_UID16=y
CONFIG_VM86=y
CONFIG_CC_OPTIMIZE_FOR_SIZE=y
# CONFIG_EMBEDDED is not set
CONFIG_KALLSYMS=y
# CONFIG_KALLSYMS_ALL is not set
# CONFIG_KALLSYMS_EXTRA_PASS is not set
CONFIG_HOTPLUG=y
CONFIG_PRINTK=y
CONFIG_BUG=y
CONFIG_ELF_CORE=y
CONFIG_BASE_FULL=y
CONFIG_RT_MUTEXES=y
CONFIG_FUTEX=y
CONFIG_EPOLL=y
CONFIG_SHMEM=y
CONFIG_CC_ALIGN_FUNCTIONS=0
CONFIG_CC_ALIGN_LABELS=0
CONFIG_CC_ALIGN_LOOPS=0
CONFIG_CC_ALIGN_JUMPS=0
CONFIG_SLAB=y
# CONFIG_TINY_SHMEM is not set
CONFIG_BASE_SMALL=0
# CONFIG_SLOB is not set

#
# Loadable module support
#
CONFIG_MODULES=y
CONFIG_MODULE_UNLOAD=y
CONFIG_MODULE_FORCE_UNLOAD=y
CONFIG_OBSOLETE_MODPARM=y
# CONFIG_MODVERSIONS is not set
CONFIG_MODULE_SRCVERSION_ALL=y
CONFIG_KMOD=y
CONFIG_STOP_MACHINE=y

#
# Block layer
#
# CONFIG_LBD is not set

#
# IO Schedulers
#
CONFIG_IOSCHED_NOOP=y
CONFIG_IOSCHED_AS=y
CONFIG_IOSCHED_DEADLINE=m
CONFIG_IOSCHED_CFQ=m
CONFIG_DEFAULT_AS=y
# CONFIG_DEFAULT_DEADLINE is not set
# CONFIG_DEFAULT_CFQ is not set
# CONFIG_DEFAULT_NOOP is not set
CONFIG_DEFAULT_IOSCHED="anticipatory"

#
# Processor type and features
#
CONFIG_X86_PC=y
# CONFIG_X86_ELAN is not set
# CONFIG_X86_VOYAGER is not set
# CONFIG_X86_NUMAQ is not set
# CONFIG_X86_SUMMIT is not set
# CONFIG_X86_BIGSMP is not set
# CONFIG_X86_VISWS is not set
# CONFIG_X86_GENERICARCH is not set
# CONFIG_X86_ES7000 is not set
# CONFIG_M386 is not set
# CONFIG_M486 is not set
# CONFIG_M586 is not set
# CONFIG_M586TSC is not set
# CONFIG_M586MMX is not set
# CONFIG_M686 is not set
# CONFIG_MPENTIUMII is not set
# CONFIG_MPENTIUMIII is not set
# CONFIG_MPENTIUMM is not set
CONFIG_MPENTIUM4=y
# CONFIG_MK6 is not set
# CONFIG_MK7 is not set
# CONFIG_MK8 is not set
# CONFIG_MCRUSOE is not set
# CONFIG_MEFFICEON is not set
# CONFIG_MWINCHIPC6 is not set
# CONFIG_MWINCHIP2 is not set
# CONFIG_MWINCHIP3D is not set
# CONFIG_MGEODEGX1 is not set
# CONFIG_MGEODE_LX is not set
# CONFIG_MCYRIXIII is not set
# CONFIG_MVIAC3_2 is not set
# CONFIG_X86_GENERIC is not set
CONFIG_X86_CMPXCHG=y
CONFIG_X86_XADD=y
CONFIG_X86_L1_CACHE_SHIFT=7
CONFIG_RWSEM_GENERIC_SPINLOCK=y
CONFIG_GENERIC_CALIBRATE_DELAY=y
CONFIG_X86_WP_WORKS_OK=y
CONFIG_X86_INVLPG=y
CONFIG_X86_BSWAP=y
CONFIG_X86_POPAD_OK=y
CONFIG_X86_CMPXCHG64=y
CONFIG_X86_GOOD_APIC=y
CONFIG_X86_INTEL_USERCOPY=y
CONFIG_X86_USE_PPRO_CHECKSUM=y
CONFIG_X86_TSC=y
# CONFIG_HPET_TIMER is not set
CONFIG_HIGH_RES_TIMERS=y
CONFIG_HIGH_RES_RESOLUTION=1000
CONFIG_SMP=y
CONFIG_NR_CPUS=2
CONFIG_SCHED_SMT=y
# CONFIG_PREEMPT_NONE is not set
# CONFIG_PREEMPT_VOLUNTARY is not set
# CONFIG_PREEMPT_DESKTOP is not set
CONFIG_PREEMPT_RT=y
CONFIG_PREEMPT=y
CONFIG_PREEMPT_SOFTIRQS=y
CONFIG_PREEMPT_HARDIRQS=y
CONFIG_PREEMPT_BKL=y
# CONFIG_CLASSIC_RCU is not set
CONFIG_PREEMPT_RCU=y
CONFIG_RCU_STATS=y
CONFIG_ASM_SEMAPHORES=y
CONFIG_X86_LOCAL_APIC=y
CONFIG_X86_IO_APIC=y
CONFIG_X86_MCE=y
CONFIG_X86_MCE_NONFATAL=m
CONFIG_X86_MCE_P4THERMAL=y
# CONFIG_TOSHIBA is not set
# CONFIG_I8K is not set
# CONFIG_X86_REBOOTFIXUPS is not set
CONFIG_MICROCODE=m
CONFIG_X86_MSR=m
CONFIG_X86_CPUID=m

#
# Firmware Drivers
#
# CONFIG_EDD is not set
# CONFIG_DELL_RBU is not set
# CONFIG_DCDBAS is not set
# CONFIG_NOHIGHMEM is not set
CONFIG_HIGHMEM4G=y
# CONFIG_HIGHMEM64G is not set
CONFIG_VMSPLIT_3G=y
# CONFIG_VMSPLIT_3G_OPT is not set
# CONFIG_VMSPLIT_2G is not set
# CONFIG_VMSPLIT_1G is not set
CONFIG_PAGE_OFFSET=0xC0000000
CONFIG_HIGHMEM=y
CONFIG_ARCH_FLATMEM_ENABLE=y
CONFIG_ARCH_SPARSEMEM_ENABLE=y
CONFIG_ARCH_SELECT_MEMORY_MODEL=y
CONFIG_SELECT_MEMORY_MODEL=y
CONFIG_FLATMEM_MANUAL=y
# CONFIG_DISCONTIGMEM_MANUAL is not set
# CONFIG_SPARSEMEM_MANUAL is not set
CONFIG_FLATMEM=y
CONFIG_FLAT_NODE_MEM_MAP=y
CONFIG_SPARSEMEM_STATIC=y
CONFIG_SPLIT_PTLOCK_CPUS=4
# CONFIG_HIGHPTE is not set
# CONFIG_MATH_EMULATION is not set
CONFIG_MTRR=y
# CONFIG_EFI is not set
CONFIG_IRQBALANCE=y
CONFIG_SECCOMP=y
# CONFIG_HZ_100 is not set
# CONFIG_HZ_250 is not set
CONFIG_HZ_1000=y
CONFIG_HZ=1000
CONFIG_KEXEC=y
CONFIG_CRASH_DUMP=y
CONFIG_PHYSICAL_START=0x1000000
# CONFIG_HOTPLUG_CPU is not set
CONFIG_DOUBLEFAULT=y

#
# Power management options (ACPI, APM)
#
CONFIG_PM=y
# CONFIG_PM_LEGACY is not set
# CONFIG_PM_DEBUG is not set

#
# ACPI (Advanced Configuration and Power Interface) Support
#
CONFIG_ACPI=y
# CONFIG_ACPI_AC is not set
# CONFIG_ACPI_BATTERY is not set
# CONFIG_ACPI_BUTTON is not set
# CONFIG_ACPI_VIDEO is not set
# CONFIG_ACPI_HOTKEY is not set
CONFIG_ACPI_FAN=m
CONFIG_ACPI_PROCESSOR=m
CONFIG_ACPI_THERMAL=m
# CONFIG_ACPI_ASUS is not set
# CONFIG_ACPI_IBM is not set
# CONFIG_ACPI_TOSHIBA is not set
CONFIG_ACPI_BLACKLIST_YEAR=0
# CONFIG_ACPI_DEBUG is not set
CONFIG_ACPI_EC=y
CONFIG_ACPI_POWER=y
CONFIG_ACPI_SYSTEM=y
CONFIG_X86_PM_TIMER=y
# CONFIG_ACPI_CONTAINER is not set

#
# APM (Advanced Power Management) BIOS Support
#
# CONFIG_APM is not set

#
# CPU Frequency scaling
#
CONFIG_CPU_FREQ=y
CONFIG_CPU_FREQ_TABLE=m
# CONFIG_CPU_FREQ_DEBUG is not set
CONFIG_CPU_FREQ_STAT=m
CONFIG_CPU_FREQ_STAT_DETAILS=y
CONFIG_CPU_FREQ_DEFAULT_GOV_PERFORMANCE=y
# CONFIG_CPU_FREQ_DEFAULT_GOV_USERSPACE is not set
CONFIG_CPU_FREQ_GOV_PERFORMANCE=y
CONFIG_CPU_FREQ_GOV_POWERSAVE=m
CONFIG_CPU_FREQ_GOV_USERSPACE=m
CONFIG_CPU_FREQ_GOV_ONDEMAND=m
CONFIG_CPU_FREQ_GOV_CONSERVATIVE=m

#
# CPUFreq processor drivers
#
CONFIG_X86_ACPI_CPUFREQ=m
# CONFIG_X86_POWERNOW_K6 is not set
# CONFIG_X86_POWERNOW_K7 is not set
# CONFIG_X86_POWERNOW_K8 is not set
# CONFIG_X86_GX_SUSPMOD is not set
# CONFIG_X86_SPEEDSTEP_CENTRINO is not set
# CONFIG_X86_SPEEDSTEP_ICH is not set
# CONFIG_X86_SPEEDSTEP_SMI is not set
CONFIG_X86_P4_CLOCKMOD=m
# CONFIG_X86_CPUFREQ_NFORCE2 is not set
# CONFIG_X86_LONGRUN is not set
# CONFIG_X86_LONGHAUL is not set

#
# shared options
#
# CONFIG_X86_ACPI_CPUFREQ_PROC_INTF is not set
CONFIG_X86_SPEEDSTEP_LIB=m

#
# Bus options (PCI, PCMCIA, EISA, MCA, ISA)
#
CONFIG_PCI=y
# CONFIG_PCI_GOBIOS is not set
# CONFIG_PCI_GOMMCONFIG is not set
# CONFIG_PCI_GODIRECT is not set
CONFIG_PCI_GOANY=y
CONFIG_PCI_BIOS=y
CONFIG_PCI_DIRECT=y
CONFIG_PCI_MMCONFIG=y
# CONFIG_PCIEPORTBUS is not set
# CONFIG_PCI_MSI is not set
# CONFIG_PCI_LEGACY_PROC is not set
# CONFIG_PCI_DEBUG is not set
CONFIG_ISA_DMA_API=y
# CONFIG_ISA is not set
# CONFIG_MCA is not set
# CONFIG_SCx200 is not set

#
# PCCARD (PCMCIA/CardBus) support
#
# CONFIG_PCCARD is not set

#
# PCI Hotplug Support
#
# CONFIG_HOTPLUG_PCI is not set

#
# Executable file formats
#
CONFIG_BINFMT_ELF=y
CONFIG_BINFMT_AOUT=m
CONFIG_BINFMT_MISC=m

#
# Networking
#
CONFIG_NET=y

#
# Networking options
#
# CONFIG_NETDEBUG is not set
CONFIG_PACKET=m
# CONFIG_PACKET_MMAP is not set
CONFIG_UNIX=m
# CONFIG_NET_KEY is not set
CONFIG_INET=y
# CONFIG_IP_MULTICAST is not set
# CONFIG_IP_ADVANCED_ROUTER is not set
CONFIG_IP_FIB_HASH=y
# CONFIG_IP_PNP is not set
# CONFIG_NET_IPIP is not set
# CONFIG_NET_IPGRE is not set
# CONFIG_ARPD is not set
CONFIG_SYN_COOKIES=y
# CONFIG_INET_AH is not set
# CONFIG_INET_ESP is not set
# CONFIG_INET_IPCOMP is not set
# CONFIG_INET_TUNNEL is not set
CONFIG_INET_DIAG=m
CONFIG_INET_TCP_DIAG=m
# CONFIG_TCP_CONG_ADVANCED is not set
CONFIG_TCP_CONG_BIC=y
CONFIG_IPV6=m
# CONFIG_IPV6_PRIVACY is not set
# CONFIG_INET6_AH is not set
# CONFIG_INET6_ESP is not set
# CONFIG_INET6_IPCOMP is not set
# CONFIG_INET6_TUNNEL is not set
# CONFIG_IPV6_TUNNEL is not set
# CONFIG_NETFILTER is not set

#
# DCCP Configuration (EXPERIMENTAL)
#
# CONFIG_IP_DCCP is not set

#
# SCTP Configuration (EXPERIMENTAL)
#
# CONFIG_IP_SCTP is not set

#
# TIPC Configuration (EXPERIMENTAL)
#
# CONFIG_TIPC is not set
# CONFIG_ATM is not set
# CONFIG_BRIDGE is not set
# CONFIG_VLAN_8021Q is not set
# CONFIG_DECNET is not set
# CONFIG_LLC2 is not set
# CONFIG_IPX is not set
# CONFIG_ATALK is not set
# CONFIG_X25 is not set
# CONFIG_LAPB is not set
# CONFIG_NET_DIVERT is not set
# CONFIG_ECONET is not set
# CONFIG_WAN_ROUTER is not set

#
# QoS and/or fair queueing
#
# CONFIG_NET_SCHED is not set

#
# Network testing
#
# CONFIG_NET_PKTGEN is not set
# CONFIG_HAMRADIO is not set
# CONFIG_IRDA is not set
# CONFIG_BT is not set
# CONFIG_IEEE80211 is not set

#
# Device Drivers
#

#
# Generic Driver Options
#
CONFIG_STANDALONE=y
CONFIG_PREVENT_FIRMWARE_BUILD=y
# CONFIG_FW_LOADER is not set
# CONFIG_DEBUG_DRIVER is not set

#
# Connector - unified userspace <-> kernelspace linker
#
CONFIG_CONNECTOR=m

#
# Memory Technology Devices (MTD)
#
# CONFIG_MTD is not set

#
# Parallel port support
#
CONFIG_PARPORT=m
CONFIG_PARPORT_PC=m
# CONFIG_PARPORT_SERIAL is not set
# CONFIG_PARPORT_PC_FIFO is not set
# CONFIG_PARPORT_PC_SUPERIO is not set
# CONFIG_PARPORT_GSC is not set
# CONFIG_PARPORT_1284 is not set

#
# Plug and Play support
#
CONFIG_PNP=y
# CONFIG_PNP_DEBUG is not set

#
# Protocols
#
CONFIG_PNPACPI=y

#
# Block devices
#
# CONFIG_BLK_DEV_FD is not set
# CONFIG_PARIDE is not set
# CONFIG_BLK_CPQ_DA is not set
# CONFIG_BLK_CPQ_CISS_DA is not set
# CONFIG_BLK_DEV_DAC960 is not set
# CONFIG_BLK_DEV_UMEM is not set
# CONFIG_BLK_DEV_COW_COMMON is not set
CONFIG_BLK_DEV_LOOP=m
CONFIG_BLK_DEV_CRYPTOLOOP=m
# CONFIG_BLK_DEV_NBD is not set
# CONFIG_BLK_DEV_SX8 is not set
# CONFIG_BLK_DEV_UB is not set
# CONFIG_BLK_DEV_RAM is not set
CONFIG_BLK_DEV_RAM_COUNT=16
CONFIG_CDROM_PKTCDVD=m
CONFIG_CDROM_PKTCDVD_BUFFERS=8
CONFIG_CDROM_PKTCDVD_WCACHE=y
# CONFIG_ATA_OVER_ETH is not set

#
# ATA/ATAPI/MFM/RLL support
#
CONFIG_IDE=y
CONFIG_BLK_DEV_IDE=y

#
# Please see Documentation/ide.txt for help/info on IDE drives
#
# CONFIG_BLK_DEV_IDE_SATA is not set
# CONFIG_BLK_DEV_HD_IDE is not set
CONFIG_BLK_DEV_IDEDISK=y
# CONFIG_IDEDISK_MULTI_MODE is not set
CONFIG_BLK_DEV_IDECD=m
# CONFIG_BLK_DEV_IDETAPE is not set
# CONFIG_BLK_DEV_IDEFLOPPY is not set
# CONFIG_BLK_DEV_IDESCSI is not set
CONFIG_IDE_TASK_IOCTL=y

#
# IDE chipset support/bugfixes
#
CONFIG_IDE_GENERIC=y
# CONFIG_BLK_DEV_CMD640 is not set
# CONFIG_BLK_DEV_IDEPNP is not set
CONFIG_BLK_DEV_IDEPCI=y
CONFIG_IDEPCI_SHARE_IRQ=y
# CONFIG_BLK_DEV_OFFBOARD is not set
CONFIG_BLK_DEV_GENERIC=y
# CONFIG_BLK_DEV_OPTI621 is not set
# CONFIG_BLK_DEV_RZ1000 is not set
CONFIG_BLK_DEV_IDEDMA_PCI=y
# CONFIG_BLK_DEV_IDEDMA_FORCED is not set
CONFIG_IDEDMA_PCI_AUTO=y
# CONFIG_IDEDMA_ONLYDISK is not set
# CONFIG_BLK_DEV_AEC62XX is not set
# CONFIG_BLK_DEV_ALI15X3 is not set
# CONFIG_BLK_DEV_AMD74XX is not set
# CONFIG_BLK_DEV_ATIIXP is not set
# CONFIG_BLK_DEV_CMD64X is not set
# CONFIG_BLK_DEV_TRIFLEX is not set
# CONFIG_BLK_DEV_CY82C693 is not set
# CONFIG_BLK_DEV_CS5520 is not set
# CONFIG_BLK_DEV_CS5530 is not set
# CONFIG_BLK_DEV_CS5535 is not set
# CONFIG_BLK_DEV_HPT34X is not set
# CONFIG_BLK_DEV_HPT366 is not set
# CONFIG_BLK_DEV_SC1200 is not set
CONFIG_BLK_DEV_PIIX=y
# CONFIG_BLK_DEV_IT821X is not set
# CONFIG_BLK_DEV_NS87415 is not set
# CONFIG_BLK_DEV_PDC202XX_OLD is not set
# CONFIG_BLK_DEV_PDC202XX_NEW is not set
# CONFIG_BLK_DEV_SVWKS is not set
# CONFIG_BLK_DEV_SIIMAGE is not set
# CONFIG_BLK_DEV_SIS5513 is not set
# CONFIG_BLK_DEV_SLC90E66 is not set
# CONFIG_BLK_DEV_TRM290 is not set
# CONFIG_BLK_DEV_VIA82CXXX is not set
# CONFIG_IDE_ARM is not set
CONFIG_BLK_DEV_IDEDMA=y
# CONFIG_IDEDMA_IVB is not set
CONFIG_IDEDMA_AUTO=y
# CONFIG_BLK_DEV_HD is not set

#
# SCSI device support
#
# CONFIG_RAID_ATTRS is not set
CONFIG_SCSI=y
CONFIG_SCSI_PROC_FS=y

#
# SCSI support type (disk, tape, CD-ROM)
#
CONFIG_BLK_DEV_SD=y
# CONFIG_CHR_DEV_ST is not set
# CONFIG_CHR_DEV_OSST is not set
# CONFIG_BLK_DEV_SR is not set
# CONFIG_CHR_DEV_SG is not set
# CONFIG_CHR_DEV_SCH is not set

#
# Some SCSI devices (e.g. CD jukebox) support multiple LUNs
#
# CONFIG_SCSI_MULTI_LUN is not set
# CONFIG_SCSI_CONSTANTS is not set
# CONFIG_SCSI_LOGGING is not set

#
# SCSI Transport Attributes
#
# CONFIG_SCSI_SPI_ATTRS is not set
CONFIG_SCSI_FC_ATTRS=y
# CONFIG_SCSI_ISCSI_ATTRS is not set
# CONFIG_SCSI_SAS_ATTRS is not set

#
# SCSI low-level drivers
#
# CONFIG_ISCSI_TCP is not set
# CONFIG_BLK_DEV_3W_XXXX_RAID is not set
# CONFIG_SCSI_3W_9XXX is not set
# CONFIG_SCSI_ACARD is not set
# CONFIG_SCSI_AACRAID is not set
# CONFIG_SCSI_AIC7XXX is not set
# CONFIG_SCSI_AIC7XXX_OLD is not set
# CONFIG_SCSI_AIC79XX is not set
# CONFIG_SCSI_DPT_I2O is not set
# CONFIG_MEGARAID_NEWGEN is not set
# CONFIG_MEGARAID_LEGACY is not set
# CONFIG_MEGARAID_SAS is not set
CONFIG_SCSI_SATA=y
# CONFIG_SCSI_SATA_AHCI is not set
# CONFIG_SCSI_SATA_SVW is not set
CONFIG_SCSI_ATA_PIIX=y
# CONFIG_SCSI_SATA_MV is not set
# CONFIG_SCSI_SATA_NV is not set
# CONFIG_SCSI_PDC_ADMA is not set
# CONFIG_SCSI_SATA_QSTOR is not set
# CONFIG_SCSI_SATA_PROMISE is not set
# CONFIG_SCSI_SATA_SX4 is not set
# CONFIG_SCSI_SATA_SIL is not set
# CONFIG_SCSI_SATA_SIL24 is not set
# CONFIG_SCSI_SATA_SIS is not set
# CONFIG_SCSI_SATA_ULI is not set
# CONFIG_SCSI_SATA_VIA is not set
# CONFIG_SCSI_SATA_VITESSE is not set
CONFIG_SCSI_SATA_INTEL_COMBINED=y
# CONFIG_SCSI_BUSLOGIC is not set
# CONFIG_SCSI_DMX3191D is not set
# CONFIG_SCSI_EATA is not set
# CONFIG_SCSI_FUTURE_DOMAIN is not set
# CONFIG_SCSI_GDTH is not set
# CONFIG_SCSI_IPS is not set
# CONFIG_SCSI_INITIO is not set
# CONFIG_SCSI_INIA100 is not set
# CONFIG_SCSI_PPA is not set
# CONFIG_SCSI_IMM is not set
# CONFIG_SCSI_SYM53C8XX_2 is not set
# CONFIG_SCSI_IPR is not set
# CONFIG_SCSI_QLOGIC_FC is not set
# CONFIG_SCSI_QLOGIC_1280 is not set
# CONFIG_SCSI_QLA_FC is not set
# CONFIG_SCSI_LPFC is not set
# CONFIG_SCSI_DC395x is not set
# CONFIG_SCSI_DC390T is not set
# CONFIG_SCSI_NSP32 is not set
# CONFIG_SCSI_DEBUG is not set

#
# Multi-device support (RAID and LVM)
#
# CONFIG_MD is not set

#
# Fusion MPT device support
#
# CONFIG_FUSION is not set
# CONFIG_FUSION_SPI is not set
# CONFIG_FUSION_FC is not set
# CONFIG_FUSION_SAS is not set

#
# IEEE 1394 (FireWire) support
#
# CONFIG_IEEE1394 is not set

#
# I2O device support
#
# CONFIG_I2O is not set

#
# Network device support
#
CONFIG_NETDEVICES=y
# CONFIG_DUMMY is not set
# CONFIG_BONDING is not set
# CONFIG_EQUALIZER is not set
CONFIG_TUN=m
# CONFIG_NET_SB1000 is not set

#
# ARCnet devices
#
# CONFIG_ARCNET is not set

#
# PHY device support
#

#
# Ethernet (10 or 100Mbit)
#
# CONFIG_NET_ETHERNET is not set

#
# Ethernet (1000 Mbit)
#
# CONFIG_ACENIC is not set
# CONFIG_DL2K is not set
# CONFIG_E1000 is not set
# CONFIG_NS83820 is not set
# CONFIG_HAMACHI is not set
# CONFIG_YELLOWFIN is not set
# CONFIG_R8169 is not set
# CONFIG_SIS190 is not set
CONFIG_SKGE=m
# CONFIG_SKY2 is not set
CONFIG_SK98LIN=m
# CONFIG_TIGON3 is not set
# CONFIG_BNX2 is not set

#
# Ethernet (10000 Mbit)
#
# CONFIG_CHELSIO_T1 is not set
# CONFIG_IXGB is not set
# CONFIG_S2IO is not set

#
# Token Ring devices
#
# CONFIG_TR is not set

#
# Wireless LAN (non-hamradio)
#
# CONFIG_NET_RADIO is not set

#
# Wan interfaces
#
# CONFIG_WAN is not set
# CONFIG_FDDI is not set
# CONFIG_HIPPI is not set
# CONFIG_PLIP is not set
# CONFIG_PPP is not set
# CONFIG_SLIP is not set
# CONFIG_NET_FC is not set
# CONFIG_SHAPER is not set
CONFIG_NETCONSOLE=y
CONFIG_NETPOLL=y
# CONFIG_NETPOLL_RX is not set
# CONFIG_NETPOLL_TRAP is not set
CONFIG_NET_POLL_CONTROLLER=y

#
# ISDN subsystem
#
# CONFIG_ISDN is not set

#
# Telephony Support
#
# CONFIG_PHONE is not set

#
# Input device support
#
CONFIG_INPUT=y

#
# Userland interfaces
#
CONFIG_INPUT_MOUSEDEV=y
# CONFIG_INPUT_MOUSEDEV_PSAUX is not set
CONFIG_INPUT_MOUSEDEV_SCREEN_X=1024
CONFIG_INPUT_MOUSEDEV_SCREEN_Y=768
# CONFIG_INPUT_JOYDEV is not set
# CONFIG_INPUT_TSDEV is not set
CONFIG_INPUT_EVDEV=m
# CONFIG_INPUT_EVBUG is not set

#
# Input Device Drivers
#
CONFIG_INPUT_KEYBOARD=y
CONFIG_KEYBOARD_ATKBD=y
# CONFIG_KEYBOARD_SUNKBD is not set
# CONFIG_KEYBOARD_LKKBD is not set
# CONFIG_KEYBOARD_XTKBD is not set
# CONFIG_KEYBOARD_NEWTON is not set
CONFIG_INPUT_MOUSE=y
# CONFIG_MOUSE_PS2 is not set
# CONFIG_MOUSE_SERIAL is not set
# CONFIG_MOUSE_VSXXXAA is not set
# CONFIG_INPUT_JOYSTICK is not set
# CONFIG_INPUT_TOUCHSCREEN is not set
# CONFIG_INPUT_MISC is not set

#
# Hardware I/O ports
#
CONFIG_SERIO=y
CONFIG_SERIO_I8042=y
# CONFIG_SERIO_SERPORT is not set
# CONFIG_SERIO_CT82C710 is not set
# CONFIG_SERIO_PARKBD is not set
# CONFIG_SERIO_PCIPS2 is not set
CONFIG_SERIO_LIBPS2=y
# CONFIG_SERIO_RAW is not set
# CONFIG_GAMEPORT is not set

#
# Character devices
#
CONFIG_VT=y
CONFIG_VT_CONSOLE=y
CONFIG_HW_CONSOLE=y
# CONFIG_SERIAL_NONSTANDARD is not set

#
# Serial drivers
#
CONFIG_SERIAL_8250=m
# CONFIG_SERIAL_8250_ACPI is not set
CONFIG_SERIAL_8250_NR_UARTS=4
CONFIG_SERIAL_8250_RUNTIME_UARTS=4
# CONFIG_SERIAL_8250_EXTENDED is not set

#
# Non-8250 serial port support
#
CONFIG_SERIAL_CORE=m
# CONFIG_SERIAL_JSM is not set
CONFIG_UNIX98_PTYS=y
# CONFIG_LEGACY_PTYS is not set
# CONFIG_PRINTER is not set
# CONFIG_PPDEV is not set
# CONFIG_TIPAR is not set

#
# IPMI
#
# CONFIG_IPMI_HANDLER is not set

#
# Watchdog Cards
#
# CONFIG_WATCHDOG is not set
CONFIG_HW_RANDOM=m
CONFIG_NVRAM=m
CONFIG_RTC=m
CONFIG_RTC_HISTOGRAM=y
CONFIG_BLOCKER=y
CONFIG_LPPTEST=m
CONFIG_GEN_RTC=m
CONFIG_GEN_RTC_X=y
# CONFIG_DTLK is not set
# CONFIG_R3964 is not set
# CONFIG_APPLICOM is not set
# CONFIG_SONYPI is not set

#
# Ftape, the floppy tape device driver
#
CONFIG_AGP=m
# CONFIG_AGP_ALI is not set
# CONFIG_AGP_ATI is not set
# CONFIG_AGP_AMD is not set
# CONFIG_AGP_AMD64 is not set
CONFIG_AGP_INTEL=m
# CONFIG_AGP_NVIDIA is not set
# CONFIG_AGP_SIS is not set
# CONFIG_AGP_SWORKS is not set
# CONFIG_AGP_VIA is not set
# CONFIG_AGP_EFFICEON is not set
# CONFIG_DRM is not set
# CONFIG_MWAVE is not set
# CONFIG_CS5535_GPIO is not set
# CONFIG_RAW_DRIVER is not set
# CONFIG_HPET is not set
# CONFIG_HANGCHECK_TIMER is not set

#
# TPM devices
#
# CONFIG_TCG_TPM is not set
# CONFIG_TELCLOCK is not set

#
# I2C support
#
CONFIG_I2C=y
CONFIG_I2C_CHARDEV=m

#
# I2C Algorithms
#
CONFIG_I2C_ALGOBIT=y
# CONFIG_I2C_ALGOPCF is not set
# CONFIG_I2C_ALGOPCA is not set

#
# I2C Hardware Bus support
#
# CONFIG_I2C_ALI1535 is not set
# CONFIG_I2C_ALI1563 is not set
# CONFIG_I2C_ALI15X3 is not set
# CONFIG_I2C_AMD756 is not set
# CONFIG_I2C_AMD8111 is not set
CONFIG_I2C_I801=m
CONFIG_I2C_I810=m
# CONFIG_I2C_PIIX4 is not set
CONFIG_I2C_ISA=m
# CONFIG_I2C_NFORCE2 is not set
# CONFIG_I2C_PARPORT is not set
# CONFIG_I2C_PARPORT_LIGHT is not set
# CONFIG_I2C_PROSAVAGE is not set
# CONFIG_I2C_SAVAGE4 is not set
# CONFIG_SCx200_ACB is not set
# CONFIG_I2C_SIS5595 is not set
# CONFIG_I2C_SIS630 is not set
# CONFIG_I2C_SIS96X is not set
# CONFIG_I2C_STUB is not set
# CONFIG_I2C_VIA is not set
# CONFIG_I2C_VIAPRO is not set
# CONFIG_I2C_VOODOO3 is not set
# CONFIG_I2C_PCA_ISA is not set

#
# Miscellaneous I2C Chip support
#
# CONFIG_SENSORS_DS1337 is not set
# CONFIG_SENSORS_DS1374 is not set
# CONFIG_SENSORS_EEPROM is not set
# CONFIG_SENSORS_PCF8574 is not set
# CONFIG_SENSORS_PCA9539 is not set
# CONFIG_SENSORS_PCF8591 is not set
# CONFIG_SENSORS_RTC8564 is not set
# CONFIG_SENSORS_MAX6875 is not set
# CONFIG_RTC_X1205_I2C is not set
# CONFIG_I2C_DEBUG_CORE is not set
# CONFIG_I2C_DEBUG_ALGO is not set
# CONFIG_I2C_DEBUG_BUS is not set
# CONFIG_I2C_DEBUG_CHIP is not set

#
# SPI support
#
# CONFIG_SPI is not set
# CONFIG_SPI_MASTER is not set

#
# Dallas's 1-wire bus
#
# CONFIG_W1 is not set

#
# Hardware Monitoring support
#
CONFIG_HWMON=m
CONFIG_HWMON_VID=m
# CONFIG_SENSORS_ADM1021 is not set
# CONFIG_SENSORS_ADM1025 is not set
# CONFIG_SENSORS_ADM1026 is not set
# CONFIG_SENSORS_ADM1031 is not set
# CONFIG_SENSORS_ADM9240 is not set
# CONFIG_SENSORS_ASB100 is not set
# CONFIG_SENSORS_ATXP1 is not set
# CONFIG_SENSORS_DS1621 is not set
# CONFIG_SENSORS_F71805F is not set
# CONFIG_SENSORS_FSCHER is not set
# CONFIG_SENSORS_FSCPOS is not set
# CONFIG_SENSORS_GL518SM is not set
# CONFIG_SENSORS_GL520SM is not set
# CONFIG_SENSORS_IT87 is not set
# CONFIG_SENSORS_LM63 is not set
# CONFIG_SENSORS_LM75 is not set
# CONFIG_SENSORS_LM77 is not set
# CONFIG_SENSORS_LM78 is not set
# CONFIG_SENSORS_LM80 is not set
# CONFIG_SENSORS_LM83 is not set
# CONFIG_SENSORS_LM85 is not set
# CONFIG_SENSORS_LM87 is not set
# CONFIG_SENSORS_LM90 is not set
# CONFIG_SENSORS_LM92 is not set
# CONFIG_SENSORS_MAX1619 is not set
# CONFIG_SENSORS_PC87360 is not set
# CONFIG_SENSORS_SIS5595 is not set
# CONFIG_SENSORS_SMSC47M1 is not set
# CONFIG_SENSORS_SMSC47B397 is not set
# CONFIG_SENSORS_VIA686A is not set
# CONFIG_SENSORS_VT8231 is not set
# CONFIG_SENSORS_W83781D is not set
# CONFIG_SENSORS_W83792D is not set
# CONFIG_SENSORS_W83L785TS is not set
CONFIG_SENSORS_W83627HF=m
# CONFIG_SENSORS_W83627EHF is not set
# CONFIG_SENSORS_HDAPS is not set
# CONFIG_HWMON_DEBUG_CHIP is not set

#
# Misc devices
#
# CONFIG_IBM_ASM is not set

#
# Multimedia Capabilities Port drivers
#

#
# Multimedia devices
#
# CONFIG_VIDEO_DEV is not set

#
# Digital Video Broadcasting Devices
#
# CONFIG_DVB is not set

#
# Graphics support
#
CONFIG_FB=y
CONFIG_FB_CFB_FILLRECT=y
CONFIG_FB_CFB_COPYAREA=y
CONFIG_FB_CFB_IMAGEBLIT=y
# CONFIG_FB_MACMODES is not set
CONFIG_FB_MODE_HELPERS=y
CONFIG_FB_TILEBLITTING=y
# CONFIG_FB_CIRRUS is not set
# CONFIG_FB_PM2 is not set
# CONFIG_FB_CYBER2000 is not set
# CONFIG_FB_ARC is not set
# CONFIG_FB_ASILIANT is not set
# CONFIG_FB_IMSTT is not set
# CONFIG_FB_VGA16 is not set
# CONFIG_FB_VESA is not set
CONFIG_VIDEO_SELECT=y
# CONFIG_FB_HGA is not set
# CONFIG_FB_S1D13XXX is not set
CONFIG_FB_NVIDIA=y
CONFIG_FB_NVIDIA_I2C=y
# CONFIG_FB_RIVA is not set
# CONFIG_FB_I810 is not set
# CONFIG_FB_INTEL is not set
# CONFIG_FB_MATROX is not set
# CONFIG_FB_RADEON_OLD is not set
# CONFIG_FB_RADEON is not set
# CONFIG_FB_ATY128 is not set
# CONFIG_FB_ATY is not set
# CONFIG_FB_SAVAGE is not set
# CONFIG_FB_SIS is not set
# CONFIG_FB_NEOMAGIC is not set
# CONFIG_FB_KYRO is not set
# CONFIG_FB_3DFX is not set
# CONFIG_FB_VOODOO1 is not set
# CONFIG_FB_CYBLA is not set
# CONFIG_FB_TRIDENT is not set
# CONFIG_FB_GEODE is not set
# CONFIG_FB_VIRTUAL is not set

#
# Console display driver support
#
CONFIG_VGA_CONSOLE=y
CONFIG_DUMMY_CONSOLE=y
CONFIG_FRAMEBUFFER_CONSOLE=y
# CONFIG_FRAMEBUFFER_CONSOLE_ROTATION is not set
# CONFIG_FONTS is not set
CONFIG_FONT_8x8=y
CONFIG_FONT_8x16=y

#
# Logo configuration
#
CONFIG_LOGO=y
# CONFIG_LOGO_LINUX_MONO is not set
# CONFIG_LOGO_LINUX_VGA16 is not set
CONFIG_LOGO_LINUX_CLUT224=y
# CONFIG_BACKLIGHT_LCD_SUPPORT is not set

#
# Sound
#
CONFIG_SOUND=m

#
# Advanced Linux Sound Architecture
#
CONFIG_SND=m
CONFIG_SND_TIMER=m
CONFIG_SND_PCM=m
CONFIG_SND_RAWMIDI=m
CONFIG_SND_SEQUENCER=m
CONFIG_SND_SEQ_DUMMY=m
CONFIG_SND_OSSEMUL=y
CONFIG_SND_MIXER_OSS=m
CONFIG_SND_PCM_OSS=m
CONFIG_SND_SEQUENCER_OSS=y
CONFIG_SND_RTCTIMER=m
CONFIG_SND_SEQ_RTCTIMER_DEFAULT=y
CONFIG_SND_DYNAMIC_MINORS=y
CONFIG_SND_SUPPORT_OLD_API=y
# CONFIG_SND_VERBOSE_PRINTK is not set
# CONFIG_SND_DEBUG is not set

#
# Generic devices
#
CONFIG_SND_AC97_CODEC=m
CONFIG_SND_AC97_BUS=m
CONFIG_SND_DUMMY=m
CONFIG_SND_VIRMIDI=m
# CONFIG_SND_MTPAV is not set
# CONFIG_SND_SERIAL_U16550 is not set
# CONFIG_SND_MPU401 is not set

#
# PCI devices
#
# CONFIG_SND_AD1889 is not set
# CONFIG_SND_ALS4000 is not set
# CONFIG_SND_ALI5451 is not set
# CONFIG_SND_ATIIXP is not set
# CONFIG_SND_ATIIXP_MODEM is not set
# CONFIG_SND_AU8810 is not set
# CONFIG_SND_AU8820 is not set
# CONFIG_SND_AU8830 is not set
# CONFIG_SND_AZT3328 is not set
# CONFIG_SND_BT87X is not set
# CONFIG_SND_CA0106 is not set
# CONFIG_SND_CMIPCI is not set
# CONFIG_SND_CS4281 is not set
# CONFIG_SND_CS46XX is not set
# CONFIG_SND_CS5535AUDIO is not set
# CONFIG_SND_EMU10K1 is not set
# CONFIG_SND_EMU10K1X is not set
# CONFIG_SND_ENS1370 is not set
# CONFIG_SND_ENS1371 is not set
# CONFIG_SND_ES1938 is not set
# CONFIG_SND_ES1968 is not set
# CONFIG_SND_FM801 is not set
# CONFIG_SND_HDA_INTEL is not set
# CONFIG_SND_HDSP is not set
# CONFIG_SND_HDSPM is not set
# CONFIG_SND_ICE1712 is not set
# CONFIG_SND_ICE1724 is not set
CONFIG_SND_INTEL8X0=m
# CONFIG_SND_INTEL8X0M is not set
# CONFIG_SND_KORG1212 is not set
# CONFIG_SND_MAESTRO3 is not set
# CONFIG_SND_MIXART is not set
# CONFIG_SND_NM256 is not set
# CONFIG_SND_PCXHR is not set
# CONFIG_SND_RME32 is not set
# CONFIG_SND_RME96 is not set
# CONFIG_SND_RME9652 is not set
# CONFIG_SND_SONICVIBES is not set
# CONFIG_SND_TRIDENT is not set
# CONFIG_SND_VIA82XX is not set
# CONFIG_SND_VIA82XX_MODEM is not set
# CONFIG_SND_VX222 is not set
# CONFIG_SND_YMFPCI is not set

#
# USB devices
#
# CONFIG_SND_USB_AUDIO is not set
# CONFIG_SND_USB_USX2Y is not set

#
# Open Sound System
#
# CONFIG_SOUND_PRIME is not set

#
# USB support
#
CONFIG_USB_ARCH_HAS_HCD=y
CONFIG_USB_ARCH_HAS_OHCI=y
CONFIG_USB=y
# CONFIG_USB_DEBUG is not set

#
# Miscellaneous USB options
#
CONFIG_USB_DEVICEFS=y
# CONFIG_USB_BANDWIDTH is not set
# CONFIG_USB_DYNAMIC_MINORS is not set
# CONFIG_USB_SUSPEND is not set
# CONFIG_USB_OTG is not set

#
# USB Host Controller Drivers
#
CONFIG_USB_EHCI_HCD=y
# CONFIG_USB_EHCI_SPLIT_ISO is not set
# CONFIG_USB_EHCI_ROOT_HUB_TT is not set
# CONFIG_USB_ISP116X_HCD is not set
# CONFIG_USB_OHCI_HCD is not set
CONFIG_USB_UHCI_HCD=y
# CONFIG_USB_SL811_HCD is not set

#
# USB Device Class drivers
#
# CONFIG_OBSOLETE_OSS_USB_DRIVER is not set
# CONFIG_USB_ACM is not set
# CONFIG_USB_PRINTER is not set

#
# NOTE: USB_STORAGE enables SCSI, and 'SCSI disk support'
#

#
# may also be needed; see USB_STORAGE Help for more information
#
# CONFIG_USB_STORAGE is not set
# CONFIG_USB_LIBUSUAL is not set

#
# USB Input Devices
#
CONFIG_USB_HID=y
CONFIG_USB_HIDINPUT=y
# CONFIG_USB_HIDINPUT_POWERBOOK is not set
# CONFIG_HID_FF is not set
# CONFIG_USB_HIDDEV is not set
# CONFIG_USB_AIPTEK is not set
# CONFIG_USB_WACOM is not set
# CONFIG_USB_ACECAD is not set
# CONFIG_USB_KBTAB is not set
# CONFIG_USB_POWERMATE is not set
# CONFIG_USB_MTOUCH is not set
# CONFIG_USB_ITMTOUCH is not set
# CONFIG_USB_EGALAX is not set
# CONFIG_USB_YEALINK is not set
# CONFIG_USB_XPAD is not set
# CONFIG_USB_ATI_REMOTE is not set
# CONFIG_USB_ATI_REMOTE2 is not set
# CONFIG_USB_KEYSPAN_REMOTE is not set
# CONFIG_USB_APPLETOUCH is not set

#
# USB Imaging devices
#
# CONFIG_USB_MDC800 is not set
# CONFIG_USB_MICROTEK is not set

#
# USB Multimedia devices
#
# CONFIG_USB_DABUSB is not set

#
# Video4Linux support is needed for USB Multimedia device support
#

#
# USB Network Adapters
#
# CONFIG_USB_CATC is not set
# CONFIG_USB_KAWETH is not set
# CONFIG_USB_PEGASUS is not set
# CONFIG_USB_RTL8150 is not set
# CONFIG_USB_USBNET is not set
# CONFIG_USB_MON is not set

#
# USB port drivers
#
# CONFIG_USB_USS720 is not set

#
# USB Serial Converter support
#
# CONFIG_USB_SERIAL is not set

#
# USB Miscellaneous drivers
#
# CONFIG_USB_EMI62 is not set
# CONFIG_USB_EMI26 is not set
# CONFIG_USB_AUERSWALD is not set
# CONFIG_USB_RIO500 is not set
# CONFIG_USB_LEGOTOWER is not set
# CONFIG_USB_LCD is not set
# CONFIG_USB_LED is not set
# CONFIG_USB_CYTHERM is not set
# CONFIG_USB_PHIDGETKIT is not set
# CONFIG_USB_PHIDGETSERVO is not set
# CONFIG_USB_IDMOUSE is not set
# CONFIG_USB_SISUSBVGA is not set
# CONFIG_USB_LD is not set
# CONFIG_USB_TEST is not set

#
# USB DSL modem support
#

#
# USB Gadget Support
#
# CONFIG_USB_GADGET is not set

#
# MMC/SD Card support
#
# CONFIG_MMC is not set

#
# InfiniBand support
#
# CONFIG_INFINIBAND is not set

#
# EDAC - error detection and reporting (RAS) (EXPERIMENTAL)
#
# CONFIG_EDAC is not set

#
# File systems
#
CONFIG_EXT2_FS=m
CONFIG_EXT2_FS_XATTR=y
CONFIG_EXT2_FS_POSIX_ACL=y
CONFIG_EXT2_FS_SECURITY=y
CONFIG_EXT2_FS_XIP=y
CONFIG_FS_XIP=y
CONFIG_EXT3_FS=y
CONFIG_EXT3_FS_XATTR=y
CONFIG_EXT3_FS_POSIX_ACL=y
CONFIG_EXT3_FS_SECURITY=y
CONFIG_JBD=y
# CONFIG_JBD_DEBUG is not set
CONFIG_FS_MBCACHE=y
CONFIG_REISERFS_FS=m
# CONFIG_REISERFS_CHECK is not set
CONFIG_REISERFS_PROC_INFO=y
CONFIG_REISERFS_FS_XATTR=y
CONFIG_REISERFS_FS_POSIX_ACL=y
CONFIG_REISERFS_FS_SECURITY=y
CONFIG_JFS_FS=m
CONFIG_JFS_POSIX_ACL=y
CONFIG_JFS_SECURITY=y
# CONFIG_JFS_DEBUG is not set
CONFIG_JFS_STATISTICS=y
CONFIG_FS_POSIX_ACL=y
CONFIG_XFS_FS=m
CONFIG_XFS_EXPORT=y
CONFIG_XFS_QUOTA=y
CONFIG_XFS_SECURITY=y
CONFIG_XFS_POSIX_ACL=y
# CONFIG_XFS_RT is not set
# CONFIG_OCFS2_FS is not set
# CONFIG_MINIX_FS is not set
# CONFIG_ROMFS_FS is not set
CONFIG_INOTIFY=y
CONFIG_QUOTA=y
# CONFIG_QFMT_V1 is not set
CONFIG_QFMT_V2=m
CONFIG_QUOTACTL=y
CONFIG_DNOTIFY=y
# CONFIG_AUTOFS_FS is not set
CONFIG_AUTOFS4_FS=m
CONFIG_FUSE_FS=m

#
# CD-ROM/DVD Filesystems
#
CONFIG_ISO9660_FS=m
CONFIG_JOLIET=y
CONFIG_ZISOFS=y
CONFIG_ZISOFS_FS=m
CONFIG_UDF_FS=m
CONFIG_UDF_NLS=y

#
# DOS/FAT/NT Filesystems
#
CONFIG_FAT_FS=m
CONFIG_MSDOS_FS=m
CONFIG_VFAT_FS=m
CONFIG_FAT_DEFAULT_CODEPAGE=437
CONFIG_FAT_DEFAULT_IOCHARSET="iso8859-1"
CONFIG_NTFS_FS=m
# CONFIG_NTFS_DEBUG is not set
CONFIG_NTFS_RW=y

#
# Pseudo filesystems
#
CONFIG_PROC_FS=y
# CONFIG_PROC_KCORE is not set
CONFIG_PROC_VMCORE=y
CONFIG_SYSFS=y
CONFIG_TMPFS=y
# CONFIG_HUGETLBFS is not set
# CONFIG_HUGETLB_PAGE is not set
CONFIG_RAMFS=y
CONFIG_RELAYFS_FS=y
CONFIG_CONFIGFS_FS=m

#
# Miscellaneous filesystems
#
# CONFIG_ADFS_FS is not set
# CONFIG_AFFS_FS is not set
# CONFIG_HFS_FS is not set
# CONFIG_HFSPLUS_FS is not set
# CONFIG_BEFS_FS is not set
# CONFIG_BFS_FS is not set
# CONFIG_EFS_FS is not set
# CONFIG_CRAMFS is not set
# CONFIG_VXFS_FS is not set
# CONFIG_HPFS_FS is not set
# CONFIG_QNX4FS_FS is not set
# CONFIG_SYSV_FS is not set
# CONFIG_UFS_FS is not set

#
# Network File Systems
#
CONFIG_NFS_FS=m
CONFIG_NFS_V3=y
CONFIG_NFS_V3_ACL=y
# CONFIG_NFS_V4 is not set
# CONFIG_NFS_DIRECTIO is not set
CONFIG_NFSD=m
CONFIG_NFSD_V2_ACL=y
CONFIG_NFSD_V3=y
CONFIG_NFSD_V3_ACL=y
# CONFIG_NFSD_V4 is not set
CONFIG_NFSD_TCP=y
CONFIG_LOCKD=m
CONFIG_LOCKD_V4=y
CONFIG_EXPORTFS=m
CONFIG_NFS_ACL_SUPPORT=m
CONFIG_NFS_COMMON=y
CONFIG_SUNRPC=m
# CONFIG_RPCSEC_GSS_KRB5 is not set
# CONFIG_RPCSEC_GSS_SPKM3 is not set
CONFIG_SMB_FS=m
CONFIG_SMB_NLS_DEFAULT=y
CONFIG_SMB_NLS_REMOTE="cp437"
# CONFIG_CIFS is not set
# CONFIG_NCP_FS is not set
# CONFIG_CODA_FS is not set
# CONFIG_AFS_FS is not set
# CONFIG_9P_FS is not set

#
# Partition Types
#
# CONFIG_PARTITION_ADVANCED is not set
CONFIG_MSDOS_PARTITION=y

#
# Native Language Support
#
CONFIG_NLS=m
CONFIG_NLS_DEFAULT="iso8859-1"
CONFIG_NLS_CODEPAGE_437=m
# CONFIG_NLS_CODEPAGE_737 is not set
# CONFIG_NLS_CODEPAGE_775 is not set
# CONFIG_NLS_CODEPAGE_850 is not set
CONFIG_NLS_CODEPAGE_852=m
# CONFIG_NLS_CODEPAGE_855 is not set
# CONFIG_NLS_CODEPAGE_857 is not set
# CONFIG_NLS_CODEPAGE_860 is not set
# CONFIG_NLS_CODEPAGE_861 is not set
# CONFIG_NLS_CODEPAGE_862 is not set
# CONFIG_NLS_CODEPAGE_863 is not set
# CONFIG_NLS_CODEPAGE_864 is not set
# CONFIG_NLS_CODEPAGE_865 is not set
# CONFIG_NLS_CODEPAGE_866 is not set
# CONFIG_NLS_CODEPAGE_869 is not set
# CONFIG_NLS_CODEPAGE_936 is not set
# CONFIG_NLS_CODEPAGE_950 is not set
# CONFIG_NLS_CODEPAGE_932 is not set
# CONFIG_NLS_CODEPAGE_949 is not set
# CONFIG_NLS_CODEPAGE_874 is not set
# CONFIG_NLS_ISO8859_8 is not set
CONFIG_NLS_CODEPAGE_1250=m
# CONFIG_NLS_CODEPAGE_1251 is not set
# CONFIG_NLS_ASCII is not set
CONFIG_NLS_ISO8859_1=m
CONFIG_NLS_ISO8859_2=m
# CONFIG_NLS_ISO8859_3 is not set
# CONFIG_NLS_ISO8859_4 is not set
# CONFIG_NLS_ISO8859_5 is not set
# CONFIG_NLS_ISO8859_6 is not set
# CONFIG_NLS_ISO8859_7 is not set
# CONFIG_NLS_ISO8859_9 is not set
# CONFIG_NLS_ISO8859_13 is not set
# CONFIG_NLS_ISO8859_14 is not set
# CONFIG_NLS_ISO8859_15 is not set
# CONFIG_NLS_KOI8_R is not set
# CONFIG_NLS_KOI8_U is not set
CONFIG_NLS_UTF8=m

#
# Instrumentation Support
#
CONFIG_PROFILING=y
CONFIG_OPROFILE=y
CONFIG_PROFILE_NMI=y
CONFIG_KPROBES=y

#
# Kernel hacking
#
# CONFIG_PRINTK_TIME is not set
# CONFIG_PRINTK_IGNORE_LOGLEVEL is not set
CONFIG_MAGIC_SYSRQ=y
CONFIG_DEBUG_KERNEL=y
CONFIG_LOG_BUF_SHIFT=19
CONFIG_DETECT_SOFTLOCKUP=y
CONFIG_SCHEDSTATS=y
CONFIG_DEBUG_SLAB=y
CONFIG_DEBUG_PREEMPT=y
CONFIG_DEBUG_IRQ_FLAGS=y
CONFIG_DEBUG_RT_MUTEXES=y
CONFIG_RT_MUTEX_TESTER=y
CONFIG_WAKEUP_TIMING=y
CONFIG_WAKEUP_LATENCY_HIST=y
CONFIG_PREEMPT_TRACE=y
CONFIG_CRITICAL_PREEMPT_TIMING=y
CONFIG_PREEMPT_OFF_HIST=y
CONFIG_CRITICAL_IRQSOFF_TIMING=y
CONFIG_INTERRUPT_OFF_HIST=y
CONFIG_CRITICAL_TIMING=y
CONFIG_LATENCY_TIMING=y
CONFIG_CRITICAL_LATENCY_HIST=y
CONFIG_LATENCY_HIST=y
CONFIG_LATENCY_TRACE=y
CONFIG_MCOUNT=y
# CONFIG_DEBUG_KOBJECT is not set
CONFIG_DEBUG_HIGHMEM=y
CONFIG_DEBUG_BUGVERBOSE=y
CONFIG_DEBUG_INFO=y
CONFIG_DEBUG_FS=y
CONFIG_DEBUG_VM=y
CONFIG_FORCED_INLINING=y
CONFIG_FRAME_POINTER=y
# CONFIG_RCU_TORTURE_TEST is not set
CONFIG_EARLY_PRINTK=y
# CONFIG_DEBUG_STACKOVERFLOW is not set
CONFIG_DEBUG_STACK_USAGE=y
CONFIG_DEBUG_PAGEALLOC=y
CONFIG_DEBUG_RODATA=y
CONFIG_4KSTACKS=y
CONFIG_X86_FIND_SMP_CONFIG=y
CONFIG_X86_MPPARSE=y

#
# Security options
#
CONFIG_KEYS=y
CONFIG_KEYS_DEBUG_PROC_KEYS=y
CONFIG_SECURITY=y
CONFIG_SECURITY_NETWORK=y
CONFIG_SECURITY_CAPABILITIES=y
# CONFIG_SECURITY_ROOTPLUG is not set
CONFIG_SECURITY_SECLVL=y
CONFIG_SECURITY_SELINUX=y
CONFIG_SECURITY_SELINUX_BOOTPARAM=y
CONFIG_SECURITY_SELINUX_BOOTPARAM_VALUE=0
CONFIG_SECURITY_SELINUX_DISABLE=y
CONFIG_SECURITY_SELINUX_DEVELOP=y
CONFIG_SECURITY_SELINUX_AVC_STATS=y
CONFIG_SECURITY_SELINUX_CHECKREQPROT_VALUE=1

#
# Cryptographic options
#
CONFIG_CRYPTO=y
# CONFIG_CRYPTO_HMAC is not set
# CONFIG_CRYPTO_NULL is not set
# CONFIG_CRYPTO_MD4 is not set
# CONFIG_CRYPTO_MD5 is not set
CONFIG_CRYPTO_SHA1=y
# CONFIG_CRYPTO_SHA256 is not set
# CONFIG_CRYPTO_SHA512 is not set
# CONFIG_CRYPTO_WP512 is not set
# CONFIG_CRYPTO_TGR192 is not set
# CONFIG_CRYPTO_DES is not set
# CONFIG_CRYPTO_BLOWFISH is not set
# CONFIG_CRYPTO_TWOFISH is not set
# CONFIG_CRYPTO_SERPENT is not set
# CONFIG_CRYPTO_AES is not set
# CONFIG_CRYPTO_AES_586 is not set
# CONFIG_CRYPTO_CAST5 is not set
# CONFIG_CRYPTO_CAST6 is not set
# CONFIG_CRYPTO_TEA is not set
# CONFIG_CRYPTO_ARC4 is not set
# CONFIG_CRYPTO_KHAZAD is not set
# CONFIG_CRYPTO_ANUBIS is not set
# CONFIG_CRYPTO_DEFLATE is not set
# CONFIG_CRYPTO_MICHAEL_MIC is not set
# CONFIG_CRYPTO_CRC32C is not set
# CONFIG_CRYPTO_TEST is not set

#
# Hardware crypto devices
#
# CONFIG_CRYPTO_DEV_PADLOCK is not set

#
# Library routines
#
CONFIG_CRC_CCITT=m
CONFIG_CRC16=m
CONFIG_CRC32=y
CONFIG_LIBCRC32C=m
CONFIG_ZLIB_INFLATE=m
CONFIG_PLIST=y
CONFIG_GENERIC_HARDIRQS=y
CONFIG_GENERIC_IRQ_PROBE=y
CONFIG_GENERIC_PENDING_IRQ=y
CONFIG_X86_SMP=y
CONFIG_X86_HT=y
CONFIG_X86_BIOS_REBOOT=y
CONFIG_X86_TRAMPOLINE=y
CONFIG_KTIME_SCALAR=y

[8.8.] dmesg log
Linux version 2.6.16-rc6-rt2 (michal@ltg01-sid) (gcc version 4.1.0
(Debian 4.1.0-0)) #7 SMP PREEMPT Mon Mar 13 14:11:11 CET 2006
BIOS-provided physical RAM map:
 BIOS-e820: 0000000000000000 - 000000000009fc00 (usable)
 BIOS-e820: 000000000009fc00 - 00000000000a0000 (reserved)
 BIOS-e820: 00000000000e8000 - 0000000000100000 (reserved)
 BIOS-e820: 0000000000100000 - 000000007ff30000 (usable)
 BIOS-e820: 000000007ff30000 - 000000007ff40000 (ACPI data)
 BIOS-e820: 000000007ff40000 - 000000007fff0000 (ACPI NVS)
 BIOS-e820: 000000007fff0000 - 0000000080000000 (reserved)
 BIOS-e820: 00000000ffb80000 - 0000000100000000 (reserved)
1151MB HIGHMEM available.
896MB LOWMEM available.
found SMP MP-table at 000ff780
On node 0 totalpages: 524080
  DMA zone: 4096 pages, LIFO batch:0
  DMA32 zone: 0 pages, LIFO batch:0
  Normal zone: 225280 pages, LIFO batch:31
  HighMem zone: 294704 pages, LIFO batch:31
DMI 2.3 present.
ACPI: RSDP (v000 ACPIAM                                ) @ 0x000f9e30
ACPI: RSDT (v001 A M I  OEMRSDT  0x10000414 MSFT 0x00000097) @ 0x7ff30000
ACPI: FADT (v002 A M I  OEMFACP  0x10000414 MSFT 0x00000097) @ 0x7ff30200
ACPI: MADT (v001 A M I  OEMAPIC  0x10000414 MSFT 0x00000097) @ 0x7ff30390
ACPI: OEMB (v001 A M I  OEMBIOS  0x10000414 MSFT 0x00000097) @ 0x7ff40040
ACPI: DSDT (v001  P4P81 P4P81104 0x00000104 INTL 0x02002026) @ 0x00000000
ACPI: PM-Timer IO Port: 0x808
ACPI: Local APIC address 0xfee00000
ACPI: LAPIC (acpi_id[0x01] lapic_id[0x00] enabled)
Processor #0 15:2 APIC version 20
ACPI: LAPIC (acpi_id[0x02] lapic_id[0x01] enabled)
Processor #1 15:2 APIC version 20
ACPI: IOAPIC (id[0x02] address[0xfec00000] gsi_base[0])
IOAPIC[0]: apic_id 2, version 32, address 0xfec00000, GSI 0-23
ACPI: INT_SRC_OVR (bus 0 bus_irq 0 global_irq 2 dfl dfl)
ACPI: INT_SRC_OVR (bus 0 bus_irq 9 global_irq 9 high level)
ACPI: IRQ0 used by override.
ACPI: IRQ2 used by override.
ACPI: IRQ9 used by override.
Enabling APIC mode:  Flat.  Using 1 I/O APICs
Using ACPI (MADT) for SMP configuration information
Allocating PCI resources starting at 88000000 (gap: 80000000:7fb80000)
Detected 2798.738 MHz processor.
Real-Time Preemption Support (C) 2004-2006 Ingo Molnar
Built 1 zonelists
Kernel command line: root=/dev/sda1 ro debug
mapped APIC to ffffd000 (fee00000)
mapped IOAPIC to ffffc000 (fec00000)
Enabling fast FPU save and restore... done.
Enabling unmasked SIMD FPU exception support... done.
Initializing CPU#0
WARNING: experimental RCU implementation.
CPU 0 irqstacks, hard=c12de000 soft=c12dc000
PID hash table entries: 4096 (order: 12, 65536 bytes)
requested: 50000000  calculated 49992350 ns 50 cyc error: 7650
Event source pit installed with caps set: 01
Console: colour VGA+ 80x25
Dentry cache hash table entries: 131072 (order: 7, 524288 bytes)
Inode-cache hash table entries: 65536 (order: 6, 262144 bytes)
Memory: 2070136k/2096320k available (1801k kernel code, 25796k
reserved, 676k data, 420k init, 1178816k highmem)
Checking if this processor honours the WP bit even in supervisor mode... Ok.
Calibrating delay using timer specific routine.. 5599.92 BogoMIPS (lpj=2799961)
Security Framework v1.0.0 initialized
SELinux:  Disabled at boot.
Capability LSM initialized
Mount-cache hash table entries: 512
CPU: After generic identify, caps: bfebfbff 00000000 00000000 00000000
00004400 00000000 00000000
CPU: After vendor identify, caps: bfebfbff 00000000 00000000 00000000
00004400 00000000 00000000
CPU: Trace cache: 12K uops, L1 D cache: 8K
CPU: L2 cache: 512K
CPU: Physical Processor ID: 0
CPU: After all inits, caps: bfebfbf7 00000000 00000000 00000080
00004400 00000000 00000000
Intel machine check architecture supported.
Intel machine check reporting enabled on CPU#0.
CPU0: Intel P4/Xeon Extended MCE MSRs (12) available
CPU0: Thermal monitoring enabled
Checking 'hlt' instruction... OK.
CPU0: Intel(R) Pentium(R) 4 CPU 2.80GHz stepping 05
Booting processor 1/1 eip 2000
CPU 1 irqstacks, hard=c12df000 soft=c12dd000
Initializing CPU#1
Calibrating delay using timer specific routine.. 5596.58 BogoMIPS (lpj=2798292)
CPU: After generic identify, caps: bfebfbff 00000000 00000000 00000000
00004400 00000000 00000000
CPU: After vendor identify, caps: bfebfbff 00000000 00000000 00000000
00004400 00000000 00000000
CPU: Trace cache: 12K uops, L1 D cache: 8K
CPU: L2 cache: 512K
CPU: Physical Processor ID: 0
CPU: After all inits, caps: bfebfbf7 00000000 00000000 00000080
00004400 00000000 00000000
Intel machine check architecture supported.
Intel machine check reporting enabled on CPU#1.
CPU1: Intel P4/Xeon Extended MCE MSRs (12) available
CPU1: Thermal monitoring enabled
CPU1: Intel(R) Pentium(R) 4 CPU 2.80GHz stepping 05
Total of 2 processors activated (11196.50 BogoMIPS).
ENABLING IO-APIC IRQs
..TIMER: vector=0x31 apic1=0 pin1=2 apic2=-1 pin2=-1
Event source lapic installed with caps set: 06
checking TSC synchronization across 2 CPUs: passed.
Event source lapic installed with caps set: 06
Brought up 2 CPUs
NET: Registered protocol family 16
ACPI: bus type pci registered
PCI: PCI BIOS revision 2.10 entry at 0xf0031, last bus=2
PCI: Using configuration type 1
ACPI: Subsystem revision 20060127
ACPI: Interpreter enabled
ACPI: Using IOAPIC for interrupt routing
ACPI: PCI Root Bridge [PCI0] (0000:00)
PCI: Probing PCI hardware (bus 00)
PCI quirk: region 0800-087f claimed by ICH4 ACPI/GPIO/TCO
PCI quirk: region 0480-04bf claimed by ICH4 GPIO
PCI: Ignoring BAR0-3 of IDE controller 0000:00:1f.1
Boot video device is 0000:01:00.0
PCI: Transparent bridge - 0000:00:1e.0
ACPI: PCI Interrupt Routing Table [\_SB_.PCI0._PRT]
ACPI: PCI Interrupt Routing Table [\_SB_.PCI0.P0P4._PRT]
ACPI: PCI Interrupt Link [LNKA] (IRQs 3 4 5 6 7 *10 11 12 14 15)
ACPI: PCI Interrupt Link [LNKB] (IRQs 3 4 *5 6 7 10 11 12 14 15)
ACPI: PCI Interrupt Link [LNKC] (IRQs 3 4 *5 6 7 10 11 12 14 15)
ACPI: PCI Interrupt Link [LNKD] (IRQs 3 4 *5 6 7 10 11 12 14 15)
ACPI: PCI Interrupt Link [LNKE] (IRQs 3 4 5 6 7 10 11 12 14 15) *0, disabled.
ACPI: PCI Interrupt Link [LNKF] (IRQs 3 4 5 6 7 10 11 12 14 15) *0, disabled.
ACPI: PCI Interrupt Link [LNKG] (IRQs 3 4 *5 6 7 10 11 12 14 15)
ACPI: PCI Interrupt Link [LNKH] (IRQs 3 4 5 6 7 10 *11 12 14 15)
Linux Plug and Play Support v0.97 (c) Adam Belay
pnp: PnP ACPI init
pnp: PnP ACPI: found 13 devices
SCSI subsystem initialized
usbcore: registered new driver usbfs
usbcore: registered new driver hub
PCI: Using ACPI for IRQ routing
PCI: If a device doesn't work, try "pci=routeirq".  If it helps, post a report
PCI: Cannot allocate resource region 0 of device 0000:00:00.0
pnp: 00:09: ioport range 0x680-0x6ff has been reserved
pnp: 00:09: ioport range 0x290-0x297 has been reserved
PCI: Bridge: 0000:00:01.0
  IO window: disabled.
  MEM window: f6000000-f7efffff
  PREFETCH window: e8000000-f4ffffff
PCI: Bridge: 0000:00:1e.0
  IO window: e000-efff
  MEM window: f7f00000-fbffffff
  PREFETCH window: disabled.
PCI: Setting latency timer of device 0000:00:1e.0 to 64
Initializing RT-Tester: OK
No per-cpu room for modules.
audit: initializing netlink socket (disabled)
audit(1142255937.100:1): initialized
highmem bounce pool size: 64 pages
VFS: Disk quotas dquot_6.5.1
Dquot-cache hash table entries: 1024 (order 0, 4096 bytes)
seclvl: seclvl_init: seclvl: Failure registering with the kernel.
seclvl: seclvl_init: seclvl: Failure registering with primary security module.
seclvl: Error during initialization: rc = [-22]
Initializing Cryptographic API
io scheduler noop registered
io scheduler anticipatory registered (default)
ACPI: PCI Interrupt 0000:01:00.0[A] -> GSI 16 (level, low) -> IRQ 16
nvidiafb: PCI id - 10de0322
nvidiafb: Actual id - 10de0322
nvidiafb: nVidia device/chipset 10DE0322
nvidiafb: CRTC0 analog found
nvidiafb: CRTC1 analog not found
nvidiafb: EDID found from BUS1
nvidiafb: CRTC 0 appears to have a CRT attached
nvidiafb: Using CRT on CRTC 0
nvidiafb: MTRR set to ON
Console: switching to colour frame buffer device 128x48
nvidiafb: PCI nVidia NV32 framebuffer (64MB @ 0xE8000000)
PNP: PS/2 Controller [PNP0303:PS2K] at 0x60,0x64 irq 1
PNP: PS/2 controller doesn't have AUX irq; using default 12
serio: i8042 AUX port at 0x60,0x64 irq 12
serio: i8042 KBD port at 0x60,0x64 irq 1
netconsole: not configured, aborting
Uniform Multi-Platform E-IDE driver Revision: 7.00alpha2
ide: Assuming 33MHz system bus speed for PIO modes; override with idebus=xx
ICH5: IDE controller at PCI slot 0000:00:1f.1
PCI: Enabling device 0000:00:1f.1 (0005 -> 0007)
ACPI: PCI Interrupt 0000:00:1f.1[A] -> GSI 18 (level, low) -> IRQ 17
ICH5: chipset revision 2
ICH5: not 100% native mode: will probe irqs later
    ide0: BM-DMA at 0xfc00-0xfc07, BIOS settings: hda:pio, hdb:pio
    ide1: BM-DMA at 0xfc08-0xfc0f, BIOS settings: hdc:DMA, hdd:DMA
Probing IDE interface ide0...
Probing IDE interface ide1...
hdc: LITE-ON DVDRW SOHW-1653S, ATAPI CD/DVD-ROM drive
hdd: LITE-ON LTR-52327S, ATAPI CD/DVD-ROM drive
ide1 at 0x170-0x177,0x376 on irq 15
Probing IDE interface ide0...
libata version 1.20 loaded.
ata_piix 0000:00:1f.2: version 1.05
ACPI: PCI Interrupt 0000:00:1f.2[A] -> GSI 18 (level, low) -> IRQ 17
PCI: Setting latency timer of device 0000:00:1f.2 to 64
ata1: SATA max UDMA/133 cmd 0xCC00 ctl 0xC882 bmdma 0xC400 irq 17
ata2: SATA max UDMA/133 cmd 0xC800 ctl 0xC482 bmdma 0xC408 irq 17
ata1: dev 0 cfg 49:2f00 82:7c6b 83:7f09 84:4003 85:7c69 86:3e01 87:4003 88:207f
ata1: dev 0 ATA-7, max UDMA/133, 398297088 sectors: LBA48
ata1: dev 0 configured for UDMA/133
scsi0 : ata_piix
ATA: abnormal status 0x7F on port 0xC807
scsi1 : ata_piix
  Vendor: ATA       Model: Maxtor 6Y200M0    Rev: YAR5
  Type:   Direct-Access                      ANSI SCSI revision: 05
SCSI device sda: 398297088 512-byte hdwr sectors (203928 MB)
sda: Write Protect is off
sda: Mode Sense: 00 3a 00 00
SCSI device sda: drive cache: write back
SCSI device sda: 398297088 512-byte hdwr sectors (203928 MB)
sda: Write Protect is off
sda: Mode Sense: 00 3a 00 00
SCSI device sda: drive cache: write back
 sda: sda1 sda2 sda3
sd 0:0:0:0: Attached scsi disk sda
ACPI: PCI Interrupt 0000:00:1d.7[D] -> GSI 23 (level, low) -> IRQ 18
PCI: Setting latency timer of device 0000:00:1d.7 to 64
ehci_hcd 0000:00:1d.7: EHCI Host Controller
ehci_hcd 0000:00:1d.7: debug port 1
PCI: cache line size of 128 is not supported by device 0000:00:1d.7
ehci_hcd 0000:00:1d.7: new USB bus registered, assigned bus number 1
ehci_hcd 0000:00:1d.7: irq 18, io mem 0xf5fffc00
ehci_hcd 0000:00:1d.7: USB 2.0 started, EHCI 1.00, driver 10 Dec 2004
usb usb1: configuration #1 chosen from 1 choice
hub 1-0:1.0: USB hub found
hub 1-0:1.0: 8 ports detected
USB Universal Host Controller Interface driver v2.3
ACPI: PCI Interrupt 0000:00:1d.0[A] -> GSI 16 (level, low) -> IRQ 16
PCI: Setting latency timer of device 0000:00:1d.0 to 64
uhci_hcd 0000:00:1d.0: UHCI Host Controller
uhci_hcd 0000:00:1d.0: new USB bus registered, assigned bus number 2
uhci_hcd 0000:00:1d.0: irq 16, io base 0x0000d480
usb usb2: configuration #1 chosen from 1 choice
hub 2-0:1.0: USB hub found
hub 2-0:1.0: 2 ports detected
ACPI: PCI Interrupt 0000:00:1d.1[B] -> GSI 19 (level, low) -> IRQ 19
PCI: Setting latency timer of device 0000:00:1d.1 to 64
uhci_hcd 0000:00:1d.1: UHCI Host Controller
uhci_hcd 0000:00:1d.1: new USB bus registered, assigned bus number 3
uhci_hcd 0000:00:1d.1: irq 19, io base 0x0000d800
usb usb3: configuration #1 chosen from 1 choice
hub 3-0:1.0: USB hub found
hub 3-0:1.0: 2 ports detected
ACPI: PCI Interrupt 0000:00:1d.2[C] -> GSI 18 (level, low) -> IRQ 17
PCI: Setting latency timer of device 0000:00:1d.2 to 64
uhci_hcd 0000:00:1d.2: UHCI Host Controller
uhci_hcd 0000:00:1d.2: new USB bus registered, assigned bus number 4
uhci_hcd 0000:00:1d.2: irq 17, io base 0x0000d880
usb usb4: configuration #1 chosen from 1 choice
hub 4-0:1.0: USB hub found
hub 4-0:1.0: 2 ports detected
ACPI: PCI Interrupt 0000:00:1d.3[A] -> GSI 16 (level, low) -> IRQ 16
PCI: Setting latency timer of device 0000:00:1d.3 to 64
uhci_hcd 0000:00:1d.3: UHCI Host Controller
uhci_hcd 0000:00:1d.3: new USB bus registered, assigned bus number 5
uhci_hcd 0000:00:1d.3: irq 16, io base 0x0000dc00
usb usb5: configuration #1 chosen from 1 choice
hub 5-0:1.0: USB hub found
hub 5-0:1.0: 2 ports detected
usb 3-2: new low speed USB device using uhci_hcd and address 2
usb 3-2: configuration #1 chosen from 1 choice
input: HID 04d9:0499 as /class/input/input0
input: USB HID v1.10 Mouse [HID 04d9:0499] on usb-0000:00:1d.1-2
usbcore: registered new driver usbhid
/usr/src/linux-rt/drivers/usb/input/hid-core.c: v2.6:USB HID core driver
mice: PS/2 mouse device common for all mice
oprofile: using NMI interrupt.
NET: Registered protocol family 2
IP route cache hash table entries: 131072 (order: 7, 524288 bytes)
TCP established hash table entries: 32768 (order: 9, 2490368 bytes)
TCP bind hash table entries: 32768 (order: 9, 2359296 bytes)
TCP: Hash tables configured (established 32768 bind 32768)
TCP reno registered
TCP bic registered
Starting balanced_irq
Using IPI Shortcut mode
*****************************************************************************
*                                                                           *
*  REMINDER, the following debugging options are turned on in your .config: *
*                                                                           *
*        CONFIG_DEBUG_RT_MUTEXES                                             *
*        CONFIG_DEBUG_PREEMPT                                               *
*        CONFIG_CRITICAL_PREEMPT_TIMING                                     *
*        CONFIG_CRITICAL_IRQSOFF_TIMING                                     *
*        CONFIG_LATENCY_TRACE                                               *
*        CONFIG_DEBUG_SLAB                                                  *
*        CONFIG_DEBUG_PAGEALLOC                                             *
*                                                                           *
*  they may increase runtime overhead and latencies.                        *
*                                                                           *
*****************************************************************************
Time: tsc clocksource has been installed.
BUG: scheduling while atomic: softirq-timer/0/0x00000001/4
caller is schedule+0xdb/0x101
 [<c10044f9>] show_trace+0x18/0x1d (20)
 [<c1004555>] dump_stack+0x1d/0x21 (20)
 [<c11bcf77>] __schedule+0x71/0xfd3 (156)
 [<c11be101>] schedule+0xdb/0x101 (20)
 [<c11bee24>] rt_lock_slowlock+0x126/0x1c5 (96)
 [<c11bf4b7>] rt_lock+0x10/0x12 (8)
 [<c105c279>] __kmalloc_track_caller+0xa7/0x112 (32)
 [<c10e96c9>] soft_cursor+0x55/0x170 (56)
 [<c10e958b>] bit_cursor+0x471/0x486 (156)
 [<c10e4b24>] fbcon_cursor+0x218/0x24d (68)
 [<c1124c83>] hide_cursor+0x22/0x61 (20)
 [<c1128713>] vt_console_print+0x91/0x207 (28)
 [<c101b7b4>] __call_console_drivers+0x42/0x59 (32)
 [<c101b829>] _call_console_drivers+0x5e/0x67 (24)
 [<c101bd4c>] release_console_sem+0x110/0x1da (40)
 [<c101bab9>] vprintk+0x278/0x2ad (116)
 [<c101bb08>] printk+0x1a/0x1c (20)
 [<c103941b>] timeofday_periodic_hook+0x4db/0x772 (140)
 [<c1023cb8>] run_timer_softirq+0x313/0x39a (40)
 [<c1020c38>] ksoftirqd+0x109/0x199 (32)
 [<c102d2ba>] kthread+0xa7/0xd5 (36)
 [<c1000dd5>] kernel_thread_helper+0x5/0xb (1030828060)
---------------------------
| preempt count: 00000001 ]
| 1-level deep critical section nesting:
----------------------------------------
.. [<c11bf646>] .... _raw_spin_lock+0x12/0x26
.....[<c1038f6b>] ..   ( <= timeofday_periodic_hook+0x2b/0x772)

------------------------------
| showing all locks held by: |  (softirq-timer/0/4 [c28eb8c0,  98]):
------------------------------

#001:             [c1217204] {console_sem.lock}
... acquired at:               rt_down_trylock+0x16/0x3c

BUG: scheduling while atomic: softirq-timer/0/0x00000001/4
caller is schedule+0xdb/0x101
 [<c10044f9>] show_trace+0x18/0x1d (20)
 [<c1004555>] dump_stack+0x1d/0x21 (20)
 [<c11bcf77>] __schedule+0x71/0xfd3 (156)
 [<c11be101>] schedule+0xdb/0x101 (20)
 [<c11bee24>] rt_lock_slowlock+0x126/0x1c5 (96)
 [<c11bf4b7>] rt_lock+0x10/0x12 (8)
 [<c105cdf7>] kfree+0x36/0x88 (24)
 [<c10e97d7>] soft_cursor+0x163/0x170 (76)
 [<c10e958b>] bit_cursor+0x471/0x486 (156)
 [<c10e4b24>] fbcon_cursor+0x218/0x24d (68)
 [<c1124c83>] hide_cursor+0x22/0x61 (20)
 [<c1128713>] vt_console_print+0x91/0x207 (28)
 [<c101b7b4>] __call_console_drivers+0x42/0x59 (32)
 [<c101b829>] _call_console_drivers+0x5e/0x67 (24)
 [<c101bd4c>] release_console_sem+0x110/0x1da (40)
 [<c101bab9>] vprintk+0x278/0x2ad (116)
 [<c101bb08>] printk+0x1a/0x1c (20)
 [<c103941b>] timeofday_periodic_hook+0x4db/0x772 (140)
 [<c1023cb8>] run_timer_softirq+0x313/0x39a (40)
 [<c1020c38>] ksoftirqd+0x109/0x199 (32)
 [<c102d2ba>] kthread+0xa7/0xd5 (36)
 [<c1000dd5>] kernel_thread_helper+0x5/0xb (1030828060)
---------------------------
| preempt count: 00000001 ]
| 1-level deep critical section nesting:
----------------------------------------
.. [<c11bf646>] .... _raw_spin_lock+0x12/0x26
.....[<c10422cf>] ..   ( <= __do_IRQ+0xb0/0xfe)

------------------------------
| showing all locks held by: |  (softirq-timer/0/4 [c28eb8c0,  98]):
------------------------------

#001:             [c1217204] {console_sem.lock}
... acquired at:               rt_down_trylock+0x16/0x3c

BUG: scheduling while atomic: softirq-timer/0/0x00000001/4
caller is schedule+0xdb/0x101
 [<c10044f9>] show_trace+0x18/0x1d (20)
 [<c1004555>] dump_stack+0x1d/0x21 (20)
 [<c11bcf77>] __schedule+0x71/0xfd3 (156)
 [<c11be101>] schedule+0xdb/0x101 (20)
 [<c11bee24>] rt_lock_slowlock+0x126/0x1c5 (96)
 [<c11bf4b7>] rt_lock+0x10/0x12 (8)
 [<c105c279>] __kmalloc_track_caller+0xa7/0x112 (32)
 [<c10e96c9>] soft_cursor+0x55/0x170 (56)
 [<c10e958b>] bit_cursor+0x471/0x486 (156)
 [<c10e4b24>] fbcon_cursor+0x218/0x24d (68)
 [<c10e7c1b>] fbcon_scroll+0xb09/0xb26 (68)
 [<c1124e8e>] scrup+0x51/0xb9 (40)
 [<c1124f19>] lf+0x23/0x45 (28)
 [<c11287c2>] vt_console_print+0x140/0x207 (28)
 [<c101b7b4>] __call_console_drivers+0x42/0x59 (32)
 [<c101b829>] _call_console_drivers+0x5e/0x67 (24)
 [<c101bd4c>] release_console_sem+0x110/0x1da (40)
 [<c101bab9>] vprintk+0x278/0x2ad (116)
 [<c101bb08>] printk+0x1a/0x1c (20)
 [<c103941b>] timeofday_periodic_hook+0x4db/0x772 (140)
 [<c1023cb8>] run_timer_softirq+0x313/0x39a (40)
 [<c1020c38>] ksoftirqd+0x109/0x199 (32)
 [<c102d2ba>] kthread+0xa7/0xd5 (36)
 [<c1000dd5>] kernel_thread_helper+0x5/0xb (1030828060)
---------------------------
| preempt count: 00000001 ]
| 1-level deep critical section nesting:
----------------------------------------
.. [<c11bf646>] .... _raw_spin_lock+0x12/0x26
.....[<c10422cf>] ..   ( <= __do_IRQ+0xb0/0xfe)

------------------------------
| showing all locks held by: |  (softirq-timer/0/4 [c28eb8c0,  98]):
------------------------------

#001:             [c1217204] {console_sem.lock}
... acquired at:               rt_down_trylock+0x16/0x3c

BUG: scheduling while atomic: softirq-timer/0/0x00000001/4
caller is schedule+0xdb/0x101
 [<c10044f9>] show_trace+0x18/0x1d (20)
 [<c1004555>] dump_stack+0x1d/0x21 (20)
 [<c11bcf77>] __schedule+0x71/0xfd3 (156)
 [<c11be101>] schedule+0xdb/0x101 (20)
 [<c11bee24>] rt_lock_slowlock+0x126/0x1c5 (96)
 [<c11bf4b7>] rt_lock+0x10/0x12 (8)
 [<c105c279>] __kmalloc_track_caller+0xa7/0x112 (32)
 [<c10e96c9>] soft_cursor+0x55/0x170 (56)
 [<c10e958b>] bit_cursor+0x471/0x486 (156)
 [<c10e4b24>] fbcon_cursor+0x218/0x24d (68)
 [<c10e7c1b>] fbcon_scroll+0xb09/0xb26 (68)
 [<c1124e8e>] scrup+0x51/0xb9 (40)
 [<c1124f19>] lf+0x23/0x45 (28)
 [<c11287c2>] vt_console_print+0x140/0x207 (28)
 [<c101b7b4>] __call_console_drivers+0x42/0x59 (32)
 [<c101b829>] _call_console_drivers+0x5e/0x67 (24)
 [<c101bd4c>] release_console_sem+0x110/0x1da (40)
 [<c101bab9>] vprintk+0x278/0x2ad (116)
 [<c101bb08>] printk+0x1a/0x1c (20)
 [<c103941b>] timeofday_periodic_hook+0x4db/0x772 (140)
 [<c1023cb8>] run_timer_softirq+0x313/0x39a (40)
 [<c1020c38>] ksoftirqd+0x109/0x199 (32)
 [<c102d2ba>] kthread+0xa7/0xd5 (36)
 [<c1000dd5>] kernel_thread_helper+0x5/0xb (1030828060)
---------------------------
| preempt count: 00000001 ]
| 1-level deep critical section nesting:
----------------------------------------
.. [<c11bf646>] .... _raw_spin_lock+0x12/0x26
.....[<c10422cf>] ..   ( <= __do_IRQ+0xb0/0xfe)

------------------------------
| showing all locks held by: |  (softirq-timer/0/4 [c28eb8c0,  98]):
------------------------------

#001:             [c1217204] {console_sem.lock}
... acquired at:               rt_down_trylock+0x16/0x3c

BUG: scheduling while atomic: softirq-timer/0/0x00000001/4
caller is schedule+0xdb/0x101
 [<c10044f9>] show_trace+0x18/0x1d (20)
 [<c1004555>] dump_stack+0x1d/0x21 (20)
 [<c11bcf77>] __schedule+0x71/0xfd3 (156)
 [<c11be101>] schedule+0xdb/0x101 (20)
 [<c11bee24>] rt_lock_slowlock+0x126/0x1c5 (96)
 [<c11bf4b7>] rt_lock+0x10/0x12 (8)
 [<c105cdf7>] kfree+0x36/0x88 (24)
 [<c10e97d7>] soft_cursor+0x163/0x170 (76)
 [<c10e958b>] bit_cursor+0x471/0x486 (156)
 [<c10e4b24>] fbcon_cursor+0x218/0x24d (68)
 [<c10e7c1b>] fbcon_scroll+0xb09/0xb26 (68)
 [<c1124e8e>] scrup+0x51/0xb9 (40)
 [<c1124f19>] lf+0x23/0x45 (28)
 [<c11287c2>] vt_console_print+0x140/0x207 (28)
 [<c101b7b4>] __call_console_drivers+0x42/0x59 (32)
 [<c101b829>] _call_console_drivers+0x5e/0x67 (24)
 [<c101bd4c>] release_console_sem+0x110/0x1da (40)
 [<c101bab9>] vprintk+0x278/0x2ad (116)
 [<c101bb08>] printk+0x1a/0x1c (20)
 [<c103941b>] timeofday_periodic_hook+0x4db/0x772 (140)
 [<c1023cb8>] run_timer_softirq+0x313/0x39a (40)
 [<c1020c38>] ksoftirqd+0x109/0x199 (32)
 [<c102d2ba>] kthread+0xa7/0xd5 (36)
 [<c1000dd5>] kernel_thread_helper+0x5/0xb (1030828060)
---------------------------
| preempt count: 00000001 ]
| 1-level deep critical section nesting:
----------------------------------------
.. [<c11bf646>] .... _raw_spin_lock+0x12/0x26
.....[<c10422cf>] ..   ( <= __do_IRQ+0xb0/0xfe)

------------------------------
| showing all locks held by: |  (softirq-timer/0/4 [c28eb8c0,  98]):
------------------------------

#001:             [c1217204] {console_sem.lock}
... acquired at:               rt_down_trylock+0x16/0x3c

BUG: scheduling while atomic: softirq-timer/0/0x00000001/4
caller is schedule+0xdb/0x101
 [<c10044f9>] show_trace+0x18/0x1d (20)
 [<c1004555>] dump_stack+0x1d/0x21 (20)
 [<c11bcf77>] __schedule+0x71/0xfd3 (156)
 [<c11be101>] schedule+0xdb/0x101 (20)
 [<c11bee24>] rt_lock_slowlock+0x126/0x1c5 (96)
 [<c11bf4b7>] rt_lock+0x10/0x12 (8)
 [<c105cdf7>] kfree+0x36/0x88 (24)
 [<c10e97d7>] soft_cursor+0x163/0x170 (76)
 [<c10e958b>] bit_cursor+0x471/0x486 (156)
 [<c10e4b24>] fbcon_cursor+0x218/0x24d (68)
 [<c10e7c1b>] fbcon_scroll+0xb09/0xb26 (68)
 [<c1124e8e>] scrup+0x51/0xb9 (40)
 [<c1124f19>] lf+0x23/0x45 (28)
 [<c11287c2>] vt_console_print+0x140/0x207 (28)
 [<c101b7b4>] __call_console_drivers+0x42/0x59 (32)
 [<c101b829>] _call_console_drivers+0x5e/0x67 (24)
 [<c101bd4c>] release_console_sem+0x110/0x1da (40)
 [<c101bab9>] vprintk+0x278/0x2ad (116)
 [<c101bb08>] printk+0x1a/0x1c (20)
 [<c103941b>] timeofday_periodic_hook+0x4db/0x772 (140)
 [<c1023cb8>] run_timer_softirq+0x313/0x39a (40)
 [<c1020c38>] ksoftirqd+0x109/0x199 (32)
 [<c102d2ba>] kthread+0xa7/0xd5 (36)
 [<c1000dd5>] kernel_thread_helper+0x5/0xb (1030828060)
---------------------------
| preempt count: 00000001 ]
| 1-level deep critical section nesting:
----------------------------------------
.. [<c11bf646>] .... _raw_spin_lock+0x12/0x26
.....[<c10422cf>] ..   ( <= __do_IRQ+0xb0/0xfe)

------------------------------
| showing all locks held by: |  (softirq-timer/0/4 [c28eb8c0,  98]):
------------------------------

#001:             [c1217204] {console_sem.lock}
... acquired at:               rt_down_trylock+0x16/0x3c

requested: 50000000  calculated 49999999 ns 139936916 cyc error: 1
hrtimers: Switched to high resolution mode CPU 0
hrtimers: Switched to high resolution mode CPU 1
EXT3-fs: INFO: recovery required on readonly filesystem.
EXT3-fs: write access will be enabled during recovery.
input: AT Translated Set 2 keyboard as /class/input/input1
EXT3-fs: sda1: orphan cleanup on readonly fs
ext3_orphan_cleanup: deleting unreferenced inode 2818040
ext3_orphan_cleanup: deleting unreferenced inode 2818037
ext3_orphan_cleanup: deleting unreferenced inode 2818038
ext3_orphan_cleanup: deleting unreferenced inode 2818030
ext3_orphan_cleanup: deleting unreferenced inode 2818029
ext3_orphan_cleanup: deleting unreferenced inode 2818028
EXT3-fs: sda1: 6 orphan inodes deleted
EXT3-fs: recovery complete.
kjournald starting.  Commit interval 5 seconds
EXT3-fs: mounted filesystem with ordered data mode.
VFS: Mounted root (ext3 filesystem) readonly.
*****************************************************************************
*                                                                           *
*  REMINDER, the following debugging options are turned on in your .config: *
*                                                                           *
*        CONFIG_DEBUG_RT_MUTEXES                                             *
*        CONFIG_DEBUG_PREEMPT                                               *
*        CONFIG_CRITICAL_PREEMPT_TIMING                                     *
*        CONFIG_CRITICAL_IRQSOFF_TIMING                                     *
*        CONFIG_LATENCY_TRACE                                               *
*        CONFIG_DEBUG_SLAB                                                  *
*        CONFIG_DEBUG_PAGEALLOC                                             *
*                                                                           *
*  they may increase runtime overhead and latencies.                        *
*                                                                           *
*****************************************************************************
Freeing unused kernel memory: 420k freed
Write protecting the kernel read-only data: 313k
NET: Registered protocol family 1
Linux agpgart interface v0.101 (c) Dave Jones
agpgart: Detected an Intel 865 Chipset.
agpgart: AGP aperture is 64M @ 0x8c000000
hdc: ATAPI 48X DVD-ROM DVD-R CD-R/RW drive, 2048kB Cache, UDMA(33)
Uniform CD-ROM driver Revision: 3.20
hdd: ATAPI 52X CD-ROM CD-R/RW drive, 2048kB Cache, UDMA(33)
hw_random hardware driver 1.0.0 loaded
ACPI: PCI Interrupt 0000:02:05.0[A] -> GSI 22 (level, low) -> IRQ 20
skge 1.3 addr 0xf7ffc000 irq 20 chip Yukon rev 1
skge eth0: addr 00:0c:6e:c2:4d:aa
Real Time Clock Driver v1.12ac
parport: PnPBIOS parport detected.
parport0: PC-style at 0x378 (0x778), irq 7 [PCSPP(,...)]
Serial: 8250/16550 driver $Revision: 1.90 $ 4 ports, IRQ sharing disabled
serial8250: ttyS0 at I/O 0x3f8 (irq = 4) is a 16550A
serial8250: ttyS1 at I/O 0x2f8 (irq = 3) is a 16550A
00:06: ttyS0 at I/O 0x3f8 (irq = 4) is a 16550A
00:07: ttyS1 at I/O 0x2f8 (irq = 3) is a 16550A
ACPI: PCI Interrupt 0000:00:1f.5[B] -> GSI 17 (level, low) -> IRQ 21
PCI: Setting latency timer of device 0000:00:1f.5 to 64
AC'97 0 analog subsections not ready
intel8x0_measure_ac97_clock: measured 50781 usecs
intel8x0: clocking to 48000
Adding 3903784k swap on /dev/sda2.  Priority:-1 extents:1 across:3903784k
EXT3 FS on sda1, internal journal
kjournald starting.  Commit interval 5 seconds
EXT3 FS on sda3, internal journal
EXT3-fs: mounted filesystem with ordered data mode.


OOPS Reporting Tool v.ltg1
www.wsi.edu.pl/~piotrowskim/files/ort/ltg/

Regards,
Michal

--
Michal K. K. Piotrowski
LTG - Linux Testers Group
(http://www.stardust.webpages.pl/ltg/wiki/)
