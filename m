Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S270711AbTGUUqi (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 21 Jul 2003 16:46:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S270713AbTGUUqi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 21 Jul 2003 16:46:38 -0400
Received: from dclient217-162-108-200.hispeed.ch ([217.162.108.200]:38149 "EHLO
	ritz.dnsalias.org") by vger.kernel.org with ESMTP id S270688AbTGUUpu
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 21 Jul 2003 16:45:50 -0400
From: Daniel Ritz <daniel.ritz@gmx.ch>
To: Javier Achirica <achirica@telefonica.net>
Subject: Re: [PATCH 2.5] fixes for airo.c
Date: Mon, 21 Jul 2003 23:01:39 +0200
User-Agent: KMail/1.5.2
Cc: Jeff Garzik <jgarzik@pobox.com>,
       linux-kernel <linux-kernel@vger.kernel.org>,
       linux-net <linux-net@vger.kernel.org>,
       Jean Tourrilhes <jt@bougret.hpl.hp.com>,
       Mike Kershaw <dragorn@melchior.nerv-un.net>
References: <Pine.SOL.4.30.0307212056370.29431-100000@tudela.mad.ttd.net>
In-Reply-To: <Pine.SOL.4.30.0307212056370.29431-100000@tudela.mad.ttd.net>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200307212301.39264.daniel.ritz@gmx.ch>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon July 21 2003 21:44, Javier Achirica wrote:
> 
> On Mon, 21 Jul 2003, Daniel Ritz wrote:
> 
> > On Mon July 21 2003 13:00, Javier Achirica wrote:
> > >
> > > Daniel,
> > >
> > > Thank you for your patch. Some comments about it:
> > >
> > > - I'd rather fix whatever is broken in the current code than going back to
> > > spinlocks, as they increase latency and reduce concurrency. In any case,
> > > please check your code. I've seen a spinlock in the interrupt handler that
> > > may lock the system.
> >
> > but we need to protect from interrupts while accessing the card and waiting for
> > completion. semaphores don't protect you from that. spin_lock_irqsave does. the
> > spin_lock in the interrupt handler is there to protect from interrupts from
> > other processors in a SMP system (see Documentation/spinlocks.txt) and is btw.
> > a no-op on UP. and semaphores are quite heavy....
> 
> Not really. You can still read the received packets from the card (as
> you're not issuing any command and are using the other BAP) while a
> command is in progress. There are some specific cases in which you need
> to have protection, and that cases are avoided with the down_trylock.
> 

ok, i think i have to look closer...if the card can handle that then we don't need
to irq-protect all the areas i did protect...but i do think that those down_trylock and
then the schedule_work should be replaced by a simple spinlock_irq_save...

i look closer at it tomorrow.
you happen to have the tech spec lying aroung? 

> AFAIK, interrupt serialization is assured by the interrupt handler, so you
> don't need to do that.
> 
> > > - The fix for the transmit code you mention, is about fixing the returned
> > > value in case of error? If not, please explain it to me as I don't see any
> > > other changes.
> >
> > fixes:
> > - return values
> > - when to free the skb, when not
> > - disabling the queues
> > - netif_wake_queue called from the interrupt handler only (and on the right
> >   net_device)
> > - i think the priv->xmit stuff and then the schedule_work is evil:
> >   if you return 0 from the dev->hard_start_xmit then the network layer assumes
> >   that the packet was kfree_skb()'ed (which does only frees the packet when the
> >   refcount drops to zero.) this is the cause for the keventd killing, for sure!
> >
> >   if you return 0 you already kfree_skb()'ed the packet. and that's it.
> 
> This is where I have the biggest problems. As I've read in
> Documentation/networking/driver.txt, looks like the packet needs to be
> freed "soon", but doesn't require to be before returning 0 in
> hard_start_xmit. Did I get it wrong?
> 

no, i got it wrong. but still...it's the xmit where the oops comes from.... 

wait. isn't there a race in airo_do_xmit? at high xfer rates (when it oopses) the
queue can wake right after it is stopped in the down_trylock section. so you can
happen to loose an skb 'cos the write to priv->xmit is not protected at all and
there should be a check so that only one skb can be queue there. no?
(and then the irq-handler can wake the queue too)

ok, i think i got it now. i'll do a new patch tomorrow or so that tries:
- to fix the transmit not to oops
- to avoid disabling the irq's whenever possible
- using spinlocks instead of the heavier semaphores ('cos i think if it's done cleaner
  than i did it now, it's faster than the semas, and to make hch happy :) 


> Thanks for your help,
> Javier Achirica
> 

rgds
-daniel

