Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315205AbSDWNor>; Tue, 23 Apr 2002 09:44:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315206AbSDWNoq>; Tue, 23 Apr 2002 09:44:46 -0400
Received: from fungus.teststation.com ([212.32.186.211]:4367 "EHLO
	fungus.teststation.com") by vger.kernel.org with ESMTP
	id <S315205AbSDWNop>; Tue, 23 Apr 2002 09:44:45 -0400
Date: Tue, 23 Apr 2002 15:44:41 +0200 (CEST)
From: Urban Widmark <urban@teststation.com>
X-X-Sender: <puw@cola.teststation.com>
To: "Ivan G." <ivangurdiev@yahoo.com>
cc: LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] Via-rhine minor issues
In-Reply-To: <02042222071600.00745@cobra.linux>
Message-ID: <Pine.LNX.4.33.0204231504230.12853-100000@cola.teststation.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 22 Apr 2002, Ivan G. wrote:

> The tech sheets do not explain what causes the interrupts in detail, how to 
> handle the interrupts in detail. They rather provide the bit address of the 
> interrupt which is good to know, but not enough. What resources did Donald 
> Becker use when he was writing this?
> 
> Perhaps I should ask him.

He's the one who wrote:
"Recovery for other fault sources not known."

I have a feeling he didn't have any other sources, except that he had
written a whole bunch of other (similar) drivers before.

Some things you can try to guess:
RxEarly - An interrupt is sent when the chip begins to receive data. if
          the driver wants to do something when that happens then it
          should enable it. The current driver doesn't so it shouldn't be
          enabled.
Or something completely different.


> Well, most Rx errors are handled in via_rhine_rx.
> The "Wicked" error rule doesn't do anything besides a CmdTxDemand.
> Is this correct handling for, let's say RxOverflow?  ..Again, facing the
> overwhelming lack of documentation :) (see above paragraph)

One option is not to do anything.

Another to catch the event and call via_rhine_error on it. That will make
it print the "wicked" message and do a CmdTxDemand. Does it hurt to make a
CmdTxDemand when you don't really need it?

If you have a reason to think it hurts, then separate the events that you
do CmdTxDemand on:
	if (intr_status & ~IntrRxOverflow)
		writew(CmdTxDemand ...);
(which will still do a CmdTxDemand in all cases it used to do one, but
 not if the interrupt was just a IntrRxOverflow. I think.)

And the same for the other interrupt bits that weren't enabled.


> Plus, I've been making too many changes to my copy. It would be easier to 
> work over a clean kernel driver.  I would have less things to keep track of 
> that have been changed.

Nothing prevents you from having more than one copy of the driver in your
local tree(s). Since the driver is just one file that works ok, make a
copy of it when you have a version you "like". Then you can look back
later and compare.


> While we're talking about bugs, here's a (possibly ignorant) question:
> Do Rhine-III's have a place in the following? : 

Probably. You need to check if their docs also enable MMIO by flipping
that bit, then you could change the "chip_id == VT6102" part to be just an
else.


> Well, apart from things which are not precisely clear how to fix, 
> would you like to me to submit any portions of my patch for inclusion at all?

The wait_for_reset thing is clearly a bug, and the cur_tx-1 is probably
right too because you want the number it was queued as. So yes, send them
to Jeff.

/Urban

