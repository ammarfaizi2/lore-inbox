Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751012AbWEREAw@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751012AbWEREAw (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 18 May 2006 00:00:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750908AbWEREAw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 18 May 2006 00:00:52 -0400
Received: from az33egw01.freescale.net ([192.88.158.102]:63701 "EHLO
	az33egw01.freescale.net") by vger.kernel.org with ESMTP
	id S1750813AbWEREAv convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 18 May 2006 00:00:51 -0400
Message-ID: <9FCDBA58F226D911B202000BDBAD46730626DE5A@zch01exm40.ap.freescale.net>
From: Zang Roy-r61911 <tie-fei.zang@freescale.com>
To: rmk+serial@arm.linux.org.uk
Cc: linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org,
       Paul Mackerras <paulus@samba.org>,
       linuxppc-dev list <linuxppc-dev@ozlabs.org>,
       Alexandre.Bounine@tundra.com,
       Yang Xin-Xin-r48390 <Xin-Xin.Yang@freescale.com>,
       Kumar Gala <galak@kernel.crashing.org>
Subject: RE: [PATCH/2.6.17-rc4 8/10]  Add  tsi108 8250 serial support
Date: Thu, 18 May 2006 12:00:43 +0800
MIME-Version: 1.0
X-Mailer: Internet Mail Service (5.5.2657.72)
Content-Type: text/plain;
	charset="utf-8"
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


-----Original Message-----
From: Kumar Gala [mailto:galak@kernel.crashing.org]
Sent: 2006年5月17日 21:26
To: Zang Roy-r61911
Cc: Paul Mackerras; linuxppc-dev list; Alexandre.Bounine@tundra.com; Yang Xin-Xin-r48390
Subject: Re: [PATCH/2.6.17-rc4 8/10] Add tsi108 8250 serial support



On May 17, 2006, at 5:14 AM, Zang Roy-r61911 wrote:

> This patch contains changes to the serial device driver specific  
> for integrated
> serial port in Tsi108 Host Bridge.
>
> Signed-off-by: Alexandre Bounine <alexandreb@tundra.com>
> Signed-off-by: Roy Zang	<tie-fei.zang@freescale.com>
>
>> From nobody Mon Sep 17 00:00:00 2001
> From: roy zang <tie-fei.zang@freescale.com>
> Date: Tue May 16 15:26:02 2006 +0800
> Subject: [PATCH] Add tsi108 serial support

This patch needs to go to Russell King as uart/8250 driver maintainer.

- kumar

>
> ---
>
>  drivers/serial/8250.c |   17 +++++++++++++++++
>  1 files changed, 17 insertions(+), 0 deletions(-)
>
> 6cb950357e9970afa671d59f172dbc4b03f11560
> diff --git a/drivers/serial/8250.c b/drivers/serial/8250.c
> index bbf78aa..c12f516 100644
> --- a/drivers/serial/8250.c
> +++ b/drivers/serial/8250.c
> @@ -723,7 +723,9 @@ static int broken_efr(struct uart_8250_p
>  static void autoconfig_16550a(struct uart_8250_port *up)
>  {
>  	unsigned char status1, status2;
> +#ifndef CONFIG_TSI108_BRIDGE
>  	unsigned int iersave;
> +#endif
>
>  	up->port.type = PORT_16550A;
>  	up->capabilities |= UART_CAP_FIFO;
> @@ -833,6 +835,7 @@ static void autoconfig_16550a(struct uar
>  	 * trying to write and read a 1 just to make sure it's not
>  	 * already a 1 and maybe locked there before we even start start.
>  	 */
> +#ifndef CONFIG_TSI108_BRIDGE
>  	iersave = serial_in(up, UART_IER);
>  	serial_outp(up, UART_IER, iersave & ~UART_IER_UUE);
>  	if (!(serial_in(up, UART_IER) & UART_IER_UUE)) {
> @@ -859,6 +862,7 @@ static void autoconfig_16550a(struct uar
>  		DEBUG_AUTOCONF("Couldn't force IER_UUE to 0 ");
>  	}
>  	serial_outp(up, UART_IER, iersave);
> +#endif
>  }
>
>  /*
> @@ -1348,7 +1352,12 @@ static irqreturn_t serial8250_interrupt(
>
>  		up = list_entry(l, struct uart_8250_port, list);
>
> +#ifdef CONFIG_TSI108_BRIDGE /* for TSI108_REV_Z1 errata U2 */
> +		/* read IIR as part of 32-bit word */
> +		iir = (in_be32((u32 *)(up->port.membase + UART_RX)) >> 8) & 0xff;
> +#else
>  		iir = serial_in(up, UART_IIR);
> +#endif
>  		if (!(iir & UART_IIR_NO_INT)) {
>  			serial8250_handle_port(up, regs);
>
> @@ -1529,7 +1538,9 @@ static int serial8250_startup(struct uar
>  {
>  	struct uart_8250_port *up = (struct uart_8250_port *)port;
>  	unsigned long flags;
> +#ifndef CONFIG_TSI108_BRIDGE
>  	unsigned char lsr, iir;
> +#endif
>  	int retval;
>
>  	up->capabilities = uart_config[up->port.type].flags;
> @@ -1567,7 +1578,9 @@ #endif
>  	 */
>  	(void) serial_inp(up, UART_LSR);
>  	(void) serial_inp(up, UART_RX);
> +#ifndef CONFIG_TSI108_BRIDGE /* for TSI108_REV_Z1 errata U2 */
>  	(void) serial_inp(up, UART_IIR);
> +#endif
>  	(void) serial_inp(up, UART_MSR);
>
>  	/*
> @@ -1634,6 +1647,7 @@ #endif
>
>  	serial8250_set_mctrl(&up->port, up->port.mctrl);
>
> +#ifndef CONFIG_TSI108_BRIDGE
>  	/*
>  	 * Do a quick test to see if we receive an
>  	 * interrupt when we enable the TX irq.
> @@ -1652,6 +1666,7 @@ #endif
>  	} else {
>  		up->bugs &= ~UART_BUG_TXEN;
>  	}
> +#endif
>
>  	spin_unlock_irqrestore(&up->port.lock, flags);
>
> @@ -1678,7 +1693,9 @@ #endif
>  	 */
>  	(void) serial_inp(up, UART_LSR);
>  	(void) serial_inp(up, UART_RX);
> +#ifndef CONFIG_TSI108_BRIDGE /* for TSI108_REV_Z1 errata U2 */
>  	(void) serial_inp(up, UART_IIR);
> +#endif
>  	(void) serial_inp(up, UART_MSR);
>
>  	return 0;
> -- 
> 1.3.0
> _______________________________________________
> Linuxppc-dev mailing list
> Linuxppc-dev@ozlabs.org
> https://ozlabs.org/mailman/listinfo/linuxppc-dev
