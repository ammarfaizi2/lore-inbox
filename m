Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S312626AbSCVCdc>; Thu, 21 Mar 2002 21:33:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S312628AbSCVCdY>; Thu, 21 Mar 2002 21:33:24 -0500
Received: from web10108.mail.yahoo.com ([216.136.130.58]:4880 "HELO
	web10108.mail.yahoo.com") by vger.kernel.org with SMTP
	id <S312626AbSCVCdO>; Thu, 21 Mar 2002 21:33:14 -0500
Message-ID: <20020322023313.99572.qmail@web10108.mail.yahoo.com>
Date: Thu, 21 Mar 2002 18:33:13 -0800 (PST)
From: Ivan Gurdiev <ivangurdiev@yahoo.com>
Subject: Re: Via-Rhine stalls - transmit errors
To: "Richard B. Johnson" <root@chaos.analogic.com>
Cc: Andy Carlson <naclos@andyc.dyndns.org>, linux-kernel@vger.kernel.org
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Okay...let's see.
I've been playing around with Urban's patch
and now I'll risk making a fool of myself 
sharing some of my 'ideas' - heh.

ISSUE 1: Those "Something Wicked" messages
Present in original and patch too.

> if ((intr_status & ~( IntrLinkChange | IntrStatsMax
|
>  IntrTxAborted ))) {

Richard,
Isn't this bitwise AND with a complement...
Meaning negation?
The way I understood it:
If this is an interrupt that is NOT IntrLinkChange,
IntrStatsMax or IntrTxAborted, we don't know what's
going on but it can't be good so print error message
and reset the chip.....a block designed to trap 
all other problems at the end of the error function.

I still don't see the point behind this. 
The function via_rhine_error is called only once like
this:
 if (intr_status & (IntrPCIErr | IntrLinkChange |
IntrMIIChange | IntrStatsMax | IntrTxAbort | 
IntrTxUnderrun))
     via_rhine_error(dev, intr_status);

so if none of those interrupts are present,
the error function won't even be called.
So why check for anything else?

Inside error function:
     if (intr_status & (mii | IntrLinkChange)) {
takes care of IntrLinkChange and IntrMIIChange

     if (intr_status & IntrStatsMax) {
takes care of IntrStatsMax
    
     if (intr_status & (underflow | IntrTxAbort)) {
takes care of IntrTxUnderflow and IntrTxAbort

     if (intr_status & IntrTxUnderrun) {
takes care of IntrTxUnderrun

only IntrPCIErr is missing....that could have 
trigged this function call...
so why don't just add:
        if (intr_status & IntrPCIErr) {
		-do error message
		-reset chip
and get rid of the "Wicked" checks...
They prints misleading error messages...
Maybe I'm missing something.

   
ISSUE 2: Repetitive negotiation of full duplex
Created by the Urban patch.

Andy,
Um...
I did some printouts and ended up with duplex being
256....probably because of:  duplex = mii_reg & 0x100;
Also: np->mii_if.full_duplex = duplex; refused
to set full_duplex to 256 (?)

I am not sure but I believe, based on other code,
that duplex is supposed to be 0 or 1.

changed to 
duplex = (mii_reg & 0x100)? 1:0;
and it's working fine now - negotiates only once.
full_duplex actually changes...

ISSUE 3:  Well, my card is still stalling.
But I should probably leave this to somebody
who actually has a clue about those things.
The log looks a lot cleaner now, though:

.....
Mar 21 19:04:10 cobra kernel: eth0: Transmitter
underflow?, status 001a.
Mar 21 19:04:10 cobra kernel: eth0: Transmitter
underrun, increasing Tx threshold setting to 40.
Mar 21 19:04:15 cobra kernel: eth0: Transmitter
underflow?, status 0008.
Mar 21 19:04:15 cobra kernel: eth0: Transmitter
underflow?, status 0008.
Mar 21 19:04:19 cobra kernel: NETDEV WATCHDOG: eth0:
transmit timed out
Mar 21 19:04:19 cobra kernel: eth0: Transmit timed
out, status 0000, PHY status 782d, resetting...
Mar 21 19:04:19 cobra kernel: eth0: reset finished
after 5 microseconds.
Mar 21 19:04:24 cobra kernel: eth0: Transmitter
underflow?, status 001a.
Mar 21 19:04:24 cobra kernel: eth0: Transmitter
underrun, increasing Tx threshold setting to 40.
Mar 21 19:04:24 cobra kernel: eth0: Transmitter
underflow?, status 000a.
Mar 21 19:04:29 cobra kernel: NETDEV WATCHDOG: eth0:
transmit timed out
Mar 21 19:04:29 cobra kernel: eth0: Transmit timed
out, status 0000, PHY status 782d, resetting...
Mar 21 19:04:29 cobra kernel: eth0: reset finished
after 5 microseconds.
Mar 21 19:04:36 cobra kernel: eth0: Transmitter
underflow?, status 0008.
Mar 21 19:04:36 cobra last message repeated 2 times
Mar 21 19:04:39 cobra kernel: NETDEV WATCHDOG: eth0:
transmit timed out
Mar 21 19:04:39 cobra kernel: eth0: Transmit timed
out, status 0000, PHY status 782d, resetting...
Mar 21 19:04:39 cobra kernel: eth0: reset finished
after 5 microseconds.
...........

So?
Is any of the above correct?
Or am I really close to frying my ethernet controller?
:)
Either way, changing stuff in the kernel's been fun.
I'll investigate some more.

Also: an off-topic question...
How do I reply to a particular message..
So that my messages appear in thread format
with more than 1 level...
In-Reply To rather than Maybe In Reply-To
This thread is starting to grow and I'd like to know.


__________________________________________________
Do You Yahoo!?
Yahoo! Movies - coverage of the 74th Academy Awards®
http://movies.yahoo.com/
