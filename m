Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261986AbUKVI77@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261986AbUKVI77 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 22 Nov 2004 03:59:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261988AbUKVI77
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 22 Nov 2004 03:59:59 -0500
Received: from mx1.elte.hu ([157.181.1.137]:16028 "EHLO mx1.elte.hu")
	by vger.kernel.org with ESMTP id S261986AbUKVI7y (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 22 Nov 2004 03:59:54 -0500
Date: Mon, 22 Nov 2004 11:01:40 +0100
From: Ingo Molnar <mingo@elte.hu>
To: Eran Mann <emann@mrv.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [patch] Real-Time Preemption, -RT-2.6.10-rc2-mm2-V0.7.30-2
Message-ID: <20041122100140.GD6817@elte.hu>
References: <20041111144414.GA8881@elte.hu> <20041111215122.GA5885@elte.hu> <20041116125402.GA9258@elte.hu> <20041116130946.GA11053@elte.hu> <20041116134027.GA13360@elte.hu> <20041117124234.GA25956@elte.hu> <20041118123521.GA29091@elte.hu> <20041118164612.GA17040@elte.hu> <20041122005411.GA19363@elte.hu> <41A1A6E6.5090807@mrv.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <41A1A6E6.5090807@mrv.com>
User-Agent: Mutt/1.4.1i
X-ELTE-SpamVersion: MailScanner 4.31.6-itk1 (ELTE 1.2) SpamAssassin 2.63 ClamAV 0.73
X-ELTE-VirusStatus: clean
X-ELTE-SpamCheck: no
X-ELTE-SpamCheck-Details: score=-4.9, required 5.9,
	autolearn=not spam, BAYES_00 -4.90
X-ELTE-SpamLevel: 
X-ELTE-SpamScore: -4
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


* Eran Mann <emann@mrv.com> wrote:

> Ingo Molnar wrote:
> >i have released the -V0.7.30-2 Real-Time Preemption patch, which can be
> >downloaded from the usual place:
> >
> >	http://redhat.com/~mingo/realtime-preempt/
> 
> Hi,
> I´m seeing latencies of up to ~2000 microseconds. see attached traces
> file for a small sample. I think I´m missing something obvious
> config-wise but I don´t know what...

  131 88000002 0.003ms (+0.000ms): deactivate_task (__schedule)
  131 88000002 0.003ms (+1.687ms): dequeue_task (deactivate_task)
 5506 80000002 1.691ms (+0.001ms): __switch_to (__schedule)

this seems to be hardware-generated. As you can see it from the trace,
the codepath between __schedule()'s deactive_task() and __switch_to()
has all interrupts and preemption disabled. The O(1) scheduler there has
constant overhead and that codepath should at most take ~1 usec.

(there is one exception, if both LATENCY_TRACING and RT_DEADLOCK_DETECT
are enabled in -V0.7.30-2 and later kernels then the overhead within
__schedule is O(nr_running), because the tracer adds entries for every
runnable task. But this is not the case for your trace because then
you'd see those entries in /proc/latency_trace.)

> The ´load´ during the traces consisted of a kernel build in a
> gnome-terminal, and 2 browser windows with a heavy site (Flash ads
> etc.) in each. This load causes a >1 ms latency every 5 minutes on
> average. After the kernel build ended the rate dropped dramatically to
> ~2 traces an hour.

this seems to imply IDE DMA related hardware overhead. Apparently what
happens is that with certain motherboards/chipsets, if IDE DMA happens
then that DMA transfer _completely locks up_ the system bus. Nothing 
happens, and the CPU is stalled in essence until the end of the DMA 
request.

there's nothing the kernel can do about a hardware latency like that,
but you can try to work it around. Mark H. Johnson has reported up to
500 usec latencies that had a similar pattern as yours, and he has
experimented with lesser DMA modes (udma2?) via hdparm. YMMV and be
careful with hdparm settings.

> The traces were from V-0.7.29-5 but I´ve seen these latencies in all
> RT kernels I tested (2.6.9-mm1-RT-V0.2 was the first). I´ll try
> V0.7.30-2 next. The machine is a PIII 733 Mhz, 256MB RAM, IDE disks.

this very strongly implies some sort of hardware overhead. Btw., the
likely reason why this often shows up within __schedule() is that 1)
it's a very common operation, especially on the -RT kernel 2) we do a
TLB flush there, which can be quite memory-intense, so if the system bus
(the memory bus) is locked up, there is a high likelyhood that this
function generates a cachemiss.

	Ingo
