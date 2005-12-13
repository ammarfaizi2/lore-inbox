Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030198AbVLMS1R@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030198AbVLMS1R (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 13 Dec 2005 13:27:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932582AbVLMS1R
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 13 Dec 2005 13:27:17 -0500
Received: from cavan.codon.org.uk ([217.147.92.49]:51166 "EHLO
	vavatch.codon.org.uk") by vger.kernel.org with ESMTP
	id S932574AbVLMS1Q (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 13 Dec 2005 13:27:16 -0500
Date: Tue, 13 Dec 2005 18:26:51 +0000
From: Matthew Garrett <mjg59@srcf.ucam.org>
To: Randy Dunlap <randy_d_dunlap@linux.intel.com>
Cc: linux-ide@vger.kernel.org, linux-scsi@vger.kernel.org,
       linux-kernel@vger.kernel.org, acpi-devel@lists.sourceforge.net
Subject: Re: RFC: ACPI/scsi/libata integration and hotswap
Message-ID: <20051213182651.GA14645@srcf.ucam.org>
References: <20051208030242.GA19923@srcf.ucam.org> <20051213101417.13fdb14c.randy_d_dunlap@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20051213101417.13fdb14c.randy_d_dunlap@linux.intel.com>
User-Agent: Mutt/1.5.9i
X-SA-Exim-Connect-IP: <locally generated>
X-SA-Exim-Mail-From: mjg59@codon.org.uk
X-SA-Exim-Scanned: No (on vavatch.codon.org.uk); SAEximRunCond expanded to false
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Dec 13, 2005 at 10:14:17AM -0800, Randy Dunlap wrote:

> 1.  I had problems applying it.  What tree is it against?
>     Say so in the description.

It was against 2.6.15-git at the time, but I accidently left a hunk of 
stuff from the hotplug patch in there which probably confused things. 
I'll try to rediff it by the end of the week (and do other tidying)

> 7.  Most important:  What good does the ACPI interface do/add?
>     What I mean is that acpi_get_child() in scsi_acpi_find_channel()
>     always returns a handle value of 0, so it doesn't get us
>     any closer to determining the ACPI address (_ADR) of the SATA
>     devices.  The acpi_get_devices() technique in my patch (basically
>     walking the ACPI namespace, looking at all "devices") is the
>     only way that I know of doing this, but I would certainly
>     like to find a better way.

When the PCI bus is registered, acpi walks it and finds the appropriate 
acpi handle for each PCI device. This is shoved in the 
firmware_data field of the device structure. Later on, we register the 
scsi bus. As each item on the bus is added, the acpi callback gets 
called. If it's not an endpoint, scsi_acpi_find_channel gets called. 
We're worried about the host case. The host number will correspond to 
the appropriate _ADR underneath the PCI device that the host is on, so 
we simply get the handle of the PCI device and then ask for the child 
with the appropriate _ADR. That gives us the handle for the device, and 
returning that sticks it back in the child's firmware_data field.

At least, that's how it works here. If acpi_get_child always returns 0 
for you, then it sounds like something's going horribly wrong. Do you 
have a copy of the DSDT?
-- 
Matthew Garrett | mjg59@srcf.ucam.org
