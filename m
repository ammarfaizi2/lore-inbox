Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261628AbUC0CLh (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 26 Mar 2004 21:11:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261651AbUC0CLf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 26 Mar 2004 21:11:35 -0500
Received: from 1-1-1-9a.ghn.gbg.bostream.se ([82.182.69.4]:41156 "EHLO
	scream.fjortis.info") by vger.kernel.org with ESMTP id S261635AbUC0CLT
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 26 Mar 2004 21:11:19 -0500
Date: Sat, 27 Mar 2004 03:13:05 +0100
From: Andreas Henriksson <andreas@fjortis.info>
To: Jeff Garzik <jgarzik@pobox.com>
Cc: Andreas Henriksson <andreas@fjortis.info>,
       Denis Vlasenko <vda@port.imtp.ilyichevsk.odessa.ua>, netdev@oss.sgi.com,
       Marcelo Tosatti <marcelo@conectiva.com.br>,
       Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] Re: fealnx oopses
Message-ID: <20040327021305.GA20101@scream.fjortis.info>
References: <200403261214.58127.vda@port.imtp.ilyichevsk.odessa.ua> <20040326192211.GA15319@scream.fjortis.info> <4064857E.2050603@pobox.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4064857E.2050603@pobox.com>
User-Agent: Mutt/1.5.5.1+cvs20040105i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Fri, Mar 26, 2004 at 02:33:18PM -0500, Jeff Garzik wrote:
> Andreas Henriksson wrote:
> >On Fri, Mar 26, 2004 at 12:14:57PM +0200, Denis Vlasenko wrote:
> >
> ><snip>
> >
> >>BTW, my box is indeed slow and low on RAM, this fits.
> >>
> >
> >
> >I have only been looking at problems with races between the interrupt
> >handler and the rest of the driver code.. there might be a bunch of
> >problems with failed memory allocations that hasn't bitten me.
> >
> >
> >>Regarding your patch: I looked in start_tx(). Apart from latent
> >>bug in commented out part of code:
> >>	next = (struct fealnx *) np->cur_tx_copy.next_desc_logical;
> >>which must be
> >>	next = (struct fealnx_desc *) np->cur_tx_copy->next_desc_logical;
> >>I can't see anything racy there. The function just submits more
> >>tx buffers for the card, it never touch cur_tx or cur_tx->skbuff...
> >
> >
> >Francois Romieu explains the race in a comment to the bug I opened in
> >the bugzilla.
> >
> >http://bugzilla.kernel.org/show_bug.cgi?id=1902#c1
> >
> >The problem is that really_tx_count and similar parts of the private
> >structure isn't atomically updated and both the interrupt handler and
> >the start_tx function updates them.
> >(they are regular integers instead of atomic_t)
> >
> >
> >>If I miss something and it indeed races with interrupt, you
> >>definitely need to add
> >>       spin_lock(&np->lock);
> >>...
> >>       spin_unlock(&np->lock);
> >>around interrupt handler body or at least around tx part
> >>of it, or else your patch is incomplete (race will still
> >>be possible on SMP).
> >>
> >
> >
> >I came to the conclusion that there should be a spinlock in the
> >interrupt handler yesterday, but it won't effect me at all since I don't
> >have SMP (nor preempt) so I'll leave it for now anyway.
> >
> >
> >>Anyway, I applied your patch and flooded with UDP again.
> >>My box did not oops. Unfortunately, it did not oops when
> >>I reverted back to old, presumably buggy driver. I cannot
> >>reproduce it anymore with old driver too! Bad. :(
> >
> >
> >I haven't been able to reproduce a kernel panic with my patch eighter.
> >And I've been transfering Terabytes of traffic during the last weeks (or
> >maybee it's months, well anyway.. I've done enough testing to say that
> >the card works "good enough" in this machine atleast).
> >And I've even tried your udp test..
> >
> >Although I now have the myson/fealnx card in my p3-900 (256Mb)
> >workstation instead of the old p-166 (40Mb) which served as a gateway 
> >before.
> >It might just be that it's harder to trigger on newer/bigger machines.
> >Maybee I should power up my p-166 again.. I actually have 2 of these
> >cards so I can have one in each machine.. :)
> 
> Well really, somebody needs to port Donald Becker's myson driver to 2.6 
> APIs...  I would like to get rid of fealnx, or somebody needs to spend a 
> decent amount of time fixing it.
> 

Ok, didn't know someone actually had a better driver.. I though "fix up
the current to not panic and wait for people to forget that the hardware
ever existed" was the proper "fix". ;)

Although I doubt I'm able to even get donalds driver to even compile
without the middle layer... I'm not anywhere near a kernel developer.
But I'd certainly love to try to get it working.. but don't hold your
breath. :)

>
> Does the attached patch fix the issue?
> 

Probably... it includes the lock I've added... though it could take me
up to 3 weeks to get a kernel panic on my p-166 (although it could
happen twice a day as well as it did when I wrote the bugreport in the bugzilla).

> 	Jeff
> 
> 

I'll try your patch and if you don't hear from me it works "good
enough". Anyway... adding a lock or two will probably not make the
situation worse then it is today..

> ===== drivers/net/fealnx.c 1.34 vs edited =====
> --- 1.34/drivers/net/fealnx.c	Sun Mar 14 01:54:58 2004
> +++ edited/drivers/net/fealnx.c	Fri Mar 26 14:31:07 2004
> @@ -1303,14 +1303,15 @@
>  	/* for the last tx descriptor */
>  	np->tx_ring[i - 1].next_desc = np->tx_ring_dma;
>  	np->tx_ring[i - 1].next_desc_logical = &np->tx_ring[0];
> -
> -	return;
>  }
>  
>  
>  static int start_tx(struct sk_buff *skb, struct net_device *dev)
>  {
>  	struct netdev_private *np = dev->priv;
> +	unsigned long flags;
> +
> +	spin_lock_irqsave(&np->lock, flags);
>  
>  	np->cur_tx_copy->skbuff = skb;
>  
> @@ -1377,6 +1378,7 @@
>  	writel(0, dev->base_addr + TXPDR);
>  	dev->trans_start = jiffies;
>  
> +	spin_unlock_irqrestore(&np->lock, flags);
>  	return 0;
>  }
>  
> @@ -1423,6 +1425,8 @@
>  	unsigned int num_tx = 0;
>  	int handled = 0;
>  
> +	spin_lock(&np->lock);
> +
>  	writel(0, dev->base_addr + IMR);
>  
>  	ioaddr = dev->base_addr;
> @@ -1564,6 +1568,8 @@
>  		       dev->name, readl(ioaddr + ISR));
>  
>  	writel(np->imrvalue, ioaddr + IMR);
> +
> +	spin_unlock(&np->lock);
>  
>  	return IRQ_RETVAL(handled);
>  }

