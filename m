Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264673AbSKNAOn>; Wed, 13 Nov 2002 19:14:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264683AbSKNAOn>; Wed, 13 Nov 2002 19:14:43 -0500
Received: from dp.samba.org ([66.70.73.150]:26074 "EHLO lists.samba.org")
	by vger.kernel.org with ESMTP id <S264673AbSKNAOg>;
	Wed, 13 Nov 2002 19:14:36 -0500
From: Rusty Russell <rusty@rustcorp.com.au>
To: linux-kernel@vger.kernel.org
Cc: Kai Germaschewski <kai@tp1.ruhr-uni-bochum.de>,
       Greg Kroah-Hartman <greg@kroah.com>, perex@suse.cz
Subject: [PATCH] Module alias and table support
Date: Thu, 14 Nov 2002 12:19:51 +1100
Message-Id: <20021114002129.477B72C236@lists.samba.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi guys,

	Below is a preliminary patch which implements module aliases
and reimplements support for MODULE_DEVICE_TABLE on top of it.  Tested
on drivers/usb/net/pegasus.c, seems to work.  The reason for doing
this is so that userspace tools are shielded from ever needing to know
the layout of the xxx_id structures.

	The idea that modules can contain a ".modalias" section of
strings which are aliases for the module.  Every module goes through a
"finishing" stage (scripts/modfinish) which looks for __module_table*
symbols and uses scripts/table2alias.c to add aliases such as
"usb:v0506p4601dl*dh*dc*dsc*dp*ic*isc*ip*" which hotplug can use to
probe for matching modules.

	You'll need the latest (experimental) version of
module-init-tools which support primitive aliases:

http://www.kernel.org/pub/linux/kernel/people/rusty/module-init-tools-0.7.tar.gz

Issues:
1) Make doesn't clean up xxx.raw.o files automatically for some reason
2) Might be neater to call the final result ".mod" and fix up the
   assumptions about ".o" in the current module-init-tools.
3) Should also create the *.map files at module install time, for
   backwards compatibility.
4) script is damn ugly, should probably turn into .c file once
   prototyping done.
5) pci_device, isapnp_card and isapnp_device need testing.

Feedback welcome,
Rusty.
--
  Anyone who quotes me in their sig is an idiot. -- Rusty Russell.

Name: Module alias and device table support
Author: Rusty Russell
Status: Experimental
Depends: Module/modfixes2.patch.gz
Depends: Module/module-ppc.patch.gz

D: Introduces "MODULE_ALIAS" which modules can use to embed their own
D: aliases for modprobe to use.  Also adds a "finishing" step to modules to
D: supplement their aliases based on MODULE_TABLE declarations, eg.
D: 'usb:v0506p4601dl*dh*dc*dsc*dp*ic*isc*ip*' for drivers/usb/net/pegasus.o

diff -urpN --exclude TAGS -X /home/rusty/devel/kernel/kernel-patches/current-dontdiff --minimal working-2.5-bk-devicetable-base/include/linux/module.h working-2.5-bk-devicetable/include/linux/module.h
--- working-2.5-bk-devicetable-base/include/linux/module.h	2002-11-14 02:29:34.000000000 +1100
+++ working-2.5-bk-devicetable/include/linux/module.h	2002-11-14 02:29:42.000000000 +1100
@@ -27,8 +27,6 @@
 #define MODULE_AUTHOR(name)
 #define MODULE_DESCRIPTION(desc)
 #define MODULE_SUPPORTED_DEVICE(name)
-#define MODULE_GENERIC_TABLE(gtype,name)
-#define MODULE_DEVICE_TABLE(type,name)
 #define MODULE_PARM_DESC(var,desc)
 #define print_symbol(format, addr)
 #define print_modules()
@@ -45,8 +43,26 @@ struct kernel_symbol
    a constant so it works in initializers. */
 extern struct module __this_module;
 #define THIS_MODULE (&__this_module)
+/* For userspace: you can also call me... */
+#define MODULE_ALIAS(alias)					\
+	static const char __alias_##__LINE__[]			\
+		__attribute__((section(".modalias"))) = alias
+
+/* Sets up aliases for hotplug-style automagic.  Known types are:
+   pci - struct pci_device_id - List of PCI ids supported
+   isapnp - struct isapnp_device_id - List of ISA PnP ids supported
+   usb - struct usb_device_id - List of USB ids supported
+*/
+#define MODULE_TABLE(type, table)				\
+	extern const struct type##_id __module_table_##type	\
+	__attribute__((alias(#table)))
+#define MODULE_DEVICE_TABLE(type, table)	\
+	MODULE_TABLE(type##_device, table)
 #else
 #define THIS_MODULE ((struct module *)0)
+#define MODULE_ALIAS(alias)
+#define MODULE_TABLE(type, table)
+#define MODULE_DEVICE_TABLE(type, table)
 #endif
 
 #ifdef CONFIG_MODULES
diff -urpN --exclude TAGS -X /home/rusty/devel/kernel/kernel-patches/current-dontdiff --minimal working-2.5-bk-devicetable-base/include/linux/isapnp.h working-2.5-bk-devicetable/include/linux/isapnp.h
--- working-2.5-bk-devicetable-base/include/linux/isapnp.h	2002-11-05 10:54:28.000000000 +1100
+++ working-2.5-bk-devicetable/include/linux/isapnp.h	2002-11-14 02:20:49.000000000 +1100
@@ -140,8 +140,9 @@ struct isapnp_resources {
 
 /* export used IDs outside module */
 #define ISAPNP_CARD_TABLE(name) \
-		MODULE_GENERIC_TABLE(isapnp_card, name)
+		MODULE_TABLE(isapnp_card, name)
 
+/* If you change this, you must update scripts/table2alias.c. */
 struct isapnp_card_id {
 	unsigned long driver_data;	/* data private to the driver */
 	unsigned short card_vendor, card_device;
@@ -156,6 +157,7 @@ struct isapnp_card_id {
 #define ISAPNP_DEVICE_SINGLE_END \
 		.card_vendor = 0, .card_device = 0
 
+/* If you change this, you must update scripts/table2alias.c. */
 struct isapnp_device_id {
 	unsigned short card_vendor, card_device;
 	unsigned short vendor, function;
diff -urpN --exclude TAGS -X /home/rusty/devel/kernel/kernel-patches/current-dontdiff --minimal working-2.5-bk-devicetable-base/include/linux/pci.h working-2.5-bk-devicetable/include/linux/pci.h
--- working-2.5-bk-devicetable-base/include/linux/pci.h	2002-11-11 20:01:05.000000000 +1100
+++ working-2.5-bk-devicetable/include/linux/pci.h	2002-11-14 01:42:24.000000000 +1100
@@ -467,6 +467,7 @@ struct pbus_set_ranges_data
 	unsigned long prefetch_start, prefetch_end;
 };
 
+/* If you change this, you must update scripts/table2alias.c. */
 struct pci_device_id {
 	unsigned int vendor, device;		/* Vendor and device ID or PCI_ANY_ID */
 	unsigned int subvendor, subdevice;	/* Subsystem ID's or PCI_ANY_ID */
diff -urpN --exclude TAGS -X /home/rusty/devel/kernel/kernel-patches/current-dontdiff --minimal working-2.5-bk-devicetable-base/include/linux/usb.h working-2.5-bk-devicetable/include/linux/usb.h
--- working-2.5-bk-devicetable-base/include/linux/usb.h	2002-10-31 12:37:02.000000000 +1100
+++ working-2.5-bk-devicetable/include/linux/usb.h	2002-11-14 01:42:36.000000000 +1100
@@ -361,6 +361,7 @@ static inline int usb_make_path (struct 
  * matches towards the beginning of your table, so that driver_info can
  * record quirks of specific products.
  */
+/* If you change this, you must update scripts/table2alias.c. */
 struct usb_device_id {
 	/* which fields to match against? */
 	__u16		match_flags;
diff -urpN --exclude TAGS -X /home/rusty/devel/kernel/kernel-patches/current-dontdiff --minimal working-2.5-bk-devicetable-base/scripts/Makefile working-2.5-bk-devicetable/scripts/Makefile
--- working-2.5-bk-devicetable-base/scripts/Makefile	2002-11-11 20:01:08.000000000 +1100
+++ working-2.5-bk-devicetable/scripts/Makefile	2002-11-14 02:51:45.000000000 +1100
@@ -8,7 +8,7 @@
 # docproc: 	 Preprocess .tmpl file in order to generate .sgml documentation
 # conmakehash:	 Create arrays for initializing the kernel console tables
 
-EXTRA_TARGETS := fixdep split-include docproc conmakehash
+EXTRA_TARGETS := fixdep split-include docproc conmakehash table2alias
 
 subdir-	:= lxdialog kconfig
 
@@ -22,7 +22,7 @@ KBUILD_BUILTIN := 1
 # can't do it
 # ---------------------------------------------------------------------------
 
-host-progs := fixdep split-include conmakehash docproc
+host-progs := fixdep split-include conmakehash docproc table2alias
 
 include $(TOPDIR)/Rules.make
 
diff -urpN --exclude TAGS -X /home/rusty/devel/kernel/kernel-patches/current-dontdiff --minimal working-2.5-bk-devicetable-base/scripts/Makefile.build working-2.5-bk-devicetable/scripts/Makefile.build
--- working-2.5-bk-devicetable-base/scripts/Makefile.build	2002-11-13 18:54:56.000000000 +1100
+++ working-2.5-bk-devicetable/scripts/Makefile.build	2002-11-14 03:41:30.000000000 +1100
@@ -91,7 +91,8 @@ cmd_cc_i_c       = $(CPP) $(c_flags)   -
 quiet_cmd_cc_o_c = CC      $@
 cmd_cc_o_c       = $(CC) $(c_flags) -c -o $@ $<
 
-%.o: %.c FORCE
+# Not for modules
+$(sort $(objs-y) $(multi-objs)) %.o: %.c FORCE
 	$(call if_changed_dep,cc_o_c)
 
 quiet_cmd_cc_lst_c = MKLST   $@
@@ -100,6 +101,16 @@ cmd_cc_lst_c       = $(CC) $(c_flags) -g
 %.lst: %.c FORCE
 	$(call if_changed_dep,cc_lst_c)
 
+# Modules need to go via "finishing" step.
+quiet_cmd_modfinish = FINISH   $@
+cmd_modfinish       = sh scripts/modfinish $< $@
+
+$(patsubst %.o,%.raw.o,$(filter-out $(multi-used-m),$(obj-m))): %.raw.o: %.c
+	$(call if_changed_dep,cc_o_c)
+
+$(obj-m): %.o: %.raw.o
+	$(call cmd,modfinish)
+
 # Compile assembler sources (.S)
 # ---------------------------------------------------------------------------
 
@@ -161,7 +172,7 @@ targets += $(L_TARGET)
 endif
 
 #
-# Rule to link composite objects
+# Rule to link composite objects (builtin)
 #
 
 quiet_cmd_link_multi = LD      $@
@@ -174,8 +185,16 @@ cmd_link_multi = $(LD) $(LDFLAGS) $(EXTR
 $(multi-used-y) : %.o: $(multi-objs-y) FORCE
 	$(call if_changed,link_multi)
 
-$(multi-used-m) : %.o: $(multi-objs-m) FORCE
-	$(call if_changed,link_multi)
+#
+# Rule to link composite objects (module)
+#
+
+quiet_cmd_link_mmulti = LD      $@
+cmd_link_mmulti = $(LD) $(LDFLAGS) $(EXTRA_LDFLAGS) -r -o $@ $(filter $(addprefix $(obj)/,$($(subst $(obj)/,,$(@:.raw.o=-objs))) $($(subst $(obj)/,,$(@:.raw.o=-y)))),$^)
+
+# Need finishing step
+$(multi-used-m:.o=.raw.o) : %.raw.o: $(multi-objs-m) FORCE
+	$(call if_changed,link_mmulti)
 
 targets += $(multi-used-y) $(multi-used-m)
 
diff -urpN --exclude TAGS -X /home/rusty/devel/kernel/kernel-patches/current-dontdiff --minimal working-2.5-bk-devicetable-base/scripts/modfinish working-2.5-bk-devicetable/scripts/modfinish
--- working-2.5-bk-devicetable-base/scripts/modfinish	1970-01-01 10:00:00.000000000 +1000
+++ working-2.5-bk-devicetable/scripts/modfinish	2002-11-14 03:43:06.000000000 +1100
@@ -0,0 +1,47 @@
+#! /bin/sh
+# Final "finishing" of a module.
+
+# Currently this consists of looking for __module_table_* and if found,
+# adding to the .alias section appropriately.
+
+set -e
+
+# Extract section $1 from objfile $2.
+extract_section()
+{
+    # Bitch to parse:
+    # [ 6] .comment          PROGBITS        00000000 0003d0 000030 00...
+    readelf -S "$2" | fgrep -w -- "$1" | sed "s/.*$1//" | $AWK '{ print $3,$4 }' |
+    (read ES_OFF ES_SIZE
+     dd bs=1 skip=`printf %i 0x$ES_OFF` count=`printf %i 0x$ES_SIZE` if="$2" 2>/dev/null)
+}
+
+# Extract table $1 from objfile $2
+extract_table()
+{
+    $OBJDUMP -t "$2" | fgrep -w -- "$1" | $AWK '{print $1,$4,$5}' |
+    (read ET_OFF ET_SECTION ET_SIZE
+     extract_section $ET_SECTION "$2" | dd bs=1 skip=`printf %i 0x$ET_OFF` count=`printf %i 0x$ET_SIZE` 2>/dev/null)
+}
+
+TABLES=`$NM "$1" | grep '__module_table_*' | $AWK '{print $3}'`
+if [ x"$TABLES" = x ]; then
+    # Fastpath
+    cp "$1" "$2"
+    exit 0
+fi
+
+# Extract original aliases, if any.
+ALIASES=`extract_section .modalias "$1" | tr -s '\0' ' '`
+
+for table in $TABLES; do
+    ALIASES="$ALIASES $(extract_table $table $1 | scripts/table2alias $(echo $table | sed 's/__module_table_//') )"
+done
+
+# Make sure to clean up if we die here.
+trap "rm -f $1.aliases $2" 0
+echo $ALIASES | tr -s ' ' '\0' > $1.aliases
+$OBJCOPY --remove-section=.modalias --add-section .modalias=$1.aliases $1 $2
+trap "rm -f $1.aliases" 0
+exit 0
+
diff -urpN --exclude TAGS -X /home/rusty/devel/kernel/kernel-patches/current-dontdiff --minimal working-2.5-bk-devicetable-base/scripts/table2alias.c working-2.5-bk-devicetable/scripts/table2alias.c
--- working-2.5-bk-devicetable-base/scripts/table2alias.c	1970-01-01 10:00:00.000000000 +1000
+++ working-2.5-bk-devicetable/scripts/table2alias.c	2002-11-14 03:46:11.000000000 +1100
@@ -0,0 +1,316 @@
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
+
+/* We need __LITTLE_ENDIAN/__BIG_ENDIAN and BITS_PER_LONG */
+#define __KERNEL__
+#include "../include/asm/byteorder.h"
+#include "../include/asm/types.h"
+
+/* If we're cross-compiling, we could have any wierd endian
+   combination.  Keep it simple. */
+static unsigned long long __to_native(unsigned char *ptr,
+                                      unsigned int size)
+{
+        unsigned int i;
+        unsigned long long ret = 0;
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
+#if BITS_PER_LONG == 32
+typedef uint32_t kernel_long;
+#elif BITS_PER_LONG == 64
+typedef uint64_t kernel_long;
+#else
+#error Unknown BITS_PER_LONG
+#endif
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
+        kernel_long     driver_info;
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
+static int all_zeros(unsigned char *buf, unsigned int bufsize)
+{
+	unsigned int i;
+
+	for (i = 0; i < bufsize; i++)
+		if (buf[i] != 0)
+			return 0;
+	return 1;
+}
+
+static int xread(int fd, void *buf, unsigned int bufsize)
+{
+	int ret, done = 0;
+
+	while ((ret = read(fd, buf+done, bufsize-done)) > 0) {
+		done += ret;
+		if (done == bufsize) {
+			/* An all-zero entry also means "finish". */
+			if (all_zeros(buf, bufsize))
+				return 0;
+			return done;
+		}
+	}
+	if (done)
+		return done;
+	else return ret;
+}
+
+/* Looks like "usb:vNpNdlNdhNdcNdscNdpNicNiscNipN" */
+static int do_usb_table(void)
+{
+        struct usb_device_id id;
+        int r;
+        char alias[200];
+
+        while ((r = xread(STDIN_FILENO, &id, sizeof(id))) == sizeof(id)) {
+                TO_NATIVE(id.match_flags);
+                TO_NATIVE(id.idVendor);
+                TO_NATIVE(id.idProduct);
+                TO_NATIVE(id.bcdDevice_lo);
+                TO_NATIVE(id.bcdDevice_hi);
+
+                strcpy(alias, "usb:");
+                ADD(alias, "v", id.match_flags&USB_DEVICE_ID_MATCH_VENDOR,
+                    id.idVendor);
+                ADD(alias, "p", id.match_flags&USB_DEVICE_ID_MATCH_PRODUCT,
+                    id.idProduct);
+                ADD(alias, "dl", id.match_flags&USB_DEVICE_ID_MATCH_DEV_LO,
+                    id.bcdDevice_lo);
+                ADD(alias, "dh", id.match_flags&USB_DEVICE_ID_MATCH_DEV_HI,
+                    id.bcdDevice_hi);
+                ADD(alias, "dc", id.match_flags&USB_DEVICE_ID_MATCH_DEV_CLASS,
+                    id.bDeviceClass);
+                ADD(alias, "dsc",
+		    id.match_flags&USB_DEVICE_ID_MATCH_DEV_SUBCLASS,
+                    id.bDeviceSubClass);
+                ADD(alias, "dp",
+		    id.match_flags&USB_DEVICE_ID_MATCH_DEV_PROTOCOL,
+                    id.bDeviceProtocol);
+                ADD(alias, "ic",
+		    id.match_flags&USB_DEVICE_ID_MATCH_INT_CLASS,
+                    id.bInterfaceClass);
+                ADD(alias, "isc",
+		    id.match_flags&USB_DEVICE_ID_MATCH_INT_SUBCLASS,
+                    id.bInterfaceSubClass);
+                ADD(alias, "ip",
+		    id.match_flags&USB_DEVICE_ID_MATCH_INT_PROTOCOL,
+                    id.bInterfaceProtocol);
+                printf("%s\n", alias);
+        }
+	return r;
+}
+
+#define PCI_ANY_ID (~0)
+
+struct pci_device_id {
+        unsigned int vendor, device;   /* Vendor and device ID or PCI_ANY_ID */
+        unsigned int subvendor, subdevice; /* Subsystem ID's or PCI_ANY_ID */
+        unsigned int class, class_mask; /* (class,subclass,prog-if) triplet */
+        kernel_long driver_data;        /* Data private to the driver */
+};
+
+/* Looks like: pci:vNdNsvNsdNcN. */
+static int do_pci_table(void)
+{
+        struct pci_device_id id;
+        int r;
+        char alias[200];
+
+        while ((r = xread(STDIN_FILENO, &id, sizeof(id))) == sizeof(id)) {
+                TO_NATIVE(id.vendor);
+                TO_NATIVE(id.device);
+                TO_NATIVE(id.subvendor);
+                TO_NATIVE(id.subdevice);
+                TO_NATIVE(id.class);
+                TO_NATIVE(id.class_mask);
+
+                strcpy(alias, "pci:");
+                ADD(alias, "v", id.vendor != PCI_ANY_ID, id.vendor);
+                ADD(alias, "d", id.device != PCI_ANY_ID, id.device);
+                ADD(alias, "sv", id.subvendor != PCI_ANY_ID, id.subvendor);
+                ADD(alias, "sd", id.subdevice != PCI_ANY_ID, id.subdevice);
+                if (id.class_mask != 0 && id.class_mask != ~0) {
+                        fprintf(stderr,
+				"Can't handle strange class_mask: %04X\n",
+				id.class_mask);
+                        exit(1);
+                }
+                ADD(alias, "c", id.class != PCI_ANY_ID, id.subvendor);
+                printf("%s\n", alias);
+        }
+	return r;
+}
+
+#define ISAPNP_ANY_ID		0xffff
+#define ISAPNP_CARD_DEVS	8
+
+struct isapnp_card_id {
+	kernel_long driver_data;	/* data private to the driver */
+	unsigned short card_vendor, card_device;
+	struct {
+		unsigned short vendor, function;
+	} devs[ISAPNP_CARD_DEVS];	/* logical devices */
+};
+
+static int do_isapnp_card_table(void)
+{
+        struct isapnp_card_id id;
+        int r, i;
+        char alias[200];
+
+        while ((r = xread(STDIN_FILENO, &id, sizeof(id))) == sizeof(id)) {
+                TO_NATIVE(id.card_vendor);
+                TO_NATIVE(id.card_device);
+		for (i = 0; i < ISAPNP_CARD_DEVS; i++) {
+			TO_NATIVE(id.devs[i].vendor);
+			TO_NATIVE(id.devs[i].function);
+
+			if (id.devs[i].vendor || id.devs[i].function) {
+				strcpy(alias, "isapnpcard:");
+				ADD(alias, "v",
+				    id.card_vendor != ISAPNP_ANY_ID,
+				    id.card_vendor);
+				ADD(alias, "d",
+				    id.card_device != ISAPNP_ANY_ID,
+				    id.card_device);
+				ADD(alias, "dv", 1, id.devs[i].vendor);
+				ADD(alias, "df", 1, id.devs[i].function);
+				printf("%s\n", alias);
+			}
+		}
+	}
+	return r;
+}
+
+struct isapnp_device_id {
+	unsigned short card_vendor, card_device;
+	unsigned short vendor, function;
+	kernel_long driver_data;	/* data private to the driver */
+};
+
+static int do_isapnp_device_table(void)
+{
+        struct isapnp_device_id id;
+        int r;
+        char alias[200];
+
+        while ((r = xread(STDIN_FILENO, &id, sizeof(id))) == sizeof(id)) {
+                TO_NATIVE(id.card_vendor);
+                TO_NATIVE(id.card_device);
+                TO_NATIVE(id.vendor);
+                TO_NATIVE(id.function);
+
+                strcpy(alias, "isapnpdev:");
+                ADD(alias, "cv", id.card_vendor != ISAPNP_ANY_ID,
+		    id.card_vendor);
+                ADD(alias, "cd", id.card_device != ISAPNP_ANY_ID,
+		    id.card_device);
+                ADD(alias, "v", id.vendor != ISAPNP_ANY_ID, id.vendor);
+                ADD(alias, "f", id.function != ISAPNP_ANY_ID, id.function);
+                printf("%s\n", alias);
+        }
+	return r;
+}
+
+int main(int argc, char *argv[])
+{
+	int ret;
+
+        if (argc != 2) {
+                fprintf(stderr,
+                        "Usage: table2alias <type>\n"
+                        "  Where type is pci_device, usb_device, isapnp_card or isapnp_device.\n"
+                        "  The binary table is fed in stdin\n");
+                exit(1);
+        }
+
+        if (strcmp(argv[1], "usb_device") == 0)
+                ret = do_usb_table();
+        else if (strcmp(argv[1], "pci_device") == 0)
+                ret = do_pci_table();
+        else if (strcmp(argv[1], "isapnp_card") == 0)
+                ret = do_isapnp_card_table();
+        else if (strcmp(argv[1], "isapnp_device") == 0)
+                ret = do_isapnp_device_table();
+        else {
+                fprintf(stderr, "table2alias: unknown type %s\n", argv[1]);
+                exit(1);
+        }
+
+	if (ret > 0) {
+		fprintf(stderr,"table2alias: %s table size wrong (%i)?\n",
+			argv[1], ret);
+                exit(1);
+	} else if (ret < 0) {
+		fprintf(stderr,"table2alias: reading %s table: %s\n", argv[1],
+			strerror(errno));
+                exit(1);
+        }
+        exit(0);
+}
