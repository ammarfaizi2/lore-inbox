Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1422677AbWAMNzQ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422677AbWAMNzQ (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 13 Jan 2006 08:55:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1422680AbWAMNzQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 13 Jan 2006 08:55:16 -0500
Received: from emailhub.stusta.mhn.de ([141.84.69.5]:54026 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S1422677AbWAMNzM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 13 Jan 2006 08:55:12 -0500
Date: Fri, 13 Jan 2006 14:55:11 +0100
From: Adrian Bunk <bunk@stusta.de>
To: linux-kernel@vger.kernel.org
Cc: macro@linux-mips.org, rmk+serial@arm.linux.org.uk,
       linux-serial@vger.kernel.org, tony.luck@intel.com,
       linux-ia64@vger.kernel.org
Subject: [RFC: 2.6 patch] kill _INLINE_
Message-ID: <20060113135511.GJ29663@stusta.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This patch removes all occurances of _INLINE_ in the kernel.

With the exception of tty_flip.h, I've simply removed the inline's since 
gcc should know best which functions to be inlined.


Signed-off-by: Adrian Bunk <bunk@stusta.de>

---

 arch/ia64/hp/sim/simserial.c       |    7 --
 arch/xtensa/platform-iss/console.c |    4 -
 drivers/char/amiserial.c           |   18 ++-----
 drivers/isdn/hisax/config.c        |    1 
 drivers/isdn/hisax/elsa.c          |    1 
 drivers/serial/68328serial.c       |    9 +--
 drivers/serial/au1x00_uart.c       |   11 ++--
 drivers/serial/crisv10.c           |   68 +++++++++--------------------
 drivers/serial/m32r_sio.c          |   15 ++----
 drivers/serial/sunsu.c             |   13 ++---
 drivers/tc/zs.c                    |    9 +--
 include/linux/tty_flip.h           |   12 +----
 12 files changed, 56 insertions(+), 112 deletions(-)

--- linux-2.6.15-mm3-full/include/linux/tty_flip.h.old	2006-01-13 12:48:30.000000000 +0100
+++ linux-2.6.15-mm3-full/include/linux/tty_flip.h	2006-01-13 12:49:17.000000000 +0100
@@ -7,14 +7,8 @@
 extern int tty_prepare_flip_string(struct tty_struct *tty, unsigned char **chars, size_t size);
 extern int tty_prepare_flip_string_flags(struct tty_struct *tty, unsigned char **chars, char **flags, size_t size);
 
-#ifdef INCLUDE_INLINE_FUNCS
-#define _INLINE_ extern
-#else
-#define _INLINE_ static __inline__
-#endif
-
-_INLINE_ int tty_insert_flip_char(struct tty_struct *tty,
-				   unsigned char ch, char flag)
+static inline int tty_insert_flip_char(struct tty_struct *tty,
+				       unsigned char ch, char flag)
 {
 	struct tty_buffer *tb = tty->buf.tail;
 	if (tb && tb->used < tb->size) {
@@ -25,7 +19,7 @@
 	return tty_insert_flip_string_flags(tty, &ch, &flag, 1);
 }
 
-_INLINE_ void tty_schedule_flip(struct tty_struct *tty)
+static inline void tty_schedule_flip(struct tty_struct *tty)
 {
 	schedule_delayed_work(&tty->buf.work, 1);
 }
--- linux-2.6.15-mm3-full/drivers/isdn/hisax/config.c.old	2006-01-13 12:49:28.000000000 +0100
+++ linux-2.6.15-mm3-full/drivers/isdn/hisax/config.c	2006-01-13 12:49:40.000000000 +0100
@@ -25,7 +25,6 @@
 #include <linux/workqueue.h>
 #include <linux/interrupt.h>
 #define HISAX_STATUS_BUFSIZE 4096
-#define INCLUDE_INLINE_FUNCS
 
 /*
  * This structure array contains one entry per card. An entry looks
--- linux-2.6.15-mm3-full/arch/ia64/hp/sim/simserial.c.old	2006-01-13 12:49:57.000000000 +0100
+++ linux-2.6.15-mm3-full/arch/ia64/hp/sim/simserial.c	2006-01-13 12:50:52.000000000 +0100
@@ -46,11 +46,6 @@
 #define KEYBOARD_INTR	3	/* must match with simulator! */
 
 #define NR_PORTS	1	/* only one port for now */
-#define SERIAL_INLINE	1
-
-#ifdef SERIAL_INLINE
-#define _INLINE_ inline
-#endif
 
 #define IRQ_T(info) ((info->flags & ASYNC_SHARE_IRQ) ? SA_SHIRQ : SA_INTERRUPT)
 
@@ -244,7 +239,7 @@
 	local_irq_restore(flags);
 }
 
-static _INLINE_ void transmit_chars(struct async_struct *info, int *intr_done)
+static void transmit_chars(struct async_struct *info, int *intr_done)
 {
 	int count;
 	unsigned long flags;
--- linux-2.6.15-mm3-full/arch/xtensa/platform-iss/console.c.old	2006-01-13 12:52:10.000000000 +0100
+++ linux-2.6.15-mm3-full/arch/xtensa/platform-iss/console.c	2006-01-13 12:52:20.000000000 +0100
@@ -31,10 +31,6 @@
 #include <linux/tty.h>
 #include <linux/tty_flip.h>
 
-#ifdef SERIAL_INLINE
-#define _INLINE_ inline
-#endif
-
 #define SERIAL_MAX_NUM_LINES 1
 #define SERIAL_TIMER_VALUE (20 * HZ)
 
--- linux-2.6.15-mm3-full/drivers/char/amiserial.c.old	2006-01-13 12:52:31.000000000 +0100
+++ linux-2.6.15-mm3-full/drivers/char/amiserial.c	2006-01-13 12:53:40.000000000 +0100
@@ -46,8 +46,6 @@
 
 /* Sanity checks */
 
-#define SERIAL_INLINE
-  
 #if defined(MODULE) && defined(SERIAL_DEBUG_MCOUNT)
 #define DBG_CNT(s) printk("(%s): [%x] refc=%d, serc=%d, ttyc=%d -> %s\n", \
  tty->name, (info->flags), serial_driver->refcount,info->count,tty->count,s)
@@ -95,10 +93,6 @@
 #include <asm/amigahw.h>
 #include <asm/amigaints.h>
 
-#ifdef SERIAL_INLINE
-#define _INLINE_ inline
-#endif
-
 #define custom amiga_custom
 static char *serial_name = "Amiga-builtin serial driver";
 
@@ -254,14 +248,14 @@
  * This routine is used by the interrupt handler to schedule
  * processing in the software interrupt portion of the driver.
  */
-static _INLINE_ void rs_sched_event(struct async_struct *info,
-				  int event)
+static void rs_sched_event(struct async_struct *info,
+			   int event)
 {
 	info->event |= 1 << event;
 	tasklet_schedule(&info->tlet);
 }
 
-static _INLINE_ void receive_chars(struct async_struct *info)
+static void receive_chars(struct async_struct *info)
 {
         int status;
 	int serdatr;
@@ -350,7 +344,7 @@
 	return;
 }
 
-static _INLINE_ void transmit_chars(struct async_struct *info)
+static void transmit_chars(struct async_struct *info)
 {
 	custom.intreq = IF_TBE;
 	mb();
@@ -390,7 +384,7 @@
 	}
 }
 
-static _INLINE_ void check_modem_status(struct async_struct *info)
+static void check_modem_status(struct async_struct *info)
 {
 	unsigned char status = ciab.pra & (SER_DCD | SER_CTS | SER_DSR);
 	unsigned char dstatus;
@@ -1960,7 +1954,7 @@
  * number, and identifies which options were configured into this
  * driver.
  */
-static _INLINE_ void show_serial_version(void)
+static void show_serial_version(void)
 {
  	printk(KERN_INFO "%s version %s\n", serial_name, serial_version);
 }
--- linux-2.6.15-mm3-full/drivers/isdn/hisax/elsa.c.old	2006-01-13 12:54:11.000000000 +0100
+++ linux-2.6.15-mm3-full/drivers/isdn/hisax/elsa.c	2006-01-13 12:54:19.000000000 +0100
@@ -108,7 +108,6 @@
 #define ELSA_ASSIGN      4
 
 #define RS_ISR_PASS_LIMIT 256
-#define _INLINE_ inline
 #define FLG_MODEM_ACTIVE 1
 /* IPAC AUX */
 #define ELSA_IPAC_LINE_LED	0x40	/* Bit 6 Gelbe LED */
--- linux-2.6.15-mm3-full/drivers/serial/68328serial.c.old	2006-01-13 12:54:29.000000000 +0100
+++ linux-2.6.15-mm3-full/drivers/serial/68328serial.c	2006-01-13 12:55:02.000000000 +0100
@@ -101,8 +101,6 @@
 
 #define RS_ISR_PASS_LIMIT 256
 
-#define _INLINE_ inline
-
 static void change_speed(struct m68k_serial *info);
 
 /*
@@ -263,7 +261,7 @@
 	/* Drop into the debugger */
 }
 
-static _INLINE_ void status_handle(struct m68k_serial *info, unsigned short status)
+static void status_handle(struct m68k_serial *info, unsigned short status)
 {
 #if 0
 	if(status & DCD) {
@@ -290,7 +288,8 @@
 	return;
 }
 
-static _INLINE_ void receive_chars(struct m68k_serial *info, struct pt_regs *regs, unsigned short rx)
+static void receive_chars(struct m68k_serial *info, struct pt_regs *regs,
+			  unsigned short rx)
 {
 	struct tty_struct *tty = info->tty;
 	m68328_uart *uart = &uart_addr[info->line];
@@ -360,7 +359,7 @@
 	return;
 }
 
-static _INLINE_ void transmit_chars(struct m68k_serial *info)
+static void transmit_chars(struct m68k_serial *info)
 {
 	m68328_uart *uart = &uart_addr[info->line];
 
--- linux-2.6.15-mm3-full/drivers/serial/au1x00_uart.c.old	2006-01-13 12:55:14.000000000 +0100
+++ linux-2.6.15-mm3-full/drivers/serial/au1x00_uart.c	2006-01-13 12:55:41.000000000 +0100
@@ -133,13 +133,12 @@
 	{ "AU1X00_UART",16,	UART_CLEAR_FIFO | UART_USE_FIFO },
 };
 
-static _INLINE_ unsigned int serial_in(struct uart_8250_port *up, int offset)
+static unsigned int serial_in(struct uart_8250_port *up, int offset)
 {
 	return au_readl((unsigned long)up->port.membase + offset);
 }
 
-static _INLINE_ void
-serial_out(struct uart_8250_port *up, int offset, int value)
+static void serial_out(struct uart_8250_port *up, int offset, int value)
 {
 	au_writel(value, (unsigned long)up->port.membase + offset);
 }
@@ -237,7 +236,7 @@
 	serial_out(up, UART_IER, up->ier);
 }
 
-static _INLINE_ void
+static void
 receive_chars(struct uart_8250_port *up, int *status, struct pt_regs *regs)
 {
 	struct tty_struct *tty = up->port.info->tty;
@@ -312,7 +311,7 @@
 	spin_lock(&up->port.lock);
 }
 
-static _INLINE_ void transmit_chars(struct uart_8250_port *up)
+static void transmit_chars(struct uart_8250_port *up)
 {
 	struct circ_buf *xmit = &up->port.info->xmit;
 	int count;
@@ -346,7 +345,7 @@
 		serial8250_stop_tx(&up->port);
 }
 
-static _INLINE_ void check_modem_status(struct uart_8250_port *up)
+static void check_modem_status(struct uart_8250_port *up)
 {
 	int status;
 
--- linux-2.6.15-mm3-full/drivers/serial/crisv10.c.old	2006-01-13 12:55:52.000000000 +0100
+++ linux-2.6.15-mm3-full/drivers/serial/crisv10.c	2006-01-13 13:03:38.000000000 +0100
@@ -480,8 +480,6 @@
 #include "serial_compat.h"
 #endif
 
-#define _INLINE_ inline
-
 struct tty_driver *serial_driver;
 
 /* serial subtype definitions */
@@ -590,8 +588,6 @@
 static void rs_wait_until_sent(struct tty_struct *tty, int timeout);
 static int rs_write(struct tty_struct * tty, int from_user,
                     const unsigned char *buf, int count);
-extern _INLINE_ int rs_raw_write(struct tty_struct * tty, int from_user,
-                            const unsigned char *buf, int count);
 #ifdef CONFIG_ETRAX_RS485
 static int e100_write_rs485(struct tty_struct * tty, int from_user,
                             const unsigned char *buf, int count);
@@ -1541,8 +1537,7 @@
 
 /* the tx DMA uses only dma_descr interrupt */
 
-static _INLINE_ void
-e100_disable_txdma_irq(struct e100_serial *info)
+static void e100_disable_txdma_irq(struct e100_serial *info)
 {
 #ifdef SERIAL_DEBUG_INTR
 	printk("txdma_irq(%d): 0\n",info->line);
@@ -1551,8 +1546,7 @@
 	*R_IRQ_MASK2_CLR = info->irq;
 }
 
-static _INLINE_ void
-e100_enable_txdma_irq(struct e100_serial *info)
+static void e100_enable_txdma_irq(struct e100_serial *info)
 {
 #ifdef SERIAL_DEBUG_INTR
 	printk("txdma_irq(%d): 1\n",info->line);
@@ -1561,8 +1555,7 @@
 	*R_IRQ_MASK2_SET = info->irq;
 }
 
-static _INLINE_ void
-e100_disable_txdma_channel(struct e100_serial *info)
+static void e100_disable_txdma_channel(struct e100_serial *info)
 {
 	unsigned long flags;
 
@@ -1602,8 +1595,7 @@
 }
 
 
-static _INLINE_ void
-e100_enable_txdma_channel(struct e100_serial *info)
+static void e100_enable_txdma_channel(struct e100_serial *info)
 {
 	unsigned long flags;
 
@@ -1628,8 +1620,7 @@
 	restore_flags(flags);
 }
 
-static _INLINE_ void
-e100_disable_rxdma_channel(struct e100_serial *info)
+static void e100_disable_rxdma_channel(struct e100_serial *info)
 {
 	unsigned long flags;
 
@@ -1668,8 +1659,7 @@
 }
 
 
-static _INLINE_ void
-e100_enable_rxdma_channel(struct e100_serial *info)
+static void e100_enable_rxdma_channel(struct e100_serial *info)
 {
 	unsigned long flags;
 
@@ -1916,9 +1906,7 @@
  * This routine is used by the interrupt handler to schedule
  * processing in the software interrupt portion of the driver.
  */
-static _INLINE_ void
-rs_sched_event(struct e100_serial *info,
-				    int event)
+static void rs_sched_event(struct e100_serial *info, int event)
 {
 	if (info->event & (1 << event))
 		return;
@@ -2158,8 +2146,9 @@
 	return 1;
 }
 
-extern _INLINE_ unsigned int
-handle_descr_data(struct e100_serial *info, struct etrax_dma_descr *descr, unsigned int recvl)
+static unsigned int handle_descr_data(struct e100_serial *info,
+				      struct etrax_dma_descr *descr,
+				      unsigned int recvl)
 {
 	struct etrax_recv_buffer *buffer = phys_to_virt(descr->buf) - sizeof *buffer;
 
@@ -2185,8 +2174,7 @@
 	return recvl;
 }
 
-static _INLINE_ unsigned int
-handle_all_descr_data(struct e100_serial *info)
+static unsigned int handle_all_descr_data(struct e100_serial *info)
 {
 	struct etrax_dma_descr *descr;
 	unsigned int recvl;
@@ -2233,8 +2221,7 @@
 	return ret;
 }
 
-static _INLINE_ void
-receive_chars_dma(struct e100_serial *info)
+static void receive_chars_dma(struct e100_serial *info)
 {
 	struct tty_struct *tty;
 	unsigned char rstat;
@@ -2295,8 +2282,7 @@
 	*info->icmdadr = IO_STATE(R_DMA_CH6_CMD, cmd, restart);
 }
 
-static _INLINE_ int
-start_recv_dma(struct e100_serial *info)
+static int start_recv_dma(struct e100_serial *info)
 {
 	struct etrax_dma_descr *descr = info->rec_descr;
 	struct etrax_recv_buffer *buffer;
@@ -2351,11 +2337,6 @@
 }
 
 
-static _INLINE_ void
-status_handle(struct e100_serial *info, unsigned short status)
-{
-}
-
 /* the bits in the MASK2 register are laid out like this:
    DMAI_EOP DMAI_DESCR DMAO_EOP DMAO_DESCR
    where I is the input channel and O is the output channel for the port.
@@ -2457,8 +2438,7 @@
 	return IRQ_RETVAL(handled);
 } /* rec_interrupt */
 
-static _INLINE_ int
-force_eop_if_needed(struct e100_serial *info)
+static int force_eop_if_needed(struct e100_serial *info)
 {
 	/* We check data_avail bit to determine if data has
 	 * arrived since last time
@@ -2502,8 +2482,7 @@
 	return 1;
 }
 
-extern _INLINE_ void
-flush_to_flip_buffer(struct e100_serial *info)
+static void flush_to_flip_buffer(struct e100_serial *info)
 {
 	struct tty_struct *tty;
 	struct etrax_recv_buffer *buffer;
@@ -2614,8 +2593,7 @@
 	tty_flip_buffer_push(tty);
 }
 
-static _INLINE_ void
-check_flush_timeout(struct e100_serial *info)
+static void check_flush_timeout(struct e100_serial *info)
 {
 	/* Flip what we've got (if we can) */
 	flush_to_flip_buffer(info);
@@ -2744,7 +2722,7 @@
 
 */
 
-extern _INLINE_
+static
 struct e100_serial * handle_ser_rx_interrupt_no_dma(struct e100_serial *info)
 {
 	unsigned long data_read;
@@ -2878,8 +2856,7 @@
 	return info;
 }
 
-extern _INLINE_
-struct e100_serial* handle_ser_rx_interrupt(struct e100_serial *info)
+static struct e100_serial* handle_ser_rx_interrupt(struct e100_serial *info)
 {
 	unsigned char rstat;
 
@@ -2998,7 +2975,7 @@
 	return info;
 } /* handle_ser_rx_interrupt */
 
-extern _INLINE_ void handle_ser_tx_interrupt(struct e100_serial *info)
+static void handle_ser_tx_interrupt(struct e100_serial *info)
 {
 	unsigned long flags;
 
@@ -3624,9 +3601,8 @@
 	restore_flags(flags);
 }
 
-extern _INLINE_ int
-rs_raw_write(struct tty_struct * tty, int from_user,
-	  const unsigned char *buf, int count)
+static int rs_raw_write(struct tty_struct * tty, int from_user,
+			const unsigned char *buf, int count)
 {
 	int	c, ret = 0;
 	struct e100_serial *info = (struct e100_serial *)tty->driver_data;
@@ -4713,7 +4689,7 @@
  * /proc fs routines....
  */
 
-extern _INLINE_ int line_info(char *buf, struct e100_serial *info)
+static int line_info(char *buf, struct e100_serial *info)
 {
 	char	stat_buf[30];
 	int	ret;
--- linux-2.6.15-mm3-full/drivers/serial/m32r_sio.c.old	2006-01-13 13:03:55.000000000 +0100
+++ linux-2.6.15-mm3-full/drivers/serial/m32r_sio.c	2006-01-13 13:04:26.000000000 +0100
@@ -248,17 +248,17 @@
 
 #endif /* CONFIG_SERIAL_M32R_PLDSIO */
 
-static _INLINE_ unsigned int sio_in(struct uart_sio_port *up, int offset)
+static unsigned int sio_in(struct uart_sio_port *up, int offset)
 {
 	return __sio_in(up->port.iobase + offset);
 }
 
-static _INLINE_ void sio_out(struct uart_sio_port *up, int offset, int value)
+static void sio_out(struct uart_sio_port *up, int offset, int value)
 {
 	__sio_out(value, up->port.iobase + offset);
 }
 
-static _INLINE_ unsigned int serial_in(struct uart_sio_port *up, int offset)
+static unsigned int serial_in(struct uart_sio_port *up, int offset)
 {
 	if (!offset)
 		return 0;
@@ -266,8 +266,7 @@
 	return __sio_in(offset);
 }
 
-static _INLINE_ void
-serial_out(struct uart_sio_port *up, int offset, int value)
+static void serial_out(struct uart_sio_port *up, int offset, int value)
 {
 	if (!offset)
 		return;
@@ -326,8 +325,8 @@
 	serial_out(up, UART_IER, up->ier);
 }
 
-static _INLINE_ void receive_chars(struct uart_sio_port *up, int *status,
-	struct pt_regs *regs)
+static void receive_chars(struct uart_sio_port *up, int *status,
+			  struct pt_regs *regs)
 {
 	struct tty_struct *tty = up->port.info->tty;
 	unsigned char ch;
@@ -400,7 +399,7 @@
 	tty_flip_buffer_push(tty);
 }
 
-static _INLINE_ void transmit_chars(struct uart_sio_port *up)
+static void transmit_chars(struct uart_sio_port *up)
 {
 	struct circ_buf *xmit = &up->port.info->xmit;
 	int count;
--- linux-2.6.15-mm3-full/drivers/serial/sunsu.c.old	2006-01-13 13:04:35.000000000 +0100
+++ linux-2.6.15-mm3-full/drivers/serial/sunsu.c	2006-01-13 13:05:04.000000000 +0100
@@ -102,9 +102,7 @@
 #endif
 };
 
-#define _INLINE_
-
-static _INLINE_ unsigned int serial_in(struct uart_sunsu_port *up, int offset)
+static unsigned int serial_in(struct uart_sunsu_port *up, int offset)
 {
 	offset <<= up->port.regshift;
 
@@ -121,8 +119,7 @@
 	}
 }
 
-static _INLINE_ void
-serial_out(struct uart_sunsu_port *up, int offset, int value)
+static void serial_out(struct uart_sunsu_port *up, int offset, int value)
 {
 #ifndef CONFIG_SPARC64
 	/*
@@ -319,7 +316,7 @@
 	spin_unlock_irqrestore(&up->port.lock, flags);
 }
 
-static _INLINE_ struct tty_struct *
+static struct tty_struct *
 receive_chars(struct uart_sunsu_port *up, unsigned char *status, struct pt_regs *regs)
 {
 	struct tty_struct *tty = up->port.info->tty;
@@ -398,7 +395,7 @@
 	return tty;
 }
 
-static _INLINE_ void transmit_chars(struct uart_sunsu_port *up)
+static void transmit_chars(struct uart_sunsu_port *up)
 {
 	struct circ_buf *xmit = &up->port.info->xmit;
 	int count;
@@ -434,7 +431,7 @@
 		__stop_tx(up);
 }
 
-static _INLINE_ void check_modem_status(struct uart_sunsu_port *up)
+static void check_modem_status(struct uart_sunsu_port *up)
 {
 	int status;
 
--- linux-2.6.15-mm3-full/drivers/tc/zs.c.old	2006-01-13 13:05:13.000000000 +0100
+++ linux-2.6.15-mm3-full/drivers/tc/zs.c	2006-01-13 13:05:35.000000000 +0100
@@ -186,8 +186,6 @@
 #define RS_STROBE_TIME 10
 #define RS_ISR_PASS_LIMIT 256
 
-#define _INLINE_ inline
-
 static void probe_sccs(void);
 static void change_speed(struct dec_serial *info);
 static void rs_wait_until_sent(struct tty_struct *tty, int timeout);
@@ -344,14 +342,13 @@
  * This routine is used by the interrupt handler to schedule
  * processing in the software interrupt portion of the driver.
  */
-static _INLINE_ void rs_sched_event(struct dec_serial *info, int event)
+static void rs_sched_event(struct dec_serial *info, int event)
 {
 	info->event |= 1 << event;
 	tasklet_schedule(&info->tlet);
 }
 
-static _INLINE_ void receive_chars(struct dec_serial *info,
-				   struct pt_regs *regs)
+static void receive_chars(struct dec_serial *info, struct pt_regs *regs)
 {
 	struct tty_struct *tty = info->tty;
 	unsigned char ch, stat, flag;
@@ -441,7 +438,7 @@
 		rs_sched_event(info, RS_EVENT_WRITE_WAKEUP);
 }
 
-static _INLINE_ void status_handle(struct dec_serial *info)
+static void status_handle(struct dec_serial *info)
 {
 	unsigned char stat;
 

