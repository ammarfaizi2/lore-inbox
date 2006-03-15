Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751945AbWCOWig@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751945AbWCOWig (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 15 Mar 2006 17:38:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752127AbWCOWig
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 15 Mar 2006 17:38:36 -0500
Received: from mx2.mail.elte.hu ([157.181.151.9]:16014 "EHLO mx2.mail.elte.hu")
	by vger.kernel.org with ESMTP id S1751945AbWCOWif (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 15 Mar 2006 17:38:35 -0500
Date: Wed, 15 Mar 2006 23:36:13 +0100
From: Ingo Molnar <mingo@elte.hu>
To: Jeff Garzik <jeff@garzik.org>
Cc: "Bill Rugolsky Jr." <brugolsky@telemetry-investments.com>,
       Andi Kleen <ak@suse.de>, Lee Revell <rlrevell@joe-job.com>,
       Jason Baron <jbaron@redhat.com>, linux-kernel@vger.kernel.org,
       john stultz <johnstul@us.ibm.com>
Subject: Re: libata/sata_nv latency on NVIDIA CK804 [was Re: AMD64 X2 lost ticks on PM timer]
Message-ID: <20060315223613.GB24074@elte.hu>
References: <200602280022.40769.darkray@ic3man.com> <4408BEB5.7000407@garzik.org> <20060303234330.GA14401@ti64.telemetry-investments.com> <200603040107.27639.ak@suse.de> <20060315213638.GA17817@ti64.telemetry-investments.com> <20060315215020.GA18241@elte.hu> <4418958E.7070200@garzik.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4418958E.7070200@garzik.org>
User-Agent: Mutt/1.4.2.1i
X-ELTE-SpamScore: -2.5
X-ELTE-SpamLevel: 
X-ELTE-SpamCheck: no
X-ELTE-SpamVersion: ELTE 2.0 
X-ELTE-SpamCheck-Details: score=-2.5 required=5.9 tests=ALL_TRUSTED,AWL,BAYES_50 autolearn=no SpamAssassin version=3.0.3
	-3.3 ALL_TRUSTED            Did not pass through any untrusted hosts
	0.0 BAYES_50               BODY: Bayesian spam probability is 40 to 60%
	[score: 0.5000]
	0.8 AWL                    AWL: From: address is in the auto white-list
X-ELTE-VirusStatus: clean
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


* Jeff Garzik <jeff@garzik.org> wrote:

> Ingo Molnar wrote:
> >* Bill Rugolsky Jr. <brugolsky@telemetry-investments.com> wrote:
> >
> >
> >>  <...>-2913  0d.h.    8us : raise_softirq_irqoff (blk_complete_request)
> >>  <...>-2913  0d.h.    8us : __ata_qc_complete (ata_qc_complete)
> >>  <...>-2913  0d.h.    9us : ata_host_intr (nv_interrupt)
> >>  <...>-2913  0d.h.    9us!: ata_bmdma_status (ata_host_intr)
> >>  <...>-2913  0d.h. 16641us : nv_check_hotplug_ck804 (nv_interrupt)
> >>  <...>-2913  0d.h. 16642us : _spin_unlock_irqrestore (nv_interrupt)
> >>  <...>-2913  0d.h. 16642us : smp_apic_timer_interrupt 
> >>  (apic_timer_interrupt)
> >>  <...>-2913  0d.h. 16642us : exit_idle (smp_apic_timer_interrupt)
> >
> >
> >ouch. The codepath in question (ata_host_intr()) doesnt seem to have any 
> >loop that could take 16.6 msecs (!). This very much looks like some 
> >hardware-triggered delay - some really screwed up DMA prioritization 
> >perhaps, starving the host CPU for 16.6 msecs? But what DMA takes 16.6 
> >msecs? That's enough time to transfer dozens of megabytes of data on a 
> >midrange system.
> 
> Yeah, I don't see anything offhand either.
> 
> sata_nv's nv_interrupt() should be using spin_lock() rather than 
> spin_lock_irqsave(), but I doubt that's a latency cause.

please see my previous codepath description. No spin_lock() calls in the 
measured codepath. They would show up in the latency trace anyway.

> I would be surprised if the legacy PCI IDE registers, all PIO-based, 
> would be implemented via BIOS SMM or some other similarly slow method.  
> But its not impossible...

yeah. But then again - PIO ops easily take 16 usecs on almost arbitrary 
PC hardware, so an SMM trap might not be all that noticeable - 
especially if this register is considered legacy. (maybe Windows does 
the MMIO variant)

	Ingo
