Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264784AbSJOUhh>; Tue, 15 Oct 2002 16:37:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264788AbSJOUhh>; Tue, 15 Oct 2002 16:37:37 -0400
Received: from 12-231-249-244.client.attbi.com ([12.231.249.244]:20489 "HELO
	kroah.com") by vger.kernel.org with SMTP id <S264784AbSJOUgh>;
	Tue, 15 Oct 2002 16:36:37 -0400
Date: Tue, 15 Oct 2002 13:42:36 -0700
From: Greg KH <greg@kroah.com>
To: Steven Dake <sdake@mvista.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [ANNOUNCE] [PATCHES] Advanced TCA Hotswap Support in Linux Kernel
Message-ID: <20021015204235.GJ15864@kroah.com>
References: <3DAB1007.6040400@mvista.com> <20021015005909.GC10278@kroah.com> <3DAC60C6.9090507@mvista.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3DAC60C6.9090507@mvista.com>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 15, 2002 at 11:39:02AM -0700, Steven Dake wrote:
> The spec hasn't ratified yet and I don't have a copy (I only have 
> pre-spec hardware).  I think distribution is limited to PICMG members 
> once a spec is available, but I'm not sure.  Who needs specs anyway :)

Heh, so are there any other devices besides the qlogic device that
support this?

> >	- are you going to be generating a 2.5 version of this so that
> >	  this feature can be added to the main kernel tree?
> >
> If you think it would be accepted, I'd spend the time making 2.5 kernel 
> patches.  Beyond your other comments, any suggestions to get it accepted?

I think those comments are a great start, fix all of them, and I'd be
glad to look at the code again.

> >	- Why don't you use the existing kernel way of notifying
> >	  userspace of hotplug events, through /sbin/hotplug?
> >
> The hotplug events occur through IPMI (a system management interface 
> specification) messages.  I'm not sure if the hotswap manager will go in 
> the kernel or not, but if it were in the kernel, it could use 
> /sbin/hotplug to notify management software of hotswap events (which 
> would allow the scsi hotswap commands to be used to add or remove 
> devices).  Initially I am going to probably do a user space manager 
> since its simpler and I think that sort of thing probably belongs in 
> user space.  It will access the IPMI driver, read hotswap events from 
> the IPMI driver, and swap in and out devices and map/unmap devices via 
> the ga mapper.

Hm, sounds like the IPMI driver needs to be generating /sbin/hotplug
events itself.  That way everything could be done in userspace, right?

> Perhaps what is really needed is a kernel driver that uses the IPMI 
> driver kernel interface to pump disk device hotswap messages through 
> /sbin/hotplug.

Could the IPMI core do that itself?

> After I get a userspace implementation working (which is 
> easier to debug and test) I can start work on something like this.  What 
> would you think of that?  The nice thing about using /sbin/hotplug is 
> more things can be scripted like automatically removing a MD disk if the 
> hotswapped device is part of an MD device.
> 
> I've not started on this component yet and am just figuring out the IPMI 
> messaging at this point.  Any comments you have on how to best integrate 
> this into the current hotplug system would be highly welcomed.

I don't know a thing about IPMI.  Feel free to ask questions here, or on
the linux-hotplug-devel list if you want to.

> >	- You create a lot of new ioctls, which is not nice.  You should
> >	  probably do what was done for the pci hotplug subsystem, and
> >	  create a ram based filesystem for this subsystem.  That way
> >	  you don't need to have a /dev node, and the userspace tools
> >	  become dirt simple.
> > 
> >
> I'll have to look at that.  I'm not familiar with the ram based 
> filesystem.  Could you point me to a source file that uses some of the 
> interfaces?

In the 2.4 kernel tree take a look at:
	drivers/hotplug/pci_hotplug_core.c
and there's an article at:
	http://www.linuxjournal.com/article.php?sid=5633
on how some of that stuff works.

In the 2.5 kernel, things are much easier, with the libfs code.  Take a
look at:
	drivers/hotplug/pci_hotplug_core.c
	drivers/usb/core/inode.c
	fs/driverfs/inode.c
for 3 different implementations of ramfs based file systems.

Hope this helps,

greg k-h
