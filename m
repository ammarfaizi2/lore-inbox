Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750919AbWFNHEz@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750919AbWFNHEz (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 14 Jun 2006 03:04:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751108AbWFNHEy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 14 Jun 2006 03:04:54 -0400
Received: from mx3.mail.elte.hu ([157.181.1.138]:31677 "EHLO mx3.mail.elte.hu")
	by vger.kernel.org with ESMTP id S1750940AbWFNHEy (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 14 Jun 2006 03:04:54 -0400
Date: Wed, 14 Jun 2006 09:03:53 +0200
From: Ingo Molnar <mingo@elte.hu>
To: "Eric W. Biederman" <ebiederm@xmission.com>
Cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org,
       Thomas Gleixner <tglx@linutronix.de>
Subject: Re: The i386 and x86_64 genirq patches are wrong!
Message-ID: <20060614070353.GA11896@elte.hu>
References: <m1r71t2ew8.fsf@ebiederm.dsl.xmission.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <m1r71t2ew8.fsf@ebiederm.dsl.xmission.com>
User-Agent: Mutt/1.4.2.1i
X-ELTE-SpamScore: 0.0
X-ELTE-SpamLevel: 
X-ELTE-SpamCheck: no
X-ELTE-SpamVersion: ELTE 2.0 
X-ELTE-SpamCheck-Details: score=0.0 required=5.9 tests=AWL,BAYES_50 autolearn=no SpamAssassin version=3.0.3
	0.0 BAYES_50               BODY: Bayesian spam probability is 40 to 60%
	[score: 0.5820]
	0.0 AWL                    AWL: From: address is in the auto white-list
X-ELTE-VirusStatus: clean
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


* Eric W. Biederman <ebiederm@xmission.com> wrote:

> A little while ago I worked up some patches to that made x86 vectors 
> per cpu.  Allowing x86 to handle more than 256 irqs, which 
> significantly cleaned up the code.
> 
> The big stumbling block there was msi and it's totally backwards way 
> of allocating interrupts.  Getting msi to work with irqs and not 
> vectors is a lot of work, and very hard to make a clean patchset out 
> of.

yeah. The whole MSI irq remapping business is a total mess anyway: all 
that trouble we do to compensate a +32 mapping offset of vectors vs. 
irqs? Why dont we simply fix up all IRQ entry stubs to have +32, and 
thus we'd standardize on vector metrics and be done with it. In 
/proc/interrupts we could subtract 32 perhaps. Then MSI would be always 
enabled and there would be no MSI #ifdefs anywhere. Am i missing 
something?

> I currently have a pending bug fix that puts move_irq in the correct 
> place for edge and level triggered interrupts.
> 
> For edge triggered interrupts you must move the irq before you 
> acknowledge the interrupt, or else it can reoccur.
>
> For level triggered interrupts you must acknowledge the irq before you 
> move it, or else the acknowledgement will never find it's way back to 
> the irq source.

could you please send that fix to me, against whatever base you have it 
tested on, and i'll merge it to genirq/irqchips [and fix up genirq if 
needed]. Please also include a description of the problem. How common is 
that edge retrigger problem, and how come this has never been seen in 
the past years since we had irqbalance?

> Previously in io_apic.c the hacks that the msi code imposed on it were 
> clear, and many of them were enclosed in #ifdef CONFIG_PCI_MSI. Now 
> that ifdefs are gone, and the logic in io_apic.h that selected between 
> the versions of the irq handlers to use (vector or irq) has not been 
> updated.
> 
> I don't know if the latter is actually a bug.  But it definitely makes 
> it harder to remove the msi hacks, and io_apic.h should definitely 
> have been updated.

here too it's hard for me to give an answer without seeing your specific 
changes (against whatever base is most convenient to you). MSI certainly 
works fine on current -mm. (at least on my box)

	Ingo
