Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932135AbWELP0y@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932135AbWELP0y (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 12 May 2006 11:26:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932136AbWELP0y
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 12 May 2006 11:26:54 -0400
Received: from smtp.osdl.org ([65.172.181.4]:63413 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S932135AbWELP0x (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 12 May 2006 11:26:53 -0400
Date: Fri, 12 May 2006 08:23:40 -0700
From: Andrew Morton <akpm@osdl.org>
To: Steven Rostedt <rostedt@goodmis.org>
Cc: mingo@elte.hu, markh@compro.net, linux-kernel@vger.kernel.org,
       dwalker@mvista.com, tglx@linutronix.de
Subject: Re: 3c59x vortex_timer rt hack (was: rt20 patch question)
Message-Id: <20060512082340.3e169128.akpm@osdl.org>
In-Reply-To: <Pine.LNX.4.58.0605121110320.3328@gandalf.stny.rr.com>
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
X-Mailer: Sylpheed version 1.0.4 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Steven Rostedt <rostedt@goodmis.org> wrote:
>
> 
> On Fri, 12 May 2006, Andrew Morton wrote:
> 
> >
> > So yes, doing spin_lock_irq() (irqrestore isn't needed in a timer handler)
> > instead of disable_irq() in vortex_timer() looks OK.
> >
> > One does wonder how long we'll hold off interrupts though.
> 
> Any longer than this!
> 
> in boomerang_start_xmit()
> 
> 	spin_lock_irqsave(&vp->lock, flags);
> 
> 	/* Wait for the stall to complete. */
> 	issue_and_wait(dev, DownStall);
> 
>   Pretty big wait!
> 
>     [...]
> 
> 	spin_unlock_irqrestore(&vp->lock, flags);
> 
> 
> Where we have in issue_and_wait
> 
> static void
> issue_and_wait(struct net_device *dev, int cmd)
> {
> 
>  [...]
> 
> 	/* OK, that didn't work.  Do it the slow way.  One second */
> 	for (i = 0; i < 100000; i++) {
> 
>  [...]
> }
> 
> So this can have interrupts off for over a second!
> 

Well, only if the hardware's fratzed.  Normally this is quick.

otoh vortex_timer() will play with the MII interface, which is slooooow.
