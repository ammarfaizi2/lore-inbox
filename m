Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268529AbUH3QHX@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268529AbUH3QHX (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 30 Aug 2004 12:07:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268530AbUH3QHW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 30 Aug 2004 12:07:22 -0400
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:64645 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id S268526AbUH3QHP
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 30 Aug 2004 12:07:15 -0400
Message-ID: <413350A2.1000003@pobox.com>
Date: Mon, 30 Aug 2004 12:06:58 -0400
From: Jeff Garzik <jgarzik@pobox.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.2) Gecko/20040803
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Brad Campbell <brad@wasp.net.au>
CC: linux-ide@vger.kernel.org, Linux Kernel <linux-kernel@vger.kernel.org>,
       Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: [PATCH] libata ATA vs SATA detection and workaround.
References: <41320DAF.2060306@wasp.net.au> <41321288.4090403@pobox.com> <413216CC.5080100@wasp.net.au> <4132198B.8000504@pobox.com> <41321F7F.7050300@pobox.com> <41333CDC.5040106@wasp.net.au> <41334058.4050902@wasp.net.au>
In-Reply-To: <41334058.4050902@wasp.net.au>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Brad Campbell wrote:
> +			/* limit bridge transfers to udma5, 200 sectors */
> +			if ((ap->cbl == ATA_CBL_SATA) && (!ata_id_is_sata(ap->device))) {
> +				printk(KERN_INFO "ata%u(%u): applying bridge limits\n",
> +					ap->id, ap->device->devno);
> +				ap->udma_mask &= ATA_UDMA5;
> +				ap->host->max_sectors = ATA_MAX_SECTORS;
> +				ap->host->hostt->max_sectors = ATA_MAX_SECTORS;
> +				ap->device->flags |= ATA_DFLAG_LOCK_SECTORS;
> +			}
>  			if (ap->ops->dev_config)
>  				ap->ops->dev_config(ap, &ap->device[i]);


Close!  Please move the entire quoted section, including the two lines 
of code calling ->dev_config(), into a new function 'ata_dev_config'. 
Export it (bottom of libata-core.c) and prototype it (libata.h) as well.

I'm still pondering what Alan was hinting at, a bit.  You (Brad) are 
correct in pointing out that this code should only trigger for the 
correct situations (lba48, etc.) which are only present on modern 
drives, but...  there is still a chance that word 93 will be zero on 
some weird (probably non-compliant) device.

However, Alan's comment is actually more relevant for unrelated sections 
of libata.  Whenever we test a feature bit in words 82-87, we should 
check for "word != 0 && word != 0xffff" which is how one knows the word 
is implemented.  There are no feature bits indicating that feature bits 
exist :)

	Jeff


