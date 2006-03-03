Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751041AbWCCX2s@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751041AbWCCX2s (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 3 Mar 2006 18:28:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751726AbWCCX2s
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 3 Mar 2006 18:28:48 -0500
Received: from nommos.sslcatacombnetworking.com ([67.18.224.114]:64642 "EHLO
	nommos.sslcatacombnetworking.com") by vger.kernel.org with ESMTP
	id S1750881AbWCCX2r (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 3 Mar 2006 18:28:47 -0500
In-Reply-To: <20060303231807.GA28055@kroah.com>
References: <20060303220741.GA22298@kroah.com> <Pine.LNX.4.44.0603031638050.30957-100000@gate.crashing.org> <20060303231807.GA28055@kroah.com>
Mime-Version: 1.0 (Apple Message framework v746.2)
Content-Type: text/plain; charset=US-ASCII; delsp=yes; format=flowed
Message-Id: <B559AC6B-A9C9-425E-9288-EE7F9C99D8EB@kernel.crashing.org>
Cc: Linux Kernel <linux-kernel@vger.kernel.org>,
       linux-pci@atrey.karlin.mff.cuni.cz
Content-Transfer-Encoding: 7bit
From: Kumar Gala <galak@kernel.crashing.org>
Subject: Re: proper way to assign fixed PCI resources to a "hotplug" device
Date: Fri, 3 Mar 2006 17:28:50 -0600
To: Greg KH <greg@kroah.com>
X-Mailer: Apple Mail (2.746.2)
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - nommos.sslcatacombnetworking.com
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [0 0] / [47 12]
X-AntiAbuse: Sender Address Domain - kernel.crashing.org
X-Source: 
X-Source-Args: 
X-Source-Dir: 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Mar 3, 2006, at 5:18 PM, Greg KH wrote:

> On Fri, Mar 03, 2006 at 04:39:52PM -0600, Kumar Gala wrote:
>> On Fri, 3 Mar 2006, Greg KH wrote:
>>
>>> On Fri, Mar 03, 2006 at 11:42:03AM -0600, Kumar Gala wrote:
>>>> I was wondering what the proper way to assign and setup a single  
>>>> PCI
>>>> device that comes into existence after the system has booted.  I  
>>>> have
>>>> an FPGA that we load from user space at which time it shows up  
>>>> on the
>>>> PCI bus.
>>>
>>> Idealy your BIOS would set up this information :)
>>
>> How would my BIOS know about a device that didn't exist when it  
>> booted.
>
> According to the PCI Hotplug spec, your BIOS needs to take that into
> consideration at boot time.  Yeah, it's a wierd thing, I agree, but is
> how this works for x86 systems.  The space and resources are reserved
> at boot time by the pci hotplug controller in anticipation of a device
> being added sometime in the future.
>
> Other arches do this differently (ppc64 has the stuff reserverd by the
> hypervisor), and then compat pci does it by just plain guessing.  It
> sounds like your situation is just like this one.

Well I reserve space for the device in my "BIOS".  However this is an  
embedded system so there isn't any calling out to the "BIOS" after  
linux has booted.  Is there some additional "work" that the x86  
systems do beyond ensure proper holes in the memory map exist for  
future devices to be placed into?

>> Or do you mean my BIOS would load the FPGA as well so it existed.
>
> No, see above.
>
>>>> It has a single BAR and I need to assign it at a fixed address  
>>>> in PCI
>>>> MMIO space.
>>>>
>>>> All of the exported interfaces I see have to do with having the
>>>> kernel assign the BAR automatically for me.
>>>>
>>>> the following looks like what I want to do:
>>>>
>>>> bus = pci_find_bus(0, 3);
>>>> dev = pci_scan_single_device(bus, devfn);
>>>> pci_bus_alloc_resource(...);
>>>> pci_update_resource(dev, dev->resource[0], 0);
>>>> pci_bus_add_devices(bus);
>>>>
>>>> However, pci_update_resource() is not an exported symbol, so I  
>>>> could
>>>> replace that code with the need updates to the actual BAR.
>>>>
>>>> Is this the "right" way to go about this or is there a better
>>>> mechanism to do this.
>>>
>>> Take a look at how the compat pci hotplug driver does this, you  
>>> probably
>>> just need to do the same as it.
>>
>> I'll take a look.  How about something like the following patch:
>
> Hm, I don't think this is needed, see how the cpcihp drivers do it in
> drivers/pci/hotplug/cpcihp*.c.  I think you can do things the same  
> way.

Ahh, looked at cpqphp_* and only found cpqhp_configure_device() of  
any use.  I'll take a look at cpcihp*.c

> But if not, I don't have any objection to adding this patch, you just
> need to prove you really need it :)

No problem, I asked because I'd prefer to use existing code to solve  
my problem.  Just need to understand how to get there.



- kumar
