Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S290267AbSAPAFH>; Tue, 15 Jan 2002 19:05:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S290268AbSAPAE5>; Tue, 15 Jan 2002 19:04:57 -0500
Received: from 12-224-37-81.client.attbi.com ([12.224.37.81]:52495 "HELO
	kroah.com") by vger.kernel.org with SMTP id <S290267AbSAPAEq>;
	Tue, 15 Jan 2002 19:04:46 -0500
Date: Tue, 15 Jan 2002 16:01:17 -0800
From: Greg KH <greg@kroah.com>
To: David Garfield <garfield@irving.iisd.sra.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Query about initramfs and modules
Message-ID: <20020116000117.GD29020@kroah.com>
In-Reply-To: <15428.47094.435181.278715@irving.iisd.sra.com> <20020115233437.GC29020@kroah.com> <15428.49056.652466.414438@irving.iisd.sra.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <15428.49056.652466.414438@irving.iisd.sra.com>
User-Agent: Mutt/1.3.25i
X-Operating-System: Linux 2.2.20 (i586)
Reply-By: Tue, 18 Dec 2001 20:22:18 -0800
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 15, 2002 at 06:47:44PM -0500, David Garfield wrote:
> Greg KH writes:
>  > On Tue, Jan 15, 2002 at 06:15:02PM -0500, David Garfield wrote:
>  > > 
>  > > Can/will the initramfs mechanism be made to implicitly load into the
>  > > kernel the modules (or some of the modules) in the image?
>  > 
>  > Most of the mechanism for loading modules for physical devices will be
>  > the /sbin/hotplug interface:
>  > 	- when the pci core code scans the pci bus, and finds a new
>  > 	  device, it calls out to /sbin/hotplug the pci device
>  > 	  information.
>  > 	- /sbin/hotplug looks up the pci device info and tries to match
>  > 	  it up with a driver that will work for this device (see the
>  > 	  linux-hotplug.sf.net site for more info on how this works.)
>  > 	- if it finds a module for the device, it calls modprobe on the
>  > 	  module, and now that pci device has a module loaded.
>  > 
>  > Repeat this process for the USB, IEEE1394, and other busses that support
>  > MODULE_DEVICE_TABLE in the kernel tree.
> 
> Seems like a great idea *after* the system is fully running (or the
> root partition is at least mounted).

The initramfs is the initial root partition.

> Seems like overkill to boot most systems.
> 
> As I understand it, all that should need to go into the initramfs is
> enough to mount the root partition.  Normally, this would probably be
> a handful of drivers that are unconditionally known to be needed.  So
> why go through several user-mode programs to make a decision that can
> be made once and built in?

But how do you always know what is "needed"?  Wouldn't it be nice to
just select "compile all SCSI PCI and IEEE1394 and USB drivers as
modules" and then have your "real" root partition's controller be
automatically found before you try to mount your "real" root partition?

Say your SCSI PCI controller dies, and you buy a new one.  Plop it in,
reboot, and everything works.  No having to build a new initrd, or build
in _all possible_ SCSI PCI drivers.

Right now you can't have your "real" root partition on a USB drive,
without a horrible "let's wait forever" patch to your kernel.

This also solves the "coldplug" problem, where you need to load
pci/usb/foobus drivers _after_ init has started.  To do this you need to
rely on scanning the busses from userspace and loading the needed
drivers.  Why reimplement this scanning logic, as the kernel already did
all of this (and usually did a much better job at it) during the boot
process before init started.

And this allows lots of horrible "boot over NFS" and other network
code/hacks in the kernel to be moved out of kernel space, and into
userspace, where it really belongs.

thanks,

greg k-h
