Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261762AbTILQ2q (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 12 Sep 2003 12:28:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261763AbTILQ2q
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 12 Sep 2003 12:28:46 -0400
Received: from 81-2-122-30.bradfords.org.uk ([81.2.122.30]:3712 "EHLO
	81-2-122-30.bradfords.org.uk") by vger.kernel.org with ESMTP
	id S261762AbTILQ2k (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 12 Sep 2003 12:28:40 -0400
Date: Fri, 12 Sep 2003 17:41:47 +0100
From: John Bradford <john@grabjohn.com>
Message-Id: <200309121641.h8CGflK0000145@81-2-122-30.bradfords.org.uk>
To: anthony.truong@mascorp.com, linux-kernel@vger.kernel.org
Subject: Re: Memory mapped IO vs Port IO
Cc: jamie@shareable.org, willy@debian.org
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> > My claim is basically:
> > 
> > Change everybody who currently does
> > 
> > #ifdef CONFIG_MMIO
> >         writel(... )
> >         readl(...)
> > #else
> >         outl( ... ) 
> >         inl ( ...) 
> > #endif
> > 
> > to 
> >         if (dev->mmio) { 
> >                 writel(); 
> >                 real();
> >         } else { 
> >                 outl();
> >                 inl();
> >         } 
> > 
> > and you will have a hard time to benchmark the difference on any non
> > ancient system
> > in actual driver operation.

Or an embedded system, maybe?

At the end of the day, it still means loosing a tiny amount of
performance just to make it easier for distributions to have one
generic kernel.  There is nothing wrong with that, but why force it on
systems that are not running a generic kernel?

What's wrong with:

#ifdef CONFIG_MMIO
	writel(... );
        readl(... );
#endif
#ifdef CONFIG_NO_MMIO
	outl(... );
	inl(...);
#endif
#ifdef CONFIG_DONT_CARE_MMIO
	if (dev->mmio) {	
		writel(... );
		readl(... );
	} else {
		outl(... );
		inl(... );
	}
#endif

Although I'm dubious of having a global switch for MMIO anyway.

> Wouldn't it be better if we set the IN and OUT function pointers to the
> right functions during driver init. based on the setting of dev->mmio.
> And throughout the driver, we just call the IN and OUT functions by
> their pointers.  Then we don't have to do if (dev->mmio) every time.
> It's similar to the concept of virtual member function in C++.

It's neater, but still means bloat, however small.

I know we're talking a few bytes here and there, but embedded systems
really care about them.

John.
