Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261967AbTKTQg3 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 20 Nov 2003 11:36:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261988AbTKTQg3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 20 Nov 2003 11:36:29 -0500
Received: from jurassic.park.msu.ru ([195.208.223.243]:7176 "EHLO
	jurassic.park.msu.ru") by vger.kernel.org with ESMTP
	id S261967AbTKTQg2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 20 Nov 2003 11:36:28 -0500
Date: Thu, 20 Nov 2003 19:36:06 +0300
From: Ivan Kokshaysky <ink@jurassic.park.msu.ru>
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Greg KH <greg@kroah.com>
Subject: Re: Simplification in pbus_size_mem
Message-ID: <20031120193606.A30216@jurassic.park.msu.ru>
References: <20031120122838.GA4575@malvern.uk.w2k.superh.com> <20031120171624.A30024@jurassic.park.msu.ru> <20031120152558.GA5895@malvern.uk.w2k.superh.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <20031120152558.GA5895@malvern.uk.w2k.superh.com>; from Richard.Curnow@superh.com on Thu, Nov 20, 2003 at 03:25:58PM +0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 20, 2003 at 03:25:58PM +0000, Richard Curnow wrote:
>   Bus  1, device  11, function  0:
>     VGA compatible controller: SGS Thomson Microelectronics STG4000 [3D Prophet Kyro Series] (rev 1).
>       IRQ 2.
>       Master Capable.  Latency=32.  
>       Prefetchable 32 bit memory at 0x10000000 [0x13ffffff].
>       Prefetchable 32 bit memory at 0x14000000 [0x1407ffff].
>       I/O at 0x2000 [0x20ff].

Probably the second memory region is ROM - 'lspci -vvv' would clarify that.

> So is the idea that by rounding up 'size' to 96Mb in this case, it's
> guaranteed that there will be a 64Mb aligned chunk inside where the
> framebuffer can go, still leaving enough room around for the other
> allocation, _regardless_ of the alignment of the base of the memory
> aperture?  (Or if there are multiple PCI-to-PCI bridges, the aperture
> base for any one bridge is going to depend on the sizes of the apertures
> forwarded by the others, I suppose).

Exactly.

> > As a workaround, you can mark those additional 768Kb regions as
> > non-prefetchable and be done with it.
> 
> How do I do that?

Add a 'pcibios_fixup' routine for this platform, which does

	dev->resource[x].flags &= ~IORESOURCE_PREFETCH;

It can be either specific for that VGA controller (if it's built-in)
or for PCI devices with a class code of PCI_CLASS_DISPLAY_VGA or
(if that region is indeed a ROM) you can just mark ROM resources as
non-prefetchable for all PCI devices (i.e. x = PCI_ROM_RESOURCE).

Ivan.
