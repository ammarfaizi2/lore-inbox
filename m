Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129289AbQLPAvu>; Fri, 15 Dec 2000 19:51:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129718AbQLPAvk>; Fri, 15 Dec 2000 19:51:40 -0500
Received: from r2167.muc.dial.surf-callino.de ([213.21.9.135]:1540 "EHLO
	notebook.diehl.home") by vger.kernel.org with ESMTP
	id <S129524AbQLPAvc>; Fri, 15 Dec 2000 19:51:32 -0500
Date: Sat, 16 Dec 2000 01:21:10 +0100 (CET)
From: Martin Diehl <mdiehlcs@compuserve.de>
To: Linus Torvalds <torvalds@transmeta.com>
cc: Martin Mares <mj@suse.cz>,
        Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: yenta, pm, ioremap(!) problems (was: PCI irq routing..)
In-Reply-To: <Pine.LNX.4.10.10012151042170.2255-100000@penguin.transmeta.com>
Message-ID: <Pine.LNX.4.21.0012160032430.500-100000@notebook.diehl.home>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 15 Dec 2000, Linus Torvalds wrote:

> I'm surprised: "yenta_init()" will re-initialize the yenta
> PCI_BASE_ADDRESS_0 register, but maybe there's something wrong there. Try

right - but it is just writing back the bogus 0xe6000 thing.

> adding a pci_enable_device() to turn the device on and also re-route the
> interrupts if necessary.

Tried: nothing changed. For the TI1131 only the bridge windows are lost,
not resource 0. It's still there and appears valid to the kernels best
knowledge - no need for re-negotiation.

> The above is fairly strange, though. I wonder if the problem is that
> 0xe6000 value: that's a pretty bogus address for a PCI window, as it's in
> the BIOS legacy area. 

I've just hacked down the pci resource allocation (namely pci-i386.c) in
such a way to always assign insane 0xe6000/0xe7000 to the base resource 0
(register memory) similar to what the BIOS does. Same result: working
until suspend, identical RO garbage thereafter. Seems it's really a bad
choice to map PCI memory to this area - at least for this box.

> I suspect that the suspend/resume will do something bad to the BAT
> registers, which control the BIOS area mapping behaviour, and it just
> kills the forwarding of the legacy region to the PCI bus, or something.

sounds reasonable wrt what I've seen - Don't trust the BIOS.

> I wonder if the PCI cardbus init code should just notice this, and force
> all cardbus windows to be re-initialized. That legacy area address really
> doesn't look right.

Should work - identify all (bad mapped) regions, free them, and let
pci_enable_device() make things fine. However, I'd suggest doing this at
initial pci device scan since
- not only cardbus devices might be misconfigured by the BIOS
- no need for sanity check in every pci-capable driver.
- similar stuff needed for transparent hotplugging
Loosing part of this later at suspend is a different issue which may
deserve fixing at per-driver basis. But broken PCI memory mapping to BIOS
legacy area should be corrected from the very beginning, I believe.

Regards
Martin

-----
FYI - /proc/iomem showing broken iomapping from BIOS
(the 53c810 might better be page-adjusted too):

00000000-0009fbff : System RAM
0009fc00-0009ffff : reserved
000a0000-000bffff : Video RAM area
000c0000-000c7fff : Video ROM
000e6000-000e6fff : Texas Instruments PCI1131
000e7000-000e7fff : Texas Instruments PCI1131 (#2)
000f0000-000fffff : System ROM
00100000-02ffffff : System RAM
  00100000-0020afaf : Kernel code
  0020afb0-0021f7a3 : Kernel data
10000000-103fffff : PCI CardBus #80
10400000-107fffff : PCI CardBus #80
10800000-10bfffff : PCI CardBus #81
10c00000-10ffffff : PCI CardBus #81
1fffff00-1fffffff : Symbios Logic Inc. (formerly NCR) 53c810
20000000-2fffffff : PCI Bus #01
30000000-3fffffff : PCI Bus #01
c0000000-c03fffff : Neomagic Corporation NM2093 [MagicGraph 128ZV]
  c0000000-c010ffff : vesafb
fff00000-ffffffff : reserved

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
