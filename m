Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268056AbUIKCU1@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268056AbUIKCU1 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 10 Sep 2004 22:20:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268061AbUIKCU1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 10 Sep 2004 22:20:27 -0400
Received: from rproxy.gmail.com ([64.233.170.198]:16367 "EHLO mproxy.gmail.com")
	by vger.kernel.org with ESMTP id S268056AbUIKCUY convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 10 Sep 2004 22:20:24 -0400
Message-ID: <9e4733910409101920563e42c0@mail.gmail.com>
Date: Fri, 10 Sep 2004 22:20:23 -0400
From: Jon Smirl <jonsmirl@gmail.com>
Reply-To: Jon Smirl <jonsmirl@gmail.com>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: radeon-pre-2
Cc: =?ISO-8859-1?Q?Felix_K=FChling?= <fxkuehl@gmx.de>,
       DRI Devel <dri-devel@lists.sourceforge.net>,
       Dave Airlie <airlied@linux.ie>, lkml <linux-kernel@vger.kernel.org>,
       Linus Torvalds <torvalds@osdl.org>
In-Reply-To: <1094853894.18235.17.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 8BIT
References: <E3389AF2-0272-11D9-A8D1-000A95F07A7A@fs.ei.tum.de>
	 <9e47339104090910374c674bf3@mail.gmail.com>
	 <DA459966-02B9-11D9-A8D1-000A95F07A7A@fs.ei.tum.de>
	 <9e47339104090917353554a586@mail.gmail.com>
	 <Pine.LNX.4.58.0409100209100.32064@skynet>
	 <9e47339104090919015b5b5a4d@mail.gmail.com>
	 <20040910153135.4310c13a.felix@trabant>
	 <1094853894.18235.17.camel@localhost.localdomain>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The current DRM code doesn't suffer from resource conflicts anymore.
DRM now supports two modes: primary and stealth. In primary mode DRM
behaves like a Linux device driver should, it attaches to it's PCI
IDs, claims it's resources, registers with sysfs, generates hotplug
events, etc.

On the other hand, if vesafb or fbdev are loaded they will be attached
to all of the resources. DRM is blocked now, it can't load and attach
to things like a normal driver. In this case the DRM code reverts to
stealth mode.  Since vesa/fbdev is already attached to the DRM PCI IDs
DRM can't directly attach. Instead the module init code searches the
pci bus for DRM hardware. If DRM finds it's hardware DRM will install
itself and function without informing the kernel that it is there.

Before every one blows up and says how stupid this is, stealth mode
came first, it's what DRM originally did. It's the primary mode code
that is new. Over time the plan is to give DRM the ability to do
take_over_console() and handle printk's. DRM will also gain mode
setting capabilities. Once these capabilities are added the need for a
standalone fbdev will be eliminated. You will still have all of the
fbdev features, they will just be coming out of the integrated code
base, not separate drivers. This is not an attempt to build a new
fbdev, the existing fbdev code is simply being reused and modified to
work in conjunction with DRM.

Stealth and primary mode are transition tools. Once DRM subsumes fbdev
capabilities stealth mode will not be needed anymore and can be
removed.

This is a different strategy than building a base driver that claims
the resources and then loads vesafb, fbdev and DRM on top of the base.
The stealth mode scheme is a smoother transition to coordinating the
video drivers since it doesn't require a simultaneous change to all of
the video drivers. Stealth/primary mode in DRM is already implemented
and tested. Parts of it are already in the kernel and the rest is in
the pipeline.

On Fri, 10 Sep 2004 23:04:56 +0100, Alan Cox <alan@lxorguk.ukuu.org.uk> wrote:
> On Gwe, 2004-09-10 at 14:31, Felix Kühling wrote:
> > The first region (frame buffer and apperture) is claimed (partially) by
> > vesafb, the second one (MMIO registers) is not claimed at all. I don't
> > see an obvious way to fix this.
> 
> Its already fixed in the stuff I'm working on. Given the list of all
> video devices its simply a matter of taking the mmio address and seeing
> who owns it. That gives you the PCI device so you now know what the VESA
> console is Linux pci_device terms. At that point VESA is attachable to
> the PCI device and so it can veto DRI attaches.
> 
> I've not addressed what occurs if you get an answer in the ISA window
> because for VESA2 allocations I don't think it can occur. If it does
> then Jon's code dealing with finding the live VGA route will handle it
> for most boxes. (Anyone using VESA video on an IBM summit can fix it
> themselves).
> 
> Alan
> 



-- 
Jon Smirl
jonsmirl@gmail.com
