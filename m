Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266833AbUIITw3@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266833AbUIITw3 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 9 Sep 2004 15:52:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264530AbUIITwH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 9 Sep 2004 15:52:07 -0400
Received: from mx2.elte.hu ([157.181.151.9]:4509 "EHLO mx2.elte.hu")
	by vger.kernel.org with ESMTP id S266833AbUIITqa (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 9 Sep 2004 15:46:30 -0400
Date: Thu, 9 Sep 2004 21:47:37 +0200
From: Ingo Molnar <mingo@elte.hu>
To: Mark_H_Johnson@raytheon.com
Cc: Lee Revell <rlrevell@joe-job.com>, Free Ekanayaka <free@agnula.org>,
       Eric St-Laurent <ericstl34@sympatico.ca>,
       linux-kernel <linux-kernel@vger.kernel.org>,
       "K.R. Foley" <kr@cybsft.com>,
       Felipe Alfaro Solana <lkml@felipe-alfaro.com>,
       Daniel Schmitt <pnambic@unu.nu>,
       "P.O. Gaillard" <pierre-olivier.gaillard@fr.thalesgroup.com>,
       nando@ccrma.stanford.edu, luke@audioslack.com, free78@tin.it
Subject: Re: [patch] voluntary-preempt-2.6.9-rc1-bk4-R1
Message-ID: <20040909194737.GA2778@elte.hu>
References: <OF1EEB0481.83AB73CE-ON86256F0A.006A8955-86256F0A.006A8968@raytheon.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <OF1EEB0481.83AB73CE-ON86256F0A.006A8955-86256F0A.006A8968@raytheon.com>
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


* Mark_H_Johnson@raytheon.com <Mark_H_Johnson@raytheon.com> wrote:

> PIO trace
> =========

> 00000001 0.000ms (+0.370ms): touch_preempt_timing (ide_outsl)
> 00000001 0.370ms (+0.000ms): touch_preempt_timing (ide_outsl)

Please decrease the 128U chunking to 8U or so.

> I have several traces where send_IPI_mask_bitmask (flush_tlb_others)
> shows up. For example...

flush_tlb_others() is a good indicator of irqs-off sections on the other
CPU. The code does the following when it flushes TLBs: it sends an IPI
(inter-process-interrupt) to all other CPUs (one CPU in your case) and
waits for arrival of that IRQ and completion while spinning on a flag. 
The IPI normally takes 10 usecs or so to process so this is not an
issue. BUT if the CPU has IRQs disabled then the IPI is delayed and the
IRQs-off latency shows up as flush_tlb_others() latency.

> 00000003 0.014ms (+0.132ms): send_IPI_mask_bitmask (flush_tlb_others)
> 00010003 0.147ms (+0.000ms): do_nmi (flush_tlb_others)
> 00010003 0.147ms (+0.001ms): do_nmi (ide_outsl)

Since the other CPU's do_nmi() implicates ide_outsl it could be that we
are doing ide_outsl with IRQs disabled? Could you add something like
this to the ide_outsl code:

	if (irqs_disabled() && printk_ratelimit())
		dump_stack();

(the most common irqs-off section is the latency printout itself - this
triggers if the latency message goes to the console - i.e. 'dmesg -n 1'
wasnt done.)

> Buried inside a pretty long trace in kswapd0, I saw the following...

> 00000007 0.111ms (+0.000ms): _spin_unlock_irqrestore (try_to_wake_up)
> 00000006 0.111ms (+0.298ms): preempt_schedule (try_to_wake_up)
> 00000005 0.409ms (+0.000ms): _spin_unlock (flush_tlb_others)

this too is flush_tlb_others() related.

> So the long wait on paths through sched and timer_tsc appear to be
> eliminated with PIO to the disk.

yeah, nice. I'd still like to make sure that we've not hidden latencies
by working down the ide_outsl() latency and its apparent IRQs-off
property.

> Is there some "for sure" way to limit the size and/or duration of DMA
> transfers so I get reasonable performance from the disk (and other DMA
> devices) and reasonable latency?

the 'unit' of the 'weird' delays seem to be around 70 usecs, the maximum
seems to be around 560 usecs. Note the 1:8 relationship between the two. 
You have 32 KB as max_sectors, so the 70 usecs unit is for a single 4K
transfer which is a single scatter-gather entry: it all makes perfect
sense. 4K per 70 usecs means a DMA rate of ~57 MB/sec which sounds
reasonable.

so if these assumptions are true i'd suggest to decrease max_sectors
from 32K to 16K - that alone should halve these random latencies from
560 usecs to 280 usecs. Unless you see stability you might want to try
an 8K setting as well - this will likely decrease your IO rates
noticeably though. This would reduce the random delays to 140 usecs.

but the real fix would be to tweak the IDE controller to not do so
agressive DMA! Are there any BIOS settings that somehow deal with it? 
Try increasing the PCI latency value? Is the disk using UDMA - if yes,
could you downgrade it to normal IDE DMA? Perhaps that tweaks the
controller to be 'nice' to the CPU. Is your IDE chipset integrated on
the motherboard? Could you send me your full bootlog (off-list)?

there are also tools that tweak chipsets directly - powertweak and the
PCI latency settings. Maybe something tweaks the IDE controller just the
right way. Also, try disabling specific controller support in the
.config (or turn it on) - by chance the generic IDE code could program
the IDE controller in a way that generates nicer DMA.

	Ingo
