Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266745AbUFYVGn@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266745AbUFYVGn (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 25 Jun 2004 17:06:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266755AbUFYVGn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 25 Jun 2004 17:06:43 -0400
Received: from atlrel7.hp.com ([156.153.255.213]:43943 "EHLO atlrel7.hp.com")
	by vger.kernel.org with ESMTP id S266745AbUFYVE6 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 25 Jun 2004 17:04:58 -0400
From: Bjorn Helgaas <bjorn.helgaas@hp.com>
To: Andrew Morton <akpm@osdl.org>
Subject: [PATCH] Add PCDP console detection support
Date: Fri, 25 Jun 2004 15:04:50 -0600
User-Agent: KMail/1.6.2
Cc: linux-ia64@vger.kernel.org, linux-kernel@vger.kernel.org,
       Matt Tolentino <matthew.e.tolentino@intel.com>,
       Russell King <rmk@arm.linux.org.uk>,
       David Mosberger <davidm@hpl.hp.com>
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Message-Id: <200406251504.50579.bjorn.helgaas@hp.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Add support for the EFI/DIG PCDP console discovery table (see
http://www.dig64.org/specifications/DIG64_HCDPv20_042804.pdf).

This moves the code from drivers/serial/8250_hcdp.[ch] to
drivers/firmware/pcdp.[ch], since it's no longer 8250-specific.
It also obsoletes CONFIG_SERIAL_8250_HCDP, replacing it with
CONFIG_EFI_PCDP (which defaults to Y for ia64).

In a nutshell, HCDP tells us "these UARTs are available for use
as a console," and it's up to the user to explicitly specify the
console device.  The kernel can guess in some cases, but not all.

The PCDP (aka HCDP v2) tells us what we really want to know, namely,
"this UART or VGA device is the console device."  (It also has
provision for support for new device types.)

Signed-off-by: Bjorn Helgaas <bjorn.helgaas@hp.com>

 drivers/serial/8250_hcdp.c |  264 ---------------------------------------------
 drivers/serial/8250_hcdp.h |   82 -------------
 arch/ia64/kernel/setup.c   |   29 ++--
 drivers/firmware/Kconfig   |   19 +++
 drivers/firmware/Makefile  |    1 
 drivers/firmware/pcdp.c    |  206 +++++++++++++++++++++++++++++++++++
 drivers/firmware/pcdp.h    |   80 +++++++++++++
 drivers/serial/Kconfig     |    9 -
 drivers/serial/Makefile    |    1 
 include/linux/efi.h        |    4 
 10 files changed, 324 insertions(+), 371 deletions(-)

diff -Nru a/arch/ia64/kernel/setup.c b/arch/ia64/kernel/setup.c
--- a/arch/ia64/kernel/setup.c	2004-06-25 12:53:30 -06:00
+++ b/arch/ia64/kernel/setup.c	2004-06-25 12:53:30 -06:00
@@ -319,31 +319,30 @@
 #ifdef CONFIG_ACPI_BOOT
 	acpi_boot_init();
 #endif
-#ifdef CONFIG_SERIAL_8250_CONSOLE
-#ifdef CONFIG_SERIAL_8250_HCDP
-	if (efi.hcdp) {
-		void setup_serial_hcdp(void *);
-		setup_serial_hcdp(efi.hcdp);
-	}
+#ifdef CONFIG_EFI_PCDP
+	efi_setup_pcdp_console(*cmdline_p);
 #endif
+#ifdef CONFIG_SERIAL_8250_CONSOLE
 	if (!efi.hcdp)
 		setup_serial_legacy();
 #endif
 
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
diff -Nru a/drivers/firmware/Kconfig b/drivers/firmware/Kconfig
--- a/drivers/firmware/Kconfig	2004-06-25 12:53:30 -06:00
+++ b/drivers/firmware/Kconfig	2004-06-25 12:53:30 -06:00
@@ -34,4 +34,23 @@
 	  Subsequent efibootmgr releases may be found at:
 	  http://linux.dell.com/efibootmgr
 
+config EFI_PCDP
+	bool "Console device selection via EFI PCDP or HCDP table"
+	depends on ACPI && EFI
+	default y if IA64
+	help
+	  If your firmware supplies the PCDP table, and you want to
+	  automatically use the primary console device it describes
+	  as the Linux console, say Y here.
+
+	  If your firmware supplies the HCDP table, and you want to
+	  use the first serial port it describes as the Linux console,
+	  say Y here.  If your EFI ConOut path contains only a UART
+	  device, it will become the console automatically.  Otherwise,
+	  you must specify the "console=ttyS0" kernel boot argument.
+
+	  You must also enable the appropriate drivers (serial, VGA, etc.)
+	  
+	  See <http://www.dig64.org/specifications/DIG64_HCDPv20_042804.pdf>
+
 endmenu
diff -Nru a/drivers/firmware/Makefile b/drivers/firmware/Makefile
--- a/drivers/firmware/Makefile	2004-06-25 12:53:30 -06:00
+++ b/drivers/firmware/Makefile	2004-06-25 12:53:30 -06:00
@@ -3,3 +3,4 @@
 #
 obj-$(CONFIG_EDD)             	+= edd.o
 obj-$(CONFIG_EFI_VARS)		+= efivars.o
+obj-$(CONFIG_EFI_PCDP)		+= pcdp.o
diff -Nru a/drivers/firmware/pcdp.c b/drivers/firmware/pcdp.c
--- /dev/null	Wed Dec 31 16:00:00 196900
+++ b/drivers/firmware/pcdp.c	2004-06-25 12:53:30 -06:00
@@ -0,0 +1,206 @@
+/*
+ * Copyright (C) 2002, 2003, 2004 Hewlett-Packard Co.
+ *	Khalid Aziz <khalid_aziz@hp.com>
+ *	Alex Williamson <alex.williamson@hp.com>
+ *	Bjorn Helgaas <bjorn.helgaas@hp.com>
+ *
+ * Parse the EFI PCDP table to locate the console device.
+ */
+
+#include <linux/acpi.h>
+#include <linux/console.h>
+#include <linux/efi.h>
+#include <linux/tty.h>
+#include <linux/serial.h>
+#include <linux/serial_core.h>
+#include <asm/serial.h>
+#include "pcdp.h"
+
+static inline int
+uart_irq_supported(int rev, struct pcdp_uart *uart)
+{
+	if (rev < 3)
+		return uart->pci_func & PCDP_UART_IRQ;
+	return uart->flags & PCDP_UART_IRQ;
+}
+
+static inline int
+uart_pci(int rev, struct pcdp_uart *uart)
+{
+	if (rev < 3)
+		return uart->pci_func & PCDP_UART_PCI;
+	return uart->flags & PCDP_UART_PCI;
+}
+
+static inline int
+uart_active_high_low(int rev, struct pcdp_uart *uart)
+{
+	if (uart_pci(rev, uart) || uart->flags & PCDP_UART_ACTIVE_LOW)
+		return ACPI_ACTIVE_LOW;
+	return ACPI_ACTIVE_HIGH;
+}
+
+static inline int
+uart_edge_level(int rev, struct pcdp_uart *uart)
+{
+	if (uart_pci(rev, uart))
+		return ACPI_LEVEL_SENSITIVE;
+	if (rev < 3 || uart->flags & PCDP_UART_EDGE_SENSITIVE)
+		return ACPI_EDGE_SENSITIVE;
+	return ACPI_LEVEL_SENSITIVE;
+}
+
+static void __init
+setup_serial_console(int rev, struct pcdp_uart *uart)
+{
+#ifdef CONFIG_SERIAL_8250_CONSOLE
+	struct uart_port port;
+	static char options[16];
+
+	memset(&port, 0, sizeof(port));
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
+		return;
+
+	switch (uart->pci_prog_intfc) {
+		case 0x0: port.type = PORT_8250;    break;
+		case 0x1: port.type = PORT_16450;   break;
+		case 0x2: port.type = PORT_16550;   break;
+		case 0x3: port.type = PORT_16650;   break;
+		case 0x4: port.type = PORT_16750;   break;
+		case 0x5: port.type = PORT_16850;   break;
+		case 0x6: port.type = PORT_16C950;  break;
+		default:  port.type = PORT_UNKNOWN; break;
+	}
+
+	port.flags = UPF_SKIP_TEST | UPF_BOOT_AUTOCONF | UPF_RESOURCES;
+
+	if (uart_irq_supported(rev, uart)) {
+		port.irq = acpi_register_gsi(uart->gsi,
+			uart_active_high_low(rev, uart),
+			uart_edge_level(rev, uart));
+		port.flags |= UPF_AUTO_IRQ;  /* some FW reported wrong GSI */
+		if (uart_pci(rev, uart))
+			port.flags |= UPF_SHARE_IRQ;
+	}
+
+	if (early_serial_setup(&port) < 0)
+		return;
+
+	snprintf(options, sizeof(options), "%lun%d", uart->baud,
+		uart->bits ? uart->bits : 8);
+	add_preferred_console("ttyS", port.line, options);
+
+	printk(KERN_INFO "PCDP: serial console at %s 0x%lx (ttyS%d, options %s)\n",
+		port.iotype == SERIAL_IO_MEM ? "MMIO" : "I/O",
+		uart->addr.address, port.line, options);
+#endif
+}
+
+static void __init
+setup_vga_console(struct pcdp_vga *vga)
+{
+#ifdef CONFIG_VT
+#ifdef CONFIG_VGA_CONSOLE
+	if (efi_mem_type(0xA0000) == EFI_CONVENTIONAL_MEMORY) {
+		printk(KERN_ERR "PCDP: VGA selected, but frame buffer is not MMIO!\n");
+		return;
+	}
+
+	conswitchp = &vga_con;
+	printk(KERN_INFO "PCDP: VGA console\n");
+#endif
+#endif
+}
+
+void __init
+efi_setup_pcdp_console(char *cmdline)
+{
+	struct pcdp *pcdp;
+	struct pcdp_uart *uart;
+	struct pcdp_device *dev, *end;
+	int i, serial = 0;
+
+	pcdp = efi.hcdp;
+	if (!pcdp)
+		return;
+
+	printk(KERN_INFO "PCDP: v%d at 0x%p\n", pcdp->rev, pcdp);
+
+	if (pcdp->rev < 3) {
+		if (strstr(cmdline, "console=ttyS0") || efi_uart_console_only())
+			serial = 1;
+	}
+
+	for (i = 0, uart = pcdp->uart; i < pcdp->num_uarts; i++, uart++) {
+		if (uart->flags & PCDP_UART_PRIMARY_CONSOLE || serial) {
+			if (uart->type == PCDP_CONSOLE_UART) {
+				setup_serial_console(pcdp->rev, uart);
+				return;
+			}
+		}
+	}
+
+	end = (struct pcdp_device *) ((u8 *) pcdp + pcdp->length);
+	for (dev = (struct pcdp_device *) (pcdp->uart + pcdp->num_uarts);
+	     dev < end;
+	     dev = (struct pcdp_device *) ((u8 *) dev + dev->length)) {
+		if (dev->flags & PCDP_PRIMARY_CONSOLE) {
+			if (dev->type == PCDP_CONSOLE_VGA) {
+				setup_vga_console((struct pcdp_vga *) dev);
+				return;
+			}
+		}
+	}
+}
+
+#ifdef CONFIG_IA64_EARLY_PRINTK_UART
+unsigned long
+hcdp_early_uart (void)
+{
+	efi_system_table_t *systab;
+	efi_config_table_t *config_tables;
+	unsigned long addr = 0;
+	struct pcdp *pcdp = 0;
+	struct pcdp_uart *uart;
+	int i;
+
+	systab = (efi_system_table_t *) ia64_boot_param->efi_systab;
+	if (!systab)
+		return 0;
+	systab = __va(systab);
+
+	config_tables = (efi_config_table_t *) systab->tables;
+	if (!config_tables)
+		return 0;
+	config_tables = __va(config_tables);
+
+	for (i = 0; i < systab->nr_tables; i++) {
+		if (efi_guidcmp(config_tables[i].guid, PCDP_TABLE_GUID) == 0) {
+			pcdp = (struct pcdp *) config_tables[i].table;
+			break;
+		}
+	}
+	if (!pcdp)
+		return 0;
+	pcdp = __va(pcdp);
+
+	for (i = 0, uart = pcdp->uart; i < pcdp->num_uarts; i++, uart++) {
+		if (uart->type == PCDP_CONSOLE_UART) {
+			addr = uart->addr.address;
+			break;
+		}
+	}
+	return addr;
+}
+#endif /* CONFIG_IA64_EARLY_PRINTK_UART */
diff -Nru a/drivers/firmware/pcdp.h b/drivers/firmware/pcdp.h
--- /dev/null	Wed Dec 31 16:00:00 196900
+++ b/drivers/firmware/pcdp.h	2004-06-25 12:53:30 -06:00
@@ -0,0 +1,80 @@
+/*
+ * Copyright (C) 2002, 2004 Hewlett-Packard Co.
+ *	Khalid Aziz <khalid_aziz@hp.com>
+ *	Bjorn Helgaas <bjorn.helgaas@hp.com>
+ *
+ * Definitions for PCDP-defined console devices
+ *
+ * v1.0a: http://www.dig64.org/specifications/DIG64_HCDPv10a_01.pdf
+ * v2.0:  http://www.dig64.org/specifications/DIG64_HCDPv20_042804.pdf
+ */
+
+#define PCDP_CONSOLE			0
+#define PCDP_DEBUG			1
+#define PCDP_CONSOLE_OUTPUT		2
+#define PCDP_CONSOLE_INPUT		3
+
+#define PCDP_UART			(0 << 3)
+#define PCDP_VGA			(1 << 3)
+#define PCDP_USB			(2 << 3)
+
+/* pcdp_uart.type and pcdp_device.type */
+#define PCDP_CONSOLE_UART		(PCDP_UART | PCDP_CONSOLE)
+#define PCDP_DEBUG_UART			(PCDP_UART | PCDP_DEBUG)
+#define PCDP_CONSOLE_VGA		(PCDP_VGA  | PCDP_CONSOLE_OUTPUT)
+#define PCDP_CONSOLE_USB		(PCDP_USB  | PCDP_CONSOLE_INPUT)
+
+/* pcdp_uart.flags */
+#define PCDP_UART_EDGE_SENSITIVE	(1 << 0)
+#define PCDP_UART_ACTIVE_LOW		(1 << 1)
+#define PCDP_UART_PRIMARY_CONSOLE	(1 << 2)
+#define PCDP_UART_IRQ			(1 << 6) /* in pci_func for rev < 3 */
+#define PCDP_UART_PCI			(1 << 7) /* in pci_func for rev < 3 */
+
+struct pcdp_uart {
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
+	u32				gsi;
+	u32				clock_rate;
+	u8				pci_prog_intfc;
+	u8				flags;
+};
+
+struct pcdp_vga {
+	u8			count;		/* address space descriptors */
+};
+
+/* pcdp_device.flags */
+#define PCDP_PRIMARY_CONSOLE	1
+
+struct pcdp_device {
+	u8			type;
+	u8			flags;
+	u16			length;
+	u16			efi_index;
+};
+
+struct pcdp {
+	u8			signature[4];
+	u32			length;
+	u8			rev;		/* PCDP v2.0 is rev 3 */
+	u8			chksum;
+	u8			oemid[6];
+	u8			oem_tabid[8];
+	u32			oem_rev;
+	u8			creator_id[4];
+	u32			creator_rev;
+	u32			num_uarts;
+	struct pcdp_uart	uart[0];	/* actual size is num_uarts */
+	/* remainder of table is pcdp_device structures */
+};
diff -Nru a/drivers/serial/8250_hcdp.c b/drivers/serial/8250_hcdp.c
--- a/drivers/serial/8250_hcdp.c	2004-06-25 12:53:30 -06:00
+++ /dev/null	Wed Dec 31 16:00:00 196900
@@ -1,264 +0,0 @@
-/*
- * linux/drivers/char/hcdp_serial.c
- *
- * Copyright (C) 2002 Hewlett-Packard Co.
- *	Khalid Aziz <khalid_aziz@hp.com>
- *
- * Parse the EFI HCDP table to locate serial console and debug ports and
- * initialize them.
- *
- * 2002/08/29 davidm	Adjust it to new 2.5 serial driver infrastructure.
- */
-
-#include <linux/config.h>
-#include <linux/console.h>
-#include <linux/kernel.h>
-#include <linux/efi.h>
-#include <linux/init.h>
-#include <linux/tty.h>
-#include <linux/serial.h>
-#include <linux/serial_core.h>
-#include <linux/types.h>
-#include <linux/acpi.h>
-
-#include <asm/io.h>
-#include <asm/serial.h>
-#include <asm/acpi.h>
-
-#include "8250_hcdp.h"
-
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
-{
-	hcdp_dev_t *hcdp_dev;
-	struct uart_port port;
-	unsigned long iobase;
-	hcdp_t hcdp;
-	int gsi, nr;
-	static char options[16];
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
-
-	memset(&port, 0, sizeof(port));
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
-		return;
-
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
-		if (HCDP_PCI_UART(hcdp_dev))
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
-
-		if (HCDP_IRQ_SUPPORTED(hcdp_dev)) {
-			if (HCDP_PCI_UART(hcdp_dev))
-				port.irq = acpi_register_gsi(gsi,
-					ACPI_LEVEL_SENSITIVE, ACPI_ACTIVE_LOW);
-			else
-				port.irq = acpi_register_gsi(gsi,
-					ACPI_EDGE_SENSITIVE, ACPI_ACTIVE_HIGH);
-			port.flags |= UPF_AUTO_IRQ;
-
-			if (HCDP_PCI_UART(hcdp_dev))
-				port.flags |= UPF_SHARE_IRQ;
-		}
-
-		port.flags |= UPF_SKIP_TEST | UPF_BOOT_AUTOCONF | UPF_RESOURCES;
-
-		/*
-		 * Note: the above memset() initializes port.line to 0,
-		 * so we register this port as ttyS0.
-		 */
-		if (early_serial_setup(&port) < 0) {
-			printk("setup_serial_hcdp(): early_serial_setup() "
-				"for HCDP serial console port failed. "
-				"Will try any additional consoles in HCDP.\n");
-			memset(&port, 0, sizeof(port));
-			continue;
-		}
-
-		if (efi_uart_console_only()) {
-			snprintf(options, sizeof(options), "%lun%d",
-				hcdp_dev->baud, hcdp_dev->bits);
-			add_preferred_console("ttyS", port.line, options);
-		}
-		break;
-	}
-
-#ifdef SERIAL_DEBUG_HCDP
-	printk("Leaving setup_serial_hcdp()\n");
-#endif
-}
-
-#ifdef CONFIG_IA64_EARLY_PRINTK_UART
-unsigned long
-hcdp_early_uart (void)
-{
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
-	if (!hcdp)
-		return 0;
-	hcdp = __va(hcdp);
-
-	for (i = 0, dev = hcdp->hcdp_dev; i < hcdp->num_entries; i++, dev++) {
-		if (dev->type == HCDP_DEV_CONSOLE) {
-			addr = (u64) dev->base_addr.addrhi << 32 | dev->base_addr.addrlo;
-			break;
-		}
-	}
-	return addr;
-}
-#endif /* CONFIG_IA64_EARLY_PRINTK_UART */
diff -Nru a/drivers/serial/8250_hcdp.h b/drivers/serial/8250_hcdp.h
--- a/drivers/serial/8250_hcdp.h	2004-06-25 12:53:30 -06:00
+++ /dev/null	Wed Dec 31 16:00:00 196900
@@ -1,82 +0,0 @@
-/*
- * drivers/serial/8250_hcdp.h
- *
- * Copyright (C) 2002 Hewlett-Packard Co.
- *	Khalid Aziz <khalid_aziz@hp.com>
- *
- * Definitions for HCDP defined serial ports (Serial console and debug
- * ports)
- */
-
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
-
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
-
-#define HCDP_PCI_UART(x) (x->pci_func & 1UL<<7)
-#define HCDP_IRQ_SUPPORTED(x) (x->pci_func & 1UL<<6)
diff -Nru a/drivers/serial/Kconfig b/drivers/serial/Kconfig
--- a/drivers/serial/Kconfig	2004-06-25 12:53:30 -06:00
+++ b/drivers/serial/Kconfig	2004-06-25 12:53:30 -06:00
@@ -62,15 +62,6 @@
 
 	  If unsure, say N.
 
-config SERIAL_8250_HCDP
-	bool "Console device discovery via EFI HCDP table"
-	depends on IA64
-	depends on SERIAL_8250_CONSOLE=y
-	---help---
-	  If you wish to make the serial console port described by the EFI
-	  HCDP table available for use as serial console, say Y here.  See
-	  <http://www.dig64.org/specifications/DIG64_HCDPv10a_01.pdf>.
-
 config SERIAL_8250_CS
 	tristate "8250/16550 PCMCIA device support"
 	depends on PCMCIA && SERIAL_8250
diff -Nru a/drivers/serial/Makefile b/drivers/serial/Makefile
--- a/drivers/serial/Makefile	2004-06-25 12:53:30 -06:00
+++ b/drivers/serial/Makefile	2004-06-25 12:53:30 -06:00
@@ -9,7 +9,6 @@
 serial-8250-$(CONFIG_GSC) += 8250_gsc.o
 serial-8250-$(CONFIG_PCI) += 8250_pci.o
 serial-8250-$(CONFIG_PNP) += 8250_pnp.o
-serial-8250-$(CONFIG_SERIAL_8250_HCDP) += 8250_hcdp.o
 
 obj-$(CONFIG_SERIAL_CORE) += serial_core.o
 obj-$(CONFIG_SERIAL_21285) += 21285.o
diff -Nru a/include/linux/efi.h b/include/linux/efi.h
--- a/include/linux/efi.h	2004-06-25 12:53:30 -06:00
+++ b/include/linux/efi.h	2004-06-25 12:53:30 -06:00
@@ -305,6 +305,10 @@
 extern int __init efi_set_rtc_mmss(unsigned long nowtime);
 extern struct efi_memory_map memmap;
 
+#ifdef CONFIG_EFI_PCDP
+extern void __init efi_setup_pcdp_console(char *);
+#endif
+
 /*
  * We play games with efi_enabled so that the compiler will, if possible, remove
  * EFI-related code altogether.
