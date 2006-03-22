Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932103AbWCVWPj@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932103AbWCVWPj (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 22 Mar 2006 17:15:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751225AbWCVWOh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 22 Mar 2006 17:14:37 -0500
Received: from omx1-ext.sgi.com ([192.48.179.11]:44504 "EHLO
	omx1.americas.sgi.com") by vger.kernel.org with ESMTP
	id S1750743AbWCVWOR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 22 Mar 2006 17:14:17 -0500
Date: Wed, 22 Mar 2006 16:14:12 -0600 (CST)
From: Pat Gefre <pfg@americas.sgi.com>
To: Andrew Morton <akpm@osdl.org>
cc: Pat Gefre <pfg@sgi.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] 2.6 Altix : rs422 support for ioc4 serial driver
In-Reply-To: <20060317181305.2d007447.akpm@osdl.org>
Message-ID: <Pine.SGI.3.96.1060322160909.25095A-100000@fsgi900.americas.sgi.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


At the bottom of the email is the 'fix-up' patch to address these points.

I also threw in a few more things that needed improving (better local
names, unneeded void *'ing)..



On Fri, 17 Mar 2006, Andrew Morton wrote:

+ Pat Gefre <pfg@sgi.com> wrote:
+ >
+ > This patch adds rs422 support to the Altix ioc4 serial driver.
+ > 
+ > +
+ > +#define PORT_IS_ACTIVE(_x, _y)	((_x->ip_flags & PORT_ACTIVE) \
+ > +					&& (_x->ip_port == _y))
+ > +
+ 
+ - Forgets to parenthesise macro args
+ 
+ - Evaluates args multiple times
+ 
+ - ugleeeee
+ 
+ 
+ This:
+ 
+ /*
+  * Nice comment goes here
+  */
+ static inline int port_is_active(struct ioc4_port *current_port,
+ 				struct ioc4_port *my_port)
+ {
+ 	...
+ }
+ 
+ Is more pleasing, no?
+ 
+ > +	if (port && PORT_IS_ACTIVE(port, the_port)) {
+ 
+ And in every case the test for port==NULL can be folded into port_is_active().
+ 
+ > +int ioc4_serial_remove_one(struct ioc4_driver_data *idd)
+ 
+ Should have static scope.
+ 
+ > +{
+ > +	int ii, jj;
+ > +	struct ioc4_control *control;
+ > +	struct uart_port *the_port;
+ > +	struct ioc4_port *port;
+ > +	struct ioc4_soft *soft;
+ > +
+ > +	control = idd->idd_serial_data;
+ > +
+ > +	for (ii = 0; ii < IOC4_NUM_SERIAL_PORTS; ii++) {
+ > +		for (jj = UART_PORT_MIN; jj < UART_PORT_COUNT; jj++) {
+ > +			the_port = &control->ic_port[ii].icp_uart_port[jj];
+ > +			if (the_port) {
+ > +				switch (jj) {
+ > +				case UART_PORT_RS422:
+ > +					uart_remove_one_port(&ioc4_uart_rs422,
+ > +							the_port);
+ > +					break;
+ > +				default:
+ > +				case UART_PORT_RS232:
+ > +					uart_remove_one_port(&ioc4_uart_rs232,
+ > +							the_port);
+ > +					break;
+ > +				}
+ > +			}
+ > +		}
+ > +		port = control->ic_port[ii].icp_port;
+ > +		if (!(ii & 1) && port) {
+ > +			pci_free_consistent(port->ip_pdev,
+ > +					TOTAL_RING_BUF_SIZE,
+ > +					(void *)port->ip_cpu_ringbuf,
+ > +					port->ip_dma_ringbuf);
+ > +			kfree(port);
+ > +		}
+ > +	}
+ 
+ Choosing more meaningful identifiers than `ii' and `jj' would help
+ understandability here.
+ 
+ > +		free_irq(control->ic_irq, (void *)soft);
+ 
+ The typecast is unneeded.
+ 




 ioc4_serial.c |  108 +++++++++++++++++++++++++++++++++++-----------------------
 1 files changed, 66 insertions(+), 42 deletions(-)


Signed-off-by: Patrick Gefre <pfg@sgi.com>


Index: linux-2.6/drivers/serial/ioc4_serial.c
===================================================================
--- linux-2.6.orig/drivers/serial/ioc4_serial.c	2006-03-17 08:47:48.000000000 -0600
+++ linux-2.6/drivers/serial/ioc4_serial.c	2006-03-22 14:18:15.946119707 -0600
@@ -514,9 +514,6 @@
 #define PORT_ACTIVE	0x10
 #define PORT_INACTIVE	0	/* This is the value when "off" */
 
-#define PORT_IS_ACTIVE(_x, _y)	((_x->ip_flags & PORT_ACTIVE) \
-					&& (_x->ip_port == _y))
-
 
 /* Since each port has different register offsets and bitmasks
  * for everything, we'll store those that we need in tables so we
@@ -638,6 +635,23 @@
 static void receive_chars(struct uart_port *);
 static void handle_intr(void *arg, uint32_t sio_ir);
 
+/*
+ * port_is_active - determines if this port is currently active
+ * @port: ptr to soft struct for this port
+ * @uart_port: uart port to test for
+ */
+static inline int port_is_active(struct ioc4_port *port,
+		struct uart_port *uart_port)
+{
+	if (port) {
+		if ((port->ip_flags & PORT_ACTIVE)
+					&& (port->ip_port == uart_port))
+			return 1;
+	}
+	return 0;
+}
+
+
 /**
  * write_ireg - write the interrupt regs
  * @ioc4_soft: ptr to soft struct for this port
@@ -730,19 +744,22 @@
 	struct ioc4_driver_data *idd = dev_get_drvdata(the_port->dev);
 	struct ioc4_control *control = idd->idd_serial_data;
 	struct ioc4_port *port;
-	int ii, jj;
+	int port_num, port_type;
 
 	if (control) {
-		for ( ii = 0; ii < IOC4_NUM_SERIAL_PORTS; ii++ ) {
-			port = control->ic_port[ii].icp_port;
+		for ( port_num = 0; port_num < IOC4_NUM_SERIAL_PORTS;
+							port_num++ ) {
+			port = control->ic_port[port_num].icp_port;
 			if (!port)
 				continue;
-			for (jj = UART_PORT_MIN; jj < UART_PORT_COUNT; jj++) {
-				if (the_port == port->ip_all_ports[jj]) {
+			for (port_type = UART_PORT_MIN;
+						port_type < UART_PORT_COUNT;
+						port_type++) {
+				if (the_port == port->ip_all_ports
+							[port_type]) {
 					/* set local copy */
 					if (set) {
-						port->ip_port
-						      = port->ip_all_ports[jj];
+						port->ip_port = the_port;
 					}
 					return port;
 				}
@@ -980,7 +997,7 @@
 	int xx, num_intrs = 0;
 	int intr_type;
 	int handled = 0;
-	struct ioc4_intr_info *ii;
+	struct ioc4_intr_info *intr_info;
 
 	soft = arg;
 	for (intr_type = 0; intr_type < IOC4_NUM_INTR_TYPES; intr_type++) {
@@ -993,13 +1010,13 @@
 		 * which interrupt bits are set.
 		 */
 		for (xx = 0; xx < num_intrs; xx++) {
-			ii = &soft->is_intr_type[intr_type].is_intr_info[xx];
-			if ((this_mir = this_ir & ii->sd_bits)) {
+			intr_info = &soft->is_intr_type[intr_type].is_intr_info[xx];
+			if ((this_mir = this_ir & intr_info->sd_bits)) {
 				/* Disable owned interrupts, call handler */
 				handled++;
-				write_ireg(soft, ii->sd_bits, IOC4_W_IEC,
+				write_ireg(soft, intr_info->sd_bits, IOC4_W_IEC,
 								intr_type);
-				ii->sd_intr(ii->sd_info, this_mir);
+				intr_info->sd_intr(intr_info->sd_info, this_mir);
 				this_ir &= ~this_mir;
 			}
 		}
@@ -2376,7 +2393,7 @@
 	struct ioc4_port *port = get_ioc4_port(the_port, 0);
 	unsigned int ret = 0;
 
-	if (port && PORT_IS_ACTIVE(port, the_port)) {
+	if (port_is_active(port, the_port)) {
 		if (readl(&port->ip_serial_regs->shadow) & IOC4_SHADOW_TEMT)
 			ret = TIOCSER_TEMT;
 	}
@@ -2392,7 +2409,7 @@
 {
 	struct ioc4_port *port = get_ioc4_port(the_port, 0);
 
-	if (port && PORT_IS_ACTIVE(port, the_port))
+	if (port_is_active(port, the_port))
 		set_notification(port, N_OUTPUT_LOWAT, 0);
 }
 
@@ -2446,7 +2463,7 @@
 	struct ioc4_port *port;
 
 	port = get_ioc4_port(the_port, 0);
-	if (!port || !PORT_IS_ACTIVE(port, the_port))
+	if (!port_is_active(port, the_port))
 		return;
 
 	if (mctrl & TIOCM_RTS)
@@ -2474,7 +2491,7 @@
 	uint32_t shadow;
 	unsigned int ret = 0;
 
-	if (!port || !PORT_IS_ACTIVE(port, the_port))
+	if (!port_is_active(port, the_port))
 		return 0;
 
 	shadow = readl(&port->ip_serial_regs->shadow);
@@ -2496,7 +2513,7 @@
 {
 	struct ioc4_port *port = get_ioc4_port(the_port, 0);
 
-	if (port && PORT_IS_ACTIVE(port, the_port)) {
+	if (port_is_active(port, the_port)) {
 		set_notification(port, N_OUTPUT_LOWAT, 1);
 		enable_intrs(port, port->ip_hooks->intr_tx_mt);
 	}
@@ -2621,9 +2638,9 @@
  * @idd: IOC4 master module data for this IOC4
  */
 
-int ioc4_serial_remove_one(struct ioc4_driver_data *idd)
+static int ioc4_serial_remove_one(struct ioc4_driver_data *idd)
 {
-	int ii, jj;
+	int port_num, port_type;
 	struct ioc4_control *control;
 	struct uart_port *the_port;
 	struct ioc4_port *port;
@@ -2631,11 +2648,14 @@
 
 	control = idd->idd_serial_data;
 
-	for (ii = 0; ii < IOC4_NUM_SERIAL_PORTS; ii++) {
-		for (jj = UART_PORT_MIN; jj < UART_PORT_COUNT; jj++) {
-			the_port = &control->ic_port[ii].icp_uart_port[jj];
+	for (port_num = 0; port_num < IOC4_NUM_SERIAL_PORTS; port_num++) {
+		for (port_type = UART_PORT_MIN;
+					port_type < UART_PORT_COUNT;
+					port_type++) {
+			the_port = &control->ic_port[port_num].icp_uart_port
+							[port_type];
 			if (the_port) {
-				switch (jj) {
+				switch (port_type) {
 				case UART_PORT_RS422:
 					uart_remove_one_port(&ioc4_uart_rs422,
 							the_port);
@@ -2648,18 +2668,19 @@
 				}
 			}
 		}
-		port = control->ic_port[ii].icp_port;
-		if (!(ii & 1) && port) {
+		port = control->ic_port[port_num].icp_port;
+		/* we allocate in pairs */
+		if (!(port_num & 1) && port) {
 			pci_free_consistent(port->ip_pdev,
 					TOTAL_RING_BUF_SIZE,
-					(void *)port->ip_cpu_ringbuf,
+					port->ip_cpu_ringbuf,
 					port->ip_dma_ringbuf);
 			kfree(port);
 		}
 	}
 	soft = control->ic_soft;
 	if (soft) {
-		free_irq(control->ic_irq, (void *)soft);
+		free_irq(control->ic_irq, soft);
 		if (soft->is_ioc4_serial_addr) {
 			release_region((unsigned long)
 			     soft->is_ioc4_serial_addr,
@@ -2686,8 +2707,8 @@
 	struct uart_port *the_port;
 	struct ioc4_driver_data *idd = pci_get_drvdata(pdev);
 	struct ioc4_control *control = idd->idd_serial_data;
-	int ii;
-	int port_index;
+	int port_num;
+	int port_type_idx;
 	struct uart_driver *u_driver;
 
 
@@ -2697,17 +2718,18 @@
 	if (!control)
 		return -ENODEV;
 
-	port_index = (port_type == PROTO_RS232) ? UART_PORT_RS232
+	port_type_idx = (port_type == PROTO_RS232) ? UART_PORT_RS232
 						: UART_PORT_RS422;
 
 	u_driver = (port_type == PROTO_RS232)	? &ioc4_uart_rs232
 						: &ioc4_uart_rs422;
 
 	/* once around for each port on this card */
-	for (ii = 0; ii < IOC4_NUM_SERIAL_PORTS; ii++) {
-		the_port = &control->ic_port[ii].icp_uart_port[port_index];
-		port = control->ic_port[ii].icp_port;
-		port->ip_all_ports[port_index] = the_port;
+	for (port_num = 0; port_num < IOC4_NUM_SERIAL_PORTS; port_num++) {
+		the_port = &control->ic_port[port_num].icp_uart_port
+							[port_type_idx];
+		port = control->ic_port[port_num].icp_port;
+		port->ip_all_ports[port_type_idx] = the_port;
 
 		DPRINT_CONFIG(("%s: attach the_port 0x%p / port 0x%p : type %s\n",
 				__FUNCTION__, (void *)the_port,
@@ -2716,8 +2738,8 @@
 
 		/* membase, iobase and mapbase just need to be non-0 */
 		the_port->membase = (unsigned char __iomem *)1;
-		the_port->iobase = (pdev->bus->number << 16) |  ii;
-		the_port->line = (Num_of_ioc4_cards << 2) | ii;
+		the_port->iobase = (pdev->bus->number << 16) |  port_num;
+		the_port->line = (Num_of_ioc4_cards << 2) | port_num;
 		the_port->mapbase = port_type;
 		the_port->type = PORT_16550A;
 		the_port->fifosize = IOC4_FIFO_CHARS;
@@ -2753,7 +2775,8 @@
 	int ret = 0;
 
 
-	DPRINT_CONFIG(("%s (0x%p, 0x%p)\n", __FUNCTION__, idd->idd_pdev, idd->idd_pci_id));
+	DPRINT_CONFIG(("%s (0x%p, 0x%p)\n", __FUNCTION__, idd->idd_pdev,
+							idd->idd_pci_id));
 
 	/* request serial registers */
 	tmp_addr1 = idd->idd_bar0 + IOC4_SERIAL_OFFSET;
@@ -2775,7 +2798,8 @@
 		goto out2;
 	}
 	DPRINT_CONFIG(("%s : mem 0x%p, serial 0x%p\n",
-				__FUNCTION__, (void *)idd->idd_misc_regs, (void *)serial));
+				__FUNCTION__, (void *)idd->idd_misc_regs,
+				(void *)serial));
 
 	/* Get memory for the new card */
 	control = kmalloc(sizeof(struct ioc4_control), GFP_KERNEL);
@@ -2823,7 +2847,7 @@
 
 	/* Hook up interrupt handler */
 	if (!request_irq(idd->idd_pdev->irq, ioc4_intr, SA_SHIRQ,
-				"sgi-ioc4serial", (void *)soft)) {
+				"sgi-ioc4serial", soft)) {
 		control->ic_irq = idd->idd_pdev->irq;
 	} else {
 		printk(KERN_WARNING


