Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261882AbTJ2CAa (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 28 Oct 2003 21:00:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261885AbTJ2CAa
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 28 Oct 2003 21:00:30 -0500
Received: from mail.kroah.org ([65.200.24.183]:34517 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S261882AbTJ2CA1 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 28 Oct 2003 21:00:27 -0500
Date: Tue, 28 Oct 2003 17:59:56 -0800
From: Greg KH <greg@kroah.com>
To: Andreas Jellinghaus <aj@dungeon.inka.de>
Cc: linux-kernel@vger.kernel.org
Subject: Re: ANNOUNCE: User-space System Device Enumeration (uSDE)
Message-ID: <20031029015956.GB9450@kroah.com>
References: <3F9DA5A6.3020008@mvista.com> <Pine.LNX.4.33.0310280901490.7139-100000@osdlab.pdx.osdl.net> <pan.2003.10.28.22.59.13.441436@dungeon.inka.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <pan.2003.10.28.22.59.13.441436@dungeon.inka.de>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 28, 2003 at 11:59:14PM +0100, Andreas Jellinghaus wrote:
> > I find it difficult to see your justification for designing a project from
> > scratch instead of contributing your time, effort, and ideas to a pair of
> > already existing, albeit immature, projects that do exactly the same
> > thing.
> 
> Hi Patric,
> 
> maybe you can tell me:

Hm, off topic here... Oh well...

> with devfs it is _very_ simple to see what a driver does, and what
> information it passes on devices. it is the major and minor number,
> the device type, a name, and a default permissions (that does not
> require changes in most cases).
> 
> sysfs is very sparse:
>  - no (explicit) device type
>    (/sys/block/ has block devices, the rest is char.)

There's your explicitness :)

>  - no default permissions
>    (the driver author often knows well, if a device should be secured
>    or not. why can't he pass that information?)

Permissions are often _not_ known better by the driver author.  Let's
leave this up to the distro to get correct.

>  - only plain names like old /dev. I still can't see how any user space
>    tool can find out, that my /sys/block/hda/ is a hard disk, and 
>    /sys/block/hdc/ is a cdrom. how could any tool create /dev/discs/ and
>    /dev/cdrom/ devices without that distinction?

Look at the type of the device associated with the block device.  That
will tell you if it's a floppy, or cdrom, or whatever.  If IDE devices
don't export the proper info for this in sysfs, we need to fix it.  I'm
pretty sure SCSI already does.

>  - why is a usb printer class usb? I thought that was the bus? shouldn't
>    it be class printer (or "lp" or something like that)? how can any
>    tool create /dev/printers/ devices, if it cannot see how some usb
>    device is a printer or not?

The USB class is for those types of devices that use the USB major
number.  See devices.txt for a list of these devices.  There is no
"class lp" for the kernel, as devices.txt does not specify such a thing.
There are parallel port printers, serial printers, and USB printers, all
with different majors and minors.  If you want to consolidate these,
into one major and class code, please do, but that's a 2.7 issue.  For
2.6, we have to stick with what we have been doing since at least 2.2.


> and how would some driver create additional export information for many
> devices? understanding how floppy.c creates devfs devices for all those
> fd0u1440 and friend devices is easy. but how would that driver create
> information on those devices via sysfs?

The individual driver can create sysfs files using the existing sysfs
functions (like DEVICE_ATTR(), CLASS_DEVICE_ATTR(), etc.)  Or for the
block devices, create an attribute and register it with the block code
(yeah, for block devices it's harder, but not impossible.)

> I don't know exactly what the problem with devfs is, but maybe it is
> because devfs is a filesystem?

Please see the many discussions about this in the past in the
linux-kernel archives.

> if sysfs doesn't gather and export the same amount of information 
> devfs does, I don't know how any tool based on sysfs can ever 
> seriously replace it. you want people to join current effords
> (i.e, udev+sysfs). with many open questions I don't see how that
> is possible? 

sysfs does export enough information for us to do this in userspace.  If
it's missing anything, please let us know.  Again, permissions will be
done in userspace, and should not be in the kernel.

> finishing the sysfs documentation and porting some drivers like
> floppy.c and lp.c to sysfs could help. In its current state, I
> don't understand many parts of sysfs, and it looks very natural
> to me, that people rather implement something from scratch if it
> is easy, than try to understand some very complex.

See the lwn.net series about kobjects and sysfs for some other sysfs
information.  Usually driver authors will not have to care about that
stuff at all, but possibly they might want to add a file or two to
sysfs, through the driver model.  See any of the existing kernel drivers
that do this (there are a lot of them) for examples of this.

Hope this helps,

greg k-h
