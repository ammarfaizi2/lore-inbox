Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S319495AbSH3IYH>; Fri, 30 Aug 2002 04:24:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S319498AbSH3IYH>; Fri, 30 Aug 2002 04:24:07 -0400
Received: from AMarseille-201-1-3-142.abo.wanadoo.fr ([193.253.250.142]:10608
	"EHLO zion.wanadoo.fr") by vger.kernel.org with ESMTP
	id <S319495AbSH3IYE>; Fri, 30 Aug 2002 04:24:04 -0400
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Ivan Kokshaysky <ink@jurassic.park.msu.ru>,
       Linus Torvalds <torvalds@transmeta.com>
Cc: Manfred Spraul <manfred@colorfullife.com>, <linux-kernel@vger.kernel.org>
Subject: Re: [patch 2.5.31] transparent PCI-to-PCI bridges
Date: Fri, 30 Aug 2002 11:28:25 +0200
Message-Id: <20020830092825.16543@192.168.4.1>
In-Reply-To: <20020830035318.A3224@jurassic.park.msu.ru>
References: <20020830035318.A3224@jurassic.park.msu.ru>
X-Mailer: CTM PowerMail 3.1.2 F <http://www.ctmdev.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>On Wed, Aug 28, 2002 at 10:35:38AM -0700, Linus Torvalds wrote:
>> I agree. There is absolutely no reason to artificially limit the "bus" 
>> structure to only three resoruces (and with hardcoded behaviour at that).
>
>I disagree. There was a very good reason for doing that - you can build
>PCI bus tree (up to 256 buses) _only_ with PCI-to-PCI bridges, and I'm
>absolutely sure that it will be true until PCI goes EOL.
>IMHO, tying the PCI bus to the PCI-to-PCI bridge makes sense -
>it's generic and can be used as abstraction.
>The code in setup-bus.c is all about that - you can start embedded
>system with completely uninitialized PCI and initialize it with
>just pci_assign_unassigned_resources(). Don't know why i386 and ppc32
>don't use this - on alpha we are using it for years. Oh, well... ;-)
>Note that we don't care about "transparent" bridges at all - we
>have everything properly allocated in the regular bridge windows.

THen why did the embedded folks at montavista redid their own
pci_auto version (it Marcelo tree since latest merge) ? Not that
I agree with them here, I haven't digged into that code yet and
I'm pretty sure it could ultimately be replaced by setup-bus, but
in it's current incarnation, setup-bus is definitely not suitable
for PPC32. I must also make sure on ppc32's like pmac and CHRP that
some critical devices do _NOT_ get moved around by the PCI code.

Then, _again_, regarding your limit of pci_bus to the capabiliti
of a P2P bridge, I would have no problem with that except that
you are also limiting the host bridge, and my problem is with
the host bridge.

Nothingin the PCI spec prevents my host bridge from declaring
scattered regions (and that is the case on some PPCs). So the
pci_bus structure of the root of that PCI domain must have
one resource per region, and wanting to absolutely stick the
layout of a P2P bridge to it makes no sense to me. (Both
the amount of resources in the pci_bus structure, but also
relying on the fixed ordering).

If I have a transparent PCI bridge connected to such a host
that expose several scattered regions, I, of course, want
that transparent bridge to copy down pointers to all parent
resources.

Of course, a "normal" P2P bridge would only expose 3 resources,
there is no problem with that.

I don't see why you insist on picking the P2P bridge as the basis
of the definition of a pci_bus structure. It's a limiting definition,
and again, the code wouldn't be much more complex, more bloated or
whatever by beeing slightly more generic...
>
>> There are examples of bridges that are very common and that can bridge at
>> least four resources: every single CarsBus bridge does that _today_. Right
>> now Linux only uses three of the 4 resources, but that's because we've
>> never needed to use more. The fourth one is allocated in case some cardbus
>> driver were to want to use it..
>
>True. But the cardbus bridge can handle only one device and the resource
>allocation is up to cardbus driver. The only way to extend the bus
>is to place the PCI-to-PCI bridge behind a cardbus bridge, and then
>we're returning to the starting point.

Well, I would argue why bother re-configuring a bridge that would have
properly been configured by the firmware in the first place, but
well... :)

>> In fact, even regular PCI bridges often bridge more than three resources: 
>> many have things like VGA pass-through etc, which would actually add up to 
>> at least _five_ regions that they bridge (the regular three, and the added 
>> VGA IO and MEM regions). Again, Linux doesn't actually care about this 
>> right now, but again it is absolutely _wrong_ to artificially limit Linux 
>> internally to some made-up (and wrong) notion of what a bridge is.
>
>Hmm. Regular bridges also have ISA mode; should we have 64(!) IO resources
>then it's enabled?
>I think that PCIBIOS_MIN_[IO,MEM] and pcibios_align_resource handle this
>legacy crap just nicely.

>> In short: if anything, we may at some point make the number of resources
>> _larger_, not smaller.
>
>Well, the pci_bus itself does not have any own resources - there are 4
>pointers to the real resources of the pci controller (host, pci or cardbus
>bridge etc.)
>So I suggest leaving only _one_ pointer, but to an array of resources
>(either pci_dev or arch specific). This will work.

And a count then... but that would work, yes.

>Not that I'm quite happy with this right now.
>
>I can't consider Ben's request for 4th resource slot as an argument because
>- he's trying to build child<->parent relationship on a resource
>  level between CPU and PCI address spaces. Which is generally impossible
>  (consider sparse addressing on alpha or io on parisc)

Hrm... Even if I did that, why wouldn't you consider a change making the
generic code slightly more generic to acomodate my construction ? You
would reject it just because your arch can't do the same ? :) Anyway,
While we do have root (CPU) memory & IO resources as parent of all resources
on PPC, it is not the reason why I need this 4th resource. It's for
describing the host bridge pci_bus of a given bus domain, the fact that
these host bridge resources are parented to root CPU resources isn't
relevant here

>- probably I have problems counting to 4 - as Ben said in earlier threads,
>  the ppc32 host bridge has 1 io and 2 memory ranges. ;-)

No, the pmac bridge has 1 IO and N memory ranges. It appears that in most
cases I dealt with on machines I actually own, I could coalesce the ranges
provided by the firmware to 1 IO and 2 memory (though those 2 memory are
both non-prefetchable), I know that when I wrote that code, I had a couple
of reports of users with problems because they had more.
Our arch code can and will eventually define host bridges with 4 resources
(and potentially more if we allowed it to). 

However, I do agree that hard-coding "4" (or "3") is no good here. Why not
just #define the number of resource slots of a pci_bus structure ? Couldn't
it be done so asm-xxx/pci.h can override it ?

>Ivan.


