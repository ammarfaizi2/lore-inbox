Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262114AbUG1UDY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262114AbUG1UDY (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 28 Jul 2004 16:03:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262744AbUG1UDX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 28 Jul 2004 16:03:23 -0400
Received: from viper.oldcity.dca.net ([216.158.38.4]:29591 "HELO
	viper.oldcity.dca.net") by vger.kernel.org with SMTP
	id S262114AbUG1UDU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 28 Jul 2004 16:03:20 -0400
Subject: Re: [patch] voluntary-preempt-2.6.8-rc2-L2, preemptable hardirqs
From: Lee Revell <rlrevell@joe-job.com>
To: Ingo Molnar <mingo@elte.hu>
Cc: linux-kernel <linux-kernel@vger.kernel.org>,
       William Lee Irwin III <wli@holomorphy.com>,
       Lenar L?hmus <lenar@vision.ee>, Andrew Morton <akpm@osdl.org>,
       Arjan van de Ven <arjanv@redhat.com>, thomas@undata.org
In-Reply-To: <20040728050535.GA14742@elte.hu>
References: <1090732537.738.2.camel@mindpipe>
	 <1090795742.719.4.camel@mindpipe> <20040726082330.GA22764@elte.hu>
	 <1090830574.6936.96.camel@mindpipe> <20040726083537.GA24948@elte.hu>
	 <1090832436.6936.105.camel@mindpipe> <20040726124059.GA14005@elte.hu>
	 <20040726204720.GA26561@elte.hu> <20040727162759.GA32548@elte.hu>
	 <1090968457.743.3.camel@mindpipe>  <20040728050535.GA14742@elte.hu>
Content-Type: text/plain
Message-Id: <1091045017.791.15.camel@mindpipe>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 
Date: Wed, 28 Jul 2004 16:03:38 -0400
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2004-07-28 at 01:05, Ingo Molnar wrote:
> if your soundcard doesnt share the irq line with any other 'heavy' 
> interrupt then you can make the irq 'direct' via a simple change to 
> arch/i386/kernel/irq.c, change this line from:
> 
>  #define redirectable_irq(irq) ((irq) != 0)
> 
> to:
> 
>  #define redirectable_irq(irq) (((irq) != 0) && ((irq) != 10))
> 
> (if the soundcard is on IRQ 10).
> 
> does such a change combined with v=3 fix the latencies you are seeing?

This fixes the PS/2 problem, but running iozone still produces these
(very small, ~0.1ms) XRUNs:

ALSA /home/rlrevell/cvs/alsa/alsa-driver/alsa-kernel/core/pcm_lib.c:139: XRUN: pcmC0D2c
 [<c01066a7>] dump_stack+0x17/0x20
 [<de93d54b>] snd_pcm_period_elapsed+0x27b/0x3e0 [snd_pcm]
 [<de979211>] snd_emu10k1_interrupt+0xd1/0x3c0 [snd_emu10k1]
 [<c01078d7>] handle_IRQ_event+0x47/0x90
 [<c0107e93>] do_IRQ+0xe3/0x1b0
 [<c0106268>] common_interrupt+0x18/0x20
 [<c020793c>] ide_dma_intr+0x7c/0xa0
 [<c02014a9>] ide_intr+0xf9/0x1a0
 [<c01078d7>] handle_IRQ_event+0x47/0x90
 [<c0107c3f>] do_hardirq+0xaf/0x180
 [<c011a9bb>] irqd+0x9b/0xc0
 [<c0128514>] kthread+0xa4/0xb0
 [<c0104395>] kernel_thread_helper+0x5/0x10

This is with the default max_sectors_kb of 1024.  If I turn this down 
to 512, I do not get these, but I did get this one, only once:

ALSA /home/rlrevell/cvs/alsa/alsa-driver/alsa-kernel/core/pcm_lib.c:139: XRUN: pcmC0D2c
 [<c01066a7>] dump_stack+0x17/0x20
 [<de93d54b>] snd_pcm_period_elapsed+0x27b/0x3e0 [snd_pcm]
 [<de979211>] snd_emu10k1_interrupt+0xd1/0x3c0 [snd_emu10k1]
 [<c01078d7>] handle_IRQ_event+0x47/0x90
 [<c0107e93>] do_IRQ+0xe3/0x1b0
 [<c0106268>] common_interrupt+0x18/0x20
 [<c0262957>] schedule+0x2c7/0x580
 [<c02630d7>] schedule_timeout+0x57/0xa0
 [<c015df61>] do_poll+0xa1/0xc0
 [<c015e0b1>] sys_poll+0x131/0x220
 [<c0106047>] syscall_call+0x7/0xb

If I turn max_sectors_kb down to 256, I do not get any XRUNs at all, 
and the maximum delay reported by running JACK for 5 minutes (several 
million soundcard IRQs) is only 42 usecs!  Previously, with 1:2, I could 
only get this down to ~120 usecs, and this required setting max_sectors_kb 
to 32-64.  Going any lower than this did not reduce latency any more, it 
seems like some other code path is responsible.

I am not seeing the latency spikes at ~8 second intervals that Thomas reported.
Could this be a bug in latencytest? 

Lee 



