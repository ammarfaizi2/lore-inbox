Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261744AbUKHF6n@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261744AbUKHF6n (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 8 Nov 2004 00:58:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261759AbUKHF6n
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 8 Nov 2004 00:58:43 -0500
Received: from gate.crashing.org ([63.228.1.57]:49792 "EHLO gate.crashing.org")
	by vger.kernel.org with ESMTP id S261744AbUKHF6k (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 8 Nov 2004 00:58:40 -0500
Subject: Re: [PATCH] fbdev: Fix IO access in rivafb
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Linux Kernel list <linux-kernel@vger.kernel.org>
Cc: "Antonino A. Daplas" <adaplas@hotpop.com>,
       Linux Fbdev development list 
	<linux-fbdev-devel@lists.sourceforge.net>
In-Reply-To: <200411080521.iA85LbG6025914@hera.kernel.org>
References: <200411080521.iA85LbG6025914@hera.kernel.org>
Content-Type: text/plain
Date: Mon, 08 Nov 2004 16:57:26 +1100
Message-Id: <1099893447.10262.154.camel@gaston>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.2 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> diff -Nru a/drivers/video/riva/riva_hw.h b/drivers/video/riva/riva_hw.h
> --- a/drivers/video/riva/riva_hw.h	2004-11-07 21:21:47 -08:00
> +++ b/drivers/video/riva/riva_hw.h	2004-11-07 21:21:47 -08:00
> @@ -78,13 +78,13 @@
>  #define NV_WR08(p,i,d)	out_8(p+i, d)
>  #define NV_RD08(p,i)	in_8(p+i)
>  #else
> -#define NV_WR08(p,i,d)  (((U008 *)(p))[i]=(d))
> -#define NV_RD08(p,i)    (((U008 *)(p))[i])
> +#define NV_WR08(p,i,d)  (writeb((d), (u8 __iomem *)(p) + (i)))
> +#define NV_RD08(p,i)    (readb((u8 __iomem *)(p) + (i)))
>  #endif
> -#define NV_WR16(p,i,d)  (((U016 *)(p))[(i)/2]=(d))
> -#define NV_RD16(p,i)    (((U016 *)(p))[(i)/2])
> -#define NV_WR32(p,i,d)  (((U032 *)(p))[(i)/4]=(d))
> -#define NV_RD32(p,i)    (((U032 *)(p))[(i)/4])
> +#define NV_WR16(p,i,d)  (writew((d), (u16 __iomem *)(p) + (i)/2))
> +#define NV_RD16(p,i)    (readw((u16 __iomem *)(p) + (i)/2))
> +#define NV_WR32(p,i,d)  (writel((d), (u32 __iomem *)(p) + (i)/4))
> +#define NV_RD32(p,i)    (readl((u32 __iomem *)(p) + (i)/4))
>  #define VGA_WR08(p,i,d) NV_WR08(p,i,d)
>  #define VGA_RD08(p,i)   NV_RD08(p,i)


You probably broke ppc versions here. The driver enables "big endian"
register access, but readw/writew/l functions do byteswap, which will
lead to incorrect results.

The fix would be to probably just remove the code that puts the chip
registers into big endian mode, this isn't necessary nor a very good
idea actually.

I don't have an nVidia card on ppc to test any more unfortunately.

Ben.


