Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S291177AbSBLVAs>; Tue, 12 Feb 2002 16:00:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S291179AbSBLVAj>; Tue, 12 Feb 2002 16:00:39 -0500
Received: from gw.lowendale.com.au ([203.26.242.120]:30504 "EHLO
	marina.lowendale.com.au") by vger.kernel.org with ESMTP
	id <S291177AbSBLVA0>; Tue, 12 Feb 2002 16:00:26 -0500
Date: Wed, 13 Feb 2002 08:27:29 +1100 (EST)
From: Neale Banks <neale@lowendale.com.au>
To: Jonathan Woithe <jwoithe@physics.adelaide.edu.au>
cc: linux-kernel@vger.kernel.org
Subject: Re: Tulip oddity under 2.2.19 - possible bug?
In-Reply-To: <200202120033.g1C0X2b10435@wave.physics.adelaide.edu.au>
Message-ID: <Pine.LNX.4.05.10202130808030.19878-100000@marina.lowendale.com.au>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 12 Feb 2002, Jonathan Woithe wrote:

> In recent times I have encounted an oddity while using a tulip-based NIC
> under 2.2.19.  I am wondering whether it's associated with a known issue or
> whether it's indicating a hardware fault of some description.

Per chance, would this be a NetGear card?

> The kernel is the stock Linus 2.2.19 (as supplied in Slackware 8.0).
> 
> The arrangement: there are two machines conected with a crossed UTP cable. 
> One is the Linux box and the other is an NT4 box.  Both have identical NICs
> based on the Tulip chip (DEC 21041).
> 
> The symptoms: if both PCs are powered up simultaneously everything comes up
> fine - communication on the network proceeds normally.  If the NT box is for
> some reason reset (without the Linux box going down), the network connection
> is not re-established successfully once NT comes back up again.  Trying to
> ping the NT box causes the "tx/rx" led on the back of the linux NIC to
> blink, but nothing is sent back from the NT box.  Interestingly enough,
> ifconfig reports some carrier errors in the fault condition.  Rebooting the
> NT4 box doesn't fix the problem; however, doing
>   ifconfig eth0 down
>   ifconfig eth0 up
> on the Linux box does fix the problem.

Sounds similar to an old "known" problem.  In my case, arp wasn't
succeeding - debug by Keith Owens found that under some circumstances
sending an arp query resulted in a copy of the outgoing packet appearing
in the Rx ring/buffer (and not the reply, which was sniffed on the wire).
After much poking and sniffing, the conclusion of "bug on the card" was
looking highly likely.

If it's this bug, you should be able to work around it by any of:

(a) as above, downing and upping the interface
(b) switch the interface in and out of promisc mode
(c) pre-setting a static arp entry (on the Linux box).

and possibly:

(d) connect the Tulip to a switch (instead of "shared" media, like a hub).

> If the network isn't connected when the Linux box is booted, a similar
> problem occurs - once the network cable is connected the linux box needs the
> above ifconfig cycle to be run before the network connection is
> successfully established.

It may simply get back to a race as to which box arps first.  E.g. IIRC
'doze configured with a static IP address will (as a sanity check) arp for
its own address on bootup - this may be enough to prime the Linux arp
cache and avoid the problem.

[...]
> During or after the fault condition nothing is written to any log files to
> indicate a problem.

"Undetected errors are handled as if no error had occured" :-(

Does "arp -n" show an "incomplete" entry for the relevant IP address?

> Is this a known issue with a workaround available, or is it indicative of a
> hardware error?

Possibly both ;-)  I'd be really interested if you come up with any
"clean" fix/workaround.

HTH,
Neale.

