Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261560AbSJQOFg>; Thu, 17 Oct 2002 10:05:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261584AbSJQOFg>; Thu, 17 Oct 2002 10:05:36 -0400
Received: from caramon.arm.linux.org.uk ([212.18.232.186]:59145 "EHLO
	caramon.arm.linux.org.uk") by vger.kernel.org with ESMTP
	id <S261560AbSJQOFe>; Thu, 17 Oct 2002 10:05:34 -0400
Date: Thu, 17 Oct 2002 15:11:25 +0100
From: Russell King <rmk@arm.linux.org.uk>
To: Osamu Tomita <tomita@cinet.co.jp>
Cc: LKML <linux-kernel@vger.kernel.org>,
       Linus Torvalds <torvalds@transmeta.com>
Subject: Re: [PATCH][RFC] add support for PC-9800 architecture (20/26) serial #1
Message-ID: <20021017151125.A3326@flint.arm.linux.org.uk>
References: <20021017204013.A1265@precia.cinet.co.jp>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <20021017204013.A1265@precia.cinet.co.jp>; from tomita@cinet.co.jp on Thu, Oct 17, 2002 at 08:40:13PM +0900
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I strongly recommend _n_o_t_ merging this patch.

On Thu, Oct 17, 2002 at 08:40:13PM +0900, Osamu Tomita wrote:
> diff -urN linux/drivers/serial/Makefile linux98/drivers/serial/Makefile
> --- linux/drivers/serial/Makefile	Wed Oct 16 13:20:41 2002
> +++ linux98/drivers/serial/Makefile	Wed Oct 16 15:31:48 2002
> @@ -4,14 +4,18 @@
>  #  $Id: Makefile,v 1.8 2002/07/21 21:32:30 rmk Exp $
>  #
>  
> -export-objs	:= core.o 8250.o suncore.o
> +export-objs	:= core.o 8250.o suncore.o serial98.o
>  
>  serial-8250-y :=
>  serial-8250-$(CONFIG_PCI) += 8250_pci.o
>  serial-8250-$(CONFIG_ISAPNP) += 8250_pnp.o
>  obj-$(CONFIG_SERIAL_CORE) += core.o
>  obj-$(CONFIG_SERIAL_21285) += 21285.o
> +ifneq ($(CONFIG_SERIAL_PC9800),y)
>  obj-$(CONFIG_SERIAL_8250) += 8250.o $(serial-8250-y)
> +else
> +obj-$(CONFIG_SERIAL_8250) += serial98.o $(serial-8250-y)
> +endif

If you don't want 8250.c, then don't re-use CONFIG_SERIAL_8250

> diff -urN linux/drivers/serial/8250_cs.c linux98/drivers/serial/8250_cs.c
> --- linux/drivers/serial/8250_cs.c	Thu Jul 25 06:03:28 2002
> +++ linux98/drivers/serial/8250_cs.c	Thu Jul 25 15:48:59 2002
> @@ -307,6 +307,7 @@
>  	serial.port = port;
>  	serial.irq = irq;
>  	serial.flags = ASYNC_SKIP_TEST | ASYNC_SHARE_IRQ;
> +	serial.baud_base = 230400;
>  	line = register_serial(&serial);
>  	if (line < 0) {
>  		printk(KERN_NOTICE "serial_cs: register_serial() at 0x%04lx,"

This breaks PCMCIA serial support on every other platform that supports
PCMCIA serial cards.

> diff -urN linux/include/linux/serial.h linux98/include/linux/serial.h
> --- linux/include/linux/serial.h	Mon Sep 16 11:18:23 2002
> +++ linux98/include/linux/serial.h	Mon Sep 16 16:21:38 2002
> @@ -10,6 +10,8 @@
>  #ifndef _LINUX_SERIAL_H
>  #define _LINUX_SERIAL_H
>  
> +#include <linux/config.h>
> +
>  #ifdef __KERNEL__
>  #include <asm/page.h>
>  
> @@ -75,11 +77,22 @@
>  #define PORT_16654	11
>  #define PORT_16850	12
>  #define PORT_RSA	13	/* RSA-DV II/S card */
> +#ifndef CONFIG_PC9800
>  #define PORT_MAX	13
> +#else
> +#define PORT_8251	14
> +#define PORT_8251_19K	15
> +#define PORT_8251_FIFO	16
> +#define PORT_8251_VFAST	17
> +#define PORT_MC16550II	18
> +#define PORT_MAX	18
> +#endif

Yuck.  Just define the new numbers.  There is no point putting an
ifdef around them.

> diff -urN linux/include/linux/serialP.h linux98/include/linux/serialP.h
> --- linux/include/linux/serialP.h	Tue Oct  8 10:56:20 2002
> +++ linux98/include/linux/serialP.h	Tue Oct  8 11:01:42 2002
> @@ -20,6 +20,7 @@
>   */
>  
>  #include <linux/config.h>
> +#include <linux/version.h>
>  #include <linux/termios.h>
>  #include <linux/workqueue.h>
>  #include <linux/circ_buf.h>
> @@ -75,6 +76,10 @@
>  	int			MCR; 	/* Modem control register */
>  	int			LCR; 	/* Line control register */
>  	int			ACR;	 /* 16950 Additional Control Reg. */
> +#ifdef CONFIG_PC9800
> +	int			cmd8251;
> +	int			msr8251;
> +#endif
>  	unsigned long		event;
>  	unsigned long		last_active;
>  	int			line;

I'm deferring comment on this until I've had time to digest your
other serial patch.

> diff -urN linux/include/linux/serial_core.h linux98/include/linux/serial_core.h
> --- linux/include/linux/serial_core.h	Sun Aug 11 10:41:20 2002
> +++ linux98/include/linux/serial_core.h	Wed Aug 21 16:26:45 2002
> @@ -37,7 +37,16 @@
>  #define PORT_16654	11
>  #define PORT_16850	12
>  #define PORT_RSA	13
> +#ifndef CONFIG_PC9800
>  #define PORT_MAX_8250	13	/* max port ID */
> +#else
> +#define PORT_8251	14
> +#define PORT_8251_19K	15
> +#define PORT_8251_FIFO	16
> +#define PORT_8251_VFAST	17
> +#define PORT_MC16550II	18
> +#define PORT_MAX_8250	18	/* max port ID */
> +#endif
>  
>  /*
>   * ARM specific type numbers.  These are not currently guaranteed

Same comments as serial.h

> diff -urN linux/include/linux/serial_reg.h linux98/include/linux/serial_reg.h
> --- linux/include/linux/serial_reg.h	Wed May  2 08:05:00 2001
> +++ linux98/include/linux/serial_reg.h	Fri Aug 17 22:15:12 2001
> @@ -14,6 +14,8 @@
>  #ifndef _LINUX_SERIAL_REG_H
>  #define _LINUX_SERIAL_REG_H
>  
> +#include <linux/config.h>
> +
>  #define UART_RX		0	/* In:  Receive buffer (DLAB=0) */
>  #define UART_TX		0	/* Out: Transmit buffer (DLAB=0) */
>  #define UART_DLL	0	/* Out: Divisor Latch Low (DLAB=1) */
> @@ -229,6 +231,47 @@
>  #define UART_TRG_120	0x78
>  #define UART_TRG_128	0x80
>  
> +#ifdef CONFIG_PC9800
> +
> +#define RX_8251F	0x130	/* In: Receive buffer */
> +#define TX_8251F	0x130	/* Out: Transmit buffer */
> +#define LSR_8251F	0x132	/* In: Line Status Register */
> +#define MSR_8251F	0x134	/* In: Modem Status Register */
> +#define IIR_8251F	0x136	/* In: Interrupt ID Register */
> +#define FCR_8251F	0x138	/* I/O: FIFO Control Register */
> +#define IER2_8251F	0x138	/* I/O: Interrupt Enable Register */
> +#define VFAST_8251F	0x13a	/* I/O: VFAST mode Register */
> +
> +#define COMMAND_8251F	0x32	/* Out: 8251 Command Resister */
> +#define IER1_8251F	0x35	/* I/O: Interrupt Enable Register */
> +#define IER1_8251F_COUT	0x37	/* Out: Interrupt Enable Register */
> +
> +#define COMMAND_8251F_DUMMY 0	/* Dummy Command */
> +#define COMMAND_8251F_RESET 0x40 /* Reset Command */
> +
> +#define VFAST_ENABLE	0x80	/* V.Fast mode Enable */
> +
> +/* Interrupt Reason */
> +#define INTR_8251_TXRE	4
> +#define INTR_8251_TXEE	2
> +#define INTR_8251_RXRE	1
> +/* I/O Port */
> +#define PORT_8251_DATA	0
> +#define PORT_8251_CMD	2
> +#define PORT_8251_MOD	2
> +#define PORT_8251_STS	2
> +/* status in */
> +#define STAT_8251_TXRDY	1
> +#define STAT_8251_RXRDY	2
> +#define STAT_8251_TXEMP	4
> +#define STAT_8251_PER	8
> +#define STAT_8251_OER	16
> +#define STAT_8251_FER	32
> +#define STAT_8251_BRK	64
> +#define STAT_8251_DSR	128
> +
> +#endif /* CONFIG_PC9800 */
> +

Same comments as serial.h

-- 
Russell King (rmk@arm.linux.org.uk)                The developer of ARM Linux
             http://www.arm.linux.org.uk/personal/aboutme.html

