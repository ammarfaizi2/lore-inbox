Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267655AbTAaALZ>; Thu, 30 Jan 2003 19:11:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267656AbTAaALY>; Thu, 30 Jan 2003 19:11:24 -0500
Received: from dp.samba.org ([66.70.73.150]:55990 "EHLO lists.samba.org")
	by vger.kernel.org with ESMTP id <S267655AbTAaALS>;
	Thu, 30 Jan 2003 19:11:18 -0500
From: Rusty Russell <rusty@rustcorp.com.au>
To: linux-kernel@vger.kernel.org
Cc: Kai Germaschewski <kai@tp1.ruhr-uni-bochum.de>, greg@kroah.com,
       jgarzik@pobox.com
Subject: [PATCH] Module alias and device table support.
Date: Fri, 31 Jan 2003 11:09:38 +1100
Message-Id: <20030131002043.947632C056@lists.samba.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This patch adds MODULE_ALIAS("foo") capability, and uses it to
automatically generate sensible aliases from device tables.  The
post-processing is a little rough, but works.

Name: Module alias and device table support
Author: Rusty Russell
Status: Tested on 2.5.59

D: Introduces "MODULE_ALIAS" which modules can use to embed their own
D: aliases for modprobe to use.  Also adds a "finishing" step to modules to
D: supplement their aliases based on MODULE_TABLE declarations, eg.
D: 'usb:v0506p4601dl*dh*dc*dsc*dp*ic*isc*ip*' for drivers/usb/net/pegasus.o

diff -urNp --exclude TAGS -X /home/rusty/current-dontdiff --minimal linux-2.5.59/include/linux/isapnp.h working-2.5.59-alias/include/linux/isapnp.h
--- linux-2.5.59/include/linux/isapnp.h	2003-01-14 10:13:08.000000000 +1100
+++ working-2.5.59-alias/include/linux/isapnp.h	2003-01-30 16:13:12.000000000 +1100
@@ -69,8 +69,9 @@
 
 /* export used IDs outside module */
 #define ISAPNP_CARD_TABLE(name) \
-		MODULE_GENERIC_TABLE(isapnp_card, name)
+		MODULE_TABLE(isapnp_card, name)
 
+/* If you change this, you must update scripts/table2alias.c. */
 struct isapnp_card_id {
 	unsigned long driver_data;	/* data private to the driver */
 	unsigned short card_vendor, card_device;
@@ -85,6 +86,7 @@ struct isapnp_card_id {
 #define ISAPNP_DEVICE_SINGLE_END \
 		.card_vendor = 0, .card_device = 0
 
+/* If you change this, you must update scripts/table2alias.c. */
 struct isapnp_device_id {
 	unsigned short card_vendor, card_device;
 	unsigned short vendor, function;
diff -urNp --exclude TAGS -X /home/rusty/current-dontdiff --minimal linux-2.5.59/include/linux/module.h working-2.5.59-alias/include/linux/module.h
--- linux-2.5.59/include/linux/module.h	2003-01-17 17:01:18.000000000 +1100
+++ working-2.5.59-alias/include/linux/module.h	2003-01-30 17:56:37.000000000 +1100
@@ -50,13 +50,14 @@ search_extable(const struct exception_ta
 	       unsigned long value);
 
 #ifdef MODULE
+#define ___module_cat(a,b) a ## b
+#define __module_cat(a,b) ___module_cat(a,b)
+/* For userspace: you can also call me... */
+#define MODULE_ALIAS(alias)					\
+	static const char __module_cat(__alias_,__LINE__)[]	\
+		__attribute__((section(".modalias"),unused)) = alias
 
-/* For replacement modutils, use an alias not a pointer. */
 #define MODULE_GENERIC_TABLE(gtype,name)			\
-static const unsigned long __module_##gtype##_size		\
-  __attribute__ ((unused)) = sizeof(struct gtype##_id);		\
-static const struct gtype##_id * __module_##gtype##_table	\
-  __attribute__ ((unused)) = name;				\
 extern const struct gtype##_id __mod_##gtype##_table		\
   __attribute__ ((unused, alias(__stringify(name))))
 
@@ -96,6 +97,7 @@ extern const struct gtype##_id __mod_##g
 
 #else  /* !MODULE */
 
+#define MODULE_ALIAS(alias)
 #define MODULE_GENERIC_TABLE(gtype,name)
 #define THIS_MODULE ((struct module *)0)
 #define MOD_INC_USE_COUNT	do { } while (0)
diff -urNp --exclude TAGS -X /home/rusty/current-dontdiff --minimal linux-2.5.59/include/linux/pci.h working-2.5.59-alias/include/linux/pci.h
--- linux-2.5.59/include/linux/pci.h	2003-01-02 14:48:00.000000000 +1100
+++ working-2.5.59-alias/include/linux/pci.h	2003-01-30 16:13:12.000000000 +1100
@@ -491,6 +491,7 @@ struct pbus_set_ranges_data
 	unsigned long prefetch_start, prefetch_end;
 };
 
+/* If you change this, you must update scripts/table2alias.c. */
 struct pci_device_id {
 	unsigned int vendor, device;		/* Vendor and device ID or PCI_ANY_ID */
 	unsigned int subvendor, subdevice;	/* Subsystem ID's or PCI_ANY_ID */
diff -urNp --exclude TAGS -X /home/rusty/current-dontdiff --minimal linux-2.5.59/include/linux/usb.h working-2.5.59-alias/include/linux/usb.h
--- linux-2.5.59/include/linux/usb.h	2003-01-17 17:01:18.000000000 +1100
+++ working-2.5.59-alias/include/linux/usb.h	2003-01-30 16:13:12.000000000 +1100
@@ -371,6 +371,7 @@ static inline int usb_make_path (struct 
  * matches towards the beginning of your table, so that driver_info can
  * record quirks of specific products.
  */
+/* If you change this, you must update scripts/table2alias.c. */
 struct usb_device_id {
 	/* which fields to match against? */
 	__u16		match_flags;
diff -urNp --exclude TAGS -X /home/rusty/current-dontdiff --minimal linux-2.5.59/scripts/Makefile working-2.5.59-alias/scripts/Makefile
--- linux-2.5.59/scripts/Makefile	2003-01-02 12:45:31.000000000 +1100
+++ working-2.5.59-alias/scripts/Makefile	2003-01-30 16:13:12.000000000 +1100
@@ -8,7 +8,7 @@
 # docproc: 	 Preprocess .tmpl file in order to generate .sgml documentation
 # conmakehash:	 Create arrays for initializing the kernel console tables
 
-host-progs    := fixdep split-include conmakehash docproc kallsyms
+host-progs    := fixdep split-include conmakehash docproc kallsyms table2alias
 build-targets := $(host-progs)
 
 # Let clean descend into subdirs
diff -urNp --exclude TAGS -X /home/rusty/current-dontdiff --minimal linux-2.5.59/scripts/Makefile.build working-2.5.59-alias/scripts/Makefile.build
--- linux-2.5.59/scripts/Makefile.build	2003-01-17 17:01:18.000000000 +1100
+++ working-2.5.59-alias/scripts/Makefile.build	2003-01-30 17:51:31.000000000 +1100
@@ -175,11 +175,16 @@ endif
 quiet_cmd_link_multi-y = LD      $@
 cmd_link_multi-y = $(LD) $(LDFLAGS) $(EXTRA_LDFLAGS) -r -o $@ $(filter $(addprefix $(obj)/,$($(subst $(obj)/,,$(@:.o=-objs))) $($(subst $(obj)/,,$(@:.o=-y)))),$^)
 
+ifdef CONFIG_HOTPLUG
+module_link_hotplug-multi = `$(CONFIG_SHELL) scripts/extract_aliases $@.aliases "$(modname_flags)" $(filter $(addprefix $(obj)/,$($(subst $(obj)/,,$(@:.ko=-objs))) $($(subst $(obj)/,,$(@:.ko=-y)))),$^)`
+module_link_hotplug-single = `$(CONFIG_SHELL) scripts/extract_aliases $@.aliases "$(modname_flags)" $<`
+endif
+
 quiet_cmd_link_multi-m = LD [M]  $@
-cmd_link_multi-m = $(LD) $(LDFLAGS) $(EXTRA_LDFLAGS) $(LDFLAGS_MODULE) -o $@ $(filter $(addprefix $(obj)/,$($(subst $(obj)/,,$(@:.ko=-objs))) $($(subst $(obj)/,,$(@:.ko=-y)))),$^) init/vermagic.o
+cmd_link_multi-m = $(LD) $(LDFLAGS) $(EXTRA_LDFLAGS) $(LDFLAGS_MODULE) -o $@ $(filter $(addprefix $(obj)/,$($(subst $(obj)/,,$(@:.ko=-objs))) $($(subst $(obj)/,,$(@:.ko=-y)))),$^) $(module_link_hotplug-multi) init/vermagic.o 
 
 quiet_cmd_link_single-m = LD [M]  $@
-cmd_link_single-m = $(LD) $(LDFLAGS) $(EXTRA_LDFLAGS) $(LDFLAGS_MODULE) -o $@ $< init/vermagic.o
+cmd_link_single-m = $(LD) $(LDFLAGS) $(EXTRA_LDFLAGS) $(LDFLAGS_MODULE) -o $@ $< init/vermagic.o $(module_link_hotplug-single)
 
 # Don't rebuilt vermagic.o unless we actually are in the init/ dir
 ifneq ($(obj),init)
diff -urNp --exclude TAGS -X /home/rusty/current-dontdiff --minimal linux-2.5.59/scripts/extract_aliases working-2.5.59-alias/scripts/extract_aliases
--- linux-2.5.59/scripts/extract_aliases	1970-01-01 10:00:00.000000000 +1000
+++ working-2.5.59-alias/scripts/extract_aliases	2003-01-30 18:06:59.000000000 +1100
@@ -0,0 +1,21 @@
+#! /bin/sh
+
+# Look for module tables, and if found, put them in the object file
+# and print its name.
+set -e
+
+OUTPUT="$1"
+MODNAME_FLAGS="$2"
+shift 2
+
+$NM --no-sort --print-size --radix=d --print-file-name "$@" | 
+    grep '__mod_[a-z_]*_table' | 
+    while IFS=": " read FILE OFFSET SIZE TYPE NAME; do
+	scripts/table2alias $NAME $FILE $OFFSET $SIZE
+    done > $OUTPUT.c
+
+if [ -s $OUTPUT.c ]; then
+    $CC $CFLAGS $NOSTDINC_FLAGS $EXTRA_CFLAGS $MODNAME_FLAGS -DMODULE -include include/linux/module.h -c -o $OUTPUT.o $OUTPUT.c
+    echo $OUTPUT.o
+fi
+rm $OUTPUT.c
diff -urNp --exclude TAGS -X /home/rusty/current-dontdiff --minimal linux-2.5.59/scripts/table2alias.c working-2.5.59-alias/scripts/table2alias.c
--- linux-2.5.59/scripts/table2alias.c	1970-01-01 10:00:00.000000000 +1000
+++ working-2.5.59-alias/scripts/table2alias.c	2003-01-30 17:49:45.000000000 +1100
@@ -0,0 +1,244 @@
+/* Simple code to turn various tables into module aliases.
+   This deals with kernel datastructures where they should be
+   dealt with: in the kernel source.
+   (C) 2002 Rusty Russell IBM Corporation.
+*/
+#include <stdint.h>
+#include <stdio.h>
+#include <fcntl.h>
+#include <string.h>
+#include <errno.h>
+#include <unistd.h>
+#include <stdlib.h>
+#include <string.h>
+
+/* We need __LITTLE_ENDIAN/__BIG_ENDIAN and BITS_PER_LONG */
+#define __KERNEL__
+#include "../include/asm/byteorder.h"
+#include "../include/asm/types.h"
+
+#if BITS_PER_LONG == 32
+typedef uint32_t kernel_long_t;
+#elif BITS_PER_LONG == 64
+typedef uint64_t kernel_long_t;
+#else
+#error Unknown BITS_PER_LONG
+#endif
+
+/* If we're cross-compiling, we could have any wierd endian
+   combination.  Keep it simple. */
+static kernel_long_t __to_native(unsigned char *ptr, unsigned int size)
+{
+        unsigned int i;
+        kernel_long_t ret = 0;
+
+#ifdef __LITTLE_ENDIAN
+        for (i = 0; i < size; i++)
+                ret += ((unsigned long long)ptr[size - 1 - i]) << (i * 8);
+#elif defined(__BIG_ENDIAN)
+        for (i = 0; i < size; i++)
+                ret += ((unsigned long long)ptr[i]) << (i * 8);
+#else
+#error Must be big or little endian.
+#endif
+	return ret;
+}
+
+#define TO_NATIVE(x) (x) = __to_native((void *)&(x), sizeof(x))
+
+#define USB_DEVICE_ID_MATCH_VENDOR              0x0001
+#define USB_DEVICE_ID_MATCH_PRODUCT             0x0002
+#define USB_DEVICE_ID_MATCH_DEV_LO              0x0004
+#define USB_DEVICE_ID_MATCH_DEV_HI              0x0008
+#define USB_DEVICE_ID_MATCH_DEV_CLASS           0x0010
+#define USB_DEVICE_ID_MATCH_DEV_SUBCLASS        0x0020
+#define USB_DEVICE_ID_MATCH_DEV_PROTOCOL        0x0040
+#define USB_DEVICE_ID_MATCH_INT_CLASS           0x0080
+#define USB_DEVICE_ID_MATCH_INT_SUBCLASS        0x0100
+#define USB_DEVICE_ID_MATCH_INT_PROTOCOL        0x0200
+
+struct usb_device_id {
+        /* which fields to match against? */
+        uint16_t        match_flags;
+
+        /* Used for product specific matches; range is inclusive */
+        uint16_t        idVendor;
+        uint16_t        idProduct;
+        uint16_t        bcdDevice_lo;
+        uint16_t        bcdDevice_hi;
+
+        /* Used for device class matches */
+        uint8_t         bDeviceClass;
+        uint8_t         bDeviceSubClass;
+        uint8_t         bDeviceProtocol;
+
+        /* Used for interface class matches */
+        uint8_t         bInterfaceClass;
+        uint8_t         bInterfaceSubClass;
+        uint8_t         bInterfaceProtocol;
+
+        /* not matched against */
+        kernel_long_t   driver_info;
+};
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
+static void do_usb_table(struct usb_device_id *ids, unsigned int size,
+			 const char *filename)
+{
+	unsigned int i;
+        char alias[200];
+
+	/* Should be exact multiple. */
+	if (size % sizeof(ids[0]))
+		fprintf(stderr, "WARNING: %s USB ids size has %u left\n",
+			filename, size % sizeof(ids[0]));
+	for (i = 0; i < size / sizeof(ids[0]); i++) {
+                TO_NATIVE(ids[i].match_flags);
+                TO_NATIVE(ids[i].idVendor);
+                TO_NATIVE(ids[i].idProduct);
+                TO_NATIVE(ids[i].bcdDevice_lo);
+                TO_NATIVE(ids[i].bcdDevice_hi);
+
+                strcpy(alias, "usb:");
+                ADD(alias, "v", ids[i].match_flags&USB_DEVICE_ID_MATCH_VENDOR,
+                    ids[i].idVendor);
+                ADD(alias, "p", ids[i].match_flags&USB_DEVICE_ID_MATCH_PRODUCT,
+                    ids[i].idProduct);
+                ADD(alias, "dl", ids[i].match_flags&USB_DEVICE_ID_MATCH_DEV_LO,
+                    ids[i].bcdDevice_lo);
+                ADD(alias, "dh", ids[i].match_flags&USB_DEVICE_ID_MATCH_DEV_HI,
+                    ids[i].bcdDevice_hi);
+                ADD(alias, "dc", ids[i].match_flags&USB_DEVICE_ID_MATCH_DEV_CLASS,
+                    ids[i].bDeviceClass);
+                ADD(alias, "dsc",
+		    ids[i].match_flags&USB_DEVICE_ID_MATCH_DEV_SUBCLASS,
+                    ids[i].bDeviceSubClass);
+                ADD(alias, "dp",
+		    ids[i].match_flags&USB_DEVICE_ID_MATCH_DEV_PROTOCOL,
+                    ids[i].bDeviceProtocol);
+                ADD(alias, "ic",
+		    ids[i].match_flags&USB_DEVICE_ID_MATCH_INT_CLASS,
+                    ids[i].bInterfaceClass);
+                ADD(alias, "isc",
+		    ids[i].match_flags&USB_DEVICE_ID_MATCH_INT_SUBCLASS,
+                    ids[i].bInterfaceSubClass);
+                ADD(alias, "ip",
+		    ids[i].match_flags&USB_DEVICE_ID_MATCH_INT_PROTOCOL,
+                    ids[i].bInterfaceProtocol);
+		/* Always end in a wildcard, for future extension */
+		if (alias[strlen(alias)-1] != '*')
+			strcat(alias, "*");
+                printf("MODULE_ALIAS(\"%s\");\n", alias);
+        }
+}
+
+#define PCI_ANY_ID (~0)
+
+struct pci_device_id {
+        unsigned int vendor, device;   /* Vendor and device ID or PCI_ANY_ID */
+        unsigned int subvendor, subdevice; /* Subsystem ID's or PCI_ANY_ID */
+        unsigned int class, class_mask; /* (class,subclass,prog-if) triplet */
+        kernel_long_t driver_data;        /* Data private to the driver */
+};
+
+/* Looks like: pci:vNdNsvNsdNcN. */
+static void do_pci_table(struct pci_device_id *ids, unsigned int size,
+			 const char *filename)
+{
+	unsigned int i;
+        char alias[200];
+
+	/* Should be exact multiple. */
+	if (size % sizeof(ids[0]))
+		fprintf(stderr, "WARNING: %s PCI ids size has %u left\n",
+			filename, size % sizeof(ids[0]));
+	for (i = 0; i < size / sizeof(ids[0]); i++) {
+                TO_NATIVE(ids[i].vendor);
+                TO_NATIVE(ids[i].device);
+                TO_NATIVE(ids[i].subvendor);
+                TO_NATIVE(ids[i].subdevice);
+                TO_NATIVE(ids[i].class);
+                TO_NATIVE(ids[i].class_mask);
+
+                strcpy(alias, "pci:");
+                ADD(alias, "v", ids[i].vendor != PCI_ANY_ID, ids[i].vendor);
+                ADD(alias, "d", ids[i].device != PCI_ANY_ID, ids[i].device);
+                ADD(alias, "sv", ids[i].subvendor != PCI_ANY_ID, ids[i].subvendor);
+                ADD(alias, "sd", ids[i].subdevice != PCI_ANY_ID, ids[i].subdevice);
+                if (ids[i].class_mask != 0 && ids[i].class_mask != ~0) {
+                        fprintf(stderr,
+				"Can't handle strange class_mask in %s:%04X\n",
+				filename, ids[i].class_mask);
+                        exit(1);
+                }
+                ADD(alias, "c", ids[i].class != PCI_ANY_ID, ids[i].subvendor);
+		/* Always end in a wildcard, for future extension */
+		if (alias[strlen(alias)-1] != '*')
+			strcat(alias, "*");
+                printf("MODULE_ALIAS(\"%s\");\n", alias);
+        }
+}
+
+int main(int argc, char *argv[])
+{
+	int ret, fd;
+	unsigned int size, offset;
+	void *file;
+
+        if (argc != 5) {
+                fprintf(stderr,
+                        "Usage: table2alias <type> <file> <offset> <size>\n"
+                        "  Where type is __mod_{pci, usb}_device_table.\n");
+                exit(1);
+        }
+
+	/* Suck it in. */
+	offset = atoi(argv[3]);
+	size = atoi(argv[4]);
+	file = malloc(size);
+
+	fd = open(argv[2], O_RDONLY);
+	if (fd < 0) {
+		fprintf(stderr, "opening %s: %s\n", argv[2], strerror(errno));
+		exit(1);
+	}
+	if (lseek(fd, offset, SEEK_SET) == (off_t)-1) {
+		fprintf(stderr, "seeking to %u in %s: %s\n",
+			offset, argv[2], strerror(errno));
+		exit(1);
+	}
+
+	offset = 0;
+	while (offset < size) {
+		ret = read(fd, file+offset, size-offset);
+		if (ret < 0) {
+			fprintf(stderr, "reading from %s: %s\n",
+				argv[2], strerror(errno));
+			exit(1);
+		}
+		offset += ret;
+	} 
+
+        if (strcmp(argv[1], "__mod_usb_device_table") == 0)
+                do_usb_table(file, size, argv[2]);
+        else if (strcmp(argv[1], "__mod_pci_device_table") == 0)
+                do_pci_table(file, size, argv[2]);
+        else {
+                fprintf(stderr, "table2alias: unknown type %s\n", argv[1]);
+                exit(1);
+        }
+        exit(0);
+}

--
  Anyone who quotes me in their sig is an idiot. -- Rusty Russell.
