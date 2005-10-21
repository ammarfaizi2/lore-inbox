Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965087AbVJUSjM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965087AbVJUSjM (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 21 Oct 2005 14:39:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965082AbVJUSjM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 21 Oct 2005 14:39:12 -0400
Received: from rwcrmhc13.comcast.net ([204.127.198.39]:63187 "EHLO
	rwcrmhc12.comcast.net") by vger.kernel.org with ESMTP
	id S965079AbVJUSjK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 21 Oct 2005 14:39:10 -0400
From: Jesse Barnes <jbarnes@virtuousgeek.org>
To: Stefan Richter <stefanr@s5r6.in-berlin.de>, bcollins@debian.org
Subject: Re: new PCI quirk for Toshiba Satellite?
Date: Fri, 21 Oct 2005 11:38:57 -0700
User-Agent: KMail/1.8.91
Cc: linux1394-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org,
       linux-pci@atrey.karlin.mff.cuni.cz, Greg KH <greg@kroah.com>,
       scjody@steamballoon.com, gregkh@suse.de
References: <20051015185502.GA9940@plato.virtuousgeek.org> <20051020000614.GI18295@kroah.com> <4357E2D3.9090206@s5r6.in-berlin.de>
In-Reply-To: <4357E2D3.9090206@s5r6.in-berlin.de>
MIME-Version: 1.0
Content-Type: Multipart/Mixed;
  boundary="Boundary-00=_BXTWDzHha7DMeCR"
Message-Id: <200510211138.57847.jbarnes@virtuousgeek.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--Boundary-00=_BXTWDzHha7DMeCR
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

On Thursday, October 20, 2005 11:32 am, Stefan Richter wrote:
> Greg KH wrote:
> > On Sat, Oct 15, 2005 at 01:40:40PM -0700, Jesse Barnes wrote:
> >> It seems that the PCI config space isn't programmed correctly on
> >> these machines for some reason, so the fix below allows my OHCI
> >> device to work if I pass 'toshiba=1'.  This seems like something
> >> that belongs in the PCI layer instead though, doesn't it?
> >
> > Yes, looks like it should be a pci quirk instead.
>
> I gather from DMI info provided by Rob and Jesse that affected
> machines could be determined by dmi_check_system() using these two
> checks: - DMI_SYS_VENDOR contains "TOSHIBA" && DMI_PRODUCT_VERSION
> contains "PS5", i.e. most of Satellite 5xxx, as well as
>    - DMI_SYS_VENDOR contains "TOSHIBA" && DMI_PRODUCT_VERSION contains
>      "PSM4", i.e. all Satellite M4x.
> A few more series are probably affected too.
>
> http://marc.theaimsgroup.com/?l=linux-kernel&m=112955338318326
> http://marc.theaimsgroup.com/?l=linux-kernel&m=112974457930368
> http://linux.toshiba-dme.co.jp/linux/eng/speclist.php3
>
> BTW, the author of the initial incarnation of the patch is this
> person: http://nemaru.at.infoseek.co.jp/1394.html

Stefan, is a PCI quirk addition possible or do we have to use 
dmi_check_system in the ohci driver itself (since we have to reprogram 
the cache line size in addition to the other registers)?

Something like this is what you had in mind (please forgive the word 
wrapping)?  In ohci1394.c somewhere:

> struct tosh_config_data {
> 	struct pci_dev *dev;
> 	u16 cache_line_size;
> };
>
> int ohci1394_toshiba_reprogram_config(struct dmi_system_id *d)
> {
> 	struct tosh_config_data *data = d->driver_data;
>
> 	mdelay(10);
> 	pci_write_config_word(data->dev, PCI_CACHE_LINE_SIZE,
> 			      data->cache_line_size);
> 	pci_write_config_word(data->dev, PCI_INTERRUPT_LINE, data->dev->irq);
> 	pci_write_config_dword(data->dev, PCI_BASE_ADDRESS_0,
> 			       pci_resource_start(data->dev, 0));
> 	pci_write_config_dword(data->dev, PCI_BASE_ADDRESS_1,
> 			       pci_resource_start(data->dev, 1));
> }

And then in ohci1394_pci_probe():

> struct tosh_config_data tosh_data;
> tosh_data.dev = dev;
> pci_read_config_word(dev, PCI_CACHE_LINE_SIZE,
> 		     &tosh_data.cache_line_size);
> static struct dmi_system_id __initdata toshiba_ohci1394_dmi_table[] =
> { {	/* Handle lack of config space programming on Toshiba laptops */
> .callback = ohci1394_toshiba_reprogram_config,
> 		.ident = "Toshiba PS5 based laptop",
> 		.matches = {
> 			DMI_MATCH(DMI_SYS_VENDOR, "TOSHIBA"),
> 			DMI_MATCH(DMI_PRODUCT_VERSION, "PS5"),
> 		},
> 		.driver_data = &tosh_data;
> 	},
> 	{
> 		.callback = ohci1394_toshiba_reprogram_config,
> 		.ident = "Toshiba PSM4 based laptop",
> 		.matches = {
> 			DMI_MATCH(DMI_SYS_VENDOR, "TOSHIBA"),
> 			DMI_MATCH(DMI_PRODUCT_VERSION, "PSM4"),
> 		},
> 		.driver_data = &tosh_data;
> 	},
> }
>
> dmi_check_system(toshiba_ohci1394_dmi_table);

But then what about the dev->current_state = 4?  Is that necessary?

And is anyone going to put together a patch for this, or should I do it?  
It would be great to have fixed either in 2.6.14 or 2.6.14.1 given that 
it breaks my laptop everytime I upgrade my kernel and forget to delete 
the ieee1394 devices from my initrd.

Jody or Ben, any comment?  I've attached the patch I most recently tested 
for reference.

Thanks,
Jesse

--Boundary-00=_BXTWDzHha7DMeCR
Content-Type: text/x-diff;
  charset="iso-8859-1";
  name="ohci-toshiba-fix-2.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename="ohci-toshiba-fix-2.patch"

diff -X linux-2.6.14-rc2/Documentation/dontdiff -Naur linux-2.6.14-rc2.orig/drivers/ieee1394/ohci1394.c linux-2.6.14-rc2/drivers/ieee1394/ohci1394.c
--- linux-2.6.14-rc2.orig/drivers/ieee1394/ohci1394.c	2005-09-19 20:00:41.000000000 -0700
+++ linux-2.6.14-rc2/drivers/ieee1394/ohci1394.c	2005-10-15 12:55:08.000000000 -0700
@@ -169,6 +169,10 @@
 module_param(phys_dma, int, 0644);
 MODULE_PARM_DESC(phys_dma, "Enable physical dma (default = 1).");
 
+static int toshiba __initdata = 0;
+module_param(toshiba, bool, 0);
+MODULE_PARM_DESC(toshiba, "Toshiba Legacy-Free BIOS workaround (default=0).");
+
 static void dma_trm_tasklet(unsigned long data);
 static void dma_trm_reset(struct dma_trm_ctx *d);
 
@@ -3222,14 +3226,28 @@
 	struct hpsb_host *host;
 	struct ti_ohci *ohci;	/* shortcut to currently handled device */
 	unsigned long ohci_base;
+	u16  toshiba_data;
 
 	if (version_printed++ == 0)
 		PRINT_G(KERN_INFO, "%s", version);
 
+	if (toshiba) {
+		dev->current_state = 4;
+		pci_read_config_word(dev, PCI_CACHE_LINE_SIZE, &toshiba_data);
+	}
+
         if (pci_enable_device(dev))
 		FAIL(-ENXIO, "Failed to enable OHCI hardware");
         pci_set_master(dev);
 
+	if (toshiba) {
+		mdelay(10);
+		pci_write_config_word(dev, PCI_CACHE_LINE_SIZE, toshiba_data);
+		pci_write_config_word(dev, PCI_INTERRUPT_LINE, dev->irq);
+		pci_write_config_dword(dev, PCI_BASE_ADDRESS_0, pci_resource_start(dev, 0));
+		pci_write_config_dword(dev, PCI_BASE_ADDRESS_1, pci_resource_start(dev, 1));
+ 	}
+
 	host = hpsb_alloc_host(&ohci1394_driver, sizeof(struct ti_ohci), &dev->dev);
 	if (!host) FAIL(-ENOMEM, "Failed to allocate host structure");
 

--Boundary-00=_BXTWDzHha7DMeCR--
