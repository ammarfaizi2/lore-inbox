Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S313514AbSDQJeH>; Wed, 17 Apr 2002 05:34:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S313547AbSDQJeG>; Wed, 17 Apr 2002 05:34:06 -0400
Received: from s2.relay.oleane.net ([195.25.12.49]:20755 "HELO
	s2.relay.oleane.net") by vger.kernel.org with SMTP
	id <S313514AbSDQJeG>; Wed, 17 Apr 2002 05:34:06 -0400
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: "David S. Miller" <davem@redhat.com>, <david.lang@digitalinsight.com>,
        <vojtech@suse.cz>, <dalecki@evision-ventures.com>,
        <rgooch@ras.ucalgary.ca>, Linus Torvalds <torvalds@transmeta.com>,
        Linux Kernel Development <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] 2.5.8 IDE 36
Date: Wed, 17 Apr 2002 02:55:50 +0100
Message-Id: <20020417015550.11501@smtp.adsl.oleane.com>
In-Reply-To: <Pine.GSO.4.21.0204171029040.1258-100000@vervain.sonytel.be>
X-Mailer: CTM PowerMail 3.1.2 F <http://www.ctmdev.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>On Tue, 16 Apr 2002, Benjamin Herrenschmidt wrote:
>
>> >   I could be wrong, it's a 2.1.x kernel that they started with. I thought
>> >   that was around the time the fix went in.
>> >   
>> >Again, I did the fix 6 years ago, thats pre-2.0.x days
>> >
>> >EXT2 has been little-endian only with proper byte-swapping support
>> >across all architectures, since that time.
>> 
>> My understanding it that Tivo behaves like some Amiga's here
>> and has broken swapping of the IDE bus itself, not the ext2
>> filesystem.
>
>You mean Ataris and Q40/Q60s?
>
>I'm not aware if any Amiga IDE interface with byteswapped IDE interface.
Or it
>must be a very rare interface not supported by Linux anyway ;-)

My confusion then. We used to have these in the PPC tree, and I
suspected those were APUS related ;)

>> On PPC, we still have some historical horrible macros redefinitions
>> in asm/ide.h to let APUS (PPC Amiga) deal with these.
>
>In asm-ppc/ide.h? Didn't see them there.

Right, looks like they are gone lately. Well, the TiVO may have been one
reason for these though I don't think the support for this box has ever
made it into our main tree. It's possible that we had some broken PReP
or whatever early boxes.

>The main problem is that IDE use[sd] `inb' et al. for accesses, which is not
>valid for I/O on something other than ISA/PCI I/O space. So for m68k and APUS
>we have to do weird things. The new IN_BYTE() etc. should help a bit there,
>though.

We tweak on pmac by feeding the IDE layer with our controller virtual address
minus _IO_BASE (for non-PPC people, _IO_BASE is the virtual address of the
main PCI IO space, all inx/outx are relative to this). The pointer arithmetic
does the magic. It sucks, but works without redefining everything around.
I haven't looked at the new IN_BYTE stuff, though if it is IDE specific,
I'd rather see it called IDE_IN_BYTE. The current scheme sucks also because
inx/outx, at least on PPC, are a lot slower than normal MMIO access (one
reason beeing their ability to recovert from machine checks). It would be
nice for IDE to use it's own accessors on MMIO platforms. This has to be
a per-controller things though. A global macro is no good. You can (and on
some configs, you do have on the motherboard) both MMIO mapped controllers
and old-style IO mapped ones. One example is the B&W mac G3 which has both
the Apple MMIO mapped mac-io IDE controller and the CMD646 on the PCI bus.

Also, when applying the taskfile, I suspect we don't need strong barriers as
we do currently have, only on IO write barrier before actually writing the
command byte. But I would gladly leave the whole issue of redefining barriers
especially regarding IOs to Anton Blanchard ;)

Maybe the entire function for writing a taskfile register state to the
controller should be made a hwif indirect call. (On Darwin, they more or
less do that, along with a bitmask indicating which register has to be
applied, though I suspect the tests against this bitmask would eats pretty
much all of the benefit of removing the useless barriers).

>> Now, the problem of dealing with DMA along with the swapping is
>> something scary. I beleive the sanest solution that won't please
>> affected people is to _not_ support DMA on these broken HW ;)
>
>Agreed. And you have to disable DMA when accessing a disk that
originates from
>such a system on a sane box.

Agreed.

Ben.

