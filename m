Return-Path: <linux-kernel-owner+w=401wt.eu-S1750870AbXAEX3N@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750870AbXAEX3N (ORCPT <rfc822;w@1wt.eu>);
	Fri, 5 Jan 2007 18:29:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750871AbXAEX3N
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 5 Jan 2007 18:29:13 -0500
Received: from emailhub.stusta.mhn.de ([141.84.69.5]:2351 "HELO
	mailout.stusta.mhn.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S1750869AbXAEX3N (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 5 Jan 2007 18:29:13 -0500
Date: Sat, 6 Jan 2007 00:29:13 +0100
From: Adrian Bunk <bunk@stusta.de>
To: Jean Delvare <khali@linux-fr.org>
Cc: greg@kroah.com, linux-pci@atrey.karlin.mff.cuni.cz,
       linux-kernel@vger.kernel.org,
       "Mark M. Hoffman" <mhoffman@lightlink.com>,
       Linus Torvalds <torvalds@osdl.org>
Subject: Re: [-mm patch] drivers/pci/quirks.c: cleanup
Message-ID: <20070105232913.GU20714@stusta.de>
References: <20061219041315.GE6993@stusta.de> <20070105095233.4ce72e7e.khali@linux-fr.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20070105095233.4ce72e7e.khali@linux-fr.org>
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jan 05, 2007 at 09:52:33AM +0100, Jean Delvare wrote:
> Hi Adrian,
> 
> On Tue, 19 Dec 2006 05:13:15 +0100, Adrian Bunk wrote:
> > This patch contains the following cleanups:
> > - move all EXPORT_SYMBOL's directly below the code they are exporting
> > - move all DECLARE_PCI_FIXUP_*'s directly below the functions they
> >   are calling
> 
> Thanks for doing this cleanup, it was really needed. I think you didn't
> get everything right though:
>...
> > @@ -1122,6 +1123,14 @@ static void quirk_sis_96x_smbus(struct p
> >  	pci_write_config_byte(dev, 0x77, val & ~0x10);
> >  	pci_read_config_byte(dev, 0x77, &val);
> >  }
> > +DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_SI,	PCI_DEVICE_ID_SI_961,		quirk_sis_96x_smbus );
> > +DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_SI,	PCI_DEVICE_ID_SI_962,		quirk_sis_96x_smbus );
> > +DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_SI,	PCI_DEVICE_ID_SI_963,		quirk_sis_96x_smbus );
> > +DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_SI,	PCI_DEVICE_ID_SI_LPC,		quirk_sis_96x_smbus );
> > +DECLARE_PCI_FIXUP_RESUME(PCI_VENDOR_ID_SI,	PCI_DEVICE_ID_SI_961,		quirk_sis_96x_smbus );
> > +DECLARE_PCI_FIXUP_RESUME(PCI_VENDOR_ID_SI,	PCI_DEVICE_ID_SI_962,		quirk_sis_96x_smbus );
> > +DECLARE_PCI_FIXUP_RESUME(PCI_VENDOR_ID_SI,	PCI_DEVICE_ID_SI_963,		quirk_sis_96x_smbus );
> > +DECLARE_PCI_FIXUP_RESUME(PCI_VENDOR_ID_SI,	PCI_DEVICE_ID_SI_LPC,		quirk_sis_96x_smbus );
> >  
> >  /*
> >   * ... This is further complicated by the fact that some SiS96x south
> > @@ -1158,6 +1167,8 @@ static void quirk_sis_503(struct pci_dev
> >  	 */
> >  	dev->device = devid;
> >  }
> > +DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_SI,	PCI_DEVICE_ID_SI_503,		quirk_sis_503 );
> > +DECLARE_PCI_FIXUP_RESUME(PCI_VENDOR_ID_SI,	PCI_DEVICE_ID_SI_503,		quirk_sis_503 );
> 
> Was this patch tested on the SiS-based boards which need these quirks?
> I think you broke them. If I remember correctly, quirk_sis_503() must
> be called before quirk_sis_96x_smbus() for some boards to work
> properly, and we currently rely on the linking order to guarantee that.
> Likewise, quirk_sis_96x_compatible() should be called before
> quirk_sis_503() otherwise the warning message in quirk_sis_503() will
> no longer be correct.
> 
> So if you want to put the calls right after the quirk functions, you
> need to reorder the functions themselves as well. Feel free to add a
> comment explaining the order requirement so that nobody breaks it
> accidentally again in the future.
>...

Thanks for this information.

While looking at the code, I also noted the following:

quirk_sis_96x_compatible() is pretty useless since all it does is to set 
a static variable that is only used in a printk().

quirk_sis_96x_compatible() was added with:


    2003/05/13 13:48:50-07:00 mhoffman
    [PATCH] i2c: Add SiS96x I2C/SMBus driver
    
    This patch adds support for the SMBus of SiS96x south
    bridges.  It is based on i2c-sis645.c from the lm sensors
    project, which never made it into an official kernel and
    was anyway mis-named.
    
    This driver works on my SiS 645/961 board vs w83781d.


It's usage in


static void __init quirk_sis_503_smbus(struct pci_dev *dev)
{
       if (sis_96x_compatible)
               quirk_sis_96x_smbus(dev);
}


Was removed in


Author: torvalds <torvalds>
Date:   Thu Oct 30 19:03:38 2003 +0000

    Stop SIS 96x chips from lying about themselves.
    
    Some machines with the SIS 96x southbridge have it set up
    to claim it is a SIS 503 chip. That breaks irq routing logic
    among other things. Fix it properly by making everybody aware
    of the duplicity.


Was this intentional (and quirk_sis_96x_compatible() should be removed), 
or is this a bug that should be fixed?


> Thanks,
> Jean Delvare


cu
Adrian

-- 

       "Is there not promise of rain?" Ling Tan asked suddenly out
        of the darkness. There had been need of rain for many days.
       "Only a promise," Lao Er said.
                                       Pearl S. Buck - Dragon Seed

