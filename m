Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266100AbUAUROq (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 21 Jan 2004 12:14:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266101AbUAUROq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 21 Jan 2004 12:14:46 -0500
Received: from hqemgate00.nvidia.com ([216.228.112.144]:30989 "EHLO
	hqemgate00.nvidia.com") by vger.kernel.org with ESMTP
	id S266100AbUAUROj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 21 Jan 2004 12:14:39 -0500
From: Terence Ripperda <tripperda@nvidia.com>
Reply-To: Terence Ripperda <tripperda@nvidia.com>
To: George Anzinger <george@mvista.com>
Cc: Terence Ripperda <tripperda@nvidia.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Date: Wed, 21 Jan 2004 11:13:56 -0600
From: <tripperda@nvidia.com>
Subject: Re: problem w/ kgdb serial port on 2.6.0 & 2.6.1
Message-ID: <20040121171356.GB7003@hygelac>
References: <20040116203203.GA1565@hygelac> <400CF7B4.10804@mvista.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <400CF7B4.10804@mvista.com>
User-Agent: Mutt/1.4i
X-Accept-Language: en
X-Operating-System: Linux hrothgar 2.4.19 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


oh, this is with the kgdb from sourceforge. I had the problem with linux-2.6.1-kgdb-2.0.2.tar.bz2 (I'm pretty sure I also had the same problem with an earlier version of kgdb for 2.6.0).

I did catch a backtrace for this issue since my last email:

Program received signal SIGSEGV, Segmentation fault.
0xc02b44d2 in uart_match_port (port1=0x0, port2=0xc18f7e38) at drivers/serial/serial_core.c:2278
2278            if (port1->iotype != port2->iotype)
(gdb) bt
#0  0xc02b44d2 in uart_match_port (port1=0x0, port2=0xc18f7e38)
    at drivers/serial/serial_core.c:2278
#1  0xc02b4559 in uart_find_match_or_unused (drv=0xc049cac0, port=0xc18f7e38)
    at drivers/serial/serial_core.c:2307
#2  0xc02b462d in uart_register_port (drv=0xc049cac0, port=0xc18f7e38)
    at drivers/serial/serial_core.c:2355
#3  0xc02b6895 in __register_serial (req=0xc18f7ef4, line=0xffffffff)
    at drivers/serial/8250.c:2068
#4  0xc02b68aa in register_serial (req=0xc18f7ef4) at drivers/serial/8250.c:2086
#5  0xc02b7778 in serial_pnp_probe (dev=0xc1919400, dev_id=<incomplete type>)
    at drivers/serial/8250_pnp.c:411
#6  0xc02967ad in pnp_device_probe (dev=<incomplete type>) at drivers/pnp/driver.c:119
#7  0xc02bc1ba in bus_match (dev=0xc1919400, drv=<incomplete type>) at drivers/base/bus.c:269
#8  0xc02bc2a0 in driver_attach (drv=<incomplete type>) at drivers/base/bus.c:342
#9  0xc02bc51d in bus_add_driver (drv=<incomplete type>) at drivers/base/bus.c:459
#10 0xc02bc8ca in driver_register (drv=<incomplete type>) at drivers/base/driver.c:91
#11 0xc0296862 in pnp_register_driver (drv=<incomplete type>) at drivers/pnp/driver.c:175
#12 0xc05036f1 in serial8250_pnp_init () at drivers/serial/8250_pnp.c:433
#13 0xc04f46c1 in do_initcalls () at init/main.c:500
#14 0xc18f6000 in ?? ()

Thanks,
Terence

On Tue, Jan 20, 2004 at 01:41:08AM -0800, george@mvista.com wrote:
> Uh, which kgdb?  The one from Andrew's mm tree or the one from souceforge?
> 
> George
> 
> 
> tripperda@nvidia.com wrote:
> >when trying to use the newest kgdb patches against both 2.6.0 and 2.6.1, I 
> >ran into a boot-time kernel oops in the serial port code. this would 
> >happen shortly after connecting to a remote gdb, on a Dell M60 laptop.
> >
> >I don't have the actual oops message anymore, but I have a patch that 
> >fixed things for me. not sure if the patch is correct, so here's the info:
> >
> >the oops happened in serial_core.c:uart_match_port(struct uart_port 
> >*port1, struct uart_port *port2). the problem was that port1 was NULL, 
> >causing an oops on this code (I've added printks in my file, so the line 
> >numbers would be off):
> >
> >static int uart_match_port(struct uart_port *port1, struct uart_port 
> >*port2)
> >{  
> >        if (port1->iotype != port2->iotype)
> >                return 0;
> >
> >this was called from uart_find_match_or_unused(struct uart_driver *drv, 
> >struct uart_port *port), here:
> >
> >        for (i = 0; i < drv->nr; i++)
> >                if (uart_match_port(drv->state[i].port, port))
> >                        return &drv->state[i];
> >
> >
> >I added printks to get a better idea of what's going on and see this:
> >
> >Jan 14 23:58:09 localhost kernel: uart_register_driver (will alloc state)
> >Jan 14 23:58:09 localhost kernel: uart_add_one_port: line 1
> >Jan 14 23:58:09 localhost kernel: uart_add_one_port: line 3
> >Jan 14 23:58:09 localhost kernel: uart_add_one_port: line 4
> >Jan 14 23:58:09 localhost kernel: uart_add_one_port: line 5
> >Jan 14 23:58:09 localhost kernel: uart_add_one_port: line 6
> >Jan 14 23:58:09 localhost kernel: uart_add_one_port: line 7
> >
> >are the ports added supposed to be sequential? it looks like 
> >drv->state[i].port is filled in as needed, but uart_find_match_or_unused() 
> >seems to expect all drv->state[i] for i = 0 && i < drv->nr.
> >
> >I "fixed" this in my kernel by adding checks for drv->state[i].port being 
> >non-null before trying to use it, and everything works great (patch 
> >attached). but I'm not sure if that's the correct solution, or if the 
> >ports should be added sequentially instead of as they are. I'm more than 
> >happy to run more tests and get more information.
> >
> >Thanks,
> >Terence
> >
> >
> >
> >
> >
> >------------------------------------------------------------------------
> >
> >--- serial_core.c	2004-01-16 14:20:15.000000000 -0600
> >+++ serial_core.c.new	2004-01-16 14:19:43.000000000 -0600
> >@@ -2304,7 +2304,7 @@
> > 	 * then we can't register the port.
> > 	 */
> > 	for (i = 0; i < drv->nr; i++)
> >-		if (uart_match_port(drv->state[i].port, port))
> >+		if (drv->state[i].port && 
> >uart_match_port(drv->state[i].port, port))
> > 			return &drv->state[i];
> > 
> > 	/*
> >@@ -2313,7 +2313,8 @@
> > 	 * used (indicated by zero iobase).
> > 	 */
> > 	for (i = 0; i < drv->nr; i++)
> >-		if (drv->state[i].port->type == PORT_UNKNOWN &&
> >+		if (drv->state[i].port &&
> >+		    drv->state[i].port->type == PORT_UNKNOWN &&
> > 		    drv->state[i].port->iobase == 0 &&
> > 		    drv->state[i].count == 0)
> > 			return &drv->state[i];
> >@@ -2323,7 +2324,8 @@
> > 	 * entry which doesn't have a real port associated with it.
> > 	 */
> > 	for (i = 0; i < drv->nr; i++)
> >-		if (drv->state[i].port->type == PORT_UNKNOWN &&
> >+		if (drv->state[i].port &&
> >+		    drv->state[i].port->type == PORT_UNKNOWN &&
> > 		    drv->state[i].count == 0)
> > 			return &drv->state[i];
> > 
> 
> -- 
> George Anzinger   george@mvista.com
> High-res-timers:  http://sourceforge.net/projects/high-res-timers/
> Preemption patch: http://www.kernel.org/pub/linux/kernel/people/rml
