Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S277282AbRJEAJn>; Thu, 4 Oct 2001 20:09:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S277281AbRJEAJY>; Thu, 4 Oct 2001 20:09:24 -0400
Received: from deimos.hpl.hp.com ([192.6.19.190]:211 "EHLO deimos.hpl.hp.com")
	by vger.kernel.org with ESMTP id <S277280AbRJEAIi>;
	Thu, 4 Oct 2001 20:08:38 -0400
Date: Thu, 4 Oct 2001 17:09:02 -0700
To: Linus Torvalds <torvalds@transmeta.com>,
        Alan Cox <alan@lxorguk.ukuu.org.uk>,
        Linux kernel mailing list <linux-kernel@vger.kernel.org>,
        linux-irda@pasta.cs.uit.no
Subject: [PATCH] : ir240_vlsi_v0.3.diff
Message-ID: <20011004170902.B3290@bougret.hpl.hp.com>
Reply-To: jt@hpl.hp.com
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
Organisation: HP Labs Palo Alto
Address: HP Labs, 1U-17, 1501 Page Mill road, Palo Alto, CA 94304, USA.
E-mail: jt@hpl.hp.com
From: Jean Tourrilhes <jt@bougret.hpl.hp.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

ir240_vlsi_v0.3.diff :
--------------------
<From Martin Diehl, his changelog :>
v0.3:
        * improve chip initialization which was insufficient in some rare
          cases without cold reboot
        * resync with v2.4.10 (irlap-hwname e.g.)
        * add MODULE_LICENSE
        * drop MOD_{INC|DEC}_USE_COUNT in favour of SET_MODULE_OWNER
        * rename mtt_bits to qos_mtt_bits parameter like other irda
          drivers use
v0.2:
        * add Documentation/Configure.help entry
        * datasize=2048 issues fixed
        * major ring operation improvement and cleanup
        * improved mtt handling
        * few minor fixes
<Note : I think this patch also enable MIR/FIR operation, i.e. higher speeds>


diff -u -p linux/Documentation/Configure.d0b.help linux/Documentation/Configure.help
--- linux/Documentation/Configure.d0b.help	Thu Oct  4 16:26:43 2001
+++ linux/Documentation/Configure.help	Thu Oct  4 16:27:54 2001
@@ -18495,6 +18495,16 @@ CONFIG_SMC_IRCC_FIR
   here and read Documentation/modules.txt. The module will be called
   smc-ircc.o.
 
+VLSI 82C147 PCI-IrDA Controller Driver
+CONFIG_VLSI_FIR
+  Say Y here if you want to build support for the VLSI 82C147
+  PCI-IrDA Controller. This controller is used by the HP OmniBook 800
+  and 5500 notebooks. The driver provides support for SIR, MIR and
+  FIR (4Mbps) speeds.
+
+  If you want to compile it as a module, say M here and read
+  <file:Documentation/modules.txt>. The module will be called vlsi_ir.o.
+
 Serial dongle support
 CONFIG_DONGLE
   Say Y here if you have an infrared device that connects to your
diff -u -p linux/include/net/irda/vlsi_ir.d0b.h linux/include/net/irda/vlsi_ir.h
--- linux/include/net/irda/vlsi_ir.d0b.h	Thu Oct  4 16:27:23 2001
+++ linux/include/net/irda/vlsi_ir.h	Thu Oct  4 16:27:54 2001
@@ -3,7 +3,7 @@
  *
  *	vlsi_ir.h:	VLSI82C147 PCI IrDA controller driver for Linux
  *
- *	Version:	0.1, Aug 6, 2001
+ *	Version:	0.3, Sep 30, 2001
  *
  *	Copyright (c) 2001 Martin Diehl
  *
@@ -49,7 +49,7 @@ enum vlsi_pci_regs {
  *
  * On my HP OB-800 the BIOS sets external 40MHz clock as source
  * when IrDA enabled and I've never detected any PLL lock success.
- * Apparently the 14.31818MHz OSC input required for the PLL to work
+ * Apparently the 14.3...MHz OSC input required for the PLL to work
  * is not connected and the 40MHz EXTCLK is provided externally.
  * At least this is what makes the driver working for me.
  */
@@ -59,7 +59,7 @@ enum vlsi_pci_clkctl {
 	/* PLL control */
 
 	CLKCTL_NO_PD		= 0x04,		/* PD# (inverted power down) signal,
-						 * i.e. PLL is powered, if PD_INV is set */
+						 * i.e. PLL is powered, if NO_PD set */
 	CLKCTL_LOCK		= 0x40,		/* (ro) set, if PLL is locked */
 
 	/* clock source selection */
@@ -71,7 +71,7 @@ enum vlsi_pci_clkctl {
 
 	CLKCTL_CLKSTP		= 0x80,		/* set to disconnect from selected clock source */
 	CLKCTL_WAKE		= 0x08		/* set to enable wakeup feature: whenever IR activity
-						 * is detected, PD_INV gets set and CLKSTP cleared */
+						 * is detected, NO_PD gets set and CLKSTP cleared */
 };
 
 /* ------------------------------------------ */
@@ -105,8 +105,8 @@ enum vlsi_pci_clkctl {
 	 * restriction to the first 16MB of physical address range.
 	 * Hence the approach here is to enable PCI busmaster support using
 	 * the correct 32bit dma-mask used by the chip. Afterwards the device's
-	 * dma-mask gets restricted to 24bit, which must be honoured by all
-	 * allocations for memory areas to be exposed to the chip.
+	 * dma-mask gets restricted to 24bit, which must be honoured somehow by
+	 * all allocations for memory areas to be exposed to the chip ...
 	 *
 	 * Note:
 	 * Don't be surprised to get "Setting latency timer..." messages every
@@ -119,7 +119,7 @@ enum vlsi_pci_clkctl {
 
 /* VLSI_PCIIRMISC: IR Miscellaneous Register (u8, rw) */
 
-/* leagcy UART emulation - not used by this driver - would require:
+/* legacy UART emulation - not used by this driver - would require:
  * (see below for some register-value definitions)
  *
  *	- IRMISC_UARTEN must be set to enable UART address decoding
@@ -135,7 +135,7 @@ enum vlsi_pci_irmisc {
 
 	IRMISC_IRRAIL		= 0x40,		/* (ro?) IR rail power indication (and control?)
 						 * 0=3.3V / 1=5V. Probably set during power-on?
-						 * Not touched by driver */
+						 * unclear - not touched by driver */
 	IRMISC_IRPD		= 0x08,		/* transceiver power down, if set */
 
 	/* legacy UART control */
@@ -168,7 +168,7 @@ enum vlsi_pio_regs {
 	VLSI_PIO_RINGBASE	= 0x04,		/* [23:10] of ring address (u16, rw) */
 	VLSI_PIO_RINGSIZE	= 0x06,		/* rx/tx ring size (u16, rw) */
 	VLSI_PIO_PROMPT		= 0x08, 	/* triggers ring processing (u16, wo) */
-						/* 0x0a-0x0f: reserved, duplicated UART regs */
+	/* 0x0a-0x0f: reserved / duplicated UART regs */
 	VLSI_PIO_IRCFG		= 0x10,		/* configuration select (u16, rw) */
 	VLSI_PIO_SIRFLAG	= 0x12,		/* BOF/EOF for filtered SIR (u16, ro) */
 	VLSI_PIO_IRENABLE	= 0x14,		/* enable and status register (u16, rw/ro) */
@@ -176,7 +176,7 @@ enum vlsi_pio_regs {
 	VLSI_PIO_NPHYCTL	= 0x18,		/* next physical layer select (u16, rw) */
 	VLSI_PIO_MAXPKT		= 0x1a,		/* [11:0] max len for packet receive (u16, rw) */
 	VLSI_PIO_RCVBCNT	= 0x1c		/* current receive-FIFO byte count (u16, ro) */
-						/* 0x1e-0x1f: reserved, duplicated UART regs */
+	/* 0x1e-0x1f: reserved / duplicated UART regs */
 };
 
 /* ------------------------------------------ */
@@ -188,7 +188,7 @@ enum vlsi_pio_regs {
  * interrupt condition bits:
  * 		set according to corresponding interrupt source
  *		(regardless of the state of the enable bits)
- *		enable bit status indicated whether interrupt gets raised
+ *		enable bit status indicates whether interrupt gets raised
  *		write-to-clear
  * note: RPKTINT and TPKTINT behave different in legacy UART mode (which we don't use :-)
  */
@@ -212,16 +212,16 @@ enum vlsi_pio_irintr {
 
 /* VLSI_PIO_RINGPTR: Ring Pointer Read-Back Register (u16, ro) */
 
-#define MAX_RING_DESCR		64	/* tx, rx rings may contain up to 64 descr each */
-
 /* _both_ ring pointers are indices relative to the _entire_ rx,tx-ring!
  * i.e. the referenced descriptor is located
  * at RINGBASE + PTR * sizeof(descr) for rx and tx
- * therefore, the tx-pointer has offset by MAX_RING_DESCR
+ * therefore, the tx-pointer has offset MAX_RING_DESCR
  */
 
+#define MAX_RING_DESCR		64	/* tx, rx rings may contain up to 64 descr each */
+
 #define RINGPTR_RX_MASK		(MAX_RING_DESCR-1)
-#define RINGPTR_TX_MASK		((MAX_RING_DESCR|(MAX_RING_DESCR-1))<<8)
+#define RINGPTR_TX_MASK		((MAX_RING_DESCR-1)<<8)
 
 #define RINGPTR_GET_RX(p)	((p)&RINGPTR_RX_MASK)
 #define RINGPTR_GET_TX(p)	(((p)&RINGPTR_TX_MASK)>>8)
@@ -233,14 +233,14 @@ enum vlsi_pio_irintr {
 /* Contains [23:10] part of the ring base (bus-) address
  * which must be 1k-alinged. [31:24] is taken from
  * VLSI_PCI_MSTRPAGE above.
- * The controler initiates non-burst PCI BM cycles to
+ * The controller initiates non-burst PCI BM cycles to
  * fetch and update the descriptors in the ring.
  * Once fetched, the descriptor remains cached onchip
  * until it gets closed and updated due to the ring
  * processing state machine.
  * The entire ring area is split in rx and tx areas with each
  * area consisting of 64 descriptors of 8 bytes each.
- * The rx(tx) ring is located at ringbase+0 (ringbase+8*64).
+ * The rx(tx) ring is located at ringbase+0 (ringbase+64*8).
  */
 
 #define BUS_TO_RINGBASE(p)	(((p)>>10)&0x3fff)
@@ -273,9 +273,7 @@ enum vlsi_pio_irintr {
 /* VLSI_PIO_PROMPT: Ring Prompting Register (u16, write-to-start) */
 
 /* writing any value kicks the ring processing state machines
- * for both tx, rx rings.
- * currently enabled rings (according to IRENABLE_ENTXST, IRENABLE_ENRXST
- * status reporting - see below) are considered as follows:
+ * for both tx, rx rings as follows:
  * 	- active rings (currently owning an active descriptor)
  *	  ignore the prompt and continue
  *	- idle rings fetch the next descr from the ring and start
@@ -289,7 +287,7 @@ enum vlsi_pio_irintr {
 /* notes:
  *	- not more than one SIR/MIR/FIR bit must be set at any time
  *	- SIR, MIR, FIR and CRC16 select the configuration which will
- *	  be applied now/next time if/when IRENABLE_IREN is _cleared_ (see below)
+ *	  be applied on next 0->1 transition of IRENABLE_IREN (see below).
  *	- besides allowing the PCI interface to execute busmaster cycles
  *	  and therefore the ring SM to operate, the MSTR bit has side-effects:
  *	  when MSTR is cleared, the RINGPTR's get reset and the legacy UART mode
@@ -340,7 +338,7 @@ enum vlsi_pio_ircfg {
  */
 
 enum vlsi_pio_irenable {
-	IRENABLE_IREN		= 0x8000,  /* enable IR phy and gate mode config (rw) */
+	IRENABLE_IREN		= 0x8000,  /* enable IR phy and gate the mode config (rw) */
 	IRENABLE_CFGER		= 0x4000,  /* mode configuration error (ro) */
 	IRENABLE_FIR_ON		= 0x2000,  /* FIR on status (ro) */
 	IRENABLE_MIR_ON		= 0x1000,  /* MIR on status (ro) */
@@ -389,7 +387,7 @@ enum vlsi_pio_irenable {
  *		specification, which provides 1.5 usec pulse width for all speeds (except
  *		for 2.4kbaud getting 6usec). This is well inside IrPHY v1.3 specs and
  *		reduces the transceiver power which drains the battery. At 9.6kbaud for
- *		example this makes more than 90% battery power saving!
+ *		example this amounts to more than 90% battery power saving!
  *
  * MIR-mode:	BAUD = 0
  *		PLSWID = 9(10) for 40(48) MHz input clock
@@ -402,7 +400,7 @@ enum vlsi_pio_irenable {
  */
 
 #define BWP_TO_PHYCTL(B,W,P)	((((B)&0x3f)<<10) | (((W)&0x1f)<<5) | (((P)&0x1f)<<0))
-#define BAUD_BITS(br)		((115200/br)-1)
+#define BAUD_BITS(br)		((115200/(br))-1)
 
 static inline unsigned
 calc_width_bits(unsigned baudrate, unsigned widthselect, unsigned clockselect)
@@ -447,15 +445,25 @@ calc_width_bits(unsigned baudrate, unsig
 
 /* VLSI_PIO_MAXPKT: Maximum Packet Length register (u16, rw) */
 
-/* specifies the maximum legth (up to 4096 bytes), which a
+/* specifies the maximum legth (up to 4k - or (4k-1)? - bytes), which a
  * received frame may have - i.e. the size of the corresponding
  * receive buffers. For simplicity we use the same length for
- * receive and submit buffers. Therefore we use 3k to have
- * enough space for a lot of XBOF's and escapes we may need at
- * some point when wrapping MTU=2048 sized packets for transmission.
- */
+ * receive and submit buffers and increase transfer buffer size
+ * byond IrDA-MTU = 2048 so we have sufficient space left when
+ * packet size increases during wrapping due to XBOFs and CE's.
+ * Even for receiving unwrapped frames we need >MAX_PACKET_LEN
+ * space since the controller appends FCS/CRC (2 or 4 bytes)
+ * so we use 2*IrDA-MTU for both directions and cover even the
+ * worst case, where all data bytes have to be escaped when wrapping.
+ * well, this wastes some memory - anyway, later we will
+ * either map skb's directly or use pci_pool allocator...
+ */
+ 
+#define IRDA_MTU	2048		/* seems to be undefined elsewhere */
+ 
+#define XFER_BUF_SIZE		(2*IRDA_MTU)
 
-#define MAX_PACKET_LENGTH	3172
+#define MAX_PACKET_LENGTH	(XFER_BUF_SIZE-1) /* register uses only [11:0] */
 
 
 /* ------------------------------------------ */
@@ -466,7 +474,7 @@ calc_width_bits(unsigned baudrate, unsig
 /* recive packet counter gets incremented on every non-filtered
  * byte which was put in the receive fifo and reset for each
  * new packet. Used to decide whether we are just in the middle
- * of receiving receiving
+ * of receiving
  */
 
 #define RCVBCNT_MASK	0x0fff
@@ -538,12 +546,21 @@ struct ring_descr {
 
 struct ring_entry {
 	struct sk_buff	*skb;
-	void		*head;
+	void		*data;
+};
+
+
+struct vlsi_ring {
+	unsigned		size;
+	unsigned		mask;
+	unsigned		head, tail;
+	struct ring_descr	*hw;
+	struct ring_entry	buf[MAX_RING_DESCR];
 };
 
 /* ------------------------------------------ */
 
-/* our compound VLSI-PCI-IRDA device information */
+/* our private compound VLSI-PCI-IRDA device information */
 
 typedef struct vlsi_irda_dev {
 	struct pci_dev		*pdev;
@@ -557,14 +574,10 @@ typedef struct vlsi_irda_dev {
 	int			baud, new_baud;
 
 	dma_addr_t		busaddr;
+	void			*virtaddr;
+	struct vlsi_ring	tx_ring, rx_ring;
 
-	struct ring_descr	*ring_hw;
-
-	struct ring_entry	*ring_buf;
-
-	unsigned		tx_mask, rx_mask;
-
-	unsigned		tx_put, tx_get, rx_put, rx_get;
+	struct timeval		last_rx;
 
 	spinlock_t		lock;
 	
diff -u -p linux/drivers/net/irda/vlsi_ir.d0b.c linux/drivers/net/irda/vlsi_ir.c
--- linux/drivers/net/irda/vlsi_ir.d0b.c	Thu Oct  4 16:25:23 2001
+++ linux/drivers/net/irda/vlsi_ir.c	Thu Oct  4 16:27:54 2001
@@ -2,7 +2,7 @@
  *
  *	vlsi_ir.c:	VLSI82C147 PCI IrDA controller driver for Linux
  *
- *	Version:	0.1, Aug 6, 2001
+ *	Version:	0.3, Sep 30, 2001
  *
  *	Copyright (c) 2001 Martin Diehl
  *
@@ -32,6 +32,7 @@
 #include <linux/netdevice.h>
 #include <linux/skbuff.h>
 #include <linux/delay.h>
+#include <linux/time.h>
 
 #include <net/irda/irda.h>
 #include <net/irda/irda_device.h>
@@ -49,15 +50,14 @@ MODULE_AUTHOR("Martin Diehl <info@mdiehl
 MODULE_LICENSE("GPL");
 
 
-
 static /* const */ char drivername[] = "vlsi_ir";
 
 
-#define PCI_CLASS_IRDA_GENERIC 0x0d00
+#define PCI_CLASS_WIRELESS_IRDA 0x0d00
 
 static struct pci_device_id vlsi_irda_table [] __devinitdata = { {
 
-	class:          PCI_CLASS_IRDA_GENERIC << 8,
+	class:          PCI_CLASS_WIRELESS_IRDA << 8,
 	vendor:         PCI_VENDOR_ID_VLSI,
 	device:         PCI_DEVICE_ID_VLSI_82C147,
 	}, { /* all zeroes */ }
@@ -83,37 +83,45 @@ static int clksrc = 0;			/* default is 0
 
 
 MODULE_PARM(ringsize, "1-2i");
-MODULE_PARM_DESC(ringsize, "tx, rx ring descriptor size");
+MODULE_PARM_DESC(ringsize, "TX, RX ring descriptor size");
 
 /*	ringsize: size of the tx and rx descriptor rings
  *		independent for tx and rx
  *		specify as ringsize=tx[,rx]
  *		allowed values: 4, 8, 16, 32, 64
+ *		Due to the IrDA 1.x max. allowed window size=7,
+ *		there should be no gain when using rings larger than 8
  */
 
-static int ringsize[] = {16,16};	/* default is tx=rx=16 */
+static int ringsize[] = {8,8};		/* default is tx=rx=8 */
 
 
 MODULE_PARM(sirpulse, "i");
-MODULE_PARM_DESC(sirpulse, "sir pulse width tuning");
+MODULE_PARM_DESC(sirpulse, "SIR pulse width tuning");
 
-/*	sirpulse: tuning of the sir pulse width within IrPHY 1.3 limits
- *		0: real short, 1.5us (exception 6us at 2.4kb/s)
+/*	sirpulse: tuning of the SIR pulse width within IrPHY 1.3 limits
+ *		0: very short, 1.5us (exception: 6us at 2.4 kbaud)
  *		1: nominal 3/16 bittime width
+ *	note: IrDA compliant peer devices should be happy regardless
+ *		which one is used. Primary goal is to save some power
+ *		on the sender's side - at 9.6kbaud for example the short
+ *		pulse width saves more than 90% of the transmitted IR power.
  */
 
 static int sirpulse = 1;		/* default is 3/16 bittime */
 
 
-MODULE_PARM(mtt_bits, "i");
-MODULE_PARM_DESC(mtt_bits, "IrLAP bitfield representing min-turn-time");
+MODULE_PARM(qos_mtt_bits, "i");
+MODULE_PARM_DESC(qos_mtt_bits, "IrLAP bitfield representing min-turn-time");
 
-/*	mtt_bit: encoded min-turn-time values we accept for connections
- *		 according to IrLAP definition (section 6.6.8)
- *		 the widespreadly used HP HDLS-1100 requires 1 msec
+/*	qos_mtt_bits: encoded min-turn-time value we require the peer device
+ *		 to use before transmitting to us. "Type 1" (per-station)
+ *		 bitfield according to IrLAP definition (section 6.6.8)
+ *		 The HP HDLS-1100 requires 1 msec - don't even know
+ *		 if this is the one which is used by my OB800
  */
 
-static int mtt_bits = 0x07;		/* default is 1 ms or more */
+static int qos_mtt_bits = 0x04;		/* default is 1 ms */
 
 
 /********************************************************/
@@ -122,68 +130,81 @@ static int mtt_bits = 0x07;		/* default 
 /* some helpers for operations on ring descriptors */
 
 
-static inline int rd_is_active(struct ring_descr *rd)
+static inline int rd_is_active(struct vlsi_ring *r, unsigned i)
+{
+	return ((r->hw[i].rd_status & RD_STAT_ACTIVE) != 0);
+}
+
+static inline void rd_activate(struct vlsi_ring *r, unsigned i)
 {
-	return ((rd->rd_status & RD_STAT_ACTIVE) != 0);
+	r->hw[i].rd_status |= RD_STAT_ACTIVE;
 }
 
-static inline void rd_set_addr_status(struct ring_descr *rd, dma_addr_t a, u8 s)
+static inline void rd_set_addr_status(struct vlsi_ring *r, unsigned i, dma_addr_t a, u8 s)
 {
-	/* overlayed - order is important! */
+	struct ring_descr *rd = r->hw +i;
+
+	/* ordering is important for two reasons:
+	 *  - overlayed: writing addr overwrites status
+	 *  - we want to write status last so we have valid address in
+	 *    case status has RD_STAT_ACTIVE set
+	 */
 
+	if ((a & ~DMA_MASK_MSTRPAGE) != MSTRPAGE_VALUE)
+		BUG();
+
+	a &= DMA_MASK_MSTRPAGE;  /* clear highbyte to make sure we won't write
+				  * to status - just in case MSTRPAGE_VALUE!=0
+				  */
 	rd->rd_addr = a;
-	rd->rd_status = s;
+	wmb();
+	rd->rd_status = s;	 /* potentially passes ownership to the hardware */
 }
 
-static inline void rd_set_status(struct ring_descr *rd, u8 s)
+static inline void rd_set_status(struct vlsi_ring *r, unsigned i, u8 s)
 {
-	rd->rd_status = s;
+	r->hw[i].rd_status = s;
 }
 
-static inline void rd_set_count(struct ring_descr *rd, u16 c)
+static inline void rd_set_count(struct vlsi_ring *r, unsigned i, u16 c)
 {
-	rd->rd_count = c;
+	r->hw[i].rd_count = c;
 }
 
-static inline u8 rd_get_status(struct ring_descr *rd)
+static inline u8 rd_get_status(struct vlsi_ring *r, unsigned i)
 {
-	return rd->rd_status;
+	return r->hw[i].rd_status;
 }
 
-static inline dma_addr_t rd_get_addr(struct ring_descr *rd)
+static inline dma_addr_t rd_get_addr(struct vlsi_ring *r, unsigned i)
 {
 	dma_addr_t	a;
 
-	a = (rd->rd_addr & DMA_MASK_MSTRPAGE) | (MSTRPAGE_VALUE << 24);
+	a = (r->hw[i].rd_addr & DMA_MASK_MSTRPAGE) | (MSTRPAGE_VALUE << 24);
 	return a;
 }
 
-static inline u16 rd_get_count(struct ring_descr *rd)
+static inline u16 rd_get_count(struct vlsi_ring *r, unsigned i)
 {
-	return rd->rd_count;
+	return r->hw[i].rd_count;
 }
 
+/* producer advances r->head when descriptor was added for processing by hw */
 
-/* advancing indices pointing into descriptor rings */
-
-static inline void ring_ptr_inc(unsigned *ptr, unsigned mask)
+static inline void ring_put(struct vlsi_ring *r)
 {
-	*ptr = (*ptr + 1) & mask;
+	r->head = (r->head + 1) & r->mask;
 }
 
+/* consumer advances r->tail when descriptor was removed after getting processed by hw */
 
-/********************************************************/
-
-
-#define MAX_PACKET_LEN		2048	/* IrDA MTU */
+static inline void ring_get(struct vlsi_ring *r)
+{
+	r->tail = (r->tail + 1) & r->mask;
+}
 
-/* increase transfer buffer size somewhat so we have enough space left
- * when packet size increases during wrapping due to XBOFs and escapes.
- * well, this wastes some memory - anyway, later we will
- * either map skb's directly or use pci_pool allocator...
- */
 
-#define XFER_BUF_SIZE		(MAX_PACKET_LEN+512)
+/********************************************************/
 
 /* the memory required to hold the 2 descriptor rings */
 
@@ -193,12 +214,11 @@ static inline void ring_ptr_inc(unsigned
 
 #define RING_ENTRY_SIZE		(2 * MAX_RING_DESCR * sizeof(struct ring_entry))
 
-
 /********************************************************/
 
 /* just dump all registers */
 
-static void vlsi_reg_debug(int iobase, const char *s)
+static void vlsi_reg_debug(unsigned iobase, const char *s)
 {
 	int	i;
 
@@ -217,15 +237,14 @@ static int vlsi_set_clock(struct pci_dev
 	u8	clkctl, lock;
 	int	i, count;
 
-	if (clksrc < 0  ||  clksrc > 3) {
-		printk(KERN_ERR "%s: invalid clksrc=%d\n", __FUNCTION__, clksrc);
-		return -1;
-	}
 	if (clksrc < 2) { /* auto or PLL: try PLL */
 		clkctl = CLKCTL_NO_PD | CLKCTL_CLKSTP;
 		pci_write_config_byte(pdev, VLSI_PCI_CLKCTL, clkctl);
 
-		/* protocol to detect PLL lock synchronisation */
+		/* procedure to detect PLL lock synchronisation:
+		 * after 0.5 msec initial delay we expect to find 3 PLL lock
+		 * indications within 10 msec for successful PLL detection.
+		 */
 		udelay(500);
 		count = 0;
 		for (i = 500; i <= 10000; i += 50) { /* max 10 msec */
@@ -244,20 +263,20 @@ static int vlsi_set_clock(struct pci_dev
 				pci_write_config_byte(pdev, VLSI_PCI_CLKCTL, clkctl);
 				return -1;
 			}
-			else /* was: clksrc=0(auto) */
-				clksrc = 3; /* fallback to 40MHz XCLK (OB800) */
+			else			/* was: clksrc=0(auto) */
+				clksrc = 3;	/* fallback to 40MHz XCLK (OB800) */
 
 			printk(KERN_INFO "%s: PLL not locked, fallback to clksrc=%d\n",
 				__FUNCTION__, clksrc);
 		}
-		else { /* got succesful PLL lock */
+		else { /* got successful PLL lock */
 			clksrc = 1;
 			return 0;
 		}
 	}
 
 	/* we get here if either no PLL detected in auto-mode or
-	   the external clock source explicitly specified */
+	   the external clock source was explicitly specified */
 
 	clkctl = CLKCTL_EXTCLK | CLKCTL_CLKSTP;
 	if (clksrc == 3)
@@ -310,80 +329,93 @@ static void vlsi_unset_clock(struct pci_
 
 /* ### FIXME: don't use old virt_to_bus() anymore! */
 
-static int vlsi_alloc_buffers_init(vlsi_irda_dev_t *idev)
+
+static void vlsi_arm_rx(struct vlsi_ring *r)
 {
-	void *buf;
-	int i, j;
+	unsigned	i;
+	dma_addr_t	ba;
 
-	idev->ring_buf = kmalloc(RING_ENTRY_SIZE,GFP_KERNEL);
-	if (!idev->ring_buf)
-		return -ENOMEM;
-	memset(idev->ring_buf, 0, RING_ENTRY_SIZE);
+	for (i = 0; i < r->size; i++) {
+		if (r->buf[i].data == NULL)
+			BUG();
+		ba = virt_to_bus(r->buf[i].data);
+		rd_set_addr_status(r, i, ba, RD_STAT_ACTIVE);
+	}
+}
+
+static int vlsi_alloc_ringbuf(struct vlsi_ring *r)
+{
+	unsigned	i, j;
 
-	for (i = MAX_RING_DESCR; i < MAX_RING_DESCR+ringsize[0]; i++) {
-		buf = kmalloc(XFER_BUF_SIZE, GFP_KERNEL|GFP_DMA);
-		if (!buf) {
-			for (j = MAX_RING_DESCR; j < i; j++)
-				kfree(idev->ring_buf[j].head);
-			kfree(idev->ring_buf);
-			idev->ring_buf = NULL;
+	r->head = r->tail = 0;
+	r->mask = r->size - 1;
+	for (i = 0; i < r->size; i++) {
+		r->buf[i].skb = NULL;
+		r->buf[i].data = kmalloc(XFER_BUF_SIZE, GFP_KERNEL|GFP_DMA);
+		if (r->buf[i].data == NULL) {
+			for (j = 0; j < i; j++) {
+				kfree(r->buf[j].data);
+				r->buf[j].data = NULL;
+			}
 			return -ENOMEM;
 		}
-		idev->ring_buf[i].head = buf;
-		idev->ring_buf[i].skb = NULL;
-		rd_set_addr_status(idev->ring_hw+i,virt_to_bus(buf), 0);
 	}
+	return 0;
+}
 
-	for (i = 0; i < ringsize[1]; i++) {
-		buf = kmalloc(XFER_BUF_SIZE, GFP_KERNEL|GFP_DMA);
-		if (!buf) {
-			for (j = 0; j < i; j++)
-				kfree(idev->ring_buf[j].head);
-			for (j = MAX_RING_DESCR; j < MAX_RING_DESCR+ringsize[0]; j++)
-				kfree(idev->ring_buf[j].head);
-			kfree(idev->ring_buf);
-			idev->ring_buf = NULL;
-			return -ENOMEM;
+static void vlsi_free_ringbuf(struct vlsi_ring *r)
+{
+	unsigned	i;
+
+	for (i = 0; i < r->size; i++) {
+		if (r->buf[i].data == NULL)
+			continue;
+		if (r->buf[i].skb) {
+			dev_kfree_skb(r->buf[i].skb);
+			r->buf[i].skb = NULL;
 		}
-		idev->ring_buf[i].head = buf;
-		idev->ring_buf[i].skb = NULL;
-		rd_set_addr_status(idev->ring_hw+i,virt_to_bus(buf), RD_STAT_ACTIVE);
+		else
+			kfree(r->buf[i].data);
+		r->buf[i].data = NULL;
 	}
-
-	return 0;
 }
 
 
 static int vlsi_init_ring(vlsi_irda_dev_t *idev)
 {
+	char 		 *ringarea;
 
-	idev->tx_mask = MAX_RING_DESCR | (ringsize[0] - 1);
-	idev->rx_mask = ringsize[1] - 1;
-
-	idev->ring_hw = pci_alloc_consistent(idev->pdev,
-		RING_AREA_SIZE, &idev->busaddr);
-	if (!idev->ring_hw) {
+	ringarea = pci_alloc_consistent(idev->pdev, RING_AREA_SIZE, &idev->busaddr);
+	if (!ringarea) {
 		printk(KERN_ERR "%s: insufficient memory for descriptor rings\n",
 			__FUNCTION__);
 		return -ENOMEM;
 	}
+	memset(ringarea, 0, RING_AREA_SIZE);
+
 #if 0
 	printk(KERN_DEBUG "%s: (%d,%d)-ring %p / %p\n", __FUNCTION__,
-		ringsize[0], ringsize[1], idev->ring_hw, 
+		ringsize[0], ringsize[1], ringarea, 
 		(void *)(unsigned)idev->busaddr);
 #endif
-	memset(idev->ring_hw, 0, RING_AREA_SIZE);
 
-	if (vlsi_alloc_buffers_init(idev)) {
-		
-		pci_free_consistent(idev->pdev, RING_AREA_SIZE,
-			idev->ring_hw, idev->busaddr);
-		printk(KERN_ERR "%s: insufficient memory for ring buffers\n",
-			__FUNCTION__);
-		return -1;
+	idev->rx_ring.size = ringsize[1];
+	idev->rx_ring.hw = (struct ring_descr *)ringarea;
+	if (!vlsi_alloc_ringbuf(&idev->rx_ring)) {
+		idev->tx_ring.size = ringsize[0];
+		idev->tx_ring.hw = idev->rx_ring.hw + MAX_RING_DESCR;
+		if (!vlsi_alloc_ringbuf(&idev->tx_ring)) {
+			idev->virtaddr = ringarea;
+			return 0;
+		}
+		vlsi_free_ringbuf(&idev->rx_ring);
 	}
 
-	return 0;
+	pci_free_consistent(idev->pdev, RING_AREA_SIZE,
+		ringarea, idev->busaddr);
+	printk(KERN_ERR "%s: insufficient memory for ring buffers\n",
+		__FUNCTION__);
+	return -1;
 }
 
 
@@ -397,7 +429,7 @@ static int vlsi_set_baud(struct net_devi
 	vlsi_irda_dev_t *idev = ndev->priv;
 	unsigned long flags;
 	u16 nphyctl;
-	int iobase; 
+	unsigned iobase; 
 	u16 config;
 	unsigned mode;
 	int	ret;
@@ -420,7 +452,7 @@ static int vlsi_set_baud(struct net_devi
 	else if (baudrate == 1152000) {
 		mode = IFF_MIR;
 		config = IRCFG_MIR | IRCFG_CRC16;
-		nphyctl = PHYCTL_MIR(baudrate);
+		nphyctl = PHYCTL_MIR(clksrc==3);
 	}
 	else {
 		mode = IFF_SIR;
@@ -449,7 +481,8 @@ static int vlsi_set_baud(struct net_devi
 	outw(nphyctl, iobase+VLSI_PIO_NPHYCTL);
 	wmb();
 	outw(IRENABLE_IREN, iobase+VLSI_PIO_IRENABLE);
-		/* chip fetches IRCFG on next rising edge of its 8MHz clock */
+
+	/* chip fetches IRCFG on next rising edge of its 8MHz clock */
 
 	mb();
 	config = inw(iobase+VLSI_PIO_IRENABLE) & IRENABLE_MASK;
@@ -493,16 +526,15 @@ static int vlsi_set_baud(struct net_devi
 static int vlsi_init_chip(struct net_device *ndev)
 {
 	vlsi_irda_dev_t *idev = ndev->priv;
+	unsigned	iobase;
 	u16 ptr;
-	unsigned  iobase;
-
 
 	iobase = ndev->base_addr;
 
-	outw(0, iobase+VLSI_PIO_IRENABLE);
-
 	outb(IRINTR_INT_MASK, iobase+VLSI_PIO_IRINTR); /* w/c pending IRQ, disable all INT */
 
+	outw(0, iobase+VLSI_PIO_IRENABLE);	/* disable IrPHY-interface */
+
 	/* disable everything, particularly IRCFG_MSTR - which resets the RING_PTR */
 
 	outw(0, iobase+VLSI_PIO_IRCFG);
@@ -513,16 +545,16 @@ static int vlsi_init_chip(struct net_dev
 
 	outw(0, iobase+VLSI_PIO_IRENABLE);
 
-	outw(MAX_PACKET_LEN, iobase+VLSI_PIO_MAXPKT);
+	outw(MAX_PACKET_LENGTH, iobase+VLSI_PIO_MAXPKT);  /* max possible value=0x0fff */
 
 	outw(BUS_TO_RINGBASE(idev->busaddr), iobase+VLSI_PIO_RINGBASE);
 
-	outw(TX_RX_TO_RINGSIZE(ringsize[0], ringsize[1]), iobase+VLSI_PIO_RINGSIZE);	
-
+	outw(TX_RX_TO_RINGSIZE(idev->tx_ring.size, idev->rx_ring.size),
+		iobase+VLSI_PIO_RINGSIZE);	
 
 	ptr = inw(iobase+VLSI_PIO_RINGPTR);
-	idev->rx_put = idev->rx_get = RINGPTR_GET_RX(ptr);
-	idev->tx_put = idev->tx_get = RINGPTR_GET_TX(ptr);
+	idev->rx_ring.head = idev->rx_ring.tail = RINGPTR_GET_RX(ptr);
+	idev->tx_ring.head = idev->tx_ring.tail = RINGPTR_GET_TX(ptr);
 
 	outw(IRCFG_MSTR, iobase+VLSI_PIO_IRCFG);		/* ready for memory access */
 	wmb();
@@ -533,12 +565,12 @@ static int vlsi_init_chip(struct net_dev
 	idev->new_baud = 9600;		/* start with IrPHY using 9600(SIR) mode */
 	vlsi_set_baud(ndev);
 
-	outb(IRINTR_INT_MASK, iobase+VLSI_PIO_IRINTR);
+	outb(IRINTR_INT_MASK, iobase+VLSI_PIO_IRINTR);	/* just in case - w/c pending IRQ's */
 	wmb();
 
 	/* DO NOT BLINDLY ENABLE IRINTR_ACTEN!
 	 * basically every received pulse fires an ACTIVITY-INT
-	 * leading to >1000 INT's per second instead of few 10
+	 * leading to >>1000 INT's per second instead of few 10
 	 */
 
 	outb(IRINTR_RPKTEN|IRINTR_TPKTEN, iobase+VLSI_PIO_IRINTR);
@@ -551,97 +583,82 @@ static int vlsi_init_chip(struct net_dev
 /**************************************************************/
 
 
+static void vlsi_refill_rx(struct vlsi_ring *r)
+{
+	do {
+		if (rd_is_active(r, r->head))
+			BUG();
+		rd_activate(r, r->head);
+		ring_put(r);
+	} while (r->head != r->tail);
+}
+
+
 static int vlsi_rx_interrupt(struct net_device *ndev)
 {
 	vlsi_irda_dev_t *idev = ndev->priv;
-	int	iobase;
-	int	entry;
+	struct vlsi_ring *r;
 	int	len;
 	u8	status;
-	u16	word;
 	struct sk_buff	*skb;
 	int	crclen;
 
-	iobase = ndev->base_addr;
-
-	entry = idev->rx_get;
-
-	while ( !rd_is_active(idev->ring_hw+idev->rx_get) ) {
-
-		ring_ptr_inc(&idev->rx_get, idev->rx_mask);
-
-		while (entry != idev->rx_get) {
-
-			status = rd_get_status(idev->ring_hw+entry);
+	r = &idev->rx_ring;
+	while (!rd_is_active(r, r->tail)) {
 
-			if (status & RD_STAT_ACTIVE) {
-				printk(KERN_CRIT "%s: rx still active!!!\n",
-					__FUNCTION__);
-				break;
-			}
-			if (status & RX_STAT_ERROR) {
-				idev->stats.rx_errors++;
-				if (status & RX_STAT_OVER)  
-					idev->stats.rx_over_errors++;
-				if (status & RX_STAT_LENGTH)  
-					idev->stats.rx_length_errors++;
-				if (status & RX_STAT_PHYERR)  
-					idev->stats.rx_frame_errors++;
-				if (status & RX_STAT_CRCERR)  
-					idev->stats.rx_crc_errors++;
+		status = rd_get_status(r, r->tail);
+		if (status & RX_STAT_ERROR) {
+			idev->stats.rx_errors++;
+			if (status & RX_STAT_OVER)  
+				idev->stats.rx_over_errors++;
+			if (status & RX_STAT_LENGTH)  
+				idev->stats.rx_length_errors++;
+			if (status & RX_STAT_PHYERR)  
+				idev->stats.rx_frame_errors++;
+			if (status & RX_STAT_CRCERR)  
+				idev->stats.rx_crc_errors++;
+		}
+		else {
+			len = rd_get_count(r, r->tail);
+			crclen = (idev->mode==IFF_FIR) ? sizeof(u32) : sizeof(u16);
+			if (len < crclen)
+				printk(KERN_ERR "%s: strange frame (len=%d)\n",
+					__FUNCTION__, len);
+			else
+				len -= crclen;		/* remove trailing CRC */
+
+			skb = dev_alloc_skb(len+1);
+			if (skb) {
+				skb->dev = ndev;
+				skb_reserve(skb,1);
+				memcpy(skb_put(skb,len), r->buf[r->tail].data, len);
+				idev->stats.rx_packets++;
+				idev->stats.rx_bytes += len;
+				skb->mac.raw = skb->data;
+				skb->protocol = htons(ETH_P_IRDA);
+				netif_rx(skb);				
 			}
 			else {
-				len = rd_get_count(idev->ring_hw+entry);
-				crclen = (idev->mode==IFF_FIR) ? 4 : 2;
-				if (len < crclen)
-					printk(KERN_ERR "%s: strange frame (len=%d)\n",
-						__FUNCTION__, len);
-				else
-					len -= crclen;		/* remove trailing CRC */
-
-				skb = dev_alloc_skb(len+1);
-				if (skb) {
-					skb->dev = ndev;
-					skb_reserve(skb,1);
-					memcpy(skb_put(skb,len), idev->ring_buf[entry].head, len);
-					idev->stats.rx_packets++;
-					idev->stats.rx_bytes += len;
-					skb->mac.raw = skb->data;
-					skb->protocol = htons(ETH_P_IRDA);
-					netif_rx(skb);				
-				}
-				else {
-					idev->stats.rx_dropped++;
-					printk(KERN_ERR "%s: rx packet dropped\n", __FUNCTION__);
-				}
+				idev->stats.rx_dropped++;
+				printk(KERN_ERR "%s: rx packet dropped\n", __FUNCTION__);
 			}
-			rd_set_count(idev->ring_hw+entry, 0);
-			rd_set_status(idev->ring_hw+entry, RD_STAT_ACTIVE);
-			ring_ptr_inc(&entry, idev->rx_mask);
+		}
+		rd_set_count(r, r->tail, 0);
+		rd_set_status(r, r->tail, 0);
+		ring_get(r);
+		if (r->tail == r->head) {
+			printk(KERN_WARNING "%s: rx ring exhausted\n", __FUNCTION__);
+			break;
 		}
 	}
-	idev->rx_put = idev->rx_get;
-	idev->rx_get = entry;
 
-	word = inw(iobase+VLSI_PIO_IRENABLE);
-	if (!(word & IRENABLE_ENTXST)) {
+	do_gettimeofday(&idev->last_rx); /* remember "now" for later mtt delay */
 
-		/* only rewrite ENRX, if tx not running!
-		 * rewriting ENRX during tx in progress wouldn't hurt
-		 * but would be racy since we would also have to rewrite
-		 * ENTX then (same register) - which might get disabled meanwhile.
-		 */
+	vlsi_refill_rx(r);
 
-		outw(0, iobase+VLSI_PIO_IRENABLE);
-
-		word = inw(iobase+VLSI_PIO_IRCFG);
-		mb();
-		outw(word | IRCFG_ENRX, iobase+VLSI_PIO_IRCFG);
-		wmb();
-		outw(IRENABLE_IREN, iobase+VLSI_PIO_IRENABLE);
-	}
 	mb();
-	outw(0, iobase+VLSI_PIO_PROMPT);
+	outw(0, ndev->base_addr+VLSI_PIO_PROMPT);
+
 	return 0;
 }
 
@@ -649,64 +666,55 @@ static int vlsi_rx_interrupt(struct net_
 static int vlsi_tx_interrupt(struct net_device *ndev)
 {
 	vlsi_irda_dev_t *idev = ndev->priv;
-	int	iobase;
-	int	entry;
+	struct vlsi_ring	*r;
+	unsigned	iobase;
 	int	ret;
 	u16	config;
 	u16	status;
 
-	ret = 0;
-	iobase = ndev->base_addr;
-
-	entry = idev->tx_get;
-
-	while ( !rd_is_active(idev->ring_hw+idev->tx_get) ) {
-
-		if (idev->tx_get == idev->tx_put) { /* tx ring empty */
-			/* sth more to do here? */
-			break;
+	r = &idev->tx_ring;
+	while (!rd_is_active(r, r->tail)) {
+		if (r->tail == r->head)
+			break;	/* tx ring empty - nothing to send anymore */
+
+		status = rd_get_status(r, r->tail);
+		if (status & TX_STAT_UNDRN) {
+			idev->stats.tx_errors++;
+			idev->stats.tx_fifo_errors++;
 		}
-		ring_ptr_inc(&idev->tx_get, idev->tx_mask);
-		while (entry != idev->tx_get) {
-			status = rd_get_status(idev->ring_hw+entry);
-			if (status & RD_STAT_ACTIVE) {
-				printk(KERN_CRIT "%s: tx still active!!!\n",
-					__FUNCTION__);
-				break;
-			}
-			if (status & TX_STAT_UNDRN) {
-				idev->stats.tx_errors++;
-				idev->stats.tx_fifo_errors++;
-			}
-			else {
-				idev->stats.tx_packets++;
-				idev->stats.tx_bytes += rd_get_count(idev->ring_hw+entry);
-			}
-			rd_set_count(idev->ring_hw+entry, 0);
-			rd_set_status(idev->ring_hw+entry, 0);
-			ring_ptr_inc(&entry, idev->tx_mask);
+		else {
+			idev->stats.tx_packets++;
+			idev->stats.tx_bytes += rd_get_count(r, r->tail); /* not correct for SIR */
 		}
+		rd_set_count(r, r->tail, 0);
+		rd_set_status(r, r->tail, 0);
+		if (r->buf[r->tail].skb) {
+			rd_set_addr_status(r, r->tail, 0, 0);
+			dev_kfree_skb(r->buf[r->tail].skb);
+			r->buf[r->tail].skb = NULL;
+			r->buf[r->tail].data = NULL;
+		}
+		ring_get(r);
 	}
 
-	outw(0, iobase+VLSI_PIO_IRENABLE);
-	config = inw(iobase+VLSI_PIO_IRCFG);
-	mb();
+	ret = 0;
+	iobase = ndev->base_addr;
 
-	if (idev->tx_get != idev->tx_put) {	/* tx ring not empty */
-		outw(config | IRCFG_ENTX, iobase+VLSI_PIO_IRCFG);
-		ret = 1;			/* no speed-change-check */
+	if (r->head == r->tail) {	/* tx ring empty: re-enable rx */
+
+		outw(0, iobase+VLSI_PIO_IRENABLE);
+		config = inw(iobase+VLSI_PIO_IRCFG);
+		mb();
+		outw((config & ~IRCFG_ENTX) | IRCFG_ENRX, iobase+VLSI_PIO_IRCFG);
+		wmb();
+		outw(IRENABLE_IREN, iobase+VLSI_PIO_IRENABLE);
 	}
 	else
-		outw((config & ~IRCFG_ENTX) | IRCFG_ENRX, iobase+VLSI_PIO_IRCFG);
-	wmb();
-	outw(IRENABLE_IREN, iobase+VLSI_PIO_IRENABLE);
+		ret = 1;			/* no speed-change-check */
 
 	mb();
-
 	outw(0, iobase+VLSI_PIO_PROMPT);
-	wmb();
 
-	idev->tx_get = entry;
 	if (netif_queue_stopped(ndev)) {
 		netif_wake_queue(ndev);
 		printk(KERN_DEBUG "%s: queue awoken\n", __FUNCTION__);
@@ -715,24 +723,27 @@ static int vlsi_tx_interrupt(struct net_
 }
 
 
+#if 0	/* disable ACTIVITY handling for now */
+
 static int vlsi_act_interrupt(struct net_device *ndev)
 {
 	printk(KERN_DEBUG "%s\n", __FUNCTION__);
 	return 0;
 }
-
+#endif
 
 static void vlsi_interrupt(int irq, void *dev_instance, struct pt_regs *regs)
 {
 	struct net_device *ndev = dev_instance;
 	vlsi_irda_dev_t *idev = ndev->priv;
-	int		iobase;
+	unsigned	iobase;
 	u8		irintr;
-	int 		boguscount = 20;
+	int 		boguscount = 32;
 	int		no_speed_check = 0;
+	unsigned	got_act;
 	unsigned long	flags;
 
-
+	got_act = 0;
 	iobase = ndev->base_addr;
 	spin_lock_irqsave(&idev->lock,flags);
 	do {
@@ -752,9 +763,16 @@ static void vlsi_interrupt(int irq, void
 		if (irintr&IRINTR_TPKTINT)
 			no_speed_check |= vlsi_tx_interrupt(ndev);
 
-		if ((irintr&IRINTR_ACTIVITY) && !(irintr^IRINTR_ACTIVITY) )
-			no_speed_check |= vlsi_act_interrupt(ndev);
+#if 0	/* disable ACTIVITY handling for now */
+
+		if (got_act  &&  irintr==IRINTR_ACTIVITY) /* nothing new */
+			break;
 
+		if ((irintr&IRINTR_ACTIVITY) && !(irintr^IRINTR_ACTIVITY) ) {
+			no_speed_check |= vlsi_act_interrupt(ndev);
+			got_act = 1;
+		}
+#endif
 		if (irintr & ~(IRINTR_RPKTINT|IRINTR_TPKTINT|IRINTR_ACTIVITY))
 			printk(KERN_DEBUG "%s: IRINTR = %02x\n",
 				__FUNCTION__, (unsigned)irintr);
@@ -774,27 +792,51 @@ static void vlsi_interrupt(int irq, void
 
 /**************************************************************/
 
+
+/* writing all-zero to the VLSI PCI IO register area seems to prevent
+ * some occasional situations where the hardware fails (symptoms are 
+ * what appears as stalled tx/rx state machines, i.e. everything ok for
+ * receive or transmit but hw makes no progress or is unable to access
+ * the bus memory locations).
+ * Best place to call this is immediately after/before the internal clock
+ * gets started/stopped.
+ */
+
+static inline void vlsi_clear_regs(unsigned iobase)
+{
+	unsigned	i;
+	const unsigned	chip_io_extent = 32;
+
+	for (i = 0; i < chip_io_extent; i += sizeof(u16))
+		outw(0, iobase + i);
+}
+
+
 static int vlsi_open(struct net_device *ndev)
 {
 	vlsi_irda_dev_t *idev = ndev->priv;
 	struct pci_dev *pdev = idev->pdev;
-	char	hwname[32];
 	int	err;
-
-	MOD_INC_USE_COUNT;		/* still needed? - we have SET_MODULE_OWNER! */
+	char	hwname[32];
 
 	if (pci_request_regions(pdev,drivername)) {
 		printk(KERN_ERR "%s: io resource busy\n", __FUNCTION__);
-		MOD_DEC_USE_COUNT;
 		return -EAGAIN;
 	}
 
-	if (request_irq(ndev->irq, vlsi_interrupt, SA_SHIRQ|SA_INTERRUPT,
+	/* under some rare occasions the chip apparently comes up
+	 * with IRQ's pending. So we get interrupts invoked much too early
+	 * which will immediately kill us again :-(
+	 * so we better w/c pending IRQ and disable them all
+	 */
+
+	outb(IRINTR_INT_MASK, ndev->base_addr+VLSI_PIO_IRINTR);
+
+	if (request_irq(ndev->irq, vlsi_interrupt, SA_SHIRQ,
 			drivername, ndev)) {
 		printk(KERN_ERR "%s: couldn't get IRQ: %d\n",
 			__FUNCTION__, ndev->irq);
 		pci_release_regions(pdev);
-		MOD_DEC_USE_COUNT;
 		return -EAGAIN;
 	}
 	printk(KERN_INFO "%s: got resources for %s - irq=%d / io=%04lx\n",
@@ -805,18 +847,18 @@ static int vlsi_open(struct net_device *
 			__FUNCTION__);
 		free_irq(ndev->irq,ndev);
 		pci_release_regions(pdev);
-		MOD_DEC_USE_COUNT;
 		return -EIO;
 	}
 
 	vlsi_start_clock(pdev);
 
+	vlsi_clear_regs(ndev->base_addr);
+
 	err = vlsi_init_ring(idev);
 	if (err) {
 		vlsi_unset_clock(pdev);
 		free_irq(ndev->irq,ndev);
 		pci_release_regions(pdev);
-		MOD_DEC_USE_COUNT;
 		return err;
 	}
 
@@ -827,7 +869,11 @@ static int vlsi_open(struct net_device *
 		(idev->mode==IFF_SIR)?"SIR":((idev->mode==IFF_MIR)?"MIR":"FIR"),
 		(sirpulse)?"3/16 bittime":"short");
 
-	sprintf(hwname, "VLSI-FIR");
+	vlsi_arm_rx(&idev->rx_ring);
+
+	do_gettimeofday(&idev->last_rx);  /* first mtt may start from now on */
+
+	sprintf(hwname, "VLSI-FIR @ 0x%04x", (unsigned)ndev->base_addr);
 	idev->irlap = irlap_open(ndev,&idev->qos,hwname);
 
 	netif_start_queue(ndev);
@@ -843,7 +889,6 @@ static int vlsi_close(struct net_device 
 {
 	vlsi_irda_dev_t *idev = ndev->priv;
 	struct pci_dev *pdev = idev->pdev;
-	int	i;
 	u8	cmd;
 	unsigned iobase;
 
@@ -861,30 +906,26 @@ static int vlsi_close(struct net_device 
 	outw(0, iobase+VLSI_PIO_IRCFG);			/* disable everything */
 	wmb();
 	outw(IRENABLE_IREN, iobase+VLSI_PIO_IRENABLE);
-	mb();				/* from now on */
+	mb();						/* ... from now on */
 
 	outw(0, iobase+VLSI_PIO_IRENABLE);
 	wmb();
 
+	vlsi_clear_regs(ndev->base_addr);
+
 	vlsi_stop_clock(pdev);
 
 	vlsi_unset_clock(pdev);
 
 	free_irq(ndev->irq,ndev);
 
-	if (idev->ring_buf) {
-		for (i = 0; i < 2*MAX_RING_DESCR; i++) {
-			if (idev->ring_buf[i].head)
-				kfree(idev->ring_buf[i].head);
-		}
-		kfree(idev->ring_buf);
-	}
+	vlsi_free_ringbuf(&idev->rx_ring);
+	vlsi_free_ringbuf(&idev->tx_ring);
 
 	if (idev->busaddr)
-		pci_free_consistent(idev->pdev,RING_AREA_SIZE,idev->ring_hw,idev->busaddr);
+		pci_free_consistent(idev->pdev,RING_AREA_SIZE,idev->virtaddr,idev->busaddr);
 
-	idev->ring_buf = NULL;
-	idev->ring_hw = NULL;
+	idev->virtaddr = NULL;
 	idev->busaddr = 0;
 
 	pci_read_config_byte(pdev, PCI_COMMAND, &cmd);
@@ -895,7 +936,6 @@ static int vlsi_close(struct net_device 
 
 	printk(KERN_INFO "%s: device %s stopped\n", __FUNCTION__, ndev->name);
 
-	MOD_DEC_USE_COUNT;
 	return 0;
 }
 
@@ -909,16 +949,17 @@ static struct net_device_stats * vlsi_ge
 static int vlsi_hard_start_xmit(struct sk_buff *skb, struct net_device *ndev)
 {
 	vlsi_irda_dev_t *idev = ndev->priv;
+	struct vlsi_ring	*r;
 	unsigned long flags;
-	int iobase;
+	unsigned iobase;
 	u8 status;
 	u16 config;
 	int mtt;
-	int entry;
 	int len, speed;
+	struct timeval  now, ready;
 
 
-	iobase = ndev->base_addr;
+	status = 0;
 
 	speed = irda_get_next_speed(skb);
 
@@ -931,71 +972,88 @@ static int vlsi_hard_start_xmit(struct s
 		}
 		status = TX_STAT_CLRENTX;  /* stop tx-ring after this frame */
 	}
-	else
-		status = 0;
 
+	if (skb->len == 0) {
+		printk(KERN_ERR "%s: blocking 0-size packet???\n",
+			__FUNCTION__);
+		dev_kfree_skb(skb);
+		return 0;
+	}
 
-	spin_lock_irqsave(&idev->lock,flags);
+	r = &idev->tx_ring;
 
-	entry = idev->tx_put;
+	if (rd_is_active(r, r->head))
+		BUG();
 
 	if (idev->mode == IFF_SIR) {
 		status |= TX_STAT_DISCRC;
-		len = async_wrap_skb(skb, idev->ring_buf[entry].head,
-			XFER_BUF_SIZE);
+		len = async_wrap_skb(skb, r->buf[r->head].data, XFER_BUF_SIZE);
 	}
 	else {				/* hw deals with MIR/FIR mode */
 		len = skb->len;
-		memcpy(idev->ring_buf[entry].head, skb->data, len);
+		memcpy(r->buf[r->head].data, skb->data, len);
 	}
 
-	if (len == 0)
-		printk(KERN_ERR "%s: sending 0-size packet???\n",
-			__FUNCTION__);
-
-	status |= RD_STAT_ACTIVE;
-
-	rd_set_count(idev->ring_hw+entry, len);
-	rd_set_status(idev->ring_hw+entry, status);
-	ring_ptr_inc(&idev->tx_put, idev->tx_mask);
+	rd_set_count(r, r->head, len);
+	rd_set_addr_status(r, r->head, virt_to_bus(r->buf[r->head].data), status);
 
-	dev_kfree_skb(skb);	
+	/* new entry not yet activated! */
 
 #if 0
 	printk(KERN_DEBUG "%s: dump entry %d: %u %02x %08x\n",
-		__FUNCTION__, entry,
-		idev->ring_hw[entry].rd_count,
-		(unsigned)idev->ring_hw[entry].rd_status,
-		idev->ring_hw[entry].rd_addr & 0xffffffff);
+		__FUNCTION__, r->head,
+		idev->ring_hw[r->head].rd_count,
+		(unsigned)idev->ring_hw[r->head].rd_status,
+		idev->ring_hw[r->head].rd_addr & 0xffffffff);
 	vlsi_reg_debug(iobase,__FUNCTION__);
 #endif
 
+
+	/* let mtt delay pass before we need to acquire the spinlock! */
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
+		}
+	}
+
 /*
- *	race window due to concurrent controller processing!
+ *	race window ahead, due to concurrent controller processing!
  *
- *	we may loose ENTX at any time when the controller
- *	fetches an inactive descr or one with CLR_ENTX set.
- *	therefore we only rely on the controller telling us
- *	tx is already stopped because (cannot restart without PROMPT).
- *	instead we depend on the tx-complete-isr to detect the
- *	false negatives and retrigger the tx ring.
- *	that's why we need interrupts disabled till tx has been
- *	kicked, so the tx-complete-isr was either already finished
- *	before we've put the new active descriptor on the ring - or
- *	the isr will be called after the new active descr is on the
- *	ring _and_ the ring was prompted. Making these two steps
- *	atomic allows to resolve the race.
+ *	We need to disable IR output in order to switch to TX mode.
+ *	Better not do this blindly anytime we want to transmit something
+ *	because TX may already run. However the controller may stop TX
+ *	at any time when fetching an inactive descriptor or one with
+ *	CLR_ENTX set. So we switch on TX only, if TX was not running
+ *	_after_ the new descriptor was activated on the ring. This ensures
+ *	we will either find TX already stopped or we can be sure, there
+ *	will be a TX-complete interrupt even if the chip stopped doing
+ *	TX just after we found it still running. The ISR will then find
+ *	the non-empty ring and restart TX processing. The enclosing
+ *	spinlock is required to get serialization with the ISR right.
  */
 
+
 	iobase = ndev->base_addr;
 
-	if (!(inw(iobase+VLSI_PIO_IRENABLE) & IRENABLE_ENTXST)) {
+	spin_lock_irqsave(&idev->lock,flags);
 
-		mtt = irda_get_mtt(skb);
-		if (mtt) {
-			udelay(mtt);		/* ### FIXME ... */
-		}
+	rd_activate(r, r->head);
+	ring_put(r);
 
+	if (!(inw(iobase+VLSI_PIO_IRENABLE) & IRENABLE_ENTXST)) {
+	
 		outw(0, iobase+VLSI_PIO_IRENABLE);
 
 		config = inw(iobase+VLSI_PIO_IRCFG);
@@ -1003,29 +1061,28 @@ static int vlsi_hard_start_xmit(struct s
 		outw(config | IRCFG_ENTX, iobase+VLSI_PIO_IRCFG);
 		wmb();
 		outw(IRENABLE_IREN, iobase+VLSI_PIO_IRENABLE);
-
 		mb();
-
 		outw(0, iobase+VLSI_PIO_PROMPT);
 		wmb();
 	}
 
-	spin_unlock_irqrestore(&idev->lock, flags);
-
-	if (idev->tx_put == idev->tx_get) {
+	if (r->head == r->tail) {
 		netif_stop_queue(ndev);
 		printk(KERN_DEBUG "%s: tx ring full - queue stopped: %d/%d\n",
-			__FUNCTION__, idev->tx_put, idev->tx_get);
-		entry = idev->tx_get;
+			__FUNCTION__, r->head, r->tail);
+#if 0
 		printk(KERN_INFO "%s: dump stalled entry %d: %u %02x %08x\n",
-			__FUNCTION__, entry,
-			idev->ring_hw[entry].rd_count,
-			(unsigned)idev->ring_hw[entry].rd_status,
-			idev->ring_hw[entry].rd_addr & 0xffffffff);
+			__FUNCTION__, r->tail,
+			r->hw[r->tail].rd_count,
+			(unsigned)r->hw[r->tail].rd_status,
+			r->hw[r->tail].rd_addr & 0xffffffff);
+#endif
 		vlsi_reg_debug(iobase,__FUNCTION__);
 	}
 
-//	vlsi_reg_debug(iobase, __FUNCTION__);
+	spin_unlock_irqrestore(&idev->lock, flags);
+
+	dev_kfree_skb(skb);	
 
 	return 0;
 }
@@ -1056,6 +1113,10 @@ static int vlsi_ioctl(struct net_device 
 			irda_device_set_media_busy(ndev, TRUE);
 			break;
 		case SIOCGRECEIVING:
+			/* the best we can do: check whether there are any bytes in rx fifo.
+			 * The trustable window (in case some data arrives just afterwards)
+			 * may be as short as 1usec or so at 4Mbps - no way for future-telling.
+			 */
 			fifocnt = inw(ndev->base_addr+VLSI_PIO_RCVBCNT) & RCVBCNT_MASK;
 			irq->ifr_receiving = (fifocnt!=0) ? 1 : 0;
 			break;
@@ -1091,7 +1152,6 @@ int vlsi_irda_init(struct net_device *nd
 		return -1;
 	}
 	pci_set_master(pdev);
-
 	pdev->dma_mask = DMA_MASK_MSTRPAGE;
 	pci_write_config_byte(pdev, VLSI_PCI_MSTRPAGE, MSTRPAGE_VALUE);
 
@@ -1110,13 +1170,13 @@ int vlsi_irda_init(struct net_device *nd
 		| IR_19200 | IR_38400 | IR_57600 | IR_115200
 		| IR_1152000 | (IR_4000000 << 8);
 
-	idev->qos.min_turn_time.bits = mtt_bits;
+	idev->qos.min_turn_time.bits = qos_mtt_bits;
 
 	irda_qos_bits_to_value(&idev->qos);
 
 	irda_device_setup(ndev);
 
-	/* currently no media definitions for SIR/MIR/FIR */
+	/* currently no public media definitions for IrDA */
 
 	ndev->flags |= IFF_PORTSEL | IFF_AUTOMEDIA;
 	ndev->if_port = IF_PORT_UNKNOWN;
@@ -1139,15 +1199,18 @@ vlsi_irda_probe(struct pci_dev *pdev, co
 	vlsi_irda_dev_t		*idev;
 	int			alloc_size;
 
-	printk(KERN_INFO "%s: found IrDA PCI controler %s\n", drivername, pdev->name);
 
+	vlsi_reg_debug(0x3000, "vlsi initial state");
 	if (pci_enable_device(pdev))
 		goto out;
 
+	printk(KERN_INFO "%s: IrDA PCI controller %s detected\n",
+		drivername, pdev->name);
+
 	if ( !pci_resource_start(pdev,0)
 	     || !(pci_resource_flags(pdev,0) & IORESOURCE_IO) ) {
 		printk(KERN_ERR "%s: bar 0 invalid", __FUNCTION__);
-		goto out;
+		goto out_disable;
 	}
 
 	alloc_size = sizeof(*ndev) + sizeof(*idev);
@@ -1156,7 +1219,7 @@ vlsi_irda_probe(struct pci_dev *pdev, co
 	if (ndev==NULL) {
 		printk(KERN_ERR "%s: Unable to allocate device memory.\n",
 			__FUNCTION__);
-		goto out;
+		goto out_disable;
 	}
 
 	memset(ndev, 0, alloc_size);
@@ -1181,6 +1244,8 @@ vlsi_irda_probe(struct pci_dev *pdev, co
 
 out_freedev:
 	kfree(ndev);
+out_disable:
+	pci_disable_device(pdev);
 out:
 	pdev->driver_data = NULL;
 	return -ENODEV;
@@ -1233,23 +1298,32 @@ static struct pci_driver vlsi_irda_drive
 
 static int __init vlsi_mod_init(void)
 {
+	int	i;
+
 	if (clksrc < 0  ||  clksrc > 3) {
-		printk(KERN_ERR "%s: invalid clksrc=%d\n", __FUNCTION__, clksrc);
+		printk(KERN_ERR "%s: invalid clksrc=%d\n", drivername, clksrc);
 		return -1;
 	}
-	if ( ringsize[0]==0  ||  (ringsize[0] & ~(64|32|16|8|4))
-	     ||  ((ringsize[0]-1)&ringsize[0])) {
-		printk(KERN_INFO "%s: invalid tx ringsize %d - using default=16\n",
-			__FUNCTION__, ringsize[0]);
-		ringsize[0] = 16;
+
+	for (i = 0; i < 2; i++) {
+		switch(ringsize[i]) {
+			case 4:
+			case 8:
+			case 16:
+			case 32:
+			case 64:
+				break;
+			default:
+				printk(KERN_WARNING "%s: invalid %s ringsize %d",
+					drivername, (i)?"rx":"tx", ringsize[i]);
+				printk(", using default=8\n");
+				ringsize[i] = 8;
+				break;
+		}
 	} 
-	if ( ringsize[1]==0  ||  (ringsize[1] & ~(64|32|16|8|4))
-	     ||  ((ringsize[1]-1)&ringsize[1])) {
-		printk(KERN_INFO "%s: invalid rx ringsize %d - using default=16\n",
-			__FUNCTION__, ringsize[1]);
-		ringsize[1] = 16;
-	}
+
 	sirpulse = !!sirpulse;
+
 	return pci_module_init(&vlsi_irda_driver);
 }
 
