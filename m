Return-Path: <linux-kernel-owner+willy=40w.ods.org-S270174AbUJTJbB@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S270174AbUJTJbB (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 20 Oct 2004 05:31:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S270149AbUJTJ1L
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 20 Oct 2004 05:27:11 -0400
Received: from mx2.elte.hu ([157.181.151.9]:37062 "EHLO mx2.elte.hu")
	by vger.kernel.org with ESMTP id S270121AbUJTJWv (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 20 Oct 2004 05:22:51 -0400
Date: Wed, 20 Oct 2004 11:20:17 +0200
From: Ingo Molnar <mingo@elte.hu>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: Paul Mackerras <paulus@samba.org>, Andrew Morton <akpm@osdl.org>,
       Linus Torvalds <torvalds@osdl.org>, Anton Blanchard <anton@samba.org>,
       Linux Kernel list <linux-kernel@vger.kernel.org>,
       Christoph Hellwig <hch@infradead.org>,
       Russell King <rmk+lkml@arm.linux.org.uk>
Subject: Re: New consolidate irqs vs . probe_irq_*()
Message-ID: <20041020092017.GA28054@elte.hu>
References: <16758.3807.954319.110353@cargo.ozlabs.ibm.com> <20041020083358.GB23396@elte.hu> <1098261745.6263.9.camel@gaston> <20041020084838.GA25798@elte.hu> <1098262403.6278.16.camel@gaston>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1098262403.6278.16.camel@gaston>
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


* Benjamin Herrenschmidt <benh@kernel.crashing.org> wrote:

> On Wed, 2004-10-20 at 18:48, Ingo Molnar wrote:
> 
> > yeah. I've put it into a separate autoprobe.c file specifically for that
> > reason, you can exclude it in the Makefile and can provide your own
> > architecture version. Or should we make the no-autoprobing choice
> > generic perhaps?
> 
> I like this later option... How may archs actually had autoprobing
> implemented and actually used ?
> 
> Well, I'll do some grep'ing around tonight as I do the NO_IRQ stuff
> and see what makes more sense. I don't think an arch that didn't have
> autoprobing needs it now, besides, it's not exactly a reliable
> mecanism...

btw., auto-detection of interrupt sources is not _necessarily_ broken. 
Especially with level-triggered interrupts (where no active irq source
can get lost) it can be doable and reliable. (Here i dont mean the
probe_irq_on/off interface, but the concept of auto-detection.)

Alan has a very neat hack that fixes laptop BIOS breakage in associating
a screaming interrupt with the driver that responds to it with
IRQ_HANDLED, by probing through all the SHIRQ handlers and checking
whether the return code is IRQ_HANDLED. (this patch was in -mm but has
not been integrated into the generic irq subsystem yet.) This patch
turned a broken-under-Linux into a working laptop so we cannot ignore
it.

In theory, as long as all drivers involved are shared-irq-capable, and
all interrupts are level-triggered and get repeated if unhandled, we can
always do this kinds of driver-feedback-based irq vector discovery.

Think about the positive effects: in theory we could even boot into a
box without _any_ BIOS interrupt info whatsoever, assuming only a few
architecture basics like the identity of the timer interrupt.
Furthermore, if the BIOS reports _bad_ interrupt information, we can
detect & redirect that interrupt to the driver that responds to it.

this is not a concept that would be too useful for the server space, but
it sure could be useful for the produce-and-forget PC mass-market. We
are playing a constant and mostly losing catchup game with BIOS quirks.

what can never work fully reliably is of course what the feature was
used for primarily: ISA :-) One-time edge-triggered interrupts that get
lost are nasty ...

so i thought autodetect.c could survive in the generic code - maybe we
can make something really nice out of it, based on Alan's patch.

	Ingo
