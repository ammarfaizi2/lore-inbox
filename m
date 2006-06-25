Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751015AbWFYSmk@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751015AbWFYSmk (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 25 Jun 2006 14:42:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751210AbWFYSmk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 25 Jun 2006 14:42:40 -0400
Received: from mail.gmx.net ([213.165.64.21]:63886 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id S1751015AbWFYSmj (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 25 Jun 2006 14:42:39 -0400
X-Authenticated: #5039886
Date: Sun, 25 Jun 2006 20:42:44 +0200
From: =?iso-8859-1?Q?Bj=F6rn?= Steinbrink <B.Steinbrink@gmx.de>
To: Arjan van de Ven <arjan@infradead.org>
Cc: Mike Galbraith <efault@gmx.de>, linux-kernel@vger.kernel.org,
       danial_thom@yahoo.com, Linus Torvalds <torvalds@osdl.org>,
       Andrew Morton <akpm@osdl.org>
Subject: Re: [PATCH] i386: Fix softirq accounting with 4K stacks
Message-ID: <20060625184244.GA11921@atjola.homenet>
Mail-Followup-To: =?iso-8859-1?Q?Bj=F6rn?= Steinbrink <B.Steinbrink@gmx.de>,
	Arjan van de Ven <arjan@infradead.org>,
	Mike Galbraith <efault@gmx.de>, linux-kernel@vger.kernel.org,
	danial_thom@yahoo.com, Linus Torvalds <torvalds@osdl.org>,
	Andrew Morton <akpm@osdl.org>
References: <1151142716.7797.10.camel@Homer.TheSimpsons.net> <1151149317.7646.14.camel@Homer.TheSimpsons.net> <20060624154037.GA2946@atjola.homenet> <1151166193.8516.8.camel@Homer.TheSimpsons.net> <20060624192523.GA3231@atjola.homenet> <1151211993.8519.6.camel@Homer.TheSimpsons.net> <20060625111238.GB8223@atjola.homenet> <20060625142440.GD8223@atjola.homenet> <1151257451.7858.45.camel@Homer.TheSimpsons.net> <1151257397.4940.45.camel@laptopd505.fenrus.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <1151257397.4940.45.camel@laptopd505.fenrus.org>
User-Agent: Mutt/1.5.11+cvs20060403
X-Y-GMX-Trusted: 0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 2006.06.25 19:43:17 +0200, Arjan van de Ven wrote:
> On Sun, 2006-06-25 at 19:44 +0200, Mike Galbraith wrote:
> > On Sun, 2006-06-25 at 16:24 +0200, Björn Steinbrink wrote:
> > 
> > > Still no idea why your "fix" works, but the following patch also fixes
> > > the problem and is at least a little more like the RightThing.
> > 
> > Yeah.  I don't know about you, but I fully intend to blatantly ignore
> > that 'why' ;-)
> 
> the why is relatively easy ;)
> 
> since the "is a softirq executing" bit is on the stack, and each context
> (user, soft and hard irq) has their own stack, it's not automatic that
> the hardirq stack gets the softirq-executing flag... which your patch
> fixes.

That's mine, not Mike's. Mike's patch removed the #ifdef CONFIG_SMP
around update_process_times() in smp_local_timer_interrupt().

> NMI's and apic irqs generally don't go via the normal irq path and thus
> don't do a stack switch... so they don't lose the bit (for accounting
> purposes)

Hm, doesn't that mean that mean that hardirq accounting is still broken?
APIC irq comes in, increases hardirq count, then the timer irq fires,
switches the stack and looses the hardirq count that was incremented by
the APIC irq.

I just booted with both patches applied, mine and Mike's, and that
actually makes a difference in hardirq cpu time accounting. With my
patch only, hi is 0 in top while the box gets a ping flood. With both
patches, I get about 1% hi. Mike's patch causes update_process_times()
to be called twice on UP, but that alone shouldn't change the
percentages, right?
OTOH top shows "hi" as zero with 8K stacks as well unless Mike's patch
is applied, so the results with Mike's patch are bogus (if so, why?) or
hardirq accounting is broken in general.

Btw, which path do apic irqs go? I stumbled across the nmi stuff, but
didn't see anything special for the apic irqs.

Björn
