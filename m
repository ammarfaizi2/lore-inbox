Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268771AbUJFH1P@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268771AbUJFH1P (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 6 Oct 2004 03:27:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268889AbUJFH1P
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 6 Oct 2004 03:27:15 -0400
Received: from caramon.arm.linux.org.uk ([212.18.232.186]:33290 "EHLO
	caramon.arm.linux.org.uk") by vger.kernel.org with ESMTP
	id S268771AbUJFH1J (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 6 Oct 2004 03:27:09 -0400
Date: Wed, 6 Oct 2004 08:26:59 +0100
From: Russell King <rmk+lkml@arm.linux.org.uk>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: Linux Kernel list <linux-kernel@vger.kernel.org>,
       linuxppc64-dev <linuxppc64-dev@ozlabs.org>
Subject: Re: [RFC][PATCH] Way for platforms to alter built-in serial ports
Message-ID: <20041006082658.A18379@flint.arm.linux.org.uk>
Mail-Followup-To: Benjamin Herrenschmidt <benh@kernel.crashing.org>,
	Linux Kernel list <linux-kernel@vger.kernel.org>,
	linuxppc64-dev <linuxppc64-dev@ozlabs.org>
References: <1096534248.32721.36.camel@gaston>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <1096534248.32721.36.camel@gaston>; from benh@kernel.crashing.org on Thu, Sep 30, 2004 at 06:50:48PM +1000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 30, 2004 at 06:50:48PM +1000, Benjamin Herrenschmidt wrote:
> +#ifndef ARCH_HAS_GET_LEGACY_SERIAL_PORTS
>  static struct old_serial_port old_serial_port[] = {
>  	SERIAL_PORT_DFNS /* defined in asm/serial.h */
>  };
> -
> +static inline struct old_serial_port *get_legacy_serial_ports(unsigned int *count)
> +{
> +	*count = ARRAY_SIZE(old_serial_port);
> +	return old_serial_port;
> +}
>  #define UART_NR	(ARRAY_SIZE(old_serial_port) + CONFIG_SERIAL_8250_NR_UARTS)
> +#endif /* ARCH_HAS_GET_LEGACY_SERIAL_PORTS */
> +

What happens if 8250.c is built as a module and
ARCH_HAS_GET_LEGACY_SERIAL_PORTS is defined?

> diff -urN linux-2.5/include/linux/serial.h linux-maple/include/linux/serial.h
> --- linux-2.5/include/linux/serial.h	2004-09-30 18:31:55.867785437 +1000
> +++ linux-maple/include/linux/serial.h	2004-09-30 15:36:57.981697919 +1000
> @@ -14,6 +14,21 @@
>  #include <asm/page.h>
>  
>  /*
> + * Definition of a legacy serial port
> + */
> +struct old_serial_port {
> +	unsigned int uart;
> +	unsigned int baud_base;
> +	unsigned int port;
> +	unsigned int irq;
> +	unsigned int flags;
> +	unsigned char hub6;
> +	unsigned char io_type;
> +	unsigned char *iomem_base;
> +	unsigned short iomem_reg_shift;
> +};
> +
> +/*
>   * Counters of the input lines (CTS, DSR, RI, CD) interrupts
>   */

serial.h is used by userspace programs.  We should not expose this
structure to those programs.  Instead, maybe creating an 8250.h
header, or even moving the existing 8250.h header ?

-- 
Russell King
 Linux kernel    2.6 ARM Linux   - http://www.arm.linux.org.uk/
 maintainer of:  2.6 PCMCIA      - http://pcmcia.arm.linux.org.uk/
                 2.6 Serial core
