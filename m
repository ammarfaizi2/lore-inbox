Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265139AbUGVMvh@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265139AbUGVMvh (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 22 Jul 2004 08:51:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265199AbUGVMvg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 22 Jul 2004 08:51:36 -0400
Received: from pxy7allmi.all.mi.charter.com ([24.247.15.58]:18148 "EHLO
	proxy7-grandhaven.chartermi.net") by vger.kernel.org with ESMTP
	id S265139AbUGVMpj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 22 Jul 2004 08:45:39 -0400
Message-ID: <40FFB68D.1000106@quark.didntduck.org>
Date: Thu, 22 Jul 2004 08:43:57 -0400
From: Brian Gerst <bgerst@didntduck.org>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7) Gecko/20040625
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Andrew Morton <akpm@osdl.org>
CC: lkml <linux-kernel@vger.kernel.org>
Subject: [PATCH] Move modpost files to a new subdir [1/2]
Content-Type: multipart/mixed;
 boundary="------------020902010501090909070403"
X-Charter-Information: 
X-Charter-Scan: 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------020902010501090909070403
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit

This patch simply moves modpost-related files to a seperate subdirectory.

--
				Brian Gerst

--------------020902010501090909070403
Content-Type: text/plain;
 name="modpost-1a"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="modpost-1a"

diff -urN linux-2.6.8-rc2/scripts/empty.c linux-mv/scripts/empty.c
--- linux-2.6.8-rc2/scripts/empty.c	2003-12-17 21:59:45.000000000 -0500
+++ linux-mv/scripts/empty.c	1969-12-31 19:00:00.000000000 -0500
@@ -1 +0,0 @@
-/* empty file to figure out endianness / word size */
diff -urN linux-2.6.8-rc2/scripts/file2alias.c linux-mv/scripts/file2alias.c
--- linux-2.6.8-rc2/scripts/file2alias.c	2004-06-23 18:05:42.000000000 -0400
+++ linux-mv/scripts/file2alias.c	1969-12-31 19:00:00.000000000 -0500
@@ -1,282 +0,0 @@
-/* Simple code to turn various tables in an ELF file into alias definitions.
- * This deals with kernel datastructures where they should be
- * dealt with: in the kernel source.
- *
- * Copyright 2002-2003  Rusty Russell, IBM Corporation
- *           2003       Kai Germaschewski
- *           
- *
- * This software may be used and distributed according to the terms
- * of the GNU General Public License, incorporated herein by reference.
- */
-
-#include "modpost.h"
-
-/* We use the ELF typedefs, since we can't rely on stdint.h being present. */
-
-#if KERNEL_ELFCLASS == ELFCLASS32
-typedef Elf32_Addr     kernel_ulong_t;
-#else
-typedef Elf64_Addr     kernel_ulong_t;
-#endif
-
-typedef Elf32_Word     __u32;
-typedef Elf32_Half     __u16;
-typedef unsigned char  __u8;
-
-/* Big exception to the "don't include kernel headers into userspace, which
- * even potentially has different endianness and word sizes, since 
- * we handle those differences explicitly below */
-#include "../include/linux/mod_devicetable.h"
-
-#define ADD(str, sep, cond, field)                              \
-do {                                                            \
-        strcat(str, sep);                                       \
-        if (cond)                                               \
-                sprintf(str + strlen(str),                      \
-                        sizeof(field) == 1 ? "%02X" :           \
-                        sizeof(field) == 2 ? "%04X" :           \
-                        sizeof(field) == 4 ? "%08X" : "",       \
-                        field);                                 \
-        else                                                    \
-                sprintf(str + strlen(str), "*");                \
-} while(0)
-
-/* Looks like "usb:vNpNdlNdhNdcNdscNdpNicNiscNipN" */
-static int do_usb_entry(const char *filename,
-			struct usb_device_id *id, char *alias)
-{
-	id->match_flags = TO_NATIVE(id->match_flags);
-	id->idVendor = TO_NATIVE(id->idVendor);
-	id->idProduct = TO_NATIVE(id->idProduct);
-	id->bcdDevice_lo = TO_NATIVE(id->bcdDevice_lo);
-	id->bcdDevice_hi = TO_NATIVE(id->bcdDevice_hi);
-
-	/*
-	 * Some modules (visor) have empty slots as placeholder for
-	 * run-time specification that results in catch-all alias
-	 */
-	if (!(id->idVendor | id->bDeviceClass | id->bInterfaceClass))
-		return 1;
-
-	strcpy(alias, "usb:");
-	ADD(alias, "v", id->match_flags&USB_DEVICE_ID_MATCH_VENDOR,
-	    id->idVendor);
-	ADD(alias, "p", id->match_flags&USB_DEVICE_ID_MATCH_PRODUCT,
-	    id->idProduct);
-	ADD(alias, "dl", id->match_flags&USB_DEVICE_ID_MATCH_DEV_LO,
-	    id->bcdDevice_lo);
-	ADD(alias, "dh", id->match_flags&USB_DEVICE_ID_MATCH_DEV_HI,
-	    id->bcdDevice_hi);
-	ADD(alias, "dc", id->match_flags&USB_DEVICE_ID_MATCH_DEV_CLASS,
-	    id->bDeviceClass);
-	ADD(alias, "dsc",
-	    id->match_flags&USB_DEVICE_ID_MATCH_DEV_SUBCLASS,
-	    id->bDeviceSubClass);
-	ADD(alias, "dp",
-	    id->match_flags&USB_DEVICE_ID_MATCH_DEV_PROTOCOL,
-	    id->bDeviceProtocol);
-	ADD(alias, "ic",
-	    id->match_flags&USB_DEVICE_ID_MATCH_INT_CLASS,
-	    id->bInterfaceClass);
-	ADD(alias, "isc",
-	    id->match_flags&USB_DEVICE_ID_MATCH_INT_SUBCLASS,
-	    id->bInterfaceSubClass);
-	ADD(alias, "ip",
-	    id->match_flags&USB_DEVICE_ID_MATCH_INT_PROTOCOL,
-	    id->bInterfaceProtocol);
-	return 1;
-}
-
-/* Looks like: ieee1394:venNmoNspNverN */
-static int do_ieee1394_entry(const char *filename,
-			     struct ieee1394_device_id *id, char *alias)
-{
-	id->match_flags = TO_NATIVE(id->match_flags);
-	id->vendor_id = TO_NATIVE(id->vendor_id);
-	id->model_id = TO_NATIVE(id->model_id);
-	id->specifier_id = TO_NATIVE(id->specifier_id);
-	id->version = TO_NATIVE(id->version);
-
-	strcpy(alias, "ieee1394:");
-	ADD(alias, "ven", id->match_flags & IEEE1394_MATCH_VENDOR_ID,
-	    id->vendor_id);
-	ADD(alias, "mo", id->match_flags & IEEE1394_MATCH_MODEL_ID,
-	    id->model_id);
-	ADD(alias, "sp", id->match_flags & IEEE1394_MATCH_SPECIFIER_ID,
-	    id->specifier_id);
-	ADD(alias, "ver", id->match_flags & IEEE1394_MATCH_VERSION,
-	    id->version);
-
-	return 1;
-}
-
-/* Looks like: pci:vNdNsvNsdNbcNscNiN. */
-static int do_pci_entry(const char *filename,
-			struct pci_device_id *id, char *alias)
-{
-	/* Class field can be divided into these three. */
-	unsigned char baseclass, subclass, interface,
-		baseclass_mask, subclass_mask, interface_mask;
-
-	id->vendor = TO_NATIVE(id->vendor);
-	id->device = TO_NATIVE(id->device);
-	id->subvendor = TO_NATIVE(id->subvendor);
-	id->subdevice = TO_NATIVE(id->subdevice);
-	id->class = TO_NATIVE(id->class);
-	id->class_mask = TO_NATIVE(id->class_mask);
-
-	strcpy(alias, "pci:");
-	ADD(alias, "v", id->vendor != PCI_ANY_ID, id->vendor);
-	ADD(alias, "d", id->device != PCI_ANY_ID, id->device);
-	ADD(alias, "sv", id->subvendor != PCI_ANY_ID, id->subvendor);
-	ADD(alias, "sd", id->subdevice != PCI_ANY_ID, id->subdevice);
-
-	baseclass = (id->class) >> 16;
-	baseclass_mask = (id->class_mask) >> 16;
-	subclass = (id->class) >> 8;
-	subclass_mask = (id->class_mask) >> 8;
-	interface = id->class;
-	interface_mask = id->class_mask;
-
-	if ((baseclass_mask != 0 && baseclass_mask != 0xFF)
-	    || (subclass_mask != 0 && subclass_mask != 0xFF)
-	    || (interface_mask != 0 && interface_mask != 0xFF)) {
-		fprintf(stderr,
-			"*** Warning: Can't handle masks in %s:%04X\n",
-			filename, id->class_mask);
-		return 0;
-	}
-
-	ADD(alias, "bc", baseclass_mask == 0xFF, baseclass);
-	ADD(alias, "sc", subclass_mask == 0xFF, subclass);
-	ADD(alias, "i", interface_mask == 0xFF, interface);
-	return 1;
-}
-
-/* looks like: "ccw:tNmNdtNdmN" */ 
-static int do_ccw_entry(const char *filename,
-			struct ccw_device_id *id, char *alias)
-{
-	id->match_flags = TO_NATIVE(id->match_flags);
-	id->cu_type = TO_NATIVE(id->cu_type);
-	id->cu_model = TO_NATIVE(id->cu_model);
-	id->dev_type = TO_NATIVE(id->dev_type);
-	id->dev_model = TO_NATIVE(id->dev_model);
-
-	strcpy(alias, "ccw:");
-	ADD(alias, "t", id->match_flags&CCW_DEVICE_ID_MATCH_CU_TYPE,
-	    id->cu_type);
-	ADD(alias, "m", id->match_flags&CCW_DEVICE_ID_MATCH_CU_MODEL,
-	    id->cu_model);
-	ADD(alias, "dt", id->match_flags&CCW_DEVICE_ID_MATCH_DEVICE_TYPE,
-	    id->dev_type);
-	ADD(alias, "dm", id->match_flags&CCW_DEVICE_ID_MATCH_DEVICE_TYPE,
-	    id->dev_model);
-	return 1;
-}
-
-/* looks like: "pnp:dD" */
-static int do_pnp_entry(const char *filename,
-			struct pnp_device_id *id, char *alias)
-{
-	sprintf(alias, "pnp:d%s", id->id);
-	return 1;
-}
-
-/* looks like: "pnp:cCdD..." */
-static int do_pnp_card_entry(const char *filename,
-			struct pnp_card_device_id *id, char *alias)
-{
-	int i;
-
-	sprintf(alias, "pnp:c%s", id->id);
-	for (i = 0; i < PNP_MAX_DEVICES; i++) {
-		if (! *id->devs[i].id)
-			break;
-		sprintf(alias + strlen(alias), "d%s", id->devs[i].id);
-	}
-	return 1;
-}
-
-/* Ignore any prefix, eg. v850 prepends _ */
-static inline int sym_is(const char *symbol, const char *name)
-{
-	const char *match;
-
-	match = strstr(symbol, name);
-	if (!match)
-		return 0;
-	return match[strlen(symbol)] == '\0';
-}
-
-static void do_table(void *symval, unsigned long size,
-		     unsigned long id_size,
-		     void *function,
-		     struct module *mod)
-{
-	unsigned int i;
-	char alias[500];
-	int (*do_entry)(const char *, void *entry, char *alias) = function;
-
-	if (size % id_size || size < id_size) {
-		fprintf(stderr, "*** Warning: %s ids %lu bad size "
-			"(each on %lu)\n", mod->name, size, id_size);
-	}
-	/* Leave last one: it's the terminator. */
-	size -= id_size;
-
-	for (i = 0; i < size; i += id_size) {
-		if (do_entry(mod->name, symval+i, alias)) {
-			/* Always end in a wildcard, for future extension */
-			if (alias[strlen(alias)-1] != '*')
-				strcat(alias, "*");
-			buf_printf(&mod->dev_table_buf,
-				   "MODULE_ALIAS(\"%s\");\n", alias);
-		}
-	}
-}
-
-/* Create MODULE_ALIAS() statements.
- * At this time, we cannot write the actual output C source yet,
- * so we write into the mod->dev_table_buf buffer. */
-void handle_moddevtable(struct module *mod, struct elf_info *info,
-			Elf_Sym *sym, const char *symname)
-{
-	void *symval;
-
-	/* We're looking for a section relative symbol */
-	if (!sym->st_shndx || sym->st_shndx >= info->hdr->e_shnum)
-		return;
-
-	symval = (void *)info->hdr
-		+ info->sechdrs[sym->st_shndx].sh_offset
-		+ sym->st_value;
-
-	if (sym_is(symname, "__mod_pci_device_table"))
-		do_table(symval, sym->st_size, sizeof(struct pci_device_id),
-			 do_pci_entry, mod);
-	else if (sym_is(symname, "__mod_usb_device_table"))
-		do_table(symval, sym->st_size, sizeof(struct usb_device_id),
-			 do_usb_entry, mod);
-	else if (sym_is(symname, "__mod_ieee1394_device_table"))
-		do_table(symval, sym->st_size, sizeof(struct ieee1394_device_id),
-			 do_ieee1394_entry, mod);
-	else if (sym_is(symname, "__mod_ccw_device_table"))
-		do_table(symval, sym->st_size, sizeof(struct ccw_device_id),
-			 do_ccw_entry, mod);
-	else if (sym_is(symname, "__mod_pnp_device_table"))
-		do_table(symval, sym->st_size, sizeof(struct pnp_device_id),
-			 do_pnp_entry, mod);
-	else if (sym_is(symname, "__mod_pnp_card_device_table"))
-		do_table(symval, sym->st_size, sizeof(struct pnp_card_device_id),
-			 do_pnp_card_entry, mod);
-}
-
-/* Now add out buffered information to the generated C source */
-void add_moddevtable(struct buffer *buf, struct module *mod)
-{
-	buf_printf(buf, "\n");
-	buf_write(buf, mod->dev_table_buf.p, mod->dev_table_buf.pos);
-	free(mod->dev_table_buf.p);
-}
diff -urN linux-2.6.8-rc2/scripts/mk_elfconfig.c linux-mv/scripts/mk_elfconfig.c
--- linux-2.6.8-rc2/scripts/mk_elfconfig.c	2004-06-23 18:06:18.000000000 -0400
+++ linux-mv/scripts/mk_elfconfig.c	1969-12-31 19:00:00.000000000 -0500
@@ -1,65 +0,0 @@
-#include <stdio.h>
-#include <stdlib.h>
-#include <string.h>
-#include <elf.h>
-
-int
-main(int argc, char **argv)
-{
-	unsigned char ei[EI_NIDENT];	
-	union { short s; char c[2]; } endian_test;
-
-	if (argc != 2) {
-		fprintf(stderr, "Error: no arch\n");
-	}
-	if (fread(ei, 1, EI_NIDENT, stdin) != EI_NIDENT) {
-		fprintf(stderr, "Error: input truncated\n");
-		return 1;
-	}
-	if (memcmp(ei, ELFMAG, SELFMAG) != 0) {
-		fprintf(stderr, "Error: not ELF\n");
-		return 1;
-	}
-	switch (ei[EI_CLASS]) {
-	case ELFCLASS32:
-		printf("#define KERNEL_ELFCLASS ELFCLASS32\n");
-		break;
-	case ELFCLASS64:
-		printf("#define KERNEL_ELFCLASS ELFCLASS64\n");
-		break;
-	default:
-		abort();
-	}
-	switch (ei[EI_DATA]) {
-	case ELFDATA2LSB:
-		printf("#define KERNEL_ELFDATA ELFDATA2LSB\n");
-		break;
-	case ELFDATA2MSB:
-		printf("#define KERNEL_ELFDATA ELFDATA2MSB\n");
-		break;
-	default:
-		abort();
-	}
-
-	if (sizeof(unsigned long) == 4) {
-		printf("#define HOST_ELFCLASS ELFCLASS32\n");
-	} else if (sizeof(unsigned long) == 8) {
-		printf("#define HOST_ELFCLASS ELFCLASS64\n");
-	}
-
-	endian_test.s = 0x0102;
-	if (memcmp(endian_test.c, "\x01\x02", 2) == 0)
-		printf("#define HOST_ELFDATA ELFDATA2MSB\n");
-	else if (memcmp(endian_test.c, "\x02\x01", 2) == 0)
-		printf("#define HOST_ELFDATA ELFDATA2LSB\n");
-	else
-		abort();
-
-	if ((strcmp(argv[1], "v850") == 0) || (strcmp(argv[1], "h8300") == 0))
-		printf("#define MODULE_SYMBOL_PREFIX \"_\"\n");
-	else 
-		printf("#define MODULE_SYMBOL_PREFIX \"\"\n");
-
-	return 0;
-}
-
diff -urN linux-2.6.8-rc2/scripts/modpost/empty.c linux-mv/scripts/modpost/empty.c
--- linux-2.6.8-rc2/scripts/modpost/empty.c	1969-12-31 19:00:00.000000000 -0500
+++ linux-mv/scripts/modpost/empty.c	2003-12-17 21:59:45.000000000 -0500
@@ -0,0 +1 @@
+/* empty file to figure out endianness / word size */
diff -urN linux-2.6.8-rc2/scripts/modpost/file2alias.c linux-mv/scripts/modpost/file2alias.c
--- linux-2.6.8-rc2/scripts/modpost/file2alias.c	1969-12-31 19:00:00.000000000 -0500
+++ linux-mv/scripts/modpost/file2alias.c	2004-06-23 18:05:42.000000000 -0400
@@ -0,0 +1,282 @@
+/* Simple code to turn various tables in an ELF file into alias definitions.
+ * This deals with kernel datastructures where they should be
+ * dealt with: in the kernel source.
+ *
+ * Copyright 2002-2003  Rusty Russell, IBM Corporation
+ *           2003       Kai Germaschewski
+ *           
+ *
+ * This software may be used and distributed according to the terms
+ * of the GNU General Public License, incorporated herein by reference.
+ */
+
+#include "modpost.h"
+
+/* We use the ELF typedefs, since we can't rely on stdint.h being present. */
+
+#if KERNEL_ELFCLASS == ELFCLASS32
+typedef Elf32_Addr     kernel_ulong_t;
+#else
+typedef Elf64_Addr     kernel_ulong_t;
+#endif
+
+typedef Elf32_Word     __u32;
+typedef Elf32_Half     __u16;
+typedef unsigned char  __u8;
+
+/* Big exception to the "don't include kernel headers into userspace, which
+ * even potentially has different endianness and word sizes, since 
+ * we handle those differences explicitly below */
+#include "../include/linux/mod_devicetable.h"
+
+#define ADD(str, sep, cond, field)                              \
+do {                                                            \
+        strcat(str, sep);                                       \
+        if (cond)                                               \
+                sprintf(str + strlen(str),                      \
+                        sizeof(field) == 1 ? "%02X" :           \
+                        sizeof(field) == 2 ? "%04X" :           \
+                        sizeof(field) == 4 ? "%08X" : "",       \
+                        field);                                 \
+        else                                                    \
+                sprintf(str + strlen(str), "*");                \
+} while(0)
+
+/* Looks like "usb:vNpNdlNdhNdcNdscNdpNicNiscNipN" */
+static int do_usb_entry(const char *filename,
+			struct usb_device_id *id, char *alias)
+{
+	id->match_flags = TO_NATIVE(id->match_flags);
+	id->idVendor = TO_NATIVE(id->idVendor);
+	id->idProduct = TO_NATIVE(id->idProduct);
+	id->bcdDevice_lo = TO_NATIVE(id->bcdDevice_lo);
+	id->bcdDevice_hi = TO_NATIVE(id->bcdDevice_hi);
+
+	/*
+	 * Some modules (visor) have empty slots as placeholder for
+	 * run-time specification that results in catch-all alias
+	 */
+	if (!(id->idVendor | id->bDeviceClass | id->bInterfaceClass))
+		return 1;
+
+	strcpy(alias, "usb:");
+	ADD(alias, "v", id->match_flags&USB_DEVICE_ID_MATCH_VENDOR,
+	    id->idVendor);
+	ADD(alias, "p", id->match_flags&USB_DEVICE_ID_MATCH_PRODUCT,
+	    id->idProduct);
+	ADD(alias, "dl", id->match_flags&USB_DEVICE_ID_MATCH_DEV_LO,
+	    id->bcdDevice_lo);
+	ADD(alias, "dh", id->match_flags&USB_DEVICE_ID_MATCH_DEV_HI,
+	    id->bcdDevice_hi);
+	ADD(alias, "dc", id->match_flags&USB_DEVICE_ID_MATCH_DEV_CLASS,
+	    id->bDeviceClass);
+	ADD(alias, "dsc",
+	    id->match_flags&USB_DEVICE_ID_MATCH_DEV_SUBCLASS,
+	    id->bDeviceSubClass);
+	ADD(alias, "dp",
+	    id->match_flags&USB_DEVICE_ID_MATCH_DEV_PROTOCOL,
+	    id->bDeviceProtocol);
+	ADD(alias, "ic",
+	    id->match_flags&USB_DEVICE_ID_MATCH_INT_CLASS,
+	    id->bInterfaceClass);
+	ADD(alias, "isc",
+	    id->match_flags&USB_DEVICE_ID_MATCH_INT_SUBCLASS,
+	    id->bInterfaceSubClass);
+	ADD(alias, "ip",
+	    id->match_flags&USB_DEVICE_ID_MATCH_INT_PROTOCOL,
+	    id->bInterfaceProtocol);
+	return 1;
+}
+
+/* Looks like: ieee1394:venNmoNspNverN */
+static int do_ieee1394_entry(const char *filename,
+			     struct ieee1394_device_id *id, char *alias)
+{
+	id->match_flags = TO_NATIVE(id->match_flags);
+	id->vendor_id = TO_NATIVE(id->vendor_id);
+	id->model_id = TO_NATIVE(id->model_id);
+	id->specifier_id = TO_NATIVE(id->specifier_id);
+	id->version = TO_NATIVE(id->version);
+
+	strcpy(alias, "ieee1394:");
+	ADD(alias, "ven", id->match_flags & IEEE1394_MATCH_VENDOR_ID,
+	    id->vendor_id);
+	ADD(alias, "mo", id->match_flags & IEEE1394_MATCH_MODEL_ID,
+	    id->model_id);
+	ADD(alias, "sp", id->match_flags & IEEE1394_MATCH_SPECIFIER_ID,
+	    id->specifier_id);
+	ADD(alias, "ver", id->match_flags & IEEE1394_MATCH_VERSION,
+	    id->version);
+
+	return 1;
+}
+
+/* Looks like: pci:vNdNsvNsdNbcNscNiN. */
+static int do_pci_entry(const char *filename,
+			struct pci_device_id *id, char *alias)
+{
+	/* Class field can be divided into these three. */
+	unsigned char baseclass, subclass, interface,
+		baseclass_mask, subclass_mask, interface_mask;
+
+	id->vendor = TO_NATIVE(id->vendor);
+	id->device = TO_NATIVE(id->device);
+	id->subvendor = TO_NATIVE(id->subvendor);
+	id->subdevice = TO_NATIVE(id->subdevice);
+	id->class = TO_NATIVE(id->class);
+	id->class_mask = TO_NATIVE(id->class_mask);
+
+	strcpy(alias, "pci:");
+	ADD(alias, "v", id->vendor != PCI_ANY_ID, id->vendor);
+	ADD(alias, "d", id->device != PCI_ANY_ID, id->device);
+	ADD(alias, "sv", id->subvendor != PCI_ANY_ID, id->subvendor);
+	ADD(alias, "sd", id->subdevice != PCI_ANY_ID, id->subdevice);
+
+	baseclass = (id->class) >> 16;
+	baseclass_mask = (id->class_mask) >> 16;
+	subclass = (id->class) >> 8;
+	subclass_mask = (id->class_mask) >> 8;
+	interface = id->class;
+	interface_mask = id->class_mask;
+
+	if ((baseclass_mask != 0 && baseclass_mask != 0xFF)
+	    || (subclass_mask != 0 && subclass_mask != 0xFF)
+	    || (interface_mask != 0 && interface_mask != 0xFF)) {
+		fprintf(stderr,
+			"*** Warning: Can't handle masks in %s:%04X\n",
+			filename, id->class_mask);
+		return 0;
+	}
+
+	ADD(alias, "bc", baseclass_mask == 0xFF, baseclass);
+	ADD(alias, "sc", subclass_mask == 0xFF, subclass);
+	ADD(alias, "i", interface_mask == 0xFF, interface);
+	return 1;
+}
+
+/* looks like: "ccw:tNmNdtNdmN" */ 
+static int do_ccw_entry(const char *filename,
+			struct ccw_device_id *id, char *alias)
+{
+	id->match_flags = TO_NATIVE(id->match_flags);
+	id->cu_type = TO_NATIVE(id->cu_type);
+	id->cu_model = TO_NATIVE(id->cu_model);
+	id->dev_type = TO_NATIVE(id->dev_type);
+	id->dev_model = TO_NATIVE(id->dev_model);
+
+	strcpy(alias, "ccw:");
+	ADD(alias, "t", id->match_flags&CCW_DEVICE_ID_MATCH_CU_TYPE,
+	    id->cu_type);
+	ADD(alias, "m", id->match_flags&CCW_DEVICE_ID_MATCH_CU_MODEL,
+	    id->cu_model);
+	ADD(alias, "dt", id->match_flags&CCW_DEVICE_ID_MATCH_DEVICE_TYPE,
+	    id->dev_type);
+	ADD(alias, "dm", id->match_flags&CCW_DEVICE_ID_MATCH_DEVICE_TYPE,
+	    id->dev_model);
+	return 1;
+}
+
+/* looks like: "pnp:dD" */
+static int do_pnp_entry(const char *filename,
+			struct pnp_device_id *id, char *alias)
+{
+	sprintf(alias, "pnp:d%s", id->id);
+	return 1;
+}
+
+/* looks like: "pnp:cCdD..." */
+static int do_pnp_card_entry(const char *filename,
+			struct pnp_card_device_id *id, char *alias)
+{
+	int i;
+
+	sprintf(alias, "pnp:c%s", id->id);
+	for (i = 0; i < PNP_MAX_DEVICES; i++) {
+		if (! *id->devs[i].id)
+			break;
+		sprintf(alias + strlen(alias), "d%s", id->devs[i].id);
+	}
+	return 1;
+}
+
+/* Ignore any prefix, eg. v850 prepends _ */
+static inline int sym_is(const char *symbol, const char *name)
+{
+	const char *match;
+
+	match = strstr(symbol, name);
+	if (!match)
+		return 0;
+	return match[strlen(symbol)] == '\0';
+}
+
+static void do_table(void *symval, unsigned long size,
+		     unsigned long id_size,
+		     void *function,
+		     struct module *mod)
+{
+	unsigned int i;
+	char alias[500];
+	int (*do_entry)(const char *, void *entry, char *alias) = function;
+
+	if (size % id_size || size < id_size) {
+		fprintf(stderr, "*** Warning: %s ids %lu bad size "
+			"(each on %lu)\n", mod->name, size, id_size);
+	}
+	/* Leave last one: it's the terminator. */
+	size -= id_size;
+
+	for (i = 0; i < size; i += id_size) {
+		if (do_entry(mod->name, symval+i, alias)) {
+			/* Always end in a wildcard, for future extension */
+			if (alias[strlen(alias)-1] != '*')
+				strcat(alias, "*");
+			buf_printf(&mod->dev_table_buf,
+				   "MODULE_ALIAS(\"%s\");\n", alias);
+		}
+	}
+}
+
+/* Create MODULE_ALIAS() statements.
+ * At this time, we cannot write the actual output C source yet,
+ * so we write into the mod->dev_table_buf buffer. */
+void handle_moddevtable(struct module *mod, struct elf_info *info,
+			Elf_Sym *sym, const char *symname)
+{
+	void *symval;
+
+	/* We're looking for a section relative symbol */
+	if (!sym->st_shndx || sym->st_shndx >= info->hdr->e_shnum)
+		return;
+
+	symval = (void *)info->hdr
+		+ info->sechdrs[sym->st_shndx].sh_offset
+		+ sym->st_value;
+
+	if (sym_is(symname, "__mod_pci_device_table"))
+		do_table(symval, sym->st_size, sizeof(struct pci_device_id),
+			 do_pci_entry, mod);
+	else if (sym_is(symname, "__mod_usb_device_table"))
+		do_table(symval, sym->st_size, sizeof(struct usb_device_id),
+			 do_usb_entry, mod);
+	else if (sym_is(symname, "__mod_ieee1394_device_table"))
+		do_table(symval, sym->st_size, sizeof(struct ieee1394_device_id),
+			 do_ieee1394_entry, mod);
+	else if (sym_is(symname, "__mod_ccw_device_table"))
+		do_table(symval, sym->st_size, sizeof(struct ccw_device_id),
+			 do_ccw_entry, mod);
+	else if (sym_is(symname, "__mod_pnp_device_table"))
+		do_table(symval, sym->st_size, sizeof(struct pnp_device_id),
+			 do_pnp_entry, mod);
+	else if (sym_is(symname, "__mod_pnp_card_device_table"))
+		do_table(symval, sym->st_size, sizeof(struct pnp_card_device_id),
+			 do_pnp_card_entry, mod);
+}
+
+/* Now add out buffered information to the generated C source */
+void add_moddevtable(struct buffer *buf, struct module *mod)
+{
+	buf_printf(buf, "\n");
+	buf_write(buf, mod->dev_table_buf.p, mod->dev_table_buf.pos);
+	free(mod->dev_table_buf.p);
+}
diff -urN linux-2.6.8-rc2/scripts/modpost/mk_elfconfig.c linux-mv/scripts/modpost/mk_elfconfig.c
--- linux-2.6.8-rc2/scripts/modpost/mk_elfconfig.c	1969-12-31 19:00:00.000000000 -0500
+++ linux-mv/scripts/modpost/mk_elfconfig.c	2004-06-23 18:06:18.000000000 -0400
@@ -0,0 +1,65 @@
+#include <stdio.h>
+#include <stdlib.h>
+#include <string.h>
+#include <elf.h>
+
+int
+main(int argc, char **argv)
+{
+	unsigned char ei[EI_NIDENT];	
+	union { short s; char c[2]; } endian_test;
+
+	if (argc != 2) {
+		fprintf(stderr, "Error: no arch\n");
+	}
+	if (fread(ei, 1, EI_NIDENT, stdin) != EI_NIDENT) {
+		fprintf(stderr, "Error: input truncated\n");
+		return 1;
+	}
+	if (memcmp(ei, ELFMAG, SELFMAG) != 0) {
+		fprintf(stderr, "Error: not ELF\n");
+		return 1;
+	}
+	switch (ei[EI_CLASS]) {
+	case ELFCLASS32:
+		printf("#define KERNEL_ELFCLASS ELFCLASS32\n");
+		break;
+	case ELFCLASS64:
+		printf("#define KERNEL_ELFCLASS ELFCLASS64\n");
+		break;
+	default:
+		abort();
+	}
+	switch (ei[EI_DATA]) {
+	case ELFDATA2LSB:
+		printf("#define KERNEL_ELFDATA ELFDATA2LSB\n");
+		break;
+	case ELFDATA2MSB:
+		printf("#define KERNEL_ELFDATA ELFDATA2MSB\n");
+		break;
+	default:
+		abort();
+	}
+
+	if (sizeof(unsigned long) == 4) {
+		printf("#define HOST_ELFCLASS ELFCLASS32\n");
+	} else if (sizeof(unsigned long) == 8) {
+		printf("#define HOST_ELFCLASS ELFCLASS64\n");
+	}
+
+	endian_test.s = 0x0102;
+	if (memcmp(endian_test.c, "\x01\x02", 2) == 0)
+		printf("#define HOST_ELFDATA ELFDATA2MSB\n");
+	else if (memcmp(endian_test.c, "\x02\x01", 2) == 0)
+		printf("#define HOST_ELFDATA ELFDATA2LSB\n");
+	else
+		abort();
+
+	if ((strcmp(argv[1], "v850") == 0) || (strcmp(argv[1], "h8300") == 0))
+		printf("#define MODULE_SYMBOL_PREFIX \"_\"\n");
+	else 
+		printf("#define MODULE_SYMBOL_PREFIX \"\"\n");
+
+	return 0;
+}
+
diff -urN linux-2.6.8-rc2/scripts/modpost/modpost.c linux-mv/scripts/modpost/modpost.c
--- linux-2.6.8-rc2/scripts/modpost/modpost.c	1969-12-31 19:00:00.000000000 -0500
+++ linux-mv/scripts/modpost/modpost.c	2004-06-23 18:06:18.000000000 -0400
@@ -0,0 +1,739 @@
+/* Postprocess module symbol versions
+ *
+ * Copyright 2003       Kai Germaschewski
+ *           2002-2003  Rusty Russell, IBM Corporation
+ *
+ * Based in part on module-init-tools/depmod.c,file2alias
+ *
+ * This software may be used and distributed according to the terms
+ * of the GNU General Public License, incorporated herein by reference.
+ *
+ * Usage: modpost vmlinux module1.o module2.o ...
+ */
+
+#include <ctype.h>
+#include "modpost.h"
+
+/* Are we using CONFIG_MODVERSIONS? */
+int modversions = 0;
+/* Warn about undefined symbols? (do so if we have vmlinux) */
+int have_vmlinux = 0;
+
+void
+fatal(const char *fmt, ...)
+{
+	va_list arglist;
+
+	fprintf(stderr, "FATAL: ");
+
+	va_start(arglist, fmt);
+	vfprintf(stderr, fmt, arglist);
+	va_end(arglist);
+
+	exit(1);
+}
+
+void
+warn(const char *fmt, ...)
+{
+	va_list arglist;
+
+	fprintf(stderr, "WARNING: ");
+
+	va_start(arglist, fmt);
+	vfprintf(stderr, fmt, arglist);
+	va_end(arglist);
+}
+
+void *do_nofail(void *ptr, const char *file, int line, const char *expr)
+{
+	if (!ptr) {
+		fatal("Memory allocation failure %s line %d: %s.\n",
+		      file, line, expr);
+	}
+	return ptr;
+}
+
+/* A list of all modules we processed */
+
+static struct module *modules;
+
+struct module *
+find_module(char *modname)
+{
+	struct module *mod;
+
+	for (mod = modules; mod; mod = mod->next)
+		if (strcmp(mod->name, modname) == 0)
+			break;
+	return mod;
+}
+
+struct module *
+new_module(char *modname)
+{
+	struct module *mod;
+	char *p, *s;
+	
+	mod = NOFAIL(malloc(sizeof(*mod)));
+	memset(mod, 0, sizeof(*mod));
+	p = NOFAIL(strdup(modname));
+
+	/* strip trailing .o */
+	if ((s = strrchr(p, '.')) != NULL)
+		if (strcmp(s, ".o") == 0)
+			*s = '\0';
+
+	/* add to list */
+	mod->name = p;
+	mod->next = modules;
+	modules = mod;
+
+	return mod;
+}
+
+/* A hash of all exported symbols,
+ * struct symbol is also used for lists of unresolved symbols */
+
+#define SYMBOL_HASH_SIZE 1024
+
+struct symbol {
+	struct symbol *next;
+	struct module *module;
+	unsigned int crc;
+	int crc_valid;
+	char name[0];
+};
+
+static struct symbol *symbolhash[SYMBOL_HASH_SIZE];
+
+/* This is based on the hash agorithm from gdbm, via tdb */
+static inline unsigned int tdb_hash(const char *name)
+{
+	unsigned value;	/* Used to compute the hash value.  */
+	unsigned   i;	/* Used to cycle through random values. */
+
+	/* Set the initial value from the key size. */
+	for (value = 0x238F13AF * strlen(name), i=0; name[i]; i++)
+		value = (value + (((unsigned char *)name)[i] << (i*5 % 24)));
+
+	return (1103515243 * value + 12345);
+}
+
+/* Allocate a new symbols for use in the hash of exported symbols or
+ * the list of unresolved symbols per module */
+
+struct symbol *
+alloc_symbol(const char *name, struct symbol *next)
+{
+	struct symbol *s = NOFAIL(malloc(sizeof(*s) + strlen(name) + 1));
+
+	memset(s, 0, sizeof(*s));
+	strcpy(s->name, name);
+	s->next = next;
+	return s;
+}
+
+/* For the hash of exported symbols */
+
+void
+new_symbol(const char *name, struct module *module, unsigned int *crc)
+{
+	unsigned int hash;
+	struct symbol *new;
+
+	hash = tdb_hash(name) % SYMBOL_HASH_SIZE;
+	new = symbolhash[hash] = alloc_symbol(name, symbolhash[hash]);
+	new->module = module;
+	if (crc) {
+		new->crc = *crc;
+		new->crc_valid = 1;
+	}
+}
+
+struct symbol *
+find_symbol(const char *name)
+{
+	struct symbol *s;
+
+	/* For our purposes, .foo matches foo.  PPC64 needs this. */
+	if (name[0] == '.')
+		name++;
+
+	for (s = symbolhash[tdb_hash(name) % SYMBOL_HASH_SIZE]; s; s=s->next) {
+		if (strcmp(s->name, name) == 0)
+			return s;
+	}
+	return NULL;
+}
+
+/* Add an exported symbol - it may have already been added without a
+ * CRC, in this case just update the CRC */
+void
+add_exported_symbol(const char *name, struct module *module, unsigned int *crc)
+{
+	struct symbol *s = find_symbol(name);
+
+	if (!s) {
+		new_symbol(name, module, crc);
+		return;
+	}
+	if (crc) {
+		s->crc = *crc;
+		s->crc_valid = 1;
+	}
+}
+
+void *
+grab_file(const char *filename, unsigned long *size)
+{
+	struct stat st;
+	void *map;
+	int fd;
+
+	fd = open(filename, O_RDONLY);
+	if (fd < 0 || fstat(fd, &st) != 0)
+		return NULL;
+
+	*size = st.st_size;
+	map = mmap(NULL, *size, PROT_READ|PROT_WRITE, MAP_PRIVATE, fd, 0);
+	close(fd);
+
+	if (map == MAP_FAILED)
+		return NULL;
+	return map;
+}
+
+/*
+   Return a copy of the next line in a mmap'ed file.
+   spaces in the beginning of the line is trimmed away.
+   Return a pointer to a static buffer.
+*/
+char*
+get_next_line(unsigned long *pos, void *file, unsigned long size)
+{
+	static char line[4096];
+	int skip = 1;
+	size_t len = 0;
+	char *p = (char *)file + *pos;
+	char *s = line;
+
+	for (; *pos < size ; (*pos)++)
+	{
+		if (skip && isspace(*p)) {
+			p++;
+			continue;
+		}
+		skip = 0;
+		if (*p != '\n' && (*pos < size)) {
+			len++;
+			*s++ = *p++;
+			if (len > 4095)
+				break; /* Too long, stop */
+		} else {
+			/* End of string */
+			*s = '\0';
+			return line;
+		}
+	}
+	/* End of buffer */
+	return NULL;
+}
+
+void
+release_file(void *file, unsigned long size)
+{
+	munmap(file, size);
+}
+
+void
+parse_elf(struct elf_info *info, const char *filename)
+{
+	unsigned int i;
+	Elf_Ehdr *hdr = info->hdr;
+	Elf_Shdr *sechdrs;
+	Elf_Sym  *sym;
+
+	hdr = grab_file(filename, &info->size);
+	if (!hdr) {
+		perror(filename);
+		abort();
+	}
+	info->hdr = hdr;
+	if (info->size < sizeof(*hdr))
+		goto truncated;
+
+	/* Fix endianness in ELF header */
+	hdr->e_shoff    = TO_NATIVE(hdr->e_shoff);
+	hdr->e_shstrndx = TO_NATIVE(hdr->e_shstrndx);
+	hdr->e_shnum    = TO_NATIVE(hdr->e_shnum);
+	hdr->e_machine  = TO_NATIVE(hdr->e_machine);
+	sechdrs = (void *)hdr + hdr->e_shoff;
+	info->sechdrs = sechdrs;
+
+	/* Fix endianness in section headers */
+	for (i = 0; i < hdr->e_shnum; i++) {
+		sechdrs[i].sh_type   = TO_NATIVE(sechdrs[i].sh_type);
+		sechdrs[i].sh_offset = TO_NATIVE(sechdrs[i].sh_offset);
+		sechdrs[i].sh_size   = TO_NATIVE(sechdrs[i].sh_size);
+		sechdrs[i].sh_link   = TO_NATIVE(sechdrs[i].sh_link);
+		sechdrs[i].sh_name   = TO_NATIVE(sechdrs[i].sh_name);
+	}
+	/* Find symbol table. */
+	for (i = 1; i < hdr->e_shnum; i++) {
+		const char *secstrings
+			= (void *)hdr + sechdrs[hdr->e_shstrndx].sh_offset;
+
+		if (sechdrs[i].sh_offset > info->size)
+			goto truncated;
+		if (strcmp(secstrings+sechdrs[i].sh_name, ".modinfo") == 0) {
+			info->modinfo = (void *)hdr + sechdrs[i].sh_offset;
+			info->modinfo_len = sechdrs[i].sh_size;
+		}
+		if (sechdrs[i].sh_type != SHT_SYMTAB)
+			continue;
+
+		info->symtab_start = (void *)hdr + sechdrs[i].sh_offset;
+		info->symtab_stop  = (void *)hdr + sechdrs[i].sh_offset 
+			                         + sechdrs[i].sh_size;
+		info->strtab       = (void *)hdr + 
+			             sechdrs[sechdrs[i].sh_link].sh_offset;
+	}
+	if (!info->symtab_start) {
+		fprintf(stderr, "modpost: %s no symtab?\n", filename);
+		abort();
+	}
+	/* Fix endianness in symbols */
+	for (sym = info->symtab_start; sym < info->symtab_stop; sym++) {
+		sym->st_shndx = TO_NATIVE(sym->st_shndx);
+		sym->st_name  = TO_NATIVE(sym->st_name);
+		sym->st_value = TO_NATIVE(sym->st_value);
+		sym->st_size  = TO_NATIVE(sym->st_size);
+	}
+	return;
+
+ truncated:
+	fprintf(stderr, "modpost: %s is truncated.\n", filename);
+	abort();
+}
+
+void
+parse_elf_finish(struct elf_info *info)
+{
+	release_file(info->hdr, info->size);
+}
+
+#define CRC_PFX     MODULE_SYMBOL_PREFIX "__crc_"
+#define KSYMTAB_PFX MODULE_SYMBOL_PREFIX "__ksymtab_"
+
+void
+handle_modversions(struct module *mod, struct elf_info *info,
+		   Elf_Sym *sym, const char *symname)
+{
+	unsigned int crc;
+
+	switch (sym->st_shndx) {
+	case SHN_COMMON:
+		fprintf(stderr, "*** Warning: \"%s\" [%s] is COMMON symbol\n",
+			symname, mod->name);
+		break;
+	case SHN_ABS:
+		/* CRC'd symbol */
+		if (memcmp(symname, CRC_PFX, strlen(CRC_PFX)) == 0) {
+			crc = (unsigned int) sym->st_value;
+			add_exported_symbol(symname + strlen(CRC_PFX),
+					    mod, &crc);
+			modversions = 1;
+		}
+		break;
+	case SHN_UNDEF:
+		/* undefined symbol */
+		if (ELF_ST_BIND(sym->st_info) != STB_GLOBAL)
+			break;
+		/* ignore global offset table */
+		if (strcmp(symname, "_GLOBAL_OFFSET_TABLE_") == 0)
+			break;
+		/* ignore __this_module, it will be resolved shortly */
+		if (strcmp(symname, MODULE_SYMBOL_PREFIX "__this_module") == 0)
+			break;
+#ifdef STT_REGISTER
+		if (info->hdr->e_machine == EM_SPARC ||
+		    info->hdr->e_machine == EM_SPARCV9) {
+			/* Ignore register directives. */
+			if (ELF_ST_TYPE(sym->st_info) == STT_REGISTER)
+				break;
+		}
+#endif
+		
+		if (memcmp(symname, MODULE_SYMBOL_PREFIX,
+			   strlen(MODULE_SYMBOL_PREFIX)) == 0)
+			mod->unres = alloc_symbol(symname +
+						  strlen(MODULE_SYMBOL_PREFIX),
+						  mod->unres);
+		break;
+	default:
+		/* All exported symbols */
+		if (memcmp(symname, KSYMTAB_PFX, strlen(KSYMTAB_PFX)) == 0) {
+			add_exported_symbol(symname + strlen(KSYMTAB_PFX),
+					    mod, NULL);
+		}
+		break;
+	}
+}
+
+int
+is_vmlinux(const char *modname)
+{
+	const char *myname;
+
+	if ((myname = strrchr(modname, '/')))
+		myname++;
+	else
+		myname = modname;
+
+	return strcmp(myname, "vmlinux") == 0;
+}
+
+void
+read_symbols(char *modname)
+{
+	const char *symname;
+	struct module *mod;
+	struct elf_info info = { };
+	Elf_Sym *sym;
+
+	parse_elf(&info, modname);
+
+	mod = new_module(modname);
+
+	/* When there's no vmlinux, don't print warnings about
+	 * unresolved symbols (since there'll be too many ;) */
+	if (is_vmlinux(modname)) {
+		unsigned int fake_crc = 0;
+		have_vmlinux = 1;
+		/* May not have this if !CONFIG_MODULE_UNLOAD: fake it.
+		   If it appears, we'll get the real CRC. */
+		add_exported_symbol("cleanup_module", mod, &fake_crc);
+		add_exported_symbol("struct_module", mod, &fake_crc);
+		mod->skip = 1;
+	}
+
+	for (sym = info.symtab_start; sym < info.symtab_stop; sym++) {
+		symname = info.strtab + sym->st_name;
+
+		handle_modversions(mod, &info, sym, symname);
+		handle_moddevtable(mod, &info, sym, symname);
+	}
+	maybe_frob_version(modname, info.modinfo, info.modinfo_len,
+			   (void *)info.modinfo - (void *)info.hdr);
+	parse_elf_finish(&info);
+
+	/* Our trick to get versioning for struct_module - it's
+	 * never passed as an argument to an exported function, so
+	 * the automatic versioning doesn't pick it up, but it's really
+	 * important anyhow */
+	if (modversions) {
+		mod->unres = alloc_symbol("struct_module", mod->unres);
+
+		/* Always version init_module and cleanup_module, in
+		 * case module doesn't have its own. */
+		mod->unres = alloc_symbol("init_module", mod->unres);
+		mod->unres = alloc_symbol("cleanup_module", mod->unres);
+	}
+}
+
+#define SZ 500
+
+/* We first write the generated file into memory using the
+ * following helper, then compare to the file on disk and
+ * only update the later if anything changed */
+
+void __attribute__((format(printf, 2, 3)))
+buf_printf(struct buffer *buf, const char *fmt, ...)
+{
+	char tmp[SZ];
+	int len;
+	va_list ap;
+	
+	va_start(ap, fmt);
+	len = vsnprintf(tmp, SZ, fmt, ap);
+	if (buf->size - buf->pos < len + 1) {
+		buf->size += 128;
+		buf->p = realloc(buf->p, buf->size);
+	}
+	strncpy(buf->p + buf->pos, tmp, len + 1);
+	buf->pos += len;
+	va_end(ap);
+}
+
+void
+buf_write(struct buffer *buf, const char *s, int len)
+{
+	if (buf->size - buf->pos < len) {
+		buf->size += len;
+		buf->p = realloc(buf->p, buf->size);
+	}
+	strncpy(buf->p + buf->pos, s, len);
+	buf->pos += len;
+}
+
+/* Header for the generated file */
+
+void
+add_header(struct buffer *b)
+{
+	buf_printf(b, "#include <linux/module.h>\n");
+	buf_printf(b, "#include <linux/vermagic.h>\n");
+	buf_printf(b, "#include <linux/compiler.h>\n");
+	buf_printf(b, "\n");
+	buf_printf(b, "MODULE_INFO(vermagic, VERMAGIC_STRING);\n");
+	buf_printf(b, "\n");
+	buf_printf(b, "#undef unix\n"); /* We have a module called "unix" */
+	buf_printf(b, "struct module __this_module\n");
+	buf_printf(b, "__attribute__((section(\".gnu.linkonce.this_module\"))) = {\n");
+	buf_printf(b, " .name = __stringify(KBUILD_MODNAME),\n");
+	buf_printf(b, " .init = init_module,\n");
+	buf_printf(b, "#ifdef CONFIG_MODULE_UNLOAD\n");
+	buf_printf(b, " .exit = cleanup_module,\n");
+	buf_printf(b, "#endif\n");
+	buf_printf(b, "};\n");
+}
+
+/* Record CRCs for unresolved symbols */
+
+void
+add_versions(struct buffer *b, struct module *mod)
+{
+	struct symbol *s, *exp;
+
+	for (s = mod->unres; s; s = s->next) {
+		exp = find_symbol(s->name);
+		if (!exp || exp->module == mod) {
+			if (have_vmlinux)
+				fprintf(stderr, "*** Warning: \"%s\" [%s.ko] "
+				"undefined!\n",	s->name, mod->name);
+			continue;
+		}
+		s->module = exp->module;
+		s->crc_valid = exp->crc_valid;
+		s->crc = exp->crc;
+	}
+
+	if (!modversions)
+		return;
+
+	buf_printf(b, "\n");
+	buf_printf(b, "static const struct modversion_info ____versions[]\n");
+	buf_printf(b, "__attribute_used__\n");
+	buf_printf(b, "__attribute__((section(\"__versions\"))) = {\n");
+
+	for (s = mod->unres; s; s = s->next) {
+		if (!s->module) {
+			continue;
+		}
+		if (!s->crc_valid) {
+			fprintf(stderr, "*** Warning: \"%s\" [%s.ko] "
+				"has no CRC!\n",
+				s->name, mod->name);
+			continue;
+		}
+		buf_printf(b, "\t{ %#8x, \"%s\" },\n", s->crc, s->name);
+	}
+
+	buf_printf(b, "};\n");
+}
+
+void
+add_depends(struct buffer *b, struct module *mod, struct module *modules)
+{
+	struct symbol *s;
+	struct module *m;
+	int first = 1;
+
+	for (m = modules; m; m = m->next) {
+		m->seen = is_vmlinux(m->name);
+	}
+
+	buf_printf(b, "\n");
+	buf_printf(b, "static const char __module_depends[]\n");
+	buf_printf(b, "__attribute_used__\n");
+	buf_printf(b, "__attribute__((section(\".modinfo\"))) =\n");
+	buf_printf(b, "\"depends=");
+	for (s = mod->unres; s; s = s->next) {
+		if (!s->module)
+			continue;
+
+		if (s->module->seen)
+			continue;
+
+		s->module->seen = 1;
+		buf_printf(b, "%s%s", first ? "" : ",",
+			   strrchr(s->module->name, '/') + 1);
+		first = 0;
+	}
+	buf_printf(b, "\";\n");
+}
+
+void
+write_if_changed(struct buffer *b, const char *fname)
+{
+	char *tmp;
+	FILE *file;
+	struct stat st;
+
+	file = fopen(fname, "r");
+	if (!file)
+		goto write;
+
+	if (fstat(fileno(file), &st) < 0)
+		goto close_write;
+
+	if (st.st_size != b->pos)
+		goto close_write;
+
+	tmp = NOFAIL(malloc(b->pos));
+	if (fread(tmp, 1, b->pos, file) != b->pos)
+		goto free_write;
+
+	if (memcmp(tmp, b->p, b->pos) != 0)
+		goto free_write;
+
+	free(tmp);
+	fclose(file);
+	return;
+
+ free_write:
+	free(tmp);
+ close_write:
+	fclose(file);
+ write:
+	file = fopen(fname, "w");
+	if (!file) {
+		perror(fname);
+		exit(1);
+	}
+	if (fwrite(b->p, 1, b->pos, file) != b->pos) {
+		perror(fname);
+		exit(1);
+	}
+	fclose(file);
+}
+
+void
+read_dump(const char *fname)
+{
+	unsigned long size, pos = 0;
+	void *file = grab_file(fname, &size);
+	char *line;
+
+        if (!file)
+		/* No symbol versions, silently ignore */
+		return;
+
+	while ((line = get_next_line(&pos, file, size))) {
+		char *symname, *modname, *d;
+		unsigned int crc;
+		struct module *mod;
+
+		if (!(symname = strchr(line, '\t')))
+			goto fail;
+		*symname++ = '\0';
+		if (!(modname = strchr(symname, '\t')))
+			goto fail;
+		*modname++ = '\0';
+		if (strchr(modname, '\t'))
+			goto fail;
+		crc = strtoul(line, &d, 16);
+		if (*symname == '\0' || *modname == '\0' || *d != '\0')
+			goto fail;
+
+		if (!(mod = find_module(modname))) {
+			if (is_vmlinux(modname)) {
+				modversions = 1;
+				have_vmlinux = 1;
+			}
+			mod = new_module(NOFAIL(strdup(modname)));
+			mod->skip = 1;
+		}
+		add_exported_symbol(symname, mod, &crc);
+	}
+	return;
+fail:
+	fatal("parse error in symbol dump file\n");
+}
+
+void
+write_dump(const char *fname)
+{
+	struct buffer buf = { };
+	struct symbol *symbol;
+	int n;
+
+	for (n = 0; n < SYMBOL_HASH_SIZE ; n++) {
+		symbol = symbolhash[n];
+		while (symbol) {
+			symbol = symbol->next;
+		}
+	}
+
+	for (n = 0; n < SYMBOL_HASH_SIZE ; n++) {
+		symbol = symbolhash[n];
+		while (symbol) {
+			buf_printf(&buf, "0x%08x\t%s\t%s\n", symbol->crc,
+				symbol->name, symbol->module->name);
+			symbol = symbol->next;
+		}
+	}
+	write_if_changed(&buf, fname);
+}
+
+int
+main(int argc, char **argv)
+{
+	struct module *mod;
+	struct buffer buf = { };
+	char fname[SZ];
+	char *dump_read = NULL, *dump_write = NULL;
+	int opt;
+
+	while ((opt = getopt(argc, argv, "i:o:")) != -1) {
+		switch(opt) {
+			case 'i':
+				dump_read = optarg;
+				break;
+			case 'o':
+				dump_write = optarg;
+				break;
+			default:
+				exit(1);
+		}
+	}
+
+	if (dump_read)
+		read_dump(dump_read);
+
+	while (optind < argc) {
+		read_symbols(argv[optind++]);
+	}
+
+	for (mod = modules; mod; mod = mod->next) {
+		if (mod->skip)
+			continue;
+
+		buf.pos = 0;
+
+		add_header(&buf);
+		add_versions(&buf, mod);
+		add_depends(&buf, mod, modules);
+		add_moddevtable(&buf, mod);
+
+		sprintf(fname, "%s.mod.c", mod->name);
+		write_if_changed(&buf, fname);
+	}
+
+	if (dump_write)
+		write_dump(dump_write);
+
+	return 0;
+}
+
diff -urN linux-2.6.8-rc2/scripts/modpost/modpost.h linux-mv/scripts/modpost/modpost.h
--- linux-2.6.8-rc2/scripts/modpost/modpost.h	1969-12-31 19:00:00.000000000 -0500
+++ linux-mv/scripts/modpost/modpost.h	2004-06-23 18:06:06.000000000 -0400
@@ -0,0 +1,103 @@
+#include <stdio.h>
+#include <stdlib.h>
+#include <stdarg.h>
+#include <string.h>
+#include <sys/types.h>
+#include <sys/stat.h>
+#include <sys/mman.h>
+#include <fcntl.h>
+#include <unistd.h>
+#include <elf.h>
+
+#include "elfconfig.h"
+
+#if KERNEL_ELFCLASS == ELFCLASS32
+
+#define Elf_Ehdr    Elf32_Ehdr 
+#define Elf_Shdr    Elf32_Shdr 
+#define Elf_Sym     Elf32_Sym
+#define ELF_ST_BIND ELF32_ST_BIND
+#define ELF_ST_TYPE ELF32_ST_TYPE
+
+#else
+
+#define Elf_Ehdr    Elf64_Ehdr 
+#define Elf_Shdr    Elf64_Shdr 
+#define Elf_Sym     Elf64_Sym
+#define ELF_ST_BIND ELF64_ST_BIND
+#define ELF_ST_TYPE ELF64_ST_TYPE
+
+#endif
+
+#if KERNEL_ELFDATA != HOST_ELFDATA
+
+static inline void __endian(const void *src, void *dest, unsigned int size)
+{
+	unsigned int i;
+	for (i = 0; i < size; i++)
+		((unsigned char*)dest)[i] = ((unsigned char*)src)[size - i-1];
+}
+
+
+
+#define TO_NATIVE(x)						\
+({								\
+	typeof(x) __x;						\
+	__endian(&(x), &(__x), sizeof(__x));			\
+	__x;							\
+})
+
+#else /* endianness matches */
+
+#define TO_NATIVE(x) (x)
+
+#endif
+
+#define NOFAIL(ptr)   do_nofail((ptr), __FILE__, __LINE__, #ptr)
+void *do_nofail(void *ptr, const char *file, int line, const char *expr);
+
+struct buffer {
+	char *p;
+	int pos;
+	int size;
+};
+
+void __attribute__((format(printf, 2, 3)))
+buf_printf(struct buffer *buf, const char *fmt, ...);
+
+void
+buf_write(struct buffer *buf, const char *s, int len);
+
+struct module {
+	struct module *next;
+	const char *name;
+	struct symbol *unres;
+	int seen;
+	int skip;
+	struct buffer dev_table_buf;
+};
+
+struct elf_info {
+	unsigned long size;
+	Elf_Ehdr     *hdr;
+	Elf_Shdr     *sechdrs;
+	Elf_Sym      *symtab_start;
+	Elf_Sym      *symtab_stop;
+	const char   *strtab;
+	char	     *modinfo;
+	unsigned int modinfo_len;
+};
+
+void handle_moddevtable(struct module *mod, struct elf_info *info,
+			Elf_Sym *sym, const char *symname);
+
+void add_moddevtable(struct buffer *buf, struct module *mod);
+
+void maybe_frob_version(const char *modfilename,
+			void *modinfo,
+			unsigned long modinfo_len,
+			unsigned long modinfo_offset);
+
+void *grab_file(const char *filename, unsigned long *size);
+char* get_next_line(unsigned long *pos, void *file, unsigned long size);
+void release_file(void *file, unsigned long size);
diff -urN linux-2.6.8-rc2/scripts/modpost/sumversion.c linux-mv/scripts/modpost/sumversion.c
--- linux-2.6.8-rc2/scripts/modpost/sumversion.c	1969-12-31 19:00:00.000000000 -0500
+++ linux-mv/scripts/modpost/sumversion.c	2004-06-23 18:06:18.000000000 -0400
@@ -0,0 +1,544 @@
+#include <netinet/in.h>
+#include <stdint.h>
+#include <ctype.h>
+#include <errno.h>
+#include <string.h>
+#include "modpost.h"
+
+/* Parse tag=value strings from .modinfo section */
+static char *next_string(char *string, unsigned long *secsize)
+{
+	/* Skip non-zero chars */
+	while (string[0]) {
+		string++;
+		if ((*secsize)-- <= 1)
+			return NULL;
+	}
+
+	/* Skip any zero padding. */
+	while (!string[0]) {
+		string++;
+		if ((*secsize)-- <= 1)
+			return NULL;
+	}
+	return string;
+}
+
+static char *get_modinfo(void *modinfo, unsigned long modinfo_len,
+			 const char *tag)
+{
+	char *p;
+	unsigned int taglen = strlen(tag);
+	unsigned long size = modinfo_len;
+
+	for (p = modinfo; p; p = next_string(p, &size)) {
+		if (strncmp(p, tag, taglen) == 0 && p[taglen] == '=')
+			return p + taglen + 1;
+	}
+	return NULL;
+}
+
+/*
+ * Stolen form Cryptographic API.
+ *
+ * MD4 Message Digest Algorithm (RFC1320).
+ *
+ * Implementation derived from Andrew Tridgell and Steve French's
+ * CIFS MD4 implementation, and the cryptoapi implementation
+ * originally based on the public domain implementation written
+ * by Colin Plumb in 1993.
+ *
+ * Copyright (c) Andrew Tridgell 1997-1998.
+ * Modified by Steve French (sfrench@us.ibm.com) 2002
+ * Copyright (c) Cryptoapi developers.
+ * Copyright (c) 2002 David S. Miller (davem@redhat.com)
+ * Copyright (c) 2002 James Morris <jmorris@intercode.com.au>
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License as published by
+ * the Free Software Foundation; either version 2 of the License, or
+ * (at your option) any later version.
+ *
+ */
+#define MD4_DIGEST_SIZE		16
+#define MD4_HMAC_BLOCK_SIZE	64
+#define MD4_BLOCK_WORDS		16
+#define MD4_HASH_WORDS		4
+
+struct md4_ctx {
+	uint32_t hash[MD4_HASH_WORDS];
+	uint32_t block[MD4_BLOCK_WORDS];
+	uint64_t byte_count;
+};
+
+static inline uint32_t lshift(uint32_t x, unsigned int s)
+{
+	x &= 0xFFFFFFFF;
+	return ((x << s) & 0xFFFFFFFF) | (x >> (32 - s));
+}
+
+static inline uint32_t F(uint32_t x, uint32_t y, uint32_t z)
+{
+	return (x & y) | ((~x) & z);
+}
+
+static inline uint32_t G(uint32_t x, uint32_t y, uint32_t z)
+{
+	return (x & y) | (x & z) | (y & z);
+}
+
+static inline uint32_t H(uint32_t x, uint32_t y, uint32_t z)
+{
+	return x ^ y ^ z;
+}
+
+#define ROUND1(a,b,c,d,k,s) (a = lshift(a + F(b,c,d) + k, s))
+#define ROUND2(a,b,c,d,k,s) (a = lshift(a + G(b,c,d) + k + (uint32_t)0x5A827999,s))
+#define ROUND3(a,b,c,d,k,s) (a = lshift(a + H(b,c,d) + k + (uint32_t)0x6ED9EBA1,s))
+
+/* XXX: this stuff can be optimized */
+static inline void le32_to_cpu_array(uint32_t *buf, unsigned int words)
+{
+	while (words--) {
+		*buf = ntohl(*buf);
+		buf++;
+	}
+}
+
+static inline void cpu_to_le32_array(uint32_t *buf, unsigned int words)
+{
+	while (words--) {
+		*buf = htonl(*buf);
+		buf++;
+	}
+}
+
+static void md4_transform(uint32_t *hash, uint32_t const *in)
+{
+	uint32_t a, b, c, d;
+
+	a = hash[0];
+	b = hash[1];
+	c = hash[2];
+	d = hash[3];
+
+	ROUND1(a, b, c, d, in[0], 3);
+	ROUND1(d, a, b, c, in[1], 7);
+	ROUND1(c, d, a, b, in[2], 11);
+	ROUND1(b, c, d, a, in[3], 19);
+	ROUND1(a, b, c, d, in[4], 3);
+	ROUND1(d, a, b, c, in[5], 7);
+	ROUND1(c, d, a, b, in[6], 11);
+	ROUND1(b, c, d, a, in[7], 19);
+	ROUND1(a, b, c, d, in[8], 3);
+	ROUND1(d, a, b, c, in[9], 7);
+	ROUND1(c, d, a, b, in[10], 11);
+	ROUND1(b, c, d, a, in[11], 19);
+	ROUND1(a, b, c, d, in[12], 3);
+	ROUND1(d, a, b, c, in[13], 7);
+	ROUND1(c, d, a, b, in[14], 11);
+	ROUND1(b, c, d, a, in[15], 19);
+
+	ROUND2(a, b, c, d,in[ 0], 3);
+	ROUND2(d, a, b, c, in[4], 5);
+	ROUND2(c, d, a, b, in[8], 9);
+	ROUND2(b, c, d, a, in[12], 13);
+	ROUND2(a, b, c, d, in[1], 3);
+	ROUND2(d, a, b, c, in[5], 5);
+	ROUND2(c, d, a, b, in[9], 9);
+	ROUND2(b, c, d, a, in[13], 13);
+	ROUND2(a, b, c, d, in[2], 3);
+	ROUND2(d, a, b, c, in[6], 5);
+	ROUND2(c, d, a, b, in[10], 9);
+	ROUND2(b, c, d, a, in[14], 13);
+	ROUND2(a, b, c, d, in[3], 3);
+	ROUND2(d, a, b, c, in[7], 5);
+	ROUND2(c, d, a, b, in[11], 9);
+	ROUND2(b, c, d, a, in[15], 13);
+
+	ROUND3(a, b, c, d,in[ 0], 3);
+	ROUND3(d, a, b, c, in[8], 9);
+	ROUND3(c, d, a, b, in[4], 11);
+	ROUND3(b, c, d, a, in[12], 15);
+	ROUND3(a, b, c, d, in[2], 3);
+	ROUND3(d, a, b, c, in[10], 9);
+	ROUND3(c, d, a, b, in[6], 11);
+	ROUND3(b, c, d, a, in[14], 15);
+	ROUND3(a, b, c, d, in[1], 3);
+	ROUND3(d, a, b, c, in[9], 9);
+	ROUND3(c, d, a, b, in[5], 11);
+	ROUND3(b, c, d, a, in[13], 15);
+	ROUND3(a, b, c, d, in[3], 3);
+	ROUND3(d, a, b, c, in[11], 9);
+	ROUND3(c, d, a, b, in[7], 11);
+	ROUND3(b, c, d, a, in[15], 15);
+
+	hash[0] += a;
+	hash[1] += b;
+	hash[2] += c;
+	hash[3] += d;
+}
+
+static inline void md4_transform_helper(struct md4_ctx *ctx)
+{
+	le32_to_cpu_array(ctx->block, sizeof(ctx->block) / sizeof(uint32_t));
+	md4_transform(ctx->hash, ctx->block);
+}
+
+static void md4_init(struct md4_ctx *mctx)
+{
+	mctx->hash[0] = 0x67452301;
+	mctx->hash[1] = 0xefcdab89;
+	mctx->hash[2] = 0x98badcfe;
+	mctx->hash[3] = 0x10325476;
+	mctx->byte_count = 0;
+}
+
+static void md4_update(struct md4_ctx *mctx,
+		       const unsigned char *data, unsigned int len)
+{
+	const uint32_t avail = sizeof(mctx->block) - (mctx->byte_count & 0x3f);
+
+	mctx->byte_count += len;
+
+	if (avail > len) {
+		memcpy((char *)mctx->block + (sizeof(mctx->block) - avail),
+		       data, len);
+		return;
+	}
+
+	memcpy((char *)mctx->block + (sizeof(mctx->block) - avail),
+	       data, avail);
+
+	md4_transform_helper(mctx);
+	data += avail;
+	len -= avail;
+
+	while (len >= sizeof(mctx->block)) {
+		memcpy(mctx->block, data, sizeof(mctx->block));
+		md4_transform_helper(mctx);
+		data += sizeof(mctx->block);
+		len -= sizeof(mctx->block);
+	}
+
+	memcpy(mctx->block, data, len);
+}
+
+static void md4_final_ascii(struct md4_ctx *mctx, char *out, unsigned int len)
+{
+	const unsigned int offset = mctx->byte_count & 0x3f;
+	char *p = (char *)mctx->block + offset;
+	int padding = 56 - (offset + 1);
+
+	*p++ = 0x80;
+	if (padding < 0) {
+		memset(p, 0x00, padding + sizeof (uint64_t));
+		md4_transform_helper(mctx);
+		p = (char *)mctx->block;
+		padding = 56;
+	}
+
+	memset(p, 0, padding);
+	mctx->block[14] = mctx->byte_count << 3;
+	mctx->block[15] = mctx->byte_count >> 29;
+	le32_to_cpu_array(mctx->block, (sizeof(mctx->block) -
+	                  sizeof(uint64_t)) / sizeof(uint32_t));
+	md4_transform(mctx->hash, mctx->block);
+	cpu_to_le32_array(mctx->hash, sizeof(mctx->hash) / sizeof(uint32_t));
+
+	snprintf(out, len, "%08X%08X%08X%08X",
+		 mctx->hash[0], mctx->hash[1], mctx->hash[2], mctx->hash[3]);
+}
+
+static inline void add_char(unsigned char c, struct md4_ctx *md)
+{
+	md4_update(md, &c, 1);
+}
+
+static int parse_string(const char *file, unsigned long len,
+			struct md4_ctx *md)
+{
+	unsigned long i;
+
+	add_char(file[0], md);
+	for (i = 1; i < len; i++) {
+		add_char(file[i], md);
+		if (file[i] == '"' && file[i-1] != '\\')
+			break;
+	}
+	return i;
+}
+
+static int parse_comment(const char *file, unsigned long len)
+{
+	unsigned long i;
+
+	for (i = 2; i < len; i++) {
+		if (file[i-1] == '*' && file[i] == '/')
+			break;
+	}
+	return i;
+}
+
+/* FIXME: Handle .s files differently (eg. # starts comments) --RR */
+static int parse_file(const char *fname, struct md4_ctx *md)
+{
+	char *file;
+	unsigned long i, len;
+
+	file = grab_file(fname, &len);
+	if (!file)
+		return 0;
+
+	for (i = 0; i < len; i++) {
+		/* Collapse and ignore \ and CR. */
+		if (file[i] == '\\' && (i+1 < len) && file[i+1] == '\n') {
+			i++;
+			continue;
+		}
+
+		/* Ignore whitespace */
+		if (isspace(file[i]))
+			continue;
+
+		/* Handle strings as whole units */
+		if (file[i] == '"') {
+			i += parse_string(file+i, len - i, md);
+			continue;
+		}
+
+		/* Comments: ignore */
+		if (file[i] == '/' && file[i+1] == '*') {
+			i += parse_comment(file+i, len - i);
+			continue;
+		}
+
+		add_char(file[i], md);
+	}
+	release_file(file, len);
+	return 1;
+}
+
+/* We have dir/file.o.  Open dir/.file.o.cmd, look for deps_ line to
+ * figure out source file. */
+static int parse_source_files(const char *objfile, struct md4_ctx *md)
+{
+	char *cmd, *file, *line, *dir;
+	const char *base;
+	unsigned long flen, pos = 0;
+	int dirlen, ret = 0, check_files = 0;
+
+	cmd = NOFAIL(malloc(strlen(objfile) + sizeof("..cmd")));
+
+	base = strrchr(objfile, '/');
+	if (base) {
+		base++;
+		dirlen = base - objfile;
+		sprintf(cmd, "%.*s.%s.cmd", dirlen, objfile, base);
+	} else {
+		dirlen = 0;
+		sprintf(cmd, ".%s.cmd", objfile);
+	}
+	dir = NOFAIL(malloc(dirlen + 1));
+	strncpy(dir, objfile, dirlen);
+	dir[dirlen] = '\0';
+
+	file = grab_file(cmd, &flen);
+	if (!file) {
+		fprintf(stderr, "Warning: could not find %s for %s\n",
+			cmd, objfile);
+		goto out;
+	}
+
+	/* There will be a line like so:
+		deps_drivers/net/dummy.o := \
+		  drivers/net/dummy.c \
+		    $(wildcard include/config/net/fastroute.h) \
+		  include/linux/config.h \
+		    $(wildcard include/config/h.h) \
+		  include/linux/module.h \
+
+	   Sum all files in the same dir or subdirs.
+	*/
+	while ((line = get_next_line(&pos, file, flen)) != NULL) {
+		char* p = line;
+		if (strncmp(line, "deps_", sizeof("deps_")-1) == 0) {
+			check_files = 1;
+			continue;
+		}
+		if (!check_files)
+			continue;
+
+		/* Continue until line does not end with '\' */
+		if ( *(p + strlen(p)-1) != '\\')
+			break;
+		/* Terminate line at first space, to get rid of final ' \' */
+		while (*p) {
+                       if (isspace(*p)) {
+				*p = '\0';
+				break;
+			}
+			p++;
+		}
+
+		/* Check if this file is in same dir as objfile */
+		if ((strstr(line, dir)+strlen(dir)-1) == strrchr(line, '/')) {
+			if (!parse_file(line, md)) {
+				fprintf(stderr,
+					"Warning: could not open %s: %s\n",
+					line, strerror(errno));
+				goto out_file;
+			}
+
+		}
+
+	}
+
+	/* Everyone parsed OK */
+	ret = 1;
+out_file:
+	release_file(file, flen);
+out:
+	free(dir);
+	free(cmd);
+	return ret;
+}
+
+static int get_version(const char *modname, char sum[])
+{
+	void *file;
+	unsigned long len;
+	int ret = 0;
+	struct md4_ctx md;
+	char *sources, *end, *fname;
+	const char *basename;
+	char filelist[sizeof(".tmp_versions/%s.mod") + strlen(modname)];
+
+	/* Source files for module are in .tmp_versions/modname.mod,
+	   after the first line. */
+	if (strrchr(modname, '/'))
+		basename = strrchr(modname, '/') + 1;
+	else
+		basename = modname;
+	sprintf(filelist, ".tmp_versions/%s", basename);
+	/* Truncate .o, add .mod */
+	strcpy(filelist + strlen(filelist)-2, ".mod");
+
+	file = grab_file(filelist, &len);
+	if (!file) {
+		fprintf(stderr, "Warning: could not find versions for %s\n",
+			filelist);
+		return 0;
+	}
+
+	sources = strchr(file, '\n');
+	if (!sources) {
+		fprintf(stderr, "Warning: malformed versions file for %s\n",
+			modname);
+		goto release;
+	}
+
+	sources++;
+	end = strchr(sources, '\n');
+	if (!end) {
+		fprintf(stderr, "Warning: bad ending versions file for %s\n",
+			modname);
+		goto release;
+	}
+	*end = '\0';
+
+	md4_init(&md);
+	for (fname = strtok(sources, " "); fname; fname = strtok(NULL, " ")) {
+		if (!parse_source_files(fname, &md))
+			goto release;
+	}
+
+	/* sum is of form \0<padding>. */
+	md4_final_ascii(&md, sum, 1 + strlen(sum+1));
+	ret = 1;
+release:
+	release_file(file, len);
+	return ret;
+}
+
+static void write_version(const char *filename, const char *sum,
+			  unsigned long offset)
+{
+	int fd;
+
+	fd = open(filename, O_RDWR);
+	if (fd < 0) {
+		fprintf(stderr, "Warning: changing sum in %s failed: %s\n",
+			filename, strerror(errno));
+		return;
+	}
+
+	if (lseek(fd, offset, SEEK_SET) == (off_t)-1) {
+		fprintf(stderr, "Warning: changing sum in %s:%lu failed: %s\n",
+			filename, offset, strerror(errno));
+		goto out;
+	}
+
+	if (write(fd, sum, strlen(sum)+1) != strlen(sum)+1) {
+		fprintf(stderr, "Warning: writing sum in %s failed: %s\n",
+			filename, strerror(errno));
+		goto out;
+	}
+out:
+	close(fd);
+}
+
+void strip_rcs_crap(char *version)
+{
+	unsigned int len, full_len;
+
+	if (strncmp(version, "$Revision", strlen("$Revision")) != 0)
+		return;
+
+	/* Space for version string follows. */
+	full_len = strlen(version) + strlen(version + strlen(version) + 1) + 2;
+
+	/* Move string to start with version number: prefix will be
+	 * $Revision$ or $Revision: */
+	len = strlen("$Revision");
+	if (version[len] == ':' || version[len] == '$')
+		len++;
+	while (isspace(version[len]))
+		len++;
+	memmove(version, version+len, full_len-len);
+	full_len -= len;
+
+	/* Preserve up to next whitespace. */
+	len = 0;
+	while (version[len] && !isspace(version[len]))
+		len++;
+	memmove(version + len, version + strlen(version),
+		full_len - strlen(version));
+}
+
+/* If the modinfo contains a "version" value, then set this. */
+void maybe_frob_version(const char *modfilename,
+			void *modinfo,
+			unsigned long modinfo_len,
+			unsigned long modinfo_offset)
+{
+	char *version, *csum;
+
+	version = get_modinfo(modinfo, modinfo_len, "version");
+	if (!version)
+		return;
+
+	/* RCS $Revision gets stripped out. */
+	strip_rcs_crap(version);
+
+	/* Check against double sumversion */
+	if (strchr(version, ' '))
+		return;
+
+	/* Version contains embedded NUL: second half has space for checksum */
+	csum = version + strlen(version);
+	*(csum++) = ' ';
+	if (get_version(modfilename, csum))
+		write_version(modfilename, version,
+			      modinfo_offset + (version - (char *)modinfo));
+}
diff -urN linux-2.6.8-rc2/scripts/modpost.c linux-mv/scripts/modpost.c
--- linux-2.6.8-rc2/scripts/modpost.c	2004-06-23 18:06:18.000000000 -0400
+++ linux-mv/scripts/modpost.c	1969-12-31 19:00:00.000000000 -0500
@@ -1,739 +0,0 @@
-/* Postprocess module symbol versions
- *
- * Copyright 2003       Kai Germaschewski
- *           2002-2003  Rusty Russell, IBM Corporation
- *
- * Based in part on module-init-tools/depmod.c,file2alias
- *
- * This software may be used and distributed according to the terms
- * of the GNU General Public License, incorporated herein by reference.
- *
- * Usage: modpost vmlinux module1.o module2.o ...
- */
-
-#include <ctype.h>
-#include "modpost.h"
-
-/* Are we using CONFIG_MODVERSIONS? */
-int modversions = 0;
-/* Warn about undefined symbols? (do so if we have vmlinux) */
-int have_vmlinux = 0;
-
-void
-fatal(const char *fmt, ...)
-{
-	va_list arglist;
-
-	fprintf(stderr, "FATAL: ");
-
-	va_start(arglist, fmt);
-	vfprintf(stderr, fmt, arglist);
-	va_end(arglist);
-
-	exit(1);
-}
-
-void
-warn(const char *fmt, ...)
-{
-	va_list arglist;
-
-	fprintf(stderr, "WARNING: ");
-
-	va_start(arglist, fmt);
-	vfprintf(stderr, fmt, arglist);
-	va_end(arglist);
-}
-
-void *do_nofail(void *ptr, const char *file, int line, const char *expr)
-{
-	if (!ptr) {
-		fatal("Memory allocation failure %s line %d: %s.\n",
-		      file, line, expr);
-	}
-	return ptr;
-}
-
-/* A list of all modules we processed */
-
-static struct module *modules;
-
-struct module *
-find_module(char *modname)
-{
-	struct module *mod;
-
-	for (mod = modules; mod; mod = mod->next)
-		if (strcmp(mod->name, modname) == 0)
-			break;
-	return mod;
-}
-
-struct module *
-new_module(char *modname)
-{
-	struct module *mod;
-	char *p, *s;
-	
-	mod = NOFAIL(malloc(sizeof(*mod)));
-	memset(mod, 0, sizeof(*mod));
-	p = NOFAIL(strdup(modname));
-
-	/* strip trailing .o */
-	if ((s = strrchr(p, '.')) != NULL)
-		if (strcmp(s, ".o") == 0)
-			*s = '\0';
-
-	/* add to list */
-	mod->name = p;
-	mod->next = modules;
-	modules = mod;
-
-	return mod;
-}
-
-/* A hash of all exported symbols,
- * struct symbol is also used for lists of unresolved symbols */
-
-#define SYMBOL_HASH_SIZE 1024
-
-struct symbol {
-	struct symbol *next;
-	struct module *module;
-	unsigned int crc;
-	int crc_valid;
-	char name[0];
-};
-
-static struct symbol *symbolhash[SYMBOL_HASH_SIZE];
-
-/* This is based on the hash agorithm from gdbm, via tdb */
-static inline unsigned int tdb_hash(const char *name)
-{
-	unsigned value;	/* Used to compute the hash value.  */
-	unsigned   i;	/* Used to cycle through random values. */
-
-	/* Set the initial value from the key size. */
-	for (value = 0x238F13AF * strlen(name), i=0; name[i]; i++)
-		value = (value + (((unsigned char *)name)[i] << (i*5 % 24)));
-
-	return (1103515243 * value + 12345);
-}
-
-/* Allocate a new symbols for use in the hash of exported symbols or
- * the list of unresolved symbols per module */
-
-struct symbol *
-alloc_symbol(const char *name, struct symbol *next)
-{
-	struct symbol *s = NOFAIL(malloc(sizeof(*s) + strlen(name) + 1));
-
-	memset(s, 0, sizeof(*s));
-	strcpy(s->name, name);
-	s->next = next;
-	return s;
-}
-
-/* For the hash of exported symbols */
-
-void
-new_symbol(const char *name, struct module *module, unsigned int *crc)
-{
-	unsigned int hash;
-	struct symbol *new;
-
-	hash = tdb_hash(name) % SYMBOL_HASH_SIZE;
-	new = symbolhash[hash] = alloc_symbol(name, symbolhash[hash]);
-	new->module = module;
-	if (crc) {
-		new->crc = *crc;
-		new->crc_valid = 1;
-	}
-}
-
-struct symbol *
-find_symbol(const char *name)
-{
-	struct symbol *s;
-
-	/* For our purposes, .foo matches foo.  PPC64 needs this. */
-	if (name[0] == '.')
-		name++;
-
-	for (s = symbolhash[tdb_hash(name) % SYMBOL_HASH_SIZE]; s; s=s->next) {
-		if (strcmp(s->name, name) == 0)
-			return s;
-	}
-	return NULL;
-}
-
-/* Add an exported symbol - it may have already been added without a
- * CRC, in this case just update the CRC */
-void
-add_exported_symbol(const char *name, struct module *module, unsigned int *crc)
-{
-	struct symbol *s = find_symbol(name);
-
-	if (!s) {
-		new_symbol(name, module, crc);
-		return;
-	}
-	if (crc) {
-		s->crc = *crc;
-		s->crc_valid = 1;
-	}
-}
-
-void *
-grab_file(const char *filename, unsigned long *size)
-{
-	struct stat st;
-	void *map;
-	int fd;
-
-	fd = open(filename, O_RDONLY);
-	if (fd < 0 || fstat(fd, &st) != 0)
-		return NULL;
-
-	*size = st.st_size;
-	map = mmap(NULL, *size, PROT_READ|PROT_WRITE, MAP_PRIVATE, fd, 0);
-	close(fd);
-
-	if (map == MAP_FAILED)
-		return NULL;
-	return map;
-}
-
-/*
-   Return a copy of the next line in a mmap'ed file.
-   spaces in the beginning of the line is trimmed away.
-   Return a pointer to a static buffer.
-*/
-char*
-get_next_line(unsigned long *pos, void *file, unsigned long size)
-{
-	static char line[4096];
-	int skip = 1;
-	size_t len = 0;
-	char *p = (char *)file + *pos;
-	char *s = line;
-
-	for (; *pos < size ; (*pos)++)
-	{
-		if (skip && isspace(*p)) {
-			p++;
-			continue;
-		}
-		skip = 0;
-		if (*p != '\n' && (*pos < size)) {
-			len++;
-			*s++ = *p++;
-			if (len > 4095)
-				break; /* Too long, stop */
-		} else {
-			/* End of string */
-			*s = '\0';
-			return line;
-		}
-	}
-	/* End of buffer */
-	return NULL;
-}
-
-void
-release_file(void *file, unsigned long size)
-{
-	munmap(file, size);
-}
-
-void
-parse_elf(struct elf_info *info, const char *filename)
-{
-	unsigned int i;
-	Elf_Ehdr *hdr = info->hdr;
-	Elf_Shdr *sechdrs;
-	Elf_Sym  *sym;
-
-	hdr = grab_file(filename, &info->size);
-	if (!hdr) {
-		perror(filename);
-		abort();
-	}
-	info->hdr = hdr;
-	if (info->size < sizeof(*hdr))
-		goto truncated;
-
-	/* Fix endianness in ELF header */
-	hdr->e_shoff    = TO_NATIVE(hdr->e_shoff);
-	hdr->e_shstrndx = TO_NATIVE(hdr->e_shstrndx);
-	hdr->e_shnum    = TO_NATIVE(hdr->e_shnum);
-	hdr->e_machine  = TO_NATIVE(hdr->e_machine);
-	sechdrs = (void *)hdr + hdr->e_shoff;
-	info->sechdrs = sechdrs;
-
-	/* Fix endianness in section headers */
-	for (i = 0; i < hdr->e_shnum; i++) {
-		sechdrs[i].sh_type   = TO_NATIVE(sechdrs[i].sh_type);
-		sechdrs[i].sh_offset = TO_NATIVE(sechdrs[i].sh_offset);
-		sechdrs[i].sh_size   = TO_NATIVE(sechdrs[i].sh_size);
-		sechdrs[i].sh_link   = TO_NATIVE(sechdrs[i].sh_link);
-		sechdrs[i].sh_name   = TO_NATIVE(sechdrs[i].sh_name);
-	}
-	/* Find symbol table. */
-	for (i = 1; i < hdr->e_shnum; i++) {
-		const char *secstrings
-			= (void *)hdr + sechdrs[hdr->e_shstrndx].sh_offset;
-
-		if (sechdrs[i].sh_offset > info->size)
-			goto truncated;
-		if (strcmp(secstrings+sechdrs[i].sh_name, ".modinfo") == 0) {
-			info->modinfo = (void *)hdr + sechdrs[i].sh_offset;
-			info->modinfo_len = sechdrs[i].sh_size;
-		}
-		if (sechdrs[i].sh_type != SHT_SYMTAB)
-			continue;
-
-		info->symtab_start = (void *)hdr + sechdrs[i].sh_offset;
-		info->symtab_stop  = (void *)hdr + sechdrs[i].sh_offset 
-			                         + sechdrs[i].sh_size;
-		info->strtab       = (void *)hdr + 
-			             sechdrs[sechdrs[i].sh_link].sh_offset;
-	}
-	if (!info->symtab_start) {
-		fprintf(stderr, "modpost: %s no symtab?\n", filename);
-		abort();
-	}
-	/* Fix endianness in symbols */
-	for (sym = info->symtab_start; sym < info->symtab_stop; sym++) {
-		sym->st_shndx = TO_NATIVE(sym->st_shndx);
-		sym->st_name  = TO_NATIVE(sym->st_name);
-		sym->st_value = TO_NATIVE(sym->st_value);
-		sym->st_size  = TO_NATIVE(sym->st_size);
-	}
-	return;
-
- truncated:
-	fprintf(stderr, "modpost: %s is truncated.\n", filename);
-	abort();
-}
-
-void
-parse_elf_finish(struct elf_info *info)
-{
-	release_file(info->hdr, info->size);
-}
-
-#define CRC_PFX     MODULE_SYMBOL_PREFIX "__crc_"
-#define KSYMTAB_PFX MODULE_SYMBOL_PREFIX "__ksymtab_"
-
-void
-handle_modversions(struct module *mod, struct elf_info *info,
-		   Elf_Sym *sym, const char *symname)
-{
-	unsigned int crc;
-
-	switch (sym->st_shndx) {
-	case SHN_COMMON:
-		fprintf(stderr, "*** Warning: \"%s\" [%s] is COMMON symbol\n",
-			symname, mod->name);
-		break;
-	case SHN_ABS:
-		/* CRC'd symbol */
-		if (memcmp(symname, CRC_PFX, strlen(CRC_PFX)) == 0) {
-			crc = (unsigned int) sym->st_value;
-			add_exported_symbol(symname + strlen(CRC_PFX),
-					    mod, &crc);
-			modversions = 1;
-		}
-		break;
-	case SHN_UNDEF:
-		/* undefined symbol */
-		if (ELF_ST_BIND(sym->st_info) != STB_GLOBAL)
-			break;
-		/* ignore global offset table */
-		if (strcmp(symname, "_GLOBAL_OFFSET_TABLE_") == 0)
-			break;
-		/* ignore __this_module, it will be resolved shortly */
-		if (strcmp(symname, MODULE_SYMBOL_PREFIX "__this_module") == 0)
-			break;
-#ifdef STT_REGISTER
-		if (info->hdr->e_machine == EM_SPARC ||
-		    info->hdr->e_machine == EM_SPARCV9) {
-			/* Ignore register directives. */
-			if (ELF_ST_TYPE(sym->st_info) == STT_REGISTER)
-				break;
-		}
-#endif
-		
-		if (memcmp(symname, MODULE_SYMBOL_PREFIX,
-			   strlen(MODULE_SYMBOL_PREFIX)) == 0)
-			mod->unres = alloc_symbol(symname +
-						  strlen(MODULE_SYMBOL_PREFIX),
-						  mod->unres);
-		break;
-	default:
-		/* All exported symbols */
-		if (memcmp(symname, KSYMTAB_PFX, strlen(KSYMTAB_PFX)) == 0) {
-			add_exported_symbol(symname + strlen(KSYMTAB_PFX),
-					    mod, NULL);
-		}
-		break;
-	}
-}
-
-int
-is_vmlinux(const char *modname)
-{
-	const char *myname;
-
-	if ((myname = strrchr(modname, '/')))
-		myname++;
-	else
-		myname = modname;
-
-	return strcmp(myname, "vmlinux") == 0;
-}
-
-void
-read_symbols(char *modname)
-{
-	const char *symname;
-	struct module *mod;
-	struct elf_info info = { };
-	Elf_Sym *sym;
-
-	parse_elf(&info, modname);
-
-	mod = new_module(modname);
-
-	/* When there's no vmlinux, don't print warnings about
-	 * unresolved symbols (since there'll be too many ;) */
-	if (is_vmlinux(modname)) {
-		unsigned int fake_crc = 0;
-		have_vmlinux = 1;
-		/* May not have this if !CONFIG_MODULE_UNLOAD: fake it.
-		   If it appears, we'll get the real CRC. */
-		add_exported_symbol("cleanup_module", mod, &fake_crc);
-		add_exported_symbol("struct_module", mod, &fake_crc);
-		mod->skip = 1;
-	}
-
-	for (sym = info.symtab_start; sym < info.symtab_stop; sym++) {
-		symname = info.strtab + sym->st_name;
-
-		handle_modversions(mod, &info, sym, symname);
-		handle_moddevtable(mod, &info, sym, symname);
-	}
-	maybe_frob_version(modname, info.modinfo, info.modinfo_len,
-			   (void *)info.modinfo - (void *)info.hdr);
-	parse_elf_finish(&info);
-
-	/* Our trick to get versioning for struct_module - it's
-	 * never passed as an argument to an exported function, so
-	 * the automatic versioning doesn't pick it up, but it's really
-	 * important anyhow */
-	if (modversions) {
-		mod->unres = alloc_symbol("struct_module", mod->unres);
-
-		/* Always version init_module and cleanup_module, in
-		 * case module doesn't have its own. */
-		mod->unres = alloc_symbol("init_module", mod->unres);
-		mod->unres = alloc_symbol("cleanup_module", mod->unres);
-	}
-}
-
-#define SZ 500
-
-/* We first write the generated file into memory using the
- * following helper, then compare to the file on disk and
- * only update the later if anything changed */
-
-void __attribute__((format(printf, 2, 3)))
-buf_printf(struct buffer *buf, const char *fmt, ...)
-{
-	char tmp[SZ];
-	int len;
-	va_list ap;
-	
-	va_start(ap, fmt);
-	len = vsnprintf(tmp, SZ, fmt, ap);
-	if (buf->size - buf->pos < len + 1) {
-		buf->size += 128;
-		buf->p = realloc(buf->p, buf->size);
-	}
-	strncpy(buf->p + buf->pos, tmp, len + 1);
-	buf->pos += len;
-	va_end(ap);
-}
-
-void
-buf_write(struct buffer *buf, const char *s, int len)
-{
-	if (buf->size - buf->pos < len) {
-		buf->size += len;
-		buf->p = realloc(buf->p, buf->size);
-	}
-	strncpy(buf->p + buf->pos, s, len);
-	buf->pos += len;
-}
-
-/* Header for the generated file */
-
-void
-add_header(struct buffer *b)
-{
-	buf_printf(b, "#include <linux/module.h>\n");
-	buf_printf(b, "#include <linux/vermagic.h>\n");
-	buf_printf(b, "#include <linux/compiler.h>\n");
-	buf_printf(b, "\n");
-	buf_printf(b, "MODULE_INFO(vermagic, VERMAGIC_STRING);\n");
-	buf_printf(b, "\n");
-	buf_printf(b, "#undef unix\n"); /* We have a module called "unix" */
-	buf_printf(b, "struct module __this_module\n");
-	buf_printf(b, "__attribute__((section(\".gnu.linkonce.this_module\"))) = {\n");
-	buf_printf(b, " .name = __stringify(KBUILD_MODNAME),\n");
-	buf_printf(b, " .init = init_module,\n");
-	buf_printf(b, "#ifdef CONFIG_MODULE_UNLOAD\n");
-	buf_printf(b, " .exit = cleanup_module,\n");
-	buf_printf(b, "#endif\n");
-	buf_printf(b, "};\n");
-}
-
-/* Record CRCs for unresolved symbols */
-
-void
-add_versions(struct buffer *b, struct module *mod)
-{
-	struct symbol *s, *exp;
-
-	for (s = mod->unres; s; s = s->next) {
-		exp = find_symbol(s->name);
-		if (!exp || exp->module == mod) {
-			if (have_vmlinux)
-				fprintf(stderr, "*** Warning: \"%s\" [%s.ko] "
-				"undefined!\n",	s->name, mod->name);
-			continue;
-		}
-		s->module = exp->module;
-		s->crc_valid = exp->crc_valid;
-		s->crc = exp->crc;
-	}
-
-	if (!modversions)
-		return;
-
-	buf_printf(b, "\n");
-	buf_printf(b, "static const struct modversion_info ____versions[]\n");
-	buf_printf(b, "__attribute_used__\n");
-	buf_printf(b, "__attribute__((section(\"__versions\"))) = {\n");
-
-	for (s = mod->unres; s; s = s->next) {
-		if (!s->module) {
-			continue;
-		}
-		if (!s->crc_valid) {
-			fprintf(stderr, "*** Warning: \"%s\" [%s.ko] "
-				"has no CRC!\n",
-				s->name, mod->name);
-			continue;
-		}
-		buf_printf(b, "\t{ %#8x, \"%s\" },\n", s->crc, s->name);
-	}
-
-	buf_printf(b, "};\n");
-}
-
-void
-add_depends(struct buffer *b, struct module *mod, struct module *modules)
-{
-	struct symbol *s;
-	struct module *m;
-	int first = 1;
-
-	for (m = modules; m; m = m->next) {
-		m->seen = is_vmlinux(m->name);
-	}
-
-	buf_printf(b, "\n");
-	buf_printf(b, "static const char __module_depends[]\n");
-	buf_printf(b, "__attribute_used__\n");
-	buf_printf(b, "__attribute__((section(\".modinfo\"))) =\n");
-	buf_printf(b, "\"depends=");
-	for (s = mod->unres; s; s = s->next) {
-		if (!s->module)
-			continue;
-
-		if (s->module->seen)
-			continue;
-
-		s->module->seen = 1;
-		buf_printf(b, "%s%s", first ? "" : ",",
-			   strrchr(s->module->name, '/') + 1);
-		first = 0;
-	}
-	buf_printf(b, "\";\n");
-}
-
-void
-write_if_changed(struct buffer *b, const char *fname)
-{
-	char *tmp;
-	FILE *file;
-	struct stat st;
-
-	file = fopen(fname, "r");
-	if (!file)
-		goto write;
-
-	if (fstat(fileno(file), &st) < 0)
-		goto close_write;
-
-	if (st.st_size != b->pos)
-		goto close_write;
-
-	tmp = NOFAIL(malloc(b->pos));
-	if (fread(tmp, 1, b->pos, file) != b->pos)
-		goto free_write;
-
-	if (memcmp(tmp, b->p, b->pos) != 0)
-		goto free_write;
-
-	free(tmp);
-	fclose(file);
-	return;
-
- free_write:
-	free(tmp);
- close_write:
-	fclose(file);
- write:
-	file = fopen(fname, "w");
-	if (!file) {
-		perror(fname);
-		exit(1);
-	}
-	if (fwrite(b->p, 1, b->pos, file) != b->pos) {
-		perror(fname);
-		exit(1);
-	}
-	fclose(file);
-}
-
-void
-read_dump(const char *fname)
-{
-	unsigned long size, pos = 0;
-	void *file = grab_file(fname, &size);
-	char *line;
-
-        if (!file)
-		/* No symbol versions, silently ignore */
-		return;
-
-	while ((line = get_next_line(&pos, file, size))) {
-		char *symname, *modname, *d;
-		unsigned int crc;
-		struct module *mod;
-
-		if (!(symname = strchr(line, '\t')))
-			goto fail;
-		*symname++ = '\0';
-		if (!(modname = strchr(symname, '\t')))
-			goto fail;
-		*modname++ = '\0';
-		if (strchr(modname, '\t'))
-			goto fail;
-		crc = strtoul(line, &d, 16);
-		if (*symname == '\0' || *modname == '\0' || *d != '\0')
-			goto fail;
-
-		if (!(mod = find_module(modname))) {
-			if (is_vmlinux(modname)) {
-				modversions = 1;
-				have_vmlinux = 1;
-			}
-			mod = new_module(NOFAIL(strdup(modname)));
-			mod->skip = 1;
-		}
-		add_exported_symbol(symname, mod, &crc);
-	}
-	return;
-fail:
-	fatal("parse error in symbol dump file\n");
-}
-
-void
-write_dump(const char *fname)
-{
-	struct buffer buf = { };
-	struct symbol *symbol;
-	int n;
-
-	for (n = 0; n < SYMBOL_HASH_SIZE ; n++) {
-		symbol = symbolhash[n];
-		while (symbol) {
-			symbol = symbol->next;
-		}
-	}
-
-	for (n = 0; n < SYMBOL_HASH_SIZE ; n++) {
-		symbol = symbolhash[n];
-		while (symbol) {
-			buf_printf(&buf, "0x%08x\t%s\t%s\n", symbol->crc,
-				symbol->name, symbol->module->name);
-			symbol = symbol->next;
-		}
-	}
-	write_if_changed(&buf, fname);
-}
-
-int
-main(int argc, char **argv)
-{
-	struct module *mod;
-	struct buffer buf = { };
-	char fname[SZ];
-	char *dump_read = NULL, *dump_write = NULL;
-	int opt;
-
-	while ((opt = getopt(argc, argv, "i:o:")) != -1) {
-		switch(opt) {
-			case 'i':
-				dump_read = optarg;
-				break;
-			case 'o':
-				dump_write = optarg;
-				break;
-			default:
-				exit(1);
-		}
-	}
-
-	if (dump_read)
-		read_dump(dump_read);
-
-	while (optind < argc) {
-		read_symbols(argv[optind++]);
-	}
-
-	for (mod = modules; mod; mod = mod->next) {
-		if (mod->skip)
-			continue;
-
-		buf.pos = 0;
-
-		add_header(&buf);
-		add_versions(&buf, mod);
-		add_depends(&buf, mod, modules);
-		add_moddevtable(&buf, mod);
-
-		sprintf(fname, "%s.mod.c", mod->name);
-		write_if_changed(&buf, fname);
-	}
-
-	if (dump_write)
-		write_dump(dump_write);
-
-	return 0;
-}
-
diff -urN linux-2.6.8-rc2/scripts/modpost.h linux-mv/scripts/modpost.h
--- linux-2.6.8-rc2/scripts/modpost.h	2004-06-23 18:06:06.000000000 -0400
+++ linux-mv/scripts/modpost.h	1969-12-31 19:00:00.000000000 -0500
@@ -1,103 +0,0 @@
-#include <stdio.h>
-#include <stdlib.h>
-#include <stdarg.h>
-#include <string.h>
-#include <sys/types.h>
-#include <sys/stat.h>
-#include <sys/mman.h>
-#include <fcntl.h>
-#include <unistd.h>
-#include <elf.h>
-
-#include "elfconfig.h"
-
-#if KERNEL_ELFCLASS == ELFCLASS32
-
-#define Elf_Ehdr    Elf32_Ehdr 
-#define Elf_Shdr    Elf32_Shdr 
-#define Elf_Sym     Elf32_Sym
-#define ELF_ST_BIND ELF32_ST_BIND
-#define ELF_ST_TYPE ELF32_ST_TYPE
-
-#else
-
-#define Elf_Ehdr    Elf64_Ehdr 
-#define Elf_Shdr    Elf64_Shdr 
-#define Elf_Sym     Elf64_Sym
-#define ELF_ST_BIND ELF64_ST_BIND
-#define ELF_ST_TYPE ELF64_ST_TYPE
-
-#endif
-
-#if KERNEL_ELFDATA != HOST_ELFDATA
-
-static inline void __endian(const void *src, void *dest, unsigned int size)
-{
-	unsigned int i;
-	for (i = 0; i < size; i++)
-		((unsigned char*)dest)[i] = ((unsigned char*)src)[size - i-1];
-}
-
-
-
-#define TO_NATIVE(x)						\
-({								\
-	typeof(x) __x;						\
-	__endian(&(x), &(__x), sizeof(__x));			\
-	__x;							\
-})
-
-#else /* endianness matches */
-
-#define TO_NATIVE(x) (x)
-
-#endif
-
-#define NOFAIL(ptr)   do_nofail((ptr), __FILE__, __LINE__, #ptr)
-void *do_nofail(void *ptr, const char *file, int line, const char *expr);
-
-struct buffer {
-	char *p;
-	int pos;
-	int size;
-};
-
-void __attribute__((format(printf, 2, 3)))
-buf_printf(struct buffer *buf, const char *fmt, ...);
-
-void
-buf_write(struct buffer *buf, const char *s, int len);
-
-struct module {
-	struct module *next;
-	const char *name;
-	struct symbol *unres;
-	int seen;
-	int skip;
-	struct buffer dev_table_buf;
-};
-
-struct elf_info {
-	unsigned long size;
-	Elf_Ehdr     *hdr;
-	Elf_Shdr     *sechdrs;
-	Elf_Sym      *symtab_start;
-	Elf_Sym      *symtab_stop;
-	const char   *strtab;
-	char	     *modinfo;
-	unsigned int modinfo_len;
-};
-
-void handle_moddevtable(struct module *mod, struct elf_info *info,
-			Elf_Sym *sym, const char *symname);
-
-void add_moddevtable(struct buffer *buf, struct module *mod);
-
-void maybe_frob_version(const char *modfilename,
-			void *modinfo,
-			unsigned long modinfo_len,
-			unsigned long modinfo_offset);
-
-void *grab_file(const char *filename, unsigned long *size);
-char* get_next_line(unsigned long *pos, void *file, unsigned long size);
-void release_file(void *file, unsigned long size);
diff -urN linux-2.6.8-rc2/scripts/sumversion.c linux-mv/scripts/sumversion.c
--- linux-2.6.8-rc2/scripts/sumversion.c	2004-06-23 18:06:18.000000000 -0400
+++ linux-mv/scripts/sumversion.c	1969-12-31 19:00:00.000000000 -0500
@@ -1,544 +0,0 @@
-#include <netinet/in.h>
-#include <stdint.h>
-#include <ctype.h>
-#include <errno.h>
-#include <string.h>
-#include "modpost.h"
-
-/* Parse tag=value strings from .modinfo section */
-static char *next_string(char *string, unsigned long *secsize)
-{
-	/* Skip non-zero chars */
-	while (string[0]) {
-		string++;
-		if ((*secsize)-- <= 1)
-			return NULL;
-	}
-
-	/* Skip any zero padding. */
-	while (!string[0]) {
-		string++;
-		if ((*secsize)-- <= 1)
-			return NULL;
-	}
-	return string;
-}
-
-static char *get_modinfo(void *modinfo, unsigned long modinfo_len,
-			 const char *tag)
-{
-	char *p;
-	unsigned int taglen = strlen(tag);
-	unsigned long size = modinfo_len;
-
-	for (p = modinfo; p; p = next_string(p, &size)) {
-		if (strncmp(p, tag, taglen) == 0 && p[taglen] == '=')
-			return p + taglen + 1;
-	}
-	return NULL;
-}
-
-/*
- * Stolen form Cryptographic API.
- *
- * MD4 Message Digest Algorithm (RFC1320).
- *
- * Implementation derived from Andrew Tridgell and Steve French's
- * CIFS MD4 implementation, and the cryptoapi implementation
- * originally based on the public domain implementation written
- * by Colin Plumb in 1993.
- *
- * Copyright (c) Andrew Tridgell 1997-1998.
- * Modified by Steve French (sfrench@us.ibm.com) 2002
- * Copyright (c) Cryptoapi developers.
- * Copyright (c) 2002 David S. Miller (davem@redhat.com)
- * Copyright (c) 2002 James Morris <jmorris@intercode.com.au>
- *
- * This program is free software; you can redistribute it and/or modify
- * it under the terms of the GNU General Public License as published by
- * the Free Software Foundation; either version 2 of the License, or
- * (at your option) any later version.
- *
- */
-#define MD4_DIGEST_SIZE		16
-#define MD4_HMAC_BLOCK_SIZE	64
-#define MD4_BLOCK_WORDS		16
-#define MD4_HASH_WORDS		4
-
-struct md4_ctx {
-	uint32_t hash[MD4_HASH_WORDS];
-	uint32_t block[MD4_BLOCK_WORDS];
-	uint64_t byte_count;
-};
-
-static inline uint32_t lshift(uint32_t x, unsigned int s)
-{
-	x &= 0xFFFFFFFF;
-	return ((x << s) & 0xFFFFFFFF) | (x >> (32 - s));
-}
-
-static inline uint32_t F(uint32_t x, uint32_t y, uint32_t z)
-{
-	return (x & y) | ((~x) & z);
-}
-
-static inline uint32_t G(uint32_t x, uint32_t y, uint32_t z)
-{
-	return (x & y) | (x & z) | (y & z);
-}
-
-static inline uint32_t H(uint32_t x, uint32_t y, uint32_t z)
-{
-	return x ^ y ^ z;
-}
-
-#define ROUND1(a,b,c,d,k,s) (a = lshift(a + F(b,c,d) + k, s))
-#define ROUND2(a,b,c,d,k,s) (a = lshift(a + G(b,c,d) + k + (uint32_t)0x5A827999,s))
-#define ROUND3(a,b,c,d,k,s) (a = lshift(a + H(b,c,d) + k + (uint32_t)0x6ED9EBA1,s))
-
-/* XXX: this stuff can be optimized */
-static inline void le32_to_cpu_array(uint32_t *buf, unsigned int words)
-{
-	while (words--) {
-		*buf = ntohl(*buf);
-		buf++;
-	}
-}
-
-static inline void cpu_to_le32_array(uint32_t *buf, unsigned int words)
-{
-	while (words--) {
-		*buf = htonl(*buf);
-		buf++;
-	}
-}
-
-static void md4_transform(uint32_t *hash, uint32_t const *in)
-{
-	uint32_t a, b, c, d;
-
-	a = hash[0];
-	b = hash[1];
-	c = hash[2];
-	d = hash[3];
-
-	ROUND1(a, b, c, d, in[0], 3);
-	ROUND1(d, a, b, c, in[1], 7);
-	ROUND1(c, d, a, b, in[2], 11);
-	ROUND1(b, c, d, a, in[3], 19);
-	ROUND1(a, b, c, d, in[4], 3);
-	ROUND1(d, a, b, c, in[5], 7);
-	ROUND1(c, d, a, b, in[6], 11);
-	ROUND1(b, c, d, a, in[7], 19);
-	ROUND1(a, b, c, d, in[8], 3);
-	ROUND1(d, a, b, c, in[9], 7);
-	ROUND1(c, d, a, b, in[10], 11);
-	ROUND1(b, c, d, a, in[11], 19);
-	ROUND1(a, b, c, d, in[12], 3);
-	ROUND1(d, a, b, c, in[13], 7);
-	ROUND1(c, d, a, b, in[14], 11);
-	ROUND1(b, c, d, a, in[15], 19);
-
-	ROUND2(a, b, c, d,in[ 0], 3);
-	ROUND2(d, a, b, c, in[4], 5);
-	ROUND2(c, d, a, b, in[8], 9);
-	ROUND2(b, c, d, a, in[12], 13);
-	ROUND2(a, b, c, d, in[1], 3);
-	ROUND2(d, a, b, c, in[5], 5);
-	ROUND2(c, d, a, b, in[9], 9);
-	ROUND2(b, c, d, a, in[13], 13);
-	ROUND2(a, b, c, d, in[2], 3);
-	ROUND2(d, a, b, c, in[6], 5);
-	ROUND2(c, d, a, b, in[10], 9);
-	ROUND2(b, c, d, a, in[14], 13);
-	ROUND2(a, b, c, d, in[3], 3);
-	ROUND2(d, a, b, c, in[7], 5);
-	ROUND2(c, d, a, b, in[11], 9);
-	ROUND2(b, c, d, a, in[15], 13);
-
-	ROUND3(a, b, c, d,in[ 0], 3);
-	ROUND3(d, a, b, c, in[8], 9);
-	ROUND3(c, d, a, b, in[4], 11);
-	ROUND3(b, c, d, a, in[12], 15);
-	ROUND3(a, b, c, d, in[2], 3);
-	ROUND3(d, a, b, c, in[10], 9);
-	ROUND3(c, d, a, b, in[6], 11);
-	ROUND3(b, c, d, a, in[14], 15);
-	ROUND3(a, b, c, d, in[1], 3);
-	ROUND3(d, a, b, c, in[9], 9);
-	ROUND3(c, d, a, b, in[5], 11);
-	ROUND3(b, c, d, a, in[13], 15);
-	ROUND3(a, b, c, d, in[3], 3);
-	ROUND3(d, a, b, c, in[11], 9);
-	ROUND3(c, d, a, b, in[7], 11);
-	ROUND3(b, c, d, a, in[15], 15);
-
-	hash[0] += a;
-	hash[1] += b;
-	hash[2] += c;
-	hash[3] += d;
-}
-
-static inline void md4_transform_helper(struct md4_ctx *ctx)
-{
-	le32_to_cpu_array(ctx->block, sizeof(ctx->block) / sizeof(uint32_t));
-	md4_transform(ctx->hash, ctx->block);
-}
-
-static void md4_init(struct md4_ctx *mctx)
-{
-	mctx->hash[0] = 0x67452301;
-	mctx->hash[1] = 0xefcdab89;
-	mctx->hash[2] = 0x98badcfe;
-	mctx->hash[3] = 0x10325476;
-	mctx->byte_count = 0;
-}
-
-static void md4_update(struct md4_ctx *mctx,
-		       const unsigned char *data, unsigned int len)
-{
-	const uint32_t avail = sizeof(mctx->block) - (mctx->byte_count & 0x3f);
-
-	mctx->byte_count += len;
-
-	if (avail > len) {
-		memcpy((char *)mctx->block + (sizeof(mctx->block) - avail),
-		       data, len);
-		return;
-	}
-
-	memcpy((char *)mctx->block + (sizeof(mctx->block) - avail),
-	       data, avail);
-
-	md4_transform_helper(mctx);
-	data += avail;
-	len -= avail;
-
-	while (len >= sizeof(mctx->block)) {
-		memcpy(mctx->block, data, sizeof(mctx->block));
-		md4_transform_helper(mctx);
-		data += sizeof(mctx->block);
-		len -= sizeof(mctx->block);
-	}
-
-	memcpy(mctx->block, data, len);
-}
-
-static void md4_final_ascii(struct md4_ctx *mctx, char *out, unsigned int len)
-{
-	const unsigned int offset = mctx->byte_count & 0x3f;
-	char *p = (char *)mctx->block + offset;
-	int padding = 56 - (offset + 1);
-
-	*p++ = 0x80;
-	if (padding < 0) {
-		memset(p, 0x00, padding + sizeof (uint64_t));
-		md4_transform_helper(mctx);
-		p = (char *)mctx->block;
-		padding = 56;
-	}
-
-	memset(p, 0, padding);
-	mctx->block[14] = mctx->byte_count << 3;
-	mctx->block[15] = mctx->byte_count >> 29;
-	le32_to_cpu_array(mctx->block, (sizeof(mctx->block) -
-	                  sizeof(uint64_t)) / sizeof(uint32_t));
-	md4_transform(mctx->hash, mctx->block);
-	cpu_to_le32_array(mctx->hash, sizeof(mctx->hash) / sizeof(uint32_t));
-
-	snprintf(out, len, "%08X%08X%08X%08X",
-		 mctx->hash[0], mctx->hash[1], mctx->hash[2], mctx->hash[3]);
-}
-
-static inline void add_char(unsigned char c, struct md4_ctx *md)
-{
-	md4_update(md, &c, 1);
-}
-
-static int parse_string(const char *file, unsigned long len,
-			struct md4_ctx *md)
-{
-	unsigned long i;
-
-	add_char(file[0], md);
-	for (i = 1; i < len; i++) {
-		add_char(file[i], md);
-		if (file[i] == '"' && file[i-1] != '\\')
-			break;
-	}
-	return i;
-}
-
-static int parse_comment(const char *file, unsigned long len)
-{
-	unsigned long i;
-
-	for (i = 2; i < len; i++) {
-		if (file[i-1] == '*' && file[i] == '/')
-			break;
-	}
-	return i;
-}
-
-/* FIXME: Handle .s files differently (eg. # starts comments) --RR */
-static int parse_file(const char *fname, struct md4_ctx *md)
-{
-	char *file;
-	unsigned long i, len;
-
-	file = grab_file(fname, &len);
-	if (!file)
-		return 0;
-
-	for (i = 0; i < len; i++) {
-		/* Collapse and ignore \ and CR. */
-		if (file[i] == '\\' && (i+1 < len) && file[i+1] == '\n') {
-			i++;
-			continue;
-		}
-
-		/* Ignore whitespace */
-		if (isspace(file[i]))
-			continue;
-
-		/* Handle strings as whole units */
-		if (file[i] == '"') {
-			i += parse_string(file+i, len - i, md);
-			continue;
-		}
-
-		/* Comments: ignore */
-		if (file[i] == '/' && file[i+1] == '*') {
-			i += parse_comment(file+i, len - i);
-			continue;
-		}
-
-		add_char(file[i], md);
-	}
-	release_file(file, len);
-	return 1;
-}
-
-/* We have dir/file.o.  Open dir/.file.o.cmd, look for deps_ line to
- * figure out source file. */
-static int parse_source_files(const char *objfile, struct md4_ctx *md)
-{
-	char *cmd, *file, *line, *dir;
-	const char *base;
-	unsigned long flen, pos = 0;
-	int dirlen, ret = 0, check_files = 0;
-
-	cmd = NOFAIL(malloc(strlen(objfile) + sizeof("..cmd")));
-
-	base = strrchr(objfile, '/');
-	if (base) {
-		base++;
-		dirlen = base - objfile;
-		sprintf(cmd, "%.*s.%s.cmd", dirlen, objfile, base);
-	} else {
-		dirlen = 0;
-		sprintf(cmd, ".%s.cmd", objfile);
-	}
-	dir = NOFAIL(malloc(dirlen + 1));
-	strncpy(dir, objfile, dirlen);
-	dir[dirlen] = '\0';
-
-	file = grab_file(cmd, &flen);
-	if (!file) {
-		fprintf(stderr, "Warning: could not find %s for %s\n",
-			cmd, objfile);
-		goto out;
-	}
-
-	/* There will be a line like so:
-		deps_drivers/net/dummy.o := \
-		  drivers/net/dummy.c \
-		    $(wildcard include/config/net/fastroute.h) \
-		  include/linux/config.h \
-		    $(wildcard include/config/h.h) \
-		  include/linux/module.h \
-
-	   Sum all files in the same dir or subdirs.
-	*/
-	while ((line = get_next_line(&pos, file, flen)) != NULL) {
-		char* p = line;
-		if (strncmp(line, "deps_", sizeof("deps_")-1) == 0) {
-			check_files = 1;
-			continue;
-		}
-		if (!check_files)
-			continue;
-
-		/* Continue until line does not end with '\' */
-		if ( *(p + strlen(p)-1) != '\\')
-			break;
-		/* Terminate line at first space, to get rid of final ' \' */
-		while (*p) {
-                       if (isspace(*p)) {
-				*p = '\0';
-				break;
-			}
-			p++;
-		}
-
-		/* Check if this file is in same dir as objfile */
-		if ((strstr(line, dir)+strlen(dir)-1) == strrchr(line, '/')) {
-			if (!parse_file(line, md)) {
-				fprintf(stderr,
-					"Warning: could not open %s: %s\n",
-					line, strerror(errno));
-				goto out_file;
-			}
-
-		}
-
-	}
-
-	/* Everyone parsed OK */
-	ret = 1;
-out_file:
-	release_file(file, flen);
-out:
-	free(dir);
-	free(cmd);
-	return ret;
-}
-
-static int get_version(const char *modname, char sum[])
-{
-	void *file;
-	unsigned long len;
-	int ret = 0;
-	struct md4_ctx md;
-	char *sources, *end, *fname;
-	const char *basename;
-	char filelist[sizeof(".tmp_versions/%s.mod") + strlen(modname)];
-
-	/* Source files for module are in .tmp_versions/modname.mod,
-	   after the first line. */
-	if (strrchr(modname, '/'))
-		basename = strrchr(modname, '/') + 1;
-	else
-		basename = modname;
-	sprintf(filelist, ".tmp_versions/%s", basename);
-	/* Truncate .o, add .mod */
-	strcpy(filelist + strlen(filelist)-2, ".mod");
-
-	file = grab_file(filelist, &len);
-	if (!file) {
-		fprintf(stderr, "Warning: could not find versions for %s\n",
-			filelist);
-		return 0;
-	}
-
-	sources = strchr(file, '\n');
-	if (!sources) {
-		fprintf(stderr, "Warning: malformed versions file for %s\n",
-			modname);
-		goto release;
-	}
-
-	sources++;
-	end = strchr(sources, '\n');
-	if (!end) {
-		fprintf(stderr, "Warning: bad ending versions file for %s\n",
-			modname);
-		goto release;
-	}
-	*end = '\0';
-
-	md4_init(&md);
-	for (fname = strtok(sources, " "); fname; fname = strtok(NULL, " ")) {
-		if (!parse_source_files(fname, &md))
-			goto release;
-	}
-
-	/* sum is of form \0<padding>. */
-	md4_final_ascii(&md, sum, 1 + strlen(sum+1));
-	ret = 1;
-release:
-	release_file(file, len);
-	return ret;
-}
-
-static void write_version(const char *filename, const char *sum,
-			  unsigned long offset)
-{
-	int fd;
-
-	fd = open(filename, O_RDWR);
-	if (fd < 0) {
-		fprintf(stderr, "Warning: changing sum in %s failed: %s\n",
-			filename, strerror(errno));
-		return;
-	}
-
-	if (lseek(fd, offset, SEEK_SET) == (off_t)-1) {
-		fprintf(stderr, "Warning: changing sum in %s:%lu failed: %s\n",
-			filename, offset, strerror(errno));
-		goto out;
-	}
-
-	if (write(fd, sum, strlen(sum)+1) != strlen(sum)+1) {
-		fprintf(stderr, "Warning: writing sum in %s failed: %s\n",
-			filename, strerror(errno));
-		goto out;
-	}
-out:
-	close(fd);
-}
-
-void strip_rcs_crap(char *version)
-{
-	unsigned int len, full_len;
-
-	if (strncmp(version, "$Revision", strlen("$Revision")) != 0)
-		return;
-
-	/* Space for version string follows. */
-	full_len = strlen(version) + strlen(version + strlen(version) + 1) + 2;
-
-	/* Move string to start with version number: prefix will be
-	 * $Revision$ or $Revision: */
-	len = strlen("$Revision");
-	if (version[len] == ':' || version[len] == '$')
-		len++;
-	while (isspace(version[len]))
-		len++;
-	memmove(version, version+len, full_len-len);
-	full_len -= len;
-
-	/* Preserve up to next whitespace. */
-	len = 0;
-	while (version[len] && !isspace(version[len]))
-		len++;
-	memmove(version + len, version + strlen(version),
-		full_len - strlen(version));
-}
-
-/* If the modinfo contains a "version" value, then set this. */
-void maybe_frob_version(const char *modfilename,
-			void *modinfo,
-			unsigned long modinfo_len,
-			unsigned long modinfo_offset)
-{
-	char *version, *csum;
-
-	version = get_modinfo(modinfo, modinfo_len, "version");
-	if (!version)
-		return;
-
-	/* RCS $Revision gets stripped out. */
-	strip_rcs_crap(version);
-
-	/* Check against double sumversion */
-	if (strchr(version, ' '))
-		return;
-
-	/* Version contains embedded NUL: second half has space for checksum */
-	csum = version + strlen(version);
-	*(csum++) = ' ';
-	if (get_version(modfilename, csum))
-		write_version(modfilename, version,
-			      modinfo_offset + (version - (char *)modinfo));
-}

--------------020902010501090909070403--
