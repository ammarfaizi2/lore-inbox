Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264279AbUEMQGP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264279AbUEMQGP (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 13 May 2004 12:06:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264277AbUEMQGP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 13 May 2004 12:06:15 -0400
Received: from webapps.arcom.com ([194.200.159.168]:21513 "EHLO
	webapps.arcom.com") by vger.kernel.org with ESMTP id S264279AbUEMQGM
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 13 May 2004 12:06:12 -0400
Message-ID: <40A39CF2.3060406@arcom.com>
Date: Thu, 13 May 2004 17:06:10 +0100
From: David Vrabel <dvrabel@arcom.com>
User-Agent: Mozilla Thunderbird 0.5 (X11/20040306)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
CC: dahinds@users.sourceforge.net
Subject: [PCMCIA] [2.4] TI CardBus PCI interrupt routing fix.
Content-Type: multipart/mixed;
 boundary="------------060309000001000205000506"
X-OriginalArrivalTime: 13 May 2004 16:12:48.0968 (UTC) FILETIME=[22807480:01C43905]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------060309000001000205000506
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit

Hi,

ti_intctl() in drivers/pcmcia/ti113x.h tweaks the MFUNC Routing register 
to route interrupts via PCI.  Currently it clobbers the top 24 bits of 
the register.

Also, certain implementations tie INTA and INTB together and use the 
MFUNC1 pin as a GPO thus INTB shouldn't be routed in this case.

Attached patch fixes both these issues.

David Vrabel
-- 
David Vrabel, Design Engineer

Arcom, Clifton Road           Tel: +44 (0)1223 411200 ext. 3233
Cambridge CB1 7EA, UK         Web: http://www.arcom.com/

--------------060309000001000205000506
Content-Type: text/plain;
 name="ti-cardbus-irq-routing-fix"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="ti-cardbus-irq-routing-fix"

Index: linux-2.4.24/drivers/pcmcia/ti113x.h
===================================================================
--- linux-2.4.24.orig/drivers/pcmcia/ti113x.h	2004-05-12 17:52:40.000000000 +0100
+++ linux-2.4.24/drivers/pcmcia/ti113x.h	2004-05-13 16:33:53.000000000 +0100
@@ -176,7 +176,8 @@
 	 *   --rmk
 	 */
 	if (!socket->cap.irq_mask) {
-		u8 irqmux, devctl;
+		uint8_t devctl;
+		uint32_t irqmux;
 
 		devctl = config_readb(socket, TI113X_DEVICE_CONTROL);
 		if ((devctl & TI113X_DCR_IMODE_MASK) != TI12XX_DCR_IMODE_ALL_SERIAL) {
@@ -186,7 +187,8 @@
 
 			irqmux = config_readl(socket, TI122X_IRQMUX);
 			irqmux = (irqmux & ~0x0f) | 0x02; /* route INTA */
-			irqmux = (irqmux & ~0xf0) | 0x20; /* route INTB */
+			if (!(config_readl(socket, TI113X_SYSTEM_CONTROL) & TI122X_SCR_INTRTIE))
+				irqmux = (irqmux & ~0xf0) | 0x20; /* route INTB if INTA and INTB aren't tied */
 
 			config_writel(socket, TI122X_IRQMUX, irqmux);
 			config_writeb(socket, TI113X_DEVICE_CONTROL, devctl);

--------------060309000001000205000506--
