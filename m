Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261891AbUKHQwy@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261891AbUKHQwy (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 8 Nov 2004 11:52:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261855AbUKHQto
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 8 Nov 2004 11:49:44 -0500
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:41121 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id S261891AbUKHPYx
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 8 Nov 2004 10:24:53 -0500
Date: Mon, 8 Nov 2004 15:24:50 +0000
From: Matthew Wilcox <matthew@wil.cx>
To: Li Shaohua <shaohua.li@intel.com>
Cc: ACPI-DEV <acpi-devel@lists.sourceforge.net>,
       lkml <linux-kernel@vger.kernel.org>, Len Brown <len.brown@intel.com>,
       Greg <greg@kroah.com>, Patrick Mochel <mochel@digitalimplant.org>
Subject: Re: [ACPI] [PATCH/RFC 4/4]An experimental implementation for IDE bus
Message-ID: <20041108152450.GB32374@parcelfarce.linux.theplanet.co.uk>
References: <1099887081.1750.249.camel@sli10-desk.sh.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1099887081.1750.249.camel@sli10-desk.sh.intel.com>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 08, 2004 at 12:11:47PM +0800, Li Shaohua wrote:
> A sample patch to bind IDE devices. I'm not familar with IDE driver, so
> the patch possibly is completely wrong, though it can show correct ACPI
> path in my laptop. This test case just shows the framework works, please
> don't apply it.

> +#ifdef CONFIG_ACPI
> +#include <linux/acpi.h>
> +int generic_ide_platform_bind(struct device *dev)
> +{
> +	acpi_handle parent_handle = NULL;
> +	acpi_integer address;
> +	int i;
> +
> +	/* Seems dev->parent->parent is the PCI IDE controller */
> +        if (dev->parent && dev->parent->parent)
> +                parent_handle = dev->parent->parent->handle;

An IDE struct device is the gendev embedded in the ide_drive_t.  Its parent
is the ide_hwif_t, and its parent is the PCI device (or maybe SBUS
or whatever).  You can see this in /sys:

$ ls /sys/devices/pci0000:00/0000:00:1f.1/ide0/0.0
block  detach_state  power

The '0.0' is the device with an ide_bus_type.  ide0 is the hwif.
0000:00:1f.1 is a pci_dev.  Or in ACPI terms, ACPI/_SB/PCI0/IDEC
is ide0 and ACPI/_SB/PCI0/IDEC/PRID is 0.0

At least, I think that's the mapping.  Are we ever going to do anything
with /sys/firmware/acpi/namespace/ or will it just stay around consuming
inodes and dentries for no good reason?

-- 
"Next the statesmen will invent cheap lies, putting the blame upon 
the nation that is attacked, and every man will be glad of those
conscience-soothing falsities, and will diligently study them, and refuse
to examine any refutations of them; and thus he will by and by convince 
himself that the war is just, and will thank God for the better sleep 
he enjoys after this process of grotesque self-deception." -- Mark Twain
