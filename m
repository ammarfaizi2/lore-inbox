Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965472AbWKDPIo@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965472AbWKDPIo (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 4 Nov 2006 10:08:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965504AbWKDPIo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 4 Nov 2006 10:08:44 -0500
Received: from mout2.freenet.de ([194.97.50.155]:24037 "EHLO mout2.freenet.de")
	by vger.kernel.org with ESMTP id S965472AbWKDPIo (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 4 Nov 2006 10:08:44 -0500
From: Karsten Wiese <fzu@wemgehoertderstaat.de>
To: Rui Nuno Capela <rncbc@rncbc.org>
Subject: Re: realtime-preempt patch-2.6.18-rt7 oops
Date: Sat, 4 Nov 2006 16:08:52 +0100
User-Agent: KMail/1.9.5
Cc: linux-kernel@vger.kernel.org, Ingo Molnar <mingo@elte.hu>
References: <42997.194.65.103.1.1162464204.squirrel@www.rncbc.org> <454BF608.20803@rncbc.org> <454C714B.8030403@rncbc.org>
In-Reply-To: <454C714B.8030403@rncbc.org>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200611041608.53260.fzu@wemgehoertderstaat.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Am Samstag, 4. November 2006 11:54 schrieb Rui Nuno Capela:
> Rui Nuno Capela wrote:
> > 
> > I will now try turning on some .config debug options, e.g.
> > CONFIG_PREEMPT, and if I can catch something I'll be back here with some
> > more dumps ;)
> > 
> 
> 
> Turned on some kernel debug switches, notably CONFIG_DEBUG_PREEMPT,
> CONFIG_DEBUG_RT_MUTEXES, CONFIG_DEBUG_SLAB
>     and CONFIG_LOCKDEP, and it crashed on the very first boot. These are
> the traces that could be captured on serial console:
> 
> ...
> =========================================================
> [ INFO: possible irq lock inversion dependency detected ]
> ---------------------------------------------------------
> swapper/1 just changed the state of lock:
>  (rtc_lock){-...}, at: [<c0426f0b>] rtc_init+0xbb/0x1c0
> but this lock was taken by another, hard-irq-safe lock in the past:
>  (name){+...}
> 
> and interrupts could create inverse lock ordering between them.
> 
> 
> other info that might help us debug this:
> no locks held by swapper/1.
> 
> the first lock's dependencies:
> -> (rtc_lock){-...} ops: 2 {
>    initial-use  at:
>                         [<c0146965>] lock_acquire+0x75/0xa0
>                         [<c030d782>] rt_spin_lock+0x32/0x40
>                         [<c0108d93>] read_persistent_clock+0x13/0x120
>                         [<c041c448>] timekeeping_init+0xc8/0x140
>                         [<c04096e5>] start_kernel+0x1b5/0x450
>                         [<00000000>] 0x0
>    hardirq-on-W at:
>                         [<c0146965>] lock_acquire+0x75/0xa0
>                         [<c030d782>] rt_spin_lock+0x32/0x40
>                         [<c0426f0b>] rtc_init+0xbb/0x1c0
>                         [<c0100430>] init+0x130/0x430
>                         [<c0103005>] kernel_thread_helper+0x5/0x10
>  }
>  ... key      at: [<c03ec8d0>] rtc_lock+0x50/0x80
> 
> the second lock's dependencies:
> -> (name){+...} ops: 6297 {
>    initial-use  at:
>                         [<c0146965>] lock_acquire+0x75/0xa0
>                         [<c030dd95>] __spin_lock+0x35/0x50
>                         [<c041c39d>] timekeeping_init+0x1d/0x140
>                         [<c04096e5>] start_kernel+0x1b5/0x450
>                         [<00000000>] 0x0
>    in-hardirq-W at:
>                         [<c0146965>] lock_acquire+0x75/0xa0
>                         [<c030dd95>] __spin_lock+0x35/0x50
>                         [<c01430f0>] handle_tick_update_profile+0x10/0x50
>                         [<c01089cb>] timer_interrupt+0x1b/0x60
>                         [<c015ec3f>] handle_IRQ_event+0x5f/0xf0
>                         [<c01608ac>] handle_level_irq+0xac/0x140
>                         [<c0107d1c>] do_IRQ+0x4c/0xc0
>                         [<c0105e89>] common_interrupt+0x25/0x2c
>                         [<c026da4f>] serial8250_console_putchar+0x1f/0x90
>                         [<c0268094>] uart_console_write+0x24/0x60
>                         [<c026b43a>] serial8250_console_write+0x8a/0x150
>                         [<c01288e4>] __call_console_drivers+0x64/0x80
>                         [<c0128942>] _call_console_drivers+0x42/0x80
>                         [<c01290dd>] release_console_sem+0xed/0x270
>                         [<c01293bb>] register_console+0xcb/0x200
>                         [<c0427592>] serial8250_console_init+0x12/0x20
>                         [<c04262d5>] console_init+0x25/0x40
>                         [<c040970a>] start_kernel+0x1da/0x450
>                         [<00000000>] 0x0
>  }
>  ... key      at: [<c03efb98>] xtime_lock+0x18/0x80
>  -> (clocksource_lock){....} ops: 1962 {
>     initial-use  at:
>                           [<c0146965>] lock_acquire+0x75/0xa0
>                           [<c030e0e2>] __spin_lock_irqsave+0x42/0x60
>                           [<c01428cd>] clocksource_get_next+0xd/0x50
>                           [<c041c3b0>] timekeeping_init+0x30/0x140
>                           [<c04096e5>] start_kernel+0x1b5/0x450
>                           [<00000000>] 0x0
>   }
>   ... key      at: [<c03efe14>] clocksource_lock+0x14/0x80
>  ... acquired at:
>    [<c0146965>] lock_acquire+0x75/0xa0
>    [<c030e0e2>] __spin_lock_irqsave+0x42/0x60
>    [<c01428cd>] clocksource_get_next+0xd/0x50
>    [<c041c3b0>] timekeeping_init+0x30/0x140
>    [<c04096e5>] start_kernel+0x1b5/0x450
>    [<00000000>] 0x0
> 
>  -> (rtc_lock){....} ops: 3 {
>     initial-use  at:
>                           [<c0146965>] lock_acquire+0x75/0xa0
>                           [<c030e0e2>] __spin_lock_irqsave+0x42/0x60
>                           [<c030ce31>] rt_spin_lock_slowlock+0x21/0x1d0
>                           [<c030d761>] rt_spin_lock+0x11/0x40
>                           [<c0108d93>] read_persistent_clock+0x13/0x120
>                           [<c041c448>] timekeeping_init+0xc8/0x140
>                           [<c04096e5>] start_kernel+0x1b5/0x450
>                           [<00000000>] 0x0
>   }
>   ... key      at: [<c03ec894>] rtc_lock+0x14/0x80
>  ... acquired at:
>    [<c0146965>] lock_acquire+0x75/0xa0
>    [<c030e0e2>] __spin_lock_irqsave+0x42/0x60
>    [<c030ce31>] rt_spin_lock_slowlock+0x21/0x1d0
>    [<c030d761>] rt_spin_lock+0x11/0x40
>    [<c0108d93>] read_persistent_clock+0x13/0x120
>    [<c041c448>] timekeeping_init+0xc8/0x140
>    [<c04096e5>] start_kernel+0x1b5/0x450
>    [<00000000>] 0x0
> 
>  -> (rtc_lock){-...} ops: 2 {
>     initial-use  at:
>                           [<c0146965>] lock_acquire+0x75/0xa0
>                           [<c030d782>] rt_spin_lock+0x32/0x40
>                           [<c0108d93>] read_persistent_clock+0x13/0x120
>                           [<c041c448>] timekeeping_init+0xc8/0x140
>                           [<c04096e5>] start_kernel+0x1b5/0x450
>                           [<00000000>] 0x0
>     hardirq-on-W at:
>                           [<c0146965>] lock_acquire+0x75/0xa0
>                           [<c030d782>] rt_spin_lock+0x32/0x40
>                           [<c0426f0b>] rtc_init+0xbb/0x1c0
>                           [<c0100430>] init+0x130/0x430
>                           [<c0103005>] kernel_thread_helper+0x5/0x10
>   }
>   ... key      at: [<c03ec8d0>] rtc_lock+0x50/0x80
>  ... acquired at:
>    [<c0146965>] lock_acquire+0x75/0xa0
>    [<c030d782>] rt_spin_lock+0x32/0x40
>    [<c0108d93>] read_persistent_clock+0x13/0x120
>    [<c041c448>] timekeeping_init+0xc8/0x140
>    [<c04096e5>] start_kernel+0x1b5/0x450
>    [<00000000>] 0x0
> 
> 
> stack backtrace:
>  [<c0106bb2>] show_trace+0x12/0x20
>  [<c0106ca9>] dump_stack+0x19/0x20
>  [<c01446e7>] print_irq_inversion_bug+0x107/0x130
>  [<c0144842>] check_usage_backwards+0x42/0x50
>  [<c0144c85>] mark_lock+0x335/0x5f0
>  [<c01458c4>] __lock_acquire+0x124/0xe60
>  [<c0146965>] lock_acquire+0x75/0xa0
>  [<c030d782>] rt_spin_lock+0x32/0x40
>  [<c0426f0b>] rtc_init+0xbb/0x1c0
>  [<c0100430>] init+0x130/0x430
>  [<c0103005>] kernel_thread_helper+0x5/0x10
> ---------------------------
> | preempt count: 00000000 ]
> | 0-level deep critical section nesting:
> ----------------------------------------

Kernel stumbles over serial-console here ?

> 
> ...
> BUG: scheduling while atomic: swapper/0x00000001/0, CPU#0
> BUG: unable to handle kernel NULL pointer dereference at virtual address
> 00000000

Is it always address 00000000 in your logs, when enqueue_task() oopsed?

>  printing eip:
> c011f7ab
> *pde = 00000000
> Oops: 0002 [#1]
> PREEMPT SMP
> Modules linked in: loop dm_mod intel_rng usbhid wacom shpchp pci_hotplug
> snd_intel8x0 snd_cs46xx gameport snd_ice1712 snd_ice17xx_ak4xxx
> snd_ak4xxx_adda snd_cs8427 snd_ac97_codec snd_pcm snd_timer i2c_i801
> ohci1394 ieee1394 i8xx_tco sk98lin snd_ac97_bus snd_i2c snd_mpu401_uart
> intel_agp agpgart snd_rawmidi snd_seq_device i2c_core snd snd_page_alloc
> soundcore ehci_hcd uhci_hcd usbcore ide_cd cdrom ext3 jbd reiserfs fan
> thermal processor piix ide_disk ide_core
> CPU:    1
> EIP:    0060:[<c011f7ab>]    Not tainted VLI
> EFLAGS: 00010046   (2.6.18.1-rt7.2-smp #1)
> EIP is at enqueue_task+0x2b/0x90

Please
	$ gdb kernel/sched.o
	(gdb) disassemble enqueue_task
and post output.
Maybe we can see there what exactly is 0 and shouldn't be.

      Karsten
