Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265415AbTGCV7k (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 3 Jul 2003 17:59:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265416AbTGCV7k
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 3 Jul 2003 17:59:40 -0400
Received: from caramon.arm.linux.org.uk ([212.18.232.186]:17168 "EHLO
	caramon.arm.linux.org.uk") by vger.kernel.org with ESMTP
	id S265415AbTGCV7g (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 3 Jul 2003 17:59:36 -0400
Date: Thu, 3 Jul 2003 23:14:01 +0100
From: Russell King <rmk@arm.linux.org.uk>
To: Johoho <johoho@hojo-net.de>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.5.74-mm1
Message-ID: <20030703231401.G20336@flint.arm.linux.org.uk>
Mail-Followup-To: Johoho <johoho@hojo-net.de>, linux-kernel@vger.kernel.org
References: <20030703023714.55d13934.akpm@osdl.org> <20030703103703.GA4266@gmx.de> <20030703120626.D15013@flint.arm.linux.org.uk> <20030703151529.B20336@flint.arm.linux.org.uk> <20030703214921.GM4266@gmx.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <20030703214921.GM4266@gmx.de>; from wodecki@gmx.de on Thu, Jul 03, 2003 at 11:49:21PM +0200
X-Message-Flag: Your copy of Microsoft Outlook is vulnerable to viruses. See www.mutt.org for more details.
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jul 03, 2003 at 11:49:21PM +0200, Wiktor Wodecki wrote:
> On Thu, Jul 03, 2003 at 03:15:29PM +0100, Russell King wrote:
> > Ok, Wiktor has tried removing these 6 patches, and his problem persists.
> > According to bk revtool, these 6 patches are the only changes which
> > went in for to pcmcia from .73 to .74.
> > 
> > If anyone else is having similar problems, they need to report them so
> > we can obtain more data points - I suspect some other change in some other
> > subsystem broke PCMCIA for Wiktor.
> > 
> > Wiktor - short of anyone else responding, you could try reversing each
> > of the nightly -bk patches from .74 to .73 and work out which set of
> > changes broke it.
> 
> it broke with the 2.5.73-rc2 patch. I assume it was:

Ok, looking at the -bk1-bk2 incremental patch, there's a couple of
possibilities:

- changes to the x86 PCI code
- changes to yenta_socket.c to add different overrides
- add burst support to yenta_socket.c for TI bridges
- add ISA interrupt routing work-around for TI bridges

I think the number one suspect is probably the final one.  Could you try
reversing this patch please?

diff -urN linux-2.5.73-bk1/drivers/pcmcia/ti113x.h linux-2.5.73-bk2/drivers/pcmcia/ti113x.h
--- linux-2.5.73-bk1/drivers/pcmcia/ti113x.h	2003-06-22 11:32:41.000000000 -0700
+++ linux-2.5.73-bk2/drivers/pcmcia/ti113x.h	2003-06-24 13:06:59.000000000 -0700
@@ -175,6 +175,27 @@
 	new = reg & ~I365_INTR_ENA;
 	if (new != reg)
 		exca_writeb(socket, I365_INTCTL, new);
+
+	/*
+	 * If ISA interrupts don't work, then fall back to routing card
+	 * interrupts to the PCI interrupt of the socket.
+	 */
+	if (!socket->socket.irq_mask) {
+		int irqmux, devctl;
+
+		printk (KERN_INFO "ti113x: Routing card interrupts to PCI\n");
+
+		devctl = config_readb(socket, TI113X_DEVICE_CONTROL);
+		devctl &= ~TI113X_DCR_IMODE_MASK;
+
+		irqmux = config_readl(socket, TI122X_IRQMUX);
+		irqmux = (irqmux & ~0x0f) | 0x02; /* route INTA */
+		irqmux = (irqmux & ~0xf0) | 0x20; /* route INTB */
+
+		config_writel(socket, TI122X_IRQMUX, irqmux);
+		config_writeb(socket, TI113X_DEVICE_CONTROL, devctl);
+	}
+
 	socket->socket.ss_entry->init = ti_init;
 	return 0;
 }



-- 
Russell King (rmk@arm.linux.org.uk)                The developer of ARM Linux
             http://www.arm.linux.org.uk/personal/aboutme.html

