Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S144034AbRAHPxG>; Mon, 8 Jan 2001 10:53:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S143977AbRAHPw4>; Mon, 8 Jan 2001 10:52:56 -0500
Received: from ppp0.ocs.com.au ([203.34.97.3]:12549 "HELO mail.ocs.com.au")
	by vger.kernel.org with SMTP id <S143676AbRAHPwj>;
	Mon, 8 Jan 2001 10:52:39 -0500
X-Mailer: exmh version 2.1.1 10/15/1999
From: Keith Owens <kaos@ocs.com.au>
To: linux-kernel@vger.kernel.org
Cc: linux-hotplug-devel@lists.sourceforge.net,
        linux-usb-devel@lists.sourceforge.net
Subject: Announce: modutils 2.4.1 is available 
Date: Tue, 09 Jan 2001 02:52:28 +1100
Message-ID: <4094.978969148@ocs3.ocs-net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

Content-Type: text/plain; charset=us-ascii

In the absence of any screams of pain from the usb list, modutils 2.4.1
is released for your enjoyment.

ftp://ftp.<country>.kernel.org/pub/linux/utils/kernel/modutils/v2.4

modutils-2.4.1.tar.gz           Source tarball, includes RPM spec file
modutils-2.4.1-1.src.rpm        As above, in SRPM format
modutils-2.4.1-1.i386.rpm       Compiled with egcs-2.91.66, glibc 2.1.2
modutils-2.4.1-1.sparc.rpm      Compiled for combined sparc 32/64
patch-modutils-2.4.1.gz		Patch from modutils 2.4.0 to 2.4.1.

Related kernel patches.

patch-2.4.0-hotplug.gz          Correctly handle USB modules in kernel 2.4.0.
				The fix adds a version number to tables read by
				depmod, this affects all kernel hotplug tables,
				not just USB.  Required for USB on 2.4.0.

patch-2.4.0-persistent.gz	Adds persistent data and generic string
				support to kernel 2.4.0.  Optional.

Changelog extract

	* Cast 2*sizeof to int in printf, new gcc warns about this.
	* Add an optional version number to kernel tables.
	* Handle version 1 and 2 usb device tables.
	* man lsmod documents use count -1.

NOTE:

  Handling the change of format for the USB tables highlighted the need
for the kernel to include a version number against each table to tell
depmod which format table it is processing.  Checking for a change in
table size was not enough.  You _must_ apply patch-2.4.0-hotplug to
2.4.0 kernels in order to pick up the new USB table format. You will
also need a new set of USB utilities that understand match_flags.

  patch-2.4.0-hotplug hits all hotplug tables, not just USB.  The
kernel and modutils changes are forward and backward compatible; old
kernels will run with new modutils and vice versa.  The only
combination not supported is USB hotplugging in an unpatched kernel
2.4.0, there is no way for any version of modutils to detect which
format USB table is being used in unpatched 2.4.0 kernels.

patch-2.4.0-hotplug follows for reference, it is also in the URL at the
top of this mail.  With any luck this patch will be included in kernel
2.4.1.

Index: 0.1/include/linux/usb.h
- --- 0.1/include/linux/usb.h Fri, 05 Jan 2001 13:42:29 +1100 kaos (linux-2.4/Z/38_usb.h 1.1 644)
+++ 0.1(w)/include/linux/usb.h Sun, 07 Jan 2001 22:36:31 +1100 kaos (linux-2.4/Z/38_usb.h 1.1 644)
@@ -344,12 +344,18 @@ struct usb_device;
 #define USB_INTERFACE_INFO(cl,sc,pr) \
 	match_flags: USB_DEVICE_ID_MATCH_INT_INFO, bInterfaceClass: (cl), bInterfaceSubClass: (sc), bInterfaceProtocol: (pr)
 
- -struct usb_device_id {
- -	/* This bitmask is used to determine which of the following fields
- -	 * are to be used for matching.
- -	 */
- -	__u16		match_flags;
+/* match_flags added in 2.4.0 but at the start which messed up depmod.
+ * match_flags moved to before driver_info in 2.4.1 by KAO, you also need
+ * modutils 2.4.1.  USB modules cannot be supported in kernel 2.4.0,
+ * insufficient data to detect which table format is being used.
+ *
+ * Do NOT change this table format without checking with the modutils
+ * maintainer.  This is an ABI visible structure.
+ */
+
+#define usb_device_id_ver	2	/* Version 2 table */
 
+struct usb_device_id {
 	/*
 	 * vendor/product codes are checked, if vendor is nonzero
 	 * Range is for device revision (bcdDevice), inclusive;
@@ -374,6 +380,11 @@ struct usb_device_id {
 	__u8		bInterfaceClass;
 	__u8		bInterfaceSubClass;
 	__u8		bInterfaceProtocol;
+
+	/* This bitmask is used to determine which of the preceding fields
+	 * are to be used for matching.
+	 */
+	__u16		match_flags;	/* New in version 2 */
 
 	/*
 	 * for driver's use; not involved in driver matching.
Index: 0.1/include/linux/isapnp.h
- --- 0.1/include/linux/isapnp.h Fri, 05 Jan 2001 13:42:29 +1100 kaos (linux-2.4/b/b/11_isapnp.h 1.1 644)
+++ 0.1(w)/include/linux/isapnp.h Sun, 07 Jan 2001 22:36:40 +1100 kaos (linux-2.4/b/b/11_isapnp.h 1.1 644)
@@ -142,6 +142,16 @@ struct isapnp_resources {
 #define ISAPNP_CARD_TABLE(name) \
 		MODULE_GENERIC_TABLE(isapnp_card, name)
 
+/* Do NOT change the format of struct isapnp_card_id, struct isapnp_device_id or
+ * the value of ISAPNP_CARD_DEVS without checking with the modutils maintainer.
+ * These are ABI visible structures and defines.
+ *
+ * isapnp_device_id_ver is a single version number for the combination of
+ * struct isapnp_card_id and struct isapnp_device_id.
+ */
+
+#define isapnp_device_id_ver	1	/* Version 1 tables */
+
 struct isapnp_card_id {
 	unsigned long driver_data;	/* data private to the driver */
 	unsigned short card_vendor, card_device;
Index: 0.1/include/linux/module.h
- --- 0.1/include/linux/module.h Fri, 05 Jan 2001 13:42:29 +1100 kaos (linux-2.4/c/b/46_module.h 1.1 644)
+++ 0.1(w)/include/linux/module.h Sun, 07 Jan 2001 22:07:49 +1100 kaos (linux-2.4/c/b/46_module.h 1.1 644)
@@ -242,19 +242,17 @@ __attribute__((section(".modinfo"))) =		
  * isapnp - struct isapnp_device_id - List of ISA PnP ids supported by this module
  * usb - struct usb_device_id - List of USB ids supported by this module
  */
- -#define MODULE_GENERIC_TABLE(gtype,name)	\
- -static const unsigned long __module_##gtype##_size \
- -  __attribute__ ((unused)) = sizeof(struct gtype##_id); \
- -static const struct gtype##_id * __module_##gtype##_table \
- -  __attribute__ ((unused)) = name
- -#define MODULE_DEVICE_TABLE(type,name)		\
- -  MODULE_GENERIC_TABLE(type##_device,name)
- -/* not put to .modinfo section to avoid section type conflicts */
 
- -/* The attributes of a section are set the first time the section is
- -   seen; we want .modinfo to not be allocated.  */
+#define MODULE_GENERIC_TABLE(gtype,name)			\
+static const unsigned long __module_##gtype##_size		\
+  __attribute__ ((unused)) = sizeof(struct gtype##_id);		\
+static const unsigned long __module_##gtype##_ver		\
+  __attribute__ ((unused)) = gtype##_id_ver;			\
+static const struct gtype##_id * __module_##gtype##_table	\
+  __attribute__ ((unused)) = name
 
- -__asm__(".section .modinfo\n\t.previous");
+#define MODULE_DEVICE_TABLE(type,name)				\
+  MODULE_GENERIC_TABLE(type##_device,name)
 
 /* Define the module variable, and usage macros.  */
 extern struct module __this_module;
Index: 0.1/include/linux/pci.h
- --- 0.1/include/linux/pci.h Fri, 05 Jan 2001 13:42:29 +1100 kaos (linux-2.4/f/b/12_pci.h 1.1 644)
+++ 0.1(w)/include/linux/pci.h Sun, 07 Jan 2001 22:36:09 +1100 kaos (linux-2.4/f/b/12_pci.h 1.1 644)
@@ -439,6 +439,12 @@ struct pbus_set_ranges_data
 	unsigned long mem_start, mem_end;
 };
 
+/* Do NOT change this table format without checking with the modutils
+ * maintainer.  This is an ABI visible structure.
+ */
+
+#define pci_device_id_ver	1	/* Version 1 table */
+
 struct pci_device_id {
 	unsigned int vendor, device;		/* Vendor and device ID or PCI_ANY_ID */
 	unsigned int subvendor, subdevice;	/* Subsystem ID's or PCI_ANY_ID */
Index: 0.1/Documentation/Changes
- --- 0.1/Documentation/Changes Fri, 05 Jan 2001 13:42:29 +1100 kaos (linux-2.4/Z/c/26_Changes 1.1 644)
+++ 0.4(w)/Documentation/Changes Tue, 09 Jan 2001 02:43:44 +1100 kaos (linux-2.4/Z/c/26_Changes 1.1 644)
@@ -52,7 +52,7 @@ o  Gnu C                  2.91.66       
 o  Gnu make               3.77                    # make --version
 o  binutils               2.9.1.0.25              # ld -v
 o  util-linux             2.10o                   # fdformat --version
- -o  modutils               2.4.0                   # insmod -V
+o  modutils               2.4.1                   # insmod -V
 o  e2fsprogs              1.19                    # tune2fs --version
 o  pcmcia-cs              3.1.21                  # cardmgr -V
 o  PPP                    2.4.0                   # pppd --version

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.0.3 (GNU/Linux)
Comment: Exmh version 2.1.1 10/15/1999

iD8DBQE6WeI7i4UHNye0ZOoRAiN8AKCjJUdySf2E/+ATzXlLIUFSG98z3gCfe90s
7OfOOWmVFrfeQ2/5VWXTgPQ=
=0gRg
-----END PGP SIGNATURE-----

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
