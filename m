Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S271831AbTHHUQJ (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 8 Aug 2003 16:16:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S271834AbTHHUQJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 8 Aug 2003 16:16:09 -0400
Received: from mail.kroah.org ([65.200.24.183]:12677 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S271831AbTHHUQB (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 8 Aug 2003 16:16:01 -0400
Date: Fri, 8 Aug 2003 13:15:17 -0700
From: Greg KH <greg@kroah.com>
To: long <tlnguyen@snoqualmie.dp.intel.com>
Cc: jun.nakajima@intel.com, linux-kernel@vger.kernel.org,
       pcihpd-discuss@lists.sourceforge.net, tom.l.nguyen@intel.com
Subject: Re: Updated MSI Patches
Message-ID: <20030808201516.GA1547@kroah.com>
References: <200308081933.h78JX12u025854@snoqualmie.dp.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200308081933.h78JX12u025854@snoqualmie.dp.intel.com>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Aug 08, 2003 at 12:33:01PM -0700, long wrote:
> >pcihpd-discuss?  Don't you mean the linux-pci mailing list instead?
> pcihpd-discuss is my first assumption of what you mean the linux-pci
> mailing list. Please forward me the email address of the linux-pci
> mailing list.

linux-pci@vger.kernel.org

Also, please wrap your emails at a sane size, you have lines here that
are longer than 900 characters long...  I've reformatted them here to be
able to quote them properly.

> > - Is there any way to dynamically detect if hardware can support MSI?
> The MSI patch dynamically detects whether hardware devices can support
> MSI once the CONFIG_PCI_MSI is set during kernel built.

So why would we ever want CONFIG_PCI_MSI to not be set?  I'm just trying
to make options dynamically happen without users having to worry about
setting a kernel option or not.

> > - If you enable this option, will boxes that do not support it stop
> > working?
> Once users enable this option, all devices that do not support MSI are
> still working. These devices are by default using IRQ pin assertion as
> interrupt generated mechanism since all pre-assigned vectors to any
> enabled IOxAPICs are reserved.

Good, so we can always enable this option, so it doesn't even need to be
an option :)

> >A driver has to be modified to use this option, right?  Do you have any
> >drivers that have been modified?  Without that, I don't think we can
> >test this patch out, right?
> MSI support may be transparent to some device drivers.

Yet you provide an api for drivers to use, right?  Why would a driver
want to use this api instead of just having the hardware work properly
on its own?  I guess I'm confused as to how to modify drivers to support
this, or if that's even needed to be done.

> > +++ linux-2.6.0-test2-create-vectorbase/include/asm-i386/mach-default/irq_vectors.h	2003-08-05 09:25:54.000000000 -0400
> > @@ -76,9 +76,14 @@
> >   * Since vectors 0x00-0x1f are used/reserved for the CPU,
> >   * the usable vector space is 0x20-0xff (224 vectors)
> >   */
> > +#define NR_VECTORS 256
> 
> >Will this _always_ be the value?  Can boxes have bigger numbers (I
> >haven't seen the spec, so I don't know...)
> Yes, this will always be 256 since the current CPU architecture
> supports a maximum of 256 vectors.

The "current" one does.  What happens in a few months when I go to help
bring up the next gen hardware platform?  Will I run into the problem
that this number needs to be increased?  Can we determine it at
run-time?

> > +++ linux-2.6.0-test2-create-msi/arch/i386/kernel/i386_ksyms.c	2003-08-05 09:45:25.000000000 -0400
> > @@ -166,6 +166,11 @@
> >  EXPORT_SYMBOL(IO_APIC_get_PCI_irq_vector);
> >  #endif
> >  
> > +#ifdef CONFIG_PCI_MSI
> > +EXPORT_SYMBOL(msix_alloc_vectors);
> > +EXPORT_SYMBOL(msix_free_vectors);
> > +#endif
> > +
> >  #ifdef CONFIG_MCA
> >  EXPORT_SYMBOL(machine_id);
> >  #endif
> 
> >Put the EXPORT_SYMBOL in the files that have the functions.  Don't
> >clutter up the ksyms.c files anymore.
> Agree. Will put these EXPORT_SYMBOL(s) in the file
> ../include/asm-i386/hw_irq.h where these functions are declared as
> extern. Thanks.

No, it needs to go into the .c file where the function is.

> > +u32 device_nomsi_list[DRIVER_NOMSI_MAX] = {0, };
> 
> >Shouldn't this be static?
> 
> > +u32 device_msi_list[DRIVER_NOMSI_MAX] = {0, };
> 
> >Same with this one?
> 
> In the initial design draft, I am thinking of defining
> DRIVER_NOMSI_MAX as 32 since it may be impossible to have more than 32
> MSI capable devices populated in the same system. I will add some
> comments to it and look forward for your comments.

Um, I ment the variable is in the global symbol table, and it doesn't
look like it needs to be.

But your comment about number of devices is also a good one.  Any way we
can figure that out at run-time too?  What happens when I hot-add the 33
MSI capable device?  Or just boot with that many devices (I've seen
boxes with 100s of pci devices all attached to one system)?

thanks,

greg k-h
