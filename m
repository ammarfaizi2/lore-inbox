Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S312308AbSDEFwt>; Fri, 5 Apr 2002 00:52:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S312320AbSDEFwj>; Fri, 5 Apr 2002 00:52:39 -0500
Received: from ucsu.Colorado.EDU ([128.138.129.83]:35215 "EHLO
	ucsu.colorado.edu") by vger.kernel.org with ESMTP
	id <S312308AbSDEFwX>; Fri, 5 Apr 2002 00:52:23 -0500
Content-Type: text/plain; charset=US-ASCII
From: "Ivan G." <ivangurdiev@yahoo.com>
Reply-To: ivangurdiev@yahoo.com
Organization: ( )
To: Urban Widmark <urban@teststation.com>
Subject: Re: Via-Rhine stalls - transmit errors
Date: Thu, 4 Apr 2002 22:47:05 -0700
X-Mailer: KMail [version 1.2]
Cc: LKML <linux-kernel@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <02040422470505.00758@cobra.linux>
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> (A week is probably a personal record ... just hasn't been
> time to think about funny rhine problems)

Well, thanks for even bothering with my problems.
Appreciate it.

Inconsistent hardware tests are driving me insane.
I am beginning to think that I am wasting both my and your
time by doing such testing. My card is stalling again and
I have no idea why. I think I should start concentrating more
on software code and what it does, rather than judging by
the way hardware "seems" to work. For some reason
I never know what to expect when I reboot
that computer and try again.

Because of those problems, I think that I should list all
the things that I have added or consider adding to my
version of the driver and, with your help (if you have time
for this stuff), decide which ones to keep and integrate into
a patch, and which ones to abandon. This way, at least I would
know that my conclusions/confusions are based on the cleanest
code possible at the moment. Also, at least some improvement
will come out of this, while fixing my card transmit is an
unsure thing.

So:
Here we go...
Enumerated list of all issues I'm concerned about...
Please approve or disapprove changes if you have time :)

1) Type of chip

Attempting to fix any device clearly requires knowing what
kind it is. I obtained my ethernet card from a friend and was
unsure about the model - I know that it has a davicom 9101f
chip on it. So far, I thought my card was a VT86C100A, because
that's what /proc/pci says. However, I see now the driver
and via-diag identify the card as VT3043 Rhine. What could
cause the inconsistency and how can I check for sure?


Related code:
In the meantime, trying to check that
I ran into the following issue:
init one: chip_id: 2
wait for reset, chip_id: 0
wait for reset, chip_id: 2
(these are my own debug messages)

Cause of the problem: The first time wait_for_reset is called
(in init_one)  np->chip_id is not initialized.
Effect of the problem: Delay code for 3043
and VT86C100A will also affect the Rhine-II
the first time wait_for_reset is ran since chip_id
is always 0. Fix: Unsure of the best way to fix.

Related code:
I am also concerned about this:
In via_rhine_error there is code
related to link change that includes HasDavicomPhy.
HasDavicomPhy is not included in the chip_info
structure of any of the three chips supported.
According to the other drivers I've seen
it should be. Fix: Should I add that flag
to the 3043 and the VT86C100A? if those
are the right cards.


2) Full duplex.
So far I've been ignoring the fact that my transmit,
whenever it works, however it works, is very very slow.
I use two cards capable of full duplex over a crossover
cable. The driver and diagnostic programs of both
cards report full duplex speed. However, my transfer speed,
even if not stalling does not exceed 1.5mb/s.
I assumed transmit errors were responsible,
however: while I was changing the driver
I ran into a situation where my card was actually
transmitting at the speed it is supposed to - 7Mb/s+
I couldn't reproduce the situation. Do you think
this is related to the transmit errors or it is a duplex
negotiation issue?

3) The missing interrupts

I added those. There's 3 or 4 of them.

4) Queue debug message

   printk(KERN_DEBUG "%s: Transmit frame #%d queued in slot %d.\n",
                           dev->name, np->cur_tx-1, entry);

   Changed np->cur_tx to np->cur_tx-1.
   I thought the frame was one off...

5) The abort handling in linuxfet vs. kernel driver
The underflow handling in linuxfet vs. kernel driver

You say that the descriptor status
is only used to log errors in the kernel.
Is this correct handling? Why does the linuxfet
driver set the ownership bit and send
CmdTxOn, CmdTxDemand in cases of abort and underflow?
How would the hardware react to such handling?
What's a good resource to check on those commands?
The datasheets are not very verbose.

I'll do tests on ownership bit
and descriptor status myself.
I would just like to clear those other
issues since they might interfere...

6) Rx Threshold

...defaults to 0x60 in kernel driver
and 0xE0 in another one I've seen -
either linuxfet or Becker. Which is correct?

7) Those "Wicked" messages

Ok. I understand why you could have a case
to handle any weird interrupt combinations
combining error interrupts and others
(such as Abort/Done).
However, how do you explain Becker's driver...

  if ((intr_status & ~(IntrLinkChange | IntrMIIChange | IntrStatsMax |
                  IntrTxAbort|IntrTxAborted | IntrNormalSummary))

it excludes IntrNormalSummary from those messages.
TxAbort/TxDone would be excluded in this case.
Exactly what kind of error should this message trap?

8) Some other information:
cat /proc/net/dev
on desktop (the via card) shows transmit errors.
cat /proc/net/dev
on laptop (the netgear opp. card) shows
large amounts of packets under FRAME.

-----

Ok, this is all for now.
I apologize for the long message
and any confusion I'm creating.
Just trying to help. I would really like to fix
this driver but I don't seem to be very good at this.
I will do additional testing with ownership bits
and try changing tresholds, etc..

