Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317142AbSHGICf>; Wed, 7 Aug 2002 04:02:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317141AbSHGICe>; Wed, 7 Aug 2002 04:02:34 -0400
Received: from AMarseille-201-1-5-21.abo.wanadoo.fr ([217.128.250.21]:13168
	"EHLO zion.wanadoo.fr") by vger.kernel.org with ESMTP
	id <S317142AbSHGIC2>; Wed, 7 Aug 2002 04:02:28 -0400
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Grant Grundler <grundler@dsl2.external.hp.com>
Cc: Linux kernel mailing list <linux-kernel@vger.kernel.org>,
       Jeff Garzik <jgarzik@mandrakesoft.com>,
       "David S. Miller" <davem@redhat.com>, <ink@jurassic.park.msu.ru>
Subject: Re: PCI<->PCI bridges, transparent resource fix 
Date: Tue, 6 Aug 2002 23:02:20 +0200
Message-Id: <20020806210220.24665@192.168.4.1>
In-Reply-To: <20020807055456.61265482A@dsl2.external.hp.com>
References: <20020807055456.61265482A@dsl2.external.hp.com>
X-Mailer: CTM PowerMail 3.1.2 F <http://www.ctmdev.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>> Also, when a host bridge has more than one MMIO ranges, which is typically
>> the case on pmac, if you have a transparent PCI<->PCI bridge, you really
>> want to show that all of these MMIO ranges are exposed to the childs, thus
>> you want all of these resource pointers to get down to the bridge.
>
>This is wrong. PCI-PCI bridges can only forward one IO range, one MMIO
>range, and one MMIO-Prefetchable range. ("range" == address window).
>Any ranges in addition to that means it's not a PCI-PCI bridge.

Well, we are talking about transparent (substractive decoding) bridges here
right ? Those don't care about ranges.
If my host bridge expose one MMIO range at 0x90000000..0x9fffffff and one
at 0xf2000000..0xf2ffffff, a transparent bridge below that host bridge will
actually forward both of these ranges, right ?

>By explicitly setting resource[1] of the parent to the MMIO range,
>arch specific code *knows* which MMIO range the PCI-PCI bridge
>will forward.
>
>Are you trying to address the following kind of problem?
>	o Host Bridge 00 forwards MMIO 0xf1000000-0xf1100000 and
>		MMIO 0xf1800000-0xf1900000.
>	o PCI-PCI Bridge 00:01.0 forwards MMIO 0xf1000000-0xf1100000
>	o PCI-PCI Bridge 00:02.0 forwards MMIO 0xf1800000-0xf1900000
>
>I'm hoping you'll have real data tomorrow for the problem machine.
>But a yes/no/"don't know" answer would be sufficient.

A typical setup found on mac is indeed to have the bridge forward
2 regions, but then, you may have a transparent bridge hanging
on the bus. I'm not talking about changing the behaviour of a bridge
that defines it's forwarding MMIO region, I'm talking about
not copying parent resources blindly for _transparent_ bridges,
but instead do it based on the flags.

The problematic machine I have at hand here is a bit different.
It does have 2 exposed MMIO regions, but doesn't have problem
with transparent bridge because of that (which isn't the case
of other pmac setups).

It has the host exposing 2 MMIO regions:

80000000-9fffffff
and
f3000000-f3ffffff

On that bus, it has 2 PCI-PCI bridges setup by the firmware
in an "interesting" way:

The first one has
bridge resource 0, base: 1000, limit: 0
bridge resource 1, base: 80000000, limit: 80000000
bridge resource 2, base: 80000000, limit: 7ff00000

The second has
bridge resource 0, base: 1000, limit: 0
bridge resource 1, base: 80100000, limit: 8ff00000
bridge resource 2, base: 80100000, limit: 80000000

As you can see, for both of them, the firmware only enable
one decoded MMIO region, and closed the IO and the prefetchable MEM
region. 

The current code would consider the prefetchable MEM region as
transparent, which seems plain wrong in this case. Thus my idea which
was to change the routine to consider the bridge as either fully
transparent for MMIO of _both_ MMIO windows are closed or not at all
(thus only using the MMIO window that is opened, leaving the resource
for the other one closed, shouldn't harm anybody).

Now, Ivan claims we shouldn't do that, but we should look for the
bit that states if a bridge is fully transparent, use that, and if
not, keep the window closed at this point and eventually assign new
ones later one. That would be the best mecanism, I agree, but
that's also, iirc, what Linus didn't want because of issues with
non standard bridges. (I have never seen such a bridge here though
it may be worth digging in the list archives. I'm about to leave
for a few days without good internet connexion though, I won't be
able to do that research before I'm back).

>...
>> The distinction between mem and prefetchable mem is, I think, irrelevant
>> when dealing with transparent bridges.
>
>Sorry - my gut feeling is it matters.  I need something better
>than "I think" before I can agree with that statement.
>For IO, cacheable vs un-cacheable addresses are worlds apart.

Well, look what a transparent bridge does at the HW level please.
How would it matter if the bridge is doing substractive decoding ?

>> >Maybe you haven't looked at other arches yet?
>> 
>> I know archs may call other functions for actually setting up the
>> bridges, I actually didn't look at that closely. This is the main
>> reason why I post that patch for discussion and not as something
>> to be included ;)
>
>ok. When implementing parisc PCI support, I looked alot at alpha,
>sparc64, and x86 code to understand how the peices fit together.
>parisc introduced some new issues neither of the above had to solve.
>Ivan's PCI code changes from 2.5.x took those problems into consideration
>and I helped test. Sounds like we need to iterate once the real
>problem is clear. You might consider looking at 2.5.30 before
>getting too hung up in a fix for 2.4.
>
>...
>> Basically, the information that the ordering gives us (basically if
>> it's an IO, MEM or prefetchable MEM region) is already present in
>> the resource flags structure. Let's use that.
>
>I'm sorry; I've still not understood the problem you are trying to fix
>by removing this assumption.

The problem fixed by removing the above asumption is when you have
a host bridge whose resource layout is different than the one of a
PCI<->PCI bridge, and then stuff a transparent PCI<->PCI bridge
below it.

But as Ivan implies in his other email, I feel the whole point is
that the bridge is either fully transparent, not transparent at all.
The current way of picking "some" bridge resources as transparent
when they are actually closed seems wrong. In the case of a fully
transparent bridge, just copying down pointers to all the 4 parent
resources would work just fine for me.

>> >From another angle, I could call that a bug. PARISC also gets
>> >the IO and MMIO routing information from host firmware.
>> 
>> Maybe, though I don't remember seeing explicitely that there is a
>> requirement for host bridge resources ;)
>
>Lots of things required of the arch support aren't explicitly specified.
>Only a handful (or two) people on this planet ever muck with arch PCI
>support and no one has felt it was worth writing a HOW-TO.
>
>If you write up an initial draft for linux/Documentation/pci-bios.txt,
>I'll review and comment on it.

Heh, well, i'm afraid I may not have time for that now, and I carefully
avoid some of the matters with legacy IOs address aliasing and other
similar cruft (that don't happen in practice on PPC machines) so I
wouldn't be able to document that.

>...
>> >It's not necessary but it's simple and easy to understand.
>> >I guess I still don't understand why it needs to be fixed.
>> 
>> I'm having some troubles with the current code, because of the
>> host bridge beeing setup with a different layout for one,
>
>This sounds like something you can fix in the arch specific code.

Sure. I wanted to raise the issue as the generic code seemed wrong
to me at that point. Of course I can (and will have to) fix that
in the arch code for now (that is for 2.4).

>> and
>> because the current code mixing transparent and non-transparent
>> regions
>
>regions aren't "transparent" - it's the bridge that's transparent.

Yup, here we agree. So why does the code in there does the
transparency thing on a per-region basis ?

>> when only one of the 2 MMIO regions is configured, causing
>> some interesting conflicts to happen when I have several neighbour
>> bridges and devices below them.
>
>If different MMIO regions route to different sibling PCI-PCI bridges
>(both P-P bridges are children of the same parent), that is a problem
>we can't solve in the generic code.
>I suspect you'll have to add some cruft to your pcibios_fixup_bus()
>to handle this properly.

Why not just consider than a PCI<->PCI bridge with one window open
and the other closed is just that... that is a PCI<->PCI bridge
forwarding 1 window, period. Currently, we make it a resource for
the window it forwards, then copy the other resource from the host
when we find it closed, which makes it "half transparent". That's
one of the things I'm trying to fix.

>> I'm afaid I may not have been clear here. There are 2 different
>> issues I'm dealing with that patch: One is that I _think_ it
>> doesn't make sense to have a "half transparent" bridge (that is
>> transparent for MMIO but not prefetch MMIO or the opposite), so
>> if one of the 2 regions is set, don't assume we deal with a
>> transparent bridge.
>
>pci_read_bridge_bases() handles each resource seperately.
>I prefer Ivan's suggestions on dealing with tranparent bridges.

I do too. Though according to the kernel resource management
mecanism, I beleive it's quite safe to incorrectly consider a
bridge with all resources closed as beeing 'transparent'
as such a bridge typically have no devices below it (which is
why the firmware closed it). That would also make Linus happy
with his problem of considering bridges we don't fully understand
as transparent (if I can ever find back his old email...)

So that would give us a pci_read_bridge_bases() that does what
it does today, except for the infamous "else { consider
transparent }" case. Instead, just add bits to a mask.

Then, at the end of the funcition, if that mask indicates all
resources where closed, then consider the bridge transparent
and copy all of the parent resources.

What my previous proposed code does is to do it on a per resource
type basis (thus allowing transparent PIO and non transparent
MMIO) but that may actually not be possible in read life (at
least not following the PCI<->PCI spec)

>
>> The other one is that when the bridge is
>> assumed transparent, copy down all the resource pointers of the
>> parent matching that resource type instead of relying on the
>> parent ordering, so if the parent (host) exposes 2 disctint
>> MMIO regions, then the transparent bridge will properly expose
>> the fact that it's actually forwarding MMIO transactions for those
>> 2 regions.
>
>The host can forward as many MMIO regions as it is capable of.
>The PCI-PCI bridge can only forward one (of each type).
>I'll keep telling you that until you get it.

I won't get it for a transparent bridge, sorry ;)

A transparent bridge does substractive decoding. It will forward
a cycel to _any_ address that have not been claimed by another
device on the same segment. Thus, it will forward all of the
regions exposed by the host

>...
>> If a bridge has an MMIO region well
>> defined (typically in the case I have to deal with, the normal one)
>> and the other "closed" (in my case the prefetch one), should the
>> bridge be considered as transparent or should we only forward the
>> defined MMIO region ?
>
>Look at setup-bus.c again in 2.4.18. Each type of range is
>handled seperately. It should only forward the MMIO region.
>If the prefetchable base and limit are not set correctly to indicate
>the range is "closed", it's a BIOS/Firmware bug which your arch support
>needs to work around.

They _are_ setup correctly !

But pci_read_bridge_bases will incorrectly assume a "closed" region is
transparent.
Thus we end up with both an explicit mem region and a copy of the parent
region, a "half transparent" bridge, which makes no sense.

>
>> If we decide it's fully transparent, we take the risk of having
>> the kernel assign resource for childs that won't actually be
>> forwarded by the bridge.
>
>yup.
>
>...
>> I don't have the offending box at hand right now, I'll find something
>> tomorrow. I hope I've been more clear this time anyway ;)
>
>Please do. Getting closer to the core problem at least. ;^)

There are several problems mixed here, what makes it a tad difficult ;)

One of them is the host having several MMIO regions an a transparent bridge,
one of them beeing the host not respecting the ordering of a PCI<->PCI
bridge (thus breaking the current transparent code in some cases), and
one of them beeing the current code considering bridges with only one of
the MMIO regions configured as "half transparent".

Ben.

