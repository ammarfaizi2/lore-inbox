Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264394AbTL3XwA (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 30 Dec 2003 18:52:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264401AbTL3Xv7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 30 Dec 2003 18:51:59 -0500
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:53435 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id S264394AbTL3Xv5
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 30 Dec 2003 18:51:57 -0500
Message-ID: <3FF20F8A.20408@pobox.com>
Date: Tue, 30 Dec 2003 18:51:38 -0500
From: Jeff Garzik <jgarzik@pobox.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.4) Gecko/20030703
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Mickael Marchand <marchand@kde.org>
CC: linux-kernel@vger.kernel.org,
       Bartlomiej Zolnierkiewicz <B.Zolnierkiewicz@elka.pw.edu.pl>
Subject: Re: [PATCH] adaptec 1210sa
References: <200312220305.29955.marchand@kde.org>
In-Reply-To: <200312220305.29955.marchand@kde.org>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Mickael Marchand wrote:
> --- /usr/src/linux-2.6.0/drivers/scsi/sata_sil.c	2003-12-21 13:30:58.000000000 +0100
> +++ linux-2.6.0/drivers/scsi/sata_sil.c	2003-12-22 02:46:32.000000000 +0100
> @@ -276,6 +276,16 @@
>  		goto err_out_regions;
>  	}
>  
> +	//let's have fun
> +	u8 v; 
> +	pci_read_config_byte(pdev, 0x8a, &v);
> +	int mask = 0x3f; //clear 6 and 7 bits
> +	if (v & ~mask) {
> +		printk("Reenabling interrupts because Adaptec's BIOS disables them\n" );
> +		v &= mask;
> +		pci_write_config_byte(pdev, 0x8a, v);
> +	}
> +
>  	memset(probe_ent, 0, sizeof(*probe_ent));
>  	INIT_LIST_HEAD(&probe_ent->node);
>  	probe_ent->pdev = pdev;


Actually, ignore that last question.  The SII docs indicate these bits 
are present in the standard SII 3112 chip, so the driver should just 
make sure to do this unconditionally.

Bart, the above applies to siimage.c as well.  The following are equal:
* PCI config reg 0x8a (byte), bits 6/7
* PCI config reg 0x88 (dword), bits 22/23
* MMIO offset 0x48 (dword), bits 22/23

The lower bit masks IDE0 interrupts, and the higher bit masks IDE1 
interrupts.

	Jeff



