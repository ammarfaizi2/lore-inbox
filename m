Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317307AbSFLCD1>; Tue, 11 Jun 2002 22:03:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317309AbSFLCD0>; Tue, 11 Jun 2002 22:03:26 -0400
Received: from c16410.randw1.nsw.optusnet.com.au ([210.49.25.29]:27640 "EHLO
	mail.chubb.wattle.id.au") by vger.kernel.org with ESMTP
	id <S317307AbSFLCD0>; Tue, 11 Jun 2002 22:03:26 -0400
From: Peter Chubb <peter@chubb.wattle.id.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <15622.44011.587251.752252@wombat.chubb.wattle.id.au>
Date: Wed, 12 Jun 2002 12:03:23 +1000
To: linux-kernel@vger.kernel.org, torvalds@transmeta.com
CC: hermes@gibson.dropbear.id.au, alan@lxorguk.ukuu.org.uk
Subject: yenta_socket driver PCI irq routing fix
X-Mailer: VM 7.04 under 21.4 (patch 8) "Honest Recruiter" XEmacs Lucid
X-Face: .slVUC18R`%{j(W3ztQe~*ATzet;h`*Wv33MZ]*M,}9AP<`+C=U)c#NzI5vK!0^d#6:<_`a
 {#.<}~(T^aJ~]-.C'p~saJ7qZXP-$AY==]7,9?WVSH5sQ}g3,8j>u%@f$/Z6,WR7*E~BFY.Yjw,H6<
 F.cEDj2$S:kO2+-5<]afj@kC!:uw\(<>lVpk)lPZs+2(=?=D/TZPG+P9LDN#1RRUPxdX
Comments: Hyperbole mail buttons accepted, v04.18.
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Hi,
	This patch  fixes the Compaq WL210 problems I've been having.

The symptoms were that no interupts were ever received from the card;
the BIOS reported it had assigned INTA to IRQ 10; but the yenta
driver reported IRQ 17.

The fix is not to rely on the BIOS's initialisation of interrupt
routing in the TI1410, but to do it explicitly.

This may break laptops that actually use the parallel ISA IRQ
mechanism.


Disclaimer: I don't really understand this code.  Better fixes welcome.

===== drivers/pcmcia/ti113x.h 1.2 vs edited =====
--- 1.2/drivers/pcmcia/ti113x.h	Tue Feb  5 18:37:44 2002
+++ edited/drivers/pcmcia/ti113x.h	Wed Jun 12 11:50:39 2002
@@ -195,6 +195,8 @@
 #define ti_sysctl(socket)	((socket)->private[0])
 #define ti_cardctl(socket)	((socket)->private[1])
 #define ti_devctl(socket)	((socket)->private[2])
+#define ti_diag(socket)		((socket)->private[3])
+#define ti_irqmux(socket)	((socket)->private[4])
 
 static int ti113x_open(pci_socket_t *socket)
 {
@@ -235,7 +237,6 @@
 	yenta_proc_setup
 };
 
-#define ti_diag(socket)		((socket)->private[0])
 
 static int ti1250_open(pci_socket_t *socket)
 {
@@ -244,16 +245,22 @@
 	ti_diag(socket) &= ~(TI1250_DIAG_PCI_CSC | TI1250_DIAG_PCI_IREQ);
 	if (socket->cb_irq)
 		ti_diag(socket) |= TI1250_DIAG_PCI_CSC | TI1250_DIAG_PCI_IREQ;
-	ti_open(socket);
+	ti113x_open(socket);
 	return 0;
 }
 
 static int ti1250_init(pci_socket_t *socket)
 {
 	yenta_init(socket);
-
+	ti113x_init(socket);
+	ti_irqmux(socket) = config_readl(socket, TI122X_IRQMUX);
+	ti_irqmux(socket) = (ti_irqmux(socket) & ~0x0f) | 0x02; /* route INTA */
+	if (!(ti_sysctl(socket) & TI122X_SCR_INTRTIE))
+		ti_irqmux(socket) |= 0x20; /* route INTB */
+	
+	config_writel(socket, TI122X_IRQMUX, ti_irqmux(socket));
+		
 	config_writeb(socket, TI1250_DIAGNOSTIC, ti_diag(socket));
-	ti_intctl(socket);
 	return 0;
 }
 
===== drivers/pcmcia/yenta.c 1.10 vs edited =====
--- 1.10/drivers/pcmcia/yenta.c	Tue Feb  5 18:55:41 2002
+++ edited/drivers/pcmcia/yenta.c	Wed Jun 12 11:40:59 2002
@@ -806,7 +806,7 @@
 	{ PD(TI,1251A),	&ti_ops },
 	{ PD(TI,1211),	&ti_ops },
 	{ PD(TI,1251B),	&ti_ops },
-	{ PD(TI,1410),	&ti_ops },
+	{ PD(TI,1410),	&ti1250_ops },
 	{ PD(TI,1420),	&ti_ops },
 	{ PD(TI,4410),	&ti_ops },
 	{ PD(TI,4451),	&ti_ops },
