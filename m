Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932102AbWELOkB@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932102AbWELOkB (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 12 May 2006 10:40:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932104AbWELOkA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 12 May 2006 10:40:00 -0400
Received: from ms-smtp-02.nyroc.rr.com ([24.24.2.56]:30423 "EHLO
	ms-smtp-02.nyroc.rr.com") by vger.kernel.org with ESMTP
	id S932102AbWELOkA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 12 May 2006 10:40:00 -0400
Date: Fri, 12 May 2006 10:39:50 -0400 (EDT)
From: Steven Rostedt <rostedt@goodmis.org>
X-X-Sender: rostedt@gandalf.stny.rr.com
To: Andrew Morton <akpm@osdl.org>
cc: Ingo Molnar <mingo@elte.hu>, markh@compro.net,
       LKML <linux-kernel@vger.kernel.org>, dwalker@mvista.com,
       Thomas Gleixner <tglx@linutronix.de>
Subject: Re: 3c59x vortex_timer rt hack (was: rt20 patch question)
In-Reply-To: <Pine.LNX.4.58.0605121029540.30264@gandalf.stny.rr.com>
Message-ID: <Pine.LNX.4.58.0605121036150.30264@gandalf.stny.rr.com>
References: <4460ADF8.4040301@compro.net> <Pine.LNX.4.58.0605100827500.3282@gandalf.stny.rr.com>
 <4461E53B.7050905@compro.net> <Pine.LNX.4.58.0605100938100.4503@gandalf.stny.rr.com>
 <446207D6.2030602@compro.net> <Pine.LNX.4.58.0605101215220.19935@gandalf.stny.rr.com>
 <44623157.9090105@compro.net> <Pine.LNX.4.58.0605101556580.22959@gandalf.stny.rr.com>
 <20060512081628.GA26736@elte.hu> <Pine.LNX.4.58.0605120435570.28581@gandalf.stny.rr.com>
 <20060512092159.GC18145@elte.hu> <Pine.LNX.4.58.0605120904110.30264@gandalf.stny.rr.com>
 <20060512071645.6b59e0a2.akpm@osdl.org> <Pine.LNX.4.58.0605121029540.30264@gandalf.stny.rr.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



Argh, cut and paste wasn't enough...

Use this patch instead.  It needs an irq disable.  But, believe it or not,
on SMP this is actually better.  If the irq is shared (as it is in Mark's
case), we don't stop the irq of other devices from being handled on
another CPU (unfortunately for Mark, he pinned all interrupts to one CPU).

Andrew,

should this be changed in mainline too?

-- Steve

Signed-off-by: Steven Rostedt <rostedt@goodmis.org>


Index: linux-2.6.16-rt20/drivers/net/3c59x.c
===================================================================
--- linux-2.6.16-rt20.orig/drivers/net/3c59x.c	2006-05-12 10:27:36.000000000 -0400
+++ linux-2.6.16-rt20/drivers/net/3c59x.c	2006-05-12 10:34:51.000000000 -0400
@@ -1888,6 +1888,7 @@ vortex_timer(unsigned long data)
 	int next_tick = 60*HZ;
 	int ok = 0;
 	int media_status, mii_status, old_window;
+	unsigned long flags;

 	if (vortex_debug > 2) {
 		printk(KERN_DEBUG "%s: Media selection timer tick happened, %s.\n",
@@ -1897,7 +1898,7 @@ vortex_timer(unsigned long data)

 	if (vp->medialock)
 		goto leave_media_alone;
-	disable_irq(dev->irq);
+	spin_lock_irqsave(&vp->lock, flags);
 	old_window = ioread16(ioaddr + EL3_CMD) >> 13;
 	EL3WINDOW(4);
 	media_status = ioread16(ioaddr + Wn4_Media);
@@ -1919,7 +1920,6 @@ vortex_timer(unsigned long data)
 		break;
 	case XCVR_MII: case XCVR_NWAY:
 		{
-			spin_lock_bh(&vp->lock);
 			mii_status = mdio_read(dev, vp->phys[0], MII_BMSR);
 			if (!(mii_status & BMSR_LSTATUS)) {
 				/* Re-read to get actual link status */
@@ -1957,7 +1957,6 @@ vortex_timer(unsigned long data)
 			} else {
 				netif_carrier_off(dev);
 			}
-			spin_unlock_bh(&vp->lock);
 		}
 		break;
 	  default:					/* Other media types handled by Tx timeouts. */
@@ -2000,7 +1999,7 @@ vortex_timer(unsigned long data)
 		/* AKPM: FIXME: Should reset Rx & Tx here.  P60 of 3c90xc.pdf */
 	}
 	EL3WINDOW(old_window);
-	enable_irq(dev->irq);
+	spin_unlock_irqrestore(&vp->lock, flags);

 leave_media_alone:
 	if (vortex_debug > 2)
