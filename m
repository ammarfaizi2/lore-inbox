Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261778AbUKHIdS@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261778AbUKHIdS (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 8 Nov 2004 03:33:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261775AbUKHIdR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 8 Nov 2004 03:33:17 -0500
Received: from smtp-out.hotpop.com ([38.113.3.61]:10463 "EHLO
	smtp-out.hotpop.com") by vger.kernel.org with ESMTP id S261778AbUKHIdM
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 8 Nov 2004 03:33:12 -0500
From: "Antonino A. Daplas" <adaplas@hotpop.com>
Reply-To: adaplas@pol.net
To: linux-fbdev-devel@lists.sourceforge.net,
       Benjamin Herrenschmidt <benh@kernel.crashing.org>,
       Linux Kernel list <linux-kernel@vger.kernel.org>
Subject: Re: [Linux-fbdev-devel] Re: [PATCH] fbdev: Fix IO access in rivafb
Date: Mon, 8 Nov 2004 16:33:00 +0800
User-Agent: KMail/1.5.4
Cc: Linux Fbdev development list 
	<linux-fbdev-devel@lists.sourceforge.net>
References: <200411080521.iA85LbG6025914@hera.kernel.org> <1099893447.10262.154.camel@gaston>
In-Reply-To: <1099893447.10262.154.camel@gaston>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200411081633.00645.adaplas@hotpop.com>
X-HotPOP: -----------------------------------------------
                   Sent By HotPOP.com FREE Email
             Get your FREE POP email at www.HotPOP.com
          -----------------------------------------------
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Monday 08 November 2004 13:57, Benjamin Herrenschmidt wrote:
> > diff -Nru a/drivers/video/riva/riva_hw.h b/drivers/video/riva/riva_hw.h
> > --- a/drivers/video/riva/riva_hw.h	2004-11-07 21:21:47 -08:00
> > +++ b/drivers/video/riva/riva_hw.h	2004-11-07 21:21:47 -08:00
> > @@ -78,13 +78,13 @@
> >  #define NV_WR08(p,i,d)	out_8(p+i, d)
> >  #define NV_RD08(p,i)	in_8(p+i)
> >  #else
> > -#define NV_WR08(p,i,d)  (((U008 *)(p))[i]=(d))
> > -#define NV_RD08(p,i)    (((U008 *)(p))[i])
> > +#define NV_WR08(p,i,d)  (writeb((d), (u8 __iomem *)(p) + (i)))
> > +#define NV_RD08(p,i)    (readb((u8 __iomem *)(p) + (i)))
> >  #endif
> > -#define NV_WR16(p,i,d)  (((U016 *)(p))[(i)/2]=(d))
> > -#define NV_RD16(p,i)    (((U016 *)(p))[(i)/2])
> > -#define NV_WR32(p,i,d)  (((U032 *)(p))[(i)/4]=(d))
> > -#define NV_RD32(p,i)    (((U032 *)(p))[(i)/4])
> > +#define NV_WR16(p,i,d)  (writew((d), (u16 __iomem *)(p) + (i)/2))
> > +#define NV_RD16(p,i)    (readw((u16 __iomem *)(p) + (i)/2))
> > +#define NV_WR32(p,i,d)  (writel((d), (u32 __iomem *)(p) + (i)/4))
> > +#define NV_RD32(p,i)    (readl((u32 __iomem *)(p) + (i)/4))
> >  #define VGA_WR08(p,i,d) NV_WR08(p,i,d)
> >  #define VGA_RD08(p,i)   NV_RD08(p,i)
>
> You probably broke ppc versions here. The driver enables "big endian"
> register access, but readw/writew/l functions do byteswap, which will
> lead to incorrect results.
>
> The fix would be to probably just remove the code that puts the chip
> registers into big endian mode, this isn't necessary nor a very good
> idea actually.
>
> I don't have an nVidia card on ppc to test any more unfortunately.

Hmm, I'll ask Guido Guenther if he can test the changes. I think a different
set of access macros for PPC might be a more preferrable solution. 

Tony


