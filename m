Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267771AbUG3SO7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267771AbUG3SO7 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 30 Jul 2004 14:14:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267781AbUG3SMt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 30 Jul 2004 14:12:49 -0400
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:6877 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id S267785AbUG3SMG
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 30 Jul 2004 14:12:06 -0400
Date: Fri, 30 Jul 2004 19:12:06 +0100
From: Matthew Wilcox <willy@debian.org>
To: Jesse Barnes <jbarnes@engr.sgi.com>
Cc: Christoph Hellwig <hch@infradead.org>, Jon Smirl <jonsmirl@yahoo.com>,
       lkml <linux-kernel@vger.kernel.org>, linux-pci@atrey.karlin.mff.cuni.cz
Subject: Re: Exposing ROM's though sysfs
Message-ID: <20040730181205.GW10025@parcelfarce.linux.theplanet.co.uk>
References: <20040730165339.76945.qmail@web14929.mail.yahoo.com> <200407301010.29807.jbarnes@engr.sgi.com> <20040730182410.A12171@infradead.org> <200407301057.12445.jbarnes@engr.sgi.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200407301057.12445.jbarnes@engr.sgi.com>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jul 30, 2004 at 10:57:12AM -0700, Jesse Barnes wrote:
> willy brings up a good point though, we may want to disable the rom file 
> entirely after its been read, since it can be a source of trouble.  Here's 
> the latest patch.

My problem is with this is the following passage from PCI 2.2 and PCI 2.3:

  In order to minimize the number of address decoders needed, a device
  may share a decoder between the Expansion ROM Base Address register and
  other Base Address registers.  When expansion ROM decode is enabled,
  the decoder is used for accesses to the expansion ROM and device
  independent software must not access the device through any other Base
  Address registers.

ie while we're reading the ROM, we have to prevent any other accesses
to the contents of the BARs.  This patch is a loaded gun, pointed right
at your face.  Sure, we can say it's root's fault for pulling the trigger,
but it'd be nice to have some kind of safety lock.

I don't see a good way of doing this, unfortunately.  It'd probably be
enough to call ->suspend on the driver while you read the contents of
the ROM, but that's pretty ugly.

How about reading the contents of the ROM at pci_scan_bus() time?  It'd
waste a bunch of memory, but hey, people love sysfs.

-- 
"Next the statesmen will invent cheap lies, putting the blame upon 
the nation that is attacked, and every man will be glad of those
conscience-soothing falsities, and will diligently study them, and refuse
to examine any refutations of them; and thus he will by and by convince 
himself that the war is just, and will thank God for the better sleep 
he enjoys after this process of grotesque self-deception." -- Mark Twain
