Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932147AbWELQif@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932147AbWELQif (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 12 May 2006 12:38:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932148AbWELQif
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 12 May 2006 12:38:35 -0400
Received: from ms-smtp-02.nyroc.rr.com ([24.24.2.56]:21663 "EHLO
	ms-smtp-02.nyroc.rr.com") by vger.kernel.org with ESMTP
	id S932147AbWELQie (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 12 May 2006 12:38:34 -0400
Date: Fri, 12 May 2006 12:38:13 -0400 (EDT)
From: Steven Rostedt <rostedt@goodmis.org>
X-X-Sender: rostedt@gandalf.stny.rr.com
To: Andrew Morton <akpm@osdl.org>
cc: mingo@elte.hu, markh@compro.net, linux-kernel@vger.kernel.org,
       dwalker@mvista.com, tglx@linutronix.de
Subject: Re: 3c59x vortex_timer rt hack (was: rt20 patch question)
In-Reply-To: <20060512092709.5b9efab7.akpm@osdl.org>
Message-ID: <Pine.LNX.4.58.0605121227440.5658@gandalf.stny.rr.com>
References: <4460ADF8.4040301@compro.net> <4461E53B.7050905@compro.net>
 <Pine.LNX.4.58.0605100938100.4503@gandalf.stny.rr.com> <446207D6.2030602@compro.net>
 <Pine.LNX.4.58.0605101215220.19935@gandalf.stny.rr.com> <44623157.9090105@compro.net>
 <Pine.LNX.4.58.0605101556580.22959@gandalf.stny.rr.com> <20060512081628.GA26736@elte.hu>
 <Pine.LNX.4.58.0605120435570.28581@gandalf.stny.rr.com> <20060512092159.GC18145@elte.hu>
 <Pine.LNX.4.58.0605120904110.30264@gandalf.stny.rr.com>
 <20060512071645.6b59e0a2.akpm@osdl.org> <Pine.LNX.4.58.0605121029540.30264@gandalf.stny.rr.com>
 <Pine.LNX.4.58.0605121036150.30264@gandalf.stny.rr.com>
 <20060512074929.031d4eaf.akpm@osdl.org> <Pine.LNX.4.58.0605121110320.3328@gandalf.stny.rr.com>
 <20060512082340.3e169128.akpm@osdl.org> <Pine.LNX.4.58.0605121136060.4281@gandalf.stny.rr.com>
 <20060512090323.252d8600.akpm@osdl.org> <Pine.LNX.4.58.0605121208350.5357@gandalf.stny.rr.com>
 <20060512092709.5b9efab7.akpm@osdl.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Fri, 12 May 2006, Andrew Morton wrote:

> Steven Rostedt <rostedt@goodmis.org> wrote:
> >
> > On Fri, 12 May 2006, Andrew Morton wrote:
> >
> > > >
> > > > The vortex_timer is a timeout,
> > >
> > > err, it's actually a function.
> >
> > OK, I meant vp->timer
>
> That's a kernel timer.

:P

>
> > >
> > > > will it go off often?
> > >
> > > Every five seconds if the cable's unplugged.  Every 60 seconds otherwise.
> > >
> >
> > OK, so the function is a service and not a fixup (or both).  Hmm, so
> > latency is an issue.
>
> yup.  It's been five years, sorry - I'm struggling to remember why
> vortex_timer() needs to block the interrupt handler.
>
> The chip is fairly stateful - that EL3WINDOW() thing selects a particular
> register bank and needs protection against other register readers.  But we
> should avoid running EL3WINDOW() in the rx and tx interrupt handlers anyway
> - iirc the chip is designed to permit that.
>
> Is tricky.
>
> How come -rt cannot permit disable_irq() in there?

It's about having threaded interrupts soft and hard, and their
combinations.  disable_irq with threaded hardirqs can schedule, but we
still don't want a softirq to do so (when not threaded).

So it too is tricky.


>
> (I think the _reason_ it's disable_irq() is, yes, because it's infrequent
> and because it can hold off interrupts for a long time if we use
> spin_lock_irq())
>

Well, it seems that the spin_lock_irq for -rt is the answer for now, until
we sort out the dependencies of threaded interrupts.

Ingo,

Maybe it will be necessary to make hardirq threading dependent on softirq
threading.

Is it really that bad?  When would someone want Hardirq threading without
having softirq threading??

-- Steve

