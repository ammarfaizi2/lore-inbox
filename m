Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261321AbUKIBWX@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261321AbUKIBWX (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 8 Nov 2004 20:22:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261320AbUKIBWX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 8 Nov 2004 20:22:23 -0500
Received: from fmr05.intel.com ([134.134.136.6]:3792 "EHLO hermes.jf.intel.com")
	by vger.kernel.org with ESMTP id S261365AbUKIBRw (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 8 Nov 2004 20:17:52 -0500
Subject: Re: [ACPI] [PATCH/RFC 0/4]Bind physical devices with ACPI devices
From: Li Shaohua <shaohua.li@intel.com>
To: Matthew Wilcox <matthew@wil.cx>
Cc: ACPI-DEV <acpi-devel@lists.sourceforge.net>,
       lkml <linux-kernel@vger.kernel.org>, Len Brown <len.brown@intel.com>,
       Greg <greg@kroah.com>, Patrick Mochel <mochel@digitalimplant.org>
In-Reply-To: <20041108135606.GA2685@parcelfarce.linux.theplanet.co.uk>
References: <1099887066.1750.241.camel@sli10-desk.sh.intel.com>
	 <20041108135606.GA2685@parcelfarce.linux.theplanet.co.uk>
Content-Type: text/plain
Message-Id: <1099961925.15294.19.camel@sli10-desk.sh.intel.com>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 (1.4.6-2) 
Date: Tue, 09 Nov 2004 09:10:33 +0800
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2004-11-08 at 21:56, Matthew Wilcox wrote:
> On Mon, Nov 08, 2004 at 12:11:06PM +0800, Li Shaohua wrote:
> > ACPI provides many functionalities for physical devices. Such as for
> > suspend/resume, ACPI can tell us correct devices D-state for S3. There
> > are tons of devices enhancement for both realtime and boot time from
> > ACPI. To utilize ACPI, physical devices like PCI devices must know its
> > partner. The patches try to do this. After this is done, we can enhance
> > many features, such as improve suspend/resume.
> > These patches are against 2.6.10-rc1, please give your comments.
> 
> I don't think this is a great way to do it.  There's at least two other
> examples of firmware that interacts with drivers in a similar way that you
> could look at -- PA-RISC's PDC and Sun/Apple/IBM OpenFirmware.  I don't
> know much about OpenFirmware, and I just redid the way parisc_device
> works, so I'll discourse about that for a bit.
> 
> From a driver's point of view, it's simple.  Call a function to get
> a cookie (an acpi_handle for ACPI, I guess), then pass that cookie to
> whatever functions necessary.  This is the code in the sym2 SCSI driver:
> 
> #ifdef CONFIG_PARISC
> /*
>  * Host firmware (PDC) keeps a table for altering SCSI capabilities.
>  * Many newer machines export one channel of 53c896 chip as SE, 50-pin HD.
>  * Also used for Multi-initiator SCSI clusters to set the SCSI Initiator ID.
>  */
> static int sym_read_parisc_pdc(struct sym_device *np, struct pdc_initiator *pdc)
> {
>         struct hardware_path hwpath;
>         get_pci_node_path(np->pdev, &hwpath);
>         if (!pdc_get_initiator(&hwpath, pdc))
>                 return 0;
> 
>         return SYM_PARISC_PDC;
> }
> #else
> static int sym_read_parisc_pdc(struct sym_device *np, struct pdc_initiator *x)
> {
>         return 0;
> }
> #endif
> 
> 
> Hm.. ACPI doesn't really hanve anything SCSI-related in it.  Let's look at
> IDE's _GTM and _STM for examples.  
> 
> static void ide_acpi_gtm(struct hwif_s *hwif, struct acpi_timing_mode *tm)
> {
> 	acpi_handle handle;
> 	acpi_buffer buffer = { ACPI_ALLOCATE_BUFFER, NULL};
> 	acpi_status status;
> 
> 	handle = acpi_get_gendev_handle(&hwif->gendev);
> 	status = acpi_evaluate_object(handle, "_GTM", NULL, &buffer);
> 	...
> }
> 
> All we need is an acpi_get_gendev_handle that takes a struct device and
> returns the acpi_handle for it.  Now, maybe that'd be best done by placing
> a pointer in the struct device, but I bet it'd be just as good to walk
> the namespace looking for the corresponding device.
I would agree with you if ACPI just supports PCI bus type, but ACPI
supports many bus types. We can't get an ACPI handler if only has a
'struct device'. You might say we can get its bus type from device->bus,
but we need a 'switch-case' to get what exactly the bus type is, but
this can't apply for loadable module bus type.

Thanks,
Shaohua

