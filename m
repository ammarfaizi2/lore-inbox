Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130897AbQLOT0e>; Fri, 15 Dec 2000 14:26:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131005AbQLOT0Z>; Fri, 15 Dec 2000 14:26:25 -0500
Received: from neon-gw.transmeta.com ([209.10.217.66]:59654 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S130897AbQLOT0L>; Fri, 15 Dec 2000 14:26:11 -0500
Date: Fri, 15 Dec 2000 10:55:26 -0800 (PST)
From: Linus Torvalds <torvalds@transmeta.com>
To: Martin Diehl <mdiehlcs@compuserve.de>
cc: Martin Mares <mj@suse.cz>,
        Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: yenta, pm, ioremap(!) problems (was: PCI irq routing..)
In-Reply-To: <Pine.LNX.4.21.0012151627280.713-100000@notebook.diehl.home>
Message-ID: <Pine.LNX.4.10.10012151042170.2255-100000@penguin.transmeta.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Fri, 15 Dec 2000, Martin Diehl wrote:
> 
> 3) The TI1131 is apparently not PCI PM 1.0 compliant. At least it seems it
> has been replaced by the 12xx series at the moment some major player
> required PCI PM 1.0 to get his "Designed for ..." label in '98 ;-)
> So I had to add some code to save and restore things like memory and io
> windows of the bridge which were lost after resume. This is implemented as
> a controller specific addon to the common yenta operations similar to the
> open/init case.

Fair enough.

> 4) The final bang was when I realized that after all that done the
> content of the CardBus/ExCA register space was total garbage after
> resume. And, even worse, it completely failed to restore - not even
> 0's written to it could be read back as such. This turned out to be a
> io-mapping issue! Believe it or not - my solution is to disable the
> cardbus controller in BIOS setup. The rationale is as follows:
> 
> - When controller is enabled the BIOS assigns BASE_0 to 0xe6000/0xe7000.
>   This is mapped to 0xc00e6000 by ioremap(). Everything works fine until
>   we suspend. Furthermore I've proved by use of virt_to_bus() and vice
>   versa the mapping is still there after resume. However the content is
>   not writeable anymore and contains some arbitrary garbage - which always
>   stays the same, even over cold reboot. But no Oops or so - just if
>   you were writing to /dev/null and reading some hardwired bytes.
>   Even unmapping it at suspend and remapping after resume did not help.

The ioremap() mappings will definitely still be there - those are kernel
data structures, and the suspend/resume won't do anything to them.

I'm surprised: "yenta_init()" will re-initialize the yenta
PCI_BASE_ADDRESS_0 register, but maybe there's something wrong there. Try
adding a pci_enable_device() to turn the device on and also re-route the
interrupts if necessary.

The above is fairly strange, though. I wonder if the problem is that
0xe6000 value: that's a pretty bogus address for a PCI window, as it's in
the BIOS legacy area. 

I suspect that the suspend/resume will do something bad to the BAT
registers, which control the BIOS area mapping behaviour, and it just
kills the forwarding of the legacy region to the PCI bus, or something.

I wonder if the PCI cardbus init code should just notice this, and force
all cardbus windows to be re-initialized. That legacy area address really
doesn't look right.

		Linus

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
