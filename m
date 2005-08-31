Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932322AbVHaLJg@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932322AbVHaLJg (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 31 Aug 2005 07:09:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932336AbVHaLJg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 31 Aug 2005 07:09:36 -0400
Received: from RT-soft-2.Moscow.itn.ru ([80.240.96.70]:17339 "HELO
	mail.dev.rtsoft.ru") by vger.kernel.org with SMTP id S932322AbVHaLJf
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 31 Aug 2005 07:09:35 -0400
Message-ID: <43159011.3060206@rbcmail.ru>
Date: Wed, 31 Aug 2005 15:10:09 +0400
From: Vitaly Wool <vitalhome@rbcmail.ru>
User-Agent: Mozilla Thunderbird 1.0 (X11/20041206)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
CC: Russell King <rmk+lkml@arm.linux.org.uk>,
       Grigory Tolstolytkin <gtolstolytkin@dev.rtsoft.ru>
Subject: [PATCH] custom PM support for 8250
Content-Type: multipart/mixed;
 boundary="------------070907010802060304020800"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------070907010802060304020800
Content-Type: text/plain; charset=KOI8-R; format=flowed
Content-Transfer-Encoding: 7bit

Greetings,
please find the patch that allows passing the pointer to custom power 
management routine (via platform_device) to 8250 serial driver.
Please note that the interface to the outer world (i. e. exported 
functions) remained the same.

Best regards,
   Vitaly

--------------070907010802060304020800
Content-Type: text/x-patch;
 name="8250.diff"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="8250.diff"

Currently 8250 serial driver doesn't have means to register custom
(i. e. board-specific) power management functions.
This patch modifies the driver to provide such facility.

 drivers/serial/8250.c       |   47 +++++++++++++++++++++++++++++++++++++------- include/linux/serial_8250.h |    4 +++
 2 files changed, 44 insertions(+), 7 deletions(-)
 
Signed-off-by: Vitaly Wool <vitalhome@rbcmail.ru>

Index: linux-2.6.10/drivers/serial/8250.c
===================================================================
--- linux-2.6.10.orig/drivers/serial/8250.c
+++ linux-2.6.10/drivers/serial/8250.c
@@ -2360,6 +2360,8 @@
 	uart_resume_port(&serial8250_reg, &serial8250_ports[line].port);
 }
 
+static struct uart_8250_port *uart_8250_register_port(struct uart_port *port, int *line);
+
 /*
  * Register a set of serial devices attached to a platform device.  The
  * list is terminated with a zero flags entry, which means we expect
@@ -2369,6 +2371,8 @@
 {
 	struct plat_serial8250_port *p = dev->platform_data;
 	struct uart_port port;
+	struct uart_8250_port *uart;
+	int line;
 
 	memset(&port, 0, sizeof(struct uart_port));
 
@@ -2386,7 +2390,9 @@
 		if (share_irqs)
 			port.flags |= UPF_SHARE_IRQ;
 
-		serial8250_register_port(&port);
+		uart = uart_8250_register_port(&port, &line);
+		if (!IS_ERR(uart))
+			uart->pm = p->pm;
 	}
 	return 0;
 }
@@ -2516,8 +2522,9 @@
 }
 
 /**
- *	serial8250_register_port - register a serial port
+ *	uart_8250_register_port - register a serial port
  *	@port: serial port template
+ *	@line: returned (on success) value of the line number
  *
  *	Configure the serial port specified by the request. If the
  *	port exists and is in use, it is hung up and unregistered
@@ -2526,19 +2533,20 @@
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
 
 	/* Avoid re-registering platform based ports if KGDB active */
 	if (port->line == kgdb8250_ttyS)
-		return -EBUSY;
+		return ERR_PTR(-EBUSY);
 
 	down(&serial_sem);
 
@@ -2560,10 +2568,35 @@
 
 		ret = uart_add_one_port(&serial8250_reg, &uart->port);
 		if (ret == 0)
-			ret = uart->port.line;
+			*line = uart->port.line;
 	}
 	up(&serial_sem);
 
+	return ret == 0 ? uart : ERR_PTR(ret);
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
--- linux-2.6.10.orig/include/linux/serial_8250.h
+++ linux-2.6.10/include/linux/serial_8250.h
@@ -24,6 +24,10 @@
 	unsigned char	iotype;		/* UPIO_* */
 	unsigned int	flags;		/* UPF_* flags */
 	unsigned int	line;		/* uart # */
+
+	/* per-port pm hook */
+	void			(*pm)(struct uart_port *port,
+				      unsigned int state, unsigned int old);
 };
 
 #endif

--------------070907010802060304020800--
