Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932217AbWBJWTw@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932217AbWBJWTw (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 10 Feb 2006 17:19:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932218AbWBJWTw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 10 Feb 2006 17:19:52 -0500
Received: from streetfiresound.liquidweb.com ([64.91.233.29]:30677 "EHLO
	host.streetfiresound.liquidweb.com") by vger.kernel.org with ESMTP
	id S932217AbWBJWTv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 10 Feb 2006 17:19:51 -0500
Subject: Re: [PATCH] spi: Updated PXA2xx SSP SPI Driver
From: Stephen Street <stephen@streetfiresound.com>
Reply-To: stephen@streetfiresound.com
To: Nicolas Pitre <nico@cam.org>
Cc: lkml <linux-kernel@vger.kernel.org>, dvrabel@arcom.com,
       David Brownell <david-b@pacbell.net>,
       spi-devel-general@lists.sourceforge.net, Andrew Morton <akpm@osdl.org>
In-Reply-To: <Pine.LNX.4.64.0602101102520.5397@localhost.localdomain>
References: <43e80ec3.oEr+gtyMVtunRTyE%stephen@streetfiresound.com>
	 <1139535480.30189.30.camel@ststephen.streetfiresound.com>
	 <Pine.LNX.4.64.0602101102520.5397@localhost.localdomain>
Content-Type: text/plain
Organization: StreetFire Sound Labs
Date: Fri, 10 Feb 2006 14:19:41 -0800
Message-Id: <1139609981.30189.84.camel@ststephen.streetfiresound.com>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.2 (2.0.2-22) 
Content-Transfer-Encoding: 7bit
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - host.streetfiresound.liquidweb.com
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - streetfiresound.com
X-Source: 
X-Source-Args: 
X-Source-Dir: 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2006-02-10 at 12:40 -0500, Nicolas Pitre wrote:
> [...]
> 
> +#define SSP_REG(x) (*((volatile unsigned long *)x))
> 
> Don't do that.  Instead, please use:
> 
> #define DEFINE_SSP_REG(reg, off) \
> static inline u32 read_##reg(void *p) { return __raw_readl(p + (off)); \
> static inline void write_##reg(u32 v, void *p) { __raw_writel(v, p + (off)); }
> 
> DEFINE_SSP_REG(SSCR0,	0x00)
> DEFINE_SSP_REG(SSCR1,	0x04)
> DEFINE_SSP_REG(SSSR,	0x08)
> DEFINE_SSP_REG(SSITR,	0x0c)
> DEFINE_SSP_REG(SSDR,	0x10)
> DEFINE_SSP_REG(SSTO,	0x28)
> DEFINE_SSP_REG(SSPSP,	0x2c)
> 
Ok,  I'll do this (Andrew made a similar comment). But...

I modeled my SSP_REG on the contents of include/asm-
arm/arch_pxa/pxa_reg.h which makes extensive use of __REG defined in
include/asm-arm/arch_pxa/hardware.h as

#define __REG(x) (*((volatile u32 *)io_p2v(x)))

which is effectively my SSP_REG without the io_p2v because I preloaded
the virtual SSP register addresses in the pxa2xx_spi_probe function.

For my education:

Why are __raw_readl and friends better than exploiting the memory map
I/O nature of the PXA2xx and other SOCs?  

Especially since something like

SSP_REG(sscr1) &= ~SSCR1_TIE;

becomes

write_SSCR1(read_SSCR1(reg) & ~SSCR_TIE, reg);

Further what should I do with the DMA register accesses (i.e. DCSR,
DCMD, etc)?

> +static void dma_handler(int channel, void *data, struct pt_regs *regs)
> +{
> +       struct driver_data *drv_data = (struct driver_data *)data;
> +       struct spi_message *msg = drv_data->cur_msg;
> +       u32 sssr = drv_data->sssr;
> +       u32 sscr1 = drv_data->sscr1;
> +       u32 ssto = drv_data->sscr1;
>         ^^^^^^^^^^^^^^^^^^^^^^^^^^
> 
Definitely wrong, harmless in this case but bad none the less.  Thanks
great eyes!

Stephen



