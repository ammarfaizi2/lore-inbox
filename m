Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265157AbUF1UJU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265157AbUF1UJU (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 28 Jun 2004 16:09:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265163AbUF1UJU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 28 Jun 2004 16:09:20 -0400
Received: from linux.us.dell.com ([143.166.224.162]:23149 "EHLO
	lists.us.dell.com") by vger.kernel.org with ESMTP id S265157AbUF1UIh
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 28 Jun 2004 16:08:37 -0400
Date: Mon, 28 Jun 2004 15:08:28 -0500
From: Matt Domsch <Matt_Domsch@dell.com>
To: akpm@osdl.org
Cc: linux-kernel@vger.kernel.org
Subject: EDD: store mbr_signature on first 16 int13 devices
Message-ID: <20040628200828.GA32078@lists.us.dell.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Currently, the x86/x86_64 real-mode kernel setup code reads and stores
the mbr_signature (4 bytes in the MBR at offset 440 decimal) for BIOS
int13h device 80h only.  This is useful, but not as useful as if we
stored such signatures for all int13h devices.  Think OS installer
wanting to set up md software RAID across several BIOS disks.

Patch below against 2.6.7 allows the storing of the mbr_signature for
the first 16 BIOS int13h devices, and exports them via
/sys/firmware/edd/int13_dev8x/mbr_signature as before.

This also merges the three EXPORT_SYMBOLs that setup.c exported for
edd.c's use into one.

Signed-off-by: Matt Domsch

Thanks,
Matt

-- 
Matt Domsch
Sr. Software Engineer, Lead Engineer
Dell Linux Solutions linux.dell.com & www.dell.com/linux
Linux on Dell mailing lists @ http://lists.us.dell.com

===== Documentation/i386/zero-page.txt 1.7 vs edited =====
--- 1.7/Documentation/i386/zero-page.txt	2004-03-19 00:03:48 -06:00
+++ edited/Documentation/i386/zero-page.txt	2004-06-25 09:37:41 -05:00
@@ -38,6 +38,7 @@
 0x1e0	unsigned long	ALT_MEM_K, alternative mem check, in Kb
 0x1e8	char		number of entries in E820MAP (below)
 0x1e9	unsigned char	number of entries in EDDBUF (below)
+0x1ea	unsigned char	number of entries in EDD_MBR_SIG_BUFFER (below)
 0x1f1	char		size of setup.S, number of sectors
 0x1f2	unsigned short	MOUNT_ROOT_RDONLY (if !=0)
 0x1f4	unsigned short	size of compressed kernel-part in the
@@ -72,7 +73,7 @@
 0x21c	unsigned long	INITRD_SIZE, size in bytes of ramdisk image
 0x220	4 bytes		(setup.S)
 0x224	unsigned short	setup.S heap end pointer
-0x2cc	4 bytes		DISK80_SIG_BUFFER (setup.S)
+0x290 - 0x2cf		EDD_MBR_SIG_BUFFER (edd.S)
 0x2d0 - 0x600		E820MAP
-0x600 - 0x7ff		EDDBUF (setup.S) for disk signature read sector
-0x600 - 0x7eb		EDDBUF (setup.S) for edd data
+0x600 - 0x7ff		EDDBUF (edd.S) for disk signature read sector
+0x600 - 0x7eb		EDDBUF (edd.S) for edd data
===== arch/i386/boot/edd.S 1.1 vs edited =====
--- 1.1/arch/i386/boot/edd.S	2004-03-19 00:04:56 -06:00
+++ edited/arch/i386/boot/edd.S	2004-06-25 16:25:46 -05:00
@@ -4,7 +4,7 @@
  * conformant to T13 Committee www.t13.org
  *   projects 1572D, 1484D, 1386D, 1226DT
  * disk signature read by Matt Domsch <Matt_Domsch@dell.com>
- *	and Andrew Wilks <Andrew_Wilks@dell.com> September 2003
+ *	and Andrew Wilks <Andrew_Wilks@dell.com> September 2003, June 2004
  * legacy CHS retreival by Patrick J. LoPresti <patl@users.sourceforge.net>
  *      March 2004
  */
@@ -12,28 +12,39 @@
 #include <linux/edd.h>
 
 #if defined(CONFIG_EDD) || defined(CONFIG_EDD_MODULE)
-# Read the first sector of device 80h and store the 4-byte signature
+# Read the first sector of each BIOS disk device and store the 4-byte signature
+edd_mbr_sig_start:
+	movb	$0, (EDD_MBR_SIG_NR_BUF)	# zero value at EDD_MBR_SIG_NR_BUF
+	movb	$0x80, %dl			# from device 80
+	movw	$EDD_MBR_SIG_BUF, %bx		# store buffer ptr in bx
+edd_mbr_sig_read:
 	movl	$0xFFFFFFFF, %eax
-	movl	%eax, (DISK80_SIG_BUFFER)	# assume failure
+	movl	%eax, (%bx)			# assume failure
+	pushw	%bx
 	movb	$READ_SECTORS, %ah
 	movb	$1, %al				# read 1 sector
-	movb	$0x80, %dl			# from device 80
 	movb	$0, %dh				# at head 0
 	movw	$1, %cx				# cylinder 0, sector 0
 	pushw	%es
 	pushw	%ds
 	popw	%es
-	movw	$EDDBUF, %bx
-	pushw   %dx             # work around buggy BIOSes
+    	movw	$EDDBUF, %bx			# disk's data goes into EDDBUF
+	pushw	%dx             # work around buggy BIOSes
 	stc                     # work around buggy BIOSes
-	int     $0x13
+	int	$0x13
 	sti                     # work around buggy BIOSes
-	popw    %dx
-	jc	disk_sig_done
-	movl	(EDDBUF+MBR_SIG_OFFSET), %eax
-	movl	%eax, (DISK80_SIG_BUFFER)	# store success
-disk_sig_done:
+	popw	%dx
 	popw	%es
+	popw	%bx
+	jc	edd_mbr_sig_done		# on failure, we're done.
+	movl	(EDDBUF+EDD_MBR_SIG_OFFSET), %eax # read sig out of the MBR
+	movl	%eax, (%bx)			# store success
+	incb	(EDD_MBR_SIG_NR_BUF)		# note that we stored something
+	incb	%dl				# increment to next device
+	addw	$4, %bx				# increment sig buffer ptr
+	cmpb	$EDD_MBR_SIG_MAX, (EDD_MBR_SIG_NR_BUF)	# Out of space?
+	jb	edd_mbr_sig_read		# keep looping
+edd_mbr_sig_done:
 
 # Do the BIOS Enhanced Disk Drive calls
 # This consists of two calls:
===== arch/i386/kernel/setup.c 1.122 vs edited =====
--- 1.122/arch/i386/kernel/setup.c	2004-06-20 20:23:40 -05:00
+++ edited/arch/i386/kernel/setup.c	2004-06-25 16:28:13 -05:00
@@ -629,13 +629,9 @@
 }
 
 #if defined(CONFIG_EDD) || defined(CONFIG_EDD_MODULE)
-unsigned char eddnr;
-struct edd_info edd[EDDMAXNR];
-unsigned int edd_disk80_sig;
+struct edd edd;
 #ifdef CONFIG_EDD_MODULE
-EXPORT_SYMBOL(eddnr);
 EXPORT_SYMBOL(edd);
-EXPORT_SYMBOL(edd_disk80_sig);
 #endif
 /**
  * copy_edd() - Copy the BIOS EDD information
@@ -644,12 +640,15 @@
  */
 static inline void copy_edd(void)
 {
-     eddnr = EDD_NR;
-     memcpy(edd, EDD_BUF, sizeof(edd));
-     edd_disk80_sig = DISK80_SIGNATURE;
+     memcpy(edd.mbr_signature, EDD_MBR_SIGNATURE, sizeof(edd.mbr_signature));
+     memcpy(edd.edd_info, EDD_BUF, sizeof(edd.edd_info));
+     edd.mbr_signature_nr = EDD_MBR_SIG_NR;
+     edd.edd_info_nr = EDD_NR;
 }
 #else
-#define copy_edd() do {} while (0)
+static inline void copy_edd(void)
+{
+}
 #endif
 
 /*
===== arch/x86_64/kernel/setup.c 1.42 vs edited =====
--- 1.42/arch/x86_64/kernel/setup.c	2004-06-18 01:49:29 -05:00
+++ edited/arch/x86_64/kernel/setup.c	2004-06-25 16:28:33 -05:00
@@ -401,27 +401,26 @@
 __setup("noreplacement", noreplacement_setup); 
 
 #if defined(CONFIG_EDD) || defined(CONFIG_EDD_MODULE)
-unsigned char eddnr;
-struct edd_info edd[EDDMAXNR];
-unsigned int edd_disk80_sig;
+struct edd edd;
 #ifdef CONFIG_EDD_MODULE
-EXPORT_SYMBOL(eddnr);
 EXPORT_SYMBOL(edd);
-EXPORT_SYMBOL(edd_disk80_sig);
 #endif
 /**
  * copy_edd() - Copy the BIOS EDD information
- *              from empty_zero_page into a safe place.
+ *              from boot_params into a safe place.
  *
  */
 static inline void copy_edd(void)
 {
-     eddnr = EDD_NR;
-     memcpy(edd, EDD_BUF, sizeof(edd));
-     edd_disk80_sig = DISK80_SIGNATURE;
+     memcpy(edd.mbr_signature, EDD_MBR_SIGNATURE, sizeof(edd.mbr_signature));
+     memcpy(edd.edd_info, EDD_BUF, sizeof(edd.edd_info));
+     edd.mbr_signature_nr = EDD_MBR_SIG_NR;
+     edd.edd_info_nr = EDD_NR;
 }
 #else
-#define copy_edd() do {} while (0)
+static inline void copy_edd(void)
+{
+}
 #endif
 
 void __init setup_arch(char **cmdline_p)
===== drivers/firmware/edd.c 1.29 vs edited =====
--- 1.29/drivers/firmware/edd.c	2004-06-03 03:46:44 -05:00
+++ edited/drivers/firmware/edd.c	2004-06-25 16:33:04 -05:00
@@ -2,7 +2,7 @@
  * linux/arch/i386/kernel/edd.c
  *  Copyright (C) 2002, 2003, 2004 Dell Inc.
  *  by Matt Domsch <Matt_Domsch@dell.com>
- *  disk80 signature by Matt Domsch, Andrew Wilks, and Sandeep K. Shandilya
+ *  disk signature by Matt Domsch, Andrew Wilks, and Sandeep K. Shandilya
  *  legacy CHS by Patrick J. LoPresti <patl@users.sourceforge.net>
  *
  * BIOS Enhanced Disk Drive Services (EDD)
@@ -43,8 +43,8 @@
 #include <linux/blkdev.h>
 #include <linux/edd.h>
 
-#define EDD_VERSION "0.15"
-#define EDD_DATE    "2004-May-17"
+#define EDD_VERSION "0.16"
+#define EDD_DATE    "2004-Jun-25"
 
 MODULE_AUTHOR("Matt Domsch <Matt_Domsch@Dell.com>");
 MODULE_DESCRIPTION("sysfs interface to BIOS EDD information");
@@ -54,6 +54,8 @@
 #define left (PAGE_SIZE - (p - buf) - 1)
 
 struct edd_device {
+	unsigned int index;
+	unsigned int mbr_signature;
 	struct edd_info *info;
 	struct kobject kobj;
 };
@@ -77,6 +79,18 @@
 	.test	= _test,				\
 };
 
+static int
+edd_has_mbr_signature(struct edd_device *edev)
+{
+	return edev->index < min_t(unsigned char, edd.mbr_signature_nr, EDD_MBR_SIG_MAX);
+}
+
+static int
+edd_has_edd_info(struct edd_device *edev)
+{
+	return edev->index < min_t(unsigned char, edd.edd_info_nr, EDDMAXNR);
+}
+
 static inline struct edd_info *
 edd_dev_get_info(struct edd_device *edev)
 {
@@ -84,9 +98,13 @@
 }
 
 static inline void
-edd_dev_set_info(struct edd_device *edev, struct edd_info *info)
+edd_dev_set_info(struct edd_device *edev, int i)
 {
-	edev->info = info;
+	edev->index = i;
+	if (edd_has_mbr_signature(edev))
+		edev->mbr_signature = edd.mbr_signature[i];
+	if (edd_has_edd_info(edev))
+		edev->info = &edd.edd_info[i];
 }
 
 #define to_edd_attr(_attr) container_of(_attr,struct edd_attribute,attr)
@@ -256,10 +274,10 @@
 }
 
 static ssize_t
-edd_show_disk80_sig(struct edd_device *edev, char *buf)
+edd_show_mbr_signature(struct edd_device *edev, char *buf)
 {
 	char *p = buf;
-	p += scnprintf(p, left, "0x%08x\n", edd_disk80_sig);
+	p += scnprintf(p, left, "0x%08x\n", edev->mbr_signature);
 	return (p - buf);
 }
 
@@ -440,10 +458,10 @@
 {
 	struct edd_info *info;
 	if (!edev)
-		return -EINVAL;
+		return 0;
 	info = edd_dev_get_info(edev);
 	if (!info)
-		return -EINVAL;
+		return 0;
 	return info->legacy_max_cylinder > 0;
 }
 
@@ -452,10 +470,10 @@
 {
 	struct edd_info *info;
 	if (!edev)
-		return -EINVAL;
+		return 0;
 	info = edd_dev_get_info(edev);
 	if (!info)
-		return -EINVAL;
+		return 0;
 	return info->legacy_max_head > 0;
 }
 
@@ -464,10 +482,10 @@
 {
 	struct edd_info *info;
 	if (!edev)
-		return -EINVAL;
+		return 0;
 	info = edd_dev_get_info(edev);
 	if (!info)
-		return -EINVAL;
+		return 0;
 	return info->legacy_sectors_per_track > 0;
 }
 
@@ -476,10 +494,10 @@
 {
 	struct edd_info *info;
 	if (!edev)
-		return -EINVAL;
+		return 0;
 	info = edd_dev_get_info(edev);
 	if (!info)
-		return -EINVAL;
+		return 0;
 	return info->params.num_default_cylinders > 0;
 }
 
@@ -488,10 +506,10 @@
 {
 	struct edd_info *info;
 	if (!edev)
-		return -EINVAL;
+		return 0;
 	info = edd_dev_get_info(edev);
 	if (!info)
-		return -EINVAL;
+		return 0;
 	return info->params.num_default_heads > 0;
 }
 
@@ -500,10 +518,10 @@
 {
 	struct edd_info *info;
 	if (!edev)
-		return -EINVAL;
+		return 0;
 	info = edd_dev_get_info(edev);
 	if (!info)
-		return -EINVAL;
+		return 0;
 	return info->params.sectors_per_track > 0;
 }
 
@@ -538,23 +556,12 @@
 	return 1;
 }
 
-static int
-edd_has_disk80_sig(struct edd_device *edev)
-{
-	struct edd_info *info;
-	if (!edev)
-		return 0;
-	info = edd_dev_get_info(edev);
-	if (!info)
-		return 0;
-	return info->device == 0x80;
-}
 
-static EDD_DEVICE_ATTR(raw_data, 0444, edd_show_raw_data, NULL);
-static EDD_DEVICE_ATTR(version, 0444, edd_show_version, NULL);
-static EDD_DEVICE_ATTR(extensions, 0444, edd_show_extensions, NULL);
-static EDD_DEVICE_ATTR(info_flags, 0444, edd_show_info_flags, NULL);
-static EDD_DEVICE_ATTR(sectors, 0444, edd_show_sectors, NULL);
+static EDD_DEVICE_ATTR(raw_data, 0444, edd_show_raw_data, edd_has_edd_info);
+static EDD_DEVICE_ATTR(version, 0444, edd_show_version, edd_has_edd_info);
+static EDD_DEVICE_ATTR(extensions, 0444, edd_show_extensions, edd_has_edd_info);
+static EDD_DEVICE_ATTR(info_flags, 0444, edd_show_info_flags, edd_has_edd_info);
+static EDD_DEVICE_ATTR(sectors, 0444, edd_show_sectors, edd_has_edd_info);
 static EDD_DEVICE_ATTR(legacy_max_cylinder, 0444,
                        edd_show_legacy_max_cylinder,
 		       edd_has_legacy_max_cylinder);
@@ -572,23 +579,23 @@
 		       edd_has_default_sectors_per_track);
 static EDD_DEVICE_ATTR(interface, 0444, edd_show_interface, edd_has_edd30);
 static EDD_DEVICE_ATTR(host_bus, 0444, edd_show_host_bus, edd_has_edd30);
-static EDD_DEVICE_ATTR(mbr_signature, 0444, edd_show_disk80_sig, edd_has_disk80_sig);
+static EDD_DEVICE_ATTR(mbr_signature, 0444, edd_show_mbr_signature, edd_has_mbr_signature);
 
 
 /* These are default attributes that are added for every edd
- * device discovered.
+ * device discovered.  There are none.
  */
 static struct attribute * def_attrs[] = {
-	&edd_attr_raw_data.attr,
-	&edd_attr_version.attr,
-	&edd_attr_extensions.attr,
-	&edd_attr_info_flags.attr,
-	&edd_attr_sectors.attr,
 	NULL,
 };
 
 /* These attributes are conditional and only added for some devices. */
 static struct edd_attribute * edd_attrs[] = {
+	&edd_attr_raw_data,
+	&edd_attr_version,
+	&edd_attr_extensions,
+	&edd_attr_info_flags,
+	&edd_attr_sectors,
 	&edd_attr_legacy_max_cylinder,
 	&edd_attr_legacy_max_head,
 	&edd_attr_legacy_sectors_per_track,
@@ -709,9 +716,9 @@
 	if (!edev)
 		return 1;
 	memset(edev, 0, sizeof (*edev));
-	edd_dev_set_info(edev, &edd[i]);
+	edd_dev_set_info(edev, i);
 	kobject_set_name(&edev->kobj, "int13_dev%02x",
-			 edd[i].device);
+			 0x80 + i);
 	kobj_set_kset_s(edev,edd_subsys);
 	error = kobject_register(&edev->kobj);
 	if (!error)
@@ -719,11 +726,15 @@
 	return error;
 }
 
+static inline int edd_num_devices(void)
+{
+	return min_t(unsigned char,
+		     max_t(unsigned char, edd.edd_info_nr, edd.mbr_signature_nr),
+		     max_t(unsigned char, EDD_MBR_SIG_MAX, EDDMAXNR));
+}
+
 /**
  * edd_init() - creates sysfs tree of EDD data
- *
- * This assumes that eddnr and edd were
- * assigned in setup.c already.
  */
 static int __init
 edd_init(void)
@@ -733,9 +744,9 @@
 	struct edd_device *edev;
 
 	printk(KERN_INFO "BIOS EDD facility v%s %s, %d devices found\n",
-	       EDD_VERSION, EDD_DATE, eddnr);
+	       EDD_VERSION, EDD_DATE, edd_num_devices());
 
-	if (!eddnr) {
+	if (!edd_num_devices()) {
 		printk(KERN_INFO "EDD information not available.\n");
 		return 1;
 	}
@@ -744,7 +755,7 @@
 	if (rc)
 		return rc;
 
-	for (i = 0; i < eddnr && i < EDDMAXNR && !rc; i++) {
+	for (i = 0; i < edd_num_devices() && !rc; i++) {
 		edev = kmalloc(sizeof (*edev), GFP_KERNEL);
 		if (!edev)
 			return -ENOMEM;
@@ -768,7 +779,7 @@
 	int i;
 	struct edd_device *edev;
 
-	for (i = 0; i < eddnr && i < EDDMAXNR; i++) {
+	for (i = 0; i < edd_num_devices(); i++) {
 		if ((edev = edd_devices[i]))
 			edd_device_unregister(edev);
 	}
===== include/asm-i386/setup.h 1.9 vs edited =====
--- 1.9/include/asm-i386/setup.h	2004-03-19 00:03:48 -06:00
+++ edited/include/asm-i386/setup.h	2004-06-25 09:44:56 -05:00
@@ -56,8 +56,9 @@
 #define INITRD_START (*(unsigned long *) (PARAM+0x218))
 #define INITRD_SIZE (*(unsigned long *) (PARAM+0x21c))
 #define EDID_INFO   (*(struct edid_info *) (PARAM+0x440))
-#define DISK80_SIGNATURE (*(unsigned int*) (PARAM+DISK80_SIG_BUFFER))
 #define EDD_NR     (*(unsigned char *) (PARAM+EDDNR))
+#define EDD_MBR_SIG_NR (*(unsigned char *) (PARAM+EDD_MBR_SIG_NR_BUF))
+#define EDD_MBR_SIGNATURE ((unsigned int *) (PARAM+EDD_MBR_SIG_BUF))
 #define EDD_BUF     ((struct edd_info *) (PARAM+EDDBUF))
 
 #endif /* __ASSEMBLY__ */
===== include/linux/edd.h 1.10 vs edited =====
--- 1.10/include/linux/edd.h	2004-06-03 03:46:44 -05:00
+++ edited/include/linux/edd.h	2004-06-25 16:35:11 -05:00
@@ -1,6 +1,6 @@
 /*
  * linux/include/linux/edd.h
- *  Copyright (C) 2002, 2003 Dell Inc.
+ *  Copyright (C) 2002, 2003, 2004 Dell Inc.
  *  by Matt Domsch <Matt_Domsch@dell.com>
  *
  * structures and definitions for the int 13h, ax={41,48}h
@@ -9,8 +9,8 @@
  * available at http://www.t13.org/docs2002/d1572r0.pdf.  It is
  * very similar to D1484 Revision 3 http://www.t13.org/docs2002/d1484r3.pdf
  *
- * In a nutshell, arch/{i386,x86_64}/boot/setup.S populates a scratch table
- * in the empty_zero_block that contains a list of BIOS-enumerated
+ * In a nutshell, arch/{i386,x86_64}/boot/setup.S populates a scratch
+ * table in the boot_params that contains a list of BIOS-enumerated
  * boot devices.
  * In arch/{i386,x86_64}/kernel/setup.c, this information is
  * transferred into the edd structure, and in drivers/firmware/edd.c, that
@@ -31,8 +31,8 @@
 #define _LINUX_EDD_H
 
 #define EDDNR 0x1e9		/* addr of number of edd_info structs at EDDBUF
-				   in empty_zero_block - treat this as 1 byte  */
-#define EDDBUF	0x600		/* addr of edd_info structs in empty_zero_block */
+				   in boot_params - treat this as 1 byte  */
+#define EDDBUF	0x600		/* addr of edd_info structs in boot_params */
 #define EDDMAXNR 6		/* number of edd_info structs starting at EDDBUF  */
 #define EDDEXTSIZE 8		/* change these if you muck with the structures */
 #define EDDPARMSIZE 74
@@ -42,9 +42,13 @@
 #define EDDMAGIC1 0x55AA
 #define EDDMAGIC2 0xAA55
 
-#define READ_SECTORS 0x02
-#define MBR_SIG_OFFSET 0x1B8
-#define DISK80_SIG_BUFFER 0x2cc
+
+#define READ_SECTORS 0x02         /* int13 AH=0x02 is READ_SECTORS command */
+#define EDD_MBR_SIG_OFFSET 0x1B8  /* offset of signature in the MBR */
+#define EDD_MBR_SIG_BUF    0x290  /* addr in boot params */
+#define EDD_MBR_SIG_MAX 16        /* max number of signatures to store */
+#define EDD_MBR_SIG_NR_BUF 0x1ea  /* addr of number of MBR signtaures at EDD_MBR_SIG_BUF
+				     in boot_params - treat this as 1 byte  */
 #ifndef __ASSEMBLY__
 
 #define EDD_EXT_FIXED_DISK_ACCESS           (1 << 0)
@@ -172,9 +176,14 @@
 	struct edd_device_params params;
 } __attribute__ ((packed));
 
-extern struct edd_info edd[EDDMAXNR];
-extern unsigned char eddnr;
-extern unsigned int edd_disk80_sig;
+struct edd {
+	unsigned int mbr_signature[EDD_MBR_SIG_MAX];
+	struct edd_info edd_info[EDDMAXNR];
+	unsigned char mbr_signature_nr;
+	unsigned char edd_info_nr;
+};
+
+extern struct edd edd;
 
 #endif				/*!__ASSEMBLY__ */
 
