Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S313524AbSC3S3u>; Sat, 30 Mar 2002 13:29:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S313529AbSC3S3k>; Sat, 30 Mar 2002 13:29:40 -0500
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:51462 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id <S313524AbSC3S32>;
	Sat, 30 Mar 2002 13:29:28 -0500
Message-ID: <3CA603B0.8B73FD4C@zip.com.au>
Date: Sat, 30 Mar 2002 10:28:00 -0800
From: Andrew Morton <akpm@zip.com.au>
X-Mailer: Mozilla 4.79 [en] (X11; U; Linux 2.4.19-pre5 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Manfred Spraul <manfred@colorfullife.com>
CC: linux-kernel@vger.kernel.org, Marcelo Tosatti <marcelo@conectiva.com.br>
Subject: Re: [patch] block/IDE/interrupt lockup
In-Reply-To: <001d01c1d7ce$34f830c0$010411ac@local>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Manfred Spraul wrote:
> 
> > -     spin_unlock_irq(&io_request_lock);
> > +     spin_unlock_irqrestore(&io_request_lock, flags);
> >       rq = kmem_cache_alloc(request_cachep, SLAB_KERNEL);
> 
> Great patch.
> kmem_cache_alloc with SLAB_KERNEL can sleep, i.e. you've just converted
> an obvious bug into a rare, difficult to find bug. What about trying to
> fix it?

Gimme a break, Manfred.  The patch fixes the new bug. Which was
hardly obvious.  The longstanding (as in years-old) bug was
pointed out to the maintainer.  

It may not even be a bug.  Certainly I don't think it's
worth my time to fiddle with it.  But you're at liberty to.

> I agree that this won't happen during boot, but what about a hotplug PCI
> ide controller?

The kernel calls request_irq() inside cli() in lots of places.
That's the same bug: "if you called cli(), how come you're
allowing kmalloc to clear it?".

In 2.4, this is a design wart.  In 2.5, it will go BUG() if
the page allocator performs I/O.

-
