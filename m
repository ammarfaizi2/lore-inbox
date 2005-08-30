Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751115AbVH3DyK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751115AbVH3DyK (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 29 Aug 2005 23:54:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751132AbVH3DyK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 29 Aug 2005 23:54:10 -0400
Received: from smtp.osdl.org ([65.172.181.4]:38557 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1751115AbVH3DyJ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 29 Aug 2005 23:54:09 -0400
Date: Mon, 29 Aug 2005 20:52:30 -0700 (PDT)
From: Linus Torvalds <torvalds@osdl.org>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Greg KH <greg@kroah.com>, helgehaf@aitel.hist.no
Subject: Re: Ignore disabled ROM resources at setup
In-Reply-To: <1125371996.11963.37.camel@gaston>
Message-ID: <Pine.LNX.4.58.0508292045590.3243@g5.osdl.org>
References: <200508261859.j7QIxT0I016917@hera.kernel.org> 
 <1125369485.11949.27.camel@gaston> <1125371996.11963.37.camel@gaston>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Tue, 30 Aug 2005, Benjamin Herrenschmidt wrote:
> 
> Ok, it won't do nothing in fact. It's worse. It will return 0 (success),
> will actually assign a completely new address to the resource, will
> update the resource structure ... and will _not_ update the PCI resource
> BAR for the ROM.
> 
> That is very bad and definitely not what you want, wether it's ppc, x86
> or anything else. Either fail (don't assign the resource at all) or if
> you assign it, keep the BAR in sync with the struct resource.

I argue that the BAR _is_ in sync with the resource.

The resource is allocated, but not enabled. You want to enable it, you
need to write the BAR.

The fact is, that writing the address (but not the enable bit) to the BAR
when it's not enabled leads to problems. It wasn't entirely clear whether
the problems were in the X server (possible) or whether it was actual
hardware (hey, nothing surprises me any more).

So what allocate does is to _allocate_ it. It so happens that with normal 
PIO and IOMEM resources, there is no per-resource "enable" bit, so they 
are always enabled. However, PCI ROM's have a per-resource enable bit both 
in hardware and in the "struct resource", and if it isn't set, then the 
resource allocation is done, but the resource is not enabled and not 
written to hardware.

All very consistent. The allocation was successful, but you didn't ask to 
enable it, so pci_alloc_resource() will return success without actually 
enablign the hardware. 

What you want is a "zombie state", where we write the partial information 
to hardware. It's what we used to do, but it's certainly no more logical 
than what it does now, and it led to problem reports.

Btw, why does this happen on powerpc, but not x86? I'm running a radeon 
laptop right now myself. Hmm..

			Linus
