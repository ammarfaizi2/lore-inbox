Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751218AbVJOUdB@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751218AbVJOUdB (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 15 Oct 2005 16:33:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751220AbVJOUdB
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 15 Oct 2005 16:33:01 -0400
Received: from sccrmhc11.comcast.net ([63.240.76.21]:34249 "EHLO
	sccrmhc11.comcast.net") by vger.kernel.org with ESMTP
	id S1751218AbVJOUdA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 15 Oct 2005 16:33:00 -0400
Date: Sat, 15 Oct 2005 13:29:44 -0700
From: Jesse Barnes <jbarnes@virtuousgeek.org>
To: Stefan Richter <stefanr@s5r6.in-berlin.de>
Cc: linux1394-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org
Subject: Re: ohci1394 unhandled interrupts bug in 2.6.14-rc2
Message-ID: <20051015202944.GA10463@plato.virtuousgeek.org>
References: <20051015185502.GA9940@plato.virtuousgeek.org> <43515ADA.6050102@s5r6.in-berlin.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <43515ADA.6050102@s5r6.in-berlin.de>
User-Agent: Mutt/1.4.2.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Oct 15, 2005 at 09:39:06PM +0200, Stefan Richter wrote:
> Somebody mentioned this Linux-on-Toshiba-Satellite page recently on 
> linux1394-user: http://www.janerob.com/rob/ts5100/index.shtml
> The patch available from there was briefly discussed in February:
> http://marc.theaimsgroup.com/?l=linux1394-devel&t=110786507900006
> 
> Does this patch correct the problem on your machine?

Yes, it seems to help.  If I boot up and modprobe the driver with
toshiba=1, everything looks fine (I have no firewire devices to test
with).  If I modprobe it with toshiba=0, the system gets sluggish for a
second then IRQ 11 is disabled.  I had to update the patch though, as
shown below.

I'm not sure if the fix is proper though, maybe this should be handled
as a PCI quirk of this Toshiba board instead?  Either way, some kind of
fix should make it in soon, ideally to 2.6.14 or 2.6.14.1.

Thanks,
Jesse

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
 
