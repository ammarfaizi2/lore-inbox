Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264450AbTLVRVS (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 22 Dec 2003 12:21:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264451AbTLVRVS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 22 Dec 2003 12:21:18 -0500
Received: from caramon.arm.linux.org.uk ([212.18.232.186]:24585 "EHLO
	caramon.arm.linux.org.uk") by vger.kernel.org with ESMTP
	id S264450AbTLVRVF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 22 Dec 2003 12:21:05 -0500
Date: Mon, 22 Dec 2003 17:21:02 +0000
From: Russell King <rmk+lkml@arm.linux.org.uk>
To: Linux Kernel List <linux-kernel@vger.kernel.org>
Subject: [PATCH] PCMCIA updates
Message-ID: <20031222172102.G18991@flint.arm.linux.org.uk>
Mail-Followup-To: Linux Kernel List <linux-kernel@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Here's a patch covering a forward-port of a couple of changes from
David Hinds to 2.6.  I've tested them, and the ISA/PCI irq fix has
been independently tested.

I'm also sending this to Linus/akpm shortly.

| [PCMCIA] fix ISA/PCI interrupt allocation
| 
| Patch from David Hinds
| 
| This is a forward port of a patch for 2.4.  This changes interrupt
| allocation for 16-bit cards so that if ISA interrupts are all in
| use, the bridge's PCI interrupt will be used.
|
| [PCMCIA] fix half/full duplex selection for pcnet_cs driver
| 
| Patch from David Hinds.
| 
| Another forward port from 2.4; this fixes full/half duplex selection
| for certain DL10019 based cards.


diff -Nru a/drivers/net/pcmcia/pcnet_cs.c b/drivers/net/pcmcia/pcnet_cs.c
--- a/drivers/net/pcmcia/pcnet_cs.c	Mon Dec 22 17:16:34 2003
+++ b/drivers/net/pcmcia/pcnet_cs.c	Mon Dec 22 17:16:34 2003
@@ -11,7 +11,7 @@
 
     Copyright (C) 1999 David A. Hinds -- dahinds@users.sourceforge.net
 
-    pcnet_cs.c 1.149 2002/06/29 06:27:37
+    pcnet_cs.c 1.153 2003/11/09 18:53:09
     
     The network driver code is based on Donald Becker's NE2000 code:
 
@@ -74,7 +74,7 @@
 MODULE_PARM(pc_debug, "i");
 #define DEBUG(n, args...) if (pc_debug>(n)) printk(KERN_DEBUG args)
 static char *version =
-"pcnet_cs.c 1.149 2002/06/29 06:27:37 (David Hinds)";
+"pcnet_cs.c 1.153 2003/11/09 18:53:09 (David Hinds)";
 #else
 #define DEBUG(n, args...)
 #endif
@@ -871,13 +871,15 @@
 
     MII interface support for DL10019 and DL10022 based cards
 
-    On the DL10019, the MII IO direction bit is 0x10; on  the DL10022
+    On the DL10019, the MII IO direction bit is 0x10; on the DL10022
     it is 0x20.  Setting both bits seems to work on both card types.
 
 ======================================================================*/
 
 #define DLINK_GPIO		0x1c
 #define DLINK_DIAG		0x1d
+#define DLINK_EEPROM		0x1e
+
 #define MDIO_SHIFT_CLK		0x80
 #define MDIO_DATA_OUT		0x40
 #define MDIO_DIR_WRITE		0x30
@@ -940,6 +942,98 @@
     outb_p(0x00, addr);
 }
 
+/*======================================================================
+
+    EEPROM access routines for DL10019 and DL10022 based cards
+
+======================================================================*/
+
+#define EE_EEP		0x40
+#define EE_ASIC		0x10
+#define EE_CS		0x08
+#define EE_CK		0x04
+#define EE_DO		0x02
+#define EE_DI		0x01
+#define EE_ADOT		0x01	/* DataOut for ASIC */
+#define EE_READ_CMD	0x06	
+
+#define DL19FDUPLX	0x0400	/* DL10019 Full duplex mode */
+
+static int read_eeprom(ioaddr_t ioaddr, int location)
+{
+    int i, retval = 0;
+    ioaddr_t ee_addr = ioaddr + DLINK_EEPROM;
+    int read_cmd = location | (EE_READ_CMD << 8);
+
+    outb(0, ee_addr);
+    outb(EE_EEP|EE_CS, ee_addr);
+
+    /* Shift the read command bits out. */
+    for (i = 10; i >= 0; i--) {
+	short dataval = (read_cmd & (1 << i)) ? EE_DO : 0;
+	outb_p(EE_EEP|EE_CS|dataval, ee_addr);
+	outb_p(EE_EEP|EE_CS|dataval|EE_CK, ee_addr);
+    }
+    outb(EE_EEP|EE_CS, ee_addr);
+
+    for (i = 16; i > 0; i--) {
+	outb_p(EE_EEP|EE_CS | EE_CK, ee_addr);
+	retval = (retval << 1) | ((inb(ee_addr) & EE_DI) ? 1 : 0);
+	outb_p(EE_EEP|EE_CS, ee_addr);
+    }
+
+    /* Terminate the EEPROM access. */
+    outb(0, ee_addr);
+    return retval;
+}
+
+/*
+    The internal ASIC registers can be changed by EEPROM READ access
+    with EE_ASIC bit set.
+    In ASIC mode, EE_ADOT is used to output the data to the ASIC.
+*/ 
+
+static void write_asic(ioaddr_t ioaddr, int location, short asic_data)
+{
+	int i;
+	ioaddr_t ee_addr = ioaddr + DLINK_EEPROM;
+	short dataval;
+	int read_cmd = location | (EE_READ_CMD << 8);
+
+	asic_data |= read_eeprom(ioaddr, location);
+
+	outb(0, ee_addr);
+	outb(EE_ASIC|EE_CS|EE_DI, ee_addr);
+	
+	read_cmd = read_cmd >> 1;
+
+	/* Shift the read command bits out. */
+	for (i = 9; i >= 0; i--) {
+		dataval = (read_cmd & (1 << i)) ? EE_DO : 0;
+		outb_p(EE_ASIC|EE_CS|EE_DI|dataval, ee_addr);
+		outb_p(EE_ASIC|EE_CS|EE_DI|dataval|EE_CK, ee_addr);
+		outb_p(EE_ASIC|EE_CS|EE_DI|dataval, ee_addr);
+	}
+	// sync
+	outb(EE_ASIC|EE_CS, ee_addr);
+	outb(EE_ASIC|EE_CS|EE_CK, ee_addr);
+	outb(EE_ASIC|EE_CS, ee_addr);
+
+	for (i = 15; i >= 0; i--) {
+		dataval = (asic_data & (1 << i)) ? EE_ADOT : 0;
+		outb_p(EE_ASIC|EE_CS|dataval, ee_addr);
+		outb_p(EE_ASIC|EE_CS|dataval|EE_CK, ee_addr);
+		outb_p(EE_ASIC|EE_CS|dataval, ee_addr);
+	}
+
+	/* Terminate the ASIC access. */
+	outb(EE_ASIC|EE_DI, ee_addr);
+	outb(EE_ASIC|EE_DI| EE_CK, ee_addr);
+	outb(EE_ASIC|EE_DI, ee_addr);
+
+	outb(0, ee_addr);
+}
+
 /*====================================================================*/
 
 static void set_misc_reg(struct net_device *dev)
@@ -1154,6 +1248,9 @@
 	if (link && (info->flags & IS_DL10022)) {
 	    /* Disable collision detection on full duplex links */
 	    outb((p & 0x0140) ? 4 : 0, nic_base + DLINK_DIAG);
+	} else if (link && (info->flags & IS_DL10019)) {
+	    /* Disable collision detection on full duplex links */
+	    write_asic(dev->base_addr, 4, (p & 0x140) ? DL19FDUPLX : 0);
 	}
 	if (link) {
 	    if (info->phy_id == info->eth_phy) {
diff -Nru a/drivers/pcmcia/cs.c b/drivers/pcmcia/cs.c
--- a/drivers/pcmcia/cs.c	Mon Dec 22 17:16:34 2003
+++ b/drivers/pcmcia/cs.c	Mon Dec 22 17:16:34 2003
@@ -1916,7 +1916,7 @@
 {
     struct pcmcia_socket *s;
     config_t *c;
-    int ret = 0, irq = 0;
+    int ret = CS_IN_USE, irq = 0;
     
     if (CHECK_HANDLE(handle))
 	return CS_BAD_HANDLE;
@@ -1928,13 +1928,9 @@
 	return CS_CONFIGURATION_LOCKED;
     if (c->state & CONFIG_IRQ_REQ)
 	return CS_IN_USE;
-    
-    /* Short cut: if there are no ISA interrupts, then it is PCI */
-    if (!s->irq_mask) {
-	irq = s->pci_irq;
-	ret = (irq) ? 0 : CS_IN_USE;
+
 #ifdef CONFIG_PCMCIA_PROBE
-    } else if (s->irq.AssignedIRQ != 0) {
+    if (s->irq.AssignedIRQ != 0) {
 	/* If the interrupt is already assigned, it must match */
 	irq = s->irq.AssignedIRQ;
 	if (req->IRQInfo1 & IRQ_INFO2_VALID) {
@@ -1943,7 +1939,6 @@
 	} else
 	    ret = ((req->IRQInfo1&IRQ_MASK) == irq) ? 0 : CS_BAD_ARGS;
     } else {
-	ret = CS_IN_USE;
 	if (req->IRQInfo1 & IRQ_INFO2_VALID) {
 	    u_int try, mask = req->IRQInfo2 & s->irq_mask;
 	    for (try = 0; try < 2; try++) {
@@ -1958,12 +1953,13 @@
 	    irq = req->IRQInfo1 & IRQ_MASK;
 	    ret = try_irq(req->Attributes, irq, 1);
 	}
-#else
-    } else {
-	ret = CS_UNSUPPORTED_MODE;
+    }
 #endif
+    if (ret != 0) {
+	if (!s->pci_irq)
+	    return ret;
+	irq = s->pci_irq;
     }
-    if (ret != 0) return ret;
 
     if (req->Attributes & IRQ_HANDLE_PRESENT) {
 	if (request_irq(irq, req->Handler,

-- 
Russell King
 Linux kernel    2.6 ARM Linux   - http://www.arm.linux.org.uk/
 maintainer of:  2.6 PCMCIA      - http://pcmcia.arm.linux.org.uk/
                 2.6 Serial core
