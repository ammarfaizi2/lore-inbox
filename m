Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131177AbRAVIwU>; Mon, 22 Jan 2001 03:52:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131067AbRAVIwA>; Mon, 22 Jan 2001 03:52:00 -0500
Received: from colorfullife.com ([216.156.138.34]:56335 "EHLO colorfullife.com")
	by vger.kernel.org with ESMTP id <S131180AbRAVIvj>;
	Mon, 22 Jan 2001 03:51:39 -0500
Message-ID: <3A6BF496.AE9957D7@colorfullife.com>
Date: Mon, 22 Jan 2001 09:51:34 +0100
From: Manfred Spraul <manfred@colorfullife.com>
X-Mailer: Mozilla 4.75 [en] (X11; U; Linux 2.2.16-22 i586)
X-Accept-Language: en
MIME-Version: 1.0
To: Donald Becker <becker@scyld.com>
CC: Jeff Garzik <jgarzik@mandrakesoft.com>, Andrew Morton <andrewm@uow.edu.au>,
        mulder.abg@sni.de, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Re: Q: natsemi.c spinlocks
In-Reply-To: <Pine.LNX.4.10.10101220157450.9133-100000@vaio.greennet>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Donald Becker wrote:
> 
> > > However, natsemi.c's spinlock needs to be retained, and
> > > extended into start_tx(), because this driver has
> > > a race which has cropped up in a few others:
> > >         ...
> > >         if (np->cur_tx - np->dirty_tx >= TX_QUEUE_LEN - 1) {
> > >         /* WINDOW HERE */
> > >                 np->tx_full = 1;
> > >                 netif_stop_queue(dev);
> > >         }
> > > If the ring is currently full and an interrupt comes in
> > > at the indicated window and reaps ALL the packets in the
> > > ring, the driver ends up in state `tx_full = 1' and tramsmit
> > > disabled, but with no outstanding transmit interrupts.
> 
> The better solution, which I've been adding to the drivers, is to check
> again for a just-cleared Tx queue after setting tx_full.
> That trades an extra comparison on a rarely followed path for a spinlock
> that is taken for every transmit and interrupt.
>
Please do not forget the memory barrier(s):
	
	tx_full = 1;
	if(condition)
		...;

That's exactly the sequence that caused deadlocks with wait_queues -
even a Pentium cpu will evaluate the condition before the write to
tx_full is commited. I have a test program (userspace) that reliably
locks up on my P II. I can send you the details if you are interested.

I think you also need a memory barrier in the tx_interrupt codepath.

> 
> Remember: spinlocks are expensive!
> 

But memory barriers are extremely error prone.

What about

tx_interrupt()

	if(netif_queue_stopped(dev)) {
		spin_lock(&np->lock);
		if(np->cur_tx - np->dirty_tx <= TX_QUEUE_LEN/2)
			netif_wake_queue(dev));
		spin_unlock(&np->lock);
	}

hard_xmit()

	if(np->cur_tx - np->dirty_tx >= TX_QUEUE_LEN-1) {
		spin_lock_irq(&np->lock);
		if(np->cur_tx - np_dirty_tx >= TX_QUEUE_LEN-1)
			netif_stop_queue(dev);
		spin_unlock_irq(&np->lock);
	}

--
	Manfred
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
