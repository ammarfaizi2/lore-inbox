Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262640AbUJ1TwE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262640AbUJ1TwE (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 28 Oct 2004 15:52:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262881AbUJ1Tvw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 28 Oct 2004 15:51:52 -0400
Received: from atlrel7.hp.com ([156.153.255.213]:25559 "EHLO atlrel7.hp.com")
	by vger.kernel.org with ESMTP id S261964AbUJ1Trr (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 28 Oct 2004 15:47:47 -0400
From: Bjorn Helgaas <bjorn.helgaas@hp.com>
To: Andrew Morton <akpm@osdl.org>
Subject: [PATCH 2/2] move HCDP/PCDP to early uart console
Date: Thu, 28 Oct 2004 13:47:44 -0600
User-Agent: KMail/1.7
Cc: Russell King <rmk@arm.linux.org.uk>,
       Benjamin Herrenschmidt <benh@kernel.crashing.org>,
       linux-kernel@vger.kernel.org, linux-ia64@vger.kernel.org
MIME-Version: 1.0
Content-Type: Multipart/Mixed;
  boundary="Boundary-00=_gzUgBvMvOCi0cKg"
Message-Id: <200410281347.44854.bjorn.helgaas@hp.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--Boundary-00=_gzUgBvMvOCi0cKg
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

This changes the HCDP/PCDP support to use the early uart console
rather than using early_serial_setup().

As a consequence, ia64 serial device names will now stay constant
regardless of firmware console settings.  (A serial device selected as
an EFI console device on HP ia64 boxes used to automatically become
ttyS0.)

Removed the ia64 early-boot kludge of assuming legacy COM ports at
0x3f8 and 0x2f8.  For boxes that have legacy ports but no HCDP,
"console=ttyS0" will still work, but the console won't start working
until after the serial driver initializes and discovers the devices.

This breaks the KGDB_EARLY hooks in PCDP.  I'll work with Bob to
figure out what needs to be done there.

--Boundary-00=_gzUgBvMvOCi0cKg
Content-Type: text/x-diff;
  charset="us-ascii";
  name="pcdp-early-uart.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename="pcdp-early-uart.patch"

This changes the HCDP/PCDP support to use the early uart console
rather than using early_serial_setup().

As a consequence, ia64 serial device names will now stay constant
regardless of firmware console settings.  (A serial device selected as
an EFI console device on HP ia64 boxes used to automatically become
ttyS0.)

Removed the ia64 early-boot kludge of assuming legacy COM ports at
0x3f8 and 0x2f8.  For boxes that have legacy ports but no HCDP,
"console=ttyS0" will still work, but the console won't start working
until after the serial driver initializes and discovers the devices.

This breaks the KGDB_EARLY hooks in PCDP.  I'll work with Bob to
figure out what needs to be done there.

 arch/ia64/kernel/setup.c |   40 +++---------
 drivers/firmware/pcdp.c  |  147 +++++++----------------------------------------
 include/linux/efi.h      |    2 
 3 files changed, 35 insertions(+), 154 deletions(-)

Signed-off-by: Bjorn Helgaas <bjorn.helgaas@hp.com>

diff -u -urN 2.6.10-rc1-mm1-uart/arch/ia64/kernel/setup.c 2.6.10-rc1-mm1-ia64/arch/ia64/kernel/setup.c
--- 2.6.10-rc1-mm1-uart/arch/ia64/kernel/setup.c	2004-10-28 13:03:31.567763520 -0600
+++ 2.6.10-rc1-mm1-ia64/arch/ia64/kernel/setup.c	2004-10-28 13:08:34.711314494 -0600
@@ -259,25 +259,6 @@
 	num_io_spaces = 1;
 }
 
-#ifdef CONFIG_SERIAL_8250_CONSOLE
-static void __init
-setup_serial_legacy (void)
-{
-	struct uart_port port;
-	unsigned int i, iobase[] = {0x3f8, 0x2f8};
-
-	printk(KERN_INFO "Registering legacy COM ports for serial console\n");
-	memset(&port, 0, sizeof(port));
-	port.iotype = SERIAL_IO_PORT;
-	port.uartclk = BASE_BAUD * 16;
-	for (i = 0; i < ARRAY_SIZE(iobase); i++) {
-		port.line = i;
-		port.iobase = iobase[i];
-		early_serial_setup(&port);
-	}
-}
-#endif
-
 /**
  * early_console_setup - setup debugging console
  *
@@ -288,15 +269,23 @@
  * Returns non-zero if a console couldn't be setup.
  */
 static inline int __init
-early_console_setup (void)
+early_console_setup (char *cmdline)
 {
 #ifdef CONFIG_SERIAL_SGI_L1_CONSOLE
 	{
 		extern int sn_serial_console_early_setup(void);
-		if(!sn_serial_console_early_setup())
+		if (!sn_serial_console_early_setup())
 			return 0;
 	}
 #endif
+#ifdef CONFIG_EFI_PCDP
+	if (!efi_setup_pcdp_console(cmdline))
+		return 0;
+#endif
+#ifdef CONFIG_SERIAL_8250_CONSOLE
+	if (!early_serial_console_init(cmdline))
+		return 0;
+#endif
 
 	return -1;
 }
@@ -320,7 +309,7 @@
 
 #ifdef CONFIG_SMP
 	/* If we register an early console, allow CPU 0 to printk */
-	if (!early_console_setup())
+	if (!early_console_setup(*cmdline_p))
 		cpu_set(smp_processor_id(), cpu_online_map);
 #endif
 
@@ -350,13 +339,6 @@
 #ifdef CONFIG_ACPI_BOOT
 	acpi_boot_init();
 #endif
-#ifdef CONFIG_EFI_PCDP
-	efi_setup_pcdp_console(*cmdline_p);
-#endif
-#ifdef CONFIG_SERIAL_8250_CONSOLE
-	if (!efi.hcdp)
-		setup_serial_legacy();
-#endif
 
 #ifdef CONFIG_VT
 	if (!conswitchp) {
diff -u -urN 2.6.10-rc1-mm1-uart/drivers/firmware/pcdp.c 2.6.10-rc1-mm1-ia64/drivers/firmware/pcdp.c
--- 2.6.10-rc1-mm1-uart/drivers/firmware/pcdp.c	2004-10-28 13:03:31.886122892 -0600
+++ 2.6.10-rc1-mm1-ia64/drivers/firmware/pcdp.c	2004-10-28 13:08:34.712291057 -0600
@@ -14,137 +14,45 @@
 #include <linux/acpi.h>
 #include <linux/console.h>
 #include <linux/efi.h>
-#include <linux/tty.h>
 #include <linux/serial.h>
-#include <linux/serial_core.h>
-#include <asm/io.h>
-#include <asm/serial.h>
 #include "pcdp.h"
 
-static inline int
-uart_irq_supported(int rev, struct pcdp_uart *uart)
-{
-	if (rev < 3)
-		return uart->pci_func & PCDP_UART_IRQ;
-	return uart->flags & PCDP_UART_IRQ;
-}
-
-static inline int
-uart_pci(int rev, struct pcdp_uart *uart)
-{
-	if (rev < 3)
-		return uart->pci_func & PCDP_UART_PCI;
-	return uart->flags & PCDP_UART_PCI;
-}
-
-static inline int
-uart_active_high_low(int rev, struct pcdp_uart *uart)
-{
-	if (uart_pci(rev, uart) || uart->flags & PCDP_UART_ACTIVE_LOW)
-		return ACPI_ACTIVE_LOW;
-	return ACPI_ACTIVE_HIGH;
-}
-
-static inline int
-uart_edge_level(int rev, struct pcdp_uart *uart)
-{
-	if (uart_pci(rev, uart))
-		return ACPI_LEVEL_SENSITIVE;
-	if (rev < 3 || uart->flags & PCDP_UART_EDGE_SENSITIVE)
-		return ACPI_EDGE_SENSITIVE;
-	return ACPI_LEVEL_SENSITIVE;
-}
-
-static void __init
-#ifndef	CONFIG_KGDB_EARLY
+static int __init
 setup_serial_console(int rev, struct pcdp_uart *uart)
-#else
-setup_serial_console(int rev, struct pcdp_uart *uart, int line)
-#endif
 {
 #ifdef CONFIG_SERIAL_8250_CONSOLE
-	struct uart_port port;
-	static char options[16];
-	int mapsize = 64;
-
-	memset(&port, 0, sizeof(port));
-#ifdef	CONFIG_KGDB_EARLY
-	port.line = line;
-#endif
-	port.uartclk = uart->clock_rate;
-	if (!port.uartclk)	/* some FW doesn't supply this */
-		port.uartclk = BASE_BAUD * 16;
-
-	if (uart->addr.address_space_id == ACPI_ADR_SPACE_SYSTEM_MEMORY) {
-		port.mapbase = uart->addr.address;
-		port.membase = ioremap(port.mapbase, mapsize);
-		if (!port.membase) {
-			printk(KERN_ERR "%s: couldn't ioremap 0x%lx-0x%lx\n",
-				__FUNCTION__, port.mapbase, port.mapbase + mapsize);
-			return;
-		}
-		port.iotype = UPIO_MEM;
-	} else if (uart->addr.address_space_id == ACPI_ADR_SPACE_SYSTEM_IO) {
-		port.iobase = uart->addr.address;
-		port.iotype = UPIO_PORT;
-	} else
-		return;
-
-	switch (uart->pci_prog_intfc) {
-		case 0x0: port.type = PORT_8250;    break;
-		case 0x1: port.type = PORT_16450;   break;
-		case 0x2: port.type = PORT_16550;   break;
-		case 0x3: port.type = PORT_16650;   break;
-		case 0x4: port.type = PORT_16750;   break;
-		case 0x5: port.type = PORT_16850;   break;
-		case 0x6: port.type = PORT_16C950;  break;
-		default:  port.type = PORT_UNKNOWN; break;
-	}
-
-	port.flags = UPF_SKIP_TEST | UPF_BOOT_AUTOCONF;
-
-	if (uart_irq_supported(rev, uart)) {
-		port.irq = acpi_register_gsi(uart->gsi,
-			uart_edge_level(rev, uart),
-			uart_active_high_low(rev, uart));
-		port.flags |= UPF_AUTO_IRQ;  /* some FW reported wrong GSI */
-		if (uart_pci(rev, uart))
-			port.flags |= UPF_SHARE_IRQ;
-	}
+	int mmio;
+	static char options[64];
 
-	if (early_serial_setup(&port) < 0)
-		return;
-
-	snprintf(options, sizeof(options), "%lun%d", uart->baud,
+	mmio = (uart->addr.address_space_id == ACPI_ADR_SPACE_SYSTEM_MEMORY);
+	snprintf(options, sizeof(options), "console=uart,%s,0x%lx,%lun%d",
+		mmio ? "mmio" : "io", uart->addr.address, uart->baud,
 		uart->bits ? uart->bits : 8);
-#ifdef	CONFIG_KGDB_EARLY
-	if (!line)
-#endif
-	add_preferred_console("ttyS", port.line, options);
 
-	printk(KERN_INFO "PCDP: serial console at %s 0x%lx (ttyS%d, options %s)\n",
-		port.iotype == UPIO_MEM ? "MMIO" : "I/O",
-		uart->addr.address, port.line, options);
+	return early_serial_console_init(options);
+#else
+	return -ENODEV;
 #endif
 }
 
-static void __init
+static int __init
 setup_vga_console(struct pcdp_vga *vga)
 {
-#ifdef CONFIG_VT
-#ifdef CONFIG_VGA_CONSOLE
+#if defined(CONFIG_VT) && defined(CONFIG_VGA_CONSOLE)
 	if (efi_mem_type(0xA0000) == EFI_CONVENTIONAL_MEMORY) {
 		printk(KERN_ERR "PCDP: VGA selected, but frame buffer is not MMIO!\n");
-		return;
+		return -ENODEV;
 	}
 
 	conswitchp = &vga_con;
 	printk(KERN_INFO "PCDP: VGA console\n");
-#endif
+	return 0;
+#else
+	return -ENODEV;
 #endif
 }
 
-void __init
+int __init
 efi_setup_pcdp_console(char *cmdline)
 {
 	struct pcdp *pcdp;
@@ -154,31 +62,21 @@
 
 	pcdp = efi.hcdp;
 	if (!pcdp)
-		return;
+		return -ENODEV;
 
-	printk(KERN_INFO "PCDP: v%d at 0x%p\n", pcdp->rev, pcdp);
+	printk(KERN_INFO "PCDP: v%d at 0x%lx\n", pcdp->rev, __pa(pcdp));
 
 	if (pcdp->rev < 3) {
-		if (strstr(cmdline, "console=ttyS0") || efi_uart_console_only())
+		if (strstr(cmdline, "console=hcdp") || efi_uart_console_only())
 			serial = 1;
 	}
 
 	for (i = 0, uart = pcdp->uart; i < pcdp->num_uarts; i++, uart++) {
 		if (uart->flags & PCDP_UART_PRIMARY_CONSOLE || serial) {
 			if (uart->type == PCDP_CONSOLE_UART) {
-#ifndef	CONFIG_KGDB_EARLY
-				setup_serial_console(pcdp->rev, uart);
-				return;
-#else
-				setup_serial_console(pcdp->rev, uart, 0);
-				serial = 0;
-#endif
+				return setup_serial_console(pcdp->rev, uart);
 			}
 		}
-#ifdef	CONFIG_KGDB_EARLY
-		else if (uart->type == PCDP_DEBUG_UART)
-				setup_serial_console(pcdp->rev, uart, 1);
-#endif
 	}
 
 	end = (struct pcdp_device *) ((u8 *) pcdp + pcdp->length);
@@ -187,11 +85,12 @@
 	     dev = (struct pcdp_device *) ((u8 *) dev + dev->length)) {
 		if (dev->flags & PCDP_PRIMARY_CONSOLE) {
 			if (dev->type == PCDP_CONSOLE_VGA) {
-				setup_vga_console((struct pcdp_vga *) dev);
-				return;
+				return setup_vga_console((struct pcdp_vga *) dev);
 			}
 		}
 	}
+
+	return -ENODEV;
 }
 
 #ifdef CONFIG_IA64_EARLY_PRINTK_UART
diff -u -urN 2.6.10-rc1-mm1-uart/include/linux/efi.h 2.6.10-rc1-mm1-ia64/include/linux/efi.h
--- 2.6.10-rc1-mm1-uart/include/linux/efi.h	2004-10-28 13:03:08.639052864 -0600
+++ 2.6.10-rc1-mm1-ia64/include/linux/efi.h	2004-10-28 13:08:34.712291057 -0600
@@ -306,7 +306,7 @@
 extern struct efi_memory_map memmap;
 
 #ifdef CONFIG_EFI_PCDP
-extern void __init efi_setup_pcdp_console(char *);
+extern int __init efi_setup_pcdp_console(char *);
 #endif
 
 /*

--Boundary-00=_gzUgBvMvOCi0cKg--
