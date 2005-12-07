Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030431AbVLGXEa@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030431AbVLGXEa (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 7 Dec 2005 18:04:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751797AbVLGXEa
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 7 Dec 2005 18:04:30 -0500
Received: from mx1.redhat.com ([66.187.233.31]:24234 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S1750886AbVLGXE3 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 7 Dec 2005 18:04:29 -0500
Date: Wed, 7 Dec 2005 18:03:02 -0500
From: Dave Jones <davej@redhat.com>
To: Xavier Bestel <xavier.bestel@free.fr>, Jason Dravet <dravet@hotmail.com>,
       linux-kernel@vger.kernel.org
Subject: Re: wrong number of serial port detected
Message-ID: <20051207230302.GD22690@redhat.com>
Mail-Followup-To: Dave Jones <davej@redhat.com>,
	Xavier Bestel <xavier.bestel@free.fr>,
	Jason Dravet <dravet@hotmail.com>, linux-kernel@vger.kernel.org
References: <20051207155034.GB6793@flint.arm.linux.org.uk> <BAY103-F32F90C9849D407E9336826DF430@phx.gbl> <20051207211551.GL6793@flint.arm.linux.org.uk> <1133990886.6184.2.camel@bip.parateam.prv> <20051207213128.GM6793@flint.arm.linux.org.uk> <20051207213856.GN6793@flint.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20051207213856.GN6793@flint.arm.linux.org.uk>
User-Agent: Mutt/1.4.2.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Dec 07, 2005 at 09:38:56PM +0000, Russell King wrote:
 > On Wed, Dec 07, 2005 at 09:31:28PM +0000, Russell King wrote:
 > > On Wed, Dec 07, 2005 at 10:28:05PM +0100, Xavier Bestel wrote:
 > > > Le mercredi 07 d?cembre 2005 ? 21:15 +0000, Russell King a ?crit :
 > > > 
 > > > > 4. User tries the well documented "setserial /dev/ttyS2 port 0x220 irq 5"
 > > > >    procedure, which has been supported since Linux 1.x
 > > > > 
 > > > > 5. User finds that, because there is no ttyS2 device in /dev, they
 > > > >    can't configure their card.
 > > > 
 > > > Well, instead of polluting everybody's /dev for the 3 users having such
 > > > cards, why not just tell the user to run
 > > > MAKEDEV /dev/ttyS2 ; setserial /dev/ttyS2 port 0x220 irq 5
 > > > instead ? (Or even mknod)
 > > 
 > > Oh sorry.  Mail me your root password and IP address, let me log in
 > > to your system, and I'll remove those device nodes right now.  Thanks
 > > for pointing that out.
 > > 
 > > Seriously, surely you aren't suggesting that I somehow have personal
 > > control over this?
 > 
 > Additionally, if you have a problem with this, the total number of
 > ports _is_ kernel configurable.
 > 
 > So if you're getting 32 ports from a distro targetted at the current
 > range of consumer hardware which commonly has maybe 1 or 2 and
 > possibly a modem card (iow probably max 4 ports), please take it up
 > with them.

Ok, how about something along the lines of this (completely untested) patch,
which adds a runtime param to lower the number of registered ports,
also allowing a default to be set for common cases.

Would something like this be acceptable ?

It would mean that users of kernels with NR_UARTS currently set to 32
would either also have to set the new default if they build their own
kernels, or fiddle with a module param to see past their first four ports
if they run a vendor kernel.
Given these people are the minority use-case, adding one extra option
to their modprobe.conf doesn't seem too harsh, does it ?

		Dave


diff -urpN --exclude-from=/home/devel/davej/.exclude vanilla/drivers/serial/8250.c linux-2.6.14/drivers/serial/8250.c
--- vanilla/drivers/serial/8250.c	2005-12-07 17:56:56.000000000 -0500
+++ linux-2.6.14/drivers/serial/8250.c	2005-12-07 17:51:52.000000000 -0500
@@ -54,6 +54,8 @@
  */
 static unsigned int share_irqs = SERIAL8250_SHARE_IRQS;
 
+static unsigned int nr_uarts = CONFIG_SERIAL_8250_RUNTIME_UARTS;
+
 /*
  * Debugging.
  */
@@ -2118,7 +2120,7 @@ static void __init serial8250_isa_init_p
 		return;
 	first = 0;
 
-	for (i = 0; i < UART_NR; i++) {
+	for (i = 0; i < nr_uarts; i++) {
 		struct uart_8250_port *up = &serial8250_ports[i];
 
 		up->port.line = i;
@@ -2137,7 +2139,7 @@ static void __init serial8250_isa_init_p
 	}
 
 	for (i = 0, up = serial8250_ports;
-	     i < ARRAY_SIZE(old_serial_port) && i < UART_NR;
+	     i < ARRAY_SIZE(old_serial_port) && i < nr_uarts;
 	     i++, up++) {
 		up->port.iobase   = old_serial_port[i].port;
 		up->port.irq      = irq_canonicalize(old_serial_port[i].irq);
@@ -2159,7 +2161,7 @@ serial8250_register_ports(struct uart_dr
 
 	serial8250_isa_init_ports();
 
-	for (i = 0; i < UART_NR; i++) {
+	for (i = 0; i < nr_uarts; i++) {
 		struct uart_8250_port *up = &serial8250_ports[i];
 
 		up->port.dev = dev;
@@ -2262,7 +2266,7 @@ static int serial8250_console_setup(stru
 	 * if so, search for the first available port that does have
 	 * console support.
 	 */
-	if (co->index >= UART_NR)
+	if (co->index >= nr_uarts)
 		co->index = 0;
 	port = &serial8250_ports[co->index].port;
 	if (!port->iobase && !port->membase)
@@ -2298,7 +2302,7 @@ static int __init find_port(struct uart_
 	int line;
 	struct uart_port *port;
 
-	for (line = 0; line < UART_NR; line++) {
+	for (line = 0; line < nr_uarts; line++) {
 		port = &serial8250_ports[line].port;
 		if (p->iotype == port->iotype &&
 		    p->iobase == port->iobase &&
@@ -2422,7 +2426,7 @@ static int __devexit serial8250_remove(s
 {
 	int i;
 
-	for (i = 0; i < UART_NR; i++) {
+	for (i = 0; i < nr_uarts; i++) {
 		struct uart_8250_port *up = &serial8250_ports[i];
 
 		if (up->port.dev == &dev->dev)
@@ -2435,7 +2439,7 @@ static int serial8250_suspend(struct pla
 {
 	int i;
 
-	for (i = 0; i < UART_NR; i++) {
+	for (i = 0; i < nr_uarts; i++) {
 		struct uart_8250_port *up = &serial8250_ports[i];
 
 		if (up->port.type != PORT_UNKNOWN && up->port.dev == &dev->dev)
@@ -2449,7 +2453,7 @@ static int serial8250_resume(struct plat
 {
 	int i;
 
-	for (i = 0; i < UART_NR; i++) {
+	for (i = 0; i < nr_uarts; i++) {
 		struct uart_8250_port *up = &serial8250_ports[i];
 
 		if (up->port.type != PORT_UNKNOWN && up->port.dev == &dev->dev)
@@ -2489,7 +2493,7 @@ static struct uart_8250_port *serial8250
 	/*
 	 * First, find a port entry which matches.
 	 */
-	for (i = 0; i < UART_NR; i++)
+	for (i = 0; i < nr_uarts; i++)
 		if (uart_match_port(&serial8250_ports[i].port, port))
 			return &serial8250_ports[i];
 
@@ -2498,7 +2502,7 @@ static struct uart_8250_port *serial8250
 	 * free entry.  We look for one which hasn't been previously
 	 * used (indicated by zero iobase).
 	 */
-	for (i = 0; i < UART_NR; i++)
+	for (i = 0; i < nr_uarts; i++)
 		if (serial8250_ports[i].port.type == PORT_UNKNOWN &&
 		    serial8250_ports[i].port.iobase == 0)
 			return &serial8250_ports[i];
@@ -2507,7 +2511,7 @@ static struct uart_8250_port *serial8250
 	 * That also failed.  Last resort is to find any entry which
 	 * doesn't have a real port associated with it.
 	 */
-	for (i = 0; i < UART_NR; i++)
+	for (i = 0; i < nr_uarts; i++)
 		if (serial8250_ports[i].port.type == PORT_UNKNOWN)
 			return &serial8250_ports[i];
 
@@ -2593,7 +2597,7 @@ static int __init serial8250_init(void)
 	int ret, i;
 
 	printk(KERN_INFO "Serial: 8250/16550 driver $Revision: 1.90 $ "
-		"%d ports, IRQ sharing %sabled\n", (int) UART_NR,
+		"%d ports, IRQ sharing %sabled\n", nr_uarts,
 		share_irqs ? "en" : "dis");
 
 	for (i = 0; i < NR_IRQS; i++)
@@ -2653,6 +2657,9 @@ module_param(share_irqs, uint, 0644);
 MODULE_PARM_DESC(share_irqs, "Share IRQs with other non-8250/16x50 devices"
 	" (unsafe)");
 
+module_param(nr_uarts, uint, 0644);
+MODULE_PARM_DESC(nr_uarts, "Maximum number of UARTs supported.");
+
 #ifdef CONFIG_SERIAL_8250_RSA
 module_param_array(probe_rsa, ulong, &probe_rsa_count, 0444);
 MODULE_PARM_DESC(probe_rsa, "Probe I/O ports for RSA");
diff -urpN --exclude-from=/home/devel/davej/.exclude vanilla/drivers/serial/Kconfig linux-2.6.14/drivers/serial/Kconfig
--- vanilla/drivers/serial/Kconfig	2005-12-07 17:56:56.000000000 -0500
+++ linux-2.6.14/drivers/serial/Kconfig	2005-12-07 17:53:34.000000000 -0500
@@ -95,6 +100,15 @@ config SERIAL_8250_NR_UARTS
 	  PCI enumeration and any ports that may be added at run-time
 	  via hot-plug, or any ISA multi-port serial cards.
 
+config SERIAL_8250_RUNTIME_UARTS
+	int "Number of 8250/16550 serial ports to register at runtime"
+	depends on SERIAL_8250
+	default "4"
+	help
+	  Set this to the maximum number of serial ports you want
+	  the kernel to register at boot time.  This can be overriden
+	  with the parameter "nr_uarts".
+
 config SERIAL_8250_EXTENDED
 	bool "Extended 8250/16550 serial driver options"
 	depends on SERIAL_8250



