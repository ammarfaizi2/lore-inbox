Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030191AbWBMVYc@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030191AbWBMVYc (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 13 Feb 2006 16:24:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030193AbWBMVYc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 13 Feb 2006 16:24:32 -0500
Received: from iolanthe.rowland.org ([192.131.102.54]:51093 "HELO
	iolanthe.rowland.org") by vger.kernel.org with SMTP
	id S1030191AbWBMVYb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 13 Feb 2006 16:24:31 -0500
Date: Mon, 13 Feb 2006 16:24:30 -0500 (EST)
From: Alan Stern <stern@rowland.harvard.edu>
X-X-Sender: stern@iolanthe.rowland.org
To: Phillip Susi <psusi@cfl.rr.com>
cc: Kyle Moffett <mrmacman_g4@mac.com>, Alon Bar-Lev <alon.barlev@gmail.com>,
       Kernel development list <linux-kernel@vger.kernel.org>
Subject: Re: Flames over -- Re: Which is simpler?
In-Reply-To: <43F0EE30.2090409@cfl.rr.com>
Message-ID: <Pine.LNX.4.44L0.0602131601220.4754-100000@iolanthe.rowland.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 13 Feb 2006, Phillip Susi wrote:

> Alan Stern wrote:
> > Okay.  Take a look at drivers/usb/core/hub.c.  The usb_resume_device()  
> > routine is called when resuming either from STR or STD.  If
> > CONFIG_USB_SUSPEND has been set, it calls hub_port_resume(), which in turn
> > calls finish_device_resume().  Inside finish_device_resume() is a call to
> > usb_get_status(), which will fail if the device has not been connected and
> > powered-up throughout the entire suspend.  That failure will cause 
> > hub_port_resume() to call hub_port_logical_disconnect(), which has the 
> > effect of doing a logical disconnect on the device.
> >   
> 
> Interesting.  How does usb_get_status() decide if the device has been 
> connected or not the entire time?

It doesn't decide that -- the device itself does.  If the device was
connected the entire time then it will respond properly.  If it was
disconnected then it will reset itself, losing its address.  Hence it will
not reply to further requests at the old address.  usb_get_status() simply
indicates whether or not a response was received.

>  And do you not agree that if it 
> indicates that the device was disconnected during hibernation, when it 
> in fact, was not, that is a bug?

Note: By "disconnected", I mean that the power session was interrupted.  
So even if the cable remained plugged in, if the bus suspend power wasn't
present then the device was disconnected.  Note also that it is impossible
to tell whether the cable has been unplugged -- the hardware is capable of
detecting only whether or not the power session was interrupted.

Given those caveats, yes, I agree that the routine should not indicate the 
device was disconnected if in fact it wasn't.

> And what if the entire bus was completely powered off, which some 
> systems do?  I know my SCSI bus is completely powered off during 
> hibernation, yet the kernel has no problem figuring out that the same 
> devices are still connected after resume, so it doesn't generate a 
> disconnect event. 

Does the kernel have any problem figuring out when a _different_ device 
of the same type is connected at the old address after resume?

With USB, if the entire bus is powered off then every device on it is
automatically disconnected.  By definition.

> > It may work that way with SCSI disks or IDE disks, which are not
> > hotpluggable.  But it does happen with USB disks, and it's not a bug;
> > it's by design.
> >   
> SCSI and IDE very well can be hot pluggable.  I have hot plugged 
> external SCSI devices numerous times, and even internal IDE drives a 
> time or two.

Have you tried unplugging a SCSI or IDE drive while it was mounted and the 
system was suspended, and then plugging in a different drive in its place?

>  Clearly if the kernel thinks you disconnected your drive 
> and causes data loss, when this is not true, it is a bug.  If it is a 
> flaw by design, that is still a class of bug. 

No.  A bug is unintentional whereas a design flaw is intentional.

You are ignoring the question of how the kernel can tell whether two 
devices are in fact the same.  There is no safe way to do this, other than 
having the hardware verify that the device was connected the whole time.

> > Again, in hub.c look at hub_events().  It's a rather long routine, but at 
> > some point you can see where it checks (portchange & 
> > USB_PORT_STAT_C_CONNECTION).  The constant stands for "Port Status Changed 
> > Connection", meaning there has been a plug/unplug event.  If the test 
> > succeeds then connect_change is set to 1, causing 
> > hub_port_connect_change() to be called.  One of the first things that 
> > routine does is call usb_disconnect() on the port's child device.
> >
> >   
> Interesting again.  This bit exists for each node on the bus and is 
> tracked by the hardware?

Yes.  The registers in the host controller only keep track of devices 
plugged directly into the computer.  Similar registers in external hubs 
keep track of the devices plugged into them.

>  If that is the case, and the hardware is 
> informing the kernel that all devices were disconnected during 
> hibernation when this is not the case, then this clearly is a bug in the 
> hardware, and the kernel possibly should work around it knowing that the 
> hardware lies. 

It's a matter of definition.  By definition, "disconnected" means 
essentially the same thing as "power interrupted".  If you use the wrong 
definition, of course you will think that the hardware lies.

> > You've got it exactly backwards.  The kernel doesn't need to make that 
> > assumption because the hardware will _tell_ it whether anything was 
> >   
> Even if some hardware does, there is a lot of hardware that does not.  
> If hardware that is capable of delivering this information does so in an 
> unreliable manner ( i.e. it lies and says everything is disconnected 
> when it isn't ) then the kernel should ignore that information. 

But it is very reliable.  And all USB hardware does it; it's part of the 
specification.

> If the hardware is capable of accurately and reliably informing the 
> kernel about this information, then that would be useful, but if it is 
> not, then seeing a device that appears to be the same as the one you 
> expect to be there is good enough to decide to continue using it rather 
> than force data loss.  It works fine like that for SCSI and IDE because 
> the user expects the system to work properly after they suspend/resume 
> when they don't mess with the hardware.  If you actually disconnect a 
> device and replace it with another one that otherwise looks the same, 
> but isn't really, then all bets are off.

Indeed.  With USB, many devices look the same.
 
> > No it shouldn't.  USB is a different kind of bus from SCSI; it has
> > different specifications and standards, and it should behave differently.
> >
> >   
> Not if "differently" means "causes data loss when hibernating". 

It works both ways.  What about "causes data loss when a different device 
is plugged in"?

> Other busses can be hot plugged in this way without causing incorrect 
> disconnect events and data loss over hibernation.  The fact that USB 
> causes data loss in the face of such a benegin event as hibernating and 
> resuming ( with no actual hardware change ) is a bug.  Claiming that 
> data loss is an acceptable price to pay for being able to hot plug is 
> silly. 

> If you ACTUALLY unplug the drive, that's fine... if you don't though, 
> and the kernel thinks you did, that is a bug.  If the kernel can 
> reasonably decide that the drive has not actually been unplugged even 
> though the busted hardware indicates it has, then it should not generate 
> a disconnect. 

You are complaining because you don't like the way USB was designed.  
That's fine, but it leaves you advocating a non-standardized position.

Can you suggest a _reliable_ way to tell if the USB device present at a 
port after resuming is the same device as was there before suspending?

Alan Stern

