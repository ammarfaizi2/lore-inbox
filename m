Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264891AbUETFBO@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264891AbUETFBO (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 20 May 2004 01:01:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264979AbUETFBO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 20 May 2004 01:01:14 -0400
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:59786 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id S264891AbUETFBM
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 20 May 2004 01:01:12 -0400
Message-ID: <40AC3B89.9060900@pobox.com>
Date: Thu, 20 May 2004 01:00:57 -0400
From: Jeff Garzik <jgarzik@pobox.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.4) Gecko/20030703
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Geert Uytterhoeven <Geert.Uytterhoeven@sonycom.com>
CC: Matt Domsch <Matt_Domsch@dell.com>,
       Linux Kernel Development <linux-kernel@vger.kernel.org>
Subject: Re: ata_piix: port disabled.  ignoring.
References: <Pine.GSO.4.58.0405141453020.27660@waterleaf.sonytel.be> <20040514150900.GA19315@lists.us.dell.com> <40A4ED87.20608@pobox.com> <Pine.GSO.4.58.0405171308580.19405@waterleaf.sonytel.be> <Pine.GSO.4.58.0405171545490.19405@waterleaf.sonytel.be>
In-Reply-To: <Pine.GSO.4.58.0405171545490.19405@waterleaf.sonytel.be>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Geert Uytterhoeven wrote:
> If I try to work around the problem by applying this patch:
> 
> --- linux-2.6.6-bk4/drivers/scsi/ata_piix.c.orig	2004-05-17 20:02:25.000000000 +0200
> +++ linux-2.6.6-bk4/drivers/scsi/ata_piix.c	2004-05-17 20:59:15.000000000 +0200
> @@ -330,8 +330,8 @@
>  	if (!pci_test_config_bits(ap->host_set->pdev,
>  				  &piix_enable_bits[ap->port_no])) {
>  		ata_port_disable(ap);
> -		printk(KERN_INFO "ata%u: port disabled. ignoring.\n", ap->id);
> -		return;
> +		//printk(KERN_INFO "ata%u: port disabled. ignoring.\n", ap->id);
> +		printk(KERN_INFO "ata%u: port disabled. NOT IGNORING!\n", ap->id);
>  	}
> 
>  	if (!piix_sata_probe(ap)) {
> 
> everything works fine, even if I disable the second SATA port in the BIOS:


I think this check is vaguely incorrect, because it sounds like you are 
in combined mode.  That would imply that ap->port_no is incorrect, for 
this one special case.  (details: in combined aka legacy mode, port 
number is always zero because it is initialized as two separate hosts, 
not one host with two ata_ports)

However, since this is SATA, and PIIX does at least give us a "no 
device" indication, we could probably just delete the 'if' and the code 
you are commenting out as well.

Ponder, ponder...

Another thing I am pondering is detecting combined mode in 
drivers/pci/quirks.c, and reconfiguring the motherboard such that is it 
no longer in combined mode.

	Jeff



