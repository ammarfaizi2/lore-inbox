Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S312855AbSDYCts>; Wed, 24 Apr 2002 22:49:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S312885AbSDYCtr>; Wed, 24 Apr 2002 22:49:47 -0400
Received: from dockmaster.scyld.com ([66.93.58.82]:39919 "EHLO
	localhost.localdomain") by vger.kernel.org with ESMTP
	id <S312855AbSDYCtq>; Wed, 24 Apr 2002 22:49:46 -0400
Date: Wed, 24 Apr 2002 22:49:22 -0400 (EDT)
From: Donald Becker <becker@scyld.com>
X-X-Sender: <becker@presario>
To: "Ivan G." <ivangurdiev@linuxfreemail.com>
cc: LKML <linux-kernel@vger.kernel.org>
Subject: Re: Via-Rhine Driver - questions for D. Becker.
In-Reply-To: <02042417390802.00760@cobra.linux>
Message-ID: <Pine.LNX.4.33.0204242218040.17528-100000@presario>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 24 Apr 2002, Ivan G. wrote:

> I have been trying to debug the kernel Via-Rhine driver but I do not have
> much information and I'm forced to guess about many things.

There are datasheets available for both the Rhine and Rhine-II chips.

> - 1) "Something wicked happened"]
> What is the precise purpose of the trap - what should be trapped and what
> shouldn't. Is it even necessary? There are a definite number of interrupts to
> call via_rhine_error - why not simply handle each one of them? I've seen 3
> different versions of the "wicked" code.

The earlier versions of the driver produced that messsage for most
unusual events.  The problem was that normal events combined with
uncommon events would trigger the message.  The driver at scyld.com
cleaned up the check for events that trigger the message long ago.

See
 http://www.scyld.com/network/via-rhine.html
    ftp://www.scyld.com/pub/network/via-rhine.c

> - 2) CmdTxDemand should be issued to handle which error interrupts?

It's used to wake an idle Tx unit.
There is a race condition when adding a new descriptor to the Tx
descriptor list.  The driver might add the descriptor just a cycle too
late, leaving the just-queued packet untransmitted.  It's safe to make
extra calls to CmdTxDemand, so the driver does this after every packet
is queued.

CmdTxDemand is also called when there is a transmit abort due to
excessive collisions, FIFO underrun, or lost carrier.

Aagin, see the code at scyld.com

> - 3) Missing interrupts in setting the bitmask....
> Is there a reason or is it an error? some of those are used later in the
> code... RxNoBuf for example, RxOverflow is another (actually your driver
> includes that but never uses it), TxAborted is missing in both kernel and
> your version.

RxNoBuf doesn't apply.  In our case it will always occur in conjunction
with IntrRxEmpty, which is the event we handle.

Compare IntrTxAbort (which we handle) with the similar IntrTxAborted
(which the driver does not explicitly mention).

> - 4) RxOverflow is not handled. Does it need to be and how?

See the datasheet.
We handle it implicitly by refilling the Rx descriptors.

> -5 ) What is a good resource on those things? I read the datasheets.
> They give useful numbers but little explanation on how different interrupts
> should be handled. What info did you have when you were writing the driver.

>From the datasheet.  As with most datasheets, it is written as if no
similar chip exists but can't be understood unless you know how other
Ethernet NICs works.  After all, they can't just come out and say "it's
just like the LANCE/Tulip/etc but we shuffled the bit fields and tweaked
this interface".

> -6) TxUnderrun - it increases threshold and then issues CmdTxDemand in  the
> "wicked error" trap. The linuxfet VIA driver, additionally  does the
> following: Sets descriptor bit, CmdTxOn, CmdTxDemand

Hmmmm, I'm not certain that the "underrun" comment is correct here.

> if (txstatus & 0x0800) {
>              /* uderrun happen */
>               np->tx_ring[entry].tx_status = cpu_to_le32(DescOwn);
>               writel(virt_to_bus(&np->tx_ring[entry]), ioaddr + TxRingPtr);

This is backing up the Tx pointer to retransmit the failed packet.
My original driver did not do this -- I believe that it's semantically
wrong.

I write my drivers to always fail the current transmit attempt on Tx
Abort.  Ethernet uses dropped packets on severe overload (16 collision
abort) to provide flow control to the protocol layers.  If you back up
and attempt to retransmit the same packet you defeat this element of the
protocol.  It's an atypical case, but Ethernet works where Aloha fails
because it gets the rare cases right.

>               /* Turn on Tx On*/
>               writew(CmdTxOn | np->chip_cmd, dev->base_addr + ChipCmd);

Note: My driver doesn't turn the Tx back on as a separate step.

>                /* Stats counted in Tx-done handler, just restart Tx. */
>               writew(CmdTxDemand | np->chip_cmd, dev->base_addr + ChipCmd);
>               if (debug > 1)
>                        printk(KERN_ERR "Underrun happen");

This is code from my driver, but someone didn't get the erorr message right.
The error message must prefix the device e.g. "eth0".

	if (np->msg_level & NETIF_MSG_TX_ERR)
		printk(KERN_INFO "%s: Transmitter underrun, increasing Tx "
		    "threshold setting to %2.2x.\n", dev->name, np->tx_thresh);


-- 
Donald Becker				becker@scyld.com
Scyld Computing Corporation		http://www.scyld.com
410 Severn Ave. Suite 210		Second Generation Beowulf Clusters
Annapolis MD 21403			410-990-9993

