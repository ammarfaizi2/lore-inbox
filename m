Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265215AbTFUR2e (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 21 Jun 2003 13:28:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265219AbTFUR2e
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 21 Jun 2003 13:28:34 -0400
Received: from caramon.arm.linux.org.uk ([212.18.232.186]:52747 "EHLO
	caramon.arm.linux.org.uk") by vger.kernel.org with ESMTP
	id S265215AbTFUR2b (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 21 Jun 2003 13:28:31 -0400
Date: Sat, 21 Jun 2003 18:42:31 +0100
From: Russell King <rmk@arm.linux.org.uk>
To: Linux Kernel List <linux-kernel@vger.kernel.org>
Subject: [CFT] Enable Cardbus bursting
Message-ID: <20030621184231.B28984@flint.arm.linux.org.uk>
Mail-Followup-To: Linux Kernel List <linux-kernel@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
X-Message-Flag: Your copy of Microsoft Outlook is vulnerable to viruses. See www.mutt.org for more details.
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Below is a patch which is the result of work sent by Linus to myself,
cleaned by Dominik, and a change for PCMCIA ISA IRQ routing stuff from
the 2.4-ac tree.

Linus said:
> Here's a patch that apparently improves throughput on Texas Instrument
> 1520 controllers a lot by enabling memory bursting. Apparently to the
> point that without this you can't even do things like 802.11g without
> starting to drop data.
and later:
> So this seems to be not a 1520-specific thing, but a generic 12xx+ thing,
> and we migth want to just enhance the current 12xx stuff and add the ID
> for the 1520 to use that too..

Before I push this to Linus, I'd like people with TI cardbus bridges to
test this patch and ensure that there are no unfortunate side effects.

The patch is against 2.5.72 bk as of about 6am GMT on Friday.

diff -Nru a/drivers/pcmcia/ti113x.h b/drivers/pcmcia/ti113x.h
--- a/drivers/pcmcia/ti113x.h	Sat Jun 21 18:27:38 2003
+++ b/drivers/pcmcia/ti113x.h	Sat Jun 21 18:27:39 2003
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
@@ -239,6 +260,17 @@
 	ti113x_override(socket);
 	socket->socket.ss_entry->init = ti1250_init;
 	return 0;
+}
+
+
+static int ti12xx_override(struct yenta_socket *socket)
+{
+	/* make sure that memory burst is active */
+	ti_sysctl(socket) = config_readl(socket, TI113X_SYSTEM_CONTROL);
+	ti_sysctl(socket) |= TI122X_SCR_MRBURSTUP;
+	config_writel(socket, TI113X_SYSTEM_CONTROL, ti_sysctl(socket));
+
+	return ti113x_override(socket);
 }
 
 #endif /* CONFIG_CARDBUS */
diff -Nru a/drivers/pcmcia/yenta_socket.c b/drivers/pcmcia/yenta_socket.c
--- a/drivers/pcmcia/yenta_socket.c	Sat Jun 21 18:27:39 2003
+++ b/drivers/pcmcia/yenta_socket.c	Sat Jun 21 18:27:39 2003
@@ -807,22 +807,29 @@
 	unsigned short device;
 	int (*override) (struct yenta_socket *socket);
 } cardbus_override[] = {
-	{ PD(TI,1130),	&ti113x_override },
 	{ PD(TI,1031),	&ti_override },
-	{ PD(TI,1131),	&ti113x_override },
-	{ PD(TI,1250),	&ti1250_override },
-	{ PD(TI,1220),	&ti_override },
-	{ PD(TI,1221),	&ti_override },
+
+	/* TBD: Check if these TI variants can use more
+	 * advanced overrides instead */
 	{ PD(TI,1210),	&ti_override },
-	{ PD(TI,1450),	&ti_override },
-	{ PD(TI,1225),	&ti_override },
-	{ PD(TI,1251A),	&ti_override },
 	{ PD(TI,1211),	&ti_override },
+	{ PD(TI,1251A),	&ti_override },
 	{ PD(TI,1251B),	&ti_override },
-	{ PD(TI,1410),	ti1250_override },
 	{ PD(TI,1420),	&ti_override },
+	{ PD(TI,1450),	&ti_override },
 	{ PD(TI,4410),	&ti_override },
 	{ PD(TI,4451),	&ti_override },
+
+	{ PD(TI,1130),	&ti113x_override },
+	{ PD(TI,1131),	&ti113x_override },
+
+	{ PD(TI,1220),	&ti12xx_override },
+	{ PD(TI,1221),	&ti12xx_override },
+	{ PD(TI,1225),	&ti12xx_override },
+	{ PD(TI,1520),  &ti12xx_override },
+
+	{ PD(TI,1250),	&ti1250_override },
+	{ PD(TI,1410),	&ti1250_override },
 
 	{ PD(RICOH,RL5C465), &ricoh_override },
 	{ PD(RICOH,RL5C466), &ricoh_override },
diff -Nru a/include/linux/pci_ids.h b/include/linux/pci_ids.h
--- a/include/linux/pci_ids.h	Sat Jun 21 18:27:39 2003
+++ b/include/linux/pci_ids.h	Sat Jun 21 18:27:39 2003
@@ -663,7 +663,6 @@
 #define PCI_DEVICE_ID_TI_1220		0xac17
 #define PCI_DEVICE_ID_TI_1221		0xac19
 #define PCI_DEVICE_ID_TI_1210		0xac1a
-#define PCI_DEVICE_ID_TI_1410		0xac50
 #define PCI_DEVICE_ID_TI_1450		0xac1b
 #define PCI_DEVICE_ID_TI_1225		0xac1c
 #define PCI_DEVICE_ID_TI_1251A		0xac1d
@@ -671,7 +670,9 @@
 #define PCI_DEVICE_ID_TI_1251B		0xac1f
 #define PCI_DEVICE_ID_TI_4410		0xac41
 #define PCI_DEVICE_ID_TI_4451		0xac42
+#define PCI_DEVICE_ID_TI_1410		0xac50
 #define PCI_DEVICE_ID_TI_1420		0xac51
+#define PCI_DEVICE_ID_TI_1520		0xac55
 
 #define PCI_VENDOR_ID_SONY		0x104d
 #define PCI_DEVICE_ID_SONY_CXD3222	0x8039

-- 
Russell King (rmk@arm.linux.org.uk)                The developer of ARM Linux
             http://www.arm.linux.org.uk/personal/aboutme.html

