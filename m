Return-Path: <linux-kernel-owner+willy=40w.ods.org-S966970AbWLDUny@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S966970AbWLDUny (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 4 Dec 2006 15:43:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S966877AbWLDUny
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 4 Dec 2006 15:43:54 -0500
Received: from smtp.osdl.org ([65.172.181.25]:44346 "EHLO smtp.osdl.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S966875AbWLDUnw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 4 Dec 2006 15:43:52 -0500
Date: Mon, 4 Dec 2006 12:43:44 -0800
From: Andrew Morton <akpm@osdl.org>
To: Alan <alan@lxorguk.ukuu.org.uk>
Cc: linux-kernel@vger.kernel.org, jgarzik@pobox.com, linux-ide@vger.kernel.org
Subject: Re: [PATCH] pata_it8213: Add new driver for the IT8213 card.
Message-Id: <20061204124344.a7c21221.akpm@osdl.org>
In-Reply-To: <20061204164931.7d36d744@localhost.localdomain>
References: <20061204164931.7d36d744@localhost.localdomain>
X-Mailer: Sylpheed version 2.2.7 (GTK+ 2.8.6; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 4 Dec 2006 16:49:31 +0000
Alan <alan@lxorguk.ukuu.org.uk> wrote:

> Add a driver for the IT8213 which is a single channel ICH-ish PATA
> controller. As it is very different to the IT8211/2 it gets its own
> driver. There is a legacy drivers/ide driver also available and I'll post
> that once I get time to test it all out (probably early January). If
> anyone else needs the drivers/ide driver and wants to do the merge for
> drivers/ide (Bart ??) then I'll forward it.
> 
> ...
>
> +static void it8213_set_piomode (struct ata_port *ap, struct ata_device *adev)
> +{
> +	unsigned int pio	= adev->pio_mode - XFER_PIO_0;
> +	struct pci_dev *dev	= to_pci_dev(ap->host->dev);
> +	unsigned int idetm_port= ap->port_no ? 0x42 : 0x40;
> +	u16 idetm_data;
> +	int control = 0;
> +
> +	/*
> +	 *	See Intel Document 298600-004 for the timing programing rules
> +	 *	for PIIX/ICH. The 8213 is a clone so very similar
> +	 */
> +
> +	static const	 /* ISP  RTC */
> +	u8 timings[][2]	= { { 0, 0 },
> +			    { 0, 0 },
> +			    { 1, 0 },
> +			    { 2, 1 },
> +			    { 2, 3 }, };
>
> ...
>
> +
> +static void it8213_set_dmamode (struct ata_port *ap, struct ata_device *adev)
> +{
> +	struct pci_dev *dev	= to_pci_dev(ap->host->dev);
> +	u16 master_data;
> +	u8 speed		= adev->dma_mode;
> +	int devid		= adev->devno;
> +	u8 udma_enable;
> +
> +	static const	 /* ISP  RTC */
> +	u8 timings[][2]	= { { 0, 0 },
> +			    { 0, 0 },
> +			    { 1, 0 },
> +			    { 2, 1 },
> +			    { 2, 3 }, };

Was the duplication of timings[] deliberate?

> +		const unsigned int needed_pio[3] = {
> +			XFER_PIO_0, XFER_PIO_3, XFER_PIO_4
> +		};

I made this static (save the world and all that).

> +static const struct pci_device_id it8213_pci_tbl[] = {
> +	{ PCI_VDEVICE(ITE, PCI_DEVICE_ID_ITE_8213), },

drivers/ata/pata_it8213.c:323: error: 'PCI_DEVICE_ID_ITE_8213' undeclared here (not in a function)

I went out on a limb and...

--- a/drivers/ata/pata_it8213.c~pata_it8213-add-new-driver-for-the-it8213-card-tidy
+++ a/drivers/ata/pata_it8213.c
@@ -194,7 +194,7 @@ static void it8213_set_dmamode (struct a
 		unsigned int mwdma	= adev->dma_mode - XFER_MW_DMA_0;
 		unsigned int control;
 		u8 slave_data;
-		const unsigned int needed_pio[3] = {
+		static const unsigned int needed_pio[3] = {
 			XFER_PIO_0, XFER_PIO_3, XFER_PIO_4
 		};
 		int pio = needed_pio[mwdma] - XFER_PIO_0;
@@ -352,4 +352,3 @@ MODULE_DESCRIPTION("SCSI low-level drive
 MODULE_LICENSE("GPL");
 MODULE_DEVICE_TABLE(pci, it8213_pci_tbl);
 MODULE_VERSION(DRV_VERSION);
-
diff -puN include/linux/pci_ids.h~pata_it8213-add-new-driver-for-the-it8213-card-tidy include/linux/pci_ids.h
--- a/include/linux/pci_ids.h~pata_it8213-add-new-driver-for-the-it8213-card-tidy
+++ a/include/linux/pci_ids.h
@@ -1622,6 +1622,7 @@
 #define PCI_VENDOR_ID_ITE		0x1283
 #define PCI_DEVICE_ID_ITE_8211		0x8211
 #define PCI_DEVICE_ID_ITE_8212		0x8212
+#define PCI_DEVICE_ID_ITE_8213		0x8213
 #define PCI_DEVICE_ID_ITE_8872		0x8872
 #define PCI_DEVICE_ID_ITE_IT8330G_0	0xe886
 
_

