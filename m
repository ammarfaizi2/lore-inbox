Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265037AbUGGKFv@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265037AbUGGKFv (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 7 Jul 2004 06:05:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265038AbUGGKFv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 7 Jul 2004 06:05:51 -0400
Received: from vsmtp4alice-fr.tin.it ([212.216.176.150]:13972 "EHLO
	vsmtp4.tin.it") by vger.kernel.org with ESMTP id S265037AbUGGKFg
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 7 Jul 2004 06:05:36 -0400
Subject: Re: EDD enhanchement patch
From: Frediano Ziglio <freddyz77@tin.it>
To: Matt Domsch <Matt_Domsch@dell.com>
Cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org,
       Bartlomiej Zolnierkiewicz <B.Zolnierkiewicz@elka.pw.edu.pl>,
       "Patrick J. LoPresti" <patl@users.sourceforge.net>
In-Reply-To: <Pine.LNX.4.44.0407062248040.19141-100000@humbolt.us.dell.com>
References: <Pine.LNX.4.44.0407062248040.19141-100000@humbolt.us.dell.com>
Content-Type: text/plain
Message-Id: <1089194759.4522.3.camel@freddy>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.5 (1.4.5-7) 
Date: Wed, 07 Jul 2004 12:05:59 +0200
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Il mer, 2004-07-07 alle 06:45, Matt Domsch ha scritto:
> > Date: Tue, 06 Jul 2004 18:53:28 +0200
> > From: Frediano Ziglio <freddyz77@tin.it>
> > 
> > This patch add support for DTPE data in EDD and mbr_signature. This
> > patch do not solve fdisk problems but can help these programs to compute
> > correct head count.
> 
> Thanks Frediano.  I don't think this is quite ready to include yet,
> but I'm not philosophically opposed to it, so let's work it out.
> 

Here you are, inlined (with your change it's quite smaller)
Fixed a stupid bug too (I'm used to code in Intel asm, not GNU asm...)
It seems that some BIOS (like mine) fill with an invalid pointer using
USB disks, add code to test DPTE data (using checksum).

diff -U10 -r linux-2.6.7.orig/arch/i386/boot/edd.S linux-2.6.7/arch/i386/boot/edd.S
--- linux-2.6.7.orig/arch/i386/boot/edd.S	2004-07-07 08:57:35.000000000 +0200
+++ linux-2.6.7/arch/i386/boot/edd.S	2004-07-07 11:50:55.000000000 +0200
@@ -45,27 +45,28 @@
 	cmpb	$EDD_MBR_SIG_MAX, (EDD_MBR_SIG_NR_BUF)	# Out of space?
 	jb	edd_mbr_sig_read		# keep looping
 edd_mbr_sig_done:
 
 # Do the BIOS Enhanced Disk Drive calls
 # This consists of two calls:
 #    int 13h ah=41h "Check Extensions Present"
 #    int 13h ah=48h "Get Device Parameters"
 #    int 13h ah=08h "Legacy Get Device Parameters"
 #
-# A buffer of size EDDMAXNR*(EDDEXTSIZE+EDDPARMSIZE) is reserved for our use
-# in the boot_params at EDDBUF.  The first four bytes of which are
+# A buffer of size EDDMAXNR*(EDDEXTSIZE+EDDPARMSIZE+DPTESIZE) is reserved 
+# for our use in the boot_params at EDDBUF.  The first four bytes of which are
 # used to store the device number, interface support map and version
 # results from fn41.  The next four bytes are used to store the legacy
 # cylinders, heads, and sectors from fn08. The following 74 bytes are used to
 # store the results from fn48.  Starting from device 80h, fn41, then fn48
-# are called and their results stored in EDDBUF+n*(EDDEXTSIZE+EDDPARMIZE).
+# are called and their results stored
+# in EDDBUF+n*(EDDEXTSIZE+EDDPARMIZE+DPTESIZE).
 # Then the pointer is incremented to store the data for the next call.
 # This repeats until either a device doesn't exist, or until EDDMAXNR
 # devices have been stored.
 # The one tricky part is that ds:si always points EDDEXTSIZE bytes into
 # the structure, and the fn41 and fn08 results are stored at offsets
 # from there.  This removes the need to increment the pointer for
 # every store, and leaves it ready for the fn48 call.
 # A second one-byte buffer, EDDNR, in the boot_params stores
 # the number of BIOS devices which exist, up to EDDMAXNR.
 # In setup.c, copy_edd() stores both boot_params buffers away
@@ -91,22 +92,58 @@
 	movb	%dl, %ds:-8(%si)		# store device number
 	movb	%ah, %ds:-7(%si)		# store version
 	movw	%cx, %ds:-6(%si)		# store extensions
 	incb	(EDDNR)				# note that we stored something
 
 edd_get_device_params:
 	movw	$EDDPARMSIZE, %ds:(%si)		# put size
 	movw	$0x0, %ds:2(%si)		# work around buggy BIOSes
 	movb	$GETDEVICEPARAMETERS, %ah	# Function 48
 	int	$0x13				# make the call
-						# Don't check for fail return
-						# it doesn't matter.
+	jc	edd_get_legacy_chs
+
+	cmpw	$0x1e, %ds:(%si)		# check if EDD 2.0 present
+	jb	edd_get_legacy_chs
+
+	movl	%ds:0x1a(%si), %eax		# check pointer
+	incl	%eax				# no ffff:ffff
+	jz	bad_dpte_data
+	decl	%eax				# or 0000:0000
+	jz	bad_dpte_data
+
+	# copy EDD 2.0 informations
+	pushw	%ds
+	pushw	%es
+	pushw	%ds
+	popw	%es
+	pushw	%si
+	leaw	EDDPARMSIZE(%si), %di
+	ldsw	%ds:0x1a(%si), %si
+	movw	$16, %cx
+	xorw	%ax, %ax
+	cld
+check_dpte:
+	lodsb
+	addb	%al, %ah
+	stosb
+	loop	check_dpte
+	popw	%si
+	popw	%es
+	popw	%ds
+	cmp	$0, %ah
+	je	edd_get_legacy_chs
+
+	# DPTE data invalid, bad BIOS, reset dpte_pointer
+bad_dpte_data:
+	movl	$-1, %ds:0x1a(%si)
+check_edd2_ok:
+
 edd_get_legacy_chs:
 	xorw    %ax, %ax
 	movw    %ax, %ds:-4(%si)
 	movw    %ax, %ds:-2(%si)
         # Ralf Brown's Interrupt List says to set ES:DI to
 	# 0000h:0000h "to guard against BIOS bugs"
 	pushw   %es
 	movw    %ax, %es
 	movw    %ax, %di
 	pushw   %dx                             # legacy call clobbers %dl
@@ -118,21 +155,19 @@
 	movb	%al, %ds:-1(%si)                # Record max sect
 	movb    %dh, %ds:-2(%si)                # Record max head number
 	movb    %ch, %al                        # Low 8 bits of max cyl
 	shr     $6, %cl
 	movb    %cl, %ah                        # High 2 bits of max cyl
 	movw    %ax, %ds:-4(%si)
 
 edd_legacy_done:
 	popw    %dx
 	popw    %es
-	movw	%si, %ax			# increment si
-	addw	$EDDPARMSIZE+EDDEXTSIZE, %ax
-	movw	%ax, %si
+	addw	$EDDPARMSIZE+EDDEXTSIZE+DPTESIZE, %si	# increment si
 
 edd_next:
 	incb	%dl				# increment to next device
 	cmpb	$EDDMAXNR, (EDDNR) 		# Out of space?
 	jb	edd_check_ext			# keep looping
 
 edd_done:
 #endif
diff -U10 -r linux-2.6.7.orig/Documentation/i386/zero-page.txt linux-2.6.7/Documentation/i386/zero-page.txt
--- linux-2.6.7.orig/Documentation/i386/zero-page.txt	2004-07-07 08:57:33.000000000 +0200
+++ linux-2.6.7/Documentation/i386/zero-page.txt	2004-07-07 10:57:54.000000000 +0200
@@ -69,11 +69,11 @@
 				  loader.
 0x212	unsigned short	(setup.S)
 0x214	unsigned long	KERNEL_START, where the loader started the kernel
 0x218	unsigned long	INITRD_START, address of loaded ramdisk image
 0x21c	unsigned long	INITRD_SIZE, size in bytes of ramdisk image
 0x220	4 bytes		(setup.S)
 0x224	unsigned short	setup.S heap end pointer
 0x290 - 0x2cf		EDD_MBR_SIG_BUFFER (edd.S)
 0x2d0 - 0x600		E820MAP
 0x600 - 0x7ff		EDDBUF (edd.S) for disk signature read sector
-0x600 - 0x7eb		EDDBUF (edd.S) for edd data
+0x600 - 0x7e9		EDDBUF (edd.S) for edd data
diff -U10 -r linux-2.6.7.orig/drivers/firmware/edd.c linux-2.6.7/drivers/firmware/edd.c
--- linux-2.6.7.orig/drivers/firmware/edd.c	2004-07-07 08:57:46.000000000 +0200
+++ linux-2.6.7/drivers/firmware/edd.c	2004-07-07 11:38:16.000000000 +0200
@@ -436,20 +436,34 @@
 		return -EINVAL;
 	info = edd_dev_get_info(edev);
 	if (!info || !buf)
 		return -EINVAL;
 
 	p += scnprintf(p, left, "%llu\n", info->params.number_of_sectors);
 	return (p - buf);
 }
 
 
+static ssize_t
+edd_show_raw_dpte(struct edd_device *edev, char *buf)
+{
+	struct edd_info *info;
+	if (!edev)
+		return -EINVAL;
+	info = edd_dev_get_info(edev);
+	if (!info || !buf)
+		return -EINVAL;
+
+	memcpy(buf, &info->dpte, sizeof(struct edd_dpte));
+	return sizeof(struct edd_dpte);
+}
+
 /*
  * Some device instances may not have all the above attributes,
  * or the attribute values may be meaningless (i.e. if
  * the device is < EDD 3.0, it won't have host_bus and interface
  * information), so don't bother making files for them.  Likewise
  * if the default_{cylinders,heads,sectors_per_track} values
  * are zero, the BIOS doesn't provide sane values, don't bother
  * creating files for them either.
  */
 
@@ -549,20 +563,36 @@
 			break;
 		}
 	}
 	if (!nonzero_path) {
 		return 0;
 	}
 
 	return 1;
 }
 
+static int
+edd_has_dpte(struct edd_device *edev)
+{
+	struct edd_info *info;
+	if (!edev)
+		return 0;
+	info = edd_dev_get_info(edev);
+	if (!info || info->params.length < 0x1e)
+		return 0;
+
+	if (info->params.dpte_ptr == 0xffffffffu)
+		return 0;
+
+	return 1;
+}
+
 
 static EDD_DEVICE_ATTR(raw_data, 0444, edd_show_raw_data, edd_has_edd_info);
 static EDD_DEVICE_ATTR(version, 0444, edd_show_version, edd_has_edd_info);
 static EDD_DEVICE_ATTR(extensions, 0444, edd_show_extensions, edd_has_edd_info);
 static EDD_DEVICE_ATTR(info_flags, 0444, edd_show_info_flags, edd_has_edd_info);
 static EDD_DEVICE_ATTR(sectors, 0444, edd_show_sectors, edd_has_edd_info);
 static EDD_DEVICE_ATTR(legacy_max_cylinder, 0444,
                        edd_show_legacy_max_cylinder,
 		       edd_has_legacy_max_cylinder);
 static EDD_DEVICE_ATTR(legacy_max_head, 0444, edd_show_legacy_max_head,
@@ -573,20 +603,21 @@
 static EDD_DEVICE_ATTR(default_cylinders, 0444, edd_show_default_cylinders,
 		       edd_has_default_cylinders);
 static EDD_DEVICE_ATTR(default_heads, 0444, edd_show_default_heads,
 		       edd_has_default_heads);
 static EDD_DEVICE_ATTR(default_sectors_per_track, 0444,
 		       edd_show_default_sectors_per_track,
 		       edd_has_default_sectors_per_track);
 static EDD_DEVICE_ATTR(interface, 0444, edd_show_interface, edd_has_edd30);
 static EDD_DEVICE_ATTR(host_bus, 0444, edd_show_host_bus, edd_has_edd30);
 static EDD_DEVICE_ATTR(mbr_signature, 0444, edd_show_mbr_signature, edd_has_mbr_signature);
+static EDD_DEVICE_ATTR(raw_dpte, 0444, edd_show_raw_dpte, edd_has_dpte);
 
 
 /* These are default attributes that are added for every edd
  * device discovered.  There are none.
  */
 static struct attribute * def_attrs[] = {
 	NULL,
 };
 
 /* These attributes are conditional and only added for some devices. */
@@ -598,20 +629,21 @@
 	&edd_attr_sectors,
 	&edd_attr_legacy_max_cylinder,
 	&edd_attr_legacy_max_head,
 	&edd_attr_legacy_sectors_per_track,
 	&edd_attr_default_cylinders,
 	&edd_attr_default_heads,
 	&edd_attr_default_sectors_per_track,
 	&edd_attr_interface,
 	&edd_attr_host_bus,
 	&edd_attr_mbr_signature,
+	&edd_attr_raw_dpte,
 	NULL,
 };
 
 /**
  *	edd_release - free edd structure
  *	@kobj:	kobject of edd structure
  *
  *	This is called when the refcount of the edd structure
  *	reaches 0. This should happen right after we unregister,
  *	but just in case, we use the release callback anyway.
diff -U10 -r linux-2.6.7.orig/include/linux/edd.h linux-2.6.7/include/linux/edd.h
--- linux-2.6.7.orig/include/linux/edd.h	2004-07-07 08:58:10.000000000 +0200
+++ linux-2.6.7/include/linux/edd.h	2004-07-07 10:57:54.000000000 +0200
@@ -26,23 +26,24 @@
  * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
  * GNU General Public License for more details.
  *
  */
 #ifndef _LINUX_EDD_H
 #define _LINUX_EDD_H
 
 #define EDDNR 0x1e9		/* addr of number of edd_info structs at EDDBUF
 				   in boot_params - treat this as 1 byte  */
 #define EDDBUF	0x600		/* addr of edd_info structs in boot_params */
-#define EDDMAXNR 6		/* number of edd_info structs starting at EDDBUF  */
+#define EDDMAXNR 5		/* number of edd_info structs starting at EDDBUF  */
 #define EDDEXTSIZE 8		/* change these if you muck with the structures */
 #define EDDPARMSIZE 74
+#define DPTESIZE 16
 #define CHECKEXTENSIONSPRESENT 0x41
 #define GETDEVICEPARAMETERS 0x48
 #define LEGACYGETDEVICEPARAMETERS 0x08
 #define EDDMAGIC1 0x55AA
 #define EDDMAGIC2 0xAA55
 
 
 #define READ_SECTORS 0x02         /* int13 AH=0x02 is READ_SECTORS command */
 #define EDD_MBR_SIG_OFFSET 0x1B8  /* offset of signature in the MBR */
 #define EDD_MBR_SIG_BUF    0x290  /* addr in boot params */
@@ -58,20 +59,22 @@
 
 #define EDD_INFO_DMA_BOUNDARY_ERROR_TRANSPARENT (1 << 0)
 #define EDD_INFO_GEOMETRY_VALID                (1 << 1)
 #define EDD_INFO_REMOVABLE                     (1 << 2)
 #define EDD_INFO_WRITE_VERIFY                  (1 << 3)
 #define EDD_INFO_MEDIA_CHANGE_NOTIFICATION     (1 << 4)
 #define EDD_INFO_LOCKABLE                      (1 << 5)
 #define EDD_INFO_NO_MEDIA_PRESENT              (1 << 6)
 #define EDD_INFO_USE_INT13_FN50                (1 << 7)
 
+#define EDD2_DRIVE_IS_SLAVE                    (1 << 4)
+
 struct edd_device_params {
 	u16 length;
 	u16 info_flags;
 	u32 num_default_cylinders;
 	u32 num_default_heads;
 	u32 sectors_per_track;
 	u64 number_of_sectors;
 	u16 bytes_per_sector;
 	u32 dpte_ptr;		/* 0xFFFFFFFF for our purposes */
 	u16 key;		/* = 0xBEDD */
@@ -159,28 +162,44 @@
 		} __attribute__ ((packed)) sata;
 		struct {
 			u64 reserved1;
 			u64 reserved2;
 		} __attribute__ ((packed)) unknown;
 	} device_path;
 	u8 reserved4;
 	u8 checksum;
 } __attribute__ ((packed));
 
+struct edd_dpte {
+	u16 port_base;
+	u16 port_command;
+	u8 drive_flags;
+	u8 proprietary_informations;
+	u8 irq;
+	u8 multi_sector_count;
+	u8 dma_control;
+	u8 programmed_io;
+	u16 drive_options;
+	u16 reserved5;
+	u8 extension_level;
+	u8 edd2_checksum;
+} __attribute__ ((packed));
+
 struct edd_info {
 	u8 device;
 	u8 version;
 	u16 interface_support;
 	u16 legacy_max_cylinder;
 	u8 legacy_max_head;
 	u8 legacy_sectors_per_track;
 	struct edd_device_params params;
+	struct edd_dpte dpte;
 } __attribute__ ((packed));
 
 struct edd {
 	unsigned int mbr_signature[EDD_MBR_SIG_MAX];
 	struct edd_info edd_info[EDDMAXNR];
 	unsigned char mbr_signature_nr;
 	unsigned char edd_info_nr;
 };
 
 extern struct edd edd;

freddy77


