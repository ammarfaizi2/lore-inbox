Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965077AbVLHAuu@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965077AbVLHAuu (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 7 Dec 2005 19:50:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965078AbVLHAuu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 7 Dec 2005 19:50:50 -0500
Received: from mx1.redhat.com ([66.187.233.31]:42977 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S965077AbVLHAut (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 7 Dec 2005 19:50:49 -0500
Date: Wed, 7 Dec 2005 19:50:40 -0500
From: Dave Jones <davej@redhat.com>
To: Xavier Bestel <xavier.bestel@free.fr>, Jason Dravet <dravet@hotmail.com>,
       linux-kernel@vger.kernel.org
Subject: Re: wrong number of serial port detected
Message-ID: <20051208005040.GB3664@redhat.com>
Mail-Followup-To: Dave Jones <davej@redhat.com>,
	Xavier Bestel <xavier.bestel@free.fr>,
	Jason Dravet <dravet@hotmail.com>, linux-kernel@vger.kernel.org
References: <20051207155034.GB6793@flint.arm.linux.org.uk> <BAY103-F32F90C9849D407E9336826DF430@phx.gbl> <20051207211551.GL6793@flint.arm.linux.org.uk> <1133990886.6184.2.camel@bip.parateam.prv> <20051207213128.GM6793@flint.arm.linux.org.uk> <20051207213856.GN6793@flint.arm.linux.org.uk> <20051207230302.GD22690@redhat.com> <20051207234603.GQ6793@flint.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20051207234603.GQ6793@flint.arm.linux.org.uk>
User-Agent: Mutt/1.4.2.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Dec 07, 2005 at 11:46:04PM +0000, Russell King wrote:

 > > Would something like this be acceptable ?
 > Sure, looks fine.  The new parameter should probably be documented
 > though, so folk know about it.

Where to? Looks like the other 8250 params aren't documented
in Documentation/ either.
If there's another good place for it already, I'll add it there.
Shall I just add it to kernel-parameters.txt ?

 > > @@ -2653,6 +2657,9 @@ module_param(share_irqs, uint, 0644);
 > >  MODULE_PARM_DESC(share_irqs, "Share IRQs with other non-8250/16x50 devices"
 > >  	" (unsafe)");
 > >  
 > > +module_param(nr_uarts, uint, 0644);
 > > +MODULE_PARM_DESC(nr_uarts, "Maximum number of UARTs supported.");
 > 
 > Should this help string include the compile-time maximum somehow?

Done.

 > What limits it to the compile-time maximum?

Hey, this was a rough & ready implementation ;)
I wanted to be sure you were ok with the principle of it first.
It now clips it to NR_UARTS.

 > > +config SERIAL_8250_RUNTIME_UARTS
 > > +	int "Number of 8250/16550 serial ports to register at runtime"
 > > +	depends on SERIAL_8250
 > > +	default "4"
 > 
 > Can this be restricted to a range of 1 to SERIAL_8250_UARTS ?

Heh, Seems not.
menuconfig gets very confused by range 1 CONFIG_SERIAL_8250_NR_UARTS
and won't let me set it to anything.
We can always add that later though if Kconfig gets fixed.

 > > +	help
 > > +	  Set this to the maximum number of serial ports you want
 > > +	  the kernel to register at boot time.  This can be overriden
 > > +	  with the parameter "nr_uarts".
 > 
 > And should we also give a pointer to the boot-time parameter (which
 > I think will be 8250.nr_uarts ?)

Done.

Here's another iteration. I'll boot test this in a bit, and if it
does the right thing, I'll add the documenation and a sign-off
and send it your way.

		Dave


diff -urpN --exclude-from=/home/davej/.exclude vanilla/drivers/serial/8250.c serial/drivers/serial/8250.c
--- vanilla/drivers/serial/8250.c	2005-10-27 20:02:08.000000000 -0400
+++ serial/drivers/serial/8250.c	2005-12-07 19:33:33.000000000 -0500
@@ -53,6 +53,8 @@
  */
 static unsigned int share_irqs = SERIAL8250_SHARE_IRQS;
 
+static unsigned int nr_uarts = CONFIG_SERIAL_8250_RUNTIME_UARTS;
+
 /*
  * Debugging.
  */
@@ -2047,7 +2049,7 @@ static void __init serial8250_isa_init_p
 		return;
 	first = 0;
 
-	for (i = 0; i < UART_NR; i++) {
+	for (i = 0; i < nr_uarts; i++) {
 		struct uart_8250_port *up = &serial8250_ports[i];
 
 		up->port.line = i;
@@ -2066,7 +2068,7 @@ static void __init serial8250_isa_init_p
 	}
 
 	for (i = 0, up = serial8250_ports;
-	     i < ARRAY_SIZE(old_serial_port) && i < UART_NR;
+	     i < ARRAY_SIZE(old_serial_port) && i < nr_uarts;
 	     i++, up++) {
 		up->port.iobase   = old_serial_port[i].port;
 		up->port.irq      = irq_canonicalize(old_serial_port[i].irq);
@@ -2088,7 +2090,7 @@ serial8250_register_ports(struct uart_dr
 
 	serial8250_isa_init_ports();
 
-	for (i = 0; i < UART_NR; i++) {
+	for (i = 0; i < nr_uarts; i++) {
 		struct uart_8250_port *up = &serial8250_ports[i];
 
 		up->port.dev = dev;
@@ -2189,7 +2191,7 @@ static int serial8250_console_setup(stru
 	 * if so, search for the first available port that does have
 	 * console support.
 	 */
-	if (co->index >= UART_NR)
+	if (co->index >= nr_uarts)
 		co->index = 0;
 	port = &serial8250_ports[co->index].port;
 	if (!port->iobase && !port->membase)
@@ -2225,7 +2227,7 @@ static int __init find_port(struct uart_
 	int line;
 	struct uart_port *port;
 
-	for (line = 0; line < UART_NR; line++) {
+	for (line = 0; line < nr_uarts; line++) {
 		port = &serial8250_ports[line].port;
 		if (p->iotype == port->iotype &&
 		    p->iobase == port->iobase &&
@@ -2349,7 +2351,7 @@ static int __devexit serial8250_remove(s
 {
 	int i;
 
-	for (i = 0; i < UART_NR; i++) {
+	for (i = 0; i < nr_uarts; i++) {
 		struct uart_8250_port *up = &serial8250_ports[i];
 
 		if (up->port.dev == dev)
@@ -2365,7 +2367,7 @@ static int serial8250_suspend(struct dev
 	if (level != SUSPEND_DISABLE)
 		return 0;
 
-	for (i = 0; i < UART_NR; i++) {
+	for (i = 0; i < nr_uarts; i++) {
 		struct uart_8250_port *up = &serial8250_ports[i];
 
 		if (up->port.type != PORT_UNKNOWN && up->port.dev == dev)
@@ -2382,7 +2384,7 @@ static int serial8250_resume(struct devi
 	if (level != RESUME_ENABLE)
 		return 0;
 
-	for (i = 0; i < UART_NR; i++) {
+	for (i = 0; i < nr_uarts; i++) {
 		struct uart_8250_port *up = &serial8250_ports[i];
 
 		if (up->port.type != PORT_UNKNOWN && up->port.dev == dev)
@@ -2421,7 +2423,7 @@ static struct uart_8250_port *serial8250
 	/*
 	 * First, find a port entry which matches.
 	 */
-	for (i = 0; i < UART_NR; i++)
+	for (i = 0; i < nr_uarts; i++)
 		if (uart_match_port(&serial8250_ports[i].port, port))
 			return &serial8250_ports[i];
 
@@ -2430,7 +2432,7 @@ static struct uart_8250_port *serial8250
 	 * free entry.  We look for one which hasn't been previously
 	 * used (indicated by zero iobase).
 	 */
-	for (i = 0; i < UART_NR; i++)
+	for (i = 0; i < nr_uarts; i++)
 		if (serial8250_ports[i].port.type == PORT_UNKNOWN &&
 		    serial8250_ports[i].port.iobase == 0)
 			return &serial8250_ports[i];
@@ -2439,7 +2441,7 @@ static struct uart_8250_port *serial8250
 	 * That also failed.  Last resort is to find any entry which
 	 * doesn't have a real port associated with it.
 	 */
-	for (i = 0; i < UART_NR; i++)
+	for (i = 0; i < nr_uarts; i++)
 		if (serial8250_ports[i].port.type == PORT_UNKNOWN)
 			return &serial8250_ports[i];
 
@@ -2524,8 +2526,11 @@ static int __init serial8250_init(void)
 {
 	int ret, i;
 
+	if (nr_uarts > UART_NR)
+		nr_uarts = UART_NR;
+
 	printk(KERN_INFO "Serial: 8250/16550 driver $Revision: 1.90 $ "
-		"%d ports, IRQ sharing %sabled\n", (int) UART_NR,
+		"%d ports, IRQ sharing %sabled\n", nr_uarts,
 		share_irqs ? "en" : "dis");
 
 	for (i = 0; i < NR_IRQS; i++)
@@ -2585,6 +2590,9 @@ module_param(share_irqs, uint, 0644);
 MODULE_PARM_DESC(share_irqs, "Share IRQs with other non-8250/16x50 devices"
 	" (unsafe)");
 
+module_param(nr_uarts, uint, 0644);
+MODULE_PARM_DESC(nr_uarts, "Maximum number of UARTs supported. (1-" __MODULE_STRING(CONFIG_SERIAL_8250_RUNTIME_UARTS) ")");
+
 #ifdef CONFIG_SERIAL_8250_RSA
 module_param_array(probe_rsa, ulong, &probe_rsa_count, 0444);
 MODULE_PARM_DESC(probe_rsa, "Probe I/O ports for RSA");
diff -urpN --exclude-from=/home/davej/.exclude vanilla/drivers/serial/Kconfig serial/drivers/serial/Kconfig
--- vanilla/drivers/serial/Kconfig	2005-10-27 20:02:08.000000000 -0400
+++ serial/drivers/serial/Kconfig	2005-12-07 19:24:11.000000000 -0500
@@ -95,6 +95,16 @@ config SERIAL_8250_NR_UARTS
 	  PCI enumeration and any ports that may be added at run-time
 	  via hot-plug, or any ISA multi-port serial cards.
 
+config SERIAL_8250_RUNTIME_UARTS
+	int "Number of 8250/16550 serial ports to register at runtime"
+	depends on SERIAL_8250
+	default "4"
+	help
+	  Set this to the maximum number of serial ports you want
+	  the kernel to register at boot time.  This can be overriden
+	  with the module parameter "nr_uarts", or boot-time parameter
+	  8250.nr_uarts
+
 config SERIAL_8250_EXTENDED
 	bool "Extended 8250/16550 serial driver options"
 	depends on SERIAL_8250
