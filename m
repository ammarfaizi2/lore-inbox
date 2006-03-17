Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751171AbWCQTih@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751171AbWCQTih (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 17 Mar 2006 14:38:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751207AbWCQTih
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 17 Mar 2006 14:38:37 -0500
Received: from omx1-ext.sgi.com ([192.48.179.11]:10390 "EHLO
	omx1.americas.sgi.com") by vger.kernel.org with ESMTP
	id S1751171AbWCQTif (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 17 Mar 2006 14:38:35 -0500
From: Pat Gefre <pfg@sgi.com>
Message-Id: <200603171938.k2HJcTDU007298@fsgi900.americas.sgi.com>
Subject: [PATCH] 2.6 Altix : rs422 support for ioc4 serial driver
To: linux-kernel@vger.kernel.org
Date: Fri, 17 Mar 2006 13:38:29 -0600 (CST)
Cc: akpm@osdl.org
X-Mailer: ELM [version 2.5 PL2]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



This patch adds rs422 support to the Altix ioc4 serial driver.


 ioc4_serial.c |  335 ++++++++++++++++++++++++++++++++++++----------------------
 1 files changed, 211 insertions(+), 124 deletions(-)


Signed-off-by: Patrick Gefre <pfg@sgi.com>


Index: linux-2.6/drivers/serial/ioc4_serial.c
===================================================================
--- linux-2.6.orig/drivers/serial/ioc4_serial.c	2006-03-09 11:38:36.697103905 -0600
+++ linux-2.6/drivers/serial/ioc4_serial.c	2006-03-17 08:47:48.621553907 -0600
@@ -3,7 +3,7 @@
  * License.  See the file "COPYING" in the main directory of this archive
  * for more details.
  *
- * Copyright (C) 2003-2005 Silicon Graphics, Inc.  All Rights Reserved.
+ * Copyright (C) 2003-2006 Silicon Graphics, Inc.  All Rights Reserved.
  */
 
 
@@ -323,9 +323,12 @@
 #define IOC4_FIFO_CHARS	255
 
 /* Device name we're using */
-#define DEVICE_NAME	"ttyIOC"
-#define DEVICE_MAJOR 204
-#define DEVICE_MINOR 50
+#define DEVICE_NAME_RS232  "ttyIOC"
+#define DEVICE_NAME_RS422  "ttyAIOC"
+#define DEVICE_MAJOR	   204
+#define DEVICE_MINOR_RS232 50
+#define DEVICE_MINOR_RS422 84
+
 
 /* register offsets */
 #define IOC4_SERIAL_OFFSET	0x300
@@ -341,10 +344,8 @@
 #define MAX_BAUD_SUPPORTED	115200
 
 /* protocol types supported */
-enum sio_proto {
-	PROTO_RS232,
-	PROTO_RS422
-};
+#define PROTO_RS232	3
+#define PROTO_RS422	7
 
 /* Notification types */
 #define N_DATA_READY	0x01
@@ -395,11 +396,17 @@
 /*
  * This is the entry saved by the driver - one per card
  */
+
+#define UART_PORT_MIN		0
+#define UART_PORT_RS232		UART_PORT_MIN
+#define UART_PORT_RS422		1
+#define UART_PORT_COUNT		2	/* one for each mode */
+
 struct ioc4_control {
 	int ic_irq;
 	struct {
-		/* uart ports are allocated here */
-		struct uart_port icp_uart_port;
+		/* uart ports are allocated here - 1 for rs232, 1 for rs422 */
+		struct uart_port icp_uart_port[UART_PORT_COUNT];
 		/* Handy reference material */
 		struct ioc4_port *icp_port;
 	} ic_port[IOC4_NUM_SERIAL_PORTS];
@@ -443,7 +450,9 @@
 
 /* Local port info for each IOC4 serial ports */
 struct ioc4_port {
-	struct uart_port *ip_port;
+	struct uart_port *ip_port;	/* current active port ptr */
+	/* Ptrs for all ports */
+	struct uart_port *ip_all_ports[UART_PORT_COUNT];
 	/* Back ptrs for this port */
 	struct ioc4_control *ip_control;
 	struct pci_dev *ip_pdev;
@@ -502,6 +511,12 @@
 #define DCD_ON		0x02
 #define LOWAT_WRITTEN	0x04
 #define READ_ABORTED	0x08
+#define PORT_ACTIVE	0x10
+#define PORT_INACTIVE	0	/* This is the value when "off" */
+
+#define PORT_IS_ACTIVE(_x, _y)	((_x->ip_flags & PORT_ACTIVE) \
+					&& (_x->ip_port == _y))
+
 
 /* Since each port has different register offsets and bitmasks
  * for everything, we'll store those that we need in tables so we
@@ -708,19 +723,30 @@
 /**
  * get_ioc4_port - given a uart port, return the control structure
  * @port: uart port
+ * @set: set this port as current
  */
-static struct ioc4_port *get_ioc4_port(struct uart_port *the_port)
+static struct ioc4_port *get_ioc4_port(struct uart_port *the_port, int set)
 {
 	struct ioc4_driver_data *idd = dev_get_drvdata(the_port->dev);
 	struct ioc4_control *control = idd->idd_serial_data;
-	int ii;
+	struct ioc4_port *port;
+	int ii, jj;
 
 	if (control) {
 		for ( ii = 0; ii < IOC4_NUM_SERIAL_PORTS; ii++ ) {
-			if (!control->ic_port[ii].icp_port)
+			port = control->ic_port[ii].icp_port;
+			if (!port)
 				continue;
-			if (the_port == control->ic_port[ii].icp_port->ip_port)
-				return control->ic_port[ii].icp_port;
+			for (jj = UART_PORT_MIN; jj < UART_PORT_COUNT; jj++) {
+				if (the_port == port->ip_all_ports[jj]) {
+					/* set local copy */
+					if (set) {
+						port->ip_port
+						      = port->ip_all_ports[jj];
+					}
+					return port;
+				}
+			}
 		}
 	}
 	return NULL;
@@ -946,6 +972,7 @@
  * @arg: handler arg
  * @regs: registers
  */
+
 static irqreturn_t ioc4_intr(int irq, void *arg, struct pt_regs *regs)
 {
 	struct ioc4_soft *soft;
@@ -980,7 +1007,6 @@
 #ifdef DEBUG_INTERRUPTS
 	{
 		struct ioc4_misc_regs __iomem *mem = soft->is_ioc4_misc_addr;
-		spinlock_t *lp = &soft->is_ir_lock;
 		unsigned long flag;
 
 		spin_lock_irqsave(&soft->is_ir_lock, flag);
@@ -1177,7 +1203,7 @@
 {
 	int spiniter = 0;
 
-	port->ip_flags = 0;
+	port->ip_flags = PORT_ACTIVE;
 
 	/* Pause the DMA interface if necessary */
 	if (port->ip_sscr & IOC4_SSCR_DMA_EN) {
@@ -1187,6 +1213,7 @@
 				& IOC4_SSCR_PAUSE_STATE) == 0) {
 			spiniter++;
 			if (spiniter > MAXITER) {
+				port->ip_flags = PORT_INACTIVE;
 				return -1;
 			}
 		}
@@ -1506,14 +1533,13 @@
 /**
  * set_mcr - set the master control reg
  * @the_port: port to use
- * @set: set ?
  * @mask1: mcr mask
  * @mask2: shadow mask
  */
-static inline int set_mcr(struct uart_port *the_port, int set,
+static inline int set_mcr(struct uart_port *the_port,
 		int mask1, int mask2)
 {
-	struct ioc4_port *port = get_ioc4_port(the_port);
+	struct ioc4_port *port = get_ioc4_port(the_port, 0);
 	uint32_t shadow;
 	int spiniter = 0;
 	char mcr;
@@ -1536,13 +1562,9 @@
 	mcr = (shadow & 0xff000000) >> 24;
 
 	/* Set new value */
-	if (set) {
-		mcr |= mask1;
-		shadow |= mask2;
-	} else {
-		mcr &= ~mask1;
-		shadow &= ~mask2;
-	}
+	mcr |= mask1;
+	shadow |= mask2;
+
 	writeb(mcr, &port->ip_uart_regs->i4u_mcr);
 	writel(shadow, &port->ip_serial_regs->shadow);
 
@@ -1558,7 +1580,7 @@
  * @port: port to use
  * @proto: protocol to use
  */
-static int ioc4_set_proto(struct ioc4_port *port, enum sio_proto proto)
+static int ioc4_set_proto(struct ioc4_port *port, int proto)
 {
 	struct hooks *hooks = port->ip_hooks;
 
@@ -1589,7 +1611,7 @@
 	int result;
 	char *start;
 	struct tty_struct *tty;
-	struct ioc4_port *port = get_ioc4_port(the_port);
+	struct ioc4_port *port = get_ioc4_port(the_port, 0);
 	struct uart_info *info;
 
 	if (!the_port)
@@ -1645,7 +1667,7 @@
 ioc4_change_speed(struct uart_port *the_port,
 		  struct termios *new_termios, struct termios *old_termios)
 {
-	struct ioc4_port *port = get_ioc4_port(the_port);
+	struct ioc4_port *port = get_ioc4_port(the_port, 0);
 	int baud, bits;
 	unsigned cflag;
 	int new_parity = 0, new_parity_enable = 0, new_stop = 0, new_data = 8;
@@ -1752,7 +1774,7 @@
 	if (!the_port)
 		return -1;
 
-	port = get_ioc4_port(the_port);
+	port = get_ioc4_port(the_port, 0);
 	if (!port)
 		return -1;
 
@@ -1760,6 +1782,9 @@
 
 	local_open(port);
 
+	/* set the protocol - mapbase has the port type */
+	ioc4_set_proto(port, the_port->mapbase);
+
 	/* set the speed of the serial port */
 	ioc4_change_speed(the_port, info->tty->termios, (struct termios *)0);
 
@@ -1768,17 +1793,17 @@
 
 /*
  * ioc4_cb_output_lowat - called when the output low water mark is hit
- * @port: port to output
+ * @the_port: port to output
  */
-static void ioc4_cb_output_lowat(struct ioc4_port *port)
+static void ioc4_cb_output_lowat(struct uart_port *the_port)
 {
 	unsigned long pflags;
 
 	/* ip_lock is set on the call here */
-	if (port->ip_port) {
-		spin_lock_irqsave(&port->ip_port->lock, pflags);
-		transmit_chars(port->ip_port);
-		spin_unlock_irqrestore(&port->ip_port->lock, pflags);
+	if (the_port) {
+		spin_lock_irqsave(&the_port->lock, pflags);
+		transmit_chars(the_port);
+		spin_unlock_irqrestore(&the_port->lock, pflags);
 	}
 }
 
@@ -1923,7 +1948,7 @@
 					&port->ip_mem->sio_ir.raw);
 
 			if (port->ip_notify & N_OUTPUT_LOWAT)
-				ioc4_cb_output_lowat(port);
+				ioc4_cb_output_lowat(port->ip_port);
 		}
 
 		/* Handle tx_mt.  Must come after tx_explicit.  */
@@ -1936,7 +1961,7 @@
 			 * So send the notification now.
 			 */
 			if (port->ip_notify & N_OUTPUT_LOWAT) {
-				ioc4_cb_output_lowat(port);
+				ioc4_cb_output_lowat(port->ip_port);
 
 				/* We need to reload the sio_ir since the lowat
 				 * call may have caused another write to occur,
@@ -2023,7 +2048,7 @@
 				int len)
 {
 	int prod_ptr, cons_ptr, total;
-	struct ioc4_port *port = get_ioc4_port(the_port);
+	struct ioc4_port *port = get_ioc4_port(the_port, 0);
 	struct ring *inring;
 	struct ring_entry *entry;
 	struct hooks *hooks = port->ip_hooks;
@@ -2335,17 +2360,27 @@
  */
 static const char *ic4_type(struct uart_port *the_port)
 {
-	return "SGI IOC4 Serial";
+	if (the_port->mapbase == PROTO_RS232)
+		return "SGI IOC4 Serial [rs232]";
+	else
+		return "SGI IOC4 Serial [rs422]";
 }
 
 /**
- * ic4_tx_empty - Is the transmitter empty?  We pretend we're always empty
- * @port: Port to operate on (we ignore since we always return 1)
+ * ic4_tx_empty - Is the transmitter empty?
+ * @port: Port to operate on
  *
  */
 static unsigned int ic4_tx_empty(struct uart_port *the_port)
 {
-	return 1;
+	struct ioc4_port *port = get_ioc4_port(the_port, 0);
+	unsigned int ret = 0;
+
+	if (port && PORT_IS_ACTIVE(port, the_port)) {
+		if (readl(&port->ip_serial_regs->shadow) & IOC4_SHADOW_TEMT)
+			ret = TIOCSER_TEMT;
+	}
+	return ret;
 }
 
 /**
@@ -2355,6 +2390,10 @@
  */
 static void ic4_stop_tx(struct uart_port *the_port)
 {
+	struct ioc4_port *port = get_ioc4_port(the_port, 0);
+
+	if (port && PORT_IS_ACTIVE(port, the_port))
+		set_notification(port, N_OUTPUT_LOWAT, 0);
 }
 
 /**
@@ -2377,11 +2416,12 @@
 	struct ioc4_port *port;
 	struct uart_info *info;
 
-	port = get_ioc4_port(the_port);
+	port = get_ioc4_port(the_port, 0);
 	if (!port)
 		return;
 
 	info = the_port->info;
+	port->ip_port = NULL;
 
 	wake_up_interruptible(&info->delta_msr_wait);
 
@@ -2390,6 +2430,7 @@
 
 	spin_lock_irqsave(&the_port->lock, port_flags);
 	set_notification(port, N_ALL, 0);
+	port->ip_flags = PORT_INACTIVE;
 	spin_unlock_irqrestore(&the_port->lock, port_flags);
 }
 
@@ -2402,6 +2443,11 @@
 static void ic4_set_mctrl(struct uart_port *the_port, unsigned int mctrl)
 {
 	unsigned char mcr = 0;
+	struct ioc4_port *port;
+
+	port = get_ioc4_port(the_port, 0);
+	if (!port || !PORT_IS_ACTIVE(port, the_port))
+		return;
 
 	if (mctrl & TIOCM_RTS)
 		mcr |= UART_MCR_RTS;
@@ -2414,7 +2460,7 @@
 	if (mctrl & TIOCM_LOOP)
 		mcr |= UART_MCR_LOOP;
 
-	set_mcr(the_port, 1, mcr, IOC4_SHADOW_DTR);
+	set_mcr(the_port, mcr, IOC4_SHADOW_DTR);
 }
 
 /**
@@ -2424,11 +2470,11 @@
  */
 static unsigned int ic4_get_mctrl(struct uart_port *the_port)
 {
-	struct ioc4_port *port = get_ioc4_port(the_port);
+	struct ioc4_port *port = get_ioc4_port(the_port, 0);
 	uint32_t shadow;
 	unsigned int ret = 0;
 
-	if (!port)
+	if (!port || !PORT_IS_ACTIVE(port, the_port))
 		return 0;
 
 	shadow = readl(&port->ip_serial_regs->shadow);
@@ -2448,9 +2494,9 @@
  */
 static void ic4_start_tx(struct uart_port *the_port)
 {
-	struct ioc4_port *port = get_ioc4_port(the_port);
+	struct ioc4_port *port = get_ioc4_port(the_port, 0);
 
-	if (port) {
+	if (port && PORT_IS_ACTIVE(port, the_port)) {
 		set_notification(port, N_OUTPUT_LOWAT, 1);
 		enable_intrs(port, port->ip_hooks->intr_tx_mt);
 	}
@@ -2467,7 +2513,7 @@
 }
 
 /**
- * ic4_startup - Start up the serial port - always return 0 (We're always on)
+ * ic4_startup - Start up the serial port
  * @port: Port to operate on
  *
  */
@@ -2479,17 +2525,16 @@
 	struct uart_info *info;
 	unsigned long port_flags;
 
-	if (!the_port) {
+	if (!the_port)
 		return -ENODEV;
-	}
-	port = get_ioc4_port(the_port);
-	if (!port) {
+	port = get_ioc4_port(the_port, 1);
+	if (!port)
 		return -ENODEV;
-	}
 	info = the_port->info;
 
 	control = port->ip_control;
 	if (!control) {
+		port->ip_port = NULL;
 		return -ENODEV;
 	}
 
@@ -2551,28 +2596,100 @@
  * Boot-time initialization code
  */
 
-static struct uart_driver ioc4_uart = {
+static struct uart_driver ioc4_uart_rs232 = {
+	.owner		= THIS_MODULE,
+	.driver_name	= "ioc4_serial_rs232",
+	.dev_name	= DEVICE_NAME_RS232,
+	.major		= DEVICE_MAJOR,
+	.minor		= DEVICE_MINOR_RS232,
+	.nr		= IOC4_NUM_CARDS * IOC4_NUM_SERIAL_PORTS,
+};
+
+static struct uart_driver ioc4_uart_rs422 = {
 	.owner		= THIS_MODULE,
-	.driver_name	= "ioc4_serial",
-	.dev_name	= DEVICE_NAME,
+	.driver_name	= "ioc4_serial_rs422",
+	.dev_name	= DEVICE_NAME_RS422,
 	.major		= DEVICE_MAJOR,
-	.minor		= DEVICE_MINOR,
+	.minor		= DEVICE_MINOR_RS422,
 	.nr		= IOC4_NUM_CARDS * IOC4_NUM_SERIAL_PORTS,
 };
 
+
 /**
- * ioc4_serial_core_attach - register with serial core
+ * ioc4_serial_remove_one - detach function
+ *
+ * @idd: IOC4 master module data for this IOC4
+ */
+
+int ioc4_serial_remove_one(struct ioc4_driver_data *idd)
+{
+	int ii, jj;
+	struct ioc4_control *control;
+	struct uart_port *the_port;
+	struct ioc4_port *port;
+	struct ioc4_soft *soft;
+
+	control = idd->idd_serial_data;
+
+	for (ii = 0; ii < IOC4_NUM_SERIAL_PORTS; ii++) {
+		for (jj = UART_PORT_MIN; jj < UART_PORT_COUNT; jj++) {
+			the_port = &control->ic_port[ii].icp_uart_port[jj];
+			if (the_port) {
+				switch (jj) {
+				case UART_PORT_RS422:
+					uart_remove_one_port(&ioc4_uart_rs422,
+							the_port);
+					break;
+				default:
+				case UART_PORT_RS232:
+					uart_remove_one_port(&ioc4_uart_rs232,
+							the_port);
+					break;
+				}
+			}
+		}
+		port = control->ic_port[ii].icp_port;
+		if (!(ii & 1) && port) {
+			pci_free_consistent(port->ip_pdev,
+					TOTAL_RING_BUF_SIZE,
+					(void *)port->ip_cpu_ringbuf,
+					port->ip_dma_ringbuf);
+			kfree(port);
+		}
+	}
+	soft = control->ic_soft;
+	if (soft) {
+		free_irq(control->ic_irq, (void *)soft);
+		if (soft->is_ioc4_serial_addr) {
+			release_region((unsigned long)
+			     soft->is_ioc4_serial_addr,
+				sizeof(struct ioc4_serial));
+		}
+		kfree(soft);
+	}
+	kfree(control);
+	idd->idd_serial_data = NULL;
+
+	return 0;
+}
+
+
+/**
+ * ioc4_serial_core_attach_rs232 - register with serial core
  *		This is done during pci probing
  * @pdev: handle for this card
  */
 static inline int
-ioc4_serial_core_attach(struct pci_dev *pdev)
+ioc4_serial_core_attach(struct pci_dev *pdev, int port_type)
 {
 	struct ioc4_port *port;
 	struct uart_port *the_port;
 	struct ioc4_driver_data *idd = pci_get_drvdata(pdev);
 	struct ioc4_control *control = idd->idd_serial_data;
 	int ii;
+	int port_index;
+	struct uart_driver *u_driver;
+
 
 	DPRINT_CONFIG(("%s: attach pdev 0x%p - control 0x%p\n",
 			__FUNCTION__, pdev, (void *)control));
@@ -2580,28 +2697,35 @@
 	if (!control)
 		return -ENODEV;
 
+	port_index = (port_type == PROTO_RS232) ? UART_PORT_RS232
+						: UART_PORT_RS422;
+
+	u_driver = (port_type == PROTO_RS232)	? &ioc4_uart_rs232
+						: &ioc4_uart_rs422;
+
 	/* once around for each port on this card */
 	for (ii = 0; ii < IOC4_NUM_SERIAL_PORTS; ii++) {
-		the_port = &control->ic_port[ii].icp_uart_port;
+		the_port = &control->ic_port[ii].icp_uart_port[port_index];
 		port = control->ic_port[ii].icp_port;
-		port->ip_port = the_port;
+		port->ip_all_ports[port_index] = the_port;
 
-		DPRINT_CONFIG(("%s: attach the_port 0x%p / port 0x%p\n",
+		DPRINT_CONFIG(("%s: attach the_port 0x%p / port 0x%p : type %s\n",
 				__FUNCTION__, (void *)the_port,
-				(void *)port));
+				(void *)port,
+				port_type == PROTO_RS232 ? "rs232" : "rs422"));
 
 		/* membase, iobase and mapbase just need to be non-0 */
 		the_port->membase = (unsigned char __iomem *)1;
 		the_port->iobase = (pdev->bus->number << 16) |  ii;
 		the_port->line = (Num_of_ioc4_cards << 2) | ii;
-		the_port->mapbase = 1;
+		the_port->mapbase = port_type;
 		the_port->type = PORT_16550A;
 		the_port->fifosize = IOC4_FIFO_CHARS;
 		the_port->ops = &ioc4_ops;
 		the_port->irq = control->ic_irq;
 		the_port->dev = &pdev->dev;
 		spin_lock_init(&the_port->lock);
-		if (uart_add_one_port(&ioc4_uart, the_port) < 0) {
+		if (uart_add_one_port(u_driver, the_port) < 0) {
 			printk(KERN_WARNING
 		           "%s: unable to add port %d bus %d\n",
 			       __FUNCTION__, the_port->line, pdev->bus->number);
@@ -2610,8 +2734,6 @@
 			    ("IOC4 serial port %d irq = %d, bus %d\n",
 			       the_port->line, the_port->irq, pdev->bus->number));
 		}
-		/* all ports are rs232 for now */
-		ioc4_set_proto(port, PROTO_RS232);
 	}
 	return 0;
 }
@@ -2656,8 +2778,7 @@
 				__FUNCTION__, (void *)idd->idd_misc_regs, (void *)serial));
 
 	/* Get memory for the new card */
-	control = kmalloc(sizeof(struct ioc4_control) * IOC4_NUM_SERIAL_PORTS,
-						GFP_KERNEL);
+	control = kmalloc(sizeof(struct ioc4_control), GFP_KERNEL);
 
 	if (!control) {
 		printk(KERN_WARNING "ioc4_attach_one"
@@ -2713,16 +2834,21 @@
 	if (ret)
 		goto out4;
 
-	/* register port with the serial core */
+	/* register port with the serial core - 1 rs232, 1 rs422 */
 
-	if ((ret = ioc4_serial_core_attach(idd->idd_pdev)))
+	if ((ret = ioc4_serial_core_attach(idd->idd_pdev, PROTO_RS232)))
 		goto out4;
 
+	if ((ret = ioc4_serial_core_attach(idd->idd_pdev, PROTO_RS422)))
+		goto out5;
+
 	Num_of_ioc4_cards++;
 
 	return ret;
 
 	/* error exits that give back resources */
+out5:
+	ioc4_serial_remove_one(idd);
 out4:
 	kfree(soft);
 out3:
@@ -2735,52 +2861,6 @@
 }
 
 
-/**
- * ioc4_serial_remove_one - detach function
- *
- * @idd: IOC4 master module data for this IOC4
- */
-
-int ioc4_serial_remove_one(struct ioc4_driver_data *idd)
-{
-	int ii;
-	struct ioc4_control *control;
-	struct uart_port *the_port;
-	struct ioc4_port *port;
-	struct ioc4_soft *soft;
-
-	control = idd->idd_serial_data;
-
-	for (ii = 0; ii < IOC4_NUM_SERIAL_PORTS; ii++) {
-		the_port = &control->ic_port[ii].icp_uart_port;
-		if (the_port) {
-			uart_remove_one_port(&ioc4_uart, the_port);
-		}
-		port = control->ic_port[ii].icp_port;
-		if (!(ii & 1) && port) {
-			pci_free_consistent(port->ip_pdev,
-					TOTAL_RING_BUF_SIZE,
-					(void *)port->ip_cpu_ringbuf,
-					port->ip_dma_ringbuf);
-			kfree(port);
-		}
-	}
-	soft = control->ic_soft;
-	if (soft) {
-		free_irq(control->ic_irq, (void *)soft);
-		if (soft->is_ioc4_serial_addr) {
-			release_region((unsigned long)
-			     soft->is_ioc4_serial_addr,
-				sizeof(struct ioc4_serial));
-		}
-		kfree(soft);
-	}
-	kfree(control);
-	idd->idd_serial_data = NULL;
-
-	return 0;
-}
-
 static struct ioc4_submodule ioc4_serial_submodule = {
 	.is_name = "IOC4_serial",
 	.is_owner = THIS_MODULE,
@@ -2796,9 +2876,15 @@
 	int ret;
 
 	/* register with serial core */
-	if ((ret = uart_register_driver(&ioc4_uart)) < 0) {
+	if ((ret = uart_register_driver(&ioc4_uart_rs232)) < 0) {
+		printk(KERN_WARNING
+			"%s: Couldn't register rs232 IOC4 serial driver\n",
+			__FUNCTION__);
+		return ret;
+	}
+	if ((ret = uart_register_driver(&ioc4_uart_rs422)) < 0) {
 		printk(KERN_WARNING
-			"%s: Couldn't register IOC4 serial driver\n",
+			"%s: Couldn't register rs422 IOC4 serial driver\n",
 			__FUNCTION__);
 		return ret;
 	}
@@ -2810,7 +2896,8 @@
 static void __devexit ioc4_serial_exit(void)
 {
 	ioc4_unregister_submodule(&ioc4_serial_submodule);
-	uart_unregister_driver(&ioc4_uart);
+	uart_unregister_driver(&ioc4_uart_rs232);
+	uart_unregister_driver(&ioc4_uart_rs422);
 }
 
 module_init(ioc4_serial_init);
