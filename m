Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263932AbTDIWGI (for <rfc822;willy@w.ods.org>); Wed, 9 Apr 2003 18:06:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263958AbTDIWGI (for <rfc822;linux-kernel-outgoing>); Wed, 9 Apr 2003 18:06:08 -0400
Received: from palrel10.hp.com ([156.153.255.245]:19861 "EHLO palrel10.hp.com")
	by vger.kernel.org with ESMTP id S263932AbTDIWF5 (for <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 9 Apr 2003 18:05:57 -0400
From: David Mosberger <davidm@napali.hpl.hp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <16020.39934.175770.141002@napali.hpl.hp.com>
Date: Wed, 9 Apr 2003 15:17:34 -0700
To: torvalds@transmeta.com
Cc: rmk@arm.linux.org.uk, linux-kernel@vger.kernel.org
Subject: add serial device discovery via ACPI name space and via EFI HCDP
X-Mailer: VM 7.07 under Emacs 21.2.1
Reply-To: davidm@hpl.hp.com
X-URL: http://www.hpl.hp.com/personal/David_Mosberger/
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus,

The patch below adds support for serial device discovery via the ACPI
namespace (PNP0501, whatever that is... ;-) and via the EFI HCDP
table.  Both optons currently have "depends on IA64" so they should be
harmless.  Neither options really are ia64-specific though, so if
there is a need in the future, the "depends" clauses can be adjusted
accordingly.

	--david

diff -Nru a/drivers/serial/Kconfig b/drivers/serial/Kconfig
--- a/drivers/serial/Kconfig	Wed Apr  9 14:49:49 2003
+++ b/drivers/serial/Kconfig	Wed Apr  9 14:49:49 2003
@@ -39,6 +39,13 @@
 	  Most people will say Y or M here, so that they can use serial mice,
 	  modems and similar devices connecting to the standard serial ports.
 
+config SERIAL_8250_ACPI
+	tristate "8250/16550 device discovery support via ACPI
+	depends on IA64
+	help
+	  Locate serial ports via the ACPI name space.
+
+
 config SERIAL_8250_CONSOLE
 	bool "Console on 8250/16550 and compatible serial port (EXPERIMENTAL)"
 	depends on SERIAL_8250=y
@@ -76,6 +83,15 @@
 	  The module will be called serial_cs.  If you want to compile it as
 	  a module, say M here and read <file:Documentation/modules.txt>.
 	  If unsure, say N.
+
+config SERIAL_8250_HCDP
+	bool "8250/16550 device discovery support via EFI HCDP table"
+	depends on IA64
+	---help---
+	  If you wish to make the serial console port described by the EFI
+	  HCDP table available for use as serial console or general
+	  purpose port, say Y here. See
+	  <http://www.dig64.org/specifications/DIG64_HCDPv10a_01.pdf>.
 
 config SERIAL_8250_EXTENDED
 	bool "Extended 8250/16550 serial driver options"
diff -Nru a/drivers/serial/Makefile b/drivers/serial/Makefile
--- a/drivers/serial/Makefile	Wed Apr  9 14:49:49 2003
+++ b/drivers/serial/Makefile	Wed Apr  9 14:49:49 2003
@@ -8,6 +8,8 @@
 serial-8250-$(CONFIG_GSC) += 8250_gsc.o
 serial-8250-$(CONFIG_PCI) += 8250_pci.o
 serial-8250-$(CONFIG_PNP) += 8250_pnp.o
+serial-8250-$(CONFIG_SERIAL_8250_ACPI) += acpi.o
+serial-8250-$(CONFIG_SERIAL_8250_HCDP) += 8250_hcdp.o
 obj-$(CONFIG_SERIAL_CORE) += core.o
 obj-$(CONFIG_SERIAL_21285) += 21285.o
 obj-$(CONFIG_SERIAL_8250) += 8250.o $(serial-8250-y)
diff -Nru a/drivers/serial/acpi.c b/drivers/serial/acpi.c
--- /dev/null	Wed Dec 31 16:00:00 1969
+++ b/drivers/serial/acpi.c	Wed Apr  9 14:49:50 2003
@@ -0,0 +1,110 @@
+/*
+ * serial/acpi.c
+ * Copyright (c) 2002-2003 Matthew Wilcox for Hewlett-Packard
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License as published by
+ * the Free Software Foundation; either version 2 of the License, or
+ * (at your option) any later version.
+ */
+
+#include <linux/acpi.h>
+#include <linux/init.h>
+#include <linux/module.h>
+#include <linux/serial.h>
+
+#include <acpi/acpi_bus.h>
+
+#include <asm/io.h>
+#include <asm/serial.h>
+
+static void acpi_serial_address(struct serial_struct *req, struct acpi_resource_address32 *addr32)
+{
+	unsigned long size;
+
+	size = addr32->max_address_range - addr32->min_address_range + 1;
+	req->iomap_base = addr32->min_address_range;
+	req->iomem_base = ioremap(req->iomap_base, size);
+	req->io_type = SERIAL_IO_MEM;
+}
+
+static void acpi_serial_irq(struct serial_struct *req, struct acpi_resource_ext_irq *ext_irq)
+{
+	if (ext_irq->number_of_interrupts > 0) {
+#ifdef CONFIG_IA64
+		req->irq = acpi_register_irq(ext_irq->interrupts[0],
+	                  ext_irq->active_high_low == ACPI_ACTIVE_HIGH,
+	                  ext_irq->edge_level == ACPI_EDGE_SENSITIVE);
+#else
+		req->irq = ext_irq->interrupts[0];
+#endif
+	}
+}
+
+static int acpi_serial_add(struct acpi_device *device)
+{
+	acpi_status result;
+	struct acpi_buffer buffer = { ACPI_ALLOCATE_BUFFER, NULL };
+	struct serial_struct serial_req;
+	int line, offset = 0;
+
+	memset(&serial_req, 0, sizeof(serial_req));
+	result = acpi_get_current_resources(device->handle, &buffer);
+	if (ACPI_FAILURE(result)) {
+		result = -ENODEV;
+		goto out;
+	}
+
+	while (offset <= buffer.length) {
+		struct acpi_resource *res = buffer.pointer + offset;
+		if (res->length == 0)
+			break;
+		offset += res->length;
+		if (res->id == ACPI_RSTYPE_ADDRESS32) {
+			acpi_serial_address(&serial_req, &res->data.address32);
+		} else if (res->id == ACPI_RSTYPE_EXT_IRQ) {
+			acpi_serial_irq(&serial_req, &res->data.extended_irq);
+		}
+	}
+
+	serial_req.baud_base = BASE_BAUD;
+	serial_req.flags = ASYNC_SKIP_TEST|ASYNC_BOOT_AUTOCONF|ASYNC_AUTO_IRQ;
+
+	result = 0;
+	line = register_serial(&serial_req);
+	if (line < 0)
+		result = -ENODEV;
+
+ out:
+	acpi_os_free(buffer.pointer);
+	return result;
+}
+
+static int acpi_serial_remove(struct acpi_device *device, int type)
+{
+	return 0;
+}
+
+static struct acpi_driver acpi_serial_driver = {
+	.name =		"serial",
+	.class =	"",
+	.ids =		"PNP0501",
+	.ops =	{
+		.add =		acpi_serial_add,
+		.remove =	acpi_serial_remove,
+	},
+};
+
+static int __init acpi_serial_init(void)
+{
+	acpi_bus_register_driver(&acpi_serial_driver);
+	return 0;
+}
+
+static void __exit acpi_serial_exit(void)
+{
+	acpi_bus_unregister_driver(&acpi_serial_driver);
+}
+
+module_init(acpi_serial_init);
+module_exit(acpi_serial_exit);
diff -Nru a/drivers/serial/8250_hcdp.c b/drivers/serial/8250_hcdp.c
--- /dev/null	Wed Dec 31 16:00:00 1969
+++ b/drivers/serial/8250_hcdp.c	Wed Apr  9 14:49:50 2003
@@ -0,0 +1,215 @@
+/*
+ * linux/drivers/char/hcdp_serial.c
+ *
+ * Copyright (C) 2002 Hewlett-Packard Co.
+ *	Khalid Aziz <khalid_aziz@hp.com>
+ *
+ * Parse the EFI HCDP table to locate serial console and debug ports and initialize them.
+ *
+ * 2002/08/29 davidm	Adjust it to new 2.5 serial driver infrastructure (untested).
+ */
+#include <linux/config.h>
+
+#include <linux/kernel.h>
+#include <linux/efi.h>
+#include <linux/init.h>
+#include <linux/tty.h>
+#include <linux/serial.h>
+#include <linux/serial_core.h>
+#include <linux/types.h>
+
+#include <asm/io.h>
+#include <asm/serial.h>
+
+#include "8250_hcdp.h"
+
+#undef SERIAL_DEBUG_HCDP
+
+/*
+ * Parse the HCDP table to find descriptions for headless console and debug serial ports
+ * and add them to rs_table[]. A pointer to HCDP table is passed as parameter. This
+ * function should be called before serial_console_init() is called to make sure the HCDP
+ * serial console will be available for use. IA-64 kernel calls this function from
+ * setup_arch() after the EFI and ACPI tables have been parsed.
+ */
+void __init
+setup_serial_hcdp (void *tablep)
+{
+	hcdp_dev_t *hcdp_dev;
+	struct uart_port port;
+	unsigned long iobase;
+	hcdp_t hcdp;
+	int gsi, nr;
+#if 0
+	static int shift_once = 1;
+#endif
+
+#ifdef SERIAL_DEBUG_HCDP
+	printk("Entering setup_serial_hcdp()\n");
+#endif
+
+	/* Verify we have a valid table pointer */
+	if (!tablep)
+		return;
+
+	memset(&port, 0, sizeof(port));
+
+	/*
+	 * Don't trust firmware to give us a table starting at an aligned address. Make a
+	 * local copy of the HCDP table with aligned structures.
+	 */
+	memcpy(&hcdp, tablep, sizeof(hcdp));
+
+	/*
+	 * Perform a sanity check on the table. Table should have a signature of "HCDP"
+	 * and it should be atleast 82 bytes long to have any useful information.
+	 */
+	if ((strncmp(hcdp.signature, HCDP_SIGNATURE, HCDP_SIG_LEN) != 0))
+		return;
+	if (hcdp.len < 82)
+		return;
+
+#ifdef SERIAL_DEBUG_HCDP
+	printk("setup_serial_hcdp(): table pointer = 0x%p, sig = '%.4s'\n",
+	       tablep, hcdp.signature);
+	printk(" length = %d, rev = %d, ", hcdp.len, hcdp.rev);
+	printk("OEM ID = %.6s, # of entries = %d\n", hcdp.oemid, hcdp.num_entries);
+#endif
+
+	/*
+	 * Parse each device entry
+	 */
+	for (nr = 0; nr < hcdp.num_entries; nr++) {
+		hcdp_dev = hcdp.hcdp_dev + nr;
+		/*
+		 * We will parse only the primary console device which is the first entry
+		 * for these devices. We will ignore rest of the entries for the same type
+		 * device that has already been parsed and initialized
+		 */
+		if (hcdp_dev->type != HCDP_DEV_CONSOLE)
+			continue;
+
+		iobase = ((u64) hcdp_dev->base_addr.addrhi << 32) | hcdp_dev->base_addr.addrlo;
+		gsi = hcdp_dev->global_int;
+
+		/* See PCI spec v2.2, Appendix D (Class Codes): */
+		switch (hcdp_dev->pci_prog_intfc) {
+		      case 0x00: port.type = PORT_8250;  break;
+		      case 0x01: port.type = PORT_16450; break;
+		      case 0x02: port.type = PORT_16550; break;
+		      case 0x03: port.type = PORT_16650; break;
+		      case 0x04: port.type = PORT_16750; break;
+		      case 0x05: port.type = PORT_16850; break;
+		      case 0x06: port.type = PORT_16C950; break;
+		      default:
+			printk(KERN_WARNING"warning: EFI HCDP table reports unknown serial "
+			       "programming interface 0x%02x; will autoprobe.\n",
+			       hcdp_dev->pci_prog_intfc);
+			port.type = PORT_UNKNOWN;
+			break;
+		}
+
+#ifdef SERIAL_DEBUG_HCDP
+		printk("  type = %s, uart = %d\n", ((hcdp_dev->type == HCDP_DEV_CONSOLE)
+					 ? "Headless Console" : ((hcdp_dev->type == HCDP_DEV_DEBUG)
+								 ? "Debug port" : "Huh????")),
+		       port.type);
+		printk("  base address space = %s, base address = 0x%lx\n",
+		       ((hcdp_dev->base_addr.space_id == ACPI_MEM_SPACE)
+			? "Memory Space" : ((hcdp_dev->base_addr.space_id == ACPI_IO_SPACE)
+					    ? "I/O space" : "PCI space")),
+		       iobase);
+		printk("  gsi = %d, baud rate = %lu, bits = %d, clock = %d\n",
+		       gsi, (unsigned long) hcdp_dev->baud, hcdp_dev->bits, hcdp_dev->clock_rate);
+		if (hcdp_dev->base_addr.space_id == ACPI_PCICONF_SPACE)
+			printk(" PCI id: %02x:%02x:%02x, vendor ID=0x%x, dev ID=0x%x\n",
+			       hcdp_dev->pci_seg, hcdp_dev->pci_bus, hcdp_dev->pci_dev,
+			       hcdp_dev->pci_vendor_id, hcdp_dev->pci_dev_id);
+#endif
+		/*
+		 * Now fill in a port structure to update the 8250 port table..
+		 */
+		if (hcdp_dev->clock_rate)
+			port.uartclk = hcdp_dev->clock_rate;
+		else
+			port.uartclk = BASE_BAUD * 16;
+
+		/*
+		 * Check if this is an I/O mapped address or a memory mapped address
+		 */
+		if (hcdp_dev->base_addr.space_id == ACPI_MEM_SPACE) {
+			port.iobase = 0;
+			port.mapbase = iobase;
+			port.membase = ioremap(iobase, 64);
+			port.iotype = SERIAL_IO_MEM;
+		} else if (hcdp_dev->base_addr.space_id == ACPI_IO_SPACE) {
+			port.iobase = iobase;
+			port.mapbase = 0;
+			port.membase = NULL;
+			port.iotype = SERIAL_IO_PORT;
+		} else if (hcdp_dev->base_addr.space_id == ACPI_PCICONF_SPACE) {
+			printk(KERN_WARNING"warning: No support for PCI serial console\n");
+			return;
+		}
+		port.irq = gsi;
+		port.flags = UPF_SKIP_TEST | UPF_BOOT_AUTOCONF;
+		if (gsi)
+			port.flags |= ASYNC_AUTO_IRQ;
+
+		/*
+		 * Note: the above memset() initializes port.line to 0, so we register
+		 * this port as ttyS0.
+		 */
+		if (early_serial_setup(&port) < 0) {
+			printk("setup_serial_hcdp(): early_serial_setup() for HCDP serial "
+			       "console port failed. Will try any additional consoles in HCDP.\n");
+			continue;
+		}
+		break;
+	}
+
+#ifdef SERIAL_DEBUG_HCDP
+	printk("Leaving setup_serial_hcdp()\n");
+#endif
+}
+
+#ifdef CONFIG_IA64_EARLY_PRINTK_UART
+unsigned long
+hcdp_early_uart (void)
+{
+	efi_system_table_t *systab;
+	efi_config_table_t *config_tables;
+	unsigned long addr = 0;
+	hcdp_t *hcdp = 0;
+	hcdp_dev_t *dev;
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
+		if (efi_guidcmp(config_tables[i].guid, HCDP_TABLE_GUID) == 0) {
+			hcdp = (hcdp_t *) config_tables[i].table;
+			break;
+		}
+	}
+	if (!hcdp)
+		return 0;
+	hcdp = __va(hcdp);
+
+	for (i = 0, dev = hcdp->hcdp_dev; i < hcdp->num_entries; i++, dev++) {
+		if (dev->type == HCDP_DEV_CONSOLE) {
+			addr = (u64) dev->base_addr.addrhi << 32 | dev->base_addr.addrlo;
+			break;
+		}
+	}
+	return addr;
+}
+#endif /* CONFIG_IA64_EARLY_PRINTK_UART */
diff -Nru a/drivers/serial/8250_hcdp.h b/drivers/serial/8250_hcdp.h
--- /dev/null	Wed Dec 31 16:00:00 1969
+++ b/drivers/serial/8250_hcdp.h	Wed Apr  9 14:49:50 2003
@@ -0,0 +1,79 @@
+/*
+ * drivers/serial/8250_hcdp.h
+ *
+ * Copyright (C) 2002 Hewlett-Packard Co.
+ *	Khalid Aziz <khalid_aziz@hp.com>
+ *
+ * Definitions for HCDP defined serial ports (Serial console and debug
+ * ports)
+ */
+
+/* ACPI table signatures */
+#define HCDP_SIG_LEN		4
+#define HCDP_SIGNATURE		"HCDP"
+
+/* Space ID as defined in ACPI generic address structure */
+#define ACPI_MEM_SPACE		0
+#define ACPI_IO_SPACE		1
+#define ACPI_PCICONF_SPACE	2
+
+/*
+ * Maximum number of HCDP devices we want to read in
+ */
+#define MAX_HCDP_DEVICES	6
+
+/*
+ * Default UART clock rate if clock rate is 0 in HCDP table.
+ */
+#define DEFAULT_UARTCLK		115200
+
+/*
+ * ACPI Generic Address Structure
+ */
+typedef struct {
+	u8  space_id;
+	u8  bit_width;
+	u8  bit_offset;
+	u8  resv;
+	u32 addrlo;
+	u32 addrhi;
+} acpi_gen_addr;
+
+/* HCDP Device descriptor entry types */
+#define HCDP_DEV_CONSOLE	0
+#define HCDP_DEV_DEBUG		1
+
+/* HCDP Device descriptor type */
+typedef struct {
+	u8	type;
+	u8	bits;
+	u8	parity;
+	u8	stop_bits;
+	u8	pci_seg;
+	u8	pci_bus;
+	u8	pci_dev;
+	u8	pci_func;
+	u64	baud;
+	acpi_gen_addr	base_addr;
+	u16	pci_dev_id;
+	u16	pci_vendor_id;
+	u32	global_int;
+	u32	clock_rate;
+	u8	pci_prog_intfc;
+	u8	resv;
+} hcdp_dev_t;
+
+/* HCDP Table format */
+typedef struct {
+	u8	signature[4];
+	u32	len;
+	u8	rev;
+	u8	chksum;
+	u8	oemid[6];
+	u8	oem_tabid[8];
+	u32	oem_rev;
+	u8	creator_id[4];
+	u32	creator_rev;
+	u32	num_entries;
+	hcdp_dev_t	hcdp_dev[MAX_HCDP_DEVICES];
+} hcdp_t;
