Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S274980AbTHFXVV (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 6 Aug 2003 19:21:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S274983AbTHFXVV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 6 Aug 2003 19:21:21 -0400
Received: from caramon.arm.linux.org.uk ([212.18.232.186]:59917 "EHLO
	caramon.arm.linux.org.uk") by vger.kernel.org with ESMTP
	id S274980AbTHFXVO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 6 Aug 2003 19:21:14 -0400
Date: Thu, 7 Aug 2003 00:21:10 +0100
From: Russell King <rmk@arm.linux.org.uk>
To: Linux Kernel List <linux-kernel@vger.kernel.org>
Subject: [PATCH] PCMCIA IRQ stuff
Message-ID: <20030807002110.K16116@flint.arm.linux.org.uk>
Mail-Followup-To: Linux Kernel List <linux-kernel@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
X-Message-Flag: Your copy of Microsoft Outlook is vulnerable to viruses. See www.mutt.org for more details.
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ok, this is what's going to Linus shortly.  I have some further changes
which cleans up the whole override stuff, but I haven't had time to
sort those out cleanly, and probably won't do until the weekend now.

Enjoy.

# This is a BitKeeper generated patch for the following project:
# Project Name: Linux kernel tree
# This patch format is intended for GNU patch command version 2.5 or higher.
# This patch includes the following deltas:
#	           ChangeSet	1.1612  -> 1.1616 
#	drivers/pcmcia/ti113x.h	1.13    -> 1.14   
#	drivers/pcmcia/yenta_socket.c	1.35    -> 1.37   
#	drivers/pcmcia/i82365.c	1.41    -> 1.42   
#
# The following is the BitKeeper ChangeSet Log
# --------------------------------------------
# 03/08/06	ambx1@com.rmk.(none)	1.1613
# [PCMCIA] Fix PnP Probing in i82365.c
# 
# pnp_x_valid returns 1 if valid.  Therefore we should be using
# !pnp_port_valid.  Also cleans up some formatting issues.
# --------------------------------------------
# 03/08/06	rmk@flint.arm.linux.org.uk	1.1614
# [PCMCIA] Fix cardbus init failure paths.
# 
# Currently, yenta does not try to clean up after an error occurs while
# initialising a cardbus socket.  This cset ensures that we release
# resources.  We also claim the cardbus MMIO memory resource.
# --------------------------------------------
# 03/08/07	rmk@flint.arm.linux.org.uk	1.1615
# [PCMCIA] Disable IRQ steering and don't change the IRQ MUX register.
# 
# The IRQ steering code operates too early at present, and actually
# prevents us detecting ISA interrupts.
# 
# We should not touch the IRQ MUX register on TI bridges - only the
# machine itself knows the right value for this.  The kernel doesn't
# have the knowledge to know what function the cardbus controllers
# multi-function pins have been assigned by the hardware manufacturer.
# --------------------------------------------
# 03/08/07	rmk@flint.arm.linux.org.uk	1.1616
# [PCMCIA] Report subsystem vendor/device IDs
# 
# In order to properly track down who needs to program the IRQ MUX
# register, add the subsystem vendor and device IDs to the kernel
# message indicating discovery of the cardbus bridge.
# --------------------------------------------
#
diff -Nru a/drivers/pcmcia/i82365.c b/drivers/pcmcia/i82365.c
--- a/drivers/pcmcia/i82365.c	Thu Aug  7 00:17:42 2003
+++ b/drivers/pcmcia/i82365.c	Thu Aug  7 00:17:42 2003
@@ -795,16 +795,14 @@
 	
 	    if (pnp_device_attach(dev) < 0)
 	    	continue;
-	
-	    printk("PNP ");
-	    
+
 	    if (pnp_activate_dev(dev) < 0) {
 		printk("activate failed\n");
 		pnp_device_detach(dev);
 		break;
 	    }
 
-	    if (pnp_port_valid(dev, 0)) {
+	    if (!pnp_port_valid(dev, 0)) {
 		printk("invalid resources ?\n");
 		pnp_device_detach(dev);
 		break;
diff -Nru a/drivers/pcmcia/ti113x.h b/drivers/pcmcia/ti113x.h
--- a/drivers/pcmcia/ti113x.h	Thu Aug  7 00:17:42 2003
+++ b/drivers/pcmcia/ti113x.h	Thu Aug  7 00:17:42 2003
@@ -258,6 +258,7 @@
 	if (new != reg)
 		exca_writeb(socket, I365_INTCTL, new);
 
+#if 0
 	/*
 	 * If ISA interrupts don't work, then fall back to routing card
 	 * interrupts to the PCI interrupt of the socket.
@@ -282,6 +283,7 @@
 			config_writeb(socket, TI113X_DEVICE_CONTROL, devctl);
 		}
 	}
+#endif
 
 	socket->socket.ops->init = ti_init;
 	return 0;
@@ -327,9 +329,11 @@
 	struct yenta_socket *socket = container_of(sock, struct yenta_socket, socket);
 	ti113x_init(sock);
 	ti_irqmux(socket) = config_readl(socket, TI122X_IRQMUX);
+#if 0
 	ti_irqmux(socket) = (ti_irqmux(socket) & ~0x0f) | 0x02; /* route INTA */
 	if (!(ti_sysctl(socket) & TI122X_SCR_INTRTIE))
 		ti_irqmux(socket) |= 0x20; /* route INTB */
+#endif
 	
 	config_writel(socket, TI122X_IRQMUX, ti_irqmux(socket));
 		
diff -Nru a/drivers/pcmcia/yenta_socket.c b/drivers/pcmcia/yenta_socket.c
--- a/drivers/pcmcia/yenta_socket.c	Thu Aug  7 00:17:42 2003
+++ b/drivers/pcmcia/yenta_socket.c	Thu Aug  7 00:17:42 2003
@@ -752,6 +752,7 @@
 		iounmap(sock->base);
 	yenta_free_resources(sock);
 
+	pci_release_regions(dev);
 	pci_set_drvdata(dev, NULL);
 }
 
@@ -823,6 +824,7 @@
 {
 	struct yenta_socket *socket;
 	struct cardbus_override_struct *d;
+	int ret;
 	
 	socket = kmalloc(sizeof(struct yenta_socket), GFP_KERNEL);
 	if (!socket)
@@ -842,11 +844,19 @@
 	/*
 	 * Do some basic sanity checking..
 	 */
-	if (pci_enable_device(dev))
-		return -1;
+	if (pci_enable_device(dev)) {
+		ret = -EBUSY;
+		goto free;
+	}
+
+	ret = pci_request_regions(dev, "yenta_socket");
+	if (ret)
+		goto disable;
+
 	if (!pci_resource_start(dev, 0)) {
 		printk("No cardbus resource!\n");
-		return -1;
+		ret = -ENODEV;
+		goto release;
 	}
 
 	/*
@@ -854,8 +864,17 @@
 	 * and request the IRQ.
 	 */
 	socket->base = ioremap(pci_resource_start(dev, 0), 0x1000);
-	if (!socket->base)
-		return -1;
+	if (!socket->base) {
+		ret = -ENOMEM;
+		goto release;
+	}
+
+	/*
+	 * report the subsystem vendor and device for help debugging
+	 * the irq stuff...
+	 */
+	printk(KERN_INFO "Yenta: CardBus bridge found at %s [%04x:%04x]\n",
+		dev->slot_name, dev->subsystem_vendor, dev->subsystem_device);
 
 	yenta_config_init(socket);
 
@@ -871,9 +890,9 @@
 	d = cardbus_override;
 	while (d->override) {
 		if ((dev->vendor == d->vendor) && (dev->device == d->device)) {
-			int retval = d->override(socket);
-			if (retval < 0)
-				return retval;
+			ret = d->override(socket);
+			if (ret < 0)
+				goto unmap;
 		}
 		d++;
 	}
@@ -895,7 +914,20 @@
 	printk("Socket status: %08x\n", cb_readl(socket, CB_SOCKET_STATE));
 
 	/* Register it with the pcmcia layer.. */
-	return pcmcia_register_socket(&socket->socket);
+	ret = pcmcia_register_socket(&socket->socket);
+	if (ret == 0)
+		goto out;
+
+ unmap:
+	iounmap(socket->base);
+ release:
+	pci_release_regions(dev);
+ disable:
+	pci_disable_device(dev);
+ free:
+	kfree(socket);
+ out:
+	return ret;
 }
 
 

-- 
Russell King (rmk@arm.linux.org.uk)                The developer of ARM Linux
             http://www.arm.linux.org.uk/personal/aboutme.html

