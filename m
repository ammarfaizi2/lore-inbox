Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S270703AbTGUT36 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 21 Jul 2003 15:29:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S270702AbTGUT36
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 21 Jul 2003 15:29:58 -0400
Received: from tudela.mad.ttd.net ([194.179.1.233]:56245 "EHLO
	tudela.mad.ttd.net") by vger.kernel.org with ESMTP id S270700AbTGUT3v
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 21 Jul 2003 15:29:51 -0400
Date: Mon, 21 Jul 2003 21:44:42 +0200 (MEST)
From: Javier Achirica <achirica@telefonica.net>
To: Daniel Ritz <daniel.ritz@gmx.ch>
cc: Jeff Garzik <jgarzik@pobox.com>,
       linux-kernel <linux-kernel@vger.kernel.org>,
       linux-net <linux-net@vger.kernel.org>,
       Jean Tourrilhes <jt@bougret.hpl.hp.com>,
       Mike Kershaw <dragorn@melchior.nerv-un.net>
Subject: Re: [PATCH 2.5] fixes for airo.c
In-Reply-To: <200307211949.30513.daniel.ritz@gmx.ch>
Message-ID: <Pine.SOL.4.30.0307212056370.29431-100000@tudela.mad.ttd.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Mon, 21 Jul 2003, Daniel Ritz wrote:

> On Mon July 21 2003 13:00, Javier Achirica wrote:
> >
> > Daniel,
> >
> > Thank you for your patch. Some comments about it:
> >
> > - I'd rather fix whatever is broken in the current code than going back to
> > spinlocks, as they increase latency and reduce concurrency. In any case,
> > please check your code. I've seen a spinlock in the interrupt handler that
> > may lock the system.
>
> but we need to protect from interrupts while accessing the card and waiting for
> completion. semaphores don't protect you from that. spin_lock_irqsave does. the
> spin_lock in the interrupt handler is there to protect from interrupts from
> other processors in a SMP system (see Documentation/spinlocks.txt) and is btw.
> a no-op on UP. and semaphores are quite heavy....

Not really. You can still read the received packets from the card (as
you're not issuing any command and are using the other BAP) while a
command is in progress. There are some specific cases in which you need
to have protection, and that cases are avoided with the down_trylock.

AFAIK, interrupt serialization is assured by the interrupt handler, so you
don't need to do that.

> > - The fix for the transmit code you mention, is about fixing the returned
> > value in case of error? If not, please explain it to me as I don't see any
> > other changes.
>
> fixes:
> - return values
> - when to free the skb, when not
> - disabling the queues
> - netif_wake_queue called from the interrupt handler only (and on the right
>   net_device)
> - i think the priv->xmit stuff and then the schedule_work is evil:
>   if you return 0 from the dev->hard_start_xmit then the network layer assumes
>   that the packet was kfree_skb()'ed (which does only frees the packet when the
>   refcount drops to zero.) this is the cause for the keventd killing, for sure!
>
>   if you return 0 you already kfree_skb()'ed the packet. and that's it.

This is where I have the biggest problems. As I've read in
Documentation/networking/driver.txt, looks like the packet needs to be
freed "soon", but doesn't require to be before returning 0 in
hard_start_xmit. Did I get it wrong?

Thanks for your help,
Javier Achirica


