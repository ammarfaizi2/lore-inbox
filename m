Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263350AbTDCLRr>; Thu, 3 Apr 2003 06:17:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263353AbTDCLRr>; Thu, 3 Apr 2003 06:17:47 -0500
Received: from deviant.impure.org.uk ([195.82.120.238]:1162 "EHLO
	deviant.impure.org.uk") by vger.kernel.org with ESMTP
	id <S263350AbTDCLRq>; Thu, 3 Apr 2003 06:17:46 -0500
Date: Thu, 3 Apr 2003 12:28:58 +0100
From: Dave Jones <davej@codemonkey.org.uk>
To: ISHIKAWA Mutsumi <ishikawa@debian.org>
Cc: fendrakyn@europaguild.com, davej@codemonkey.org.uk,
       matthew.e.tolentino@intel.com, linux-kernel@vger.kernel.org
Subject: Re: [BUG] E7x05 chipset bug in 2.5 kernels' AGPGART driver.
Message-ID: <20030403112858.GB15999@suse.de>
Mail-Followup-To: Dave Jones <davej@codemonkey.org.uk>,
	ISHIKAWA Mutsumi <ishikawa@debian.org>, fendrakyn@europaguild.com,
	matthew.e.tolentino@intel.com, linux-kernel@vger.kernel.org
References: <200304022050.03026.fendrakyn@europaguild.com> <20030402221046.GA30881@suse.de> <20030403033359.33D8E8DC14@master.hanzubon.jp>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030403033359.33D8E8DC14@master.hanzubon.jp>
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 03, 2003 at 12:33:59PM +0900, ISHIKAWA Mutsumi wrote:

 >  I've checked Intel E7205 and E7505 spec sheets. But I can not find
 > why we should use device #1 (virtual agp bridge) instaed of device
 > #0 (MCH).

Look at agp_3_0_node_enable()
In particular, the part that does a pci read of PCI_SECONDARY_BUS.
device #1 (AGP bridge) has 1:0.0 (AGP graphic card) as its secondary
bus here. Device #0 (Host bridge) doesn't have anything as a secondary
bus, so it can't mate the card with the bridge. So i7x05 jumps through
hoops using the wrong device in its agp_bridge->dev to get this right.

Its really fugly, and is against what every other gart driver is doing.
In my working tree (not yet pushed to bkbits) I've ripped out that
whole PCI_SECONDARY_BUS thing and replaced it with a simple bus scan
that looks for 2 devices that are AGP host and AGP target and pairs
them unconditionally.

This will probably break if ever someone does a >1 AGP Slot motherboard
but with vendors preffering to just dual-head AGP cards, and with PCI Express
in the pipeline, it's questionable whether or not we'll see them.
I've heard from one vendor who says they're interested in doing such a
board. If it ever sees light of day, it's worth worrying about,
(and this system sounds so niche I doubt it'd ever be mainstream anyway).

 > I rewrite E7x05 agpgart driver to  use device #0. It
 > works fine for me (I tested it on E7505 motherboard with AGPx4
 > card and AGPx8 card). To use MCH registers (on device #0) is generic
 > way for Intel agpgart driver, so the driver can merge into intel-agp.c
 > easyly.

I don't mind either way. If Matt wants to keep this as a seperate
subdriver I'll keep it as it is. If he's ok with the merge, I'll
apply your changes.  The only questionable bit is the increase in
size of the respective modules by a few KB.

Thanks for your work..

		Dave

