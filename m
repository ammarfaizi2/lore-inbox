Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265808AbUAPUcY (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 16 Jan 2004 15:32:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265810AbUAPUcY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 16 Jan 2004 15:32:24 -0500
Received: from hqemgate00.nvidia.com ([216.228.112.144]:55046 "EHLO
	hqemgate00.nvidia.com") by vger.kernel.org with ESMTP
	id S265808AbUAPUcU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 16 Jan 2004 15:32:20 -0500
From: Terence Ripperda <tripperda@nvidia.com>
Reply-To: Terence Ripperda <tripperda@nvidia.com>
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Cc: Terence Ripperda <tripperda@nvidia.com>
Date: Fri, 16 Jan 2004 14:32:03 -0600
From: <tripperda@nvidia.com>
Subject: problem w/ kgdb serial port on 2.6.0 & 2.6.1
Message-ID: <20040116203203.GA1565@hygelac>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="ibTvN161/egqYuK8"
Content-Disposition: inline
User-Agent: Mutt/1.4i
X-Accept-Language: en
X-Operating-System: Linux hrothgar 2.4.19 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--ibTvN161/egqYuK8
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

when trying to use the newest kgdb patches against both 2.6.0 and 2.6.1, I ran into a boot-time kernel oops in the serial port code. this would happen shortly after connecting to a remote gdb, on a Dell M60 laptop.

I don't have the actual oops message anymore, but I have a patch that fixed things for me. not sure if the patch is correct, so here's the info:

the oops happened in serial_core.c:uart_match_port(struct uart_port *port1, struct uart_port *port2). the problem was that port1 was NULL, causing an oops on this code (I've added printks in my file, so the line numbers would be off):

static int uart_match_port(struct uart_port *port1, struct uart_port *port2)
{  
        if (port1->iotype != port2->iotype)
                return 0;

this was called from uart_find_match_or_unused(struct uart_driver *drv, struct uart_port *port), here:

        for (i = 0; i < drv->nr; i++)
                if (uart_match_port(drv->state[i].port, port))
                        return &drv->state[i];


I added printks to get a better idea of what's going on and see this:

Jan 14 23:58:09 localhost kernel: uart_register_driver (will alloc state)
Jan 14 23:58:09 localhost kernel: uart_add_one_port: line 1
Jan 14 23:58:09 localhost kernel: uart_add_one_port: line 3
Jan 14 23:58:09 localhost kernel: uart_add_one_port: line 4
Jan 14 23:58:09 localhost kernel: uart_add_one_port: line 5
Jan 14 23:58:09 localhost kernel: uart_add_one_port: line 6
Jan 14 23:58:09 localhost kernel: uart_add_one_port: line 7

are the ports added supposed to be sequential? it looks like drv->state[i].port is filled in as needed, but uart_find_match_or_unused() seems to expect all drv->state[i] for i = 0 && i < drv->nr.

I "fixed" this in my kernel by adding checks for drv->state[i].port being non-null before trying to use it, and everything works great (patch attached). but I'm not sure if that's the correct solution, or if the ports should be added sequentially instead of as they are. I'm more than happy to run more tests and get more information.

Thanks,
Terence




--ibTvN161/egqYuK8
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="linux-2.6.1_serial_kgdb.patch"

--- serial_core.c	2004-01-16 14:20:15.000000000 -0600
+++ serial_core.c.new	2004-01-16 14:19:43.000000000 -0600
@@ -2304,7 +2304,7 @@
 	 * then we can't register the port.
 	 */
 	for (i = 0; i < drv->nr; i++)
-		if (uart_match_port(drv->state[i].port, port))
+		if (drv->state[i].port && uart_match_port(drv->state[i].port, port))
 			return &drv->state[i];
 
 	/*
@@ -2313,7 +2313,8 @@
 	 * used (indicated by zero iobase).
 	 */
 	for (i = 0; i < drv->nr; i++)
-		if (drv->state[i].port->type == PORT_UNKNOWN &&
+		if (drv->state[i].port &&
+		    drv->state[i].port->type == PORT_UNKNOWN &&
 		    drv->state[i].port->iobase == 0 &&
 		    drv->state[i].count == 0)
 			return &drv->state[i];
@@ -2323,7 +2324,8 @@
 	 * entry which doesn't have a real port associated with it.
 	 */
 	for (i = 0; i < drv->nr; i++)
-		if (drv->state[i].port->type == PORT_UNKNOWN &&
+		if (drv->state[i].port &&
+		    drv->state[i].port->type == PORT_UNKNOWN &&
 		    drv->state[i].count == 0)
 			return &drv->state[i];
 

--ibTvN161/egqYuK8--
