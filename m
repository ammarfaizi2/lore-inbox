Return-Path: <linux-kernel-owner+w=401wt.eu-S1161228AbXAHLK5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161228AbXAHLK5 (ORCPT <rfc822;w@1wt.eu>);
	Mon, 8 Jan 2007 06:10:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161227AbXAHLK5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 8 Jan 2007 06:10:57 -0500
Received: from smtp-101-monday.noc.nerim.net ([62.4.17.101]:3873 "EHLO
	mallaury.nerim.net" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1161228AbXAHLK4 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 8 Jan 2007 06:10:56 -0500
Date: Mon, 8 Jan 2007 12:10:55 +0100
From: Jean Delvare <khali@linux-fr.org>
To: "Mark M. Hoffman" <mhoffman@lightlink.com>
Cc: Adrian Bunk <bunk@stusta.de>, greg@kroah.com,
       linux-pci@atrey.karlin.mff.cuni.cz, linux-kernel@vger.kernel.org
Subject: Re: [-mm patch] drivers/pci/quirks.c: cleanup
Message-Id: <20070108121055.d25c8ffa.khali@linux-fr.org>
In-Reply-To: <20070107154441.GB22558@jupiter.solarsys.private>
References: <20061219041315.GE6993@stusta.de>
	<20070105095233.4ce72e7e.khali@linux-fr.org>
	<20070107154441.GB22558@jupiter.solarsys.private>
X-Mailer: Sylpheed version 2.2.10 (GTK+ 2.8.20; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Mark,

On Sun, 7 Jan 2007 10:44:41 -0500, Mark M. Hoffman wrote:
> Hi Jean, Adrian:
> 
> > On Tue, 19 Dec 2006 05:13:15 +0100, Adrian Bunk wrote:
> > > @@ -1122,6 +1123,14 @@ static void quirk_sis_96x_smbus(struct p
> > >  	pci_write_config_byte(dev, 0x77, val & ~0x10);
> > >  	pci_read_config_byte(dev, 0x77, &val);
> > >  }
> > > +DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_SI,	PCI_DEVICE_ID_SI_961,		quirk_sis_96x_smbus );
> > > +DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_SI,	PCI_DEVICE_ID_SI_962,		quirk_sis_96x_smbus );
> > > +DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_SI,	PCI_DEVICE_ID_SI_963,		quirk_sis_96x_smbus );
> > > +DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_SI,	PCI_DEVICE_ID_SI_LPC,		quirk_sis_96x_smbus );
> > > +DECLARE_PCI_FIXUP_RESUME(PCI_VENDOR_ID_SI,	PCI_DEVICE_ID_SI_961,		quirk_sis_96x_smbus );
> > > +DECLARE_PCI_FIXUP_RESUME(PCI_VENDOR_ID_SI,	PCI_DEVICE_ID_SI_962,		quirk_sis_96x_smbus );
> > > +DECLARE_PCI_FIXUP_RESUME(PCI_VENDOR_ID_SI,	PCI_DEVICE_ID_SI_963,		quirk_sis_96x_smbus );
> > > +DECLARE_PCI_FIXUP_RESUME(PCI_VENDOR_ID_SI,	PCI_DEVICE_ID_SI_LPC,		quirk_sis_96x_smbus );
> > >  
> > >  /*
> > >   * ... This is further complicated by the fact that some SiS96x south
> > > @@ -1158,6 +1167,8 @@ static void quirk_sis_503(struct pci_dev
> > >  	 */
> > >  	dev->device = devid;
> > >  }
> > > +DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_SI,	PCI_DEVICE_ID_SI_503,		quirk_sis_503 );
> > > +DECLARE_PCI_FIXUP_RESUME(PCI_VENDOR_ID_SI,	PCI_DEVICE_ID_SI_503,		quirk_sis_503 );
> 
> * Jean Delvare <khali@linux-fr.org> [2007-01-05 09:52:33 +0100]:
> > Was this patch tested on the SiS-based boards which need these quirks?
> > I think you broke them. If I remember correctly, quirk_sis_503() must
> > be called before quirk_sis_96x_smbus() for some boards to work
> > properly, and we currently rely on the linking order to guarantee that.
> > Likewise, quirk_sis_96x_compatible() should be called before
> > quirk_sis_503() otherwise the warning message in quirk_sis_503() will
> > no longer be correct.
> > 
> > So if you want to put the calls right after the quirk functions, you
> > need to reorder the functions themselves as well. Feel free to add a
> > comment explaining the order requirement so that nobody breaks it
> > accidentally again in the future.
> 
> It is fragile for this code to depend on link order; Adrian's obvious and
> trivial cleanups broke it.  Not only that, but some FC kernels had/have the
> link order reversed such that this quirk is broken anyway.

The former problem would be addressed just fine by a proper ordering
(as Adrian's patch was attempting to bring) and a comment explaining
the dependency.

> I sent a patch for this back in May:
> http://lists.lm-sensors.org/pipermail/lm-sensors/2006-May/016113.html
> 
> There was some discussion on the linux-pci mailing list as well; can't seem to
> find an archive of that though.  Basically, it was not understood how the FC
> kernels could have a reversed link order.  I never followed up on it, my bad.

As long as it isn't explained, I call it a compiler bug in FC.

> At any rate, can we please get the patch above applied?  I will send a new one
> if necessary.

This is a PCI patch, so I'm not the one picking it. I seem to remember
Greg was fine with the patch except for the comment about the linking
order.

BTW, the Intel (Asus) SMBus unhiding quirk also depends on the linking
order if I'm not mistaking, and quite frankly I don't see a way to
"fix" it if we decide to no longer trust the linking order.

-- 
Jean Delvare
