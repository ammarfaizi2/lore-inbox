Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932614AbWJFGIJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932614AbWJFGIJ (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 6 Oct 2006 02:08:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932616AbWJFGIJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 6 Oct 2006 02:08:09 -0400
Received: from mx1.redhat.com ([66.187.233.31]:18653 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S932614AbWJFGIH (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 6 Oct 2006 02:08:07 -0400
Date: Fri, 6 Oct 2006 02:08:03 -0400
From: Dave Jones <davej@redhat.com>
To: Shawn Starr <shawn.starr@rogers.com>
Cc: linux-kernel@vger.kernel.org, davej@codemonkey.org.uk
Subject: Re: [2.6.19-rc1][AGP] Regression -  amd_k7_agp  no longer detected
Message-ID: <20061006060803.GB3381@redhat.com>
Mail-Followup-To: Dave Jones <davej@redhat.com>,
	Shawn Starr <shawn.starr@rogers.com>, linux-kernel@vger.kernel.org,
	davej@codemonkey.org.uk
References: <200610060150.20415.shawn.starr@rogers.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200610060150.20415.shawn.starr@rogers.com>
User-Agent: Mutt/1.4.2.2i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 06, 2006 at 01:50:19AM -0400, Shawn Starr wrote:

 > When loading amd_k7_agp nothing appears from kernel, no information about the AGP chipset/aptreture size etc. 
 > Even putting kprints inside the probe() function of the driver does not get called.

Even as the first thing in agp_amdk7_probe() ?
What is pci_register_driver returning ?

 > So it seems core agpart is aborting silently. 

When we modprobe the chipset driver, and run through the ->probe, it's all pci layer
stuff really, up until we agp_alloc_bridge(). But if you're not getting that far,
the core agpgart stuff doesn't even come into play.

 > In the specific agp chipset driver, the PCI ID bridge is matched but I see no further checks being done.
 > 
 > When the X Window System starts I get the following:
 > 
 > [ 1084.678461] Linux agpgart interface v0.101 (c) Dave Jones
 > [ 1301.755691] [drm] Initialized drm 1.0.1 20051102
 > [ 1301.761525] ACPI: PCI Interrupt 0000:01:05.0[A] -> GSI 16 (level, low) -> IRQ 20
 > [ 1301.762563] [drm] Initialized radeon 1.25.0 20060524 on minor 0
 > [ 1303.005775] [drm:radeon_cp_init] *ERROR* radeon_cp_init called without lock held
 > [ 1303.005988] [drm:drm_unlock] *ERROR* Process 5215 using kernel context 0

This is the behaviour I'd expect if agp-amdk7.ko hadn't been loaded, but agpgart.ko had.

It's something of a mystery to me as that driver hasn't changed in ages asides
from spelling fixes and other trivialities.

 > What should be expected
 > From 2.6.15-rc5:

Damn, that's going back a bit..
But again, this driver hasn't really changed much since 2.5.x, so I'm 
wondering if this is a side-effect of some change in another subsystem.
Can you narrow it down to a specific kernel version where it broke ?
2.6.15 -> 2.6.18 is such a huge delta it's not even worth looking at.
Narrow the scope, and I'll eyeball the pci changes etc.

 > [   62.814823] Linux agpgart interface v0.101 (c) Dave Jones
 > [   62.841388] agpgart: Detected AMD 760MP chipset
 > [   62.870371] agpgart: AGP aperture is 128M @ 0xf0000000

I don't have any AMD hardware to test any more, so I've no chance of
trying to reproduce this.  All I can suggest is to try and narrow
down where it's failing, and then maybe I'll have enough clues to hazard
a guess at the cause.
 
 > Looking at the differences, I noticed some changes in generic.c for determing the AGP speed. I don't know
 >  if this has anything to do with this breaking. This video card is a Radeon 7500 AiW 64MB DDR and can do
 >  AGP4x and BIOS has AGP4x turned on by default. But this all would fail even before X is started if agpgart finds no chipset.

That code runs later when /dev/agpgart is open()'d, so it shouldn't
affect this. It shouldn't be hard to revert though if you want to
try it.  Also, that only changed the AGPx8 path, which no K7 chipsets can do.
If you ended up running that code, something is deeply screwed.

	Dave

-- 
http://www.codemonkey.org.uk
