Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262129AbUCQXJm (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 17 Mar 2004 18:09:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262147AbUCQXJl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 17 Mar 2004 18:09:41 -0500
Received: from lists.us.dell.com ([143.166.224.162]:42685 "EHLO
	lists.us.dell.com") by vger.kernel.org with ESMTP id S262129AbUCQXIN
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 17 Mar 2004 18:08:13 -0500
Date: Wed, 17 Mar 2004 17:07:36 -0600
From: Matt Domsch <Matt_Domsch@dell.com>
To: akpm@osdl.org
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH 1/3] move EDD code from i386-specific locations to generic
Message-ID: <20040317230736.GB30399@lists.us.dell.com>
References: <20040317230540.GA30399@lists.us.dell.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="xgyAXRrhYN0wYx8y"
Content-Disposition: inline
In-Reply-To: <20040317230540.GA30399@lists.us.dell.com>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--xgyAXRrhYN0wYx8y
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

EDD: move edd.h from include/asm-i386 to include/linux

Fix reference in setup.c=20

 b/arch/i386/kernel/setup.c |    2=20
 b/include/linux/edd.h      |  181 ++++++++++++++++++++++++++++++++++++++++=
+++++
 include/asm-i386/edd.h     |  180 ----------------------------------------=
----
 3 files changed, 182 insertions, 181 deletions

--=20
Matt Domsch
Sr. Software Engineer, Lead Engineer
Dell Linux Solutions linux.dell.com & www.dell.com/linux
Linux on Dell mailing lists @ http://lists.us.dell.com

diff -Nru a/include/asm-i386/edd.h b/include/asm-i386/edd.h
--- a/include/asm-i386/edd.h	Tue Mar 16 10:03:36 2004
+++ /dev/null	Wed Dec 31 16:00:00 1969
@@ -1,180 +0,0 @@
-/*
- * linux/include/asm-i386/edd.h
- *  Copyright (C) 2002, 2003 Dell Inc.
- *  by Matt Domsch <Matt_Domsch@dell.com>
- *
- * structures and definitions for the int 13h, ax=3D{41,48}h
- * BIOS Enhanced Disk Drive Services
- * This is based on the T13 group document D1572 Revision 0 (August 14 200=
2)
- * available at http://www.t13.org/docs2002/d1572r0.pdf.  It is
- * very similar to D1484 Revision 3 http://www.t13.org/docs2002/d1484r3.pdf
- *
- * In a nutshell, arch/i386/boot/setup.S populates a scratch table
- * in the empty_zero_block that contains a list of BIOS-enumerated
- * boot devices.
- * In arch/i386/kernel/setup.c, this information is
- * transferred into the edd structure, and in arch/i386/kernel/edd.c, that
- * information is used to identify BIOS boot disk.  The code in setup.S
- * is very sensitive to the size of these structures.
- *
- * This program is free software; you can redistribute it and/or modify
- * it under the terms of the GNU General Public License v2.0 as published =
by
- * the Free Software Foundation
- *
- * This program is distributed in the hope that it will be useful,
- * but WITHOUT ANY WARRANTY; without even the implied warranty of
- * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
- * GNU General Public License for more details.
- *
- */
-#ifndef _ASM_I386_EDD_H
-#define _ASM_I386_EDD_H
-
-#define EDDNR 0x1e9		/* addr of number of edd_info structs at EDDBUF
-				   in empty_zero_block - treat this as 1 byte  */
-#define EDDBUF	0x600		/* addr of edd_info structs in empty_zero_block */
-#define EDDMAXNR 6		/* number of edd_info structs starting at EDDBUF  */
-#define EDDEXTSIZE 8		/* change these if you muck with the structures */
-#define EDDPARMSIZE 74
-#define CHECKEXTENSIONSPRESENT 0x41
-#define GETDEVICEPARAMETERS 0x48
-#define LEGACYGETDEVICEPARAMETERS 0x08
-#define EDDMAGIC1 0x55AA
-#define EDDMAGIC2 0xAA55
-
-#define READ_SECTORS 0x02
-#define MBR_SIG_OFFSET 0x1B8
-#define DISK80_SIG_BUFFER 0x2cc
-#ifndef __ASSEMBLY__
-
-#define EDD_EXT_FIXED_DISK_ACCESS           (1 << 0)
-#define EDD_EXT_DEVICE_LOCKING_AND_EJECTING (1 << 1)
-#define EDD_EXT_ENHANCED_DISK_DRIVE_SUPPORT (1 << 2)
-#define EDD_EXT_64BIT_EXTENSIONS            (1 << 3)
-
-#define EDD_INFO_DMA_BOUNDARY_ERROR_TRANSPARENT (1 << 0)
-#define EDD_INFO_GEOMETRY_VALID                (1 << 1)
-#define EDD_INFO_REMOVABLE                     (1 << 2)
-#define EDD_INFO_WRITE_VERIFY                  (1 << 3)
-#define EDD_INFO_MEDIA_CHANGE_NOTIFICATION     (1 << 4)
-#define EDD_INFO_LOCKABLE                      (1 << 5)
-#define EDD_INFO_NO_MEDIA_PRESENT              (1 << 6)
-#define EDD_INFO_USE_INT13_FN50                (1 << 7)
-
-struct edd_device_params {
-	u16 length;
-	u16 info_flags;
-	u32 num_default_cylinders;
-	u32 num_default_heads;
-	u32 sectors_per_track;
-	u64 number_of_sectors;
-	u16 bytes_per_sector;
-	u32 dpte_ptr;		/* 0xFFFFFFFF for our purposes */
-	u16 key;		/* =3D 0xBEDD */
-	u8 device_path_info_length;	/* =3D 44 */
-	u8 reserved2;
-	u16 reserved3;
-	u8 host_bus_type[4];
-	u8 interface_type[8];
-	union {
-		struct {
-			u16 base_address;
-			u16 reserved1;
-			u32 reserved2;
-		} __attribute__ ((packed)) isa;
-		struct {
-			u8 bus;
-			u8 slot;
-			u8 function;
-			u8 channel;
-			u32 reserved;
-		} __attribute__ ((packed)) pci;
-		/* pcix is same as pci */
-		struct {
-			u64 reserved;
-		} __attribute__ ((packed)) ibnd;
-		struct {
-			u64 reserved;
-		} __attribute__ ((packed)) xprs;
-		struct {
-			u64 reserved;
-		} __attribute__ ((packed)) htpt;
-		struct {
-			u64 reserved;
-		} __attribute__ ((packed)) unknown;
-	} interface_path;
-	union {
-		struct {
-			u8 device;
-			u8 reserved1;
-			u16 reserved2;
-			u32 reserved3;
-			u64 reserved4;
-		} __attribute__ ((packed)) ata;
-		struct {
-			u8 device;
-			u8 lun;
-			u8 reserved1;
-			u8 reserved2;
-			u32 reserved3;
-			u64 reserved4;
-		} __attribute__ ((packed)) atapi;
-		struct {
-			u16 id;
-			u64 lun;
-			u16 reserved1;
-			u32 reserved2;
-		} __attribute__ ((packed)) scsi;
-		struct {
-			u64 serial_number;
-			u64 reserved;
-		} __attribute__ ((packed)) usb;
-		struct {
-			u64 eui;
-			u64 reserved;
-		} __attribute__ ((packed)) i1394;
-		struct {
-			u64 wwid;
-			u64 lun;
-		} __attribute__ ((packed)) fibre;
-		struct {
-			u64 identity_tag;
-			u64 reserved;
-		} __attribute__ ((packed)) i2o;
-		struct {
-			u32 array_number;
-			u32 reserved1;
-			u64 reserved2;
-		} __attribute__ ((packed)) raid;
-		struct {
-			u8 device;
-			u8 reserved1;
-			u16 reserved2;
-			u32 reserved3;
-			u64 reserved4;
-		} __attribute__ ((packed)) sata;
-		struct {
-			u64 reserved1;
-			u64 reserved2;
-		} __attribute__ ((packed)) unknown;
-	} device_path;
-	u8 reserved4;
-	u8 checksum;
-} __attribute__ ((packed));
-
-struct edd_info {
-	u8 device;
-	u8 version;
-	u16 interface_support;
-	u16 legacy_cylinders;
-	u8 legacy_heads;
-	u8 legacy_sectors;
-	struct edd_device_params params;
-} __attribute__ ((packed));
-
-extern struct edd_info edd[EDDMAXNR];
-extern unsigned char eddnr;
-extern unsigned int edd_disk80_sig;
-#endif				/*!__ASSEMBLY__ */
-
-#endif				/* _ASM_I386_EDD_H */
diff -Nru a/include/linux/edd.h b/include/linux/edd.h
--- /dev/null	Wed Dec 31 16:00:00 1969
+++ b/include/linux/edd.h	Tue Mar 16 10:03:36 2004
@@ -0,0 +1,181 @@
+/*
+ * linux/include/linux/edd.h
+ *  Copyright (C) 2002, 2003 Dell Inc.
+ *  by Matt Domsch <Matt_Domsch@dell.com>
+ *
+ * structures and definitions for the int 13h, ax=3D{41,48}h
+ * BIOS Enhanced Disk Drive Services
+ * This is based on the T13 group document D1572 Revision 0 (August 14 200=
2)
+ * available at http://www.t13.org/docs2002/d1572r0.pdf.  It is
+ * very similar to D1484 Revision 3 http://www.t13.org/docs2002/d1484r3.pdf
+ *
+ * In a nutshell, arch/{i386,x86_64}/boot/setup.S populates a scratch table
+ * in the empty_zero_block that contains a list of BIOS-enumerated
+ * boot devices.
+ * In arch/{i386,x86_64}/kernel/setup.c, this information is
+ * transferred into the edd structure, and in drivers/firmware/edd.c, that
+ * information is used to identify BIOS boot disk.  The code in setup.S
+ * is very sensitive to the size of these structures.
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License v2.0 as published =
by
+ * the Free Software Foundation
+ *
+ * This program is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ * GNU General Public License for more details.
+ *
+ */
+#ifndef _LINUX_EDD_H
+#define _LINUX_EDD_H
+
+#define EDDNR 0x1e9		/* addr of number of edd_info structs at EDDBUF
+				   in empty_zero_block - treat this as 1 byte  */
+#define EDDBUF	0x600		/* addr of edd_info structs in empty_zero_block */
+#define EDDMAXNR 6		/* number of edd_info structs starting at EDDBUF  */
+#define EDDEXTSIZE 8		/* change these if you muck with the structures */
+#define EDDPARMSIZE 74
+#define CHECKEXTENSIONSPRESENT 0x41
+#define GETDEVICEPARAMETERS 0x48
+#define LEGACYGETDEVICEPARAMETERS 0x08
+#define EDDMAGIC1 0x55AA
+#define EDDMAGIC2 0xAA55
+
+#define READ_SECTORS 0x02
+#define MBR_SIG_OFFSET 0x1B8
+#define DISK80_SIG_BUFFER 0x2cc
+#ifndef __ASSEMBLY__
+
+#define EDD_EXT_FIXED_DISK_ACCESS           (1 << 0)
+#define EDD_EXT_DEVICE_LOCKING_AND_EJECTING (1 << 1)
+#define EDD_EXT_ENHANCED_DISK_DRIVE_SUPPORT (1 << 2)
+#define EDD_EXT_64BIT_EXTENSIONS            (1 << 3)
+
+#define EDD_INFO_DMA_BOUNDARY_ERROR_TRANSPARENT (1 << 0)
+#define EDD_INFO_GEOMETRY_VALID                (1 << 1)
+#define EDD_INFO_REMOVABLE                     (1 << 2)
+#define EDD_INFO_WRITE_VERIFY                  (1 << 3)
+#define EDD_INFO_MEDIA_CHANGE_NOTIFICATION     (1 << 4)
+#define EDD_INFO_LOCKABLE                      (1 << 5)
+#define EDD_INFO_NO_MEDIA_PRESENT              (1 << 6)
+#define EDD_INFO_USE_INT13_FN50                (1 << 7)
+
+struct edd_device_params {
+	u16 length;
+	u16 info_flags;
+	u32 num_default_cylinders;
+	u32 num_default_heads;
+	u32 sectors_per_track;
+	u64 number_of_sectors;
+	u16 bytes_per_sector;
+	u32 dpte_ptr;		/* 0xFFFFFFFF for our purposes */
+	u16 key;		/* =3D 0xBEDD */
+	u8 device_path_info_length;	/* =3D 44 */
+	u8 reserved2;
+	u16 reserved3;
+	u8 host_bus_type[4];
+	u8 interface_type[8];
+	union {
+		struct {
+			u16 base_address;
+			u16 reserved1;
+			u32 reserved2;
+		} __attribute__ ((packed)) isa;
+		struct {
+			u8 bus;
+			u8 slot;
+			u8 function;
+			u8 channel;
+			u32 reserved;
+		} __attribute__ ((packed)) pci;
+		/* pcix is same as pci */
+		struct {
+			u64 reserved;
+		} __attribute__ ((packed)) ibnd;
+		struct {
+			u64 reserved;
+		} __attribute__ ((packed)) xprs;
+		struct {
+			u64 reserved;
+		} __attribute__ ((packed)) htpt;
+		struct {
+			u64 reserved;
+		} __attribute__ ((packed)) unknown;
+	} interface_path;
+	union {
+		struct {
+			u8 device;
+			u8 reserved1;
+			u16 reserved2;
+			u32 reserved3;
+			u64 reserved4;
+		} __attribute__ ((packed)) ata;
+		struct {
+			u8 device;
+			u8 lun;
+			u8 reserved1;
+			u8 reserved2;
+			u32 reserved3;
+			u64 reserved4;
+		} __attribute__ ((packed)) atapi;
+		struct {
+			u16 id;
+			u64 lun;
+			u16 reserved1;
+			u32 reserved2;
+		} __attribute__ ((packed)) scsi;
+		struct {
+			u64 serial_number;
+			u64 reserved;
+		} __attribute__ ((packed)) usb;
+		struct {
+			u64 eui;
+			u64 reserved;
+		} __attribute__ ((packed)) i1394;
+		struct {
+			u64 wwid;
+			u64 lun;
+		} __attribute__ ((packed)) fibre;
+		struct {
+			u64 identity_tag;
+			u64 reserved;
+		} __attribute__ ((packed)) i2o;
+		struct {
+			u32 array_number;
+			u32 reserved1;
+			u64 reserved2;
+		} __attribute__ ((packed)) raid;
+		struct {
+			u8 device;
+			u8 reserved1;
+			u16 reserved2;
+			u32 reserved3;
+			u64 reserved4;
+		} __attribute__ ((packed)) sata;
+		struct {
+			u64 reserved1;
+			u64 reserved2;
+		} __attribute__ ((packed)) unknown;
+	} device_path;
+	u8 reserved4;
+	u8 checksum;
+} __attribute__ ((packed));
+
+struct edd_info {
+	u8 device;
+	u8 version;
+	u16 interface_support;
+	u16 legacy_cylinders;
+	u8 legacy_heads;
+	u8 legacy_sectors;
+	struct edd_device_params params;
+} __attribute__ ((packed));
+
+extern struct edd_info edd[EDDMAXNR];
+extern unsigned char eddnr;
+extern unsigned int edd_disk80_sig;
+
+#endif				/*!__ASSEMBLY__ */
+
+#endif				/* _LINUX_EDD_H */

diff -Nru a/arch/i386/kernel/setup.c b/arch/i386/kernel/setup.c
--- a/arch/i386/kernel/setup.c	Tue Mar 16 10:03:36 2004
+++ b/arch/i386/kernel/setup.c	Tue Mar 16 10:03:36 2004
@@ -38,10 +38,10 @@
 #include <linux/module.h>
 #include <linux/efi.h>
 #include <linux/init.h>
+#include <linux/edd.h>
 #include <video/edid.h>
 #include <asm/e820.h>
 #include <asm/mpspec.h>
-#include <asm/edd.h>
 #include <asm/setup.h>
 #include <asm/arch_hooks.h>
 #include <asm/sections.h>

--xgyAXRrhYN0wYx8y
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.1 (GNU/Linux)

iD8DBQFAWNo4Iavu95Lw/AkRAm6dAJ9fZo5YQKI8vf8C625LbZrgtBPqqwCeLm4F
bF2UhjvYC6sVALSHekiYBzU=
=r9gB
-----END PGP SIGNATURE-----

--xgyAXRrhYN0wYx8y--
