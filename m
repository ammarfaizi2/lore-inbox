Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S274879AbTHKVTy (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 11 Aug 2003 17:19:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S274878AbTHKVTy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 11 Aug 2003 17:19:54 -0400
Received: from mail.kroah.org ([65.200.24.183]:20677 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S274879AbTHKVTt (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 11 Aug 2003 17:19:49 -0400
Date: Mon, 11 Aug 2003 14:16:55 -0700
From: Greg KH <greg@kroah.com>
To: long <tlnguyen@snoqualmie.dp.intel.com>
Cc: jun.nakajima@intel.com, linux-kernel@vger.kernel.org,
       pcihpd-discuss@lists.sourceforge.net, tom.l.nguyen@intel.com
Subject: Re: Updated MSI Patches
Message-ID: <20030811211654.GA18578@kroah.com>
References: <200308112051.h7BKp9ZU003007@snoqualmie.dp.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200308112051.h7BKp9ZU003007@snoqualmie.dp.intel.com>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 11, 2003 at 01:51:09PM -0700, long wrote:
> > Good, so we can always enable this option, so it doesn't even need 
> > to be an option :)
> Agree. Will eliminate CONFIG_PCI_MSI to make this option dynamically 
> happens.

Thank you.

> > A driver has to be modified to use this option, right?  Do you have 
> > any drivers that have been modified?  Without that, I don't think we
> > can test this patch out, right?
> > MSI support may be transparent to some device drivers.
> 
> > Yet you provide an api for drivers to use, right?  Why would a driver
> > want to use this api instead of just having the hardware work properly
> > on its own?  I guess I'm confused as to how to modify drivers to 
> > support this, or if that's even needed to be done.
> There are two types of MSI capable devices: one supports the MSI 
> capability structure and other supports the MSI-X capability structure.
> The patches provide two APIs msix_alloc_vectors/msix_free_vectors for 
> only devices, which support the MSI-X capability structure, to request
> for additional messages. By default, each MSI/MSI-X capable device 
> function is allocated with one vector for below reasons:
> - To achieve a backward compatibility with existing drivers if possible.
> - Due to the current implementation of vector assignment, all devices 
>   that support the MSI-capability structure work with no more than one 
>   allocated vector.
> - The hardware devices, which support the MSI-X capability structure, 
>   may indicate the maximum capable number of vectors supported (32 
>   vectors as example). However, the device drivers may require only 
>   four. With provided APIs, the optimization of MSI vector allocation 
>   is achievable.
> 
> The existing driver is required to be modified if and only if its
> hardware/software synchronization is not provided; that means, the 
> hardware device may generate multiple messages from the same vector. 
> These messages may be lost; the results may be unpredictable. To 
> overcome this issue, the existing driver driver requires to provide 
> the hardware/software synchronization to ask its hardware device to 
> generate one message at a time.

Ok, that makes a little more sense.  I'm guessing that new hardware will
need to have their drivers modified to support this if it is needed.

> > > +++ linux-2.6.0-test2-create-vectorbase/include/asm-i386/mach-default/irq_vectors.h	2003-08-05 09:25:54.000000000 -0400
> > > @@ -76,9 +76,14 @@
> > >   * Since vectors 0x00-0x1f are used/reserved for the CPU,
> > >   * the usable vector space is 0x20-0xff (224 vectors)
> > >   */
> > > +#define NR_VECTORS 256
> > 
> > >Will this _always_ be the value?  Can boxes have bigger numbers (I
> > >haven't seen the spec, so I don't know...)
> > Yes, this will always be 256 since the current CPU architecture
> > supports a maximum of 256 vectors.
> 
> > The "current" one does. What happens in a few months when I go to help
> > bring up the next gen hardware platform?  Will I run into the problem
> > that this number needs to be increased?  Can we determine it at
> > run-time?
> I hope there may be a way to determine the number of vectors supported 
> by CPU during the run-time. I look at the file ../include/asm-i386/mach-
> default/irq_vectors.h, the maximum of vectors (256) is already well 
> commented.

Yeah, but that's in reference to APIC interrupt sources, right?  Does
that correspond to these "vectors" too?  If so, why not just use the
existing NR_IRQS value instead of creating your own?

> > > +u32 device_nomsi_list[DRIVER_NOMSI_MAX] = {0, };
> > 
> > >Shouldn't this be static?
> > 
> > > +u32 device_msi_list[DRIVER_NOMSI_MAX] = {0, };
> > 
> > >Same with this one?
> > 
> > In the initial design draft, I am thinking of defining
> > DRIVER_NOMSI_MAX as 32 since it may be impossible to have more than 32
> > MSI capable devices populated in the same system. I will add some
> > comments to it and look forward for your comments.
> 
> > Um, I ment the variable is in the global symbol table, and it doesn't
> > look like it needs to be.
> 
> > But your comment about number of devices is also a good one.  Any way
> > we can figure that out at run-time too?  What happens when I hot-add 
> > the 33 MSI capable device?  Or just boot with that many devices (I've 
> > seen boxes with 100s of pci devices all attached to one system)?
> The defined variable DRIVER_NOMSI_MAX in device_msi_list[] and 
> device_nomsi_list[] are used to serve mainly as debug purposes since 
> most IHVs have not yet validated their hardware devices.

Heh, but what if I have 33 of the same kind of card in a machine (and
that card has already been "validated")?

> If one of the system has more than 32 MSI capable devices, users can
> enable MSI on all devices by default (by setting
> CONFIG_PCI_MSI_ON_SPECIFIC_DEVICES to 'n') and use boot parameter
> "device_nomsi=" to disable some devices, which have bugs in MSI.

Ugh, I'm trying to get across the point that a user does _not_ want to
have to reconfig their kernel.  Distros do not want to ship a whole
different kernel just for this one option.  That's not acceptable if we
can handle everything dynamically with no problems for the small boxes
as well as the big ones.

> In summary, there are two options provided:
> Option 1: Enable MSI on all MSI capable devices by default and use boot
> parameter "device_nomsi=" to disable specific devices, which have bugs 
> in MSI.

Ok, that's almost acceptable.  How about fixing the bugs in MSI so this
is not needed?  :)


> Option 2 (default): Enable individual MSI capable devices as validation
> purpose by using the boot parameter "device_msi=" to select which 
> devices the kernel supports MSI.

Ick.  How do you specify which "device" this option pertains to?  Do I
have to know the pci id?  What about pci hotplug boxes which decide to
re-arrange the pci ids every other time the box boots (yeah, I've seen
this, no fun...)

How about (if MSI is so troublesome), we just disable MSI all the time,
and provide a sysfs file for MSI to be "enabled" for every device if it
is wanted?  The init scripts could go and enable this as needed.  But
I'm guessing that you can't switch interrupt modes in a device after it
has been initialized, right?  Oh well...

> Note that if this option is chosen, 
> then the use of "device_nomsi" id no longer necessary. This is by 
> default because users may not know how many MSI capable devices 
> populated in their systems and how many of these have bugs in MSI.
> 
> Either one of these options is chosen, I do not think you have any 
> issue of hot-adding the 33 MSI capable device.

So then there is no limit on the number of MSI devices if
CONFIG_PCI_MSI_ON_SPECIFIC_DEVICES is not selected?

thanks,

greg k-h
