Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965166AbWEaV3q@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965166AbWEaV3q (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 31 May 2006 17:29:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965167AbWEaV3q
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 31 May 2006 17:29:46 -0400
Received: from mx3.mail.elte.hu ([157.181.1.138]:19938 "EHLO mx3.mail.elte.hu")
	by vger.kernel.org with ESMTP id S965166AbWEaV3p (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 31 May 2006 17:29:45 -0400
Date: Wed, 31 May 2006 23:30:02 +0200
From: Ingo Molnar <mingo@elte.hu>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: tglx@linutronix.de, Linux Kernel list <linux-kernel@vger.kernel.org>,
       Andrew Morton <akpm@osdl.org>
Subject: Re: [patch, -rc5-mm1] genirq: add chip->eoi(), fastack -> fasteoi
Message-ID: <20060531213002.GB3174@elte.hu>
References: <1149040361.766.10.camel@localhost.localdomain> <1149064735.20582.85.camel@localhost.localdomain> <1149066718.766.51.camel@localhost.localdomain> <20060531101925.GA27637@elte.hu> <1149110637.29764.9.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1149110637.29764.9.camel@localhost.localdomain>
User-Agent: Mutt/1.4.2.1i
X-ELTE-SpamScore: 0.0
X-ELTE-SpamLevel: 
X-ELTE-SpamCheck: no
X-ELTE-SpamVersion: ELTE 2.0 
X-ELTE-SpamCheck-Details: score=0.0 required=5.9 tests=AWL,BAYES_50 autolearn=no SpamAssassin version=3.0.3
	0.0 BAYES_50               BODY: Bayesian spam probability is 40 to 60%
	[score: 0.5024]
	0.0 AWL                    AWL: From: address is in the auto white-list
X-ELTE-VirusStatus: clean
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


* Benjamin Herrenschmidt <benh@kernel.crashing.org> wrote:

> Hrm... ok. Not sure I agree with adding one more callback but it 
> doesn't matter much.
> 
> Thing is, end() isn't used anymore at all now. Thus it's just 
> basically renaming end() to eoi() except that end() is still there for 
> whoever uses __do_IRQ() and ... handle_percpu_irq(). Doesn't make that 
> much sense to me. So I suppose you should also change 
> handle_percpu_irq() to use eoi() then and consider end() to be 
> "legacy" (to be used only by __do_IRQ) ?

ok, that works with me. I did not want to reuse ->end() just to have a 
clean migration path. ->eoi() is in fact quite descriptive as well, so 
i'm not worried about the name.

> > sounds like a plan? The patch below works fine for me.
> 
> The patch is _almost_ right to me :) I don't need the
> 
> 	if (unlikely(desc->status & IRQ_DISABLED))
>  		desc->chip->mask(irq);
> 
> At all. I suppose it won't harm, but it shouldn't be necessary for me 
> and I'm not sure why it's necessary on IO_APIC neither (but then I 
> don't know those very well).

hm, i dont think it's necessary either. I'll run a few experiments. 
Thomas, do you remember why we have that masking there?

	Ingo
