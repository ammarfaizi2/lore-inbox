Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750717AbWI2EhV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750717AbWI2EhV (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 29 Sep 2006 00:37:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751555AbWI2EhV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 29 Sep 2006 00:37:21 -0400
Received: from mail01.verismonetworks.com ([164.164.99.228]:16105 "EHLO
	mail01.verismonetworks.com") by vger.kernel.org with ESMTP
	id S1750717AbWI2EhU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 29 Sep 2006 00:37:20 -0400
Subject: [PATCH] ioremap balanced with iounmap for drivers/serial
From: Amol Lad <amol@verismonetworks.com>
To: linux kernel <linux-kernel@vger.kernel.org>
Content-Type: text/plain
Date: Fri, 29 Sep 2006 10:10:39 +0530
Message-Id: <1159504839.7264.29.camel@amol.verismonetworks.com>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.1 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

ioremap must be balanced by an iounmap and failing to do so can result
in a memory leak.

Tested (compilation only) with:
- Modifying drivers/serial/Kconfig to make sure that the changed file is
compiling without error/warning (due to my changes)

Signed-off-by: Amol Lad <amol@verismonetworks.com>
---
Forwarding to lkml as got no response from linux-serial. (Please CC me)
---
 8250_acorn.c   |    9 +++++----
 8250_gsc.c     |    1 +
 ioc4_serial.c  |    3 +++
 ip22zilog.c    |   16 +++++++++++++++-
 mpc52xx_uart.c |   11 ++++++++++-
 mpsc.c         |   12 ++++++++++++
 mux.c          |    2 ++
 sunsu.c        |    3 +++
 8 files changed, 51 insertions(+), 6 deletions(-)
---
diff -uprN -X linux-2.6.18-orig/Documentation/dontdiff linux-2.6.18-orig/drivers/serial/8250_acorn.c linux-2.6.18/drivers/serial/8250_acorn.c
--- linux-2.6.18-orig/drivers/serial/8250_acorn.c	2006-08-24 02:46:33.000000000 +0530
+++ linux-2.6.18/drivers/serial/8250_acorn.c	2006-09-26 15:26:09.000000000 +0530
@@ -35,6 +35,7 @@ struct serial_card_type {
 struct serial_card_info {
 	unsigned int	num_ports;
 	int		ports[MAX_PORTS];
+	void __iomem *vaddr;
 };
 
 static int __devinit
@@ -44,7 +45,6 @@ serial_card_probe(struct expansion_card 
 	struct serial_card_type *type = id->data;
 	struct uart_port port;
 	unsigned long bus_addr;
-	unsigned char __iomem *virt_addr;
 	unsigned int i;
 
 	info = kmalloc(sizeof(struct serial_card_info), GFP_KERNEL);
@@ -55,8 +55,8 @@ serial_card_probe(struct expansion_card 
 	info->num_ports = type->num_ports;
 
 	bus_addr = ecard_resource_start(ec, type->type);
-	virt_addr = ioremap(bus_addr, ecard_resource_len(ec, type->type));
-	if (!virt_addr) {
+	info->vaddr = ioremap(bus_addr, ecard_resource_len(ec, type->type));
+	if (!info->vaddr) {
 		kfree(info);
 		return -ENOMEM;
 	}
@@ -72,7 +72,7 @@ serial_card_probe(struct expansion_card 
 	port.dev	= &ec->dev;
 
 	for (i = 0; i < info->num_ports; i ++) {
-		port.membase = virt_addr + type->offset[i];
+		port.membase = info->vaddr + type->offset[i];
 		port.mapbase = bus_addr + type->offset[i];
 
 		info->ports[i] = serial8250_register_port(&port);
@@ -92,6 +92,7 @@ static void __devexit serial_card_remove
 		if (info->ports[i] > 0)
 			serial8250_unregister_port(info->ports[i]);
 
+	iounmap(info->vaddr);
 	kfree(info);
 }
 
diff -uprN -X linux-2.6.18-orig/Documentation/dontdiff linux-2.6.18-orig/drivers/serial/8250_gsc.c linux-2.6.18/drivers/serial/8250_gsc.c
--- linux-2.6.18-orig/drivers/serial/8250_gsc.c	2006-08-24 02:46:33.000000000 +0530
+++ linux-2.6.18/drivers/serial/8250_gsc.c	2006-09-26 17:06:16.000000000 +0530
@@ -64,6 +64,7 @@ serial_init_chip(struct parisc_device *d
 	err = serial8250_register_port(&port);
 	if (err < 0) {
 		printk(KERN_WARNING "serial8250_register_port returned error %d\n", err);
+		iounmap(port.membase);
 		return err;
 	}
         
diff -uprN -X linux-2.6.18-orig/Documentation/dontdiff linux-2.6.18-orig/drivers/serial/ioc4_serial.c linux-2.6.18/drivers/serial/ioc4_serial.c
--- linux-2.6.18-orig/drivers/serial/ioc4_serial.c	2006-09-21 10:15:41.000000000 +0530
+++ linux-2.6.18/drivers/serial/ioc4_serial.c	2006-09-26 15:35:30.000000000 +0530
@@ -2685,6 +2685,7 @@ static int ioc4_serial_remove_one(struct
 	if (soft) {
 		free_irq(control->ic_irq, soft);
 		if (soft->is_ioc4_serial_addr) {
+			iounmap(soft->is_ioc4_serial_addr);
 			release_region((unsigned long)
 			     soft->is_ioc4_serial_addr,
 				sizeof(struct ioc4_serial));
@@ -2887,6 +2888,8 @@ out4:
 out3:
 	kfree(control);
 out2:
+	if (serial)
+		iounmap(serial);
 	release_region(tmp_addr1, sizeof(struct ioc4_serial));
 out1:
 
diff -uprN -X linux-2.6.18-orig/Documentation/dontdiff linux-2.6.18-orig/drivers/serial/ip22zilog.c linux-2.6.18/drivers/serial/ip22zilog.c
--- linux-2.6.18-orig/drivers/serial/ip22zilog.c	2006-09-21 10:15:41.000000000 +0530
+++ linux-2.6.18/drivers/serial/ip22zilog.c	2006-09-26 16:42:35.000000000 +0530
@@ -1229,13 +1229,27 @@ static int __init ip22zilog_init(void)
 static void __exit ip22zilog_exit(void)
 {
 	int i;
+	struct uart_ip22zilog_port *up;
 
 	for (i = 0; i < NUM_CHANNELS; i++) {
-		struct uart_ip22zilog_port *up = &ip22zilog_port_table[i];
+		up = &ip22zilog_port_table[i];
 
 		uart_remove_one_port(&ip22zilog_reg, &up->port);
 	}
 
+	/* Free IO mem */
+	up = &ip22zilog_port_table[0];
+	for (i = 0; i < NUM_IP22ZILOG; i++) {
+		if (up[(i * 2) + 0].port.mapbase) {
+		   iounmap((void*)up[(i * 2) + 0].port.mapbase);
+		   up[(i * 2) + 0].port.mapbase = 0;
+		}
+		if (up[(i * 2) + 1].port.mapbase) {
+			iounmap((void*)up[(i * 2) + 1].port.mapbase);
+			up[(i * 2) + 1].port.mapbase = 0;
+		}
+	}
+
 	uart_unregister_driver(&ip22zilog_reg);
 }
 
diff -uprN -X linux-2.6.18-orig/Documentation/dontdiff linux-2.6.18-orig/drivers/serial/mpc52xx_uart.c linux-2.6.18/drivers/serial/mpc52xx_uart.c
--- linux-2.6.18-orig/drivers/serial/mpc52xx_uart.c	2006-09-21 10:15:41.000000000 +0530
+++ linux-2.6.18/drivers/serial/mpc52xx_uart.c	2006-09-26 16:01:14.000000000 +0530
@@ -338,14 +338,23 @@ mpc52xx_uart_release_port(struct uart_po
 static int
 mpc52xx_uart_request_port(struct uart_port *port)
 {
+	int err;
+	
 	if (port->flags & UPF_IOREMAP) /* Need to remap ? */
 		port->membase = ioremap(port->mapbase, MPC52xx_PSC_SIZE);
 
 	if (!port->membase)
 		return -EINVAL;
 
-	return request_mem_region(port->mapbase, MPC52xx_PSC_SIZE,
+	err = request_mem_region(port->mapbase, MPC52xx_PSC_SIZE,
 			"mpc52xx_psc_uart") != NULL ? 0 : -EBUSY;
+
+	if (err && (port->flags & UPF_IOREMAP)) {
+		iounmap(port->membase);
+		port->membase = NULL;
+	}
+
+	return err;
 }
 
 static void
diff -uprN -X linux-2.6.18-orig/Documentation/dontdiff linux-2.6.18-orig/drivers/serial/mpsc.c linux-2.6.18/drivers/serial/mpsc.c
--- linux-2.6.18-orig/drivers/serial/mpsc.c	2006-09-21 10:15:41.000000000 +0530
+++ linux-2.6.18/drivers/serial/mpsc.c	2006-09-26 16:08:19.000000000 +0530
@@ -1893,6 +1893,10 @@ mpsc_drv_map_regs(struct mpsc_port_info 
 	}
 	else {
 		mpsc_resource_err("SDMA base");
+		if (pi->mpsc_base) {
+			iounmap(pi->mpsc_base);
+			pi->mpsc_base = NULL;
+		}
 		return -ENOMEM;
 	}
 
@@ -1905,6 +1909,14 @@ mpsc_drv_map_regs(struct mpsc_port_info 
 	}
 	else {
 		mpsc_resource_err("BRG base");
+		if (pi->mpsc_base) {
+			iounmap(pi->mpsc_base);
+			pi->mpsc_base = NULL;
+		}
+		if (pi->sdma_base) {
+			iounmap(pi->sdma_base);
+			pi->sdma_base = NULL;
+		}
 		return -ENOMEM;
 	}
 
diff -uprN -X linux-2.6.18-orig/Documentation/dontdiff linux-2.6.18-orig/drivers/serial/mux.c linux-2.6.18/drivers/serial/mux.c
--- linux-2.6.18-orig/drivers/serial/mux.c	2006-09-21 10:15:41.000000000 +0530
+++ linux-2.6.18/drivers/serial/mux.c	2006-09-26 16:12:37.000000000 +0530
@@ -521,6 +521,8 @@ static void __exit mux_exit(void)
 
 	for (i = 0; i < port_cnt; i++) {
 		uart_remove_one_port(&mux_driver, &mux_ports[i]);
+		if (mux_ports[i].membase)
+			iounmap(mux_ports[i].membase);
 	}
 
 	uart_unregister_driver(&mux_driver);
diff -uprN -X linux-2.6.18-orig/Documentation/dontdiff linux-2.6.18-orig/drivers/serial/sunsu.c linux-2.6.18/drivers/serial/sunsu.c
--- linux-2.6.18-orig/drivers/serial/sunsu.c	2006-09-21 10:15:41.000000000 +0530
+++ linux-2.6.18/drivers/serial/sunsu.c	2006-09-26 16:22:42.000000000 +0530
@@ -1499,6 +1499,9 @@ static int __devexit su_remove(struct of
 		uart_remove_one_port(&sunsu_reg, &up->port);
 	}
 
+	if (up->port.membase)
+		of_iounmap(up->port.membase, up->reg_size);
+
 	dev_set_drvdata(&dev->dev, NULL);
 
 	return 0;


_______________________________________________
Kernel-janitors mailing list
Kernel-janitors@lists.osdl.org
https://lists.osdl.org/mailman/listinfo/kernel-janitors



