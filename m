Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262305AbVAOSs6@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262305AbVAOSs6 (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 15 Jan 2005 13:48:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262306AbVAOSs6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 15 Jan 2005 13:48:58 -0500
Received: from hermine.aitel.hist.no ([158.38.50.15]:41735 "HELO
	hermine.aitel.hist.no") by vger.kernel.org with SMTP
	id S262305AbVAOSsy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 15 Jan 2005 13:48:54 -0500
Date: Sat, 15 Jan 2005 19:57:12 +0100
To: Dave Airlie <airlied@gmail.com>
Cc: covici@ccs.covici.com, Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: 2.6.10 dies when X tries to initialize PCI radeon 9200 SE
Message-ID: <20050115185712.GA17372@hh.idb.hist.no>
References: <41E64DAB.1010808@hist.no> <16870.21720.866418.326325@ccs.covici.com> <21d7e997050113130659da39c9@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <21d7e997050113130659da39c9@mail.gmail.com>
User-Agent: Mutt/1.5.6+20040907i
From: Helge Hafting <helgehaf@aitel.hist.no>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jan 14, 2005 at 08:06:09AM +1100, Dave Airlie wrote:
> > on Thursday 01/13/2005 Helge Hafting(helge.hafting@hist.no) wrote
> >  > 2.6.10 boots fine, but is killed by the X server when it
> >  > tries to initialize my PCI radeon 9200 SE.  This problem exists
> >  > in 2.6.9 too, but not in 2.6.8.1.  So I'm stuck with that version currently.
> >  >
> >  > The problem seems to be access to the card bios, X uses
> >  > int10 bios calls to initialize the card.
> >  >
> 
> Do you have DRM enabled if so can you turn it off.. same with radeonfb
> or vesafb...
> 

Some more data:
2.6.10 with agp and drm (drm for radeon & matrox) - dies with X on radeon
2.6.10 with drm (for radeon) no agp               - runs X fine!
2.6.10 with agp and no drm at all                 - dies with X on radeon
2.6.10 no agp no drm                              - runs X, but no 3d of course


2.6.10 with drm and no agp couldn't use matrox drm because that one 
needs agp to compile.


This is a bit strange.  I can't run X on the radoen PCI card if AGP is compiled,
but X and the kernel is not supposed to use AGP in this case because it is a
pci card!  Seems very strange to me, particularly considering that 2.6.8.1 
is able to run with both agp and drm.


I've mounted /var synchronously so as to get the most of the crash log.  It ends
like this:

(II) RADEON(0): Using 8 bits per RGB (8 bit DAC)
(II) Loading sub module "int10"
(II) LoadModule: "int10"
(II) Reloading /usr/X11R6/lib/modules/linux/libint10.a
(II) RADEON(0): initializing int10
(**) RADEON(0): Option "InitPrimary" "on"
(II) Truncating PCI BIOS Length to 53248

A normal non-crashing run looks like this:
(II) RADEON(0): Using 8 bits per RGB (8 bit DAC)
(II) LoadModule: "int10"
(II) Reloading /usr/X11R6/lib/modules/linux/libint10.a
(II) RADEON(0): initializing int10
(**) RADEON(0): Option "InitPrimary" "on"
(II) Truncating PCI BIOS Length to 53248
(--) RADEON(0): Chipset: "ATI Radeon 9200SE 5964 (AGP)" (ChipID = 0x5964)
(--) RADEON(0): Linear framebuffer at 0xe0000000
(--) RADEON(0): VideoRAM: 131072 kByte (64 bit DDR SDRAM)
(II) RADEON(0): PCI card detected
(II) Loading sub module "ddc"
(II) LoadModule: "ddc"

(and so on)

Another item that may be interesting:
>From the log, it looks like DRM failed to load for the PCI card when
AGP wasn't present.  Odd - it couldn't use AGP anyway.  
Maybe the explanation is that the xserver erroneously believes that it is
an agp card?  The log contains this:

(--) Chipset ATI Radeon 9200SE 5964 (AGP) found

It _is_ an "ATI Radeon 9200 SE", but it is definitely not an AGP card.
I don't know wether the X server is mistaken, or if it merely is a
wrong message.  I don't think X should hang the kernel this way, even
if it opens the AGP device by mistake.  AGP is normally in use by the 
matrox card and should be unavailable anyway.

Any further ideas?�  More things to try?  It'd be nice to get 3D on these
newer kernels too. :-)  I can post full logs if that's interesting.

Helge Hafting
