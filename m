Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267858AbUG3WPs@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267858AbUG3WPs (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 30 Jul 2004 18:15:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267857AbUG3WPs
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 30 Jul 2004 18:15:48 -0400
Received: from web14922.mail.yahoo.com ([216.136.225.6]:31631 "HELO
	web14922.mail.yahoo.com") by vger.kernel.org with SMTP
	id S267808AbUG3WP3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 30 Jul 2004 18:15:29 -0400
Message-ID: <20040730221528.2702.qmail@web14922.mail.yahoo.com>
Date: Fri, 30 Jul 2004 15:15:28 -0700 (PDT)
From: Jon Smirl <jonsmirl@yahoo.com>
Subject: Re: [PATCH] add PCI ROMs to sysfs
To: Jesse Barnes <jbarnes@engr.sgi.com>, Greg KH <greg@kroah.com>
Cc: linux-kernel@vger.kernel.org, linux-pci@atrey.karlin.mff.cuni.cz,
       Jon Smirl <jonsmirl@yahoo.com>
In-Reply-To: <200407301434.50373.jbarnes@engr.sgi.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--- Jesse Barnes <jbarnes@engr.sgi.com> wrote:
> Jon, am I missing something or is it possible for us to cache the ROM
> in userspace when it receives the hotplug event?  I saw your DRM
code,
> and for the case of ROMs at a nonstandard address, we can fixup the
> address for pci_dev->resource[PCI_ROM_RESOURCE] in pci-quirks, 
> can't we?

When I was done with the ROM I did this:
if (r->parent) {
	release_resource(r);
	r->flags &= ~PCI_ROM_ADDRESS_ENABLE;
	r->end -= r->start;
	r->start = 0;
}
/* This will disable and set address to unassigned */
pci_write_config_dword(dev->pdev, PCI_ROM_ADDRESS, 0);
	
Then when I accessed them I did this:

/* assign the ROM an address if it doesn't have one */
if (r->parent == NULL)
	pci_assign_resource(dev->pdev, PCI_ROM_RESOURCE);

I believe I needed to do this because Xfree was enabling the ROMs
without telling the kernel. This caused the kernel resource struct to
get out of sync with the actual state of the ROM. 

If you set pci_dev->resource[PCI_ROM_RESOURCE] to C000:0 won't this
mess up pci_assign_resource()/release_resource()?

I wrote this code a while ago so I'm forgetting exactly why I did
things. There is a variation on this code in drivers/video/aty/radeon_base.c

=====
Jon Smirl
jonsmirl@yahoo.com


	
		
__________________________________
Do you Yahoo!?
New and Improved Yahoo! Mail - 100MB free storage!
http://promotions.yahoo.com/new_mail 
