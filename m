Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261351AbVDMOSv@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261351AbVDMOSv (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 13 Apr 2005 10:18:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261352AbVDMOSv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 13 Apr 2005 10:18:51 -0400
Received: from mo01.iij4u.or.jp ([210.130.0.20]:58345 "EHLO mo01.iij4u.or.jp")
	by vger.kernel.org with ESMTP id S261351AbVDMOSh (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 13 Apr 2005 10:18:37 -0400
Date: Wed, 13 Apr 2005 23:18:27 +0900
From: Yoichi Yuasa <yuasa@hh.iij4u.or.jp>
To: Andrew Morton <akpm@osdl.org>
Cc: yuasa@hh.iij4u.or.jp, linux-kernel <linux-kernel@vger.kernel.org>
Subject: [PATCH 2.6.12-rc2-mm3] serial: update NEC VR4100 series serial
 support
Message-Id: <20050413231827.11799413.yuasa@hh.iij4u.or.jp>
X-Mailer: Sylpheed version 1.0.4 (GTK+ 1.2.10; i386-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

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

Yoichi

Signed-off-by: Yoichi Yuasa <yuasa@hh.iij4u.or.jp>

diff -urN -X dontdiff rc1-mm3-orig/drivers/serial/vr41xx_siu.c rc1-mm3/drivers/serial/vr41xx_siu.c
--- rc1-mm3-orig/drivers/serial/vr41xx_siu.c	Mon Mar 28 21:08:04 2005
+++ rc1-mm3/drivers/serial/vr41xx_siu.c	Thu Mar 31 12:47:54 2005
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
@@ -804,51 +801,8 @@
 
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
 static struct uart_ops early_uart_ops = {
-	.set_termios	= early_set_termios,
+	.set_termios	= siu_set_termios,
 };
 
 #define BOTH_EMPTY	(UART_LSR_TEMT | UART_LSR_THRE)
@@ -996,8 +950,10 @@
 		port->dev = dev;
 
 		retval = uart_add_one_port(&siu_uart_driver, port);
-		if (retval)
+		if (retval < 0) {
+			port->dev = NULL;
 			break;
+		}
 	}
 
 	if (i == 0 && retval < 0) {


