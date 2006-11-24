Return-Path: <linux-kernel-owner+willy=40w.ods.org-S934297AbWKXGCD@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S934297AbWKXGCD (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 24 Nov 2006 01:02:03 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S934435AbWKXGCD
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 24 Nov 2006 01:02:03 -0500
Received: from nf-out-0910.google.com ([64.233.182.189]:65184 "EHLO
	nf-out-0910.google.com") by vger.kernel.org with ESMTP
	id S934297AbWKXGCB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 24 Nov 2006 01:02:01 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:user-agent:mime-version:to:cc:subject:references:in-reply-to:content-type:content-transfer-encoding;
        b=sZ1EFvOLejI9oFqO1YsrqUSPflK0kxFaYQqpO27E1iWvbVbmzx4GpUIKLolPX/4oDbewEqLoMKGOH9iZEry+95orMsoqtVDkNwiaDqS9MRGfy8eAhdyD2RpxyPxq9CWcwNuoxxHrs/WD7hRWyY3fDOsfD+dUE6WTNK4tRPVP2QI=
Message-ID: <45668ACF.1040101@gmail.com>
Date: Fri, 24 Nov 2006 15:01:51 +0900
From: Tejun Heo <htejun@gmail.com>
User-Agent: Icedove 1.5.0.8 (X11/20061116)
MIME-Version: 1.0
To: Conke Hu <conke.hu@amd.com>
CC: linux-kernel@vger.kernel.org, alan@lxorguk.ukuu.org.uk,
       Andrew Morton <akpm@osdl.org>, Jeff Garzik <jeff@garzik.org>
Subject: Re: [PATCH] Add IDE mode support for SB600 SATA
References: <FFECF24D2A7F6D418B9511AF6F3586020108CE7D@shacnexch2.atitech.com>
In-Reply-To: <FFECF24D2A7F6D418B9511AF6F3586020108CE7D@shacnexch2.atitech.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Conke Hu wrote:
> ATI SB600 SATA controller supports 4 modes: Legacy IDE, Native IDE, AHCI and RAID. Legacy/Native IDE mode is designed for compatibility with some old OS without AHCI driver but looses SATAII/AHCI features such as NCQ. This patch will make SB600 SATA run in AHCI mode even if it was set as IDE mode by system BIOS.
> 
> Signed-off-by: conke.hu@amd.com
> ---------
> --- linux-2.6.19-rc6-git4/drivers/pci/quirks.c.orig	2006-11-23 19:45:49.000000000 +0800
> +++ linux-2.6.19-rc6-git4/drivers/pci/quirks.c	2006-11-23 19:34:23.000000000 +0800
> @@ -795,6 +795,25 @@ static void __init quirk_mediagx_master(
>  	}
>  }
>  DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_CYRIX,	PCI_DEVICE_ID_CYRIX_PCI_MASTER, quirk_mediagx_master );
> + 
> +#if defined(CONFIG_SATA_AHCI) || defined(CONFIG_SATA_AHCI_MODULE)
> +static void __devinit quirk_sb600_sata(struct pci_dev *pdev)
> +{
> +	/* set sb600 sata to ahci mode */
> +	if ((pdev->class >> 8) == PCI_CLASS_STORAGE_IDE) {
> +		u8 tmp;
> +
> +		pci_read_config_byte(pdev, 0x40, &tmp);
> +		pci_write_config_byte(pdev, 0x40, tmp|1);
> +		pci_write_config_byte(pdev, 0x9, 1);
> +		pci_write_config_byte(pdev, 0xa, 6);
> +		pci_write_config_byte(pdev, 0x40, tmp);
> +		

Two trailing tabs in the above line.  Please remove those.

> +		pdev->class = 0x010601;
> +	}
> +}
> +DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_ATI, PCI_DEVICE_ID_ATI_IXP600_SATA, quirk_sb600_sata);
> +#endif
>  
>  /*
>   * As per PCI spec, ignore base address registers 0-3 of the IDE controllers

Other than that, Acked-by: Tejun Heo <htejun@gmail.com>

-- 
tejun
