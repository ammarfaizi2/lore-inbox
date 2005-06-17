Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262010AbVFQQXe@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262010AbVFQQXe (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 17 Jun 2005 12:23:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262011AbVFQQXe
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 17 Jun 2005 12:23:34 -0400
Received: from magic.adaptec.com ([216.52.22.17]:26302 "EHLO magic.adaptec.com")
	by vger.kernel.org with ESMTP id S262010AbVFQQX2 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 17 Jun 2005 12:23:28 -0400
Message-ID: <42B2F8F7.3030101@adaptec.com>
Date: Fri, 17 Jun 2005 12:23:19 -0400
From: Luben Tuikov <luben_tuikov@adaptec.com>
User-Agent: Mozilla Thunderbird 1.0.2 (X11/20050317)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Greg KH <greg@kroah.com>
CC: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Oops calling sysfs_create_link() from pci_probe()
References: <42B1D9AE.5000002@adaptec.com> <20050617055555.GA16371@kroah.com>
In-Reply-To: <20050617055555.GA16371@kroah.com>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 17 Jun 2005 16:22:46.0442 (UTC) FILETIME=[CBDBC0A0:01C57358]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 06/17/05 01:55, Greg KH wrote:
> On Thu, Jun 16, 2005 at 03:57:34PM -0400, Luben Tuikov wrote:
> 
>>Hi,
>>
>>I'm calling
>>
>>sysfs_create_link(&class->kobj,
>>		  &pcidev->driver->driver.kobj, "driver");
>>
>>To create a link from a syfs directory of an object which I've
>>created with class_device_regsiter(), to point to the
>>driver directory of the pci driver.
> 
> 
> Ick, why?  Shouldn't something like this be done in the driver core, and
> not in the individual drivers?

Hi Greg,

I agree, it should be done in the driver core.  The LLDD is registering
with the SAS class (unfinished, incomplete) and this is what appears:
/sys/class/sas/
/sys/class/sas/ha0/
/sys/class/sas/ha0/device -> link to PCI device
/sys/class/sas/ha0/device_name

where device name is the SAS address attribute (RO).
I'd ideally like to have a link to the LLDD in there
as well:

/sys/class/sas/ha0/driver -> link to the driver

But this host adapter registration with the SAS class happens
at pci_probe time, *at pci_register_driver* time so it seems that this
is the reason for the oops. (as opposed to PCI hot plugging the controller)
 
> Looks like one of the kobjects that you are wanting to link is not fully
> initialized and registered with sysfs.  Where are you getting that
> "&class->kobj" from?

It is the kobj of "ha0" which was just registered with class_device_register().
I suspect since all this is called from pci_probe at module init, it is
failing for the 2nd kobj, the driver.

Would this imply that had pci_probe been called on a PCI hot plug event
(not at pci_driver_register() time) then that symlink would've succeeded?
(since the driver had been registered already)

If so, can we reconcile this somehow so that code executed in pci_probe
at time B, could've also been executed at time A, A < B?

> Have a pointer to your patch anywhere?

It is quite incomplete.  Let me have something substantial and I'll post it
and then we can figure it out.  For now that line is /* XXX it would be good... */

> Also, try turning on kobject and driver core debugging, you should get a
> lot of helpful information in your syslog right before this oops.

Thanks,
	Luben
