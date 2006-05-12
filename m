Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751306AbWELQZH@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751306AbWELQZH (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 12 May 2006 12:25:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751307AbWELQZG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 12 May 2006 12:25:06 -0400
Received: from smtp.osdl.org ([65.172.181.4]:44487 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1751306AbWELQZB (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 12 May 2006 12:25:01 -0400
Date: Fri, 12 May 2006 09:27:09 -0700
From: Andrew Morton <akpm@osdl.org>
To: Steven Rostedt <rostedt@goodmis.org>
Cc: mingo@elte.hu, markh@compro.net, linux-kernel@vger.kernel.org,
       dwalker@mvista.com, tglx@linutronix.de
Subject: Re: 3c59x vortex_timer rt hack (was: rt20 patch question)
Message-Id: <20060512092709.5b9efab7.akpm@osdl.org>
In-Reply-To: <Pine.LNX.4.58.0605121208350.5357@gandalf.stny.rr.com>
References: <4460ADF8.4040301@compro.net>
	<Pine.LNX.4.58.0605100827500.3282@gandalf.stny.rr.com>
	<4461E53B.7050905@compro.net>
	<Pine.LNX.4.58.0605100938100.4503@gandalf.stny.rr.com>
	<446207D6.2030602@compro.net>
	<Pine.LNX.4.58.0605101215220.19935@gandalf.stny.rr.com>
	<44623157.9090105@compro.net>
	<Pine.LNX.4.58.0605101556580.22959@gandalf.stny.rr.com>
	<20060512081628.GA26736@elte.hu>
	<Pine.LNX.4.58.0605120435570.28581@gandalf.stny.rr.com>
	<20060512092159.GC18145@elte.hu>
	<Pine.LNX.4.58.0605120904110.30264@gandalf.stny.rr.com>
	<20060512071645.6b59e0a2.akpm@osdl.org>
	<Pine.LNX.4.58.0605121029540.30264@gandalf.stny.rr.com>
	<Pine.LNX.4.58.0605121036150.30264@gandalf.stny.rr.com>
	<20060512074929.031d4eaf.akpm@osdl.org>
	<Pine.LNX.4.58.0605121110320.3328@gandalf.stny.rr.com>
	<20060512082340.3e169128.akpm@osdl.org>
	<Pine.LNX.4.58.0605121136060.4281@gandalf.stny.rr.com>
	<20060512090323.252d8600.akpm@osdl.org>
	<Pine.LNX.4.58.0605121208350.5357@gandalf.stny.rr.com>
X-Mailer: Sylpheed version 1.0.0 (GTK+ 1.2.10; i386-vine-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Steven Rostedt <rostedt@goodmis.org> wrote:
>
> 
> 
> On Fri, 12 May 2006, Andrew Morton wrote:
> 
> > >
> > > The vortex_timer is a timeout,
> >
> > err, it's actually a function.
> 
> OK, I meant vp->timer

That's a kernel timer.

> >
> > > will it go off often?
> >
> > Every five seconds if the cable's unplugged.  Every 60 seconds otherwise.
> >
> 
> OK, so the function is a service and not a fixup (or both).  Hmm, so
> latency is an issue.

yup.  It's been five years, sorry - I'm struggling to remember why
vortex_timer() needs to block the interrupt handler.

The chip is fairly stateful - that EL3WINDOW() thing selects a particular
register bank and needs protection against other register readers.  But we
should avoid running EL3WINDOW() in the rx and tx interrupt handlers anyway
- iirc the chip is designed to permit that.

Is tricky.

How come -rt cannot permit disable_irq() in there?

(I think the _reason_ it's disable_irq() is, yes, because it's infrequent
and because it can hold off interrupts for a long time if we use
spin_lock_irq())
