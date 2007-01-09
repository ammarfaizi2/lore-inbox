Return-Path: <linux-kernel-owner+w=401wt.eu-S1751361AbXAIMxM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751361AbXAIMxM (ORCPT <rfc822;w@1wt.eu>);
	Tue, 9 Jan 2007 07:53:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751384AbXAIMxL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 9 Jan 2007 07:53:11 -0500
Received: from ug-out-1314.google.com ([66.249.92.173]:3765 "EHLO
	ug-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751361AbXAIMxK (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 9 Jan 2007 07:53:10 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=XE4ylp1i5eB38Y5POR6+2CeMNyBHXv6dE8mwNZc7kniCSkjrJ7VpwAKEEo10qfcF3xzuurWDNluGnEQuKjUAhWrNi2JpdUL6uFJthxeqJYfhMARR5pCJ5Ra60dmmfIcSDNvejS2fdblFGsjO3klvvG9I0hN7i+iC/QkDTPQi6QU=
Message-ID: <5767b9100701090453g51448661td14e4c05a4eceb2a@mail.gmail.com>
Date: Tue, 9 Jan 2007 20:53:09 +0800
From: "Conke Hu" <conke.hu@gmail.com>
To: "Bartlomiej Zolnierkiewicz" <bzolnier@gmail.com>
Subject: Re: [PATCH 3/3] atiixp.c: add cable detection support for ATI IDE
Cc: "Linux kernel mailing list" <linux-kernel@vger.kernel.org>,
       "Andrew Morton" <akpm@osdl.org>, "Greg KH" <greg@kroah.com>,
       linux-ide@vger.kernel.org
In-Reply-To: <58cb370e0701061816s308155abw719a00d499f504ea@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
References: <5767b9100701060422p1abd1d21x606b758220815551@mail.gmail.com>
	 <58cb370e0701061816s308155abw719a00d499f504ea@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 1/7/07, Bartlomiej Zolnierkiewicz <bzolnier@gmail.com> wrote:
> On 1/6/07, Conke Hu <conke.hu@gmail.com> wrote:
> > IDE HDD does not work if it uses a 40-pin PATA cable on ATI chipset.
> > This patch fixes the bug.
> >
> > Signed-off-by: Conke Hu <conke.hu@amd.com>
>
> Acked-by: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
>
> [ the one is also line wrapped, please resend them ]
>

re-created.
pls apply it after the [patch 1/3] and [patch 2/3] :)
------------------------
--- linux-2.6.20-rc4/drivers/ide/pci/atiixp.c.3	2007-01-09
15:37:42.000000000 +0800
+++ linux-2.6.20-rc4/drivers/ide/pci/atiixp.c	2007-01-09
15:40:08.000000000 +0800
@@ -291,8 +291,12 @@ fast_ata_pio:

 static void __devinit init_hwif_atiixp(ide_hwif_t *hwif)
 {
+	u8 udma_mode = 0;
+	u8 ch = hwif->channel;
+	struct pci_dev *pdev = hwif->pci_dev;
+
 	if (!hwif->irq)
-		hwif->irq = hwif->channel ? 15 : 14;
+		hwif->irq = ch ? 15 : 14;

 	hwif->autodma = 0;
 	hwif->tuneproc = &atiixp_tuneproc;
@@ -308,8 +312,12 @@ static void __devinit init_hwif_atiixp(i
 	hwif->mwdma_mask = 0x06;
 	hwif->swdma_mask = 0x04;

-	/* FIXME: proper cable detection needed */
-	hwif->udma_four = 1;
+	pci_read_config_byte(pdev, ATIIXP_IDE_UDMA_MODE + ch, &udma_mode);
+	if ((udma_mode & 0x07) >= 0x04 || (udma_mode & 0x70) >= 0x40)
+		hwif->udma_four = 1;
+	else
+		hwif->udma_four = 0;
+
 	hwif->ide_dma_host_on = &atiixp_ide_dma_host_on;
 	hwif->ide_dma_host_off = &atiixp_ide_dma_host_off;
 	hwif->ide_dma_check = &atiixp_dma_check;
