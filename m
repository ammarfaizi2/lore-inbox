Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751158AbWIHUDU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751158AbWIHUDU (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 8 Sep 2006 16:03:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751156AbWIHUDU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 8 Sep 2006 16:03:20 -0400
Received: from cavan.codon.org.uk ([217.147.92.49]:13747 "EHLO
	vavatch.codon.org.uk") by vger.kernel.org with ESMTP
	id S1751131AbWIHUDT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 8 Sep 2006 16:03:19 -0400
Date: Fri, 8 Sep 2006 20:58:42 +0100
From: Matthew Garrett <mjg59@srcf.ucam.org>
To: Kristen Carlson Accardi <kristen.c.accardi@intel.com>
Cc: linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org,
       len.brown@intel.com
Subject: Re: patch [0/2]: acpi: add generic removable drive bay support
Message-ID: <20060908195842.GA17220@srcf.ucam.org>
References: <20060907161305.67804d14.kristen.c.accardi@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060907161305.67804d14.kristen.c.accardi@intel.com>
User-Agent: Mutt/1.5.9i
X-SA-Exim-Connect-IP: <locally generated>
X-SA-Exim-Mail-From: mjg59@codon.org.uk
X-SA-Exim-Scanned: No (on vavatch.codon.org.uk); SAEximRunCond expanded to false
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 07, 2006 at 04:13:05PM -0700, Kristen Carlson Accardi wrote:

Firstly, thanks for this - I wrote some related code a while ago. A 
couple of questions...

> can then be used by udev to unmount or rescan depending on the event.  It will
> create a proc entry under /proc/acpi/bay for "eject" and for "status".  Writing 

Do we really want it under /proc? It would seem to make more sense for 
it to be under /sys.

> a 1 to the eject call will cause the drive bays acpi eject method to be called, 
> and should be done prior to removing the device.  Reading the "status" entry
> will tell you either "present" or "removed" depending on the state of the
> device.  User space scripts can use the status entry to determine if a device
> has been either inserted or removed in the case of some laptops who generate
> the exact same event for either insertion or removal (i.e. the Dell M65 for
> example).  Same scripts for using these events and udev can be found on the
> thinkwiki website:

What gets generated if I rip a drive out without notifying the system 
beforehand? Dell hardware doesn't appear to send any event when poking 
the eject lever.

The way I originally implemented this was to tie it into the libata 
layer directly. With a small amount of glue it's possible to tie a 
hotswap bay to a specific sata port, and use the event to trigger a 
hotplug rescan. Doing it in kernel space means that the device can be 
destroyed the moment it's removed, reducing the possibility that further 
writes will be made. There was some amount of resistance to acpi 
integration in the scsi layer, though I think we eventually reached a 
compromise about providing support for platform firmware hooks.

Doing it this way also means that the bay itself can be represented in 
sysfs as an attribute under the appropriate port. That seems more 
natural than having the bay be entirely separate, despite ACPI providing 
us with the information for them to be tied together.

-- 
Matthew Garrett | mjg59@srcf.ucam.org
