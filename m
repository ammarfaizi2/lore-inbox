Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262521AbVAJU4p@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262521AbVAJU4p (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 10 Jan 2005 15:56:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262503AbVAJUyc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 10 Jan 2005 15:54:32 -0500
Received: from smtp5.wanadoo.fr ([193.252.22.26]:46902 "EHLO smtp5.wanadoo.fr")
	by vger.kernel.org with ESMTP id S262478AbVAJUtU convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 10 Jan 2005 15:49:20 -0500
From: Vincent ETIENNE <ve@vetienne.net>
To: linux-kernel@vger.kernel.org
Subject: Re: AMD64-AGP pb with AGP APERTURE on IWILL DK8N
Date: Mon, 10 Jan 2005 20:49:15 +0000
User-Agent: KMail/1.7.2
References: <200412282049.48616.ve@vetienne.net> <m13bxnli1x.fsf@muc.de>
In-Reply-To: <m13bxnli1x.fsf@muc.de>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 8BIT
Content-Disposition: inline
Message-Id: <200501102049.15404.ve@vetienne.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Le Jeudi 30 Décembre 2004 19:09, vous avez écrit :
> Vincent ETIENNE <ve@vetienne.net> writes:
> > IOMMU reports a 128MB aperture for CPU0 ( that's the value i used in my
> > bios) at F0000000 but only 32MB at 4000000 for CPU1 and declare i have no
> > valid aperture as show in this dmesg extract.
>
> First you should complain to your BIOS vendor because it is just another
> kind of BIOS bug (of which there seems to be an infinite supply ...)
>
> > +  if ( last_aper_order )
> > + {
> > +   if ( aper_order != last_aper_order )
> > +   {
> >
> > +    printk("Aperture size changed!! use old one (%x,%x)",
> > last_aper_order, last_aper_base );
> > +    write_pci_config(0, num, 3, 0x90, last_aper_order<<1);
> > +    write_pci_config(0, num, 3, 0x94, last_aper_base>>25);
> > +    aper_order = last_aper_order;
> > +    aper_base = last_aper_base;
> > +    aper_size = (32 * 1024 * 1024) << aper_order;
> > +   }
>
> There is already code to do this at the end of the function. A better
> patch would be the attached one.
>
> This would also handle the case of a wrong aper_base.
>
> Untested, uncompiled right now.
>
> Can you test if that works on your board? If yes I can add it.
>
> -Andi
>
> Based on debugging&code from Vincent ETIENNE <ve@vetienne.net>
>
>
> I have some problem with AGP initialization with my board : IWILL DK8N (Bi
> opteron chipset NFORCE3 ). I use kernel 2.6.10-rc3-mm1, but i have try with
> different kernel always with the same result :
>
> IOMMU reports a 128MB aperture for CPU0 ( that's the value i used in my
> bios) at F0000000 but only 32MB at 4000000 for CPU1
> <<
>
> This patch checks for this condition and fixes the other CPUs up.
>
> Signed-off-by: Andi Kleen <ak@suse.de>
>
> diff -u linux-2.6.10/arch/x86_64/kernel/aperture.c-o
> linux-2.6.10/arch/x86_64/kernel/aperture.c ---
> linux-2.6.10/arch/x86_64/kernel/aperture.c-o 2004-12-24 22:35:23.000000000
> +0100 +++ linux-2.6.10/arch/x86_64/kernel/aperture.c 2004-12-30
> 19:56:22.000000000 +0100 @@ -200,8 +200,8 @@
>  void __init iommu_hole_init(void)
>  {
>   int fix, num;
> - u32 aper_size, aper_alloc = 0, aper_order;
> - u64 aper_base;
> + u32 aper_size, aper_alloc = 0, aper_order, last_aper_order = 0;
> + u64 aper_base, last_aper_base = 0;
>   int valid_agp = 0;
>
>   if (iommu_aperture_disabled || !fix_aperture)
> @@ -230,7 +230,15 @@
>    if (!aperture_valid(name, aper_base, aper_size)) {
>     fix = 1;
>     break;
> -  }
> +  }
> +
> +  if ((last_aper_order && aper_order != last_aper_order) ||
> +      (last_aper_base && aper_base != last_aper_base)) {
> +   fix = 1;
> +   break;
> +  }
> +  last_aper_order = aper_order;
> +  last_aper_base = aper_base;
>   }
>
>   if (!fix && !fallback_aper_force) )

Many thanks for your time and your effort. As i have replied to 
fa.linux.kernel list, i'm not sure you receive it. Your patch has greatly 
simplify my problem. And it's incorporated in the last mm release 
(2.6.10-mm2). The fallback to AGP works (but the BIOS doesn't initalized AGP 
bridge correctly as well so..). I have sent some information to IWILL 
technician as well as a a link to our discussion and i'm waiting information.

Best regards,

Vincent



