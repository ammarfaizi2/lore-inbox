Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261435AbVBGOo2@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261435AbVBGOo2 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 7 Feb 2005 09:44:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261440AbVBGOo1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 7 Feb 2005 09:44:27 -0500
Received: from mo00.iij4u.or.jp ([210.130.0.19]:1248 "EHLO mo00.iij4u.or.jp")
	by vger.kernel.org with ESMTP id S261435AbVBGOj0 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 7 Feb 2005 09:39:26 -0500
Date: Mon, 7 Feb 2005 23:39:14 +0900
From: Yoichi Yuasa <yuasa@hh.iij4u.or.jp>
To: Andrew Morton <akpm@osdl.org>
Cc: yuasa@hh.iij4u.or.jp, linux-kernel <linux-kernel@vger.kernel.org>
Subject: [PATCH 2.6.11-rc3-mm1] pcmcia: update vrc4171_card
Message-Id: <20050207233914.366b4994.yuasa@hh.iij4u.or.jp>
X-Mailer: Sylpheed version 1.0.0 (GTK+ 1.2.10; i386-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This patch updates vrc4171 pcmcia driver.

Yoichi

Signed-off-by: Yoichi Yuasa <yuasa@hh.iij4u.or.jp>

diff -urN -X dontdiff a-orig/arch/mips/vr41xx/common/Makefile a/arch/mips/vr41xx/common/Makefile
--- a-orig/arch/mips/vr41xx/common/Makefile	Thu Feb  3 10:55:52 2005
+++ a/arch/mips/vr41xx/common/Makefile	Mon Feb  7 22:55:20 2005
@@ -4,7 +4,6 @@
 
 obj-y				+= bcu.o cmu.o giu.o icu.o init.o int-handler.o ksyms.o pmu.o rtc.o
 obj-$(CONFIG_SERIAL_8250)	+= serial.o
-obj-$(CONFIG_VRC4171)		+= vrc4171.o
 obj-$(CONFIG_VRC4173)		+= vrc4173.o
 
 EXTRA_AFLAGS := $(CFLAGS)
diff -urN -X dontdiff a-orig/arch/mips/vr41xx/common/vrc4171.c a/arch/mips/vr41xx/common/vrc4171.c
--- a-orig/arch/mips/vr41xx/common/vrc4171.c	Thu Feb  3 10:55:35 2005
+++ a/arch/mips/vr41xx/common/vrc4171.c	Thu Jan  1 09:00:00 1970
@@ -1,106 +0,0 @@
-/*
- *  vrc4171.c, NEC VRC4171 base driver.
- *
- *  Copyright (C) 2003  Yoichi Yuasa <yuasa@hh.iij4u.or.jp>
- *
- *  This program is free software; you can redistribute it and/or modify
- *  it under the terms of the GNU General Public License as published by
- *  the Free Software Foundation; either version 2 of the License, or
- *  (at your option) any later version.
- *
- *  This program is distributed in the hope that it will be useful,
- *  but WITHOUT ANY WARRANTY; without even the implied warranty of
- *  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
- *  GNU General Public License for more details.
- *
- *  You should have received a copy of the GNU General Public License
- *  along with this program; if not, write to the Free Software
- *  Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA  02111-1307  USA
- */
-#include <linux/init.h>
-#include <linux/ioport.h>
-#include <linux/module.h>
-#include <linux/types.h>
-
-#include <asm/io.h>
-#include <asm/vr41xx/vrc4171.h>
-
-MODULE_DESCRIPTION("NEC VRC4171 base driver");
-MODULE_AUTHOR("Yoichi Yuasa <yuasa@hh.iij4u.or.jp>");
-MODULE_LICENSE("GPL");
-
-EXPORT_SYMBOL_GPL(vrc4171_get_irq_status);
-EXPORT_SYMBOL_GPL(vrc4171_set_multifunction_pin);
-
-#define CONFIGURATION1		0x05fe
- #define SLOTB_CONFIG		0xc000
- #define SLOTB_NONE		0x0000
- #define SLOTB_PCCARD		0x4000
- #define SLOTB_CF		0x8000
- #define SLOTB_FLASHROM		0xc000
-
-#define CONFIGURATION2		0x05fc
-#define INTERRUPT_STATUS	0x05fa
-#define PCS_CONTROL		0x05ee
-#define GPIO_DATA		PCS_CONTROL
-#define PCS0_UPPER_START	0x05ec
-#define PCS0_LOWER_START	0x05ea
-#define PCS0_UPPER_STOP		0x05e8
-#define PCS0_LOWER_STOP		0x05e6
-#define PCS1_UPPER_START	0x05e4
-#define PCS1_LOWER_START	0x05e2
-#define PCS1_UPPER_STOP		0x05de
-#define PCS1_LOWER_STOP		0x05dc
-
-#define VRC4171_REGS_BASE	PCS1_LOWER_STOP
-#define VRC4171_REGS_SIZE	0x24
-
-uint16_t vrc4171_get_irq_status(void)
-{
-	return inw(INTERRUPT_STATUS);
-}
-
-void vrc4171_set_multifunction_pin(int config)
-{
-	uint16_t config1;
-
-	config1 = inw(CONFIGURATION1);
-	config1 &= ~SLOTB_CONFIG;
-
-	switch (config) {
-	case SLOTB_IS_NONE:
-		config1 |= SLOTB_NONE;
-		break;
-	case SLOTB_IS_PCCARD:
-		config1 |= SLOTB_PCCARD;
-		break;
-	case SLOTB_IS_CF:
-		config1 |= SLOTB_CF;
-		break;
-	case SLOTB_IS_FLASHROM:
-		config1 |= SLOTB_FLASHROM;
-		break;
-	default:
-		break;
-	}
-
-	outw(config1, CONFIGURATION1);
-}
-
-static int __devinit vrc4171_init(void)
-{
-	if (request_region(VRC4171_REGS_BASE, VRC4171_REGS_SIZE, "NEC VRC4171") == NULL)
-		return -EBUSY;
-
-	printk(KERN_INFO "NEC VRC4171 base driver\n");
-
-	return 0;
-}
-
-static void __devexit vrc4171_exit(void)
-{
-	release_region(VRC4171_REGS_BASE, VRC4171_REGS_SIZE);
-}
-
-module_init(vrc4171_init);
-module_exit(vrc4171_exit);
diff -urN -X dontdiff a-orig/drivers/pcmcia/vrc4171_card.c a/drivers/pcmcia/vrc4171_card.c
--- a-orig/drivers/pcmcia/vrc4171_card.c	Thu Feb  3 10:56:53 2005
+++ a/drivers/pcmcia/vrc4171_card.c	Mon Feb  7 23:11:27 2005
@@ -1,7 +1,7 @@
 /*
  * vrc4171_card.c, NEC VRC4171 Card Controller driver for Socket Services.
  *
- * Copyright (C) 2003  Yoichi Yuasa <yuasa@hh.iij4u.or.jp>
+ * Copyright (C) 2003-2005  Yoichi Yuasa <yuasa@hh.iij4u.or.jp>
  *
  *  This program is free software; you can redistribute it and/or modify
  *  it under the terms of the GNU General Public License as published by
@@ -26,7 +26,6 @@
 #include <linux/types.h>
 
 #include <asm/io.h>
-#include <asm/vr41xx/vrc4171.h>
 
 #include <pcmcia/ss.h>
 
@@ -48,7 +47,6 @@
 
 #define CARD_CONTROLLER_INDEX	0x03e0
 #define CARD_CONTROLLER_DATA	0x03e1
-#define CARD_CONTROLLER_SIZE	2
  /* Power register */
   #define VPP_GET_VCC		0x01
   #define POWER_ENABLE		0x10
@@ -69,18 +67,40 @@
   #define IRQPM_EN		0x08
   #define CLRPMIRQ		0x10
 
+#define INTERRUPT_STATUS	0x05fa
+ #define IRQ_A			0x02
+ #define IRQ_B			0x04
+
+#define CONFIGURATION1		0x05fe
+ #define SLOTB_CONFIG		0xc000
+ #define SLOTB_NONE		0x0000
+ #define SLOTB_PCCARD		0x4000
+ #define SLOTB_CF		0x8000
+ #define SLOTB_FLASHROM		0xc000
+
+#define CARD_CONTROLLER_START	CARD_CONTROLLER_INDEX
+#define CARD_CONTROLLER_END	CARD_CONTROLLER_DATA
+
 #define IO_MAX_MAPS	2
 #define MEM_MAX_MAPS	5
 
-enum {
+typedef enum {
 	SLOT_PROBE = 0,
 	SLOT_NOPROBE_IO,
 	SLOT_NOPROBE_MEM,
-	SLOT_NOPROBE_ALL
-};
+	SLOT_NOPROBE_ALL,
+	SLOT_INITIALIZED,
+} vrc4171_slot_t;
+
+typedef enum {
+	SLOTB_IS_NONE,
+	SLOTB_IS_PCCARD,
+	SLOTB_IS_CF,
+	SLOTB_IS_FLASHROM,
+} vrc4171_slotb_t;
 
 typedef struct vrc4171_socket {
-	int noprobe;
+	vrc4171_slot_t slot;
 	struct pcmcia_socket pcmcia_socket;
 	char name[24];
 	int csc_irq;
@@ -88,10 +108,65 @@
 } vrc4171_socket_t;
 
 static vrc4171_socket_t vrc4171_sockets[CARD_MAX_SLOTS];
-static int vrc4171_slotb = SLOTB_IS_NONE;
+static vrc4171_slotb_t vrc4171_slotb = SLOTB_IS_NONE;
+static char vrc4171_card_name[] = "NEC VRC4171 Card Controller";
 static unsigned int vrc4171_irq;
 static uint16_t vrc4171_irq_mask = 0xdeb8;
 
+static struct resource vrc4171_card_resource[3] = {
+	{	.name		= vrc4171_card_name,
+		.start		= CARD_CONTROLLER_START,
+		.end		= CARD_CONTROLLER_END,
+		.flags		= IORESOURCE_IO,	},
+	{	.name		= vrc4171_card_name,
+		.start		= INTERRUPT_STATUS,
+		.end		= INTERRUPT_STATUS,
+		.flags		= IORESOURCE_IO,	},
+	{	.name		= vrc4171_card_name,
+		.start		= CONFIGURATION1,
+		.end		= CONFIGURATION1,
+		.flags		= IORESOURCE_IO,	},
+};
+
+static struct platform_device vrc4171_card_device = {
+	.name		= vrc4171_card_name,
+	.id		= 0,
+	.num_resources	= 3,
+	.resource	= vrc4171_card_resource,
+};
+
+static inline uint16_t vrc4171_get_irq_status(void)
+{
+	return inw(INTERRUPT_STATUS);
+}
+
+static inline void vrc4171_set_multifunction_pin(vrc4171_slotb_t config)
+{
+	uint16_t config1;
+
+	config1 = inw(CONFIGURATION1);
+	config1 &= ~SLOTB_CONFIG;
+
+	switch (config) {
+	case SLOTB_IS_NONE:
+		config1 |= SLOTB_NONE;
+		break;
+	case SLOTB_IS_PCCARD:
+		config1 |= SLOTB_PCCARD;
+		break;
+	case SLOTB_IS_CF:
+		config1 |= SLOTB_CF;
+		break;
+	case SLOTB_IS_FLASHROM:
+		config1 |= SLOTB_FLASHROM;
+		break;
+	default:
+		break;
+	}
+
+	outw(config1, CONFIGURATION1);
+}
+
 static inline uint8_t exca_read_byte(int slot, uint8_t index)
 {
 	if (slot == CARD_SLOTB)
@@ -286,9 +361,9 @@
 		if (cscint & I365_CSC_STSCHG)
 			state->flags |= SS_STSCHG;
 	} else {
-		if (cscint & I365_CSC_BVD1)
+		if (cscint & I365_CSC_BVD1)  
 			state->csc_mask |= SS_BATDEAD;
-		if (cscint & I365_CSC_BVD2)
+		if (cscint & I365_CSC_BVD2)  
 			state->csc_mask |= SS_BATWARN;
 	}
 	if (cscint & I365_CSC_READY)
@@ -425,9 +500,9 @@
 
 	if (sock == NULL || sock->sock >= CARD_MAX_SLOTS ||
 	    mem == NULL || mem->map >= MEM_MAX_MAPS ||
-	    mem->sys_start < CARD_MEM_START || mem->sys_start > CARD_MEM_END ||
-	    mem->sys_stop < CARD_MEM_START || mem->sys_stop > CARD_MEM_END ||
-	    mem->sys_start > mem->sys_stop ||
+	    mem->res->start < CARD_MEM_START || mem->res->start > CARD_MEM_END ||
+	    mem->res->end < CARD_MEM_START || mem->res->end > CARD_MEM_END ||
+	    mem->res->start > mem->res->end ||
 	    mem->card_start > CARD_MAX_MEM_OFFSET ||
 	    mem->speed > CARD_MAX_MEM_SPEED)
 		return -EINVAL;
@@ -441,12 +516,12 @@
 		exca_write_byte(slot, I365_ADDRWIN, addrwin);
 	}
 
-	start = (mem->sys_start >> 12) & 0x3fff;
+	start = (mem->res->start >> 12) & 0x3fff;
 	if (mem->flags & MAP_16BIT)
 		start |= I365_MEM_16BIT;
 	exca_write_word(slot, I365_MEM(map)+I365_W_START, start);
 
-	stop = (mem->sys_stop >> 12) & 0x3fff;
+	stop = (mem->res->end >> 12) & 0x3fff;
 	switch (mem->speed) {
 	case 0:
 		break;
@@ -524,7 +599,7 @@
 	status = vrc4171_get_irq_status();
 	if (status & IRQ_A) {
 		socket = &vrc4171_sockets[CARD_SLOTA];
-		if (socket->noprobe == SLOT_PROBE) {
+		if (socket->slot == SLOT_INITIALIZED) {
 			if (status & (1 << socket->csc_irq)) {
 				events = get_events(CARD_SLOTA);
 				if (events != 0) {
@@ -537,7 +612,7 @@
 
 	if (status & IRQ_B) {
 		socket = &vrc4171_sockets[CARD_SLOTB];
-		if (socket->noprobe == SLOT_PROBE) {
+		if (socket->slot == SLOT_INITIALIZED) {
 			if (status & (1 << socket->csc_irq)) {
 				events = get_events(CARD_SLOTB);
 				if (events != 0) {
@@ -564,63 +639,71 @@
 	vrc4171_irq_mask &= ~(1 << irq);
 }
 
-static int __devinit vrc4171_add_socket(int slot)
+static int __devinit vrc4171_add_sockets(void)
 {
 	vrc4171_socket_t *socket;
-	int retval;
+	int slot, retval;
 
-	if (slot >= CARD_MAX_SLOTS)
-		return -EINVAL;
+	for (slot = 0; slot < CARD_MAX_SLOTS; slot++) {
+		if (slot == CARD_SLOTB && vrc4171_slotb == SLOTB_IS_NONE)
+			continue;
 
-	socket = &vrc4171_sockets[slot];
-	if (socket->noprobe != SLOT_PROBE) {
-		uint8_t addrwin;
+		socket = &vrc4171_sockets[slot];
+		if (socket->slot != SLOT_PROBE) {
+			uint8_t addrwin;
+
+			switch (socket->slot) {
+			case SLOT_NOPROBE_MEM:
+				addrwin = exca_read_byte(slot, I365_ADDRWIN);
+				addrwin &= 0x1f;
+				exca_write_byte(slot, I365_ADDRWIN, addrwin);
+				break;
+			case SLOT_NOPROBE_IO:
+				addrwin = exca_read_byte(slot, I365_ADDRWIN);
+				addrwin &= 0xc0;
+				exca_write_byte(slot, I365_ADDRWIN, addrwin);
+				break;
+			default:
+				break;
+			}
 
-		switch (socket->noprobe) {
-		case SLOT_NOPROBE_MEM:
-			addrwin = exca_read_byte(slot, I365_ADDRWIN);
-			addrwin &= 0x1f;
-			exca_write_byte(slot, I365_ADDRWIN, addrwin);
-			break;
-		case SLOT_NOPROBE_IO:
-			addrwin = exca_read_byte(slot, I365_ADDRWIN);
-			addrwin &= 0xc0;
-			exca_write_byte(slot, I365_ADDRWIN, addrwin);
-			break;
-		default:
-			break;
+			reserve_using_irq(slot);
+			continue;
 		}
 
-		reserve_using_irq(slot);
-
-		return 0;
-	}
+		sprintf(socket->name, "NEC VRC4171 Card Slot %1c", 'A' + slot);
+		socket->pcmcia_socket.dev.dev = &vrc4171_card_device.dev;
+		socket->pcmcia_socket.ops = &vrc4171_pccard_operations;
+		socket->pcmcia_socket.owner = THIS_MODULE;
 
-	sprintf(socket->name, "NEC VRC4171 Card Slot %1c", 'A' + slot);
-
-	socket->pcmcia_socket.ops = &vrc4171_pccard_operations;
-
-	retval = pcmcia_register_socket(&socket->pcmcia_socket);
-	if (retval != 0)
-		return retval;
+		retval = pcmcia_register_socket(&socket->pcmcia_socket);
+		if (retval < 0)
+			return retval;
 
-	exca_write_byte(slot, I365_ADDRWIN, 0);
+		exca_write_byte(slot, I365_ADDRWIN, 0);
+		exca_write_byte(slot, GLOBAL_CONTROL, 0);
 
-	exca_write_byte(slot, GLOBAL_CONTROL, 0);
+		socket->slot = SLOT_INITIALIZED;
+	}
 
 	return 0;
 }
 
-static void vrc4171_remove_socket(int slot)
+static void vrc4171_remove_sockets(void)
 {
 	vrc4171_socket_t *socket;
+	int slot;
 
-	if (slot >= CARD_MAX_SLOTS)
-		return;
+	for (slot = 0; slot < CARD_MAX_SLOTS; slot++) {
+		if (slot == CARD_SLOTB && vrc4171_slotb == SLOTB_IS_NONE)
+			continue;
 
-	socket = &vrc4171_sockets[slot];
+		socket = &vrc4171_sockets[slot];
+		if (socket->slot == SLOT_INITIALIZED)
+			pcmcia_unregister_socket(&socket->pcmcia_socket);
 
-	pcmcia_unregister_socket(&socket->pcmcia_socket);
+		socket->slot = SLOT_PROBE;
+	}
 }
 
 static int __devinit vrc4171_card_setup(char *options)
@@ -644,13 +727,13 @@
 		options += 6;
 		if (*options != '\0') {
 			if (strncmp(options, "memnoprobe", 10) == 0) {
-				vrc4171_sockets[CARD_SLOTA].noprobe = SLOT_NOPROBE_MEM;
+				vrc4171_sockets[CARD_SLOTA].slot = SLOT_NOPROBE_MEM;
 				options += 10;
 			} else if (strncmp(options, "ionoprobe", 9) == 0) {
-				vrc4171_sockets[CARD_SLOTA].noprobe = SLOT_NOPROBE_IO;
+				vrc4171_sockets[CARD_SLOTA].slot = SLOT_NOPROBE_IO;
 				options += 9;
 			} else if ( strncmp(options, "noprobe", 7) == 0) {
-				vrc4171_sockets[CARD_SLOTA].noprobe = SLOT_NOPROBE_ALL;
+				vrc4171_sockets[CARD_SLOTA].slot = SLOT_NOPROBE_ALL;
 				options += 7;
 			}
 
@@ -684,11 +767,11 @@
 			options++;
 
 			if (strncmp(options, "memnoprobe", 10) == 0)
-				vrc4171_sockets[CARD_SLOTB].noprobe = SLOT_NOPROBE_MEM;
+				vrc4171_sockets[CARD_SLOTB].slot = SLOT_NOPROBE_MEM;
 			if (strncmp(options, "ionoprobe", 9) == 0)
-				vrc4171_sockets[CARD_SLOTB].noprobe = SLOT_NOPROBE_IO;
+				vrc4171_sockets[CARD_SLOTB].slot = SLOT_NOPROBE_IO;
 			if (strncmp(options, "noprobe", 7) == 0)
-				vrc4171_sockets[CARD_SLOTB].noprobe = SLOT_NOPROBE_ALL;
+				vrc4171_sockets[CARD_SLOTB].slot = SLOT_NOPROBE_ALL;
 		}
 	}
 
@@ -697,47 +780,72 @@
 
 __setup("vrc4171_card=", vrc4171_card_setup);
 
-static int __devinit vrc4171_card_init(void)
+static int vrc4171_card_suspend(struct device *dev, u32 state, u32 level)
 {
-	int retval, slot;
+	int retval = 0;
 
-	vrc4171_set_multifunction_pin(vrc4171_slotb);
+	if (level == SUSPEND_SAVE_STATE)
+		retval = pcmcia_socket_dev_suspend(dev, state);
+
+	return retval;
+}
 
-	if (request_region(CARD_CONTROLLER_INDEX, CARD_CONTROLLER_SIZE,
-	                       "NEC VRC4171 Card Controller") == NULL)
-		return -EBUSY;
+static int vrc4171_card_resume(struct device *dev, u32 level)
+{
+	int retval = 0;
 
-	for (slot = 0; slot < CARD_MAX_SLOTS; slot++) {
-		if (slot == CARD_SLOTB && vrc4171_slotb == SLOTB_IS_NONE)
-			break;
+	if (level == RESUME_RESTORE_STATE)
+		retval = pcmcia_socket_dev_resume(dev);
 
-		retval = vrc4171_add_socket(slot);
-		if (retval != 0)
-			return retval;
-	}
+	return retval;
+}
 
-	retval = request_irq(vrc4171_irq, pccard_interrupt, SA_SHIRQ,
-	                     "NEC VRC4171 Card Controller", vrc4171_sockets);
+static struct device_driver vrc4171_card_driver = {
+	.name		= vrc4171_card_name,
+	.bus		= &platform_bus_type,
+	.suspend	= vrc4171_card_suspend,
+	.resume		= vrc4171_card_resume,
+};
+
+static int __devinit vrc4171_card_init(void)
+{
+	int retval;
+
+	retval = driver_register(&vrc4171_card_driver);
+	if (retval < 0)
+		return retval;
+
+	retval = platform_device_register(&vrc4171_card_device);
 	if (retval < 0) {
-		for (slot = 0; slot < CARD_MAX_SLOTS; slot++)
-			vrc4171_remove_socket(slot);
+		driver_unregister(&vrc4171_card_driver);
+		return retval;
+	}
+
+	vrc4171_set_multifunction_pin(vrc4171_slotb);
+
+	retval = vrc4171_add_sockets();
+	if (retval == 0)
+		retval = request_irq(vrc4171_irq, pccard_interrupt, SA_SHIRQ,
+		                     vrc4171_card_name, vrc4171_sockets);
 
+	if (retval < 0) {
+		vrc4171_remove_sockets();
+		platform_device_unregister(&vrc4171_card_device);
+		driver_unregister(&vrc4171_card_driver);
 		return retval;
 	}
 
-	printk(KERN_INFO "NEC VRC4171 Card Controller, connected to IRQ %d\n", vrc4171_irq);
+	printk(KERN_INFO "%s, connected to IRQ %d\n", vrc4171_card_driver.name, vrc4171_irq);
 
 	return 0;
 }
 
 static void __devexit vrc4171_card_exit(void)
 {
-	int slot;
-
-	for (slot = 0; slot < CARD_MAX_SLOTS; slot++)
-		vrc4171_remove_socket(slot);
-
-	release_region(CARD_CONTROLLER_INDEX, CARD_CONTROLLER_SIZE);
+	free_irq(vrc4171_irq, vrc4171_sockets);
+	vrc4171_remove_sockets();
+	platform_device_unregister(&vrc4171_card_device);
+	driver_unregister(&vrc4171_card_driver);
 }
 
 module_init(vrc4171_card_init);
diff -urN -X dontdiff a-orig/include/asm-mips/vr41xx/vrc4171.h a/include/asm-mips/vr41xx/vrc4171.h
--- a-orig/include/asm-mips/vr41xx/vrc4171.h	Thu Feb  3 10:56:53 2005
+++ a/include/asm-mips/vr41xx/vrc4171.h	Thu Jan  1 09:00:00 1970
@@ -1,43 +0,0 @@
-/*
- *  vrc4171.h, Include file for NEC VRC4171.
- *
- *  Copyright (C) 2003  Yoichi Yuasa <yuasa@hh.iij4u.or.jp>
- *
- *  This program is free software; you can redistribute it and/or modify
- *  it under the terms of the GNU General Public License as published by
- *  the Free Software Foundation; either version 2 of the License, or
- *  (at your option) any later version.
- *
- *  This program is distributed in the hope that it will be useful,
- *  but WITHOUT ANY WARRANTY; without even the implied warranty of
- *  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
- *  GNU General Public License for more details.
- *
- *  You should have received a copy of the GNU General Public License
- *  along with this program; if not, write to the Free Software
- *  Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA  02111-1307  USA
- */
-#ifndef __NEC_VRC4171_H 
-#define __NEC_VRC4171_H 
-
-/*
- * Configuration 1
- */
-enum {
-	SLOTB_IS_NONE,       
-	SLOTB_IS_PCCARD,
-	SLOTB_IS_CF,
-	SLOTB_IS_FLASHROM
-};
-
-extern void vrc4171_set_multifunction_pin(int config);
-
-/*
- * Interrupt Status Mask
- */
-#define IRQ_A	0x02
-#define IRQ_B	0x04
-
-extern uint16_t vrc4171_get_irq_status(void);
-
-#endif /* __NEC_VRC4171_H */
