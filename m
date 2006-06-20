Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750978AbWFTNxI@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750978AbWFTNxI (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 20 Jun 2006 09:53:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750983AbWFTNxI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 20 Jun 2006 09:53:08 -0400
Received: from mailhub.sw.ru ([195.214.233.200]:21693 "EHLO relay.sw.ru")
	by vger.kernel.org with ESMTP id S1750974AbWFTNxH (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 20 Jun 2006 09:53:07 -0400
Message-ID: <4497FDBF.8010500@sw.ru>
Date: Tue, 20 Jun 2006 17:53:03 +0400
From: Vasily Averin <vvs@sw.ru>
Organization: SW-soft
User-Agent: Mozilla/5.0 (X11; U; Linux x86_64; en-US; rv:1.7.12) Gecko/20050921
X-Accept-Language: en-us, en, ru
MIME-Version: 1.0
To: "Ju, Seokmann" <Seokmann.Ju@lsil.com>
CC: James Bottomley <James.Bottomley@SteelEye.com>,
       Andrew Morton <akpm@osdl.org>, linux-scsi@vger.kernel.org,
       linux-kernel@vger.kernel.org, devel@openvz.org
Subject: Re: [PATCH 1/1] scsi : megaraid_{mm,mbox}: a fix on 64-bit DMA capability
 check
References: <890BF3111FB9484E9526987D912B261901BD91@NAMAIL3.ad.lsil.com>
In-Reply-To: <890BF3111FB9484E9526987D912B261901BD91@NAMAIL3.ad.lsil.com>
X-Enigmail-Version: 0.90.1.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Seokmann,

I would like to tell you that your patch is wrong, at least for
 MegaRAID SATA 150-4 RAID Controller

06:02.0 RAID bus controller: LSI Logic / Symbios Logic MegaRAID (rev 01)
        Subsystem: LSI Logic / Symbios Logic MegaRAID SATA 150-4 RAID Controller
00: 00 10 60 19 16 03 b0 04 01 00 04 01 08 20 00 00
10: 08 00 20 df 00 00 00 00 00 00 00 00 00 00 00 00
20: 00 00 00 00 00 00 00 00 00 00 00 00 00 10 23 45
30: 00 00 00 00 80 00 00 00 00 00 00 00 0a 01 00 00
40: 00 00 ff ff 00 00 00 d0 08 00 00 fc 00 00 00 fc
50: 00 00 00 d0 00 00 00 00 00 00 00 00 00 00 00 00
60: 00 00 00 00 88 1f 00 00 00 00 00 f8 00 00 00 00
70: 00 00 00 00 00 00 ff ff 00 00 f4 fe 00 00 00 00
80: 01 00 02 00 00 00 00 00 06 01 38 00 00 00 00 00
90: 00 00 00 00 00 00 00 00 06 01 00 20 9c 00 00 00
a0: cc cc 00 00 99 02 00 00 00 06 00 80 00 00 00 00
b0: 00 00 00 6e 00 00 00 00 00 00 00 00 fd 01 00 00
c0: fd 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
d0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
e0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
f0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00

As far as I see the 64-bit magic is set, pci(0xA4) == 0x0299 and driver tries to
enable 64-bit DMA. However the controller is not supported 64-bit DMA, and I
still have the same error messages.

Could you please check this issue and update your patch properly.

Thank you,
	Vasily Averin

SWsoft Virtuozzo/OpenVZ Linux kernel team

Ju, Seokmann wrote:
> Hi,
> 
> This patch contains a fix for 64-bit DMA capability check in
> megaraid_{mm,mbox} driver. With patch, the driver access PCI
> configuration space with dedicated offset to read a signature. If the
> signature read, it means that the controller has capability to handle
> 64-bit DMA. Before this patch, the driver blindly claimed the capability
> without checking with controller.
> The issue has been reported by Vasily Averin [vvs@sw.ru]. Thank you
> Vasily for the reporting.

> +#define HBA_SIGNATURE_64BIT		0x0299
> +#define PCI_CONF_AMISIG64		0xa4
...
> -	if (pci_set_dma_mask(adapter->pdev, DMA_64BIT_MASK) != 0) {
> +	pci_read_config_dword(adapter->pdev, PCI_CONF_AMISIG64,
> &magic64);
>  
> -		con_log(CL_ANN, (KERN_WARNING
> -			"megaraid: could not set DMA mask for
> 64-bit.\n"));
> +	if ((magic64 == HBA_SIGNATURE_64BIT) || 
> +		(adapter->pdev->vendor == PCI_VENDOR_ID_DELL &&
> +		adapter->pdev->device ==
> PCI_DEVICE_ID_PERC4_DI_EVERGLADES) ||
> +		(adapter->pdev->vendor == PCI_VENDOR_ID_LSI_LOGIC &&
> +		adapter->pdev->device == PCI_DEVICE_ID_VERDE) ||
> +		(adapter->pdev->vendor == PCI_VENDOR_ID_LSI_LOGIC &&
> +		adapter->pdev->device == PCI_DEVICE_ID_DOBSON) ||
> +		(adapter->pdev->vendor == PCI_VENDOR_ID_DELL &&
> +		adapter->pdev->device == PCI_DEVICE_ID_PERC4E_DI_KOBUK)
> ||
> +		(adapter->pdev->vendor == PCI_VENDOR_ID_LSI_LOGIC &&
> +		adapter->pdev->device == PCI_DEVICE_ID_LINDSAY)) {
> +		if (pci_set_dma_mask(adapter->pdev, DMA_64BIT_MASK) !=
> 0) {
