Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263856AbUDPWig (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 16 Apr 2004 18:38:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263900AbUDPWgF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 16 Apr 2004 18:36:05 -0400
Received: from mail.kroah.org ([65.200.24.183]:30691 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S263927AbUDPWfM (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 16 Apr 2004 18:35:12 -0400
Date: Fri, 16 Apr 2004 15:34:36 -0700
From: Greg KH <greg@kroah.com>
To: Keiichiro Tokunaga <tokunaga.keiich@jp.fujitsu.com>
Cc: lhcs-devel@lists.sourceforge.net, lhms-devel@lists.sourceforge.net,
       linux-hotplug-devel@lists.sourceforge.net,
       pcihpd-discuss@lists.sourceforge.net, lhns-devel@lists.sourceforge.net,
       linux-ia64@vger.kernel.org, linux-kernel@vger.kernel.org,
       acpi-largesys-devel@lists.sourceforge.net
Subject: Re: [Pcihpd-discuss] [RFC] New sysfs tree for hotplug
Message-ID: <20040416223436.GB21701@kroah.com>
References: <20040415170939.0ff62618.tokunaga.keiich@jp.fujitsu.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040415170939.0ff62618.tokunaga.keiich@jp.fujitsu.com>
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 15, 2004 at 05:09:39PM +0900, Keiichiro Tokunaga wrote:
> 
> 1. Current sysfs for hotplug
> ----------------------------
>  In 2.6, there are some sysfs files for hotplug.  For instance, PCI has that
> kind of files to control hotplug features.  PCI related sysfs entries for hotplug
> are created under /sys/bus/pci/slots/:
> 
>     /sys/bus/pci/slots/<slot#>/<files>
> 
> There are some files under <slot#> directory.  Some of them are supposed
> to expose kenrel information, the others are supposed to control hotplug.
> Recently, CPU and memory hotplug are being worked actively.  According 
> to their patch, they seem to be trying to create sysfs files under the following
> directory.
> 
>     /sys/devices/system/

That's correct, as cpus and memory are system devices, while pci slots
belong in the pci bus directory in sysfs.

> 2. Problem

There is no problem :)

>  Recent large machines have many PCI devices and some boards that
> contain devices (e.g. CPU, memory, and/or I/O devices).  A certain PCI
> device (PCI1) might be connected with other one (PCI2), which means that
> there is a dependency between PCI1 and PCI2.

You have this today?  On what platform?  This is the first I have heard
of this.  If needed, we can merely change the pci hotplug core to allow
a hierarchy of pci slots.  Will that solve your problem?

> 3. Suggestion
> -------------
>  To solve the problem, I'd like to propose the following idea.
> 
> ["hotplug" directory]
>    This directory is to represent a hierarchy of hotpluggable devices.

Hm, no.  What about usb, firewire, scsi and any other future bus that
can be "hotpluggable".  The kernel doesn't treat them differently, and
we shouldn't either.

>   "hotpluggable device" means a device that can be powered off and
>   removed physically from the system running.  The hierarchy describes a 
>   dependency between each device.  This directory would be placed, like:
> 
>       /sys/devices/hotplug
> 
>   Any systems that enable hotplug (e.g. ACPI, DLPAR) can create their
>   own directory right under the "hotplug" directory, like:
> 
>       /sys/devices/hotplug/acpi
>       /sys/devices/hotplug/dlpar
> 
>   Each of systems can create directories and files under the own directory,
>   and these directories should be easy for user to use.
> 
> 
> [ACPI based Hotplug Case]
>    I think that ACPI is one of the systems tha know dependencies of devices.

But it doesn't know about all devices in the system (like USB, firewire
and others), so this would quickly break down.  I also don't like
creating a solution that is so hard-wired for one firmware type like
ACPI.  What about Open Firmware based machines?  Pure BIOS machines?  No
firmware at all machines?  The current sysfs trees work just fine for
all of them, without users having to figure out what the access type the
kernel uses to get to the devices.

thanks,

greg k-h
