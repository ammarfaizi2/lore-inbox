Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261401AbVA2Baq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261401AbVA2Baq (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 28 Jan 2005 20:30:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262836AbVA2Baq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 28 Jan 2005 20:30:46 -0500
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:17831 "EHLO
	parcelfarce.linux.theplanet.co.uk") by vger.kernel.org with ESMTP
	id S261401AbVA2Bag (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 28 Jan 2005 20:30:36 -0500
Message-ID: <41FAE72C.1010905@pobox.com>
Date: Fri, 28 Jan 2005 20:30:20 -0500
From: Jeff Garzik <jgarzik@pobox.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.3) Gecko/20040922
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Martins Krikis <mkrikis@yahoo.com>
CC: linux-kernel@vger.kernel.org,
       "linux-ide@vger.kernel.org" <linux-ide@vger.kernel.org>,
       Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: [RFC PATCH 2.4] ata_piix on ich6r in RAID mode
References: <87acqte8xr.fsf@yahoo.com>
In-Reply-To: <87acqte8xr.fsf@yahoo.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Martins Krikis wrote:
> Without this patch, if the BIOS of an ICH6R box has IDE set to "RAID"
> mode then ata_piix will not find any SATA disks because it incorrectly
> tries the legacy mode. With the patch all 4 SATA drives become visible.
> I don't think it would break any other vendor's SATA, but you can be
> the judge of that. If so, perhaps we can restrict the test some more
> by checking vendor/device IDs.

> --- linux-2.4.29/drivers/scsi/libata-core.c	2005-01-28 12:07:56.000000000 -0500
> +++ linux-2.4.29-iswraid/drivers/scsi/libata-core.c	2005-01-28 12:14:43.000000000 -0500
> @@ -3605,6 +3605,9 @@ int ata_pci_init_one (struct pci_dev *pd
>  			legacy_mode = (1 << 3);
>  	}
>  
> +	if ((pdev->class >> 8) == PCI_CLASS_STORAGE_RAID)
> +		legacy_mode = 0;
> +
>  	/* FIXME... */
>  	if ((!legacy_mode) && (n_ports > 1)) {
>  		printk(KERN_ERR "ata: BUG: native mode, n_ports > 1\n");


hmmmmmm.  Maybe "!= PCI_CLASS_STORAGE_IDE" instead?

Overall, however, I am worried about your report of the driver's 
behavior based on that BIOS's configuration.  The driver follows the PCI 
IDE standard (previously SFF 8038i), where a register indicates whether 
its in legacy or native mode.  As it see it, either
a) the driver logic for reading that register is wrong, or
b) BIOS incorrectly configuring the device, or
c) that register is only applicable for PCI_CLASS_STORAGE_IDE devices.

Comments either way?

	Jeff


