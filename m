Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266190AbUALPWo (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 12 Jan 2004 10:22:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266440AbUALPWn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 12 Jan 2004 10:22:43 -0500
Received: from jaguar.mkp.net ([192.139.46.146]:56773 "EHLO jaguar.mkp.net")
	by vger.kernel.org with ESMTP id S266190AbUALPWj (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 12 Jan 2004 10:22:39 -0500
To: Christoph Hellwig <hch@infradead.org>
Cc: akpm@osdl.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] allow SGI IOC4 chipset support
References: <20040106010924.GA21747@sgi.com>
	<20040106102538.A14492@infradead.org>
From: Jes Sorensen <jes@wildopensource.com>
Date: 12 Jan 2004 10:22:35 -0500
In-Reply-To: <20040106102538.A14492@infradead.org>
Message-ID: <yq0fzelchtw.fsf@wildopensource.com>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.2
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>>>>> "Christoph" == Christoph Hellwig <hch@infradead.org> writes:

Christoph> On Mon, Jan 05, 2004 at 05:09:24PM -0800, Jesse Barnes
Christoph> wrote:
>> The 'depends' directive for SGI IOC4 support is too restrictive.
>> Just kill it altogether.

Christoph> Umm, it won't work for anything but a kernel with SN2
Christoph> support compile in due to the bridge-level dma byteswapping
Christoph> it needs (through a week symbol, that's why you don't see
Christoph> compile failures for other architectures, eek!).

Christoph> So at least make it depend on CONFIG_IA64

Lets try this then, relative to 2.6.1.

Jes

--- orig/linux-2.6.1-jb-boot/drivers/ide/pci/sgiioc4.c	Sun Jan 11 07:00:35 2004
+++ linux-2.6.1/drivers/ide/pci/sgiioc4.c	Mon Jan 12 06:17:19 2004
@@ -726,7 +726,7 @@
 	PCIDMA_ENDIAN_BIG,
 	PCIDMA_ENDIAN_LITTLE
 } pciio_endian_t;
-pciio_endian_t __attribute__ ((weak)) snia_pciio_endian_set(struct pci_dev
+extern pciio_endian_t snia_pciio_endian_set(struct pci_dev
 					    *pci_dev, pciio_endian_t device_end,
 					    pciio_endian_t desired_end);
 
@@ -755,15 +755,7 @@
 	}
 
 	/* Enable Byte Swapping in the PIC... */
-	if (snia_pciio_endian_set) {
-		snia_pciio_endian_set(dev, PCIDMA_ENDIAN_LITTLE,
-				      PCIDMA_ENDIAN_BIG);
-	} else {
-		printk(KERN_ERR
-		       "Failed to set endianness for device %s at slot %s\n",
-		       d->name, dev->slot_name);
-		return 1;
-	}
+	snia_pciio_endian_set(dev, PCIDMA_ENDIAN_LITTLE, PCIDMA_ENDIAN_BIG);
 
 	return sgiioc4_ide_setup_pci_device(dev, d);
 }
--- orig/linux-2.6.1-jb-boot/drivers/ide/Kconfig	Sun Jan 11 07:00:35 2004
+++ linux-2.6.1/drivers/ide/Kconfig	Mon Jan 12 06:18:19 2004
@@ -747,7 +747,7 @@
 
 config BLK_DEV_SGIIOC4
 	tristate "Silicon Graphics IOC4 chipset support"
-	depends on IA64_SGI_SN2
+	depends on IA64_GENERIC || IA64_SGI_SN2
 	help
 	  This driver adds PIO & MultiMode DMA-2 support for the SGI IOC4
 	  chipset, which has one channel and can support two devices.
