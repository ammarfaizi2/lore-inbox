Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263088AbTLSTBV (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 19 Dec 2003 14:01:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263015AbTLSTBV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 19 Dec 2003 14:01:21 -0500
Received: from linux.us.dell.com ([143.166.224.162]:22944 "EHLO
	lists.us.dell.com") by vger.kernel.org with ESMTP id S263088AbTLSTBG
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 19 Dec 2003 14:01:06 -0500
Date: Fri, 19 Dec 2003 13:01:02 -0600
From: Matt Domsch <Matt_Domsch@dell.com>
To: linux-kernel@vger.kernel.org
Subject: Re: [RFC] 2.6.0 EDD enhancements
Message-ID: <20031219130102.A6530@lists.us.dell.com>
References: <Pine.LNX.4.44.0312191254550.2465-100000@humbolt.us.dell.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <Pine.LNX.4.44.0312191254550.2465-100000@humbolt.us.dell.com>; from Matt_Domsch@dell.com on Fri, Dec 19, 2003 at 12:57:06PM -0600
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is equivalent to the code in 2.4.23 + fix posted today. -Matt


You can import this changeset into BK by piping this whole message to
'| bk receive [path to repository]' or apply the patch as usual.

===================================================================


ChangeSet@1.1532.1.1, 2003-12-18 15:13:36-06:00, Matt_Domsch@dell.com
  EDD: read disk80 MBR signature, export through edd module
  
  There are 4 bytes in the MSDOS master boot record, at offset 0x1b8,
  which may contain a per-system-unique signature.  By first writing a
  unique signature to each disk in the system, then rebooting, and then
  reading the MBR to get the signature for the boot disk (int13 dev
  80h), userspace may use it to compare against disks it knows as named
  /dev/[hs]d[a-z], and thus determine which disk is the BIOS boot disk,
  thus where the /boot, / and boot loaders should be placed.
    
  This is useful in the case where the BIOS is not EDD3.0 compliant,
  thus doesn't provide the PCI bus/dev/fn and IDE/SCSI location of the
  boot disk, yet you need to know which disk is the boot disk.  It's
  most useful in OS installers.
     
  This patch retrieves the signature from the disk in setup.S, stores it
  in a space reserved in the empty_zero_page, copies it somewhere safe
  in setup.c, and exports it via
  /sys/firmware/edd/int13_disk80/mbr_signature in edd.c.  Code is
  covered under CONFIG_EDD=[ym].


 Documentation/i386/zero-page.txt |    4 +++-
 arch/i386/boot/setup.S           |   21 +++++++++++++++++++++
 arch/i386/kernel/edd.c           |   22 +++++++++++++++++++++-
 arch/i386/kernel/i386_ksyms.c    |    6 ------
 arch/i386/kernel/setup.c         |    7 +++++++
 include/asm-i386/edd.h           |    6 +++++-
 include/asm-i386/setup.h         |    1 +
 7 files changed, 58 insertions, 9 deletions


diff -Nru a/Documentation/i386/zero-page.txt b/Documentation/i386/zero-page.txt
--- a/Documentation/i386/zero-page.txt	Fri Dec 19 12:52:44 2003
+++ b/Documentation/i386/zero-page.txt	Fri Dec 19 12:52:44 2003
@@ -66,8 +66,10 @@
 0x21c	unsigned long	INITRD_SIZE, size in bytes of ramdisk image
 0x220	4 bytes		(setup.S)
 0x224	unsigned short	setup.S heap end pointer
+0x2cc	4 bytes		DISK80_SIG_BUFFER (setup.S)
 0x2d0 - 0x600		E820MAP
-0x600 - 0x7D4		EDDBUF (setup.S)
+0x600 - 0x7ff		EDDBUF (setup.S) for disk signature read sector
+0x600 - 0x7d3		EDDBUF (setup.S) for edd data
 
 0x800	string, 2K max	COMMAND_LINE, the kernel commandline as
 			copied using CL_OFFSET.
diff -Nru a/arch/i386/boot/setup.S b/arch/i386/boot/setup.S
--- a/arch/i386/boot/setup.S	Fri Dec 19 12:52:44 2003
+++ b/arch/i386/boot/setup.S	Fri Dec 19 12:52:44 2003
@@ -49,6 +49,8 @@
  * by Matt Domsch <Matt_Domsch@dell.com> October 2002
  * conformant to T13 Committee www.t13.org
  *   projects 1572D, 1484D, 1386D, 1226DT
+ * disk signature read by Matt Domsch <Matt_Domsch@dell.com>
+ *	and Andrew Wilks <Andrew_Wilks@dell.com> September 2003
  */
 
 #include <linux/config.h>
@@ -578,6 +580,25 @@
 #endif
 
 #if defined(CONFIG_EDD) || defined(CONFIG_EDD_MODULE)
+# Read the first sector of device 80h and store the 4-byte signature
+	movl	$0xFFFFFFFF, %eax
+	movl	%eax, (DISK80_SIG_BUFFER)	# assume failure
+	movb	$READ_SECTORS, %ah
+	movb	$1, %al				# read 1 sector
+	movb	$0x80, %dl			# from device 80
+	movb	$0, %dh				# at head 0
+	movw	$1, %cx				# cylinder 0, sector 0
+	pushw	%es
+	pushw	%ds
+	popw	%es
+	movw	$EDDBUF, %bx
+	int	$0x13
+	jc	disk_sig_done
+	movl	(EDDBUF+MBR_SIG_OFFSET), %eax
+	movl	%eax, (DISK80_SIG_BUFFER)	# store success
+disk_sig_done:
+	popw	%es
+
 # Do the BIOS Enhanced Disk Drive calls
 # This consists of two calls:
 #    int 13h ah=41h "Check Extensions Present"
diff -Nru a/arch/i386/kernel/edd.c b/arch/i386/kernel/edd.c
--- a/arch/i386/kernel/edd.c	Fri Dec 19 12:52:44 2003
+++ b/arch/i386/kernel/edd.c	Fri Dec 19 12:52:44 2003
@@ -2,6 +2,7 @@
  * linux/arch/i386/kernel/edd.c
  *  Copyright (C) 2002, 2003 Dell Inc.
  *  by Matt Domsch <Matt_Domsch@dell.com>
+ *  disk80 signature by Matt Domsch, Andrew Wilks, and Sandeep K. Shandilya
  *
  * BIOS Enhanced Disk Drive Services (EDD)
  * conformant to T13 Committee www.t13.org
@@ -59,7 +60,7 @@
 MODULE_DESCRIPTION("sysfs interface to BIOS EDD information");
 MODULE_LICENSE("GPL");
 
-#define EDD_VERSION "0.10 2003-Oct-11"
+#define EDD_VERSION "0.11 2003-Dec-17"
 #define EDD_DEVICE_NAME_SIZE 16
 #define REPORT_URL "http://domsch.com/linux/edd30/results.html"
 
@@ -260,6 +261,14 @@
 }
 
 static ssize_t
+edd_show_disk80_sig(struct edd_device *edev, char *buf)
+{
+	char *p = buf;
+	p += snprintf(p, left, "0x%08x\n", edd_disk80_sig);
+	return (p - buf);
+}
+
+static ssize_t
 edd_show_extensions(struct edd_device *edev, char *buf)
 {
 	struct edd_info *info = edd_dev_get_info(edev);
@@ -429,6 +438,15 @@
 	return 1;
 }
 
+static int
+edd_has_disk80_sig(struct edd_device *edev)
+{
+	struct edd_info *info = edd_dev_get_info(edev);
+	if (!edev || !info)
+		return 0;
+	return info->device == 0x80;
+}
+
 static EDD_DEVICE_ATTR(raw_data, 0444, edd_show_raw_data, NULL);
 static EDD_DEVICE_ATTR(version, 0444, edd_show_version, NULL);
 static EDD_DEVICE_ATTR(extensions, 0444, edd_show_extensions, NULL);
@@ -443,6 +461,7 @@
 		       edd_has_default_sectors_per_track);
 static EDD_DEVICE_ATTR(interface, 0444, edd_show_interface, edd_has_edd30);
 static EDD_DEVICE_ATTR(host_bus, 0444, edd_show_host_bus, edd_has_edd30);
+static EDD_DEVICE_ATTR(mbr_signature, 0444, edd_show_disk80_sig, edd_has_disk80_sig);
 
 
 /* These are default attributes that are added for every edd
@@ -464,6 +483,7 @@
 	&edd_attr_default_sectors_per_track,
 	&edd_attr_interface,
 	&edd_attr_host_bus,
+	&edd_attr_mbr_signature,
 	NULL,
 };
 
diff -Nru a/arch/i386/kernel/i386_ksyms.c b/arch/i386/kernel/i386_ksyms.c
--- a/arch/i386/kernel/i386_ksyms.c	Fri Dec 19 12:52:44 2003
+++ b/arch/i386/kernel/i386_ksyms.c	Fri Dec 19 12:52:44 2003
@@ -32,7 +32,6 @@
 #include <asm/pgalloc.h>
 #include <asm/tlbflush.h>
 #include <asm/nmi.h>
-#include <asm/edd.h>
 #include <asm/ist.h>
 
 extern void dump_thread(struct pt_regs *, struct user *);
@@ -201,11 +200,6 @@
 EXPORT_SYMBOL(kmap_atomic);
 EXPORT_SYMBOL(kunmap_atomic);
 EXPORT_SYMBOL(kmap_atomic_to_page);
-#endif
-
-#ifdef CONFIG_EDD_MODULE
-EXPORT_SYMBOL(edd);
-EXPORT_SYMBOL(eddnr);
 #endif
 
 #if defined(CONFIG_X86_SPEEDSTEP_SMI) || defined(CONFIG_X86_SPEEDSTEP_SMI_MODULE)
diff -Nru a/arch/i386/kernel/setup.c b/arch/i386/kernel/setup.c
--- a/arch/i386/kernel/setup.c	Fri Dec 19 12:52:44 2003
+++ b/arch/i386/kernel/setup.c	Fri Dec 19 12:52:44 2003
@@ -423,6 +423,12 @@
 #if defined(CONFIG_EDD) || defined(CONFIG_EDD_MODULE)
 unsigned char eddnr;
 struct edd_info edd[EDDMAXNR];
+unsigned int edd_disk80_sig;
+#ifdef CONFIG_EDD_MODULE
+EXPORT_SYMBOL(eddnr);
+EXPORT_SYMBOL(edd);
+EXPORT_SYMBOL(edd_disk80_sig);
+#endif
 /**
  * copy_edd() - Copy the BIOS EDD information
  *              from empty_zero_page into a safe place.
@@ -432,6 +438,7 @@
 {
      eddnr = EDD_NR;
      memcpy(edd, EDD_BUF, sizeof(edd));
+     edd_disk80_sig = DISK80_SIGNATURE;
 }
 #else
 #define copy_edd() do {} while (0)
diff -Nru a/include/asm-i386/edd.h b/include/asm-i386/edd.h
--- a/include/asm-i386/edd.h	Fri Dec 19 12:52:44 2003
+++ b/include/asm-i386/edd.h	Fri Dec 19 12:52:44 2003
@@ -1,6 +1,6 @@
 /*
  * linux/include/asm-i386/edd.h
- *  Copyright (C) 2002 Dell Inc.
+ *  Copyright (C) 2002, 2003 Dell Inc.
  *  by Matt Domsch <Matt_Domsch@dell.com>
  *
  * structures and definitions for the int 13h, ax={41,48}h
@@ -41,6 +41,9 @@
 #define EDDMAGIC1 0x55AA
 #define EDDMAGIC2 0xAA55
 
+#define READ_SECTORS 0x02
+#define MBR_SIG_OFFSET 0x1B8
+#define DISK80_SIG_BUFFER 0x2cc
 #ifndef __ASSEMBLY__
 
 #define EDD_EXT_FIXED_DISK_ACCESS           (1 << 0)
@@ -167,6 +170,7 @@
 
 extern struct edd_info edd[EDDMAXNR];
 extern unsigned char eddnr;
+extern unsigned int edd_disk80_sig;
 #endif				/*!__ASSEMBLY__ */
 
 #endif				/* _ASM_I386_EDD_H */
diff -Nru a/include/asm-i386/setup.h b/include/asm-i386/setup.h
--- a/include/asm-i386/setup.h	Fri Dec 19 12:52:44 2003
+++ b/include/asm-i386/setup.h	Fri Dec 19 12:52:44 2003
@@ -39,6 +39,7 @@
 #define INITRD_START (*(unsigned long *) (PARAM+0x218))
 #define INITRD_SIZE (*(unsigned long *) (PARAM+0x21c))
 #define EDID_INFO   (*(struct edid_info *) (PARAM+0x440))
+#define DISK80_SIGNATURE (*(unsigned int*) (PARAM+DISK80_SIG_BUFFER))
 #define EDD_NR     (*(unsigned char *) (PARAM+EDDNR))
 #define EDD_BUF     ((struct edd_info *) (PARAM+EDDBUF))
 #define COMMAND_LINE ((char *) (PARAM+2048))

===================================================================


This BitKeeper patch contains the following changesets:
1.1532.1.1
## Wrapped with gzip_uu ##


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
=T>W>_7[M#;AWA;7# =5UUT*%M?\#,' W/"L?    
 
