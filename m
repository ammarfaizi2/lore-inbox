Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S270196AbTGMJp6 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 13 Jul 2003 05:45:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S270197AbTGMJp6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 13 Jul 2003 05:45:58 -0400
Received: from caramon.arm.linux.org.uk ([212.18.232.186]:2310 "EHLO
	caramon.arm.linux.org.uk") by vger.kernel.org with ESMTP
	id S270196AbTGMJp4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 13 Jul 2003 05:45:56 -0400
Date: Sun, 13 Jul 2003 11:00:16 +0100
From: Russell King <rmk@arm.linux.org.uk>
To: Jaakko Niemi <liiwi@lonesom.pp.fi>
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>, Wiktor Wodecki <wodecki@gmx.de>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: hang with pcmcia wlan card
Message-ID: <20030713110016.A2621@flint.arm.linux.org.uk>
Mail-Followup-To: Jaakko Niemi <liiwi@lonesom.pp.fi>,
	Alan Cox <alan@lxorguk.ukuu.org.uk>,
	Wiktor Wodecki <wodecki@gmx.de>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <87fzldxcf5.fsf@jumper.lonesom.pp.fi> <873chbyasi.fsf@jumper.lonesom.pp.fi> <20030712173039.A17432@flint.arm.linux.org.uk> <20030712164855.GB2133@gmx.de> <1058086011.31919.39.camel@dhcp22.swansea.linux.org.uk> <87wuemg3h2.fsf@jumper.lonesom.pp.fi>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <87wuemg3h2.fsf@jumper.lonesom.pp.fi>; from liiwi@lonesom.pp.fi on Sun, Jul 13, 2003 at 12:50:33PM +0300
X-Message-Flag: Your copy of Microsoft Outlook is vulnerable to viruses. See www.mutt.org for more details.
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jul 13, 2003 at 12:50:33PM +0300, Jaakko Niemi wrote:
> Alan Cox <alan@lxorguk.ukuu.org.uk> writes:
> > On Sad, 2003-07-12 at 17:48, Wiktor Wodecki wrote:
> >> > +      * If ISA interrupts don't work, then fall back to routing card
> >> > +      * interrupts to the PCI interrupt of the socket.
> >> > +      */
> >> > +     if (!socket->socket.irq_mask) {
> >> > +             int irqmux, devctl;
> >> > +
> >
> > See the fix posted to the list a while ago and apply that and all should
> > be well. The change you refer to breaks for some setups
> 
>  Was the fix against drivers/pcmcia/ti113x.h ? (other than backing off
>  that patch..). If so, then I'm unable to locate it. Looks like I need
>  local lkml archive anyway :)

The patch never went anywhere near lkml.  It was sent to Pat Mochel
primerily for testing (since Pat was able to produce the feedback
last time around to solve the problem.)  However, I haven't heard back
from Pat.

I won't even bother putting this into my bk tree and asking Linus to
pull; I'm sure someone else will integrate this into the kernel tree
for me.  (as happened previously, and as a result I need to sort out
my bk tree.)

--- orig/drivers/pcmcia/ti113x.h	Wed Jul  2 22:44:06 2003
+++ linux/drivers/pcmcia/ti113x.h	Sun Jul  6 22:52:41 2003
@@ -179,21 +179,26 @@
 	/*
 	 * If ISA interrupts don't work, then fall back to routing card
 	 * interrupts to the PCI interrupt of the socket.
+	 *
+	 * Tweaking this when we are using serial PCI IRQs causes hangs
+	 *   --rmk
 	 */
 	if (!socket->socket.irq_mask) {
-		int irqmux, devctl;
-
-		printk (KERN_INFO "ti113x: Routing card interrupts to PCI\n");
+		u8 irqmux, devctl;
 
 		devctl = config_readb(socket, TI113X_DEVICE_CONTROL);
-		devctl &= ~TI113X_DCR_IMODE_MASK;
+		if (devctl & TI113X_DCR_IMODE_MASK != TI12XX_DCR_IMODE_ALL_SERIAL) {
+			printk (KERN_INFO "ti113x: Routing card interrupts to PCI\n");
+
+			devctl &= ~TI113X_DCR_IMODE_MASK;
 
-		irqmux = config_readl(socket, TI122X_IRQMUX);
-		irqmux = (irqmux & ~0x0f) | 0x02; /* route INTA */
-		irqmux = (irqmux & ~0xf0) | 0x20; /* route INTB */
+			irqmux = config_readl(socket, TI122X_IRQMUX);
+			irqmux = (irqmux & ~0x0f) | 0x02; /* route INTA */
+			irqmux = (irqmux & ~0xf0) | 0x20; /* route INTB */
 
-		config_writel(socket, TI122X_IRQMUX, irqmux);
-		config_writeb(socket, TI113X_DEVICE_CONTROL, devctl);
+			config_writel(socket, TI122X_IRQMUX, irqmux);
+			config_writeb(socket, TI113X_DEVICE_CONTROL, devctl);
+		}
 	}
 
 	socket->socket.ss_entry->init = ti_init;


-- 
Russell King (rmk@arm.linux.org.uk)                The developer of ARM Linux
             http://www.arm.linux.org.uk/personal/aboutme.html

