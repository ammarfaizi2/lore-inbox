Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965266AbWKDKuj@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965266AbWKDKuj (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 4 Nov 2006 05:50:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965276AbWKDKuj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 4 Nov 2006 05:50:39 -0500
Received: from smtpa2.netcabo.pt ([212.113.174.17]:61654 "EHLO
	exch01smtp01.hdi.tvcabo") by vger.kernel.org with ESMTP
	id S965266AbWKDKuh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 4 Nov 2006 05:50:37 -0500
Message-ID: <454C714B.8030403@rncbc.org>
Date: Sat, 04 Nov 2006 10:54:03 +0000
From: Rui Nuno Capela <rncbc@rncbc.org>
User-Agent: Thunderbird 1.5.0.7 (X11/20060911)
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
CC: Karsten Wiese <fzu@wemgehoertderstaat.de>, Ingo Molnar <mingo@elte.hu>
Subject: Re: realtime-preempt patch-2.6.18-rt7 oops
References: <42997.194.65.103.1.1162464204.squirrel@www.rncbc.org> <200611031230.24983.fzu@wemgehoertderstaat.de> <454BC8D1.1020001@rncbc.org> <454BF608.20803@rncbc.org>
In-Reply-To: <454BF608.20803@rncbc.org>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 04 Nov 2006 10:50:35.0486 (UTC) FILETIME=[0EB0F7E0:01C6FFFF]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Rui Nuno Capela wrote:
> 
> I will now try turning on some .config debug options, e.g.
> CONFIG_PREEMPT, and if I can catch something I'll be back here with some
> more dumps ;)
> 


Turned on some kernel debug switches, notably CONFIG_DEBUG_PREEMPT,
CONFIG_DEBUG_RT_MUTEXES, CONFIG_DEBUG_SLAB
    and CONFIG_LOCKDEP, and it crashed on the very first boot. These are
the traces that could be captured on serial console:

...
=========================================================
[ INFO: possible irq lock inversion dependency detected ]
---------------------------------------------------------
swapper/1 just changed the state of lock:
 (rtc_lock){-...}, at: [<c0426f0b>] rtc_init+0xbb/0x1c0
but this lock was taken by another, hard-irq-safe lock in the past:
 (name){+...}

and interrupts could create inverse lock ordering between them.


other info that might help us debug this:
no locks held by swapper/1.

the first lock's dependencies:
-> (rtc_lock){-...} ops: 2 {
   initial-use  at:
                        [<c0146965>] lock_acquire+0x75/0xa0
                        [<c030d782>] rt_spin_lock+0x32/0x40
                        [<c0108d93>] read_persistent_clock+0x13/0x120
                        [<c041c448>] timekeeping_init+0xc8/0x140
                        [<c04096e5>] start_kernel+0x1b5/0x450
                        [<00000000>] 0x0
   hardirq-on-W at:
                        [<c0146965>] lock_acquire+0x75/0xa0
                        [<c030d782>] rt_spin_lock+0x32/0x40
                        [<c0426f0b>] rtc_init+0xbb/0x1c0
                        [<c0100430>] init+0x130/0x430
                        [<c0103005>] kernel_thread_helper+0x5/0x10
 }
 ... key      at: [<c03ec8d0>] rtc_lock+0x50/0x80

the second lock's dependencies:
-> (name){+...} ops: 6297 {
   initial-use  at:
                        [<c0146965>] lock_acquire+0x75/0xa0
                        [<c030dd95>] __spin_lock+0x35/0x50
                        [<c041c39d>] timekeeping_init+0x1d/0x140
                        [<c04096e5>] start_kernel+0x1b5/0x450
                        [<00000000>] 0x0
   in-hardirq-W at:
                        [<c0146965>] lock_acquire+0x75/0xa0
                        [<c030dd95>] __spin_lock+0x35/0x50
                        [<c01430f0>] handle_tick_update_profile+0x10/0x50
                        [<c01089cb>] timer_interrupt+0x1b/0x60
                        [<c015ec3f>] handle_IRQ_event+0x5f/0xf0
                        [<c01608ac>] handle_level_irq+0xac/0x140
                        [<c0107d1c>] do_IRQ+0x4c/0xc0
                        [<c0105e89>] common_interrupt+0x25/0x2c
                        [<c026da4f>] serial8250_console_putchar+0x1f/0x90
                        [<c0268094>] uart_console_write+0x24/0x60
                        [<c026b43a>] serial8250_console_write+0x8a/0x150
                        [<c01288e4>] __call_console_drivers+0x64/0x80
                        [<c0128942>] _call_console_drivers+0x42/0x80
                        [<c01290dd>] release_console_sem+0xed/0x270
                        [<c01293bb>] register_console+0xcb/0x200
                        [<c0427592>] serial8250_console_init+0x12/0x20
                        [<c04262d5>] console_init+0x25/0x40
                        [<c040970a>] start_kernel+0x1da/0x450
                        [<00000000>] 0x0
 }
 ... key      at: [<c03efb98>] xtime_lock+0x18/0x80
 -> (clocksource_lock){....} ops: 1962 {
    initial-use  at:
                          [<c0146965>] lock_acquire+0x75/0xa0
                          [<c030e0e2>] __spin_lock_irqsave+0x42/0x60
                          [<c01428cd>] clocksource_get_next+0xd/0x50
                          [<c041c3b0>] timekeeping_init+0x30/0x140
                          [<c04096e5>] start_kernel+0x1b5/0x450
                          [<00000000>] 0x0
  }
  ... key      at: [<c03efe14>] clocksource_lock+0x14/0x80
 ... acquired at:
   [<c0146965>] lock_acquire+0x75/0xa0
   [<c030e0e2>] __spin_lock_irqsave+0x42/0x60
   [<c01428cd>] clocksource_get_next+0xd/0x50
   [<c041c3b0>] timekeeping_init+0x30/0x140
   [<c04096e5>] start_kernel+0x1b5/0x450
   [<00000000>] 0x0

 -> (rtc_lock){....} ops: 3 {
    initial-use  at:
                          [<c0146965>] lock_acquire+0x75/0xa0
                          [<c030e0e2>] __spin_lock_irqsave+0x42/0x60
                          [<c030ce31>] rt_spin_lock_slowlock+0x21/0x1d0
                          [<c030d761>] rt_spin_lock+0x11/0x40
                          [<c0108d93>] read_persistent_clock+0x13/0x120
                          [<c041c448>] timekeeping_init+0xc8/0x140
                          [<c04096e5>] start_kernel+0x1b5/0x450
                          [<00000000>] 0x0
  }
  ... key      at: [<c03ec894>] rtc_lock+0x14/0x80
 ... acquired at:
   [<c0146965>] lock_acquire+0x75/0xa0
   [<c030e0e2>] __spin_lock_irqsave+0x42/0x60
   [<c030ce31>] rt_spin_lock_slowlock+0x21/0x1d0
   [<c030d761>] rt_spin_lock+0x11/0x40
   [<c0108d93>] read_persistent_clock+0x13/0x120
   [<c041c448>] timekeeping_init+0xc8/0x140
   [<c04096e5>] start_kernel+0x1b5/0x450
   [<00000000>] 0x0

 -> (rtc_lock){-...} ops: 2 {
    initial-use  at:
                          [<c0146965>] lock_acquire+0x75/0xa0
                          [<c030d782>] rt_spin_lock+0x32/0x40
                          [<c0108d93>] read_persistent_clock+0x13/0x120
                          [<c041c448>] timekeeping_init+0xc8/0x140
                          [<c04096e5>] start_kernel+0x1b5/0x450
                          [<00000000>] 0x0
    hardirq-on-W at:
                          [<c0146965>] lock_acquire+0x75/0xa0
                          [<c030d782>] rt_spin_lock+0x32/0x40
                          [<c0426f0b>] rtc_init+0xbb/0x1c0
                          [<c0100430>] init+0x130/0x430
                          [<c0103005>] kernel_thread_helper+0x5/0x10
  }
  ... key      at: [<c03ec8d0>] rtc_lock+0x50/0x80
 ... acquired at:
   [<c0146965>] lock_acquire+0x75/0xa0
   [<c030d782>] rt_spin_lock+0x32/0x40
   [<c0108d93>] read_persistent_clock+0x13/0x120
   [<c041c448>] timekeeping_init+0xc8/0x140
   [<c04096e5>] start_kernel+0x1b5/0x450
   [<00000000>] 0x0


stack backtrace:
 [<c0106bb2>] show_trace+0x12/0x20
 [<c0106ca9>] dump_stack+0x19/0x20
 [<c01446e7>] print_irq_inversion_bug+0x107/0x130
 [<c0144842>] check_usage_backwards+0x42/0x50
 [<c0144c85>] mark_lock+0x335/0x5f0
 [<c01458c4>] __lock_acquire+0x124/0xe60
 [<c0146965>] lock_acquire+0x75/0xa0
 [<c030d782>] rt_spin_lock+0x32/0x40
 [<c0426f0b>] rtc_init+0xbb/0x1c0
 [<c0100430>] init+0x130/0x430
 [<c0103005>] kernel_thread_helper+0x5/0x10
---------------------------
| preempt count: 00000000 ]
| 0-level deep critical section nesting:
----------------------------------------

...
BUG: scheduling while atomic: swapper/0x00000001/0, CPU#0
BUG: unable to handle kernel NULL pointer dereference at virtual address
00000000
 printing eip:
c011f7ab
*pde = 00000000
Oops: 0002 [#1]
PREEMPT SMP
Modules linked in: loop dm_mod intel_rng usbhid wacom shpchp pci_hotplug
snd_intel8x0 snd_cs46xx gameport snd_ice1712 snd_ice17xx_ak4xxx
snd_ak4xxx_adda snd_cs8427 snd_ac97_codec snd_pcm snd_timer i2c_i801
ohci1394 ieee1394 i8xx_tco sk98lin snd_ac97_bus snd_i2c snd_mpu401_uart
intel_agp agpgart snd_rawmidi snd_seq_device i2c_core snd snd_page_alloc
soundcore ehci_hcd uhci_hcd usbcore ide_cd cdrom ext3 jbd reiserfs fan
thermal processor piix ide_disk ide_core
CPU:    1
EIP:    0060:[<c011f7ab>]    Not tainted VLI
EFLAGS: 00010046   (2.6.18.1-rt7.2-smp #1)
EIP is at enqueue_task+0x2b/0x90
eax: c18204e4   ebx: c1820068   ecx: 00000000   edx: c036a988
esi: c036a960   edi: c1820000   ebp: f74b9d6c   esp: f74b9d64
ds: 007b   es: 007b   ss: 0068   preempt: 00000004
Process boot.cleanup (pid: 2269, ti=f74b8000 task=f7a820b0 task.ti=f74b8000)
Stack: c1820000 c036a960 f74b9d7c c011f831 00000001 c036a960 f74b9ddc
c0121d2a
       f7a820b0 00000046 c030ce52 00000000 0000001f 00000000 00000001
00000004
       00000000 f74b9dd0 00000046 00000000 00000002 00000001 00000000
f74b9ddc
Call Trace:
 [<c01065c1>] show_stack_log_lvl+0xb1/0xe0
 [<c01067cc>] show_registers+0x1dc/0x270
 [<c0106993>] die+0x133/0x300
 [<c030fee1>] do_page_fault+0x1f1/0x5e0
 [<c0106021>] error_code+0x39/0x40
 [<c011f831>] __activate_task+0x21/0x40
 [<c0121d2a>] try_to_wake_up+0x31a/0x440
 [<c0121ec9>] wake_up_process_mutex+0x19/0x20
 [<c014a02f>] wakeup_next_waiter+0xef/0x1e0
 [<c030cd2c>] rt_spin_lock_slowunlock+0x5c/0x80
 [<c030d7ad>] rt_spin_unlock+0x1d/0x20
 [<c0310d3a>] kprobe_flush_task+0x3a/0x50
 [<c030bab5>] __schedule+0xbc5/0xf90
 [<c030bff0>] schedule+0x30/0x100
 [<c012b82c>] do_wait+0x73c/0xc00
 [<c012bd22>] sys_wait4+0x32/0x40
 [<c012bd57>] sys_waitpid+0x27/0x30
 [<c0105419>] sysenter_past_esp+0x56/0x8d
---------------------------
| preempt count: 00000004 ]
| 4-level deep critical section nesting:
----------------------------------------
.. [<c030af41>] .... __schedule+0x51/0xf90
.....[<c030bff0>] ..   ( <= schedule+0x30/0x100)
.. [<c030e0c0>] .... __spin_lock_irqsave+0x20/0x60
.....[<c030cce4>] ..   ( <= rt_spin_lock_slowunlock+0x14/0x80)
.. [<c030dd73>] .... __spin_lock+0x13/0x50
.....[<c012090c>] ..   ( <= task_rq_lock+0x3c/0x70)
.. [<c030e0c0>] .... __spin_lock_irqsave+0x20/0x60
.....[<c01068af>] ..   ( <= die+0x4f/0x300)

Code: 55 89 e5 56 89 c6 53 89 d3 f6 40 0c 08 74 09 a1 24 ec 36 c0 85 c0
75 4b 8b 46 1c 8d 56 28 8d 44 c3 1c 8b 48 04 89 46 28 89 50 04 <89> 11
89 4a 04 8b 46 1c 83 43 04 01 0f ab 43 08 83 7e 1c 63 89
EIP: [<c011f7ab>] enqueue_task+0x2b/0x90 SS:ESP 0068:f74b9d64
 <3>BUG: sleeping function called from invalid context
boot.cleanup(2269) at kernel/rtmutex.c:1155
in_atomic():1 [00000003], irqs_disabled():1
 [<c0106bb2>] show_trace+0x12/0x20
 [<c0106ca9>] dump_stack+0x19/0x20
 [<c011f460>] __might_sleep+0xe0/0x110
 [<c030cde8>] rt_mutex_lock+0x18/0x40
 [<c014b885>] rt_down_read+0x55/0x80
 [<c0137c7c>] blocking_notifier_call_chain+0x1c/0x50
 [<c012a1f1>] profile_task_exit+0x11/0x20
 [<c012bdec>] do_exit+0x1c/0xab0
 [<c0106b58>] die+0x2f8/0x300
 [<c030fee1>] do_page_fault+0x1f1/0x5e0
 [<c0106021>] error_code+0x39/0x40
 [<c011f831>] __activate_task+0x21/0x40
 [<c0121d2a>] try_to_wake_up+0x31a/0x440
 [<c0121ec9>] wake_up_process_mutex+0x19/0x20
 [<c014a02f>] wakeup_next_waiter+0xef/0x1e0
 [<c030cd2c>] rt_spin_lock_slowunlock+0x5c/0x80
 [<c030d7ad>] rt_spin_unlock+0x1d/0x20
 [<c0310d3a>] kprobe_flush_task+0x3a/0x50
 [<c030bab5>] __schedule+0xbc5/0xf90
 [<c030bff0>] schedule+0x30/0x100
 [<c012b82c>] do_wait+0x73c/0xc00
 [<c012bd22>] sys_wait4+0x32/0x40
 [<c012bd57>] sys_waitpid+0x27/0x30
 [<c0105419>] sysenter_past_esp+0x56/0x8d
---------------------------
| preempt count: 00000003 ]
| 3-level deep critical section nesting:
----------------------------------------
.. [<c030af41>] .... __schedule+0x51/0xf90
.....[<c030bff0>] ..   ( <= schedule+0x30/0x100)
.. [<c030e0c0>] .... __spin_lock_irqsave+0x20/0x60
.....[<c030cce4>] ..   ( <= rt_spin_lock_slowunlock+0x14/0x80)
.. [<c030dd73>] .... __spin_lock+0x13/0x50
.....[<c012090c>] ..   ( <= task_rq_lock+0x3c/0x70)

note: boot.cleanup[2269] exited with preempt_count 3


Bye now.
-- 
rncbc aka Rui Nuno Capela
rncbc@rncbc.org
