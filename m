Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932207AbVIHHH0@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932207AbVIHHH0 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 8 Sep 2005 03:07:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751317AbVIHHH0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 8 Sep 2005 03:07:26 -0400
Received: from pacific.moreton.com.au ([203.143.235.130]:26892 "EHLO
	bne.snapgear.com") by vger.kernel.org with ESMTP id S1751271AbVIHHHZ
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 8 Sep 2005 03:07:25 -0400
Message-ID: <431FE33E.1000607@snapgear.com>
Date: Thu, 08 Sep 2005 17:07:42 +1000
From: Greg Ungerer <gerg@snapgear.com>
User-Agent: Mozilla Thunderbird 1.0.2 (X11/20050317)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Yasushi SHOJI <yashi@atmark-techno.com>
CC: Christoph Hellwig <hch@infradead.org>, linux-kernel@vger.kernel.org,
       Janos Farkas <jf-ml-k1-1087813225@lk8rp.mail.xeon.eu.org>
Subject: Re: [PATCH] add romfs_get_size()
References: <87k6htt0tg.wl@mail2.atmark-techno.com>	<20050907142604.GA5822@infradead.org>	<87irxdt0dz.wl@mail2.atmark-techno.com>	<20050907150439.GA6646@infradead.org> <87fysguc1d.wl@mail2.atmark-techno.com>
In-Reply-To: <87fysguc1d.wl@mail2.atmark-techno.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Yashi,

Yasushi SHOJI wrote:
> At Wed, 7 Sep 2005 16:04:39 +0100,
> Christoph Hellwig wrote:
> 
>>On Wed, Sep 07, 2005 at 11:31:36PM +0900, Yasushi SHOJI wrote:
>>
>>>>On Wed, Sep 07, 2005 at 11:22:19PM +0900, Yasushi SHOJI wrote:
>>>>
>>>>>Many embedded linux products have been using romfs and it's still
>>>>>growing.  most, if not all, of them implement thier own way to check
>>>>>its romfs size.
>>>>>
>>>>>this patch provides this commonly used function.
>>>>
>>>>Used where.  Please come back as soon as you have a caller in-tree
>>>>which makes sense..
>>>
>>>i don't know this one make sense but the biggest user is uclinux mtd
>>>map. in uclinux_mtd_init():
>>
>>I don't quite see the corelation.  Anyway, please submit a patch series
>>that converts whatever wrong variant to the new one, describing each
>>patch in detail, and adding proper ROMFS depencies to the places using
>>it.
> 
> 
> I don't have most of platform to test. sure it's easy to just convert
> them using romfs_get_size() but I don't wanna submit any patch that I
> can't test.
> 
> So, if the patch is not that bad, it'd be much easier to just tell all
> platform maintainer that the infra. is in place and they can start
> converting their code to use new function.
> 
> Anyway I just converted uclinux.c to use romfs_get_size(). Greg, would
> you kindly comment on the attached patch?

I don't see any problem with it.

The uclinux.c code as it stands is probably a little sloppy.
It doesn't do any checks for a valid ROMfs first - it should at
least check the magic number.

Regards
Greg



> Signed-off-by: Yasushi SHOJI <yashi@atmark-techno.com>
> ---
> diff --git a/drivers/mtd/maps/uclinux.c b/drivers/mtd/maps/uclinux.c
> --- a/drivers/mtd/maps/uclinux.c
> +++ b/drivers/mtd/maps/uclinux.c
> @@ -16,6 +16,7 @@
>  #include <linux/init.h>
>  #include <linux/kernel.h>
>  #include <linux/fs.h>
> +#include <linux/romfs_fs.h>
>  #include <linux/major.h>
>  #include <linux/root_dev.h>
>  #include <linux/mtd/mtd.h>
> @@ -63,7 +64,7 @@ int __init uclinux_mtd_init(void)
>  
>  	mapp = &uclinux_ram_map;
>  	mapp->phys = (unsigned long) &_ebss;
> -	mapp->size = PAGE_ALIGN(*((unsigned long *)((&_ebss) + 8)));
> +	mapp->size = PAGE_ALIGN(romfs_get_size((struct romfs_super_block *)&_ebss));
>  	mapp->bankwidth = 4;
>  
>  	printk("uclinux[mtd]: RAM probe address=0x%x size=0x%x\n",
> 
> 

-- 
------------------------------------------------------------------------
Greg Ungerer  --  Chief Software Dude       EMAIL:     gerg@snapgear.com
SnapGear -- a CyberGuard Company            PHONE:       +61 7 3435 2888
825 Stanley St,                             FAX:         +61 7 3891 3630
Woolloongabba, QLD, 4102, Australia         WEB: http://www.SnapGear.com
