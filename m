Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932152AbWBJRky@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932152AbWBJRky (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 10 Feb 2006 12:40:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932115AbWBJRky
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 10 Feb 2006 12:40:54 -0500
Received: from relais.videotron.ca ([24.201.245.36]:35327 "EHLO
	relais.videotron.ca") by vger.kernel.org with ESMTP id S932152AbWBJRkx
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 10 Feb 2006 12:40:53 -0500
Date: Fri, 10 Feb 2006 12:40:52 -0500 (EST)
From: Nicolas Pitre <nico@cam.org>
Subject: Re: [PATCH] spi: Updated PXA2xx SSP SPI Driver
In-reply-to: <1139535480.30189.30.camel@ststephen.streetfiresound.com>
X-X-Sender: nico@localhost.localdomain
To: Stephen Street <stephen@streetfiresound.com>
Cc: lkml <linux-kernel@vger.kernel.org>, dvrabel@arcom.com,
       David Brownell <david-b@pacbell.net>,
       spi-devel-general@lists.sourceforge.net, Andrew Morton <akpm@osdl.org>
Message-id: <Pine.LNX.4.64.0602101102520.5397@localhost.localdomain>
MIME-version: 1.0
Content-type: TEXT/PLAIN; charset=US-ASCII
Content-transfer-encoding: 7BIT
References: <43e80ec3.oEr+gtyMVtunRTyE%stephen@streetfiresound.com>
 <1139535480.30189.30.camel@ststephen.streetfiresound.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 9 Feb 2006, Stephen Street wrote:

> Sorry for the delay in posting this.  My workstation crashed on Tuesday
> and I'm still recovering.
> 
> Attached is an updated patch to add SPI master controller for PXA2xx
> boards.  This update includes fixes for the PXA27x CPU to correctly
> handle the differences peripheral clock speeds with in the PXA2xx
> family.
> 
> I have tested the driver extensively on the PXA255 NSSP port.  My
> application includes a 3 slave chip SPI bus configuration which I have
> driven under load (44850+ bytes per second).  Everything appears to work
> great.  I also implemented a sample loopback driver (please e-mail me
> directly if you are interested the loopback driver) for testing purposes
> and used it to test the driver on the PXA255 SSP port.
> 
> It would be nice is additional eyes review my implementation as I only
> have access to a custom PXA255 board.  Any feedback or word of success
> would be greatly appreciated!

[...]

+#define SSP_REG(x) (*((volatile unsigned long *)x))

Don't do that.  Instead, please use:

#define DEFINE_SSP_REG(reg, off) \
static inline u32 read_##reg(void *p) { return __raw_readl(p + (off)); \
static inline void write_##reg(u32 v, void *p) { __raw_writel(v, p + (off)); }

DEFINE_SSP_REG(SSCR0,	0x00)
DEFINE_SSP_REG(SSCR1,	0x04)
DEFINE_SSP_REG(SSSR,	0x08)
DEFINE_SSP_REG(SSITR,	0x0c)
DEFINE_SSP_REG(SSDR,	0x10)
DEFINE_SSP_REG(SSTO,	0x28)
DEFINE_SSP_REG(SSPSP,	0x2c)

[...]
+	/* SSP register addresses */
+	u32 sscr0;
+	u32 sscr1;
+	u32 sssr;
+	u32 ssitr;
+	u32 ssdr;
+	u32 ssdr_physical;
+	u32 ssto;
+	u32 Bsspsp;

And then you'll only need to store the base address for each port:

	void *ioaddr;

[...]
+static inline void flush(struct driver_data *drv_data)
+{
+       u32 sssr = drv_data->sssr;
+       u32 ssdr = drv_data->ssdr;
+
+       do {
+               while (SSP_REG(sssr) & SSSR_RNE) {
+                       (void)SSP_REG(ssdr);
+               }
+       } while (SSP_REG(sssr) & SSSR_BSY);
+       SSP_REG(sssr) = SSSR_ROR ;
+}

Then it would become:

static inline void flush(struct driver_data *drv_data)
{
	void *reg = drv_data->ioaddr;

	do {
		while (read_SSSR(reg) & SSSR_RNE)
			read_SSDR(reg);
       } while (read_SSSR(reg) & SSSR_BSY);
       write_SSSR(SSSR_ROR, reg);
}

This will make your structure smaller, and gcc will be able to produce 
much smaller and better code due to less register pressure and constant 
base offsets.  It also make the source a bit more readable with fewer
possibilities for errors like:

+static void dma_handler(int channel, void *data, struct pt_regs *regs)
+{
+       struct driver_data *drv_data = (struct driver_data *)data;
+       struct spi_message *msg = drv_data->cur_msg;
+       u32 sssr = drv_data->sssr;
+       u32 sscr1 = drv_data->sscr1;
+       u32 ssto = drv_data->sscr1;
        ^^^^^^^^^^^^^^^^^^^^^^^^^^


Nicolas
