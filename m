Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264122AbUDBRSi (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 2 Apr 2004 12:18:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264121AbUDBRSi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 2 Apr 2004 12:18:38 -0500
Received: from atlrel8.hp.com ([156.153.255.206]:62169 "EHLO atlrel8.hp.com")
	by vger.kernel.org with ESMTP id S264116AbUDBRSO (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 2 Apr 2004 12:18:14 -0500
From: Bjorn Helgaas <bjorn.helgaas@hp.com>
To: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] early serial console support (updated ia64 part)
Date: Fri, 2 Apr 2004 10:18:11 -0700
User-Agent: KMail/1.6.1
Cc: linux-ia64@vger.kernel.org, Russell King <rmk@arm.linux.org.uk>
References: <200404011458.04264.bjorn.helgaas@hp.com> <200404011524.43700.bjorn.helgaas@hp.com>
In-Reply-To: <200404011524.43700.bjorn.helgaas@hp.com>
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Message-Id: <200404021018.11557.bjorn.helgaas@hp.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Here's an update to the ia64 part of my early serial console patch.
The only change is to supply BASE_BAUD * 16 as the uartclk for
the COM1 port.


Changelog text:

This updates ia64 to use the early serial console support.

The benefits to ia64 are:
    - /dev/ttyS<N> naming is now independent of any EFI console
      configuration or "console=" arguments.
    - Serial console can work a little earlier because it no longer
      depends on ACPI for interrupt registration.
    - It probably works early enough to obsolete the EARLY_PRINTK
      stuff.

"console=serial" means use the first device described in the HCDP (or
COM1 at I/O port 0x3f8 if no HCDP) as the early and normal console.
The baud rate is obtained from the HCDP or probed from the UART if
not specified.

"console=ttyS<N>" means use ttyS<N> as the console.  There will be no
early console.  The baud rate must be specified unless it is 9600.

Gotchas:
    - Old kernels don't understand "console=serial", so elilo.conf
      changes are needed if you want an early console.
    - Old kernels named ttyS devices in different orders, depending on
      which one was selected as the EFI console device, so you may
      need to add or change a getty entry in /etc/inittab.

For example, a machine with a built-in serial port plus an MP might
have these ports:

			        old, EFI	old, EFI	new, EFI
		   MMIO		console		console		console
		  address	on builtin	on MP		anywhere
		----------	---------	--------	--------
    builtin	0xff5e0000	ttyS0		ttyS1		ttyS0
    MP UPS	0xf8031000	ttyS1		ttyS2		ttyS1
    MP Console	0xf8030000	ttyS2		ttyS0		ttyS2
    MP 2	0xf8030010	ttyS3		ttyS3		ttyS3
    MP 3	0xf8030038	ttyS4		ttyS4		ttyS4

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


===== arch/ia64/kernel/setup.c 1.70 vs edited =====
--- 1.70/arch/ia64/kernel/setup.c	Wed Mar 17 05:46:59 2004
+++ edited/arch/ia64/kernel/setup.c	Fri Apr  2 09:42:47 2004
@@ -263,20 +263,35 @@
 
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
+	if (!strstr(cmdline, "console=serial"))
+		return;
+
+	/*
+	 * We have no idea where the console UART is, but the
+	 * user explicitly requested it, so assume it's COM1.
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
 
@@ -297,6 +312,17 @@
 	machvec_init(acpi_get_sysname());
 #endif
 
+#ifdef CONFIG_SERIAL_8250_CONSOLE
+#ifdef CONFIG_SERIAL_8250_HCDP
+	if (efi.hcdp) {
+		extern void setup_hcdp_console(void *, char *);
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
@@ -322,26 +348,6 @@
 
 #ifdef CONFIG_ACPI_BOOT
 	acpi_boot_init();
-#endif
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
 #endif
 
 #ifdef CONFIG_VT
