Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S313773AbSERTLs>; Sat, 18 May 2002 15:11:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S313789AbSERTLr>; Sat, 18 May 2002 15:11:47 -0400
Received: from mta9n.bluewin.ch ([195.186.1.215]:50006 "EHLO mta9n.bluewin.ch")
	by vger.kernel.org with ESMTP id <S313773AbSERTLq>;
	Sat, 18 May 2002 15:11:46 -0400
Date: Sat, 18 May 2002 21:11:36 +0200
From: "'Roger Luethi'" <rl@hellgate.ch>
To: "Ivan G." <ivangurdiev@linuxfreemail.com>
Cc: LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] #2 VIA Rhine stalls: TxAbort handling
Message-ID: <20020518191136.GA4405@k3.hellgate.ch>
In-Reply-To: <369B0912E1F5D511ACA5003048222B75A3C06E@EXCHANGE2> <20020518040143.GA9318@k3.hellgate.ch> <02051717133300.00656@cobra.linux>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.27i
X-Operating-System: Linux 2.4.19-pre8 on i686
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 17 May 2002 17:13:33 -0600, Ivan G. wrote:
> 
> > [1] "aborted due to excessive collisions" according to the doc, but it also
> >     mentions that for "excessive collisions", bit 13 would have to be set.
> >     It isn't.
> >     (I have seen it on my VT6102, though, with interrupt status of 0x2008
> >     for instance)
> 
> bit 13 = IntrTxAborted
> I don't see it below.
> 
> /* Enable interrupts by setting the interrupt mask. */
> writew(IntrRxDone | IntrRxErr | IntrRxEmpty| IntrRxOverflow| IntrRxDropped|
>    IntrTxDone | IntrTxAbort | IntrTxUnderrun | IntrPCIErr | IntrStatsMax | 
> IntrLinkChange | IntrMIIChange, ioaddr + IntrEnable);

Hey, somebody's paying attention here! I'm impressed ;-).

We don't need to enable an interrupt in order to have the status bit set by
the chip. Enabling an interrupt basically means that the ISR gets called
when the the status flag goes up.

To put it differently: if you don't enable both TxAbort or TxAborted, you
get to handle those events whenever the ISR is active anyway. So either you
get, say 0x2009 (errors + rxdone) or you enter the ISR with 0x0001 (rxdone)
and while you're doing your first round the chip updates the status
register and next time you hit

while ((intr_status = readw(ioaddr + IntrStatus))) {

you find it's 0x2008 now. No matter what interrupts you enable: as long as
you receive a steady flow of interrupts of any kind, the driver should
still work. Sort of.

Not enabling the TxAborted interrupt is easy to justify: the chip just
failed to send out a frame due to massive collisions. Therefore, we are not
in a hurry to be notified and restart Tx, and as we learned recently it
also takes the chip some time to halt the Tx engine.

Of course that's all a moot point if TxAborted always implies TxAbort:
_that_ interrupt is enabled. I think I'm going to enable TxAborted
regardless. It shouldn't make a difference, and if it did, we're better off
having it enabled.

The contrast between interrupts enabled and handled in the current LK
driver is not pretty, but for most of them it's probably rather a clean-up
than a bug fixing issue if anything. I am currently focusing on what I
suspect to be a problem, so my comments below are mostly based on reading
src and docs, not actual experiments.

> Interrupts referenced in the driver and not listed here are: IntrRxNoBuf,
> IntrRxWakeUp, IntrTxAborted

IMO IntrRxNoBuf should be enabled. If there are no Rx buffers left, we want
to know ASAP and free them.

IntrRxWakeUp has been used to indicate that a magic wake up packet was
received (hence the name). On the VT6102, the same bit is now a "general
purpose interrupt". Whatever that means. Proper support for magic packets
might be desirable later on. Not a problem now.

> Interrupts included here but not used in the driver are:
> IntrRxOverflow, IntrRxDropped.

Since we have problems with Tx, I don't care much about Rx right now. May
be a mistake ;-). For IntrRxDropped, though, we call via_rhine_rx(). We do
use it.

> For example what exactly is the difference between IntrTxAbort and 
> IntrTxAborted. 

Depends on the docs you read. Currently I tend to think that IntrTxAbort is
a misnomer and I have renamed it IntrTxError in my code.

> I was also puzzled as to why the docs say:
> Transmit Descriptor Underflow for IntrMIIChange
> 
> I am talking about the newest VT86C100A docs.

I agree, and I am talking about three different docs. I'd be very curious
where this is coming from, I can't imagine that somebody just pulled it out
of thin air. The name IntrMIIChange and its use in the driver suggest that
the 0x0200 interrupt announces changes in the MII status register.
According to all docs I've checked 0x0200 means a Tx underflow related to a
descriptor (as opposed to 0x0010 which is a Tx underflow related to a
frame).

But even if these suspicions are correct, the impact seems rather small.
The driver takes action based on the MII status register anyway, so worst
case is probably we ignore Tx descriptor underflows (which I don't expect
to be very common).

I'm not sure if it was a good idea to take this back to LKML at this point.
I doubt that the greater public is interested in the gory details of VIA
Rhine programming. I suggest we keep the traffic among the interested
parties and send a patch along with a summary once we have come to a
conclusion or a patch needs wider testing. Comments?

Roger
