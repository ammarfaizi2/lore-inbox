Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316663AbSF0HHm>; Thu, 27 Jun 2002 03:07:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316756AbSF0HHm>; Thu, 27 Jun 2002 03:07:42 -0400
Received: from mail0.epfl.ch ([128.178.50.57]:25870 "HELO mail0.epfl.ch")
	by vger.kernel.org with SMTP id <S316663AbSF0HHl>;
	Thu, 27 Jun 2002 03:07:41 -0400
Message-ID: <3D1AB9BD.8050303@epfl.ch>
Date: Thu, 27 Jun 2002 09:07:41 +0200
From: Nicolas Aspert <Nicolas.Aspert@epfl.ch>
Organization: LTS-DE-EPFL
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.0.0) Gecko/20020605
X-Accept-Language: en-us, ja
MIME-Version: 1.0
To: Adrian Bunk <bunk@fs.tum.de>, Knut J Bjuland <knutjbj@online.no>
CC: linux-kernel@vger.kernel.org, jhartmann@addoes.com
Subject: Re: bug in Linux 2.4.19RC1 i815e agpgart module, unable to determineaperture
 size.
References: <fa.ckqb7hv.j48jpn@ifi.uio.no> <fa.soqp29v.17ncoig@ifi.uio.no>
Content-Type: multipart/mixed;
 boundary="------------020100090800070806040307"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------020100090800070806040307
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit

Adrian Bunk wrote:

> Since -rc1 agpgart_be.c uses for the 815 new 815-specific instead of the
> generic intel functions.
> 
> Could you try whether reverting the following part of the patch fixes the
> problem?
> 
> --- linux/drivers/char/agp/agpgart_be.c	2002-06-04 01:22:07.000000000 +0000
> +++ linux/drivers/char/agp/agpgart_be.c	2002-06-24 15:23:36.000000000 +0000
> @@ -3929,7 +4005,7 @@
>  		INTEL_I815,
>  		"Intel",
>  		"i815",
> -		intel_generic_setup },
> +		intel_815_setup },
>  	{ PCI_DEVICE_ID_INTEL_820_0,
>  		PCI_VENDOR_ID_INTEL,
>  		INTEL_I820,
> 
> 
> 

Hello

I suspect that the problem (from what you sent) comes from the 
'intel_8xx_fetch_size' function. The APSIZE register has only one bit 
with valuable information with intel815 chipset, all other bits are 
'reserved'. The problem you saw may come from reading those reserved bits.
I attach a patch against 2.4.19-rc1 that aims at fixing this. Could you 
please test and report whether things get better/worse ?

Best regards

Nicolas.

-- 
Nicolas Aspert      Signal Processing Institute (ITS)
Swiss Federal Institute of Technology (EPFL)


--------------020100090800070806040307
Content-Type: text/plain;
 name="i815-fetch-size-2.4.19-rc1.diff"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="i815-fetch-size-2.4.19-rc1.diff"

diff -Nru linux-2.4.19-rc1.clean/drivers/char/agp/agpgart_be.c linux-2.4.19-rc1/drivers/char/agp/agpgart_be.c
--- linux-2.4.19-rc1.clean/drivers/char/agp/agpgart_be.c	Thu Jun 27 08:56:02 2002
+++ linux-2.4.19-rc1/drivers/char/agp/agpgart_be.c	Thu Jun 27 08:59:21 2002
@@ -1402,6 +1402,10 @@
 	aper_size_info_8 *values;
 
 	pci_read_config_byte(agp_bridge.dev, INTEL_APSIZE, &temp);
+
+        if (agp_bridge.type == INTEL_I815) 
+          temp &= (1 << 3);
+        
 	values = A_SIZE_8(agp_bridge.aperture_sizes);
 
 	for (i = 0; i < agp_bridge.num_aperture_sizes; i++) {

--------------020100090800070806040307--

