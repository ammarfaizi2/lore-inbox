Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262222AbSJKAKK>; Thu, 10 Oct 2002 20:10:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262230AbSJKAKK>; Thu, 10 Oct 2002 20:10:10 -0400
Received: from deimos.hpl.hp.com ([192.6.19.190]:48343 "EHLO deimos.hpl.hp.com")
	by vger.kernel.org with ESMTP id <S262222AbSJKAJB>;
	Thu, 10 Oct 2002 20:09:01 -0400
Date: Thu, 10 Oct 2002 17:14:44 -0700
To: irda-users@lists.sourceforge.net, Jeff Garzik <jgarzik@mandrakesoft.com>,
       Linux kernel mailing list <linux-kernel@vger.kernel.org>
Subject: [PATCH 2.5] : ir251_vlsi_v4-2.diff
Message-ID: <20021011001443.GB6645@bougret.hpl.hp.com>
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

ir251_vlsi_v4-2.diff :
--------------------
	        <Following patch from Martin Diehl>
        * merge+sync with changes from recent kernels: pci_[sg]et_drvdata,
          __devexit_p, netdev->last_rx, irda header cleanup
        * add netdev tx_timeout which re-initializes the whole thing
        * add power management support consistent with pci driver api
        * major rework of the ring descriptor operations
        * make correct usage of consistent and streaming pci dma api
        * nuke last virt_to_bus() and friends
        * support MIR/FIR highspeed interaction pulse (SIP)
        * review all paths for packet-size issues (rx and tx)
        * fix an old issue requiring hw powercycle caused by a race
          between IrLAP and hardware when switching _back_ to default
          speed at LAP disconnect. This was opened by the complete async
          behaviour of netdev->xmit but didn't happen before your latency
          improvements went into the stack.
        * add driver status readout under /proc/driver/vlsi_ir/irda%
          For 2.5, this will probably go into driverfs once things have
          stabilized.
        * fix potential deadlock in speed changing code
        * make identical driver working for both 2.4 and 2.5
        * add __attribute__((packed)) to hardware-exposed struct
        * add suggested pci_dma_prep_single() to flush cpu cache before
          streaming dma buffer gets reused for busmastering



diff -u -p linux/include/net/irda/vlsi_ir.v3.h linux/include/net/irda/vlsi_ir.h
--- linux/include/net/irda/vlsi_ir.v3.h	Thu Oct 10 13:54:33 2002
+++ linux/include/net/irda/vlsi_ir.h	Thu Oct 10 13:56:53 2002
@@ -3,9 +3,9 @@
  *
  *	vlsi_ir.h:	VLSI82C147 PCI IrDA controller driver for Linux
  *
- *	Version:	0.3, Sep 30, 2001
+ *	Version:	0.4
  *
- *	Copyright (c) 2001 Martin Diehl
+ *	Copyright (c) 2001-2002 Martin Diehl
  *
  *	This program is free software; you can redistribute it and/or 
  *	modify it under the terms of the GNU General Public License as 
@@ -27,6 +27,26 @@
 #ifndef IRDA_VLSI_FIR_H
 #define IRDA_VLSI_FIR_H
 
+#if LINUX_VERSION_CODE < KERNEL_VERSION(2,5,4)
+#ifdef CONFIG_PROC_FS
+/* PDE() introduced in 2.5.4 */
+#define PDE(inode) ((inode)->u.generic_ip)
+#endif
+#endif
+
+/*
+ * #if LINUX_VERSION_CODE < KERNEL_VERSION(2,5,xx)
+ *
+ * missing pci-dma api call to give streaming dma buffer back to hw
+ * patch floating on lkml - probably present in 2.5.26 or later
+ * otherwise defining it as noop is ok, since the vlsi-ir is only
+ * used on two oldish x86-based notebooks which are cache-coherent
+ */
+#define pci_dma_prep_single(dev, addr, size, direction)	/* nothing */
+/*
+ * #endif
+ */
+
 /* ================================================================ */
 
 /* non-standard PCI registers */
@@ -58,20 +78,20 @@ enum vlsi_pci_clkctl {
 
 	/* PLL control */
 
-	CLKCTL_NO_PD		= 0x04,		/* PD# (inverted power down) signal,
-						 * i.e. PLL is powered, if NO_PD set */
+	CLKCTL_PD_INV		= 0x04,		/* PD#: inverted power down signal,
+						 * i.e. PLL is powered, if PD_INV set */
 	CLKCTL_LOCK		= 0x40,		/* (ro) set, if PLL is locked */
 
 	/* clock source selection */
 
-	CLKCTL_EXTCLK		= 0x20,		/* set to select external clock input */
-	CLKCTL_XCKSEL		= 0x10,		/* set to indicate 40MHz EXTCLK, not 48MHz */
+	CLKCTL_EXTCLK		= 0x20,		/* set to select external clock input, not PLL */
+	CLKCTL_XCKSEL		= 0x10,		/* set to indicate EXTCLK is 40MHz, not 48MHz */
 
 	/* IrDA block control */
 
 	CLKCTL_CLKSTP		= 0x80,		/* set to disconnect from selected clock source */
 	CLKCTL_WAKE		= 0x08		/* set to enable wakeup feature: whenever IR activity
-						 * is detected, NO_PD gets set and CLKSTP cleared */
+						 * is detected, PD_INV gets set(?) and CLKSTP cleared */
 };
 
 /* ------------------------------------------ */
@@ -82,10 +102,9 @@ enum vlsi_pci_clkctl {
 #define DMA_MASK_MSTRPAGE	0x00ffffff
 #define MSTRPAGE_VALUE		(DMA_MASK_MSTRPAGE >> 24)
 
-
 	/* PCI busmastering is somewhat special for this guy - in short:
 	 *
-	 * We select to operate using MSTRPAGE=0 fixed, use ISA DMA
+	 * We select to operate using fixed MSTRPAGE=0, use ISA DMA
 	 * address restrictions to make the PCI BM api aware of this,
 	 * but ensure the hardware is dealing with real 32bit access.
 	 *
@@ -151,7 +170,6 @@ enum vlsi_pci_irmisc {
 	IRMISC_UARTSEL_2e8	= 0x03
 };
 
-
 /* ================================================================ */
 
 /* registers mapped to 32 byte PCI IO space */
@@ -350,22 +368,17 @@ enum vlsi_pio_irenable {
 
 #define	  IRENABLE_MASK	    0xff00  /* Read mask */
 
-
 /* ------------------------------------------ */
 
 /* VLSI_PIO_PHYCTL: IR Physical Layer Current Control Register (u16, ro) */
 
-
 /* read-back of the currently applied physical layer status.
  * applied from VLSI_PIO_NPHYCTL at rising edge of IRENABLE_IREN
  * contents identical to VLSI_PIO_NPHYCTL (see below)
  */
 
-
-
 /* ------------------------------------------ */
 
-
 /* VLSI_PIO_NPHYCTL: IR Physical Layer Next Control Register (u16, rw) */
 
 /* latched during IRENABLE_IREN=0 and applied at 0-1 transition
@@ -382,10 +395,10 @@ enum vlsi_pio_irenable {
  *		fixed for all SIR speeds at 40MHz input clock (PLSWID=24 at 48MHz).
  *		IrPHY also allows shorter pulses down to the nominal pulse duration
  *		at 115.2kbaud (minus some tolerance) which is 1.41 usec.
- *		Using the expression PLSWID = 12/(BAUD+1)-1 (multiplied by to for 48MHz)
+ *		Using the expression PLSWID = 12/(BAUD+1)-1 (multiplied by two for 48MHz)
  *		we get the minimum acceptable PLSWID values according to the VLSI
  *		specification, which provides 1.5 usec pulse width for all speeds (except
- *		for 2.4kbaud getting 6usec). This is well inside IrPHY v1.3 specs and
+ *		for 2.4kbaud getting 6usec). This is fine with IrPHY v1.3 specs and
  *		reduces the transceiver power which drains the battery. At 9.6kbaud for
  *		example this amounts to more than 90% battery power saving!
  *
@@ -399,7 +412,21 @@ enum vlsi_pio_irenable {
  *		PREAMB = 15
  */
 
-#define BWP_TO_PHYCTL(B,W,P)	((((B)&0x3f)<<10) | (((W)&0x1f)<<5) | (((P)&0x1f)<<0))
+#define PHYCTL_BAUD_SHIFT	10
+#define PHYCTL_BAUD_MASK	0xfc00
+#define PHYCTL_PLSWID_SHIFT	5
+#define PHYCTL_PLSWID_MASK	0x03e0
+#define PHYCTL_PREAMB_SHIFT	0
+#define PHYCTL_PREAMB_MASK	0x001f
+
+#define PHYCTL_TO_BAUD(bwp)	(((bwp)&PHYCTL_BAUD_MASK)>>PHYCTL_BAUD_SHIFT)
+#define PHYCTL_TO_PLSWID(bwp)	(((bwp)&PHYCTL_PLSWID_MASK)>>PHYCTL_PLSWID_SHIFT)
+#define PHYCTL_TO_PREAMB(bwp)	(((bwp)&PHYCTL_PREAMB_MASK)>>PHYCTL_PREAMB_SHIFT)
+
+#define BWP_TO_PHYCTL(b,w,p)	((((b)<<PHYCTL_BAUD_SHIFT)&PHYCTL_BAUD_MASK) \
+				 | (((w)<<PHYCTL_PLSWID_SHIFT)&PHYCTL_PLSWID_MASK) \
+				 | (((p)<<PHYCTL_PREAMB_SHIFT)&PHYCTL_PREAMB_MASK))
+
 #define BAUD_BITS(br)		((115200/(br))-1)
 
 static inline unsigned
@@ -417,7 +444,6 @@ calc_width_bits(unsigned baudrate, unsig
 	return (tmp>0) ? (tmp-1) : 0;
 }
 
-
 #define PHYCTL_SIR(br,ws,cs)	BWP_TO_PHYCTL(BAUD_BITS(br),calc_width_bits((br),(ws),(cs)),0)
 #define PHYCTL_MIR(cs)		BWP_TO_PHYCTL(0,((cs)?9:10),1)
 #define PHYCTL_FIR		BWP_TO_PHYCTL(0,0,15)
@@ -445,42 +471,61 @@ calc_width_bits(unsigned baudrate, unsig
 
 /* VLSI_PIO_MAXPKT: Maximum Packet Length register (u16, rw) */
 
-/* specifies the maximum legth (up to 4k - or (4k-1)? - bytes), which a
- * received frame may have - i.e. the size of the corresponding
- * receive buffers. For simplicity we use the same length for
- * receive and submit buffers and increase transfer buffer size
- * byond IrDA-MTU = 2048 so we have sufficient space left when
- * packet size increases during wrapping due to XBOFs and CE's.
- * Even for receiving unwrapped frames we need >MAX_PACKET_LEN
- * space since the controller appends FCS/CRC (2 or 4 bytes)
- * so we use 2*IrDA-MTU for both directions and cover even the
- * worst case, where all data bytes have to be escaped when wrapping.
- * well, this wastes some memory - anyway, later we will
- * either map skb's directly or use pci_pool allocator...
- */
- 
-#define IRDA_MTU	2048		/* seems to be undefined elsewhere */
- 
-#define XFER_BUF_SIZE		(2*IRDA_MTU)
+/* maximum acceptable length for received packets */
 
-#define MAX_PACKET_LENGTH	(XFER_BUF_SIZE-1) /* register uses only [11:0] */
+/* hw imposed limitation - register uses only [11:0] */
+#define MAX_PACKET_LENGTH	0x0fff
 
+/* IrLAP I-field (apparently not defined elsewhere) */
+#define IRDA_MTU		2048
 
-/* ------------------------------------------ */
+/* complete packet consists of A(1)+C(1)+I(<=IRDA_MTU) */
+#define IRLAP_SKB_ALLOCSIZE	(1+1+IRDA_MTU)
+
+/* the buffers we use to exchange frames with the hardware need to be
+ * larger than IRLAP_SKB_ALLOCSIZE because we may have up to 4 bytes FCS
+ * appended and, in SIR mode, a lot of frame wrapping bytes. The worst
+ * case appears to be a SIR packet with I-size==IRDA_MTU and all bytes
+ * requiring to be escaped to provide transparency. Furthermore, the peer
+ * might ask for quite a number of additional XBOFs:
+ *	up to 115+48 XBOFS		 163
+ *	regular BOF			   1
+ *	A-field				   1
+ *	C-field				   1
+ *	I-field, IRDA_MTU, all escaped	4096
+ *	FCS (16 bit at SIR, escaped)	   4
+ *	EOF				   1
+ * AFAICS nothing in IrLAP guarantees A/C field not to need escaping
+ * (f.e. 0xc0/0xc1 - i.e. BOF/EOF - are legal values there) so in the
+ * worst case we have 4269 bytes total frame size.
+ * However, the VLSI uses 12 bits only for all buffer length values,
+ * which limits the maximum useable buffer size <= 4095.
+ * Note this is not a limitation in the receive case because we use
+ * the SIR filtering mode where the hw unwraps the frame and only the
+ * bare packet+fcs is stored into the buffer - in contrast to the SIR
+ * tx case where we have to pass frame-wrapped packets to the hw.
+ * If this would ever become an issue in real life, the only workaround
+ * I see would be using the legacy UART emulation in SIR mode.
+ */
 
+#define XFER_BUF_SIZE		MAX_PACKET_LENGTH
+
+/* ------------------------------------------ */
 
 /* VLSI_PIO_RCVBCNT: Receive Byte Count Register (u16, ro) */
 
-/* recive packet counter gets incremented on every non-filtered
+/* receive packet counter gets incremented on every non-filtered
  * byte which was put in the receive fifo and reset for each
  * new packet. Used to decide whether we are just in the middle
  * of receiving
  */
 
+/* better apply the [11:0] mask when reading, as some docs say the
+ * reserved [15:12] would return 1 when reading - which is wrong AFAICS
+ */
 #define RCVBCNT_MASK	0x0fff
 
-/* ================================================================ */
-
+/******************************************************************/
 
 /* descriptors for rx/tx ring
  *
@@ -494,10 +539,10 @@ calc_width_bits(unsigned baudrate, unsig
  *
  * Attention: Writing addr overwrites status!
  *
- * ### FIXME: we depend on endianess here
+ * ### FIXME: depends on endianess (but there ain't no non-i586 ob800 ;-)
  */
 
-struct ring_descr {
+struct ring_descr_hw {
 	volatile u16	rd_count;	/* tx/rx count [11:0] */
 	u16		reserved;
 	union {
@@ -505,60 +550,168 @@ struct ring_descr {
 		struct {
 			u8		addr_res[3];
 			volatile u8	status;		/* descriptor status */
-		} rd_s;
-	} rd_u;
-};
+		} rd_s __attribute__((packed));
+	} rd_u __attribute((packed));
+} __attribute__ ((packed));
 
 #define rd_addr		rd_u.addr
 #define rd_status	rd_u.rd_s.status
 
-
 /* ring descriptor status bits */
 
-#define RD_STAT_ACTIVE		0x80	/* descriptor owned by hw (both TX,RX) */
+#define RD_ACTIVE		0x80	/* descriptor owned by hw (both TX,RX) */
 
 /* TX ring descriptor status */
 
-#define	TX_STAT_DISCRC		0x40	/* do not send CRC (for SIR) */
-#define	TX_STAT_BADCRC		0x20	/* force a bad CRC */
-#define	TX_STAT_PULSE		0x10	/* send indication pulse after this frame (MIR/FIR) */
-#define	TX_STAT_FRCEUND		0x08	/* force underrun */
-#define	TX_STAT_CLRENTX		0x04	/* clear ENTX after this frame */
-#define	TX_STAT_UNDRN		0x01	/* TX fifo underrun (probably PCI problem) */
+#define	RD_TX_DISCRC		0x40	/* do not send CRC (for SIR) */
+#define	RD_TX_BADCRC		0x20	/* force a bad CRC */
+#define	RD_TX_PULSE		0x10	/* send indication pulse after this frame (MIR/FIR) */
+#define	RD_TX_FRCEUND		0x08	/* force underrun */
+#define	RD_TX_CLRENTX		0x04	/* clear ENTX after this frame */
+#define	RD_TX_UNDRN		0x01	/* TX fifo underrun (probably PCI problem) */
 
 /* RX ring descriptor status */
 
-#define RX_STAT_PHYERR		0x40	/* physical encoding error */
-#define RX_STAT_CRCERR		0x20	/* CRC error (MIR/FIR) */
-#define RX_STAT_LENGTH		0x10	/* frame exceeds buffer length */
-#define RX_STAT_OVER		0x08	/* RX fifo overrun (probably PCI problem) */
-#define RX_STAT_SIRBAD		0x04	/* EOF missing: BOF follows BOF (SIR, filtered) */
-
+#define RD_RX_PHYERR		0x40	/* physical encoding error */
+#define RD_RX_CRCERR		0x20	/* CRC error (MIR/FIR) */
+#define RD_RX_LENGTH		0x10	/* frame exceeds buffer length */
+#define RD_RX_OVER		0x08	/* RX fifo overrun (probably PCI problem) */
+#define RD_RX_SIRBAD		0x04	/* EOF missing: BOF follows BOF (SIR, filtered) */
 
-#define RX_STAT_ERROR		0x7c	/* any error in frame */
+#define RD_RX_ERROR		0x7c	/* any error in received frame */
 
+/* the memory required to hold the 2 descriptor rings */
+#define HW_RING_AREA_SIZE	(2 * MAX_RING_DESCR * sizeof(struct ring_descr_hw))
 
-/* ------------------------------------------ */
+/******************************************************************/
 
-/* contains the objects we've put into the ring descriptors
- * static buffers for now - probably skb's later
+/* sw-ring descriptors consists of a bus-mapped transfer buffer with
+ * associated skb and a pointer to the hw entry descriptor
  */
 
-struct ring_entry {
-	struct sk_buff	*skb;
-	void		*data;
+struct ring_descr {
+	struct ring_descr_hw	*hw;
+	struct sk_buff		*skb;
+	void			*buf;
 };
 
+/* wrappers for operations on hw-exposed ring descriptors
+ * access to the hw-part of the descriptors must use these.
+ */
+
+static inline int rd_is_active(struct ring_descr *rd)
+{
+	return ((rd->hw->rd_status & RD_ACTIVE) != 0);
+}
+
+static inline void rd_activate(struct ring_descr *rd)
+{
+	rd->hw->rd_status |= RD_ACTIVE;
+}
+
+static inline void rd_set_status(struct ring_descr *rd, u8 s)
+{
+	rd->hw->rd_status = s;	 /* may pass ownership to the hardware */
+}
+
+static inline void rd_set_addr_status(struct ring_descr *rd, dma_addr_t a, u8 s)
+{
+	/* order is important for two reasons:
+	 *  - overlayed: writing addr overwrites status
+	 *  - we want to write status last so we have valid address in
+	 *    case status has RD_ACTIVE set
+	 */
+
+	if ((a & ~DMA_MASK_MSTRPAGE)>>24 != MSTRPAGE_VALUE) {
+		BUG();
+		return;
+	}
+
+	a &= DMA_MASK_MSTRPAGE;  /* clear highbyte to make sure we won't write
+				  * to status - just in case MSTRPAGE_VALUE!=0
+				  */
+	rd->hw->rd_addr = a;
+	wmb();
+	rd_set_status(rd, s);	 /* may pass ownership to the hardware */
+}
+
+static inline void rd_set_count(struct ring_descr *rd, u16 c)
+{
+	rd->hw->rd_count = c;
+}
+
+static inline u8 rd_get_status(struct ring_descr *rd)
+{
+	return rd->hw->rd_status;
+}
+
+static inline dma_addr_t rd_get_addr(struct ring_descr *rd)
+{
+	dma_addr_t	a;
+
+	a = (rd->hw->rd_addr & DMA_MASK_MSTRPAGE) | (MSTRPAGE_VALUE << 24);
+	return a;
+}
+
+static inline u16 rd_get_count(struct ring_descr *rd)
+{
+	return rd->hw->rd_count;
+}
+
+/******************************************************************/
+
+/* sw descriptor rings for rx, tx:
+ *
+ * operations follow producer-consumer paradigm, with the hw
+ * in the middle doing the processing.
+ * ring size must be power of two.
+ *
+ * producer advances r->tail after inserting for processing
+ * consumer advances r->head after removing processed rd
+ * ring is empty if head==tail / full if (tail+1)==head
+ */
 
 struct vlsi_ring {
+	struct pci_dev		*pdev;
+	int			dir;
+	unsigned		len;
 	unsigned		size;
 	unsigned		mask;
-	unsigned		head, tail;
-	struct ring_descr	*hw;
-	struct ring_entry	buf[MAX_RING_DESCR];
+	atomic_t		head, tail;
+	struct ring_descr	*rd;
 };
 
-/* ------------------------------------------ */
+/* ring processing helpers */
+
+static inline struct ring_descr *ring_last(struct vlsi_ring *r)
+{
+	int t;
+
+	t = atomic_read(&r->tail) & r->mask;
+	return (((t+1) & r->mask) == (atomic_read(&r->head) & r->mask)) ? NULL : &r->rd[t];
+}
+
+static inline struct ring_descr *ring_put(struct vlsi_ring *r)
+{
+	atomic_inc(&r->tail);
+	return ring_last(r);
+}
+
+static inline struct ring_descr *ring_first(struct vlsi_ring *r)
+{
+	int h;
+
+	h = atomic_read(&r->head) & r->mask;
+	return (h == (atomic_read(&r->tail) & r->mask)) ? NULL : &r->rd[h];
+}
+
+static inline struct ring_descr *ring_get(struct vlsi_ring *r)
+{
+	atomic_inc(&r->head);
+	return ring_first(r);
+}
+
+/******************************************************************/
 
 /* our private compound VLSI-PCI-IRDA device information */
 
@@ -575,13 +728,38 @@ typedef struct vlsi_irda_dev {
 
 	dma_addr_t		busaddr;
 	void			*virtaddr;
-	struct vlsi_ring	tx_ring, rx_ring;
+	struct vlsi_ring	*tx_ring, *rx_ring;
 
 	struct timeval		last_rx;
 
 	spinlock_t		lock;
-	
+	struct semaphore	sem;
+
+	u32			cfg_space[64/sizeof(u32)];
+	u8			resume_ok;	
+#ifdef CONFIG_PROC_FS
+	struct proc_dir_entry	*proc_entry;
+#endif
+
 } vlsi_irda_dev_t;
+
+/********************************************************/
+
+/* the remapped error flags we use for returning from frame
+ * post-processing in vlsi_process_tx/rx() after it was completed
+ * by the hardware. These functions either return the >=0 number
+ * of transfered bytes in case of success or the negative (-)
+ * of the or'ed error flags.
+ */
+
+#define VLSI_TX_DROP		0x0001
+#define VLSI_TX_FIFO		0x0002
+
+#define VLSI_RX_DROP		0x0100
+#define VLSI_RX_OVER		0x0200
+#define VLSI_RX_LENGTH  	0x0400
+#define VLSI_RX_FRAME		0x0800
+#define VLSI_RX_CRC		0x1000
 
 /********************************************************/
 
diff -u -p linux/drivers/net/irda/vlsi_ir.v3.c linux/drivers/net/irda/vlsi_ir.c
--- linux/drivers/net/irda/vlsi_ir.v3.c	Thu Oct 10 13:44:32 2002
+++ linux/drivers/net/irda/vlsi_ir.c	Thu Oct 10 14:00:32 2002
@@ -2,9 +2,7 @@
  *
  *	vlsi_ir.c:	VLSI82C147 PCI IrDA controller driver for Linux
  *
- *	Version:	0.3a, Nov 10, 2001
- *
- *	Copyright (c) 2001 Martin Diehl
+ *	Copyright (c) 2001-2002 Martin Diehl
  *
  *	This program is free software; you can redistribute it and/or 
  *	modify it under the terms of the GNU General Public License as 
@@ -25,6 +23,17 @@
 
 #include <linux/module.h>
  
+MODULE_DESCRIPTION("IrDA SIR/MIR/FIR driver for VLSI 82C147");
+MODULE_AUTHOR("Martin Diehl <info@mdiehl.de>");
+MODULE_LICENSE("GPL");
+EXPORT_NO_SYMBOLS;
+
+#define DRIVER_NAME "vlsi_ir"
+#define DRIVER_VERSION "v0.4"
+
+/********************************************************/
+
+#include <linux/config.h>
 #include <linux/kernel.h>
 #include <linux/init.h>
 #include <linux/pci.h>
@@ -33,6 +42,9 @@
 #include <linux/skbuff.h>
 #include <linux/delay.h>
 #include <linux/time.h>
+#include <linux/proc_fs.h>
+#include <linux/smp_lock.h>
+#include <asm/uaccess.h>
 
 #include <net/irda/irda.h>
 #include <net/irda/irda_device.h>
@@ -40,17 +52,9 @@
 
 #include <net/irda/vlsi_ir.h>
 
-
 /********************************************************/
 
-
-MODULE_DESCRIPTION("IrDA SIR/MIR/FIR driver for VLSI 82C147");
-MODULE_AUTHOR("Martin Diehl <info@mdiehl.de>");
-MODULE_LICENSE("GPL");
-
-
-static /* const */ char drivername[] = "vlsi_ir";
-
+static /* const */ char drivername[] = DRIVER_NAME;
 
 #define PCI_CLASS_WIRELESS_IRDA 0x0d00
 
@@ -64,13 +68,8 @@ static struct pci_device_id vlsi_irda_ta
 
 MODULE_DEVICE_TABLE(pci, vlsi_irda_table);
 
-
 /********************************************************/
 
-
-MODULE_PARM(clksrc, "i");
-MODULE_PARM_DESC(clksrc, "clock input source selection");
-
 /*	clksrc: which clock source to be used
  *		0: auto - try PLL, fallback to 40MHz XCLK
  *		1: on-chip 48MHz PLL
@@ -78,12 +77,10 @@ MODULE_PARM_DESC(clksrc, "clock input so
  *		3: external 40MHz XCLK (HP OB-800)
  */
 
+MODULE_PARM(clksrc, "i");
+MODULE_PARM_DESC(clksrc, "clock input source selection");
 static int clksrc = 0;			/* default is 0(auto) */
 
-
-MODULE_PARM(ringsize, "1-2i");
-MODULE_PARM_DESC(ringsize, "TX, RX ring descriptor size");
-
 /*	ringsize: size of the tx and rx descriptor rings
  *		independent for tx and rx
  *		specify as ringsize=tx[,rx]
@@ -92,11 +89,9 @@ MODULE_PARM_DESC(ringsize, "TX, RX ring 
  *		there should be no gain when using rings larger than 8
  */
 
-static int ringsize[] = {8,8};		/* default is tx=rx=8 */
-
-
-MODULE_PARM(sirpulse, "i");
-MODULE_PARM_DESC(sirpulse, "SIR pulse width tuning");
+MODULE_PARM(ringsize, "1-2i");
+MODULE_PARM_DESC(ringsize, "TX, RX ring descriptor size");
+static int ringsize[] = {8,8};		/* default is tx=8 / rx=8 */
 
 /*	sirpulse: tuning of the SIR pulse width within IrPHY 1.3 limits
  *		0: very short, 1.5us (exception: 6us at 2.4 kbaud)
@@ -107,355 +102,780 @@ MODULE_PARM_DESC(sirpulse, "SIR pulse wi
  *		pulse width saves more than 90% of the transmitted IR power.
  */
 
+MODULE_PARM(sirpulse, "i");
+MODULE_PARM_DESC(sirpulse, "SIR pulse width tuning");
 static int sirpulse = 1;		/* default is 3/16 bittime */
 
-
-MODULE_PARM(qos_mtt_bits, "i");
-MODULE_PARM_DESC(qos_mtt_bits, "IrLAP bitfield representing min-turn-time");
-
 /*	qos_mtt_bits: encoded min-turn-time value we require the peer device
  *		 to use before transmitting to us. "Type 1" (per-station)
  *		 bitfield according to IrLAP definition (section 6.6.8)
- *		 The HP HDLS-1100 requires 1 msec - don't even know
- *		 if this is the one which is used by my OB800
+ *		 Don't know which transceiver is used by my OB800 - the
+ *		 pretty common HP HDLS-1100 requires 1 msec - so lets use this.
  */
 
+MODULE_PARM(qos_mtt_bits, "i");
+MODULE_PARM_DESC(qos_mtt_bits, "IrLAP bitfield representing min-turn-time");
 static int qos_mtt_bits = 0x04;		/* default is 1 ms */
 
-
 /********************************************************/
 
-
-/* some helpers for operations on ring descriptors */
-
-
-static inline int rd_is_active(struct vlsi_ring *r, unsigned i)
+static void vlsi_reg_debug(unsigned iobase, const char *s)
 {
-	return ((r->hw[i].rd_status & RD_STAT_ACTIVE) != 0);
-}
+	int	i;
 
-static inline void rd_activate(struct vlsi_ring *r, unsigned i)
-{
-	r->hw[i].rd_status |= RD_STAT_ACTIVE;
+	printk(KERN_DEBUG "%s: ", s);
+	for (i = 0; i < 0x20; i++)
+		printk("%02x", (unsigned)inb((iobase+i)));
+	printk("\n");
 }
 
-static inline void rd_set_addr_status(struct vlsi_ring *r, unsigned i, dma_addr_t a, u8 s)
+static void vlsi_ring_debug(struct vlsi_ring *r)
 {
-	struct ring_descr *rd = r->hw +i;
-
-	/* ordering is important for two reasons:
-	 *  - overlayed: writing addr overwrites status
-	 *  - we want to write status last so we have valid address in
-	 *    case status has RD_STAT_ACTIVE set
-	 */
-
-	if ((a & ~DMA_MASK_MSTRPAGE) != MSTRPAGE_VALUE)
-		BUG();
-
-	a &= DMA_MASK_MSTRPAGE;  /* clear highbyte to make sure we won't write
-				  * to status - just in case MSTRPAGE_VALUE!=0
-				  */
-	rd->rd_addr = a;
-	wmb();
-	rd->rd_status = s;	 /* potentially passes ownership to the hardware */
-}
+	struct ring_descr *rd;
+	unsigned i;
 
-static inline void rd_set_status(struct vlsi_ring *r, unsigned i, u8 s)
-{
-	r->hw[i].rd_status = s;
+	printk(KERN_DEBUG "%s - ring %p / size %u / mask 0x%04x / len %u / dir %d / hw %p\n",
+		__FUNCTION__, r, r->size, r->mask, r->len, r->dir, r->rd[0].hw);
+	printk(KERN_DEBUG "%s - head = %d / tail = %d\n", __FUNCTION__,
+		atomic_read(&r->head) & r->mask, atomic_read(&r->tail) & r->mask);
+	for (i = 0; i < r->size; i++) {
+		rd = &r->rd[i];
+		printk(KERN_DEBUG "%s - ring descr %u: ", __FUNCTION__, i);
+		printk("skb=%p data=%p hw=%p\n", rd->skb, rd->buf, rd->hw);
+		printk(KERN_DEBUG "%s - hw: status=%02x count=%u addr=0x%08x\n",
+			__FUNCTION__, (unsigned) rd_get_status(rd),
+			(unsigned) rd_get_count(rd), (unsigned) rd_get_addr(rd));
+	}
 }
 
-static inline void rd_set_count(struct vlsi_ring *r, unsigned i, u16 c)
-{
-	r->hw[i].rd_count = c;
-}
+/********************************************************/
 
-static inline u8 rd_get_status(struct vlsi_ring *r, unsigned i)
-{
-	return r->hw[i].rd_status;
-}
+#ifdef CONFIG_PROC_FS
 
-static inline dma_addr_t rd_get_addr(struct vlsi_ring *r, unsigned i)
+static int vlsi_proc_pdev(struct pci_dev *pdev, char *buf, int len)
 {
-	dma_addr_t	a;
+	unsigned iobase = pci_resource_start(pdev, 0);
+	unsigned i;
+	char *out = buf;
 
-	a = (r->hw[i].rd_addr & DMA_MASK_MSTRPAGE) | (MSTRPAGE_VALUE << 24);
-	return a;
-}
+	if (len < 500)
+		return 0;
 
-static inline u16 rd_get_count(struct vlsi_ring *r, unsigned i)
-{
-	return r->hw[i].rd_count;
+	out += sprintf(out, "\n%s (vid/did: %04x/%04x)\n",
+			pdev->name, (int)pdev->vendor, (int)pdev->device);
+	out += sprintf(out, "pci-power-state: %u\n", (unsigned) pdev->current_state);
+	out += sprintf(out, "resources: irq=%u / io=0x%04x / dma_mask=0x%016Lx\n",
+			pdev->irq, (unsigned)pci_resource_start(pdev, 0), (u64)pdev->dma_mask);
+	out += sprintf(out, "hw registers: ");
+	for (i = 0; i < 0x20; i++)
+		out += sprintf(out, "%02x", (unsigned)inb((iobase+i)));
+	out += sprintf(out, "\n");
+	return out - buf;
 }
-
-/* producer advances r->head when descriptor was added for processing by hw */
-
-static inline void ring_put(struct vlsi_ring *r)
+		
+static int vlsi_proc_ndev(struct net_device *ndev, char *buf, int len)
 {
-	r->head = (r->head + 1) & r->mask;
-}
+	vlsi_irda_dev_t *idev = ndev->priv;
+	char *out = buf;
+	u8 byte;
+	u16 word;
+	unsigned delta1, delta2;
+	struct timeval now;
+	unsigned iobase = ndev->base_addr;
 
-/* consumer advances r->tail when descriptor was removed after getting processed by hw */
+	if (len < 1000)
+		return 0;
 
-static inline void ring_get(struct vlsi_ring *r)
-{
-	r->tail = (r->tail + 1) & r->mask;
-}
+	out += sprintf(out, "\n%s link state: %s / %s / %s / %s\n", ndev->name,
+		netif_device_present(ndev) ? "attached" : "detached", 
+		netif_running(ndev) ? "running" : "not running",
+		netif_carrier_ok(ndev) ? "carrier ok" : "no carrier",
+		netif_queue_stopped(ndev) ? "queue stopped" : "queue running");
+	if (!netif_running(ndev))
+		return out - buf;
+
+	out += sprintf(out, "\nhw-state:\n");
+	pci_read_config_byte(idev->pdev, VLSI_PCI_IRMISC, &byte);
+	out += sprintf(out, "IRMISC:%s%s%s UART%s",
+		(byte&IRMISC_IRRAIL) ? " irrail" : "",
+		(byte&IRMISC_IRPD) ? " irpd" : "",
+		(byte&IRMISC_UARTTST) ? " uarttest" : "",
+		(byte&IRMISC_UARTEN) ? "" : " disabled\n");
+	if (byte&IRMISC_UARTEN) {
+		out += sprintf(out, "@0x%s\n",
+			(byte&2) ? ((byte&1) ? "3e8" : "2e8")
+				 : ((byte&1) ? "3f8" : "2f8"));
+	}
+	pci_read_config_byte(idev->pdev, VLSI_PCI_CLKCTL, &byte);
+	out += sprintf(out, "CLKCTL: PLL %s%s%s / clock %s / wakeup %s\n",
+		(byte&CLKCTL_PD_INV) ? "powered" : "down",
+		(byte&CLKCTL_LOCK) ? " locked" : "",
+		(byte&CLKCTL_EXTCLK) ? ((byte&CLKCTL_XCKSEL)?" / 40 MHz XCLK":" / 48 MHz XCLK") : "",
+		(byte&CLKCTL_CLKSTP) ? "stopped" : "running",
+		(byte&CLKCTL_WAKE) ? "enabled" : "disabled");
+	pci_read_config_byte(idev->pdev, VLSI_PCI_MSTRPAGE, &byte);
+	out += sprintf(out, "MSTRPAGE: 0x%02x\n", (unsigned)byte);
+
+	byte = inb(iobase+VLSI_PIO_IRINTR);
+	out += sprintf(out, "IRINTR:%s%s%s%s%s%s%s%s\n",
+		(byte&IRINTR_ACTEN) ? " ACTEN" : "",
+		(byte&IRINTR_RPKTEN) ? " RPKTEN" : "",
+		(byte&IRINTR_TPKTEN) ? " TPKTEN" : "",
+		(byte&IRINTR_OE_EN) ? " OE_EN" : "",
+		(byte&IRINTR_ACTIVITY) ? " ACTIVITY" : "",
+		(byte&IRINTR_RPKTINT) ? " RPKTINT" : "",
+		(byte&IRINTR_TPKTINT) ? " TPKTINT" : "",
+		(byte&IRINTR_OE_INT) ? " OE_INT" : "");
+	word = inw(iobase+VLSI_PIO_RINGPTR);
+	out += sprintf(out, "RINGPTR: rx=%u / tx=%u\n", RINGPTR_GET_RX(word), RINGPTR_GET_TX(word));
+	word = inw(iobase+VLSI_PIO_RINGBASE);
+	out += sprintf(out, "RINGBASE: busmap=0x%08x\n",
+		((unsigned)word << 10)|(MSTRPAGE_VALUE<<24));
+	word = inw(iobase+VLSI_PIO_RINGSIZE);
+	out += sprintf(out, "RINGSIZE: rx=%u / tx=%u\n", RINGSIZE_TO_RXSIZE(word),
+		RINGSIZE_TO_TXSIZE(word));
+
+	word = inw(iobase+VLSI_PIO_IRCFG);
+	out += sprintf(out, "IRCFG:%s%s%s%s%s%s%s%s%s%s%s%s%s\n",
+		(word&IRCFG_LOOP) ? " LOOP" : "",
+		(word&IRCFG_ENTX) ? " ENTX" : "",
+		(word&IRCFG_ENRX) ? " ENRX" : "",
+		(word&IRCFG_MSTR) ? " MSTR" : "",
+		(word&IRCFG_RXANY) ? " RXANY" : "",
+		(word&IRCFG_CRC16) ? " CRC16" : "",
+		(word&IRCFG_FIR) ? " FIR" : "",
+		(word&IRCFG_MIR) ? " MIR" : "",
+		(word&IRCFG_SIR) ? " SIR" : "",
+		(word&IRCFG_SIRFILT) ? " SIRFILT" : "",
+		(word&IRCFG_SIRTEST) ? " SIRTEST" : "",
+		(word&IRCFG_TXPOL) ? " TXPOL" : "",
+		(word&IRCFG_RXPOL) ? " RXPOL" : "");
+	word = inw(iobase+VLSI_PIO_IRENABLE);
+	out += sprintf(out, "IRENABLE:%s%s%s%s%s%s%s%s\n",
+		(word&IRENABLE_IREN) ? " IRENABLE" : "",
+		(word&IRENABLE_CFGER) ? " CFGERR" : "",
+		(word&IRENABLE_FIR_ON) ? " FIR_ON" : "",
+		(word&IRENABLE_MIR_ON) ? " MIR_ON" : "",
+		(word&IRENABLE_SIR_ON) ? " SIR_ON" : "",
+		(word&IRENABLE_ENTXST) ? " ENTXST" : "",
+		(word&IRENABLE_ENRXST) ? " ENRXST" : "",
+		(word&IRENABLE_CRC16_ON) ? " CRC16_ON" : "");
+	word = inw(iobase+VLSI_PIO_PHYCTL);
+	out += sprintf(out, "PHYCTL: baud-divisor=%u / pulsewidth=%u / preamble=%u\n",
+		(unsigned)PHYCTL_TO_BAUD(word),
+		(unsigned)PHYCTL_TO_PLSWID(word),
+		(unsigned)PHYCTL_TO_PREAMB(word));
+	word = inw(iobase+VLSI_PIO_NPHYCTL);
+	out += sprintf(out, "NPHYCTL: baud-divisor=%u / pulsewidth=%u / preamble=%u\n",
+		(unsigned)PHYCTL_TO_BAUD(word),
+		(unsigned)PHYCTL_TO_PLSWID(word),
+		(unsigned)PHYCTL_TO_PREAMB(word));
+	word = inw(iobase+VLSI_PIO_MAXPKT);
+	out += sprintf(out, "MAXPKT: max. rx packet size = %u\n", word);
+	word = inw(iobase+VLSI_PIO_RCVBCNT) & RCVBCNT_MASK;
+	out += sprintf(out, "RCVBCNT: rx-fifo filling level = %u\n", word);
+
+	out += sprintf(out, "\nsw-state:\n");
+	out += sprintf(out, "IrPHY setup: %d baud - %s encoding\n", idev->baud, 
+		(idev->mode==IFF_SIR)?"SIR":((idev->mode==IFF_MIR)?"MIR":"FIR"));
+	do_gettimeofday(&now);
+	if (now.tv_usec >= idev->last_rx.tv_usec) {
+		delta2 = now.tv_usec - idev->last_rx.tv_usec;
+		delta1 = 0;
+	}
+	else {
+		delta2 = 1000000 + now.tv_usec - idev->last_rx.tv_usec;
+		delta1 = 1;
+	}
+	out += sprintf(out, "last rx: %lu.%06u sec\n",
+		now.tv_sec - idev->last_rx.tv_sec - delta1, delta2);	
 
+	out += sprintf(out, "RX: packets=%lu / bytes=%lu / errors=%lu / dropped=%lu",
+		idev->stats.rx_packets, idev->stats.rx_bytes, idev->stats.rx_errors,
+		idev->stats.rx_dropped);
+	out += sprintf(out, " / overrun=%lu / length=%lu / frame=%lu / crc=%lu\n",
+		idev->stats.rx_over_errors, idev->stats.rx_length_errors,
+		idev->stats.rx_frame_errors, idev->stats.rx_crc_errors);
+	out += sprintf(out, "TX: packets=%lu / bytes=%lu / errors=%lu / dropped=%lu / fifo=%lu\n",
+		idev->stats.tx_packets, idev->stats.tx_bytes, idev->stats.tx_errors,
+		idev->stats.tx_dropped, idev->stats.tx_fifo_errors);
+
+	return out - buf;
+}
+		
+static int vlsi_proc_ring(struct vlsi_ring *r, char *buf, int len)
+{
+	struct ring_descr *rd;
+	unsigned i, j;
+	int h, t;
+	char *out = buf;
 
-/********************************************************/
+	if (len < 3000)
+		return 0;
 
-/* the memory required to hold the 2 descriptor rings */
+	out += sprintf(out, "size %u / mask 0x%04x / len %u / dir %d / hw %p\n",
+		r->size, r->mask, r->len, r->dir, r->rd[0].hw);
+	h = atomic_read(&r->head) & r->mask;
+	t = atomic_read(&r->tail) & r->mask;
+	out += sprintf(out, "head = %d / tail = %d ", h, t);
+	if (h == t)
+		out += sprintf(out, "(empty)\n");
+	else {
+		if (((t+1)&r->mask) == h)
+			out += sprintf(out, "(full)\n");
+		else
+			out += sprintf(out, "(level = %d)\n", ((unsigned)(t-h) & r->mask)); 
+		rd = &r->rd[h];
+		j = (unsigned) rd_get_count(rd);
+		out += sprintf(out, "current: rd = %d / status = %02x / len = %u\n",
+				h, (unsigned)rd_get_status(rd), j);
+		if (j > 0) {
+			out += sprintf(out, "   data:");
+			if (j > 20)
+				j = 20;
+			for (i = 0; i < j; i++)
+				out += sprintf(out, " %02x", (unsigned)((unsigned char *)rd->buf)[i]);
+			out += sprintf(out, "\n");
+		}
+	}
+	for (i = 0; i < r->size; i++) {
+		rd = &r->rd[i];
+		out += sprintf(out, "> ring descr %u: ", i);
+		out += sprintf(out, "skb=%p data=%p hw=%p\n", rd->skb, rd->buf, rd->hw);
+		out += sprintf(out, "  hw: status=%02x count=%u busaddr=0x%08x\n",
+			(unsigned) rd_get_status(rd),
+			(unsigned) rd_get_count(rd), (unsigned) rd_get_addr(rd));
+	}
+	return out - buf;
+}
 
-#define RING_AREA_SIZE		(2 * MAX_RING_DESCR * sizeof(struct ring_descr))
+static int vlsi_proc_print(struct net_device *ndev, char *buf, int len)
+{
+	vlsi_irda_dev_t *idev;
+	unsigned long flags;
+	char *out = buf;
 
-/* the memory required to hold the rings' buffer entries */
+	if (!ndev || !ndev->priv) {
+		printk(KERN_ERR "%s: invalid ptr!\n", __FUNCTION__);
+		return 0;
+	}
 
-#define RING_ENTRY_SIZE		(2 * MAX_RING_DESCR * sizeof(struct ring_entry))
+	idev = ndev->priv;
 
-/********************************************************/
+	if (len < 8000)
+		return 0;
 
-/* just dump all registers */
+	out += sprintf(out, "\n%s %s\n\n", DRIVER_NAME, DRIVER_VERSION);
+	out += sprintf(out, "clksrc: %s\n", 
+		(clksrc>=2) ? ((clksrc==3)?"40MHz XCLK":"48MHz XCLK")
+			    : ((clksrc==1)?"48MHz PLL":"autodetect"));
+	out += sprintf(out, "ringsize: tx=%d / rx=%d\n",
+		ringsize[0], ringsize[1]);
+	out += sprintf(out, "sirpulse: %s\n", (sirpulse)?"3/16 bittime":"short");
+	out += sprintf(out, "qos_mtt_bits: 0x%02x\n", (unsigned)qos_mtt_bits);
 
-static void vlsi_reg_debug(unsigned iobase, const char *s)
-{
-	int	i;
+	spin_lock_irqsave(&idev->lock, flags);
+	if (idev->pdev != NULL) {
+		out += vlsi_proc_pdev(idev->pdev, out, len - (out-buf));
+		if (idev->pdev->current_state == 0)
+			out += vlsi_proc_ndev(ndev, out, len - (out-buf));
+		else
+			out += sprintf(out, "\nPCI controller down - resume_ok = %d\n",
+				idev->resume_ok);
+		if (netif_running(ndev) && idev->rx_ring && idev->tx_ring) {
+			out += sprintf(out, "\n--------- RX ring -----------\n\n");
+			out += vlsi_proc_ring(idev->rx_ring, out, len - (out-buf));
+			out += sprintf(out, "\n--------- TX ring -----------\n\n");
+			out += vlsi_proc_ring(idev->tx_ring, out, len - (out-buf));
+		}
+	}
+	out += sprintf(out, "\n");
+	spin_unlock_irqrestore(&idev->lock, flags);
 
-	mb();
-	printk(KERN_DEBUG "%s: ", s);
-	for (i = 0; i < 0x20; i++)
-		printk("%02x", (unsigned)inb((iobase+i)));
-	printk("\n");
+	return out - buf;
 }
 
-/********************************************************/
-
+static struct proc_dir_entry *vlsi_proc_root = NULL;
 
-static int vlsi_set_clock(struct pci_dev *pdev)
-{
-	u8	clkctl, lock;
-	int	i, count;
+struct vlsi_proc_data {
+	int size;
+	char *data;
+};
 
-	if (clksrc < 2) { /* auto or PLL: try PLL */
-		clkctl = CLKCTL_NO_PD | CLKCTL_CLKSTP;
-		pci_write_config_byte(pdev, VLSI_PCI_CLKCTL, clkctl);
+/* most of the proc-fops code borrowed from usb/uhci */
 
-		/* procedure to detect PLL lock synchronisation:
-		 * after 0.5 msec initial delay we expect to find 3 PLL lock
-		 * indications within 10 msec for successful PLL detection.
-		 */
-		udelay(500);
-		count = 0;
-		for (i = 500; i <= 10000; i += 50) { /* max 10 msec */
-			pci_read_config_byte(pdev, VLSI_PCI_CLKCTL, &lock);
-			if (lock&CLKCTL_LOCK) {
-				if (++count >= 3)
-					break;
-			}
-			udelay(50);
-		}
-		if (count < 3) {
-			if (clksrc == 1) { /* explicitly asked for PLL hence bail out */
-				printk(KERN_ERR "%s: no PLL or failed to lock!\n",
-					__FUNCTION__);
-				clkctl = CLKCTL_CLKSTP;
-				pci_write_config_byte(pdev, VLSI_PCI_CLKCTL, clkctl);
-				return -1;
-			}
-			else			/* was: clksrc=0(auto) */
-				clksrc = 3;	/* fallback to 40MHz XCLK (OB800) */
+static int vlsi_proc_open(struct inode *inode, struct file *file)
+{
+	const struct proc_dir_entry *pde = PDE(inode);
+	struct net_device *ndev = pde->data;
+	vlsi_irda_dev_t *idev = ndev->priv;
+	struct vlsi_proc_data *procdata;
+	const int maxdata = 8000;
 
-			printk(KERN_INFO "%s: PLL not locked, fallback to clksrc=%d\n",
-				__FUNCTION__, clksrc);
-		}
-		else { /* got successful PLL lock */
-			clksrc = 1;
-			return 0;
-		}
+	lock_kernel();
+	procdata = kmalloc(sizeof(*procdata), GFP_KERNEL);
+	if (!procdata) {
+		unlock_kernel();
+		return -ENOMEM;
+	}
+	procdata->data = kmalloc(maxdata, GFP_KERNEL);
+	if (!procdata->data) {
+		kfree(procdata);
+		unlock_kernel();
+		return -ENOMEM;
 	}
 
-	/* we get here if either no PLL detected in auto-mode or
-	   the external clock source was explicitly specified */
-
-	clkctl = CLKCTL_EXTCLK | CLKCTL_CLKSTP;
-	if (clksrc == 3)
-		clkctl |= CLKCTL_XCKSEL;	
-	pci_write_config_byte(pdev, VLSI_PCI_CLKCTL, clkctl);
+	down(&idev->sem);
+	procdata->size = vlsi_proc_print(ndev, procdata->data, maxdata);
+	up(&idev->sem);
 
-	/* no way to test for working XCLK */
+	file->private_data = procdata;
 
 	return 0;
 }
 
-
-static void vlsi_start_clock(struct pci_dev *pdev)
+static loff_t vlsi_proc_lseek(struct file *file, loff_t off, int whence)
 {
-	u8	clkctl;
-
-	printk(KERN_INFO "%s: start clock using %s as input\n", __FUNCTION__,
-		(clksrc&2)?((clksrc&1)?"40MHz XCLK":"48MHz XCLK"):"48MHz PLL");
-	pci_read_config_byte(pdev, VLSI_PCI_CLKCTL, &clkctl);
-	clkctl &= ~CLKCTL_CLKSTP;
-	pci_write_config_byte(pdev, VLSI_PCI_CLKCTL, clkctl);
-}
-			
+	struct vlsi_proc_data *procdata;
+	loff_t new = -1;
 
-static void vlsi_stop_clock(struct pci_dev *pdev)
-{
-	u8	clkctl;
+	lock_kernel();
+	procdata = file->private_data;
 
-	pci_read_config_byte(pdev, VLSI_PCI_CLKCTL, &clkctl);
-	clkctl |= CLKCTL_CLKSTP;
-	pci_write_config_byte(pdev, VLSI_PCI_CLKCTL, clkctl);
+	switch (whence) {
+	case 0:
+		new = off;
+		break;
+	case 1:
+		new = file->f_pos + off;
+		break;
+	}
+	if (new < 0 || new > procdata->size) {
+		unlock_kernel();
+		return -EINVAL;
+	}
+	unlock_kernel();
+	return (file->f_pos = new);
 }
-			
 
-static void vlsi_unset_clock(struct pci_dev *pdev)
+static ssize_t vlsi_proc_read(struct file *file, char *buf, size_t nbytes,
+			loff_t *ppos)
 {
-	u8	clkctl;
-
-	pci_read_config_byte(pdev, VLSI_PCI_CLKCTL, &clkctl);
-	if (!(clkctl&CLKCTL_CLKSTP))
-		/* make sure clock is already stopped */
-		vlsi_stop_clock(pdev);
+	struct vlsi_proc_data *procdata = file->private_data;
+	unsigned int pos;
+	unsigned int size;
 
-	clkctl &= ~(CLKCTL_EXTCLK | CLKCTL_NO_PD);
-	pci_write_config_byte(pdev, VLSI_PCI_CLKCTL, clkctl);
-}
+	pos = *ppos;
+	size = procdata->size;
+	if (pos >= size)
+		return 0;
+	if (nbytes >= size)
+		nbytes = size;
+	if (pos + nbytes > size)
+		nbytes = size - pos;
 
-/********************************************************/
+	if (!access_ok(VERIFY_WRITE, buf, nbytes))
+		return -EINVAL;
 
+	copy_to_user(buf, procdata->data + pos, nbytes);
 
-/* ### FIXME: don't use old virt_to_bus() anymore! */
+	*ppos += nbytes;
 
+	return nbytes;
+}
 
-static void vlsi_arm_rx(struct vlsi_ring *r)
+static int vlsi_proc_release(struct inode *inode, struct file *file)
 {
-	unsigned	i;
-	dma_addr_t	ba;
+	struct vlsi_proc_data *procdata = file->private_data;
 
-	for (i = 0; i < r->size; i++) {
-		if (r->buf[i].data == NULL)
-			BUG();
-		ba = virt_to_bus(r->buf[i].data);
-		rd_set_addr_status(r, i, ba, RD_STAT_ACTIVE);
-	}
+	kfree(procdata->data);
+	kfree(procdata);
+
+	return 0;
 }
 
-static int vlsi_alloc_ringbuf(struct vlsi_ring *r)
+static struct file_operations vlsi_proc_fops = {
+	open:		vlsi_proc_open,
+	llseek:		vlsi_proc_lseek,
+	read:		vlsi_proc_read,
+	release:	vlsi_proc_release,
+};
+#endif
+
+/********************************************************/
+
+static struct vlsi_ring *vlsi_alloc_ring(struct pci_dev *pdev, struct ring_descr_hw *hwmap,
+						unsigned size, unsigned len, int dir)
 {
+	struct vlsi_ring *r;
+	struct ring_descr *rd;
 	unsigned	i, j;
+	dma_addr_t	busaddr;
 
-	r->head = r->tail = 0;
-	r->mask = r->size - 1;
-	for (i = 0; i < r->size; i++) {
-		r->buf[i].skb = NULL;
-		r->buf[i].data = kmalloc(XFER_BUF_SIZE, GFP_KERNEL|GFP_DMA);
-		if (r->buf[i].data == NULL) {
+	if (!size  ||  ((size-1)&size)!=0)	/* must be >0 and power of 2 */
+		return NULL;
+
+	r = kmalloc(sizeof(*r) + size * sizeof(struct ring_descr), GFP_KERNEL);
+	if (!r)
+		return NULL;
+	memset(r, 0, sizeof(*r));
+
+	r->pdev = pdev;
+	r->dir = dir;
+	r->len = len;
+	r->rd = (struct ring_descr *)(r+1);
+	r->mask = size - 1;
+	r->size = size;
+	atomic_set(&r->head, 0);
+	atomic_set(&r->tail, 0);
+
+	for (i = 0; i < size; i++) {
+		rd = r->rd + i;
+		memset(rd, 0, sizeof(*rd));
+		rd->hw = hwmap + i;
+		rd->buf = kmalloc(len, GFP_KERNEL|GFP_DMA);
+		if (rd->buf == NULL) {
 			for (j = 0; j < i; j++) {
-				kfree(r->buf[j].data);
-				r->buf[j].data = NULL;
+				rd = r->rd + j;
+				busaddr = rd_get_addr(rd);
+				rd_set_addr_status(rd, 0, 0);
+				if (busaddr)
+					pci_unmap_single(pdev, busaddr, len, dir);
+				kfree(rd->buf);
+				rd->buf = NULL;
 			}
-			return -ENOMEM;
+			kfree(r);
+			return NULL;
+		}
+		busaddr = pci_map_single(pdev, rd->buf, len, dir);
+		if (!busaddr) {
+			printk(KERN_ERR "%s: failed to create PCI-MAP for %p",
+				__FUNCTION__, rd->buf);
+			BUG();
 		}
+		rd_set_addr_status(rd, busaddr, 0);
+		pci_dma_sync_single(pdev, busaddr, len, dir);
+		/* initially, the dma buffer is owned by the CPU */
+		rd->skb = NULL;
 	}
-	return 0;
+	return r;
 }
 
-static void vlsi_free_ringbuf(struct vlsi_ring *r)
+static int vlsi_free_ring(struct vlsi_ring *r)
 {
+	struct ring_descr *rd;
 	unsigned	i;
+	dma_addr_t	busaddr;
 
 	for (i = 0; i < r->size; i++) {
-		if (r->buf[i].data == NULL)
-			continue;
-		if (r->buf[i].skb) {
-			dev_kfree_skb(r->buf[i].skb);
-			r->buf[i].skb = NULL;
-		}
-		else
-			kfree(r->buf[i].data);
-		r->buf[i].data = NULL;
+		rd = r->rd + i;
+		if (rd->skb)
+			dev_kfree_skb_any(rd->skb);
+		busaddr = rd_get_addr(rd);
+		rd_set_addr_status(rd, 0, 0);
+		if (busaddr)
+			pci_unmap_single(r->pdev, busaddr, r->len, r->dir);
+		if (rd->buf)
+			kfree(rd->buf);
 	}
+	kfree(r);
+	return 0;
 }
 
-
-static int vlsi_init_ring(vlsi_irda_dev_t *idev)
+static int vlsi_create_hwif(vlsi_irda_dev_t *idev)
 {
-	char 		 *ringarea;
+	char 			*ringarea;
+	struct ring_descr_hw	*hwmap;
+
+	idev->virtaddr = NULL;
+	idev->busaddr = 0;
 
-	ringarea = pci_alloc_consistent(idev->pdev, RING_AREA_SIZE, &idev->busaddr);
+	ringarea = pci_alloc_consistent(idev->pdev, HW_RING_AREA_SIZE, &idev->busaddr);
 	if (!ringarea) {
 		printk(KERN_ERR "%s: insufficient memory for descriptor rings\n",
 			__FUNCTION__);
-		return -ENOMEM;
+		goto out;
 	}
-	memset(ringarea, 0, RING_AREA_SIZE);
+	memset(ringarea, 0, HW_RING_AREA_SIZE);
 
-#if 0
-	printk(KERN_DEBUG "%s: (%d,%d)-ring %p / %p\n", __FUNCTION__,
-		ringsize[0], ringsize[1], ringarea, 
-		(void *)(unsigned)idev->busaddr);
-#endif
+	hwmap = (struct ring_descr_hw *)ringarea;
+	idev->rx_ring = vlsi_alloc_ring(idev->pdev, hwmap, ringsize[1],
+					XFER_BUF_SIZE, PCI_DMA_FROMDEVICE);
+	if (idev->rx_ring == NULL)
+		goto out_unmap;
+
+	hwmap += MAX_RING_DESCR;
+	idev->tx_ring = vlsi_alloc_ring(idev->pdev, hwmap, ringsize[0],
+					XFER_BUF_SIZE, PCI_DMA_TODEVICE);
+	if (idev->tx_ring == NULL)
+		goto out_free_rx;
 
-	idev->rx_ring.size = ringsize[1];
-	idev->rx_ring.hw = (struct ring_descr *)ringarea;
-	if (!vlsi_alloc_ringbuf(&idev->rx_ring)) {
-		idev->tx_ring.size = ringsize[0];
-		idev->tx_ring.hw = idev->rx_ring.hw + MAX_RING_DESCR;
-		if (!vlsi_alloc_ringbuf(&idev->tx_ring)) {
-			idev->virtaddr = ringarea;
-			return 0;
-		}
-		vlsi_free_ringbuf(&idev->rx_ring);
-	}
+	idev->virtaddr = ringarea;
+	return 0;
 
-	pci_free_consistent(idev->pdev, RING_AREA_SIZE,
-		ringarea, idev->busaddr);
-	printk(KERN_ERR "%s: insufficient memory for ring buffers\n",
-		__FUNCTION__);
-	return -1;
+out_free_rx:
+	vlsi_free_ring(idev->rx_ring);
+out_unmap:
+	idev->rx_ring = idev->tx_ring = NULL;
+	pci_free_consistent(idev->pdev, HW_RING_AREA_SIZE, ringarea, idev->busaddr);
+	idev->busaddr = 0;
+out:
+	return -ENOMEM;
 }
 
+static int vlsi_destroy_hwif(vlsi_irda_dev_t *idev)
+{
+	vlsi_free_ring(idev->rx_ring);
+	vlsi_free_ring(idev->tx_ring);
+	idev->rx_ring = idev->tx_ring = NULL;
 
+	if (idev->busaddr)
+		pci_free_consistent(idev->pdev,HW_RING_AREA_SIZE,idev->virtaddr,idev->busaddr);
 
-/********************************************************/
+	idev->virtaddr = NULL;
+	idev->busaddr = 0;
 
+	return 0;
+}
 
+/********************************************************/
 
-static int vlsi_set_baud(struct net_device *ndev)
+static int vlsi_process_rx(struct vlsi_ring *r, struct ring_descr *rd)
 {
+	u16		status;
+	int		crclen, len = 0;
+	struct sk_buff	*skb;
+	int		ret = 0;
+	struct net_device *ndev = (struct net_device *)pci_get_drvdata(r->pdev);
 	vlsi_irda_dev_t *idev = ndev->priv;
-	unsigned long flags;
-	u16 nphyctl;
-	unsigned iobase; 
-	u16 config;
-	unsigned mode;
-	int	ret;
-	int	baudrate;
-
-	baudrate = idev->new_baud;
-	iobase = ndev->base_addr;
 
-	printk(KERN_DEBUG "%s: %d -> %d\n", __FUNCTION__, idev->baud, idev->new_baud);
+	pci_dma_sync_single(r->pdev, rd_get_addr(rd), r->len, r->dir);
+	/* dma buffer now owned by the CPU */
+	status = rd_get_status(rd);
+	if (status & RD_RX_ERROR) {
+		if (status & RD_RX_OVER)  
+			ret |= VLSI_RX_OVER;
+		if (status & RD_RX_LENGTH)  
+			ret |= VLSI_RX_LENGTH;
+		if (status & RD_RX_PHYERR)  
+			ret |= VLSI_RX_FRAME;
+		if (status & RD_RX_CRCERR)  
+			ret |= VLSI_RX_CRC;
+	}
+	else {
+		len = rd_get_count(rd);
+		crclen = (idev->mode==IFF_FIR) ? sizeof(u32) : sizeof(u16);
+		len -= crclen;		/* remove trailing CRC */
+		if (len <= 0) {
+			printk(KERN_ERR "%s: strange frame (len=%d)\n",
+				__FUNCTION__, len);
+			ret |= VLSI_RX_DROP;
+		}
+		else if (!rd->skb) {
+			printk(KERN_ERR "%s: rx packet dropped\n", __FUNCTION__);
+			ret |= VLSI_RX_DROP;
+		}
+		else {
+			skb = rd->skb;
+			rd->skb = NULL;
+			skb->dev = ndev;
+			memcpy(skb_put(skb,len), rd->buf, len);
+			skb->mac.raw = skb->data;
+			if (in_interrupt())
+				netif_rx(skb);
+			else
+				netif_rx_ni(skb);
+			ndev->last_rx = jiffies;
+		}
+	}
+	rd_set_status(rd, 0);
+	rd_set_count(rd, 0);
+	/* buffer still owned by CPU */
 
-	spin_lock_irqsave(&idev->lock, flags);
+	return (ret) ? -ret : len;
+}
 
-	outw(0, iobase+VLSI_PIO_IRENABLE);
+static void vlsi_fill_rx(struct vlsi_ring *r)
+{
+	struct ring_descr *rd;
 
-	if (baudrate == 4000000) {
-		mode = IFF_FIR;
-		config = IRCFG_FIR;
-		nphyctl = PHYCTL_FIR;
+	for (rd = ring_last(r); rd != NULL; rd = ring_put(r)) {
+		if (rd_is_active(rd)) {
+			BUG();
+			break;
+		}
+		if (!rd->skb) {
+			rd->skb = dev_alloc_skb(IRLAP_SKB_ALLOCSIZE);
+			if (rd->skb) {
+				skb_reserve(rd->skb,1);
+				rd->skb->protocol = htons(ETH_P_IRDA);
+			}
+			else
+				break;	/* probably not worth logging? */
+		}
+		/* give dma buffer back to busmaster */
+		pci_dma_prep_single(r->pdev, rd_get_addr(rd), r->len, r->dir);
+		rd_activate(rd);
 	}
-	else if (baudrate == 1152000) {
-		mode = IFF_MIR;
-		config = IRCFG_MIR | IRCFG_CRC16;
+}
+
+static void vlsi_rx_interrupt(struct net_device *ndev)
+{
+	vlsi_irda_dev_t *idev = ndev->priv;
+	struct vlsi_ring *r = idev->rx_ring;
+	struct ring_descr *rd;
+	int ret;
+
+	for (rd = ring_first(r); rd != NULL; rd = ring_get(r)) {
+
+		if (rd_is_active(rd))
+			break;
+
+		ret = vlsi_process_rx(r, rd);
+
+		if (ret < 0) {
+			ret = -ret;
+			idev->stats.rx_errors++;
+			if (ret & VLSI_RX_DROP)  
+				idev->stats.rx_dropped++;
+			if (ret & VLSI_RX_OVER)  
+				idev->stats.rx_over_errors++;
+			if (ret & VLSI_RX_LENGTH)  
+				idev->stats.rx_length_errors++;
+			if (ret & VLSI_RX_FRAME)  
+				idev->stats.rx_frame_errors++;
+			if (ret & VLSI_RX_CRC)  
+				idev->stats.rx_crc_errors++;
+		}
+		else if (ret > 0) {
+			idev->stats.rx_packets++;
+			idev->stats.rx_bytes += ret;
+		}
+	}
+
+	do_gettimeofday(&idev->last_rx); /* remember "now" for later mtt delay */
+
+	vlsi_fill_rx(r);
+
+	if (ring_first(r) == NULL) {
+		/* we are in big trouble, if this should ever happen */
+		printk(KERN_ERR "%s: rx ring exhausted!\n", __FUNCTION__);
+		vlsi_ring_debug(r);
+	}
+	else
+		outw(0, ndev->base_addr+VLSI_PIO_PROMPT);
+}
+
+/* caller must have stopped the controller from busmastering */
+
+static void vlsi_unarm_rx(vlsi_irda_dev_t *idev)
+{
+	struct vlsi_ring *r = idev->rx_ring;
+	struct ring_descr *rd;
+	int ret;
+
+	for (rd = ring_first(r); rd != NULL; rd = ring_get(r)) {
+
+		ret = 0;
+		if (rd_is_active(rd)) {
+			rd_set_status(rd, 0);
+			if (rd_get_count(rd)) {
+				printk(KERN_INFO "%s - dropping rx packet\n", __FUNCTION__);
+				ret = -VLSI_RX_DROP;
+			}
+			rd_set_count(rd, 0);
+			pci_dma_sync_single(r->pdev, rd_get_addr(rd), r->len, r->dir);
+			if (rd->skb) {
+				dev_kfree_skb_any(rd->skb);
+				rd->skb = NULL;
+			}
+		}
+		else
+			ret = vlsi_process_rx(r, rd);
+
+		if (ret < 0) {
+			ret = -ret;
+			idev->stats.rx_errors++;
+			if (ret & VLSI_RX_DROP)  
+				idev->stats.rx_dropped++;
+			if (ret & VLSI_RX_OVER)  
+				idev->stats.rx_over_errors++;
+			if (ret & VLSI_RX_LENGTH)  
+				idev->stats.rx_length_errors++;
+			if (ret & VLSI_RX_FRAME)  
+				idev->stats.rx_frame_errors++;
+			if (ret & VLSI_RX_CRC)  
+				idev->stats.rx_crc_errors++;
+		}
+		else if (ret > 0) {
+			idev->stats.rx_packets++;
+			idev->stats.rx_bytes += ret;
+		}
+	}
+}
+
+/********************************************************/
+
+static int vlsi_process_tx(struct vlsi_ring *r, struct ring_descr *rd)
+{
+	u16		status;
+	int		len;
+	int		ret;
+
+	pci_dma_sync_single(r->pdev, rd_get_addr(rd), r->len, r->dir);
+	/* dma buffer now owned by the CPU */
+	status = rd_get_status(rd);
+	if (status & RD_TX_UNDRN)
+		ret = VLSI_TX_FIFO;
+	else
+		ret = 0;
+	rd_set_status(rd, 0);
+
+	if (rd->skb) {
+		len = rd->skb->len;
+		dev_kfree_skb_any(rd->skb);
+		rd->skb = NULL;
+	}
+	else	/* tx-skb already freed? - should never happen */
+		len = rd_get_count(rd);		/* incorrect for SIR! (due to wrapping) */
+
+	rd_set_count(rd, 0);
+	/* dma buffer still owned by the CPU */
+
+	return (ret) ? -ret : len;
+}
+
+static int vlsi_set_baud(struct net_device *ndev, int dolock)
+{
+	vlsi_irda_dev_t *idev = ndev->priv;
+	unsigned long flags;
+	u16 nphyctl;
+	unsigned iobase; 
+	u16 config;
+	unsigned mode;
+	unsigned idle_retry;
+	int	ret;
+	int	baudrate;
+	int	fifocnt = 0;	/* Keep compiler happy */
+
+	baudrate = idev->new_baud;
+	iobase = ndev->base_addr;
+#if 0
+	printk(KERN_DEBUG "%s: %d -> %d\n", __FUNCTION__, idev->baud, idev->new_baud);
+#endif
+	if (baudrate == 4000000) {
+		mode = IFF_FIR;
+		config = IRCFG_FIR;
+		nphyctl = PHYCTL_FIR;
+	}
+	else if (baudrate == 1152000) {
+		mode = IFF_MIR;
+		config = IRCFG_MIR | IRCFG_CRC16;
 		nphyctl = PHYCTL_MIR(clksrc==3);
 	}
 	else {
 		mode = IFF_SIR;
-		config = IRCFG_SIR | IRCFG_SIRFILT | IRCFG_RXANY;
+		config = IRCFG_SIR | IRCFG_SIRFILT  | IRCFG_RXANY;
 		switch(baudrate) {
 			default:
 				printk(KERN_ERR "%s: undefined baudrate %d - fallback to 9600!\n",
@@ -473,6 +893,32 @@ static int vlsi_set_baud(struct net_devi
 		}
 	}
 
+	if (dolock)
+		spin_lock_irqsave(&idev->lock, flags);
+	else
+		flags = 0xdead;	/* prevent bogus warning about possible uninitialized use */
+
+	for (idle_retry=0; idle_retry < 100; idle_retry++) {
+		fifocnt = inw(ndev->base_addr+VLSI_PIO_RCVBCNT) & RCVBCNT_MASK;
+		if (fifocnt == 0)
+			break;
+		if (!idle_retry)
+			printk(KERN_WARNING "%s: waiting for rx fifo to become empty(%d)\n",
+				__FUNCTION__, fifocnt);
+		if (dolock) {
+			spin_unlock_irqrestore(&idev->lock, flags);
+			udelay(100);
+			spin_lock_irqsave(&idev->lock, flags);
+		}
+		else
+			udelay(100);
+	}
+	if (fifocnt != 0)
+		printk(KERN_ERR "%s: rx fifo not empty(%d)\n", __FUNCTION__, fifocnt);
+
+	outw(0, iobase+VLSI_PIO_IRENABLE);
+	wmb();
+
 	config |= IRCFG_MSTR | IRCFG_ENRX;
 
 	outw(config, iobase+VLSI_PIO_IRCFG);
@@ -480,10 +926,12 @@ static int vlsi_set_baud(struct net_devi
 	outw(nphyctl, iobase+VLSI_PIO_NPHYCTL);
 	wmb();
 	outw(IRENABLE_IREN, iobase+VLSI_PIO_IRENABLE);
+	mb();
 
-	/* chip fetches IRCFG on next rising edge of its 8MHz clock */
+	udelay(1);	/* chip applies IRCFG on next rising edge of its 8MHz clock */
+
+	/* read back settings for validation */
 
-	mb();
 	config = inw(iobase+VLSI_PIO_IRENABLE) & IRENABLE_MASK;
 
 	if (mode == IFF_FIR)
@@ -493,7 +941,6 @@ static int vlsi_set_baud(struct net_devi
 	else
 		config ^= IRENABLE_SIR_ON;
 
-
 	if (config != (IRENABLE_IREN|IRENABLE_ENRXST)) {
 		printk(KERN_ERR "%s: failed to set %s mode!\n", __FUNCTION__,
 			(mode==IFF_SIR)?"SIR":((mode==IFF_MIR)?"MIR":"FIR"));
@@ -512,7 +959,8 @@ static int vlsi_set_baud(struct net_devi
 			ret = 0;
 		}
 	}
-	spin_unlock_irqrestore(&idev->lock, flags);
+	if (dolock)
+		spin_unlock_irqrestore(&idev->lock, flags);
 
 	if (ret)
 		vlsi_reg_debug(iobase,__FUNCTION__);
@@ -520,278 +968,396 @@ static int vlsi_set_baud(struct net_devi
 	return ret;
 }
 
+static inline int vlsi_set_baud_lock(struct net_device *ndev)
+{
+	return vlsi_set_baud(ndev, 1);
+}
 
+static inline int vlsi_set_baud_nolock(struct net_device *ndev)
+{
+	return vlsi_set_baud(ndev, 0);
+}
 
-static int vlsi_init_chip(struct net_device *ndev)
+static int vlsi_hard_start_xmit(struct sk_buff *skb, struct net_device *ndev)
 {
 	vlsi_irda_dev_t *idev = ndev->priv;
-	unsigned	iobase;
-	u16 ptr;
-
-	iobase = ndev->base_addr;
-
-	outb(IRINTR_INT_MASK, iobase+VLSI_PIO_IRINTR); /* w/c pending IRQ, disable all INT */
-
-	outw(0, iobase+VLSI_PIO_IRENABLE);	/* disable IrPHY-interface */
+	struct vlsi_ring	*r = idev->tx_ring;
+	struct ring_descr *rd;
+	unsigned long flags;
+	unsigned iobase = ndev->base_addr;
+	u8 status;
+	u16 config;
+	int mtt;
+	int len, speed;
+	struct timeval  now, ready;
 
-	/* disable everything, particularly IRCFG_MSTR - which resets the RING_PTR */
+	speed = irda_get_next_speed(skb);
+	if (speed != -1  &&  speed != idev->baud) {
+		netif_stop_queue(ndev);
+		idev->new_baud = speed;
+		if (!skb->len) {
+			dev_kfree_skb_any(skb);
 
-	outw(0, iobase+VLSI_PIO_IRCFG);
-	wmb();
-	outw(IRENABLE_IREN, iobase+VLSI_PIO_IRENABLE);
+			/* due to the completely asynch tx operation we might have
+			 * IrLAP racing with the hardware here, f.e. if the controller
+			 * is just sending the last packet with current speed while
+			 * the LAP is already switching the speed using synchronous
+			 * len=0 packet. Immediate execution would lead to hw lockup
+			 * requiring a powercycle to reset. Good candidate to trigger
+			 * this is the final UA:RSP packet after receiving a DISC:CMD
+			 * when getting the LAP down.
+			 * Note that we are not protected by the queue_stop approach
+			 * because the final UA:RSP arrives _without_ request to apply
+			 * new-speed-after-this-packet - hence the driver doesn't know
+			 * this was the last packet and doesn't stop the queue. So the
+			 * forced switch to default speed from LAP gets through as fast
+			 * as only some 10 usec later while the UA:RSP is still processed
+			 * by the hardware and we would get screwed.
+			 * Note: no locking required since we (netdev->xmit) are the only
+			 * supplier for tx and the network layer provides serialization
+			 */
+			spin_lock_irqsave(&idev->lock, flags);
+			if (ring_first(idev->tx_ring) == NULL) {
+				/* no race - tx-ring already empty */
+				vlsi_set_baud_nolock(ndev);
+				netif_wake_queue(ndev);
+			}
+			else
+				; /* keep the speed change pending like it would
+				   * for any len>0 packet. tx completion interrupt
+				   * will apply it when the tx ring becomes empty.
+				   */
+			spin_unlock_irqrestore(&idev->lock, flags);
+			return 0;
+		}
+		status = RD_TX_CLRENTX;  /* stop tx-ring after this frame */
+	}
+	else
+		status = 0;
 
-	mb();
+	if (skb->len == 0) {
+		printk(KERN_ERR "%s: dropping len=0 packet\n", __FUNCTION__);
+		goto drop;
+	}
 
-	outw(0, iobase+VLSI_PIO_IRENABLE);
+	/* sanity checks - should never happen!
+	 * simply BUGging the violation and dropping the packet
+	 */
 
-	outw(MAX_PACKET_LENGTH, iobase+VLSI_PIO_MAXPKT);  /* max possible value=0x0fff */
+	rd = ring_last(r);
+	if (!rd) {				/* ring full - queue should have been stopped! */
+		BUG();
+		goto drop;
+	}
 
-	outw(BUS_TO_RINGBASE(idev->busaddr), iobase+VLSI_PIO_RINGBASE);
+	if (rd_is_active(rd)) {			/* entry still owned by hw! */
+		BUG();
+		goto drop;
+	}
 
-	outw(TX_RX_TO_RINGSIZE(idev->tx_ring.size, idev->rx_ring.size),
-		iobase+VLSI_PIO_RINGSIZE);	
+	if (!rd->buf) {				/* no memory for this tx entry - weird! */
+		BUG();
+		goto drop;
+	}
 
-	ptr = inw(iobase+VLSI_PIO_RINGPTR);
-	idev->rx_ring.head = idev->rx_ring.tail = RINGPTR_GET_RX(ptr);
-	idev->tx_ring.head = idev->tx_ring.tail = RINGPTR_GET_TX(ptr);
+	if (rd->skb) {				/* hm, associated old skb still there */
+		BUG();
+		goto drop;
+	}
 
-	outw(IRCFG_MSTR, iobase+VLSI_PIO_IRCFG);		/* ready for memory access */
-	wmb();
-	outw(IRENABLE_IREN, iobase+VLSI_PIO_IRENABLE);
+	/* tx buffer already owned by CPU due to pci_dma_sync_single() either
+	 * after initial pci_map_single or after subsequent tx-completion
+	 */
 
-	mb();
+	if (idev->mode == IFF_SIR) {
+		status |= RD_TX_DISCRC;		/* no hw-crc creation */
+		len = async_wrap_skb(skb, rd->buf, r->len);
 
-	idev->new_baud = 9600;		/* start with IrPHY using 9600(SIR) mode */
-	vlsi_set_baud(ndev);
+		/* Some rare worst case situation in SIR mode might lead to
+		 * potential buffer overflow. The wrapper detects this, returns
+		 * with a shortened frame (without FCS/EOF) but doesn't provide
+		 * any error indication about the invalid packet which we are
+		 * going to transmit.
+		 * Therefore we log if the buffer got filled to the point, where the
+		 * wrapper would abort, i.e. when there are less than 5 bytes left to
+		 * allow appending the FCS/EOF.
+		 */
 
-	outb(IRINTR_INT_MASK, iobase+VLSI_PIO_IRINTR);	/* just in case - w/c pending IRQ's */
-	wmb();
+		if (len >= r->len-5)
+			 printk(KERN_WARNING "%s: possible buffer overflow with SIR wrapping!\n",
+			 	__FUNCTION__);
+	}
+	else {
+		/* hw deals with MIR/FIR mode wrapping */
+		status |= RD_TX_PULSE;		/* send 2 us highspeed indication pulse */
+		len = skb->len;
+		if (len > r->len) {
+			printk(KERN_ERR "%s: no space - skb too big (%d)\n",
+				__FUNCTION__, skb->len);
+			goto drop;
+		}
+		else
+			memcpy(rd->buf, skb->data, len);
+	}
 
-	/* DO NOT BLINDLY ENABLE IRINTR_ACTEN!
-	 * basically every received pulse fires an ACTIVITY-INT
-	 * leading to >>1000 INT's per second instead of few 10
-	 */
+	/* do mtt delay before we need to disable interrupts! */
 
-	outb(IRINTR_RPKTEN|IRINTR_TPKTEN, iobase+VLSI_PIO_IRINTR);
-	wmb();
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
+	}
 
-	return 0;
-}
+	rd->skb = skb;			/* remember skb for tx-complete stats */
 
+	rd_set_count(rd, len);
+	rd_set_status(rd, status);	/* not yet active! */
 
-/**************************************************************/
+	/* give dma buffer back to busmaster-hw (flush caches to make
+	 * CPU-driven changes visible from the pci bus).
+	 */
 
+	pci_dma_prep_single(r->pdev, rd_get_addr(rd), r->len, r->dir);
 
-static void vlsi_refill_rx(struct vlsi_ring *r)
-{
-	do {
-		if (rd_is_active(r, r->head))
-			BUG();
-		rd_activate(r, r->head);
-		ring_put(r);
-	} while (r->head != r->tail);
-}
+/*
+ *	We need to disable IR output in order to switch to TX mode.
+ *	Better not do this blindly anytime we want to transmit something
+ *	because TX may already run. However we are racing with the controller
+ *	which may stop TX at any time when fetching an inactive descriptor
+ *	or one with CLR_ENTX set. So we switch on TX only, if TX was not running
+ *	_after_ the new descriptor was activated on the ring. This ensures
+ *	we will either find TX already stopped or we can be sure, there
+ *	will be a TX-complete interrupt even if the chip stopped doing
+ *	TX just after we found it still running. The ISR will then find
+ *	the non-empty ring and restart TX processing. The enclosing
+ *	spinlock provides the correct serialization to prevent race with isr.
+ */
 
+	spin_lock_irqsave(&idev->lock,flags);
 
-static int vlsi_rx_interrupt(struct net_device *ndev)
-{
-	vlsi_irda_dev_t *idev = ndev->priv;
-	struct vlsi_ring *r;
-	int	len;
-	u8	status;
-	struct sk_buff	*skb;
-	int	crclen;
+	rd_activate(rd);
 
-	r = &idev->rx_ring;
-	while (!rd_is_active(r, r->tail)) {
+	if (!(inw(iobase+VLSI_PIO_IRENABLE) & IRENABLE_ENTXST)) {
+		int fifocnt;
 
-		status = rd_get_status(r, r->tail);
-		if (status & RX_STAT_ERROR) {
-			idev->stats.rx_errors++;
-			if (status & RX_STAT_OVER)  
-				idev->stats.rx_over_errors++;
-			if (status & RX_STAT_LENGTH)  
-				idev->stats.rx_length_errors++;
-			if (status & RX_STAT_PHYERR)  
-				idev->stats.rx_frame_errors++;
-			if (status & RX_STAT_CRCERR)  
-				idev->stats.rx_crc_errors++;
-		}
-		else {
-			len = rd_get_count(r, r->tail);
-			crclen = (idev->mode==IFF_FIR) ? sizeof(u32) : sizeof(u16);
-			if (len < crclen)
-				printk(KERN_ERR "%s: strange frame (len=%d)\n",
-					__FUNCTION__, len);
-			else
-				len -= crclen;		/* remove trailing CRC */
+		fifocnt = inw(ndev->base_addr+VLSI_PIO_RCVBCNT) & RCVBCNT_MASK;
+		if (fifocnt != 0)
+			printk(KERN_WARNING "%s: rx fifo not empty(%d)\n",
+				__FUNCTION__, fifocnt);
 
-			skb = dev_alloc_skb(len+1);
-			if (skb) {
-				skb->dev = ndev;
-				skb_reserve(skb,1);
-				memcpy(skb_put(skb,len), r->buf[r->tail].data, len);
-				idev->stats.rx_packets++;
-				idev->stats.rx_bytes += len;
-				skb->mac.raw = skb->data;
-				skb->protocol = htons(ETH_P_IRDA);
-				netif_rx(skb);				
-				ndev->last_rx = jiffies;
-			}
-			else {
-				idev->stats.rx_dropped++;
-				printk(KERN_ERR "%s: rx packet dropped\n", __FUNCTION__);
-			}
-		}
-		rd_set_count(r, r->tail, 0);
-		rd_set_status(r, r->tail, 0);
-		ring_get(r);
-		if (r->tail == r->head) {
-			printk(KERN_WARNING "%s: rx ring exhausted\n", __FUNCTION__);
-			break;
-		}
+		config = inw(iobase+VLSI_PIO_IRCFG);
+		rmb();
+		outw(config | IRCFG_ENTX, iobase+VLSI_PIO_IRCFG);
+		mb();
+		outw(0, iobase+VLSI_PIO_PROMPT);
 	}
+	ndev->trans_start = jiffies;
 
-	do_gettimeofday(&idev->last_rx); /* remember "now" for later mtt delay */
-
-	vlsi_refill_rx(r);
-
-	mb();
-	outw(0, ndev->base_addr+VLSI_PIO_PROMPT);
+	if (ring_put(r) == NULL) {
+		netif_stop_queue(ndev);
+		printk(KERN_DEBUG "%s: tx ring full - queue stopped\n", __FUNCTION__);
+	}
+	spin_unlock_irqrestore(&idev->lock, flags);
 
 	return 0;
-}
 
+drop:
+	dev_kfree_skb_any(skb);
+	idev->stats.tx_errors++;
+	idev->stats.tx_dropped++;
+	return 1;
+}
 
-static int vlsi_tx_interrupt(struct net_device *ndev)
+static void vlsi_tx_interrupt(struct net_device *ndev)
 {
 	vlsi_irda_dev_t *idev = ndev->priv;
-	struct vlsi_ring	*r;
+	struct vlsi_ring	*r = idev->tx_ring;
+	struct ring_descr	*rd;
 	unsigned	iobase;
 	int	ret;
 	u16	config;
-	u16	status;
 
-	r = &idev->tx_ring;
-	while (!rd_is_active(r, r->tail)) {
-		if (r->tail == r->head)
-			break;	/* tx ring empty - nothing to send anymore */
+	for (rd = ring_first(r); rd != NULL; rd = ring_get(r)) {
 
-		status = rd_get_status(r, r->tail);
-		if (status & TX_STAT_UNDRN) {
+		if (rd_is_active(rd))
+			break;
+
+		ret = vlsi_process_tx(r, rd);
+
+		if (ret < 0) {
+			ret = -ret;
 			idev->stats.tx_errors++;
-			idev->stats.tx_fifo_errors++;
+			if (ret & VLSI_TX_DROP)
+				idev->stats.tx_dropped++;
+			if (ret & VLSI_TX_FIFO)
+				idev->stats.tx_fifo_errors++;
 		}
-		else {
+		else if (ret > 0){
 			idev->stats.tx_packets++;
-			idev->stats.tx_bytes += rd_get_count(r, r->tail); /* not correct for SIR */
+			idev->stats.tx_bytes += ret;
 		}
-		rd_set_count(r, r->tail, 0);
-		rd_set_status(r, r->tail, 0);
-		if (r->buf[r->tail].skb) {
-			rd_set_addr_status(r, r->tail, 0, 0);
-			dev_kfree_skb(r->buf[r->tail].skb);
-			r->buf[r->tail].skb = NULL;
-			r->buf[r->tail].data = NULL;
-		}
-		ring_get(r);
 	}
 
-	ret = 0;
-	iobase = ndev->base_addr;
+	if (idev->new_baud  &&  rd == NULL)	/* tx ring empty and speed change pending */
+		vlsi_set_baud_lock(ndev);
 
-	if (r->head == r->tail) {	/* tx ring empty: re-enable rx */
+	iobase = ndev->base_addr;
+	config = inw(iobase+VLSI_PIO_IRCFG);
 
-		outw(0, iobase+VLSI_PIO_IRENABLE);
-		config = inw(iobase+VLSI_PIO_IRCFG);
-		mb();
+	if (rd == NULL)			/* tx ring empty: re-enable rx */
 		outw((config & ~IRCFG_ENTX) | IRCFG_ENRX, iobase+VLSI_PIO_IRCFG);
-		wmb();
-		outw(IRENABLE_IREN, iobase+VLSI_PIO_IRENABLE);
+
+	else if (!(inw(iobase+VLSI_PIO_IRENABLE) & IRENABLE_ENTXST)) {
+		int fifocnt;
+
+		fifocnt = inw(iobase+VLSI_PIO_RCVBCNT) & RCVBCNT_MASK;
+		if (fifocnt != 0)
+			printk(KERN_WARNING "%s: rx fifo not empty(%d)\n",
+				__FUNCTION__, fifocnt);
+		outw(config | IRCFG_ENTX, iobase+VLSI_PIO_IRCFG);
 	}
-	else
-		ret = 1;			/* no speed-change-check */
 
-	mb();
 	outw(0, iobase+VLSI_PIO_PROMPT);
 
-	if (netif_queue_stopped(ndev)) {
+	if (netif_queue_stopped(ndev)  &&  !idev->new_baud) {
 		netif_wake_queue(ndev);
 		printk(KERN_DEBUG "%s: queue awoken\n", __FUNCTION__);
 	}
-	return ret;
 }
 
+/* caller must have stopped the controller from busmastering */
 
-#if 0	/* disable ACTIVITY handling for now */
-
-static int vlsi_act_interrupt(struct net_device *ndev)
+static void vlsi_unarm_tx(vlsi_irda_dev_t *idev)
 {
-	printk(KERN_DEBUG "%s\n", __FUNCTION__);
-	return 0;
+	struct vlsi_ring *r = idev->tx_ring;
+	struct ring_descr *rd;
+	int ret;
+
+	for (rd = ring_first(r); rd != NULL; rd = ring_get(r)) {
+
+		ret = 0;
+		if (rd_is_active(rd)) {
+			rd_set_status(rd, 0);
+			rd_set_count(rd, 0);
+			pci_dma_sync_single(r->pdev, rd_get_addr(rd), r->len, r->dir);
+			if (rd->skb) {
+				dev_kfree_skb_any(rd->skb);
+				rd->skb = NULL;
+			}
+			printk(KERN_INFO "%s - dropping tx packet\n", __FUNCTION__);
+			ret = -VLSI_TX_DROP;
+		}
+		else
+			ret = vlsi_process_tx(r, rd);
+
+		if (ret < 0) {
+			ret = -ret;
+			idev->stats.tx_errors++;
+			if (ret & VLSI_TX_DROP)
+				idev->stats.tx_dropped++;
+			if (ret & VLSI_TX_FIFO)
+				idev->stats.tx_fifo_errors++;
+		}
+		else if (ret > 0){
+			idev->stats.tx_packets++;
+			idev->stats.tx_bytes += ret;
+		}
+	}
+
 }
-#endif
 
-static void vlsi_interrupt(int irq, void *dev_instance, struct pt_regs *regs)
-{
-	struct net_device *ndev = dev_instance;
-	vlsi_irda_dev_t *idev = ndev->priv;
-	unsigned	iobase;
-	u8		irintr;
-	int 		boguscount = 32;
-	int		no_speed_check = 0;
-	unsigned	got_act;
-	unsigned long	flags;
+/********************************************************/
 
-	got_act = 0;
-	iobase = ndev->base_addr;
-	spin_lock_irqsave(&idev->lock,flags);
-	do {
-		irintr = inb(iobase+VLSI_PIO_IRINTR);
-		rmb();
-		outb(irintr, iobase+VLSI_PIO_IRINTR); /* acknowledge asap */
-		wmb();
+static int vlsi_start_clock(struct pci_dev *pdev)
+{
+	u8	clkctl, lock;
+	int	i, count;
 
-		if (!(irintr&=IRINTR_INT_MASK))		/* not our INT - probably shared */
-			break;
+	if (clksrc < 2) { /* auto or PLL: try PLL */
+		clkctl = CLKCTL_PD_INV | CLKCTL_CLKSTP;
+		pci_write_config_byte(pdev, VLSI_PCI_CLKCTL, clkctl);
 
-//		vlsi_reg_debug(iobase,__FUNCTION__);
+		/* procedure to detect PLL lock synchronisation:
+		 * after 0.5 msec initial delay we expect to find 3 PLL lock
+		 * indications within 10 msec for successful PLL detection.
+		 */
+		udelay(500);
+		count = 0;
+		for (i = 500; i <= 10000; i += 50) { /* max 10 msec */
+			pci_read_config_byte(pdev, VLSI_PCI_CLKCTL, &lock);
+			if (lock&CLKCTL_LOCK) {
+				if (++count >= 3)
+					break;
+			}
+			udelay(50);
+		}
+		if (count < 3) {
+			if (clksrc == 1) { /* explicitly asked for PLL hence bail out */
+				printk(KERN_ERR "%s: no PLL or failed to lock!\n",
+					__FUNCTION__);
+				clkctl = CLKCTL_CLKSTP;
+				pci_write_config_byte(pdev, VLSI_PCI_CLKCTL, clkctl);
+				return -1;
+			}
+			else			/* was: clksrc=0(auto) */
+				clksrc = 3;	/* fallback to 40MHz XCLK (OB800) */
 
-		if (irintr&IRINTR_RPKTINT)
-			no_speed_check |= vlsi_rx_interrupt(ndev);
+			printk(KERN_INFO "%s: PLL not locked, fallback to clksrc=%d\n",
+				__FUNCTION__, clksrc);
+		}
+		else
+			clksrc = 1;	/* got successful PLL lock */
+	}
 
-		if (irintr&IRINTR_TPKTINT)
-			no_speed_check |= vlsi_tx_interrupt(ndev);
+	if (clksrc != 1) {
+		/* we get here if either no PLL detected in auto-mode or
+		   an external clock source was explicitly specified */
 
-#if 0	/* disable ACTIVITY handling for now */
+		clkctl = CLKCTL_EXTCLK | CLKCTL_CLKSTP;
+		if (clksrc == 3)
+			clkctl |= CLKCTL_XCKSEL;	
+		pci_write_config_byte(pdev, VLSI_PCI_CLKCTL, clkctl);
 
-		if (got_act  &&  irintr==IRINTR_ACTIVITY) /* nothing new */
-			break;
+		/* no way to test for working XCLK */
+	}
+	else
+		pci_read_config_byte(pdev, VLSI_PCI_CLKCTL, &clkctl);
 
-		if ((irintr&IRINTR_ACTIVITY) && !(irintr^IRINTR_ACTIVITY) ) {
-			no_speed_check |= vlsi_act_interrupt(ndev);
-			got_act = 1;
-		}
-#endif
-		if (irintr & ~(IRINTR_RPKTINT|IRINTR_TPKTINT|IRINTR_ACTIVITY))
-			printk(KERN_DEBUG "%s: IRINTR = %02x\n",
-				__FUNCTION__, (unsigned)irintr);
-			
-	} while (--boguscount > 0);
-	spin_unlock_irqrestore(&idev->lock,flags);
+	/* ok, now going to connect the chip with the clock source */
 
-	if (boguscount <= 0)
-		printk(KERN_ERR "%s: too much work in interrupt!\n", __FUNCTION__);
+	clkctl &= ~CLKCTL_CLKSTP;
+	pci_write_config_byte(pdev, VLSI_PCI_CLKCTL, clkctl);
 
-	else if (!no_speed_check) {
-		if (idev->new_baud)
-			vlsi_set_baud(ndev);
-	}
+	return 0;
 }
 
+static void vlsi_stop_clock(struct pci_dev *pdev)
+{
+	u8	clkctl;
 
-/**************************************************************/
+	/* disconnect chip from clock source */
+	pci_read_config_byte(pdev, VLSI_PCI_CLKCTL, &clkctl);
+	clkctl |= CLKCTL_CLKSTP;
+	pci_write_config_byte(pdev, VLSI_PCI_CLKCTL, clkctl);
 
+	/* disable all clock sources */
+	clkctl &= ~(CLKCTL_EXTCLK | CLKCTL_PD_INV);
+	pci_write_config_byte(pdev, VLSI_PCI_CLKCTL, clkctl);
+}
+
+/********************************************************/
 
 /* writing all-zero to the VLSI PCI IO register area seems to prevent
  * some occasional situations where the hardware fails (symptoms are 
@@ -811,283 +1377,150 @@ static inline void vlsi_clear_regs(unsig
 		outw(0, iobase + i);
 }
 
-
-static int vlsi_open(struct net_device *ndev)
+static int vlsi_init_chip(struct pci_dev *pdev)
 {
+	struct net_device *ndev = pci_get_drvdata(pdev);
 	vlsi_irda_dev_t *idev = ndev->priv;
-	struct pci_dev *pdev = idev->pdev;
-	int	err;
-	char	hwname[32];
-
-	if (pci_request_regions(pdev,drivername)) {
-		printk(KERN_ERR "%s: io resource busy\n", __FUNCTION__);
-		return -EAGAIN;
-	}
-
-	/* under some rare occasions the chip apparently comes up
-	 * with IRQ's pending. So we get interrupts invoked much too early
-	 * which will immediately kill us again :-(
-	 * so we better w/c pending IRQ and disable them all
-	 */
-
-	outb(IRINTR_INT_MASK, ndev->base_addr+VLSI_PIO_IRINTR);
+	unsigned	iobase;
+	u16 ptr;
 
-	if (request_irq(ndev->irq, vlsi_interrupt, SA_SHIRQ,
-			drivername, ndev)) {
-		printk(KERN_ERR "%s: couldn't get IRQ: %d\n",
-			__FUNCTION__, ndev->irq);
-		pci_release_regions(pdev);
-		return -EAGAIN;
-	}
-	printk(KERN_INFO "%s: got resources for %s - irq=%d / io=%04lx\n",
-		__FUNCTION__, ndev->name, ndev->irq, ndev->base_addr );
+	/* start the clock and clean the registers */
 
-	if (vlsi_set_clock(pdev)) {
+	if (vlsi_start_clock(pdev)) {
 		printk(KERN_ERR "%s: no valid clock source\n",
 			__FUNCTION__);
-		free_irq(ndev->irq,ndev);
-		pci_release_regions(pdev);
-		return -EIO;
-	}
-
-	vlsi_start_clock(pdev);
-
-	vlsi_clear_regs(ndev->base_addr);
-
-	err = vlsi_init_ring(idev);
-	if (err) {
-		vlsi_unset_clock(pdev);
-		free_irq(ndev->irq,ndev);
-		pci_release_regions(pdev);
-		return err;
+		pci_disable_device(pdev);
+		return -1;
 	}
-
-	vlsi_init_chip(ndev);
-
-	printk(KERN_INFO "%s: IrPHY setup: %d baud (%s), %s SIR-pulses\n",
-		__FUNCTION__, idev->baud, 
-		(idev->mode==IFF_SIR)?"SIR":((idev->mode==IFF_MIR)?"MIR":"FIR"),
-		(sirpulse)?"3/16 bittime":"short");
-
-	vlsi_arm_rx(&idev->rx_ring);
-
-	do_gettimeofday(&idev->last_rx);  /* first mtt may start from now on */
-
-	sprintf(hwname, "VLSI-FIR @ 0x%04x", (unsigned)ndev->base_addr);
-	idev->irlap = irlap_open(ndev,&idev->qos,hwname);
-
-	netif_start_queue(ndev);
-	outw(0, ndev->base_addr+VLSI_PIO_PROMPT);	/* kick hw state machine */
-
-	printk(KERN_INFO "%s: device %s operational using (%d,%d) tx,rx-ring\n",
-		__FUNCTION__, ndev->name, ringsize[0], ringsize[1]);
-
-	return 0;
-}
-
-
-static int vlsi_close(struct net_device *ndev)
-{
-	vlsi_irda_dev_t *idev = ndev->priv;
-	struct pci_dev *pdev = idev->pdev;
-	u8	cmd;
-	unsigned iobase;
-
-
 	iobase = ndev->base_addr;
-	netif_stop_queue(ndev);
+	vlsi_clear_regs(iobase);
 
-	if (idev->irlap)
-		irlap_close(idev->irlap);
-	idev->irlap = NULL;
-
-	outb(IRINTR_INT_MASK, iobase+VLSI_PIO_IRINTR);	/* w/c pending + disable further IRQ */
-	wmb();
-	outw(0, iobase+VLSI_PIO_IRENABLE);
-	outw(0, iobase+VLSI_PIO_IRCFG);			/* disable everything */
-	wmb();
-	outw(IRENABLE_IREN, iobase+VLSI_PIO_IRENABLE);
-	mb();						/* ... from now on */
+	outb(IRINTR_INT_MASK, iobase+VLSI_PIO_IRINTR); /* w/c pending IRQ, disable all INT */
 
-	outw(0, iobase+VLSI_PIO_IRENABLE);
-	wmb();
+	outw(0, iobase+VLSI_PIO_IRENABLE);	/* disable IrPHY-interface */
 
-	vlsi_clear_regs(ndev->base_addr);
+	/* disable everything, particularly IRCFG_MSTR - (also resetting the RING_PTR) */
 
-	vlsi_stop_clock(pdev);
+	outw(0, iobase+VLSI_PIO_IRCFG);
+	wmb();
 
-	vlsi_unset_clock(pdev);
+	outw(MAX_PACKET_LENGTH, iobase+VLSI_PIO_MAXPKT);  /* max possible value=0x0fff */
 
-	free_irq(ndev->irq,ndev);
+	outw(BUS_TO_RINGBASE(idev->busaddr), iobase+VLSI_PIO_RINGBASE);
 
-	vlsi_free_ringbuf(&idev->rx_ring);
-	vlsi_free_ringbuf(&idev->tx_ring);
+	outw(TX_RX_TO_RINGSIZE(idev->tx_ring->size, idev->rx_ring->size),
+		iobase+VLSI_PIO_RINGSIZE);	
 
-	if (idev->busaddr)
-		pci_free_consistent(idev->pdev,RING_AREA_SIZE,idev->virtaddr,idev->busaddr);
+	ptr = inw(iobase+VLSI_PIO_RINGPTR);
+	atomic_set(&idev->rx_ring->head, RINGPTR_GET_RX(ptr));
+	atomic_set(&idev->rx_ring->tail, RINGPTR_GET_RX(ptr));
+	atomic_set(&idev->tx_ring->head, RINGPTR_GET_TX(ptr));
+	atomic_set(&idev->tx_ring->tail, RINGPTR_GET_TX(ptr));
 
-	idev->virtaddr = NULL;
-	idev->busaddr = 0;
+	vlsi_set_baud_lock(ndev);	/* idev->new_baud used as provided by caller */
 
-	pci_read_config_byte(pdev, PCI_COMMAND, &cmd);
-	cmd &= ~PCI_COMMAND_MASTER;
-	pci_write_config_byte(pdev, PCI_COMMAND, cmd);
+	outb(IRINTR_INT_MASK, iobase+VLSI_PIO_IRINTR);	/* just in case - w/c pending IRQ's */
+	wmb();
 
-	pci_release_regions(pdev);
+	/* DO NOT BLINDLY ENABLE IRINTR_ACTEN!
+	 * basically every received pulse fires an ACTIVITY-INT
+	 * leading to >>1000 INT's per second instead of few 10
+	 */
 
-	printk(KERN_INFO "%s: device %s stopped\n", __FUNCTION__, ndev->name);
+	outb(IRINTR_RPKTEN|IRINTR_TPKTEN, iobase+VLSI_PIO_IRINTR);
 
 	return 0;
 }
 
-static struct net_device_stats * vlsi_get_stats(struct net_device *ndev)
-{
-	vlsi_irda_dev_t *idev = ndev->priv;
-
-	return &idev->stats;
-}
-
-static int vlsi_hard_start_xmit(struct sk_buff *skb, struct net_device *ndev)
+static int vlsi_start_hw(vlsi_irda_dev_t *idev)
 {
-	vlsi_irda_dev_t *idev = ndev->priv;
-	struct vlsi_ring	*r;
-	unsigned long flags;
-	unsigned iobase;
-	u8 status;
-	u16 config;
-	int mtt;
-	int len, speed;
-	struct timeval  now, ready;
-
+	struct pci_dev *pdev = idev->pdev;
+	struct net_device *ndev = pci_get_drvdata(pdev);
+	unsigned iobase = ndev->base_addr;
+	u8 byte;
 
-	status = 0;
+	/* we don't use the legacy UART, disable its address decoding */
 
-	speed = irda_get_next_speed(skb);
+	pci_read_config_byte(pdev, VLSI_PCI_IRMISC, &byte);
+	byte &= ~(IRMISC_UARTEN | IRMISC_UARTTST);
+	pci_write_config_byte(pdev, VLSI_PCI_IRMISC, byte);
 
-	if (speed != -1  &&  speed != idev->baud) {
-		idev->new_baud = speed;
-		if (!skb->len) {
-			dev_kfree_skb(skb);
-			vlsi_set_baud(ndev);
-			return 0;
-		}
-		status = TX_STAT_CLRENTX;  /* stop tx-ring after this frame */
-	}
+	/* enable PCI busmaster access to our 16MB page */
 
-	if (skb->len == 0) {
-		printk(KERN_ERR "%s: blocking 0-size packet???\n",
-			__FUNCTION__);
-		dev_kfree_skb(skb);
-		return 0;
-	}
+	pci_write_config_byte(pdev, VLSI_PCI_MSTRPAGE, MSTRPAGE_VALUE);
+	pci_set_master(pdev);
 
-	r = &idev->tx_ring;
+	vlsi_init_chip(pdev);
 
-	if (rd_is_active(r, r->head))
-		BUG();
+	vlsi_fill_rx(idev->rx_ring);
 
-	if (idev->mode == IFF_SIR) {
-		status |= TX_STAT_DISCRC;
-		len = async_wrap_skb(skb, r->buf[r->head].data, XFER_BUF_SIZE);
-	}
-	else {				/* hw deals with MIR/FIR mode */
-		len = skb->len;
-		memcpy(r->buf[r->head].data, skb->data, len);
-	}
+	do_gettimeofday(&idev->last_rx);	/* first mtt may start from now on */
 
-	rd_set_count(r, r->head, len);
-	rd_set_addr_status(r, r->head, virt_to_bus(r->buf[r->head].data), status);
+	outw(0, iobase+VLSI_PIO_PROMPT);	/* kick hw state machine */
 
-	/* new entry not yet activated! */
+	return 0;
+}
 
-#if 0
-	printk(KERN_DEBUG "%s: dump entry %d: %u %02x %08x\n",
-		__FUNCTION__, r->head,
-		idev->ring_hw[r->head].rd_count,
-		(unsigned)idev->ring_hw[r->head].rd_status,
-		idev->ring_hw[r->head].rd_addr & 0xffffffff);
-	vlsi_reg_debug(iobase,__FUNCTION__);
-#endif
+static int vlsi_stop_hw(vlsi_irda_dev_t *idev)
+{
+	struct pci_dev *pdev = idev->pdev;
+	struct net_device *ndev = pci_get_drvdata(pdev);
+	unsigned iobase = ndev->base_addr;
+	unsigned long flags;
 
+	spin_lock_irqsave(&idev->lock,flags);
+	outw(0, iobase+VLSI_PIO_IRENABLE);
+	outw(0, iobase+VLSI_PIO_IRCFG);			/* disable everything */
+	wmb();
 
-	/* let mtt delay pass before we need to acquire the spinlock! */
+	outb(IRINTR_INT_MASK, iobase+VLSI_PIO_IRINTR);	/* w/c pending + disable further IRQ */
+	mb();
+	spin_unlock_irqrestore(&idev->lock,flags);
 
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
-		}
-	}
+	vlsi_unarm_tx(idev);
+	vlsi_unarm_rx(idev);
 
-/*
- *	race window ahead, due to concurrent controller processing!
- *
- *	We need to disable IR output in order to switch to TX mode.
- *	Better not do this blindly anytime we want to transmit something
- *	because TX may already run. However the controller may stop TX
- *	at any time when fetching an inactive descriptor or one with
- *	CLR_ENTX set. So we switch on TX only, if TX was not running
- *	_after_ the new descriptor was activated on the ring. This ensures
- *	we will either find TX already stopped or we can be sure, there
- *	will be a TX-complete interrupt even if the chip stopped doing
- *	TX just after we found it still running. The ISR will then find
- *	the non-empty ring and restart TX processing. The enclosing
- *	spinlock is required to get serialization with the ISR right.
- */
+	vlsi_clear_regs(iobase);
+	vlsi_stop_clock(pdev);
 
+	pci_disable_device(pdev);
 
-	iobase = ndev->base_addr;
+	return 0;
+}
 
-	spin_lock_irqsave(&idev->lock,flags);
+/**************************************************************/
 
-	rd_activate(r, r->head);
-	ring_put(r);
+static struct net_device_stats * vlsi_get_stats(struct net_device *ndev)
+{
+	vlsi_irda_dev_t *idev = ndev->priv;
 
-	if (!(inw(iobase+VLSI_PIO_IRENABLE) & IRENABLE_ENTXST)) {
-	
-		outw(0, iobase+VLSI_PIO_IRENABLE);
+	return &idev->stats;
+}
 
-		config = inw(iobase+VLSI_PIO_IRCFG);
-		rmb();
-		outw(config | IRCFG_ENTX, iobase+VLSI_PIO_IRCFG);
-		wmb();
-		outw(IRENABLE_IREN, iobase+VLSI_PIO_IRENABLE);
-		mb();
-		outw(0, iobase+VLSI_PIO_PROMPT);
-		wmb();
-	}
+static void vlsi_tx_timeout(struct net_device *ndev)
+{
+	vlsi_irda_dev_t *idev = ndev->priv;
+
+
+	vlsi_reg_debug(ndev->base_addr, __FUNCTION__);
+	vlsi_ring_debug(idev->tx_ring);
 
-	if (r->head == r->tail) {
+	if (netif_running(ndev))
 		netif_stop_queue(ndev);
-		printk(KERN_DEBUG "%s: tx ring full - queue stopped: %d/%d\n",
-			__FUNCTION__, r->head, r->tail);
-#if 0
-		printk(KERN_INFO "%s: dump stalled entry %d: %u %02x %08x\n",
-			__FUNCTION__, r->tail,
-			r->hw[r->tail].rd_count,
-			(unsigned)r->hw[r->tail].rd_status,
-			r->hw[r->tail].rd_addr & 0xffffffff);
-#endif
-		vlsi_reg_debug(iobase,__FUNCTION__);
-	}
 
-	spin_unlock_irqrestore(&idev->lock, flags);
+	vlsi_stop_hw(idev);
 
-	dev_kfree_skb(skb);	
+	/* now simply restart the whole thing */
 
-	return 0;
-}
+	if (!idev->new_baud)
+		idev->new_baud = idev->baud;		/* keep current baudrate */
 
+	if (vlsi_start_hw(idev))
+		printk(KERN_CRIT "%s: failed to restart hw - %s(%s) unusable!\n",
+			__FUNCTION__, idev->pdev->name, ndev->name);
+	else
+		netif_start_queue(ndev);
+}
 
 static int vlsi_ioctl(struct net_device *ndev, struct ifreq *rq, int cmd)
 {
@@ -1097,14 +1530,20 @@ static int vlsi_ioctl(struct net_device 
 	u16 fifocnt;
 	int ret = 0;
 
-	spin_lock_irqsave(&idev->lock,flags);
 	switch (cmd) {
 		case SIOCSBANDWIDTH:
 			if (!capable(CAP_NET_ADMIN)) {
 				ret = -EPERM;
 				break;
 			}
+			spin_lock_irqsave(&idev->lock, flags);
 			idev->new_baud = irq->ifr_baudrate;
+			/* when called from userland there might be a minor race window here
+			 * if the stack tries to change speed concurrently - which would be
+			 * pretty strange anyway with the userland having full control...
+			 */
+			vlsi_set_baud_nolock(ndev);
+			spin_unlock_irqrestore(&idev->lock, flags);
 			break;
 		case SIOCSMEDIABUSY:
 			if (!capable(CAP_NET_ADMIN)) {
@@ -1116,7 +1555,7 @@ static int vlsi_ioctl(struct net_device 
 		case SIOCGRECEIVING:
 			/* the best we can do: check whether there are any bytes in rx fifo.
 			 * The trustable window (in case some data arrives just afterwards)
-			 * may be as short as 1usec or so at 4Mbps - no way for future-telling.
+			 * may be as short as 1usec or so at 4Mbps.
 			 */
 			fifocnt = inw(ndev->base_addr+VLSI_PIO_RCVBCNT) & RCVBCNT_MASK;
 			irq->ifr_receiving = (fifocnt!=0) ? 1 : 0;
@@ -1126,42 +1565,159 @@ static int vlsi_ioctl(struct net_device 
 				__FUNCTION__, cmd);
 			ret = -EOPNOTSUPP;
 	}	
-	spin_unlock_irqrestore(&idev->lock,flags);
 	
 	return ret;
 }
 
+/********************************************************/
+
+static void vlsi_interrupt(int irq, void *dev_instance, struct pt_regs *regs)
+{
+	struct net_device *ndev = dev_instance;
+	vlsi_irda_dev_t *idev = ndev->priv;
+	unsigned	iobase;
+	u8		irintr;
+	int 		boguscount = 32;
+	unsigned	got_act;
+	unsigned long	flags;
+
+	got_act = 0;
+	iobase = ndev->base_addr;
+	do {
+		spin_lock_irqsave(&idev->lock,flags);
+		irintr = inb(iobase+VLSI_PIO_IRINTR);
+		rmb();
+		outb(irintr, iobase+VLSI_PIO_IRINTR); /* acknowledge asap */
+		spin_unlock_irqrestore(&idev->lock,flags);
+
+		if (!(irintr&=IRINTR_INT_MASK))		/* not our INT - probably shared */
+			break;
+
+		if (irintr&IRINTR_RPKTINT)
+			vlsi_rx_interrupt(ndev);
+
+		if (irintr&IRINTR_TPKTINT)
+			vlsi_tx_interrupt(ndev);
+
+		if (!(irintr & ~IRINTR_ACTIVITY))
+			break;		/* done if only activity remaining */
+	
+		if (irintr & ~(IRINTR_RPKTINT|IRINTR_TPKTINT|IRINTR_ACTIVITY)) {
+			printk(KERN_DEBUG "%s: IRINTR = %02x\n",
+				__FUNCTION__, (unsigned)irintr);
+			vlsi_reg_debug(iobase,__FUNCTION__);
+		}			
+	} while (--boguscount > 0);
+
+	if (boguscount <= 0)
+		printk(KERN_WARNING "%s: too much work in interrupt!\n", __FUNCTION__);
 
+}
+
+/********************************************************/
 
-int vlsi_irda_init(struct net_device *ndev)
+static int vlsi_open(struct net_device *ndev)
+{
+	vlsi_irda_dev_t *idev = ndev->priv;
+	int	err = -EAGAIN;
+	char	hwname[32];
+
+	if (pci_request_regions(idev->pdev, drivername)) {
+		printk(KERN_ERR "%s: io resource busy\n", __FUNCTION__);
+		goto errout;
+	}
+	ndev->base_addr = pci_resource_start(idev->pdev,0);
+	ndev->irq = idev->pdev->irq;
+
+	/* under some rare occasions the chip apparently comes up with
+	 * IRQ's pending. We better w/c pending IRQ and disable them all
+	 */
+
+	outb(IRINTR_INT_MASK, ndev->base_addr+VLSI_PIO_IRINTR);
+
+	if (request_irq(ndev->irq, vlsi_interrupt, SA_SHIRQ,
+			drivername, ndev)) {
+		printk(KERN_ERR "%s: couldn't get IRQ: %d\n",
+			__FUNCTION__, ndev->irq);
+		goto errout_io;
+	}
+
+	if ((err = vlsi_create_hwif(idev)) != 0)
+		goto errout_irq;
+
+	sprintf(hwname, "VLSI-FIR @ 0x%04x", (unsigned)ndev->base_addr);
+	idev->irlap = irlap_open(ndev,&idev->qos,hwname);
+	if (!idev->irlap)
+		goto errout_free_ring;
+
+	do_gettimeofday(&idev->last_rx);  /* first mtt may start from now on */
+
+	idev->new_baud = 9600;		/* start with IrPHY using 9600(SIR) mode */
+
+	if ((err = vlsi_start_hw(idev)) != 0)
+		goto errout_close_irlap;
+
+	netif_start_queue(ndev);
+
+	printk(KERN_INFO "%s: device %s operational\n", __FUNCTION__, ndev->name);
+
+	return 0;
+
+errout_close_irlap:
+	irlap_close(idev->irlap);
+errout_free_ring:
+	vlsi_destroy_hwif(idev);
+errout_irq:
+	free_irq(ndev->irq,ndev);
+errout_io:
+	pci_release_regions(idev->pdev);
+errout:
+	return err;
+}
+
+static int vlsi_close(struct net_device *ndev)
 {
 	vlsi_irda_dev_t *idev = ndev->priv;
-	struct pci_dev *pdev = idev->pdev;
-	u8	byte;
 
+	netif_stop_queue(ndev);
+
+	if (idev->irlap)
+		irlap_close(idev->irlap);
+	idev->irlap = NULL;
+
+	vlsi_stop_hw(idev);
+
+	vlsi_destroy_hwif(idev);
+
+	free_irq(ndev->irq,ndev);
+
+	pci_release_regions(idev->pdev);
+
+	printk(KERN_INFO "%s: device %s stopped\n", __FUNCTION__, ndev->name);
+
+	return 0;
+}
+
+static int vlsi_irda_init(struct net_device *ndev)
+{
+	vlsi_irda_dev_t *idev = ndev->priv;
+	struct pci_dev *pdev = idev->pdev;
 
 	SET_MODULE_OWNER(ndev);
 
 	ndev->irq = pdev->irq;
 	ndev->base_addr = pci_resource_start(pdev,0);
 
-	/* PCI busmastering - see include file for details! */
+	/* PCI busmastering
+	 * see include file for details why we need these 2 masks, in this order!
+	 */
 
-	if (pci_set_dma_mask(pdev,DMA_MASK_USED_BY_HW)) {
+	if (pci_set_dma_mask(pdev,DMA_MASK_USED_BY_HW)
+	    || pci_set_dma_mask(pdev,DMA_MASK_MSTRPAGE)) {
 		printk(KERN_ERR "%s: aborting due to PCI BM-DMA address limitations\n",
 			__FUNCTION__);
 		return -1;
 	}
-	pci_set_master(pdev);
-	pdev->dma_mask = DMA_MASK_MSTRPAGE;
-	pci_write_config_byte(pdev, VLSI_PCI_MSTRPAGE, MSTRPAGE_VALUE);
-
-	/* we don't use the legacy UART, disable its address decoding */
-
-	pci_read_config_byte(pdev, VLSI_PCI_IRMISC, &byte);
-	byte &= ~(IRMISC_UARTEN | IRMISC_UARTTST);
-	pci_write_config_byte(pdev, VLSI_PCI_IRMISC, byte);
-
 
 	irda_init_max_qos_capabilies(&idev->qos);
 
@@ -1187,6 +1743,8 @@ int vlsi_irda_init(struct net_device *nd
 	ndev->get_stats	      = vlsi_get_stats;
 	ndev->hard_start_xmit = vlsi_hard_start_xmit;
 	ndev->do_ioctl	      = vlsi_ioctl;
+	ndev->tx_timeout      = vlsi_tx_timeout;
+	ndev->watchdog_timeo  = 500*HZ/1000;	/* max. allowed turn time for IrLAP */
 
 	return 0;
 }	
@@ -1203,6 +1761,8 @@ vlsi_irda_probe(struct pci_dev *pdev, co
 
 	if (pci_enable_device(pdev))
 		goto out;
+	else
+		pdev->current_state = 0; /* hw must be running now */
 
 	printk(KERN_INFO "%s: IrDA PCI controller %s detected\n",
 		drivername, pdev->name);
@@ -1228,6 +1788,8 @@ vlsi_irda_probe(struct pci_dev *pdev, co
 	ndev->priv = (void *) idev;
 
 	spin_lock_init(&idev->lock);
+	init_MUTEX(&idev->sem);
+	down(&idev->sem);
 	idev->pdev = pdev;
 	ndev->init = vlsi_irda_init;
 	strcpy(ndev->name,"irda%d");
@@ -1236,13 +1798,36 @@ vlsi_irda_probe(struct pci_dev *pdev, co
 			__FUNCTION__);
 		goto out_freedev;
 	}
+
+#ifdef CONFIG_PROC_FS
+	{
+		struct proc_dir_entry *ent;
+
+		ent = create_proc_entry(ndev->name, S_IFREG|S_IRUGO, vlsi_proc_root);
+		if (!ent) {
+			printk(KERN_ERR "%s: failed to create proc entry\n", __FUNCTION__);
+			goto out_unregister;
+		}
+		ent->data = ndev;
+		ent->proc_fops = &vlsi_proc_fops;
+		ent->size = 0;
+		idev->proc_entry = ent;
+	}
+#endif
+
 	printk(KERN_INFO "%s: registered device %s\n", drivername, ndev->name);
 
 	pci_set_drvdata(pdev, ndev);
+	up(&idev->sem);
 
 	return 0;
 
+out_unregister:
+	up(&idev->sem);
+	unregister_netdev(ndev);
+	goto out_disable;
 out_freedev:
+	up(&idev->sem);
 	kfree(ndev);
 out_disable:
 	pci_disable_device(pdev);
@@ -1254,37 +1839,145 @@ out:
 static void __devexit vlsi_irda_remove(struct pci_dev *pdev)
 {
 	struct net_device *ndev = pci_get_drvdata(pdev);
+	vlsi_irda_dev_t *idev;
 
-	if (ndev) {
-		printk(KERN_INFO "%s: unregister device %s\n",
-			drivername, ndev->name);
-
-		unregister_netdev(ndev);
-		/* do not free - async completed by unregister_netdev()
-		 * ndev->destructor called (if present) when going to free
-		 */
-
-	}
-	else
+	if (!ndev) {
 		printk(KERN_CRIT "%s: lost netdevice?\n", drivername);
-	pci_set_drvdata(pdev, NULL);
+		return;
+	}
 
+	idev = ndev->priv;
+	down(&idev->sem);
+	pci_set_drvdata(pdev, NULL);
 	pci_disable_device(pdev);
-	printk(KERN_INFO "%s: %s disabled\n", drivername, pdev->name);
+#ifdef CONFIG_PROC_FS
+	if (idev->proc_entry) {
+		remove_proc_entry(ndev->name, vlsi_proc_root);
+		idev->proc_entry = NULL;
+	}
+#endif
+	up(&idev->sem);
+
+	unregister_netdev(ndev);
+	/* do not free - async completed by unregister_netdev()
+	 * ndev->destructor called (if present) when going to free
+	 */
+
+	printk(KERN_INFO "%s: %s removed\n", drivername, pdev->name);
+}
+
+#ifdef CONFIG_PM
+
+/* The Controller doesn't provide PCI PM capabilities as defined by PCI specs.
+ * Some of the Linux PCI-PM code however depends on this, for example in
+ * pci_set_power_state(). So we have to take care to perform the required
+ * operations on our own (particularly reflecting the pdev->current_state)
+ * otherwise we might get cheated by pci-pm.
+ */
+
+static int vlsi_irda_save_state(struct pci_dev *pdev, u32 state)
+{
+	if (state < 1 || state > 3 ) {
+		printk( KERN_ERR "%s - %s: invalid pm state request: %u\n",
+			__FUNCTION__, pdev->name, state);
+		return -1;
+	}
+	return 0;
 }
 
 static int vlsi_irda_suspend(struct pci_dev *pdev, u32 state)
 {
-	printk(KERN_ERR "%s - %s\n", __FUNCTION__, pdev->name);
+	struct net_device *ndev = pci_get_drvdata(pdev);
+	vlsi_irda_dev_t *idev;
+
+	if (state < 1 || state > 3 ) {
+		printk( KERN_ERR "%s - %s: invalid pm state request: %u\n",
+			__FUNCTION__, pdev->name, state);
+		return 0;
+	}
+	if (!ndev) {
+		printk(KERN_ERR "%s - %s: no netdevice \n", __FUNCTION__, pdev->name);
+		return 0;
+	}
+	idev = ndev->priv;	
+	down(&idev->sem);
+	if (pdev->current_state != 0) {			/* already suspended */
+		if (state > pdev->current_state) {	/* simply go deeper */
+			pci_set_power_state(pdev,state);
+			pdev->current_state = state;
+		}
+		else
+			printk(KERN_ERR "%s - %s: invalid suspend request %u -> %u\n",
+				__FUNCTION__, pdev->name, pdev->current_state, state);
+		up(&idev->sem);
+		return 0;
+	}
+
+	if (netif_running(ndev)) {
+		netif_device_detach(ndev);
+		vlsi_stop_hw(idev);
+		pci_save_state(pdev, idev->cfg_space);
+		if (!idev->new_baud)
+			/* remember speed settings to restore on resume */
+			idev->new_baud = idev->baud;
+	}
+
+	pci_set_power_state(pdev,state);
+	pdev->current_state = state;
+	idev->resume_ok = 1;
+	up(&idev->sem);
 	return 0;
 }
 
 static int vlsi_irda_resume(struct pci_dev *pdev)
 {
-	printk(KERN_ERR "%s - %s\n", __FUNCTION__, pdev->name);
+	struct net_device *ndev = pci_get_drvdata(pdev);
+	vlsi_irda_dev_t	*idev;
+
+	if (!ndev) {
+		printk(KERN_ERR "%s - %s: no netdevice \n", __FUNCTION__, pdev->name);
+		return 0;
+	}
+	idev = ndev->priv;	
+	down(&idev->sem);
+	if (pdev->current_state == 0) {
+		up(&idev->sem);
+		printk(KERN_ERR "%s - %s: already resumed\n", __FUNCTION__, pdev->name);
+		return 0;
+	}
+	
+	pci_set_power_state(pdev, 0);
+	pdev->current_state = 0;
+
+	if (!idev->resume_ok) {
+		/* should be obsolete now - but used to happen due to:
+		 * - pci layer initially setting pdev->current_state = 4 (unknown)
+		 * - pci layer did not walk the save_state-tree (might be APM problem)
+		 *   so we could not refuse to suspend from undefined state
+		 * - vlsi_irda_suspend detected invalid state and refused to save
+		 *   configuration for resume - but was too late to stop suspending
+		 * - vlsi_irda_resume got screwed when trying to resume from garbage
+		 *
+		 * now we explicitly set pdev->current_state = 0 after enabling the
+		 * device and independently resume_ok should catch any garbage config.
+		 */
+		printk(KERN_ERR "%s - hm, nothing to resume?\n", __FUNCTION__);
+		up(&idev->sem);
+		return 0;
+	}
+
+	if (netif_running(ndev)) {
+		pci_restore_state(pdev, idev->cfg_space);
+		vlsi_start_hw(idev);
+		netif_device_attach(ndev);
+	}
+	idev->resume_ok = 0;
+	up(&idev->sem);
 	return 0;
 }
 
+#endif /* CONFIG_PM */
+
 /*********************************************************/
 
 static struct pci_driver vlsi_irda_driver = {
@@ -1292,13 +1985,20 @@ static struct pci_driver vlsi_irda_drive
 	.id_table	= vlsi_irda_table,
 	.probe		= vlsi_irda_probe,
 	.remove		= __devexit_p(vlsi_irda_remove),
+#ifdef CONFIG_PM
+	.save_state	= vlsi_irda_save_state,
 	.suspend	= vlsi_irda_suspend,
 	.resume		= vlsi_irda_resume,
+#endif
 };
 
+#ifdef CONFIG_PROC_FS
+#define PROC_DIR ("driver/" DRIVER_NAME)
+#endif
+
 static int __init vlsi_mod_init(void)
 {
-	int	i;
+	int	i, ret;
 
 	if (clksrc < 0  ||  clksrc > 3) {
 		printk(KERN_ERR "%s: invalid clksrc=%d\n", drivername, clksrc);
@@ -1324,14 +2024,27 @@ static int __init vlsi_mod_init(void)
 
 	sirpulse = !!sirpulse;
 
-	return pci_module_init(&vlsi_irda_driver);
+#ifdef CONFIG_PROC_FS
+	vlsi_proc_root = create_proc_entry(PROC_DIR, S_IFDIR, 0);
+	if (!vlsi_proc_root)
+		return -ENOMEM;
+#endif
+
+	ret = pci_module_init(&vlsi_irda_driver);
+
+#ifdef CONFIG_PROC_FS
+	if (ret)
+		remove_proc_entry(PROC_DIR, 0);
+#endif
+	return ret;
+
 }
 
 static void __exit vlsi_mod_exit(void)
 {
 	pci_unregister_driver(&vlsi_irda_driver);
+	remove_proc_entry(PROC_DIR, 0);
 }
 
 module_init(vlsi_mod_init);
 module_exit(vlsi_mod_exit);
-
