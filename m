Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264807AbSJOUqw>; Tue, 15 Oct 2002 16:46:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264805AbSJOUqt>; Tue, 15 Oct 2002 16:46:49 -0400
Received: from 12-231-249-244.client.attbi.com ([12.231.249.244]:22537 "HELO
	kroah.com") by vger.kernel.org with SMTP id <S264792AbSJOUqC>;
	Tue, 15 Oct 2002 16:46:02 -0400
Date: Tue, 15 Oct 2002 13:52:00 -0700
From: Greg KH <greg@kroah.com>
To: Steven Dake <sdake@mvista.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [ANNOUNCE] [PATCHES] Advanced TCA Hotswap Support in Linux Kernel
Message-ID: <20021015205200.GK15864@kroah.com>
References: <3DAB1007.6040400@mvista.com> <20021015052916.GA11190@kroah.com> <3DAC52A7.907@mvista.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3DAC52A7.907@mvista.com>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 15, 2002 at 10:38:47AM -0700, Steven Dake wrote:
> >In looking at this patch (and the others) it looks like you are relying
> >on devfs being in the system.  Is this true?  What about the other 99%
> >of machines out there with devfs disabled?
> > 
> >
> Hopefully these machines that have devfs disabled aren't ATCA machines 
> :)  It is true that devfs is REQUIRED for the GA Mapping.

Given that there are a number of kernel developers working their
respective asses off trying to get devfs out of the kernel (by obsoleting
it), I would not really recommend tying your driver to it if you want it
to be around for very long :)

> It isn't 
> required for the scsi hotswap feature.  The reason it is required for 
> gamapping is that devices must be defineable at runtime during hot swap 
> events and /dev/sda is inappropriate for several reasons as named access 
> to a device.  I can't see any other way to do it, although I could 
> provide some library in userspace that translates /dev/sda into 
> chassis/slots.  The downside of this technique is now the user must use 
> some utility to find out which device to access when using fdisk, etc 
> instead of just using the device directly.

Take a look at the driverfs tree in 2.5, and see how you could tie into
that.  I think everything you need is there, if not, please let us know.

> >You are re-using minors that have previously been reserved.  Does this
> >mean Montavista is dropping their PICMG patches?
> > 
> I had requested these minors in our rev1 of the PICMG 2.12 hotswap 
> patches.  During a rework of the picmg patches another developer dropped 
> the minors and nobody is using the old code, so I thought I could reuse 
> them.  This is probably bad mojo, but I think its ok :)

Hm, if the picmg code is dropped, why is it in the CGL release?  And a
lot of code in the picmg patch was good, I'd hate to see it go away :(

But I agree, the picmg minors are not needed (it should tie into the
existing pci hotplug interface, and not use a minor), so as long as you
talked the pcimg people into it, that's fine.

> At this point, there isn't anything using them.  I am working on a 
> hotswap manager, that may be in kernel space (for performance reasons) 
> that may use these interfaces.  I'm also working on a SAFTE Hotswap 
> processor module (ie; drivers/scsi/sp.c) for the SCSI subsystem that 
> uses these interfaces.  (Safte is a hotswap standard for SCSI chassis).

As I mentioned previously, this can probably be done in userspace (unless
you have some unreasonable performance reasons, what are the
requirements?)

> >You shouldn't use a #ifdef within this .c file.  I think you could move
> >it to your specific file, and then use #ifdef within a .h file.  This
> >also goes for your other change to this file.
> > 
> >
> I'm not so sure about this.  The reason this file is patched is to 
> support things like fdisk changes (rexporting partitions after an fdisk) 
> and initial setup.  I could provide an "alternate" check.c but would 
> rather not have to maintain the bug fixes from check.c to check_alt.c. 
> devfs_gamap_register_partition could be in a seperate file, but 
> devfs_register_partition is a generic function used by other parts of 
> the kernel that needs ifdef patches (or two seperate implementations).

Hm, no I don't think you need to do that.  Just put your logic in a
function, and provide a null function if your CONFIG variable is not
present.

> maybe not.  I think there is still a little bit of slop in the patches. 
> As you can tell, I've not code reviewed the driver yet (thats what you 
> guys are for :) and there are some things that need improvement.

Ah, didn't realize we were the first line of quality control :)

> >As the gendisk interface has been cleaned up a _lot_ in 2.5, I'm not so
> >sure how well this implementation will now work.
> >
> >Pretty much the same comments apply for your scsi-hotswap-main.patch
> >(devfs reliance, coding style, loads of ioctls, long ioctl function
> >names, global functions that don't need to be, etc.)
> > 
> >
> the scsi-hotswap-main patch can use devfs, but shouldn't rely on it. 
> Ioctls are only to provide user space access to the kernel features. 
> global functions, as in global in the symbol table (via EXPORT_SYMBOL?)

ioctls should be not used, instead a ram based fs like I mentioned in
the previous reply.

> >I also noticed that this code is included in the CGL CVS tree.  What is
> >MontaVista's (and yours) future plans for this feature?  Do you want it
> >in the main kernel tree, and are you willing to port it to 2.5?
> > 
> >
> I'd love to see ATCA support in the main kernel (if it would be 
> accepted). Maintaining patches against 2.4 is ok (since it has slowed 
> down to bug fixes mostly).   I really don't want to maintain these 
> patches against every minor release of 2.5 for now until 2.6 is 
> stabilized if I can help it.  I think these sorts of things belong in 
> the kernel, atleast the SCSI hotswap patches.

I agree, come up with a 2.5 version, and let us see what it looks like.

> These patches also depend on the Qlogic QLA 2300 driver which isn't in 
> the kernel.  Would this also be included?  We can talk to the QLogic 
> guys and see if they want to submit their driver to the 2.5 trees...

That's up to the QLogic people, I'm just too confused with the vast
number of different drivers from them :)

> If you can suggest a route for getting these patches accepted into the 
> 2.5 trees (beyond a port to 2.5 and the above suggested changes) i'd 
> love to hear them.

That's a good start.

thanks,

greg k-h
