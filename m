Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S268063AbTCFNTP>; Thu, 6 Mar 2003 08:19:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S268061AbTCFNTP>; Thu, 6 Mar 2003 08:19:15 -0500
Received: from caramon.arm.linux.org.uk ([212.18.232.186]:25101 "EHLO
	caramon.arm.linux.org.uk") by vger.kernel.org with ESMTP
	id <S268063AbTCFNSj>; Thu, 6 Mar 2003 08:18:39 -0500
Date: Thu, 6 Mar 2003 13:29:04 +0000
From: Russell King <rmk@arm.linux.org.uk>
To: CaT <cat@zip.com.au>
Cc: dahinds@users.sourceforge.net, linux-kernel@vger.kernel.org
Subject: Re: 2.5.64 - xircom realport no workie well
Message-ID: <20030306132904.A838@flint.arm.linux.org.uk>
Mail-Followup-To: CaT <cat@zip.com.au>, dahinds@users.sourceforge.net,
	linux-kernel@vger.kernel.org
References: <20030306130340.GA453@zip.com.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <20030306130340.GA453@zip.com.au>; from cat@zip.com.au on Fri, Mar 07, 2003 at 12:03:40AM +1100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Mar 07, 2003 at 12:03:40AM +1100, CaT wrote:
> With the 2.5.x series of kernels I've lost serial port functionality of
> my xircom pcmcia card and the network port, whilst working, does give
> errors on eject. The dmesg from an insert/eject sequence is:
> 
> cs: cb_alloc(bus 2): vendor 0x115d, device 0x0003
> PCI: Enabling device 02:00.0 (0000 -> 0003)
> PCI: Setting latency timer of device 02:00.0 to 64
> eth1: Xircom cardbus revision 3 at irq 10 
> PCI: Enabling device 02:00.1 (0000 -> 0003)
> ttyS15 at I/O 0x1880 (irq = 10) is a 16550A

Ok, we found the modem.

> Trying to free nonexistent resource <00001880-00001887>

I've been working in the 8250_pci area recently, and already found that.

Can you check whether the attached patch fixes this for you?  It's more
a cleanup of 8250_pci.c than anything else - I'll split it up when I
send it towards Linus though.

> When accessing the serial port (ttyS15) all I get is:
> 
> 13 [23:58:06] root@theirongiant:/usr/src/linux>> cat /dev/ttyS15
> cat: /dev/ttyS15: Input/output error

Argh, this is probably a side effect of the way IRQ sharing now works.
Thanks for this report - it should also be fixed by this patch.  We
weren't explicitly allowing PCI-based ports to share IRQs with anything
else.

--- orig/drivers/serial/8250_pci.c	Tue Feb 25 10:57:53 2003
+++ linux/drivers/serial/8250_pci.c	Thu Mar  6 13:27:35 2003
@@ -20,8 +20,10 @@
 #include <linux/string.h>
 #include <linux/kernel.h>
 #include <linux/slab.h>
+#include <linux/tty.h>
 #include <linux/serial.h>
 #include <linux/serialP.h>
+#include <linux/serial_core.h>
 
 #include <asm/bitops.h>
 #include <asm/byteorder.h>
@@ -30,174 +32,181 @@
 
 #include "8250.h"
 
-
-#ifndef IS_PCI_REGION_IOPORT
-#define IS_PCI_REGION_IOPORT(dev, r) (pci_resource_flags((dev), (r)) & \
-				      IORESOURCE_IO)
-#endif
-#ifndef IS_PCI_REGION_IOMEM
-#define IS_PCI_REGION_IOMEM(dev, r) (pci_resource_flags((dev), (r)) & \
-				      IORESOURCE_MEM)
-#endif
-#ifndef PCI_IRQ_RESOURCE
-#define PCI_IRQ_RESOURCE(dev, r) ((dev)->irq_resource[r].start)
-#endif
-
-#ifndef pci_get_subvendor
-#define pci_get_subvendor(dev) ((dev)->subsystem_vendor)
-#define pci_get_subdevice(dev)  ((dev)->subsystem_device)
-#endif
-
-struct serial_private {
-	unsigned int nr;
-	struct pci_board *board;
-	int line[0];
+struct pci_board {
+	unsigned int flags;
+	unsigned int num_ports;
+	unsigned int base_baud;
+	unsigned int uart_offset;
+	unsigned int reg_shift;
+	unsigned int first_offset;
 };
 
 /*
- * init_fn returns:
+ * init function returns:
  *  > 0 - number of ports
  *  = 0 - use board->num_ports
  *  < 0 - error
  */
-struct pci_board {
-	int flags;
-	int num_ports;
-	int base_baud;
-	int uart_offset;
-	int reg_shift;
-	int (*init_fn)(struct pci_dev *dev, int enable);
-	int first_uart_offset;
+struct pci_serial_quirk {
+	u32	vendor;
+	u32	device;
+	u32	subvendor;
+	u32	subdevice;
+	int	(*init)(struct pci_dev *dev);
+	int	(*setup)(struct pci_dev *dev, struct pci_board *board,
+			 struct serial_struct *req, int idx);
+	void	(*exit)(struct pci_dev *dev);
 };
 
-static int
-get_pci_port(struct pci_dev *dev, struct pci_board *board,
-	     struct serial_struct *req, int idx)
+#define PCI_NUM_BAR_RESOURCES	6
+
+struct serial_private {
+	unsigned int		nr;
+	void			*remapped_bar[PCI_NUM_BAR_RESOURCES];
+	struct pci_serial_quirk	*quirk;
+	int			line[0];
+};
+
+static void moan_device(const char *str, struct pci_dev *dev)
 {
-	unsigned long port;
-	int base_idx;
-	int max_port;
-	int offset;
+	printk(KERN_WARNING "%s: %s\n"
+	       KERN_WARNING "Please send the output of lspci -vv, this\n"
+	       KERN_WARNING "message (0x%04x,0x%04x,0x%04x,0x%04x), the\n"
+	       KERN_WARNING "manufacturer and name of serial board or\n"
+	       KERN_WARNING "modem board to rmk+serial@arm.linux.org.uk.\n",
+	       dev->slot_name, str, dev->vendor, dev->device,
+	       dev->subsystem_vendor, dev->subsystem_device);
+}
 
-	base_idx = SPCI_FL_GET_BASE(board->flags);
-	if (board->flags & SPCI_FL_BASE_TABLE)
-		base_idx += idx;
+static int
+setup_port(struct pci_dev *dev, struct serial_struct *req,
+	   int bar, int offset, int regshift)
+{
+	struct serial_private *priv = pci_get_drvdata(dev);
+	unsigned long port, len;
 
-	if (board->flags & SPCI_FL_REGION_SZ_CAP) {
-		max_port = pci_resource_len(dev, base_idx) / 8;
-		if (idx >= max_port)
-			return 1;
+	if (pci_resource_flags(dev, bar) & IORESOURCE_MEM) {
+		port = pci_resource_start(dev, bar);
+		len =  pci_resource_len(dev, bar);
+
+		if (!priv->remapped_bar[bar])
+			priv->remapped_bar[bar] = ioremap(port, len);
+		if (!priv->remapped_bar[bar])
+			return -ENOMEM;
+
+		req->io_type = UPIO_MEM;
+		req->iomap_base = port;
+		req->iomem_base = priv->remapped_bar[bar] + offset;
+		req->iomem_reg_shift = regshift;
+	} else {
+		port = pci_resource_start(dev, bar) + offset;
+		req->io_type = UPIO_PORT;
+		req->port = port;
+		if (HIGH_BITS_OFFSET)
+			req->port_high = port >> HIGH_BITS_OFFSET;
 	}
-			
-	offset = board->first_uart_offset;
+	return 0;
+}
 
-	/*
-	 * Timedia/SUNIX uses a mixture of BARs and offsets
-	 * Ugh, this is ugly as all hell --- TYT
-	 */
-	if (dev->vendor == PCI_VENDOR_ID_TIMEDIA)
-		switch(idx) {
-		case 0:
-			base_idx = 0;
-			break;
-		case 1:
-			base_idx = 0;
-			offset = 8;
-			break;
-		case 2:
-			base_idx = 1; 
-			break;
-		case 3:
-			base_idx = 1;
-			offset = 8;
-			break;
-		case 4: /* BAR 2 */
-		case 5: /* BAR 3 */
-		case 6: /* BAR 4 */
-		case 7: /* BAR 5 */
-			base_idx = idx - 2;
-		}
+/*
+ * AFAVLAB uses a different mixture of BARs and offsets
+ * Not that ugly ;) -- HW
+ */
+static int
+afavlab_setup(struct pci_dev *dev, struct pci_board *board,
+	      struct serial_struct *req, int idx)
+{
+	unsigned int bar, offset = board->first_offset;
+	
+	bar = SPCI_FL_GET_BASE(board->flags);
+	if (idx < 4)
+		bar += idx;
+	else
+		offset += (idx - 4) * board->uart_offset;
 
-	/* AFAVLAB uses a different mixture of BARs and offsets */
-	/* Not that ugly ;) -- HW */
-	if (dev->vendor == PCI_VENDOR_ID_AFAVLAB && idx >= 4) {
-		base_idx = 4;
-		offset = (idx - 4) * 8;
-	}
+	return setup_port(dev, req, bar, offset, board->reg_shift);
+}
 
-	/* Some Titan cards are also a little weird */
-	if (dev->vendor == PCI_VENDOR_ID_TITAN &&
-	    (dev->device == PCI_DEVICE_ID_TITAN_400L ||
-	     dev->device == PCI_DEVICE_ID_TITAN_800L)) {
-		switch (idx) {
-		case 0: base_idx = 1;
-			break;
-		case 1: base_idx = 2;
-			break;
-		default:
-			base_idx = 4;
-			offset = 8 * (idx - 2);
-		}
-	}
+/*
+ * HP's Remote Management Console.  The Diva chip came in several
+ * different versions.  N-class, L2000 and A500 have two Diva chips, each
+ * with 3 UARTs (the third UART on the second chip is unused).  Superdome
+ * and Keystone have one Diva chip with 3 UARTs.  Some later machines have
+ * one Diva chip, but it has been expanded to 5 UARTs.
+ */
+static int __devinit pci_hp_diva_init(struct pci_dev *dev)
+{
+	int rc = 0;
 
-	/* HP's Diva chip puts the 4th/5th serial port further out, and
-	 * some serial ports are supposed to be hidden on certain models.
-	 */
-	if (dev->vendor == PCI_VENDOR_ID_HP &&
-	    dev->device == PCI_DEVICE_ID_HP_DIVA) {
-		switch (dev->subsystem_device) {
-		case PCI_DEVICE_ID_HP_DIVA_MAESTRO:
-			if (idx == 3)
-				idx++;
-			break;
-		case PCI_DEVICE_ID_HP_DIVA_EVEREST:
-			if (idx > 0)
-				idx++;
-			if (idx > 2)
-				idx++;
-			break;
-		}
-		if (idx > 2) {
-			offset = 0x18;
-		}
+	switch (dev->subsystem_device) {
+	case PCI_DEVICE_ID_HP_DIVA_TOSCA1:
+	case PCI_DEVICE_ID_HP_DIVA_HALFDOME:
+	case PCI_DEVICE_ID_HP_DIVA_KEYSTONE:
+	case PCI_DEVICE_ID_HP_DIVA_EVEREST:
+		rc = 3;
+		break;
+	case PCI_DEVICE_ID_HP_DIVA_TOSCA2:
+		rc = 2;
+		break;
+	case PCI_DEVICE_ID_HP_DIVA_MAESTRO:
+		rc = 4;
+		break;
+	case PCI_DEVICE_ID_HP_DIVA_POWERBAR:
+		rc = 1;
+		break;
 	}
 
-	port =  pci_resource_start(dev, base_idx) + offset;
+	return rc;
+}
 
-	if ((board->flags & SPCI_FL_BASE_TABLE) == 0)
-		port += idx * (board->uart_offset ? board->uart_offset : 8);
+/*
+ * HP's Diva chip puts the 4th/5th serial port further out, and
+ * some serial ports are supposed to be hidden on certain models.
+ */
+static int
+pci_hp_diva_setup(struct pci_dev *dev, struct pci_board *board,
+	      struct serial_struct *req, int idx)
+{
+	unsigned int offset = board->first_offset;
+	unsigned int bar = SPCI_FL_GET_BASE(board->flags);
 
-	if (IS_PCI_REGION_IOPORT(dev, base_idx)) {
-		req->port = port;
-		if (HIGH_BITS_OFFSET)
-			req->port_high = port >> HIGH_BITS_OFFSET;
-		else
-			req->port_high = 0;
-		return 0;
+	switch (dev->subsystem_device) {
+	case PCI_DEVICE_ID_HP_DIVA_MAESTRO:
+		if (idx == 3)
+			idx++;
+		break;
+	case PCI_DEVICE_ID_HP_DIVA_EVEREST:
+		if (idx > 0)
+			idx++;
+		if (idx > 2)
+			idx++;
+		break;
 	}
-	req->io_type = SERIAL_IO_MEM;
-	req->iomap_base = port;
-	req->iomem_base = ioremap(port, board->uart_offset);
-	if (req->iomem_base == NULL)
-		return -ENOMEM;
-	req->iomem_reg_shift = board->reg_shift;
-	req->port = 0;
-	return 0;
+	if (idx > 2)
+		offset = 0x18;
+
+	offset += idx * board->uart_offset;
+
+	return setup_port(dev, req, bar, offset, board->reg_shift);
 }
 
-static _INLINE_ int
-get_pci_irq(struct pci_dev *dev, struct pci_board *board, int idx)
+/*
+ * Added for EKF Intel i960 serial boards
+ */
+static int __devinit pci_inteli960ni_init(struct pci_dev *dev)
 {
-	int base_idx;
+	unsigned long oldval;
 
-	if ((board->flags & SPCI_FL_IRQRESOURCE) == 0)
-		return dev->irq;
+	if (!(dev->subsystem_device & 0x1000))
+		return -ENODEV;
 
-	base_idx = SPCI_FL_GET_IRQBASE(board->flags);
-	if (board->flags & SPCI_FL_IRQ_TABLE)
-		base_idx += idx;
-	
-	return PCI_IRQ_RESOURCE(dev, base_idx);
+	/* is firmware started? */
+	pci_read_config_dword(dev, 0x44, (void*) &oldval); 
+	if (oldval == 0x00001000L) { /* RESET value */ 
+		printk(KERN_DEBUG "Local i960 firmware missing");
+		return -ENODEV;
+	}
+	return 0;
 }
 
 /*
@@ -206,26 +215,29 @@
  * seems to be mainly needed on card using the PLX which also use I/O
  * mapped memory.
  */
-static int __devinit pci_plx9050_fn(struct pci_dev *dev, int enable)
+static int __devinit pci_plx9050_init(struct pci_dev *dev)
 {
-	u8 *p, irq_config = 0;
+	u8 *p, irq_config;
 
-	if (enable) {
-		irq_config = 0x41;
-		if (dev->vendor == PCI_VENDOR_ID_PANACOM)
-			irq_config = 0x43;
-		if ((dev->vendor == PCI_VENDOR_ID_PLX) &&
-		    (dev->device == PCI_DEVICE_ID_PLX_ROMULUS)) {
-			/*
-			 * As the megawolf cards have the int pins active
-			 * high, and have 2 UART chips, both ints must be
-			 * enabled on the 9050. Also, the UARTS are set in
-			 * 16450 mode by default, so we have to enable the
-			 * 16C950 'enhanced' mode so that we can use the
-			 * deep FIFOs
-			 */
-			irq_config = 0x5b;
-		}
+	if ((pci_resource_flags(dev, 0) & IORESOURCE_MEM) == 0) {
+		moan_device("no memory in bar 0", dev);
+		return 0;
+	}
+
+	irq_config = 0x41;
+	if (dev->vendor == PCI_VENDOR_ID_PANACOM)
+		irq_config = 0x43;
+	if ((dev->vendor == PCI_VENDOR_ID_PLX) &&
+	    (dev->device == PCI_DEVICE_ID_PLX_ROMULUS)) {
+		/*
+		 * As the megawolf cards have the int pins active
+		 * high, and have 2 UART chips, both ints must be
+		 * enabled on the 9050. Also, the UARTS are set in
+		 * 16450 mode by default, so we have to enable the
+		 * 16C950 'enhanced' mode so that we can use the
+		 * deep FIFOs
+		 */
+		irq_config = 0x5b;
 	}
 
 	/*
@@ -245,6 +257,27 @@
 	return 0;
 }
 
+static void __devexit pci_plx9050_exit(struct pci_dev *dev)
+{
+	u8 *p;
+
+	if ((pci_resource_flags(dev, 0) & IORESOURCE_MEM) == 0)
+		return;
+
+	/*
+	 * disable interrupts
+	 */
+	p = ioremap(pci_resource_start(dev, 0), 0x80);
+	if (p != NULL) {
+		writel(0, p + 0x4c);
+
+		/*
+		 * Read the register back to ensure that it took effect.
+		 */
+		readl(p + 0x4c);
+		iounmap(p);
+	}
+}
 
 /*
  * SIIG serial cards have an PCI interface chip which also controls
@@ -270,23 +303,20 @@
 #define PCI_DEVICE_ID_SIIG_1S_10x (PCI_DEVICE_ID_SIIG_1S_10x_550 & 0xfffc)
 #define PCI_DEVICE_ID_SIIG_2S_10x (PCI_DEVICE_ID_SIIG_2S_10x_550 & 0xfff8)
 
-int pci_siig10x_fn(struct pci_dev *dev, int enable)
+static int pci_siig10x_init(struct pci_dev *dev)
 {
 	u16 data, *p;
 
-	if (!enable)
-		return 0;
-
 	switch (dev->device & 0xfff8) {
-		case PCI_DEVICE_ID_SIIG_1S_10x:	/* 1S */
-			data = 0xffdf;
-			break;
-		case PCI_DEVICE_ID_SIIG_2S_10x:	/* 2S, 2S1P */
-			data = 0xf7ff;
-			break;
-		default:			/* 1S1P, 4S */
-			data = 0xfffb;
-			break;
+	case PCI_DEVICE_ID_SIIG_1S_10x:	/* 1S */
+		data = 0xffdf;
+		break;
+	case PCI_DEVICE_ID_SIIG_2S_10x:	/* 2S, 2S1P */
+		data = 0xf7ff;
+		break;
+	default:			/* 1S1P, 4S */
+		data = 0xfffb;
+		break;
 	}
 
 	p = ioremap(pci_resource_start(dev, 0), 0x80);
@@ -294,22 +324,18 @@
 		return -ENOMEM;
 
 	writew(readw((unsigned long) p + 0x28) & data, (unsigned long) p + 0x28);
+	readw((unsigned long)p + 0x28);
 	iounmap(p);
 	return 0;
 }
 
-EXPORT_SYMBOL(pci_siig10x_fn);
-
 #define PCI_DEVICE_ID_SIIG_2S_20x (PCI_DEVICE_ID_SIIG_2S_20x_550 & 0xfffc)
 #define PCI_DEVICE_ID_SIIG_2S1P_20x (PCI_DEVICE_ID_SIIG_2S1P_20x_550 & 0xfffc)
 
-int pci_siig20x_fn(struct pci_dev *dev, int enable)
+static int pci_siig20x_init(struct pci_dev *dev)
 {
 	u8 data;
 
-	if (!enable)
-		return 0;
-
 	/* Change clock frequency for the first UART. */
 	pci_read_config_byte(dev, 0x6f, &data);
 	pci_write_config_byte(dev, 0x6f, data & 0xef);
@@ -323,28 +349,25 @@
 	return 0;
 }
 
-EXPORT_SYMBOL(pci_siig20x_fn);
-
-/* Added for EKF Intel i960 serial boards */
-static int __devinit pci_inteli960ni_fn(struct pci_dev *dev, int enable)
+int pci_siig10x_fn(struct pci_dev *dev, int enable)
 {
-	unsigned long oldval;
-
-	if (!(pci_get_subdevice(dev) & 0x1000))
-		return -ENODEV;
+	int ret = 0;
+	if (enable)
+		ret = pci_siig10x_init(dev);
+	return ret;
+}
 
-	if (!enable) /* is there something to deinit? */
-		return 0;
-   
-	/* is firmware started? */
-	pci_read_config_dword(dev, 0x44, (void*) &oldval); 
-	if (oldval == 0x00001000L) { /* RESET value */ 
-		printk(KERN_DEBUG "Local i960 firmware missing");
-		return -ENODEV;
-	}
-	return 0;
+int pci_siig20x_fn(struct pci_dev *dev, int enable)
+{
+	int ret = 0;
+	if (enable)
+		ret = pci_siig20x_init(dev);
+	return ret;
 }
 
+EXPORT_SYMBOL(pci_siig10x_fn);
+EXPORT_SYMBOL(pci_siig20x_fn);
+
 /*
  * Timedia has an explosion of boards, and to avoid the PCI table from
  * growing *huge*, we use this function to collapse some 70 entries
@@ -385,78 +408,450 @@
 	{ 0, 0 }
 };
 
-static int __devinit pci_timedia_fn(struct pci_dev *dev, int enable)
+static int __devinit pci_timedia_init(struct pci_dev *dev)
 {
-	int	i, j;
 	unsigned short *ids;
-
-	if (!enable)
-		return 0;
+	int i, j;
 
 	for (i = 0; timedia_data[i].num; i++) {
 		ids = timedia_data[i].ids;
 		for (j = 0; ids[j]; j++)
-			if (pci_get_subdevice(dev) == ids[j])
+			if (dev->subsystem_device == ids[j])
 				return timedia_data[i].num;
 	}
 	return 0;
 }
 
 /*
- * HP's Remote Management Console.  The Diva chip came in several
- * different versions.  N-class, L2000 and A500 have two Diva chips, each
- * with 3 UARTs (the third UART on the second chip is unused).  Superdome
- * and Keystone have one Diva chip with 3 UARTs.  Some later machines have
- * one Diva chip, but it has been expanded to 5 UARTs.
+ * Timedia/SUNIX uses a mixture of BARs and offsets
+ * Ugh, this is ugly as all hell --- TYT
  */
-static int __devinit pci_hp_diva(struct pci_dev *dev, int enable)
+static int
+pci_timedia_setup(struct pci_dev *dev, struct pci_board *board,
+		  struct serial_struct *req, int idx)
 {
-	int rc = 0;
-
-	if (!enable)
-		return 0;
+	unsigned int bar = 0, offset = board->first_offset;
 
-	switch (dev->subsystem_device) {
-	case PCI_DEVICE_ID_HP_DIVA_TOSCA1:
-	case PCI_DEVICE_ID_HP_DIVA_HALFDOME:
-	case PCI_DEVICE_ID_HP_DIVA_KEYSTONE:
-	case PCI_DEVICE_ID_HP_DIVA_EVEREST:
-		rc = 3;
+	switch (idx) {
+	case 0:
+		bar = 0;
 		break;
-	case PCI_DEVICE_ID_HP_DIVA_TOSCA2:
-		rc = 2;
+	case 1:
+		offset = board->uart_offset;
+		bar = 0;
 		break;
-	case PCI_DEVICE_ID_HP_DIVA_MAESTRO:
-		rc = 4;
-		break;
-	case PCI_DEVICE_ID_HP_DIVA_POWERBAR:
-		rc = 1;
+	case 2:
+		bar = 1;
 		break;
+	case 3:
+		offset = board->uart_offset;
+		bar = 1;
+	case 4: /* BAR 2 */
+	case 5: /* BAR 3 */
+	case 6: /* BAR 4 */
+	case 7: /* BAR 5 */
+		bar = idx - 2;
 	}
 
-	return rc;
+	return setup_port(dev, req, bar, offset, board->reg_shift);
 }
 
+/*
+ * Some Titan cards are also a little weird
+ */
+static int
+titan_400l_800l_setup(struct pci_dev *dev, struct pci_board *board,
+		      struct serial_struct *req, int idx)
+{
+	unsigned int bar, offset = board->first_offset;
+
+	switch (idx) {
+	case 0:
+		bar = 1;
+		break;
+	case 1:
+		bar = 2;
+		break;
+	default:
+		bar = 4;
+		offset = (idx - 2) * board->uart_offset;
+	}
+
+	return setup_port(dev, req, bar, offset, board->reg_shift);
+}
 
-static int __devinit pci_xircom_fn(struct pci_dev *dev, int enable)
+static int __devinit pci_xircom_init(struct pci_dev *dev)
 {
 	__set_current_state(TASK_UNINTERRUPTIBLE);
 	schedule_timeout(HZ/10);
 	return 0;
 }
 
+static int
+pci_default_setup(struct pci_dev *dev, struct pci_board *board,
+		  struct serial_struct *req, int idx)
+{
+	unsigned int bar, offset = board->first_offset;
+
+	bar = SPCI_FL_GET_BASE(board->flags);
+	if (board->flags & SPCI_FL_BASE_TABLE)
+		bar += idx;
+	else
+		offset += idx * board->uart_offset;
+
+	if (board->flags & SPCI_FL_REGION_SZ_CAP &&
+	    idx >= pci_resource_len(dev, bar) / 8)
+		return 1;
+			
+	return setup_port(dev, req, bar, offset, board->reg_shift);
+}
+
+/*
+ * Master list of serial port init/setup/exit quirks.
+ * This does not describe the general nature of the port.
+ * (ie, baud base, number and location of ports, etc)
+ *
+ * This list is ordered alphabetically by vendor then device.
+ * Specific entries must come before more generic entries.
+ */
+static struct pci_serial_quirk pci_serial_quirks[] = {
+	/*
+	 * AFAVLAB cards.
+	 *  It is not clear whether this applies to all products.
+	 */
+	{
+		.vendor		= PCI_VENDOR_ID_AFAVLAB,
+		.device		= PCI_ANY_ID,
+		.subvendor	= PCI_ANY_ID,
+		.subdevice	= PCI_ANY_ID,
+		.setup		= afavlab_setup,
+	},
+	/*
+	 * HP Diva
+	 */
+	{
+		.vendor		= PCI_VENDOR_ID_HP,
+		.device		= PCI_DEVICE_ID_HP_DIVA,
+		.subvendor	= PCI_ANY_ID,
+		.subdevice	= PCI_ANY_ID,
+		.init		= pci_hp_diva_init,
+		.setup		= pci_hp_diva_setup,
+	},
+	/*
+	 * Intel
+	 */
+	{
+		.vendor		= PCI_VENDOR_ID_INTEL,
+		.device		= PCI_DEVICE_ID_INTEL_80960_RP,
+		.subvendor	= 0xe4bf,
+		.subdevice	= PCI_ANY_ID,
+		.init		= pci_inteli960ni_init,
+		.setup		= pci_default_setup,
+	},
+	/*
+	 * Panacom
+	 */
+	{
+		.vendor		= PCI_VENDOR_ID_PANACOM,
+		.device		= PCI_DEVICE_ID_PANACOM_QUADMODEM,
+		.subvendor	= PCI_ANY_ID,
+		.subdevice	= PCI_ANY_ID,
+		.init		= pci_plx9050_init,
+		.setup		= pci_default_setup,
+		.exit		= __devexit_p(pci_plx9050_exit),
+	},		
+	{
+		.vendor		= PCI_VENDOR_ID_PANACOM,
+		.device		= PCI_DEVICE_ID_PANACOM_DUALMODEM,
+		.subvendor	= PCI_ANY_ID,
+		.subdevice	= PCI_ANY_ID,
+		.init		= pci_plx9050_init,
+		.setup		= pci_default_setup,
+		.exit		= __devexit_p(pci_plx9050_exit),
+	},
+	/*
+	 * PLX
+	 */
+	{
+		.vendor		= PCI_VENDOR_ID_PLX,
+		.device		= PCI_DEVICE_ID_PLX_9050,
+		.subvendor	= PCI_SUBVENDOR_ID_KEYSPAN,
+		.subdevice	= PCI_SUBDEVICE_ID_KEYSPAN_SX2,
+		.init		= pci_plx9050_init,
+		.setup		= pci_default_setup,
+		.exit		= __devexit_p(pci_plx9050_exit),
+	},
+	{
+		.vendor		= PCI_VENDOR_ID_PLX,
+		.device		= PCI_DEVICE_ID_PLX_ROMULUS,
+		.subvendor	= PCI_VENDOR_ID_PLX,
+		.subdevice	= PCI_DEVICE_ID_PLX_ROMULUS,
+		.init		= pci_plx9050_init,
+		.setup		= pci_default_setup,
+		.exit		= __devexit_p(pci_plx9050_exit),
+	},
+	/*
+	 * SIIG cards.
+	 *  It is not clear whether these could be collapsed.
+	 */
+	{
+		.vendor		= PCI_VENDOR_ID_SIIG,
+		.device		= PCI_DEVICE_ID_SIIG_1S_10x_550,
+		.subvendor	= PCI_ANY_ID,
+		.subdevice	= PCI_ANY_ID,
+		.init		= pci_siig10x_init,
+		.setup		= pci_default_setup,
+	},
+	{
+		.vendor		= PCI_VENDOR_ID_SIIG,
+		.device		= PCI_DEVICE_ID_SIIG_1S_10x_650,
+		.subvendor	= PCI_ANY_ID,
+		.subdevice	= PCI_ANY_ID,
+		.init		= pci_siig10x_init,
+		.setup		= pci_default_setup,
+	},
+	{
+		.vendor		= PCI_VENDOR_ID_SIIG,
+		.device		= PCI_DEVICE_ID_SIIG_1S_10x_850,
+		.subvendor	= PCI_ANY_ID,
+		.subdevice	= PCI_ANY_ID,
+		.init		= pci_siig10x_init,
+		.setup		= pci_default_setup,
+	},
+	{
+		.vendor		= PCI_VENDOR_ID_SIIG,
+		.device		= PCI_DEVICE_ID_SIIG_2S_10x_550,
+		.subvendor	= PCI_ANY_ID,
+		.subdevice	= PCI_ANY_ID,
+		.init		= pci_siig10x_init,
+		.setup		= pci_default_setup,
+	},
+	{
+		.vendor		= PCI_VENDOR_ID_SIIG,
+		.device		= PCI_DEVICE_ID_SIIG_2S_10x_650,
+		.subvendor	= PCI_ANY_ID,
+		.subdevice	= PCI_ANY_ID,
+		.init		= pci_siig10x_init,
+		.setup		= pci_default_setup,
+	},
+	{
+		.vendor		= PCI_VENDOR_ID_SIIG,
+		.device		= PCI_DEVICE_ID_SIIG_2S_10x_850,
+		.subvendor	= PCI_ANY_ID,
+		.subdevice	= PCI_ANY_ID,
+		.init		= pci_siig10x_init,
+		.setup		= pci_default_setup,
+	},
+	{
+		.vendor		= PCI_VENDOR_ID_SIIG,
+		.device		= PCI_DEVICE_ID_SIIG_4S_10x_550,
+		.subvendor	= PCI_ANY_ID,
+		.subdevice	= PCI_ANY_ID,
+		.init		= pci_siig10x_init,
+		.setup		= pci_default_setup,
+	},
+	{
+		.vendor		= PCI_VENDOR_ID_SIIG,
+		.device		= PCI_DEVICE_ID_SIIG_4S_10x_650,
+		.subvendor	= PCI_ANY_ID,
+		.subdevice	= PCI_ANY_ID,
+		.init		= pci_siig10x_init,
+		.setup		= pci_default_setup,
+	},
+	{
+		.vendor		= PCI_VENDOR_ID_SIIG,
+		.device		= PCI_DEVICE_ID_SIIG_4S_10x_850,
+		.subvendor	= PCI_ANY_ID,
+		.subdevice	= PCI_ANY_ID,
+		.init		= pci_siig10x_init,
+		.setup		= pci_default_setup,
+	},
+	{
+		.vendor		= PCI_VENDOR_ID_SIIG,
+		.device		= PCI_DEVICE_ID_SIIG_1S_20x_550,
+		.subvendor	= PCI_ANY_ID,
+		.subdevice	= PCI_ANY_ID,
+		.init		= pci_siig20x_init,
+		.setup		= pci_default_setup,
+	},
+	{
+		.vendor		= PCI_VENDOR_ID_SIIG,
+		.device		= PCI_DEVICE_ID_SIIG_1S_20x_650,
+		.subvendor	= PCI_ANY_ID,
+		.subdevice	= PCI_ANY_ID,
+		.init		= pci_siig20x_init,
+		.setup		= pci_default_setup,
+	},
+	{
+		.vendor		= PCI_VENDOR_ID_SIIG,
+		.device		= PCI_DEVICE_ID_SIIG_1S_20x_850,
+		.subvendor	= PCI_ANY_ID,
+		.subdevice	= PCI_ANY_ID,
+		.init		= pci_siig20x_init,
+		.setup		= pci_default_setup,
+	},
+	{
+		.vendor		= PCI_VENDOR_ID_SIIG,
+		.device		= PCI_DEVICE_ID_SIIG_2S_20x_550,
+		.subvendor	= PCI_ANY_ID,
+		.subdevice	= PCI_ANY_ID,
+		.init		= pci_siig20x_init,
+		.setup		= pci_default_setup,
+	},
+	{	.vendor		= PCI_VENDOR_ID_SIIG,
+		.device		= PCI_DEVICE_ID_SIIG_2S_20x_650,
+		.subvendor	= PCI_ANY_ID,
+		.subdevice	= PCI_ANY_ID,
+		.init		= pci_siig20x_init,
+		.setup		= pci_default_setup,
+	},
+	{
+		.vendor		= PCI_VENDOR_ID_SIIG,
+		.device		= PCI_DEVICE_ID_SIIG_2S_20x_850,
+		.subvendor	= PCI_ANY_ID,
+		.subdevice	= PCI_ANY_ID,
+		.init		= pci_siig20x_init,
+		.setup		= pci_default_setup,
+	},
+	{
+		.vendor		= PCI_VENDOR_ID_SIIG,
+		.device		= PCI_DEVICE_ID_SIIG_4S_20x_550,
+		.subvendor	= PCI_ANY_ID,
+		.subdevice	= PCI_ANY_ID,
+		.init		= pci_siig20x_init,
+		.setup		= pci_default_setup,
+	},
+	{
+		.vendor		= PCI_VENDOR_ID_SIIG,
+		.device		= PCI_DEVICE_ID_SIIG_4S_20x_650,
+		.subvendor	= PCI_ANY_ID,
+		.subdevice	= PCI_ANY_ID,
+		.init		= pci_siig20x_init,
+		.setup		= pci_default_setup,
+	},
+	{
+		.vendor		= PCI_VENDOR_ID_SIIG,
+		.device		= PCI_DEVICE_ID_SIIG_4S_20x_850,
+		.subvendor	= PCI_ANY_ID,
+		.subdevice	= PCI_ANY_ID,
+		.init		= pci_siig20x_init,
+		.setup		= pci_default_setup,
+	},
+	/*
+	 * Titan cards
+	 */
+	{
+		.vendor		= PCI_VENDOR_ID_TITAN,
+		.device		= PCI_DEVICE_ID_TITAN_400L,
+		.subvendor	= PCI_ANY_ID,
+		.subdevice	= PCI_ANY_ID,
+		.setup		= titan_400l_800l_setup,
+	},
+	{
+		.vendor		= PCI_VENDOR_ID_TITAN,
+		.device		= PCI_DEVICE_ID_TITAN_800L,
+		.subvendor	= PCI_ANY_ID,
+		.subdevice	= PCI_ANY_ID,
+		.setup		= titan_400l_800l_setup,
+	},
+	/*
+	 * Timedia cards
+	 */
+	{
+		.vendor		= PCI_VENDOR_ID_TIMEDIA,
+		.device		= PCI_DEVICE_ID_TIMEDIA_1889,
+		.subvendor	= PCI_VENDOR_ID_TIMEDIA,
+		.subdevice	= PCI_ANY_ID,
+		.init		= pci_timedia_init,
+		.setup		= pci_timedia_setup,
+	},
+	{
+		.vendor		= PCI_VENDOR_ID_TIMEDIA,
+		.device		= PCI_ANY_ID,
+		.subvendor	= PCI_ANY_ID,
+		.subdevice	= PCI_ANY_ID,
+		.setup		= pci_timedia_setup,
+	},
+	/*
+	 * Xircom cards
+	 */
+	{
+		.vendor		= PCI_VENDOR_ID_XIRCOM,
+		.device		= PCI_DEVICE_ID_XIRCOM_X3201_MDM,
+		.subvendor	= PCI_ANY_ID,
+		.subdevice	= PCI_ANY_ID,
+		.init		= pci_xircom_init,
+		.setup		= pci_default_setup,
+	},
+	/*
+	 * Default "match everything" terminator entry
+	 */
+	{
+		.vendor		= PCI_ANY_ID,
+		.device		= PCI_ANY_ID,
+		.subvendor	= PCI_ANY_ID,
+		.subdevice	= PCI_ANY_ID,
+		.setup		= pci_default_setup,
+	}
+};
+
+static inline int quirk_id_matches(u32 quirk_id, u32 dev_id)
+{
+	return quirk_id == PCI_ANY_ID || quirk_id == dev_id;
+}
+
+static struct pci_serial_quirk *find_quirk(struct pci_dev *dev)
+{
+	struct pci_serial_quirk *quirk;
+
+	for (quirk = pci_serial_quirks; ; quirk++)
+		if (quirk_id_matches(quirk->vendor, dev->vendor) &&
+		    quirk_id_matches(quirk->device, dev->device) &&
+		    quirk_id_matches(quirk->subvendor, dev->subsystem_vendor) &&
+		    quirk_id_matches(quirk->subdevice, dev->subsystem_device))
+		 	break;
+	return quirk;
+}
+
+static _INLINE_ int
+get_pci_irq(struct pci_dev *dev, struct pci_board *board, int idx)
+{
+	int base_idx;
+
+	if ((board->flags & SPCI_FL_IRQRESOURCE) == 0)
+		return dev->irq;
+
+	base_idx = SPCI_FL_GET_IRQBASE(board->flags);
+	if (board->flags & SPCI_FL_IRQ_TABLE)
+		base_idx += idx;
+	
+	return dev->irq_resource[base_idx].start;
+}
+
 /*
  * This is the configuration table for all of the PCI serial boards
  * which we support.  It is directly indexed by the pci_board_num_t enum
  * value, which is encoded in the pci_device_id PCI probe table's
  * driver_data member.
+ *
+ * The makeup of these names are:
+ *  pbn_bn{_bt}_n_baud
+ *
+ *  bn   = PCI BAR number
+ *  bt   = Index using PCI BARs
+ *  n    = number of serial ports
+ *  baud = baud rate
+ *
+ * Please note: in theory if n = 1, _bt infix should make no difference.
+ * ie, pbn_b0_1_115200 is the same as pbn_b0_bt_1_115200
  */
 enum pci_board_num_t {
-	pbn_b0_1_115200,
 	pbn_default = 0,
 
+	pbn_b0_1_115200,
 	pbn_b0_2_115200,
 	pbn_b0_4_115200,
+	pbn_b0_5_115200,
 
 	pbn_b0_1_921600,
 	pbn_b0_2_921600,
@@ -465,171 +860,465 @@
 	pbn_b0_bt_1_115200,
 	pbn_b0_bt_2_115200,
 	pbn_b0_bt_8_115200,
+
 	pbn_b0_bt_1_460800,
 	pbn_b0_bt_2_460800,
 
+	pbn_b0_bt_1_921600,
+	pbn_b0_bt_2_921600,
+	pbn_b0_bt_4_921600,
+	pbn_b0_bt_8_921600,
+
 	pbn_b1_1_115200,
 	pbn_b1_2_115200,
 	pbn_b1_4_115200,
 	pbn_b1_8_115200,
 
+	pbn_b1_1_921600,
 	pbn_b1_2_921600,
 	pbn_b1_4_921600,
 	pbn_b1_8_921600,
 
+	pbn_b1_bt_2_921600,
+
 	pbn_b1_2_1382400,
 	pbn_b1_4_1382400,
 	pbn_b1_8_1382400,
 
 	pbn_b2_1_115200,
 	pbn_b2_8_115200,
+
+	pbn_b2_1_460800,
 	pbn_b2_4_460800,
 	pbn_b2_8_460800,
 	pbn_b2_16_460800,
+
+	pbn_b2_1_921600,
 	pbn_b2_4_921600,
 	pbn_b2_8_921600,
 
 	pbn_b2_bt_1_115200,
 	pbn_b2_bt_2_115200,
 	pbn_b2_bt_4_115200,
+
 	pbn_b2_bt_2_921600,
+	pbn_b2_bt_4_921600,
+
+	pbn_b3_4_115200,
+	pbn_b3_8_115200,
 
+	/*
+	 * Board-specific versions.
+	 */
 	pbn_panacom,
 	pbn_panacom2,
 	pbn_panacom4,
 	pbn_plx_romulus,
 	pbn_oxsemi,
-	pbn_timedia,
 	pbn_intel_i960,
 	pbn_sgi_ioc3,
-	pbn_hp_diva,
 	pbn_nec_nile4,
-
-	pbn_dci_pccom4,
-	pbn_dci_pccom8,
-
-	pbn_xircom_combo,
-
-	pbn_siig10x_0,
-	pbn_siig10x_1,
-	pbn_siig10x_2,
-	pbn_siig10x_4,
-	pbn_siig20x_0,
-	pbn_siig20x_2,
-	pbn_siig20x_4,
-	
 	pbn_computone_4,
 	pbn_computone_6,
 	pbn_computone_8,
 };
 
 static struct pci_board pci_boards[] __devinitdata = {
+	[pbn_default] = {
+		.flags		= SPCI_FL_BASE0,
+		.num_ports	= 1,
+		.base_baud	= 115200,
+		.uart_offset	= 8,
+	},
+	[pbn_b0_1_115200] = {
+		.flags		= SPCI_FL_BASE0,
+		.num_ports	= 1,
+		.base_baud	= 115200,
+		.uart_offset	= 8,
+	},
+	[pbn_b0_2_115200] = {
+		.flags		= SPCI_FL_BASE0,
+		.num_ports	= 2,
+		.base_baud	= 115200,
+		.uart_offset	= 8,
+	},
+	[pbn_b0_4_115200] = {
+		.flags		= SPCI_FL_BASE0,
+		.num_ports	= 4,
+		.base_baud	= 115200,
+		.uart_offset	= 8,
+	},
+	[pbn_b0_5_115200] = {
+		.flags		= SPCI_FL_BASE0,
+		.num_ports	= 5,
+		.base_baud	= 115200,
+		.uart_offset	= 8,
+	},
+
+	[pbn_b0_1_921600] = {
+		.flags		= SPCI_FL_BASE0,
+		.num_ports	= 1,
+		.base_baud	= 921600,
+		.uart_offset	= 8,
+	},
+	[pbn_b0_2_921600] = {
+		.flags		= SPCI_FL_BASE0,
+		.num_ports	= 2,
+		.base_baud	= 921600,
+		.uart_offset	= 8,
+	},
+	[pbn_b0_4_921600] = {
+		.flags		= SPCI_FL_BASE0,
+		.num_ports	= 4,
+		.base_baud	= 921600,
+		.uart_offset	= 8,
+	},
+
+	[pbn_b0_bt_1_115200] = {
+		.flags		= SPCI_FL_BASE0|SPCI_FL_BASE_TABLE,
+		.num_ports	= 1,
+		.base_baud	= 115200,
+		.uart_offset	= 8,
+	},
+	[pbn_b0_bt_2_115200] = {
+		.flags		= SPCI_FL_BASE0|SPCI_FL_BASE_TABLE,
+		.num_ports	= 2,
+		.base_baud	= 115200,
+		.uart_offset	= 8,
+	},
+	[pbn_b0_bt_8_115200] = {
+		.flags		= SPCI_FL_BASE0|SPCI_FL_BASE_TABLE,
+		.num_ports	= 8,
+		.base_baud	= 115200,
+		.uart_offset	= 8,
+	},
+
+	[pbn_b0_bt_1_460800] = {
+		.flags		= SPCI_FL_BASE0|SPCI_FL_BASE_TABLE,
+		.num_ports	= 1,
+		.base_baud	= 460800,
+		.uart_offset	= 8,
+	},
+	[pbn_b0_bt_2_460800] = {
+		.flags		= SPCI_FL_BASE0|SPCI_FL_BASE_TABLE,
+		.num_ports	= 2,
+		.base_baud	= 460800,
+		.uart_offset	= 8,
+	},
+
+	[pbn_b0_bt_1_921600] = {
+		.flags		= SPCI_FL_BASE0|SPCI_FL_BASE_TABLE,
+		.num_ports	= 1,
+		.base_baud	= 921600,
+		.uart_offset	= 8,
+	},
+	[pbn_b0_bt_2_921600] = {
+		.flags		= SPCI_FL_BASE0|SPCI_FL_BASE_TABLE,
+		.num_ports	= 2,
+		.base_baud	= 921600,
+		.uart_offset	= 8,
+	},
+	[pbn_b0_bt_4_921600] = {
+		.flags		= SPCI_FL_BASE0|SPCI_FL_BASE_TABLE,
+		.num_ports	= 4,
+		.base_baud	= 921600,
+		.uart_offset	= 8,
+	},
+	[pbn_b0_bt_8_921600] = {
+		.flags		= SPCI_FL_BASE0|SPCI_FL_BASE_TABLE,
+		.num_ports	= 8,
+		.base_baud	= 921600,
+		.uart_offset	= 8,
+	},
+
+	[pbn_b1_1_115200] = {
+		.flags		= SPCI_FL_BASE1,
+		.num_ports	= 1,
+		.base_baud	= 115200,
+		.uart_offset	= 8,
+	},
+	[pbn_b1_2_115200] = {
+		.flags		= SPCI_FL_BASE1,
+		.num_ports	= 2,
+		.base_baud	= 115200,
+		.uart_offset	= 8,
+	},
+	[pbn_b1_4_115200] = {
+		.flags		= SPCI_FL_BASE1,
+		.num_ports	= 4,
+		.base_baud	= 115200,
+		.uart_offset	= 8,
+	},
+	[pbn_b1_8_115200] = {
+		.flags		= SPCI_FL_BASE1,
+		.num_ports	= 8,
+		.base_baud	= 115200,
+		.uart_offset	= 8,
+	},
+
+	[pbn_b1_1_921600] = {
+		.flags		= SPCI_FL_BASE1,
+		.num_ports	= 1,
+		.base_baud	= 921600,
+		.uart_offset	= 8,
+	},
+	[pbn_b1_2_921600] = {
+		.flags		= SPCI_FL_BASE1,
+		.num_ports	= 2,
+		.base_baud	= 921600,
+		.uart_offset	= 8,
+	},
+	[pbn_b1_4_921600] = {
+		.flags		= SPCI_FL_BASE1,
+		.num_ports	= 4,
+		.base_baud	= 921600,
+		.uart_offset	= 8,
+	},
+	[pbn_b1_8_921600] = {
+		.flags		= SPCI_FL_BASE1,
+		.num_ports	= 8,
+		.base_baud	= 921600,
+		.uart_offset	= 8,
+	},
+
+	[pbn_b1_bt_2_921600] = {
+		.flags		= SPCI_FL_BASE1|SPCI_FL_BASE_TABLE,
+		.num_ports	= 2,
+		.base_baud	= 921600,
+		.uart_offset	= 8,
+	},
+
+	[pbn_b1_2_1382400] = {
+		.flags		= SPCI_FL_BASE1,
+		.num_ports	= 2,
+		.base_baud	= 1382400,
+		.uart_offset	= 8,
+	},
+	[pbn_b1_4_1382400] = {
+		.flags		= SPCI_FL_BASE1,
+		.num_ports	= 4,
+		.base_baud	= 1382400,
+		.uart_offset	= 8,
+	},
+	[pbn_b1_8_1382400] = {
+		.flags		= SPCI_FL_BASE1,
+		.num_ports	= 8,
+		.base_baud	= 1382400,
+		.uart_offset	= 8,
+	},
+
+	[pbn_b2_1_115200] = {
+		.flags		= SPCI_FL_BASE2,
+		.num_ports	= 1,
+		.base_baud	= 115200,
+		.uart_offset	= 8,
+	},
+	[pbn_b2_8_115200] = {
+		.flags		= SPCI_FL_BASE2,
+		.num_ports	= 8,
+		.base_baud	= 115200,
+		.uart_offset	= 8,
+	},
+
+	[pbn_b2_1_460800] = {
+		.flags		= SPCI_FL_BASE2,
+		.num_ports	= 1,
+		.base_baud	= 460800,
+		.uart_offset	= 8,
+	},
+	[pbn_b2_4_460800] = {
+		.flags		= SPCI_FL_BASE2,
+		.num_ports	= 4,
+		.base_baud	= 460800,
+		.uart_offset	= 8,
+	},
+	[pbn_b2_8_460800] = {
+		.flags		= SPCI_FL_BASE2,
+		.num_ports	= 8,
+		.base_baud	= 460800,
+		.uart_offset	= 8,
+	},
+	[pbn_b2_16_460800] = {
+		.flags		= SPCI_FL_BASE2,
+		.num_ports	= 16,
+		.base_baud	= 460800,
+		.uart_offset	= 8,
+	 },
+
+	[pbn_b2_1_921600] = {
+		.flags		= SPCI_FL_BASE2,
+		.num_ports	= 1,
+		.base_baud	= 921600,
+		.uart_offset	= 8,
+	},
+	[pbn_b2_4_921600] = {
+		.flags		= SPCI_FL_BASE2,
+		.num_ports	= 4,
+		.base_baud	= 921600,
+		.uart_offset	= 8,
+	},
+	[pbn_b2_8_921600] = {
+		.flags		= SPCI_FL_BASE2,
+		.num_ports	= 8,
+		.base_baud	= 921600,
+		.uart_offset	= 8,
+	},
+
+	[pbn_b2_bt_1_115200] = {
+		.flags		= SPCI_FL_BASE2|SPCI_FL_BASE_TABLE,
+		.num_ports	= 1,
+		.base_baud	= 115200,
+		.uart_offset	= 8,
+	},
+	[pbn_b2_bt_2_115200] = {
+		.flags		= SPCI_FL_BASE2|SPCI_FL_BASE_TABLE,
+		.num_ports	= 2,
+		.base_baud	= 115200,
+		.uart_offset	= 8,
+	},
+	[pbn_b2_bt_4_115200] = {
+		.flags		= SPCI_FL_BASE2|SPCI_FL_BASE_TABLE,
+		.num_ports	= 4,
+		.base_baud	= 115200,
+		.uart_offset	= 8,
+	},
+
+	[pbn_b2_bt_2_921600] = {
+		.flags		= SPCI_FL_BASE2|SPCI_FL_BASE_TABLE,
+		.num_ports	= 2,
+		.base_baud	= 921600,
+		.uart_offset	= 8,
+	},
+	[pbn_b2_bt_4_921600] = {
+		.flags		= SPCI_FL_BASE2|SPCI_FL_BASE_TABLE,
+		.num_ports	= 4,
+		.base_baud	= 921600,
+		.uart_offset	= 8,
+	},
+
+	[pbn_b3_4_115200] = {
+		.flags		= SPCI_FL_BASE3,
+		.num_ports	= 4,
+		.base_baud	= 115200,
+		.uart_offset	= 8,
+	},
+	[pbn_b3_8_115200] = {
+		.flags		= SPCI_FL_BASE3,
+		.num_ports	= 8,
+		.base_baud	= 115200,
+		.uart_offset	= 8,
+	},
+
+	/*
+	 * Entries following this are board-specific.
+	 */
+
 	/*
-	 * PCI Flags, Number of Ports, Base (Maximum) Baud Rate,
-	 * Offset to get to next UART's registers,
-	 * Register shift to use for memory-mapped I/O,
-	 * Initialization function, first UART offset
-	 */
-
-	/* Generic serial board, pbn_b0_1_115200, pbn_default */
-	{ SPCI_FL_BASE0, 1, 115200 },		/* pbn_b0_1_115200,
-						   pbn_default */
-
-	{ SPCI_FL_BASE0, 2, 115200 },		/* pbn_b0_2_115200 */
-	{ SPCI_FL_BASE0, 4, 115200 },		/* pbn_b0_4_115200 */
-
-	{ SPCI_FL_BASE0, 1, 921600 },		/* pbn_b0_1_921600 */
-	{ SPCI_FL_BASE0, 2, 921600 },		/* pbn_b0_2_921600 */
-	{ SPCI_FL_BASE0, 4, 921600 },		/* pbn_b0_4_921600 */
-
-	{ SPCI_FL_BASE0 | SPCI_FL_BASE_TABLE, 1, 115200 }, /* pbn_b0_bt_1_115200 */
-	{ SPCI_FL_BASE0 | SPCI_FL_BASE_TABLE, 2, 115200 }, /* pbn_b0_bt_2_115200 */
-	{ SPCI_FL_BASE0 | SPCI_FL_BASE_TABLE, 8, 115200 }, /* pbn_b0_bt_8_115200 */
-	{ SPCI_FL_BASE0 | SPCI_FL_BASE_TABLE, 1, 460800 }, /* pbn_b0_bt_1_460800 */
-	{ SPCI_FL_BASE0 | SPCI_FL_BASE_TABLE, 2, 460800 }, /* pbn_b0_bt_2_460800 */
-
-	{ SPCI_FL_BASE1, 1, 115200 },		/* pbn_b1_1_115200 */
-	{ SPCI_FL_BASE1, 2, 115200 },		/* pbn_b1_2_115200 */
-	{ SPCI_FL_BASE1, 4, 115200 },		/* pbn_b1_4_115200 */
-	{ SPCI_FL_BASE1, 8, 115200 },		/* pbn_b1_8_115200 */
-
-	{ SPCI_FL_BASE1, 2, 921600 },		/* pbn_b1_2_921600 */
-	{ SPCI_FL_BASE1, 4, 921600 },		/* pbn_b1_4_921600 */
-	{ SPCI_FL_BASE1, 8, 921600 },		/* pbn_b1_8_921600 */
-
-	{ SPCI_FL_BASE1, 2, 1382400 },		/* pbn_b1_2_1382400 */
-	{ SPCI_FL_BASE1, 4, 1382400 },		/* pbn_b1_4_1382400 */
-	{ SPCI_FL_BASE1, 8, 1382400 },		/* pbn_b1_8_1382400 */
-
-	{ SPCI_FL_BASE2, 1, 115200 },		/* pbn_b2_1_115200 */
-	{ SPCI_FL_BASE2, 8, 115200 },		/* pbn_b2_8_115200 */
-	{ SPCI_FL_BASE2, 4, 460800 },		/* pbn_b2_4_460800 */
-	{ SPCI_FL_BASE2, 8, 460800 },		/* pbn_b2_8_460800 */
-	{ SPCI_FL_BASE2, 16, 460800 },		/* pbn_b2_16_460800 */
-	{ SPCI_FL_BASE2, 4, 921600 },		/* pbn_b2_4_921600 */
-	{ SPCI_FL_BASE2, 8, 921600 },		/* pbn_b2_8_921600 */
-
-	{ SPCI_FL_BASE2 | SPCI_FL_BASE_TABLE, 1, 115200 }, /* pbn_b2_bt_1_115200 */
-	{ SPCI_FL_BASE2 | SPCI_FL_BASE_TABLE, 2, 115200 }, /* pbn_b2_bt_2_115200 */
-	{ SPCI_FL_BASE2 | SPCI_FL_BASE_TABLE, 4, 115200 }, /* pbn_b2_bt_4_115200 */
-	{ SPCI_FL_BASE2 | SPCI_FL_BASE_TABLE, 2, 921600 }, /* pbn_b2_bt_2_921600 */
-
-	{ SPCI_FL_BASE2, 2, 921600, /* IOMEM */		   /* pbn_panacom */
-		0x400, 7, pci_plx9050_fn },
-	{ SPCI_FL_BASE2 | SPCI_FL_BASE_TABLE, 2, 921600,   /* pbn_panacom2 */
-		0x400, 7, pci_plx9050_fn },
-	{ SPCI_FL_BASE2 | SPCI_FL_BASE_TABLE, 4, 921600,   /* pbn_panacom4 */
-		0x400, 7, pci_plx9050_fn },
-	{ SPCI_FL_BASE2, 4, 921600,			   /* pbn_plx_romulus */
-		0x20, 2, pci_plx9050_fn, 0x03 },
+	 * Panacom - IOMEM
+	 */
+	[pbn_panacom] = {
+		.flags		= SPCI_FL_BASE2,
+		.num_ports	= 2,
+		.base_baud	= 921600,
+		.uart_offset	= 0x400,
+		.reg_shift	= 7,
+	},
+	[pbn_panacom2] = {
+		.flags		= SPCI_FL_BASE2|SPCI_FL_BASE_TABLE,
+		.num_ports	= 2,
+		.base_baud	= 921600,
+		.uart_offset	= 0x400,
+		.reg_shift	= 7,
+	},
+	[pbn_panacom4] = {
+		.flags		= SPCI_FL_BASE2|SPCI_FL_BASE_TABLE,
+		.num_ports	= 4,
+		.base_baud	= 921600,
+		.uart_offset	= 0x400,
+		.reg_shift	= 7,
+	},
+
+	/* I think this entry is broken - the first_offset looks wrong --rmk */
+	[pbn_plx_romulus] = {
+		.flags		= SPCI_FL_BASE2,
+		.num_ports	= 4,
+		.base_baud	= 921600,
+		.uart_offset	= 8 << 2,
+		.reg_shift	= 2,
+		.first_offset	= 0x03,
+	},
 
 	/*
 	 * This board uses the size of PCI Base region 0 to
 	 * signal now many ports are available
 	 */
-	{ SPCI_FL_BASE0 | SPCI_FL_REGION_SZ_CAP, 32, 115200 }, /* pbn_oxsemi */
-	{ SPCI_FL_BASE_TABLE, 1, 921600,		   /* pbn_timedia */
-		0, 0, pci_timedia_fn },
-	/* EKF addition for i960 Boards form EKF with serial port */
-	{ SPCI_FL_BASE0, 32, 921600, /* max 256 ports */   /* pbn_intel_i960 */
-		8<<2, 2, pci_inteli960ni_fn, 0x10000},
-	{ SPCI_FL_BASE0 | SPCI_FL_IRQRESOURCE,		   /* pbn_sgi_ioc3 */
-		1, 458333, 0, 0, 0, 0x20178 },
-	{ SPCI_FL_BASE0, 5, 115200, 8, 0, pci_hp_diva, 0 },/* pbn_hp_diva */
+	[pbn_oxsemi] = {
+		.flags		= SPCI_FL_BASE0|SPCI_FL_REGION_SZ_CAP,
+		.num_ports	= 32,
+		.base_baud	= 115200,
+		.uart_offset	= 8,
+	},
 
 	/*
-	 * NEC Vrc-5074 (Nile 4) builtin UART.
+	 * EKF addition for i960 Boards form EKF with serial port.
+	 * Max 256 ports.
 	 */
-	{ SPCI_FL_BASE0, 1, 520833,			   /* pbn_nec_nile4 */
-		64, 3, NULL, 0x300 },
+	[pbn_intel_i960] = {
+		.flags		= SPCI_FL_BASE0,
+		.num_ports	= 32,
+		.base_baud	= 921600,
+		.uart_offset	= 8 << 2,
+		.reg_shift	= 2,
+		.first_offset	= 0x10000,
+	},
+	[pbn_sgi_ioc3] = {
+		.flags		= SPCI_FL_BASE0|SPCI_FL_IRQRESOURCE,
+		.num_ports	= 1,
+		.base_baud	= 458333,
+		.uart_offset	= 8,
+		.reg_shift	= 0,
+		.first_offset	= 0x20178,
+	},
 
-	{ SPCI_FL_BASE3, 4, 115200, 8 },		   /* pbn_dci_pccom4 */
-	{ SPCI_FL_BASE3, 8, 115200, 8 },		   /* pbn_dci_pccom8 */
-
-	{ SPCI_FL_BASE0, 1, 115200,			   /* pbn_xircom_combo */
-		0, 0, pci_xircom_fn },
+	/*
+	 * NEC Vrc-5074 (Nile 4) builtin UART.
+	 */
+	[pbn_nec_nile4] = {
+		.flags		= SPCI_FL_BASE0,
+		.num_ports	= 1,
+		.base_baud	= 520833,
+		.uart_offset	= 8 << 3,
+		.reg_shift	= 3,
+		.first_offset	= 0x300,
+	},
 
-	{ SPCI_FL_BASE2, 1, 460800,			   /* pbn_siig10x_0 */
-		0, 0, pci_siig10x_fn },
-	{ SPCI_FL_BASE2, 1, 921600,			   /* pbn_siig10x_1 */
-		0, 0, pci_siig10x_fn },
-	{ SPCI_FL_BASE2 | SPCI_FL_BASE_TABLE, 2, 921600,   /* pbn_siig10x_2 */
-		0, 0, pci_siig10x_fn },
-	{ SPCI_FL_BASE2 | SPCI_FL_BASE_TABLE, 4, 921600,   /* pbn_siig10x_4 */
-		0, 0, pci_siig10x_fn },
-	{ SPCI_FL_BASE0, 1, 921600,			   /* pbn_siix20x_0 */
-		0, 0, pci_siig20x_fn },
-	{ SPCI_FL_BASE0 | SPCI_FL_BASE_TABLE, 2, 921600,   /* pbn_siix20x_2 */
-		0, 0, pci_siig20x_fn },
-	{ SPCI_FL_BASE0 | SPCI_FL_BASE_TABLE, 4, 921600,   /* pbn_siix20x_4 */
-		0, 0, pci_siig20x_fn },
-
-	{ SPCI_FL_BASE0, 4, 921600, /* IOMEM */		   /* pbn_computone_4 */
-		0x40, 2, NULL, 0x200 },
-	{ SPCI_FL_BASE0, 6, 921600, /* IOMEM */		   /* pbn_computone_6 */
-		0x40, 2, NULL, 0x200 },
-	{ SPCI_FL_BASE0, 8, 921600, /* IOMEM */		   /* pbn_computone_8 */
-		0x40, 2, NULL, 0x200 },
+	/*
+	 * Computone - uses IOMEM.
+	 */
+	[pbn_computone_4] = {
+		.flags		= SPCI_FL_BASE0,
+		.num_ports	= 4,
+		.base_baud	= 921600,
+		.uart_offset	= 0x40,
+		.reg_shift	= 2,
+		.first_offset	= 0x200,
+	},
+	[pbn_computone_6] = {
+		.flags		= SPCI_FL_BASE0,
+		.num_ports	= 6,
+		.base_baud	= 921600,
+		.uart_offset	= 0x40,
+		.reg_shift	= 2,
+		.first_offset	= 0x200,
+	},
+	[pbn_computone_8] = {
+		.flags		= SPCI_FL_BASE0,
+		.num_ports	= 8,
+		.base_baud	= 921600,
+		.uart_offset	= 0x40,
+		.reg_shift	= 2,
+		.first_offset	= 0x200,
+	},
 };
 
 /*
@@ -640,8 +1329,7 @@
 static int __devinit
 serial_pci_guess_board(struct pci_dev *dev, struct pci_board *board)
 {
-	int num_iomem = 0, num_port = 0, first_port = -1;
-	int i;
+	int num_iomem, num_port, first_port = -1, i;
 	
 	/*
 	 * If it is not a communications device or the programming
@@ -655,36 +1343,63 @@
 	    (dev->class & 0xff) > 6)
 		return -ENODEV;
 
-	for (i = 0; i < 6; i++) {
-		if (IS_PCI_REGION_IOPORT(dev, i)) {
+	num_iomem = num_port = 0;
+	for (i = 0; i < PCI_NUM_BAR_RESOURCES; i++) {
+		if (pci_resource_flags(dev, i) & IORESOURCE_IO) {
 			num_port++;
 			if (first_port == -1)
 				first_port = i;
 		}
-		if (IS_PCI_REGION_IOMEM(dev, i))
+		if (pci_resource_flags(dev, i) & IORESOURCE_MEM)
 			num_iomem++;
 	}
 
 	/*
-	 * If there is 1 or 0 iomem regions, and exactly one port, use
-	 * it.
+	 * If there is 1 or 0 iomem regions, and exactly one port,
+	 * use it.  We guess the number of ports based on the IO
+	 * region size.
 	 */
 	if (num_iomem <= 1 && num_port == 1) {
 		board->flags = first_port;
+		board->num_ports = pci_resource_len(dev, first_port) / 8;
 		return 0;
 	}
+
+	/*
+	 * Now guess if we've got a board which indexes by BARs.
+	 * Each IO BAR should be 8 bytes, and they should follow
+	 * consecutively.
+	 */
+	first_port = -1;
+	num_port = 0;
+	for (i = 0; i < PCI_NUM_BAR_RESOURCES; i++) {
+		if (pci_resource_flags(dev, i) & IORESOURCE_IO &&
+		    pci_resource_len(dev, i) == 8 &&
+		    (first_port == -1 || (first_port + num_port) == i)) {
+			num_port++;
+			if (first_port == -1)
+				first_port = i;
+		}
+	}
+
+	if (num_port > 1) {
+		board->flags = first_port | SPCI_FL_BASE_TABLE;
+		board->num_ports = num_port;
+		return 0;
+	}
+
 	return -ENODEV;
 }
 
 static inline int
-serial_pci_matches(struct pci_board *board, int index)
+serial_pci_matches(struct pci_board *board, struct pci_board *guessed)
 {
 	return
-	    board->base_baud == pci_boards[index].base_baud &&
-	    board->num_ports == pci_boards[index].num_ports &&
-	    board->uart_offset == pci_boards[index].uart_offset &&
-	    board->reg_shift == pci_boards[index].reg_shift &&
-	    board->first_uart_offset == pci_boards[index].first_uart_offset;
+	    board->num_ports == guessed->num_ports &&
+	    board->base_baud == guessed->base_baud &&
+	    board->uart_offset == guessed->uart_offset &&
+	    board->reg_shift == guessed->reg_shift &&
+	    board->first_offset == guessed->first_offset;
 }
 
 /*
@@ -696,6 +1411,7 @@
 {
 	struct serial_private *priv;
 	struct pci_board *board, tmp;
+	struct pci_serial_quirk *quirk;
 	struct serial_struct serial_req;
 	int base_baud, rc, nr_ports, i;
 
@@ -732,74 +1448,76 @@
 		 * detect this boards settings with our heuristic,
 		 * then we no longer need this entry.
 		 */
+		memcpy(&tmp, &pci_boards[pbn_default], sizeof(struct pci_board));
 		rc = serial_pci_guess_board(dev, &tmp);
-		if (rc == 0 && serial_pci_matches(board, pbn_default)) {
-			printk(KERN_INFO
-		"Redundant entry in serial pci_table.  Please send the output\n"
-		"of lspci -vv, this message (0x%04x,0x%04x,0x%04x,0x%04x),\n"
-		"the manufacturer and name of serial board or modem board to\n"
-		"rmk@arm.linux.org.uk.\n",
-			       dev->vendor, dev->device,
-			       pci_get_subvendor(dev), pci_get_subdevice(dev));
-		}
+		if (rc == 0 && serial_pci_matches(board, &tmp))
+			moan_device("Redundant entry in serial pci_table.", dev);
 	}
 
 	nr_ports = board->num_ports;
 
 	/*
-	 * Run the initialization function, if any.  The initialization
-	 * function returns:
+	 * Find an init and setup quirks.
+	 */
+	quirk = find_quirk(dev);
+
+	/*
+	 * Run the new-style initialization function.
+	 * The initialization function returns:
 	 *  <0  - error
 	 *   0  - use board->num_ports
 	 *  >0  - number of ports
 	 */
-	if (board->init_fn) {
-		rc = board->init_fn(dev, 1);
+	if (quirk->init) {
+		rc = quirk->init(dev);
 		if (rc < 0)
 			goto disable;
-
 		if (rc)
 			nr_ports = rc;
 	}
 
 	priv = kmalloc(sizeof(struct serial_private) +
-			      sizeof(unsigned int) * nr_ports,
-			      GFP_KERNEL);
+		       sizeof(unsigned int) * nr_ports,
+		       GFP_KERNEL);
 	if (!priv) {
 		rc = -ENOMEM;
 		goto deinit;
 	}
 
+	memset(priv, 0, sizeof(struct serial_private) +
+			sizeof(unsigned int) * nr_ports);
+
+	priv->quirk = quirk;
+	pci_set_drvdata(dev, priv);
+
 	base_baud = board->base_baud;
 	if (!base_baud)
 		base_baud = BASE_BAUD;
-	memset(&serial_req, 0, sizeof(serial_req));
 	for (i = 0; i < nr_ports; i++) {
+		memset(&serial_req, 0, sizeof(serial_req));
+		serial_req.flags = UPF_SKIP_TEST | UPF_AUTOPROBE |
+				   UPF_RESOURCES | UPF_SHARE_IRQ;
+		serial_req.baud_base = base_baud;
 		serial_req.irq = get_pci_irq(dev, board, i);
-		if (get_pci_port(dev, board, &serial_req, i))
+		if (quirk->setup(dev, board, &serial_req, i))
 			break;
 #ifdef SERIAL_DEBUG_PCI
 		printk("Setup PCI port: port %x, irq %d, type %d\n",
 		       serial_req.port, serial_req.irq, serial_req.io_type);
 #endif
-		serial_req.flags = ASYNC_SKIP_TEST | ASYNC_AUTOPROBE;
-		serial_req.baud_base = base_baud;
 		
 		priv->line[i] = register_serial(&serial_req);
 		if (priv->line[i] < 0)
 			break;
 	}
 
-	priv->board = board;
 	priv->nr = i;
 
-	pci_set_drvdata(dev, priv);
-
 	return 0;
 
  deinit:
-	if (board->init_fn)
-		board->init_fn(dev, 0);
+	if (quirk->exit)
+		quirk->exit(dev);
  disable:
 	pci_disable_device(dev);
 	return rc;
@@ -808,16 +1526,28 @@
 static void __devexit pci_remove_one(struct pci_dev *dev)
 {
 	struct serial_private *priv = pci_get_drvdata(dev);
-	int i;
 
 	pci_set_drvdata(dev, NULL);
 
 	if (priv) {
+		struct pci_serial_quirk *quirk;
+		int i;
+
 		for (i = 0; i < priv->nr; i++)
 			unregister_serial(priv->line[i]);
 
-		if (priv->board->init_fn)
-			priv->board->init_fn(dev, 0);
+		for (i = 0; i < PCI_NUM_BAR_RESOURCES; i++) {
+			if (priv->remapped_bar[i])
+				iounmap(priv->remapped_bar[i]);
+			priv->remapped_bar[i] = NULL;
+		}
+
+		/*
+		 * Find the exit quirks.
+		 */
+		quirk = find_quirk(dev);
+		if (quirk->exit)
+			quirk->exit(dev);
 
 		pci_disable_device(dev);
 
@@ -825,6 +1555,40 @@
 	}
 }
 
+static int pci_suspend_one(struct pci_dev *dev, u32 state)
+{
+#ifdef not_yet
+	struct serial_private *priv = pci_get_drvdata(dev);
+	int i;
+
+	if (priv)
+		for (i = 0; i < priv->nr; i++)
+			serial8250_suspend_port(priv->line[i]);
+#endif
+	return 0;
+}
+
+static int pci_resume_one(struct pci_dev *dev)
+{
+#ifdef not_yet
+	struct serial_private *priv = pci_get_drvdata(dev);
+	int i;
+
+	if (priv) {
+		/*
+		 * We may need to ensure that the board is correctly
+		 * configured.  This is just a guess. --rmk
+		 */
+		if (priv->quirk->init)
+			priv->quirk->init(dev);
+
+		for (i = 0; i < priv->nr; i++)
+			serial8250_resume_port(priv->line[i]);
+	}
+#endif
+	return 0;
+}
+
 static struct pci_device_id serial_pci_tbl[] __devinitdata = {
 	{	PCI_VENDOR_ID_V3, PCI_DEVICE_ID_V3_V960,
 		PCI_SUBVENDOR_ID_CONNECT_TECH,
@@ -908,7 +1672,9 @@
 	{	PCI_VENDOR_ID_PLX, PCI_DEVICE_ID_PLX_SPCOM200,
 		PCI_ANY_ID, PCI_ANY_ID, 0, 0,
 		pbn_b2_bt_2_921600 },
-	/* VScom SPCOM800, from sl@s.pl */
+	/*
+	 * VScom SPCOM800, from sl@s.pl
+	 */
 	{	PCI_VENDOR_ID_PLX, PCI_DEVICE_ID_PLX_SPCOM800, 
 		PCI_ANY_ID, PCI_ANY_ID, 0, 0, 
 		pbn_b2_8_921600 },
@@ -949,8 +1715,10 @@
 		PCI_SUBVENDOR_ID_CHASE_PCIRAS,
 		PCI_SUBDEVICE_ID_CHASE_PCIRAS8, 0, 0, 
 		pbn_b2_8_460800 },
-	/* Megawolf Romulus PCI Serial Card, from Mike Hudson */
-	/* (Exoray@isys.ca) */
+	/*
+	 * Megawolf Romulus PCI Serial Card, from Mike Hudson
+	 * (Exoray@isys.ca)
+	 */
 	{	PCI_VENDOR_ID_PLX, PCI_DEVICE_ID_PLX_ROMULUS,
 		0x10b5, 0x106a, 0, 0,
 		pbn_plx_romulus },
@@ -976,16 +1744,24 @@
 		PCI_ANY_ID, PCI_ANY_ID, 0, 0, 
 		pbn_b0_2_115200 },
 
-	/* Digitan DS560-558, from jimd@esoft.com */
+	/*
+	 * Digitan DS560-558, from jimd@esoft.com
+	 */
 	{	PCI_VENDOR_ID_ATT, PCI_DEVICE_ID_ATT_VENUS_MODEM,
 		PCI_ANY_ID, PCI_ANY_ID, 0, 0, 
 		pbn_b1_1_115200 },
 
-	/* 3Com US Robotics 56k Voice Internal PCI model 5610 */
+	/*
+	 * 3Com US Robotics 56k Voice Internal PCI model 5610
+	 */
 	{	PCI_VENDOR_ID_USR, 0x1008,
-		PCI_ANY_ID, PCI_ANY_ID, },
+		PCI_ANY_ID, PCI_ANY_ID, 0, 0,
+		pbn_b0_1_115200 },
 
-	/* Titan Electronic cards */
+	/*
+	 * Titan Electronic cards
+	 *  The 400L and 800L have a custom setup quirk.
+	 */
 	{	PCI_VENDOR_ID_TITAN, PCI_DEVICE_ID_TITAN_100,
 		PCI_ANY_ID, PCI_ANY_ID, 0, 0, 
 		pbn_b0_1_921600 },
@@ -999,120 +1775,76 @@
 		PCI_ANY_ID, PCI_ANY_ID, 0, 0, 
 		pbn_b0_4_921600 },
 	{	PCI_VENDOR_ID_TITAN, PCI_DEVICE_ID_TITAN_100L,
-		PCI_ANY_ID, PCI_ANY_ID,
-		SPCI_FL_BASE1, 1, 921600 },
+		PCI_ANY_ID, PCI_ANY_ID, 0, 0,
+		pbn_b1_1_921600 },
 	{	PCI_VENDOR_ID_TITAN, PCI_DEVICE_ID_TITAN_200L,
-		PCI_ANY_ID, PCI_ANY_ID,
-		SPCI_FL_BASE1 | SPCI_FL_BASE_TABLE, 2, 921600 },
-	/* The 400L and 800L have a custom hack in get_pci_port */
+		PCI_ANY_ID, PCI_ANY_ID, 0, 0,
+		pbn_b1_bt_2_921600 },
 	{	PCI_VENDOR_ID_TITAN, PCI_DEVICE_ID_TITAN_400L,
-		PCI_ANY_ID, PCI_ANY_ID,
-		SPCI_FL_BASE_TABLE, 4, 921600 },
+		PCI_ANY_ID, PCI_ANY_ID, 0, 0,
+		pbn_b0_bt_4_921600 },
 	{	PCI_VENDOR_ID_TITAN, PCI_DEVICE_ID_TITAN_800L,
-		PCI_ANY_ID, PCI_ANY_ID,
-		SPCI_FL_BASE_TABLE, 8, 921600 },
+		PCI_ANY_ID, PCI_ANY_ID, 0, 0,
+		pbn_b0_bt_8_921600 },
 
 	{	PCI_VENDOR_ID_SIIG, PCI_DEVICE_ID_SIIG_1S_10x_550,
 		PCI_ANY_ID, PCI_ANY_ID, 0, 0,
-		pbn_siig10x_0 },
+		pbn_b2_1_460800 },
 	{	PCI_VENDOR_ID_SIIG, PCI_DEVICE_ID_SIIG_1S_10x_650,
 		PCI_ANY_ID, PCI_ANY_ID, 0, 0,
-		pbn_siig10x_0 },
+		pbn_b2_1_460800 },
 	{	PCI_VENDOR_ID_SIIG, PCI_DEVICE_ID_SIIG_1S_10x_850,
 		PCI_ANY_ID, PCI_ANY_ID, 0, 0,
-		pbn_siig10x_0 },
-	{	PCI_VENDOR_ID_SIIG, PCI_DEVICE_ID_SIIG_1S1P_10x_550,
-		PCI_ANY_ID, PCI_ANY_ID, 0, 0,
-		pbn_siig10x_1 },
-	{	PCI_VENDOR_ID_SIIG, PCI_DEVICE_ID_SIIG_1S1P_10x_650,
-		PCI_ANY_ID, PCI_ANY_ID, 0, 0,
-		pbn_siig10x_1 },
-	{	PCI_VENDOR_ID_SIIG, PCI_DEVICE_ID_SIIG_1S1P_10x_850,
-		PCI_ANY_ID, PCI_ANY_ID, 0, 0,
-		pbn_siig10x_1 },
+		pbn_b2_1_460800 },
 	{	PCI_VENDOR_ID_SIIG, PCI_DEVICE_ID_SIIG_2S_10x_550,
 		PCI_ANY_ID, PCI_ANY_ID, 0, 0,
-		pbn_siig10x_2 },
+		pbn_b2_bt_2_921600 },
 	{	PCI_VENDOR_ID_SIIG, PCI_DEVICE_ID_SIIG_2S_10x_650,
 		PCI_ANY_ID, PCI_ANY_ID, 0, 0,
-		pbn_siig10x_2 },
+		pbn_b2_bt_2_921600 },
 	{	PCI_VENDOR_ID_SIIG, PCI_DEVICE_ID_SIIG_2S_10x_850,
 		PCI_ANY_ID, PCI_ANY_ID, 0, 0,
-		pbn_siig10x_2 },
-	{	PCI_VENDOR_ID_SIIG, PCI_DEVICE_ID_SIIG_2S1P_10x_550,
-		PCI_ANY_ID, PCI_ANY_ID, 0, 0,
-		pbn_siig10x_2 },
-	{	PCI_VENDOR_ID_SIIG, PCI_DEVICE_ID_SIIG_2S1P_10x_650,
-		PCI_ANY_ID, PCI_ANY_ID, 0, 0,
-		pbn_siig10x_2 },
-	{	PCI_VENDOR_ID_SIIG, PCI_DEVICE_ID_SIIG_2S1P_10x_850,
-		PCI_ANY_ID, PCI_ANY_ID, 0, 0,
-		pbn_siig10x_2 },
+		pbn_b2_bt_2_921600 },
 	{	PCI_VENDOR_ID_SIIG, PCI_DEVICE_ID_SIIG_4S_10x_550,
 		PCI_ANY_ID, PCI_ANY_ID, 0, 0,
-		pbn_siig10x_4 },
+		pbn_b2_bt_4_921600 },
 	{	PCI_VENDOR_ID_SIIG, PCI_DEVICE_ID_SIIG_4S_10x_650,
 		PCI_ANY_ID, PCI_ANY_ID, 0, 0,
-		pbn_siig10x_4 },
+		pbn_b2_bt_4_921600 },
 	{	PCI_VENDOR_ID_SIIG, PCI_DEVICE_ID_SIIG_4S_10x_850,
 		PCI_ANY_ID, PCI_ANY_ID, 0, 0,
-		pbn_siig10x_4 },
+		pbn_b2_bt_4_921600 },
 	{	PCI_VENDOR_ID_SIIG, PCI_DEVICE_ID_SIIG_1S_20x_550,
 		PCI_ANY_ID, PCI_ANY_ID, 0, 0,
-		pbn_siig20x_0 },
+		pbn_b0_1_921600 },
 	{	PCI_VENDOR_ID_SIIG, PCI_DEVICE_ID_SIIG_1S_20x_650,
 		PCI_ANY_ID, PCI_ANY_ID, 0, 0,
-		pbn_siig20x_0 },
+		pbn_b0_1_921600 },
 	{	PCI_VENDOR_ID_SIIG, PCI_DEVICE_ID_SIIG_1S_20x_850,
 		PCI_ANY_ID, PCI_ANY_ID, 0, 0,
-		pbn_siig20x_0 },
-	{	PCI_VENDOR_ID_SIIG, PCI_DEVICE_ID_SIIG_1S1P_20x_550,
-		PCI_ANY_ID, PCI_ANY_ID, 0, 0,
-		pbn_siig20x_0 },
-	{	PCI_VENDOR_ID_SIIG, PCI_DEVICE_ID_SIIG_1S1P_20x_650,
-		PCI_ANY_ID, PCI_ANY_ID, 0, 0,
-		pbn_siig20x_0 },
-	{	PCI_VENDOR_ID_SIIG, PCI_DEVICE_ID_SIIG_1S1P_20x_850,
-		PCI_ANY_ID, PCI_ANY_ID, 0, 0,
-		pbn_siig20x_0 },
-	{	PCI_VENDOR_ID_SIIG, PCI_DEVICE_ID_SIIG_2P1S_20x_550,
-		PCI_ANY_ID, PCI_ANY_ID, 0, 0,
-		pbn_siig20x_0 },
-	{	PCI_VENDOR_ID_SIIG, PCI_DEVICE_ID_SIIG_2P1S_20x_650,
-		PCI_ANY_ID, PCI_ANY_ID, 0, 0,
-		pbn_siig20x_0 },
-	{	PCI_VENDOR_ID_SIIG, PCI_DEVICE_ID_SIIG_2P1S_20x_850,
-		PCI_ANY_ID, PCI_ANY_ID, 0, 0,
-		pbn_siig20x_0 },
+		pbn_b0_1_921600 },
 	{	PCI_VENDOR_ID_SIIG, PCI_DEVICE_ID_SIIG_2S_20x_550,
 		PCI_ANY_ID, PCI_ANY_ID, 0, 0,
-		pbn_siig20x_2 },
+		pbn_b0_bt_2_921600 },
 	{	PCI_VENDOR_ID_SIIG, PCI_DEVICE_ID_SIIG_2S_20x_650,
 		PCI_ANY_ID, PCI_ANY_ID, 0, 0,
-		pbn_siig20x_2 },
+		pbn_b0_bt_2_921600 },
 	{	PCI_VENDOR_ID_SIIG, PCI_DEVICE_ID_SIIG_2S_20x_850,
 		PCI_ANY_ID, PCI_ANY_ID, 0, 0,
-		pbn_siig20x_2 },
-	{	PCI_VENDOR_ID_SIIG, PCI_DEVICE_ID_SIIG_2S1P_20x_550,
-		PCI_ANY_ID, PCI_ANY_ID, 0, 0,
-		pbn_siig20x_2 },
-	{	PCI_VENDOR_ID_SIIG, PCI_DEVICE_ID_SIIG_2S1P_20x_650,
-		PCI_ANY_ID, PCI_ANY_ID, 0, 0,
-		pbn_siig20x_2 },
-	{	PCI_VENDOR_ID_SIIG, PCI_DEVICE_ID_SIIG_2S1P_20x_850,
-		PCI_ANY_ID, PCI_ANY_ID, 0, 0,
-		pbn_siig20x_2 },
+		pbn_b0_bt_2_921600 },
 	{	PCI_VENDOR_ID_SIIG, PCI_DEVICE_ID_SIIG_4S_20x_550,
 		PCI_ANY_ID, PCI_ANY_ID, 0, 0,
-		pbn_siig20x_4 },
+		pbn_b0_bt_4_921600 },
 	{	PCI_VENDOR_ID_SIIG, PCI_DEVICE_ID_SIIG_4S_20x_650,
 		PCI_ANY_ID, PCI_ANY_ID, 0, 0,
-		pbn_siig20x_4 },
+		pbn_b0_bt_4_921600 },
 	{	PCI_VENDOR_ID_SIIG, PCI_DEVICE_ID_SIIG_4S_20x_850,
 		PCI_ANY_ID, PCI_ANY_ID, 0, 0,
-		pbn_siig20x_4 },
+		pbn_b0_bt_4_921600 },
 
-	/* Computone devices submitted by Doug McNash dmcnash@computone.com */
+	/*
+	 * Computone devices submitted by Doug McNash dmcnash@computone.com
+	 */
 	{	PCI_VENDOR_ID_COMPUTONE, PCI_DEVICE_ID_COMPUTONE_PG,
 		PCI_SUBVENDOR_ID_COMPUTONE, PCI_SUBDEVICE_ID_COMPUTONE_PG4,
 		0, 0, pbn_computone_4 },
@@ -1124,18 +1856,22 @@
 		0, 0, pbn_computone_6 },
 
 	{	PCI_VENDOR_ID_OXSEMI, PCI_DEVICE_ID_OXSEMI_16PCI95N,
-		PCI_ANY_ID, PCI_ANY_ID, 0, 0, pbn_oxsemi },
+		PCI_ANY_ID, PCI_ANY_ID, 0, 0,
+		pbn_oxsemi },
 	{	PCI_VENDOR_ID_TIMEDIA, PCI_DEVICE_ID_TIMEDIA_1889,
-		PCI_VENDOR_ID_TIMEDIA, PCI_ANY_ID, 0, 0, pbn_timedia },
+		PCI_VENDOR_ID_TIMEDIA, PCI_ANY_ID, 0, 0,
+		pbn_b0_bt_1_921600 },
 
-	{	PCI_VENDOR_ID_LAVA, PCI_DEVICE_ID_LAVA_DSERIAL,
-		PCI_ANY_ID, PCI_ANY_ID, 0, 0,
-		pbn_b0_bt_2_115200 },
-	/* AFAVLAB serial card, from Harald Welte <laforge@gnumonks.org> */
+	/*
+	 * AFAVLAB serial card, from Harald Welte <laforge@gnumonks.org>
+	 */
 	{	PCI_VENDOR_ID_AFAVLAB, PCI_DEVICE_ID_AFAVLAB_P028,
 		PCI_ANY_ID, PCI_ANY_ID, 0, 0,
 		pbn_b0_bt_8_115200 },
 
+	{	PCI_VENDOR_ID_LAVA, PCI_DEVICE_ID_LAVA_DSERIAL,
+		PCI_ANY_ID, PCI_ANY_ID, 0, 0,
+		pbn_b0_bt_2_115200 },
 	{	PCI_VENDOR_ID_LAVA, PCI_DEVICE_ID_LAVA_QUATRO_A,
 		PCI_ANY_ID, PCI_ANY_ID, 0, 0,
 		pbn_b0_bt_2_115200 },
@@ -1158,26 +1894,40 @@
 		PCI_ANY_ID, PCI_ANY_ID, 0, 0,
 		pbn_b0_bt_1_460800 },
 
-	/* RAStel 2 port modem, gerg@moreton.com.au */
+	/*
+	 * RAStel 2 port modem, gerg@moreton.com.au
+	 */
 	{	PCI_VENDOR_ID_MORETON, PCI_DEVICE_ID_RASTEL_2PORT,
 		PCI_ANY_ID, PCI_ANY_ID, 0, 0,
 		pbn_b2_bt_2_115200 },
 
-	/* EKF addition for i960 Boards form EKF with serial port */
-	{	PCI_VENDOR_ID_INTEL, 0x1960,
+	/*
+	 * EKF addition for i960 Boards form EKF with serial port
+	 */
+	{	PCI_VENDOR_ID_INTEL, PCI_DEVICE_ID_INTEL_80960_RP,
 		0xE4BF, PCI_ANY_ID, 0, 0,
 		pbn_intel_i960 },
 
-	/* Xircom Cardbus/Ethernet combos */
+	/*
+	 * Xircom Cardbus/Ethernet combos
+	 */
 	{	PCI_VENDOR_ID_XIRCOM, PCI_DEVICE_ID_XIRCOM_X3201_MDM,
 		PCI_ANY_ID, PCI_ANY_ID, 0, 0,
-		pbn_xircom_combo },
+		pbn_b0_1_115200 },
+	/*
+	 * Xircom RBM56G cardbus modem - Dirk Arnold (temp entry)
+	 */
+	{	PCI_VENDOR_ID_XIRCOM, PCI_DEVICE_ID_XIRCOM_RBM56G,
+		PCI_ANY_ID, PCI_ANY_ID, 0, 0,
+		pbn_b0_1_115200 },
 
 	/*
 	 * Untested PCI modems, sent in from various folks...
 	 */
 
-	/* Elsa Model 56K PCI Modem, from Andreas Rath <arh@01019freenet.de> */
+	/*
+	 * Elsa Model 56K PCI Modem, from Andreas Rath <arh@01019freenet.de>
+	 */
 	{	PCI_VENDOR_ID_ROCKWELL, 0x1004,
 		0x1048, 0x1500, 0, 0,
 		pbn_b1_1_115200 },
@@ -1186,10 +1936,12 @@
 		0xFF00, 0, 0, 0,
 		pbn_sgi_ioc3 },
 
-	/* HP Diva card */
+	/*
+	 * HP Diva card
+	 */
 	{	PCI_VENDOR_ID_HP, PCI_DEVICE_ID_HP_DIVA,
 		PCI_ANY_ID, PCI_ANY_ID, 0, 0,
-		pbn_hp_diva },
+		pbn_b0_5_115200 },
 	{	PCI_VENDOR_ID_HP, PCI_DEVICE_ID_HP_DIVA_AUX,
 		PCI_ANY_ID, PCI_ANY_ID, 0, 0,
 		pbn_b2_1_115200 },
@@ -1203,10 +1955,10 @@
 
 	{	PCI_VENDOR_ID_DCI, PCI_DEVICE_ID_DCI_PCCOM4,
 		PCI_ANY_ID, PCI_ANY_ID, 0, 0,
-		pbn_dci_pccom4 },
+		pbn_b3_4_115200 },
 	{	PCI_VENDOR_ID_DCI, PCI_DEVICE_ID_DCI_PCCOM8,
 		PCI_ANY_ID, PCI_ANY_ID, 0, 0,
-		pbn_dci_pccom8 },
+		pbn_b3_8_115200 },
 
 	/*
 	 * These entries match devices with class
@@ -1232,7 +1984,12 @@
 	.name		= "serial",
 	.probe		= pci_init_one,
 	.remove		= __devexit_p(pci_remove_one),
+	.suspend	= pci_suspend_one,
+	.resume		= pci_resume_one,
 	.id_table	= serial_pci_tbl,
+	.driver = {
+		.devclass = &tty_devclass,
+	},
 };
 
 static int __init serial8250_pci_init(void)

-- 
Russell King (rmk@arm.linux.org.uk)                The developer of ARM Linux
             http://www.arm.linux.org.uk/personal/aboutme.html

