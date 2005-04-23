Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261582AbVDWNu3@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261582AbVDWNu3 (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 23 Apr 2005 09:50:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261591AbVDWNu3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 23 Apr 2005 09:50:29 -0400
Received: from mo00.iij4u.or.jp ([210.130.0.19]:11722 "EHLO mo00.iij4u.or.jp")
	by vger.kernel.org with ESMTP id S261582AbVDWNtz (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 23 Apr 2005 09:49:55 -0400
Date: Sat, 23 Apr 2005 22:49:45 +0900
From: Yoichi Yuasa <yuasa@hh.iij4u.or.jp>
To: Andrew Morton <akpm@osdl.org>
Cc: yuasa@hh.iij4u.or.jp, linux-kernel <linux-kernel@vger.kernel.org>
Subject: [PATCH 2.6.12-rc3] serial: update NEC VR4100 series serial support
Message-Id: <20050423224945.342d6e69.yuasa@hh.iij4u.or.jp>
X-Mailer: Sylpheed version 1.0.4 (GTK+ 1.2.10; i386-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

I had fixed Russell's comment.

On Wed, 30 Mar 2005 10:23:08 +0100
Russell King <rmk@arm.linux.org.uk> wrote:

> On Mon, Mar 07, 2005 at 09:20:22PM -0800, akpm@osdl.org wrote:
> > +static inline const char *siu_type_name(struct uart_port *port)
> > +{
> > +	switch (port->type) {
> > +	case PORT_VR41XX_SIU:
> > +		return "SIU";
> > +	case PORT_VR41XX_DSIU:
> > +		return "DSIU";
> > +	}
> > +
> > +	return "unknown";
> 
> You can return NULL here.

Changed.

> > +static irqreturn_t siu_interrupt(int irq, void *dev_id, struct pt_regs *regs)
> > +{
> > +	struct uart_port *port;
> > +	uint8_t iir, lsr;
> > +
> > +	if (dev_id == NULL)
> > +		return IRQ_NONE;
> 
> This driver always registers interrupts with a dev_id.  Therefore, this can
> never be NULL.

Removed.

> 
> > +static void siu_shutdown(struct uart_port *port)
> > +{
> > +	unsigned long flags;
> > +	uint8_t lcr;
> > +
> > +	if (port->membase == NULL)
> > +		return;
> 
> How can this happen?  We always shut down a port before we change the
> address.  Maybe this check should be in siu_startup instead?

This check moved to siu_startup.

> > +#ifdef CONFIG_SERIAL_VR41XX_CONSOLE
> > +
> > +static void early_set_termios(struct uart_port *port, struct termios *new,
> > +                              struct termios *old)
> > +{

<snip>

> > +}
> > +
> > +static struct uart_ops early_uart_ops = {
> > +	.set_termios	= early_set_termios,
> > +};
> 
> Eww.  Is there a reason why your standard termios setting function can't
> be used?

Now using my standerd termios. It changed.

> > +static int siu_probe(struct device *dev)
> > +{
> > +	struct uart_port *port;
> > +	int num, i, retval;
> > +
> > +	num = siu_init_ports();
> > +	if (num <= 0)
> > +		return -ENODEV;
> > +
> > +	siu_uart_driver.nr = num;
> > +	retval = uart_register_driver(&siu_uart_driver);
> > +	if (retval)
> > +		return retval;
> > +
> > +	for (i = 0; i < num; i++) {
> > +		port = &siu_uart_ports[i];
> > +		port->ops = &siu_uart_ops;
> > +		port->dev = dev;
> > +
> > +		retval = uart_add_one_port(&siu_uart_driver, port);
> > +		if (retval)
> > +			break;
> > +	}
> 
> If port 1 fails to be registered...
> 
> > +
> > +	if (i == 0 && retval < 0) {
> > +		uart_unregister_driver(&siu_uart_driver);
> > +		return retval;
> > +	}
> > +
> > +	return 0;
> > +}
> > +
> > +static int siu_remove(struct device *dev)
> > +{
> > +	struct uart_port *port;
> > +	int i;
> > +
> > +	for (i = 0; i < siu_uart_driver.nr; i++) {
> > +		port = &siu_uart_ports[i];
> > +		if (port->dev == dev) {
> 
> ... we try to unregister it here, because port->dev was initialised.
> Maybe you want to NULL out port->dev in the above function when that
> happens?

Fixed.

> On Wed, Apr 13, 2005 at 11:18:27PM +0900, Yoichi Yuasa wrote:
> >  static struct uart_ops early_uart_ops = {
> > -	.set_termios	= early_set_termios,
> > +	.set_termios	= siu_set_termios,
> >  };
> 
> In this case, you don't need the early_uart_ops here - the standard
> ones will do just as well.  (.set_termios is the only method which
> the console init code will use.)

Use standard one.

Yoichi

Signed-off-by: Yoichi Yuasa <yuasa@hh.iij4u.or.jp>

Index: drivers/serial/vr41xx_siu.c
===================================================================
--- 43765d4b40a4a3c64f2a32b684f4041e2f01644d/drivers/serial/vr41xx_siu.c  (mode:100644 sha1:307886199f2f6f1301d6aa240b1f3263e9ec8a90)
+++ uncommitted/drivers/serial/vr41xx_siu.c  (mode:100644)
@@ -234,7 +234,7 @@
 		return "DSIU";
 	}
 
-	return "unknown";
+	return NULL;
 }
 
 static unsigned int siu_tx_empty(struct uart_port *port)
@@ -484,9 +484,6 @@
 	struct uart_port *port;
 	uint8_t iir, lsr;
 
-	if (dev_id == NULL)
-		return IRQ_NONE;
-
 	port = (struct uart_port *)dev_id;
 
 	iir = siu_read(port, UART_IIR);
@@ -509,6 +506,9 @@
 {
 	int retval;
 
+	if (port->membase == NULL)
+		return -ENODEV;
+
 	siu_clear_fifo(port);
 
 	(void)siu_read(port, UART_LSR);
@@ -547,9 +547,6 @@
 	unsigned long flags;
 	uint8_t lcr;
 
-	if (port->membase == NULL)
-		return;
-
 	siu_write(port, UART_IER, 0);
 
 	spin_lock_irqsave(&port->lock, flags);
@@ -804,53 +801,6 @@
 
 #ifdef CONFIG_SERIAL_VR41XX_CONSOLE
 
-static void early_set_termios(struct uart_port *port, struct termios *new,
-                              struct termios *old)
-{
-	tcflag_t c_cflag;
-	uint8_t lcr;
-	unsigned int baud, quot;
-
-	c_cflag = new->c_cflag;
-	switch (c_cflag & CSIZE) {
-	case CS5:
-		lcr = UART_LCR_WLEN5;
-		break;
-	case CS6:
-		lcr = UART_LCR_WLEN6;
-		break;
-	case CS7:
-		lcr = UART_LCR_WLEN7;
-		break;
-	default:
-		lcr = UART_LCR_WLEN8;
-		break;
-	}
-
-	if (c_cflag & CSTOPB)
-		lcr |= UART_LCR_STOP;
-	if (c_cflag & PARENB)
-		lcr |= UART_LCR_PARITY;
-	if ((c_cflag & PARODD) != PARODD)
-		lcr |= UART_LCR_EPAR;
-	if (c_cflag & CMSPAR)
-		lcr |= UART_LCR_SPAR;
-
-	baud = uart_get_baud_rate(port, new, old, 0, port->uartclk/16);
-	quot = uart_get_divisor(port, baud);
-
-	siu_write(port, UART_LCR, lcr | UART_LCR_DLAB);
-
-	siu_write(port, UART_DLL, (uint8_t)quot);
-	siu_write(port, UART_DLM, (uint8_t)(quot >> 8));
-
-	siu_write(port, UART_LCR, lcr);
-}
-
-static struct uart_ops early_uart_ops = {
-	.set_termios	= early_set_termios,
-};
-
 #define BOTH_EMPTY	(UART_LSR_TEMT | UART_LSR_THRE)
 
 static void wait_for_xmitr(struct uart_port *port)
@@ -917,7 +867,7 @@
 	if (port->membase == NULL) {
 		if (port->mapbase == 0)
 			return -ENODEV;
-		port->membase = (unsigned char __iomem *)KSEG1ADDR(port->mapbase);
+		port->membase = ioremap(port->mapbase, siu_port_size(port));
 	}
 
 	vr41xx_select_siu_interface(SIU_INTERFACE_RS232C);
@@ -951,7 +901,7 @@
 
 	for (i = 0; i < num; i++) {
 		port = &siu_uart_ports[i];
-		port->ops = &early_uart_ops;
+		port->ops = &siu_uart_ops;
 	}
 
 	register_console(&siu_console);
@@ -996,8 +946,10 @@
 		port->dev = dev;
 
 		retval = uart_add_one_port(&siu_uart_driver, port);
-		if (retval)
+		if (retval < 0) {
+			port->dev = NULL;
 			break;
+		}
 	}
 
 	if (i == 0 && retval < 0) {


