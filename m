Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131324AbQKIVon>; Thu, 9 Nov 2000 16:44:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131262AbQKIVoe>; Thu, 9 Nov 2000 16:44:34 -0500
Received: from front3m.grolier.fr ([195.36.216.53]:39637 "EHLO
	front3m.grolier.fr") by vger.kernel.org with ESMTP
	id <S131154AbQKIVoT> convert rfc822-to-8bit; Thu, 9 Nov 2000 16:44:19 -0500
Date: Thu, 9 Nov 2000 21:37:41 +0100 (CET)
From: Gérard Roudier <groudier@club-internet.fr>
To: Ivan Kokshaysky <ink@jurassic.park.msu.ru>
cc: Richard Henderson <rth@twiddle.net>, axp-list@redhat.com,
        linux-kernel@vger.kernel.org
Subject: Re: PCI-PCI bridges mess in 2.4.x
In-Reply-To: <20001109173920.A3205@jurassic.park.msu.ru>
Message-ID: <Pine.LNX.4.10.10011092123320.1438-100000@linux.local>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=ISO-8859-1
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Thu, 9 Nov 2000, Ivan Kokshaysky wrote:

Hmmm...
The PCI spec. says that Limit registers define the top addresses
_inclusive_.

The spec. does not seem to imagine that a Limit register lower than the
corresponding Base register will ever exist anywhere, in my opinion. :-)

This let me think that trying to be clever here is probably a very bad
idea. What is so catastrophic of having 1 to 4 bytes of addresses and no
more being possibly in a forwardable range?

  Gérard.


> On Wed, Nov 08, 2000 at 03:48:11PM -0800, Richard Henderson wrote:
> > Whee!  We're back in Bootsville.
> 
> Cool!
> Meanwhile this base/limit stuff got confirmation :-)
> Here is a patch against bridges-2.4.0t11-rth.
> 
> Ivan.
> 
> --- 2.4.0t11p1/drivers/pci/setup-bus.c	Wed Nov  8 19:44:42 2000
> +++ linux/drivers/pci/setup-bus.c	Thu Nov  9 15:11:01 2000
> @@ -88,14 +88,14 @@ pbus_assign_resources_sorted(struct pci_
>  	ranges->io_end += io_reserved;
>  	ranges->mem_end += mem_reserved;
>  
> -	/* ??? How to turn off a bus from responding to, say, I/O at
> -	   all if there are no I/O ports behind the bus?  Turning off
> -	   PCI_COMMAND_IO doesn't seem to do the job.  So we must
> -	   allow for at least one unit.  */
> -	if (ranges->io_end == ranges->io_start)
> -		ranges->io_end += 1;
> -	if (ranges->mem_end == ranges->mem_start)
> -		ranges->mem_end += 1;
> +	/* Interesting case is when, say, io_end == io_start, i.e.
> +	   there is no I/O behind the bridge at all. We initialize
> +	   the bridge with base=io_start and limit=io_end-1, so
> +	   in this case we'll have base > limit. According to
> +	   the `PCI-to-PCI Bridge Architecture Specification', this
> +	   means that the bridge will not forward any I/O transactions
> +	   from the primary bus to the secondary bus and will forward
> +	   all I/O transactions upstream. Exactly what we want.  */
>  
>  	ranges->io_end = ROUND_UP(ranges->io_end, 4*1024);
>  	ranges->mem_end = ROUND_UP(ranges->mem_end, 1024*1024);
> 
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> Please read the FAQ at http://www.tux.org/lkml/
> 

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
