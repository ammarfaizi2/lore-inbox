Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265244AbUAOXjX (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 15 Jan 2004 18:39:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265245AbUAOXjX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 15 Jan 2004 18:39:23 -0500
Received: from smtpq3.home.nl ([213.51.128.198]:47778 "EHLO smtpq3.home.nl")
	by vger.kernel.org with ESMTP id S265244AbUAOXjS (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 15 Jan 2004 18:39:18 -0500
Message-ID: <400723D1.2090400@keyaccess.nl>
Date: Fri, 16 Jan 2004 00:35:45 +0100
From: Rene Herman <rene.herman@keyaccess.nl>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.4.1) Gecko/20031029
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Adam Belay <ambx1@neo.rr.com>
CC: Takashi Iwai <tiwai@suse.de>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Re: ALSA in 2.6 failing to find the OPL chip of the sb
 cards
References: <20040107212916.GA978@man.manty.net> <s5hy8sixsor.wl@alsa2.suse.de> <20040109171715.GA933@man.manty.net> <s5hn08xgh06.wl@alsa2.suse.de> <20040109201423.GA1677@man.manty.net> <3FFFA8C3.6040609@keyaccess.nl> <4000E030.2020500@keyaccess.nl> <s5hr7y5b2oe.wl@alsa2.suse.de> <20040113232940.GC3188@neo.rr.com> <20040114190721.GD3188@neo.rr.com>
In-Reply-To: <20040114190721.GD3188@neo.rr.com>
Content-Type: multipart/mixed;
 boundary="------------040202010504030201000106"
X-AtHome-MailScanner-Information: Neem contact op met support@home.nl voor meer informatie
X-AtHome-MailScanner: Found to be clean
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------040202010504030201000106
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit

Adam Belay wrote:

> Here's the patch.  Any testing would be appreciated.

Tested with two more ISA-Pnp soundcards, ES1868 and OPTi 82c933, and
their ALSA drivers, snd-es18xx and snd-opti93x, and both work the same
as they do without the patch (not quite right that is, but nothing to do
with PnP). Also tested with ISA-PnP IDE (on the ES1868), ISA-PnP NE2000
(RTL8019), and ISA-PnP modem. All fine.

Minor point about the patch itself though. In pnp.h, you do:

> -#define pnp_port_valid(dev,bar) (pnp_port_flags((dev),(bar)) &
> IORESOURCE_IO)
> +#define pnp_port_valid(dev,bar) \ +
> ((pnp_port_flags((dev),(bar)) & IORESOURCE_IO) && \ +
> !(pnp_port_flags((dev),(bar)) & IORESOURCE_UNSET))

and the same for mem,irq,dma. It seems you could roll these two tests
into one with:

#define pnp_port_valid(dev,bar) \
((pnp_port_flags((dev),(bar)) & (IORESOURCE_IO | IORESOURCE_UNSET)) ==
IORESOURCE_IO)

Basically just an optimisation I guess (just checked and gcc doesn't do
this itself) but this also stops the macro arguments from being accessed
more than once.

One more point, in isapnp/core.c:isapnp_set_resources()

> -	for (tmp = 0; tmp < PNP_MAX_PORT && res->port_resource[tmp].flags & IORESOURCE_IO; tmp++)
> +	for (tmp = 0; tmp < PNP_MAX_PORT && !(res->port_resource[tmp].flags & IORESOURCE_UNSET); tmp++)

and again same for mem,irq,dma. That is, it goes from only checking
IORESOURCE_<TYPE> to only checking IORESOURCE_UNSET. Also checking for
the type does sound like a valid sanity check, so would it be better to
also check both flags here? Ie:

for (tmp = 0; tmp < PNP_MAX_PORT && (res->port_resource[tmp].flags &
(IORESOURCE_IO | IORESOURCE_UNSET)) == IORESOURCE_IO; tmp++)

Incremental patch attached, in case you agree. Compiled, booted and tested.

Rene.





--------------040202010504030201000106
Content-Type: text/plain;
 name="linux-2.6.1-pnp_incr.diff"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="linux-2.6.1-pnp_incr.diff"

diff -urN linux-2.6.1-pnp/drivers/pnp/isapnp/core.c linux-2.6.1-pnp-incr/drivers/pnp/isapnp/core.c
--- linux-2.6.1-pnp/drivers/pnp/isapnp/core.c	2004-01-16 00:02:40.000000000 +0100
+++ linux-2.6.1-pnp-incr/drivers/pnp/isapnp/core.c	2004-01-15 23:58:23.000000000 +0100
@@ -1039,17 +1039,17 @@
 
 	isapnp_cfg_begin(dev->card->number, dev->number);
 	dev->active = 1;
-	for (tmp = 0; tmp < PNP_MAX_PORT && !(res->port_resource[tmp].flags & IORESOURCE_UNSET); tmp++)
+	for (tmp = 0; tmp < PNP_MAX_PORT && (res->port_resource[tmp].flags & (IORESOURCE_IO | IORESOURCE_UNSET)) == IORESOURCE_IO; tmp++)
 		isapnp_write_word(ISAPNP_CFG_PORT+(tmp<<1), res->port_resource[tmp].start);
-	for (tmp = 0; tmp < PNP_MAX_IRQ && !(res->irq_resource[tmp].flags & IORESOURCE_UNSET); tmp++) {
+	for (tmp = 0; tmp < PNP_MAX_IRQ && (res->irq_resource[tmp].flags & (IORESOURCE_IRQ | IORESOURCE_UNSET)) == IORESOURCE_IRQ; tmp++) {
 		int irq = res->irq_resource[tmp].start;
 		if (irq == 2)
 			irq = 9;
 		isapnp_write_byte(ISAPNP_CFG_IRQ+(tmp<<1), irq);
 	}
-	for (tmp = 0; tmp < PNP_MAX_DMA && !(res->dma_resource[tmp].flags & IORESOURCE_UNSET); tmp++)
+	for (tmp = 0; tmp < PNP_MAX_DMA && (res->dma_resource[tmp].flags & (IORESOURCE_DMA | IORESOURCE_UNSET)) == IORESOURCE_DMA; tmp++)
 		isapnp_write_byte(ISAPNP_CFG_DMA+tmp, res->dma_resource[tmp].start);
-	for (tmp = 0; tmp < PNP_MAX_MEM && !(res->mem_resource[tmp].flags & IORESOURCE_UNSET); tmp++)
+	for (tmp = 0; tmp < PNP_MAX_MEM && (res->mem_resource[tmp].flags & (IORESOURCE_MEM | IORESOURCE_UNSET)) == IORESOURCE_MEM; tmp++)
 		isapnp_write_word(ISAPNP_CFG_MEM+(tmp<<2), (res->mem_resource[tmp].start >> 8) & 0xffff);
 	/* FIXME: We aren't handling 32bit mems properly here */
 	isapnp_activate(dev->number);
diff -urN linux-2.6.1-pnp/include/linux/pnp.h linux-2.6.1-pnp-incr/include/linux/pnp.h
--- linux-2.6.1-pnp/include/linux/pnp.h	2004-01-16 00:02:40.000000000 +0100
+++ linux-2.6.1-pnp-incr/include/linux/pnp.h	2004-01-15 23:56:31.000000000 +0100
@@ -34,8 +34,8 @@
 #define pnp_port_end(dev,bar)     ((dev)->res.port_resource[(bar)].end)
 #define pnp_port_flags(dev,bar)   ((dev)->res.port_resource[(bar)].flags)
 #define pnp_port_valid(dev,bar) \
-	((pnp_port_flags((dev),(bar)) & IORESOURCE_IO) && \
-	!(pnp_port_flags((dev),(bar)) & IORESOURCE_UNSET))
+	((pnp_port_flags((dev),(bar)) & (IORESOURCE_IO | IORESOURCE_UNSET)) \
+		== IORESOURCE_IO)
 #define pnp_port_len(dev,bar) \
 	((pnp_port_start((dev),(bar)) == 0 &&	\
 	  pnp_port_end((dev),(bar)) ==		\
@@ -48,8 +48,8 @@
 #define pnp_mem_end(dev,bar)     ((dev)->res.mem_resource[(bar)].end)
 #define pnp_mem_flags(dev,bar)   ((dev)->res.mem_resource[(bar)].flags)
 #define pnp_mem_valid(dev,bar) \
-	((pnp_mem_flags((dev),(bar)) & IORESOURCE_MEM) && \
-	!(pnp_mem_flags((dev),(bar)) & IORESOURCE_UNSET))
+	((pnp_mem_flags((dev),(bar)) & (IORESOURCE_MEM | IORESOURCE_UNSET)) \
+		== IORESOURCE_MEM)
 #define pnp_mem_len(dev,bar) \
 	((pnp_mem_start((dev),(bar)) == 0 &&	\
 	  pnp_mem_end((dev),(bar)) ==		\
@@ -61,14 +61,14 @@
 #define pnp_irq(dev,bar)	 ((dev)->res.irq_resource[(bar)].start)
 #define pnp_irq_flags(dev,bar)	 ((dev)->res.irq_resource[(bar)].flags)
 #define pnp_irq_valid(dev,bar) \
-	((pnp_irq_flags((dev),(bar)) & IORESOURCE_IRQ) && \
-	!(pnp_irq_flags((dev),(bar)) & IORESOURCE_UNSET))
+	((pnp_irq_flags((dev),(bar)) & (IORESOURCE_IRQ | IORESOURCE_UNSET)) \
+		== IORESOURCE_IRQ)
 
 #define pnp_dma(dev,bar)	 ((dev)->res.dma_resource[(bar)].start)
 #define pnp_dma_flags(dev,bar)	 ((dev)->res.dma_resource[(bar)].flags)
 #define pnp_dma_valid(dev,bar) \
-	((pnp_dma_flags((dev),(bar)) & IORESOURCE_DMA) && \
-	!(pnp_dma_flags((dev),(bar)) & IORESOURCE_UNSET))
+	((pnp_dma_flags((dev),(bar)) & (IORESOURCE_DMA | IORESOURCE_UNSET)) \
+		== IORESOURCE_DMA)
 
 #define PNP_PORT_FLAG_16BITADDR	(1<<0)
 #define PNP_PORT_FLAG_FIXED	(1<<1)


--------------040202010504030201000106--

