Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750726AbWELQxj@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750726AbWELQxj (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 12 May 2006 12:53:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750721AbWELQxj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 12 May 2006 12:53:39 -0400
Received: from 216-54-166-5.static.twtelecom.net ([216.54.166.5]:2438 "EHLO
	mx1.compro.net") by vger.kernel.org with ESMTP id S1750736AbWELQxi
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 12 May 2006 12:53:38 -0400
Message-ID: <4464BD8B.8060503@compro.net>
Date: Fri, 12 May 2006 12:53:31 -0400
From: Mark Hounschell <markh@compro.net>
Reply-To: markh@compro.net
Organization: Compro Computer Svcs.
User-Agent: Thunderbird 1.5 (X11/20060111)
MIME-Version: 1.0
To: Steven Rostedt <rostedt@goodmis.org>
Cc: Andrew Morton <akpm@osdl.org>, mingo@elte.hu, linux-kernel@vger.kernel.org,
       dwalker@mvista.com, tglx@linutronix.de
Subject: Re: 3c59x vortex_timer rt hack
References: <4460ADF8.4040301@compro.net> <Pine.LNX.4.58.0605100827500.3282@gandalf.stny.rr.com> <4461E53B.7050905@compro.net> <Pine.LNX.4.58.0605100938100.4503@gandalf.stny.rr.com> <446207D6.2030602@compro.net> <Pine.LNX.4.58.0605101215220.19935@gandalf.stny.rr.com> <44623157.9090105@compro.net> <Pine.LNX.4.58.0605101556580.22959@gandalf.stny.rr.com> <20060512081628.GA26736@elte.hu> <Pine.LNX.4.58.0605120435570.28581@gandalf.stny.rr.com> <20060512092159.GC18145@elte.hu> <Pine.LNX.4.58.0605120904110.30264@gandalf.stny.rr.com> <20060512071645.6b59e0a2.akpm@osdl.org> <Pine.LNX.4.58.0605121029540.30264@gandalf.stny.rr.com> <Pine.LNX.4.58.0605121036150.30264@gandalf.stny.rr.com> <20060512074929.031d4eaf.akpm@osdl.org> <Pine.LNX.4.58.0605121100080.3328@gandalf.stny.rr.com>
In-Reply-To: <Pine.LNX.4.58.0605121100080.3328@gandalf.stny.rr.com>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Steven Rostedt wrote:
> On Fri, 12 May 2006, Andrew Morton wrote:
> 
>> Steven Rostedt <rostedt@goodmis.org> wrote:
>>>  Use this patch instead.  It needs an irq disable.  But, believe it or not,
>>>  on SMP this is actually better.  If the irq is shared (as it is in Mark's
>>>  case), we don't stop the irq of other devices from being handled on
>>>  another CPU (unfortunately for Mark, he pinned all interrupts to one CPU).
>>>
>>>  Andrew,
>>>
>>>  should this be changed in mainline too?
>> I suppose so - we're taking the lock with spin_lock_bh(), but it can also
>> be taken by this CPU from the interrupt, so it'll deadlock.  But lo!  We've
>> done disable_irq(), so the interrupt won't be happening.
>>
>> So yes, doing spin_lock_irq() (irqrestore isn't needed in a timer handler)
>> instead of disable_irq() in vortex_timer() looks OK.
> 
> Ah, you're right, it's an over kill.
> 
> Ingo, here's the patch without irqsave
> 
> -- Steve
> 
> Index: linux-2.6.16-rt20/drivers/net/3c59x.c
> ===================================================================
> --- linux-2.6.16-rt20.orig/drivers/net/3c59x.c	2006-05-12 10:27:36.000000000 -0400
> +++ linux-2.6.16-rt20/drivers/net/3c59x.c	2006-05-12 11:03:39.000000000 -0400
> @@ -1897,7 +1897,7 @@ vortex_timer(unsigned long data)
> 
>  	if (vp->medialock)
>  		goto leave_media_alone;
> -	disable_irq(dev->irq);
> +	spin_lock_irq(&vp->lock);
>  	old_window = ioread16(ioaddr + EL3_CMD) >> 13;
>  	EL3WINDOW(4);
>  	media_status = ioread16(ioaddr + Wn4_Media);
> @@ -1919,7 +1919,6 @@ vortex_timer(unsigned long data)
>  		break;
>  	case XCVR_MII: case XCVR_NWAY:
>  		{
> -			spin_lock_bh(&vp->lock);
>  			mii_status = mdio_read(dev, vp->phys[0], MII_BMSR);
>  			if (!(mii_status & BMSR_LSTATUS)) {
>  				/* Re-read to get actual link status */
> @@ -1957,7 +1956,6 @@ vortex_timer(unsigned long data)
>  			} else {
>  				netif_carrier_off(dev);
>  			}
> -			spin_unlock_bh(&vp->lock);
>  		}
>  		break;
>  	  default:					/* Other media types handled by Tx timeouts. */
> @@ -2000,7 +1998,7 @@ vortex_timer(unsigned long data)
>  		/* AKPM: FIXME: Should reset Rx & Tx here.  P60 of 3c90xc.pdf */
>  	}
>  	EL3WINDOW(old_window);
> -	enable_irq(dev->irq);
> +	spin_unlock_irq(&vp->lock);
> 
>  leave_media_alone:
>  	if (vortex_debug > 2)
> 

I have tried this one and it seems OK. No BUGs or disconnections for
over an hour now and I'm beating it good.

Mark
