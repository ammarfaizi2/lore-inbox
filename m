Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265776AbUGNWTY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265776AbUGNWTY (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 14 Jul 2004 18:19:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265960AbUGNWTY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 14 Jul 2004 18:19:24 -0400
Received: from mustang.oldcity.dca.net ([216.158.38.3]:39119 "HELO
	mustang.oldcity.dca.net") by vger.kernel.org with SMTP
	id S265776AbUGNWTT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 14 Jul 2004 18:19:19 -0400
Subject: Losing interrupts
From: Lee Revell <rlrevell@joe-job.com>
To: linux-kernel <linux-kernel@vger.kernel.org>
Cc: alsa-devel <alsa-devel@lists.sourceforge.net>
Content-Type: text/plain
Message-Id: <1089843559.22841.8.camel@mindpipe>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 
Date: Wed, 14 Jul 2004 18:19:20 -0400
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

It seems that interrupts are being disabled for long periods, resulting
in the soundcard interrupt being lost.  I hacked the ALSA emu10k1 driver
to keep track in the interrupt handler of the number of CPU cycles
elapsed since the last time it ran.  I am using a period that
corresponds to 666 microseconds between interrupts, or ~400000 cycles on
my 600Mhz CPU.  As you can see the average jitter is *extremely* low -
50-400 CPU cycles of per interrupt.  I hardcoded it to printk if the
jitter is more than 15000 (only happens every 5-10 seconds), and error
if it's really big.  As you can see, something is disabling interrupts
for a long time.  This is a completely different issue from an XRUN,
improving the scheduler latency will not solve this.

Jul 14 18:06:08 mindpipe kernel: IRQ: delay =  392256 cycles, jitter = 15387
Jul 14 18:06:08 mindpipe kernel: IRQ: delay =  392353 cycles, jitter = 15603
Jul 14 18:06:08 mindpipe kernel: IRQ: delay =  391461 cycles, jitter = 16916
Jul 14 18:06:08 mindpipe kernel: IRQ: delay =  818180 cycles, jitter = 418547
Jul 14 18:06:08 mindpipe kernel: IRQ: delay =  818180 cycles, jitter = 418547 - missed an interrupt?
Jul 14 18:06:08 mindpipe kernel: ALSA /home/rlrevell/cvs/alsa-driver/alsa-kernel/core/pcm_lib.c:199: Unexpected hw_pointer value [1] (stream = 0, delta: -26, max jitter = 32): wrong interrupt
 acknowledge?
Jul 14 18:06:08 mindpipe kernel:  [dump_stack+23/32] dump_stack+0x17/0x20
Jul 14 18:06:08 mindpipe kernel:  [__crc_totalram_pages+664125/3558647] snd_pcm_period_elapsed+0x1a7/0x400 [snd_pcm]
Jul 14 18:06:08 mindpipe kernel:  [__crc_totalram_pages+729917/3558647] snd_emu10k1_interrupt+0x337/0x3c0 [snd_emu10k1]
Jul 14 18:06:08 mindpipe kernel:  [handle_IRQ_event+51/96] handle_IRQ_event+0x33/0x60
Jul 14 18:06:08 mindpipe kernel:  [do_IRQ+165/368] do_IRQ+0xa5/0x170
Jul 14 18:06:08 mindpipe kernel:  [common_interrupt+24/32] common_interrupt+0x18/0x20
Jul 14 18:06:08 mindpipe kernel:  [do_softirq+53/64] do_softirq+0x35/0x40
Jul 14 18:06:08 mindpipe kernel:  [do_IRQ+277/368] do_IRQ+0x115/0x170
Jul 14 18:06:08 mindpipe kernel:  [common_interrupt+24/32] common_interrupt+0x18/0x20
Jul 14 18:06:08 mindpipe kernel: 
Jul 14 18:06:08 mindpipe kernel: ALSA /home/rlrevell/cvs/alsa-driver/alsa-kernel/core/pcm_lib.c:199: Unexpected hw_pointer value [1] (stream = 1, delta: -4, max jitter = 32): wrong interrupt 
acknowledge?
Jul 14 18:06:08 mindpipe kernel:  [dump_stack+23/32] dump_stack+0x17/0x20
Jul 14 18:06:08 mindpipe kernel:  [__crc_totalram_pages+664125/3558647] snd_pcm_period_elapsed+0x1a7/0x400 [snd_pcm]
Jul 14 18:06:08 mindpipe kernel:  [__crc_totalram_pages+729303/3558647] snd_emu10k1_interrupt+0xd1/0x3c0 [snd_emu10k1]
Jul 14 18:06:08 mindpipe kernel:  [handle_IRQ_event+51/96] handle_IRQ_event+0x33/0x60
Jul 14 18:06:08 mindpipe kernel:  [do_IRQ+165/368] do_IRQ+0xa5/0x170
Jul 14 18:06:08 mindpipe kernel:  [common_interrupt+24/32] common_interrupt+0x18/0x20
Jul 14 18:06:08 mindpipe kernel:  [do_softirq+53/64] do_softirq+0x35/0x40
Jul 14 18:06:08 mindpipe kernel:  [do_IRQ+277/368] do_IRQ+0x115/0x170
Jul 14 18:06:08 mindpipe kernel:  [common_interrupt+24/32] common_interrupt+0x18/0x20
Jul 14 18:06:08 mindpipe kernel: 
Jul 14 18:06:08 mindpipe kernel: ALSA /home/rlrevell/cvs/alsa-driver/alsa-kernel/core/pcm_lib.c:169: XRUN: pcmC0D2c
Jul 14 18:06:08 mindpipe kernel:  [dump_stack+23/32] dump_stack+0x17/0x20
Jul 14 18:06:08 mindpipe kernel:  [__crc_totalram_pages+664413/3558647] snd_pcm_period_elapsed+0x2c7/0x400 [snd_pcm]
Jul 14 18:06:08 mindpipe kernel:  [__crc_totalram_pages+729303/3558647] snd_emu10k1_interrupt+0xd1/0x3c0 [snd_emu10k1]
Jul 14 18:06:08 mindpipe kernel:  [handle_IRQ_event+51/96] handle_IRQ_event+0x33/0x60
Jul 14 18:06:08 mindpipe kernel:  [do_IRQ+165/368] do_IRQ+0xa5/0x170
Jul 14 18:06:08 mindpipe kernel:  [common_interrupt+24/32] common_interrupt+0x18/0x20
Jul 14 18:06:08 mindpipe kernel: 
Jul 14 18:06:08 mindpipe kernel: IRQ: delay =  4964265 cycles, jitter = 4146085
Jul 14 18:06:08 mindpipe kernel: IRQ: delay =  4964265 cycles, jitter = 4146085 - missed an interrupt?
Jul 14 18:06:08 mindpipe kernel: ALSA /home/rlrevell/cvs/alsa-driver/alsa-kernel/core/pcm_lib.c:199: Unexpected hw_pointer value [1] (stream = 0, delta: -14, max jitter = 32): wrong interrupt
 acknowledge?
Jul 14 18:06:08 mindpipe kernel:  [dump_stack+23/32] dump_stack+0x17/0x20
Jul 14 18:06:08 mindpipe kernel:  [__crc_totalram_pages+664125/3558647] snd_pcm_period_elapsed+0x1a7/0x400 [snd_pcm]
Jul 14 18:06:08 mindpipe kernel:  [__crc_totalram_pages+729917/3558647] snd_emu10k1_interrupt+0x337/0x3c0 [snd_emu10k1]
Jul 14 18:06:08 mindpipe kernel:  [handle_IRQ_event+51/96] handle_IRQ_event+0x33/0x60
Jul 14 18:06:08 mindpipe kernel:  [do_IRQ+165/368] do_IRQ+0xa5/0x170
Jul 14 18:06:08 mindpipe kernel:  [common_interrupt+24/32] common_interrupt+0x18/0x20
Jul 14 18:06:08 mindpipe kernel: 
Jul 14 18:06:08 mindpipe kernel: IRQ: delay =  1055689 cycles, jitter = 3908576
Jul 14 18:06:08 mindpipe kernel: IRQ: delay =  1055689 cycles, jitter = 3908576 - missed an interrupt?
Jul 14 18:06:08 mindpipe kernel: IRQ: delay =  362752 cycles, jitter = 692937
Jul 14 18:06:08 mindpipe kernel: IRQ: delay =  362752 cycles, jitter = 692937 - missed an interrupt?
Jul 14 18:06:08 mindpipe kernel: IRQ: delay =  399829 cycles, jitter = 37077
Jul 14 18:06:08 mindpipe kernel: IRQ: delay =  413648 cycles, jitter = 15319
Jul 14 18:06:08 mindpipe kernel: IRQ: delay =  387686 cycles, jitter = 25962
Jul 14 18:06:08 mindpipe kernel: IRQ: delay =  450250 cycles, jitter = 51838
Jul 14 18:06:08 mindpipe kernel: IRQ: delay =  349918 cycles, jitter = 100332
Jul 14 18:06:08 mindpipe kernel: IRQ: delay =  400891 cycles, jitter = 50973
Jul 14 18:06:08 mindpipe kernel: IRQ: delay =  386404 cycles, jitter = 26320
Jul 14 18:06:08 mindpipe kernel: IRQ: delay =  453172 cycles, jitter = 54183
Jul 14 18:06:08 mindpipe kernel: IRQ: delay =  347573 cycles, jitter = 105599
Jul 14 18:06:08 mindpipe kernel: IRQ: delay =  401149 cycles, jitter = 53576
Jul 14 18:06:08 mindpipe kernel: IRQ: delay =  386633 cycles, jitter = 26209
Jul 14 18:06:08 mindpipe kernel: IRQ: delay =  449097 cycles, jitter = 49093
Jul 14 18:06:08 mindpipe kernel: IRQ: delay =  351560 cycles, jitter = 97537
Jul 14 18:06:08 mindpipe kernel: IRQ: delay =  397671 cycles, jitter = 46111
Jul 14 18:06:08 mindpipe kernel: IRQ: delay =  389595 cycles, jitter = 21606
Jul 14 18:06:08 mindpipe kernel: IRQ: delay =  451106 cycles, jitter = 51236
Jul 14 18:06:08 mindpipe kernel: IRQ: delay =  350349 cycles, jitter = 100757
Jul 14 18:06:08 mindpipe kernel: IRQ: delay =  400588 cycles, jitter = 50239
Jul 14 18:06:08 mindpipe kernel: IRQ: delay =  386300 cycles, jitter = 25946
Jul 14 18:06:08 mindpipe kernel: IRQ: delay =  448680 cycles, jitter = 49155
Jul 14 18:06:08 mindpipe kernel: IRQ: delay =  351876 cycles, jitter = 96804
Jul 14 18:06:08 mindpipe kernel: IRQ: delay =  400708 cycles, jitter = 48832
Jul 14 18:06:08 mindpipe kernel: IRQ: delay =  385443 cycles, jitter = 28488
Jul 14 18:06:08 mindpipe kernel: IRQ: delay =  400482 cycles, jitter = 15039
Jul 14 18:06:09 mindpipe kernel: IRQ: delay =  387947 cycles, jitter = 23589
Jul 14 18:06:09 mindpipe kernel: IRQ: delay =  391951 cycles, jitter = 16855
Jul 14 18:06:09 mindpipe kernel: IRQ: delay =  388987 cycles, jitter = 21825
Jul 14 18:06:09 mindpipe kernel: IRQ: delay =  392021 cycles, jitter = 16017
Jul 14 18:06:09 mindpipe kernel: IRQ: delay =  390522 cycles, jitter = 20142
Jul 14 18:06:09 mindpipe kernel: IRQ: delay =  391896 cycles, jitter = 17595
Jul 14 18:06:09 mindpipe kernel: IRQ: delay =  388017 cycles, jitter = 23648
Jul 14 18:06:09 mindpipe kernel: IRQ: delay =  391085 cycles, jitter = 18631
Jul 14 18:06:09 mindpipe kernel: IRQ: delay =  390518 cycles, jitter = 17585
Jul 14 18:06:09 mindpipe kernel: IRQ: delay =  390227 cycles, jitter = 18928
Jul 14 18:06:09 mindpipe kernel: IRQ: delay =  389163 cycles, jitter = 20901
Jul 14 18:06:09 mindpipe kernel: IRQ: delay =  389526 cycles, jitter = 19946
Jul 14 18:06:09 mindpipe kernel: IRQ: delay =  389876 cycles, jitter = 19494
Jul 14 18:06:09 mindpipe kernel: IRQ: delay =  391128 cycles, jitter = 17707
Jul 14 18:06:09 mindpipe kernel: IRQ: delay =  391987 cycles, jitter = 16681
Jul 14 18:06:09 mindpipe kernel: IRQ: delay =  390271 cycles, jitter = 18691
Jul 14 18:06:09 mindpipe kernel: IRQ: delay =  388294 cycles, jitter = 21678
Jul 14 18:06:09 mindpipe kernel: IRQ: delay =  389929 cycles, jitter = 19020
Jul 14 18:06:09 mindpipe kernel: IRQ: delay =  390888 cycles, jitter = 18574
Jul 14 18:06:09 mindpipe kernel: IRQ: delay =  387801 cycles, jitter = 22866
Jul 14 18:06:09 mindpipe kernel: IRQ: delay =  390384 cycles, jitter = 20683
Jul 14 18:06:09 mindpipe kernel: IRQ: delay =  391604 cycles, jitter = 17213
Jul 14 18:06:09 mindpipe kernel: IRQ: delay =  392076 cycles, jitter = 15074
Jul 14 18:06:09 mindpipe kernel: IRQ: delay =  392304 cycles, jitter = 15524
Jul 14 18:06:09 mindpipe kernel: IRQ: delay =  388990 cycles, jitter = 20218
Jul 14 18:06:09 mindpipe kernel: IRQ: delay =  391993 cycles, jitter = 16200
Jul 14 18:06:09 mindpipe kernel: IRQ: delay =  391055 cycles, jitter = 17245
Jul 14 18:06:09 mindpipe kernel: IRQ: delay =  391652 cycles, jitter = 15653
Jul 14 18:06:09 mindpipe kernel: IRQ: delay =  391095 cycles, jitter = 17794
Jul 14 18:06:10 mindpipe kernel: IRQ: delay =  392424 cycles, jitter = 15108


