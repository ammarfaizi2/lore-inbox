Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261936AbTKTP0Q (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 20 Nov 2003 10:26:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261953AbTKTP0Q
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 20 Nov 2003 10:26:16 -0500
Received: from ns2.uk.superh.com ([193.128.105.170]:47267 "EHLO
	smtp.uk.superh.com") by vger.kernel.org with ESMTP id S261936AbTKTP0J
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 20 Nov 2003 10:26:09 -0500
Date: Thu, 20 Nov 2003 15:25:58 +0000
From: Richard Curnow <Richard.Curnow@superh.com>
To: Ivan Kokshaysky <ink@jurassic.park.msu.ru>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Greg KH <greg@kroah.com>
Subject: Re: Simplification in pbus_size_mem
Message-ID: <20031120152558.GA5895@malvern.uk.w2k.superh.com>
Mail-Followup-To: Ivan Kokshaysky <ink@jurassic.park.msu.ru>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
	Greg KH <greg@kroah.com>
References: <20031120122838.GA4575@malvern.uk.w2k.superh.com> <20031120171624.A30024@jurassic.park.msu.ru>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20031120171624.A30024@jurassic.park.msu.ru>
X-OS: Linux 2.4.22 i686
User-Agent: Mutt/1.5.4i
X-OriginalArrivalTime: 20 Nov 2003 15:27:06.0687 (UTC) FILETIME=[C1AF54F0:01C3AF7A]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

* Ivan Kokshaysky <ink@jurassic.park.msu.ru> [2003-11-20]:
> On Thu, Nov 20, 2003 at 12:28:38PM +0000, Richard Curnow wrote:
> > * 96Mb PCI memory aperture
> 
> Also there is a PCI-PCI bridge, I guess? ;-)

Yes.  'cat /proc/pci' (with my patch so the USB card gets allocations)
gives

  Bus  0, device   2, function  0:
    PCI bridge: Digital Equipment Corporation DECchip 21150 (rev 6).
      Master Capable.  Latency=32.  Min Gnt=12.
  Bus  1, device   9, function  0:
    USB Controller: Lucent Microelectronics USS-344S USB Controller (rev 17).
      IRQ 4.
      Master Capable.  Latency=32.  Min Gnt=3.Max Lat=86.
      Non-prefetchable 32 bit memory at 0x14100000 [0x14100fff].
  Bus  1, device   9, function  1:
    USB Controller: Lucent Microelectronics USS-344S USB Controller (#2) (rev 17).
      IRQ 4.
      Master Capable.  Latency=32.  Min Gnt=3.Max Lat=86.
      Non-prefetchable 32 bit memory at 0x14101000 [0x14101fff].
  Bus  1, device   9, function  2:
    USB Controller: Lucent Microelectronics USS-344S USB Controller (#3) (rev 17).
      IRQ 4.
      Master Capable.  Latency=32.  Min Gnt=3.Max Lat=86.
      Non-prefetchable 32 bit memory at 0x14102000 [0x14102fff].
  Bus  1, device   9, function  3:
    USB Controller: Lucent Microelectronics USS-344S USB Controller (#4) (rev 17).
      IRQ 4.
      Master Capable.  Latency=32.  Min Gnt=3.Max Lat=86.
      Non-prefetchable 32 bit memory at 0x14103000 [0x14103fff].
  Bus  1, device  11, function  0:
    VGA compatible controller: SGS Thomson Microelectronics STG4000 [3D Prophet Kyro Series] (rev 1).
      IRQ 2.
      Master Capable.  Latency=32.  
      Prefetchable 32 bit memory at 0x10000000 [0x13ffffff].
      Prefetchable 32 bit memory at 0x14000000 [0x1407ffff].
      I/O at 0x2000 [0x20ff].
  Bus  1, device  12, function  0:
    Ethernet controller: SGS Thomson Microelectronics DEC-Tulip compatible 10/100 Ethernet (rev 161).
      IRQ 1.
      Master Capable.  Latency=32.  Min Gnt=255.Max Lat=255.
      I/O at 0x2400 [0x24ff].
      Non-prefetchable 32 bit memory at 0x14104000 [0x141040ff].

(This is an SH-4 platform.)

> 768Kb sounds strange. It must be power of 2. Perhaps it's 512Kb MMIO
> and 256Kb ROM? But MMIO registers must be non-prefetchable. Weird.

Looks like it's actually 512kB.  I'm not sure why I thought it was
768kB.

> > alignment requirement that was found?), hence in the pass where the
> > prefetchable block is sized, 'size' ends up as 96Mb, which means there
> > is no space left in which to place the non-prefetchable blocks for the
> > USB card.
> 
> Yes, it's a trade-off - minimizing alignment vs. size requirements.
> In most situations the former approach gives much better allocations.

So is the idea that by rounding up 'size' to 96Mb in this case, it's
guaranteed that there will be a 64Mb aligned chunk inside where the
framebuffer can go, still leaving enough room around for the other
allocation, _regardless_ of the alignment of the base of the memory
aperture?  (Or if there are multiple PCI-to-PCI bridges, the aperture
base for any one bridge is going to depend on the sizes of the apertures
forwarded by the others, I suppose).

If this is so, I can begin to see what the loop in the existing code is
doing.

> 
> > With the patch above, the alignment requirement for the prefetchable
> > memory actually ends up as the alignment required for the framebuffer,
> > and the size isn't rounded up unnecessarily.  The USB card gets
> > allocated successfully as a result.
> 
> Well, it works only because your 96Mb PCI aperture is aligned at 64Mb
> (or more).

It's aligned at 256Mb in fact, as shown above.

> If it was aligned at 32Mb, you wouldn't be able to allocate
> prefetchable memory at all with your patch.

Good point.

I'll think about this some more.

> As a workaround, you can mark those additional 768Kb regions as
> non-prefetchable and be done with it.

How do I do that?

Many thanks for your help
Richard

-- 
Richard \\\ SuperH Core+Debug Architect /// .. At home ..
  P.    /// richard.curnow@superh.com  ///  rc@rc0.org.uk
Curnow  \\\ http://www.superh.com/    ///  www.rc0.org.uk
