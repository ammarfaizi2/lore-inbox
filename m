Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266881AbUG1Lpx@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266881AbUG1Lpx (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 28 Jul 2004 07:45:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266882AbUG1Lpx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 28 Jul 2004 07:45:53 -0400
Received: from pD9517271.dip.t-dialin.net ([217.81.114.113]:6529 "EHLO
	undata.org") by vger.kernel.org with ESMTP id S266881AbUG1Lpu (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 28 Jul 2004 07:45:50 -0400
Subject: Re: [patch] voluntary-preempt-2.6.8-rc2-L2, preemptable hardirqs
From: Thomas Charbonnel <thomas@undata.org>
To: Ingo Molnar <mingo@elte.hu>
Cc: Lee Revell <rlrevell@joe-job.com>,
       linux-kernel <linux-kernel@vger.kernel.org>,
       William Lee Irwin III <wli@holomorphy.com>,
       Lenar L?hmus <lenar@vision.ee>, Andrew Morton <akpm@osdl.org>,
       Arjan van de Ven <arjanv@redhat.com>
In-Reply-To: <20040728050535.GA14742@elte.hu>
References: <1090732537.738.2.camel@mindpipe>
	 <1090795742.719.4.camel@mindpipe> <20040726082330.GA22764@elte.hu>
	 <1090830574.6936.96.camel@mindpipe> <20040726083537.GA24948@elte.hu>
	 <1090832436.6936.105.camel@mindpipe> <20040726124059.GA14005@elte.hu>
	 <20040726204720.GA26561@elte.hu> <20040727162759.GA32548@elte.hu>
	 <1090968457.743.3.camel@mindpipe>  <20040728050535.GA14742@elte.hu>
Content-Type: text/plain
Message-Id: <1091015060.5560.9.camel@localhost>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 
Date: Wed, 28 Jul 2004 13:44:20 +0200
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> * Lee Revell <rlrevell@joe-job.com> wrote:
> 
> > > i've done a softirq lock-break in the atkbd and ps2mouse drivers - this
> > > should fix the big latencies triggered by NumLock/CapsLock, reported by
> > > Lee Revell.
> > 
> > L2 does not fix this problem.  Previously, toggling CapsLock would
> > trigger a single large XRUN.  Now it seems to actually prevent the
> > soundcard interrupt handler from executing in time, as well as
> > triggering smaller XRUNs.  This is with preempt=1,
> > voluntary-preempt=3.
> 
> yeah, this is because right now irqd lacks any configurability: it is
> executing all hardirqs (and all softirqs) in one context without any
> particular prioritization.
> 
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
> 
> 	Ingo

Testing with -L2 and the redirectable_irq change, the xruns triggered by
the keyboard on 8.079 secs boundaries are still here (but the CAPS_LOCK
one is gone since the the redirectable change). I ran some latency tests
with vp:3 kp:0, progressively rising the rtc freqency (2048, 4096), and
I realized that those latency spikes every 8.079 seconds are here even
if I don't touch the keyboard. Here's the typical showtrace output for
those spikes :

T=1.14231 diff=0.978288
 rtc_interrupt (+bd)
 handle_IRQ_event (+50)
 do_hardirq (+bc)
 irqd (+ac)
 kthread (+aa)
 irqd (+0)
 kthread (+0)
 kernel_thread_helper (+5)

The pattern is very similar to the previous one I reported on those
regular xruns :

XRUN: pcmC2D0c
 [<c0105f6e>] dump_stack+0x1e/0x30
 [<c03673b1>] snd_pcm_period_elapsed+0x2e1/0x420
 [<c039d3d4>] snd_hdsp_interrupt+0x174/0x180
 [<c01073bb>] handle_IRQ_event+0x3b/0x70
 [<c0107746>] do_IRQ+0x96/0x150
 [<c0105b14>] common_interrupt+0x18/0x20
 [<c0107746>] do_IRQ+0x96/0x150
 [<c0105b14>] common_interrupt+0x18/0x20
 [<c01030f4>] cpu_idle+0x34/0x40
 [<c054880d>] start_kernel+0x16d/0x190
 [<c010019f>] 0xc010019f

The other source of xrun was seen during the disk write tests, once the
memory runs out (spikes up to 14 ms, but more generally 6 ms)

Thomas


