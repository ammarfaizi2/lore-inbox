Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266305AbUGTVb4@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266305AbUGTVb4 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 20 Jul 2004 17:31:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266310AbUGTVb4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 20 Jul 2004 17:31:56 -0400
Received: from viper.oldcity.dca.net ([216.158.38.4]:43411 "HELO
	viper.oldcity.dca.net") by vger.kernel.org with SMTP
	id S266305AbUGTVbw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 20 Jul 2004 17:31:52 -0400
Subject: Re: [linux-audio-dev] Re: [announce] [patch] Voluntary Kernel
	Preemption Patch
From: Lee Revell <rlrevell@joe-job.com>
To: Jens Axboe <axboe@suse.de>
Cc: Ingo Molnar <mingo@elte.hu>, Andrew Morton <akpm@osdl.org>,
       linux-audio-dev@music.columbia.edu, arjanv@redhat.com,
       linux-kernel <linux-kernel@vger.kernel.org>
In-Reply-To: <20040720121905.GG1651@suse.de>
References: <1089673014.10777.42.camel@mindpipe>
	 <20040712163141.31ef1ad6.akpm@osdl.org>
	 <1089677823.10777.64.camel@mindpipe>
	 <20040712174639.38c7cf48.akpm@osdl.org>
	 <1089687168.10777.126.camel@mindpipe>
	 <20040712205917.47d1d58b.akpm@osdl.org>
	 <1089705440.20381.14.camel@mindpipe> <20040719104837.GA9459@elte.hu>
	 <1090301906.22521.16.camel@mindpipe> <20040720061227.GC27118@elte.hu>
	 <20040720121905.GG1651@suse.de>
Content-Type: text/plain
Message-Id: <1090359127.28175.64.camel@mindpipe>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 
Date: Tue, 20 Jul 2004 17:32:08 -0400
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2004-07-20 at 08:19, Jens Axboe wrote:
> On Tue, Jul 20 2004, Ingo Molnar wrote:
> > > How much I/O do you allow to be in flight at once?  It seems like by
> > > decreasing the maximum size of I/O that you handle in one interrupt
> > > you could improve this quite a bit.  Disk throughput is good enough,
> > > anyone in the real world who would feel a 10% hit would just throw
> > > hardware at the problem.
> > 
> > i'm not sure whether this particular value (max # of sg-entries per IO
> > op) is runtime tunable. Jens? Might make sense to enable elvtune-alike
> > tunability of this value.
> 
> elvtune is long dead :-)
> 
> it's not tweakable right now, but if you wish to experiment you just
> need to add a line to ide-disk.c:idedisk_setup() - pseudo patch:
> 
> +	blk_queue_max_sectors(drive->queue, 32);
> +
> 	printk("%s: max request size: %dKiB\n", drive->name, drive->queue->max_sectors / 2);
> 
> 	/* Extract geometry if we did not already have one for the drive */
> 
> above will limit max request to 16kb, experiment as you see fit.

I will give this a try.

Using 2.6.8-rc1-mm1, with La Monte H. P. Yarroll's patch to daemonize
softirqs, running two jackds (one in the playback direction, one in
capture, to work around an issue with the emu10k1 driver) with 2 periods
of 32 frames (666 usec), I am no longer seeing any XRUNS at all once the
jackd processes are up and running.  I tried stressing the filesystem by
recompiling ALSA while running a 'du /' and a 'find / -ls'.  The
scheduling jitter peaks occasionally at around 100000 CPU cycles (166
usecs) every few seconds, but this is as high as it goes.

This is as good or better than a 2.4 kernel with the low latency
patches.

I do not have voluntary preemption enabled, as I do not have a version
of the patch that corresponds to this kernel.

The only XRUNS I still get seem related to ioctl() and mlockall().  
These both cause an XRUN in one jackd process when starting another:

Jul 20 16:25:46 mindpipe kernel: ALSA /home/rlrevell/cvs/alsa-driver/alsa-kernel/core/pcm_lib.c:169: XRUN: pcmC0D0p
Jul 20 16:25:46 mindpipe kernel:  [dump_stack+23/32] dump_stack+0x17/0x20
Jul 20 16:25:46 mindpipe kernel:  [__crc_totalram_pages+115469/3518512] snd_pcm_period_elapsed+0x2c7/0x400 [snd_pcm]
Jul 20 16:25:46 mindpipe kernel:  [__crc_totalram_pages+291773/3518512] snd_emu10k1_interrupt+0x337/0x3c0 [snd_emu10k1]
Jul 20 16:25:46 mindpipe kernel:  [handle_IRQ_event+51/96] handle_IRQ_event+0x33/0x60
Jul 20 16:25:46 mindpipe kernel:  [do_IRQ+161/320] do_IRQ+0xa1/0x140
Jul 20 16:25:46 mindpipe kernel:  [common_interrupt+24/32] common_interrupt+0x18/0x20
Jul 20 16:25:46 mindpipe kernel:  [do_anonymous_page+124/384] do_anonymous_page+0x7c/0x180
Jul 20 16:25:46 mindpipe kernel:  [do_no_page+78/784] do_no_page+0x4e/0x310
Jul 20 16:25:46 mindpipe kernel:  [handle_mm_fault+193/368] handle_mm_fault+0xc1/0x170
Jul 20 16:25:46 mindpipe kernel:  [get_user_pages+337/960] get_user_pages+0x151/0x3c0
Jul 20 16:25:46 mindpipe kernel:  [make_pages_present+104/144] make_pages_present+0x68/0x90
Jul 20 16:25:46 mindpipe kernel:  [mlock_fixup+141/176] mlock_fixup+0x8d/0xb0
Jul 20 16:25:46 mindpipe kernel:  [do_mlockall+112/144] do_mlockall+0x70/0x90
Jul 20 16:25:46 mindpipe kernel:  [sys_mlockall+150/160] sys_mlockall+0x96/0xa0
Jul 20 16:25:46 mindpipe kernel:  [syscall_call+7/11] syscall_call+0x7/0xb
Jul 20 16:25:46 mindpipe kernel: IRQ: delay =  9213566 cycles, jitter = 8820554

Jul 20 16:54:02 mindpipe kernel: ALSA /home/rlrevell/cvs/alsa-driver/alsa-kernel/core/pcm_lib.c:169: XRUN: pcmC0D2c
Jul 20 16:54:02 mindpipe kernel:  [dump_stack+23/32] dump_stack+0x17/0x20
Jul 20 16:54:02 mindpipe kernel:  [__crc_totalram_pages+115469/3518512] snd_pcm_period_elapsed+0x2c7/0x400 [snd_pcm]
Jul 20 16:54:02 mindpipe kernel:  [__crc_totalram_pages+291159/3518512] snd_emu10k1_interrupt+0xd1/0x3c0 [snd_emu10k1]
Jul 20 16:54:02 mindpipe kernel:  [handle_IRQ_event+51/96] handle_IRQ_event+0x33/0x60
Jul 20 16:54:02 mindpipe kernel:  [do_IRQ+161/320] do_IRQ+0xa1/0x140
Jul 20 16:54:02 mindpipe kernel:  [common_interrupt+24/32] common_interrupt+0x18/0x20
Jul 20 16:54:02 mindpipe kernel:  [__crc_totalram_pages+86289/3518512] snd_pcm_hw_rule_div+0x4b/0x60 [snd_pcm]
Jul 20 16:54:02 mindpipe kernel:  [__crc_totalram_pages+77959/3518512] snd_pcm_hw_refine+0x371/0x4a0 [snd_pcm]
Jul 20 16:54:02 mindpipe kernel:  [__crc_totalram_pages+111312/3518512] snd_pcm_hw_param_mask+0x3a/0x50 [snd_pcm]
Jul 20 16:54:02 mindpipe kernel:  [__crc_totalram_pages+882570/3518512] snd_pcm_oss_change_params+0xf4/0x850 [snd_pcm_oss]
Jul 20 16:54:02 mindpipe kernel:  [__crc_totalram_pages+884572/3518512] snd_pcm_oss_get_active_substream+0x76/0x90 [snd_pcm_oss]
Jul 20 16:54:02 mindpipe kernel:  [__crc_totalram_pages+888499/3518512] snd_pcm_oss_get_formats+0x1d/0x120 [snd_pcm_oss]
Jul 20 16:54:02 mindpipe kernel:  [__crc_totalram_pages+888796/3518512] snd_pcm_oss_set_format+0x26/0x60 [snd_pcm_oss]
Jul 20 16:54:02 mindpipe kernel:  [__crc_totalram_pages+894737/3518512] snd_pcm_oss_ioctl+0x49b/0x740 [snd_pcm_oss]
Jul 20 16:54:02 mindpipe kernel:  [sys_ioctl+256/608] sys_ioctl+0x100/0x260
Jul 20 16:54:02 mindpipe kernel:  [syscall_call+7/11] syscall_call+0x7/0xb
Jul 20 16:54:02 mindpipe kernel: IRQ: delay =  6702030 cycles, jitter = 6302828

Lee



