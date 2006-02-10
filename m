Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932226AbWBJWpn@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932226AbWBJWpn (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 10 Feb 2006 17:45:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932227AbWBJWpn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 10 Feb 2006 17:45:43 -0500
Received: from relais.videotron.ca ([24.201.245.36]:22628 "EHLO
	relais.videotron.ca") by vger.kernel.org with ESMTP id S932226AbWBJWpn
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 10 Feb 2006 17:45:43 -0500
Date: Fri, 10 Feb 2006 17:45:41 -0500 (EST)
From: Nicolas Pitre <nico@cam.org>
Subject: Re: [PATCH] spi: Updated PXA2xx SSP SPI Driver
In-reply-to: <1139609981.30189.84.camel@ststephen.streetfiresound.com>
X-X-Sender: nico@localhost.localdomain
To: Stephen Street <stephen@streetfiresound.com>
Cc: lkml <linux-kernel@vger.kernel.org>, dvrabel@arcom.com,
       David Brownell <david-b@pacbell.net>,
       spi-devel-general@lists.sourceforge.net, Andrew Morton <akpm@osdl.org>
Message-id: <Pine.LNX.4.64.0602101732590.5397@localhost.localdomain>
MIME-version: 1.0
Content-type: TEXT/PLAIN; charset=US-ASCII
Content-transfer-encoding: 7BIT
References: <43e80ec3.oEr+gtyMVtunRTyE%stephen@streetfiresound.com>
 <1139535480.30189.30.camel@ststephen.streetfiresound.com>
 <Pine.LNX.4.64.0602101102520.5397@localhost.localdomain>
 <1139609981.30189.84.camel@ststephen.streetfiresound.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 10 Feb 2006, Stephen Street wrote:

> On Fri, 2006-02-10 at 12:40 -0500, Nicolas Pitre wrote:
> > [...]
> > 
> > +#define SSP_REG(x) (*((volatile unsigned long *)x))
> > 
> > Don't do that.  Instead, please use:
> > 
> > #define DEFINE_SSP_REG(reg, off) \
> > static inline u32 read_##reg(void *p) { return __raw_readl(p + (off)); \
> > static inline void write_##reg(u32 v, void *p) { __raw_writel(v, p + (off)); }
> > 
> > DEFINE_SSP_REG(SSCR0,	0x00)
> > DEFINE_SSP_REG(SSCR1,	0x04)
> > DEFINE_SSP_REG(SSSR,	0x08)
> > DEFINE_SSP_REG(SSITR,	0x0c)
> > DEFINE_SSP_REG(SSDR,	0x10)
> > DEFINE_SSP_REG(SSTO,	0x28)
> > DEFINE_SSP_REG(SSPSP,	0x2c)
> > 
> Ok,  I'll do this (Andrew made a similar comment). But...
> 
> I modeled my SSP_REG on the contents of include/asm-
> arm/arch_pxa/pxa_reg.h which makes extensive use of __REG defined in
> include/asm-arm/arch_pxa/hardware.h as
> 
> #define __REG(x) (*((volatile u32 *)io_p2v(x)))
> 
> which is effectively my SSP_REG without the io_p2v because I preloaded
> the virtual SSP register addresses in the pxa2xx_spi_probe function.

True. But you should pretend to never have seen that.  This macro is low 
level stuff and if it changes for whatever reason it is better if driver 
code didn't reimplement it. Furthermore the argument to __REG() is 
always a constant not a variable making it a simple absolute address 
that the compiler can use and optimize for pretty effectively.

> For my education:
> 
> Why are __raw_readl and friends better than exploiting the memory map
> I/O nature of the PXA2xx and other SOCs?  

Actually, it will do almost the same as you originally did if you look 
at its definition.  However, because a solution needs to be implemented 
to support multiple ports then using __raw_readl() at the driver level 
is more familiar to other kernel people.

> Especially since something like
> 
> SSP_REG(sscr1) &= ~SSCR1_TIE;
> 
> becomes
> 
> write_SSCR1(read_SSCR1(reg) & ~SSCR_TIE, reg);
> 
> Further what should I do with the DMA register accesses (i.e. DCSR,
> DCMD, etc)?

They are fine already.

In fact, if there was only one SSP port, I'd have asked you to use 
SSPCR0, SSPDR, etc. directly.  But the fact that the driver can handle 
multiple ports makes it rather messy (and the SSP*_P() macros in 
pxa-regs.h are an abomination IMHO).


Nicolas
