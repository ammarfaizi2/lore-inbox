Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261309AbSJUKex>; Mon, 21 Oct 2002 06:34:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261310AbSJUKex>; Mon, 21 Oct 2002 06:34:53 -0400
Received: from pc1-cwma1-5-cust42.swa.cable.ntl.com ([80.5.120.42]:31667 "EHLO
	irongate.swansea.linux.org.uk") by vger.kernel.org with ESMTP
	id <S261309AbSJUKew>; Mon, 21 Oct 2002 06:34:52 -0400
Subject: Re: 2.5.41 still not testable by end users
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Andrew Morton <akpm@digeo.com>
Cc: Thomas Molina <tmolina@cox.net>, Steve Parker <steve.parker@netops.co.uk>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <3DAF3C36.2065CFD1@digeo.com>
References: <3DAE2691.76F83D1B@digeo.com>
	<Pine.LNX.4.44.0210171717550.18123-100000@dad.molina> 
	<3DAF3C36.2065CFD1@digeo.com>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.8 (1.0.8-10) 
Date: 21 Oct 2002 11:56:32 +0100
Message-Id: <1035197792.27309.28.camel@irongate.swansea.linux.org.uk>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2002-10-17 at 23:39, Andrew Morton wrote:
> request_irq() was changed to use GFP_ATOMIC, so it's "fixed".
> 
> But only for i386.
> 
> request_irq() inside spinlock is a *very* common bug.  Moreso
> as people move cli()-using code across to use spinlocks.
> 
> And we've just lost our ability to detect this bug.
> 
> request_irq() needs to take the allocation mode as an argument.
> Should always have.  Sigh.  I'll fix it up sometime.

Many of the people who use request_irq out of spinlocks are actually the
buggy ones, especially in the PCI world. Im not sure passing the
argument is the real fix. I'd like to be able to write code that was
more of the form

		irqptr = allocate_irq(irqnum, flags, handler, &err);

		install_irq(irqptr);

That would clean up vast amounts of locking, if I can allocate, check I
can obtain and handle all the setup -before- I turn the IRQ one.
enable/disable_irq doesnt really cut it for granularity and has the same
can't sleep issue

