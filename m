Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261368AbUA3PDZ (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 30 Jan 2004 10:03:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261563AbUA3PDZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 30 Jan 2004 10:03:25 -0500
Received: from mail0.lsil.com ([147.145.40.20]:10435 "EHLO mail0.lsil.com")
	by vger.kernel.org with ESMTP id S261368AbUA3PDT (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 30 Jan 2004 10:03:19 -0500
Message-ID: <0E3FA95632D6D047BA649F95DAB60E57033BC33D@exa-atlanta.se.lsil.com>
From: "Mukker, Atul" <Atulm@lsil.com>
To: "'hch@infradead.org'" <hch@infradead.org>
Cc: "'James Bottomley'" <James.Bottomley@SteelEye.com>,
       "'marcelo.tosatti@cyclades.com'" <marcelo.tosatti@cyclades.com>,
       Matt_Domsch@dell.com,
       "'linux-kernel@vger.kernel.org'" <linux-kernel@vger.kernel.org>,
       linux-scsi@vger.kernel.org
Subject: RE: ANNOUNCE: megaraid driver version 2.10.1
Date: Fri, 30 Jan 2004 10:03:00 -0500
MIME-Version: 1.0
X-Mailer: Internet Mail Service (5.5.2657.72)
Content-Type: text/plain;
	charset="iso-8859-1"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Christoph,

I am in process of testing the next version of the megaraid driver. I faced
an issue while doing the insmod-rmmod sequence. Your patch for PCI hotplug
does "pci_disable_device" when the driver is unloaded.

The insmod-rmmod-insmod fails the first time unless you do an explicit
pci_set_master at driver load time, since pci_enable_device does not seem to
enable bus mastering, which is disabled by pci_disable_device.

Even with pci_set_master, insmod stalls the CPU after about 2-3 hours of
insmod-rmmod sequence. So I took out the pci_disable_device altogether to
find out it takes only longer, about 9 hours, but CPU stalls at the exact
location again with a NMI watchdog. It happens when the driver issues the
first command to the FW, which is never received by it and driver gets stuck
in a forever cpu_relax loop waiting for the command to complete

After an hour or two I get "Unable to proc_mkdir in
scsi.c/build_proc_dir_entries", but that's another story.

The kernel is a genre of 2.4.21

Any ideas....

Thanks
-Atul Mukker
LSI Logic

> -----Original Message-----
> From: 'hch@infradead.org' [mailto:hch@infradead.org]
> Sent: Wednesday, January 14, 2004 4:22 AM
> To: Mukker, Atul
> Cc: 'hch@infradead.org'; 'James Bottomley';
> 'linux-kernel@vger.kernel.org'; linux-scsi@vger.kernel.org;
> 'marcelo.tosatti@cyclades.com'; Matt_Domsch@dell.com
> Subject: Re: ANNOUNCE: megaraid driver version 2.10.1
> 
> 
> On Tue, Jan 13, 2004 at 04:39:12PM -0500, Mukker, Atul wrote:
> > The changes in 2.6.1 are rather extensive, so it would be 
> sometime before
> > kernel 2.6.1 version of megaraid is sync'ed against 
> megaraid-2.10.1. Also,
> > we would like to backport the PCI hotplug changes to 2.4.x 
> kernel megaraid
> > as well.
> 
> The problem with backporting is that the 2.4 scsi layer is 
> not hot-plug aware,
> so while you can make the driver detect a newly inserted or 
> removed HBA there's
> no way to tell the SCSI midlayer.
> 
> > +#ifdef SCSI_HAS_HOST_LOCK
> > +#  if LINUX_VERSION_CODE <= KERNEL_VERSION(2,4,9)
> > +		/* This is the Red Hat AS2.1 kernel */
> > +		adapter->host_lock = &adapter->lock;
> > +		host->lock = adapter->host_lock;
> > +#  elif LINUX_VERSION_CODE < KERNEL_VERSION(2,6,0)
> > +		/* This is the later Red Hat 2.4 kernels */
> > +		adapter->host_lock = &adapter->lock;
> > +		host->host_lock = adapter->host_lock;
> > +#  else
> > +		/* This is the 2.6 and later kernel series */
> > +		adapter->host_lock = &adapter->lock;
> > +		scsi_set_host_lock(&adapter->lock);
> > +#  endif
> > +#else
> > +		/* And this is the remainder of the 2.4 kernel series */
> >  		adapter->host_lock = &io_request_lock;
> > +#endif
> 
> This is horribly ugly, but not your faul.  Any chance you could hide
> it into some macro ala megaraid_set_host_lock(adapter, host).
> 
> Also note that in 2.6 scsi_set_host_lock should and could 
> easily be avoided,
> just let your adapter->host_lock point to host->host_lock.
> 
> >  		if((adapter->flag & 
> BOARD_64BIT)&&(sizeof(dma_addr_t) == 8))
> > {
> > -			pci_set_dma_mask(pdev, 0xffffffffffffffff);
> > +			pci_set_dma_mask(pdev, 0xffffffffffffffffULL);
> 
> This needs error return checking.  Again this no regression 
> from the previous
> version, could you please fix it in the next update?
> 
