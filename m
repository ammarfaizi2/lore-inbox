Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264141AbUBKOsr (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 11 Feb 2004 09:48:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265289AbUBKOsq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 11 Feb 2004 09:48:46 -0500
Received: from svr44.ehostpros.com ([66.98.192.92]:35781 "EHLO
	svr44.ehostpros.com") by vger.kernel.org with ESMTP id S264141AbUBKOsY
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 11 Feb 2004 09:48:24 -0500
From: "Amit S. Kale" <amitkale@emsyssoft.com>
Organization: EmSysSoft
To: KGDB bugreports <kgdb-bugreport@lists.sourceforge.net>,
       Linux Kernel <linux-kernel@vger.kernel.org>
Subject: kgdb interdiff for 8250.patch
Date: Wed, 11 Feb 2004 20:17:44 +0530
User-Agent: KMail/1.5
Cc: George Anzinger <george@mvista.com>, Tom Rini <trini@kernel.crashing.org>,
       Pavel Machek <pavel@suse.cz>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200402112017.45412.amitkale@emsyssoft.com>
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - svr44.ehostpros.com
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - emsyssoft.com
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

Here is interdiff for file 8250.patch

--- archive/2.1.0/linux-2.6.1-kgdb-2.1.0/8250.patch	2004-01-21 
22:03:08.000000000 +0530
+++ cvs/kgdb-2/8250.patch	2004-02-11 16:01:04.000000000 +0530
@@ -1,6 +1,6 @@
-diff -Naurp linux-2.6.1/drivers/serial/8250.c 
linux-2.6.1-kgdb-2.1.0-8250/drivers/serial/8250.c
---- linux-2.6.1/drivers/serial/8250.c	2004-01-10 11:01:45.000000000 +0530
-+++ linux-2.6.1-kgdb-2.1.0-8250/drivers/serial/8250.c	2004-01-12 
19:10:45.000000000 +0530
+diff -Naurp linux-2.6.2/drivers/serial/8250.c 
linux-2.6.2-kgdb-8250/drivers/serial/8250.c
+--- linux-2.6.2/drivers/serial/8250.c	2004-01-10 11:01:45.000000000 +0530
++++ linux-2.6.2-kgdb-8250/drivers/serial/8250.c	2004-02-10 18:49:00.000000000 
+0530
 @@ -1198,12 +1198,17 @@ static void serial8250_break_ctl(struct 
  	spin_unlock_irqrestore(&up->port.lock, flags);
  }
@@ -48,7 +48,7 @@
 +	int ttyS;
 +
 +	if (released_irq != -1) {
-+		return 1;
++		return -EBUSY;
 +	}
 +	released_irq = irq;
 +	for (ttyS = 0; ttyS < UART_NR; ttyS++){
@@ -67,9 +67,9 @@
  static int __init serial8250_init(void)
  {
  	int ret, i;
-diff -Naurp linux-2.6.1/drivers/serial/Kconfig 
linux-2.6.1-kgdb-2.1.0-8250/drivers/serial/Kconfig
---- linux-2.6.1/drivers/serial/Kconfig	2003-11-24 07:03:13.000000000 +0530
-+++ linux-2.6.1-kgdb-2.1.0-8250/drivers/serial/Kconfig	2004-01-12 
19:10:45.000000000 +0530
+diff -Naurp linux-2.6.2/drivers/serial/Kconfig 
linux-2.6.2-kgdb-8250/drivers/serial/Kconfig
+--- linux-2.6.2/drivers/serial/Kconfig	2004-02-10 13:01:27.000000000 +0530
++++ linux-2.6.2-kgdb-8250/drivers/serial/Kconfig	2004-02-10 
13:10:17.000000000 +0530
 @@ -6,6 +6,13 @@
  
  menu "Serial drivers"
@@ -84,10 +84,10 @@
  #
  # The new 8250/16550 serial drivers
  config SERIAL_8250
-diff -Naurp linux-2.6.1/drivers/serial/kgdb_8250.c 
linux-2.6.1-kgdb-2.1.0-8250/drivers/serial/kgdb_8250.c
---- linux-2.6.1/drivers/serial/kgdb_8250.c	1970-01-01 05:30:00.000000000 
+0530
-+++ linux-2.6.1-kgdb-2.1.0-8250/drivers/serial/kgdb_8250.c	2004-01-17 
13:55:58.000000000 +0530
-@@ -0,0 +1,408 @@
+diff -Naurp linux-2.6.2/drivers/serial/kgdb_8250.c 
linux-2.6.2-kgdb-8250/drivers/serial/kgdb_8250.c
+--- linux-2.6.2/drivers/serial/kgdb_8250.c	1970-01-01 05:30:00.000000000 
+0530
++++ linux-2.6.2-kgdb-8250/drivers/serial/kgdb_8250.c	2004-02-10 
18:53:13.000000000 +0530
+@@ -0,0 +1,396 @@
 +/*
 + * 8250 interface for kgdb.
 + *
@@ -150,14 +150,11 @@
 +static void (*serial_outb)(unsigned char, unsigned long);
 +static unsigned long (*serial_inb)(unsigned long);
 +
-+extern void	set_debug_traps(void) ;		/* GDB routine */
 +int serial8250_release_irq(int irq);
 +
 +int kgdb8250_irq;
 +unsigned long  kgdb8250_port;
 +
-+static int initialized = -1;
-+
 +int kgdb8250_baud = 115200;
 +int kgdb8250_ttyS;
 +
@@ -183,35 +180,36 @@
 +
 +/*
 + * Get a byte from the hardware data buffer and return it
++ * Get a char if available, return -EAGAIN if nothing available.
 + */
 +static int read_data_bfr(void)
 +{
 +	if (serial_inb(kgdb8250_port + UART_LSR) & UART_LSR_DR)
 +		return(serial_inb(kgdb8250_port + UART_RX));
 +
-+	return( -1 ) ;
-+
++	return -EAGAIN;
 +}
 +
 +/*
-+ * Get a char if available, return -1 if nothing available.
 + * Empty the receive buffer first, then look at the interface hardware.
-+ * It waits for a character from the serial interface and then returns it. 
++ * It waits for a character from the serial interface and then returns it.
 + */
 +static int kgdb8250_read_char(void)
 +{
 +	int retchar;
-+	if (atomic_read(&kgdb8250_buf_in_cnt) != 0)	/* intr routine has q'd chars 
*/
++	if (atomic_read(&kgdb8250_buf_in_cnt) != 0)
 +	{
-+		int		chr ;
++		/* intr routine has q'd chars read them from buffer */
++		int		chr;
 +
-+		chr = kgdb8250_buf[kgdb8250_buf_out_inx++] ;
-+		kgdb8250_buf_out_inx &= (GDB_BUF_SIZE - 1) ;
-+		atomic_dec(&kgdb8250_buf_in_cnt) ;
-+		return(chr) ;
++		chr = kgdb8250_buf[kgdb8250_buf_out_inx++];
++		kgdb8250_buf_out_inx &= (GDB_BUF_SIZE - 1);
++		atomic_dec(&kgdb8250_buf_in_cnt);
++		return chr;
 +	}
 +	do {
-+		retchar = (read_data_bfr()) ;	/* read from hardware */
++		/* read from hardware */
++		retchar = read_data_bfr();
 +	} while (retchar < 0);
 +	return retchar;
 +} 
@@ -221,11 +219,12 @@
 + */
 +static void kgdb8250_write_char(int chr)
 +{
-+    while ( !(serial_inb(kgdb8250_port + UART_LSR) & UART_LSR_THRE) ) ;
++    while (!(serial_inb(kgdb8250_port + UART_LSR) & UART_LSR_THRE))
++	    /* Do nothing */;
 +
 +    serial_outb(chr, kgdb8250_port+UART_TX);
 +
-+} /* write_char */
++}
 +
 +/*
 + * This is the receiver interrupt routine for the GDB stub.
@@ -249,7 +248,8 @@
 + * care to learn can make this work for any low level serial
 + * driver.
 + */
-+static irqreturn_t kgdb8250_interrupt(int irq, void *dev_id, struct pt_regs 
* regs)
++static irqreturn_t kgdb8250_interrupt(int irq, void *dev_id,
++		struct pt_regs * regs)
 +{
 +	int	chr;
 +	int	iir;
@@ -311,11 +311,9 @@
 +}
 +
 +/* 
-+ *  Takes:
++ * Initializes serial port.
 + *	ttyS - integer specifying which serial port to use for debugging
 + *	baud - baud rate of specified serial port
-+ *  Returns:
-+ *	port for use by the gdb serial driver
 + */
 +static int kgdb8250_init(int ttyS, int baud)
 +{
@@ -405,7 +403,7 @@
 +         *      If we read 0xff from the LSR, there is no UART here.
 +         */
 +        if (serial_inb(kgdb8250_port + UART_LSR) == 0xff)
-+                return -1;
++                return -ENODEV;
 +        return 0;
 +}
 +
@@ -431,24 +429,16 @@
 +	}
 +
 +#ifdef CONFIG_SERIAL_8250
-+	if (serial8250_release_irq(kgdb8250_irq))
-+		return -1;
++	if ((retval = serial8250_release_irq(kgdb8250_irq)) < 0)
++		return retval;
 +#endif
 +
-+	if (kgdb8250_init(kgdb8250_ttyS, kgdb8250_baud) == -1)
-+		return -1;
++	if ((retval = kgdb8250_init(kgdb8250_ttyS, kgdb8250_baud)) < 0)
++		return retval;
 +
 +	retval = request_irq(kgdb8250_irq, kgdb8250_interrupt, SA_INTERRUPT,
 +                         "GDB-stub", NULL);
-+	if (retval == 0)
-+        	initialized = 1;
-+	else
-+	{
-+        	initialized = 0;
-+	}
-+
-+	return 0;
-+
++	return retval;
 +}
 +
 +void
@@ -460,7 +450,7 @@
 +	rs_table[i].regshift = serial_req->regshift;
 +}
 +
-+struct kgdb_serial kgdb8250_serial = {
++struct kgdb_serial kgdb8250_serial_driver = {
 +	.read_char = kgdb8250_read_char,
 +	.write_char = kgdb8250_write_char,
 +	.hook = kgdb8250_hook
@@ -485,9 +475,7 @@
 +	    kgdb8250_baud != 38400 && kgdb8250_baud != 57600 &&
 +	    kgdb8250_baud != 115200)
 +		goto errout;
-+
-+	kgdb_serial = &kgdb8250_serial;
-+
++	kgdb_serial = &kgdb8250_serial_driver;
 +	return 1;
 +
 +errout:
@@ -496,20 +484,20 @@
 +}
 +
 +__setup("kgdb8250=", kgdb8250_opt);
-diff -Naurp linux-2.6.1/drivers/serial/Makefile 
linux-2.6.1-kgdb-2.1.0-8250/drivers/serial/Makefile
---- linux-2.6.1/drivers/serial/Makefile	2003-11-24 07:01:55.000000000 +0530
-+++ linux-2.6.1-kgdb-2.1.0-8250/drivers/serial/Makefile	2004-01-12 
19:10:45.000000000 +0530
+diff -Naurp linux-2.6.2/drivers/serial/Makefile 
linux-2.6.2-kgdb-8250/drivers/serial/Makefile
+--- linux-2.6.2/drivers/serial/Makefile	2003-11-24 07:01:55.000000000 +0530
++++ linux-2.6.2-kgdb-8250/drivers/serial/Makefile	2004-02-10 
13:10:17.000000000 +0530
 @@ -32,3 +32,5 @@ obj-$(CONFIG_SERIAL_COLDFIRE) += mcfseri
  obj-$(CONFIG_V850E_UART) += v850e_uart.o
  obj-$(CONFIG_SERIAL98) += serial98.o
  obj-$(CONFIG_SERIAL_PMACZILOG) += pmac_zilog.o
 +
 +obj-$(CONFIG_KGDB_8250) += kgdb_8250.o
-diff -Naurp linux-2.6.1/drivers/serial/serial_core.c 
linux-2.6.1-kgdb-2.1.0-8250/drivers/serial/serial_core.c
---- linux-2.6.1/drivers/serial/serial_core.c	2004-01-10 11:01:45.000000000 
+0530
-+++ linux-2.6.1-kgdb-2.1.0-8250/drivers/serial/serial_core.c	2004-01-12 
19:10:45.000000000 +0530
-@@ -1209,7 +1209,11 @@ static void uart_set_termios(struct tty_
- static void uart_close(struct tty_struct *tty, struct file *filp)
+diff -Naurp linux-2.6.2/drivers/serial/serial_core.c 
linux-2.6.2-kgdb-8250/drivers/serial/serial_core.c
+--- linux-2.6.2/drivers/serial/serial_core.c	2004-02-10 13:01:27.000000000 
+0530
++++ linux-2.6.2-kgdb-8250/drivers/serial/serial_core.c	2004-02-10 
13:10:17.000000000 +0530
+@@ -917,7 +917,11 @@ uart_tiocmset(struct tty_struct *tty, st
+ static void uart_break_ctl(struct tty_struct *tty, int break_state)
  {
  	struct uart_state *state = tty->driver_data;
 -	struct uart_port *port = state->port;
@@ -520,4 +508,4 @@
 +	port = state->port;
  
  	BUG_ON(!kernel_locked());
- 	DPRINTK("uart_close(%d) called\n", port->line);
+ 

