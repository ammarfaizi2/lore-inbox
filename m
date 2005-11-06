Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750740AbVKFMfR@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750740AbVKFMfR (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 6 Nov 2005 07:35:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750744AbVKFMfR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 6 Nov 2005 07:35:17 -0500
Received: from van-1-67.lab.dnainternet.fi ([62.78.96.67]:21426 "EHLO
	mail.zmailer.org") by vger.kernel.org with ESMTP id S1750740AbVKFMfP
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 6 Nov 2005 07:35:15 -0500
Date: Sun, 6 Nov 2005 14:35:12 +0200
From: Matti Aarnio <matti.aarnio@zmailer.org>
To: Andreas Kleen <ak@suse.de>
Cc: Marc Perkel <marc@perkel.com>, Matti Aarnio <matti.aarnio@zmailer.org>,
       Michael Madore <michael.madore@gmail.com>, linux-kernel@vger.kernel.org,
       acurrid@nvidia.com
Subject: Re: PCI-DMA: high address but no IOMMU - nForce4
Message-ID: <20051106123512.GG3423@mea-ext.zmailer.org>
References: <d4b6d3ea0510271047t413e9ea8l333a532c1a5f3d77@mail.gmail.com> <p73slum38rw.fsf@verdi.suse.de> <20051030002737.GB3423@mea-ext.zmailer.org> <56702.69.50.231.10.1130822490.squirrel@mail.ctyme.com> <6079139.1130945900155.SLOX.WebMail.wwwrun@imap-dhs.suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <6079139.1130945900155.SLOX.WebMail.wwwrun@imap-dhs.suse.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 02, 2005 at 04:38:20PM +0100, Andreas Kleen wrote:
> Date:	Wed, 2 Nov 2005 16:38:20 +0100 (CET)
> From:	Andreas Kleen <ak@suse.de>
> To:	Marc Perkel <marc@perkel.com>
> Subject: Re: PCI-DMA: high address but no IOMMU - nForce4
> 
> [full quote]

[severe clipping]
 
> Am Di 01.11.2005 06:21 schrieb Marc Perkel <marc@perkel.com>:
> 
> > > On Fri, Oct 28, 2005 at 12:16:51AM +0200, Andi Kleen wrote:
> > >
> > > I will attach my own; A brand new Amd64 dual-core thing.
> > > Works fine with mem=2500M, but blows up with mem=3G or
> > > without any override and full 4G complement in use.
> > >
> > > This board (ASUS A8N-SLI) does use NVIDIA nForce4 chipset with
> > > bios-option to map (hoist) "excess memory" out from first 4G to
> > > higher physical addresses so that it can be accessed by the
> > > processor.
> > >
> > > This board has no AGP at all in it, but it does have lots
> > > of PCIE, and a bit of PCI-X thrown in for "legacy cards".
> > > Somehow that detail breaks things when the machine really
> > > should use bounce-buffering, or something similar -- I don't
> > > know if Nvidia nForce4 chipset does have IOMMU, though...
> >
> > For what it's worth I have almost the exact same hardware and got the
> > same
> > error. Athlon X2 4400 with the same ASUS board. Reverting to 2.6.13.2
> > kernel works.
>  
> This sounds like the PCI-X BIOS misconfiguration issue that Andy C.
> recently tracked down. Andy do you agree?
>  
> If yes it's a BIOS problem, but we can probably work around it with a
> quirk.
> 
> -Andi

Well..  sort of.   Thinking goes probably like this:
  "The GART is AGP thingie, it shall be initialized minimally
   or not at all in a system that has no AGP."

which naturally backfires, when indeed all IO bus things will
use GART, not only AGP..


I am using Fedora Core development kernels for x86_64, and am able
to get system to work (mostly) with all 4 GB of memory by using
following boot parameters:

    iommu=soft swiotlb=65536

with all of 2.6.14 series kernel versions for past week (or two).
I did try some other options as well, like:

    iommu=noagp,force,memaper=3

but that didn't succeed in booting my box all the way, and always
in the end crashing with the message in $SUBJECT, above.

Plain 2.4.14 works completely with   mem=2600M  boot-option, but
it does still tell:

    Checking aperture...
    CPU 0: aperture @ 0 size 32 MB
    No AGP bridge found

and somewhere (AMD documents?) I spotted a mention that having
aperture overlaying memory is "a bad idea", thus when memory
starts at zero, and aperture starts there... 

A quirk, very least.



There is separate issue with recent change in  mm/memory.c
contained   get_user_pages()  function (?) that fail my
BTTV card access  --  and I might be wrong again,  I did
suspect I2C at first, but strace shows fault to happen with
VIDIOC_QBUF  ioctl...

   /Matti Aarnio
