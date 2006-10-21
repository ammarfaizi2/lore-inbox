Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1422843AbWJUTvp@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422843AbWJUTvp (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 21 Oct 2006 15:51:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1423385AbWJUTvp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 21 Oct 2006 15:51:45 -0400
Received: from srv5.dvmed.net ([207.36.208.214]:63360 "EHLO mail.dvmed.net")
	by vger.kernel.org with ESMTP id S1422843AbWJUTvo (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 21 Oct 2006 15:51:44 -0400
Message-ID: <453A7A4C.3090808@pobox.com>
Date: Sat, 21 Oct 2006 15:51:40 -0400
From: Jeff Garzik <jgarzik@pobox.com>
User-Agent: Thunderbird 1.5.0.7 (X11/20060913)
MIME-Version: 1.0
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
CC: akpm@osdl.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] pata_marvell: switch to pci_iomap as Jeff asked
References: <1161192357.9363.101.camel@localhost.localdomain>
In-Reply-To: <1161192357.9363.101.camel@localhost.localdomain>
Content-Type: multipart/mixed;
 boundary="------------080802000205040709060207"
X-Spam-Score: -4.3 (----)
X-Spam-Report: SpamAssassin version 3.1.7 on srv5.dvmed.net summary:
	Content analysis details:   (-4.3 points, 5.0 required)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------080802000205040709060207
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

Alan Cox wrote:
> Signed-off-by: Alan Cox <alan@redhat.com>
> 
> diff -u --new-file --recursive --exclude-from /usr/src/exclude linux.vanilla-2.6.19-rc2-mm1/drivers/ata/pata_marvell.c linux-2.6.19-rc2-mm1/drivers/ata/pata_marvell.c
> --- linux.vanilla-2.6.19-rc2-mm1/drivers/ata/pata_marvell.c	2006-10-18 13:51:02.000000000 +0100
> +++ linux-2.6.19-rc2-mm1/drivers/ata/pata_marvell.c	2006-10-18 13:56:55.000000000 +0100
> @@ -20,7 +20,7 @@
>  #include <linux/ata.h>
>  
>  #define DRV_NAME	"pata_marvell"
> -#define DRV_VERSION	"0.0.4t"
> +#define DRV_VERSION	"0.0.5t"
>  
>  /**
>   *	marvell_pre_reset	-	check for 40/80 pin
> @@ -39,18 +39,17 @@
>  
>  	/* Check if our port is enabled */
>  
> -	bar5 = pci_resource_start(pdev, 5);
> -	barp = ioremap(bar5, 0x10);
> +	barp = pci_ioremap(pdev, 5, 0x10);

Please provide code that links successfully, and compiles without 
obvious warnings.  pci_ioremap() does not exist; you wanted pci_iomap().

I applied the patch, fixed the obvious bugs, and then did my own line 
length, trailing whitespace, "if(" javaism, 'case' indentation, and 
other cosmetic cleanups.

	Jeff




--------------080802000205040709060207
Content-Type: text/plain;
 name="patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="patch"

diff --git a/drivers/ata/pata_marvell.c b/drivers/ata/pata_marvell.c
index 2b8e00c..1ea6407 100644
--- a/drivers/ata/pata_marvell.c
+++ b/drivers/ata/pata_marvell.c
@@ -20,7 +20,7 @@ #include <linux/libata.h>
 #include <linux/ata.h>
 
 #define DRV_NAME	"pata_marvell"
-#define DRV_VERSION	"0.0.4t"
+#define DRV_VERSION	"0.0.5u"
 
 /**
  *	marvell_pre_reset	-	check for 40/80 pin
@@ -33,14 +33,12 @@ static int marvell_pre_reset(struct ata_
 {
 	struct pci_dev *pdev = to_pci_dev(ap->host->dev);
 	u32 devices;
-	unsigned long bar5;
 	void __iomem *barp;
 	int i;
 
 	/* Check if our port is enabled */
 
-	bar5 = pci_resource_start(pdev, 5);
-	barp = ioremap(bar5, 0x10);
+	barp = pci_iomap(pdev, 5, 0x10);
 	if (barp == NULL)
 		return -ENOMEM;
 	printk("BAR5:");
@@ -49,24 +47,25 @@ static int marvell_pre_reset(struct ata_
 	printk("\n");
 	
 	devices = readl(barp + 0x0C);
-	iounmap(barp);
+	pci_iounmap(pdev, barp);
 	
-	if (pdev->device == 0x6145 && ap->port_no == 0 && !(devices & 0x10))	/* PATA enable ? */
+	if ((pdev->device == 0x6145) && (ap->port_no == 0) &&
+	    (!(devices & 0x10)))	/* PATA enable ? */
 		return -ENOENT;
 
 	/* Cable type */
 	switch(ap->port_no)
 	{
-		case 0:
-			/* Might be backward, docs unclear */
-			if(inb(ap->ioaddr.bmdma_addr + 1) & 1)
-				ap->cbl = ATA_CBL_PATA80;
-			else
-				ap->cbl = ATA_CBL_PATA40;
-			
-		case 1: /* Legacy SATA port */
-			ap->cbl = ATA_CBL_SATA;
-			break;
+	case 0:
+		/* Might be backward, docs unclear */
+		if (inb(ap->ioaddr.bmdma_addr + 1) & 1)
+			ap->cbl = ATA_CBL_PATA80;
+		else
+			ap->cbl = ATA_CBL_PATA40;
+
+	case 1: /* Legacy SATA port */
+		ap->cbl = ATA_CBL_SATA;
+		break;
 	}
 	return ata_std_prereset(ap);
 }
@@ -81,7 +80,8 @@ static int marvell_pre_reset(struct ata_
 
 static void marvell_error_handler(struct ata_port *ap)
 {
-	return ata_bmdma_drive_eh(ap, marvell_pre_reset, ata_std_softreset, NULL, ata_std_postreset);
+	return ata_bmdma_drive_eh(ap, marvell_pre_reset, ata_std_softreset,
+				  NULL, ata_std_postreset);
 }
 
 /* No PIO or DMA methods needed for this device */
@@ -130,7 +130,6 @@ static const struct ata_port_operations 
 	.data_xfer		= ata_pio_data_xfer,
 
 	/* Timeout handling */
-	.eng_timeout		= ata_eng_timeout,
 	.irq_handler		= ata_interrupt,
 	.irq_clear		= ata_bmdma_irq_clear,
 
@@ -159,7 +158,7 @@ static int marvell_init_one (struct pci_
 {
 	static struct ata_port_info info = {
 		.sht		= &marvell_sht,
-		.flags	= ATA_FLAG_SLAVE_POSS | ATA_FLAG_SRST,
+		.flags		= ATA_FLAG_SLAVE_POSS | ATA_FLAG_SRST,
 
 		.pio_mask	= 0x1f,
 		.mwdma_mask	= 0x07,
@@ -170,7 +169,7 @@ static int marvell_init_one (struct pci_
 	static struct ata_port_info info_sata = {
 		.sht		= &marvell_sht,
 		/* Slave possible as its magically mapped not real */
-		.flags	= ATA_FLAG_SLAVE_POSS | ATA_FLAG_SRST,
+		.flags		= ATA_FLAG_SLAVE_POSS | ATA_FLAG_SRST,
 
 		.pio_mask	= 0x1f,
 		.mwdma_mask	= 0x07,
@@ -180,10 +179,10 @@ static int marvell_init_one (struct pci_
 	};
 	struct ata_port_info *port_info[2] = { &info, &info_sata };
 	int n_port = 2;
-	
+
 	if (pdev->device == 0x6101)
 		n_port = 1;
-	
+
 	return ata_pci_init_one(pdev, port_info, n_port);
 }
 

--------------080802000205040709060207--
