Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262088AbVAEAbj@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262088AbVAEAbj (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 4 Jan 2005 19:31:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262157AbVAEA2I
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 4 Jan 2005 19:28:08 -0500
Received: from pacific.moreton.com.au ([203.143.235.130]:52740 "EHLO
	bne.snapgear.com") by vger.kernel.org with ESMTP id S261761AbVAEA0u
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 4 Jan 2005 19:26:50 -0500
Message-ID: <41DB343F.5070207@snapgear.com>
Date: Wed, 05 Jan 2005 10:26:39 +1000
From: Greg Ungerer <gerg@snapgear.com>
Organization: SnapGear
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7) Gecko/20040616
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Jesper Juhl <juhl-lkml@dif.dk>
Cc: linux-mtd <linux-mtd@lists.infradead.org>,
       David Woodhouse <dwmw2@redhat.com>,
       =?ISO-8859-1?Q?J=F6rn_Engel?= <joern@wh.fh-wedel.de>,
       linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: [patch] remove unnessesary casts from drivers/mtd/maps/nettel.c
 and kill two warnings
References: <Pine.LNX.4.61.0412262202510.3552@dragon.hygekrogen.localhost>
In-Reply-To: <Pine.LNX.4.61.0412262202510.3552@dragon.hygekrogen.localhost>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Jesper,

Sorry for the slow response, I have been out on vacation the
last couple of weeks :-)


Jesper Juhl wrote:
> I took a look at the cause for these warnings in the 2.6.10 kernel,
> 
> drivers/mtd/maps/nettel.c:361: warning: assignment makes pointer from integer without a cast
> drivers/mtd/maps/nettel.c:395: warning: assignment makes pointer from integer without a cast
> 
> and as far as I can see the casts in there (to unsigned long and back to 
> void*) are completely unnessesary ('virt' in 'struct map_info' is a void 
> __iomem *), and getting rid of those casts buys us a warning free build.
> 
> Are there any reasons not to apply the patch below?
> Unfortunately I don't have hardware to test this patch, so it has been 
> compile tested only.

Looks good to me. I have applied it to my working tree.
Do you want me to send it to Linus?

Thanks
Greg




> Please keep me on CC since I'm not subscribed to linux-mtd.
> 
> 
> Signed-off-by: Jesper Juhl <juhl-lkml@dif.dk>
> 
> diff -up linux-2.6.10-orig/drivers/mtd/maps/nettel.c linux-2.6.10/drivers/mtd/maps/nettel.c
> --- linux-2.6.10-orig/drivers/mtd/maps/nettel.c	2004-12-24 22:34:27.000000000 +0100
> +++ linux-2.6.10/drivers/mtd/maps/nettel.c	2004-12-26 22:00:07.000000000 +0100
> @@ -332,8 +332,8 @@ int __init nettel_init(void)
>  
>  		/* Destroy useless AMD MTD mapping */
>  		amd_mtd = NULL;
> -		iounmap((void *) nettel_amd_map.virt);
> -		nettel_amd_map.virt = (unsigned long) NULL;
> +		iounmap(nettel_amd_map.virt);
> +		nettel_amd_map.virt = NULL;
>  #else
>  		/* Only AMD flash supported */
>  		return(-ENXIO);
> @@ -357,8 +357,7 @@ int __init nettel_init(void)
>  	/* Probe for the the size of the first Intel flash */
>  	nettel_intel_map.size = maxsize;
>  	nettel_intel_map.phys = intel0addr;
> -	nettel_intel_map.virt = (unsigned long)
> -		ioremap_nocache(intel0addr, maxsize);
> +	nettel_intel_map.virt = ioremap_nocache(intel0addr, maxsize);
>  	if (!nettel_intel_map.virt) {
>  		printk("SNAPGEAR: failed to ioremap() ROMCS1\n");
>  		return(-EIO);
> @@ -366,8 +365,8 @@ int __init nettel_init(void)
>  	simple_map_init(&nettel_intel_map);
>  
>  	intel_mtd = do_map_probe("cfi_probe", &nettel_intel_map);
> -	if (! intel_mtd) {
> -		iounmap((void *) nettel_intel_map.virt);
> +	if (!intel_mtd) {
> +		iounmap(nettel_intel_map.virt);
>  		return(-ENXIO);
>  	}
>  
> @@ -388,11 +387,10 @@ int __init nettel_init(void)
>  	/* Delete the old map and probe again to do both chips */
>  	map_destroy(intel_mtd);
>  	intel_mtd = NULL;
> -	iounmap((void *) nettel_intel_map.virt);
> +	iounmap(nettel_intel_map.virt);
>  
>  	nettel_intel_map.size = maxsize;
> -	nettel_intel_map.virt = (unsigned long)
> -		ioremap_nocache(intel0addr, maxsize);
> +	nettel_intel_map.virt = ioremap_nocache(intel0addr, maxsize);
>  	if (!nettel_intel_map.virt) {
>  		printk("SNAPGEAR: failed to ioremap() ROMCS1/2\n");
>  		return(-EIO);
> @@ -480,7 +478,7 @@ void __exit nettel_cleanup(void)
>  		map_destroy(intel_mtd);
>  	}
>  	if (nettel_intel_map.virt) {
> -		iounmap((void *)nettel_intel_map.virt);
> +		iounmap(nettel_intel_map.virt);
>  		nettel_intel_map.virt = 0;
>  	}
>  #endif
> 
> 
> 
> 

-- 
------------------------------------------------------------------------
Greg Ungerer  --  Chief Software Dude       EMAIL:     gerg@snapgear.com
SnapGear -- a CyberGuard Company            PHONE:       +61 7 3435 2888
825 Stanley St,                             FAX:         +61 7 3891 3630
Woolloongabba, QLD, 4102, Australia         WEB: http://www.SnapGear.com
