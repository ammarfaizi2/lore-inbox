Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261250AbUKEXDW@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261250AbUKEXDW (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 5 Nov 2004 18:03:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261248AbUKEXDW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 5 Nov 2004 18:03:22 -0500
Received: from atarelbas02.hp.com ([156.153.255.213]:16572 "EHLO
	atlrel7.hp.com") by vger.kernel.org with ESMTP id S261241AbUKEXCM
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 5 Nov 2004 18:02:12 -0500
From: Bjorn Helgaas <bjorn.helgaas@hp.com>
To: Andrew Morton <akpm@osdl.org>
Subject: Re: [PATCH 2/2] move HCDP/PCDP to early uart console
Date: Fri, 5 Nov 2004 16:02:08 -0700
User-Agent: KMail/1.7
Cc: Russell King <rmk@arm.linux.org.uk>,
       Benjamin Herrenschmidt <benh@kernel.crashing.org>,
       linux-kernel@vger.kernel.org, linux-ia64@vger.kernel.org
References: <200410281347.44854.bjorn.helgaas@hp.com>
In-Reply-To: <200410281347.44854.bjorn.helgaas@hp.com>
MIME-Version: 1.0
Content-Type: Multipart/Mixed;
  boundary="Boundary-00=_wZAjBLxqbuf46Ds"
Message-Id: <200411051602.08316.bjorn.helgaas@hp.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--Boundary-00=_wZAjBLxqbuf46Ds
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

On Thursday 28 October 2004 1:47 pm, Bjorn Helgaas wrote:
> This changes the HCDP/PCDP support to use the early uart console
> rather than using early_serial_setup().

Andrew, would you please replace move-hcdp-pcdp-to-early-uart-console.patch
with the revised version attached?

The most important change is to add usage notes in the changeset
comments because this change breaks many existing serial console
setups (for HP ia64 boxes).  The breakage is unfortunate, but I
think justified in order to finally make the ttyS names stable
across firmware configuration changes.

The other changes to the patch itself (see the attached interdiff)
are to update the config help and to ignore the HCDP/PCDP if the
user specifies "console=" explicitly.

I'll be out on vacation until 11/15.  Just FYI so you don't think
I'm ignoring any feedback :-)

--Boundary-00=_wZAjBLxqbuf46Ds
Content-Type: text/x-diff;
  charset="iso-8859-1";
  name="move-hcdp-pcdp-to-early-uart-console2.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename="move-hcdp-pcdp-to-early-uart-console2.patch"


From: Bjorn Helgaas <bjorn.helgaas@hp.com>

This changes the HCDP/PCDP support to use the early uart console rather
than using early_serial_setup().

As a consequence, ia64 serial device names will now stay constant
regardless of firmware console settings.  (A serial device selected as an
EFI console device on HP ia64 boxes used to automatically become ttyS0.)

Removed the ia64 early-boot kludge of assuming legacy COM ports at 0x3f8
and 0x2f8.  For boxes that have legacy ports but no HCDP, "console=ttyS0"
will still work, but the console won't start working until after the serial
driver initializes and discovers the devices.


WARNING:

If you have an HP machine and you're using the MP serial console port
(the connector labelled "console" on the 3-headed cable), this patch
will break your console!

HOW TO FIX IT:

 1) The console device will change from /dev/ttyS0 to /dev/ttyS1,
    ttyS2, or ttyS3, so:

    1a) Edit /etc/inittab to add a getty entry for
           /dev/ttyS1 (rx4640, rx5670, rx7620, rx8620, Superdome),
           /dev/ttyS2 (rx1600), or
           /dev/ttyS3 (rx2600).

    1b) Edit /etc/securetty to add ttyS1, ttyS2, or ttyS3.

    1c) Leave the existing ttyS0 entries in /etc/inittab and
        /etc/securetty so you can still boot old kernels.

 2) Edit /etc/elilo.conf to remove any "console=" arguments (see [1]).

 3) Run elilo to install the bootloader with new configuration.

 4) Reboot and use the EFI boot option maintenance menu to select
    exactly one device for console output, input, and standard error.
    Then do a cold reset so the changes take effect.

    For the MP console, be careful to select the device with
    "Acpi(HWP0002,700)/Pci(...)/Uart" in the path (see [2]).

DETAILS:

  - Prior to this patch, serial device names depended on the HCDP,
    which in turn depends on EFI console settings.  After this patch,
    the naming always stays the same, regardless of firmware settings.

    For example, an rx1600 with a single built-in serial port plus
    an MP has these ports:
                                   Old             Old
                  MMIO         (EFI console    (EFI console
                 address        on builtin)     on MP port)      New
                ----------     ------------    ------------     -----
    builtin     0xff5e0000        ttyS0           ttyS1         ttyS0
    MP UPS      0xf8031000        ttyS1           ttyS2         ttyS1
    MP Console  0xf8030000        ttyS2           ttyS0         ttyS2
    MP 2        0xf8030010        ttyS3           ttyS3         ttyS3
    MP 3        0xf8030038        ttyS4           ttyS4         ttyS4

  - If you want to have multiple devices in the EFI console path, you
    can, but Linux won't be able to deduce which console to use, so it
    will default to using VGA.  You can use "console=hcdp" (the UART
    device from the EFI path) or "console=ttyS<n>" to select the
    device directly.

TROUBLESHOOTING:

  - No kernel output after "Uncompressing Linux... done":

        -> You're using an MP port as the console and specified
           "console=ttyS0".  This port is now named something else.
           Remove the "console=" option.

        -> Multiple UARTs selected as EFI console devices, and you're
           looking at the wrong one.  Make sure only one UART is
           selected (use the EFI Boot Manager "Boot option maintenance"
           menu).

        -> You're physically connected to the MP port but have a
           non-MP UART selected as EFI console device.  Either move
           the console cable to the non-MP UART, or change the EFI
           console path to the MP UART (the MP UART is the one with
           "Acpi(HWP0002,700)/Pci(...)/Uart" in it.)

  - Long pause (60+ seconds) between "Uncompressing Linux... done"
    and start of kernel output:

        -> No early console, probably because you used "console=ttyS<n>".
           Remove the "console=" option.

  - Kernel and init script output works fine, but no "login:" prompt:

        -> Add getty entry to /etc/inittab for console tty.  Use the table
           in (1a) above or look for the "Adding console on ttyS<n>" message
           that tells you which device is the console.

  - "login:" prompt, but can't login as root:

        -> Add entry to /etc/securetty for console tty.


[1] When the EFI console path contains exactly one device (either
    serial or VGA), 2.6.6 and newer kernels default to that device
    automatically.  So if you remove "console=" arguments, you can use
    the same elilo configuration to boot any 2.6.6 or newer kernel
    with or without this patch.

    If you need to boot kernels older than 2.6.6 (including RHEL3 and
    SLES9), keep an 'append="console=ttyS0"' line in those elilo.conf
    stanzas.

    Non-HP machines will still need "console=" for serial consoles
    because they don't supply the HCDP table.

[2] The HP management card (MP) causes confusion because it is always
    active as an EFI console, even if it doesn't appear in the EFI
    console path.  If your console path is set to a non-MP UART, and
    you happen to be attached to the MP UART, everything works in EFI,
    but the kernel will think the non-MP UART is the console, so you
    won't see any kernel output.

Signed-off-by: Bjorn Helgaas <bjorn.helgaas@hp.com>
Signed-off-by: Andrew Morton <akpm@osdl.org>
---
 arch/ia64/kernel/setup.c |   40 +++--------
 drivers/firmware/Kconfig |    6 +
 drivers/firmware/pcdp.c  |  157 +++++++++--------------------------------------
 include/linux/efi.h      |    2 
 4 files changed, 48 insertions(+), 157 deletions(-)

--- a/arch/ia64/kernel/setup.c.orig	2004-11-05 15:10:38.267166606 -0700
+++ b/arch/ia64/kernel/setup.c	2004-11-05 15:11:39.324783045 -0700
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
--- a/drivers/firmware/Kconfig.orig	2004-11-05 13:22:30.771152328 -0700
+++ b/drivers/firmware/Kconfig	2004-11-05 15:11:45.395095471 -0700
@@ -59,7 +59,11 @@
 	  use the first serial port it describes as the Linux console,
 	  say Y here.  If your EFI ConOut path contains only a UART
 	  device, it will become the console automatically.  Otherwise,
-	  you must specify the "console=ttyS0" kernel boot argument.
+	  you must specify the "console=hcdp" kernel boot argument.
+
+	  Neither the PCDP nor the HCDP affects naming of serial devices,
+	  so a serial console may be /dev/ttyS0, /dev/ttyS1, etc, depending
+	  on how the driver discovers devices.
 
 	  You must also enable the appropriate drivers (serial, VGA, etc.)
 
--- a/drivers/firmware/pcdp.c.orig	2004-11-05 15:10:38.268143168 -0700
+++ b/drivers/firmware/pcdp.c	2004-11-05 15:11:45.395095471 -0700
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
-setup_serial_console(int rev, struct pcdp_uart *uart)
-#else
-setup_serial_console(int rev, struct pcdp_uart *uart, int line)
-#endif
+static int __init
+setup_serial_console(struct pcdp_uart *uart)
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
-
-	if (early_serial_setup(&port) < 0)
-		return;
+	int mmio;
+	static char options[64];
 
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
@@ -154,31 +62,27 @@
 
 	pcdp = efi.hcdp;
 	if (!pcdp)
-		return;
+		return -ENODEV;
 
-	printk(KERN_INFO "PCDP: v%d at 0x%p\n", pcdp->rev, pcdp);
+	printk(KERN_INFO "PCDP: v%d at 0x%lx\n", pcdp->rev, __pa(pcdp));
 
-	if (pcdp->rev < 3) {
-		if (strstr(cmdline, "console=ttyS0") || efi_uart_console_only())
+	if (strstr(cmdline, "console=hcdp")) {
+		if (pcdp->rev < 3)
 			serial = 1;
+	} else if (strstr(cmdline, "console=")) {
+		printk(KERN_INFO "Explicit \"console=\"; ignoring PCDP\n");
+		return -ENODEV;
 	}
 
+	if (pcdp->rev < 3 && efi_uart_console_only())
+		serial = 1;
+
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
+				return setup_serial_console(uart);
 			}
 		}
-#ifdef	CONFIG_KGDB_EARLY
-		else if (uart->type == PCDP_DEBUG_UART)
-				setup_serial_console(pcdp->rev, uart, 1);
-#endif
 	}
 
 	end = (struct pcdp_device *) ((u8 *) pcdp + pcdp->length);
@@ -187,11 +91,12 @@
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
--- a/include/linux/efi.h.orig	2004-11-05 15:10:38.269119731 -0700
+++ b/include/linux/efi.h	2004-11-05 15:11:39.326736170 -0700
@@ -306,7 +306,7 @@
 extern struct efi_memory_map memmap;
 
 #ifdef CONFIG_EFI_PCDP
-extern void __init efi_setup_pcdp_console(char *);
+extern int __init efi_setup_pcdp_console(char *);
 #endif
 
 /*

--Boundary-00=_wZAjBLxqbuf46Ds
Content-Type: text/x-diff;
  charset="iso-8859-1";
  name="interdiff"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename="interdiff"

diff -u 25-akpm/drivers/firmware/pcdp.c b/drivers/firmware/pcdp.c
--- 25-akpm/drivers/firmware/pcdp.c	Thu Oct 28 15:45:44 2004
+++ b/drivers/firmware/pcdp.c	2004-11-05 15:11:45.395095471 -0700
@@ -18,7 +18,7 @@
 #include "pcdp.h"
 
 static int __init
-setup_serial_console(int rev, struct pcdp_uart *uart)
+setup_serial_console(struct pcdp_uart *uart)
 {
 #ifdef CONFIG_SERIAL_8250_CONSOLE
 	int mmio;
@@ -66,15 +66,21 @@
 
 	printk(KERN_INFO "PCDP: v%d at 0x%lx\n", pcdp->rev, __pa(pcdp));
 
-	if (pcdp->rev < 3) {
-		if (strstr(cmdline, "console=hcdp") || efi_uart_console_only())
+	if (strstr(cmdline, "console=hcdp")) {
+		if (pcdp->rev < 3)
 			serial = 1;
+	} else if (strstr(cmdline, "console=")) {
+		printk(KERN_INFO "Explicit \"console=\"; ignoring PCDP\n");
+		return -ENODEV;
 	}
 
+	if (pcdp->rev < 3 && efi_uart_console_only())
+		serial = 1;
+
 	for (i = 0, uart = pcdp->uart; i < pcdp->num_uarts; i++, uart++) {
 		if (uart->flags & PCDP_UART_PRIMARY_CONSOLE || serial) {
 			if (uart->type == PCDP_CONSOLE_UART) {
-				return setup_serial_console(pcdp->rev, uart);
+				return setup_serial_console(uart);
 			}
 		}
 	}
only in patch2:
unchanged:
--- a/drivers/firmware/Kconfig.orig	2004-11-05 13:22:30.771152328 -0700
+++ b/drivers/firmware/Kconfig	2004-11-05 15:11:45.395095471 -0700
@@ -59,7 +59,11 @@
 	  use the first serial port it describes as the Linux console,
 	  say Y here.  If your EFI ConOut path contains only a UART
 	  device, it will become the console automatically.  Otherwise,
-	  you must specify the "console=ttyS0" kernel boot argument.
+	  you must specify the "console=hcdp" kernel boot argument.
+
+	  Neither the PCDP nor the HCDP affects naming of serial devices,
+	  so a serial console may be /dev/ttyS0, /dev/ttyS1, etc, depending
+	  on how the driver discovers devices.
 
 	  You must also enable the appropriate drivers (serial, VGA, etc.)
 

--Boundary-00=_wZAjBLxqbuf46Ds--
