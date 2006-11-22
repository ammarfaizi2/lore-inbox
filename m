Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1756681AbWKVTMY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756681AbWKVTMY (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 22 Nov 2006 14:12:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756682AbWKVTMY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 22 Nov 2006 14:12:24 -0500
Received: from caramon.arm.linux.org.uk ([217.147.92.249]:270 "EHLO
	caramon.arm.linux.org.uk") by vger.kernel.org with ESMTP
	id S1756681AbWKVTMX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 22 Nov 2006 14:12:23 -0500
Date: Wed, 22 Nov 2006 19:12:17 +0000
From: Russell King <rmk+lkml@arm.linux.org.uk>
To: Burman Yan <yan_952@hotmail.com>
Cc: linux-kernel@vger.kernel.org, trivial@kernel.org
Subject: Re: [PATCH 2.6.19-rc6] serial: replace kmalloc+memset with kzalloc
Message-ID: <20061122191217.GB22601@flint.arm.linux.org.uk>
Mail-Followup-To: Burman Yan <yan_952@hotmail.com>,
	linux-kernel@vger.kernel.org, trivial@kernel.org
References: <BAY20-F16EB95A16D5DB8549DE6A1D8E30@phx.gbl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <BAY20-F16EB95A16D5DB8549DE6A1D8E30@phx.gbl>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 22, 2006 at 08:57:33PM +0200, Burman Yan wrote:
> diff -rubp linux-2.6.19-rc5_orig/drivers/serial/8250_acorn.c linux-2.6.19-rc5_kzalloc/drivers/serial/8250_acorn.c
> --- linux-2.6.19-rc5_orig/drivers/serial/8250_acorn.c	2006-11-09 12:16:21.000000000 +0200
> +++ linux-2.6.19-rc5_kzalloc/drivers/serial/8250_acorn.c	2006-11-11 22:44:04.000000000 +0200
> @@ -47,11 +47,10 @@ serial_card_probe(struct expansion_card 
>  	unsigned long bus_addr;
>  	unsigned int i;
>  
> -	info = kmalloc(sizeof(struct serial_card_info), GFP_KERNEL);
> +	info = kzalloc(sizeof(struct serial_card_info), GFP_KERNEL);
>  	if (!info)
>  		return -ENOMEM;
>  
> -	memset(info, 0, sizeof(struct serial_card_info));
>  	info->num_ports = type->num_ports;
>  
>  	bus_addr = ecard_resource_start(ec, type->type);
> diff -rubp linux-2.6.19-rc5_orig/drivers/serial/8250_pci.c linux-2.6.19-rc5_kzalloc/drivers/serial/8250_pci.c
> --- linux-2.6.19-rc5_orig/drivers/serial/8250_pci.c	2006-11-09 12:16:21.000000000 +0200
> +++ linux-2.6.19-rc5_kzalloc/drivers/serial/8250_pci.c	2006-11-11 22:44:18.000000000 +0200
> @@ -1614,7 +1614,7 @@ pciserial_init_ports(struct pci_dev *dev
>  			nr_ports = rc;
>  	}
>  
> -	priv = kmalloc(sizeof(struct serial_private) +
> +	priv = kzalloc(sizeof(struct serial_private) +
>  		       sizeof(unsigned int) * nr_ports,
>  		       GFP_KERNEL);
>  	if (!priv) {
> @@ -1622,9 +1622,6 @@ pciserial_init_ports(struct pci_dev *dev
>  		goto err_deinit;
>  	}
>  
> -	memset(priv, 0, sizeof(struct serial_private) +
> -			sizeof(unsigned int) * nr_ports);
> -
>  	priv->dev = dev;
>  	priv->quirk = quirk;
>  
> diff -rubp linux-2.6.19-rc5_orig/drivers/serial/serial_core.c linux-2.6.19-rc5_kzalloc/drivers/serial/serial_core.c
> --- linux-2.6.19-rc5_orig/drivers/serial/serial_core.c	2006-11-09 12:16:21.000000000 +0200
> +++ linux-2.6.19-rc5_kzalloc/drivers/serial/serial_core.c	2006-11-11 22:44:04.000000000 +0200
> @@ -1523,9 +1523,8 @@ static struct uart_state *uart_get(struc
>  	}
>  
>  	if (!state->info) {
> -		state->info = kmalloc(sizeof(struct uart_info), GFP_KERNEL);
> +		state->info = kzalloc(sizeof(struct uart_info), GFP_KERNEL);
>  		if (state->info) {
> -			memset(state->info, 0, sizeof(struct uart_info));
>  			init_waitqueue_head(&state->info->open_wait);
>  			init_waitqueue_head(&state->info->delta_msr_wait);
>  
> @@ -2167,13 +2166,11 @@ int uart_register_driver(struct uart_dri
>  	 * Maybe we should be using a slab cache for this, especially if
>  	 * we have a large number of ports to handle.
>  	 */
> -	drv->state = kmalloc(sizeof(struct uart_state) * drv->nr, GFP_KERNEL);
> +	drv->state = kzalloc(sizeof(struct uart_state) * drv->nr, GFP_KERNEL);
>  	retval = -ENOMEM;
>  	if (!drv->state)
>  		goto out;
>  
> -	memset(drv->state, 0, sizeof(struct uart_state) * drv->nr);
> -
>  	normal  = alloc_tty_driver(drv->nr);
>  	if (!normal)
>  		goto out;
> diff -rubp linux-2.6.19-rc5_orig/drivers/serial/serial_cs.c linux-2.6.19-rc5_kzalloc/drivers/serial/serial_cs.c
> --- linux-2.6.19-rc5_orig/drivers/serial/serial_cs.c	2006-11-09 12:16:21.000000000 +0200
> +++ linux-2.6.19-rc5_kzalloc/drivers/serial/serial_cs.c	2006-11-11 22:44:04.000000000 +0200
> @@ -334,10 +334,9 @@ static int serial_probe(struct pcmcia_de
>  	DEBUG(0, "serial_attach()\n");
>  
>  	/* Create new serial device */
> -	info = kmalloc(sizeof (*info), GFP_KERNEL);
> +	info = kzalloc(sizeof (*info), GFP_KERNEL);
>  	if (!info)
>  		return -ENOMEM;
> -	memset(info, 0, sizeof (*info));
>  	info->p_dev = link;
>  	link->priv = info;
>  

The above (and only the above 4 files):

Acked-by: Russell King <rmk+kernel@arm.linux.org.uk>


-- 
Russell King
 Linux kernel    2.6 ARM Linux   - http://www.arm.linux.org.uk/
 maintainer of:
