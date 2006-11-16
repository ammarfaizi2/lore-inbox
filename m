Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1424184AbWKPXZK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1424184AbWKPXZK (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 16 Nov 2006 18:25:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1424267AbWKPXZK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 16 Nov 2006 18:25:10 -0500
Received: from outmx004.isp.belgacom.be ([195.238.4.101]:1189 "EHLO
	outmx004.isp.belgacom.be") by vger.kernel.org with ESMTP
	id S1424184AbWKPXZI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 16 Nov 2006 18:25:08 -0500
Message-ID: <455CF360.4000101@trollprod.org>
Date: Fri, 17 Nov 2006 00:25:20 +0100
From: Olivier Nicolas <olivn@trollprod.org>
User-Agent: Thunderbird 2.0b1pre (X11/20061115)
MIME-Version: 1.0
To: Yinghai Lu <yinghai.lu@amd.com>
CC: Linus Torvalds <torvalds@osdl.org>, Mws <mws@twisted-brains.org>,
       Jeff Garzik <jeff@garzik.org>, Krzysztof Halasa <khc@pm.waw.pl>,
       David Miller <davem@davemloft.net>, linux-kernel@vger.kernel.org,
       tiwai@suse.de
Subject: Re: [PATCH] ALSA: hda-intel - Disable MSI support by default
References: <Pine.LNX.4.64.0611141846190.3349@woody.osdl.org>	 <455B688F.8070007@garzik.org>	 <Pine.LNX.4.64.0611151127560.3349@woody.osdl.org>	 <200611152059.53845.mws@twisted-brains.org>	 <Pine.LNX.4.64.0611151210380.3349@woody.osdl.org>	 <455B7E3F.6040403@trollprod.org> <86802c440611152208jf415991vdd348a0a369f8aa2@mail.gmail.com>
In-Reply-To: <86802c440611152208jf415991vdd348a0a369f8aa2@mail.gmail.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Yinghai Lu wrote:
> Please try the patch about using pci_intx.
> 
> it could use msi.

It can't cold boot with this one (with pci=routeirq or not)

The last visible boot messages are
Interrupt Link [AAZA] enabled at IRQ 20
Interrupt 0000:00:0e.1[B]->Link [AAZA] -> GSI 20 (level,low) -> IRQ 20



Olivier

> 
> YH
> 
> 
> ------------------------------------------------------------------------
> 
> diff --git a/sound/pci/hda/hda_intel.c b/sound/pci/hda/hda_intel.c
> index e35cfd3..88b99ab 100644
> --- a/sound/pci/hda/hda_intel.c
> +++ b/sound/pci/hda/hda_intel.c
> @@ -547,6 +547,7 @@ static unsigned int azx_rirb_get_respons
>  		chip->msi = 0;
>  		if (azx_acquire_irq(chip, 1) < 0)
>  			return -1;
> +		pci_intx(chip->pci, 1);
>  		goto again;
>  	}
>  
> @@ -1435,11 +1436,16 @@ static int azx_resume(struct pci_dev *pc
>  		return -EIO;
>  	}
>  	pci_set_master(pci);
> -	if (chip->msi)
> +	if (chip->msi) {
> +		pci_intx(pci, 0);
>  		if (pci_enable_msi(pci) < 0)
>  			chip->msi = 0;
> +	}
>  	if (azx_acquire_irq(chip, 1) < 0)
>  		return -EIO;
> +
> +	if (!chip->msi) 
> +		pci_intx(pci, 1);
>  	azx_init_chip(chip);
>  	snd_hda_resume(chip->bus);
>  	snd_power_change_state(card, SNDRV_CTL_POWER_D0);
> @@ -1531,7 +1537,8 @@ static int __devinit azx_create(struct s
>  	chip->pci = pci;
>  	chip->irq = -1;
>  	chip->driver_type = driver_type;
> -	chip->msi = enable_msi;
> +//	chip->msi = enable_msi;
> +	chip->msi = 1;
>  
>  	chip->position_fix = position_fix;
>  	chip->single_cmd = single_cmd;
> @@ -1561,14 +1568,19 @@ #endif
>  		goto errout;
>  	}
>  
> -	if (chip->msi)
> +	if (chip->msi) {
> +		pci_intx(pci, 0);
>  		if (pci_enable_msi(pci) < 0)
>  			chip->msi = 0;
> +	}
>  
>  	if (azx_acquire_irq(chip, 0) < 0) {
>  		err = -EBUSY;
>  		goto errout;
>  	}
> +	
> +	if(!chip->msi)
> +		pci_intx(pci, 1);
>  
>  	pci_set_master(pci);
>  	synchronize_irq(chip->irq);


-- 
Laudator temporis acti (Horace, 173)
Donner c'est donner, repeindre ses volets
