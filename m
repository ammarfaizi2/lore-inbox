Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261759AbTDOQc4 (for <rfc822;willy@w.ods.org>); Tue, 15 Apr 2003 12:32:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261764AbTDOQc4 
	(for <rfc822;linux-kernel-outgoing>);
	Tue, 15 Apr 2003 12:32:56 -0400
Received: from 237.oncolt.com ([213.86.99.237]:33736 "EHLO
	passion.cambridge.redhat.com") by vger.kernel.org with ESMTP
	id S261759AbTDOQcr (for <rfc822;linux-kernel@vger.kernel.org>); Tue, 15 Apr 2003 12:32:47 -0400
Subject: [PATCH] i82092 PCI-PCMCIA bridge driver fixes
From: David Woodhouse <dwmw2@infradead.org>
To: marcelo@conectiva.com.br
Cc: arjanv@redhat.com, linux-kernel@vger.kernel.org
Content-Type: text/plain
Organization: 
Message-Id: <1050425071.32593.522.camel@passion.cambridge.redhat.com>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.2 (1.2.2-5.dwmw2) 
Date: Tue, 15 Apr 2003 17:44:32 +0100
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This device got very unhappy if it was put on a PCI bus with no ISA
bridge present and it didn't see any ISA transactions. Attached patch
makes it work with higher memory addresses and also makes it aware of
the I/O port restrictions that PCI busses may have in PeeCee-class
hardware.

Please apply.

===== drivers/pcmcia/i82092.c 1.4 vs edited =====
--- 1.4/drivers/pcmcia/i82092.c	Sun Sep 29 20:32:03 2002
+++ edited/drivers/pcmcia/i82092.c	Tue Apr 15 17:43:22 2003
@@ -1,12 +1,12 @@
 /* 
  * Driver for Intel I82092AA PCI-PCMCIA bridge.
  *
- * (C) 2001 Red Hat, Inc.
+ * (C) 2001-2003 Red Hat, Inc.
  *
- * Author: Arjan Van De Ven <arjanv@redhat.com>
- * Loosly based on i82365.c from the pcmcia-cs package
+ * Author: Arjan Van De Ven <arjanv@redhat.com> 
+ * Loosely based on i82365.c from the pcmcia-cs package
  *
- * $Id: i82092aa.c,v 1.2 2001/10/23 14:43:34 arjanv Exp $
+ * $Id: i82092.c,v 1.16 2003/04/15 16:36:42 dwmw2 Exp $
  */
 
 #include <linux/kernel.h>
@@ -26,6 +26,11 @@
 #include "i82365.h"
 
 MODULE_LICENSE("GPL");
+MODULE_AUTHOR("Red Hat, Inc. - Arjan Van De Ven <arjanv@redhat.com>");
+MODULE_DESCRIPTION("Socket driver for Intel i82092AA PCI-PCMCIA bridge");
+
+/* Extra i82092-specific register */
+#define I365_CPAGE 0x26
 
 /* PCI core routines */
 static struct pci_device_id i82092aa_pci_ids[] = {
@@ -73,9 +78,9 @@
 				    1 = empty socket, 
 				    2 = card but not initialized,
 				    3 = operational card */
-	int 	io_base; 	/* base io address of the socket */
+	unsigned long io_base; 	/* base io address of the socket */
 	socket_cap_t cap;
-	
+
 	unsigned int pending_events; /* Pending events on this interface */
 	
 	void	(*handler)(void *info, u_int events); 
@@ -87,19 +92,35 @@
 
 #define MAX_SOCKETS 4
 static struct socket_info sockets[MAX_SOCKETS];
-static int socket_count;  /* shortcut */                                  	                                	
+static int socket_count;  /* shortcut */
+
+int membase = -1;
+int isa_setup;
 
+MODULE_PARM(membase, "i");
+MODULE_PARM(isa_setup, "i");
 
 static int __init i82092aa_pci_probe(struct pci_dev *dev, const struct pci_device_id *id)
 {
 	unsigned char configbyte;
+	struct pci_dev *parent;
 	int i;
 	
 	enter("i82092aa_pci_probe");
 	
 	if (pci_enable_device(dev))
 		return -EIO;
-		
+
+	/* Since we have no memory BARs some firmware we may not
+	   have had PCI_COMMAND_MEM enabled, yet the device needs
+	   it. */
+	pci_read_config_byte(dev, PCI_COMMAND, &configbyte);
+	if (!(configbyte | PCI_COMMAND_MEMORY)) {
+		dprintk(KERN_DEBUG "Enabling PCI_COMMAND_MEMORY\n");
+		configbyte |= PCI_COMMAND_MEMORY;
+		pci_write_config_byte(dev, PCI_COMMAND, configbyte);
+	}
+
 	pci_read_config_byte(dev, 0x40, &configbyte);  /* PCI Configuration Control */
 	switch(configbyte&6) {
 		case 0:
@@ -122,6 +143,53 @@
 			break;
 	}
 	
+	if (membase == -1) {
+		for (i = 0; i < 4; i++) {
+			if ((dev->bus->resource[i]->flags & (IORESOURCE_MEM|IORESOURCE_READONLY|IORESOURCE_CACHEABLE|IORESOURCE_SHADOWABLE))
+			    == IORESOURCE_MEM) {
+				membase = dev->bus->resource[i]->start >> 24;
+				goto mem_ok;
+			}
+		}
+		printk(KERN_WARNING "No suitable memory range for i82092aa found\n");
+		return -ENOSPC;
+	}
+ mem_ok:
+	if (membase)
+		printk(KERN_NOTICE "i82092 memory base address set to 0x%02x000000\n", membase);
+
+	/* If we're down the end of the PCI bus chain where ISA cycles don't get sent, then
+	   only 1/4 of the I/O address space is going to be usable, unless we make sure that
+	   the NO_ISA bit in the Bridge Control register of all upstream busses is cleared.
+	   Since some PCMCIA cards (most serial ports, for example) will decode 10 bits and
+	   respond only to addresses where bits 8 and 9 are non-zero, we need to do this. */
+	for (parent = dev->bus->self; 
+	     parent && (parent->class>>8) == PCI_CLASS_BRIDGE_PCI;
+	     parent = parent->bus->self) {
+		uint16_t brctl;
+
+		if (pci_read_config_word(parent, PCI_BRIDGE_CONTROL, &brctl)) {
+			printk(KERN_WARNING "Error reading bridge control word from device %s\n", parent->slot_name);
+			continue;
+		}
+
+		if (!(brctl & PCI_BRIDGE_CTL_NO_ISA))
+			continue;
+
+		if (isa_setup) {
+			printk(KERN_NOTICE "PCI bridge %s has NOISA bit set. Clearing to allow full PCMCIA operation\n",
+			       parent->slot_name);
+			brctl &= ~PCI_BRIDGE_CTL_NO_ISA;
+			if (pci_write_config_word(parent, PCI_BRIDGE_CONTROL, brctl))
+				printk(KERN_WARNING "Error writing bridge control word from device %s\n", parent->slot_name);
+		} else {
+			printk(KERN_NOTICE "PCI bridge %s has NOISA bit set. Some I/O addresses for PCMCIA cards will not work.\n",
+			       parent->slot_name);
+			printk(KERN_NOTICE "Perhaps use 'isa_setup=1' option to i82092.o?\n");
+			break;
+		}
+	}			
+				
 	for (i = 0;i<socket_count;i++) {
 		sockets[i].card_state = 1; /* 1 = present but empty */
 		sockets[i].io_base = (dev->resource[0].start & ~1);
@@ -129,10 +197,13 @@
 		 	request_region(sockets[i].io_base, 2, "i82092aa");
 		 
 		
-		sockets[i].cap.features |= SS_CAP_PCCARD;
+		sockets[i].cap.features |= SS_CAP_PCCARD | SS_CAP_PAGE_REGS;
 		sockets[i].cap.map_size = 0x1000;
 		sockets[i].cap.irq_mask = 0;
 		sockets[i].cap.pci_irq  = dev->irq;
+
+		/* Trick the resource code into doing the right thing... */
+		sockets[i].cap.cb_dev = dev;
 		
 		if (card_present(i)) {
 			sockets[i].card_state = 3;
@@ -177,7 +248,7 @@
 
 static unsigned char indirect_read(int socket, unsigned short reg)
 {
-	unsigned short int port;
+	unsigned long port;
 	unsigned char val;
 	unsigned long flags;
 	spin_lock_irqsave(&port_lock,flags);
@@ -191,7 +262,7 @@
 
 static unsigned short indirect_read16(int socket, unsigned short reg)
 {
-	unsigned short int port;
+	unsigned long port;
 	unsigned short tmp;
 	unsigned long flags;
 	spin_lock_irqsave(&port_lock,flags);
@@ -208,7 +279,7 @@
 
 static void indirect_write(int socket, unsigned short reg, unsigned char value)
 {
-	unsigned short int port;
+	unsigned long port;
 	unsigned long flags;
 	spin_lock_irqsave(&port_lock,flags);
 	reg = reg + socket * 0x40;
@@ -220,7 +291,7 @@
 
 static void indirect_setbit(int socket, unsigned short reg, unsigned char mask)
 {
-	unsigned short int port;
+	unsigned long port;
 	unsigned char val;
 	unsigned long flags;
 	spin_lock_irqsave(&port_lock,flags);
@@ -237,7 +308,7 @@
 
 static void indirect_resetbit(int socket, unsigned short reg, unsigned char mask)
 {
-	unsigned short int port;
+	unsigned long port;
 	unsigned char val;
 	unsigned long flags;
 	spin_lock_irqsave(&port_lock,flags);
@@ -253,7 +324,7 @@
 
 static void indirect_write16(int socket, unsigned short reg, unsigned short value)
 {
-	unsigned short int port;
+	unsigned long port;
 	unsigned char val;
 	unsigned long flags;
 	spin_lock_irqsave(&port_lock,flags);
@@ -299,7 +370,7 @@
                 
         for (i=0; i < socket_count; i++) {
         	events = xchg(&(sockets[i].pending_events),0);
-        	printk("events = %x \n",events);
+        	dprintk("events = %x \n",events);
                 if (sockets[i].handler)
                 	sockets[i].handler(sockets[i].info, events);
 	}
@@ -343,7 +414,7 @@
 			 
 			if (csc & I365_CSC_DETECT) {
 				events |= SS_DETECT;
-				printk("Card detected in socket %i!\n",i);
+				dprintk("Card detected in socket %i!\n",i);
 			 }
 			
 			if (indirect_read(i,I365_INTCTL) & I365_PC_IOCARD) { 
@@ -419,7 +490,6 @@
         
         enter("i82092aa_init");
                         
-        mem.sys_stop = 0x0fff;
         i82092aa_set_socket(s, &dead_socket);
         for (i = 0; i < 2; i++) {
         	io.map = i;
@@ -604,11 +674,11 @@
 	reg = I365_PWR_NORESET; /* default: disable resetdrv on resume */
 	
 	if (state->flags & SS_PWR_AUTO) {
-		printk("Auto power\n");
+		dprintk("Auto power\n");
 		reg |= I365_PWR_AUTO;	/* automatic power mngmnt */
 	}
 	if (state->flags & SS_OUTPUT_ENA) {
-		printk("Power Enabled \n");
+		dprintk("Power Enabled \n");
 		reg |= I365_PWR_OUT;	/* enable power */
 	}
 	
@@ -616,11 +686,11 @@
 		case 0:	
 			break;
 		case 50: 
-			printk("setting voltage to Vcc to 5V on socket %i\n",sock);
+			dprintk("setting voltage to Vcc to 5V on socket %i\n",sock);
 			reg |= I365_VCC_5V;
 			break;
 		default:
-			printk("i82092aa: i82092aa_set_socket called with invalid VCC power value: %i ", state->Vcc);
+			printk(KERN_WARNING "i82092aa: i82092aa_set_socket called with invalid VCC power value: %i ", state->Vcc);
 			leave("i82092aa_set_socket");
 			return -EINVAL;
 	}
@@ -628,18 +698,18 @@
 	
 	switch (state->Vpp) {
 		case 0:	
-			printk("not setting Vpp on socket %i\n",sock);
+			dprintk("not setting Vpp on socket %i\n",sock);
 			break;
 		case 50: 
-			printk("setting Vpp to 5.0 for socket %i\n",sock);
+			dprintk("setting Vpp to 5.0 for socket %i\n",sock);
 			reg |= I365_VPP1_5V | I365_VPP2_5V;
 			break;
 		case 120: 
-			printk("setting Vpp to 12.0\n");
+			dprintk("setting Vpp to 12.0\n");
 			reg |= I365_VPP1_12V | I365_VPP2_12V;
 			break;
 		default:
-			printk("i82092aa: i82092aa_set_socket called with invalid VPP power value: %i ", state->Vcc);
+			printk(KERN_WARNING "i82092aa: i82092aa_set_socket called with invalid VPP power value: %i ", state->Vcc);
 			leave("i82092aa_set_socket");
 			return -EINVAL;
 	}
@@ -797,7 +867,7 @@
 	mem->card_start = ( (unsigned long)(i & 0x3fff)<12) + mem->sys_start;
 	mem->card_start &=  0x3ffffff;
 	
-	printk("Card %i is from %lx to %lx \n",sock,mem->sys_start,mem->sys_stop);
+	dprintk("Card %i is from %lx to %lx \n",sock,mem->sys_start,mem->sys_stop);
 	
 	leave("i82092aa_get_mem_map");
 	return 0;
@@ -808,7 +878,7 @@
 {
 	unsigned short base, i;
 	unsigned char map;
-	
+
 	enter("i82092aa_set_mem_map");
 	
 	map = mem->map;
@@ -817,17 +887,22 @@
 		return -EINVAL;
 	}
 	
+	/* Turn off the window before changing anything */
+	if (indirect_read(sock, I365_ADDRWIN) & I365_ENA_MEM(map))
+	              indirect_resetbit(sock, I365_ADDRWIN, I365_ENA_MEM(map));
+
 	
+	if (!(mem->flags & MAP_ACTIVE))
+		return 0;
+
 	if ( (mem->card_start > 0x3ffffff) || (mem->sys_start > mem->sys_stop) ||
+	     ((mem->sys_start >> 24) != membase) || ((mem->sys_stop >> 24) != membase) ||
 	     (mem->speed > 1000) ) {
 		leave("i82092aa_set_mem_map: invalid address / speed");
-		printk("invalid mem map for socket %i : %lx to %lx with a start of %x \n",sock,mem->sys_start, mem->sys_stop, mem->card_start);
+		printk(KERN_WARNING "invalid mem map for socket %i : %lx to %lx with a start of %x \n",sock,mem->sys_start, mem->sys_stop, mem->card_start);
 		return -EINVAL;
 	}
 	
-	/* Turn off the window before changing anything */
-	if (indirect_read(sock, I365_ADDRWIN) & I365_ENA_MEM(map))
-	              indirect_resetbit(sock, I365_ADDRWIN, I365_ENA_MEM(map));
 	                 
 	                 
 /* 	printk("set_mem_map: Setting map %i range to %x - %x on socket %i, speed is %i, active = %i \n",map, mem->sys_start,mem->sys_stop,sock,mem->speed,mem->flags & MAP_ACTIVE);  */
@@ -862,7 +937,7 @@
 	
 	/* card start */
 	
-	i = ((mem->card_start - mem->sys_start) >> 12) & 0x3fff;
+	i = (((mem->card_start - mem->sys_start) >> 12) - (membase << 12)) & 0x3fff;
 	if (mem->flags & MAP_WRPROT)
 		i |= I365_MEM_WRPROT;
 	if (mem->flags & MAP_ATTRIB) {
@@ -872,10 +947,10 @@
 /*		printk("requesting normal memory for socket %i\n",sock);*/
 	}
 	indirect_write16(sock,base+I365_W_OFF,i);
-	
+	indirect_write(sock, I365_CPAGE, membase);
+
 	/* Enable the window if necessary */
-	if (mem->flags & MAP_ACTIVE)
-		indirect_setbit(sock, I365_ADDRWIN, I365_ENA_MEM(map));
+	indirect_setbit(sock, I365_ADDRWIN, I365_ENA_MEM(map));
 	            
 	leave("i82092aa_set_mem_map");
 	return 0;




-- 
dwmw2

