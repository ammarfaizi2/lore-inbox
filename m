Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750728AbVI1Szv@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750728AbVI1Szv (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 28 Sep 2005 14:55:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750726AbVI1Szv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 28 Sep 2005 14:55:51 -0400
Received: from mail.dvmed.net ([216.237.124.58]:31205 "EHLO mail.dvmed.net")
	by vger.kernel.org with ESMTP id S1750716AbVI1Szu (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 28 Sep 2005 14:55:50 -0400
Message-ID: <433AE72B.1060708@pobox.com>
Date: Wed, 28 Sep 2005 14:55:39 -0400
From: Jeff Garzik <jgarzik@pobox.com>
User-Agent: Mozilla Thunderbird 1.0.6-1.1.fc4 (X11/20050720)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Lukasz Kosewski <lkosewsk@gmail.com>
CC: linux-kernel@vger.kernel.org, linux-ide@vger.kernel.org,
       linux-scsi@vger.kernel.org
Subject: Re: [PATCH 1/3] Add disk hotswap support to libata RESEND #5
References: <355e5e5e0509261801613c9bdb@mail.gmail.com>
In-Reply-To: <355e5e5e0509261801613c9bdb@mail.gmail.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Score: 0.0 (/)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Lukasz Kosewski wrote:
> @@ -57,6 +57,7 @@ enum {
>  	PDC_GLOBAL_CTL		= 0x48, /* Global control/status (per port) */
>  	PDC_CTLSTAT		= 0x60,	/* IDE control and status (per port) */
>  	PDC_SATA_PLUG_CSR	= 0x6C, /* SATA Plug control/status reg */
> +	PDC2_SATA_PLUG_CSR	= 0X60, /* SATAII Plug control/status reg */

Did you actually compile and test this?  :)


> @@ -690,6 +745,9 @@ static int pdc_ata_init_one (struct pci_
>  
>  	/* notice 4-port boards */
>  	switch (board_idx) {
> +	case board_40518:
> +		/* Override hotplug offset for SATAII150 */
> +		hp->hotplug_offset = PDC2_SATA_PLUG_CSR;

add a comment /* fall through */ here


>  	case board_20319:
>         		probe_ent->n_ports = 4;
>  
> @@ -699,6 +757,9 @@ static int pdc_ata_init_one (struct pci_
>  		probe_ent->port[2].scr_addr = base + 0x600;
>  		probe_ent->port[3].scr_addr = base + 0x700;
>  		break;
> +	case board_2057x:
> +		/* Override hotplug offset for SATAII150 */
> +		hp->hotplug_offset = PDC2_SATA_PLUG_CSR;

ditto


>  	case board_2037x:
>         		probe_ent->n_ports = 2;
>  		break;
> @@ -724,7 +785,7 @@ static int pdc_ata_init_one (struct pci_
> 	/* initialize adapter */
> 	pdc_host_init(board_idx, probe_ent);
>  
> -	/* FIXME: check ata_device_add return value */
> +	/* FIXME: check ata_device_add return value.  If 0, kfree(hp) */
> 	ata_device_add(probe_ent);

Just leave the comment as is.  You made it worse:

* if ata_device_add() returns zero, then everything is OK.

* if ata_device_add() returns non-zero, then an error occured. 
kfree(hp) is but one of several things that need to be cleaned up on 
failure.


Finally, please fix the format of your subject line per
	http://linux.yyz.us/patch-format.html

Most notably, each Subject should be unique for each patch.  e.g.

[PATCH 1/3] sata_promise: fix hotplug register offset
[PATCH 2/3] libata: add device hotplug infrastructure
[PATCH 3/3] sata_promise: add device hotplug support

	Jeff


