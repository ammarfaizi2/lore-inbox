Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932093AbWELOUH@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932093AbWELOUH (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 12 May 2006 10:20:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932092AbWELOUH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 12 May 2006 10:20:07 -0400
Received: from smtp.osdl.org ([65.172.181.4]:38305 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S932090AbWELOUF (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 12 May 2006 10:20:05 -0400
Date: Fri, 12 May 2006 07:16:45 -0700
From: Andrew Morton <akpm@osdl.org>
To: Steven Rostedt <rostedt@goodmis.org>
Cc: mingo@elte.hu, markh@compro.net, linux-kernel@vger.kernel.org,
       dwalker@mvista.com, tglx@linutronix.de
Subject: Re: 3c59x vortex_timer rt hack (was: rt20 patch question)
Message-Id: <20060512071645.6b59e0a2.akpm@osdl.org>
In-Reply-To: <Pine.LNX.4.58.0605120904110.30264@gandalf.stny.rr.com>
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
X-Mailer: Sylpheed version 1.0.4 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Steven Rostedt <rostedt@goodmis.org> wrote:
>
> 
> 
> On Fri, 12 May 2006, Ingo Molnar wrote:
> 
> > --- linux-rt.q.orig/drivers/net/3c59x.c
> > +++ linux-rt.q/drivers/net/3c59x.c
> > @@ -1897,7 +1897,8 @@ vortex_timer(unsigned long data)
> >
> >  	if (vp->medialock)
> >  		goto leave_media_alone;
> > -	disable_irq(dev->irq);
> > +	/* hack! */
> > +	disable_irq_nosync(dev->irq);
> >  	old_window = ioread16(ioaddr + EL3_CMD) >> 13;
> >  	EL3WINDOW(4);
> >  	media_status = ioread16(ioaddr + Wn4_Media);
> 
> BTW, I originally thought about having Mark do this, but I'm nervious
> about the side effects that this might have.  Basically, it's doing
> ioreads from the device while the interrupt could be doing iowrites.
> 
> I don't know the device well enough to know if this is a problem.
> I've added Andrew Morton to the CC list, since his name is all over the
> code.
> 
> Andrew,
> 
> Do you know off hand what the side-effects to the vortex card might be
> if we use disable_irq_nosync instead of disable_irq?
> 

ooh, ow, sorry, that's lost in the mists of time.  I don't know why we're
doing disable_irq() in there.

Whatever it does, I think you could take vp->lock instead - that'll stop
the interrupt handler from doing anything if it does get entered while this
CPU is running vortex_timer().

