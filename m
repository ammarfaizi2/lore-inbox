Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261235AbVFNGAr@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261235AbVFNGAr (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 14 Jun 2005 02:00:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261233AbVFNGAr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 14 Jun 2005 02:00:47 -0400
Received: from mx1.elte.hu ([157.181.1.137]:11751 "EHLO mx1.elte.hu")
	by vger.kernel.org with ESMTP id S261235AbVFNGAj (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 14 Jun 2005 02:00:39 -0400
Date: Tue, 14 Jun 2005 07:58:55 +0200
From: Ingo Molnar <mingo@elte.hu>
To: Christoph Hellwig <hch@infradead.org>,
       Kristian Benoit <kbenoit@opersys.com>, linux-kernel@vger.kernel.org
Subject: Re: network driver disabled interrupts in PREEMPT_RT
Message-ID: <20050614055855.GA29397@elte.hu>
References: <1118688347.5792.12.camel@localhost> <20050613185642.GA12463@elte.hu> <20050613190310.GB4308@infradead.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050613190310.GB4308@infradead.org>
User-Agent: Mutt/1.4.2.1i
X-ELTE-SpamVersion: MailScanner 4.31.6-itk1 (ELTE 1.2) SpamAssassin 2.63 ClamAV 0.73
X-ELTE-VirusStatus: clean
X-ELTE-SpamCheck: no
X-ELTE-SpamCheck-Details: score=-4.9, required 5.9,
	BAYES_00 -4.90
X-ELTE-SpamLevel: 
X-ELTE-SpamScore: -4
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


* Christoph Hellwig <hch@infradead.org> wrote:

> On Mon, Jun 13, 2005 at 08:56:42PM +0200, Ingo Molnar wrote:
> > 
> > * Kristian Benoit <kbenoit@opersys.com> wrote:
> > 
> > > Hi,
> > > I got lots of these messages when accessing the net running
> > > 2.6.12-rc6-RT-V0.7.48-25 :
> > > 
> > > "network driver disabled interrupts: tg3_start_xmit+0x0/0x629 [tg3]"
> > > 
> > > it seem to come from net/sched/sch_generic.c.
> > 
> > does the patch below fix it?
> 
> Wouldn't it be much more useful to add spin_trylock_irq?

you are right, a spin_trylock_irqsave() call would be much cleaner.

i think i should explain why you are seeing such hacks in the PREEMPT_RT 
patch: generally we are trying to achieve near-100% driver API 
compatibility (that of course is also one of the requirements for any of 
this to hit mainline), so i'm marking any deviations with _nort or _rt 
postfixes (depending on where the change in semantics is needed). I 
consider them temporary hacks, so i'm usually trying to keep the 
original form of the code, so that i can go back later and fix it.

I had these hacks in tg3.c for some time, and i thought i could drop 
them now that local_irq_*() uses the soft IRQ-flag - but i was wrong.  
One example of the _rt/_nort marking process is e.g. the earlier RCU API 
related grossness, which went away with Paul's PREEMPT_RCU aproach and 
now PREEMPT_RT is fully compatible with the RCU API. Fortunately, 
assymetric local_irq_* + spin_lock_* uses (which are perfectly legal!)  
are relatively rare. Extending the spinlock APIs and converting all 
upstream code would be a good approach to solve this problem, as it's 
also a cleanup. (It would probably also make static lock analysis 
easier.)

	Ingo
