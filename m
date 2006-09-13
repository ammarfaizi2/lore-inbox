Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751135AbWIMTM3@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751135AbWIMTM3 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 13 Sep 2006 15:12:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751132AbWIMTM3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 13 Sep 2006 15:12:29 -0400
Received: from khc.piap.pl ([195.187.100.11]:36069 "EHLO khc.piap.pl")
	by vger.kernel.org with ESMTP id S1751117AbWIMTM2 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 13 Sep 2006 15:12:28 -0400
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: akpm@osdl.org, jgarzik@pobox.com, linux-kernel@vger.kernel.org,
       linux-ide@vger.kernel.org
Subject: Re: [PATCH] pata_amd: Check enable bits on Nvidia
References: <1158077643.6780.45.camel@localhost.localdomain>
From: Krzysztof Halasa <khc@pm.waw.pl>
Date: Wed, 13 Sep 2006 21:12:25 +0200
In-Reply-To: <1158077643.6780.45.camel@localhost.localdomain> (Alan Cox's message of "Tue, 12 Sep 2006 17:14:03 +0100")
Message-ID: <m3wt871syu.fsf@defiant.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Alan Cox <alan@lxorguk.ukuu.org.uk> writes:

> +++ linux-2.6.18-rc6-mm1/drivers/ata/pata_amd.c	2006-09-11 17:17:19.000000000 +0100
> @@ -25,7 +25,7 @@
>  #include <linux/libata.h>
>  
>  #define DRV_NAME "pata_amd"
> -#define DRV_VERSION "0.2.2"
> +#define DRV_VERSION "0.2.3"
>  
>  /**
>   *	timing_setup		-	shared timing computation and load
> @@ -253,11 +253,22 @@
>  
>  static int nv_pre_reset(struct ata_port *ap) {
>  	static const u8 bitmask[2] = {0x03, 0xC0};
> +	static const struct pci_bits nv_enable_bits[] = {
> +		{ 0x50, 1, 0x02, 0x02 },
> +		{ 0x50, 1, 0x01, 0x01 }
> +	};
>  
>  	struct pci_dev *pdev = to_pci_dev(ap->host->dev);
>  	u8 ata66;
>  	u16 udma;
>  
> +	if (!pci_test_config_bits(pdev, &nv_enable_bits[ap->port_no])) {
> +		ata_port_disable(ap);
> +		printk(KERN_INFO "ata%u: port disabled. ignoring.\n", ap->id);
> +		return 0;
> +	}
> +
> +

Well, it's now a bit better :-)

ata4: port disabled. ignoring.
ata4: SRST failed (status 0xFF)
ata4: SRST failed (err_mask=0x100)
ata4: softreset failed, retrying in 5 secs
ata4: SRST failed (status 0xFF)
ata4: SRST failed (err_mask=0x100)
ata4: softreset failed, retrying in 5 secs
ata4: SRST failed (status 0xFF)
ata4: SRST failed (err_mask=0x100)
ata4: reset failed, giving up
-- 
Krzysztof Halasa
