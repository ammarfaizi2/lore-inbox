Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932852AbWCRCP4@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932852AbWCRCP4 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 17 Mar 2006 21:15:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932850AbWCRCP4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 17 Mar 2006 21:15:56 -0500
Received: from smtp.osdl.org ([65.172.181.4]:28850 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S932852AbWCRCPz (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 17 Mar 2006 21:15:55 -0500
Date: Fri, 17 Mar 2006 18:13:05 -0800
From: Andrew Morton <akpm@osdl.org>
To: Pat Gefre <pfg@sgi.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] 2.6 Altix : rs422 support for ioc4 serial driver
Message-Id: <20060317181305.2d007447.akpm@osdl.org>
In-Reply-To: <200603171938.k2HJcTDU007298@fsgi900.americas.sgi.com>
References: <200603171938.k2HJcTDU007298@fsgi900.americas.sgi.com>
X-Mailer: Sylpheed version 1.0.4 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Pat Gefre <pfg@sgi.com> wrote:
>
> This patch adds rs422 support to the Altix ioc4 serial driver.
> 
> +
> +#define PORT_IS_ACTIVE(_x, _y)	((_x->ip_flags & PORT_ACTIVE) \
> +					&& (_x->ip_port == _y))
> +

- Forgets to parenthesise macro args

- Evaluates args multiple times

- ugleeeee


This:

/*
 * Nice comment goes here
 */
static inline int port_is_active(struct ioc4_port *current_port,
				struct ioc4_port *my_port)
{
	...
}

Is more pleasing, no?

> +	if (port && PORT_IS_ACTIVE(port, the_port)) {

And in every case the test for port==NULL can be folded into port_is_active().

> +int ioc4_serial_remove_one(struct ioc4_driver_data *idd)

Should have static scope.

> +{
> +	int ii, jj;
> +	struct ioc4_control *control;
> +	struct uart_port *the_port;
> +	struct ioc4_port *port;
> +	struct ioc4_soft *soft;
> +
> +	control = idd->idd_serial_data;
> +
> +	for (ii = 0; ii < IOC4_NUM_SERIAL_PORTS; ii++) {
> +		for (jj = UART_PORT_MIN; jj < UART_PORT_COUNT; jj++) {
> +			the_port = &control->ic_port[ii].icp_uart_port[jj];
> +			if (the_port) {
> +				switch (jj) {
> +				case UART_PORT_RS422:
> +					uart_remove_one_port(&ioc4_uart_rs422,
> +							the_port);
> +					break;
> +				default:
> +				case UART_PORT_RS232:
> +					uart_remove_one_port(&ioc4_uart_rs232,
> +							the_port);
> +					break;
> +				}
> +			}
> +		}
> +		port = control->ic_port[ii].icp_port;
> +		if (!(ii & 1) && port) {
> +			pci_free_consistent(port->ip_pdev,
> +					TOTAL_RING_BUF_SIZE,
> +					(void *)port->ip_cpu_ringbuf,
> +					port->ip_dma_ringbuf);
> +			kfree(port);
> +		}
> +	}

Choosing more meaningful identifiers than `ii' and `jj' would help
understandability here.

> +		free_irq(control->ic_irq, (void *)soft);

The typecast is unneeded.

