Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262635AbTJXVRq (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 24 Oct 2003 17:17:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262640AbTJXVRq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 24 Oct 2003 17:17:46 -0400
Received: from hq.pm.waw.pl ([195.116.170.10]:10217 "EHLO hq.pm.waw.pl")
	by vger.kernel.org with ESMTP id S262635AbTJXVRO (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 24 Oct 2003 17:17:14 -0400
To: Marcelo Tosatti <marcelo@conectiva.com.br>
Cc: lkml <linux-kernel@vger.kernel.org>
Subject: [PATCH] Goramo PCI200SYN sync serial card driver for 2.4.23pre8
From: Krzysztof Halasa <khc@pm.waw.pl>
Date: 24 Oct 2003 23:13:36 +0200
In-Reply-To: <Pine.LNX.4.55L.0308301743280.31768@freak.distro.conectiva>
Message-ID: <m31xt2tk3j.fsf_-_@defiant.pm.waw.pl>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="=-=-="
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--=-=-=

Hi,

The attached patch is a driver for Goramo PCI200SYN, a dual channel
synchronous serial card. Applies cleanly to Linux-2.4.23pre8, compiles,
works (another version of this driver has been submitted for inclusion
into 2.6.0test).

Please apply to Linux 2.4. Thanks.
-- 
Krzysztof Halasa, B*FH

--=-=-=
Content-Type: text/x-patch
Content-Disposition: attachment;
  filename=pci200syn-2.4.23pre8-1.14.patch

--- linux-2.4.orig/drivers/net/wan/Makefile	2003-10-24 22:49:52.000000000 +0200
+++ linux-2.4/drivers/net/wan/Makefile	2003-10-24 22:50:51.000000000 +0200
@@ -77,6 +77,7 @@
 endif
 obj-$(CONFIG_N2)		+= n2.o
 obj-$(CONFIG_C101)		+= c101.o
+obj-$(CONFIG_PCI200SYN)		+= pci200syn.o
 
 include $(TOPDIR)/Rules.make
 
--- linux-2.4.orig/drivers/net/wan/hd64572.h	2003-10-24 22:54:14.000000000 +0200
+++ linux-2.4/drivers/net/wan/hd64572.h	2003-10-24 22:39:48.000000000 +0200
@@ -0,0 +1,488 @@
+/*
+ * hd64572.h	Description of the Hitachi HD64572 (SCA-II), valid for 
+ * 		CPU modes 0 & 2.
+ *
+ * Authors:	Ivan Passos <ivan@cyclades.com>
+ *              Krzysztof Halasa <khc@pm.waw.pl>
+ *
+ * Copyright:   (c) 2000-2001 Cyclades Corp.
+ *              (C) 2000-2003 Krzysztof Halasa <khc@pm.waw.pl>
+ *
+ *	This program is free software; you can redistribute it and/or
+ *	modify it under the terms of the GNU General Public License
+ *	as published by the Free Software Foundation; either version
+ *	2 of the License, or (at your option) any later version.
+ *
+ */
+
+#ifndef __HD64572_H
+#define __HD64572_H
+
+/* Illegal Access Register */
+#define	ILAR	0x00
+
+/* Wait Controller Registers */
+#define PABR0L	0x20	/* Physical Addr Boundary Register 0 L */
+#define PABR0H	0x21	/* Physical Addr Boundary Register 0 H */
+#define PABR1L	0x22	/* Physical Addr Boundary Register 1 L */
+#define PABR1H	0x23	/* Physical Addr Boundary Register 1 H */
+#define WCRL	0x24	/* Wait Control Register L */
+#define WCRM	0x25	/* Wait Control Register M */
+#define WCRH	0x26	/* Wait Control Register H */
+
+/* Interrupt Registers */
+#define IVR	0x60	/* Interrupt Vector Register */
+#define IMVR	0x64	/* Interrupt Modified Vector Register */
+#define ITCR	0x68	/* Interrupt Control Register */
+#define ISR0	0x6c	/* Interrupt Status Register 0 */
+#define ISR1	0x70	/* Interrupt Status Register 1 */
+#define IER0	0x74	/* Interrupt Enable Register 0 */
+#define IER1	0x78	/* Interrupt Enable Register 1 */
+
+/* Register Access Macros (chan is 0 or 1 in _any_ case) */
+#define	M_REG(reg, chan)	(reg + 0x80*chan)	       /* MSCI */
+#define	DRX_REG(reg, chan)	(reg + 0x40*chan)	       /* DMA Rx */
+#define	DTX_REG(reg, chan)	(reg + 0x20*(2*chan + 1))      /* DMA Tx */
+#define	TRX_REG(reg, chan)	(reg + 0x20*chan)	       /* Timer Rx */
+#define	TTX_REG(reg, chan)	(reg + 0x10*(2*chan + 1))      /* Timer Tx */
+#define	ST_REG(reg, chan)	(reg + 0x80*chan)	       /* Status Cnt */
+#define IR0_DRX(val, chan)	((val)<<(8*(chan)))	       /* Int DMA Rx */
+#define IR0_DTX(val, chan)	((val)<<(4*(2*chan + 1)))      /* Int DMA Tx */
+#define IR0_M(val, chan)	((val)<<(8*(chan)))	       /* Int MSCI */
+
+/* MSCI Channel Registers */
+#define MSCI0_OFFSET 0x00
+#define MSCI1_OFFSET 0x80
+
+/* MSCI Channel Registers */
+#define MD0	0x138	/* Mode reg 0 */
+#define MD1	0x139	/* Mode reg 1 */
+#define MD2	0x13a	/* Mode reg 2 */
+#define MD3	0x13b	/* Mode reg 3 */
+#define CTL	0x130	/* Control reg */
+#define RXS	0x13c	/* RX clock source */
+#define TXS	0x13d	/* TX clock source */
+#define EXS	0x13e	/* External clock input selection */
+#define TMCT	0x144	/* Time constant (Tx) */
+#define TMCR	0x145	/* Time constant (Rx) */
+#define CMD	0x128	/* Command reg */
+#define ST0	0x118	/* Status reg 0 */
+#define ST1	0x119	/* Status reg 1 */
+#define ST2	0x11a	/* Status reg 2 */
+#define ST3	0x11b	/* Status reg 3 */
+#define ST4	0x11c	/* Status reg 4 */
+#define FST	0x11d	/* frame Status reg  */
+#define IE0	0x120	/* Interrupt enable reg 0 */
+#define IE1	0x121	/* Interrupt enable reg 1 */
+#define IE2	0x122	/* Interrupt enable reg 2 */
+#define IE4	0x124	/* Interrupt enable reg 4 */
+#define FIE	0x125	/* Frame Interrupt enable reg  */
+#define SA0	0x140	/* Syn Address reg 0 */
+#define SA1	0x141	/* Syn Address reg 1 */
+#define IDL	0x142	/* Idle register */
+#define TRBL	0x100	/* TX/RX buffer reg L */ 
+#define TRBK	0x101	/* TX/RX buffer reg K */ 
+#define TRBJ	0x102	/* TX/RX buffer reg J */ 
+#define TRBH	0x103	/* TX/RX buffer reg H */ 
+#define TRC0	0x148	/* TX Ready control reg 0 */ 
+#define TRC1	0x149	/* TX Ready control reg 1 */ 
+#define RRC	0x14a	/* RX Ready control reg */ 
+#define CST0	0x108	/* Current Status Register 0 */ 
+#define CST1	0x109	/* Current Status Register 1 */ 
+#define CST2	0x10a	/* Current Status Register 2 */ 
+#define CST3	0x10b	/* Current Status Register 3 */ 
+#define GPO	0x131	/* General Purpose Output Pin Ctl Reg */
+#define TFS	0x14b	/* Tx Start Threshold Ctl Reg */
+#define TFN	0x143	/* Inter-transmit-frame Time Fill Ctl Reg */
+#define TBN	0x110	/* Tx Buffer Number Reg */
+#define RBN	0x111	/* Rx Buffer Number Reg */
+#define TNR0	0x150	/* Tx DMA Request Ctl Reg 0 */
+#define TNR1	0x151	/* Tx DMA Request Ctl Reg 1 */
+#define TCR	0x152	/* Tx DMA Critical Request Reg */
+#define RNR	0x154	/* Rx DMA Request Ctl Reg */
+#define RCR	0x156	/* Rx DMA Critical Request Reg */
+
+/* Timer Registers */
+#define TIMER0RX_OFFSET 0x00
+#define TIMER0TX_OFFSET 0x10
+#define TIMER1RX_OFFSET 0x20
+#define TIMER1TX_OFFSET 0x30
+
+/* Timer Registers */
+#define TCNTL	0x200	/* Timer Upcounter L */
+#define TCNTH	0x201	/* Timer Upcounter H */
+#define TCONRL	0x204	/* Timer Constant Register L */
+#define TCONRH	0x205	/* Timer Constant Register H */
+#define TCSR	0x206	/* Timer Control/Status Register */
+#define TEPR	0x207	/* Timer Expand Prescale Register */
+
+/* DMA registers */
+#define PCR		0x40		/* DMA priority control reg */
+#define DRR		0x44		/* DMA reset reg */
+#define DMER		0x07		/* DMA Master Enable reg */
+#define BTCR		0x08		/* Burst Tx Ctl Reg */
+#define BOLR		0x0c		/* Back-off Length Reg */
+#define DSR_RX(chan)	(0x48 + 2*chan)	/* DMA Status Reg (Rx) */
+#define DSR_TX(chan)	(0x49 + 2*chan)	/* DMA Status Reg (Tx) */
+#define DIR_RX(chan)	(0x4c + 2*chan)	/* DMA Interrupt Enable Reg (Rx) */
+#define DIR_TX(chan)	(0x4d + 2*chan)	/* DMA Interrupt Enable Reg (Tx) */
+#define FCT_RX(chan)	(0x50 + 2*chan)	/* Frame End Interrupt Counter (Rx) */
+#define FCT_TX(chan)	(0x51 + 2*chan)	/* Frame End Interrupt Counter (Tx) */
+#define DMR_RX(chan)	(0x54 + 2*chan)	/* DMA Mode Reg (Rx) */
+#define DMR_TX(chan)	(0x55 + 2*chan)	/* DMA Mode Reg (Tx) */
+#define DCR_RX(chan)	(0x58 + 2*chan)	/* DMA Command Reg (Rx) */
+#define DCR_TX(chan)	(0x59 + 2*chan)	/* DMA Command Reg (Tx) */
+
+/* DMA Channel Registers */
+#define DMAC0RX_OFFSET 0x00
+#define DMAC0TX_OFFSET 0x20
+#define DMAC1RX_OFFSET 0x40
+#define DMAC1TX_OFFSET 0x60
+
+/* DMA Channel Registers */
+#define DARL	0x80	/* Dest Addr Register L (single-block, RX only) */
+#define DARH	0x81	/* Dest Addr Register H (single-block, RX only) */
+#define DARB	0x82	/* Dest Addr Register B (single-block, RX only) */
+#define DARBH	0x83	/* Dest Addr Register BH (single-block, RX only) */
+#define SARL	0x80	/* Source Addr Register L (single-block, TX only) */
+#define SARH	0x81	/* Source Addr Register H (single-block, TX only) */
+#define SARB	0x82	/* Source Addr Register B (single-block, TX only) */
+#define DARBH	0x83	/* Source Addr Register BH (single-block, TX only) */
+#define BARL	0x80	/* Buffer Addr Register L (chained-block) */
+#define BARH	0x81	/* Buffer Addr Register H (chained-block) */
+#define BARB	0x82	/* Buffer Addr Register B (chained-block) */
+#define BARBH	0x83	/* Buffer Addr Register BH (chained-block) */
+#define CDAL	0x84	/* Current Descriptor Addr Register L */
+#define CDAH	0x85	/* Current Descriptor Addr Register H */
+#define CDAB	0x86	/* Current Descriptor Addr Register B */
+#define CDABH	0x87	/* Current Descriptor Addr Register BH */
+#define EDAL	0x88	/* Error Descriptor Addr Register L */
+#define EDAH	0x89	/* Error Descriptor Addr Register H */
+#define EDAB	0x8a	/* Error Descriptor Addr Register B */
+#define EDABH	0x8b	/* Error Descriptor Addr Register BH */
+#define BFLL	0x90	/* RX Buffer Length L (only RX) */
+#define BFLH	0x91	/* RX Buffer Length H (only RX) */
+#define BCRL	0x8c	/* Byte Count Register L */
+#define BCRH	0x8d	/* Byte Count Register H */
+
+/* Block Descriptor Structure */
+typedef struct {
+	u32 cp;			/* pointer to next block descriptor */
+	u32 bp;			/* buffer pointer */
+	u16 len;		/* data length */
+	u8 stat;		/* status */
+	u8 unused;		/* pads to 4-byte boundary */
+}pkt_desc;
+
+/* Packet Descriptor Status bits */
+
+#define ST_TX_EOM     0x80	/* End of frame */
+#define ST_TX_UNDRRUN 0x08
+#define ST_TX_OWNRSHP 0x02
+#define ST_TX_EOT     0x01	/* End of transmition */
+
+#define ST_RX_EOM     0x80	/* End of frame */
+#define ST_RX_SHORT   0x40	/* Short frame */
+#define ST_RX_ABORT   0x20	/* Abort */
+#define ST_RX_RESBIT  0x10	/* Residual bit */
+#define ST_RX_OVERRUN 0x08	/* Overrun */
+#define ST_RX_CRC     0x04	/* CRC */
+#define ST_RX_OWNRSHP 0x02
+
+#define ST_ERROR_MASK 0x7C
+
+/* Status Counter Registers */
+#define CMCR	0x158	/* Counter Master Ctl Reg */
+#define TECNTL	0x160	/* Tx EOM Counter L */
+#define TECNTM	0x161	/* Tx EOM Counter M */
+#define TECNTH	0x162	/* Tx EOM Counter H */
+#define TECCR	0x163	/* Tx EOM Counter Ctl Reg */
+#define URCNTL	0x164	/* Underrun Counter L */
+#define URCNTH	0x165	/* Underrun Counter H */
+#define URCCR	0x167	/* Underrun Counter Ctl Reg */
+#define RECNTL	0x168	/* Rx EOM Counter L */
+#define RECNTM	0x169	/* Rx EOM Counter M */
+#define RECNTH	0x16a	/* Rx EOM Counter H */
+#define RECCR	0x16b	/* Rx EOM Counter Ctl Reg */
+#define ORCNTL	0x16c	/* Overrun Counter L */
+#define ORCNTH	0x16d	/* Overrun Counter H */
+#define ORCCR	0x16f	/* Overrun Counter Ctl Reg */
+#define CECNTL	0x170	/* CRC Counter L */
+#define CECNTH	0x171	/* CRC Counter H */
+#define CECCR	0x173	/* CRC Counter Ctl Reg */
+#define ABCNTL	0x174	/* Abort frame Counter L */
+#define ABCNTH	0x175	/* Abort frame Counter H */
+#define ABCCR	0x177	/* Abort frame Counter Ctl Reg */
+#define SHCNTL	0x178	/* Short frame Counter L */
+#define SHCNTH	0x179	/* Short frame Counter H */
+#define SHCCR	0x17b	/* Short frame Counter Ctl Reg */
+#define RSCNTL	0x17c	/* Residual bit Counter L */
+#define RSCNTH	0x17d	/* Residual bit Counter H */
+#define RSCCR	0x17f	/* Residual bit Counter Ctl Reg */
+
+/* Register Programming Constants */
+
+#define IR0_DMIC	0x00000001
+#define IR0_DMIB	0x00000002
+#define IR0_DMIA	0x00000004
+#define IR0_EFT		0x00000008
+#define IR0_DMAREQ	0x00010000
+#define IR0_TXINT	0x00020000
+#define IR0_RXINTB	0x00040000
+#define IR0_RXINTA	0x00080000
+#define IR0_TXRDY	0x00100000
+#define IR0_RXRDY	0x00200000
+
+#define MD0_CRC16_0	0x00
+#define MD0_CRC16_1	0x01
+#define MD0_CRC32	0x02
+#define MD0_CRC_CCITT	0x03
+#define MD0_CRCC0	0x04
+#define MD0_CRCC1	0x08
+#define MD0_AUTO_ENA	0x10
+#define MD0_ASYNC	0x00
+#define MD0_BY_MSYNC	0x20
+#define MD0_BY_BISYNC	0x40
+#define MD0_BY_EXT	0x60
+#define MD0_BIT_SYNC	0x80
+#define MD0_TRANSP	0xc0
+
+#define MD0_HDLC        0x80	/* Bit-sync HDLC mode */
+
+#define MD0_CRC_NONE	0x00
+#define MD0_CRC_16_0	0x04
+#define MD0_CRC_16	0x05
+#define MD0_CRC_ITU32	0x06
+#define MD0_CRC_ITU	0x07
+
+#define MD1_NOADDR	0x00
+#define MD1_SADDR1	0x40
+#define MD1_SADDR2	0x80
+#define MD1_DADDR	0xc0
+
+#define MD2_NRZI_IEEE	0x40
+#define MD2_MANCHESTER	0x80
+#define MD2_FM_MARK	0xA0
+#define MD2_FM_SPACE	0xC0
+#define MD2_LOOPBACK    0x03	/* Local data Loopback */
+
+#define MD2_F_DUPLEX	0x00
+#define MD2_AUTO_ECHO	0x01
+#define MD2_LOOP_HI_Z	0x02
+#define MD2_LOOP_MIR	0x03
+#define MD2_ADPLL_X8	0x00
+#define MD2_ADPLL_X16	0x08
+#define MD2_ADPLL_X32	0x10
+#define MD2_NRZ		0x00
+#define MD2_NRZI	0x20
+#define MD2_NRZ_IEEE	0x40
+#define MD2_MANCH	0x00
+#define MD2_FM1		0x20
+#define MD2_FM0		0x40
+#define MD2_FM		0x80
+
+#define CTL_RTS		0x01
+#define CTL_DTR		0x02
+#define CTL_SYN		0x04
+#define CTL_IDLC	0x10
+#define CTL_UDRNC	0x20
+#define CTL_URSKP	0x40
+#define CTL_URCT	0x80
+
+#define CTL_NORTS	0x01
+#define CTL_NODTR	0x02
+#define CTL_IDLE	0x10
+
+#define	RXS_BR0		0x01
+#define	RXS_BR1		0x02
+#define	RXS_BR2		0x04
+#define	RXS_BR3		0x08
+#define	RXS_ECLK	0x00
+#define	RXS_ECLK_NS	0x20
+#define	RXS_IBRG	0x40
+#define	RXS_PLL1	0x50
+#define	RXS_PLL2	0x60
+#define	RXS_PLL3	0x70
+#define	RXS_DRTXC	0x80
+
+#define	TXS_BR0		0x01
+#define	TXS_BR1		0x02
+#define	TXS_BR2		0x04
+#define	TXS_BR3		0x08
+#define	TXS_ECLK	0x00
+#define	TXS_IBRG	0x40
+#define	TXS_RCLK	0x60
+#define	TXS_DTRXC	0x80
+
+#define	EXS_RES0	0x01
+#define	EXS_RES1	0x02
+#define	EXS_RES2	0x04
+#define	EXS_TES0	0x10
+#define	EXS_TES1	0x20
+#define	EXS_TES2	0x40
+
+#define CLK_BRG_MASK	0x0F
+#define CLK_PIN_OUT	0x80
+#define CLK_LINE    	0x00	/* clock line input */
+#define CLK_BRG     	0x40	/* internal baud rate generator */
+#define CLK_TX_RXCLK	0x60	/* TX clock from RX clock */
+
+#define CMD_RX_RST	0x11
+#define CMD_RX_ENA	0x12
+#define CMD_RX_DIS	0x13
+#define CMD_RX_CRC_INIT	0x14
+#define CMD_RX_MSG_REJ	0x15
+#define CMD_RX_MP_SRCH	0x16
+#define CMD_RX_CRC_EXC	0x17
+#define CMD_RX_CRC_FRC	0x18
+#define CMD_TX_RST	0x01
+#define CMD_TX_ENA	0x02
+#define CMD_TX_DISA	0x03
+#define CMD_TX_CRC_INIT	0x04
+#define CMD_TX_CRC_EXC	0x05
+#define CMD_TX_EOM	0x06
+#define CMD_TX_ABORT	0x07
+#define CMD_TX_MP_ON	0x08
+#define CMD_TX_BUF_CLR	0x09
+#define CMD_TX_DISB	0x0b
+#define CMD_CH_RST	0x21
+#define CMD_SRCH_MODE	0x31
+#define CMD_NOP		0x00
+
+#define CMD_RESET	0x21
+#define CMD_TX_ENABLE	0x02
+#define CMD_RX_ENABLE	0x12
+
+#define ST0_RXRDY	0x01
+#define ST0_TXRDY	0x02
+#define ST0_RXINTB	0x20
+#define ST0_RXINTA	0x40
+#define ST0_TXINT	0x80
+
+#define ST1_IDLE	0x01
+#define ST1_ABORT	0x02
+#define ST1_CDCD	0x04
+#define ST1_CCTS	0x08
+#define ST1_SYN_FLAG	0x10
+#define ST1_CLMD	0x20
+#define ST1_TXIDLE	0x40
+#define ST1_UDRN	0x80
+
+#define ST2_CRCE	0x04
+#define ST2_ONRN	0x08
+#define ST2_RBIT	0x10
+#define ST2_ABORT	0x20
+#define ST2_SHORT	0x40
+#define ST2_EOM		0x80
+
+#define ST3_RX_ENA	0x01
+#define ST3_TX_ENA	0x02
+#define ST3_DCD		0x04
+#define ST3_CTS		0x08
+#define ST3_SRCH_MODE	0x10
+#define ST3_SLOOP	0x20
+#define ST3_GPI		0x80
+
+#define ST4_RDNR	0x01
+#define ST4_RDCR	0x02
+#define ST4_TDNR	0x04
+#define ST4_TDCR	0x08
+#define ST4_OCLM	0x20
+#define ST4_CFT		0x40
+#define ST4_CGPI	0x80
+
+#define FST_CRCEF	0x04
+#define FST_OVRNF	0x08
+#define FST_RBIF	0x10
+#define FST_ABTF	0x20
+#define FST_SHRTF	0x40
+#define FST_EOMF	0x80
+
+#define IE0_RXRDY	0x01
+#define IE0_TXRDY	0x02
+#define IE0_RXINTB	0x20
+#define IE0_RXINTA	0x40
+#define IE0_TXINT     	0x00000080 /* TX INT MSCI interrupt enable */
+#define IE0_UDRN      	0x00008000 /* TX underrun MSCI interrupt enable */
+#define IE0_CDCD	0x00000400 /* CD level change interrupt enable */
+
+#define IE1_IDLD	0x01
+#define IE1_ABTD	0x02
+#define IE1_CDCD	0x04
+#define IE1_CCTS	0x08
+#define IE1_SYNCD	0x10
+#define IE1_CLMD	0x20
+#define IE1_IDL		0x40
+#define IE1_UDRN	0x80
+
+#define IE2_CRCE	0x04
+#define IE2_OVRN	0x08
+#define IE2_RBIT	0x10
+#define IE2_ABT		0x20
+#define IE2_SHRT	0x40
+#define IE2_EOM		0x80
+
+#define IE4_RDNR	0x01
+#define IE4_RDCR	0x02
+#define IE4_TDNR	0x04
+#define IE4_TDCR	0x08
+#define IE4_OCLM	0x20
+#define IE4_CFT		0x40
+#define IE4_CGPI	0x80
+
+#define FIE_CRCEF	0x04
+#define FIE_OVRNF	0x08
+#define FIE_RBIF	0x10
+#define FIE_ABTF	0x20
+#define FIE_SHRTF	0x40
+#define FIE_EOMF	0x80
+
+#define DSR_DWE		0x01
+#define DSR_DE		0x02
+#define DSR_REF		0x04
+#define DSR_UDRF	0x04
+#define DSR_COA		0x08
+#define DSR_COF		0x10
+#define DSR_BOF		0x20
+#define DSR_EOM		0x40
+#define DSR_EOT		0x80
+
+#define DIR_REF		0x04
+#define DIR_UDRF	0x04
+#define DIR_COA		0x08
+#define DIR_COF		0x10
+#define DIR_BOF		0x20
+#define DIR_EOM		0x40
+#define DIR_EOT		0x80
+
+#define DIR_REFE	0x04
+#define DIR_UDRFE	0x04
+#define DIR_COAE	0x08
+#define DIR_COFE	0x10
+#define DIR_BOFE	0x20
+#define DIR_EOME	0x40
+#define DIR_EOTE	0x80
+
+#define DMR_CNTE	0x02
+#define DMR_NF		0x04
+#define DMR_SEOME	0x08
+#define DMR_TMOD	0x10
+
+#define DMER_DME        0x80	/* DMA Master Enable */
+
+#define DCR_SW_ABT	0x01
+#define DCR_FCT_CLR	0x02
+
+#define DCR_ABORT	0x01
+#define DCR_CLEAR_EOF	0x02
+
+#define PCR_COTE	0x80
+#define PCR_PR0		0x01
+#define PCR_PR1		0x02
+#define PCR_PR2		0x04
+#define PCR_CCC		0x08
+#define PCR_BRC		0x10
+#define PCR_OSB		0x40
+#define PCR_BURST	0x80
+
+#endif /* (__HD64572_H) */
--- linux-2.4.orig/drivers/net/wan/pci200syn.c	2003-10-24 22:54:14.000000000 +0200
+++ linux-2.4/drivers/net/wan/pci200syn.c	2003-10-24 22:50:51.000000000 +0200
@@ -0,0 +1,456 @@
+/*
+ * Goramo PCI200SYN synchronous serial card driver for Linux
+ *
+ * Copyright (C) 2002-2003 Krzysztof Halasa <khc@pm.waw.pl>
+ *
+ * This program is free software; you can redistribute it and/or modify it
+ * under the terms of version 2 of the GNU General Public License
+ * as published by the Free Software Foundation.
+ *
+ * For information see http://hq.pm.waw.pl/hdlc/
+ *
+ * Sources of information:
+ *    Hitachi HD64572 SCA-II User's Manual
+ *    PLX Technology Inc. PCI9052 Data Book
+ */
+
+#include <linux/config.h>
+#include <linux/module.h>
+#include <linux/kernel.h>
+#include <linux/slab.h>
+#include <linux/sched.h>
+#include <linux/types.h>
+#include <linux/fcntl.h>
+#include <linux/in.h>
+#include <linux/string.h>
+#include <linux/errno.h>
+#include <linux/init.h>
+#include <linux/ioport.h>
+#include <linux/netdevice.h>
+#include <linux/hdlc.h>
+#include <linux/pci.h>
+#include <asm/delay.h>
+#include <asm/io.h>
+
+#include "hd64572.h"
+
+static const char* version = "Goramo PCI200SYN driver version: 1.14";
+static const char* devname = "PCI200SYN";
+
+#define	PCI200SYN_PLX_SIZE	0x80	/* PLX control window size (128b) */
+#define	PCI200SYN_SCA_SIZE	0x400	/* SCA window size (1Kb) */
+#define ALL_PAGES_ALWAYS_MAPPED
+#define NEED_DETECT_RAM
+#define MAX_TX_BUFFERS		10
+
+static int pci_clock_freq = 33000000;
+#define CLOCK_BASE pci_clock_freq
+
+#define PCI_VENDOR_ID_GORAMO	0x10B5	/* uses PLX:9050 ID - this card	*/
+#define PCI_DEVICE_ID_PCI200SYN	0x9050	/* doesn't have its own ID	*/
+
+
+/*
+ *      PLX PCI9052 local configuration and shared runtime registers.
+ *	This structure can be used to access 9052 registers (memory mapped).
+ */
+typedef struct {
+	u32 loc_addr_range[4];	/* 00-0Ch : Local Address Ranges */
+	u32 loc_rom_range;	/* 10h : Local ROM Range */
+	u32 loc_addr_base[4];	/* 14-20h : Local Address Base Addrs */
+	u32 loc_rom_base;	/* 24h : Local ROM Base */
+	u32 loc_bus_descr[4];	/* 28-34h : Local Bus Descriptors */
+	u32 rom_bus_descr;	/* 38h : ROM Bus Descriptor */
+	u32 cs_base[4];		/* 3C-48h : Chip Select Base Addrs */
+	u32 intr_ctrl_stat;	/* 4Ch : Interrupt Control/Status */
+	u32 init_ctrl;		/* 50h : EEPROM ctrl, Init Ctrl, etc */
+}plx9052;
+
+
+
+typedef struct port_s {
+	hdlc_device hdlc;	/* HDLC device struct - must be first */
+	struct card_s *card;
+	spinlock_t lock;	/* TX lock */
+	sync_serial_settings settings;
+	int rxpart;		/* partial frame received, next frame invalid*/
+	unsigned short encoding;
+	unsigned short parity;
+	u16 rxin;		/* rx ring buffer 'in' pointer */
+	u16 txin;		/* tx ring buffer 'in' and 'last' pointers */
+	u16 txlast;
+	u8 rxs, txs, tmc;	/* SCA registers */
+	u8 phy_node;		/* physical port # - 0 or 1 */
+}port_t;
+
+
+
+typedef struct card_s {
+	u32 ramphys;		/* buffer memory base (physical) */
+	u8* rambase;		/* buffer memory base (virtual) */
+	u32 ramsize;		/* buffer memory size */
+	u32 scaphys;		/* SCA memory base (physical) */
+	u8* scabase;		/* SCA memory base (virtual) */
+	u32 plxphys;		/* PLX registers memory base (physical) */
+	plx9052* plxbase;	/* PLX registers memory base (virtual) */
+	u16 rx_ring_buffers;	/* number of buffers in a ring */
+	u16 tx_ring_buffers;
+	u16 buff_offset;	/* offset of first buffer of first channel */
+	u8 irq;			/* interrupt request level */
+
+	port_t ports[2];
+}card_t;
+
+
+#define sca_in(reg, card)	     readb(card->scabase + (reg))
+#define sca_out(value, reg, card)    writeb(value, card->scabase + (reg))
+#define sca_inw(reg, card)	     readw(card->scabase + (reg))
+#define sca_outw(value, reg, card)   writew(value, card->scabase + (reg))
+#define sca_inl(reg, card)	     readl(card->scabase + (reg))
+#define sca_outl(value, reg, card)   writel(value, card->scabase + (reg))
+
+#define port_to_card(port)	     (port->card)
+#define log_node(port)		     (port->phy_node)
+#define phy_node(port)		     (port->phy_node)
+#define winbase(card)      	     (card->rambase)
+#define get_port(card, port)	     (&card->ports[port])
+#define sca_flush(card)		     (sca_in(IER0, card));
+
+static inline void new_memcpy_toio(char *dest, char *src, int length)
+{
+	int len;
+	do {
+		len = length > 256 ? 256 : length;
+		memcpy_toio(dest, src, len);
+		dest += len;
+		src += len;
+		length -= len;
+		readb(dest);
+	} while (len);
+}
+
+#undef memcpy_toio
+#define memcpy_toio new_memcpy_toio
+
+#include "hd6457x.c"
+
+
+static void pci200_set_iface(port_t *port)
+{
+	card_t *card = port->card;
+	u16 msci = get_msci(port);
+	u8 rxs = port->rxs & CLK_BRG_MASK;
+	u8 txs = port->txs & CLK_BRG_MASK;
+
+	sca_out(EXS_TES1, (phy_node(port) ? MSCI1_OFFSET : MSCI0_OFFSET) + EXS,
+		port_to_card(port));
+	switch(port->settings.clock_type) {
+	case CLOCK_INT:
+		rxs |= CLK_BRG; /* BRG output */
+		txs |= CLK_PIN_OUT | CLK_TX_RXCLK; /* RX clock */
+		break;
+
+	case CLOCK_TXINT:
+		rxs |= CLK_LINE; /* RXC input */
+		txs |= CLK_PIN_OUT | CLK_BRG; /* BRG output */
+		break;
+
+	case CLOCK_TXFROMRX:
+		rxs |= CLK_LINE; /* RXC input */
+		txs |= CLK_PIN_OUT | CLK_TX_RXCLK; /* RX clock */
+		break;
+
+	default:		/* EXTernal clock */
+		rxs |= CLK_LINE; /* RXC input */
+		txs |= CLK_PIN_OUT | CLK_LINE; /* TXC input */
+		break;
+	}
+
+	port->rxs = rxs;
+	port->txs = txs;
+	sca_out(rxs, msci + RXS, card);
+	sca_out(txs, msci + TXS, card);
+	sca_set_port(port);
+}
+
+
+
+static int pci200_open(struct net_device *dev)
+{
+	hdlc_device *hdlc = dev_to_hdlc(dev);
+	port_t *port = hdlc_to_port(hdlc);
+
+	int result = hdlc_open(hdlc);
+	if (result)
+		return result;
+
+	MOD_INC_USE_COUNT;
+	sca_open(hdlc);
+	pci200_set_iface(port);
+	sca_flush(port_to_card(port));
+	return 0;
+}
+
+
+
+static int pci200_close(struct net_device *dev)
+{
+	hdlc_device *hdlc = dev_to_hdlc(dev);
+	sca_close(hdlc);
+	sca_flush(port_to_card(dev_to_port(dev)));
+	hdlc_close(hdlc);
+	MOD_DEC_USE_COUNT;
+	return 0;
+}
+
+
+
+static int pci200_ioctl(struct net_device *dev, struct ifreq *ifr, int cmd)
+{
+	const size_t size = sizeof(sync_serial_settings);
+	sync_serial_settings new_line, *line = ifr->ifr_settings.ifs_ifsu.sync;
+	hdlc_device *hdlc = dev_to_hdlc(dev);
+	port_t *port = hdlc_to_port(hdlc);
+
+#ifdef CONFIG_HDLC_DEBUG_RINGS
+	if (cmd == SIOCDEVPRIVATE) {
+		sca_dump_rings(hdlc);
+		return 0;
+	}
+#endif
+	if (cmd != SIOCWANDEV)
+		return hdlc_ioctl(dev, ifr, cmd);
+
+	switch(ifr->ifr_settings.type) {
+	case IF_GET_IFACE:
+		ifr->ifr_settings.type = IF_IFACE_V35;
+		if (ifr->ifr_settings.size < size) {
+			ifr->ifr_settings.size = size; /* data size wanted */
+			return -ENOBUFS;
+		}
+		if (copy_to_user(line, &port->settings, size))
+			return -EFAULT;
+		return 0;
+
+	case IF_IFACE_V35:
+	case IF_IFACE_SYNC_SERIAL:
+		if (!capable(CAP_NET_ADMIN))
+			return -EPERM;
+
+		if (copy_from_user(&new_line, line, size))
+			return -EFAULT;
+
+		if (new_line.clock_type != CLOCK_EXT &&
+		    new_line.clock_type != CLOCK_TXFROMRX &&
+		    new_line.clock_type != CLOCK_INT &&
+		    new_line.clock_type != CLOCK_TXINT)
+		return -EINVAL;	/* No such clock setting */
+
+		if (new_line.loopback != 0 && new_line.loopback != 1)
+			return -EINVAL;
+
+		memcpy(&port->settings, &new_line, size); /* Update settings */
+		pci200_set_iface(port);
+		sca_flush(port_to_card(port));
+		return 0;
+
+	default:
+		return hdlc_ioctl(dev, ifr, cmd);
+	}
+}
+
+
+
+static void pci200_pci_remove_one(struct pci_dev *pdev)
+{
+	int i;
+        card_t *card = pci_get_drvdata(pdev);
+
+	for(i = 0; i < 2; i++)
+		if (card->ports[i].card)
+			unregister_hdlc_device(&card->ports[i].hdlc);
+
+	if (card->irq)
+		free_irq(card->irq, card);
+	iounmap(card->rambase);
+	iounmap(card->scabase);
+	iounmap(card->plxbase);
+        pci_release_regions(pdev);
+	kfree(card);
+}
+
+
+
+static int __devinit pci200_pci_init_one(struct pci_dev *pdev,
+					 const struct pci_device_id *ent)
+{
+	card_t *card;
+	u8 rev_id;
+	u32 *p;
+	int i;
+
+#ifndef MODULE
+        static int printed_version;
+        if (!printed_version++)
+                printk(KERN_INFO "%s\n", version);
+#endif
+
+	i = pci_enable_device(pdev);
+	if (i)
+		return i;
+
+        i = pci_request_regions(pdev, "PCI200SYN");
+	if (i)
+                return i;
+
+	card = kmalloc(sizeof(card_t), GFP_KERNEL);
+	if (card == NULL) {
+		printk(KERN_ERR "pci200syn: unable to allocate memory\n");
+		return -ENOBUFS;
+	}
+	memset(card, 0, sizeof(card_t));
+	pci_set_drvdata(pdev, card);
+
+	pci_read_config_byte(pdev, PCI_REVISION_ID, &rev_id);
+	if (pci_resource_len(pdev, 0) != PCI200SYN_PLX_SIZE ||
+	    pci_resource_len(pdev, 2) != PCI200SYN_SCA_SIZE ||
+	    pci_resource_len(pdev, 3) < 16384) {
+		printk(KERN_ERR "pci200syn: invalid card EEPROM parameters\n");
+		kfree(card);
+		return -EFAULT;
+	}
+
+	card->plxphys = pci_resource_start(pdev,0) & PCI_BASE_ADDRESS_MEM_MASK;
+	card->plxbase = ioremap(card->plxphys, PCI200SYN_PLX_SIZE);
+
+	card->scaphys = pci_resource_start(pdev,2) & PCI_BASE_ADDRESS_MEM_MASK;
+	card->scabase = ioremap(card->scaphys, PCI200SYN_SCA_SIZE);
+
+	card->ramphys = pci_resource_start(pdev,3) & PCI_BASE_ADDRESS_MEM_MASK;
+	card->rambase = ioremap(card->ramphys, pci_resource_len(pdev,3));
+
+	/* Reset PLX */
+	p = &card->plxbase->init_ctrl;
+	writel(readl(p) | 0x40000000, p);
+	readl(p);		/* Flush the write - do not use sca_flush */
+	udelay(1);
+
+	writel(readl(p) & ~0x40000000, p);
+	readl(p);		/* Flush the write - do not use sca_flush */
+	udelay(1);
+
+	card->ramsize = sca_detect_ram(card, card->rambase,
+				       pci_resource_len(pdev,3));
+
+	/* number of TX + RX buffers for one port - this is dual port card */
+	i = card->ramsize / (2 * (sizeof(pkt_desc) + HDLC_MAX_MRU));
+	card->tx_ring_buffers = min(i / 2, MAX_TX_BUFFERS);
+	card->rx_ring_buffers = i - card->tx_ring_buffers;
+
+	card->buff_offset = 2 * sizeof(pkt_desc) * (card->tx_ring_buffers +
+						    card->rx_ring_buffers);
+
+	printk(KERN_INFO "pci200syn: %u KB RAM at 0x%x, IRQ%u, using %u TX +"
+	       " %u RX packets rings\n", card->ramsize / 1024,
+	       card->ramphys, pdev->irq,
+	       card->tx_ring_buffers, card->rx_ring_buffers);
+
+	if (card->tx_ring_buffers < 1) {
+		printk(KERN_ERR "pci200syn: RAM test failed\n");
+		pci200_pci_remove_one(pdev);
+		return -EFAULT;
+	}
+
+	/* Enable interrupts on the PCI bridge */
+	p = &card->plxbase->intr_ctrl_stat;
+	writew(readw(p) | 0x0040, p);
+
+	/* Allocate IRQ */
+	if(request_irq(pdev->irq, sca_intr, SA_SHIRQ, devname, card)) {
+		printk(KERN_WARNING "pci200syn: could not allocate IRQ%d.\n",
+		       pdev->irq);
+		pci200_pci_remove_one(pdev);
+		return -EBUSY;
+	}
+	card->irq = pdev->irq;
+
+	sca_init(card, 0);
+
+	for(i = 0; i < 2; i++) {
+		port_t *port = &card->ports[i];
+		struct net_device *dev = hdlc_to_dev(&port->hdlc);
+		port->phy_node = i;
+
+		spin_lock_init(&port->lock);
+		dev->irq = card->irq;
+		dev->mem_start = card->ramphys;
+		dev->mem_end = card->ramphys + card->ramsize - 1;
+		dev->tx_queue_len = 50;
+		dev->do_ioctl = pci200_ioctl;
+		dev->open = pci200_open;
+		dev->stop = pci200_close;
+		port->hdlc.attach = sca_attach;
+		port->hdlc.xmit = sca_xmit;
+		port->settings.clock_type = CLOCK_EXT;
+		if(register_hdlc_device(&port->hdlc)) {
+			printk(KERN_ERR "pci200syn: unable to register hdlc "
+			       "device\n");
+			pci200_pci_remove_one(pdev);
+			return -ENOBUFS;
+		}
+		port->card = card;
+		sca_init_sync_port(port);	/* Set up SCA memory */
+
+		printk(KERN_INFO "%s: PCI200SYN node %d\n",
+		       hdlc_to_name(&port->hdlc), port->phy_node);
+	}
+
+	sca_flush(card);
+	return 0;
+}
+
+
+
+static struct pci_device_id pci200_pci_tbl[] __devinitdata = {
+        { PCI_VENDOR_ID_GORAMO, PCI_DEVICE_ID_PCI200SYN, PCI_ANY_ID,
+	  PCI_ANY_ID, 0, 0, 0 },
+        { 0, }
+};
+
+
+static struct pci_driver pci200_pci_driver = {
+        name:           "PCI200SYN",
+        id_table:       pci200_pci_tbl,
+        probe:          pci200_pci_init_one,
+        remove:         pci200_pci_remove_one,
+};
+
+
+static int __init pci200_init_module(void)
+{
+#ifdef MODULE
+        printk(KERN_INFO "%s\n", version);
+#endif
+	if (pci_clock_freq < 1000000 || pci_clock_freq > 80000000) {
+		printk(KERN_ERR "pci200syn: Invalid PCI clock frequency\n");
+		return -EINVAL;
+	}
+	return pci_module_init(&pci200_pci_driver);
+}
+
+
+
+static void __exit pci200_cleanup_module(void)
+{
+	pci_unregister_driver(&pci200_pci_driver);
+}
+
+MODULE_AUTHOR("Krzysztof Halasa <khc@pm.waw.pl>");
+MODULE_DESCRIPTION("Goramo PCI200SYN serial port driver");
+MODULE_LICENSE("GPL v2");
+MODULE_DEVICE_TABLE(pci, pci200_pci_tbl);
+MODULE_PARM(pci_clock_freq, "i");
+MODULE_PARM_DESC(pci_clock_freq, "System PCI clock frequency in Hz");
+EXPORT_NO_SYMBOLS;
+module_init(pci200_init_module);
+module_exit(pci200_cleanup_module);
--- linux-2.4.orig/Documentation/Configure.help	2003-10-24 22:49:50.000000000 +0200
+++ linux-2.4/Documentation/Configure.help	2003-10-24 22:52:26.000000000 +0200
@@ -11310,6 +11310,18 @@
 
   If unsure, say N here.
 
+CONFIG_PCI200SYN
+  This driver is for PCI200SYN cards made by Goramo sp. j.
+  If you have such a card, say Y or M here and see
+  <http://hq.pm.waw.pl/pub/hdlc/>
+
+  If you want to compile the driver as a module ( = code which can be
+  inserted in and removed from the running kernel whenever you want),
+  say M here and read <file:Documentation/modules.txt>.  The module
+  will be called pci200syn.o.
+
+  If unsure, say N here.
+
 SDL RISCom/N2 support
 CONFIG_N2
   This driver is for RISCom/N2 single or dual channel ISA cards
--- linux-2.4.orig/drivers/net/wan/Config.in	2003-10-24 22:49:52.000000000 +0200
+++ linux-2.4/drivers/net/wan/Config.in	2003-10-24 22:53:07.000000000 +0200
@@ -77,6 +77,7 @@
       else
 	 comment '    X.25/LAPB support is disabled'
       fi
+      dep_tristate '    Goramo PCI200SYN support' CONFIG_PCI200SYN $CONFIG_HDLC
       dep_tristate '    SDL RISCom/N2 support' CONFIG_N2 $CONFIG_HDLC
       dep_tristate '    Moxa C101 support' CONFIG_C101 $CONFIG_HDLC
       dep_tristate '    FarSync T-Series support' CONFIG_FARSYNC $CONFIG_HDLC

--=-=-=--
