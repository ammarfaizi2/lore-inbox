Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263980AbUGMSmL@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263980AbUGMSmL (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 13 Jul 2004 14:42:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264160AbUGMSmL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 13 Jul 2004 14:42:11 -0400
Received: from mustang.oldcity.dca.net ([216.158.38.3]:19122 "HELO
	mustang.oldcity.dca.net") by vger.kernel.org with SMTP
	id S263980AbUGMSmF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 13 Jul 2004 14:42:05 -0400
Subject: Re: [linux-audio-dev] Re: [announce] [patch] Voluntary Kernel
	Preemption Patch
From: Lee Revell <rlrevell@joe-job.com>
To: Andrea Arcangeli <andrea@suse.de>
Cc: linux-audio-dev@music.columbia.edu, linux-kernel@vger.kernel.org
In-Reply-To: <20040713162539.GD974@dualathlon.random>
References: <20040712163141.31ef1ad6.akpm@osdl.org>
	 <200407130001.i6D01pkJ003489@localhost.localdomain>
	 <20040712170844.6bd01712.akpm@osdl.org>
	 <20040713162539.GD974@dualathlon.random>
Content-Type: text/plain
Message-Id: <1089744137.20381.49.camel@mindpipe>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 
Date: Tue, 13 Jul 2004 14:42:18 -0400
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2004-07-13 at 12:25, Andrea Arcangeli wrote:
> On Mon, Jul 12, 2004 at 05:08:44PM -0700, Andrew Morton wrote:
> > of code then it's pretty obvious what's happening.  If the trace is due to
> > a long irq-off time then it will point up into the offending
> > local_irq_enable().
> 
> schedule should be called with irq enabled, and I noticed here it's not
> (jnz work_resched is executed with irq off so there is a window for
> schedule to be called with irq off):
> 
> Index: linux-2.5/arch/i386/kernel/entry.S
> ===================================================================
> RCS file: /home/andrea/crypto/cvs/linux-2.5/arch/i386/kernel/entry.S,v
> retrieving revision 1.86
> diff -u -p -r1.86 entry.S
> --- linux-2.5/arch/i386/kernel/entry.S	23 May 2004 05:03:15 -0000	1.86
> +++ linux-2.5/arch/i386/kernel/entry.S	13 Jul 2004 04:21:55 -0000
> @@ -302,6 +310,7 @@ work_pending:
>  	testb $_TIF_NEED_RESCHED, %cl
>  	jz work_notifysig
>  work_resched:
> +	sti
>  	call schedule
>  	cli				# make sure we don't miss an interrupt
>  					# setting need_resched or sigpending

Would this explain these?  When running JACK with settings that need
sub-millisecond latencies, I get them when I generate any load at all on
the system (typing, switching windows, etc).  I also get lots of these
if I run JACK from an X terminal, but very few if I run it from a text
console, even if X is running in the background.

Jul 13 14:36:16 mindpipe kernel: ALSA /usr/src/alsa-cvs-1.0.5/alsa-driver/alsa-kernel/core/pcm_lib.c:199: Unexpected hw_pointer value [1] (stream = 0, delta: -25, max jitter = 32): wrong interrupt acknowledge?
Jul 13 14:36:16 mindpipe kernel:  [__crc_totalram_pages+1386981/5353478] snd_pcm_period_elapsed+0x1af/0x410 [snd_pcm]
Jul 13 14:36:16 mindpipe kernel:  [__crc_totalram_pages+1455070/5353478] snd_emu10k1_interrupt+0x3c8/0x480 [snd_emu10k1]
Jul 13 14:36:16 mindpipe kernel:  [handle_IRQ_event+49/96] handle_IRQ_event+0x31/0x60
Jul 13 14:36:16 mindpipe kernel:  [do_IRQ+155/352] do_IRQ+0x9b/0x160
Jul 13 14:36:16 mindpipe kernel:  [common_interrupt+24/32] common_interrupt+0x18/0x20
Jul 13 14:36:16 mindpipe kernel:  [__do_softirq+48/144] __do_softirq+0x30/0x90
Jul 13 14:36:16 mindpipe kernel:  [do_softirq+53/64] do_softirq+0x35/0x40
Jul 13 14:36:16 mindpipe kernel:  [do_IRQ+261/352] do_IRQ+0x105/0x160
Jul 13 14:36:16 mindpipe kernel:  [common_interrupt+24/32] common_interrupt+0x18/0x20
Jul 13 14:36:16 mindpipe kernel:
Jul 13 14:36:16 mindpipe kernel: ALSA /usr/src/alsa-cvs-1.0.5/alsa-driver/alsa-kernel/core/pcm_lib.c:199: Unexpected hw_pointer value [1] (stream = 0, delta: -31, max jitter = 32): wrong interrupt acknowledge?
Jul 13 14:36:16 mindpipe kernel:  [__crc_totalram_pages+1386981/5353478] snd_pcm_period_elapsed+0x1af/0x410 [snd_pcm]
Jul 13 14:36:16 mindpipe kernel:  [__crc_totalram_pages+1455070/5353478] snd_emu10k1_interrupt+0x3c8/0x480 [snd_emu10k1]
Jul 13 14:36:16 mindpipe kernel:  [handle_IRQ_event+49/96] handle_IRQ_event+0x31/0x60
Jul 13 14:36:16 mindpipe kernel:  [do_IRQ+155/352] do_IRQ+0x9b/0x160
Jul 13 14:36:16 mindpipe kernel:  [common_interrupt+24/32] common_interrupt+0x18/0x20
Jul 13 14:36:16 mindpipe kernel:  [dnotify_parent+42/160] dnotify_parent+0x2a/0xa0
Jul 13 14:36:16 mindpipe kernel:  [vfs_read+206/256] vfs_read+0xce/0x100
Jul 13 14:36:16 mindpipe kernel:  [sys_read+45/80] sys_read+0x2d/0x50
Jul 13 14:36:16 mindpipe kernel:  [syscall_call+7/11] syscall_call+0x7/0xb
Jul 13 14:36:16 mindpipe kernel:

Lee

