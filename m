Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130441AbRCCKgR>; Sat, 3 Mar 2001 05:36:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130443AbRCCKgH>; Sat, 3 Mar 2001 05:36:07 -0500
Received: from smtp-rt-14.wanadoo.fr ([193.252.19.224]:61155 "EHLO
	adansonia.wanadoo.fr") by vger.kernel.org with ESMTP
	id <S130441AbRCCKgB>; Sat, 3 Mar 2001 05:36:01 -0500
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Grant Grundler <grundler@cup.hp.com>
Cc: <linux-kernel@vger.kernel.org>, <linuxppc-dev@lists.linuxppc.org>,
        "David S. Miller" <davem@redhat.com>
Subject: Re: IO issues vs. multiple busses 
Date: Sat, 3 Mar 2001 03:45:22 +0100
Message-Id: <19350125201706.1788@mailhost.mipsys.com>
In-Reply-To: <200103021843.KAA29619@milano.cup.hp.com>
In-Reply-To: <200103021843.KAA29619@milano.cup.hp.com>
X-Mailer: CTM PowerMail 3.0.6 <http://www.ctmdev.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>Here are my comments directly responding to your mail.

Hi ! Thanks for taking the time to respond in details.

>Large systems have problems with I/O port space and legacy devices.
>There just isn't enough I/O port space to support large configs
>and ISA aliasing and all the other crud. That's why Intel is (a)
>ditching all the legacy crap in IA64 and (b) strongly encouraging
>people to use MMIO space on PCI.

Right. We need to decourage use of IOs, definitely ;)
I now tend to think that we shouldn't care about making a whole
architecture to handle those IO problems, but the simplest possible thing
that would fit our needs. (still for in-kernel matters)

>If you only support one type of bridge, you could avoid the indirect
>function call (which parisc-linux uses) and encode the access method
>directly in the inb/outb macros.

We do that now, and support IOs on one bridge only. However, some PCI
cards still require IO access and we do have several busses, so...
The reason why I'm getting this problem on the public place (again ?)
is that we are now faced with people who want to put video cards in both
AGP & PCI busses, those cards requiring accesses to some legacy VGA IOs
on each of their busses.

>Just note that processor speed is so much faster (and getter faster)
>than the ISA bus (and PCI-1X bus), that CPU overhead is mostly
>irrelevant to the cost of accessing IO port space. On older x86
>boxes it is relevant.

Right. That's my opinion too. But it's difficult to make everybody agree
on it ;) Even the simple mecanism Paul Mackerras did so that IOs to
non-existent devices don't kill the kernel (very small overhead) caused
some barking ;)

>parisc-linux has solved exactly that problem.

I have to look in more details. It's my understanding that you use high
bits of the IO address to store the HBA number and then use that to call
the proper access functions. That would solve the PCI IO problem (PCI cards
requiring IOs to BAR-mapped regions), but I don't see how it can fix the
problem of a card accessing legacy VGA addresses, except if you hand-fixed
the video drivers to fill those high bits before doing IOs.

If I understand things correctly, that mean that each card, instead of
accessing the legacy VGA port 0xpp, would instead access 0x00bb00pp
(or whatever mangling you use to stuff the HBA number).

>From the driver point of view, it's exactly the same as passing an "offset"
that would be added to the legacy address. So both methods (the one I describe
that would fit well for us) and yours can end up with the same driver-side API
which is to get an "IO base" for the bus a given card reside on.

The question is then to decide is all ISA busses are on a matching PCI bus,
in which case a simple unsigned pci_get_bus_io_base(int bus_no) -like function
would be enough, or if we want a scheme that supports other ISA-like busses ?

We could eventually decide to support only PCI, and additionally declare a
fake PCI bus for an ISA bus not matched to a PCI bus, whose config ops would
return no device in any slot.

Do we agree on this ? 

>I don't believe such a solution exists which is "cleaner" than
>what parisc-linux does and meets the same objectives. Right now,
>it's important the install be easy in order to make it easy for
>people to migrate from HPUX to parisc-linux. :^)

Well, from the driver point of view, I think it _do_ exist. Basically, the
driver will do inb/outb & friends. Whatever those function do in reality is
arch-dependant.
But we agree on the fact that in order for those functions to know on which
bus to tap, an additional information must be "cooked" inside the IO address
passed to them. That's why I'm proposing this notion of "io base".

Additionally, the same problem is true for ISA memory, when it exist
obviously.
I would indeed like to see the same function for
pci_get_legacy_mem_base(int bus_no)-like, that is allowed to return something
like ffffffff for informing the driver that this specific machine won't
support
ISA memory.

With those two simple functions, we could at least

 - fix the the fbdev's that need access to VGA regions so that they work on
   multiple bus systems properly
 - Have vgacon disable itself when there's no ISA memory (that can be
handled by
   reserving the region and thus preventing request_region from working
too, well,
   but that scheme would also simplify the various more/less hacked
macros used
   on all non-x86 archs to access the VGA memory).
 - Eventually have vgacon work on "any" bus, possibly by providing a kernel
   option telling it on which bus to look for a legacy VGA device (and
defaulting
   to whatever VGA device the PCI will find first). This way, vgacon
would work
   properly in most cases without arch-specific hacking.

Additionally, I beleive it would help making other legacy drivers (if
any) work on
non-0 busses (I'm thinking about IDE cards using legacy addresses, those
do exist),
and whatever.

The only thing that's annoying me in the fact that we keep tied to PCI is
that in
various embedded system, there is one (or more) ISA-like bus hanging
around with
legacy devices and no PCI, and abstracting a bit the notion of IO bus
would have
helped. But it seem that now, more embedded systems are also going toward 
in-CPU IOs anyway, along with eventually a PCI bus for the most expensive
ones,
so it may finally not be an issue in the long term.

>This might work for other arches. I'm pretty sure it won't for parisc.
>Again, the issue is the IO port space access method varies by HBA.

Well, as I said above, this can still be an arch-dependant implementation
detail provided that the driver-side interface for getting the "offset"
or whatever we call it that is applies to ISA addresses is common.

>I agree with davem on this.

I do too ;)

>But maybe for different reasons.
>The issue with exporting IO port regions is the access method.
>Access method varies by platform (for parisc arch) and I don't
>want to see user apps encoding the access method for specific platforms
>by default. If someone intentionally wants to build an app for a
>specific platform, that's different.

Right. DaveM idea, as we discussed it some time ago, is to abstract the
mapping
using mmap, and an ioctl that would provide some access information (stepping,
access size maybe, etc...). If really specific access methods are still
needed,
then they should be written specifically in the userland app too, there's no
workaround for that I can imagine. But the fact that those are needed can
probably be returned to userland by this ioctl via a specific result code or
whatever.

Ben.
