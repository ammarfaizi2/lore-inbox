Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262757AbVA1UKP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262757AbVA1UKP (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 28 Jan 2005 15:10:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262739AbVA1UFh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 28 Jan 2005 15:05:37 -0500
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:61138 "EHLO
	parcelfarce.linux.theplanet.co.uk") by vger.kernel.org with ESMTP
	id S262736AbVA1UAX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 28 Jan 2005 15:00:23 -0500
Date: Fri, 28 Jan 2005 20:00:10 +0000
From: Matthew Wilcox <matthew@wil.cx>
To: Grant Grundler <grundler@parisc-linux.org>
Cc: Jesse Barnes <jbarnes@sgi.com>, Jon Smirl <jonsmirl@gmail.com>,
       Greg KH <greg@kroah.com>, Russell King <rmk+lkml@arm.linux.org.uk>,
       Jeff Garzik <jgarzik@pobox.com>, Matthew Wilcox <matthew@wil.cx>,
       linux-pci@atrey.karlin.mff.cuni.cz, lkml <linux-kernel@vger.kernel.org>,
       Russell King <rmk@arm.linux.org.uk>
Subject: Re: Fwd: Patch to control VGA bus routing and active VGA device.
Message-ID: <20050128200010.GJ28246@parcelfarce.linux.theplanet.co.uk>
References: <9e47339105011719436a9e5038@mail.gmail.com> <200501270828.43879.jbarnes@sgi.com> <20050128173222.GC30791@colo.lackof.org> <200501281041.42016.jbarnes@sgi.com> <20050128193320.GB32135@colo.lackof.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050128193320.GB32135@colo.lackof.org>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jan 28, 2005 at 12:33:20PM -0700, Grant Grundler wrote:
> > > If it is intended to work with multiple IO Port address spaces,
> > > then it needs to use the pci_dev->resource[] and mangle that appropriately.
> > 
> > There is no resource for some of the I/O port space that cards respond to.
> 
> Yes - I've heard several graphics cards are horrible broken WRT address
> decoding.  Are PCI quirks supposed to handle that sort of thing?

No, PCI quirks are for fixing broken things.  VGA cards are entitled to
3c0-3df and all their 10-bit aliases.  I've been thinking for a while that we should mark the 10-bit aliases of ISA devices as used ... ie:

x100-x3ff
x500-x7ff
x900-xbff
xd00-xfff

Unfortunately, that may break some legitimate setups, but is hinted at
being a good idea in the EISA docs I've read.  My laptop uses only the
10-bit aliases of motherboard space (x000-x0ff, x400-x4ff, x800-x8ff,
xc00-xcff) for devices, except for the ISA bridge, which gets:
1180-11bf : 0000:00:1f.0
  1180-11bf : pnp 00:0b

The K6-2 is similar; only 10-bit aliases of motherboard space except for:
0a79-0a79 : isapnp write

Possibly a better solution (less likely to break things) would be to allow
drivers to reserve the 10-bit aliases too.  Something like this:

static inline void request_isa_alias_regions(unsigned long start,
                unsigned long n, const char *name)
{
        int base;
        for (base = 0x400; base < 0x10000; base += 0x400) {
                request_region(base + start, n, name);
        }
}

and then call that in drivers/video/console/vgacon.c

Russell, would that allay your issues with the kernel io resource database?

-- 
"Next the statesmen will invent cheap lies, putting the blame upon 
the nation that is attacked, and every man will be glad of those
conscience-soothing falsities, and will diligently study them, and refuse
to examine any refutations of them; and thus he will by and by convince 
himself that the war is just, and will thank God for the better sleep 
he enjoys after this process of grotesque self-deception." -- Mark Twain
