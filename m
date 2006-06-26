Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751042AbWFZHwT@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751042AbWFZHwT (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 26 Jun 2006 03:52:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932391AbWFZHwT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 26 Jun 2006 03:52:19 -0400
Received: from de01egw02.freescale.net ([192.88.165.103]:37884 "EHLO
	de01egw02.freescale.net") by vger.kernel.org with ESMTP
	id S1751042AbWFZHwS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 26 Jun 2006 03:52:18 -0400
Message-ID: <9FCDBA58F226D911B202000BDBAD467306D425EC@zch01exm40.ap.freescale.net>
From: Zang Roy-r61911 <tie-fei.zang@freescale.com>
To: akpm@osdl.org, rmk@arm.linux.org.uk
Cc: linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org
Subject: RE: [patch 1/2] serial: add tsi108 8250 serial support
Date: Mon, 26 Jun 2006 15:52:11 +0800
MIME-Version: 1.0
X-Mailer: Internet Mail Service (5.5.2657.72)
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


The following patch fixes the tsi108 port report information.
Signed-off-by: Roy Zang	<tie-fei.zang@freescale.com>

--
diff --git a/drivers/serial/serial_core.c b/drivers/serial/serial_core.c
index 17839e7..9d45af1 100644
--- a/drivers/serial/serial_core.c
+++ b/drivers/serial/serial_core.c
@@ -2028,6 +2028,7 @@ uart_report_port(struct uart_driver *drv
 	case UPIO_MEM:
 	case UPIO_MEM32:
 	case UPIO_AU:
+	case UPIO_TSI:
 		snprintf(address, sizeof(address),
 			 "MMIO 0x%lx", port->mapbase);
 		break;

 
> 
> 
> From: Zang Roy-r61911 <tie-fei.zang@freescale.com>
> 
> The following patch gets rid of CONFIG_TSI108_BRIDGE.  I add 
> UPIO_TSI to handle IIR and IER register in serial_in and serial_out.
> 
> (1) the reason to rewrite serial_in:
> 
>     TSI108 rev Z1 version ERRATA.  Reading the UART's Interrupt
>     Identification Register (IIR) clears the Transmit Holding Register
>     Empty (THRE) and Transmit buffer Empty (TEMP) interrupts 
> even if they
>     are not enabled in the Interrupt Enable Register (IER).  
> This leads to
>     loss of the interrupts.  Interrupts are not cleared when 
> reading UART
>     registers as 32-bit word.
> 
> (2) the reason to rewrite serial_out:
> 
>     Check for UART_IER_UUE bit in the autoconfig routine.  
> This section
>     of autoconfig is excluded for Tsi108/109 because bits 7 and 6 are
>     reserved for internal use.  They are R/W bits.  In addition to
>     incorrect identification, changing these bits (from 00) will make
>     Tsi108/109 UART non-functional.
> 
> Cc: Russell King <rmk@arm.linux.org.uk>
> Signed-off-by: Andrew Morton <akpm@osdl.org>
> ---
> 
>  drivers/serial/8250.c       |   12 ++++++++++++
>  include/linux/serial_core.h |    1 +
>  2 files changed, 13 insertions(+)
> 
> diff -puN 
> drivers/serial/8250.c~serial-add-tsi108-8250-serial-support 
> drivers/serial/8250.c
> --- a/drivers/serial/8250.c~serial-add-tsi108-8250-serial-support
> +++ a/drivers/serial/8250.c
> @@ -300,6 +300,7 @@ static inline int map_8250_out_reg(struc
>  
>  static unsigned int serial_in(struct uart_8250_port *up, int 
> offset)  {
> +	unsigned int tmp;
>  	offset = map_8250_in_reg(up, offset) << up->port.regshift;
>  
>  	switch (up->port.iotype) {
> @@ -317,6 +318,13 @@ static unsigned int serial_in(struct uar
>  	case UPIO_AU:
>  		return __raw_readl(up->port.membase + offset);  #endif
> +
> +	case UPIO_TSI:
> +		if (offset == UART_IIR) {
> +			tmp = readl((u32 *)(up->port.membase + 
> UART_RX));
> +			return (cpu_to_le32(tmp) >> 8) & 0xff;
> +		} else
> +			return readb(up->port.membase + offset);
>  
>  	default:
>  		return inb(up->port.iobase + offset); @@ -347,6 
> +355,10 @@ serial_out(struct uart_8250_port *up, in
>  		__raw_writel(value, up->port.membase + offset);
>  		break;
>  #endif
> +	case UPIO_TSI:
> +		if (!((offset == UART_IER) && (value & UART_IER_UUE)))
> +			writeb(value, up->port.membase + offset);
> +		break;
>  
>  	default:
>  		outb(value, up->port.iobase + offset); diff 
> -puN 
> include/linux/serial_core.h~serial-add-tsi108-8250-serial-supp
> ort include/linux/serial_core.h
> --- 
> a/include/linux/serial_core.h~serial-add-tsi108-8250-serial-support
> +++ a/include/linux/serial_core.h
> @@ -223,6 +223,7 @@ struct uart_port {
>  #define UPIO_MEM		(2)
>  #define UPIO_MEM32		(3)
>  #define UPIO_AU			(4)			
> /* Au1x00 type IO */
> +#define UPIO_TSI		(5)			/* 
> Tsi108/109 type IO */
>  
>  	unsigned int		read_status_mask;	/* 
> driver specific */
>  	unsigned int		ignore_status_mask;	/* 
> driver specific */
> _
> 
