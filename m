Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S271186AbTGWRl1 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 23 Jul 2003 13:41:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S271183AbTGWRl1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 23 Jul 2003 13:41:27 -0400
Received: from dclient217-162-108-200.hispeed.ch ([217.162.108.200]:40453 "EHLO
	ritz.dnsalias.org") by vger.kernel.org with ESMTP id S271182AbTGWRlT
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 23 Jul 2003 13:41:19 -0400
From: Daniel Ritz <daniel.ritz@gmx.ch>
To: Javier Achirica <achirica@telefonica.net>
Subject: Re: [PATCH 2.5] fixes for airo.c
Date: Wed, 23 Jul 2003 19:56:58 +0200
User-Agent: KMail/1.5.2
Cc: linux-kernel <linux-kernel@vger.kernel.org>,
       linux-net <linux-net@vger.kernel.org>
References: <Pine.SOL.4.30.0307231219020.12179-100000@tudela.mad.ttd.net>
In-Reply-To: <Pine.SOL.4.30.0307231219020.12179-100000@tudela.mad.ttd.net>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200307231956.58656.daniel.ritz@gmx.ch>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

[shortening the cc: list a bit..]

On Wed July 23 2003 12:26, Javier Achirica wrote:
> 
> You cannot use down() in xmit, as it may be called in interrupt context. I
> know it slows things down, but that's the only way I figured out of
> handling a transmission while the card is processing a long command.

hu? no. you can do a down() as xmit is never called from interrupt context. and
the dev->hard_start_xmit() calls are serialized with the dev->xmit_lock. the
serialization is broken by the schedule_work() thing.

> 
> I thought about the fix and I think it's fixed. The only case the race
> could happen is if there's some work pending to be scheduled and the queue
> gets started again (by the interrupt handler), so airo_start_xmit
> overwrites the priv->xmit data. Now, because of the new flag, the
> interrupt handler won't wake the queue until the pending packet is
> sent to the card (or fails) so I don't see how can the race happen
> (although I didn't see it until you pointed out :-(
> 

may be the flag fixes the problem, but it adds complexity...

> Javier Achirica

-daniel

> 
> On Wed, 23 Jul 2003, Daniel Ritz wrote:
> 
> > ok, now the braindamaged thing called sourceforge showed the changes, but:
> > - i don't think the race is fixed. just remove the whole down_trylock()
> >   crap in the xmit altogether and replace it with a single down(). faster,
> >   simpler, not racy...and with the schedule_work you win nothing, you lose
> > speed
> > - please don't commit bugfixes and new features in the same changeset...
> > - the loop-forever fix in transmit_allocate: you should have copied the
> > comment
> >   changes from my patch too, so the spin-forever-comment goes away...
> >
> > i look closer when i'm home, having a real operating system to work on, not
> > this
> > winblows box at work now..
> >
> > -daniel
> >
> >
> > Javier Achirica wrote:
> > >
> > > Today I updated the CVS and Sourceforge (airo-linux.sf.net) with the
> > > latest version (1.53) that (I hope) fixes the race problem. If everything
> > > is fine, I'll commit the changes to the kernel tree.
> > >
> > > Javier Achirica
> > >
> > > On Mon, 21 Jul 2003, Daniel Ritz wrote:
> > >
> > > > On Mon July 21 2003 21:44, Javier Achirica wrote:
> > > > >
> > > > > On Mon, 21 Jul 2003, Daniel Ritz wrote:
> > > > >
> > > > > > On Mon July 21 2003 13:00, Javier Achirica wrote:
> > > > > > >
> > > > > > > Daniel,
> > > > > > >
> > > > > > > Thank you for your patch. Some comments about it:
> > > > > > >
> > > > > > > - I'd rather fix whatever is broken in the current code than going
> > back to
> > > > > > > spinlocks, as they increase latency and reduce concurrency. In any
> > case,
> > > > > > > please check your code. I've seen a spinlock in the interrupt
> > handler that
> > > > > > > may lock the system.
> > > > > >
> > > > > > but we need to protect from interrupts while accessing the card and
> > waiting for
> > > > > > completion. semaphores don't protect you from that.
> > spin_lock_irqsave does. the
> > > > > > spin_lock in the interrupt handler is there to protect from
> > interrupts from
> > > > > > other processors in a SMP system (see Documentation/spinlocks.txt)
> > and is btw.
> > > > > > a no-op on UP. and semaphores are quite heavy....
> > > > >
> > > > > Not really. You can still read the received packets from the card (as
> > > > > you're not issuing any command and are using the other BAP) while a
> > > > > command is in progress. There are some specific cases in which you
> > need
> > > > > to have protection, and that cases are avoided with the down_trylock.
> > > > >
> > > >
> > > > ok, i think i have to look closer...if the card can handle that then we
> > don't need
> > > > to irq-protect all the areas i did protect...but i do think that those
> > down_trylock and
> > > > then the schedule_work should be replaced by a simple
> > spinlock_irq_save...
> > > >
> > > > i look closer at it tomorrow.
> > > > you happen to have the tech spec lying aroung?
> > > >
> > > > > AFAIK, interrupt serialization is assured by the interrupt handler, so
> > you
> > > > > don't need to do that.
> > > > >
> > > > > > > - The fix for the transmit code you mention, is about fixing the
> > returned
> > > > > > > value in case of error? If not, please explain it to me as I don't
> > see any
> > > > > > > other changes.
> > > > > >
> > > > > > fixes:
> > > > > > - return values
> > > > > > - when to free the skb, when not
> > > > > > - disabling the queues
> > > > > > - netif_wake_queue called from the interrupt handler only (and on
> > the right
> > > > > >   net_device)
> > > > > > - i think the priv->xmit stuff and then the schedule_work is evil:
> > > > > >   if you return 0 from the dev->hard_start_xmit then the network
> > layer assumes
> > > > > >   that the packet was kfree_skb()'ed (which does only frees the
> > packet when the
> > > > > >   refcount drops to zero.) this is the cause for the keventd
> > killing, for sure!
> > > > > >
> > > > > >   if you return 0 you already kfree_skb()'ed the packet. and that's
> > it.
> > > > >
> > > > > This is where I have the biggest problems. As I've read in
> > > > > Documentation/networking/driver.txt, looks like the packet needs to be
> > > > > freed "soon", but doesn't require to be before returning 0 in
> > > > > hard_start_xmit. Did I get it wrong?
> > > > >
> > > >
> > > > no, i got it wrong. but still...it's the xmit where the oops comes
> > from....
> > > >
> > > > wait. isn't there a race in airo_do_xmit? at high xfer rates (when it
> > oopses) the
> > > > queue can wake right after it is stopped in the down_trylock section. so
> > you can
> > > > happen to loose an skb 'cos the write to priv->xmit is not protected at
> > all and
> > > > there should be a check so that only one skb can be queue there. no?
> > > > (and then the irq-handler can wake the queue too)
> > > >
> > > > ok, i think i got it now. i'll do a new patch tomorrow or so that tries:
> > > > - to fix the transmit not to oops
> > > > - to avoid disabling the irq's whenever possible
> > > > - using spinlocks instead of the heavier semaphores ('cos i think if
> > it's done cleaner
> > > >   than i did it now, it's faster than the semas, and to make hch happy
> > :)
> > > >
> > > >
> > > > > Thanks for your help,
> > > > > Javier Achirica
> > > > >
> > > >
> > > > rgds
> > > > -daniel
> > > >
> > > >
> > > >
> > >
> >
> >
> >
> 
> 

