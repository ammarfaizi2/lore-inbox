Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S311710AbSDDWLH>; Thu, 4 Apr 2002 17:11:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S311735AbSDDWK6>; Thu, 4 Apr 2002 17:10:58 -0500
Received: from fungus.teststation.com ([212.32.186.211]:13061 "EHLO
	fungus.teststation.com") by vger.kernel.org with ESMTP
	id <S311710AbSDDWKp>; Thu, 4 Apr 2002 17:10:45 -0500
Date: Fri, 5 Apr 2002 00:10:40 +0200 (CEST)
From: Urban Widmark <urban@teststation.com>
X-X-Sender: <puw@cola.teststation.com>
To: Ivan Gurdiev <ivangurdiev@yahoo.com>
cc: LKML <linux-kernel@vger.kernel.org>
Subject: Re: Via-Rhine stalls - transmit errors
In-Reply-To: <20020328085058.77333.qmail@web10107.mail.yahoo.com>
Message-ID: <Pine.LNX.4.33.0204042309350.30303-100000@cola.teststation.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 28 Mar 2002, Ivan Gurdiev wrote:

(A week is probably a personal record ... just hasn't been time to think 
 about funny rhine problems)

> > If you get a IntrTxAbort
> > by itself then a message isn't printed, but if you
> get a IntrTxAbort and
> > IntrTxDone you get some output (000a).
> 
> This is actually a great example of the
> 'redundancies' I was talking about.
> You get both Abort and Done...
> Abort handler sends command CmdTxDemand.
> "Wicked" message handler excludes Abort
> but not Done, so it will: (1) print message,
> (2) send CmdTxDemand (once again)

Setting CmdTxDemand twice is probably (thought to be) harmless.  Also
IntrTxAbort doesn't necessarily want the same fix as IntrTxAbort |
IntrTxDone even if it currently does the same.

> >Possibly those flags are never set without also
> setting
> > another flag, like IntrRxErr,
> 
> Why? Each interrupt should have its own bit
> in the bitmask.

The bitmask is the hardware interrupts, so they do. I meant if the
hardware always sets those bits together (and no, I don't know why Donald
can make that assumption if that is what he did).


> /*----------------------------------------------*/
> np->tx_ring[entry].tx_status = cpu_to_le32(DescOwn);
>                    
> writel(virt_to_bus(&np->tx_ring[entry]), ioaddr +
> TxRingPtr)
> ;
> /* Turn on Tx On*/
> writew(CmdTxOn | np->chip_cmd, dev->base_addr +
> ChipCmd);   
> /* Stats counted in Tx-done handler, just restart Tx.
> */
> writew(CmdTxDemand | np->chip_cmd, dev->base_addr +
> ChipCmd)
> ;
> /*----------------------------------------------*/
> I am particularly curious about the ownership bits
> and the TxRingPtr save... no such thing
> in kernel via_rhine_tx...I don't think.

The DescOwn tells if the NIC owns the descriptor. TxRingPtr points to RAM 
that holds the descriptor ring. Both exist in both drivers, but the kernel 
driver looks a little different because it uses the 2.4 PCI DMA interface.

Oh you mean their error handling. No, the descriptor status is only used 
to log errors in the kernel driver.

> Then the linuxfet driver doesn't do 
> anything for abort in the error handler
> and increases threshold for underrun.

You have descriptor status "txstatus" that they do the above on but the
kernel driver only does a tx_aborted_errors++ on. Question is if that
txstatus is always accompanied by a IntrTxAbort or IntrTxAborted.
(Note that the name "abort" is used for different abort flags, not
 necessarily having the same meaning)

> ______________________________________
> I moved the code above to the kernel driver
> and made it handle aborts and underruns
> the same way. I disabled the CmdTxDemand

If you just copied it the "virt_to_bus(&np->tx_ring[entry])" construct
isn't supposed to be used. I think. But I also think it ends up being the
same on x86 so it probably doesn't matter for you.

> This way, I fixed stalls on the Desktop.
> However, my laptop was still slow and stalling.
> (desktop->laptop transmit, laptop initiates.)
> 
> I commented the underrun code in via_rhine_tx
> and it fixed all stalls, but speed decreased.

Could you send diffs for these changes? Incremental would be nice (first
vs the orig driver, then against the modified and so on). It's kind of
hard to follow what changes you make.

If speed decreases then maybe it is still aborting a lot, and if CmdTxOn
or something takes a little bit of time it would be noticable.

It could also be that you have decreased the speed of the driver and that 
it for some reason then doesn't trigger the event that stalls it.

Another thought is that aborted in txstatus happens a lot more than
IntrTxAbort and that you have increased the workload of the driver.
Perhaps the aborted error handling in the linuxfet driver should be done
in the IntrTxAbort handler instead.

> I wish I could explain all of this,
> but I have little knowledge of hardware operation.
> Apparently the handling of aborts is the cause
> of stalling. Previously I had logged ownership
> bits and stalls always occured when
> an ownership bit was set to 0, but transmit 
> stopped (result of abort, wrong handling?)

DescOwn 0 means that the chip no longer has any right to access that
descriptor, so it should stop. If the chip signals IntrTxDone |
IntrTxAbort, then it seems reasonable that it would no longer own the
descriptor because it says it is done with it.

Btw, this could be a reason why IntrTxDone | IntrTxAbort would be
different from IntrTxAbort (if the second ever happens) and that they
should be treated differently (the current code has a "Recovery for other
fault sources not known." in the wicked-part but maybe that should be 
something else).

That it stalls could be that it for some reason doesn't continue sending
the new descriptors that are written when packets are moved to the driver.
You could examine the state of the tx descriptors when it stalls, and if
they still make up a ring.

If the TxRingPtr is readable then I think you can look at that to see
which descriptor the card thinks is current. If that pointer does not
match what the cur_tx ("entry") points to then something has made them
loose sync and I guess that could stop progress.


> The underrun code has effect on speed
> and on transmits initiated from my laptop..
> but I am too confused to comment about it.
> I am sure this is a horribly ignorant question,
> but what exactly is an underrun :)

My understanding:
A buffer on the chip was empty when it needed to send more data to keep up
with the ethernet speed. Increasing the buffer means that it has more time
to get the rest of the data, and store&forward means that it reads the
full packet into the buffer before beginning to send.

Have you tried simply increasing the tx_thresh and not change anything in
the IntrTxUnderrun handling?

/Urban

