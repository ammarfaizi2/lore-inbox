Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S314617AbSD0VWe>; Sat, 27 Apr 2002 17:22:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S314618AbSD0VWe>; Sat, 27 Apr 2002 17:22:34 -0400
Received: from ucsu.Colorado.EDU ([128.138.129.83]:27347 "EHLO
	ucsu.colorado.edu") by vger.kernel.org with ESMTP
	id <S314617AbSD0VWd>; Sat, 27 Apr 2002 17:22:33 -0400
Content-Type: text/plain; charset=US-ASCII
From: "Ivan G." <ivangurdiev@linuxfreemail.com>
Reply-To: ivangurdiev@linuxfreemail.com
Organization: ( )
To: Donald Becker <becker@scyld.com>
Subject: Re: Via-Rhine Driver - questions for D. Becker.
Date: Sat, 27 Apr 2002 15:15:56 -0600
X-Mailer: KMail [version 1.2]
In-Reply-To: <Pine.LNX.4.33.0204242218040.17528-100000@presario>
Cc: LKML <linux-kernel@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <02042715155600.01022@cobra.linux>
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> The earlier versions of the driver produced that messsage for most
> unusual events.  The problem was that normal events combined with
> uncommon events would trigger the message.  The driver at scyld.com
> cleaned up the check for events that trigger the message long ago.

Yes, I saw that problem. How do you define
"unusual events". Right now your "Wicked" trap will catch
IntrTxUnderrun, IntrPCIErr, and any other interrupts not in
IntrNormalSummary that occur along MIIChange,StatsMax,LinkChange,
Underrun, Abort, or PCIErr, and issue a CmdTxDemand on each.
Was this the intention?


> There is a race condition when adding a new descriptor to the Tx
> descriptor list.  The driver might add the descriptor just a cycle too
> late, leaving the just-queued packet untransmitted.  It's safe to make
> extra calls to CmdTxDemand, so the driver does this after every packet
> is queued.

This is interesting. The reason why I started messing with the driver in
the first place was because my card was stalling. Some investigation
showed that 1 Tx Done interrupt clears 2 descriptor ownership bits
after which the card stalls. hmm.

> RxNoBuf doesn't apply.  In our case it will always occur in conjunction
> with IntrRxEmpty, which is the event we handle.

Okay, but you use it to call netdev_rx while you haven't included it
when setting the interrupt mask. The kernel driver does the same.
The same is true for IntrTxAbort and IntrRxWakeUp.
Also, why are there two interrupts that do the same thing according
to documentation (aborted and abort).

> See the datasheet.
> We handle it implicitly by refilling the Rx descriptors.

The kernel driver includes it in the interrupt mask
and never uses it explicitly. Should it be removed?

----------------------------------------------
Some additional interrupt questions:
IntrMIIChange is defined as Transmit Descriptor Underflow by the docs (??)
IntrRxDropped is defined as FIFO Overflow (??)


