Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263205AbVCDXIN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263205AbVCDXIN (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 4 Mar 2005 18:08:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263395AbVCDXDR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 4 Mar 2005 18:03:17 -0500
Received: from e1.ny.us.ibm.com ([32.97.182.141]:7883 "EHLO e1.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S263216AbVCDVIr (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 4 Mar 2005 16:08:47 -0500
Message-ID: <4228CE5C.9010207@us.ltcfwd.linux.ibm.com>
Date: Fri, 04 Mar 2005 16:08:44 -0500
From: Wen Xiong <wendyx@us.ibm.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.2.1) Gecko/20030225
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Greg KH <greg@kroah.com>
CC: Wen Xiong <wendyx@us.ibm.com>, linux-kernel@vger.kernel.org
Subject: Re: [ patch 6/7] drivers/serial/jsm: new serial device driver
References: <42225A64.6070904@us.ltcfwd.linux.ibm.com> <20050228065534.GC23595@kroah.com>
In-Reply-To: <20050228065534.GC23595@kroah.com>
Content-Type: multipart/mixed;
 boundary="------------060205080802080801040409"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------060205080802080801040409
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit

Greg KH wrote:

>On Sun, Feb 27, 2005 at 06:40:20PM -0500, Wen Xiong wrote:
>  
>
>>diff -Nuar linux-2.6.9.orig/drivers/serial/jsm/digi.h linux-2.6.9.new/drivers/serial/jsm/digi.h
>>    
>>
>
>Oh, and please diff against at least the latest kernel release, 2.6.9 is
>old...
>
>
>  
>
>>+ * $Id: digi.h,v 1.7 2004/09/23 16:08:30 scottk Exp $
>>+ *
>>+ *	NOTE: THIS IS A SHARED HEADER. DO NOT CHANGE CODING STYLE!!!
>>    
>>
>
>Not true anymore, right?
>
>  
>
>>+/************************************************************************
>>+ * Structure to get driver status information
>>+ ************************************************************************/
>>+struct digi_dinfo {
>>+	unsigned int	dinfo_nboards;		/* # boards configured	*/
>>+	char		dinfo_reserved[12];	/* for future expansion */
>>+	char		dinfo_version[16];	/* driver version	*/
>>+};
>>+
>>+#define	DIGI_GETDD	('d'<<8) | 248		/* get driver info	*/
>>    
>>
>
>All structures that are passed accross the ioctl interface, MUST use the
>__u8, __u16, __u32, and friend definitions.  unsigned int is not
>allowed.
>
>And why have all of these ioctls?  Shouldn't most of this stuff be
>availble in sysfs instead?
>
>  
>
>>+#ifndef __JSM_DRIVER_H
>>+#define __JSM_DRIVER_H
>>+
>>+#include <linux/types.h>	/* To pick up the varions Linux types */
>>+#include <linux/tty.h>		/* To pick up the various tty structs/defines */
>>+#include <linux/serial_core.h>
>>+#include <linux/interrupt.h>	/* For irqreturn_t type */
>>+#include <linux/module.h>	/* For irqreturn_t type */
>>    
>>
>
>That comment is incorrect.
>
>  
>
>>+/*
>>+ * Driver identification, error and debugging statments
>>+ *
>>+ * In theory, you can change all occurances of "digi" in the next
>>+ * three lines, and the driver printk's will all automagically change.
>>+ *
>>+ * APR((fmt, args, ...));	Always prints message
>>+ * DPR((fmt, args, ...));	Only prints if JSM_TRACER is defined at
>>+ *				  compile time and jsm_debug!=0
>>+ *
>>+ * TRC_TO_CONSOLE:
>>+ *	Setting this to 1 will turn on some general function tracing
>>+ *	resulting in a bunch of extra debugging printks to the console
>>+ *
>>+ */
>>+
>>+#define	PROCSTR		"jsm"			/* /proc entries	 */
>>+#define	DEVSTR		"/dev/dg/jsm"		/* /dev entries		 */
>>+#define	DRVSTR		"jsm"			/* Driver name string 
>>+						 * displayed by APR	 */
>>+#define	APR(args)	do {printk(DRVSTR": "); printk args;} while (0)
>>    
>>
>
>Ick.  You _must_ use a KERN_ level for a printk, this is not allowed.
>Please use the dev_printk and helper functions instead.  It's not ok to
>create new functions like this.
>
>And again, what's with the double (( when you use this macro?
>
>  
>
>>+#if TRC_TO_CONSOLE
>>+#define PRINTF_TO_CONSOLE(args) { printk(DRVSTR": "); printk args; }
>>+#else //!defined TRACE_TO_CONSOLE
>>+#define PRINTF_TO_CONSOLE(args)
>>+#endif
>>+
>>+#define	TRC(args)	{ PRINTF_TO_CONSOLE(args) }
>>    
>>
>
>do { } while 0
>
>  
>
>>+/* Our 3 magic numbers for our board, channel and unit structs */
>>+#define JSM_BOARD_MAGIC		0x5c6df104
>>+#define JSM_CHANNEL_MAGIC	0x6c6df104
>>+#define JSM_UNIT_MAGIC		0x7c6df104
>>    
>>
>
>Don't use magic numbers, they are not needed at all.  Please just remove
>them from the structures, and use the provided kernel slab debug
>functions to catch errors that you might have been able to catch with
>the magic values.
>
>  
>
>>+ * This file is intended to contain all the kernel "differences" between the
>>+ * various kernels that we support.
>>    
>>
>
>No, please use this for your 2.4 code, not for your 2.6 driver version.
>
>  
>
>>+# define JSM_MOD_INC_USE_COUNT(rtn)	(rtn = 1)
>>+# define JSM_MOD_DEC_USE_COUNT		
>>    
>>
>
>You shouldn't even be using these macros in your 2.4 code, so please
>don't use it here.
>
>  
>
>>diff -Nuar linux-2.6.9.orig/drivers/serial/jsm/jsm_mgmt.h linux-2.6.9.new/drivers/serial/jsm/jsm_mgmt.h
>>--- linux-2.6.9.orig/drivers/serial/jsm/jsm_mgmt.h	1969-12-31 18:00:00.000000000 -0600
>>+++ linux-2.6.9.new/drivers/serial/jsm/jsm_mgmt.h	2005-02-27 17:14:44.747952016 -0600
>>    
>>
>
>Do you really need all of these different header files?  Why not just
>put them all in 1?
>
>  
>
>>+/************************************************************************ 
>>+ * Per channel/port NEO UART structure					*
>>+ ************************************************************************
>>+ *		Base Structure Entries Usage Meanings to Host		*
>>+ *									*
>>+ *	W = read write		R = read only				* 
>>+ *			U = Unused.					*
>>+ ************************************************************************/
>>+
>>+struct neo_uart_struct {
>>+	volatile uchar txrx;		/* WR  RHR/THR - Holding Reg */
>>+	volatile uchar ier;		/* WR  IER - Interrupt Enable Reg */
>>+	volatile uchar isr_fcr;		/* WR  ISR/FCR - Interrupt Status Reg/Fifo Control Reg */
>>+	volatile uchar lcr;		/* WR  LCR - Line Control Reg */
>>+	volatile uchar mcr;		/* WR  MCR - Modem Control Reg */
>>+	volatile uchar lsr;		/* WR  LSR - Line Status Reg */
>>+	volatile uchar msr;		/* WR  MSR - Modem Status Reg */
>>+	volatile uchar spr;		/* WR  SPR - Scratch Pad Reg */
>>+	volatile uchar fctr;		/* WR  FCTR - Feature Control Reg */
>>+	volatile uchar efr;		/* WR  EFR - Enhanced Function Reg */
>>+	volatile uchar tfifo;		/* WR  TXCNT/TXTRG - Transmit FIFO Reg */	
>>+	volatile uchar rfifo;		/* WR  RXCNT/RXTRG - Recieve  FIFO Reg */
>>+	volatile uchar xoffchar1;	/* WR  XOFF 1 - XOff Character 1 Reg */
>>+	volatile uchar xoffchar2;	/* WR  XOFF 2 - XOff Character 2 Reg */
>>+	volatile uchar xonchar1;	/* WR  XON 1 - Xon Character 1 Reg */
>>+	volatile uchar xonchar2;	/* WR  XON 2 - XOn Character 2 Reg */
>>+
>>+	volatile uchar reserved1[0x2ff - 0x200]; /* U   Reserved by Exar */
>>+	volatile uchar txrxburst[64];	/* RW  64 bytes of RX/TX FIFO Data */
>>+	volatile uchar reserved2[0x37f - 0x340]; /* U   Reserved by Exar */
>>+	volatile uchar rxburst_with_errors[64];	/* R  64 bytes of RX FIFO Data + LSR */
>>+};
>>    
>>
>
>If you need to use volatile, you are doing something wrong.  Please
>don't use it.
>
>  
>
>>+#define PCIMAX 32			/* maximum number of PCI boards */
>>    
>>
>
>Why?  I've seen boxes with more than this number of PCI slots.
>
>  
>
>>+int	jsm_tty_write(struct uart_port *port);
>>+int	jsm_tty_register(struct board_t *brd);
>>+
>>+int	jsm_tty_init(struct board_t *);
>>+int	jsm_uart_port_init(struct board_t *);
>>+int	jsm_remove_uart_port(struct board_t *);
>>+
>>+void	jsm_tty_uninit(struct board_t *);
>>+
>>+void	jsm_input(struct channel_t *ch);
>>+void	jsm_carrier(struct channel_t *ch);
>>+void	jsm_check_queue_flow_control(struct channel_t *ch);
>>+void	neo_clear_break(struct channel_t *ch, int force);
>>    
>>
>
>Why a different naming scheme for this one function?
>
>  
>
>>diff -Nuar linux-2.6.9.orig/drivers/serial/jsm/jsm_types.h linux-2.6.9.new/drivers/serial/jsm/jsm_types.h
>>--- linux-2.6.9.orig/drivers/serial/jsm/jsm_types.h	1969-12-31 18:00:00.000000000 -0600
>>+++ linux-2.6.9.new/drivers/serial/jsm/jsm_types.h	2005-02-27 17:14:44.749951712 -0600
>>@@ -0,0 +1,36 @@
>>+/*
>>+ * Copyright 2003 Digi International (www.digi.com)
>>+ *	Scott H Kilau <Scott_Kilau at digi dot com>
>>+ *
>>+ * This program is free software; you can redistribute it and/or modify
>>+ * it under the terms of the GNU General Public License as published by
>>+ * the Free Software Foundation; either version 2, or (at your option)
>>+ * any later version.
>>+ *
>>+ * This program is distributed in the hope that it will be useful,
>>+ * but WITHOUT ANY WARRANTY, EXPRESS OR IMPLIED; without even the
>>+ * implied warranty of MERCHANTABILITY or FITNESS FOR A PARTICULAR
>>+ * PURPOSE.  See the GNU General Public License for more details.
>>+ *
>>+ * You should have received a copy of the GNU General Public License
>>+ * along with this program; if not, write to the Free Software
>>+ * Foundation, Inc., 675 Mass Ave, Cambridge, MA 02139, USA.
>>+ *
>>+ *	NOTE: THIS IS A SHARED HEADER. DO NOT CHANGE CODING STYLE!!!
>>+ */
>>+
>>+#ifndef __JSM_TYPES_H
>>+#define __JSM_TYPES_H
>>+
>>+#ifndef TRUE
>>+# define TRUE 1
>>+#endif
>>+
>>+#ifndef FALSE
>>+# define FALSE 0
>>+#endif
>>    
>>
>
>Ick, no, just use 0 for valid function returns, and -ERRSOMETHING for an
>error.  You don't need TRUE and FALSE in your code.
>
>  
>
>>+/* Required for our shared headers! */
>>+typedef unsigned char uchar;
>>    
>>
>
>No, don't do this.  So this whole .h file can be removed.
>
>thanks,
>
>greg k-h
>-
>To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
>the body of a message to majordomo@vger.kernel.org
>More majordomo info at  http://vger.kernel.org/majordomo-info.html
>Please read the FAQ at  http://www.tux.org/lkml/
>
>  
>
Fixed all above problem and combined headers files to one device driver 
head file and another one has user's API.

Signed-off-by: Wen Xiong <wendyx@us.ltcfwd.linux.ibm.com>



--------------060205080802080801040409
Content-Type: text/plain;
 name="patch6.jasmine"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="patch6.jasmine"

diff -Nuar linux-2.6.11.org/drivers/serial/jsm/digi.h linux-2.6.11.new/drivers/serial/jsm/digi.h
--- linux-2.6.11.org/drivers/serial/jsm/digi.h	1969-12-31 18:00:00.000000000 -0600
+++ linux-2.6.11.new/drivers/serial/jsm/digi.h	2005-03-04 11:22:27.558933144 -0600
@@ -0,0 +1,387 @@
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
+
+#ifndef __DIGI_H
+#define __DIGI_H
+
+/************************************************************************
+ ***	Definitions for Digi ditty(1) command.
+ ************************************************************************/
+
+/************************************************************************
+ * This module provides application access to special Digi
+ * serial line enhancements which are not standard UNIX(tm) features.
+ ************************************************************************/
+
+#if !defined(TIOCMODG)
+
+#define TIOCMODG	('d'<<8) | 250		/* get modem ctrl state	*/
+#define TIOCMODS	('d'<<8) | 251		/* set modem ctrl state	*/
+
+#ifndef TIOCM_LE 
+#define TIOCM_LE	0x01		/* line enable		*/
+#define TIOCM_DTR	0x02		/* data terminal ready	*/
+#define TIOCM_RTS	0x04		/* request to send	*/
+#define TIOCM_ST	0x08		/* secondary transmit	*/
+#define TIOCM_SR	0x10		/* secondary receive	*/
+#define TIOCM_CTS	0x20		/* clear to send	*/
+#define TIOCM_CAR	0x40		/* carrier detect	*/
+#define TIOCM_RNG	0x80		/* ring	indicator	*/
+#define TIOCM_DSR	0x100		/* data set ready	*/
+#define TIOCM_RI	TIOCM_RNG	/* ring (alternate)	*/
+#define TIOCM_CD	TIOCM_CAR	/* carrier detect (alt)	*/
+#endif
+
+#endif
+
+#if !defined(TIOCMSET)
+#define TIOCMSET	('d'<<8) | 252		/* set modem ctrl state	*/
+#define TIOCMGET	('d'<<8) | 253		/* set modem ctrl state	*/
+#endif
+
+#if !defined(TIOCMBIC)
+#define TIOCMBIC	('d'<<8) | 254		/* set modem ctrl state */
+#define TIOCMBIS	('d'<<8) | 255		/* set modem ctrl state */
+#endif
+
+
+#if !defined(TIOCSDTR)
+#define TIOCSDTR	('e'<<8) | 0		/* set DTR		*/
+#define TIOCCDTR	('e'<<8) | 1		/* clear DTR		*/
+#endif
+
+/************************************************************************
+ * Ioctl command arguments for DIGI parameters.
+ ************************************************************************/
+#define DIGI_GETA	('e'<<8) | 94		/* Read params		*/
+#define DIGI_SETA	('e'<<8) | 95		/* Set params		*/
+#define DIGI_SETAW	('e'<<8) | 96		/* Drain & set params	*/
+#define DIGI_SETAF	('e'<<8) | 97		/* Drain, flush & set params */
+#define DIGI_KME	('e'<<8) | 98		/* Read/Write Host	*/
+#define DIGI_GETFLOW	('e'<<8) | 99		/* Get startc/stopc flow */
+#define DIGI_SETFLOW	('e'<<8) | 100		/* Set startc/stopc flow */
+#define DIGI_GETAFLOW	('e'<<8) | 101		/* Get Aux. startc/stopc */
+#define DIGI_SETAFLOW	('e'<<8) | 102		/* Set Aux. startc/stopc */
+#define DIGI_GEDELAY	('d'<<8) | 246		/* Get edelay */
+#define DIGI_SEDELAY	('d'<<8) | 247		/* Set edelay */
+
+struct	digiflow_t {
+	unsigned char	startc;			/* flow cntl start char	*/
+	unsigned char	stopc;			/* flow cntl stop char	*/
+};
+
+#ifdef	FLOW_2200
+#define F2200_GETA	('e'<<8) | 104		/* Get 2x36 flow cntl flags */
+#define F2200_SETAW	('e'<<8) | 105		/* Set 2x36 flow cntl flags */
+#define F2200_MASK	0x03		/* 2200 flow cntl bit mask */
+#define FCNTL_2200	0x01		/* 2x36 terminal flow cntl */
+#define PCNTL_2200	0x02		/* 2x36 printer flow cntl  */
+#define F2200_XON	0xf8
+#define P2200_XON	0xf9
+#define F2200_XOFF	0xfa
+#define P2200_XOFF	0xfb
+
+#define FXOFF_MASK	0x03		/* 2200 flow status mask   */
+#define RCVD_FXOFF	0x01		/* 2x36 Terminal XOFF rcvd */
+#define RCVD_PXOFF	0x02		/* 2x36 Printer XOFF rcvd  */
+#endif
+
+/************************************************************************
+ * Values for digi_flags 
+ ************************************************************************/
+#define DIGI_IXON	0x0001		/* Handle IXON in the FEP	*/
+#define DIGI_FAST	0x0002		/* Fast baud rates		*/
+#define RTSPACE		0x0004		/* RTS input flow control	*/
+#define CTSPACE		0x0008		/* CTS output flow control	*/
+#define DSRPACE		0x0010		/* DSR output flow control	*/
+#define DCDPACE		0x0020		/* DCD output flow control	*/
+#define DTRPACE		0x0040		/* DTR input flow control	*/
+#define DIGI_COOK	0x0080		/* Cooked processing done in FEP */
+#define DIGI_FORCEDCD	0x0100		/* Force carrier		*/
+#define DIGI_ALTPIN	0x0200		/* Alternate RJ-45 pin config	*/
+#define DIGI_AIXON	0x0400		/* Aux flow control in fep	*/
+#define DIGI_PRINTER	0x0800		/* Hold port open for flow cntrl*/
+#define DIGI_PP_INPUT	0x1000		/* Change parallel port to input*/
+#define DIGI_DTR_TOGGLE	0x2000		/* Support DTR Toggle		*/
+#define DIGI_422	0x4000		/* for 422/232 selectable panel */
+#define DIGI_RTS_TOGGLE	0x8000		/* Support RTS Toggle		*/
+
+/************************************************************************
+ * These options are not supported on the comxi.
+ ************************************************************************/
+#define DIGI_COMXI	(DIGI_FAST|DIGI_COOK|DSRPACE|DCDPACE|DTRPACE)
+
+#define DIGI_PLEN	28		/* String length		*/
+#define DIGI_TSIZ	10		/* Terminal string len		*/
+
+/************************************************************************
+ * Structure used with ioctl commands for DIGI parameters.
+ ************************************************************************/
+struct digi_t {
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
+#define PCXI_TYPE	1	/* Board type at the designated port is a PC/Xi */
+#define PCXM_TYPE	2	/* Board type at the designated port is a PC/Xm */
+#define PCXE_TYPE	3	/* Board type at the designated port is a PC/Xe */
+#define MCXI_TYPE	4	/* Board type at the designated port is a MC/Xi */
+#define COMXI_TYPE	5	/* Board type at the designated port is a COM/Xi */
+
+			 /* Non-Zero Result codes. */
+#define RESULT_NOBDFND	1	/* A Digi product at that port is not config installed */ 
+#define RESULT_NODESCT	2	/* A memory descriptor was not obtainable */ 
+#define RESULT_NOOSSIG	3	/* FEP/OS signature was not detected on the board */
+#define RESULT_TOOSML	4	/* Too small an area to shrink.  */
+#define RESULT_NOCHAN	5	/* Channel structure for the board was not found */
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
+/************************************************************************
+ * Structure used with ioctl commands for per-board information
+ *
+ * physsize and memsize differ when board has "windowed" memory
+ ************************************************************************/
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
+struct digi_stat {
+	unsigned int	info_chan;		/* Channel number (0 based)  */
+	unsigned int	info_brd;		/* Board number (0 based)  */
+	unsigned int	info_cflag;		/* cflag for channel	   */
+	unsigned int	info_iflag;		/* iflag for channel	   */
+	unsigned int	info_oflag;		/* oflag for channel	   */
+	unsigned int	info_mstat;		/* mstat for channel	   */
+	unsigned int	info_tx_data;		/* tx_data for channel	   */
+	unsigned int	info_rx_data;		/* rx_data for channel	   */
+	unsigned int	info_hflow;		/* hflow for channel	   */
+	unsigned int	info_reserved[8];	/* for future expansion    */
+};
+
+/***********************************************************************
+ *
+ * Structure used with ioctl commands for per-channel information
+ *
+ ************************************************************************/
+struct digi_ch {
+	unsigned int	info_bdnum;		/* Board number (0 based)  */
+	unsigned int	info_channel;		/* Channel index number	   */
+	unsigned int	info_ch_cflag;		/* Channel cflag   	   */
+	unsigned int	info_ch_iflag;		/* Channel iflag   	   */
+	unsigned int	info_ch_oflag;		/* Channel oflag   	   */
+	unsigned int	info_chsize;		/* Channel structure size  */
+	unsigned int	info_sleep_stat;	/* sleep status		   */
+	dev_t		info_dev;		/* device number	   */
+	unsigned char	info_initstate;		/* Channel init state	   */
+	unsigned char	info_running;		/* Channel running state   */
+	int		reserved[8];		/* reserved for future use */
+};
+
+/*
+* This structure is used with the DIGI_FEPCMD ioctl to 
+* tell the driver which port to send the command for.
+*/
+struct digi_cmd {
+	int	cmd;
+	int	word;
+	int	ncmds;
+	int	chan; /* channel index (zero based) */
+	int	bdid; /* board index (zero based) */
+};
+
+struct digi_getbuffer /* Struct for holding buffer use counts */
+{
+	unsigned long tIn;
+	unsigned long tOut;
+	unsigned long rxbuf;
+	unsigned long txbuf;
+	unsigned long txdone;
+};
+
+struct digi_getcounter
+{
+	unsigned long norun;		/* number of UART overrun errors */
+	unsigned long noflow;		/* number of buffer overflow errors */
+	unsigned long nframe;		/* number of framing errors */
+	unsigned long nparity;		/* number of parity errors */
+	unsigned long nbreak;		/* number of breaks received */
+	unsigned long rbytes;		/* number of received bytes */
+	unsigned long tbytes;		/* number of bytes transmitted fully */
+};
+
+/*
+*  info_sleep_stat defines
+*/
+#define INFO_RUNWAIT	0x0001
+#define INFO_WOPEN	0x0002
+#define INFO_TTIOW	0x0004
+#define INFO_CH_RWAIT	0x0008
+#define INFO_CH_WEMPTY	0x0010
+#define INFO_CH_WLOW	0x0020
+#define INFO_XXBUF_BUSY 0x0040
+
+
+/* Board type definitions */
+
+#define SUBTYPE		0007
+#define T_PCXI		0000
+#define T_PCXM		0001
+#define T_PCXE		0002
+#define T_PCXR		0003
+#define T_SP		0004
+#define T_SP_PLUS	0005
+
+#define T_HERC		0000
+#define T_HOU		0001
+#define T_LON		0002
+#define T_CHA		0003
+
+#define T_NEO		0000
+#define T_CLASSIC	0001
+
+#define FAMILY		0070
+#define T_COMXI		0000
+#define T_PCXX		0010
+#define T_CX		0020
+#define T_EPC		0030
+#define T_PCLITE	0040
+#define T_SPXX		0050
+#define T_AVXX		0060
+#define T_DXB		0070
+#define T_A2K_4_8	0070
+#define BUSTYPE		0700
+#define T_ISABUS	0000
+#define T_MCBUS		0100
+#define T_EISABUS	0200
+#define T_PCIBUS	0400
+
+/* Board State Definitions */
+
+#define BD_RUNNING	0x0
+#define BD_REASON	0x7f
+#define BD_NOTFOUND	0x1
+#define BD_NOIOPORT	0x2
+#define BD_NOMEM	0x3
+#define BD_NOBIOS	0x4
+#define BD_NOFEP	0x5
+#define BD_FAILED	0x6
+#define BD_ALLOCATED	0x7
+#define BD_TRIBOOT	0x8
+#define BD_BADKME	0x80
+
+#define DIGI_SPOLL		('d'<<8) | 254	/* change poller rate   */
+
+#define DIGI_SETCUSTOMBAUD	_IOW('e', 106, int)	/* Set integer baud rate */
+#define DIGI_GETCUSTOMBAUD	_IOR('e', 107, int)	/* Get integer baud rate */
+
+#define DIGI_REALPORT_GETBUFFERS	('e'<<8 ) | 108
+#define DIGI_REALPORT_SENDIMMEDIATE	('e'<<8 ) | 109
+#define DIGI_REALPORT_GETCOUNTERS	('e'<<8 ) | 110
+#define DIGI_REALPORT_GETEVENTS		('e'<<8 ) | 111
+
+#define EV_OPU		0x0001		//!<Output paused by client
+#define EV_OPS		0x0002		//!<Output paused by reqular sw flowctrl  
+#define EV_OPX		0x0004		//!<Output paused by extra sw flowctrl
+#define EV_OPH		0x0008		//!<Output paused by hw flowctrl
+#define EV_OPT		0x0800		//!<Output paused for RTS Toggle predelay
+
+#define EV_IPU		0x0010		//!<Input paused unconditionally by user
+#define EV_IPS		0x0020		//!<Input paused by high/low water marks
+#define EV_IPA		0x0400		//!<Input paused by pattern alarm module
+
+#define EV_TXB		0x0040		//!<Transmit break pending
+#define EV_TXI		0x0080		//!<Transmit immediate pending
+#define EV_TXF		0x0100		//!<Transmit flowctrl char pending
+#define EV_RXB		0x0200		//!<Break received
+
+#define EV_OPALL	0x080f		//!<Output pause flags
+#define EV_IPALL	0x0430		//!<Input pause flags
+
+/* 
+ * This structure holds data needed for the intelligent <--> nonintelligent
+ * DPA translation
+ */
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
+
+	unsigned char xmit_stopped;
+	unsigned char recv_stopped;
+
+	unsigned int baud;
+};
+
+/* Ioctls needed for dpa operation */
+
+#define DIGI_GETSTAT	('d'<<8) | 244		/* get board info	*/
+#define DIGI_GETCH	('d'<<8) | 245		/* get board info	*/
+#define DIGI_GETDD	('d'<<8) | 248		/* get driver info      */
+#define DIGI_GETBD	('d'<<8) | 249		/* get board info       */
+#define DIGI_GET_NI_INFO ('d'<<8) | 250		/* nonintelligent state snfo */
+
+/* Other special ioctls */
+#define DIGI_TIMERIRQ	('d'<<8) | 251		/* Enable/disable RS_TIMER use */
+#define DIGI_LOOPBACK	('d'<<8) | 252		/* Enable/disable UART internal loopback */
+
+#endif /* DIGI_H */
diff -Nuar linux-2.6.11.org/drivers/serial/jsm/jsm_driver.h linux-2.6.11.new/drivers/serial/jsm/jsm_driver.h
--- linux-2.6.11.org/drivers/serial/jsm/jsm_driver.h	1969-12-31 18:00:00.000000000 -0600
+++ linux-2.6.11.new/drivers/serial/jsm/jsm_driver.h	2005-03-04 11:22:19.222869456 -0600
@@ -0,0 +1,465 @@
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
+
+#ifndef __JSM_DRIVER_H
+#define __JSM_DRIVER_H
+
+#include <linux/kernel.h>
+#include <linux/version.h>
+#include <linux/types.h>	/* To pick up the varions Linux types */
+#include <linux/tty.h>		
+#include <linux/serial_core.h>
+#include <linux/serial_reg.h>
+#include <linux/interrupt.h>	/* For irqreturn_t type */
+#include <linux/module.h>	
+#include <linux/moduleparam.h>	
+#include <linux/kdev_t.h>	
+#include <linux/pci.h>
+#include <linux/pci_ids.h>
+#include <linux/device.h>
+#include <linux/config.h>
+
+
+#include "digi.h"		/* Digi specific ioctl header */
+
+#define DRVSTR	"jsm"		/* Driver name string */
+
+#define TRC_TO_IOCTL	1
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
+#define DPRINTK(nlevel, klevel, fmt, args...) \
+	(void)((DBG_##nlevel & debug) && \
+	printk(KERN_##klevel "%s: " fmt, \
+		__FUNCTION__, ## args)); 
+	
+#define MAXPORTS	8
+#define MAX_STOPS_SENT	5
+
+/* 4 extra for alignment play space */
+#define WRITEBUFLEN	((4096) + 4)
+#define MYFLIPLEN	N_TTY_BUF_SIZE
+
+#define JSM_MAJOR(x)	(imajor(x))
+#define JSM_MINOR(x)	(iminor(x))
+
+#ifndef _POSIX_VDISABLE
+#define	_POSIX_VDISABLE '\0'
+#endif
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
+	 u8 xoffchar1;	/* WR	XOFF 1 - XOff Character 1 Reg */
+	 u8 xoffchar2;	/* WR	XOFF 2 - XOff Character 2 Reg */
+	 u8 xonchar1;	/* WR	XON 1 - Xon Character 1 Reg */
+	 u8 xonchar2;	/* WR	XON 2 - XOn Character 2 Reg */
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
+extern int	debug;
+extern int	rawreadok;
+
+extern int	jsm_driver_state;	/* The state of the driver	*/
+extern char	*jsm_driver_state_text[];/* Array of driver state text */
+
+extern spinlock_t jsm_board_head_lock;
+static LIST_HEAD(jsm_board_head);
+
+/*************************************************************************
+ *
+ * Prototypes for non-static functions used in more than one module
+ *
+ *************************************************************************/
+extern char *jsm_ioctl_name(int cmd);
+extern int get_jsm_board_number(void);
+
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
+
+int jsm_tty_class_init(void);
+int jsm_tty_class_destroy(void);
+void jsm_create_driver_sysfiles(struct device_driver *);
+void jsm_remove_driver_sysfiles(struct device_driver *);
+void jsm_create_ports_sysfiles(struct jsm_board *, struct device *);
+void jsm_remove_ports_sysfiles(struct jsm_board *, struct device *);
+void jsm_tty_register_device(struct jsm_channel *, struct device *);
+void jsm_tty_unregister_device(struct jsm_channel *);
+
+#endif

--------------060205080802080801040409--

