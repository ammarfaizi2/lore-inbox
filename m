Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262020AbUCIVlh (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 9 Mar 2004 16:41:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262076AbUCIVlh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 9 Mar 2004 16:41:37 -0500
Received: from lists.us.dell.com ([143.166.224.162]:34194 "EHLO
	lists.us.dell.com") by vger.kernel.org with ESMTP id S262020AbUCIVk4
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 9 Mar 2004 16:40:56 -0500
Date: Tue, 9 Mar 2004 15:40:29 -0600
From: Matt Domsch <Matt_Domsch@dell.com>
To: linux-kernel@vger.kernel.org
Cc: patl@users.sourceforge.net
Subject: [RFC][PATCH] EDD Get Legacy Parameters
Message-ID: <20040309214029.GA29652@lists.us.dell.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="8t9RHnE3ZwKMSgU+"
Content-Disposition: inline
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--8t9RHnE3ZwKMSgU+
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Patch below from Patrick J. LoPresti and myself.  Patrick describes:

Why this patch?  The problem is that the legacy BIOS interface
(INT13/AH=3D08) for querying the disk geometry returns different values
than the extended INT13 interface which the EDD code currently uses.
This is because the legacy interface only provides a 10-bit cylinder
field, so modern BIOSes "lie" about the head/sector counts in order to
make more of the disk visible within the first 1024 cylinders.

Many non-Linux applications, including the stock Windows boot loader,
DOS fdisk, etc., rely upon the legacy interface and geometry.  So it
is useful to be able to obtain the legacy values from a running Linux
kernel.

What this patch does is to add new entries under
/sys/firmware/edd/int13_devXX named "legacy_cylinders",
"legacy_heads", and "legacy_sectors".  These provide the geometry
given by the legacy INT13/AH=3D08 BIOS interface, just like the current
"default_cylinders" etc. provide the the geometry given by the
INT13/AH=3D48 interface.

Without this patch, I cannot use Linux to partition a drive and
install Windows, which happens to be my application.
Thanks!

 - Pat
   http://unattended.sourceforge.net/

In addition, this adds two buggy BIOS workarounds  in the EDD int13
calls as suggested by Ralf Brown's interrupt list.

Patch below applies to 2.6.4-rc2 and 2.6.4-rc2-mm1, and has been
run-tested on 2.6.4-rc2.

I'm also interested in moving this code out of arch/i386/kernel/edd.c and
include/asm-i386/edd.h, as I believe it is applicable on x86-64 as well.
However, there's no good place under drivers/ to put edd.c when it's
not tied to a bus, but to several CPU architectures and their
firmwares...  Maybe a new directory drivers/firmware?

Feedback welcome.=20

--=20
Matt Domsch
Sr. Software Engineer, Lead Engineer
Dell Linux Solutions linux.dell.com & www.dell.com/linux
Linux on Dell mailing lists @ http://lists.us.dell.com


diff -urNp --exclude-from=3D/home/mdomsch/excludes --minimal linux-2.6.4-rc=
2/Documentation/i386/zero-page.txt linux-2.6.4-rc2-edd-legacychs/Documentat=
ion/i386/zero-page.txt
--- linux-2.6.4-rc2/Documentation/i386/zero-page.txt	Tue Feb 17 21:57:24 20=
04
+++ linux-2.6.4-rc2-edd-legacychs/Documentation/i386/zero-page.txt	Tue Mar =
 9 15:25:19 2004
@@ -75,7 +75,7 @@ Offset	Type		Description
 0x2cc	4 bytes		DISK80_SIG_BUFFER (setup.S)
 0x2d0 - 0x600		E820MAP
 0x600 - 0x7ff		EDDBUF (setup.S) for disk signature read sector
-0x600 - 0x7d3		EDDBUF (setup.S) for edd data
+0x600 - 0x7eb		EDDBUF (setup.S) for edd data
=20
 0x800	string, 2K max	COMMAND_LINE, the kernel commandline as
 			copied using CL_OFFSET.
diff -urNp --exclude-from=3D/home/mdomsch/excludes --minimal linux-2.6.4-rc=
2/arch/i386/boot/setup.S linux-2.6.4-rc2-edd-legacychs/arch/i386/boot/setup=
.S
--- linux-2.6.4-rc2/arch/i386/boot/setup.S	Tue Mar  9 15:20:12 2004
+++ linux-2.6.4-rc2-edd-legacychs/arch/i386/boot/setup.S	Tue Mar  9 15:25:2=
0 2004
@@ -51,6 +51,8 @@
  *   projects 1572D, 1484D, 1386D, 1226DT
  * disk signature read by Matt Domsch <Matt_Domsch@dell.com>
  *	and Andrew Wilks <Andrew_Wilks@dell.com> September 2003
+ * legacy CHS retreival by Patrick J. LoPresti <patl@users.sourceforge.net>
+ *      March 2004
  */
=20
 #include <linux/config.h>
@@ -592,7 +594,11 @@ done_apm_bios:
 	pushw	%ds
 	popw	%es
 	movw	$EDDBUF, %bx
-	int	$0x13
+	pushw   %dx             # work around buggy BIOSes
+	stc                     # work around buggy BIOSes
+	int     $0x13
+	sti                     # work around buggy BIOSes
+	popw    %dx
 	jc	disk_sig_done
 	movl	(EDDBUF+MBR_SIG_OFFSET), %eax
 	movl	%eax, (DISK80_SIG_BUFFER)	# store success
@@ -603,32 +609,34 @@ disk_sig_done:
 # This consists of two calls:
 #    int 13h ah=3D41h "Check Extensions Present"
 #    int 13h ah=3D48h "Get Device Parameters"
+#    int 13h ah=3D08h "Legacy Get Device Parameters"
 #
 # A buffer of size EDDMAXNR*(EDDEXTSIZE+EDDPARMSIZE) is reserved for our u=
se
 # in the empty_zero_page at EDDBUF.  The first four bytes of which are
 # used to store the device number, interface support map and version
-# results from fn41.  The following 74 bytes are used to store
-# the results from fn48.  Starting from device 80h, fn41, then fn48
+# results from fn41.  The next four bytes are used to store the legacy
+# cylinders, heads, and sectors from fn08. The following 74 bytes are used=
 to
+# store the results from fn48.  Starting from device 80h, fn41, then fn48
 # are called and their results stored in EDDBUF+n*(EDDEXTSIZE+EDDPARMIZE).
 # Then the pointer is incremented to store the data for the next call.
 # This repeats until either a device doesn't exist, or until EDDMAXNR
 # devices have been stored.
-# The one tricky part is that ds:si always points four bytes into
-# the structure, and the fn41 results are stored at offsets
+# The one tricky part is that ds:si always points EDDEXTSIZE bytes into
+# the structure, and the fn41 and fn08 results are stored at offsets
 # from there.  This removes the need to increment the pointer for
 # every store, and leaves it ready for the fn48 call.
 # A second one-byte buffer, EDDNR, in the empty_zero_page stores
 # the number of BIOS devices which exist, up to EDDMAXNR.
 # In setup.c, copy_edd() stores both empty_zero_page buffers away
-# for later use, as they would get overwritten otherwise.=20
+# for later use, as they would get overwritten otherwise.
 # This code is sensitive to the size of the structs in edd.h
-edd_start: =20
+edd_start:
 						# %ds points to the bootsector
        						# result buffer for fn48
-    	movw	$EDDBUF+EDDEXTSIZE, %si		# in ds:si, fn41 results
-						# kept just before that   =20
+	movw	$EDDBUF+EDDEXTSIZE, %si		# in ds:si, fn41 results
+						# kept just before that
 	movb	$0, (EDDNR)			# zero value at EDDNR
-    	movb	$0x80, %dl			# BIOS device 0x80
+	movb	$0x80, %dl			# BIOS device 0x80
=20
 edd_check_ext:
 	movb	$CHECKEXTENSIONSPRESENT, %ah    # Function 41
@@ -636,30 +644,56 @@ edd_check_ext:
 	int	$0x13				# make the call
 	jc	edd_done			# no more BIOS devices
=20
-    	cmpw	$EDDMAGIC2, %bx			# is magic right?
+	cmpw	$EDDMAGIC2, %bx			# is magic right?
 	jne	edd_next			# nope, next...
=20
-    	movb	%dl, %ds:-4(%si)		# store device number
-    	movb	%ah, %ds:-3(%si)		# store version
-	movw	%cx, %ds:-2(%si)		# store extensions
+	movb	%dl, %ds:-8(%si)		# store device number
+	movb	%ah, %ds:-7(%si)		# store version
+	movw	%cx, %ds:-6(%si)		# store extensions
 	incb	(EDDNR)				# note that we stored something
-       =20
-edd_get_device_params: =20
+
+edd_get_device_params:
 	movw	$EDDPARMSIZE, %ds:(%si)		# put size
-    	movb	$GETDEVICEPARAMETERS, %ah	# Function 48
+	movw	$0x0, %ds:2(%si)		# work around buggy BIOSes
+	movb	$GETDEVICEPARAMETERS, %ah	# Function 48
 	int	$0x13				# make the call
 						# Don't check for fail return
 						# it doesn't matter.
+edd_get_legacy_chs:
+	xorw    %ax, %ax
+	movw    %ax, %ds:-4(%si)
+	movw    %ax, %ds:-2(%si)
+        # Ralf Brown's Interrupt List says to set ES:DI to
+	# 0000h:0000h "to guard against BIOS bugs"
+	pushw   %es
+	movw    %ax, %es
+	movw    %ax, %di
+	pushw   %dx                             # legacy call clobbers %dl
+	movb    $LEGACYGETDEVICEPARAMETERS, %ah # Function 08
+	int     $0x13                           # make the call
+	jc      edd_legacy_done                 # failed
+	movb    %cl, %al                        # Low 6 bits are max
+	andb    $0x3F, %al                      #   sector number
+	movb	%al, %ds:-1(%si)                # Record max sect
+	movb    %dh, %ds:-2(%si)                # Record max head number
+	movb    %ch, %al                        # Low 8 bits of max cyl
+	shr     $6, %cl
+	movb    %cl, %ah                        # High 2 bits of max cyl
+	movw    %ax, %ds:-4(%si)
+
+edd_legacy_done:
+	popw    %dx
+	popw    %es
 	movw	%si, %ax			# increment si
 	addw	$EDDPARMSIZE+EDDEXTSIZE, %ax
 	movw	%ax, %si
=20
 edd_next:
-        incb	%dl				# increment to next device
-       	cmpb	$EDDMAXNR, (EDDNR) 		# Out of space?
+	incb	%dl				# increment to next device
+	cmpb	$EDDMAXNR, (EDDNR) 		# Out of space?
 	jb	edd_check_ext			# keep looping
-   =20
-edd_done:  =20
+
+edd_done:
 #endif
=20
 # Now we want to move to protected mode ...
diff -urNp --exclude-from=3D/home/mdomsch/excludes --minimal linux-2.6.4-rc=
2/arch/i386/kernel/edd.c linux-2.6.4-rc2-edd-legacychs/arch/i386/kernel/edd=
.c
--- linux-2.6.4-rc2/arch/i386/kernel/edd.c	Tue Mar  9 15:20:12 2004
+++ linux-2.6.4-rc2-edd-legacychs/arch/i386/kernel/edd.c	Tue Mar  9 15:25:2=
0 2004
@@ -1,8 +1,9 @@
 /*
  * linux/arch/i386/kernel/edd.c
- *  Copyright (C) 2002, 2003 Dell Inc.
+ *  Copyright (C) 2002, 2003, 2004 Dell Inc.
  *  by Matt Domsch <Matt_Domsch@dell.com>
  *  disk80 signature by Matt Domsch, Andrew Wilks, and Sandeep K. Shandilya
+ *  legacy CHS by Patrick J. LoPresti <patl@users.sourceforge.net>
  *
  * BIOS Enhanced Disk Drive Services (EDD)
  * conformant to T13 Committee www.t13.org
@@ -60,7 +61,7 @@ MODULE_AUTHOR("Matt Domsch <Matt_Domsch@
 MODULE_DESCRIPTION("sysfs interface to BIOS EDD information");
 MODULE_LICENSE("GPL");
=20
-#define EDD_VERSION "0.12 2004-Jan-26"
+#define EDD_VERSION "0.13 2004-Mar-09"
 #define EDD_DEVICE_NAME_SIZE 16
 #define REPORT_URL "http://linux.dell.com/edd/results.html"
=20
@@ -231,7 +232,7 @@ static ssize_t
 edd_show_raw_data(struct edd_device *edev, char *buf)
 {
 	struct edd_info *info =3D edd_dev_get_info(edev);
-	ssize_t len =3D sizeof (*info) - 4;
+	ssize_t len =3D sizeof (info->params);
 	if (!edev || !info || !buf) {
 		return -EINVAL;
 	}
@@ -240,10 +241,10 @@ edd_show_raw_data(struct edd_device *ede
 		len =3D info->params.length;
=20
 	/* In case of buggy BIOSs */
-	if (len > (sizeof(*info) - 4))
-		len =3D sizeof(*info) - 4;
+	if (len > (sizeof(info->params)))
+		len =3D sizeof(info->params);
=20
-	memcpy(buf, ((char *)info) + 4, len);
+	memcpy(buf, &info->params, len);
 	return len;
 }
=20
@@ -321,6 +322,45 @@ edd_show_info_flags(struct edd_device *e
 }
=20
 static ssize_t
+edd_show_legacy_cylinders(struct edd_device *edev, char *buf)
+{
+	struct edd_info *info =3D edd_dev_get_info(edev);
+	char *p =3D buf;
+	if (!edev || !info || !buf) {
+		return -EINVAL;
+	}
+
+	p +=3D snprintf(p, left, "0x%x\n", info->legacy_cylinders);
+	return (p - buf);
+}
+
+static ssize_t
+edd_show_legacy_heads(struct edd_device *edev, char *buf)
+{
+	struct edd_info *info =3D edd_dev_get_info(edev);
+	char *p =3D buf;
+	if (!edev || !info || !buf) {
+		return -EINVAL;
+	}
+
+	p +=3D snprintf(p, left, "0x%x\n", info->legacy_heads);
+	return (p - buf);
+}
+
+static ssize_t
+edd_show_legacy_sectors(struct edd_device *edev, char *buf)
+{
+	struct edd_info *info =3D edd_dev_get_info(edev);
+	char *p =3D buf;
+	if (!edev || !info || !buf) {
+		return -EINVAL;
+	}
+
+	p +=3D snprintf(p, left, "0x%x\n", info->legacy_sectors);
+	return (p - buf);
+}
+
+static ssize_t
 edd_show_default_cylinders(struct edd_device *edev, char *buf)
 {
 	struct edd_info *info =3D edd_dev_get_info(edev);
@@ -384,6 +424,33 @@ edd_show_sectors(struct edd_device *edev
  */
=20
 static int
+edd_has_legacy_cylinders(struct edd_device *edev)
+{
+	struct edd_info *info =3D edd_dev_get_info(edev);
+	if (!edev || !info)
+		return -EINVAL;
+	return info->legacy_cylinders > 0;
+}
+
+static int
+edd_has_legacy_heads(struct edd_device *edev)
+{
+	struct edd_info *info =3D edd_dev_get_info(edev);
+	if (!edev || !info)
+		return -EINVAL;
+	return info->legacy_heads > 0;
+}
+
+static int
+edd_has_legacy_sectors(struct edd_device *edev)
+{
+	struct edd_info *info =3D edd_dev_get_info(edev);
+	if (!edev || !info)
+		return -EINVAL;
+	return info->legacy_sectors > 0;
+}
+
+static int
 edd_has_default_cylinders(struct edd_device *edev)
 {
 	struct edd_info *info =3D edd_dev_get_info(edev);
@@ -452,6 +519,12 @@ static EDD_DEVICE_ATTR(version, 0444, ed
 static EDD_DEVICE_ATTR(extensions, 0444, edd_show_extensions, NULL);
 static EDD_DEVICE_ATTR(info_flags, 0444, edd_show_info_flags, NULL);
 static EDD_DEVICE_ATTR(sectors, 0444, edd_show_sectors, NULL);
+static EDD_DEVICE_ATTR(legacy_cylinders, 0444, edd_show_legacy_cylinders,
+		       edd_has_legacy_cylinders);
+static EDD_DEVICE_ATTR(legacy_heads, 0444, edd_show_legacy_heads,
+		       edd_has_legacy_heads);
+static EDD_DEVICE_ATTR(legacy_sectors, 0444, edd_show_legacy_sectors,
+		       edd_has_legacy_sectors);
 static EDD_DEVICE_ATTR(default_cylinders, 0444, edd_show_default_cylinders,
 		       edd_has_default_cylinders);
 static EDD_DEVICE_ATTR(default_heads, 0444, edd_show_default_heads,
@@ -478,6 +551,9 @@ static struct attribute * def_attrs[] =3D=20
=20
 /* These attributes are conditional and only added for some devices. */
 static struct edd_attribute * edd_attrs[] =3D {
+	&edd_attr_legacy_cylinders,
+	&edd_attr_legacy_heads,
+	&edd_attr_legacy_sectors,
 	&edd_attr_default_cylinders,
 	&edd_attr_default_heads,
 	&edd_attr_default_sectors_per_track,
diff -urNp --exclude-from=3D/home/mdomsch/excludes --minimal linux-2.6.4-rc=
2/include/asm-i386/edd.h linux-2.6.4-rc2-edd-legacychs/include/asm-i386/edd=
.h
--- linux-2.6.4-rc2/include/asm-i386/edd.h	Tue Feb 17 21:57:12 2004
+++ linux-2.6.4-rc2-edd-legacychs/include/asm-i386/edd.h	Tue Mar  9 15:25:2=
0 2004
@@ -34,10 +34,11 @@
 				   in empty_zero_block - treat this as 1 byte  */
 #define EDDBUF	0x600		/* addr of edd_info structs in empty_zero_block */
 #define EDDMAXNR 6		/* number of edd_info structs starting at EDDBUF  */
-#define EDDEXTSIZE 4		/* change these if you muck with the structures */
+#define EDDEXTSIZE 8		/* change these if you muck with the structures */
 #define EDDPARMSIZE 74
 #define CHECKEXTENSIONSPRESENT 0x41
 #define GETDEVICEPARAMETERS 0x48
+#define LEGACYGETDEVICEPARAMETERS 0x08
 #define EDDMAGIC1 0x55AA
 #define EDDMAGIC2 0xAA55
=20
@@ -165,6 +166,9 @@ struct edd_info {
 	u8 device;
 	u8 version;
 	u16 interface_support;
+	u16 legacy_cylinders;
+	u8 legacy_heads;
+	u8 legacy_sectors;
 	struct edd_device_params params;
 } __attribute__ ((packed));
=20

--8t9RHnE3ZwKMSgU+
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.1 (GNU/Linux)

iD8DBQFATjnLIavu95Lw/AkRArDFAJ9Y2C1DCdLEw1UFnJSpQWuTezOOUgCeOZQq
UDvjtWNG0iuhE/Ajav5C08s=
=IPjx
-----END PGP SIGNATURE-----

--8t9RHnE3ZwKMSgU+--
