Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267606AbTAHQhg>; Wed, 8 Jan 2003 11:37:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267614AbTAHQhf>; Wed, 8 Jan 2003 11:37:35 -0500
Received: from meg.hrz.tu-chemnitz.de ([134.109.132.57]:31423 "EHLO
	meg.hrz.tu-chemnitz.de") by vger.kernel.org with ESMTP
	id <S267606AbTAHQhe>; Wed, 8 Jan 2003 11:37:34 -0500
Date: Wed, 8 Jan 2003 17:11:48 +0100
From: Ingo Oeser <ingo.oeser@informatik.tu-chemnitz.de>
To: Bjorn Helgaas <bjorn_helgaas@hp.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] AGP 4/7: add generic print of AGP version & mode
Message-ID: <20030108171148.I628@nightmaster.csn.tu-chemnitz.de>
References: <200301071338.17372.bjorn_helgaas@hp.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2i
In-Reply-To: <200301071338.17372.bjorn_helgaas@hp.com>; from bjorn_helgaas@hp.com on Tue, Jan 07, 2003 at 01:38:17PM -0700
X-Spam-Score: -3.3 (---)
X-Scanner: exiscan for exim4 (http://duncanthrax.net/exiscan/) *18WJLK-0007Wo-00*kS.pvhICDqw*
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Bjorn,
hi lkml,

On Tue, Jan 07, 2003 at 01:38:17PM -0700, Bjorn Helgaas wrote:
> diff -Nru a/drivers/char/agp/generic.c b/drivers/char/agp/generic.c
> --- a/drivers/char/agp/generic.c	Tue Jan  7 12:52:25 2003
> +++ b/drivers/char/agp/generic.c	Tue Jan  7 12:52:25 2003
> @@ -314,15 +314,22 @@
>  
>  /* Generic Agp routines - Start */
>  
> -void agp_device_command(u32 command)
> +void agp_device_command(u32 command, int agp_v3)

Why not agp_version?

>  {
>  	struct pci_dev *device;
> +	int mode;
> +
> +	mode = command & 0x7;
> +	if (agp_v3)
> +		mode *= 4;
>  
>  	pci_for_each_dev(device) {
>  		u8 agp = pci_find_capability(device, PCI_CAP_ID_AGP);
>  		if (!agp)
>  			continue;
>  
> +		printk(KERN_INFO PFX "Putting AGP V%d device at %s into %dx mode\n",
> +				agp_v3 ? 3 : 2, device->slot_name, mode);

Why not use agp_version directly here?

>  		pci_write_config_dword(device, agp + 8, command);
>  	}
>  }

And always supply AGP_VERSION_1, AGP_VERSION_2, AGP_VERSION_3 and
so or simply numbers to that command?

This offers a lot of possibilities:

   - Version checking (drivers can deny commands not suitable for
     this interface, if this checking is enabled)

   - Support for AGP_VERSION_4 can be implemented without
     obfuscating the interface for older (non-compliant) drivers.

   - One check less ;-)

   - Cleaner Code

Regards

Ingo Oeser
-- 
Science is what we can tell a computer. Art is everything else. --- D.E.Knuth
