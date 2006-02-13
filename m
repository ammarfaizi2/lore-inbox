Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964840AbWBMUER@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964840AbWBMUER (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 13 Feb 2006 15:04:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964845AbWBMUEQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 13 Feb 2006 15:04:16 -0500
Received: from iolanthe.rowland.org ([192.131.102.54]:42370 "HELO
	iolanthe.rowland.org") by vger.kernel.org with SMTP id S964840AbWBMUEP
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 13 Feb 2006 15:04:15 -0500
Date: Mon, 13 Feb 2006 15:04:11 -0500 (EST)
From: Alan Stern <stern@rowland.harvard.edu>
X-X-Sender: stern@iolanthe.rowland.org
To: Phillip Susi <psusi@cfl.rr.com>
cc: Kyle Moffett <mrmacman_g4@mac.com>, Alon Bar-Lev <alon.barlev@gmail.com>,
       Kernel development list <linux-kernel@vger.kernel.org>
Subject: Re: Flames over -- Re: Which is simpler?
In-Reply-To: <43F0BE8F.6030609@cfl.rr.com>
Message-ID: <Pine.LNX.4.44L0.0602131425140.4632-100000@iolanthe.rowland.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 13 Feb 2006, Phillip Susi wrote:

> If you believe I am wrong, then please offer proof.  Specifically, refer 
> to the kernel code that handles verifying that the hardware is still 
> there after a resume.  I very well may be wrong, but you can not simply 
> surmise this to be so without any proof.  It is currently my belief that 
> the kernel probes the hardware the same way after a cold boot, resume 
> from s-t-r, and resume from s-t-d.  Specifically it looks to see if a 
> device is located in the same bus location with the same serial number, 
> etc, and if so, access to it continues exactly where it left off prior 
> to the suspend. 

Okay.  Take a look at drivers/usb/core/hub.c.  The usb_resume_device()  
routine is called when resuming either from STR or STD.  If
CONFIG_USB_SUSPEND has been set, it calls hub_port_resume(), which in turn
calls finish_device_resume().  Inside finish_device_resume() is a call to
usb_get_status(), which will fail if the device has not been connected and
powered-up throughout the entire suspend.  That failure will cause 
hub_port_resume() to call hub_port_logical_disconnect(), which has the 
effect of doing a logical disconnect on the device.

There are other, redundant code paths that perform this check even when 
CONFIG_USB_SUSPEND isn't set, but they are more difficult to describe.  
For example, look at uhci_check_and_reset_hc() in 
drivers/usb/host/pci-quirks.c.

You'll find that nowhere in the resume pathway does the kernel check
serial numbers or anything else of that nature.  If the power session has
not been interrupted, that's sufficient proof that the device hasn't been
unplugged.

> This is why you can suspend to disk, and when you resume, your open 
> files are still valid; the disk is found to be still there, so it 
> continues to be accessible.  Nothing gets clobbered as a result of the 
> disk seeming to be disconnected and reconnected.  If that does happen, 
> it is a bug. 

It may work that way with SCSI disks or IDE disks, which are not
hotpluggable.  But it does happen with USB disks, and it's not a bug;
it's by design.


> > Second, with USB at any rate, in addition to checking that hardware is 
> > still there, the kernel queries the USB controller to see if a disconnect 
> > occurred while the system was asleep.  (If the controller wasn't powered 
> > during that time then it will report that every USB device was 
> > disconnected.)
> >   
> 
> AFAIK, there is no interface by which the kernel can query that 
> information from the controller, maybe you could show me?

Again, in hub.c look at hub_events().  It's a rather long routine, but at 
some point you can see where it checks (portchange & 
USB_PORT_STAT_C_CONNECTION).  The constant stands for "Port Status Changed 
Connection", meaning there has been a plug/unplug event.  If the test 
succeeds then connect_change is set to 1, causing 
hub_port_connect_change() to be called.  One of the first things that 
routine does is call usb_disconnect() on the port's child device.

>  If that is 
> the case however, then I consider that to be a bug with the USB bus and 
> the kernel's handling of it.  The kernel needs to be able to assume that 
> nothing was disconnected while it was shutdown, provided that the same 
> devices are there now as when it went to sleep.

You've got it exactly backwards.  The kernel doesn't need to make that 
assumption because the hardware will _tell_ it whether anything was 
disconnected.  Rather, the kernel needs to _avoid_ making the assumption 
that the device there now is the same as the device that was there before, 
merely because a serial number (or something equivalent) happens to match.  
Note: many USB mass storage devices don't have serial numbers.

>  This is how it behaves 
> for say, SCSI disks in desktops/servers, where the controller certainly 
> is completely powered off.  It should work the same for USB. 

No it shouldn't.  USB is a different kind of bus from SCSI; it has
different specifications and standards, and it should behave differently.


> > Third, there is indeed something special that monitors USB device 
> > insertion/removal while suspended to RAM -- the USB host controller does 
> > so if it has suspend power.
> >
> >   
> 
> Could you site references to that?  AFAIK, the host controller is only 
> capable of generating a wake event when the bus state changes; it does 
> not have a means of informing the OS what has changed, aside from the OS 
> enumerating the devices on the bus again. 

Take a look, for example, at the UHCI specification (available from 
<http://developer.intel.com/technology/usb/uhci11d.htm>).  Section 2.1.7 
describes the Port Status and Control register, which indicates (for each 
port) whether a connect-change event has taken place, as well as many 
other things.


> If the mounted filesystem becomes corrupted over a hibernation because 
> the kernel thinks the drive was unplugged, then plugged back in, that 
> clearly is a bug. It does not do this for disks connected via other bus 
> types, and it clearly is undesirable to corrupt data in this way. 

I agree that it's annoying and undesirable, but it's not a bug.  Other 
buses would work this way too if they were hotpluggable, like USB.


> > It's not a bug if the device _has_ been unplugged and reconnected.  When 
> > that happens, there's no way for the kernel to tell whether the device 
> > there now is the same as the device that used to be there.
> >
> >   
> 
> Again, we're not talking about it actually being unplugged, though since 
> the kernel has no way of knowing it, you can unplug a scsi disk while 
> hibernated, then plug it back in before you resume, and it will work 
> just fine since the same type of hardware with the same serial number et 
> al is found in the same place on the bus. 

As I said above, SCSI isn't the same as USB.

By the way, usb-storage in 2.4 used to work (still does, in fact) more 
along the lines you're describing.  You could unplug a drive and the 
kernel's disk data structures would be kept intact.  Later on, when you 
replugged the drive it would be re-associated with those data structures, 
using some not-go-great heuristics for trying to find a match, and you 
could pick up where you left off.

Then at some point during the 2.5 development sequence, Linus put his foot
down.  He said that when a device goes away, it's _gone_!  That was the
end of it.  Ever since, unplugging a USB drive (or any other kind of USB
device) causes all its device structures to be released.

Alan Stern

