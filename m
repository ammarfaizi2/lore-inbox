Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131036AbQLKXuI>; Mon, 11 Dec 2000 18:50:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131156AbQLKXt6>; Mon, 11 Dec 2000 18:49:58 -0500
Received: from pizda.ninka.net ([216.101.162.242]:45184 "EHLO pizda.ninka.net")
	by vger.kernel.org with ESMTP id <S131036AbQLKXto>;
	Mon, 11 Dec 2000 18:49:44 -0500
Date: Mon, 11 Dec 2000 15:03:24 -0800
Message-Id: <200012112303.PAA01350@pizda.ninka.net>
From: "David S. Miller" <davem@redhat.com>
To: groudier@club-internet.fr
CC: mj@suse.cz, lk@tantalophile.demon.co.uk, davej@suse.de,
        linux-kernel@vger.kernel.org
In-Reply-To: <Pine.LNX.4.10.10012112250330.2255-100000@linux.local> (message
	from Gérard Roudier on Mon, 11 Dec 2000 23:07:01 +0100 (CET))
Subject: Re: pdev_enable_device no longer used ?
In-Reply-To: <Pine.LNX.4.10.10012112250330.2255-100000@linux.local>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

   Date: Mon, 11 Dec 2000 23:07:01 +0100 (CET)
   From: Gérard Roudier <groudier@club-internet.fr>

   So, if you want to fix this insane PCI interface:

   1) Provide the _actual_ BARs values in the pci dev structure, otherwise 
      drivers that need them will have to deal with ugly hackery or access 
      explicitely the PCI configuration space.

Tell me one valid use of this information first :-)

a) If you want to use it to arrive at addresses MEM I/O operations
   you need to go through something akin to ioremap() first anyways.

b) If you wish to interpret the BAR values and use them from a BUS
   perspective somehow, you still need to go through some interface
   because you cannot assume what even the hw BAR values mean.
   This is precisely the kind of interface I am suggesting.

   Consider even just that top few bits of BAR values on some system
   have some special meaning, and must be masked out before used from
   PCI device side transactions.  Perhaps these bits are interpreted
   somehow at the host bridge when CPU accesses to device MEM or I/O
   space are made.  I argue not that this is compliant behavior, I
   argue only that it is something idiots designing hardware will in
   fact do.  We have seen worse things occur.  Now, subsequently, if
   we start using raw BARs in drivers these systems (however important
   or not important) will become difficult to impossible to support.
   Here the blacklists will end up in your driver, which is where I
   think both of us will agree they should not be :-)

   2) Provide an interface that accepts the PCI dev and the BAR offset as
      input and that return somes cookie for read*/write* interface.
	  GiveMeSomeCookieForMmIo(pcidev, bar_offset).

I do not understand why ioremap() is such a bletcherous interface
for you :-)  You take resource in PDEV, add desired offset, and pass
it to ioremap().  What about this sequence requires you to take pain
killers? :-)  It seems quite straightforward to me.

We do not want to expose physical BARs because you as a driver have
no way to portably interpret this information.  On the other hand
if you tell us "Given PDEV resource X, plus offset Y, give me this
address in BUS space" we can do that and that is the interface that
makes sense and is implementable on all architectures.  This is what
I am proposing for adding asm/pci.h

Having people read and intepret BARs is not implementable on all
architecures (see discussion in (b) above).

I guess there is some fundamental reason you do not like the kernel
trying to discourage access to physical BARs.  This makes things so
much easier and cleaner, at least to me.

I bet we end up in standstill here and ifdef hacks remain in symbios
drivers :-)))  We will see...

Later,
David S. Miller
davem@redhat.com
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
