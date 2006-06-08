Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964786AbWFHKyR@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964786AbWFHKyR (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 8 Jun 2006 06:54:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964794AbWFHKyR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 8 Jun 2006 06:54:17 -0400
Received: from mx3.mail.elte.hu ([157.181.1.138]:40414 "EHLO mx3.mail.elte.hu")
	by vger.kernel.org with ESMTP id S964786AbWFHKyQ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 8 Jun 2006 06:54:16 -0400
Date: Thu, 8 Jun 2006 12:53:43 +0200
From: Ingo Molnar <mingo@elte.hu>
To: David Woodhouse <dwmw2@infradead.org>
Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>,
       Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org,
       paulus@samba.org
Subject: Re: mutex vs. local irqs (Was: 2.6.18 -mm merge plans)
Message-ID: <20060608105342.GA2346@elte.hu>
References: <20060604135011.decdc7c9.akpm@osdl.org> <1149652378.27572.109.camel@localhost.localdomain> <20060606212930.364b43fa.akpm@osdl.org> <1149656647.27572.128.camel@localhost.localdomain> <20060606222942.43ed6437.akpm@osdl.org> <1149662671.27572.158.camel@localhost.localdomain> <20060607132155.GB14425@elte.hu> <1149726685.23790.8.camel@localhost.localdomain> <1149763768.13596.140.camel@pmac.infradead.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1149763768.13596.140.camel@pmac.infradead.org>
User-Agent: Mutt/1.4.2.1i
X-ELTE-SpamScore: 0.0
X-ELTE-SpamLevel: 
X-ELTE-SpamCheck: no
X-ELTE-SpamVersion: ELTE 2.0 
X-ELTE-SpamCheck-Details: score=0.0 required=5.9 tests=AWL,BAYES_50 autolearn=no SpamAssassin version=3.0.3
	0.0 BAYES_50               BODY: Bayesian spam probability is 40 to 60%
	[score: 0.5012]
	0.0 AWL                    AWL: From: address is in the auto white-list
X-ELTE-VirusStatus: clean
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


* David Woodhouse <dwmw2@infradead.org> wrote:

> On Thu, 2006-06-08 at 10:31 +1000, Benjamin Herrenschmidt wrote:
> > I still don't think where is the suckage in just not hard-enabling in
> > the mutex debug code... 
> 
> If the mutex debugging code is hard-enabling interrupts before 
> init_IRQ() ever got called, that's just broken. Fixing that can hardly 
> be called 'suckage'.

to quote Andrew:

--------------->
Nonsense.  mutex_lock() can sleep.  Sleeping will enable interrupts.
Therefore, hence, ergo ipso facto mutex_lock() can enable interrupts. QED,
that's it.

But now, because some broken piece of hardware is coming out of
reset/firmware asserting an interrupt we need to change the rules to be
"mutex_lock() must preserve local interrupts if the lock is uncontended".
Ditto down(), down_read() and down_write().

And why does this bizarre restriction upon the implementation of our
locking primtives exist?  Because of your broken PIC and because of our
inability to sort out the early boot code.  And because the early boot code
has this implicit knowledge that the locks will be uncontended, else we're
toast.

We're doing mutex_lock(), down(), down_read() and down_write() with local
interrupts disabled, which is a bug.  We have explicit code in there to
*disable* our runtime debugging checks because we know about this bug but
don't know how to fix it.

I call that sucky.

