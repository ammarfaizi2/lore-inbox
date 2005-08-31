Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964818AbVHaOWu@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964818AbVHaOWu (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 31 Aug 2005 10:22:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932516AbVHaOWu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 31 Aug 2005 10:22:50 -0400
Received: from RT-soft-2.Moscow.itn.ru ([80.240.96.70]:36790 "HELO
	mail.dev.rtsoft.ru") by vger.kernel.org with SMTP id S932515AbVHaOWt
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 31 Aug 2005 10:22:49 -0400
Message-ID: <4315BD5F.4070403@rbcmail.ru>
Date: Wed, 31 Aug 2005 18:23:27 +0400
From: Vitaly Wool <vitalhome@rbcmail.ru>
User-Agent: Mozilla Thunderbird 1.0 (X11/20041206)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Russell King <rmk+lkml@arm.linux.org.uk>
CC: Grigory Tolstolytkin <gtolstolytkin@dev.rtsoft.ru>,
       linux-kernel@vger.kernel.org
Subject: [PATCH] custom PM support for 8250 serial (updated)
Content-Type: multipart/mixed;
 boundary="------------080600000003030109020502"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------080600000003030109020502
Content-Type: text/plain; charset=KOI8-R; format=flowed
Content-Transfer-Encoding: 7bit

Greetings gentlemen,

please find the patch against 2.6.13 tree with Russel's proposal taken 
into account.
This patch that allows passing the pointer to custom power management 
routine (via platform_device) to 8250 serial driver.
Please note that the exported functions' API remained the same.
The only change for the outer worls is the format of platform data 
representation for the 8250 serial devices.

Best regards,
   Vitaly

--------------080600000003030109020502
Content-Type: text/x-patch;
 name="8250.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="8250.patch"

Currently 8250 serial driver doesn't have means to register custom
(i. e. board-specific) power management functions.
This patch modifies the driver to provide such facility.

 drivers/serial/8250.c       |   77 ++++++++++++++++++++++++++++++++++++-------- include/linux/serial_8250.h |    6 +++
 2 files changed, 69 insertions(+), 14 deletions(-)
  
Signed-off-by: Vitaly Wool <vitalhome@rbcmail.ru>


Index: linux-2.6.13/drivers/serial/8250.c
===================================================================
--- linux-2.6.13.orig/drivers/serial/8250.c	2005-08-29 03:41:01.000000000 +0400
+++ linux-2.6.13/drivers/serial/8250.c	2005-08-31 18:02:35.000000000 +0400
@@ -2302,6 +2302,8 @@
 	uart_resume_port(&serial8250_reg, &serial8250_ports[line].port);
 }
 
+static struct uart_8250_port *uart_8250_register_port(struct uart_port *port, int *line);
+
 /*
  * Register a set of serial devices attached to a platform device.  The
  * list is terminated with a zero flags entry, which means we expect
@@ -2309,13 +2311,23 @@
  */
 static int __devinit serial8250_probe(struct device *dev)
 {
-	struct plat_serial8250_port *p = dev->platform_data;
+	struct platform_serial8250_data *data = dev->platform_data;
+	struct plat_serial8250_port *p;
 	struct uart_port port;
-	int ret, i;
+	struct uart_8250_port *uart;
+	int ret = 0, i, line;
+
+	if (!data) {
+		printk(KERN_WARNING "8250.c: platform_data for device 0x%p"
+				" is NULL!\n", dev);
+		ret = -EINVAL;
+		goto out;
+	} else 
+		p = data->ports;
 
 	memset(&port, 0, sizeof(struct uart_port));
 
-	for (i = 0; p && p->flags != 0; p++, i++) {
+	for (i = 0; i < data->nr_ports; i++, p++) {
 		port.iobase	= p->iobase;
 		port.membase	= p->membase;
 		port.irq	= p->irq;
@@ -2328,14 +2340,19 @@
 		port.dev	= dev;
 		if (share_irqs)
 			port.flags |= UPF_SHARE_IRQ;
-		ret = serial8250_register_port(&port);
-		if (ret < 0) {
+		
+		uart = uart_8250_register_port(&port, &line);
+
+		if (IS_ERR(uart)) {
 			dev_err(dev, "unable to register port at index %d "
-				"(IO%lx MEM%lx IRQ%d): %d\n", i,
-				p->iobase, p->mapbase, p->irq, ret);
-		}
+				"(IO%lx MEM%lx IRQ%d): %ld\n", i,
+				p->iobase, p->mapbase, p->irq, PTR_ERR(uart));
+		} else
+			uart->pm = data->pm;
 	}
-	return 0;
+
+out:
+	return ret;
 }
 
 /*
@@ -2443,8 +2460,9 @@
 }
 
 /**
- *	serial8250_register_port - register a serial port
+ *	uart_8250_register_port - register a serial port
  *	@port: serial port template
+ *	@line: returned (on success) value of the line number
  *
  *	Configure the serial port specified by the request. If the
  *	port exists and is in use, it is hung up and unregistered
@@ -2453,15 +2471,16 @@
  *	The port is then probed and if necessary the IRQ is autodetected
  *	If this fails an error is returned.
  *
- *	On success the port is ready to use and the line number is returned.
+ *	On success the port is ready to use and the pointer to the 
+ *	corresponding struct uart_8250_port is returned.
  */
-int serial8250_register_port(struct uart_port *port)
+static struct uart_8250_port *uart_8250_register_port(struct uart_port *port, int *line)
 {
 	struct uart_8250_port *uart;
 	int ret = -ENOSPC;
 
 	if (port->uartclk == 0)
-		return -EINVAL;
+		return ERR_PTR(-EINVAL);
 
 	down(&serial_sem);
 
@@ -2483,10 +2502,40 @@
 
 		ret = uart_add_one_port(&serial8250_reg, &uart->port);
 		if (ret == 0)
-			ret = uart->port.line;
+			*line = uart->port.line;
 	}
 	up(&serial_sem);
 
+	if (uart == NULL)
+		uart = ERR_PTR(-ENOENT);
+	if (ret < 0)
+		uart = ERR_PTR(ret);
+
+	return uart;
+
+}
+
+/**
+ *	serial8250_register_port - register a serial port
+ *	@port: serial port template
+ *
+ *	Configure the serial port specified by the request. If the
+ *	port exists and is in use, it is hung up and unregistered
+ *	first.
+ *
+ *	The port is then probed and if necessary the IRQ is autodetected
+ *	If this fails an error is returned.
+ *
+ *	On success the port is ready to use and the line number is returned.
+ */
+int serial8250_register_port(struct uart_port *port)
+{
+	int ret = 0;
+	struct uart_8250_port *uart = uart_8250_register_port(port, &ret);
+
+	if (IS_ERR(uart))
+		ret = PTR_ERR(uart);
+
 	return ret;
 }
 EXPORT_SYMBOL(serial8250_register_port);
Index: linux-2.6.10/include/linux/serial_8250.h
===================================================================
--- linux-2.6.13.orig/include/linux/serial_8250.h	2005-08-29 03:41:01.000000000 +0400
+++ linux-2.6.13/include/linux/serial_8250.h	2005-08-31 17:29:31.000000000 +0400
@@ -26,4 +26,10 @@
 	unsigned int	flags;		/* UPF_* flags */
 };
 
+struct platform_serial8250_data {
+	void	(*pm)(struct uart_port *port, unsigned int state, unsigned int old);					/* platform-specific PM hook */
+	int	nr_ports;		/* nr of ports */
+	struct	plat_serial8250_port *ports;
+					/* ptr to plat_serial8250_port array */
+};
 #endif


--------------080600000003030109020502--
