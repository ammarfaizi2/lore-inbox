Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130111AbQLXBUS>; Sat, 23 Dec 2000 20:20:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130290AbQLXBT7>; Sat, 23 Dec 2000 20:19:59 -0500
Received: from isis.its.uow.edu.au ([130.130.68.21]:62348 "EHLO
	isis.its.uow.edu.au") by vger.kernel.org with ESMTP
	id <S130111AbQLXBTw>; Sat, 23 Dec 2000 20:19:52 -0500
Message-ID: <3A45493C.3C75EC1A@uow.edu.au>
Date: Sun, 24 Dec 2000 11:54:20 +1100
From: Andrew Morton <andrewm@uow.edu.au>
X-Mailer: Mozilla 4.7 [en] (X11; I; Linux 2.4.0-test8 i586)
X-Accept-Language: en
MIME-Version: 1.0
To: Manfred <manfred@colorfullife.com>
CC: mulder.abg@sni.de, jgarzik@mandrakesoft.com, linux-kernel@vger.kernel.org
Subject: Re: Q: natsemi.c spinlocks
In-Reply-To: <3A44E4D0.E8F177B9@colorfullife.com>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Manfred wrote:
> 
> Hi Jeff, Tjeerd,
> 
> I spotted the spin_lock in natsemi.c, and I think it's bogus.
> 
> The "simultaneous interrupt entry" is a bug in some 2.0 and 2.1 kernel
> (even Alan didn't remember it exactly when I asked him), thus a sane
> driver can assume that an interrupt handler is never reentered.
> 
> Donald often uses dev->interrupt to hide other races, but I don't see
> anything in this driver (tx_timeout and netdev_timer are both trivial)

Hi, Manfed.

I think you're right.  2.4's interrupt handling prevents
simultaneous entry of the same ISR.

However, natsemi.c's spinlock needs to be retained, and
extended into start_tx(), because this driver has
a race which has cropped up in a few others:

Current code:

start_tx()
{
	...
	if (np->cur_tx - np->dirty_tx >= TX_QUEUE_LEN - 1) {
	/* WINDOW HERE */
                np->tx_full = 1;
                netif_stop_queue(dev);
        }
	...
}

If the ring is currently full and an interrupt comes in
at the indicated window and reaps ALL the packets in the
ring, the driver ends up in state `tx_full = 1' and tramsmit
disabled, but with no outstanding transmit interrupts.

It's screwed.  You need another interrupt so tx_full
can be cleared and the queue can be restarted, but you can't
*get* another interrupt because there are no Tx packets outstanding.

It's very unlikely to happen with this particular driver
because it's also polling the transmit queue within
receive interrupts.  Receiving a packet will clear
the condition.

If you were madly hosing out UDP packets and receiving nothing
then this could occur.  It was certainly triggerable in 3c59x.c,
which doesn't test the Tx queue state in Rx interrupts.

I currently have natsemi.c lying in pieces on my garage floor,
so I'll put this locking in if it's OK with everyone?


-
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
