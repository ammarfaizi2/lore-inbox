Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129401AbRAVHCq>; Mon, 22 Jan 2001 02:02:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129584AbRAVHCg>; Mon, 22 Jan 2001 02:02:36 -0500
Received: from adsl-151-196-234-208.baltmd.adsl.bellatlantic.net ([151.196.234.208]:9274
	"EHLO vaio.greennet") by vger.kernel.org with ESMTP
	id <S129401AbRAVHCY>; Mon, 22 Jan 2001 02:02:24 -0500
Date: Mon, 22 Jan 2001 02:06:11 -0500 (EST)
From: Donald Becker <becker@scyld.com>
To: Jeff Garzik <jgarzik@mandrakesoft.com>
cc: Andrew Morton <andrewm@uow.edu.au>, Manfred <manfred@colorfullife.com>,
        mulder.abg@sni.de, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Re: Q: natsemi.c spinlocks
In-Reply-To: <3A6AF575.D593AEBC@mandrakesoft.com>
Message-ID: <Pine.LNX.4.10.10101220157450.9133-100000@vaio.greennet>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 21 Jan 2001, Jeff Garzik wrote:
> Andrew Morton wrote:
> > Manfred wrote:
> > > Hi Jeff, Tjeerd,
> > > I spotted the spin_lock in natsemi.c, and I think it's bogus.
> > >
> > > The "simultaneous interrupt entry" is a bug in some 2.0 and 2.1 kernel
> > > (even Alan didn't remember it exactly when I asked him), thus a sane
> > > driver can assume that an interrupt handler is never reentered.
...
> > I think you're right.  2.4's interrupt handling prevents
> > simultaneous entry of the same ISR.

The bug (simultaneous calls to the interrupt handler on SMP) existed in
most 2.0 versions was fixed before 2.2.  A driver that needs to work
with multiple kernel versions must have the check.

> > However, natsemi.c's spinlock needs to be retained, and
> > extended into start_tx(), because this driver has
> > a race which has cropped up in a few others:
> >         ...
> >         if (np->cur_tx - np->dirty_tx >= TX_QUEUE_LEN - 1) {
> >         /* WINDOW HERE */
> >                 np->tx_full = 1;
> >                 netif_stop_queue(dev);
> >         }
> > If the ring is currently full and an interrupt comes in
> > at the indicated window and reaps ALL the packets in the
> > ring, the driver ends up in state `tx_full = 1' and tramsmit
> > disabled, but with no outstanding transmit interrupts.

The better solution, which I've been adding to the drivers, is to check
again for a just-cleared Tx queue after setting tx_full.
That trades an extra comparison on a rarely followed path for a spinlock
that is taken for every transmit and interrupt.

Remember: spinlocks are expensive!

Donald Becker				becker@scyld.com
Scyld Computing Corporation		http://www.scyld.com
410 Severn Ave. Suite 210		Second Generation Beowulf Clusters
Annapolis MD 21403			410-990-9993

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
