Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266013AbUAVI7K (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 22 Jan 2004 03:59:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266016AbUAVI7K
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 22 Jan 2004 03:59:10 -0500
Received: from 213-229-38-66.static.adsl-line.inode.at ([213.229.38.66]:57573
	"HELO mail.falke.at") by vger.kernel.org with SMTP id S266013AbUAVI7E
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 22 Jan 2004 03:59:04 -0500
Message-ID: <400F9055.5050206@winischhofer.net>
Date: Thu, 22 Jan 2004 09:56:53 +0100
From: Thomas Winischhofer <thomas@winischhofer.net>
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.0; en-US; rv:1.4) Gecko/20030624 Netscape/7.1 (ax)
X-Accept-Language: en-us, en, de, de-de, de-at, sv
MIME-Version: 1.0
To: Andrew Morton <akpm@osdl.org>
CC: linux-kernel@vger.kernel.org, torvalds@osdl.org
Subject: Re: [PATCH] sisfb update 2.6.1
References: <400F0F8C.8070900@winischhofer.net> <20040121160309.2fd26f0a.akpm@osdl.org>
In-Reply-To: <20040121160309.2fd26f0a.akpm@osdl.org>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



Andrew Morton wrote:

> Thomas Winischhofer <thomas@winischhofer.net> wrote:
> 
>>Update for SiS framebuffer driver for 2.6.1 vanilla
> 
> 
> It still has floating point stuff in sis_init().  Could you please
> review, integrate and test the below patch?

sis_init()? You probably mean sis/init.c?

Anyway: Irrelevant. This code part isn't even being compiled for the 
linux kernel (See line 4304 - #ifdef LINUX_XF86).

(init.c and init301.c are universal modules for XFree86 and the Linux 
kernel; there are some lines of code which are unique to one of these, 
though. I will sort this out in the next release.)

> After that we need to coordinate this with James and Ben who are also doing
> things in this area.  But we wouldn't want to have to defer this SiS patch
> until everything is sorted out in the fbdev core - life is too short ;)

Exactly. I don't see any activity on the fvdevel list since a while 
back. Don't even know what the current status is.

Anyway, it required only to compiler directives to exclude the 
modifications needed by the current James-stuff. Shouldn't be too hard.

Thomas

> From: Andi Kleen <ak@muc.de>
> 
> Here's the matching patch from the SuSE 2.4 tree which also compiles with
> soft-float.  No i haven't even checked if it applies to 2.6.  But maybe it
> will help somebody fix the 2.6 driver.
> 
> 
> 
> ---
> 
>  25-akpm/drivers/video/sis/init.c |   15 ++++++++-------
>  1 files changed, 8 insertions(+), 7 deletions(-)
> 
> diff -puN drivers/video/sis/init.c~sis-DRM-floating-point-removal drivers/video/sis/init.c
> --- 25/drivers/video/sis/init.c~sis-DRM-floating-point-removal	Fri Jan  9 13:22:47 2004
> +++ 25-akpm/drivers/video/sis/init.c	Fri Jan  9 13:22:47 2004
> @@ -5165,7 +5165,8 @@ SiSBuildBuiltInModeList(ScrnInfoPtr pScr
>     unsigned short HRE, HBE, HRS, HBS, HDE, HT;
>     unsigned char  sr_data, cr_data, cr_data2, cr_data3;
>     unsigned char  sr2b, sr2c;
> -   float          num, denum, postscalar, divider;
> +   //float          num, denum, postscalar, divider;
> +   unsigned int	  num, denum, postscalar, divider;
>     int            A, B, C, D, E, F, temp, i, j, index, vclkindex;
>     DisplayModePtr new = NULL, current = NULL, first = NULL, backup = NULL;
>  
> @@ -5230,19 +5231,19 @@ SiSBuildBuiltInModeList(ScrnInfoPtr pScr
>        sr2b = pSiS->SiS_Pr->SiS_VCLKData[vclkindex].SR2B;
>        sr2c = pSiS->SiS_Pr->SiS_VCLKData[vclkindex].SR2C;
>  
> -      divider = (sr2b & 0x80) ? 2.0 : 1.0;
> +      divider = (sr2b & 0x80) ? 2 : 1;
>        postscalar = (sr2c & 0x80) ?
> -              ( (((sr2c >> 5) & 0x03) == 0x02) ? 6.0 : 8.0) : (((sr2c >> 5) & 0x03) + 1.0);
> -      num = (sr2b & 0x7f) + 1.0;
> -      denum = (sr2c & 0x1f) + 1.0;
> +              ( (((sr2c >> 5) & 0x03) == 0x02) ? 6 : 8) : (((sr2c >> 5) & 0x03) + 1);
> +      num = (sr2b & 0x7f) + 1;
> +      denum = (sr2c & 0x1f) + 1;
>        
>  #ifdef TWDEBUG
>        xf86DrvMsg(0, X_INFO, "------------\n");
> -      xf86DrvMsg(0, X_INFO, "sr2b: %x sr2c %x div %f ps %f num %f denum %f\n",
> +      xf86DrvMsg(0, X_INFO, "sr2b: %x sr2c %x div %i ps %i num %i denum %i\n",
>           sr2b, sr2c, divider, postscalar, num, denum);
>  #endif
>  
> -      current->Clock = (int)(14318 * (divider / postscalar) * (num / denum));
> +      current->Clock = (int)(14318 * divider / postscalar * num / denum);
>  
>        sr_data = pSiS->SiS_Pr->SiS_CRT1Table[index].CR[14];
>  	/* inSISIDXREG(SISSR, 0x0b, sr_data); */
> 
> _
> 

-- 
Thomas Winischhofer
Vienna/Austria
thomas AT winischhofer DOT net          *** http://www.winischhofer.net/
twini AT xfree86 DOT org



