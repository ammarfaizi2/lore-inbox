Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264098AbUGLW5e@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264098AbUGLW5e (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 12 Jul 2004 18:57:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264113AbUGLW5e
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 12 Jul 2004 18:57:34 -0400
Received: from mustang.oldcity.dca.net ([216.158.38.3]:48780 "HELO
	mustang.oldcity.dca.net") by vger.kernel.org with SMTP
	id S264098AbUGLW4r (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 12 Jul 2004 18:56:47 -0400
Subject: Re: [linux-audio-dev] Re: [announce] [patch] Voluntary Kernel
	Preemption Patch
From: Lee Revell <rlrevell@joe-job.com>
To: "The Linux Audio Developers' Mailing List" 
	<linux-audio-dev@music.columbia.edu>
Cc: Ingo Molnar <mingo@elte.hu>, arjanv@redhat.com,
       linux-kernel@vger.kernel.org
In-Reply-To: <20040710222510.0593f4a4.akpm@osdl.org>
References: <20040709182638.GA11310@elte.hu>
	 <20040710222510.0593f4a4.akpm@osdl.org>
Content-Type: text/plain
Message-Id: <1089673014.10777.42.camel@mindpipe>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 
Date: Mon, 12 Jul 2004 18:56:55 -0400
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 2004-07-11 at 01:25, Andrew Morton wrote:
> What we need to do is to encourage audio testers to use ALSA drivers, to
> enable CONFIG_SND_DEBUG in the kernel build and to set
> /proc/asound/*/*/xrun_debug and to send us the traces which result from
> underruns.
> 

OK, here goes.  The following traces result from running JACK overnight
like so, on an otherwise idle system.  Hardware is a VIA EPIA 6000, with
a 600Mhz C3 processor.  Kernel is 2.6.7 + volunatary_preempt patch. 
voluntary_preempt and kernel_preemption are both on.

jackd -v --realtime -d alsa --outchannels 2 --rate 48000 --shorts
--playback --period 32  --nperiods 2

These settings require less than 666 microseconds scheduler latency. 
The average performance is quite good - 5-20 *microseconds*!

load = 0.3754 max usecs: 5.000, spare = 661.000
load = 1.1637 max usecs: 13.000, spare = 653.000
load = 3.0593 max usecs: 33.000, spare = 633.000
load = 1.9050 max usecs: 5.000, spare = 661.000
load = 1.4780 max usecs: 7.000, spare = 659.000
load = 1.2645 max usecs: 7.000, spare = 659.000
load = 1.0076 max usecs: 5.000, spare = 661.000
load = 1.1044 max usecs: 8.000, spare = 658.000
load = 0.9276 max usecs: 5.000, spare = 661.000
load = 1.5148 max usecs: 14.000, spare = 652.000
load = 1.1328 max usecs: 5.000, spare = 661.000
load = 1.0168 max usecs: 6.000, spare = 660.000

However there are periodic XRUNS.  I noticed that many of these seem
APM-related, so here are the relevant settings:

# Power management options (ACPI, APM)
# APM (Advanced Power Management) BIOS Support
CONFIG_APM=y
# CONFIG_APM_IGNORE_USER_SUSPEND is not set
# CONFIG_APM_DO_ENABLE is not set
CONFIG_APM_CPU_IDLE=y
# CONFIG_APM_DISPLAY_BLANK is not set
CONFIG_APM_RTC_IS_GMT=y
# CONFIG_APM_ALLOW_INTS is not set
# CONFIG_APM_REAL_MODE_POWER_OFF is not set

I did not intend to activate these settings when I compiled the kernel,
but as this is certainly not an idle system, it seems like there may be
a bug lurking.

The log excerpts below are annotated.  Sorry if it is too long.

This section of the log is from running JACK overnight:

Jul 12 06:56:07 mindpipe kernel: ALSA /usr/src/alsa-cvs-1.0.5/alsa-driver/alsa-kernel/core/pcm_lib.c:169: XRUN: pcmC0D0p
Jul 12 06:56:07 mindpipe kernel:  [__crc_totalram_pages+1387264/5353478] snd_pcm_period_elapsed+0x2ca/0x410 [snd_pcm]
Jul 12 06:56:07 mindpipe kernel:  [__crc_totalram_pages+1455070/5353478] snd_emu10k1_interrupt+0x3c8/0x480 [snd_emu10k1]
Jul 12 06:56:07 mindpipe kernel:  [handle_IRQ_event+49/96] handle_IRQ_event+0x31/0x60
Jul 12 06:56:07 mindpipe kernel:  [do_IRQ+155/352] do_IRQ+0x9b/0x160
Jul 12 06:56:07 mindpipe kernel:  [common_interrupt+24/32] common_interrupt+0x18/0x20
Jul 12 06:56:07 mindpipe kernel:  [preempt_schedule+16/80] preempt_schedule+0x10/0x50
Jul 12 06:56:07 mindpipe kernel:  [rt_run_flush+135/144] rt_run_flush+0x87/0x90
Jul 12 06:56:07 mindpipe kernel:  [rt_secret_rebuild+0/48] rt_secret_rebuild+0x0/0x30
Jul 12 06:56:07 mindpipe kernel:  [rt_secret_rebuild+14/48] rt_secret_rebuild+0xe/0x30
Jul 12 06:56:07 mindpipe kernel:  [run_timer_softirq+201/416] run_timer_softirq+0xc9/0x1a0
Jul 12 06:56:07 mindpipe kernel:  [__do_softirq+131/144] __do_softirq+0x83/0x90
Jul 12 06:56:07 mindpipe kernel:  [do_softirq+53/64] do_softirq+0x35/0x40
Jul 12 06:56:07 mindpipe kernel:  [do_IRQ+261/352] do_IRQ+0x105/0x160
Jul 12 06:56:07 mindpipe kernel:  [common_interrupt+24/32] common_interrupt+0x18/0x20
Jul 12 06:56:07 mindpipe kernel:
Jul 12 07:46:07 mindpipe kernel: ALSA /usr/src/alsa-cvs-1.0.5/alsa-driver/alsa-kernel/core/pcm_lib.c:169: XRUN: pcmC0D0p
Jul 12 07:46:07 mindpipe kernel:  [__crc_totalram_pages+1387264/5353478] snd_pcm_period_elapsed+0x2ca/0x410 [snd_pcm]
Jul 12 07:46:07 mindpipe kernel:  [__crc_totalram_pages+1455070/5353478] snd_emu10k1_interrupt+0x3c8/0x480 [snd_emu10k1]
Jul 12 07:46:07 mindpipe kernel:  [handle_IRQ_event+49/96] handle_IRQ_event+0x31/0x60
Jul 12 07:46:07 mindpipe kernel:  [do_IRQ+155/352] do_IRQ+0x9b/0x160
Jul 12 07:46:07 mindpipe kernel:  [common_interrupt+24/32] common_interrupt+0x18/0x20
Jul 12 07:46:07 mindpipe kernel:  [preempt_schedule+1/80] preempt_schedule+0x1/0x50
Jul 12 07:46:07 mindpipe kernel:  [rt_run_flush+135/144] rt_run_flush+0x87/0x90
Jul 12 07:46:07 mindpipe kernel:  [rt_secret_rebuild+0/48] rt_secret_rebuild+0x0/0x30
Jul 12 07:46:07 mindpipe kernel:  [rt_secret_rebuild+14/48] rt_secret_rebuild+0xe/0x30
Jul 12 07:46:07 mindpipe kernel:  [run_timer_softirq+201/416] run_timer_softirq+0xc9/0x1a0
Jul 12 07:46:07 mindpipe kernel:  [__do_softirq+131/144] __do_softirq+0x83/0x90
Jul 12 07:46:07 mindpipe kernel:  [do_softirq+53/64] do_softirq+0x35/0x40
Jul 12 07:46:07 mindpipe kernel:  [do_IRQ+261/352] do_IRQ+0x105/0x160
Jul 12 07:46:07 mindpipe kernel:  [common_interrupt+24/32] common_interrupt+0x18/0x20
Jul 12 07:46:07 mindpipe kernel:  [default_idle+35/64] default_idle+0x23/0x40
Jul 12 07:46:07 mindpipe kernel:  [apm_cpu_idle+165/384] apm_cpu_idle+0xa5/0x180
Jul 12 07:46:07 mindpipe kernel:  [cpu_idle+45/64] cpu_idle+0x2d/0x40
Jul 12 07:46:07 mindpipe kernel:  [start_kernel+392/464] start_kernel+0x188/0x1d0
Jul 12 07:46:07 mindpipe kernel:
Jul 12 08:06:07 mindpipe kernel: ALSA /usr/src/alsa-cvs-1.0.5/alsa-driver/alsa-kernel/core/pcm_lib.c:169: XRUN: pcmC0D0p
Jul 12 08:06:07 mindpipe kernel:  [__crc_totalram_pages+1387264/5353478] snd_pcm_period_elapsed+0x2ca/0x410 [snd_pcm]
Jul 12 08:06:07 mindpipe kernel:  [__crc_totalram_pages+1455070/5353478] snd_emu10k1_interrupt+0x3c8/0x480 [snd_emu10k1]
Jul 12 08:06:07 mindpipe kernel:  [handle_IRQ_event+49/96] handle_IRQ_event+0x31/0x60
Jul 12 08:06:07 mindpipe kernel:  [do_IRQ+155/352] do_IRQ+0x9b/0x160
Jul 12 08:06:07 mindpipe kernel:  [common_interrupt+24/32] common_interrupt+0x18/0x20
Jul 12 08:06:07 mindpipe kernel:  [local_bh_enable+46/112] local_bh_enable+0x2e/0x70
Jul 12 08:06:07 mindpipe kernel:  [rt_run_flush+92/144] rt_run_flush+0x5c/0x90
Jul 12 08:06:07 mindpipe kernel:  [rt_secret_rebuild+0/48] rt_secret_rebuild+0x0/0x30
Jul 12 08:06:07 mindpipe kernel:  [rt_secret_rebuild+14/48] rt_secret_rebuild+0xe/0x30
Jul 12 08:06:07 mindpipe kernel:  [run_timer_softirq+201/416] run_timer_softirq+0xc9/0x1a0
Jul 12 08:06:07 mindpipe kernel:  [__do_softirq+131/144] __do_softirq+0x83/0x90
Jul 12 08:06:07 mindpipe kernel:  [do_softirq+53/64] do_softirq+0x35/0x40
Jul 12 08:06:07 mindpipe kernel:  [do_IRQ+261/352] do_IRQ+0x105/0x160
Jul 12 08:06:07 mindpipe kernel:  [common_interrupt+24/32] common_interrupt+0x18/0x20
Jul 12 08:06:07 mindpipe kernel:
Jul 12 08:26:06 mindpipe kernel: ALSA /usr/src/alsa-cvs-1.0.5/alsa-driver/alsa-kernel/core/pcm_lib.c:169: XRUN: pcmC0D0p
Jul 12 08:26:06 mindpipe kernel:  [__crc_totalram_pages+1387264/5353478] snd_pcm_period_elapsed+0x2ca/0x410 [snd_pcm]
Jul 12 08:26:06 mindpipe kernel:  [ide_build_sglist+50/160] ide_build_sglist+0x32/0xa0
Jul 12 08:26:06 mindpipe kernel:  [__crc_totalram_pages+1455070/5353478] snd_emu10k1_interrupt+0x3c8/0x480 [snd_emu10k1]
Jul 12 08:26:06 mindpipe kernel:  [handle_IRQ_event+49/96] handle_IRQ_event+0x31/0x60
Jul 12 08:26:06 mindpipe kernel:  [do_IRQ+155/352] do_IRQ+0x9b/0x160
Jul 12 08:26:06 mindpipe kernel:  [common_interrupt+24/32] common_interrupt+0x18/0x20
Jul 12 08:26:06 mindpipe kernel:  [del_timer+110/144] del_timer+0x6e/0x90
Jul 12 08:26:06 mindpipe kernel:  [schedule_timeout+94/176] schedule_timeout+0x5e/0xb0
Jul 12 08:26:06 mindpipe kernel:  [process_timeout+0/16] process_timeout+0x0/0x10
Jul 12 08:26:06 mindpipe kernel:  [do_poll+161/192] do_poll+0xa1/0xc0
Jul 12 08:26:06 mindpipe kernel:  [sys_poll+330/560] sys_poll+0x14a/0x230
Jul 12 08:26:06 mindpipe kernel:  [__pollwait+0/160] __pollwait+0x0/0xa0
Jul 12 08:26:06 mindpipe kernel:  [syscall_call+7/11] syscall_call+0x7/0xb
Jul 12 08:26:06 mindpipe kernel:
Jul 12 08:36:06 mindpipe kernel: ALSA /usr/src/alsa-cvs-1.0.5/alsa-driver/alsa-kernel/core/pcm_lib.c:169: XRUN: pcmC0D0p
Jul 12 08:36:06 mindpipe kernel:  [__crc_totalram_pages+1387264/5353478] snd_pcm_period_elapsed+0x2ca/0x410 [snd_pcm]
Jul 12 08:36:06 mindpipe kernel:  [__crc_totalram_pages+1455070/5353478] snd_emu10k1_interrupt+0x3c8/0x480 [snd_emu10k1]
Jul 12 08:36:06 mindpipe kernel:  [handle_IRQ_event+49/96] handle_IRQ_event+0x31/0x60
Jul 12 08:36:06 mindpipe kernel:  [do_IRQ+155/352] do_IRQ+0x9b/0x160
Jul 12 08:36:06 mindpipe kernel:  [common_interrupt+24/32] common_interrupt+0x18/0x20
Jul 12 08:36:06 mindpipe kernel:  [rt_run_flush+66/144] rt_run_flush+0x42/0x90
Jul 12 08:36:06 mindpipe kernel:  [rt_secret_rebuild+0/48] rt_secret_rebuild+0x0/0x30
Jul 12 08:36:06 mindpipe kernel:  [rt_secret_rebuild+14/48] rt_secret_rebuild+0xe/0x30
Jul 12 08:36:06 mindpipe kernel:  [run_timer_softirq+201/416] run_timer_softirq+0xc9/0x1a0
Jul 12 08:36:06 mindpipe kernel:  [__do_softirq+131/144] __do_softirq+0x83/0x90
Jul 12 08:36:06 mindpipe kernel:  [do_softirq+53/64] do_softirq+0x35/0x40
Jul 12 08:36:06 mindpipe kernel:  [do_IRQ+261/352] do_IRQ+0x105/0x160
Jul 12 08:36:06 mindpipe kernel:  [common_interrupt+24/32] common_interrupt+0x18/0x20
Jul 12 08:36:06 mindpipe kernel:  [default_idle+35/64] default_idle+0x23/0x40
Jul 12 08:36:06 mindpipe kernel:  [apm_cpu_idle+165/384] apm_cpu_idle+0xa5/0x180
Jul 12 08:36:06 mindpipe kernel:  [cpu_idle+45/64] cpu_idle+0x2d/0x40
Jul 12 08:36:06 mindpipe kernel:  [start_kernel+392/464] start_kernel+0x188/0x1d0
Jul 12 08:36:06 mindpipe kernel:
Jul 12 08:46:06 mindpipe kernel: ALSA /usr/src/alsa-cvs-1.0.5/alsa-driver/alsa-kernel/core/pcm_lib.c:169: XRUN: pcmC0D0p
Jul 12 08:46:06 mindpipe kernel:  [__crc_totalram_pages+1387264/5353478] snd_pcm_period_elapsed+0x2ca/0x410 [snd_pcm]
Jul 12 08:46:06 mindpipe kernel:  [__crc_totalram_pages+1455070/5353478] snd_emu10k1_interrupt+0x3c8/0x480 [snd_emu10k1]
Jul 12 08:46:06 mindpipe kernel:  [handle_IRQ_event+49/96] handle_IRQ_event+0x31/0x60
Jul 12 08:46:06 mindpipe kernel:  [do_IRQ+155/352] do_IRQ+0x9b/0x160
Jul 12 08:46:06 mindpipe kernel:  [common_interrupt+24/32] common_interrupt+0x18/0x20
Jul 12 08:46:06 mindpipe kernel:  [rt_run_flush+123/144] rt_run_flush+0x7b/0x90
Jul 12 08:46:06 mindpipe kernel:  [rt_secret_rebuild+0/48] rt_secret_rebuild+0x0/0x30
Jul 12 08:46:06 mindpipe kernel:  [rt_secret_rebuild+14/48] rt_secret_rebuild+0xe/0x30
Jul 12 08:46:06 mindpipe kernel:  [run_timer_softirq+201/416] run_timer_softirq+0xc9/0x1a0
Jul 12 08:46:06 mindpipe kernel:  [__do_softirq+131/144] __do_softirq+0x83/0x90
Jul 12 08:46:06 mindpipe kernel:  [do_softirq+53/64] do_softirq+0x35/0x40
Jul 12 08:46:06 mindpipe kernel:  [do_IRQ+261/352] do_IRQ+0x105/0x160
Jul 12 08:46:06 mindpipe kernel:  [common_interrupt+24/32] common_interrupt+0x18/0x20
Jul 12 08:46:06 mindpipe kernel:  [default_idle+35/64] default_idle+0x23/0x40
Jul 12 08:46:06 mindpipe kernel:  [apm_cpu_idle+165/384] apm_cpu_idle+0xa5/0x180
Jul 12 08:46:06 mindpipe kernel:  [cpu_idle+45/64] cpu_idle+0x2d/0x40
Jul 12 08:46:06 mindpipe kernel:  [start_kernel+392/464] start_kernel+0x188/0x1d0
Jul 12 08:46:06 mindpipe kernel:
Jul 12 08:56:06 mindpipe kernel: ALSA /usr/src/alsa-cvs-1.0.5/alsa-driver/alsa-kernel/core/pcm_lib.c:169: XRUN: pcmC0D0p
Jul 12 08:56:06 mindpipe kernel:  [__crc_totalram_pages+1387264/5353478] snd_pcm_period_elapsed+0x2ca/0x410 [snd_pcm]
Jul 12 08:56:06 mindpipe kernel:  [__crc_totalram_pages+1455070/5353478] snd_emu10k1_interrupt+0x3c8/0x480 [snd_emu10k1]
Jul 12 08:56:06 mindpipe kernel:  [handle_IRQ_event+49/96] handle_IRQ_event+0x31/0x60
Jul 12 08:56:06 mindpipe kernel:  [do_IRQ+155/352] do_IRQ+0x9b/0x160
Jul 12 08:56:06 mindpipe kernel:  [common_interrupt+24/32] common_interrupt+0x18/0x20
Jul 12 08:56:06 mindpipe kernel:  [rt_run_flush+123/144] rt_run_flush+0x7b/0x90
Jul 12 08:56:06 mindpipe kernel:  [rt_secret_rebuild+0/48] rt_secret_rebuild+0x0/0x30
Jul 12 08:56:06 mindpipe kernel:  [rt_secret_rebuild+14/48] rt_secret_rebuild+0xe/0x30
Jul 12 08:56:06 mindpipe kernel:  [run_timer_softirq+201/416] run_timer_softirq+0xc9/0x1a0
Jul 12 08:56:06 mindpipe kernel:  [__do_softirq+131/144] __do_softirq+0x83/0x90
Jul 12 08:56:06 mindpipe kernel:  [do_softirq+53/64] do_softirq+0x35/0x40
Jul 12 08:56:06 mindpipe kernel:  [do_IRQ+261/352] do_IRQ+0x105/0x160
Jul 12 08:56:06 mindpipe kernel:  [common_interrupt+24/32] common_interrupt+0x18/0x20
Jul 12 08:56:06 mindpipe kernel:  [default_idle+35/64] default_idle+0x23/0x40
Jul 12 08:56:06 mindpipe kernel:  [apm_cpu_idle+165/384] apm_cpu_idle+0xa5/0x180
Jul 12 08:56:06 mindpipe kernel:  [cpu_idle+45/64] cpu_idle+0x2d/0x40
Jul 12 08:56:06 mindpipe kernel:  [start_kernel+392/464] start_kernel+0x188/0x1d0
Jul 12 08:56:06 mindpipe kernel:
Jul 12 09:06:06 mindpipe kernel: ALSA /usr/src/alsa-cvs-1.0.5/alsa-driver/alsa-kernel/core/pcm_lib.c:169: XRUN: pcmC0D0p
Jul 12 09:06:06 mindpipe kernel:  [__crc_totalram_pages+1387264/5353478] snd_pcm_period_elapsed+0x2ca/0x410 [snd_pcm]
Jul 12 09:06:06 mindpipe kernel:  [__crc_totalram_pages+1455070/5353478] snd_emu10k1_interrupt+0x3c8/0x480 [snd_emu10k1]
Jul 12 09:06:06 mindpipe kernel:  [handle_IRQ_event+49/96] handle_IRQ_event+0x31/0x60
Jul 12 09:06:06 mindpipe kernel:  [do_IRQ+155/352] do_IRQ+0x9b/0x160
Jul 12 09:06:06 mindpipe kernel:  [common_interrupt+24/32] common_interrupt+0x18/0x20
Jul 12 09:06:06 mindpipe kernel:  [preempt_schedule+1/80] preempt_schedule+0x1/0x50
Jul 12 09:06:06 mindpipe kernel:  [rt_run_flush+135/144] rt_run_flush+0x87/0x90
Jul 12 09:06:06 mindpipe kernel:  [rt_secret_rebuild+0/48] rt_secret_rebuild+0x0/0x30
Jul 12 09:06:06 mindpipe kernel:  [rt_secret_rebuild+14/48] rt_secret_rebuild+0xe/0x30
Jul 12 09:06:06 mindpipe kernel:  [run_timer_softirq+201/416] run_timer_softirq+0xc9/0x1a0
Jul 12 09:06:06 mindpipe kernel:  [__do_softirq+131/144] __do_softirq+0x83/0x90
Jul 12 09:06:06 mindpipe kernel:  [do_softirq+53/64] do_softirq+0x35/0x40
Jul 12 09:06:06 mindpipe kernel:  [do_IRQ+261/352] do_IRQ+0x105/0x160
Jul 12 09:06:06 mindpipe kernel:  [common_interrupt+24/32] common_interrupt+0x18/0x20
Jul 12 09:06:06 mindpipe kernel:  [default_idle+35/64] default_idle+0x23/0x40
Jul 12 09:06:06 mindpipe kernel:  [apm_cpu_idle+165/384] apm_cpu_idle+0xa5/0x180
Jul 12 09:06:06 mindpipe kernel:  [cpu_idle+45/64] cpu_idle+0x2d/0x40
Jul 12 09:06:06 mindpipe kernel:  [start_kernel+392/464] start_kernel+0x188/0x1d0
Jul 12 09:06:06 mindpipe kernel:
Jul 12 09:36:06 mindpipe kernel: ALSA /usr/src/alsa-cvs-1.0.5/alsa-driver/alsa-kernel/core/pcm_lib.c:169: XRUN: pcmC0D0p
Jul 12 09:36:06 mindpipe kernel:  [__crc_totalram_pages+1387264/5353478] snd_pcm_period_elapsed+0x2ca/0x410 [snd_pcm]
Jul 12 09:36:06 mindpipe kernel:  [__crc_totalram_pages+1455070/5353478] snd_emu10k1_interrupt+0x3c8/0x480 [snd_emu10k1]
Jul 12 09:36:06 mindpipe kernel:  [handle_IRQ_event+49/96] handle_IRQ_event+0x31/0x60
Jul 12 09:36:06 mindpipe kernel:  [do_IRQ+155/352] do_IRQ+0x9b/0x160
Jul 12 09:36:06 mindpipe kernel:  [common_interrupt+24/32] common_interrupt+0x18/0x20
Jul 12 09:36:06 mindpipe kernel:  [local_bh_enable+23/112] local_bh_enable+0x17/0x70
Jul 12 09:36:06 mindpipe kernel:  [rt_run_flush+92/144] rt_run_flush+0x5c/0x90
Jul 12 09:36:06 mindpipe kernel:  [rt_secret_rebuild+0/48] rt_secret_rebuild+0x0/0x30
Jul 12 09:36:06 mindpipe kernel:  [rt_secret_rebuild+14/48] rt_secret_rebuild+0xe/0x30
Jul 12 09:36:06 mindpipe kernel:  [run_timer_softirq+201/416] run_timer_softirq+0xc9/0x1a0
Jul 12 09:36:06 mindpipe kernel:  [__do_softirq+131/144] __do_softirq+0x83/0x90
Jul 12 09:36:06 mindpipe kernel:  [do_softirq+53/64] do_softirq+0x35/0x40
Jul 12 09:36:06 mindpipe kernel:  [do_IRQ+261/352] do_IRQ+0x105/0x160
Jul 12 09:36:06 mindpipe kernel:  [common_interrupt+24/32] common_interrupt+0x18/0x20
Jul 12 09:36:06 mindpipe kernel:  [default_idle+35/64] default_idle+0x23/0x40
Jul 12 09:36:06 mindpipe kernel:  [apm_cpu_idle+165/384] apm_cpu_idle+0xa5/0x180
Jul 12 09:36:06 mindpipe kernel:  [cpu_idle+45/64] cpu_idle+0x2d/0x40
Jul 12 09:36:06 mindpipe kernel:  [start_kernel+392/464] start_kernel+0x188/0x1d0
Jul 12 09:36:06 mindpipe kernel:
Jul 12 09:46:06 mindpipe kernel: ALSA /usr/src/alsa-cvs-1.0.5/alsa-driver/alsa-kernel/core/pcm_lib.c:169: XRUN: pcmC0D0p
Jul 12 09:46:06 mindpipe kernel:  [__crc_totalram_pages+1387264/5353478] snd_pcm_period_elapsed+0x2ca/0x410 [snd_pcm]
Jul 12 09:46:06 mindpipe kernel:  [__crc_totalram_pages+1455070/5353478] snd_emu10k1_interrupt+0x3c8/0x480 [snd_emu10k1]
Jul 12 09:46:06 mindpipe kernel:  [handle_IRQ_event+49/96] handle_IRQ_event+0x31/0x60
Jul 12 09:46:06 mindpipe kernel:  [do_IRQ+155/352] do_IRQ+0x9b/0x160
Jul 12 09:46:06 mindpipe kernel:  [common_interrupt+24/32] common_interrupt+0x18/0x20
Jul 12 09:46:06 mindpipe kernel:  [preempt_schedule+23/80] preempt_schedule+0x17/0x50
Jul 12 09:46:06 mindpipe kernel:  [rt_run_flush+92/144] rt_run_flush+0x5c/0x90
Jul 12 09:46:06 mindpipe kernel:  [rt_secret_rebuild+0/48] rt_secret_rebuild+0x0/0x30
Jul 12 09:46:06 mindpipe kernel:  [rt_secret_rebuild+14/48] rt_secret_rebuild+0xe/0x30
Jul 12 09:46:06 mindpipe kernel:  [run_timer_softirq+201/416] run_timer_softirq+0xc9/0x1a0
Jul 12 09:46:06 mindpipe kernel:  [__do_softirq+131/144] __do_softirq+0x83/0x90
Jul 12 09:46:06 mindpipe kernel:  [do_softirq+53/64] do_softirq+0x35/0x40
Jul 12 09:46:06 mindpipe kernel:  [do_IRQ+261/352] do_IRQ+0x105/0x160
Jul 12 09:46:06 mindpipe kernel:  [common_interrupt+24/32] common_interrupt+0x18/0x20
Jul 12 09:46:06 mindpipe kernel:  [default_idle+35/64] default_idle+0x23/0x40
Jul 12 09:46:06 mindpipe kernel:  [apm_cpu_idle+165/384] apm_cpu_idle+0xa5/0x180
Jul 12 09:46:06 mindpipe kernel:  [cpu_idle+45/64] cpu_idle+0x2d/0x40
Jul 12 09:46:06 mindpipe kernel:  [start_kernel+392/464] start_kernel+0x188/0x1d0
Jul 12 09:46:06 mindpipe kernel:
Jul 12 10:16:05 mindpipe kernel: ALSA /usr/src/alsa-cvs-1.0.5/alsa-driver/alsa-kernel/core/pcm_lib.c:169: XRUN: pcmC0D0p
Jul 12 10:16:05 mindpipe kernel:  [__crc_totalram_pages+1387264/5353478] snd_pcm_period_elapsed+0x2ca/0x410 [snd_pcm]
Jul 12 10:16:05 mindpipe kernel:  [__crc_totalram_pages+1455070/5353478] snd_emu10k1_interrupt+0x3c8/0x480 [snd_emu10k1]
Jul 12 10:16:05 mindpipe kernel:  [handle_IRQ_event+49/96] handle_IRQ_event+0x31/0x60
Jul 12 10:16:05 mindpipe kernel:  [do_IRQ+155/352] do_IRQ+0x9b/0x160
Jul 12 10:16:05 mindpipe kernel:  [common_interrupt+24/32] common_interrupt+0x18/0x20
Jul 12 10:16:05 mindpipe kernel:  [preempt_schedule+73/80] preempt_schedule+0x49/0x50
Jul 12 10:16:05 mindpipe kernel:  [rt_run_flush+135/144] rt_run_flush+0x87/0x90
Jul 12 10:16:05 mindpipe kernel:  [rt_secret_rebuild+0/48] rt_secret_rebuild+0x0/0x30
Jul 12 10:16:05 mindpipe kernel:  [rt_secret_rebuild+14/48] rt_secret_rebuild+0xe/0x30
Jul 12 10:16:05 mindpipe kernel:  [run_timer_softirq+201/416] run_timer_softirq+0xc9/0x1a0
Jul 12 10:16:05 mindpipe kernel:  [__do_softirq+131/144] __do_softirq+0x83/0x90
Jul 12 10:16:05 mindpipe kernel:  [do_softirq+53/64] do_softirq+0x35/0x40
Jul 12 10:16:05 mindpipe kernel:  [do_IRQ+261/352] do_IRQ+0x105/0x160
Jul 12 10:16:05 mindpipe kernel:  [common_interrupt+24/32] common_interrupt+0x18/0x20
Jul 12 10:16:05 mindpipe kernel:  [default_idle+35/64] default_idle+0x23/0x40
Jul 12 10:16:05 mindpipe kernel:  [apm_cpu_idle+165/384] apm_cpu_idle+0xa5/0x180
Jul 12 10:16:05 mindpipe kernel:  [cpu_idle+45/64] cpu_idle+0x2d/0x40
Jul 12 10:16:05 mindpipe kernel:  [start_kernel+392/464] start_kernel+0x188/0x1d0
Jul 12 10:16:05 mindpipe kernel:
Jul 12 10:46:05 mindpipe kernel: ALSA /usr/src/alsa-cvs-1.0.5/alsa-driver/alsa-kernel/core/pcm_lib.c:169: XRUN: pcmC0D0p
Jul 12 10:46:05 mindpipe kernel:  [__crc_totalram_pages+1387264/5353478] snd_pcm_period_elapsed+0x2ca/0x410 [snd_pcm]
Jul 12 10:46:05 mindpipe kernel:  [__crc_totalram_pages+1455070/5353478] snd_emu10k1_interrupt+0x3c8/0x480 [snd_emu10k1]
Jul 12 10:46:05 mindpipe kernel:  [handle_IRQ_event+49/96] handle_IRQ_event+0x31/0x60
Jul 12 10:46:05 mindpipe kernel:  [do_IRQ+155/352] do_IRQ+0x9b/0x160
Jul 12 10:46:05 mindpipe kernel:  [common_interrupt+24/32] common_interrupt+0x18/0x20
Jul 12 10:46:05 mindpipe kernel:  [rt_run_flush+94/144] rt_run_flush+0x5e/0x90
Jul 12 10:46:05 mindpipe kernel:  [rt_secret_rebuild+0/48] rt_secret_rebuild+0x0/0x30
Jul 12 10:46:05 mindpipe kernel:  [rt_secret_rebuild+14/48] rt_secret_rebuild+0xe/0x30
Jul 12 10:46:05 mindpipe kernel:  [run_timer_softirq+201/416] run_timer_softirq+0xc9/0x1a0
Jul 12 10:46:05 mindpipe kernel:  [__do_softirq+131/144] __do_softirq+0x83/0x90
Jul 12 10:46:05 mindpipe kernel:  [do_softirq+53/64] do_softirq+0x35/0x40
Jul 12 10:46:05 mindpipe kernel:  [do_IRQ+261/352] do_IRQ+0x105/0x160
Jul 12 10:46:05 mindpipe kernel:  [common_interrupt+24/32] common_interrupt+0x18/0x20
Jul 12 10:46:05 mindpipe kernel:  [default_idle+35/64] default_idle+0x23/0x40
Jul 12 10:46:05 mindpipe kernel:  [apm_cpu_idle+165/384] apm_cpu_idle+0xa5/0x180
Jul 12 10:46:05 mindpipe kernel:  [cpu_idle+45/64] cpu_idle+0x2d/0x40
Jul 12 10:46:05 mindpipe kernel:  [start_kernel+392/464] start_kernel+0x188/0x1d0
Jul 12 10:46:05 mindpipe kernel:
Jul 12 10:56:05 mindpipe kernel: ALSA /usr/src/alsa-cvs-1.0.5/alsa-driver/alsa-kernel/core/pcm_lib.c:169: XRUN: pcmC0D0p
Jul 12 10:56:05 mindpipe kernel:  [__crc_totalram_pages+1387264/5353478] snd_pcm_period_elapsed+0x2ca/0x410 [snd_pcm]
Jul 12 10:56:05 mindpipe kernel:  [__crc_totalram_pages+1455070/5353478] snd_emu10k1_interrupt+0x3c8/0x480 [snd_emu10k1]
Jul 12 10:56:05 mindpipe kernel:  [handle_IRQ_event+49/96] handle_IRQ_event+0x31/0x60
Jul 12 10:56:05 mindpipe kernel:  [do_IRQ+155/352] do_IRQ+0x9b/0x160
Jul 12 10:56:05 mindpipe kernel:  [common_interrupt+24/32] common_interrupt+0x18/0x20
Jul 12 10:56:05 mindpipe kernel:  [local_bh_enable+8/112] local_bh_enable+0x8/0x70
Jul 12 10:56:05 mindpipe kernel:  [rt_run_flush+92/144] rt_run_flush+0x5c/0x90
Jul 12 10:56:05 mindpipe kernel:  [rt_secret_rebuild+0/48] rt_secret_rebuild+0x0/0x30
Jul 12 10:56:05 mindpipe kernel:  [rt_secret_rebuild+14/48] rt_secret_rebuild+0xe/0x30
Jul 12 10:56:05 mindpipe kernel:  [run_timer_softirq+201/416] run_timer_softirq+0xc9/0x1a0
Jul 12 10:56:05 mindpipe kernel:  [__do_softirq+131/144] __do_softirq+0x83/0x90
Jul 12 10:56:05 mindpipe kernel:  [do_softirq+53/64] do_softirq+0x35/0x40
Jul 12 10:56:05 mindpipe kernel:  [do_IRQ+261/352] do_IRQ+0x105/0x160
Jul 12 10:56:05 mindpipe kernel:  [common_interrupt+24/32] common_interrupt+0x18/0x20
Jul 12 10:56:05 mindpipe kernel:  [default_idle+35/64] default_idle+0x23/0x40
Jul 12 10:56:05 mindpipe kernel:  [apm_cpu_idle+165/384] apm_cpu_idle+0xa5/0x180
Jul 12 10:56:05 mindpipe kernel:  [cpu_idle+45/64] cpu_idle+0x2d/0x40
Jul 12 10:56:05 mindpipe kernel:  [start_kernel+392/464] start_kernel+0x188/0x1d0
Jul 12 10:56:05 mindpipe kernel:
Jul 12 11:06:05 mindpipe kernel: ALSA /usr/src/alsa-cvs-1.0.5/alsa-driver/alsa-kernel/core/pcm_lib.c:169: XRUN: pcmC0D0p
Jul 12 11:06:05 mindpipe kernel:  [__crc_totalram_pages+1387264/5353478] snd_pcm_period_elapsed+0x2ca/0x410 [snd_pcm]
Jul 12 11:06:05 mindpipe kernel:  [__crc_totalram_pages+1455070/5353478] snd_emu10k1_interrupt+0x3c8/0x480 [snd_emu10k1]
Jul 12 11:06:05 mindpipe kernel:  [handle_IRQ_event+49/96] handle_IRQ_event+0x31/0x60
Jul 12 11:06:05 mindpipe kernel:  [do_IRQ+155/352] do_IRQ+0x9b/0x160
Jul 12 11:06:05 mindpipe kernel:  [common_interrupt+24/32] common_interrupt+0x18/0x20
Jul 12 11:06:05 mindpipe kernel:  [preempt_schedule+9/80] preempt_schedule+0x9/0x50
Jul 12 11:06:05 mindpipe kernel:  [rt_run_flush+92/144] rt_run_flush+0x5c/0x90
Jul 12 11:06:05 mindpipe kernel:  [rt_secret_rebuild+0/48] rt_secret_rebuild+0x0/0x30
Jul 12 11:06:05 mindpipe kernel:  [rt_secret_rebuild+14/48] rt_secret_rebuild+0xe/0x30
Jul 12 11:06:05 mindpipe kernel:  [run_timer_softirq+201/416] run_timer_softirq+0xc9/0x1a0
Jul 12 11:06:05 mindpipe kernel:  [__do_softirq+131/144] __do_softirq+0x83/0x90
Jul 12 11:06:05 mindpipe kernel:  [do_softirq+53/64] do_softirq+0x35/0x40
Jul 12 11:06:05 mindpipe kernel:  [do_IRQ+261/352] do_IRQ+0x105/0x160
Jul 12 11:06:05 mindpipe kernel:  [common_interrupt+24/32] common_interrupt+0x18/0x20
Jul 12 11:06:05 mindpipe kernel:  [default_idle+35/64] default_idle+0x23/0x40
Jul 12 11:06:05 mindpipe kernel:  [apm_cpu_idle+165/384] apm_cpu_idle+0xa5/0x180
Jul 12 11:06:05 mindpipe kernel:  [cpu_idle+45/64] cpu_idle+0x2d/0x40
Jul 12 11:06:05 mindpipe kernel:  [start_kernel+392/464] start_kernel+0x188/0x1d0
Jul 12 11:06:05 mindpipe kernel:
Jul 12 11:36:05 mindpipe kernel: ALSA /usr/src/alsa-cvs-1.0.5/alsa-driver/alsa-kernel/core/pcm_lib.c:169: XRUN: pcmC0D0p
Jul 12 11:36:05 mindpipe kernel:  [__crc_totalram_pages+1387264/5353478] snd_pcm_period_elapsed+0x2ca/0x410 [snd_pcm]
Jul 12 11:36:05 mindpipe kernel:  [__crc_totalram_pages+1455070/5353478] snd_emu10k1_interrupt+0x3c8/0x480 [snd_emu10k1]
Jul 12 11:36:05 mindpipe kernel:  [handle_IRQ_event+49/96] handle_IRQ_event+0x31/0x60
Jul 12 11:36:05 mindpipe kernel:  [do_IRQ+155/352] do_IRQ+0x9b/0x160
Jul 12 11:36:05 mindpipe kernel:  [common_interrupt+24/32] common_interrupt+0x18/0x20
Jul 12 11:36:05 mindpipe kernel:  [local_bh_enable+0/112] local_bh_enable+0x0/0x70
Jul 12 11:36:05 mindpipe kernel:  [rt_run_flush+92/144] rt_run_flush+0x5c/0x90
Jul 12 11:36:05 mindpipe kernel:  [rt_secret_rebuild+0/48] rt_secret_rebuild+0x0/0x30
Jul 12 11:36:05 mindpipe kernel:  [rt_secret_rebuild+14/48] rt_secret_rebuild+0xe/0x30
Jul 12 11:36:05 mindpipe kernel:  [run_timer_softirq+201/416] run_timer_softirq+0xc9/0x1a0
Jul 12 11:36:05 mindpipe kernel:  [__do_softirq+131/144] __do_softirq+0x83/0x90
Jul 12 11:36:05 mindpipe kernel:  [do_softirq+53/64] do_softirq+0x35/0x40
Jul 12 11:36:05 mindpipe kernel:  [do_IRQ+261/352] do_IRQ+0x105/0x160
Jul 12 11:36:05 mindpipe kernel:  [common_interrupt+24/32] common_interrupt+0x18/0x20
Jul 12 11:36:05 mindpipe kernel:  [default_idle+35/64] default_idle+0x23/0x40
Jul 12 11:36:05 mindpipe kernel:  [apm_cpu_idle+165/384] apm_cpu_idle+0xa5/0x180
Jul 12 11:36:05 mindpipe kernel:  [cpu_idle+45/64] cpu_idle+0x2d/0x40
Jul 12 11:36:05 mindpipe kernel:  [start_kernel+392/464] start_kernel+0x188/0x1d0
Jul 12 11:36:05 mindpipe kernel:
Jul 12 11:46:05 mindpipe kernel: ALSA /usr/src/alsa-cvs-1.0.5/alsa-driver/alsa-kernel/core/pcm_lib.c:169: XRUN: pcmC0D0p
Jul 12 11:46:05 mindpipe kernel:  [__crc_totalram_pages+1387264/5353478] snd_pcm_period_elapsed+0x2ca/0x410 [snd_pcm]
Jul 12 11:46:05 mindpipe kernel:  [__crc_totalram_pages+1455070/5353478] snd_emu10k1_interrupt+0x3c8/0x480 [snd_emu10k1]
Jul 12 11:46:05 mindpipe kernel:  [handle_IRQ_event+49/96] handle_IRQ_event+0x31/0x60
Jul 12 11:46:05 mindpipe kernel:  [do_IRQ+155/352] do_IRQ+0x9b/0x160
Jul 12 11:46:05 mindpipe kernel:  [common_interrupt+24/32] common_interrupt+0x18/0x20
Jul 12 11:46:05 mindpipe kernel:  [rt_run_flush+66/144] rt_run_flush+0x42/0x90
Jul 12 11:46:05 mindpipe kernel:  [rt_secret_rebuild+0/48] rt_secret_rebuild+0x0/0x30
Jul 12 11:46:05 mindpipe kernel:  [rt_secret_rebuild+14/48] rt_secret_rebuild+0xe/0x30
Jul 12 11:46:05 mindpipe kernel:  [run_timer_softirq+201/416] run_timer_softirq+0xc9/0x1a0
Jul 12 11:46:05 mindpipe kernel:  [__do_softirq+131/144] __do_softirq+0x83/0x90
Jul 12 11:46:05 mindpipe kernel:  [do_softirq+53/64] do_softirq+0x35/0x40
Jul 12 11:46:05 mindpipe kernel:  [do_IRQ+261/352] do_IRQ+0x105/0x160
Jul 12 11:46:05 mindpipe kernel:  [common_interrupt+24/32] common_interrupt+0x18/0x20
Jul 12 11:46:05 mindpipe kernel:  [default_idle+35/64] default_idle+0x23/0x40
Jul 12 11:46:05 mindpipe kernel:  [apm_cpu_idle+165/384] apm_cpu_idle+0xa5/0x180
Jul 12 11:46:05 mindpipe kernel:  [cpu_idle+45/64] cpu_idle+0x2d/0x40
Jul 12 11:46:05 mindpipe kernel:  [start_kernel+392/464] start_kernel+0x188/0x1d0

That continues until I sat down at the machine and switched consoles.  I am aware that 
this is a known latency 'hot spot' and not trivial to fix.  Here are the traces anyway:

Jul 12 17:33:42 mindpipe kernel:
Jul 12 17:33:42 mindpipe kernel: ALSA /usr/src/alsa-cvs-1.0.5/alsa-driver/alsa-kernel/core/pcm_lib.c:169: XRUN: pcmC0D0p Jul 12 17:33:42 mindpipe kernel:  [__crc_totalram_pages+1387264/5353478] snd_pcm_period_elapsed+0x2ca/0x410 [snd_pcm]
Jul 12 17:33:42 mindpipe kernel:  [__crc_totalram_pages+1455070/5353478] snd_emu10k1_interrupt+0x3c8/0x480 [snd_emu10k1]
Jul 12 17:33:42 mindpipe kernel:  [handle_IRQ_event+49/96] handle_IRQ_event+0x31/0x60
Jul 12 17:33:42 mindpipe kernel:  [do_IRQ+155/352] do_IRQ+0x9b/0x160
Jul 12 17:33:42 mindpipe kernel:  [common_interrupt+24/32] common_interrupt+0x18/0x20
Jul 12 17:33:42 mindpipe kernel:  [release_console_sem+129/208] release_console_sem+0x81/0xd0
Jul 12 17:33:42 mindpipe kernel:  [do_con_write+657/1888] do_con_write+0x291/0x760
Jul 12 17:33:42 mindpipe kernel:  [con_put_char+51/64] con_put_char+0x33/0x40
Jul 12 17:33:42 mindpipe kernel:  [opost+162/464] opost+0xa2/0x1d0
Jul 12 17:33:42 mindpipe kernel:  [write_chan+437/544] write_chan+0x1b5/0x220
Jul 12 17:33:42 mindpipe kernel:  [default_wake_function+0/32] default_wake_function+0x0/0x20
Jul 12 17:33:42 mindpipe kernel:  [default_wake_function+0/32] default_wake_function+0x0/0x20
Jul 12 17:33:42 mindpipe kernel:  [tty_write+434/608] tty_write+0x1b2/0x260
Jul 12 17:33:42 mindpipe kernel:  [write_chan+0/544] write_chan+0x0/0x220
Jul 12 17:33:42 mindpipe kernel:  [vfs_write+186/256] vfs_write+0xba/0x100
Jul 12 17:33:42 mindpipe kernel:  [sys_write+45/80] sys_write+0x2d/0x50
Jul 12 17:33:42 mindpipe kernel:  [syscall_call+7/11] syscall_call+0x7/0xb
Jul 12 17:33:42 mindpipe kernel:
Jul 12 17:33:42 mindpipe kernel: ALSA /usr/src/alsa-cvs-1.0.5/alsa-driver/alsa-kernel/core/pcm_lib.c:169: XRUN: pcmC0D0p
Jul 12 17:33:42 mindpipe kernel:  [__crc_totalram_pages+1387264/5353478] snd_pcm_period_elapsed+0x2ca/0x410 [snd_pcm]
Jul 12 17:33:42 mindpipe kernel:  [avc_has_perm+72/96] avc_has_perm+0x48/0x60
Jul 12 17:33:42 mindpipe kernel:  [__crc_totalram_pages+1455070/5353478] snd_emu10k1_interrupt+0x3c8/0x480 [snd_emu10k1]
Jul 12 17:33:42 mindpipe kernel:  [handle_IRQ_event+49/96] handle_IRQ_event+0x31/0x60
Jul 12 17:33:42 mindpipe kernel:  [do_IRQ+155/352] do_IRQ+0x9b/0x160
Jul 12 17:33:42 mindpipe kernel:  [common_interrupt+24/32] common_interrupt+0x18/0x20
Jul 12 17:33:42 mindpipe kernel:  [lf+1/112] lf+0x1/0x70
Jul 12 17:33:42 mindpipe kernel:  [do_con_trol+2907/3360] do_con_trol+0xb5b/0xd20
Jul 12 17:33:42 mindpipe kernel:  [do_con_write+1128/1888] do_con_write+0x468/0x760
Jul 12 17:33:42 mindpipe kernel:  [con_put_char+51/64] con_put_char+0x33/0x40
Jul 12 17:33:42 mindpipe kernel:  [opost+162/464] opost+0xa2/0x1d0
Jul 12 17:33:42 mindpipe kernel:  [write_chan+437/544] write_chan+0x1b5/0x220
Jul 12 17:33:42 mindpipe kernel:  [default_wake_function+0/32] default_wake_function+0x0/0x20
Jul 12 17:33:42 mindpipe kernel:  [default_wake_function+0/32] default_wake_function+0x0/0x20
Jul 12 17:33:42 mindpipe kernel:  [tty_write+434/608] tty_write+0x1b2/0x260
Jul 12 17:33:42 mindpipe kernel:  [write_chan+0/544] write_chan+0x0/0x220
Jul 12 17:33:42 mindpipe kernel:  [vfs_write+186/256] vfs_write+0xba/0x100
Jul 12 17:33:42 mindpipe kernel:  [sys_write+45/80] sys_write+0x2d/0x50
Jul 12 17:33:42 mindpipe kernel:  [syscall_call+7/11] syscall_call+0x7/0xb
Jul 12 17:33:42 mindpipe kernel:

It looks like reiserfs has a hot spot as well:

Jul 12 17:55:11 mindpipe kernel: ALSA /usr/src/alsa-cvs-1.0.5/alsa-driver/alsa-kernel/core/pcm_lib.c:169: XRUN: pcmC0D0p
Jul 12 17:55:11 mindpipe kernel:  [__crc_totalram_pages+1387264/5353478] snd_pcm_period_elapsed+0x2ca/0x410 [snd_pcm]
Jul 12 17:55:11 mindpipe kernel:  [do_pollfd+125/144] do_pollfd+0x7d/0x90
Jul 12 17:55:11 mindpipe kernel:  [__crc_totalram_pages+1455070/5353478] snd_emu10k1_interrupt+0x3c8/0x480 [snd_emu10k1]
Jul 12 17:55:11 mindpipe kernel:  [handle_IRQ_event+49/96] handle_IRQ_event+0x31/0x60
Jul 12 17:55:11 mindpipe kernel:  [do_IRQ+155/352] do_IRQ+0x9b/0x160
Jul 12 17:55:11 mindpipe kernel:  [common_interrupt+24/32] common_interrupt+0x18/0x20
Jul 12 17:55:11 mindpipe kernel:
Jul 12 17:55:11 mindpipe kernel: ALSA /usr/src/alsa-cvs-1.0.5/alsa-driver/alsa-kernel/core/pcm_lib.c:169: XRUN: pcmC0D0p
Jul 12 17:55:11 mindpipe kernel:  [__crc_totalram_pages+1387264/5353478] snd_pcm_period_elapsed+0x2ca/0x410 [snd_pcm]
Jul 12 17:55:11 mindpipe kernel:  [__crc_totalram_pages+1455070/5353478] snd_emu10k1_interrupt+0x3c8/0x480 [snd_emu10k1]
Jul 12 17:55:11 mindpipe kernel:  [handle_IRQ_event+49/96] handle_IRQ_event+0x31/0x60
Jul 12 17:55:11 mindpipe kernel:  [do_IRQ+155/352] do_IRQ+0x9b/0x160
Jul 12 17:55:11 mindpipe kernel:  [common_interrupt+24/32] common_interrupt+0x18/0x20
Jul 12 17:55:11 mindpipe kernel:  [free_hot_cold_page+21/288] free_hot_cold_page+0x15/0x120
Jul 12 17:55:11 mindpipe kernel:  [poll_freewait+68/80] poll_freewait+0x44/0x50
Jul 12 17:55:11 mindpipe kernel:  [sys_poll+489/560] sys_poll+0x1e9/0x230
Jul 12 17:55:11 mindpipe kernel:  [__pollwait+0/160] __pollwait+0x0/0xa0
Jul 12 17:55:11 mindpipe kernel:  [syscall_call+7/11] syscall_call+0x7/0xb
Jul 12 17:55:11 mindpipe kernel:
Jul 12 17:55:11 mindpipe kernel: ALSA /usr/src/alsa-cvs-1.0.5/alsa-driver/alsa-kernel/core/pcm_lib.c:169: XRUN: pcmC0D0p
Jul 12 17:55:11 mindpipe kernel:  [__crc_totalram_pages+1387264/5353478] snd_pcm_period_elapsed+0x2ca/0x410 [snd_pcm]
Jul 12 17:55:11 mindpipe kernel:  [__crc_totalram_pages+1455070/5353478] snd_emu10k1_interrupt+0x3c8/0x480 [snd_emu10k1]
Jul 12 17:55:11 mindpipe kernel:  [handle_IRQ_event+49/96] handle_IRQ_event+0x31/0x60
Jul 12 17:55:11 mindpipe kernel:  [do_IRQ+155/352] do_IRQ+0x9b/0x160
Jul 12 17:55:11 mindpipe kernel:  [common_interrupt+24/32] common_interrupt+0x18/0x20
Jul 12 17:55:11 mindpipe kernel:  [can_dirty+99/192] can_dirty+0x63/0xc0
Jul 12 17:55:11 mindpipe kernel:  [dirty_one_transaction+74/128] dirty_one_transaction+0x4a/0x80
Jul 12 17:55:11 mindpipe kernel:  [flush_commit_list+519/944] flush_commit_list+0x207/0x3b0
Jul 12 17:55:11 mindpipe kernel:  [do_journal_end+2081/2848] do_journal_end+0x821/0xb20
Jul 12 17:55:11 mindpipe kernel:  [journal_end_sync+54/112] journal_end_sync+0x36/0x70
Jul 12 17:55:11 mindpipe kernel:  [__commit_trans_jl+223/240] __commit_trans_jl+0xdf/0xf0
Jul 12 17:55:11 mindpipe kernel:  [reiserfs_commit_for_inode+32/64] reiserfs_commit_for_inode+0x20/0x40
Jul 12 17:55:11 mindpipe kernel:  [reiserfs_sync_file+77/144] reiserfs_sync_file+0x4d/0x90
Jul 12 17:55:11 mindpipe kernel:  [sys_fsync+123/176] sys_fsync+0x7b/0xb0
Jul 12 17:55:11 mindpipe kernel:  [syscall_call+7/11] syscall_call+0x7/0xb
Jul 12 17:55:11 mindpipe kernel:
Jul 12 17:55:11 mindpipe kernel:
Jul 12 17:55:11 mindpipe kernel: ALSA /usr/src/alsa-cvs-1.0.5/alsa-driver/alsa-kernel/core/pcm_lib.c:169: XRUN: pcmC0D0p
Jul 12 17:55:11 mindpipe kernel:  [__crc_totalram_pages+1387264/5353478] snd_pcm_period_elapsed+0x2ca/0x410 [snd_pcm]
Jul 12 17:55:11 mindpipe kernel:  [__crc_totalram_pages+1455070/5353478] snd_emu10k1_interrupt+0x3c8/0x480 [snd_emu10k1]
Jul 12 17:55:11 mindpipe kernel:  [handle_IRQ_event+49/96] handle_IRQ_event+0x31/0x60
Jul 12 17:55:11 mindpipe kernel:  [do_IRQ+155/352] do_IRQ+0x9b/0x160
Jul 12 17:55:11 mindpipe kernel:  [common_interrupt+24/32] common_interrupt+0x18/0x20
Jul 12 17:55:11 mindpipe kernel:  [finish_task_switch+34/112] finish_task_switch+0x22/0x70
Jul 12 17:55:11 mindpipe kernel:  [schedule+731/1424] schedule+0x2db/0x590
Jul 12 17:55:11 mindpipe kernel:  [__mod_timer+206/384] __mod_timer+0xce/0x180
Jul 12 17:55:11 mindpipe kernel:  [schedule_timeout+88/176] schedule_timeout+0x58/0xb0
Jul 12 17:55:11 mindpipe kernel:  [process_timeout+0/16] process_timeout+0x0/0x10
Jul 12 17:55:11 mindpipe kernel:  [do_poll+161/192] do_poll+0xa1/0xc0
Jul 12 17:55:11 mindpipe kernel:  [sys_poll+330/560] sys_poll+0x14a/0x230
Jul 12 17:55:11 mindpipe kernel:  [__pollwait+0/160] __pollwait+0x0/0xa0
Jul 12 17:55:11 mindpipe kernel:  [syscall_call+7/11] syscall_call+0x7/0xb
Jul 12 17:55:11 mindpipe kernel:
Jul 12 17:55:17 mindpipe kernel: ALSA /usr/src/alsa-cvs-1.0.5/alsa-driver/alsa-kernel/core/pcm_lib.c:169: XRUN: pcmC0D0p
Jul 12 17:55:17 mindpipe kernel:  [__crc_totalram_pages+1387264/5353478] snd_pcm_period_elapsed+0x2ca/0x410 [snd_pcm]
Jul 12 17:55:17 mindpipe kernel:  [__crc_totalram_pages+1455070/5353478] snd_emu10k1_interrupt+0x3c8/0x480 [snd_emu10k1]
Jul 12 17:55:17 mindpipe kernel:  [handle_IRQ_event+49/96] handle_IRQ_event+0x31/0x60
Jul 12 17:55:17 mindpipe kernel:  [do_IRQ+155/352] do_IRQ+0x9b/0x160
Jul 12 17:55:17 mindpipe kernel:  [common_interrupt+24/32] common_interrupt+0x18/0x20
Jul 12 17:55:17 mindpipe kernel:  [remove_journal_hash+72/208] remove_journal_hash+0x48/0xd0
Jul 12 17:55:17 mindpipe kernel:  [remove_all_from_journal_list+78/160] remove_all_from_journal_list+0x4e/0xa0
Jul 12 17:55:17 mindpipe kernel:  [flush_journal_list+496/1344] flush_journal_list+0x1f0/0x540
Jul 12 17:55:17 mindpipe kernel:  [flush_older_journal_lists+48/64] flush_older_journal_lists+0x30/0x40
Jul 12 17:55:17 mindpipe kernel:  [flush_journal_list+795/1344] flush_journal_list+0x31b/0x540
Jul 12 17:55:17 mindpipe kernel:  [flush_used_journal_lists+147/160] flush_used_journal_lists+0x93/0xa0
Jul 12 17:55:17 mindpipe kernel:  [flush_old_journal_lists+69/112] flush_old_journal_lists+0x45/0x70
Jul 12 17:55:17 mindpipe kernel:  [do_journal_end+1853/2848] do_journal_end+0x73d/0xb20
Jul 12 17:55:17 mindpipe kernel:  [journal_end_sync+54/112] journal_end_sync+0x36/0x70
Jul 12 17:55:17 mindpipe kernel:  [__commit_trans_jl+223/240] __commit_trans_jl+0xdf/0xf0
Jul 12 17:55:17 mindpipe kernel:  [reiserfs_commit_for_inode+32/64] reiserfs_commit_for_inode+0x20/0x40
Jul 12 17:55:17 mindpipe kernel:  [reiserfs_sync_file+77/144] reiserfs_sync_file+0x4d/0x90
Jul 12 17:55:17 mindpipe kernel:  [sys_fsync+123/176] sys_fsync+0x7b/0xb0
Jul 12 17:55:17 mindpipe kernel:  [syscall_call+7/11] syscall_call+0x7/0xb
Jul 12 17:55:17 mindpipe kernel:
Jul 12 17:55:17 mindpipe kernel: ALSA /usr/src/alsa-cvs-1.0.5/alsa-driver/alsa-kernel/core/pcm_lib.c:169: XRUN: pcmC0D0p
Jul 12 17:55:17 mindpipe kernel:  [__crc_totalram_pages+1387264/5353478] snd_pcm_period_elapsed+0x2ca/0x410 [snd_pcm]
Jul 12 17:55:17 mindpipe kernel:  [__crc_totalram_pages+1455070/5353478] snd_emu10k1_interrupt+0x3c8/0x480 [snd_emu10k1]
Jul 12 17:55:17 mindpipe kernel:  [handle_IRQ_event+49/96] handle_IRQ_event+0x31/0x60
Jul 12 17:55:17 mindpipe kernel:  [do_IRQ+155/352] do_IRQ+0x9b/0x160
Jul 12 17:55:17 mindpipe kernel:  [common_interrupt+24/32] common_interrupt+0x18/0x20
Jul 12 17:55:17 mindpipe kernel:  [remove_journal_hash+67/208] remove_journal_hash+0x43/0xd0
Jul 12 17:55:17 mindpipe kernel:  [remove_all_from_journal_list+78/160] remove_all_from_journal_list+0x4e/0xa0
Jul 12 17:55:17 mindpipe kernel:  [flush_journal_list+496/1344] flush_journal_list+0x1f0/0x540
Jul 12 17:55:17 mindpipe kernel:  [flush_older_journal_lists+48/64] flush_older_journal_lists+0x30/0x40
Jul 12 17:55:17 mindpipe kernel:  [flush_journal_list+795/1344] flush_journal_list+0x31b/0x540
Jul 12 17:55:17 mindpipe kernel:  [flush_used_journal_lists+147/160] flush_used_journal_lists+0x93/0xa0
Jul 12 17:55:17 mindpipe kernel:  [flush_old_journal_lists+69/112] flush_old_journal_lists+0x45/0x70
Jul 12 17:55:17 mindpipe kernel:  [do_journal_end+1853/2848] do_journal_end+0x73d/0xb20
Jul 12 17:55:17 mindpipe kernel:  [journal_end_sync+54/112] journal_end_sync+0x36/0x70
Jul 12 17:55:17 mindpipe kernel:  [__commit_trans_jl+223/240] __commit_trans_jl+0xdf/0xf0
Jul 12 17:55:17 mindpipe kernel:  [reiserfs_commit_for_inode+32/64] reiserfs_commit_for_inode+0x20/0x40
Jul 12 17:55:17 mindpipe kernel:  [reiserfs_sync_file+77/144] reiserfs_sync_file+0x4d/0x90
Jul 12 17:55:17 mindpipe kernel:  [sys_fsync+123/176] sys_fsync+0x7b/0xb0
Jul 12 17:55:17 mindpipe kernel:  [syscall_call+7/11] syscall_call+0x7/0xb
Jul 12 17:55:17 mindpipe kernel:

A few minutes later:

Jul 12 17:56:54 mindpipe kernel: ALSA /usr/src/alsa-cvs-1.0.5/alsa-driver/alsa-kernel/core/pcm_lib.c:169: XRUN: pcmC0D0p
Jul 12 17:56:54 mindpipe kernel:  [__crc_totalram_pages+1387264/5353478] snd_pcm_period_elapsed+0x2ca/0x410 [snd_pcm]
Jul 12 17:56:54 mindpipe kernel:  [i8042_timer_func+0/16] i8042_timer_func+0x0/0x10
Jul 12 17:56:54 mindpipe kernel:  [__crc_totalram_pages+1455070/5353478] snd_emu10k1_interrupt+0x3c8/0x480 [snd_emu10k1]
Jul 12 17:56:54 mindpipe kernel:  [handle_IRQ_event+49/96] handle_IRQ_event+0x31/0x60
Jul 12 17:56:54 mindpipe kernel:  [do_IRQ+155/352] do_IRQ+0x9b/0x160
Jul 12 17:56:54 mindpipe kernel:  [common_interrupt+24/32] common_interrupt+0x18/0x20
Jul 12 17:56:54 mindpipe kernel:  [can_dirty+144/192] can_dirty+0x90/0xc0
Jul 12 17:56:54 mindpipe kernel:  [dirty_one_transaction+74/128] dirty_one_transaction+0x4a/0x80
Jul 12 17:56:54 mindpipe kernel:  [flush_commit_list+519/944] flush_commit_list+0x207/0x3b0
Jul 12 17:56:54 mindpipe kernel:  [do_journal_end+2081/2848] do_journal_end+0x821/0xb20
Jul 12 17:56:54 mindpipe kernel:  [journal_end_sync+54/112] journal_end_sync+0x36/0x70
Jul 12 17:56:54 mindpipe kernel:  [reiserfs_sync_fs+61/128] reiserfs_sync_fs+0x3d/0x80
Jul 12 17:56:54 mindpipe kernel:  [sync_supers+174/192] sync_supers+0xae/0xc0
Jul 12 17:56:54 mindpipe kernel:  [wb_kupdate+47/256] wb_kupdate+0x2f/0x100
Jul 12 17:56:54 mindpipe kernel:  [deactivate_task+29/64] deactivate_task+0x1d/0x40
Jul 12 17:56:54 mindpipe kernel:  [__pdflush+200/496] __pdflush+0xc8/0x1f0
Jul 12 17:56:54 mindpipe kernel:  [pdflush+0/48] pdflush+0x0/0x30
Jul 12 17:56:54 mindpipe kernel:  [pdflush+30/48] pdflush+0x1e/0x30
Jul 12 17:56:54 mindpipe kernel:  [wb_kupdate+0/256] wb_kupdate+0x0/0x100
Jul 12 17:56:54 mindpipe kernel:  [kthread+163/176] kthread+0xa3/0xb0
Jul 12 17:56:54 mindpipe kernel:  [kthread+0/176] kthread+0x0/0xb0
Jul 12 17:56:54 mindpipe kernel:  [kernel_thread_helper+5/16] kernel_thread_helper+0x5/0x10
Jul 12 17:56:54 mindpipe kernel:

Another one:

Jul 12 17:57:22 mindpipe kernel: ALSA /usr/src/alsa-cvs-1.0.5/alsa-driver/alsa-kernel/core/pcm_lib.c:169: XRUN: pcmC0D0p
Jul 12 17:57:22 mindpipe kernel:  [__crc_totalram_pages+1387264/5353478] snd_pcm_period_elapsed+0x2ca/0x410 [snd_pcm]
Jul 12 17:57:22 mindpipe kernel:  [__crc_totalram_pages+1455070/5353478] snd_emu10k1_interrupt+0x3c8/0x480 [snd_emu10k1]
Jul 12 17:57:22 mindpipe kernel:  [handle_IRQ_event+49/96] handle_IRQ_event+0x31/0x60
Jul 12 17:57:22 mindpipe kernel:  [do_IRQ+155/352] do_IRQ+0x9b/0x160
Jul 12 17:57:22 mindpipe kernel:  [common_interrupt+24/32] common_interrupt+0x18/0x20
Jul 12 17:57:22 mindpipe kernel:  [remove_journal_hash+67/208] remove_journal_hash+0x43/0xd0
Jul 12 17:57:22 mindpipe kernel:  [remove_all_from_journal_list+78/160] remove_all_from_journal_list+0x4e/0xa0
Jul 12 17:57:22 mindpipe kernel:  [flush_journal_list+496/1344] flush_journal_list+0x1f0/0x540
Jul 12 17:57:22 mindpipe kernel:  [flush_older_journal_lists+48/64] flush_older_journal_lists+0x30/0x40
Jul 12 17:57:22 mindpipe kernel:  [flush_journal_list+795/1344] flush_journal_list+0x31b/0x540
Jul 12 17:57:22 mindpipe kernel:  [flush_used_journal_lists+147/160] flush_used_journal_lists+0x93/0xa0
Jul 12 17:57:22 mindpipe kernel:  [flush_old_journal_lists+69/112] flush_old_journal_lists+0x45/0x70
Jul 12 17:57:22 mindpipe kernel:  [do_journal_end+1853/2848] do_journal_end+0x73d/0xb20
Jul 12 17:57:22 mindpipe kernel:  [journal_end_sync+54/112] journal_end_sync+0x36/0x70
Jul 12 17:57:22 mindpipe kernel:  [__commit_trans_jl+223/240] __commit_trans_jl+0xdf/0xf0
Jul 12 17:57:22 mindpipe kernel:  [reiserfs_commit_for_inode+32/64] reiserfs_commit_for_inode+0x20/0x40
Jul 12 17:57:22 mindpipe kernel:  [reiserfs_sync_file+77/144] reiserfs_sync_file+0x4d/0x90
Jul 12 17:57:22 mindpipe kernel:  [sys_fsync+123/176] sys_fsync+0x7b/0xb0
Jul 12 17:57:22 mindpipe kernel:  [syscall_call+7/11] syscall_call+0x7/0xb
Jul 12 17:57:22 mindpipe kernel:
Jul 12 17:57:22 mindpipe kernel: ALSA /usr/src/alsa-cvs-1.0.5/alsa-driver/alsa-kernel/core/pcm_lib.c:169: XRUN: pcmC0D0p
Jul 12 17:57:22 mindpipe kernel:  [__crc_totalram_pages+1387264/5353478] snd_pcm_period_elapsed+0x2ca/0x410 [snd_pcm]
Jul 12 17:57:22 mindpipe kernel:  [__crc_totalram_pages+1455070/5353478] snd_emu10k1_interrupt+0x3c8/0x480 [snd_emu10k1]
Jul 12 17:57:22 mindpipe kernel:  [handle_IRQ_event+49/96] handle_IRQ_event+0x31/0x60
Jul 12 17:57:22 mindpipe kernel:  [do_IRQ+155/352] do_IRQ+0x9b/0x160
Jul 12 17:57:22 mindpipe kernel:  [common_interrupt+24/32] common_interrupt+0x18/0x20
Jul 12 17:57:22 mindpipe kernel:  [remove_journal_hash+72/208] remove_journal_hash+0x48/0xd0
Jul 12 17:57:22 mindpipe kernel:  [remove_all_from_journal_list+78/160] remove_all_from_journal_list+0x4e/0xa0
Jul 12 17:57:22 mindpipe kernel:  [flush_journal_list+496/1344] flush_journal_list+0x1f0/0x540
Jul 12 17:57:22 mindpipe kernel:  [flush_older_journal_lists+48/64] flush_older_journal_lists+0x30/0x40
Jul 12 17:57:22 mindpipe kernel:  [flush_journal_list+795/1344] flush_journal_list+0x31b/0x540
Jul 12 17:57:22 mindpipe kernel:  [flush_used_journal_lists+147/160] flush_used_journal_lists+0x93/0xa0
Jul 12 17:57:22 mindpipe kernel:  [flush_old_journal_lists+69/112] flush_old_journal_lists+0x45/0x70
Jul 12 17:57:22 mindpipe kernel:  [do_journal_end+1853/2848] do_journal_end+0x73d/0xb20
Jul 12 17:57:22 mindpipe kernel:  [journal_end_sync+54/112] journal_end_sync+0x36/0x70
Jul 12 17:57:22 mindpipe kernel:  [__commit_trans_jl+223/240] __commit_trans_jl+0xdf/0xf0
Jul 12 17:57:22 mindpipe kernel:  [reiserfs_commit_for_inode+32/64] reiserfs_commit_for_inode+0x20/0x40
Jul 12 17:57:22 mindpipe kernel:  [reiserfs_sync_file+77/144] reiserfs_sync_file+0x4d/0x90
Jul 12 17:57:22 mindpipe kernel:  [sys_fsync+123/176] sys_fsync+0x7b/0xb0
Jul 12 17:57:22 mindpipe kernel:  [syscall_call+7/11] syscall_call+0x7/0xb
Jul 12 17:57:22 mindpipe kernel:
Jul 12 17:57:22 mindpipe kernel:
Jul 12 17:57:22 mindpipe kernel: ALSA /usr/src/alsa-cvs-1.0.5/alsa-driver/alsa-kernel/core/pcm_lib.c:169: XRUN: pcmC0D0p
Jul 12 17:57:22 mindpipe kernel:  [__crc_totalram_pages+1387264/5353478] snd_pcm_period_elapsed+0x2ca/0x410 [snd_pcm]
Jul 12 17:57:22 mindpipe kernel:  [__crc_totalram_pages+1455070/5353478] snd_emu10k1_interrupt+0x3c8/0x480 [snd_emu10k1]
Jul 12 17:57:22 mindpipe kernel:  [handle_IRQ_event+49/96] handle_IRQ_event+0x31/0x60
Jul 12 17:57:22 mindpipe kernel:  [do_IRQ+155/352] do_IRQ+0x9b/0x160
Jul 12 17:57:22 mindpipe kernel:  [common_interrupt+24/32] common_interrupt+0x18/0x20
Jul 12 17:57:22 mindpipe kernel:  [remove_journal_hash+99/208] remove_journal_hash+0x63/0xd0
Jul 12 17:57:22 mindpipe kernel:  [remove_all_from_journal_list+78/160] remove_all_from_journal_list+0x4e/0xa0
Jul 12 17:57:22 mindpipe kernel:  [flush_journal_list+496/1344] flush_journal_list+0x1f0/0x540
Jul 12 17:57:22 mindpipe kernel:  [flush_older_journal_lists+48/64] flush_older_journal_lists+0x30/0x40
Jul 12 17:57:22 mindpipe kernel:  [flush_journal_list+795/1344] flush_journal_list+0x31b/0x540
Jul 12 17:57:22 mindpipe kernel:  [flush_used_journal_lists+147/160] flush_used_journal_lists+0x93/0xa0
Jul 12 17:57:22 mindpipe kernel:  [flush_old_journal_lists+69/112] flush_old_journal_lists+0x45/0x70
Jul 12 17:57:22 mindpipe kernel:  [do_journal_end+1853/2848] do_journal_end+0x73d/0xb20
Jul 12 17:57:22 mindpipe kernel:  [journal_end_sync+54/112] journal_end_sync+0x36/0x70
Jul 12 17:57:22 mindpipe kernel:  [__commit_trans_jl+223/240] __commit_trans_jl+0xdf/0xf0
Jul 12 17:57:22 mindpipe kernel:  [reiserfs_commit_for_inode+32/64] reiserfs_commit_for_inode+0x20/0x40
Jul 12 17:57:22 mindpipe kernel:  [reiserfs_sync_file+77/144] reiserfs_sync_file+0x4d/0x90
Jul 12 17:57:22 mindpipe kernel:  [sys_fsync+123/176] sys_fsync+0x7b/0xb0
Jul 12 17:57:22 mindpipe kernel:  [syscall_call+7/11] syscall_call+0x7/0xb
Jul 12 17:57:22 mindpipe kernel:
Jul 12 17:57:22 mindpipe kernel: ALSA /usr/src/alsa-cvs-1.0.5/alsa-driver/alsa-kernel/core/pcm_lib.c:169: XRUN: pcmC0D0p
Jul 12 17:57:22 mindpipe kernel:  [__crc_totalram_pages+1387264/5353478] snd_pcm_period_elapsed+0x2ca/0x410 [snd_pcm]
Jul 12 17:57:22 mindpipe kernel:  [__crc_totalram_pages+1455070/5353478] snd_emu10k1_interrupt+0x3c8/0x480 [snd_emu10k1]
Jul 12 17:57:22 mindpipe kernel:  [handle_IRQ_event+49/96] handle_IRQ_event+0x31/0x60
Jul 12 17:57:22 mindpipe kernel:  [do_IRQ+155/352] do_IRQ+0x9b/0x160
Jul 12 17:57:22 mindpipe kernel:  [common_interrupt+24/32] common_interrupt+0x18/0x20
Jul 12 17:57:22 mindpipe kernel:  [remove_journal_hash+72/208] remove_journal_hash+0x48/0xd0
Jul 12 17:57:22 mindpipe kernel:  [remove_all_from_journal_list+78/160] remove_all_from_journal_list+0x4e/0xa0
Jul 12 17:57:22 mindpipe kernel:  [flush_journal_list+496/1344] flush_journal_list+0x1f0/0x540
Jul 12 17:57:22 mindpipe kernel:  [flush_older_journal_lists+48/64] flush_older_journal_lists+0x30/0x40
Jul 12 17:57:22 mindpipe kernel:  [flush_journal_list+795/1344] flush_journal_list+0x31b/0x540
Jul 12 17:57:22 mindpipe kernel:  [flush_used_journal_lists+147/160] flush_used_journal_lists+0x93/0xa0
Jul 12 17:57:22 mindpipe kernel:  [flush_old_journal_lists+69/112] flush_old_journal_lists+0x45/0x70
Jul 12 17:57:22 mindpipe kernel:  [do_journal_end+1853/2848] do_journal_end+0x73d/0xb20
Jul 12 17:57:22 mindpipe kernel:  [journal_end_sync+54/112] journal_end_sync+0x36/0x70
Jul 12 17:57:22 mindpipe kernel:  [__commit_trans_jl+223/240] __commit_trans_jl+0xdf/0xf0
Jul 12 17:57:22 mindpipe kernel:  [reiserfs_commit_for_inode+32/64] reiserfs_commit_for_inode+0x20/0x40
Jul 12 17:57:22 mindpipe kernel:  [reiserfs_sync_file+77/144] reiserfs_sync_file+0x4d/0x90
Jul 12 17:57:22 mindpipe kernel:  [sys_fsync+123/176] sys_fsync+0x7b/0xb0
Jul 12 17:57:22 mindpipe kernel:  [syscall_call+7/11] syscall_call+0x7/0xb
Jul 12 17:57:22 mindpipe kernel:
Jul 12 17:57:22 mindpipe kernel: ALSA /usr/src/alsa-cvs-1.0.5/alsa-driver/alsa-kernel/core/pcm_lib.c:169: XRUN: pcmC0D0p
Jul 12 17:57:22 mindpipe kernel:  [__crc_totalram_pages+1387264/5353478] snd_pcm_period_elapsed+0x2ca/0x410 [snd_pcm]
Jul 12 17:57:22 mindpipe kernel:  [__crc_totalram_pages+1455070/5353478] snd_emu10k1_interrupt+0x3c8/0x480 [snd_emu10k1]
Jul 12 17:57:22 mindpipe kernel:  [handle_IRQ_event+49/96] handle_IRQ_event+0x31/0x60
Jul 12 17:57:22 mindpipe kernel:  [do_IRQ+155/352] do_IRQ+0x9b/0x160
Jul 12 17:57:22 mindpipe kernel:  [common_interrupt+24/32] common_interrupt+0x18/0x20
Jul 12 17:57:22 mindpipe kernel:  [remove_journal_hash+72/208] remove_journal_hash+0x48/0xd0
Jul 12 17:57:22 mindpipe kernel:  [remove_all_from_journal_list+78/160] remove_all_from_journal_list+0x4e/0xa0
Jul 12 17:57:22 mindpipe kernel:  [flush_journal_list+496/1344] flush_journal_list+0x1f0/0x540
Jul 12 17:57:22 mindpipe kernel:  [flush_older_journal_lists+48/64] flush_older_journal_lists+0x30/0x40
Jul 12 17:57:22 mindpipe kernel:  [flush_journal_list+795/1344] flush_journal_list+0x31b/0x540
Jul 12 17:57:22 mindpipe kernel:  [flush_used_journal_lists+147/160] flush_used_journal_lists+0x93/0xa0
Jul 12 17:57:22 mindpipe kernel:  [flush_old_journal_lists+69/112] flush_old_journal_lists+0x45/0x70
Jul 12 17:57:22 mindpipe kernel:  [do_journal_end+1853/2848] do_journal_end+0x73d/0xb20
Jul 12 17:57:22 mindpipe kernel:  [journal_end_sync+54/112] journal_end_sync+0x36/0x70
Jul 12 17:57:22 mindpipe kernel:  [__commit_trans_jl+223/240] __commit_trans_jl+0xdf/0xf0
Jul 12 17:57:22 mindpipe kernel:  [reiserfs_commit_for_inode+32/64] reiserfs_commit_for_inode+0x20/0x40
Jul 12 17:57:22 mindpipe kernel:  [reiserfs_sync_file+77/144] reiserfs_sync_file+0x4d/0x90
Jul 12 17:57:22 mindpipe kernel:  [sys_fsync+123/176] sys_fsync+0x7b/0xb0
Jul 12 17:57:22 mindpipe kernel:  [syscall_call+7/11] syscall_call+0x7/0xb
Jul 12 17:57:22 mindpipe kernel:
Jul 12 17:57:22 mindpipe kernel: ALSA /usr/src/alsa-cvs-1.0.5/alsa-driver/alsa-kernel/core/pcm_lib.c:169: XRUN: pcmC0D0p
Jul 12 17:57:22 mindpipe kernel:  [__crc_totalram_pages+1387264/5353478] snd_pcm_period_elapsed+0x2ca/0x410 [snd_pcm]
Jul 12 17:57:22 mindpipe kernel:  [__crc_totalram_pages+1455070/5353478] snd_emu10k1_interrupt+0x3c8/0x480 [snd_emu10k1]
Jul 12 17:57:22 mindpipe kernel:  [handle_IRQ_event+49/96] handle_IRQ_event+0x31/0x60
Jul 12 17:57:22 mindpipe kernel:  [do_IRQ+155/352] do_IRQ+0x9b/0x160
Jul 12 17:57:22 mindpipe kernel:  [common_interrupt+24/32] common_interrupt+0x18/0x20
Jul 12 17:57:22 mindpipe kernel:  [remove_journal_hash+67/208] remove_journal_hash+0x43/0xd0
Jul 12 17:57:22 mindpipe kernel:  [remove_all_from_journal_list+78/160] remove_all_from_journal_list+0x4e/0xa0
Jul 12 17:57:22 mindpipe kernel:  [flush_journal_list+496/1344] flush_journal_list+0x1f0/0x540
Jul 12 17:57:22 mindpipe kernel:  [flush_older_journal_lists+48/64] flush_older_journal_lists+0x30/0x40
Jul 12 17:57:22 mindpipe kernel:  [flush_journal_list+795/1344] flush_journal_list+0x31b/0x540
Jul 12 17:57:22 mindpipe kernel:  [flush_used_journal_lists+147/160] flush_used_journal_lists+0x93/0xa0
Jul 12 17:57:22 mindpipe kernel:  [flush_old_journal_lists+69/112] flush_old_journal_lists+0x45/0x70
Jul 12 17:57:22 mindpipe kernel:  [do_journal_end+1853/2848] do_journal_end+0x73d/0xb20
Jul 12 17:57:22 mindpipe kernel:  [journal_end_sync+54/112] journal_end_sync+0x36/0x70
Jul 12 17:57:22 mindpipe kernel:  [__commit_trans_jl+223/240] __commit_trans_jl+0xdf/0xf0
Jul 12 17:57:22 mindpipe kernel:  [reiserfs_commit_for_inode+32/64] reiserfs_commit_for_inode+0x20/0x40
Jul 12 17:57:22 mindpipe kernel:  [reiserfs_sync_file+77/144] reiserfs_sync_file+0x4d/0x90
Jul 12 17:57:22 mindpipe kernel:  [sys_fsync+123/176] sys_fsync+0x7b/0xb0
Jul 12 17:57:22 mindpipe kernel:  [syscall_call+7/11] syscall_call+0x7/0xb
Jul 12 17:57:22 mindpipe kernel:
Jul 12 17:57:22 mindpipe kernel: ALSA /usr/src/alsa-cvs-1.0.5/alsa-driver/alsa-kernel/core/pcm_lib.c:169: XRUN: pcmC0D0p
Jul 12 17:57:22 mindpipe kernel:  [__crc_totalram_pages+1387264/5353478] snd_pcm_period_elapsed+0x2ca/0x410 [snd_pcm]
Jul 12 17:57:22 mindpipe kernel:  [__crc_totalram_pages+1455070/5353478] snd_emu10k1_interrupt+0x3c8/0x480 [snd_emu10k1]
Jul 12 17:57:22 mindpipe kernel:  [handle_IRQ_event+49/96] handle_IRQ_event+0x31/0x60
Jul 12 17:57:22 mindpipe kernel:  [do_IRQ+155/352] do_IRQ+0x9b/0x160
Jul 12 17:57:22 mindpipe kernel:  [common_interrupt+24/32] common_interrupt+0x18/0x20
Jul 12 17:57:22 mindpipe kernel:  [remove_journal_hash+108/208] remove_journal_hash+0x6c/0xd0
Jul 12 17:57:22 mindpipe kernel:  [remove_all_from_journal_list+78/160] remove_all_from_journal_list+0x4e/0xa0
Jul 12 17:57:22 mindpipe kernel:  [flush_journal_list+496/1344] flush_journal_list+0x1f0/0x540
Jul 12 17:57:22 mindpipe kernel:  [flush_older_journal_lists+48/64] flush_older_journal_lists+0x30/0x40
Jul 12 17:57:22 mindpipe kernel:  [flush_journal_list+795/1344] flush_journal_list+0x31b/0x540
Jul 12 17:57:22 mindpipe kernel:  [flush_used_journal_lists+147/160] flush_used_journal_lists+0x93/0xa0
Jul 12 17:57:22 mindpipe kernel:  [flush_old_journal_lists+69/112] flush_old_journal_lists+0x45/0x70
Jul 12 17:57:22 mindpipe kernel:  [do_journal_end+1853/2848] do_journal_end+0x73d/0xb20
Jul 12 17:57:22 mindpipe kernel:  [journal_end_sync+54/112] journal_end_sync+0x36/0x70
Jul 12 17:57:22 mindpipe kernel:  [__commit_trans_jl+223/240] __commit_trans_jl+0xdf/0xf0
Jul 12 17:57:22 mindpipe kernel:  [reiserfs_commit_for_inode+32/64] reiserfs_commit_for_inode+0x20/0x40
Jul 12 17:57:22 mindpipe kernel:  [reiserfs_sync_file+77/144] reiserfs_sync_file+0x4d/0x90
Jul 12 17:57:22 mindpipe kernel:  [sys_fsync+123/176] sys_fsync+0x7b/0xb0
Jul 12 17:57:22 mindpipe kernel:  [syscall_call+7/11] syscall_call+0x7/0xb Jul 12 17:57:22 mindpipe kernel:
Jul 12 17:57:22 mindpipe kernel: ALSA /usr/src/alsa-cvs-1.0.5/alsa-driver/alsa-kernel/core/pcm_lib.c:169: XRUN: pcmC0D0p
Jul 12 17:57:22 mindpipe kernel:  [__crc_totalram_pages+1387264/5353478] snd_pcm_period_elapsed+0x2ca/0x410 [snd_pcm]
Jul 12 17:57:22 mindpipe kernel:  [__crc_totalram_pages+1455070/5353478] snd_emu10k1_interrupt+0x3c8/0x480 [snd_emu10k1]
Jul 12 17:57:22 mindpipe kernel:  [handle_IRQ_event+49/96] handle_IRQ_event+0x31/0x60
Jul 12 17:57:22 mindpipe kernel:  [do_IRQ+155/352] do_IRQ+0x9b/0x160
Jul 12 17:57:22 mindpipe kernel:  [common_interrupt+24/32] common_interrupt+0x18/0x20
Jul 12 17:57:22 mindpipe kernel:  [remove_journal_hash+72/208] remove_journal_hash+0x48/0xd0
Jul 12 17:57:22 mindpipe kernel:  [remove_all_from_journal_list+78/160] remove_all_from_journal_list+0x4e/0xa0
Jul 12 17:57:22 mindpipe kernel:  [flush_journal_list+496/1344] flush_journal_list+0x1f0/0x540
Jul 12 17:57:22 mindpipe kernel:  [flush_older_journal_lists+48/64] flush_older_journal_lists+0x30/0x40
Jul 12 17:57:22 mindpipe kernel:  [flush_journal_list+795/1344] flush_journal_list+0x31b/0x540 Jul 12 17:57:22 mindpipe kernel:  [flush_used_journal_lists+147/160] flush_used_journal_lists+0x93/0xa0
Jul 12 17:57:22 mindpipe kernel:  [flush_old_journal_lists+69/112] flush_old_journal_lists+0x45/0x70
Jul 12 17:57:22 mindpipe kernel:  [do_journal_end+1853/2848] do_journal_end+0x73d/0xb20
Jul 12 17:57:22 mindpipe kernel:  [journal_end_sync+54/112] journal_end_sync+0x36/0x70
Jul 12 17:57:22 mindpipe kernel:  [__commit_trans_jl+223/240] __commit_trans_jl+0xdf/0xf0
Jul 12 17:57:22 mindpipe kernel:  [reiserfs_commit_for_inode+32/64] reiserfs_commit_for_inode+0x20/0x40
Jul 12 17:57:22 mindpipe kernel:  [reiserfs_sync_file+77/144] reiserfs_sync_file+0x4d/0x90
Jul 12 17:57:22 mindpipe kernel:  [sys_fsync+123/176] sys_fsync+0x7b/0xb0
Jul 12 17:57:22 mindpipe kernel:  [syscall_call+7/11] syscall_call+0x7/0xb
Jul 12 17:57:22 mindpipe kernel:
Jul 12 17:57:22 mindpipe kernel: ALSA /usr/src/alsa-cvs-1.0.5/alsa-driver/alsa-kernel/core/pcm_lib.c:169: XRUN: pcmC0D0p
Jul 12 17:57:22 mindpipe kernel:  [__crc_totalram_pages+1387264/5353478] snd_pcm_period_elapsed+0x2ca/0x410 [snd_pcm]
Jul 12 17:57:22 mindpipe kernel:  [__crc_totalram_pages+1455070/5353478] snd_emu10k1_interrupt+0x3c8/0x480 [snd_emu10k1] Jul 12 17:57:22 mindpipe kernel:  [handle_IRQ_event+49/96] handle_IRQ_event+0x31/0x60
Jul 12 17:57:22 mindpipe kernel:  [do_IRQ+155/352] do_IRQ+0x9b/0x160
Jul 12 17:57:22 mindpipe kernel:  [common_interrupt+24/32] common_interrupt+0x18/0x20
Jul 12 17:57:22 mindpipe kernel:  [generic_unplug_device+32/96] generic_unplug_device+0x20/0x60
Jul 12 17:57:22 mindpipe kernel:  [blk_backing_dev_unplug+35/48] blk_backing_dev_unplug+0x23/0x30
Jul 12 17:57:22 mindpipe kernel:  [sync_buffer+53/64] sync_buffer+0x35/0x40
Jul 12 17:57:22 mindpipe kernel:  [__wait_on_buffer+150/160] __wait_on_buffer+0x96/0xa0
Jul 12 17:57:22 mindpipe kernel:  [bh_wake_function+0/64] bh_wake_function+0x0/0x40
Jul 12 17:57:22 mindpipe kernel:  [bh_wake_function+0/64] bh_wake_function+0x0/0x40
Jul 12 17:57:22 mindpipe kernel:  [_update_journal_header_block+177/240] _update_journal_header_block+0xb1/0xf0
Jul 12 17:57:22 mindpipe kernel:  [update_journal_header_block+21/48] update_journal_header_block+0x15/0x30
Jul 12 17:57:22 mindpipe kernel:  [flush_journal_list+835/1344] flush_journal_list+0x343/0x540 Jul 12 17:57:22 mindpipe kernel:  [flush_used_journal_lists+147/160] flush_used_journal_lists+0x93/0xa0
Jul 12 17:57:22 mindpipe kernel:  [flush_old_journal_lists+69/112] flush_old_journal_lists+0x45/0x70
Jul 12 17:57:22 mindpipe kernel:  [do_journal_end+1853/2848] do_journal_end+0x73d/0xb20
Jul 12 17:57:22 mindpipe kernel:  [journal_end_sync+54/112] journal_end_sync+0x36/0x70
Jul 12 17:57:22 mindpipe kernel:  [__commit_trans_jl+223/240] __commit_trans_jl+0xdf/0xf0
Jul 12 17:57:22 mindpipe kernel:  [reiserfs_commit_for_inode+32/64] reiserfs_commit_for_inode+0x20/0x40
Jul 12 17:57:22 mindpipe kernel:  [reiserfs_sync_file+77/144] reiserfs_sync_file+0x4d/0x90
Jul 12 17:57:22 mindpipe kernel:  [sys_fsync+123/176] sys_fsync+0x7b/0xb0
Jul 12 17:57:22 mindpipe kernel:  [syscall_call+7/11] syscall_call+0x7/0xb

Hopefully this is not too much information.  You did ask for details...

Lee Revell
Mindpipe Audio

