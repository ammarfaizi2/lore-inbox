Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S271807AbTHHTGS (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 8 Aug 2003 15:06:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S271756AbTHHTEI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 8 Aug 2003 15:04:08 -0400
Received: from palrel10.hp.com ([156.153.255.245]:30147 "EHLO palrel10.hp.com")
	by vger.kernel.org with ESMTP id S271750AbTHHSyG (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 8 Aug 2003 14:54:06 -0400
Date: Fri, 8 Aug 2003 11:54:04 -0700
To: Jeff Garzik <jgarzik@pobox.com>,
       Linux kernel mailing list <linux-kernel@vger.kernel.org>
Subject: [PATCH 2.5 IrDA] vlsi driver update
Message-ID: <20030808185404.GF13274@bougret.hpl.hp.com>
Reply-To: jt@hpl.hp.com
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.28i
Organisation: HP Labs Palo Alto
Address: HP Labs, 1U-17, 1501 Page Mill road, Palo Alto, CA 94304, USA.
E-mail: jt@hpl.hp.com
From: Jean Tourrilhes <jt@bougret.hpl.hp.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

ir260_vlsi-05.diff :
~~~~~~~~~~~~~~~~~~
		<Patch from Martin Diehl>
* correct endianess conversion of hardware exposed fields
* we need to check crc16 of rx frames in SIR-mode
  (hardware does this in MIR/FIR modes). Use irda_calc_crc16.
* get rid of BUG'gers - having them in interrupt path isn't fun.
* don't return NET_XMIT_DROP when we drop (dev_kfree_skb_any)
  frames. This value is meant to ask for retransmit so we would
  corrupt the skb slab.
* locking review, corrections and improvements: particularly focus 
  on speed setting and start_xmit paths, but also reducing time
  we are staying with interrupts disabled.
* printk-cleanup: less/better syslog msgs, use IRDA_DEBUG and friends.
* default qos_mtt_bits should be 1ms or longer (0x07), not exactly 1ms
* rename IRENABLE_IREN -> IRENABLE_PHYANDCLOCK
* few minor improvements 
* compatibility stuff to preserve 2.4 backport path
* it's a pci controller, so we should depend on CONFIG_PCI
* DRIVER_VERSION 0.5


diff -u -p linux/drivers/net/irda/Kconfig.d2 linux/drivers/net/irda/Kconfig
--- linux/drivers/net/irda/Kconfig.d2	Fri Aug  8 10:18:53 2003
+++ linux/drivers/net/irda/Kconfig	Fri Aug  8 10:19:45 2003
@@ -333,7 +333,7 @@ config ALI_FIR
 
 config VLSI_FIR
 	tristate "VLSI 82C147 SIR/MIR/FIR (EXPERIMENTAL)"
-	depends on EXPERIMENTAL && IRDA
+	depends on EXPERIMENTAL && IRDA && PCI
 	help
 	  Say Y here if you want to build support for the VLSI 82C147
 	  PCI-IrDA Controller. This controller is used by the HP OmniBook 800
diff -u -p linux/include/net/irda/vlsi_ir.d2.h linux/include/net/irda/vlsi_ir.h
--- linux/include/net/irda/vlsi_ir.d2.h	Fri Aug  8 10:19:24 2003
+++ linux/include/net/irda/vlsi_ir.h	Fri Aug  8 10:19:45 2003
@@ -3,7 +3,7 @@
  *
  *	vlsi_ir.h:	VLSI82C147 PCI IrDA controller driver for Linux
  *
- *	Version:	0.4a
+ *	Version:	0.5
  *
  *	Copyright (c) 2001-2003 Martin Diehl
  *
@@ -27,18 +27,64 @@
 #ifndef IRDA_VLSI_FIR_H
 #define IRDA_VLSI_FIR_H
 
-/*
- * #if LINUX_VERSION_CODE < KERNEL_VERSION(2,5,xx)
- *
- * missing pci-dma api call to give streaming dma buffer back to hw
- * patch floating on lkml - probably present in 2.5.26 or later
- * otherwise defining it as noop is ok, since the vlsi-ir is only
- * used on two oldish x86-based notebooks which are cache-coherent
+/* ================================================================
+ * compatibility stuff
  */
-#define pci_dma_prep_single(dev, addr, size, direction)	/* nothing */
-/*
- * #endif
+
+/* definitions not present in pci_ids.h */
+
+#ifndef PCI_CLASS_WIRELESS_IRDA
+#define PCI_CLASS_WIRELESS_IRDA		0x0d00
+#endif
+
+#ifndef PCI_CLASS_SUBCLASS_MASK
+#define PCI_CLASS_SUBCLASS_MASK		0xffff
+#endif
+
+/* missing pci-dma api call to give streaming dma buffer back to hw
+ * patch was floating on lkml around 2.5.2x and might be present later.
+ * Defining it this way is ok, since the vlsi-ir is only
+ * used on two oldish x86-based notebooks which are cache-coherent
+ * (and flush_write_buffers also handles PPro errata and C3 OOstore)
  */
+#ifdef CONFIG_X86
+#include <asm-i386/io.h>
+#define pci_dma_prep_single(dev, addr, size, direction)	flush_write_buffers()
+#else
+#error missing pci dma api call
+#endif
+
+/* in recent 2.5 interrupt handlers have non-void return value */
+#ifndef IRQ_RETVAL
+typedef void irqreturn_t;
+#define IRQ_NONE
+#define IRQ_HANDLED
+#define IRQ_RETVAL(x)
+#endif
+
+/* some stuff need to check kernelversion. Not all 2.5 stuff was present
+ * in early 2.5.x - the test is merely to separate 2.4 from 2.5
+ */
+#include <linux/version.h>
+
+#if LINUX_VERSION_CODE < KERNEL_VERSION(2,5,0)
+
+/* PDE() introduced in 2.5.4 */
+#ifdef CONFIG_PROC_FS
+#define PDE(inode) ((inode)->u.generic_ip)
+#endif
+
+/* irda crc16 calculation exported in 2.5.42 */
+#define irda_calc_crc16(fcs,buf,len)	(GOOD_FCS)
+
+/* we use this for unified pci device name access */
+#define PCIDEV_NAME(pdev)	((pdev)->name)
+
+#else /* 2.5 */
+
+/* recent 2.5 stores name in struct device */
+#define PCIDEV_NAME(pdev)	((pdev)->dev.name)
+#endif
 
 /* ================================================================ */
 
@@ -138,7 +184,7 @@ enum vlsi_pci_clkctl {
  *	- IRMISC_UARTSEL configured
  *	- IRCFG_MASTER must be cleared
  *	- IRCFG_SIR must be set
- *	- IRENABLE_IREN must be asserted 0->1 (and hence IRENABLE_SIR_ON)
+ *	- IRENABLE_PHYANDCLOCK must be asserted 0->1 (and hence IRENABLE_SIR_ON)
  */
 
 enum vlsi_pci_irmisc {
@@ -298,7 +344,7 @@ enum vlsi_pio_irintr {
 /* notes:
  *	- not more than one SIR/MIR/FIR bit must be set at any time
  *	- SIR, MIR, FIR and CRC16 select the configuration which will
- *	  be applied on next 0->1 transition of IRENABLE_IREN (see below).
+ *	  be applied on next 0->1 transition of IRENABLE_PHYANDCLOCK (see below).
  *	- besides allowing the PCI interface to execute busmaster cycles
  *	  and therefore the ring SM to operate, the MSTR bit has side-effects:
  *	  when MSTR is cleared, the RINGPTR's get reset and the legacy UART mode
@@ -349,7 +395,7 @@ enum vlsi_pio_ircfg {
  */
 
 enum vlsi_pio_irenable {
-	IRENABLE_IREN		= 0x8000,  /* enable IR phy and gate the mode config (rw) */
+	IRENABLE_PHYANDCLOCK	= 0x8000,  /* enable IR phy and gate the mode config (rw) */
 	IRENABLE_CFGER		= 0x4000,  /* mode configuration error (ro) */
 	IRENABLE_FIR_ON		= 0x2000,  /* FIR on status (ro) */
 	IRENABLE_MIR_ON		= 0x1000,  /* MIR on status (ro) */
@@ -366,7 +412,7 @@ enum vlsi_pio_irenable {
 /* VLSI_PIO_PHYCTL: IR Physical Layer Current Control Register (u16, ro) */
 
 /* read-back of the currently applied physical layer status.
- * applied from VLSI_PIO_NPHYCTL at rising edge of IRENABLE_IREN
+ * applied from VLSI_PIO_NPHYCTL at rising edge of IRENABLE_PHYANDCLOCK
  * contents identical to VLSI_PIO_NPHYCTL (see below)
  */
 
@@ -374,7 +420,7 @@ enum vlsi_pio_irenable {
 
 /* VLSI_PIO_NPHYCTL: IR Physical Layer Next Control Register (u16, rw) */
 
-/* latched during IRENABLE_IREN=0 and applied at 0-1 transition
+/* latched during IRENABLE_PHYANDCLOCK=0 and applied at 0-1 transition
  *
  * consists of BAUD[15:10], PLSWID[9:5] and PREAMB[4:0] bits defined as follows:
  *
@@ -616,21 +662,22 @@ static inline void rd_set_addr_status(st
 	 */
 
 	if ((a & ~DMA_MASK_MSTRPAGE)>>24 != MSTRPAGE_VALUE) {
-		BUG();
+		printk(KERN_ERR "%s: pci busaddr inconsistency!\n", __FUNCTION__);
+		dump_stack();
 		return;
 	}
 
 	a &= DMA_MASK_MSTRPAGE;  /* clear highbyte to make sure we won't write
 				  * to status - just in case MSTRPAGE_VALUE!=0
 				  */
-	rd->hw->rd_addr = a;
+	rd->hw->rd_addr = cpu_to_le32(a);
 	wmb();
 	rd_set_status(rd, s);	 /* may pass ownership to the hardware */
 }
 
 static inline void rd_set_count(struct ring_descr *rd, u16 c)
 {
-	rd->hw->rd_count = c;
+	rd->hw->rd_count = cpu_to_le16(c);
 }
 
 static inline u8 rd_get_status(struct ring_descr *rd)
@@ -642,13 +689,13 @@ static inline dma_addr_t rd_get_addr(str
 {
 	dma_addr_t	a;
 
-	a = (rd->hw->rd_addr & DMA_MASK_MSTRPAGE) | (MSTRPAGE_VALUE << 24);
-	return a;
+	a = le32_to_cpu(rd->hw->rd_addr);
+	return (a & DMA_MASK_MSTRPAGE) | (MSTRPAGE_VALUE << 24);
 }
 
 static inline u16 rd_get_count(struct ring_descr *rd)
 {
-	return rd->hw->rd_count;
+	return le16_to_cpu(rd->hw->rd_count);
 }
 
 /******************************************************************/
diff -u -p linux/drivers/net/irda/vlsi_ir.d2.c linux/drivers/net/irda/vlsi_ir.c
--- linux/drivers/net/irda/vlsi_ir.d2.c	Fri Aug  8 10:19:01 2003
+++ linux/drivers/net/irda/vlsi_ir.c	Fri Aug  8 10:19:45 2003
@@ -21,18 +21,20 @@
  *
  ********************************************************************/
 
+#include <linux/config.h>
 #include <linux/module.h>
  
-MODULE_DESCRIPTION("IrDA SIR/MIR/FIR driver for VLSI 82C147");
-MODULE_AUTHOR("Martin Diehl <info@mdiehl.de>");
-MODULE_LICENSE("GPL");
+#define DRIVER_NAME 		"vlsi_ir"
+#define DRIVER_VERSION		"v0.5"
+#define DRIVER_DESCRIPTION	"IrDA SIR/MIR/FIR driver for VLSI 82C147"
+#define DRIVER_AUTHOR		"Martin Diehl <info@mdiehl.de>"
 
-#define DRIVER_NAME "vlsi_ir"
-#define DRIVER_VERSION "v0.4a"
+MODULE_DESCRIPTION(DRIVER_DESCRIPTION);
+MODULE_AUTHOR(DRIVER_AUTHOR);
+MODULE_LICENSE("GPL");
 
 /********************************************************/
 
-#include <linux/config.h>
 #include <linux/kernel.h>
 #include <linux/init.h>
 #include <linux/pci.h>
@@ -44,10 +46,12 @@ MODULE_LICENSE("GPL");
 #include <linux/proc_fs.h>
 #include <linux/smp_lock.h>
 #include <asm/uaccess.h>
+#include <asm/byteorder.h>
 
 #include <net/irda/irda.h>
 #include <net/irda/irda_device.h>
 #include <net/irda/wrapper.h>
+#include <net/irda/crc.h>
 
 #include <net/irda/vlsi_ir.h>
 
@@ -55,14 +59,16 @@ MODULE_LICENSE("GPL");
 
 static /* const */ char drivername[] = DRIVER_NAME;
 
-#define PCI_CLASS_WIRELESS_IRDA 0x0d00
-
-static struct pci_device_id vlsi_irda_table [] __devinitdata = { {
-
-	.class =        PCI_CLASS_WIRELESS_IRDA << 8,
-	.vendor =       PCI_VENDOR_ID_VLSI,
-	.device =       PCI_DEVICE_ID_VLSI_82C147,
-	}, { /* all zeroes */ }
+static struct pci_device_id vlsi_irda_table [] __devinitdata = {
+	{
+		.class =        PCI_CLASS_WIRELESS_IRDA << 8,
+		.class_mask =	PCI_CLASS_SUBCLASS_MASK << 8, 
+		.vendor =       PCI_VENDOR_ID_VLSI,
+		.device =       PCI_DEVICE_ID_VLSI_82C147,
+		.subvendor = 	PCI_ANY_ID,
+		.subdevice =	PCI_ANY_ID,
+	},
+	{ /* all zeroes */ }
 };
 
 MODULE_DEVICE_TABLE(pci, vlsi_irda_table);
@@ -114,7 +120,7 @@ static int sirpulse = 1;		/* default is 
 
 MODULE_PARM(qos_mtt_bits, "i");
 MODULE_PARM_DESC(qos_mtt_bits, "IrLAP bitfield representing min-turn-time");
-static int qos_mtt_bits = 0x04;		/* default is 1 ms */
+static int qos_mtt_bits = 0x07;		/* default is 1 ms or more */
 
 /********************************************************/
 
@@ -164,7 +170,7 @@ static int vlsi_proc_pdev(struct pci_dev
 		return 0;
 
 	out += sprintf(out, "\n%s (vid/did: %04x/%04x)\n",
-			pdev->dev.name, (int)pdev->vendor, (int)pdev->device);
+			PCIDEV_NAME(pdev), (int)pdev->vendor, (int)pdev->device);
 	out += sprintf(out, "pci-power-state: %u\n", (unsigned) pdev->current_state);
 	out += sprintf(out, "resources: irq=%u / io=0x%04x / dma_mask=0x%016Lx\n",
 			pdev->irq, (unsigned)pci_resource_start(pdev, 0), (u64)pdev->dma_mask);
@@ -198,13 +204,13 @@ static int vlsi_proc_ndev(struct net_dev
 
 	out += sprintf(out, "\nhw-state:\n");
 	pci_read_config_byte(idev->pdev, VLSI_PCI_IRMISC, &byte);
-	out += sprintf(out, "IRMISC:%s%s%s UART%s",
+	out += sprintf(out, "IRMISC:%s%s%s uart%s",
 		(byte&IRMISC_IRRAIL) ? " irrail" : "",
 		(byte&IRMISC_IRPD) ? " irpd" : "",
 		(byte&IRMISC_UARTTST) ? " uarttest" : "",
-		(byte&IRMISC_UARTEN) ? "" : " disabled\n");
+		(byte&IRMISC_UARTEN) ? "@" : " disabled\n");
 	if (byte&IRMISC_UARTEN) {
-		out += sprintf(out, "@0x%s\n",
+		out += sprintf(out, "0x%s\n",
 			(byte&2) ? ((byte&1) ? "3e8" : "2e8")
 				 : ((byte&1) ? "3f8" : "2f8"));
 	}
@@ -254,7 +260,7 @@ static int vlsi_proc_ndev(struct net_dev
 		(word&IRCFG_RXPOL) ? " RXPOL" : "");
 	word = inw(iobase+VLSI_PIO_IRENABLE);
 	out += sprintf(out, "IRENABLE:%s%s%s%s%s%s%s%s\n",
-		(word&IRENABLE_IREN) ? " IRENABLE" : "",
+		(word&IRENABLE_PHYANDCLOCK) ? " PHYANDCLOCK" : "",
 		(word&IRENABLE_CFGER) ? " CFGERR" : "",
 		(word&IRENABLE_FIR_ON) ? " FIR_ON" : "",
 		(word&IRENABLE_MIR_ON) ? " MIR_ON" : "",
@@ -358,7 +364,7 @@ static int vlsi_proc_print(struct net_de
 	char *out = buf;
 
 	if (!ndev || !ndev->priv) {
-		printk(KERN_ERR "%s: invalid ptr!\n", __FUNCTION__);
+		ERROR("%s: invalid ptr!\n", __FUNCTION__);
 		return 0;
 	}
 
@@ -539,7 +545,14 @@ static struct vlsi_ring *vlsi_alloc_ring
 		memset(rd, 0, sizeof(*rd));
 		rd->hw = hwmap + i;
 		rd->buf = kmalloc(len, GFP_KERNEL|GFP_DMA);
-		if (rd->buf == NULL) {
+		if (rd->buf == NULL
+		    ||  !(busaddr = pci_map_single(pdev, rd->buf, len, dir))) {
+			if (rd->buf) {
+				ERROR("%s: failed to create PCI-MAP for %p",
+					__FUNCTION__, rd->buf);
+				kfree(rd->buf);
+				rd->buf = NULL;
+			}
 			for (j = 0; j < i; j++) {
 				rd = r->rd + j;
 				busaddr = rd_get_addr(rd);
@@ -552,12 +565,6 @@ static struct vlsi_ring *vlsi_alloc_ring
 			kfree(r);
 			return NULL;
 		}
-		busaddr = pci_map_single(pdev, rd->buf, len, dir);
-		if (!busaddr) {
-			printk(KERN_ERR "%s: failed to create PCI-MAP for %p",
-				__FUNCTION__, rd->buf);
-			BUG();
-		}
 		rd_set_addr_status(rd, busaddr, 0);
 		pci_dma_sync_single(pdev, busaddr, len, dir);
 		/* initially, the dma buffer is owned by the CPU */
@@ -597,8 +604,7 @@ static int vlsi_create_hwif(vlsi_irda_de
 
 	ringarea = pci_alloc_consistent(idev->pdev, HW_RING_AREA_SIZE, &idev->busaddr);
 	if (!ringarea) {
-		printk(KERN_ERR "%s: insufficient memory for descriptor rings\n",
-			__FUNCTION__);
+		ERROR("%s: insufficient memory for descriptor rings\n", __FUNCTION__);
 		goto out;
 	}
 	memset(ringarea, 0, HW_RING_AREA_SIZE);
@@ -666,33 +672,52 @@ static int vlsi_process_rx(struct vlsi_r
 			ret |= VLSI_RX_FRAME;
 		if (status & RD_RX_CRCERR)  
 			ret |= VLSI_RX_CRC;
+		goto done;
 	}
-	else {
-		len = rd_get_count(rd);
-		crclen = (idev->mode==IFF_FIR) ? sizeof(u32) : sizeof(u16);
-		len -= crclen;		/* remove trailing CRC */
-		if (len <= 0) {
-			printk(KERN_ERR "%s: strange frame (len=%d)\n",
-				__FUNCTION__, len);
-			ret |= VLSI_RX_DROP;
-		}
-		else if (!rd->skb) {
-			printk(KERN_ERR "%s: rx packet dropped\n", __FUNCTION__);
-			ret |= VLSI_RX_DROP;
-		}
-		else {
-			skb = rd->skb;
-			rd->skb = NULL;
-			skb->dev = ndev;
-			memcpy(skb_put(skb,len), rd->buf, len);
-			skb->mac.raw = skb->data;
-			if (in_interrupt())
-				netif_rx(skb);
-			else
-				netif_rx_ni(skb);
-			ndev->last_rx = jiffies;
+
+	len = rd_get_count(rd);
+	crclen = (idev->mode==IFF_FIR) ? sizeof(u32) : sizeof(u16);
+	len -= crclen;		/* remove trailing CRC */
+	if (len <= 0) {
+		IRDA_DEBUG(0, "%s: strange frame (len=%d)\n", __FUNCTION__, len);
+		ret |= VLSI_RX_DROP;
+		goto done;
+	}
+
+	if (idev->mode == IFF_SIR) {	/* hw checks CRC in MIR, FIR mode */
+
+		/* rd->buf is a streaming PCI_DMA_FROMDEVICE map. Doing the
+		 * endian-adjustment there just in place will dirty a cache line
+		 * which belongs to the map and thus we must be sure it will
+		 * get flushed before giving the buffer back to hardware.
+		 * vlsi_fill_rx() will do this anyway - but here we rely on.
+		 */
+		le16_to_cpus(rd->buf+len);
+		if (irda_calc_crc16(INIT_FCS,rd->buf,len+crclen) != GOOD_FCS) {
+			IRDA_DEBUG(0, "%s: crc error\n", __FUNCTION__);
+			ret |= VLSI_RX_CRC;
+			goto done;
 		}
 	}
+
+	if (!rd->skb) {
+		WARNING("%s: rx packet lost\n", __FUNCTION__);
+		ret |= VLSI_RX_DROP;
+		goto done;
+	}
+
+	skb = rd->skb;
+	rd->skb = NULL;
+	skb->dev = ndev;
+	memcpy(skb_put(skb,len), rd->buf, len);
+	skb->mac.raw = skb->data;
+	if (in_interrupt())
+		netif_rx(skb);
+	else
+		netif_rx_ni(skb);
+	ndev->last_rx = jiffies;
+
+done:
 	rd_set_status(rd, 0);
 	rd_set_count(rd, 0);
 	/* buffer still owned by CPU */
@@ -706,7 +731,9 @@ static void vlsi_fill_rx(struct vlsi_rin
 
 	for (rd = ring_last(r); rd != NULL; rd = ring_put(r)) {
 		if (rd_is_active(rd)) {
-			BUG();
+			WARNING("%s: driver bug: rx descr race with hw\n",
+				__FUNCTION__);
+			vlsi_ring_debug(r);
 			break;
 		}
 		if (!rd->skb) {
@@ -764,7 +791,7 @@ static void vlsi_rx_interrupt(struct net
 
 	if (ring_first(r) == NULL) {
 		/* we are in big trouble, if this should ever happen */
-		printk(KERN_ERR "%s: rx ring exhausted!\n", __FUNCTION__);
+		ERROR("%s: rx ring exhausted!\n", __FUNCTION__);
 		vlsi_ring_debug(r);
 	}
 	else
@@ -785,7 +812,7 @@ static void vlsi_unarm_rx(vlsi_irda_dev_
 		if (rd_is_active(rd)) {
 			rd_set_status(rd, 0);
 			if (rd_get_count(rd)) {
-				printk(KERN_INFO "%s - dropping rx packet\n", __FUNCTION__);
+				IRDA_DEBUG(0, "%s - dropping rx packet\n", __FUNCTION__);
 				ret = -VLSI_RX_DROP;
 			}
 			rd_set_count(rd, 0);
@@ -850,24 +877,16 @@ static int vlsi_process_tx(struct vlsi_r
 	return (ret) ? -ret : len;
 }
 
-static int vlsi_set_baud(struct net_device *ndev, int dolock)
+static int vlsi_set_baud(vlsi_irda_dev_t *idev, unsigned iobase)
 {
-	vlsi_irda_dev_t *idev = ndev->priv;
-	unsigned long flags;
 	u16 nphyctl;
-	unsigned iobase; 
 	u16 config;
 	unsigned mode;
-	unsigned idle_retry;
 	int	ret;
 	int	baudrate;
-	int	fifocnt = 0;	/* Keep compiler happy */
+	int	fifocnt;
 
 	baudrate = idev->new_baud;
-	iobase = ndev->base_addr;
-#if 0
-	printk(KERN_DEBUG "%s: %d -> %d\n", __FUNCTION__, idev->baud, idev->new_baud);
-#endif
 	if (baudrate == 4000000) {
 		mode = IFF_FIR;
 		config = IRCFG_FIR;
@@ -883,7 +902,7 @@ static int vlsi_set_baud(struct net_devi
 		config = IRCFG_SIR | IRCFG_SIRFILT  | IRCFG_RXANY;
 		switch(baudrate) {
 			default:
-				printk(KERN_ERR "%s: undefined baudrate %d - fallback to 9600!\n",
+				WARNING("%s: undefined baudrate %d - fallback to 9600!\n",
 					__FUNCTION__, baudrate);
 				baudrate = 9600;
 				/* fallthru */
@@ -897,40 +916,18 @@ static int vlsi_set_baud(struct net_devi
 				break;
 		}
 	}
+	config |= IRCFG_MSTR | IRCFG_ENRX;
 
-	if (dolock)
-		spin_lock_irqsave(&idev->lock, flags);
-	else
-		flags = 0xdead;	/* prevent bogus warning about possible uninitialized use */
-
-	for (idle_retry=0; idle_retry < 100; idle_retry++) {
-		fifocnt = inw(ndev->base_addr+VLSI_PIO_RCVBCNT) & RCVBCNT_MASK;
-		if (fifocnt == 0)
-			break;
-		if (!idle_retry)
-			printk(KERN_WARNING "%s: waiting for rx fifo to become empty(%d)\n",
-				__FUNCTION__, fifocnt);
-		if (dolock) {
-			spin_unlock_irqrestore(&idev->lock, flags);
-			udelay(100);
-			spin_lock_irqsave(&idev->lock, flags);
-		}
-		else
-			udelay(100);
+	fifocnt = inw(iobase+VLSI_PIO_RCVBCNT) & RCVBCNT_MASK;
+	if (fifocnt != 0) {
+		IRDA_DEBUG(0, "%s: rx fifo not empty(%d)\n", __FUNCTION__, fifocnt);
 	}
-	if (fifocnt != 0)
-		printk(KERN_ERR "%s: rx fifo not empty(%d)\n", __FUNCTION__, fifocnt);
 
 	outw(0, iobase+VLSI_PIO_IRENABLE);
-	wmb();
-
-	config |= IRCFG_MSTR | IRCFG_ENRX;
-
 	outw(config, iobase+VLSI_PIO_IRCFG);
-
 	outw(nphyctl, iobase+VLSI_PIO_NPHYCTL);
 	wmb();
-	outw(IRENABLE_IREN, iobase+VLSI_PIO_IRENABLE);
+	outw(IRENABLE_PHYANDCLOCK, iobase+VLSI_PIO_IRENABLE);
 	mb();
 
 	udelay(1);	/* chip applies IRCFG on next rising edge of its 8MHz clock */
@@ -946,14 +943,14 @@ static int vlsi_set_baud(struct net_devi
 	else
 		config ^= IRENABLE_SIR_ON;
 
-	if (config != (IRENABLE_IREN|IRENABLE_ENRXST)) {
-		printk(KERN_ERR "%s: failed to set %s mode!\n", __FUNCTION__,
+	if (config != (IRENABLE_PHYANDCLOCK|IRENABLE_ENRXST)) {
+		WARNING("%s: failed to set %s mode!\n", __FUNCTION__,
 			(mode==IFF_SIR)?"SIR":((mode==IFF_MIR)?"MIR":"FIR"));
 		ret = -1;
 	}
 	else {
 		if (inw(iobase+VLSI_PIO_PHYCTL) != nphyctl) {
-			printk(KERN_ERR "%s: failed to apply baudrate %d\n",
+			WARNING("%s: failed to apply baudrate %d\n",
 				__FUNCTION__, baudrate);
 			ret = -1;
 		}
@@ -964,8 +961,6 @@ static int vlsi_set_baud(struct net_devi
 			ret = 0;
 		}
 	}
-	if (dolock)
-		spin_unlock_irqrestore(&idev->lock, flags);
 
 	if (ret)
 		vlsi_reg_debug(iobase,__FUNCTION__);
@@ -975,12 +970,14 @@ static int vlsi_set_baud(struct net_devi
 
 static inline int vlsi_set_baud_lock(struct net_device *ndev)
 {
-	return vlsi_set_baud(ndev, 1);
-}
+	vlsi_irda_dev_t *idev = ndev->priv;
+	unsigned long flags;
+	int ret;
 
-static inline int vlsi_set_baud_nolock(struct net_device *ndev)
-{
-	return vlsi_set_baud(ndev, 0);
+	spin_lock_irqsave(&idev->lock, flags);
+	ret = vlsi_set_baud(idev, ndev->base_addr);
+	spin_unlock_irqrestore(&idev->lock, flags);
+	return ret;
 }
 
 static int vlsi_hard_start_xmit(struct sk_buff *skb, struct net_device *ndev)
@@ -995,79 +992,100 @@ static int vlsi_hard_start_xmit(struct s
 	int mtt;
 	int len, speed;
 	struct timeval  now, ready;
+	char *msg = NULL;
 
 	speed = irda_get_next_speed(skb);
+	spin_lock_irqsave(&idev->lock, flags);
 	if (speed != -1  &&  speed != idev->baud) {
 		netif_stop_queue(ndev);
 		idev->new_baud = speed;
-		if (!skb->len) {
-			dev_kfree_skb_any(skb);
-
-			/* due to the completely asynch tx operation we might have
-			 * IrLAP racing with the hardware here, f.e. if the controller
-			 * is just sending the last packet with current speed while
-			 * the LAP is already switching the speed using synchronous
-			 * len=0 packet. Immediate execution would lead to hw lockup
-			 * requiring a powercycle to reset. Good candidate to trigger
-			 * this is the final UA:RSP packet after receiving a DISC:CMD
-			 * when getting the LAP down.
-			 * Note that we are not protected by the queue_stop approach
-			 * because the final UA:RSP arrives _without_ request to apply
-			 * new-speed-after-this-packet - hence the driver doesn't know
-			 * this was the last packet and doesn't stop the queue. So the
-			 * forced switch to default speed from LAP gets through as fast
-			 * as only some 10 usec later while the UA:RSP is still processed
-			 * by the hardware and we would get screwed.
-			 * Note: no locking required since we (netdev->xmit) are the only
-			 * supplier for tx and the network layer provides serialization
-			 */
-			spin_lock_irqsave(&idev->lock, flags);
-			if (ring_first(idev->tx_ring) == NULL) {
-				/* no race - tx-ring already empty */
-				vlsi_set_baud_nolock(ndev);
-				netif_wake_queue(ndev);
-			}
-			else
-				; /* keep the speed change pending like it would
-				   * for any len>0 packet. tx completion interrupt
-				   * will apply it when the tx ring becomes empty.
-				   */
-			spin_unlock_irqrestore(&idev->lock, flags);
-			return 0;
-		}
 		status = RD_TX_CLRENTX;  /* stop tx-ring after this frame */
 	}
 	else
 		status = 0;
 
 	if (skb->len == 0) {
-		printk(KERN_ERR "%s: dropping len=0 packet\n", __FUNCTION__);
-		goto drop;
+		/* handle zero packets - should be speed change */
+		if (status == 0) {
+			msg = "bogus zero-length packet";
+			goto drop_unlock;
+		}
+
+		/* due to the completely asynch tx operation we might have
+		 * IrLAP racing with the hardware here, f.e. if the controller
+		 * is just sending the last packet with current speed while
+		 * the LAP is already switching the speed using synchronous
+		 * len=0 packet. Immediate execution would lead to hw lockup
+		 * requiring a powercycle to reset. Good candidate to trigger
+		 * this is the final UA:RSP packet after receiving a DISC:CMD
+		 * when getting the LAP down.
+		 * Note that we are not protected by the queue_stop approach
+		 * because the final UA:RSP arrives _without_ request to apply
+		 * new-speed-after-this-packet - hence the driver doesn't know
+		 * this was the last packet and doesn't stop the queue. So the
+		 * forced switch to default speed from LAP gets through as fast
+		 * as only some 10 usec later while the UA:RSP is still processed
+		 * by the hardware and we would get screwed.
+		 */
+
+		if (ring_first(idev->tx_ring) == NULL) {
+			/* no race - tx-ring already empty */
+			vlsi_set_baud(idev, ndev->base_addr);
+			netif_wake_queue(ndev);
+		}
+		else
+			;
+			/* keep the speed change pending like it would
+			 * for any len>0 packet. tx completion interrupt
+			 * will apply it when the tx ring becomes empty.
+			 */
+		spin_unlock_irqrestore(&idev->lock, flags);
+		dev_kfree_skb_any(skb);
+		return 0;
 	}
 
-	/* sanity checks - should never happen!
-	 * simply BUGging the violation and dropping the packet
-	 */
+	/* sanity checks - simply drop the packet */
 
 	rd = ring_last(r);
-	if (!rd) {				/* ring full - queue should have been stopped! */
-		BUG();
-		goto drop;
+	if (!rd) {
+		msg = "ring full, but queue wasn't stopped";
+		goto drop_unlock;
 	}
 
-	if (rd_is_active(rd)) {			/* entry still owned by hw! */
-		BUG();
-		goto drop;
+	if (rd_is_active(rd)) {
+		msg = "entry still owned by hw";
+		goto drop_unlock;
 	}
 
-	if (!rd->buf) {				/* no memory for this tx entry - weird! */
-		BUG();
-		goto drop;
+	if (!rd->buf) {
+		msg = "tx ring entry without pci buffer";
+		goto drop_unlock;
 	}
 
-	if (rd->skb) {				/* hm, associated old skb still there */
-		BUG();
-		goto drop;
+	if (rd->skb) {
+		msg = "ring entry with old skb still attached";
+		goto drop_unlock;
+	}
+
+	/* no need for serialization or interrupt disable during mtt */
+	spin_unlock_irqrestore(&idev->lock, flags);
+
+	if ((mtt = irda_get_mtt(skb)) > 0) {
+	
+		ready.tv_usec = idev->last_rx.tv_usec + mtt;
+		ready.tv_sec = idev->last_rx.tv_sec;
+		if (ready.tv_usec >= 1000000) {
+			ready.tv_usec -= 1000000;
+			ready.tv_sec++;		/* IrLAP 1.1: mtt always < 1 sec */
+		}
+		for(;;) {
+			do_gettimeofday(&now);
+			if (now.tv_sec > ready.tv_sec
+			    ||  (now.tv_sec==ready.tv_sec && now.tv_usec>=ready.tv_usec))
+			    	break;
+			udelay(100);
+			/* must not sleep here - we are called under xmit_lock! */
+		}
 	}
 
 	/* tx buffer already owned by CPU due to pci_dma_sync_single() either
@@ -1089,7 +1107,7 @@ static int vlsi_hard_start_xmit(struct s
 		 */
 
 		if (len >= r->len-5)
-			 printk(KERN_WARNING "%s: possible buffer overflow with SIR wrapping!\n",
+			 WARNING("%s: possible buffer overflow with SIR wrapping!\n",
 			 	__FUNCTION__);
 	}
 	else {
@@ -1097,34 +1115,13 @@ static int vlsi_hard_start_xmit(struct s
 		status |= RD_TX_PULSE;		/* send 2 us highspeed indication pulse */
 		len = skb->len;
 		if (len > r->len) {
-			printk(KERN_ERR "%s: no space - skb too big (%d)\n",
-				__FUNCTION__, skb->len);
+			msg = "frame exceeds tx buffer length";
 			goto drop;
 		}
 		else
 			memcpy(rd->buf, skb->data, len);
 	}
 
-	/* do mtt delay before we need to disable interrupts! */
-
-	if ((mtt = irda_get_mtt(skb)) > 0) {
-	
-		ready.tv_usec = idev->last_rx.tv_usec + mtt;
-		ready.tv_sec = idev->last_rx.tv_sec;
-		if (ready.tv_usec >= 1000000) {
-			ready.tv_usec -= 1000000;
-			ready.tv_sec++;		/* IrLAP 1.1: mtt always < 1 sec */
-		}
-		for(;;) {
-			do_gettimeofday(&now);
-			if (now.tv_sec > ready.tv_sec
-			    ||  (now.tv_sec==ready.tv_sec && now.tv_usec>=ready.tv_usec))
-			    	break;
-			udelay(100);
-			/* must not sleep here - we are called under xmit_lock! */
-		}
-	}
-
 	rd->skb = skb;			/* remember skb for tx-complete stats */
 
 	rd_set_count(rd, len);
@@ -1136,10 +1133,7 @@ static int vlsi_hard_start_xmit(struct s
 
 	pci_dma_prep_single(r->pdev, rd_get_addr(rd), r->len, r->dir);
 
-/*
- *	We need to disable IR output in order to switch to TX mode.
- *	Better not do this blindly anytime we want to transmit something
- *	because TX may already run. However we are racing with the controller
+/*	Switching to TX mode here races with the controller
  *	which may stop TX at any time when fetching an inactive descriptor
  *	or one with CLR_ENTX set. So we switch on TX only, if TX was not running
  *	_after_ the new descriptor was activated on the ring. This ensures
@@ -1158,31 +1152,38 @@ static int vlsi_hard_start_xmit(struct s
 		int fifocnt;
 
 		fifocnt = inw(ndev->base_addr+VLSI_PIO_RCVBCNT) & RCVBCNT_MASK;
-		if (fifocnt != 0)
-			printk(KERN_WARNING "%s: rx fifo not empty(%d)\n",
-				__FUNCTION__, fifocnt);
+		if (fifocnt != 0) {
+			IRDA_DEBUG(0, "%s: rx fifo not empty(%d)\n", __FUNCTION__, fifocnt);
+		}
 
 		config = inw(iobase+VLSI_PIO_IRCFG);
-		rmb();
-		outw(config | IRCFG_ENTX, iobase+VLSI_PIO_IRCFG);
 		mb();
+		outw(config | IRCFG_ENTX, iobase+VLSI_PIO_IRCFG);
+		wmb();
 		outw(0, iobase+VLSI_PIO_PROMPT);
 	}
 	ndev->trans_start = jiffies;
 
-	if (ring_put(r) == NULL) {
+	if (ring_put(r) == NULL)	/* stop queue if tx ring is full */
 		netif_stop_queue(ndev);
-		printk(KERN_DEBUG "%s: tx ring full - queue stopped\n", __FUNCTION__);
-	}
+
 	spin_unlock_irqrestore(&idev->lock, flags);
 
 	return 0;
 
+drop_unlock:
+	spin_unlock_irqrestore(&idev->lock, flags);
 drop:
+	WARNING("%s: dropping packet - %s\n", __FUNCTION__, msg);
 	dev_kfree_skb_any(skb);
 	idev->stats.tx_errors++;
 	idev->stats.tx_dropped++;
-	return 1;
+	/* Don't even think about returning NET_XMIT_DROP (=1) here!
+	 * In fact any retval!=0 causes the packet scheduler to requeue the
+	 * packet for later retry of transmission - which isn't exactly
+	 * what we want after we've just called dev_kfree_skb_any ;-)
+	 */
+	return 0;
 }
 
 static void vlsi_tx_interrupt(struct net_device *ndev)
@@ -1215,12 +1216,12 @@ static void vlsi_tx_interrupt(struct net
 		}
 	}
 
+	iobase = ndev->base_addr;
+
 	if (idev->new_baud  &&  rd == NULL)	/* tx ring empty and speed change pending */
-		vlsi_set_baud_lock(ndev);
+		vlsi_set_baud(idev, iobase);
 
-	iobase = ndev->base_addr;
 	config = inw(iobase+VLSI_PIO_IRCFG);
-
 	if (rd == NULL)			/* tx ring empty: re-enable rx */
 		outw((config & ~IRCFG_ENTX) | IRCFG_ENRX, iobase+VLSI_PIO_IRCFG);
 
@@ -1228,18 +1229,17 @@ static void vlsi_tx_interrupt(struct net
 		int fifocnt;
 
 		fifocnt = inw(iobase+VLSI_PIO_RCVBCNT) & RCVBCNT_MASK;
-		if (fifocnt != 0)
-			printk(KERN_WARNING "%s: rx fifo not empty(%d)\n",
+		if (fifocnt != 0) {
+			IRDA_DEBUG(0, "%s: rx fifo not empty(%d)\n",
 				__FUNCTION__, fifocnt);
+		}
 		outw(config | IRCFG_ENTX, iobase+VLSI_PIO_IRCFG);
 	}
 
 	outw(0, iobase+VLSI_PIO_PROMPT);
 
-	if (netif_queue_stopped(ndev)  &&  !idev->new_baud) {
+	if (netif_queue_stopped(ndev)  &&  !idev->new_baud)
 		netif_wake_queue(ndev);
-		printk(KERN_DEBUG "%s: queue awoken\n", __FUNCTION__);
-	}
 }
 
 /* caller must have stopped the controller from busmastering */
@@ -1261,7 +1261,7 @@ static void vlsi_unarm_tx(vlsi_irda_dev_
 				dev_kfree_skb_any(rd->skb);
 				rd->skb = NULL;
 			}
-			printk(KERN_INFO "%s - dropping tx packet\n", __FUNCTION__);
+			IRDA_DEBUG(0, "%s - dropping tx packet\n", __FUNCTION__);
 			ret = -VLSI_TX_DROP;
 		}
 		else
@@ -1310,8 +1310,7 @@ static int vlsi_start_clock(struct pci_d
 		}
 		if (count < 3) {
 			if (clksrc == 1) { /* explicitly asked for PLL hence bail out */
-				printk(KERN_ERR "%s: no PLL or failed to lock!\n",
-					__FUNCTION__);
+				ERROR("%s: no PLL or failed to lock!\n", __FUNCTION__);
 				clkctl = CLKCTL_CLKSTP;
 				pci_write_config_byte(pdev, VLSI_PCI_CLKCTL, clkctl);
 				return -1;
@@ -1319,7 +1318,7 @@ static int vlsi_start_clock(struct pci_d
 			else			/* was: clksrc=0(auto) */
 				clksrc = 3;	/* fallback to 40MHz XCLK (OB800) */
 
-			printk(KERN_INFO "%s: PLL not locked, fallback to clksrc=%d\n",
+			IRDA_DEBUG(0, "%s: PLL not locked, fallback to clksrc=%d\n",
 				__FUNCTION__, clksrc);
 		}
 		else
@@ -1392,8 +1391,7 @@ static int vlsi_init_chip(struct pci_dev
 	/* start the clock and clean the registers */
 
 	if (vlsi_start_clock(pdev)) {
-		printk(KERN_ERR "%s: no valid clock source\n",
-			__FUNCTION__);
+		ERROR("%s: no valid clock source\n", __FUNCTION__);
 		pci_disable_device(pdev);
 		return -1;
 	}
@@ -1422,7 +1420,7 @@ static int vlsi_init_chip(struct pci_dev
 	atomic_set(&idev->tx_ring->head, RINGPTR_GET_TX(ptr));
 	atomic_set(&idev->tx_ring->tail, RINGPTR_GET_TX(ptr));
 
-	vlsi_set_baud_lock(ndev);	/* idev->new_baud used as provided by caller */
+	vlsi_set_baud(idev, iobase);	/* idev->new_baud used as provided by caller */
 
 	outb(IRINTR_INT_MASK, iobase+VLSI_PIO_IRINTR);	/* just in case - w/c pending IRQ's */
 	wmb();
@@ -1476,10 +1474,11 @@ static int vlsi_stop_hw(vlsi_irda_dev_t 
 	spin_lock_irqsave(&idev->lock,flags);
 	outw(0, iobase+VLSI_PIO_IRENABLE);
 	outw(0, iobase+VLSI_PIO_IRCFG);			/* disable everything */
-	wmb();
 
-	outb(IRINTR_INT_MASK, iobase+VLSI_PIO_IRINTR);	/* w/c pending + disable further IRQ */
-	mb();
+	/* disable and w/c irqs */
+	outb(0, iobase+VLSI_PIO_IRINTR);
+	wmb();
+	outb(IRINTR_INT_MASK, iobase+VLSI_PIO_IRINTR);
 	spin_unlock_irqrestore(&idev->lock,flags);
 
 	vlsi_unarm_tx(idev);
@@ -1521,8 +1520,8 @@ static void vlsi_tx_timeout(struct net_d
 		idev->new_baud = idev->baud;		/* keep current baudrate */
 
 	if (vlsi_start_hw(idev))
-		printk(KERN_CRIT "%s: failed to restart hw - %s(%s) unusable!\n",
-			__FUNCTION__, idev->pdev->dev.name, ndev->name);
+		ERROR("%s: failed to restart hw - %s(%s) unusable!\n",
+			__FUNCTION__, PCIDEV_NAME(idev->pdev), ndev->name);
 	else
 		netif_start_queue(ndev);
 }
@@ -1547,7 +1546,7 @@ static int vlsi_ioctl(struct net_device 
 			 * if the stack tries to change speed concurrently - which would be
 			 * pretty strange anyway with the userland having full control...
 			 */
-			vlsi_set_baud_nolock(ndev);
+			vlsi_set_baud(idev, ndev->base_addr);
 			spin_unlock_irqrestore(&idev->lock, flags);
 			break;
 		case SIOCSMEDIABUSY:
@@ -1566,8 +1565,7 @@ static int vlsi_ioctl(struct net_device 
 			irq->ifr_receiving = (fifocnt!=0) ? 1 : 0;
 			break;
 		default:
-			printk(KERN_ERR "%s: notsupp - cmd=%04x\n",
-				__FUNCTION__, cmd);
+			WARNING("%s: notsupp - cmd=%04x\n", __FUNCTION__, cmd);
 			ret = -EOPNOTSUPP;
 	}	
 	
@@ -1583,41 +1581,36 @@ static irqreturn_t vlsi_interrupt(int ir
 	vlsi_irda_dev_t *idev = ndev->priv;
 	unsigned	iobase;
 	u8		irintr;
-	int 		boguscount = 32;
-	unsigned	got_act;
+	int 		boguscount = 5;
 	unsigned long	flags;
 	int		handled = 0;
 
-	got_act = 0;
 	iobase = ndev->base_addr;
+	spin_lock_irqsave(&idev->lock,flags);
 	do {
-		spin_lock_irqsave(&idev->lock,flags);
 		irintr = inb(iobase+VLSI_PIO_IRINTR);
-		rmb();
-		outb(irintr, iobase+VLSI_PIO_IRINTR); /* acknowledge asap */
-		spin_unlock_irqrestore(&idev->lock,flags);
+		mb();
+		outb(irintr, iobase+VLSI_PIO_IRINTR);	/* acknowledge asap */
 
 		if (!(irintr&=IRINTR_INT_MASK))		/* not our INT - probably shared */
 			break;
+
 		handled = 1;
+
+		if (unlikely(!(irintr & ~IRINTR_ACTIVITY)))
+			break;				/* nothing todo if only activity */
+
 		if (irintr&IRINTR_RPKTINT)
 			vlsi_rx_interrupt(ndev);
 
 		if (irintr&IRINTR_TPKTINT)
 			vlsi_tx_interrupt(ndev);
 
-		if (!(irintr & ~IRINTR_ACTIVITY))
-			break;		/* done if only activity remaining */
-	
-		if (irintr & ~(IRINTR_RPKTINT|IRINTR_TPKTINT|IRINTR_ACTIVITY)) {
-			printk(KERN_DEBUG "%s: IRINTR = %02x\n",
-				__FUNCTION__, (unsigned)irintr);
-			vlsi_reg_debug(iobase,__FUNCTION__);
-		}			
 	} while (--boguscount > 0);
+	spin_unlock_irqrestore(&idev->lock,flags);
 
 	if (boguscount <= 0)
-		printk(KERN_WARNING "%s: too much work in interrupt!\n", __FUNCTION__);
+		MESSAGE("%s: too much work in interrupt!\n", __FUNCTION__);
 	return IRQ_RETVAL(handled);
 }
 
@@ -1630,7 +1623,7 @@ static int vlsi_open(struct net_device *
 	char	hwname[32];
 
 	if (pci_request_regions(idev->pdev, drivername)) {
-		printk(KERN_ERR "%s: io resource busy\n", __FUNCTION__);
+		WARNING("%s: io resource busy\n", __FUNCTION__);
 		goto errout;
 	}
 	ndev->base_addr = pci_resource_start(idev->pdev,0);
@@ -1644,8 +1637,7 @@ static int vlsi_open(struct net_device *
 
 	if (request_irq(ndev->irq, vlsi_interrupt, SA_SHIRQ,
 			drivername, ndev)) {
-		printk(KERN_ERR "%s: couldn't get IRQ: %d\n",
-			__FUNCTION__, ndev->irq);
+		WARNING("%s: couldn't get IRQ: %d\n", __FUNCTION__, ndev->irq);
 		goto errout_io;
 	}
 
@@ -1666,7 +1658,7 @@ static int vlsi_open(struct net_device *
 
 	netif_start_queue(ndev);
 
-	printk(KERN_INFO "%s: device %s operational\n", __FUNCTION__, ndev->name);
+	MESSAGE("%s: device %s operational\n", __FUNCTION__, ndev->name);
 
 	return 0;
 
@@ -1700,7 +1692,7 @@ static int vlsi_close(struct net_device 
 
 	pci_release_regions(idev->pdev);
 
-	printk(KERN_INFO "%s: device %s stopped\n", __FUNCTION__, ndev->name);
+	MESSAGE("%s: device %s stopped\n", __FUNCTION__, ndev->name);
 
 	return 0;
 }
@@ -1721,8 +1713,7 @@ static int vlsi_irda_init(struct net_dev
 
 	if (pci_set_dma_mask(pdev,DMA_MASK_USED_BY_HW)
 	    || pci_set_dma_mask(pdev,DMA_MASK_MSTRPAGE)) {
-		printk(KERN_ERR "%s: aborting due to PCI BM-DMA address limitations\n",
-			__FUNCTION__);
+		ERROR("%s: aborting due to PCI BM-DMA address limitations\n", __FUNCTION__);
 		return -1;
 	}
 
@@ -1771,12 +1762,12 @@ vlsi_irda_probe(struct pci_dev *pdev, co
 	else
 		pdev->current_state = 0; /* hw must be running now */
 
-	printk(KERN_INFO "%s: IrDA PCI controller %s detected\n",
-		drivername, pdev->dev.name);
+	MESSAGE("%s: IrDA PCI controller %s detected\n",
+		drivername, PCIDEV_NAME(pdev));
 
 	if ( !pci_resource_start(pdev,0)
 	     || !(pci_resource_flags(pdev,0) & IORESOURCE_IO) ) {
-		printk(KERN_ERR "%s: bar 0 invalid", __FUNCTION__);
+		ERROR("%s: bar 0 invalid", __FUNCTION__);
 		goto out_disable;
 	}
 
@@ -1784,8 +1775,7 @@ vlsi_irda_probe(struct pci_dev *pdev, co
 
 	ndev = (struct net_device *) kmalloc (alloc_size, GFP_KERNEL);
 	if (ndev==NULL) {
-		printk(KERN_ERR "%s: Unable to allocate device memory.\n",
-			__FUNCTION__);
+		ERROR("%s: Unable to allocate device memory.\n", __FUNCTION__);
 		goto out_disable;
 	}
 
@@ -1801,37 +1791,33 @@ vlsi_irda_probe(struct pci_dev *pdev, co
 	ndev->init = vlsi_irda_init;
 	strcpy(ndev->name,"irda%d");
 	if (register_netdev(ndev)) {
-		printk(KERN_ERR "%s: register_netdev failed\n",
-			__FUNCTION__);
+		ERROR("%s: register_netdev failed\n", __FUNCTION__);
 		goto out_freedev;
 	}
 
+	idev->proc_entry = NULL;
 	if (vlsi_proc_root != NULL) {
 		struct proc_dir_entry *ent;
 
 		ent = create_proc_entry(ndev->name, S_IFREG|S_IRUGO, vlsi_proc_root);
 		if (!ent) {
-			printk(KERN_ERR "%s: failed to create proc entry\n", __FUNCTION__);
-			goto out_unregister;
+			WARNING("%s: failed to create proc entry\n", __FUNCTION__);
+			idev->proc_entry = NULL;
 		}
-		ent->data = ndev;
-		ent->proc_fops = VLSI_PROC_FOPS;
-		ent->size = 0;
-		idev->proc_entry = ent;
-	} else
-		idev->proc_entry = NULL;
-
-	printk(KERN_INFO "%s: registered device %s\n", drivername, ndev->name);
+		else {
+			ent->data = ndev;
+			ent->proc_fops = VLSI_PROC_FOPS;
+			ent->size = 0;
+			idev->proc_entry = ent;
+		}
+	}
+	MESSAGE("%s: registered device %s\n", drivername, ndev->name);
 
 	pci_set_drvdata(pdev, ndev);
 	up(&idev->sem);
 
 	return 0;
 
-out_unregister:
-	up(&idev->sem);
-	unregister_netdev(ndev);
-	goto out_disable;
 out_freedev:
 	up(&idev->sem);
 	kfree(ndev);
@@ -1848,7 +1834,7 @@ static void __devexit vlsi_irda_remove(s
 	vlsi_irda_dev_t *idev;
 
 	if (!ndev) {
-		printk(KERN_CRIT "%s: lost netdevice?\n", drivername);
+		ERROR("%s: lost netdevice?\n", drivername);
 		return;
 	}
 
@@ -1867,7 +1853,7 @@ static void __devexit vlsi_irda_remove(s
 	 * ndev->destructor called (if present) when going to free
 	 */
 
-	printk(KERN_INFO "%s: %s removed\n", drivername, pdev->dev.name);
+	MESSAGE("%s: %s removed\n", drivername, PCIDEV_NAME(pdev));
 }
 
 #ifdef CONFIG_PM
@@ -1882,8 +1868,8 @@ static void __devexit vlsi_irda_remove(s
 static int vlsi_irda_save_state(struct pci_dev *pdev, u32 state)
 {
 	if (state < 1 || state > 3 ) {
-		printk( KERN_ERR "%s - %s: invalid pm state request: %u\n",
-			__FUNCTION__, pdev->dev.name, state);
+		ERROR("%s - %s: invalid pm state request: %u\n",
+			__FUNCTION__, PCIDEV_NAME(pdev), state);
 		return -1;
 	}
 	return 0;
@@ -1895,12 +1881,12 @@ static int vlsi_irda_suspend(struct pci_
 	vlsi_irda_dev_t *idev;
 
 	if (state < 1 || state > 3 ) {
-		printk( KERN_ERR "%s - %s: invalid pm state request: %u\n",
-			__FUNCTION__, pdev->dev.name, state);
+		ERROR("%s - %s: invalid pm state request: %u\n",
+			__FUNCTION__, PCIDEV_NAME(pdev), state);
 		return 0;
 	}
 	if (!ndev) {
-		printk(KERN_ERR "%s - %s: no netdevice \n", __FUNCTION__, pdev->dev.name);
+		ERROR("%s - %s: no netdevice \n", __FUNCTION__, PCIDEV_NAME(pdev));
 		return 0;
 	}
 	idev = ndev->priv;	
@@ -1911,8 +1897,8 @@ static int vlsi_irda_suspend(struct pci_
 			pdev->current_state = state;
 		}
 		else
-			printk(KERN_ERR "%s - %s: invalid suspend request %u -> %u\n",
-				__FUNCTION__, pdev->dev.name, pdev->current_state, state);
+			ERROR("%s - %s: invalid suspend request %u -> %u\n",
+				__FUNCTION__, PCIDEV_NAME(pdev), pdev->current_state, state);
 		up(&idev->sem);
 		return 0;
 	}
@@ -1939,14 +1925,14 @@ static int vlsi_irda_resume(struct pci_d
 	vlsi_irda_dev_t	*idev;
 
 	if (!ndev) {
-		printk(KERN_ERR "%s - %s: no netdevice \n", __FUNCTION__, pdev->dev.name);
+		ERROR("%s - %s: no netdevice \n", __FUNCTION__, PCIDEV_NAME(pdev));
 		return 0;
 	}
 	idev = ndev->priv;	
 	down(&idev->sem);
 	if (pdev->current_state == 0) {
 		up(&idev->sem);
-		printk(KERN_ERR "%s - %s: already resumed\n", __FUNCTION__, pdev->dev.name);
+		WARNING("%s - %s: already resumed\n", __FUNCTION__, PCIDEV_NAME(pdev));
 		return 0;
 	}
 	
@@ -1965,7 +1951,7 @@ static int vlsi_irda_resume(struct pci_d
 		 * now we explicitly set pdev->current_state = 0 after enabling the
 		 * device and independently resume_ok should catch any garbage config.
 		 */
-		printk(KERN_ERR "%s - hm, nothing to resume?\n", __FUNCTION__);
+		WARNING("%s - hm, nothing to resume?\n", __FUNCTION__);
 		up(&idev->sem);
 		return 0;
 	}
@@ -2003,7 +1989,7 @@ static int __init vlsi_mod_init(void)
 	int	i, ret;
 
 	if (clksrc < 0  ||  clksrc > 3) {
-		printk(KERN_ERR "%s: invalid clksrc=%d\n", drivername, clksrc);
+		ERROR("%s: invalid clksrc=%d\n", drivername, clksrc);
 		return -1;
 	}
 
@@ -2016,9 +2002,8 @@ static int __init vlsi_mod_init(void)
 			case 64:
 				break;
 			default:
-				printk(KERN_WARNING "%s: invalid %s ringsize %d",
+				WARNING("%s: invalid %s ringsize %d, using default=8",
 					drivername, (i)?"rx":"tx", ringsize[i]);
-				printk(", using default=8\n");
 				ringsize[i] = 8;
 				break;
 		}
