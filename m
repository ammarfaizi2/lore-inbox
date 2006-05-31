Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965162AbWEaV1O@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965162AbWEaV1O (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 31 May 2006 17:27:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965169AbWEaV1N
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 31 May 2006 17:27:13 -0400
Received: from mx3.mail.elte.hu ([157.181.1.138]:58593 "EHLO mx3.mail.elte.hu")
	by vger.kernel.org with ESMTP id S965163AbWEaV1L (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 31 May 2006 17:27:11 -0400
Date: Wed, 31 May 2006 23:27:30 +0200
From: Ingo Molnar <mingo@elte.hu>
To: Arjan van de Ven <arjan@infradead.org>
Cc: alan@redhat.com, Andrew Morton <akpm@osdl.org>,
       linux-kernel@vger.kernel.org
Subject: Re: [patch, -rc5-mm1] locking validator: special rule: 8390.c disable_irq()
Message-ID: <20060531212730.GA3174@elte.hu>
References: <20060531200236.GA31619@elte.hu> <1149107500.3114.75.camel@laptopd505.fenrus.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1149107500.3114.75.camel@laptopd505.fenrus.org>
User-Agent: Mutt/1.4.2.1i
X-ELTE-SpamScore: 0.0
X-ELTE-SpamLevel: 
X-ELTE-SpamCheck: no
X-ELTE-SpamVersion: ELTE 2.0 
X-ELTE-SpamCheck-Details: score=0.0 required=5.9 tests=AWL,BAYES_50 autolearn=no SpamAssassin version=3.0.3
	0.0 BAYES_50               BODY: Bayesian spam probability is 40 to 60%
	[score: 0.5001]
	0.0 AWL                    AWL: From: address is in the auto white-list
X-ELTE-VirusStatus: clean
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


* Arjan van de Ven <arjan@infradead.org> wrote:

> On Wed, 2006-05-31 at 22:02 +0200, Ingo Molnar wrote:
> > untested on 8390 hardware, but ought to solve the lockdep false 
> > positive.
> > 
> > -----------------
> > Subject: locking validator: special rule: 8390.c disable_irq()
> > From: Ingo Molnar <mingo@elte.hu>
> > 
> > 8390.c knows that ei_local->page_lock can only be used by an irq
> > context that it disabled -
> 
> btw I think this is no longer correct with the irq polling stuff Alan 
> added to the kernel recently...

hm, indeed. misrouted_irq() goes through all irq descriptors and ignores 
IRQ_DISABLED flag - rendering disable_irq() useless in essence, and 
introducing the kind of deadlocks that lockdep warned about.

Andrew, as far as i can see with irqfixup this isnt a lockdep false 
positive but a real deadlock scenario - a spurious IRQ might arrive 
during vortex_timer() execution and might cause the execution of 
misrouted_irq(), which could execute vortex_interrupt() => deadlock.

Alan, is this a necessary property of irqpoll/irqfixup? Shouldnt 
irqfixup leave irq descriptors alone that are disabled?

	Ingo
