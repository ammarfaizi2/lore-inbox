Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262960AbTHZWcL (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 26 Aug 2003 18:32:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263014AbTHZWcL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 26 Aug 2003 18:32:11 -0400
Received: from atlrel7.hp.com ([156.153.255.213]:11756 "EHLO atlrel7.hp.com")
	by vger.kernel.org with ESMTP id S262960AbTHZW33 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 26 Aug 2003 18:29:29 -0400
Message-ID: <3F4BDF46.45A5547B@hp.com>
Date: Tue, 26 Aug 2003 16:29:26 -0600
From: Alex Williamson <alex.williamson@hp.com>
X-Mailer: Mozilla 4.77 [en] (X11; U; Linux 2.6.0-test4-aw-ob500 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Cc: linux-ia64@vger.kernel.org
Subject: [PATCH] EFI & HCDP Console auto selection
Content-Type: multipart/mixed;
 boundary="------------0954AB19A95C6AFEB3BFC207"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------0954AB19A95C6AFEB3BFC207
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit


   Current ia64 boxes (and potentially ia32 boxes using EFI and HCDP)
have enough information in firmware to make a reasonably educated
guess on where the console lives.  This patch tries to make use of
it and "do the right thing" when it can, without getting in the way
when it shouldn't.

   The code is triggered off whether there's a console port found
in the HCDP table.  At that point, it tries to determine what the
current command line enables for consoles.  The EFI ConOut variable
is also used to try to guess whether the system has VGA.  In short,
if the system only has one device specified for ConOut and you do
not pass a "console=tty..." argument, it will just work.  There's
some other nice parts of it that try to print a courtesy message to
the port that's not being used for the console to indicate where the
console has been started.  These only work for MMIO serial ports in
the HCDP and boxes where the EFI memory map seems to indicate a VGA
memory hole.  Doing the same for I/O port space UARTs should be trivial
to add, but I don't have the hardware/firmware combination to test it.
FWIW, I believe early ia64 boxes set the EFI memory type wrong for
the VGA hole.  I don't try to figure that out so you won't get the
courtesy messages on VGA for them.

   Let me know what you think and if you find any unexpected behavior.
It should not adversely affect any currently working setups.  The
current patch is against 2.6.0-test4.  Portions of this code are
leveraged from a previous implementation by Khalid Aziz.  Thanks,

	Alex

-- 
Alex Williamson                             HP Linux & Open Source Lab
--------------0954AB19A95C6AFEB3BFC207
Content-Type: text/plain; charset=us-ascii;
 name="auto_console_setup.diff"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="auto_console_setup.diff"

diff -urN linux/drivers/Makefile linux/drivers/Makefile
--- linux/drivers/Makefile	2003-08-08 22:39:36.000000000 -0600
+++ linux/drivers/Makefile	2003-08-25 12:42:55.000000000 -0600
@@ -49,3 +49,4 @@
 obj-$(CONFIG_MCA)		+= mca/
 obj-$(CONFIG_EISA)		+= eisa/
 obj-$(CONFIG_CPU_FREQ)		+= cpufreq/
+obj-$(CONFIG_ACPI_EFI)		+= efi/
diff -urN linux/drivers/efi/Makefile linux/drivers/efi/Makefile
--- linux/drivers/efi/Makefile	1969-12-31 17:00:00.000000000 -0700
+++ linux/drivers/efi/Makefile	2003-08-25 12:45:24.000000000 -0600
@@ -0,0 +1,6 @@
+#
+# Makefile for EFI (Extensible Firmware Interface) drivers.
+#
+
+obj-y += efi_console.o
+
diff -urN linux/drivers/efi/efi_console.c linux/drivers/efi/efi_console.c
--- linux/drivers/efi/efi_console.c	1969-12-31 17:00:00.000000000 -0700
+++ linux/drivers/efi/efi_console.c	2003-08-25 14:07:17.000000000 -0600
@@ -0,0 +1,265 @@
+/*
+ * Copyright 2003 Hewlett-Packard Co
+ * Copyright 2003 Alex Williamson <alex.williamson@hp.com>
+ * Copyright 2003 Khalid Aziz <khalid.aziz@hp.com>
+ *
+ * Locate EFI ConOut variable and check for VGA (non-UART)
+ */
+#include <linux/efi.h>
+#include <linux/kernel.h>
+
+#undef VERBOSE
+#undef DEBUG
+
+#ifdef VERBOSE
+#define VERB_PRINTK(x...) printk(x)
+#else
+#define VERB_PRINTK(x...)
+#endif
+
+#ifdef DEBUG
+#define DBG_PRINTK(x...) printk(x)
+#else
+#define DBG_PRINTK(x...)
+#endif
+
+#ifdef VERBOSE
+static void __init
+efi_print_hw_path(efi_generic_dev_path_t *hdr)
+{
+	
+	if (hdr->type != EFI_DEV_TYPE_HW_PATH)
+		return;
+
+	if (hdr->sub_type == EFI_DEV_SUBTYPE_PCI) {
+		efi_pci_dev_path_t pci_path;
+
+		if (hdr->length < sizeof(efi_pci_dev_path_t))
+			return;
+
+		memcpy(&pci_path, hdr, sizeof(efi_pci_dev_path_t));
+
+		printk("%s(%d|%d)", EFI_DEV_PCI_NAME,
+		       pci_path.device, pci_path.function);
+		return;
+	}
+	printk("Unknown hardware path");
+}
+
+static void __init
+efi_print_acpi_path(efi_generic_dev_path_t *hdr)
+{
+	
+	if (hdr->type != EFI_DEV_TYPE_ACPI_PATH)
+		return;
+
+	if (hdr->sub_type == EFI_DEV_SUBTYPE_ACPI) {
+		efi_acpi_dev_path_t acpi_path;
+		char hid_str[8];
+
+		if (hdr->length < sizeof(efi_acpi_dev_path_t))
+			return;
+
+		memcpy(&acpi_path, hdr, sizeof(efi_acpi_dev_path_t));
+
+		hid_str[0] = (char) ('@' + ((acpi_path.hid >> 10) & 0x1f));
+		hid_str[1] = (char) ('@' + ((acpi_path.hid >> 5)  & 0x1f));
+		hid_str[2] = (char) ('@' + ((acpi_path.hid >> 0)  & 0x1f));
+		hid_str[3] = (char) ('0' + ((acpi_path.hid >> 28) & 0xf));
+		hid_str[4] = (char) ('0' + ((acpi_path.hid >> 24) & 0xf));
+		hid_str[5] = (char) ('0' + ((acpi_path.hid >> 20) & 0xf));
+		hid_str[6] = (char) ('0' + ((acpi_path.hid >> 16) & 0xf));
+		hid_str[7] = 0;
+
+		printk("%s(%s,%x)", EFI_DEV_ACPI_NAME, hid_str, acpi_path.uid);
+		return;
+	}
+	printk("Unknown ACPI path");
+}
+
+static void __init
+efi_print_msg_path(efi_generic_dev_path_t *hdr)
+{
+	
+	if (hdr->type != EFI_DEV_TYPE_MSG_PATH)
+		return;
+
+	if (hdr->sub_type == EFI_DEV_SUBTYPE_UART) {
+		efi_uart_dev_path_t uart_path;
+		char parity;
+
+		if (hdr->length < sizeof(efi_uart_dev_path_t))
+			return;
+
+		memcpy(&uart_path, hdr, sizeof(efi_uart_dev_path_t));
+
+		switch (uart_path.parity) {
+			case EFI_NO_PARITY:
+				parity = 'N';
+				break;
+			case EFI_EVEN_PARITY:
+				parity = 'E';
+				break;
+			case EFI_ODD_PARITY:
+				parity = 'O';
+				break;
+			default:
+				parity = '?';
+		}
+
+		printk("%s(%ld %c%d%d)", EFI_DEV_UART_NAME, uart_path.baud,
+		       parity, uart_path.bits, uart_path.stop_bits);
+
+		return;
+	}
+	if (hdr->sub_type == EFI_DEV_SUBTYPE_VENMSG) {
+		efi_venmsg_dev_path_t venmsg_path;
+
+		if (hdr->length < sizeof(efi_venmsg_dev_path_t))
+			return;
+
+		memcpy(&venmsg_path, hdr, sizeof(efi_venmsg_dev_path_t));
+
+		if (efi_guidcmp(EFI_PC_ANSI_GUID, venmsg_path.guid) == 0)
+			printk("(PcAnsi)");
+		else if (efi_guidcmp(EFI_VT_100_GUID, venmsg_path.guid) == 0)
+			printk("(Vt100)");
+		else if (efi_guidcmp(EFI_VT_100_PLUS_GUID, venmsg_path.guid) == 0)
+			printk("(Vt100+)");
+		else if (efi_guidcmp(EFI_VT_UTF8_GUID, venmsg_path.guid) == 0)
+			printk("(VtUtf8)");
+		else
+			printk("(VenMsg)");
+		return;
+	}
+	printk("Unknown message path");
+}
+#endif
+
+#ifdef VERBOSE
+#define verb_print_separator()	\
+	if (first) {		\
+		first = 0;	\
+	} else {		\
+		printk("/");	\
+	}
+#endif
+
+int __init
+efi_conout_has_vga(void)
+{
+	efi_status_t status;
+	efi_guid_t vendor_guid;
+	unsigned char efi_data[1024];
+	efi_char16_t variable_name[128];
+	unsigned char varname[sizeof(variable_name)/sizeof(efi_char16_t) + 1];
+	unsigned long name_size, data_size, end_addr;
+	u32 attributes;
+	int i, found_end, found_vga, found_uart, first;
+	efi_generic_dev_path_t *hdr;
+
+	DBG_PRINTK("Entering %s()\n", __FUNCTION__);
+	for (;;) {
+		name_size = sizeof(variable_name);
+		status = efi.get_next_variable(&name_size, variable_name,
+		                               &vendor_guid);
+
+		if (status != EFI_SUCCESS)
+			break;
+
+		/*
+		 * Convert Unicode to normal chars (assume top bits
+		 * are 0), ala UTF-8
+		 */
+		for (i = 0; i < (name_size/sizeof(efi_char16_t)); i++)
+			varname[i] = variable_name[i] & 0xFF;
+
+		varname[i] = 0;
+
+		DBG_PRINTK("Found EFI variable %s\n", varname);
+
+		if (strcmp(varname, "ConOut") != 0)
+			continue;
+
+		data_size = sizeof(efi_data);
+		status = efi.get_variable(variable_name, &vendor_guid,
+		                          &attributes, &data_size, efi_data);
+
+		if (status != EFI_SUCCESS)
+			continue;
+
+		end_addr = (unsigned long)efi_data + data_size;
+
+#ifdef DEBUG
+		for (i = 0 ; i < data_size ;) {
+			printk("%02x", efi_data[i++]);
+
+			if (!(i % 2))
+				printk(" ");
+			if (!(i % 16))
+				printk("\n");
+		}
+		printk("\n");
+#endif
+		hdr = (efi_generic_dev_path_t *)&efi_data;
+		found_end = found_vga = found_uart = 0;
+		first = 1;
+
+		VERB_PRINTK("EFI ConOut variable data:\n");
+
+		do {
+			switch (hdr->type) {
+				case EFI_DEV_TYPE_HW_PATH:
+#ifdef VERBOSE
+					verb_print_separator();
+					efi_print_hw_path(hdr);
+#endif
+					break;
+
+				case EFI_DEV_TYPE_ACPI_PATH:
+#ifdef VERBOSE
+					verb_print_separator();
+					efi_print_acpi_path(hdr);
+#endif
+					break;
+
+				case EFI_DEV_TYPE_MSG_PATH:
+#ifdef VERBOSE
+					verb_print_separator();
+					efi_print_msg_path(hdr);
+#endif
+					if (hdr->sub_type == EFI_DEV_SUBTYPE_UART)
+						found_uart = 1;
+					break;
+
+				case EFI_DEV_TYPE_END_PATH:
+				case EFI_DEV_TYPE_END_PATH2:
+
+					if (!found_uart) {
+						found_vga = 1;
+						VERB_PRINTK(" <-- VGA");
+					}
+
+					VERB_PRINTK("\n");
+					found_uart = 0;
+					first = 1;
+					
+					if (hdr->sub_type == EFI_DEV_SUBTYPE_END)
+						found_end = 1;
+					break;
+				default:
+					break;
+			}
+
+			hdr = (efi_generic_dev_path_t *)((u8*)hdr + hdr->length);
+
+		} while (!found_end && (unsigned long)hdr < end_addr);
+
+		if (found_vga) {
+			DBG_PRINTK("Found VGA in ConOut\n");
+			return 1;
+		}
+	}
+	DBG_PRINTK("Leaving %s()\n", __FUNCTION__);
+	return 0;
+}
diff -urN linux/drivers/serial/8250_hcdp.c linux/drivers/serial/8250_hcdp.c
--- linux/drivers/serial/8250_hcdp.c	2003-08-08 22:40:06.000000000 -0600
+++ linux/drivers/serial/8250_hcdp.c	2003-08-25 13:28:17.000000000 -0600
@@ -19,6 +19,8 @@
 #include <linux/serial_core.h>
 #include <linux/types.h>
 #include <linux/acpi.h>
+#include <linux/moduleparam.h>
+#include <linux/serial_reg.h>
 
 #include <asm/io.h>
 #include <asm/serial.h>
@@ -28,6 +30,158 @@
 
 #undef SERIAL_DEBUG_HCDP
 
+static unsigned char __initdata hcdp_fake_cmdline[32];
+
+static int __init
+obsolete_setup(char *param, char *val)
+{
+	struct obs_kernel_param *p;
+	extern struct obs_kernel_param __setup_start, __setup_end;
+
+	if (val)
+		val[-1] = '=';
+
+	 p = &__setup_start;
+	 do {
+		 int n = strlen(p->str);
+		 if (!strncmp(param,p->str,n)) {
+			 if (p->setup_func(param+n))
+				 return 0;
+		 }
+		 p++;
+	 } while (p < &__setup_end);
+
+	return 0;
+}
+
+static void __init
+early_print_uart_raw(char *str, int len, unsigned long iobase)
+{
+	void *mmio_base;
+	char c;
+	
+	if (!iobase)
+		return;
+
+	mmio_base = ioremap(iobase, 64UL);
+
+	if (!mmio_base)
+		return;
+
+	while (len-- > 0) {
+		c = *str++;
+		while ((readb(mmio_base + UART_LSR) & UART_LSR_TEMT) == 0)
+			cpu_relax(); /* spin */
+
+		writeb(c, mmio_base + UART_TX);
+
+		if (c == '\n')
+			writeb('\r', mmio_base + UART_TX);
+	}
+}
+
+#define VGABASE		0xb8000UL
+#define VGALINES	24
+#define VGACOLS		80
+
+static void __init
+early_print_vga_raw(char *str, int len)
+{
+	int current_ypos = VGALINES, current_xpos = 0;
+	char c;
+	int  i, k, j;
+	void *vgabase = ioremap(VGABASE, 4000);
+
+	while (len-- > 0) {
+		c = *str++;
+		if (current_ypos >= VGALINES) {
+			/* scroll 1 line up */
+			for (k = 1, j = 0; k < VGALINES; k++, j++) {
+				for (i = 0; i < VGACOLS; i++) {
+					writew(readw(vgabase + 2*(VGACOLS*k + i)), vgabase + 2*(VGACOLS*j + i));
+				}
+			}
+			for (i = 0; i < VGACOLS; i++) {
+				writew(0x720, vgabase + 2*(VGACOLS*j + i));
+			}
+			current_ypos = VGALINES-1;
+		}
+		if (c == '\n') {
+			current_xpos = 0;
+			current_ypos++;
+		} else if (c != '\r')  {
+			writew(((0x7 << 8) | (unsigned short) c),
+					vgabase + 2*(VGACOLS*current_ypos + current_xpos++));
+			if (current_xpos >= VGACOLS) {
+				current_xpos = 0;
+				current_ypos++;
+			}
+		}
+	}
+}
+
+static void __init
+setup_console_cmdline(hcdp_dev_t *hcdp)
+{
+	int has_vga = 0;
+	int has_ttyS_cmdline = 0;
+	int has_tty_cmdline = 0;
+	extern char saved_command_line[];
+	char *cp;
+
+	has_vga = efi_conout_has_vga();
+
+	for (cp = saved_command_line; *cp; ) {
+		if (memcmp(cp, "console=ttyS", 12) == 0)
+			has_ttyS_cmdline = 1;
+		 else if (memcmp(cp, "console=tty", 11) == 0)
+			has_tty_cmdline = 1;
+
+		while (*cp && *cp != ' ')
+			++cp;
+		while (*cp && *cp == ' ')
+			++cp;
+	}
+
+	if (!has_vga && !(has_ttyS_cmdline | has_tty_cmdline)) {
+		extern struct kernel_param __start___param[], __stop___param[];
+
+		sprintf(hcdp_fake_cmdline, " console=ttyS0,%ld%c%d",
+		        hcdp->baud, ((hcdp->parity == 0x01) ?
+		        'n': ((hcdp->parity == 0x02) ? 'e':
+		        ((hcdp->parity == 0x03) ? 'o':'n'))), 
+		        hcdp->bits);
+
+		/*
+		 * Append a "console=..." string to
+		 * saved_command_line so /proc/cmdline would
+		 * show the serial console in use.
+		 */
+		strcat(saved_command_line, hcdp_fake_cmdline);
+
+		parse_args("HCDP Console setup", hcdp_fake_cmdline,
+		           __start___param, __stop___param -
+			   __start___param, &obsolete_setup);
+
+	} else if (has_vga && !has_ttyS_cmdline) {
+
+		if (hcdp->base_addr.space_id == ACPI_MEM_SPACE) {
+			unsigned long iobase;
+
+			iobase = ((u64) hcdp->base_addr.addrhi << 32) |
+			         hcdp->base_addr.addrlo;
+
+			early_print_uart_raw("Console initialized on VGA\n",
+			                     27, iobase);
+		}
+
+	} else if (has_vga && has_ttyS_cmdline && !has_tty_cmdline) {
+
+		if (efi_mem_type(VGABASE) == EFI_MEMORY_MAPPED_IO)
+			early_print_vga_raw("Console initialized on serial\n", 30);
+	}
+}
+
 /*
  * Parse the HCDP table to find descriptions for headless console and debug
  * serial ports and add them to rs_table[]. A pointer to HCDP table is
@@ -199,6 +353,9 @@
 				"Will try any additional consoles in HCDP.\n");
 			continue;
 		}
+
+		setup_console_cmdline(hcdp_dev);
+
 		break;
 	}
 
diff -urN linux/drivers/serial/Kconfig linux/drivers/serial/Kconfig
--- linux/drivers/serial/Kconfig	2003-08-08 22:41:26.000000000 -0600
+++ linux/drivers/serial/Kconfig	2003-08-25 12:47:58.000000000 -0600
@@ -86,7 +86,7 @@
 
 config SERIAL_8250_HCDP
 	bool "8250/16550 device discovery support via EFI HCDP table"
-	depends on IA64 && SERIAL_8250
+	depends on IA64 && SERIAL_8250 && ACPI_EFI
 	---help---
 	  If you wish to make the serial console port described by the EFI
 	  HCDP table available for use as serial console or general
diff -urN linux/include/linux/efi.h linux/include/linux/efi.h
--- linux/include/linux/efi.h	2003-08-08 22:41:36.000000000 -0600
+++ linux/include/linux/efi.h	2003-08-25 12:36:48.000000000 -0600
@@ -154,6 +154,63 @@
 	unsigned long reset_system;
 } efi_runtime_services_t;
 
+#define EFI_DEV_TYPE_HW_PATH   0x01
+	#define EFI_DEV_SUBTYPE_PCI  0x1
+		#define EFI_DEV_PCI_NAME "Pci"
+
+#define EFI_DEV_TYPE_ACPI_PATH 0x02
+	#define EFI_DEV_SUBTYPE_ACPI 0x1
+		#define EFI_DEV_ACPI_NAME "Acpi"
+
+#define EFI_DEV_TYPE_MSG_PATH  0x03
+	#define EFI_DEV_SUBTYPE_UART 0x0E
+		#define EFI_DEV_UART_NAME "Uart"
+
+		#define EFI_NO_PARITY   0x01
+		#define EFI_EVEN_PARITY 0x02
+		#define EFI_ODD_PARITY  0x03
+
+		#define EFI_ONE_STOP_BIT 0x01
+
+	#define EFI_DEV_SUBTYPE_VENMSG 0x0A
+
+#define EFI_DEV_TYPE_END_PATH   0xFF
+#define EFI_DEV_TYPE_END_PATH2  0x7F
+	#define EFI_DEV_SUBTYPE_END       0xFF
+	#define EFI_DEV_SUBTYPE_START_NEW 0x01
+
+typedef struct {
+	u8 type;
+	u8 sub_type;
+	u16 length;
+} efi_generic_dev_path_t;
+
+typedef struct {
+	efi_generic_dev_path_t hdr;
+	u8 function;
+	u8 device;
+} efi_pci_dev_path_t;
+
+typedef struct {
+	efi_generic_dev_path_t hdr;
+	u32 hid;
+	u32 uid;
+} efi_acpi_dev_path_t;
+
+typedef struct {
+	efi_generic_dev_path_t hdr;
+	u32 reserved;
+	u64 baud;
+	u8 bits;
+	u8 parity;
+	u8 stop_bits;
+} efi_uart_dev_path_t;
+
+typedef struct {
+	efi_generic_dev_path_t hdr;
+	efi_guid_t guid;
+} efi_venmsg_dev_path_t;
+
 typedef efi_status_t efi_get_time_t (efi_time_t *tm, efi_time_cap_t *tc);
 typedef efi_status_t efi_set_time_t (efi_time_t *tm);
 typedef efi_status_t efi_get_wakeup_time_t (efi_bool_t *enabled, efi_bool_t *pending,
@@ -194,6 +251,18 @@
 #define HCDP_TABLE_GUID	\
     EFI_GUID(  0xf951938d, 0x620b, 0x42ef, 0x82, 0x79, 0xa8, 0x4b, 0x79, 0x61, 0x78, 0x98 )
 
+#define EFI_PC_ANSI_GUID \
+    EFI_GUID(  0xe0c14753, 0xf9be, 0x11d2, 0x9a, 0x0c, 0x00, 0x90, 0x27, 0x3f, 0xc1, 0x4d )
+
+#define EFI_VT_100_GUID \
+    EFI_GUID(  0xdfa66065, 0xb419, 0x11d3, 0x9a, 0x2d, 0x00, 0x90, 0x27, 0x3f, 0xc1, 0x4d )
+
+#define EFI_VT_100_PLUS_GUID \
+    EFI_GUID(  0x7baec70b, 0x57e0, 0x4c76, 0x8e, 0x87, 0x2f, 0x9e, 0x28, 0x08, 0x83, 0x43 )
+
+#define EFI_VT_UTF8_GUID \
+    EFI_GUID(  0xad15a0d6, 0x8bec, 0x4acf, 0xa0, 0x73, 0xd0, 0x1d, 0xe7, 0x7e, 0x2d, 0x88 )
+
 typedef struct {
 	efi_guid_t guid;
 	unsigned long table;
@@ -266,6 +335,7 @@
 extern u64 efi_get_iobase (void);
 extern u32 efi_mem_type (unsigned long phys_addr);
 extern u64 efi_mem_attributes (unsigned long phys_addr);
+extern int efi_conout_has_vga(void);
 
 /*
  * Variable Attributes

--------------0954AB19A95C6AFEB3BFC207--

