Return-Path: <linux-kernel-owner+willy=40w.ods.org-S270217AbUJSXmR@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S270217AbUJSXmR (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 19 Oct 2004 19:42:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S270115AbUJSXl2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 19 Oct 2004 19:41:28 -0400
Received: from caramon.arm.linux.org.uk ([212.18.232.186]:53519 "EHLO
	caramon.arm.linux.org.uk") by vger.kernel.org with ESMTP
	id S270061AbUJSWrX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 19 Oct 2004 18:47:23 -0400
Date: Tue, 19 Oct 2004 23:47:16 +0100
From: Russell King <rmk+lkml@arm.linux.org.uk>
To: Linux Kernel List <linux-kernel@vger.kernel.org>
Subject: [PATCH] Fix serial breakage in -bk3
Message-ID: <20041019234716.D20243@flint.arm.linux.org.uk>
Mail-Followup-To: Linux Kernel List <linux-kernel@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Sorry guys, I goofed by completely missing this file out of one of the
changesets.  Here's a patch which fixes it.

(I'll send this separately to Linus and akpm.)

--- orig/include/linux/serial_reg.h	Sun Apr 18 18:45:26 2004
+++ linux/include/linux/serial_reg.h	Mon Jun 28 18:32:58 2004
@@ -14,47 +14,63 @@
 #ifndef _LINUX_SERIAL_REG_H
 #define _LINUX_SERIAL_REG_H
 
-#define UART_RX		0	/* In:  Receive buffer (DLAB=0) */
-#define UART_TX		0	/* Out: Transmit buffer (DLAB=0) */
-#define UART_DLL	0	/* Out: Divisor Latch Low (DLAB=1) */
-#define UART_TRG	0	/* (LCR=BF) FCTR bit 7 selects Rx or Tx
-				 * In: Fifo count
-				 * Out: Fifo custom trigger levels
-				 * XR16C85x only */
+/*
+ * DLAB=0
+ */
+#define UART_RX		0	/* In:  Receive buffer */
+#define UART_TX		0	/* Out: Transmit buffer */
 
-#define UART_DLM	1	/* Out: Divisor Latch High (DLAB=1) */
 #define UART_IER	1	/* Out: Interrupt Enable Register */
-#define UART_FCTR	1	/* (LCR=BF) Feature Control Register
-				 * XR16C85x only */
+#define UART_IER_MSI		0x08 /* Enable Modem status interrupt */
+#define UART_IER_RLSI		0x04 /* Enable receiver line status interrupt */
+#define UART_IER_THRI		0x02 /* Enable Transmitter holding register int. */
+#define UART_IER_RDI		0x01 /* Enable receiver data interrupt */
+/*
+ * Sleep mode for ST16650 and TI16750.  For the ST16650, EFR[4]=1
+ */
+#define UART_IERX_SLEEP		0x10 /* Enable sleep mode */
 
 #define UART_IIR	2	/* In:  Interrupt ID Register */
-#define UART_FCR	2	/* Out: FIFO Control Register */
-#define UART_EFR	2	/* I/O: Extended Features Register */
-				/* (DLAB=1, 16C660 only) */
+#define UART_IIR_NO_INT		0x01 /* No interrupts pending */
+#define UART_IIR_ID		0x06 /* Mask for the interrupt ID */
+#define UART_IIR_MSI		0x00 /* Modem status interrupt */
+#define UART_IIR_THRI		0x02 /* Transmitter holding register empty */
+#define UART_IIR_RDI		0x04 /* Receiver data interrupt */
+#define UART_IIR_RLSI		0x06 /* Receiver line status interrupt */
 
-#define UART_LCR	3	/* Out: Line Control Register */
-#define UART_MCR	4	/* Out: Modem Control Register */
-#define UART_LSR	5	/* In:  Line Status Register */
-#define UART_MSR	6	/* In:  Modem Status Register */
-#define UART_SCR	7	/* I/O: Scratch Register */
-#define UART_EMSR	7	/* (LCR=BF) Extended Mode Select Register 
-				 * FCTR bit 6 selects SCR or EMSR
-				 * XR16c85x only */
-
-/*
- * These are the definitions for the FIFO Control Register
- * (16650 only)
- */
+#define UART_FCR	2	/* Out: FIFO Control Register */
 #define UART_FCR_ENABLE_FIFO	0x01 /* Enable the FIFO */
 #define UART_FCR_CLEAR_RCVR	0x02 /* Clear the RCVR FIFO */
 #define UART_FCR_CLEAR_XMIT	0x04 /* Clear the XMIT FIFO */
 #define UART_FCR_DMA_SELECT	0x08 /* For DMA applications */
+/*
+ * Note: The FIFO trigger levels are chip specific:
+ *	RX:76 = 00  01  10  11	TX:54 = 00  01  10  11
+ * PC16550D:	 1   4   8  14		xx  xx  xx  xx
+ * TI16C550A:	 1   4   8  14          xx  xx  xx  xx
+ * TI16C550C:	 1   4   8  14          xx  xx  xx  xx
+ * ST16C550:	 1   4   8  14		xx  xx  xx  xx
+ * ST16C650:	 8  16  24  28		16   8  24  30	PORT_16650V2
+ * NS16C552:	 1   4   8  14		xx  xx  xx  xx
+ * ST16C654:	 8  16  56  60		 8  16  32  56	PORT_16654
+ * TI16C750:	 1  16  32  56		xx  xx  xx  xx	PORT_16750
+ * TI16C752:	 8  16  56  60		 8  16  32  56
+ */
+#define UART_FCR_R_TRIG_00	0x00
+#define UART_FCR_R_TRIG_01	0x40
+#define UART_FCR_R_TRIG_10	0x80
+#define UART_FCR_R_TRIG_11	0xc0
+#define UART_FCR_T_TRIG_00	0x00
+#define UART_FCR_T_TRIG_01	0x10
+#define UART_FCR_T_TRIG_10	0x20
+#define UART_FCR_T_TRIG_11	0x30
+
 #define UART_FCR_TRIGGER_MASK	0xC0 /* Mask for the FIFO trigger range */
 #define UART_FCR_TRIGGER_1	0x00 /* Mask for trigger set at 1 */
 #define UART_FCR_TRIGGER_4	0x40 /* Mask for trigger set at 4 */
 #define UART_FCR_TRIGGER_8	0x80 /* Mask for trigger set at 8 */
 #define UART_FCR_TRIGGER_14	0xC0 /* Mask for trigger set at 14 */
-/* 16650 redefinitions */
+/* 16650 definitions */
 #define UART_FCR6_R_TRIGGER_8	0x00 /* Mask for receive trigger set at 1 */
 #define UART_FCR6_R_TRIGGER_16	0x40 /* Mask for receive trigger set at 4 */
 #define UART_FCR6_R_TRIGGER_24  0x80 /* Mask for receive trigger set at 8 */
@@ -63,83 +79,129 @@
 #define UART_FCR6_T_TRIGGER_8	0x10 /* Mask for transmit trigger set at 8 */
 #define UART_FCR6_T_TRIGGER_24  0x20 /* Mask for transmit trigger set at 24 */
 #define UART_FCR6_T_TRIGGER_30	0x30 /* Mask for transmit trigger set at 30 */
-/* TI 16750 definitions */
-#define UART_FCR7_64BYTE	0x20 /* Go into 64 byte mode */
+#define UART_FCR7_64BYTE	0x20 /* Go into 64 byte mode (TI16C750) */
 
+#define UART_LCR	3	/* Out: Line Control Register */
 /*
- * These are the definitions for the Line Control Register
- * 
  * Note: if the word length is 5 bits (UART_LCR_WLEN5), then setting 
  * UART_LCR_STOP will select 1.5 stop bits, not 2 stop bits.
  */
-#define UART_LCR_DLAB	0x80	/* Divisor latch access bit */
-#define UART_LCR_SBC	0x40	/* Set break control */
-#define UART_LCR_SPAR	0x20	/* Stick parity (?) */
-#define UART_LCR_EPAR	0x10	/* Even parity select */
-#define UART_LCR_PARITY	0x08	/* Parity Enable */
-#define UART_LCR_STOP	0x04	/* Stop bits: 0=1 stop bit, 1= 2 stop bits */
-#define UART_LCR_WLEN5  0x00	/* Wordlength: 5 bits */
-#define UART_LCR_WLEN6  0x01	/* Wordlength: 6 bits */
-#define UART_LCR_WLEN7  0x02	/* Wordlength: 7 bits */
-#define UART_LCR_WLEN8  0x03	/* Wordlength: 8 bits */
+#define UART_LCR_DLAB		0x80 /* Divisor latch access bit */
+#define UART_LCR_SBC		0x40 /* Set break control */
+#define UART_LCR_SPAR		0x20 /* Stick parity (?) */
+#define UART_LCR_EPAR		0x10 /* Even parity select */
+#define UART_LCR_PARITY		0x08 /* Parity Enable */
+#define UART_LCR_STOP		0x04 /* Stop bits: 0=1 bit, 1=2 bits */
+#define UART_LCR_WLEN5		0x00 /* Wordlength: 5 bits */
+#define UART_LCR_WLEN6		0x01 /* Wordlength: 6 bits */
+#define UART_LCR_WLEN7		0x02 /* Wordlength: 7 bits */
+#define UART_LCR_WLEN8		0x03 /* Wordlength: 8 bits */
+
+#define UART_MCR	4	/* Out: Modem Control Register */
+#define UART_MCR_CLKSEL		0x80 /* Divide clock by 4 (TI16C752, EFR[4]=1) */
+#define UART_MCR_TCRTLR		0x40 /* Access TCR/TLR (TI16C752, EFR[4]=1) */
+#define UART_MCR_XONANY		0x20 /* Enable Xon Any (TI16C752, EFR[4]=1) */
+#define UART_MCR_AFE		0x20 /* Enable auto-RTS/CTS (TI16C550C/TI16C750) */
+#define UART_MCR_LOOP		0x10 /* Enable loopback test mode */
+#define UART_MCR_OUT2		0x08 /* Out2 complement */
+#define UART_MCR_OUT1		0x04 /* Out1 complement */
+#define UART_MCR_RTS		0x02 /* RTS complement */
+#define UART_MCR_DTR		0x01 /* DTR complement */
+
+#define UART_LSR	5	/* In:  Line Status Register */
+#define UART_LSR_TEMT		0x40 /* Transmitter empty */
+#define UART_LSR_THRE		0x20 /* Transmit-hold-register empty */
+#define UART_LSR_BI		0x10 /* Break interrupt indicator */
+#define UART_LSR_FE		0x08 /* Frame error indicator */
+#define UART_LSR_PE		0x04 /* Parity error indicator */
+#define UART_LSR_OE		0x02 /* Overrun error indicator */
+#define UART_LSR_DR		0x01 /* Receiver data ready */
+
+#define UART_MSR	6	/* In:  Modem Status Register */
+#define UART_MSR_DCD		0x80 /* Data Carrier Detect */
+#define UART_MSR_RI		0x40 /* Ring Indicator */
+#define UART_MSR_DSR		0x20 /* Data Set Ready */
+#define UART_MSR_CTS		0x10 /* Clear to Send */
+#define UART_MSR_DDCD		0x08 /* Delta DCD */
+#define UART_MSR_TERI		0x04 /* Trailing edge ring indicator */
+#define UART_MSR_DDSR		0x02 /* Delta DSR */
+#define UART_MSR_DCTS		0x01 /* Delta CTS */
+#define UART_MSR_ANY_DELTA	0x0F /* Any of the delta bits! */
+
+#define UART_SCR	7	/* I/O: Scratch Register */
 
 /*
- * These are the definitions for the Line Status Register
+ * DLAB=1
  */
-#define UART_LSR_TEMT	0x40	/* Transmitter empty */
-#define UART_LSR_THRE	0x20	/* Transmit-hold-register empty */
-#define UART_LSR_BI	0x10	/* Break interrupt indicator */
-#define UART_LSR_FE	0x08	/* Frame error indicator */
-#define UART_LSR_PE	0x04	/* Parity error indicator */
-#define UART_LSR_OE	0x02	/* Overrun error indicator */
-#define UART_LSR_DR	0x01	/* Receiver data ready */
+#define UART_DLL	0	/* Out: Divisor Latch Low */
+#define UART_DLM	1	/* Out: Divisor Latch High */
 
 /*
- * These are the definitions for the Interrupt Identification Register
+ * LCR=0xBF (or DLAB=1 for 16C660)
+ */
+#define UART_EFR	2	/* I/O: Extended Features Register */
+#define UART_EFR_CTS		0x80 /* CTS flow control */
+#define UART_EFR_RTS		0x40 /* RTS flow control */
+#define UART_EFR_SCD		0x20 /* Special character detect */
+#define UART_EFR_ECB		0x10 /* Enhanced control bit */
+/*
+ * the low four bits control software flow control
  */
-#define UART_IIR_NO_INT	0x01	/* No interrupts pending */
-#define UART_IIR_ID	0x06	/* Mask for the interrupt ID */
-
-#define UART_IIR_MSI	0x00	/* Modem status interrupt */
-#define UART_IIR_THRI	0x02	/* Transmitter holding register empty */
-#define UART_IIR_RDI	0x04	/* Receiver data interrupt */
-#define UART_IIR_RLSI	0x06	/* Receiver line status interrupt */
 
 /*
- * These are the definitions for the Interrupt Enable Register
+ * LCR=0xBF, TI16C752, ST16650, ST16650A, ST16654
  */
-#define UART_IER_MSI	0x08	/* Enable Modem status interrupt */
-#define UART_IER_RLSI	0x04	/* Enable receiver line status interrupt */
-#define UART_IER_THRI	0x02	/* Enable Transmitter holding register int. */
-#define UART_IER_RDI	0x01	/* Enable receiver data interrupt */
+#define UART_XON1	4	/* I/O: Xon character 1 */
+#define UART_XON2	5	/* I/O: Xon character 2 */
+#define UART_XOFF1	6	/* I/O: Xoff character 1 */
+#define UART_XOFF2	7	/* I/O: Xoff character 2 */
+
 /*
- * Sleep mode for ST16650 and TI16750.
- * Note that for 16650, EFR-bit 4 must be selected as well.
+ * EFR[4]=1 MCR[6]=1, TI16C752
  */
-#define UART_IERX_SLEEP  0x10	/* Enable sleep mode */
+#define UART_TI752_TCR	6	/* I/O: transmission control register */
+#define UART_TI752_TLR	7	/* I/O: trigger level register */
 
 /*
- * These are the definitions for the Modem Control Register
+ * LCR=0xBF, XR16C85x
  */
-#define UART_MCR_AFE	0x20	/* Enable auto-RTS/CTS (TI16C750) */
-#define UART_MCR_LOOP	0x10	/* Enable loopback test mode */
-#define UART_MCR_OUT2	0x08	/* Out2 complement */
-#define UART_MCR_OUT1	0x04	/* Out1 complement */
-#define UART_MCR_RTS	0x02	/* RTS complement */
-#define UART_MCR_DTR	0x01	/* DTR complement */
+#define UART_TRG	0	/* FCTR bit 7 selects Rx or Tx
+				 * In: Fifo count
+				 * Out: Fifo custom trigger levels */
+/*
+ * These are the definitions for the Programmable Trigger Register
+ */
+#define UART_TRG_1		0x01
+#define UART_TRG_4		0x04
+#define UART_TRG_8		0x08
+#define UART_TRG_16		0x10
+#define UART_TRG_32		0x20
+#define UART_TRG_64		0x40
+#define UART_TRG_96		0x60
+#define UART_TRG_120		0x78
+#define UART_TRG_128		0x80
+
+#define UART_FCTR	1	/* Feature Control Register */
+#define UART_FCTR_RTS_NODELAY	0x00  /* RTS flow control delay */
+#define UART_FCTR_RTS_4DELAY	0x01
+#define UART_FCTR_RTS_6DELAY	0x02
+#define UART_FCTR_RTS_8DELAY	0x03
+#define UART_FCTR_IRDA		0x04  /* IrDa data encode select */
+#define UART_FCTR_TX_INT	0x08  /* Tx interrupt type select */
+#define UART_FCTR_TRGA		0x00  /* Tx/Rx 550 trigger table select */
+#define UART_FCTR_TRGB		0x10  /* Tx/Rx 650 trigger table select */
+#define UART_FCTR_TRGC		0x20  /* Tx/Rx 654 trigger table select */
+#define UART_FCTR_TRGD		0x30  /* Tx/Rx 850 programmable trigger select */
+#define UART_FCTR_SCR_SWAP	0x40  /* Scratch pad register swap */
+#define UART_FCTR_RX		0x00  /* Programmable trigger mode select */
+#define UART_FCTR_TX		0x80  /* Programmable trigger mode select */
 
 /*
- * These are the definitions for the Modem Status Register
+ * LCR=0xBF, FCTR[6]=1
  */
-#define UART_MSR_DCD	0x80	/* Data Carrier Detect */
-#define UART_MSR_RI	0x40	/* Ring Indicator */
-#define UART_MSR_DSR	0x20	/* Data Set Ready */
-#define UART_MSR_CTS	0x10	/* Clear to Send */
-#define UART_MSR_DDCD	0x08	/* Delta DCD */
-#define UART_MSR_TERI	0x04	/* Trailing edge ring indicator */
-#define UART_MSR_DDSR	0x02	/* Delta DSR */
-#define UART_MSR_DCTS	0x01	/* Delta CTS */
-#define UART_MSR_ANY_DELTA 0x0F	/* Any of the delta bits! */
+#define UART_EMSR	7	/* Extended Mode Select Register */
+#define UART_EMSR_FIFO_COUNT	0x01  /* Rx/Tx select */
+#define UART_EMSR_ALT_COUNT	0x02  /* Alternating count select */
 
 /*
  * The Intel XScale on-chip UARTs define these bits
@@ -156,17 +218,8 @@
 #define UART_FCR_PXAR16	0x80	/* receive FIFO treshold = 16 */
 #define UART_FCR_PXAR32	0xc0	/* receive FIFO treshold = 32 */
 
-/*
- * These are the definitions for the Extended Features Register
- * (StarTech 16C660 only, when DLAB=1)
- */
-#define UART_EFR_CTS	0x80	/* CTS flow control */
-#define UART_EFR_RTS	0x40	/* RTS flow control */
-#define UART_EFR_SCD	0x20	/* Special character detect */
-#define UART_EFR_ECB	0x10	/* Enhanced control bit */
-/*
- * the low four bits control software flow control
- */
+
+
 
 /*
  * These register definitions are for the 16C950
@@ -203,47 +256,7 @@
 #define UART_ACR_ICRRD	0x40	/* ICR Read enable */
 #define UART_ACR_ASREN	0x80	/* Additional status enable */
 
-/*
- * These are the definitions for the Feature Control Register
- * (XR16C85x only, when LCR=bf; doubles with the Interrupt Enable
- * Register, UART register #1)
- */
-#define UART_FCTR_RTS_NODELAY	0x00  /* RTS flow control delay */
-#define UART_FCTR_RTS_4DELAY	0x01
-#define UART_FCTR_RTS_6DELAY	0x02
-#define UART_FCTR_RTS_8DELAY	0x03
-#define UART_FCTR_IRDA	0x04  /* IrDa data encode select */
-#define UART_FCTR_TX_INT	0x08  /* Tx interrupt type select */
-#define UART_FCTR_TRGA	0x00  /* Tx/Rx 550 trigger table select */
-#define UART_FCTR_TRGB	0x10  /* Tx/Rx 650 trigger table select */
-#define UART_FCTR_TRGC	0x20  /* Tx/Rx 654 trigger table select */
-#define UART_FCTR_TRGD	0x30  /* Tx/Rx 850 programmable trigger select */
-#define UART_FCTR_SCR_SWAP	0x40  /* Scratch pad register swap */
-#define UART_FCTR_RX	0x00  /* Programmable trigger mode select */
-#define UART_FCTR_TX	0x80  /* Programmable trigger mode select */
-
-/*
- * These are the definitions for the Enhanced Mode Select Register
- * (XR16C85x only, when LCR=bf and FCTR bit 6=1; doubles with the
- * Scratch register, UART register #7)
- */
-#define UART_EMSR_FIFO_COUNT	0x01  /* Rx/Tx select */
-#define UART_EMSR_ALT_COUNT	0x02  /* Alternating count select */
 
-/*
- * These are the definitions for the Programmable Trigger
- * Register (XR16C85x only, when LCR=bf; doubles with the UART RX/TX
- * register, UART register #0)
- */
-#define UART_TRG_1	0x01
-#define UART_TRG_4	0x04
-#define UART_TRG_8	0x08
-#define UART_TRG_16	0x10
-#define UART_TRG_32	0x20
-#define UART_TRG_64	0x40
-#define UART_TRG_96	0x60
-#define UART_TRG_120	0x78
-#define UART_TRG_128	0x80
 
 /*
  * These definitions are for the RSA-DV II/S card, from

-- 
Russell King
 Linux kernel    2.6 ARM Linux   - http://www.arm.linux.org.uk/
 maintainer of:  2.6 PCMCIA      - http://pcmcia.arm.linux.org.uk/
                 2.6 Serial core
