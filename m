Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932095AbWELOcQ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932095AbWELOcQ (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 12 May 2006 10:32:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932096AbWELOcQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 12 May 2006 10:32:16 -0400
Received: from ms-smtp-01.nyroc.rr.com ([24.24.2.55]:35550 "EHLO
	ms-smtp-01.nyroc.rr.com") by vger.kernel.org with ESMTP
	id S932095AbWELOcP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 12 May 2006 10:32:15 -0400
Date: Fri, 12 May 2006 10:32:00 -0400 (EDT)
From: Steven Rostedt <rostedt@goodmis.org>
X-X-Sender: rostedt@gandalf.stny.rr.com
To: Andrew Morton <akpm@osdl.org>
cc: mingo@elte.hu, markh@compro.net, linux-kernel@vger.kernel.org,
       dwalker@mvista.com, tglx@linutronix.de
Subject: Re: 3c59x vortex_timer rt hack (was: rt20 patch question)
In-Reply-To: <20060512071645.6b59e0a2.akpm@osdl.org>
Message-ID: <Pine.LNX.4.58.0605121029540.30264@gandalf.stny.rr.com>
References: <4460ADF8.4040301@compro.net> <Pine.LNX.4.58.0605100827500.3282@gandalf.stny.rr.com>
 <4461E53B.7050905@compro.net> <Pine.LNX.4.58.0605100938100.4503@gandalf.stny.rr.com>
 <446207D6.2030602@compro.net> <Pine.LNX.4.58.0605101215220.19935@gandalf.stny.rr.com>
 <44623157.9090105@compro.net> <Pine.LNX.4.58.0605101556580.22959@gandalf.stny.rr.com>
 <20060512081628.GA26736@elte.hu> <Pine.LNX.4.58.0605120435570.28581@gandalf.stny.rr.com>
 <20060512092159.GC18145@elte.hu> <Pine.LNX.4.58.0605120904110.30264@gandalf.stny.rr.com>
 <20060512071645.6b59e0a2.akpm@osdl.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Fri, 12 May 2006, Andrew Morton wrote:

> >
> > Andrew,
> >
> > Do you know off hand what the side-effects to the vortex card might be
> > if we use disable_irq_nosync instead of disable_irq?
> >
>
> ooh, ow, sorry, that's lost in the mists of time.  I don't know why we're
> doing disable_irq() in there.
>
> Whatever it does, I think you could take vp->lock instead - that'll stop
> the interrupt handler from doing anything if it does get entered while this
> CPU is running vortex_timer().
>

Thanks Andrew, I was thinking about using that lock too.

Mark, could you try this instead of the hack, and see if it works.

Thanks,

-- Steve

Signed-off-by: Steven Rostedt <rostedt@goodmis.org>

Index: linux-2.6.16-rt20/drivers/net/3c59x.c
===================================================================
--- linux-2.6.16-rt20.orig/drivers/net/3c59x.c	2006-05-12 10:27:36.000000000 -0400
+++ linux-2.6.16-rt20/drivers/net/3c59x.c	2006-05-12 10:28:22.000000000 -0400
@@ -1897,7 +1897,7 @@ vortex_timer(unsigned long data)

 	if (vp->medialock)
 		goto leave_media_alone;
-	disable_irq(dev->irq);
+	spin_lock_bh(&vp->lock);
 	old_window = ioread16(ioaddr + EL3_CMD) >> 13;
 	EL3WINDOW(4);
 	media_status = ioread16(ioaddr + Wn4_Media);
@@ -1919,7 +1919,6 @@ vortex_timer(unsigned long data)
 		break;
 	case XCVR_MII: case XCVR_NWAY:
 		{
-			spin_lock_bh(&vp->lock);
 			mii_status = mdio_read(dev, vp->phys[0], MII_BMSR);
 			if (!(mii_status & BMSR_LSTATUS)) {
 				/* Re-read to get actual link status */
@@ -1957,7 +1956,6 @@ vortex_timer(unsigned long data)
 			} else {
 				netif_carrier_off(dev);
 			}
-			spin_unlock_bh(&vp->lock);
 		}
 		break;
 	  default:					/* Other media types handled by Tx timeouts. */
@@ -2000,7 +1998,7 @@ vortex_timer(unsigned long data)
 		/* AKPM: FIXME: Should reset Rx & Tx here.  P60 of 3c90xc.pdf */
 	}
 	EL3WINDOW(old_window);
-	enable_irq(dev->irq);
+	spin_unlock_bh(&vp->lock);

 leave_media_alone:
 	if (vortex_debug > 2)
