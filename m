Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261822AbUDVX0p@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261822AbUDVX0p (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 22 Apr 2004 19:26:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262837AbUDVX0p
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 22 Apr 2004 19:26:45 -0400
Received: from atlrel6.hp.com ([156.153.255.205]:58816 "EHLO atlrel6.hp.com")
	by vger.kernel.org with ESMTP id S261822AbUDVXZV (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 22 Apr 2004 19:25:21 -0400
From: Bjorn Helgaas <bjorn.helgaas@hp.com>
To: Russell King <rmk@arm.linux.org.uk>
Subject: [PATCH] early serial console support
Date: Thu, 22 Apr 2004 17:25:18 -0600
User-Agent: KMail/1.6.1
Cc: linux-kernel@vger.kernel.org, linux-ia64@vger.kernel.org
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Message-Id: <200404221725.18328.bjorn.helgaas@hp.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Here's another iteration of my early serial console patch.

This includes the ia64 part as well as the 8250 part.  The benefit
to ia64 is that "console=" is now required ONLY when the EFI
console path contains more than one device and you want a
serial console (the default is VGA).

If the EFI console path contains only VGA, we default to that
for the Linux console.  If it contains only a UART device, we
default to that (*).  If it contains both VGA and a UART, we
default to VGA.

(*) HP has a management card (MP) that causes headaches
    because it is always active as an EFI console, even if
    it doesn't appear in the EFI console path.  If your
    console path is set to a non-MP UART, and you happen to
    be using the MP UART, everything works in EFI, but the
    kernel will think the non-MP UART is the console.

If we select a serial console, it is set up early, and we
automatically switch to the normal 8250 serial console driver
after all the serial devices are discovered.  The serial devices
are named independently of the HCDP or EFI console path contents,
so they stay the same across console reconfig.

Users' guide, troubleshooting info, and changelog text below.

Bjorn


USERS' GUIDE:

  - /dev/ttyS<N> naming stays the same, regardless of what
    is selected as the console in EFI.

  - You should use "console=serial" instead of "console=ttyS<N>,<baud>".
    The console will start working early in setup_arch(), basically
    the same place early_printk on i386 and x86_64 starts working.

    If you have an HCDP, the first port listed in it will be used as
    the console, and the HCDP tells us the baud rate.

    If you don't have an HCDP (i.e., HP i2000 or non-HP box), the
    console is assumed to be COM1 (I/O port 0x3f8), and we peek at
    the UART to figure out the baud rate automatically.

  - You CAN still use "console=ttyS0,115200", but the console
    doesn't start working until after the serial driver initializes.

    Note that if the console is an MP port, it may now be named
    /dev/ttyS2 or something instead of ttyS0.

    As before, you must specify the baud rate unless it is 9600.

  - Old kernels don't understand "console=serial", so elilo.conf
    changes are needed if you want an early console.

  - Old kernels named ttyS devices in different orders, depending on
    which one was selected as the EFI console device, so you may
    need to add or change a getty entry in /etc/inittab.

For example, a machine with a built-in serial port plus an MP might
have these ports:

                                old, EFI        old, EFI        new, EFI
                   MMIO         console         console         console
                  address       on builtin      on MP           anywhere
                ----------      ---------       --------        --------
    builtin     0xff5e0000      ttyS0           ttyS1           ttyS0
    MP UPS      0xf8031000      ttyS1           ttyS2           ttyS1
    MP Console  0xf8030000      ttyS2           ttyS0           ttyS2
    MP 2        0xf8030010      ttyS3           ttyS3           ttyS3
    MP 3        0xf8030038      ttyS4           ttyS4           ttyS4

If you're using the MP console port (the port labelled "console" on
the 3-headed cable), it used to be /dev/ttyS0, but is now /dev/ttyS2.

Troubleshooting:
    - No kernel output after "Uncompressing Linux... done":
        -> You're using an MP port as the console and specified
           "console=ttyS0".  This port is now named something else.
           Use "console=serial" instead.
        -> Multiple UARTs selected as EFI console devices, and you're
           looking at the wrong one.  Make sure only one UART is
           selected (use the Boot Manager "Boot option maintenance"
           menu).
        -> You're physically connected to the MP port but have a
           non-MP UART selected as EFI console device.  Either move
           the console cable to the non-MP UART, or change the EFI
           console path to the MP UART (the MP UART is the one with
           "Acpi(HWP0002,700)/Pci(...)/Uart" in it.)

    - Long pause (60+ seconds) between "Uncompressing Linux... done"
      and start of kernel output:
        -> No early console, probably because you used "console=ttyS0".
           Replace it with "console=serial".

    - Kernel and init script output is fine, but no "login:" prompt:
        -> Missing getty entry in /etc/inittab.  Add the appropriate
           entry based on the kernel "Starting serial console on
           ttyS<N>" message.

    - "login:" prompt, but can't login as root:
        -> Add entry to /etc/securetty for console tty.

CHANGELOG TEXT:

This adds fairly generic early console support to the 8250 serial driver.

The current early_serial_setup() functionality is a bit of a problem for
ia64 because it assumes that you know where ttyS0 is before the driver
initializes.  On ia64, we don't know that because all the devices are
enumerated via ACPI and PCI.

However, we do have a firmware interface to tell us where the serial
console device is.  So this patch adds serial8250_early_console_setup()
so the architecture can specify the MMIO or I/O port address instead of
the ttyS0 device name.

After the serial driver initializes, we automatically try to locate
the corresponding ttyS device, and start up a console on that.

The early serial init and output routines are based on
arch/x86_64/kernel/early_printk.c


===== arch/ia64/kernel/efi.c 1.31 vs edited =====
--- 1.31/arch/ia64/kernel/efi.c	Mon Apr 12 04:21:11 2004
+++ edited/arch/ia64/kernel/efi.c	Wed Apr 21 13:03:31 2004
@@ -747,6 +747,51 @@
 	return 0;
 }
 
+int __init
+efi_uart_console_only(void)
+{
+	efi_status_t status;
+	char *s, name[] = "ConOut";
+	efi_guid_t guid = EFI_GLOBAL_VARIABLE_GUID;
+	efi_char16_t *utf16, name_utf16[32];
+	unsigned char data[1024];
+	unsigned long size = sizeof(data);
+	struct efi_generic_dev_path *hdr, *end_addr;
+	int uart = 0;
+
+	/* Convert to UTF-16 */
+	utf16 = name_utf16;
+	s = name;
+	while (*s)
+		*utf16++ = *s++ & 0x7f;
+	*utf16 = 0;
+
+	status = efi.get_variable(name_utf16, &guid, NULL, &size, data);
+	if (status != EFI_SUCCESS) {
+		printk(KERN_ERR "No EFI %s variable?\n", name);
+		return 0;
+	}
+
+	hdr = (struct efi_generic_dev_path *) data;
+	end_addr = (struct efi_generic_dev_path *) ((u8 *) data + size);
+	while (hdr < end_addr) {
+		if (hdr->type == EFI_DEV_MSG &&
+		    hdr->sub_type == EFI_DEV_MSG_UART)
+			uart = 1;
+		else if (hdr->type == EFI_DEV_END_PATH ||
+			  hdr->type == EFI_DEV_END_PATH2) {
+			if (!uart)
+				return 0;
+			if (hdr->sub_type == EFI_DEV_END_ENTIRE)
+				return 1;
+			uart = 0;
+		}
+		hdr = (struct efi_generic_dev_path *) ((u8 *) hdr + hdr->length);
+	}
+	printk(KERN_ERR "Malformed %s value\n", name);
+	return 0;
+}
+
 static void __exit
 efivars_exit (void)
 {
===== arch/ia64/kernel/setup.c 1.70 vs edited =====
--- 1.70/arch/ia64/kernel/setup.c	Wed Mar 17 05:46:59 2004
+++ edited/arch/ia64/kernel/setup.c	Wed Apr 21 13:38:30 2004
@@ -263,20 +263,40 @@
 
 #ifdef CONFIG_SERIAL_8250_CONSOLE
 static void __init
-setup_serial_legacy (void)
+setup_serial_legacy (char *cmdline)
 {
+	static char buf[32];
+	char *options, *space;
 	struct uart_port port;
-	unsigned int i, iobase[] = {0x3f8, 0x2f8};
 
-	printk(KERN_INFO "Registering legacy COM ports for serial console\n");
+	if (ia64_platform_is("sn2"))
+		return;
+
+	if (!(strstr(cmdline, "console=serial") ||
+	      efi_uart_console_only()))
+		return;
+
+	/*
+	 * Either the user requested a serial console or the EFI
+	 * ConOut path includes only UARTs.  But we have no idea where
+	 * the UART is, so assume it's COM1.
+	 */
 	memset(&port, 0, sizeof(port));
 	port.iotype = SERIAL_IO_PORT;
+	port.iobase = 0x3f8;
 	port.uartclk = BASE_BAUD * 16;
-	for (i = 0; i < ARRAY_SIZE(iobase); i++) {
-		port.line = i;
-		port.iobase = iobase[i];
-		early_serial_setup(&port);
+
+	options = strstr(cmdline, "console=serial,");
+	if (options) {
+		options += 15;	// strlen("console=serial,")
+		strlcpy(buf, options, sizeof(buf));
+		space = strchr(buf, ' ');
+		if (space)
+			*space = 0;
+		options = buf;
 	}
+
+	serial8250_early_console_setup(&port, options);
 }
 #endif
 
@@ -297,6 +317,17 @@
 	machvec_init(acpi_get_sysname());
 #endif
 
+#ifdef CONFIG_SERIAL_8250_CONSOLE
+#ifdef CONFIG_SERIAL_8250_HCDP
+	if (efi.hcdp) {
+		extern void __init setup_hcdp_console(void *, char *);
+		setup_hcdp_console(efi.hcdp, *cmdline_p);
+	}
+#endif
+	if (!efi.hcdp)
+		setup_serial_legacy(*cmdline_p);
+#endif
+
 #ifdef CONFIG_ACPI_BOOT
 	/* Initialize the ACPI boot-time table parser */
 	acpi_table_init();
@@ -323,41 +354,23 @@
 #ifdef CONFIG_ACPI_BOOT
 	acpi_boot_init();
 #endif
-#ifdef CONFIG_SERIAL_8250_CONSOLE
-#ifdef CONFIG_SERIAL_8250_HCDP
-	if (efi.hcdp) {
-		void setup_serial_hcdp(void *);
-		setup_serial_hcdp(efi.hcdp);
-	}
-#endif
-	/*
-	 * Without HCDP, we won't discover any serial ports until the serial driver looks
-	 * in the ACPI namespace.  If ACPI claims there are some legacy devices, register
-	 * the legacy COM ports so serial console works earlier.  This is slightly dangerous
-	 * because we don't *really* know whether there's anything there, but we hope that
-	 * all new boxes will implement HCDP.
-	 */
-	{
-		extern unsigned char acpi_legacy_devices;
-		if (!efi.hcdp && acpi_legacy_devices)
-			setup_serial_legacy();
-	}
-#endif
 
 #ifdef CONFIG_VT
+	if (!conswitchp) {
 # if defined(CONFIG_DUMMY_CONSOLE)
-	conswitchp = &dummy_con;
+		conswitchp = &dummy_con;
 # endif
 # if defined(CONFIG_VGA_CONSOLE)
-	/*
-	 * Non-legacy systems may route legacy VGA MMIO range to system
-	 * memory.  vga_con probes the MMIO hole, so memory looks like
-	 * a VGA device to it.  The EFI memory map can tell us if it's
-	 * memory so we can avoid this problem.
-	 */
-	if (efi_mem_type(0xA0000) != EFI_CONVENTIONAL_MEMORY)
-		conswitchp = &vga_con;
+		/*
+		 * Non-legacy systems may route legacy VGA MMIO range to system
+		 * memory.  vga_con probes the MMIO hole, so memory looks like
+		 * a VGA device to it.  The EFI memory map can tell us if it's
+		 * memory so we can avoid this problem.
+		 */
+		if (efi_mem_type(0xA0000) != EFI_CONVENTIONAL_MEMORY)
+			conswitchp = &vga_con;
 # endif
+	}
 #endif
 
 	/* enable IA-64 Machine Check Abort Handling */
===== arch/ia64/kernel/smpboot.c 1.49 vs edited =====
--- 1.49/arch/ia64/kernel/smpboot.c	Thu Mar 25 12:53:03 2004
+++ edited/arch/ia64/kernel/smpboot.c	Thu Apr 22 14:31:53 2004
@@ -293,11 +293,6 @@
 	 */
 	ia64_init_itm();
 
-	/*
-	 * Set I/O port base per CPU
-	 */
-	ia64_set_kr(IA64_KR_IO_BASE, __pa(ia64_iobase));
-
 	ia64_mca_cmc_vector_setup();	/* Setup vector on AP & enable */
 
 #ifdef CONFIG_PERFMON
@@ -337,6 +332,9 @@
 start_secondary (void *unused)
 {
 	extern int cpu_idle (void);
+
+	/* Early console may need I/O port base, so set it early */
+	ia64_set_kr(IA64_KR_IO_BASE, __pa(ia64_iobase));
 
 	Dprintk("start_secondary: starting CPU 0x%x\n", hard_smp_processor_id());
 	efi_map_pal_code();
===== drivers/serial/8250.c 1.55 vs edited =====
--- 1.55/drivers/serial/8250.c	Sat Apr 17 03:48:54 2004
+++ edited/drivers/serial/8250.c	Thu Apr 22 15:43:19 2004
@@ -1904,34 +1904,52 @@
 }
 
 #ifdef CONFIG_SERIAL_8250_CONSOLE
+static int serial8250_early_device(struct uart_port *);
 
 #define BOTH_EMPTY (UART_LSR_TEMT | UART_LSR_THRE)
 
 /*
  *	Wait for transmitter & holding register to empty
  */
-static inline void wait_for_xmitr(struct uart_8250_port *up)
+static inline void wait_for_xmitr(struct uart_8250_port *up, int timeout)
 {
 	unsigned int status, tmout = 10000;
 
-	/* Wait up to 10ms for the character(s) to be sent. */
-	do {
+	/*
+	 * Wait for the character(s) to be sent.  If "timeout", wait 10ms
+	 * at most.
+	 */
+	for (;;) {
 		status = serial_in(up, UART_LSR);
 
 		if (status & UART_LSR_BI)
 			up->lsr_break_flag = UART_LSR_BI;
 
-		if (--tmout == 0)
+		if ((status & BOTH_EMPTY) == BOTH_EMPTY)
 			break;
-		udelay(1);
-	} while ((status & BOTH_EMPTY) != BOTH_EMPTY);
 
-	/* Wait up to 1s for flow control if necessary */
+		if (timeout) {
+			if (--tmout == 0)
+				break;
+			udelay(1);
+		}
+	}
+
+	/* Wait for flow control if necessary (for at most 1s if "timeout") */
 	if (up->port.flags & UPF_CONS_FLOW) {
 		tmout = 1000000;
-		while (--tmout &&
-		       ((serial_in(up, UART_MSR) & UART_MSR_CTS) == 0))
-			udelay(1);
+		for (;;) {
+			status = serial_in(up, UART_MSR);
+
+			if (status & UART_MSR_CTS)
+				break;
+
+			if (timeout) {
+				if (--tmout == 0)
+					break;
+				udelay(1);
+			}
+		}
 	}
 }
 
@@ -1942,9 +1960,9 @@
  *	The console_lock must be held when we get here.
  */
 static void
-serial8250_console_write(struct console *co, const char *s, unsigned int count)
+serial8250_write(struct uart_8250_port *up, const char *s, unsigned int count,
+	int timeout)
 {
-	struct uart_8250_port *up = &serial8250_ports[co->index];
 	unsigned int ier;
 	int i;
 
@@ -1962,7 +1980,7 @@
 	 *	Now, do each character
 	 */
 	for (i = 0; i < count; i++, s++) {
-		wait_for_xmitr(up);
+		wait_for_xmitr(up, timeout);
 
 		/*
 		 *	Send the character out.
@@ -1970,7 +1988,7 @@
 		 */
 		serial_out(up, UART_TX, *s);
 		if (*s == 10) {
-			wait_for_xmitr(up);
+			wait_for_xmitr(up, timeout);
 			serial_out(up, UART_TX, 13);
 		}
 	}
@@ -1979,10 +1997,16 @@
 	 *	Finally, wait for transmitter to become empty
 	 *	and restore the IER
 	 */
-	wait_for_xmitr(up);
+	wait_for_xmitr(up, timeout);
 	serial_out(up, UART_IER, ier);
 }
 
+static void
+serial8250_console_write(struct console *co, const char *s, unsigned int count)
+{
+	serial8250_write(&serial8250_ports[co->index], s, count, 1);
+}
+
 static int __init serial8250_console_setup(struct console *co, char *options)
 {
 	struct uart_port *port;
@@ -2003,6 +2027,13 @@
 		return -ENODEV;
 
 	/*
+	 * No need to dump the buffer again if the port is already in
+	 * use as the early console device.
+	 */
+	if (serial8250_early_device(port))
+		co->flags &= ~CON_PRINTBUFFER;
+
+	/*
 	 * Temporary fix.
 	 */
 	spin_lock_init(&port->lock);
@@ -2039,6 +2070,149 @@
 	return 0;
 }
 late_initcall(serial8250_late_console_init);
+
+/*
+ * This is for use before the serial driver has initialized, in
+ * particular, before the UARTs have been discovered and named.  Instead
+ * of specifying the console device as "ttyS0", platform code can call
+ * serial8250_early_console_setup() to specify it directly with an MMIO
+ * or I/O port address.
+ */
+static struct uart_8250_port serial8250_early_port __initdata;
+static char *serial8250_early_options __initdata;
+
+static void __init serial8250_early_write(struct console *co, const char *s,
+					  unsigned int count)
+{
+	/* This may be used very early, so we can't rely on udelay() */
+	serial8250_write(&serial8250_early_port, s, count, 0);
+}
+
+static struct console serial8250_early_console __initdata = {
+	.name	= "serial",
+	.write	= serial8250_early_write,
+	.flags	= CON_PRINTBUFFER,
+	.index	= -1,
+};
+
+static unsigned int __init serial8250_probe_baud(struct uart_8250_port *port)
+{
+	unsigned char lcr, dll, dlm;
+	unsigned int quot;
+
+	lcr = serial_in(port, UART_LCR);
+	serial_out(port, UART_LCR, lcr | UART_LCR_DLAB);
+	dll = serial_in(port, UART_DLL);
+	dlm = serial_in(port, UART_DLM);
+	serial_out(port, UART_LCR, lcr);
+
+	quot = (dlm << 8) | dll;
+	return (port->port.uartclk / 16) / quot;
+}
+
+static void __init serial8250_early_init(struct uart_8250_port *port, unsigned int baud)
+{
+	unsigned char c;
+	unsigned int divisor;
+
+	serial_out(port, UART_LCR, 0x3);	/* 8n1 */
+	serial_out(port, UART_IER, 0);		/* no interrupt */
+	serial_out(port, UART_FCR, 0);		/* no fifo */
+	serial_out(port, UART_MCR, 0x3);	/* DTR + RTS */
+
+	divisor = port->port.uartclk / (16 * baud);
+	c = serial_in(port, UART_LCR);
+	serial_out(port, UART_LCR, c | UART_LCR_DLAB);
+	serial_out(port, UART_DLL, divisor & 0xff);
+	serial_out(port, UART_DLM, (divisor >> 8) & 0xff);
+	serial_out(port, UART_LCR, c & ~UART_LCR_DLAB);
+}
+
+void __init serial8250_early_console_setup(struct uart_port *port, char *options)
+{
+	unsigned int baud = 9600;
+	static char probed_options[16];
+
+	serial8250_early_port.port = *port;
+	if (options) {
+		serial8250_early_options = options;
+		baud = simple_strtoul(options, 0, 0);
+	} else {
+		baud = serial8250_probe_baud(&serial8250_early_port);
+		snprintf(probed_options, sizeof(probed_options), "%u", baud);
+		serial8250_early_options = probed_options;
+	}
+	serial8250_early_init(&serial8250_early_port, baud);
+	printk("Early serial console at %s 0x%lx (options %s)\n",
+		port->iotype == SERIAL_IO_MEM ? "MMIO" : "I/O port",
+		port->iotype == SERIAL_IO_MEM ? (unsigned long) port->mapbase :
+		    (unsigned long) port->iobase,
+		serial8250_early_options);
+	register_console(&serial8250_early_console);
+}
+
+static int __init serial8250_early_device(struct uart_port *port)
+{
+	struct uart_port *early = &serial8250_early_port.port;
+
+	if (early->iotype == port->iotype &&
+	    early->iobase == port->iobase &&
+	    early->membase == port->membase)
+		return 1;
+	return 0;
+}
+
+static int __init serial8250_start_console(char *options)
+{
+	int line;
+	struct uart_port *port;
+
+	for (line = 0; line < UART_NR; line++) {
+		port = &serial8250_ports[line].port;
+		if (serial8250_early_device(port)) {
+			add_preferred_console("ttyS", line, options);
+			break;
+		}
+	}
+	if (line == UART_NR)
+		return -ENODEV;
+
+	printk("Starting serial console on ttyS%d at %s 0x%lx (options %s)\n",
+		line,
+		port->iotype == SERIAL_IO_MEM ? "MMIO" : "I/O port",
+		port->iotype == SERIAL_IO_MEM ? (unsigned long) port->mapbase :
+		(unsigned long) port->iobase,
+		options);
+	if (!(serial8250_console.flags & CON_ENABLED))
+		register_console(&serial8250_console);
+	return line;
+}
+
+static int __init serial8250_early_console_switch(void)
+{
+	struct uart_port *port = &serial8250_early_port.port;
+	int line;
+
+	if (!(serial8250_early_console.flags & CON_ENABLED))
+		return 0;
+
+	/* Try to start the normal driver on a matching line.  */
+	line = serial8250_start_console(serial8250_early_options);
+	if (line < 0)
+		printk("No ttyS device at %s 0x%lx for console\n",
+			port->iotype == SERIAL_IO_MEM ?  "MMIO" : "I/O port",
+			port->iotype == SERIAL_IO_MEM ?
+			    (unsigned long) port->mapbase :
+			    (unsigned long) port->iobase);
+
+	unregister_console(&serial8250_early_console);
+	if (line >= 0)
+		if (port->iotype == SERIAL_IO_MEM)
+			iounmap(port->membase);
+
+	return 0;
+}
+late_initcall(serial8250_early_console_switch);
 
 #define SERIAL8250_CONSOLE	&serial8250_console
 #else
===== drivers/serial/8250_hcdp.c 1.4 vs edited =====
--- 1.4/drivers/serial/8250_hcdp.c	Sat Apr 10 03:26:14 2004
+++ edited/drivers/serial/8250_hcdp.c	Wed Apr 21 13:00:29 2004
@@ -1,249 +1,68 @@
 /*
- * linux/drivers/char/hcdp_serial.c
- *
- * Copyright (C) 2002 Hewlett-Packard Co.
+ * Copyright (C) 2002, 2003, 2004 Hewlett-Packard Co.
  *	Khalid Aziz <khalid_aziz@hp.com>
+ *	Alex Williamson <alex.williamson@hp.com>
+ *	Bjorn Helgaas <bjorn.helgaas@hp.com>
  *
- * Parse the EFI HCDP table to locate serial console and debug ports and
- * initialize them.
- *
- * 2002/08/29 davidm	Adjust it to new 2.5 serial driver infrastructure.
+ * Parse the EFI HCDP table to locate the console device.
  */
 
-#include <linux/config.h>
-#include <linux/kernel.h>
 #include <linux/efi.h>
-#include <linux/init.h>
 #include <linux/tty.h>
 #include <linux/serial.h>
 #include <linux/serial_core.h>
-#include <linux/types.h>
 #include <linux/acpi.h>
-
-#include <asm/io.h>
 #include <asm/serial.h>
-#include <asm/acpi.h>
-
 #include "8250_hcdp.h"
 
-#undef SERIAL_DEBUG_HCDP
-
-/*
- * Parse the HCDP table to find descriptions for headless console and debug
- * serial ports and add them to rs_table[]. A pointer to HCDP table is
- * passed as parameter. This function should be called before
- * serial_console_init() is called to make sure the HCDP serial console will
- * be available for use. IA-64 kernel calls this function from setup_arch()
- * after the EFI and ACPI tables have been parsed.
- */
-void __init
-setup_serial_hcdp(void *tablep)
+static void __init
+setup_serial_console(struct hcdp_uart *uart)
 {
-	hcdp_dev_t *hcdp_dev;
 	struct uart_port port;
-	unsigned long iobase;
-	hcdp_t hcdp;
-	int gsi, nr;
-#if 0
-	static int shift_once = 1;
-#endif
-
-#ifdef SERIAL_DEBUG_HCDP
-	printk("Entering setup_serial_hcdp()\n");
-#endif
-
-	/* Verify we have a valid table pointer */
-	if (!tablep)
-		return;
+	static char options[16];
 
 	memset(&port, 0, sizeof(port));
-
-	/*
-	 * Don't trust firmware to give us a table starting at an aligned
-	 * address. Make a local copy of the HCDP table with aligned
-	 * structures.
-	 */
-	memcpy(&hcdp, tablep, sizeof(hcdp));
-
-	/*
-	 * Perform a sanity check on the table. Table should have a signature
-	 * of "HCDP" and it should be atleast 82 bytes long to have any
-	 * useful information.
-	 */
-	if ((strncmp(hcdp.signature, HCDP_SIGNATURE, HCDP_SIG_LEN) != 0))
-		return;
-	if (hcdp.len < 82)
+	port.uartclk = uart->clock_rate;
+	if (!port.uartclk)	/* some FW doesn't supply this */
+		port.uartclk = BASE_BAUD * 16;
+
+	if (uart->addr.address_space_id == ACPI_ADR_SPACE_SYSTEM_MEMORY) {
+		port.mapbase = uart->addr.address;
+		port.membase = ioremap(port.mapbase, 64);
+		port.iotype = SERIAL_IO_MEM;
+	} else if (uart->addr.address_space_id == ACPI_ADR_SPACE_SYSTEM_IO) {
+		port.iobase = uart->addr.address;
+		port.iotype = SERIAL_IO_PORT;
+	} else
 		return;
 
-#ifdef SERIAL_DEBUG_HCDP
-	printk("setup_serial_hcdp(): table pointer = 0x%p, sig = '%.4s'\n",
-	       tablep, hcdp.signature);
-	printk(" length = %d, rev = %d, ", hcdp.len, hcdp.rev);
-	printk("OEM ID = %.6s, # of entries = %d\n", hcdp.oemid,
-			hcdp.num_entries);
-#endif
-
-	/*
-	 * Parse each device entry
-	 */
-	for (nr = 0; nr < hcdp.num_entries; nr++) {
-		hcdp_dev = hcdp.hcdp_dev + nr;
-		/*
-		 * We will parse only the primary console device which is
-		 * the first entry for these devices. We will ignore rest
-		 * of the entries for the same type device that has already
-		 * been parsed and initialized
-		 */
-		if (hcdp_dev->type != HCDP_DEV_CONSOLE)
-			continue;
-
-		iobase = ((u64) hcdp_dev->base_addr.addrhi << 32) |
-					hcdp_dev->base_addr.addrlo;
-		gsi = hcdp_dev->global_int;
-
-		/* See PCI spec v2.2, Appendix D (Class Codes): */
-		switch (hcdp_dev->pci_prog_intfc) {
-		case 0x00:
-			port.type = PORT_8250;
-			break;
-		case 0x01:
-			port.type = PORT_16450;
-			break;
-		case 0x02:
-			port.type = PORT_16550;
-			break;
-		case 0x03:
-			port.type = PORT_16650;
-			break;
-		case 0x04:
-			port.type = PORT_16750;
-			break;
-		case 0x05:
-			port.type = PORT_16850;
-			break;
-		case 0x06:
-			port.type = PORT_16C950;
-			break;
-		default:
-			printk(KERN_WARNING "warning: EFI HCDP table reports "
-				"unknown serial programming interface 0x%02x; "
-				"will autoprobe.\n", hcdp_dev->pci_prog_intfc);
-			port.type = PORT_UNKNOWN;
-			break;
-		}
-
-#ifdef SERIAL_DEBUG_HCDP
-		printk("  type = %s, uart = %d\n",
-			((hcdp_dev->type == HCDP_DEV_CONSOLE) ?
-			"Headless Console" :
-			((hcdp_dev->type == HCDP_DEV_DEBUG) ?
-			"Debug port" : "Huh????")), port.type);
-		printk("  base address space = %s, base address = 0x%lx\n",
-		       ((hcdp_dev->base_addr.space_id == ACPI_MEM_SPACE) ?
-		       "Memory Space" :
-			((hcdp_dev->base_addr.space_id == ACPI_IO_SPACE) ?
-			"I/O space" : "PCI space")),
-		       iobase);
-		printk("  gsi = %d, baud rate = %lu, bits = %d, clock = %d\n",
-		       gsi, (unsigned long) hcdp_dev->baud, hcdp_dev->bits,
-		       hcdp_dev->clock_rate);
-		if (hcdp_dev->base_addr.space_id == ACPI_PCICONF_SPACE)
-			printk(" PCI id: %02x:%02x:%02x, vendor ID=0x%x, "
-				"dev ID=0x%x\n", hcdp_dev->pci_seg,
-				hcdp_dev->pci_bus, hcdp_dev->pci_dev,
-				hcdp_dev->pci_vendor_id, hcdp_dev->pci_dev_id);
-#endif
-		/*
-		 * Now fill in a port structure to update the 8250 port table..
-		 */
-		if (hcdp_dev->clock_rate)
-			port.uartclk = hcdp_dev->clock_rate;
-		else
-			port.uartclk = BASE_BAUD * 16;
-
-		/*
-		 * Check if this is an I/O mapped address or a memory mapped
-		 * address
-		 */
-		if (hcdp_dev->base_addr.space_id == ACPI_MEM_SPACE) {
-			port.iobase = 0;
-			port.mapbase = iobase;
-			port.membase = ioremap(iobase, 64);
-			port.iotype = SERIAL_IO_MEM;
-		} else if (hcdp_dev->base_addr.space_id == ACPI_IO_SPACE) {
-			port.iobase = iobase;
-			port.mapbase = 0;
-			port.membase = NULL;
-			port.iotype = SERIAL_IO_PORT;
-		} else if (hcdp_dev->base_addr.space_id == ACPI_PCICONF_SPACE) {
-			printk(KERN_WARNING"warning: No support for PCI serial console\n");
-			return;
-		}
-#ifdef CONFIG_IA64
-		port.irq = acpi_register_irq(gsi, ACPI_ACTIVE_HIGH,
-				ACPI_EDGE_SENSITIVE);
-#else
-		port.irq = gsi;
-#endif
-		port.flags = UPF_SKIP_TEST | UPF_BOOT_AUTOCONF | UPF_RESOURCES;
-		if (gsi)
-			port.flags |= UPF_AUTO_IRQ;
-
-		/*
-		 * Note: the above memset() initializes port.line to 0,
-		 * so we register this port as ttyS0.
-		 */
-		if (early_serial_setup(&port) < 0) {
-			printk("setup_serial_hcdp(): early_serial_setup() "
-				"for HCDP serial console port failed. "
-				"Will try any additional consoles in HCDP.\n");
-			continue;
-		}
-		break;
-	}
-
-#ifdef SERIAL_DEBUG_HCDP
-	printk("Leaving setup_serial_hcdp()\n");
-#endif
+	snprintf(options, sizeof(options), "%lun%d", uart->baud,
+		uart->bits ? uart->bits : 8);
+	serial8250_early_console_setup(&port, options);
 }
 
-#ifdef CONFIG_IA64_EARLY_PRINTK_UART
-unsigned long
-hcdp_early_uart (void)
+void __init
+setup_hcdp_console(struct hcdp *hcdp, char *cmdline)
 {
-	efi_system_table_t *systab;
-	efi_config_table_t *config_tables;
-	unsigned long addr = 0;
-	hcdp_t *hcdp = 0;
-	hcdp_dev_t *dev;
-	int i;
-
-	systab = (efi_system_table_t *) ia64_boot_param->efi_systab;
-	if (!systab)
-		return 0;
-	systab = __va(systab);
-
-	config_tables = (efi_config_table_t *) systab->tables;
-	if (!config_tables)
-		return 0;
-	config_tables = __va(config_tables);
-
-	for (i = 0; i < systab->nr_tables; i++) {
-		if (efi_guidcmp(config_tables[i].guid, HCDP_TABLE_GUID) == 0) {
-			hcdp = (hcdp_t *) config_tables[i].table;
-			break;
-		}
-	}
+	struct hcdp_uart *uart;
+	int i, serial = 0;
+
 	if (!hcdp)
-		return 0;
-	hcdp = __va(hcdp);
+		return;
+
+	printk(KERN_INFO "HCDP: v%d at 0x%p\n", hcdp->rev, hcdp);
 
-	for (i = 0, dev = hcdp->hcdp_dev; i < hcdp->num_entries; i++, dev++) {
-		if (dev->type == HCDP_DEV_CONSOLE) {
-			addr = (u64) dev->base_addr.addrhi << 32 | dev->base_addr.addrlo;
-			break;
+	if (strstr(cmdline, "console=serial"))
+		serial = 1;
+	if (efi_uart_console_only())
+		serial = 1;
+
+	for (i = 0, uart = hcdp->uart; i < hcdp->num_uarts; i++, uart++) {
+		if (serial) {
+			if (uart->type == HCDP_CONSOLE_UART) {
+				setup_serial_console(uart);
+				return;
+			}
 		}
 	}
-	return addr;
 }
-#endif /* CONFIG_IA64_EARLY_PRINTK_UART */
===== drivers/serial/8250_hcdp.h 1.1 vs edited =====
--- 1.1/drivers/serial/8250_hcdp.h	Wed May 14 08:50:38 2003
+++ edited/drivers/serial/8250_hcdp.h	Tue Apr 20 15:05:27 2004
@@ -1,79 +1,43 @@
 /*
- * drivers/serial/8250_hcdp.h
- *
- * Copyright (C) 2002 Hewlett-Packard Co.
+ * Copyright (C) 2002, 2004 Hewlett-Packard Co.
  *	Khalid Aziz <khalid_aziz@hp.com>
+ *	Bjorn Helgaas <bjorn.helgaas@hp.com>
  *
  * Definitions for HCDP defined serial ports (Serial console and debug
  * ports)
  */
 
-/* ACPI table signatures */
-#define HCDP_SIG_LEN		4
-#define HCDP_SIGNATURE		"HCDP"
-
-/* Space ID as defined in ACPI generic address structure */
-#define ACPI_MEM_SPACE		0
-#define ACPI_IO_SPACE		1
-#define ACPI_PCICONF_SPACE	2
-
-/*
- * Maximum number of HCDP devices we want to read in
- */
-#define MAX_HCDP_DEVICES	6
-
-/*
- * Default UART clock rate if clock rate is 0 in HCDP table.
- */
-#define DEFAULT_UARTCLK		115200
-
-/*
- * ACPI Generic Address Structure
- */
-typedef struct {
-	u8  space_id;
-	u8  bit_width;
-	u8  bit_offset;
-	u8  resv;
-	u32 addrlo;
-	u32 addrhi;
-} acpi_gen_addr;
-
-/* HCDP Device descriptor entry types */
-#define HCDP_DEV_CONSOLE	0
-#define HCDP_DEV_DEBUG		1
-
-/* HCDP Device descriptor type */
-typedef struct {
-	u8	type;
-	u8	bits;
-	u8	parity;
-	u8	stop_bits;
-	u8	pci_seg;
-	u8	pci_bus;
-	u8	pci_dev;
-	u8	pci_func;
-	u64	baud;
-	acpi_gen_addr	base_addr;
-	u16	pci_dev_id;
-	u16	pci_vendor_id;
-	u32	global_int;
-	u32	clock_rate;
-	u8	pci_prog_intfc;
-	u8	resv;
-} hcdp_dev_t;
+#define HCDP_CONSOLE_UART		0
 
-/* HCDP Table format */
-typedef struct {
-	u8	signature[4];
-	u32	len;
-	u8	rev;
-	u8	chksum;
-	u8	oemid[6];
-	u8	oem_tabid[8];
-	u32	oem_rev;
-	u8	creator_id[4];
-	u32	creator_rev;
-	u32	num_entries;
-	hcdp_dev_t	hcdp_dev[MAX_HCDP_DEVICES];
-} hcdp_t;
+struct hcdp_uart {
+	u8				type;
+	u8				bits;
+	u8				parity;
+	u8				stop_bits;
+	u8				pci_seg;
+	u8				pci_bus;
+	u8				pci_dev;
+	u8				pci_func;
+	u64				baud;
+	struct acpi_generic_address	addr;
+	u16				pci_dev_id;
+	u16				pci_vendor_id;
+	u32				global_int;
+	u32				clock_rate;
+	u8				pci_prog_intfc;
+	u8				flags;
+};
+
+struct hcdp {
+	u8			signature[4];
+	u32			length;
+	u8			rev;
+	u8			chksum;
+	u8			oemid[6];
+	u8			oem_tabid[8];
+	u32			oem_rev;
+	u8			creator_id[4];
+	u32			creator_rev;
+	u32			num_uarts;
+	struct hcdp_uart	uart[0];
+};
===== include/linux/efi.h 1.7 vs edited =====
--- 1.7/include/linux/efi.h	Tue Feb  3 22:29:14 2004
+++ edited/include/linux/efi.h	Wed Apr 21 12:59:47 2004
@@ -212,6 +212,9 @@
 #define UGA_IO_PROTOCOL_GUID \
     EFI_GUID(  0x61a4d49e, 0x6f68, 0x4f1b, 0xb9, 0x22, 0xa8, 0x6e, 0xed, 0xb, 0x7, 0xa2 )
 
+#define EFI_GLOBAL_VARIABLE_GUID \
+    EFI_GUID(  0x8be4df61, 0x93ca, 0x11d2, 0xaa, 0x0d, 0x00, 0xe0, 0x98, 0x03, 0x2b, 0x8c )
+
 typedef struct {
 	efi_guid_t guid;
 	unsigned long table;
@@ -294,6 +297,7 @@
 extern u64 efi_get_iobase (void);
 extern u32 efi_mem_type (unsigned long phys_addr);
 extern u64 efi_mem_attributes (unsigned long phys_addr);
+extern int __init efi_uart_console_only (void);
 extern void efi_initialize_iomem_resources(struct resource *code_resource,
 					struct resource *data_resource);
 extern efi_status_t phys_efi_get_time(efi_time_t *tm, efi_time_cap_t *tc);
@@ -322,6 +326,49 @@
 #define EFI_VARIABLE_BOOTSERVICE_ACCESS 0x0000000000000002
 #define EFI_VARIABLE_RUNTIME_ACCESS     0x0000000000000004
 
+/*
+ * EFI Device Path information
+ */
+#define EFI_DEV_HW			0x01
+#define  EFI_DEV_PCI				 1
+#define  EFI_DEV_PCCARD				 2
+#define  EFI_DEV_MEM_MAPPED			 3
+#define  EFI_DEV_VENDOR				 4
+#define  EFI_DEV_CONTROLLER			 5
+#define EFI_DEV_ACPI			0x02
+#define   EFI_DEV_BASIC_ACPI			 1
+#define   EFI_DEV_EXPANDED_ACPI			 2
+#define EFI_DEV_MSG			0x03
+#define   EFI_DEV_MSG_ATAPI			 1
+#define   EFI_DEV_MSG_SCSI			 2
+#define   EFI_DEV_MSG_FC			 3
+#define   EFI_DEV_MSG_1394			 4
+#define   EFI_DEV_MSG_USB			 5
+#define   EFI_DEV_MSG_USB_CLASS			15
+#define   EFI_DEV_MSG_I20			 6
+#define   EFI_DEV_MSG_MAC			11
+#define   EFI_DEV_MSG_IPV4			12
+#define   EFI_DEV_MSG_IPV6			13
+#define   EFI_DEV_MSG_INFINIBAND		 9
+#define   EFI_DEV_MSG_UART			14
+#define   EFI_DEV_MSG_VENDOR			10
+#define EFI_DEV_MEDIA			0x04
+#define   EFI_DEV_MEDIA_HARD_DRIVE		 1
+#define   EFI_DEV_MEDIA_CDROM			 2
+#define   EFI_DEV_MEDIA_VENDOR			 3
+#define   EFI_DEV_MEDIA_FILE			 4
+#define   EFI_DEV_MEDIA_PROTOCOL		 5
+#define EFI_DEV_BIOS_BOOT		0x05
+#define EFI_DEV_END_PATH		0x7F
+#define EFI_DEV_END_PATH2		0xFF
+#define   EFI_DEV_END_INSTANCE			0x01
+#define   EFI_DEV_END_ENTIRE			0xFF
+
+struct efi_generic_dev_path {
+	u8 type;
+	u8 sub_type;
+	u16 length;
+} __attribute ((packed));
 
 /*
  * efi_dir is allocated in arch/ia64/kernel/efi.c.
===== include/linux/serial.h 1.11 vs edited =====
--- 1.11/include/linux/serial.h	Thu Feb 26 04:26:01 2004
+++ edited/include/linux/serial.h	Tue Apr 20 14:34:04 2004
@@ -181,6 +181,7 @@
 /* Allow architectures to override entries in serial8250_ports[] at run time: */
 struct uart_port;	/* forward declaration */
 extern int early_serial_setup(struct uart_port *port);
+extern void serial8250_early_console_setup(struct uart_port *port, char *options);
 
 #endif /* __KERNEL__ */
 #endif /* _LINUX_SERIAL_H */
