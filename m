Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317025AbSHHIRB>; Thu, 8 Aug 2002 04:17:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317373AbSHHIRB>; Thu, 8 Aug 2002 04:17:01 -0400
Received: from smtp-out-2.wanadoo.fr ([193.252.19.254]:30924 "EHLO
	mel-rto2.wanadoo.fr") by vger.kernel.org with ESMTP
	id <S317025AbSHHIRA>; Thu, 8 Aug 2002 04:17:00 -0400
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Ivan Kokshaysky <ink@jurassic.park.msu.ru>
Cc: Grant Grundler <grundler@dsl2.external.hp.com>,
       Linux kernel mailing list <linux-kernel@vger.kernel.org>,
       Jeff Garzik <jgarzik@mandrakesoft.com>,
       "David S. Miller" <davem@redhat.com>
Subject: Re: PCI<->PCI bridges, transparent resource fix
Date: Thu, 8 Aug 2002 10:20:15 +0200
Message-Id: <20020808082015.20733@smtp.wanadoo.fr>
In-Reply-To: <20020807200311.A5566@jurassic.park.msu.ru>
References: <20020807200311.A5566@jurassic.park.msu.ru>
X-Mailer: CTM PowerMail 3.1.2 carbon <http://www.ctmdev.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>Ok. Assume that additional window is 0xf2000000-0xf2ffffff.
>I'd try the following:
>- set the _single_ memory resource of the root bus to 0x80000000-0xf2ffffff;
>- create dummy memory type resource 0xf0000000-0xf1ffffff and "claim" it
>  on the root bus. This will prevent all further allocations in the
>  gap between two MMIO windows.
>I think it should seriously simplify the things.

Unfortunately that wouldn't work as I actually have 3 host bridges
on these models, and the windows can be "mixed". One host can have
0x80000000 to 0x9ffffffff (and one region at 0xfx000000), The next
one can have 0xa0000000 to 0xaffffffff and another region at
0xfx000000, etc...

>> Ok, here we need Linus answert. We did have a patch in the PPC tree
>> that was consideing closed resources as really closed instead of
>> transparent, and we were told by Linus that there were non standard
>> bridges and various issues in the x86 world with that, and that those
>> would remain transparent. I don't have pointers at hand, but I think
>> this was dicusssed on lkml several monthes ago.
>
>I recall that. I do agree with Linus, but only about bridges with
>class code 0x60401 (subtractive decoders). The details of operating in
>subtractive decoding mode are beyond the scope of the P2P bridge specs,
>and probably we don't want to know these details either. "Assuming
>transparent" is a sufficient workaround in this case.

Agreed.

>Some additional notes. The P2P bridge specification says:
>"The primary use of a subtractive decoding bridge is to connect
> a laptop system to a docking station and support legacy ISA devices
> in the docking station."
>
>Indeed, that "transparency" code had been added to fix P2P bridge problems
>on some Dell docking station (reported by Jamal) back in the 2.4.0-test
>times. Unfortunately, lspci output of that machine hasn't been posted
>(or I just missed that). However, I'm sure that the problematic bridge
>did have ProgIf code 1, otherwise that type of machines would have
>problems running Windows, as MS says:
>  "A  bridge  indicates  that  it  performs  subtractive  decode  if  its
>   Programming  Interface bit in the PCI Configuration Register is set to
>   01h.  Not  all  PCI-to-PCI bridges support subtractive decode. Windows
>   will  not  switch  a bridge from positive decode to subtractive decode
>   (or  vice  versa) because there is no standard method defined for this
>   action."
>
>For those who are interested, the entire document (zipped .doc) is
>http://download.microsoft.com/download/whistler/hwdev3/1.0/WXP/EN-US/
>pcibridge-cardbus.exe
>Not in the human readable form, sorry. ;-)
>
>> I'd set all 4 then, thus the bridge would really be seen as forwarding
>> all the regions of the host bridge, whatever they are.
>
>There are only 3, as Grant pointed out. :-)

Well, I as pointed out, I may actually need all 4 regions of the host ;)

Anyway, since we agree on copying down the parent regions, and the pci_bus
stucture holds 4 resource slots, then let's copy them all down.

I'll write some code about that when I'm back from vacation and we'll
see what's up. I may end up adding a quirk call inside the
pci_read_bridge_bases
functions so that it's behaviour can be easily overriden if we ever meet
a non-strandard enough bridge to be transparent without having ProgIf code 1

Ben.

