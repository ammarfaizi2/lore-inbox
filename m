Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932313AbWHVPNX@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932313AbWHVPNX (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 22 Aug 2006 11:13:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932315AbWHVPNX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 22 Aug 2006 11:13:23 -0400
Received: from europa.telenet-ops.be ([195.130.137.75]:9890 "EHLO
	europa.telenet-ops.be") by vger.kernel.org with ESMTP
	id S932308AbWHVPNV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 22 Aug 2006 11:13:21 -0400
From: Peter Korsgaard <jacmet@sunsite.dk>
To: rmk+serial@arm.linux.org.uk, linux-serial@vger.kernel.org
Cc: linux-kernel@vger.kernel.org
Subject: Re: [RFC][PATCH] Xilinx uartlite serial driver
References: <87ac9o3ak3.fsf@sleipner.barco.com>
Date: Tue, 22 Aug 2006 17:13:13 +0200
In-Reply-To: <87ac9o3ak3.fsf@sleipner.barco.com> (Peter Korsgaard's message of
	"Thu, 11 May 2006 16:23:08 +0200")
Message-ID: <878xlgercm.fsf@slug.be.48ers.dk>
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>>>>> "Peter" == Peter Korsgaard <jacmet@sunsite.dk> writes:

Hi,

 Peter> The following patch adds a driver for the Xilinx uartlite serial
 Peter> controller used in boards with the PPC405 core in the Xilinx V2P/V4
 Peter> fpgas.

 Peter> The hardware is very simple (baudrate/start/stopbits fixed and
 Peter> no break support). See the datasheet for details:

 Peter> http://www.xilinx.com/bvdocs/ipcenter/data_sheet/opb_uartlite.pdf

 Peter> Comments and suggestions are welcome. I'm especially wondering about
 Peter> the fact that I'm hijacking the device nodes used by the mpc52xx_uart
 Peter> driver ..

Ok, I now got a chunk of the 204 major range from LANANA. That afaik
solves the last remaining issue with this..

Signed-off-by: Peter Korsgaard <jacmet@sunsite.dk>

diff -urpN linux-2.6.18-rc4.orig/drivers/serial/Kconfig linux-2.6.18-rc4/drivers/serial/Kconfig
--- linux-2.6.18-rc4.orig/drivers/serial/Kconfig	2006-08-22 16:19:15.000000000 +0200
+++ linux-2.6.18-rc4/drivers/serial/Kconfig	2006-08-22 16:24:25.000000000 +0200
@@ -511,6 +511,33 @@ config SERIAL_IMX_CONSOLE
 	  your boot loader (lilo or loadlin) about how to pass options to the
 	  kernel at boot time.)
 
+config SERIAL_UARTLITE
+	tristate "Xilinx uartlite serial port support"
+	depends on PPC32
+	select SERIAL_CORE
+	help
+	  Say Y here if you want to use the Xilinx uartlite serial controller.
+
+	  To compile this driver as a module, choose M here: the
+	  module will be called uartlite.ko.
+
+config SERIAL_UARTLITE_NR_UARTS
+	int "Maximum number of Xilinx uartlite serial ports"
+	depends on SERIAL_UARTLITE
+	default "4"
+	help
+	  Set this to the number of serial ports you want the driver
+	  to support.
+
+config SERIAL_UARTLITE_CONSOLE
+	bool "Support for console on Xilinx uartlite serial port"
+	depends on SERIAL_UARTLITE=y
+	select SERIAL_CORE_CONSOLE
+	help
+	  Say Y here if you wish to use a Xilinx uartlite as the system
+	  console (the system console is the device which receives all kernel
+	  messages and warnings and which allows logins in single user mode).
+
 config SERIAL_SUNCORE
 	bool
 	depends on SPARC
diff -urpN linux-2.6.18-rc4.orig/drivers/serial/Makefile linux-2.6.18-rc4/drivers/serial/Makefile
--- linux-2.6.18-rc4.orig/drivers/serial/Makefile	2006-08-22 16:19:15.000000000 +0200
+++ linux-2.6.18-rc4/drivers/serial/Makefile	2006-08-22 16:24:25.000000000 +0200
@@ -55,4 +55,5 @@ obj-$(CONFIG_SERIAL_VR41XX) += vr41xx_si
 obj-$(CONFIG_SERIAL_SGI_IOC4) += ioc4_serial.o
 obj-$(CONFIG_SERIAL_SGI_IOC3) += ioc3_serial.o
 obj-$(CONFIG_SERIAL_AT91) += at91_serial.o
+obj-$(CONFIG_SERIAL_UARTLITE) += uartlite.o
 obj-$(CONFIG_SERIAL_NETX) += netx-serial.o
diff -urpN linux-2.6.18-rc4.orig/drivers/serial/uartlite.c linux-2.6.18-rc4/drivers/serial/uartlite.c
--- linux-2.6.18-rc4.orig/drivers/serial/uartlite.c	1970-01-01 01:00:00.000000000 +0100
+++ linux-2.6.18-rc4/drivers/serial/uartlite.c	2006-08-22 16:48:08.000000000 +0200
@@ -0,0 +1,431 @@
+/*
+ * uartlite.c: Serial driver for Xilinx uartlite serial controller
+ *
+ * Peter Korsgaard <jacmet@sunsite.dk>
+ *
+ * This file is licensed under the terms of the GNU General Public License
+ * version 2.  This program is licensed "as is" without any warranty of any
+ * kind, whether express or implied.
+ */
+
+#include <linux/config.h>
+#include <linux/platform_device.h>
+#include <linux/module.h>
+#include <linux/console.h>
+#include <linux/serial.h>
+#include <linux/serial_core.h>
+#include <linux/tty.h>
+#include <linux/interrupt.h>
+#include <asm/io.h>
+
+#define SERIAL_ULITE_MAJOR	204
+#define SERIAL_ULITE_MINOR	187
+
+/* For register details see datasheet:
+   http://www.xilinx.com/bvdocs/ipcenter/data_sheet/opb_uartlite.pdf
+*/
+#define ULITE_RX		0x00
+#define ULITE_TX		0x04
+#define ULITE_STATUS		0x08
+#define ULITE_CONTROL		0x0c
+
+#define ULITE_STATUS_RXVALID	0x01
+#define ULITE_STATUS_RXFULL	0x02
+#define ULITE_STATUS_TXEMPTY	0x04
+#define ULITE_STATUS_TXFULL	0x08
+#define ULITE_STATUS_IE		0x10
+#define ULITE_STATUS_OVERRUN	0x20
+#define ULITE_STATUS_FRAME	0x40
+#define ULITE_STATUS_PARITY	0x80
+
+#define ULITE_CONTROL_RST_TX	0x01
+#define ULITE_CONTROL_RST_RX	0x02
+#define ULITE_CONTROL_IE	0x10
+
+
+static struct uart_port ports[CONFIG_SERIAL_UARTLITE_NR_UARTS];
+
+
+static inline unsigned int serial_in(struct uart_port *port, int offset)
+{
+	return readb(port->membase + offset);
+}
+
+static inline void serial_out(struct uart_port *port, int offset, int value)
+{
+	writeb(value, port->membase + offset);
+}
+
+static unsigned int ulite_tx_empty(struct uart_port *port)
+{
+	unsigned long flags;
+	unsigned int ret;
+
+	spin_lock_irqsave(&port->lock, flags);
+	ret = serial_in(port, ULITE_STATUS);
+	spin_unlock_irqrestore(&port->lock, flags);
+
+	return ret & ULITE_STATUS_TXEMPTY ? TIOCSER_TEMT : 0;
+}
+
+static unsigned int ulite_get_mctrl(struct uart_port *port)
+{
+	return TIOCM_CTS | TIOCM_DSR | TIOCM_CAR;
+}
+
+static void ulite_set_mctrl(struct uart_port *port, unsigned int mctrl)
+{
+	/* N/A */
+}
+
+static void ulite_stop_tx(struct uart_port *port)
+{
+	/* N/A */
+}
+
+static void ulite_start_tx(struct uart_port *port)
+{
+	struct circ_buf *xmit = &port->info->xmit;
+	int stat;
+
+	stat = serial_in(port, ULITE_STATUS);
+	if (!(stat & ULITE_STATUS_TXFULL)) {
+		serial_out(port, ULITE_TX, xmit->buf[xmit->tail]);
+		xmit->tail = (xmit->tail + 1) & (UART_XMIT_SIZE - 1);
+		port->icount.tx++;
+	}
+}
+
+static void ulite_stop_rx(struct uart_port *port)
+{
+	/* N/A */
+}
+
+static void ulite_enable_ms(struct uart_port *port)
+{
+	/* N/A */
+}
+
+static void ulite_break_ctl(struct uart_port *port, int ctl)
+{
+	/* N/A */
+}
+
+static irqreturn_t ulite_isr(int irq, void *dev_id, struct pt_regs *regs)
+{
+	struct uart_port *port = (struct uart_port *)dev_id;
+	struct tty_struct *tty = port->info->tty;
+	struct circ_buf *xmit  = &port->info->xmit;
+	int busy;
+
+	do {
+		int stat = serial_in(port, ULITE_STATUS);
+
+		busy = 0;
+
+		if (stat & (ULITE_STATUS_OVERRUN | ULITE_STATUS_FRAME
+			    | ULITE_STATUS_RXVALID)) {
+			busy = 1;
+
+			if (stat & ULITE_STATUS_OVERRUN) {
+				tty_insert_flip_char(tty, 0, TTY_OVERRUN);
+				port->icount.overrun++;
+			}
+
+			if (stat & ULITE_STATUS_FRAME) {
+				tty_insert_flip_char(tty, 0, TTY_FRAME);
+				port->icount.frame++;
+			}
+
+			if (stat & ULITE_STATUS_RXVALID) {
+				unsigned char flag = TTY_NORMAL;
+
+				if (stat & ULITE_STATUS_PARITY) {
+					flag = TTY_PARITY; /* still received */
+					port->icount.parity++;
+				}
+
+				tty_insert_flip_char(
+					tty, serial_in(port, ULITE_RX), flag);
+				port->icount.rx++;
+			}
+		}
+
+		if (uart_circ_empty(xmit) || uart_tx_stopped(port))
+			continue;
+
+		if (!(stat & ULITE_STATUS_TXFULL)) {
+			busy = 1;
+			serial_out(port, ULITE_TX, xmit->buf[xmit->tail]);
+			xmit->tail = (xmit->tail + 1) & (UART_XMIT_SIZE - 1);
+			port->icount.tx++;
+		}
+
+		/* wake up */
+		if (uart_circ_chars_pending(xmit) < WAKEUP_CHARS)
+			uart_write_wakeup(port);
+	} while (busy);
+
+	tty_flip_buffer_push(tty);
+
+	return IRQ_HANDLED;
+}
+
+static int ulite_startup(struct uart_port *port)
+{
+	int ret;
+
+	ret = request_irq(port->irq, ulite_isr,
+			  SA_INTERRUPT | SA_SAMPLE_RANDOM, "uartlite", port);
+	if (ret)
+		return ret;
+
+	serial_out(port, ULITE_CONTROL,
+		   ULITE_CONTROL_RST_RX | ULITE_CONTROL_RST_TX);
+	serial_out(port, ULITE_CONTROL, ULITE_CONTROL_IE);
+
+	return 0;
+}
+
+static void ulite_shutdown(struct uart_port *port)
+{
+	serial_out(port, ULITE_CONTROL, 0);
+	free_irq(port->irq, port);
+}
+
+static void ulite_set_termios(struct uart_port *port, struct termios *termios,
+			      struct termios *old)
+{
+	/* N/A */
+}
+
+static const char *ulite_type(struct uart_port *port)
+{
+	return port->type == PORT_UARTLITE ? "uartlite" : NULL;
+}
+
+static void ulite_release_port(struct uart_port *port)
+{
+	/* N/A */
+}
+
+static int ulite_request_port(struct uart_port *port)
+{
+	return 0;
+}
+
+static void ulite_config_port(struct uart_port *port, int flags)
+{
+	port->type = PORT_UARTLITE;
+}
+
+static int ulite_verify_port(struct uart_port *port, struct serial_struct *ser)
+{
+	/* we don't want the core code to modify any port params */
+	return -EINVAL;
+}
+
+static struct uart_ops ulite_ops = {
+	.tx_empty	= ulite_tx_empty,
+	.set_mctrl	= ulite_set_mctrl,
+	.get_mctrl	= ulite_get_mctrl,
+	.stop_tx	= ulite_stop_tx,
+	.start_tx	= ulite_start_tx,
+	.stop_rx	= ulite_stop_rx,
+	.enable_ms	= ulite_enable_ms,
+	.break_ctl	= ulite_break_ctl,
+	.startup	= ulite_startup,
+	.shutdown	= ulite_shutdown,
+	.set_termios	= ulite_set_termios,
+	.type		= ulite_type,
+	.release_port	= ulite_release_port,
+	.request_port	= ulite_request_port,
+	.config_port	= ulite_config_port,
+	.verify_port	= ulite_verify_port
+};
+
+#ifdef CONFIG_SERIAL_UARTLITE_CONSOLE
+
+static void ulite_console_write(struct console *co, const char *s,
+				unsigned int count)
+{
+	struct uart_port *port = &ports[co->index];
+	int i;
+
+	/* disable interrupts */
+	serial_out(port, ULITE_CONTROL, 0);
+
+	for (i = 0; i < count; i++) {
+		/* line return handling */
+		if (*s == '\n')
+			serial_out(port, ULITE_TX, '\r');
+
+		serial_out(port, ULITE_TX, *s++);
+
+		/* wait until it's sent */
+		while (!(serial_in(port, ULITE_STATUS)
+			 & ULITE_STATUS_TXEMPTY)) ;
+	}
+
+	/* restore interrupt state */
+	serial_out(port, ULITE_CONTROL, ULITE_CONTROL_IE);
+}
+
+static int __init ulite_console_setup(struct console *co, char *options)
+{
+	struct uart_port *port;
+
+	if (co->index < 0 || co->index >= CONFIG_SERIAL_UARTLITE_NR_UARTS)
+		return -EINVAL;
+
+	port = &ports[co->index];
+
+	/* not initialized yet? */
+	if (!port->type)
+		return -ENODEV;
+
+	return 0;
+}
+
+static struct uart_driver ulite_uart_driver;
+
+static struct console ulite_console = {
+	.name	= "ttyUL",
+	.write	= ulite_console_write,
+	.device	= uart_console_device,
+	.setup	= ulite_console_setup,
+	.flags	= CON_PRINTBUFFER,
+	.index	= -1, /* Specified on the cmdline (e.g. console=ttyUL0 ) */
+	.data	= &ulite_uart_driver,
+};
+
+static int __init ulite_console_init(void)
+{
+	register_console(&ulite_console);
+	return 0;
+}
+
+console_initcall(ulite_console_init);
+
+#endif /* CONFIG_SERIAL_UARTLITE_CONSOLE */
+
+static struct uart_driver ulite_uart_driver = {
+	.owner		= THIS_MODULE,
+	.driver_name	= "uartlite",
+	.dev_name	= "ttyUL",
+	.devfs_name	= "ttyUL",
+	.major		= SERIAL_ULITE_MAJOR,
+	.minor		= SERIAL_ULITE_MINOR,
+	.nr		= CONFIG_SERIAL_UARTLITE_NR_UARTS,
+#ifdef CONFIG_SERIAL_UARTLITE_CONSOLE
+	.cons		= &ulite_console,
+#endif
+};
+
+static int __devinit ulite_probe(struct platform_device *pdev)
+{
+	struct resource *res, *res2;
+	struct uart_port *port;
+	int ret;
+
+	if (pdev->id < 0 || pdev->id >= CONFIG_SERIAL_UARTLITE_NR_UARTS)
+		return -EINVAL;
+
+	if (ports[pdev->id].iobase)
+		return -EBUSY;
+
+	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
+	if (!res)
+		return -ENODEV;
+
+	res2 = platform_get_resource(pdev, IORESOURCE_IRQ, 0);
+	if (!res2)
+		return -ENODEV;
+
+	port = &ports[pdev->id];
+
+	port->fifosize	= 16;
+	port->regshift	= 2;
+	port->iotype	= UPIO_MEM;
+	port->iobase	= 1; /* mark port in use */
+	port->mapbase	= res->start;
+	port->ops	= &ulite_ops;
+	port->irq	= res2->start;
+	port->flags	= UPF_BOOT_AUTOCONF;
+	port->dev	= &pdev->dev;
+
+	if (!request_mem_region(res->start, res->end - res->start + 1,
+				pdev->name)) {
+		dev_err(&pdev->dev, "Memory region busy\n");
+		ret = -EBUSY;
+		goto request_mem_failed;
+	}
+
+	port->membase = ioremap(res->start, res->end - res->start + 1);
+	if (!port->membase) {
+		dev_err(&pdev->dev, "Unable to map registers\n");
+		ret = -EIO;
+		goto map_failed;
+	}
+
+	uart_add_one_port(&ulite_uart_driver, port);
+	platform_set_drvdata(pdev, port);
+	return 0;
+
+ map_failed:
+	release_mem_region(res->start, res->end - res->start + 1);
+ request_mem_failed:
+
+	return ret;
+}
+
+static int ulite_remove(struct platform_device *pdev)
+{
+	struct uart_port *port = platform_get_drvdata(pdev);
+
+	platform_set_drvdata(pdev, NULL);
+
+	if (port)
+		uart_remove_one_port(&ulite_uart_driver, port);
+
+	port->iobase = 0;
+
+	return 0;
+}
+
+static struct platform_driver ulite_platform_driver = {
+	.probe	= ulite_probe,
+	.remove	= ulite_remove,
+	.driver	= {
+		   .owner = THIS_MODULE,
+		   .name  = "uartlite",
+		   },
+};
+
+int __init ulite_init(void)
+{
+	int ret;
+
+	ret = uart_register_driver(&ulite_uart_driver);
+	if (ret)
+		return ret;
+
+	ret = platform_driver_register(&ulite_platform_driver);
+	if (ret)
+		uart_unregister_driver(&ulite_uart_driver);
+
+	return ret;
+}
+
+void __exit ulite_exit(void)
+{
+	platform_driver_unregister(&ulite_platform_driver);
+	uart_unregister_driver(&ulite_uart_driver);
+}
+
+module_init(ulite_init);
+module_exit(ulite_exit);
+
+MODULE_AUTHOR("Peter Korsgaard <jacmet@sunsite.dk>");
+MODULE_DESCRIPTION("Xilinx uartlite serial driver");
+MODULE_LICENSE("GPL");
diff -urpN linux-2.6.18-rc4.orig/include/linux/serial.h linux-2.6.18-rc4/include/linux/serial.h
--- linux-2.6.18-rc4.orig/include/linux/serial.h	2006-06-18 03:49:35.000000000 +0200
+++ linux-2.6.18-rc4/include/linux/serial.h	2006-08-22 16:24:25.000000000 +0200
@@ -76,7 +76,8 @@ struct serial_struct {
 #define PORT_16654	11
 #define PORT_16850	12
 #define PORT_RSA	13	/* RSA-DV II/S card */
-#define PORT_MAX	13
+#define PORT_UARTLITE	14
+#define PORT_MAX	14
 
 #define SERIAL_IO_PORT	0
 #define SERIAL_IO_HUB6	1
diff -urpN linux-2.6.18-rc4.orig/MAINTAINERS linux-2.6.18-rc4/MAINTAINERS
--- linux-2.6.18-rc4.orig/MAINTAINERS	2006-08-22 16:19:12.000000000 +0200
+++ linux-2.6.18-rc4/MAINTAINERS	2006-08-22 16:41:08.000000000 +0200
@@ -3288,6 +3288,12 @@ L:	xfs@oss.sgi.com
 W:	http://oss.sgi.com/projects/xfs
 S:	Supported
 
+XILINX UARTLITE SERIAL DRIVER
+P:	Peter Korsgaard
+M:	jacmet@sunsite.dk
+L:	linux-serial@vger.kernel.org
+S:	Maintained
+
 X86 3-LEVEL PAGING (PAE) SUPPORT
 P:	Ingo Molnar
 M:	mingo@redhat.com

-- 
Bye, Peter Korsgaard
