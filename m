Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965128AbWEaToS@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965128AbWEaToS (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 31 May 2006 15:44:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965129AbWEaToS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 31 May 2006 15:44:18 -0400
Received: from mx3.mail.elte.hu ([157.181.1.138]:58790 "EHLO mx3.mail.elte.hu")
	by vger.kernel.org with ESMTP id S965128AbWEaToR (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 31 May 2006 15:44:17 -0400
Date: Wed, 31 May 2006 21:44:37 +0200
From: Ingo Molnar <mingo@elte.hu>
To: Andrew Morton <akpm@osdl.org>
Cc: Arjan van de Ven <arjan@linux.intel.com>, pauldrynoff@gmail.com,
       linux-kernel@vger.kernel.org
Subject: Re: 2.6.17-rc5-mm1 - output of lock validator
Message-ID: <20060531194437.GA31121@elte.hu>
References: <20060530195417.e870b305.pauldrynoff@gmail.com> <20060530132540.a2c98244.akpm@osdl.org> <20060531181926.51c4f4c5.pauldrynoff@gmail.com> <1149085739.3114.34.camel@laptopd505.fenrus.org> <20060531102128.eb0020ad.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060531102128.eb0020ad.akpm@osdl.org>
User-Agent: Mutt/1.4.2.1i
X-ELTE-SpamScore: 0.0
X-ELTE-SpamLevel: 
X-ELTE-SpamCheck: no
X-ELTE-SpamVersion: ELTE 2.0 
X-ELTE-SpamCheck-Details: score=0.0 required=5.9 tests=AWL,BAYES_50 autolearn=no SpamAssassin version=3.0.3
	0.0 BAYES_50               BODY: Bayesian spam probability is 40 to 60%
	[score: 0.5000]
	0.0 AWL                    AWL: From: address is in the auto white-list
X-ELTE-VirusStatus: clean
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


* Andrew Morton <akpm@osdl.org> wrote:

> On Wed, 31 May 2006 16:28:59 +0200
> Arjan van de Ven <arjan@linux.intel.com> wrote:
> 
> > --- linux-2.6.17-rc5-mm1.5.orig/drivers/net/8390.c
> > +++ linux-2.6.17-rc5-mm1.5/drivers/net/8390.c
> > @@ -299,7 +299,7 @@ static int ei_start_xmit(struct sk_buff 
> >  	 
> >  	disable_irq_nosync(dev->irq);
> >  	
> > -	spin_lock(&ei_local->page_lock);
> > +	spin_lock_irqsave(&ei_local->page_lock, flags);
> 
> Again, notabug - we did disable_irq().
> 
> I think lockdep needs to be taught about this idiom.  Perhaps add a 
> new disable_irq_tell_lockdep() which assumes that we're in an 
> equivalent-to-local_irq_disable() state.

agreed. I'll cook up an API for that. The best would be to disable local 
irqs if LOCKDEP is enabled - i.e. how about disable_irq_lockdep() that 
maps to disable_irq() if !LOCKDEP and on LOCKDEP it also disables local 
interrupts? Likewise there would be an enable_irq_lockdep() which would 
re-enable local irqs.

	Ingo
