Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262222AbULQWvO@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262222AbULQWvO (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 17 Dec 2004 17:51:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262221AbULQWuQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 17 Dec 2004 17:50:16 -0500
Received: from e32.co.us.ibm.com ([32.97.110.130]:14758 "EHLO
	e32.co.us.ibm.com") by vger.kernel.org with ESMTP id S262219AbULQWrv
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 17 Dec 2004 17:47:51 -0500
Subject: Re: [tpmdd-devel] Re: [PATCH 1/1] driver: Tpm hardware enablement
	--updated version
From: Kylene Hall <kjhall@us.ibm.com>
To: Greg KH <greg@kroah.com>
Cc: linux-kernel@vger.kernel.org, sailer@watson.ibm.com,
       leendert@watson.ibm.com, Emily Ratliff <emilyr@us.ibm.com>,
       Tom Lendacky <toml@us.ibm.com>, tpmdd-devel@lists.sourceforge.net
In-Reply-To: <20041216224803.GA10542@kroah.com>
References: <Pine.LNX.4.58.0412081546470.24510@jo.austin.ibm.com>
	 <Pine.LNX.4.58.0412161632200.4219@jo.austin.ibm.com>
	 <20041216224803.GA10542@kroah.com>
Content-Type: text/plain
Message-Id: <1103323632.3780.112.camel@jo.austin.ibm.com>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 
Date: Fri, 17 Dec 2004 16:47:13 -0600
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2004-12-16 at 16:48, Greg KH wrote:
Thanks for your help.  Comments and more questions inline.  

> On Thu, Dec 16, 2004 at 04:37:34PM -0600, Kylene Hall wrote:
> > +config TCG_TPM
> > +	tristate "TPM Hardware Support"
> > +	depends on EXPERIMENTAL
> > +	---help---
> > +	  If you have a TPM security chip in your system, which
> > +	  implements the Trusted Computing Group's specification,
> > +	  say Yes and it will be accessible from within Linux. To 
> > +	  compile this driver as a module, choose M here; the module 
> > +	  will be called tpm. For more information see 
> > +	  www.trustedcomputinggroup.org. A implementation of the 
> > +	  Trusted Software Stack (TSS), the userspace enablement piece 
> > +	  of the specification, can be obtained at 
> > +	  http://sourceforge.net/projects/trousers
> > +	  If unsure, say N.
> 
> What happened to the "if built as a module..
> ." text?
It is there in the middle of the paragraph.  I moved it to the end of
the paragraph to make it easier to find in the future.

> 
> > +
> > +config TCG_NSC
> > +	tristate "National Semiconductor TPM Interface"
> > +	depends on TCG_TPM
> > +
> > +config TCG_ATMEL
> > +	tristate "Atmel TPM Interface"
> > +	depends on TCG_TPM
> 
> Please provide help text for these options.
Added.
> 
> > +/*
> > + * Vendor specific TPMs will have a unique name and probe function.
> > + * Those fields should be populated prior to calling this function in
> > + * tpm_<specific>.c's module init function.
> > + */
> > +int register_tpm_driver(struct pci_driver *drv)
> > +{
> > +	drv->id_table = tpm_pci_tbl;
> > +	drv->remove = __devexit_p(tpm_remove);
> > +	drv->suspend = tpm_pm_suspend;
> > +	drv->resume = tpm_pm_resume;
> > +
> > +	return pci_register_driver(drv);
> > +}
> > +
> > +EXPORT_SYMBOL(register_tpm_driver);
> 
> Why not EXPORT_SYMBOL_GPL()?  Based on the content of these drivers, I'd
> feel better if they all were that way, but that's just me :)

> Actually, why even have this function at all?  It's not needed, just
> export the suspend, resume, and remove functions, and you are set.
> 
All fixed.

> Also, don't say that other drivers really support the other pci devices,
> when they do not.  The MODULE_DEVICE_TABLE() stuff needs to be in the
> driver that actually supports that hardware.  Otherwise all of the
> hotplug functionality will not work properly.
> 
So the problem we have is that the chip does not have a unique id and we
are just having to rely on the id of the chipset that the lpc bus is on
therefore either chip (NSC or Atmel, etc.) could claim any of these ids.
Do you have a better suggestion so we can get away from maintaining this
list?  Also, in my latest version this table has been moved to the
header inorder to move to static initialization of the struct pci_driver
as Chris suggested.

> > +
> > +void unregister_tpm_driver(struct pci_driver *drv)
> > +{
> > +	pci_unregister_driver(drv);
> > +}
> > +
> > +EXPORT_SYMBOL(unregister_tpm_driver);
> 
> Um, why even have such a function?
> 
Fixed.
> 
> > +EXPORT_SYMBOL(register_tpm_hardware);
> 
> EXPORT_SYMBOL_GPL() (same goes for all of these exported symbols...)
> 
Fixed.
> > diff -uprN linux-2.6.9/drivers/char/tpm.h linux-2.6.9-tpm/drivers/char/tpm.h
> > --- linux-2.6.9/drivers/char/tpm.h	1969-12-31 18:00:00.000000000 -0600
> > +++ linux-2.6.9-tpm/drivers/char/tpm.h	2004-12-16 17:16:50.000000000 -0600
> > +extern void tpm_time_expired(unsigned long);
> > +extern int rdx(int);
> > +extern void wrx(int, int);
> 
> Please use better names for these functions.  That's very cryptic for a
> global symbol.
Fixed.
> 
> > +extern int lpc_bus_init(struct pci_dev *, u16);
> 
> No "tpm"?
> 
Fixed.
> > +extern int register_tpm_driver(struct pci_driver *);
> > +extern void unregister_tpm_driver(struct pci_driver *);
> > +extern int register_tpm_hardware(struct pci_dev *, struct tpm_chip_ops *,
> > +				 u16);
> 
> Try putting "tpm" first here, for these functions, so the namespace is sane.
> 
Fixed.
> thanks,
> 
> greg k-h
> 
Thanks,
Kylene

> 
> -------------------------------------------------------
> SF email is sponsored by - The IT Product Guide
> Read honest & candid reviews on hundreds of IT Products from real users.
> Discover which products truly live up to the hype. Start reading now. 
> http://productguide.itmanagersjournal.com/
> _______________________________________________
> tpmdd-devel mailing list
> tpmdd-devel@lists.sourceforge.net
> https://lists.sourceforge.net/lists/listinfo/tpmdd-devel
> 

