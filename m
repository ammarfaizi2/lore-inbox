Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261556AbVCIPxQ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261556AbVCIPxQ (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 9 Mar 2005 10:53:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261624AbVCIPxQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 9 Mar 2005 10:53:16 -0500
Received: from e2.ny.us.ibm.com ([32.97.182.142]:38376 "EHLO e2.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S261556AbVCIPuO (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 9 Mar 2005 10:50:14 -0500
Message-ID: <422F1B2C.6070405@us.ltcfwd.linux.ibm.com>
Date: Wed, 09 Mar 2005 10:50:04 -0500
From: Wen Xiong <wendyx@us.ibm.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.2.1) Gecko/20030225
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Greg KH <greg@kroah.com>
CC: Wen Xiong <wendyx@us.ibm.com>, linux-kernel@vger.kernel.org
Subject: Re: [ patch 6/7] drivers/serial/jsm: new serial device driver
References: <42225A64.6070904@us.ltcfwd.linux.ibm.com> <20050228065534.GC23595@kroah.com> <4228CE5C.9010207@us.ltcfwd.linux.ibm.com> <20050305064445.GA8447@kroah.com> <422CDA58.5000506@us.ltcfwd.linux.ibm.com> <20050308064211.GE17022@kroah.com> <422DF217.8070401@us.ltcfwd.linux.ibm.com> <20050309060450.GA17560@kroah.com>
In-Reply-To: <20050309060450.GA17560@kroah.com>
Content-Type: multipart/mixed;
 boundary="------------070407070101000802070808"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------070407070101000802070808
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit

Greg KH wrote:

>On Tue, Mar 08, 2005 at 01:42:31PM -0500, Wen Xiong wrote:
>  
>
>>The following email I got from Scott Kilau in digi:
>>Scott Kilau wrote:
>>
>>       The DPA program is very old, and is shared among other drivers 
>>and OS's,
>>       so changing the code to read the sysfs instead of doing ioctls 
>>is not possible.
>>    
>>
>
>Hm, so we are supposed to support, for forever, custom ioctls just
>because another OS, that we care nothing about, supports it?  Hm, I just
>can't think this is a acceptable thing, sorry.  Especially due to the
>nasty 64/32 bit issues...
>
>  
>
>>       However, any *new* tools I write, will use sysfs, which is why 
>>we need to have both the ioctl calls and sysfs files.
>>    
>>
>
>Please, no new ioctls, end of story.
>
>  
>
>>       The digi.h file has extra structures and ioctls that may not be 
>>used in the driver, as that header
>>       is shared among other drivers and OS's.
>>    
>>
>
>Please remove them as they are not needed in this OS, right?  As you
>already had to change the naming, structure definitions, and format, you
>aren't sharing the file.
>  
>
Removed the all things are not needed(digi.h) in this OS.
Attached the new patch6.jasmine for your reviewing.

Thanks,
wendy

--------------070407070101000802070808
Content-Type: text/plain;
 name="patch6.jasmine"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="patch6.jasmine"

diff -Nuar linux-2.6.11.org/drivers/serial/jsm/jsm_driver.h linux-2.6.11.new/drivers/serial/jsm/jsm_driver.h
--- linux-2.6.11.org/drivers/serial/jsm/jsm_driver.h	1969-12-31 18:00:00.000000000 -0600
+++ linux-2.6.11.new/drivers/serial/jsm/jsm_driver.h	2005-03-09 09:43:11.995943064 -0600
@@ -0,0 +1,518 @@
+/************************************************************************
+ * Copyright 2003 Digi International (www.digi.com)
+ *
+ * Copyright (C) 2004 IBM Corporation. All rights reserved.
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License as published by
+ * the Free Software Foundation; either version 2, or (at your option)
+ * any later version.
+ * 
+ * This program is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY, EXPRESS OR IMPLIED; without even the 
+ * implied warranty of MERCHANTABILITY or FITNESS FOR A PARTICULAR 
+ * PURPOSE.  See the GNU General Public License for more details.
+ * 
+ * You should have received a copy of the GNU General Public License 
+ * along with this program; if not, write to the Free Software 
+ * Foundation, Inc., 59 * Temple Place - Suite 330, Boston,
+ * MA  02111-1307, USA.
+ *
+ * Contact Information:
+ * Scott H Kilau <Scott_Kilau@digi.com>
+ * Wendy Xiong   <wendyx@us.ltcfwd.linux.ibm.com>
+ *
+ ***********************************************************************/
+#ifndef __JSM_DRIVER_H
+#define __JSM_DRIVER_H
+
+#include <linux/kernel.h>
+#include <linux/version.h>
+#include <linux/types.h>	/* To pick up the varions Linux types */
+#include <linux/tty.h>
+#include <linux/serial_core.h>
+#include <linux/device.h>
+#include <linux/ioctl.h>
+
+/*
+ * Debugging levels can be set using debug insmod variable
+ * They can also be compiled out completely.
+ */
+enum {
+	DBG_INIT	= 0x01,
+	DBG_BASIC	= 0x02,
+	DBG_CORE	= 0x04,
+	DBG_OPEN	= 0x08,
+	DBG_CLOSE	= 0x10,
+	DBG_READ	= 0x20,
+	DBG_WRITE	= 0x40,
+	DBG_IOCTL	= 0x80,
+	DBG_PROC	= 0x100,
+	DBG_PARAM	= 0x200,
+	DBG_PSCAN	= 0x400,
+	DBG_EVENT	= 0x800,
+	DBG_DRAIN	= 0x1000,
+	DBG_MSIGS	= 0x2000,
+	DBG_MGMT	= 0x4000,
+	DBG_INTR	= 0x8000,
+	DBG_CARR	= 0x10000,
+};
+
+#define jsm_printk(nlevel, klevel, pdev, fmt, args...) \
+	if ((DBG_##nlevel & jsm_debug))  		\
+	dev_printk(KERN_##klevel, pdev->dev, fmt, ## args)
+
+#define MAXPORTS	8
+#define MAX_STOPS_SENT	5
+
+/* Board type definitions */
+
+#define T_NEO           0000
+#define T_CLASSIC       0001
+#define T_PCIBUS        0400
+
+/* Board State Definitions */
+
+#define BD_RUNNING      0x0
+#define BD_REASON       0x7f
+#define BD_NOTFOUND     0x1
+#define BD_NOIOPORT     0x2
+#define BD_NOMEM        0x3
+#define BD_NOBIOS       0x4
+#define BD_NOFEP        0x5
+#define BD_FAILED       0x6
+#define BD_ALLOCATED    0x7
+#define BD_TRIBOOT      0x8
+#define BD_BADKME       0x80
+
+/* 4 extra for alignment play space */
+#define WRITEBUFLEN	((4096) + 4)
+#define MYFLIPLEN	N_TTY_BUF_SIZE
+
+#define JSM_VERSION	"jsm: 1.1-1-INKERNEL"
+#define JSM_PARTNUM	"40002438_A-INKERNEL"
+
+/*
+ * All the possible states the driver can be while being loaded.
+ */
+enum {
+	DRIVER_INITIALIZED = 0,
+	DRIVER_READY
+};
+
+/*
+ * All the possible states the board can be while booting up.
+ */
+enum {
+	BOARD_FAILED = 0,
+	BOARD_FOUND,
+	BOARD_READY
+};
+
+struct board_id {
+	u8 *name;
+	u32 maxports;
+};
+
+struct jsm_board;
+struct jsm_channel;
+
+/************************************************************************
+ * Per board operations structure					*
+ ************************************************************************/
+struct board_ops {
+	irqreturn_t (*intr) (int irq, void *voidbrd, struct pt_regs *regs);
+	void (*uart_init) (struct jsm_channel *ch);
+	void (*uart_off) (struct jsm_channel *ch);
+	void (*param) (struct jsm_channel *ch);
+	void (*assert_modem_signals) (struct jsm_channel *ch);
+	void (*flush_uart_write) (struct jsm_channel *ch);
+	void (*flush_uart_read) (struct jsm_channel *ch);
+	void (*disable_receiver) (struct jsm_channel *ch);
+	void (*enable_receiver) (struct jsm_channel *ch);
+	void (*send_break) (struct jsm_channel *ch);
+	void (*clear_break) (struct jsm_channel *ch, int);
+	void (*send_start_character) (struct jsm_channel *ch);
+	void (*send_stop_character) (struct jsm_channel *ch);
+	void (*copy_data_from_queue_to_uart) (struct jsm_channel *ch);
+	u32 (*get_uart_bytes_left) (struct jsm_channel *ch);
+	void (*send_immediate_char) (struct jsm_channel *ch, unsigned char);
+};
+
+/*
+ *	Per-board information
+ */
+struct jsm_board
+{
+	int		boardnum;	/* Board number: 0-32 */
+
+	int		type;		/* Type of board */
+	char		*name;		/* Product Name */
+	u8		rev;		/* PCI revision ID */
+	struct pci_dev	*pci_dev;
+	u32		maxports;	/* MAX ports this board can handle */
+
+	spinlock_t	bd_lock;	/* Used to protect board */
+
+	spinlock_t	bd_intr_lock;	/* Used to protect the poller tasklet and
+					 * the interrupt routine from each other.
+					 */
+
+	u32		state;		/* State of card. */
+	wait_queue_head_t state_wait;	/* Place to sleep on for state change */
+
+	u32		nasync;		/* Number of ports on card */
+
+	u32		irq;		/* Interrupt request number */
+	u64		intr_count;	/* Count of interrupts */
+
+	u64		membase;	/* Start of base memory of the card */
+	u64		membase_end;	/* End of base memory of the card */
+
+	u8		*re_map_membase;/* Remapped memory of the card */
+
+	u64		iobase;		/* Start of io base of the card */
+	u64		iobase_end;	/* End of io base of the card */
+
+	u32		bd_uart_offset;	/* Space between each UART */
+
+	struct jsm_channel *channels[MAXPORTS]; /* array of pointers to our channels. */
+
+	u32		jsm_major_serial_registered;
+	u32		jsm_serial_major;
+
+	char		*flipbuf;	/* Our flip buffer, alloced if board is found */
+
+	u16		dpatype;	/* The board "type", as defined by DPA */
+	u16		dpastatus;	/* The board "status", as defined by DPA */
+
+	u32		bd_dividend;	/* Board/UARTs specific dividend */
+
+	struct board_ops *bd_ops;
+
+	struct list_head jsm_board_entry;
+};
+
+/************************************************************************ 
+ * Device flag definitions for ch_flags.
+ ************************************************************************/
+#define CH_PRON		0x0001		/* Printer on string		*/
+#define CH_STOP		0x0002		/* Output is stopped		*/
+#define CH_STOPI	0x0004		/* Input is stopped		*/
+#define CH_CD		0x0008		/* Carrier is present		*/
+#define CH_FCAR		0x0010		/* Carrier forced on		*/
+#define CH_HANGUP	0x0020		/* Hangup received		*/
+
+#define CH_RECEIVER_OFF	0x0040		/* Receiver is off		*/
+#define CH_OPENING	0x0080		/* Port in fragile open state	*/
+#define CH_CLOSING	0x0100		/* Port in fragile close state	*/
+#define CH_FIFO_ENABLED 0x0200		/* Port has FIFOs enabled	*/
+#define CH_TX_FIFO_EMPTY 0x0400		/* TX Fifo is completely empty	*/
+#define CH_TX_FIFO_LWM	0x0800		/* TX Fifo is below Low Water	*/
+#define CH_BREAK_SENDING 0x1000		/* Break is being sent		*/
+#define CH_LOOPBACK 0x2000		/* Channel is in lookback mode	*/
+#define CH_FLIPBUF_IN_USE 0x4000	/* Channel's flipbuf is in use	*/
+#define CH_BAUD0	0x08000		/* Used for checking B0 transitions */
+
+/* Our Read/Error/Write queue sizes */
+#define RQUEUEMASK	0x1FFF		/* 8 K - 1 */
+#define EQUEUEMASK	0x1FFF		/* 8 K - 1 */
+#define WQUEUEMASK	0x0FFF		/* 4 K - 1 */
+#define RQUEUESIZE	(RQUEUEMASK + 1)
+#define EQUEUESIZE	RQUEUESIZE
+#define WQUEUESIZE	(WQUEUEMASK + 1)
+
+
+/************************************************************************ 
+ * Channel information structure.
+ ************************************************************************/
+struct jsm_channel {
+	struct uart_port uart_port;
+	struct jsm_board	*ch_bd;		/* Board structure pointer	*/
+
+	spinlock_t	ch_lock;	/* provide for serialization */
+	wait_queue_head_t ch_flags_wait;
+
+	u32		ch_portnum;	/* Port number, 0 offset.	*/
+	u32		ch_open_count;	/* open count			*/
+	u32		ch_flags;	/* Channel flags		*/
+
+	u64		ch_close_delay;	/* How long we should drop RTS/DTR for */
+
+	u64		ch_cpstime;	/* Time for CPS calculations	*/
+
+	tcflag_t	ch_c_iflag;	/* channel iflags		*/
+	tcflag_t	ch_c_cflag;	/* channel cflags		*/
+	tcflag_t	ch_c_oflag;	/* channel oflags		*/
+	tcflag_t	ch_c_lflag;	/* channel lflags		*/
+	u8		ch_stopc;	/* Stop character		*/
+	u8		ch_startc;	/* Start character		*/
+
+	u32		ch_old_baud;	/* Cache of the current baud */
+	u32		ch_custom_speed;/* Custom baud, if set */
+
+	u32		ch_wopen;	/* Waiting for open process cnt */
+
+	u8		ch_mostat;	/* FEP output modem status	*/
+	u8		ch_mistat;	/* FEP input modem status	*/
+
+	struct neo_uart_struct *ch_neo_uart;	/* Pointer to the "mapped" UART struct */
+	u8		ch_cached_lsr;	/* Cached value of the LSR register */
+
+	u8		*ch_rqueue;	/* Our read queue buffer - malloc'ed */
+	u16		ch_r_head;	/* Head location of the read queue */
+	u16		ch_r_tail;	/* Tail location of the read queue */
+
+	u8		*ch_equeue;	/* Our error queue buffer - malloc'ed */
+	u16		ch_e_head;	/* Head location of the error queue */
+	u16		ch_e_tail;	/* Tail location of the error queue */
+
+	u8		*ch_wqueue;	/* Our write queue buffer - malloc'ed */
+	u16		ch_w_head;	/* Head location of the write queue */
+	u16		ch_w_tail;	/* Tail location of the write queue */
+
+	u64		ch_rxcount;	/* total of data received so far */
+	u64		ch_txcount;	/* total of data transmitted so far */
+
+	u8		ch_r_tlevel;	/* Receive Trigger level */
+	u8		ch_t_tlevel;	/* Transmit Trigger level */
+
+	u8		ch_r_watermark;	/* Receive Watermark */
+
+
+	u32		ch_stops_sent;	/* How many times I have sent a stop character
+					 * to try to stop the other guy sending.
+					 */
+	u64		ch_err_parity;	/* Count of parity errors on channel */
+	u64		ch_err_frame;	/* Count of framing errors on channel */
+	u64		ch_err_break;	/* Count of breaks on channel */
+	u64		ch_err_overrun; /* Count of overruns on channel */
+
+	u64		ch_xon_sends;	/* Count of xons transmitted */
+	u64		ch_xoff_sends;	/* Count of xoffs transmitted */
+};
+
+/************************************************************************ 
+ * Per channel/port NEO UART structure					*
+ ************************************************************************
+ *		Base Structure Entries Usage Meanings to Host		*
+ *									*
+ *	W = read write		R = read only				* 
+ *			U = Unused.					*
+ ************************************************************************/
+
+struct neo_uart_struct {
+	 u8 txrx;		/* WR	RHR/THR - Holding Reg */
+	 u8 ier;		/* WR	IER - Interrupt Enable Reg */
+	 u8 isr_fcr;		/* WR	ISR/FCR - Interrupt Status Reg/Fifo Control Reg */
+	 u8 lcr;		/* WR	LCR - Line Control Reg */
+	 u8 mcr;		/* WR	MCR - Modem Control Reg */
+	 u8 lsr;		/* WR	LSR - Line Status Reg */
+	 u8 msr;		/* WR	MSR - Modem Status Reg */
+	 u8 spr;		/* WR	SPR - Scratch Pad Reg */
+	 u8 fctr;		/* WR	FCTR - Feature Control Reg */
+	 u8 efr;		/* WR	EFR - Enhanced Function Reg */
+	 u8 tfifo;		/* WR	TXCNT/TXTRG - Transmit FIFO Reg */	
+	 u8 rfifo;		/* WR	RXCNT/RXTRG - Recieve FIFO Reg */
+	 u8 xoffchar1;		/* WR	XOFF 1 - XOff Character 1 Reg */
+	 u8 xoffchar2;		/* WR	XOFF 2 - XOff Character 2 Reg */
+	 u8 xonchar1;		/* WR	XON 1 - Xon Character 1 Reg */
+	 u8 xonchar2;		/* WR	XON 2 - XOn Character 2 Reg */
+
+	 u8 reserved1[0x2ff - 0x200]; /* U	Reserved by Exar */
+	 u8 txrxburst[64];	/* RW	64 bytes of RX/TX FIFO Data */
+	 u8 reserved2[0x37f - 0x340]; /* U	Reserved by Exar */
+	 u8 rxburst_with_errors[64];	/* R	64 bytes of RX FIFO Data + LSR */
+};
+
+/* Where to read the extended interrupt register (32bits instead of 8bits) */
+#define	UART_17158_POLL_ADDR_OFFSET	0x80
+
+/*
+ * These are the redefinitions for the FCTR on the XR17C158, since
+ * Exar made them different than their earlier design. (XR16C854)
+ */
+
+/* These are only applicable when table D is selected */
+#define UART_17158_FCTR_RTS_NODELAY	0x00
+#define UART_17158_FCTR_RTS_4DELAY	0x01
+#define UART_17158_FCTR_RTS_6DELAY	0x02
+#define UART_17158_FCTR_RTS_8DELAY	0x03
+#define UART_17158_FCTR_RTS_12DELAY	0x12
+#define UART_17158_FCTR_RTS_16DELAY	0x05
+#define UART_17158_FCTR_RTS_20DELAY	0x13
+#define UART_17158_FCTR_RTS_24DELAY	0x06
+#define UART_17158_FCTR_RTS_28DELAY	0x14
+#define UART_17158_FCTR_RTS_32DELAY	0x07
+#define UART_17158_FCTR_RTS_36DELAY	0x16
+#define UART_17158_FCTR_RTS_40DELAY	0x08
+#define UART_17158_FCTR_RTS_44DELAY	0x09
+#define UART_17158_FCTR_RTS_48DELAY	0x10
+#define UART_17158_FCTR_RTS_52DELAY	0x11
+
+#define UART_17158_FCTR_RTS_IRDA	0x10
+#define UART_17158_FCTR_RS485		0x20
+#define UART_17158_FCTR_TRGA		0x00
+#define UART_17158_FCTR_TRGB		0x40
+#define UART_17158_FCTR_TRGC		0x80
+#define UART_17158_FCTR_TRGD		0xC0
+
+/* 17158 trigger table selects.. */
+#define UART_17158_FCTR_BIT6		0x40
+#define UART_17158_FCTR_BIT7		0x80
+
+/* 17158 TX/RX memmapped buffer offsets */
+#define UART_17158_RX_FIFOSIZE		64
+#define UART_17158_TX_FIFOSIZE		64
+
+/* 17158 Extended IIR's */
+#define UART_17158_IIR_RDI_TIMEOUT	0x0C	/* Receiver data TIMEOUT */
+#define UART_17158_IIR_XONXOFF		0x10	/* Received an XON/XOFF char */
+#define UART_17158_IIR_HWFLOW_STATE_CHANGE 0x20	/* CTS/DSR or RTS/DTR state change */
+#define UART_17158_IIR_FIFO_ENABLED	0xC0	/* 16550 FIFOs are Enabled */
+
+/*
+ * These are the extended interrupts that get sent
+ * back to us from the UART's 32bit interrupt register
+ */
+#define UART_17158_RX_LINE_STATUS	0x1	/* RX Ready */
+#define UART_17158_RXRDY_TIMEOUT	0x2	/* RX Ready Timeout */
+#define UART_17158_TXRDY		0x3	/* TX Ready */
+#define UART_17158_MSR			0x4	/* Modem State Change */
+#define UART_17158_TX_AND_FIFO_CLR	0x40	/* Transmitter Holding Reg Empty */
+#define UART_17158_RX_FIFO_DATA_ERROR	0x80	/* UART detected an RX FIFO Data error */
+
+/*
+ * These are the EXTENDED definitions for the 17C158's Interrupt
+ * Enable Register.
+ */
+#define UART_17158_EFR_ECB	0x10	/* Enhanced control bit */
+#define UART_17158_EFR_IXON	0x2	/* Receiver compares Xon1/Xoff1 */
+#define UART_17158_EFR_IXOFF	0x8	/* Transmit Xon1/Xoff1 */
+#define UART_17158_EFR_RTSDTR	0x40	/* Auto RTS/DTR Flow Control Enable */
+#define UART_17158_EFR_CTSDSR	0x80	/* Auto CTS/DSR Flow COntrol Enable */
+
+#define UART_17158_XOFF_DETECT	0x1	/* Indicates whether chip saw an incoming XOFF char  */
+#define UART_17158_XON_DETECT	0x2	/* Indicates whether chip saw an incoming XON char */
+
+#define UART_17158_IER_RSVD1	0x10	/* Reserved by Exar */
+#define UART_17158_IER_XOFF	0x20	/* Xoff Interrupt Enable */
+#define UART_17158_IER_RTSDTR	0x40	/* Output Interrupt Enable */
+#define UART_17158_IER_CTSDSR	0x80	/* Input Interrupt Enable */
+
+#define PCI_DEVICE_NEO_4_PCI_NAME		"Neo 4 PCI"
+#define PCI_DEVICE_NEO_8_PCI_NAME		"Neo 8 PCI"
+#define PCI_DEVICE_NEO_2DB9_PCI_NAME		"Neo 2 - DB9 Universal PCI"
+#define PCI_DEVICE_NEO_2DB9PRI_PCI_NAME		"Neo 2 - DB9 Universal PCI - Powered Ring Indicator"
+#define PCI_DEVICE_NEO_2RJ45_PCI_NAME		"Neo 2 - RJ45 Universal PCI"
+#define PCI_DEVICE_NEO_2RJ45PRI_PCI_NAME	"Neo 2 - RJ45 Universal PCI - Powered Ring Indicator"
+#define PCI_DEVICE_NEO_1_422_PCI_NAME		"Neo 1 422 PCI"
+#define PCI_DEVICE_NEO_1_422_485_PCI_NAME	"Neo 1 422/485 PCI"
+#define PCI_DEVICE_NEO_2_422_485_PCI_NAME	"Neo 2 422/485 PCI"
+
+/*
+ * Our Global Variables.
+ */
+extern struct	uart_driver jsm_uart_driver;
+extern struct	board_ops jsm_neo_ops;
+extern int	jsm_debug;
+extern int	jsm_rawreadok;
+
+extern int	jsm_driver_state;	/* The state of the driver	*/
+extern char	*jsm_driver_state_text[];/* Array of driver state text */
+
+extern spinlock_t jsm_board_head_lock;
+extern struct list_head jsm_board_head;
+/*************************************************************************
+ *
+ * Prototypes for non-static functions used in more than one module
+ *
+ *************************************************************************/
+int jsm_mgmt_open(struct inode *inode, struct file *file);
+int jsm_mgmt_close(struct inode *inode, struct file *file);
+int jsm_mgmt_ioctl(struct inode *inode, struct file *file, unsigned int cmd, unsigned long arg);
+
+int jsm_tty_write(struct uart_port *port);
+int jsm_tty_register(struct jsm_board *brd);
+
+int jsm_tty_init(struct jsm_board *);
+int jsm_uart_port_init(struct jsm_board *);
+int jsm_remove_uart_port(struct jsm_board *);
+
+void jsm_tty_uninit(struct jsm_board *);
+
+void jsm_input(struct jsm_channel *ch);
+void jsm_carrier(struct jsm_channel *ch);
+void jsm_check_queue_flow_control(struct jsm_channel *ch);
+
+void jsm_create_driver_sysfiles(struct device_driver *);
+void jsm_remove_driver_sysfiles(struct device_driver *);
+
+/************************************************************************
+ * All structures for management ports of adapters			* 
+ ************************************************************************/
+#define DIGI_PLEN       28              /* String length                */
+#define DIGI_TSIZ       10              /* Terminal string len          */
+
+struct digi {
+	unsigned short	digi_flags;		/* Flags (see above)	*/
+	unsigned short	digi_maxcps;		/* Max printer CPS	*/
+	unsigned short	digi_maxchar;		/* Max chars in print queue */
+	unsigned short	digi_bufsize;		/* Buffer size		*/
+	unsigned char	digi_onlen;		/* Length of ON string	*/
+	unsigned char	digi_offlen;		/* Length of OFF string	*/
+	char		digi_onstr[DIGI_PLEN];	/* Printer on string	*/
+	char		digi_offstr[DIGI_PLEN];	/* Printer off string	*/
+	char		digi_term[DIGI_TSIZ];	/* terminal string	*/
+};
+
+/************************************************************************
+ * Structure to get driver status information
+ ************************************************************************/
+struct digi_dinfo {
+	u8	dinfo_nboards;		/* # boards configured	*/
+	char	dinfo_reserved[12];	/* for future expansion */
+	char	dinfo_version[16];	/* driver version	*/
+};
+
+struct digi_info {
+	unsigned int	info_bdnum;		/* Board number (0 based)  */
+	unsigned int	info_ioport;		/* io port address	   */
+	unsigned long	info_physaddr;		/* memory address	   */
+	unsigned int	info_physsize;		/* Size of host mem window */
+	unsigned int	info_memsize;		/* Amount of dual-port mem */
+						/* on board		   */
+	unsigned short	info_bdtype;		/* Board type		   */
+	unsigned short	info_nports;		/* number of ports	   */
+	char		info_bdstate;		/* board state		   */
+	char		info_reserved[7];	/* for future expansion	   */
+};
+
+struct ni_info {
+	int board;
+	int channel;
+	int dtr;
+	int rts;
+	int cts;
+	int dsr;
+	int ri;
+	int dcd;
+	int curtx;
+	int currx;
+	unsigned short iflag;
+	unsigned short oflag;
+	unsigned short cflag;
+	unsigned short lflag;
+	unsigned int mstat;
+	unsigned char hflow;
+	unsigned char xmit_stopped;
+	unsigned char recv_stopped;
+	unsigned int baud;
+};
+
+/* Ioctls needed for dpa operation */
+#define DIGI_GETDD	('d'<<8) | 248		/* get driver info      */
+#define DIGI_GETBD	('d'<<8) | 249		/* get board info       */
+#define DIGI_GET_NI_INFO ('d'<<8) | 250		/* nonintelligent state snfo */
+
+#endif

--------------070407070101000802070808--

