Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262070AbSJQWd7>; Thu, 17 Oct 2002 18:33:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262223AbSJQWd7>; Thu, 17 Oct 2002 18:33:59 -0400
Received: from packet.digeo.com ([12.110.80.53]:5809 "EHLO packet.digeo.com")
	by vger.kernel.org with ESMTP id <S262070AbSJQWd6>;
	Thu, 17 Oct 2002 18:33:58 -0400
Message-ID: <3DAF3C36.2065CFD1@digeo.com>
Date: Thu, 17 Oct 2002 15:39:50 -0700
From: Andrew Morton <akpm@digeo.com>
X-Mailer: Mozilla 4.79 [en] (X11; U; Linux 2.4.19-pre4 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Thomas Molina <tmolina@cox.net>
CC: Steve Parker <steve.parker@netops.co.uk>, linux-kernel@vger.kernel.org
Subject: Re: 2.5.41 still not testable by end users
References: <3DAE2691.76F83D1B@digeo.com> <Pine.LNX.4.44.0210171717550.18123-100000@dad.molina>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 17 Oct 2002 22:39:50.0599 (UTC) FILETIME=[1A8FA570:01C2762E]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Thomas Molina wrote:
> 
> ...
> > > Oct 16 21:40:59 declan kernel:  [__might_sleep+84/96]
> > > ...
> > > Oct 16 21:41:00 declan kernel:  [init_irq+637/820] init_irq+0x27d/0x334
> > >
> >
> > One day.  Before we all die.  Please.
> 
> I had that as fixed in my problem list.  It should have been integrated by
> 2.5.42, certainly 2.5.43.  I'm not seeing any additional reports since
> then.

Oh.  We still have:

                if (request_irq(hwif->irq,&ide_intr,sa,hwif->name,hwgroup)) {
                        if (!match)
                                kfree(hwgroup);
                        spin_unlock_irqrestore(&ide_lock, flags);

request_irq() was changed to use GFP_ATOMIC, so it's "fixed".

But only for i386.

request_irq() inside spinlock is a *very* common bug.  Moreso
as people move cli()-using code across to use spinlocks.

And we've just lost our ability to detect this bug.

request_irq() needs to take the allocation mode as an argument.
Should always have.  Sigh.  I'll fix it up sometime.
