Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261571AbVB1G7B@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261571AbVB1G7B (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 28 Feb 2005 01:59:01 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261568AbVB1G7B
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 28 Feb 2005 01:59:01 -0500
Received: from mail.kroah.org ([69.55.234.183]:17564 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S261388AbVB1G6J (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 28 Feb 2005 01:58:09 -0500
Date: Sun, 27 Feb 2005 22:55:34 -0800
From: Greg KH <greg@kroah.com>
To: Wen Xiong <wendyx@us.ibm.com>
Cc: linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org
Subject: Re: [ patch 6/7] drivers/serial/jsm: new serial device driver
Message-ID: <20050228065534.GC23595@kroah.com>
References: <42225A64.6070904@us.ltcfwd.linux.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <42225A64.6070904@us.ltcfwd.linux.ibm.com>
User-Agent: Mutt/1.5.8i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Feb 27, 2005 at 06:40:20PM -0500, Wen Xiong wrote:
> 
> diff -Nuar linux-2.6.9.orig/drivers/serial/jsm/digi.h linux-2.6.9.new/drivers/serial/jsm/digi.h

Oh, and please diff against at least the latest kernel release, 2.6.9 is
old...


> + * $Id: digi.h,v 1.7 2004/09/23 16:08:30 scottk Exp $
> + *
> + *	NOTE: THIS IS A SHARED HEADER. DO NOT CHANGE CODING STYLE!!!

Not true anymore, right?

> +/************************************************************************
> + * Structure to get driver status information
> + ************************************************************************/
> +struct digi_dinfo {
> +	unsigned int	dinfo_nboards;		/* # boards configured	*/
> +	char		dinfo_reserved[12];	/* for future expansion */
> +	char		dinfo_version[16];	/* driver version	*/
> +};
> +
> +#define	DIGI_GETDD	('d'<<8) | 248		/* get driver info	*/

All structures that are passed accross the ioctl interface, MUST use the
__u8, __u16, __u32, and friend definitions.  unsigned int is not
allowed.

And why have all of these ioctls?  Shouldn't most of this stuff be
availble in sysfs instead?

> +#ifndef __JSM_DRIVER_H
> +#define __JSM_DRIVER_H
> +
> +#include <linux/types.h>	/* To pick up the varions Linux types */
> +#include <linux/tty.h>		/* To pick up the various tty structs/defines */
> +#include <linux/serial_core.h>
> +#include <linux/interrupt.h>	/* For irqreturn_t type */
> +#include <linux/module.h>	/* For irqreturn_t type */

That comment is incorrect.

> +/*
> + * Driver identification, error and debugging statments
> + *
> + * In theory, you can change all occurances of "digi" in the next
> + * three lines, and the driver printk's will all automagically change.
> + *
> + * APR((fmt, args, ...));	Always prints message
> + * DPR((fmt, args, ...));	Only prints if JSM_TRACER is defined at
> + *				  compile time and jsm_debug!=0
> + *
> + * TRC_TO_CONSOLE:
> + *	Setting this to 1 will turn on some general function tracing
> + *	resulting in a bunch of extra debugging printks to the console
> + *
> + */
> +
> +#define	PROCSTR		"jsm"			/* /proc entries	 */
> +#define	DEVSTR		"/dev/dg/jsm"		/* /dev entries		 */
> +#define	DRVSTR		"jsm"			/* Driver name string 
> +						 * displayed by APR	 */
> +#define	APR(args)	do {printk(DRVSTR": "); printk args;} while (0)

Ick.  You _must_ use a KERN_ level for a printk, this is not allowed.
Please use the dev_printk and helper functions instead.  It's not ok to
create new functions like this.

And again, what's with the double (( when you use this macro?

> +#if TRC_TO_CONSOLE
> +#define PRINTF_TO_CONSOLE(args) { printk(DRVSTR": "); printk args; }
> +#else //!defined TRACE_TO_CONSOLE
> +#define PRINTF_TO_CONSOLE(args)
> +#endif
> +
> +#define	TRC(args)	{ PRINTF_TO_CONSOLE(args) }

do { } while 0

> +/* Our 3 magic numbers for our board, channel and unit structs */
> +#define JSM_BOARD_MAGIC		0x5c6df104
> +#define JSM_CHANNEL_MAGIC	0x6c6df104
> +#define JSM_UNIT_MAGIC		0x7c6df104

Don't use magic numbers, they are not needed at all.  Please just remove
them from the structures, and use the provided kernel slab debug
functions to catch errors that you might have been able to catch with
the magic values.

> + * This file is intended to contain all the kernel "differences" between the
> + * various kernels that we support.

No, please use this for your 2.4 code, not for your 2.6 driver version.

> +# define JSM_MOD_INC_USE_COUNT(rtn)	(rtn = 1)
> +# define JSM_MOD_DEC_USE_COUNT		

You shouldn't even be using these macros in your 2.4 code, so please
don't use it here.

> diff -Nuar linux-2.6.9.orig/drivers/serial/jsm/jsm_mgmt.h linux-2.6.9.new/drivers/serial/jsm/jsm_mgmt.h
> --- linux-2.6.9.orig/drivers/serial/jsm/jsm_mgmt.h	1969-12-31 18:00:00.000000000 -0600
> +++ linux-2.6.9.new/drivers/serial/jsm/jsm_mgmt.h	2005-02-27 17:14:44.747952016 -0600

Do you really need all of these different header files?  Why not just
put them all in 1?

> +/************************************************************************ 
> + * Per channel/port NEO UART structure					*
> + ************************************************************************
> + *		Base Structure Entries Usage Meanings to Host		*
> + *									*
> + *	W = read write		R = read only				* 
> + *			U = Unused.					*
> + ************************************************************************/
> +
> +struct neo_uart_struct {
> +	volatile uchar txrx;		/* WR  RHR/THR - Holding Reg */
> +	volatile uchar ier;		/* WR  IER - Interrupt Enable Reg */
> +	volatile uchar isr_fcr;		/* WR  ISR/FCR - Interrupt Status Reg/Fifo Control Reg */
> +	volatile uchar lcr;		/* WR  LCR - Line Control Reg */
> +	volatile uchar mcr;		/* WR  MCR - Modem Control Reg */
> +	volatile uchar lsr;		/* WR  LSR - Line Status Reg */
> +	volatile uchar msr;		/* WR  MSR - Modem Status Reg */
> +	volatile uchar spr;		/* WR  SPR - Scratch Pad Reg */
> +	volatile uchar fctr;		/* WR  FCTR - Feature Control Reg */
> +	volatile uchar efr;		/* WR  EFR - Enhanced Function Reg */
> +	volatile uchar tfifo;		/* WR  TXCNT/TXTRG - Transmit FIFO Reg */	
> +	volatile uchar rfifo;		/* WR  RXCNT/RXTRG - Recieve  FIFO Reg */
> +	volatile uchar xoffchar1;	/* WR  XOFF 1 - XOff Character 1 Reg */
> +	volatile uchar xoffchar2;	/* WR  XOFF 2 - XOff Character 2 Reg */
> +	volatile uchar xonchar1;	/* WR  XON 1 - Xon Character 1 Reg */
> +	volatile uchar xonchar2;	/* WR  XON 2 - XOn Character 2 Reg */
> +
> +	volatile uchar reserved1[0x2ff - 0x200]; /* U   Reserved by Exar */
> +	volatile uchar txrxburst[64];	/* RW  64 bytes of RX/TX FIFO Data */
> +	volatile uchar reserved2[0x37f - 0x340]; /* U   Reserved by Exar */
> +	volatile uchar rxburst_with_errors[64];	/* R  64 bytes of RX FIFO Data + LSR */
> +};

If you need to use volatile, you are doing something wrong.  Please
don't use it.

> +#define PCIMAX 32			/* maximum number of PCI boards */

Why?  I've seen boxes with more than this number of PCI slots.

> +int	jsm_tty_write(struct uart_port *port);
> +int	jsm_tty_register(struct board_t *brd);
> +
> +int	jsm_tty_init(struct board_t *);
> +int	jsm_uart_port_init(struct board_t *);
> +int	jsm_remove_uart_port(struct board_t *);
> +
> +void	jsm_tty_uninit(struct board_t *);
> +
> +void	jsm_input(struct channel_t *ch);
> +void	jsm_carrier(struct channel_t *ch);
> +void	jsm_check_queue_flow_control(struct channel_t *ch);
> +void	neo_clear_break(struct channel_t *ch, int force);

Why a different naming scheme for this one function?

> diff -Nuar linux-2.6.9.orig/drivers/serial/jsm/jsm_types.h linux-2.6.9.new/drivers/serial/jsm/jsm_types.h
> --- linux-2.6.9.orig/drivers/serial/jsm/jsm_types.h	1969-12-31 18:00:00.000000000 -0600
> +++ linux-2.6.9.new/drivers/serial/jsm/jsm_types.h	2005-02-27 17:14:44.749951712 -0600
> @@ -0,0 +1,36 @@
> +/*
> + * Copyright 2003 Digi International (www.digi.com)
> + *	Scott H Kilau <Scott_Kilau at digi dot com>
> + *
> + * This program is free software; you can redistribute it and/or modify
> + * it under the terms of the GNU General Public License as published by
> + * the Free Software Foundation; either version 2, or (at your option)
> + * any later version.
> + *
> + * This program is distributed in the hope that it will be useful,
> + * but WITHOUT ANY WARRANTY, EXPRESS OR IMPLIED; without even the
> + * implied warranty of MERCHANTABILITY or FITNESS FOR A PARTICULAR
> + * PURPOSE.  See the GNU General Public License for more details.
> + *
> + * You should have received a copy of the GNU General Public License
> + * along with this program; if not, write to the Free Software
> + * Foundation, Inc., 675 Mass Ave, Cambridge, MA 02139, USA.
> + *
> + *	NOTE: THIS IS A SHARED HEADER. DO NOT CHANGE CODING STYLE!!!
> + */
> +
> +#ifndef __JSM_TYPES_H
> +#define __JSM_TYPES_H
> +
> +#ifndef TRUE
> +# define TRUE 1
> +#endif
> +
> +#ifndef FALSE
> +# define FALSE 0
> +#endif

Ick, no, just use 0 for valid function returns, and -ERRSOMETHING for an
error.  You don't need TRUE and FALSE in your code.

> +/* Required for our shared headers! */
> +typedef unsigned char uchar;

No, don't do this.  So this whole .h file can be removed.

thanks,

greg k-h
