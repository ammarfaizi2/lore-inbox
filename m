Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317592AbSHGP74>; Wed, 7 Aug 2002 11:59:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317829AbSHGP74>; Wed, 7 Aug 2002 11:59:56 -0400
Received: from jurassic.park.msu.ru ([195.208.223.243]:56840 "EHLO
	jurassic.park.msu.ru") by vger.kernel.org with ESMTP
	id <S317592AbSHGP7z>; Wed, 7 Aug 2002 11:59:55 -0400
Date: Wed, 7 Aug 2002 20:03:11 +0400
From: Ivan Kokshaysky <ink@jurassic.park.msu.ru>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: Grant Grundler <grundler@dsl2.external.hp.com>,
       Linux kernel mailing list <linux-kernel@vger.kernel.org>,
       Jeff Garzik <jgarzik@mandrakesoft.com>,
       "David S. Miller" <davem@redhat.com>
Subject: Re: PCI<->PCI bridges, transparent resource fix
Message-ID: <20020807200311.A5566@jurassic.park.msu.ru>
References: <20020807042402.A4840@jurassic.park.msu.ru> <20020806203134.15708@192.168.4.1>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <20020806203134.15708@192.168.4.1>; from benh@kernel.crashing.org on Tue, Aug 06, 2002 at 10:31:34PM +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 06, 2002 at 10:31:34PM +0200, Benjamin Herrenschmidt wrote:
> Well, it's definitely not that specific since I know several host
> bridges that have several programmable windows to PCI, and those
> aren't PPC specifc. In the case of pmacs, the UniNorth bridge
> forwards up to 7 regions of 256Mb (0x80000000..0x8fffffff,
> 0x90000000..0x9fffffff, etc... up to 0xe0000000..0xefffffff),
> each of them beeing selected by a bit setup by the firmware.
> It then have additional 16 regions of type 0xfx000000 than can
> also be individually selected, some of them beeing reserved for
> IO and config space, but one of them beeing typically an additional
> memory window to the PCI bus.

Ok. Assume that additional window is 0xf2000000-0xf2ffffff.
I'd try the following:
- set the _single_ memory resource of the root bus to 0x80000000-0xf2ffffff;
- create dummy memory type resource 0xf0000000-0xf1ffffff and "claim" it
  on the root bus. This will prevent all further allocations in the
  gap between two MMIO windows.
I think it should seriously simplify the things.

> Ok, here we need Linus answert. We did have a patch in the PPC tree
> that was consideing closed resources as really closed instead of
> transparent, and we were told by Linus that there were non standard
> bridges and various issues in the x86 world with that, and that those
> would remain transparent. I don't have pointers at hand, but I think
> this was dicusssed on lkml several monthes ago.

I recall that. I do agree with Linus, but only about bridges with
class code 0x60401 (subtractive decoders). The details of operating in
subtractive decoding mode are beyond the scope of the P2P bridge specs,
and probably we don't want to know these details either. "Assuming
transparent" is a sufficient workaround in this case.

Some additional notes. The P2P bridge specification says:
"The primary use of a subtractive decoding bridge is to connect
 a laptop system to a docking station and support legacy ISA devices
 in the docking station."

Indeed, that "transparency" code had been added to fix P2P bridge problems
on some Dell docking station (reported by Jamal) back in the 2.4.0-test
times. Unfortunately, lspci output of that machine hasn't been posted
(or I just missed that). However, I'm sure that the problematic bridge
did have ProgIf code 1, otherwise that type of machines would have
problems running Windows, as MS says:
  "A  bridge  indicates  that  it  performs  subtractive  decode  if  its
   Programming  Interface bit in the PCI Configuration Register is set to
   01h.  Not  all  PCI-to-PCI bridges support subtractive decode. Windows
   will  not  switch  a bridge from positive decode to subtractive decode
   (or  vice  versa) because there is no standard method defined for this
   action."

For those who are interested, the entire document (zipped .doc) is
http://download.microsoft.com/download/whistler/hwdev3/1.0/WXP/EN-US/pcibridge-cardbus.exe
Not in the human readable form, sorry. ;-)

> I'd set all 4 then, thus the bridge would really be seen as forwarding
> all the regions of the host bridge, whatever they are.

There are only 3, as Grant pointed out. :-)

> That makes sense. This would also allow to spot that there is no device
> below a PCI<->PCI bridge when doing that assignement of unassigned
> resources, and thus to spot that the firmware may have indeed been
> right to close them and not to bother.

Exactly.

Ivan.
