Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S282137AbRKWMhh>; Fri, 23 Nov 2001 07:37:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S282133AbRKWMhS>; Fri, 23 Nov 2001 07:37:18 -0500
Received: from jurassic.park.msu.ru ([195.208.223.243]:48647 "EHLO
	jurassic.park.msu.ru") by vger.kernel.org with ESMTP
	id <S282128AbRKWMg5>; Fri, 23 Nov 2001 07:36:57 -0500
Date: Fri, 23 Nov 2001 15:36:24 +0300
From: Ivan Kokshaysky <ink@jurassic.park.msu.ru>
To: Paul Mackerras <paulus@samba.org>
Cc: Linus Torvalds <torvalds@transmeta.com>,
        Richard Henderson <rth@twiddle.net>, linux-kernel@vger.kernel.org
Subject: Re: [patch non-x86] PCI-PCI bridges fix
Message-ID: <20011123153624.A2735@jurassic.park.msu.ru>
In-Reply-To: <20011122150418.A623@jurassic.park.msu.ru> <15357.29418.938012.421837@cargo.ozlabs.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <15357.29418.938012.421837@cargo.ozlabs.ibm.com>; from paulus@samba.org on Fri, Nov 23, 2001 at 08:49:30AM +1100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Nov 23, 2001 at 08:49:30AM +1100, Paul Mackerras wrote:
> There is code in pci_read_bridge_bases which will decide under some
> circumstances that a PCI-PCI bridge is transparent and set
> 
> 	child->resource[i] = child->parent->resource[i];
> 
> for i = 0, 1 or 2.  What will happen with your request_resource in
> this case is that the resource will end up being its own parent and
> its own child and all allocations against it will fail. :)

These code paths shouldn't be mixed in the first place, i.e. if
you use stuff in setup-bus.c, don't use pci_read_bridge_bases.
Basically, these are two different approaches to PCI setup:
"We trust our firmware" (i386, ia64) and "We are the firmware"
(alpha, arm, partially parisc).

> I hit this just yesterday on PPC.  On our RS/6000 boxes, if you have a
> PCI-PCI bridge with nothing behind it, the firmware will configure it
> with all the apertures closed, i.e. with base set larger than limit.

Right, as required by PCI-PCI bridge specs.

> Then pci_read_bridge_bases goes and decides that the bridge is
> transparent and consequently everything stops working. :(

I think that "assuming transparent" code is not correct. Yes, PCI-PCI
bridge specs allow "transparent" (i.e. subtractive decoding) bridges,
but such bridges must have a class code 0x60401. IMO, we need something
like this instead:

 	if (!dev)		/* It's a host bus, nothing to read */
 		return;
 
+	if (dev->class & 1) {
+		printk("Subtractive decoding bridge %s: assuming transparent\n",
+					dev->name);
+		for(i=0; i<3; i++)
+			child->resource[i] = child->parent->resource[i];
+		return;
+	}

Of course, this requires testing on problematic machines.
BTW, currently almost every PC user sees those "Unknown bridge resource"
messages just because a graphic card behind the AGP bridge doesn't use
IO or prefetchable memory...

Ivan.
