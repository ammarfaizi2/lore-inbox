Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266409AbUGPTDY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266409AbUGPTDY (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 16 Jul 2004 15:03:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266549AbUGPTDY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 16 Jul 2004 15:03:24 -0400
Received: from gate.crashing.org ([63.228.1.57]:1675 "EHLO gate.crashing.org")
	by vger.kernel.org with ESMTP id S266409AbUGPTDR (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 16 Jul 2004 15:03:17 -0400
Subject: Re: [PATCH] pmac_zilog: insert correct failure path for device
	numbers being taken
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: David Eger <eger@havoc.gtf.org>
Cc: Linux Kernel list <linux-kernel@vger.kernel.org>
In-Reply-To: <20040716185832.GA8750@havoc.gtf.org>
References: <20040712075113.GB19875@havoc.gtf.org>
	 <20040712082104.GA22366@havoc.gtf.org>
	 <20040712220935.GA20049@havoc.gtf.org>
	 <20040713003935.GA1050@havoc.gtf.org> <1089692194.1845.38.camel@gaston>
	 <20040716185832.GA8750@havoc.gtf.org>
Content-Type: text/plain
Message-Id: <1090004491.2933.91.camel@gaston>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 
Date: Fri, 16 Jul 2004 15:01:31 -0400
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> By the time pmac_zilog gets there, the ports it requests are already
> reserved.  Unfortunately, init_pmz() doesn't check if pmz_register()
> succeeded or not, and so it merrily goes on to register the driver with
> the power management subsystem, handing it a half-initialized driver.

Excellent !

> The attached patch removes my previous patch-over-the-symptom and provides
> a proper failure path.
> 
> Now this begs the question: shouldn't you be able to use multiple serial 
> devices?  If so, why not code register_chrdev_region() to search for the
> next set of free minors?  Or (more apt), have a new call 
> register_chrdev_region_search() that asks for a set of X  free minors 
> anywhere above some value.  Comments?

Well... I think the problem is that the serial core doesn't deal with
that, and the other drivers should be fixed too if they had to deal with
a different set of minors (an offset basically). Russel didn't want to
do that when I asked him...

I'll talk to him at KS/OLS and see if we can come up with some solution,
this is actually a regression since 2.4 could "offset" macserial, so we
could accomodate, for example, a driver for a pcmcia modem _and_ the
zilog ports.

> -dte
> 
> For reference, the pmac_zilog path goes like this:
> 
> init_pmz: 
> -> pmz_probe:
> --> pmz_init_port:
> ---> ioremap() mem for ports
> -> pmz_register:
> --> uart_registeri_driver(.major=TTY_MAJOR, .minor=64, .nr=pmz_ports_count)
> ---> alloc_tty_driver:
> ---> tty_set_operations:
> ----> tty_register_driver:
> -----> register_chrdev_region(.from = MKDEV(major,minor), nr, "ttyS")
> 	for x in major + as many majors as we need for that many ports, do:
> 	/* p.s. is this a bug? why would a driver reserve more than one
> 	 * major's worth of dev entries? */
> 		__register_chrdev_region:
> 			(.major=TTY_MAJOR+x, 
> 			 .baseminor=64, 
> 			 .minorct="how many we still need to alloc", 
> 			 .name="ttyS")
> ********* THIS BIT SKIPPED BY ERROR HANDLING *********
> -->  for i in ports:
>        uart_add_one_port(.major=TTY_MAJOR, .minor=64, .nr=pmz_ports_count)
> ----> spin_lock_init(&port->lock)
> ----> uart_configure_port(drv, state, port)
> ----> tty_register_device(drv->tty_driver, port->line, port->dev)
> ********* END THIS BIT SKIPPED BY ERROR HANDLING *****
> -> macio_register_driver:
> --> driver_register:
> ---> bus_add_driver:
> 
> Signed-off-by: David Eger <eger@havoc.gtf.org>
> 
> diff -Nru a/drivers/serial/pmac_zilog.c b/drivers/serial/pmac_zilog.c
> --- a/drivers/serial/pmac_zilog.c	2004-07-16 14:48:01 -04:00
> +++ b/drivers/serial/pmac_zilog.c	2004-07-16 14:48:01 -04:00
> @@ -1433,6 +1433,7 @@
>  			ioremap(np->addrs[np->n_addrs - 1].address, 0x1000);
>  		if (uap->rx_dma_regs == NULL) {	
>  			iounmap((void *)uap->tx_dma_regs);
> +			uap->tx_dma_regs = NULL;
>  			uap->flags &= ~PMACZILOG_FLAG_HAS_DMA;
>  			goto no_dma;
>  		}
> @@ -1490,7 +1491,6 @@
>  	uap->port.ops = &pmz_pops;
>  	uap->port.type = PORT_PMAC_ZILOG;
>  	uap->port.flags = 0;
> -	spin_lock_init(&uap->port.lock);
>  
>  	/* Setup some valid baud rate information in the register
>  	 * shadows so we don't write crap there before baud rate is
> @@ -1508,10 +1508,13 @@
>  {
>  	struct device_node *np;
>  
> -	iounmap((void *)uap->control_reg);
>  	np = uap->node;
> +	iounmap((void *)uap->rx_dma_regs);
> +	iounmap((void *)uap->tx_dma_regs);
> +	iounmap((void *)uap->control_reg);
>  	uap->node = NULL;
>  	of_node_put(np);
> +	memset(uap, 0, sizeof(struct uart_pmac_port));
>  }
>  
>  /*
> @@ -1798,7 +1801,7 @@
>  	 * Register this driver with the serial core
>  	 */
>  	rc = uart_register_driver(&pmz_uart_reg);
> -	if (rc != 0)
> +	if (rc != 0) 
>  		return rc;
>  
>  	/*
> @@ -1808,10 +1811,19 @@
>  		struct uart_pmac_port *uport = &pmz_ports[i];
>  		/* NULL node may happen on wallstreet */
>  		if (uport->node != NULL)
> -			uart_add_one_port(&pmz_uart_reg, &uport->port);
> +			rc = uart_add_one_port(&pmz_uart_reg, &uport->port);
> +		if (!rc)
> +			goto err_out;
>  	}
>  
>  	return 0;
> +err_out:
> +	while (i-- > 0) {
> +		struct uart_pmac_port *uport = &pmz_ports[i];
> +		uart_remove_one_port(&pmz_uart_reg, &uport->port);
> +	}
> +	uart_unregister_driver(&pmz_uart_reg);
> +	return rc;
>  }
>  
>  static struct of_match pmz_match[] = 
> @@ -1841,6 +1853,7 @@
>  
>  static int __init init_pmz(void)
>  {
> +	int rc, i;
>  	printk(KERN_INFO "%s\n", version);
>  
>  	/* 
> @@ -1862,7 +1875,16 @@
>  	/*
>  	 * Now we register with the serial layer
>  	 */
> -	pmz_register();
> +	rc = pmz_register();
> +	if (rc) {
> +		printk(KERN_ERR 
> +			"pmac_zilog: Error registering serial device, disabling pmac_zilog.\n"
> +		 	"pmac_zilog: Did another serial driver already claim the minors?\n"); 
> +		/* effectively "pmz_unprobe()" */
> +		for (i=0; i < pmz_ports_count; i++)
> +			pmz_dispose_port(&pmz_ports[i]);
> +		return rc;
> +	}
>  	
>  	/*
>  	 * Then we register the macio driver itself
-- 
Benjamin Herrenschmidt <benh@kernel.crashing.org>

