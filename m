Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264992AbTA1KQ1>; Tue, 28 Jan 2003 05:16:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265058AbTA1KQ1>; Tue, 28 Jan 2003 05:16:27 -0500
Received: from jurassic.park.msu.ru ([195.208.223.243]:48910 "EHLO
	jurassic.park.msu.ru") by vger.kernel.org with ESMTP
	id <S264992AbTA1KQ0>; Tue, 28 Jan 2003 05:16:26 -0500
Date: Tue, 28 Jan 2003 13:24:06 +0300
From: Ivan Kokshaysky <ink@jurassic.park.msu.ru>
To: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>,
       Martin Mares <mj@ucw.cz>, Richard Henderson <rth@twiddle.net>,
       "Wiedemeier, Jeff" <Jeff.Wiedemeier@hp.com>,
       Linux Kernel Development <linux-kernel@vger.kernel.org>
Subject: Re: [patch 2.5] VGA IO on systems with multiple PCI IO domains
Message-ID: <20030128132406.A9195@jurassic.park.msu.ru>
References: <20030128011710.A638@localhost.park.msu.ru> <Pine.GSO.4.21.0301281030590.9269-100000@vervain.sonytel.be>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <Pine.GSO.4.21.0301281030590.9269-100000@vervain.sonytel.be>; from geert@linux-m68k.org on Tue, Jan 28, 2003 at 10:32:53AM +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 28, 2003 at 10:32:53AM +0100, Geert Uytterhoeven wrote:
> BTW, we still need a separate isa_request_mem_region(), since right now we
> cannot simply call request_mem_region(0xa0000, 0x10000) to request the VGA
> memory buffer in ISA memory space. On ia32 the plain request_mem_region() is
> OK, but on other archs you need to add the ISA memory space base.

I agree. Currently the VGA_MAP_MEM() hack does the trick in the vgacon.c,
but it would be a lot better to have a generic function.
However, I don't think that "isa_" prefix is good - as Ben pointed out,
legacy IO ranges of PCI devices like VGA, IDE, serial etc. can be
in other IO spaces than the real ISA bus.

What about
int pci_request_legacy_resource(struct pci_bus *bus, struct resource *res)
which would check res->flags and make appropriate decision?

The default in <linux/pci.h> for architectures like ia32 will be
#ifndef __HAVE_ARCH_LEGACY_REMAP
static inline int
pci_request_legacy_resource(struct pci_bus *bus, struct resource *res)
{
	struct resource *root = res->flags & IORESOURCE_IO ?
				&ioport_resource : &iomem_resource;
	return request_resource(root, res);
}
#infdef

This can be overridden in <asm/pci.h>.

Ivan.
