Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262490AbTIUSCZ (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 21 Sep 2003 14:02:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262491AbTIUSCZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 21 Sep 2003 14:02:25 -0400
Received: from zeus.kernel.org ([204.152.189.113]:45240 "EHLO zeus.kernel.org")
	by vger.kernel.org with ESMTP id S262490AbTIUSCO (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 21 Sep 2003 14:02:14 -0400
Date: Mon, 15 Sep 2003 17:16:26 -0500
From: Matt Domsch <Matt_Domsch@DELL.COM>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: Jeff Garzik <jgarzik@pobox.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: 2.7 block ramblings (was Re: DMA for ide-scsi?)
Message-ID: <20030915221626.GA18299@tux.linuxdev.us.dell.com>
Reply-To: Matt Domsch <Matt_Domsch@DELL.COM>
References: <1063578413.2479.18.camel@dhcp23.swansea.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1063578413.2479.18.camel@dhcp23.swansea.linux.org.uk>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Sep 14, 2003 at 05:26:54PM -0500, Alan Cox wrote:
>    On Sad, 2003-09-13 at 17:11, Matt Domsch wrote:
>    > system-unique disk signature to the boot disk (int13 device 80h)
>    > "BOOT" or something - we've got 4 bytes available in the msdos label
>    > for it
> 
>    int 13 is still available during the 16bit boot up phase of the kernel.
>    It does strike me as playing with fire, but an alternative approach
>    might work. Read the first 4K off the boot disk, stuff it somewhere
>    temporary and then in 32bit compare it with the disk starts..

This is what I had in mind.
linux-2.4.23-pre4
+ http://domsch.com/linux/edd30/linux/linux-2.4.23-pre4-edd-20030914.patch.gz
+ patch below

 Documentation/i386/zero-page.txt |    4 +++-
 arch/i386/boot/setup.S           |   21 +++++++++++++++++++++
 arch/i386/kernel/edd.c           |   27 +++++++++++++++++++++++++--
 arch/i386/kernel/i386_ksyms.c    |    1 +
 arch/i386/kernel/setup.c         |    3 +++
 include/asm-i386/edd.h           |    7 ++++++-
 6 files changed, 59 insertions(+), 4 deletions(-)

This puts the 4-byte disk signature into
/proc/bios/edd/int13_dev80/mbr_signature

Thanks,
Matt

-- 
Matt Domsch
Sr. Software Engineer, Lead Engineer
Dell Linux Solutions www.dell.com/linux
Linux on Dell mailing lists @ http://lists.us.dell.com


diff -Nru a/Documentation/i386/zero-page.txt b/Documentation/i386/zero-page.txt
--- a/Documentation/i386/zero-page.txt	Mon Sep 15 17:00:58 2003
+++ b/Documentation/i386/zero-page.txt	Mon Sep 15 17:00:58 2003
@@ -66,8 +66,10 @@
 0x21c	unsigned long	INITRD_SIZE, size in bytes of ramdisk image
 0x220	4 bytes		(setup.S)
 0x224	unsigned short	setup.S heap end pointer
+0x228	4 bytes		DISK80_SIG_BUFFER (setup.S)
 0x2d0 - 0x600		E820MAP
-0x600 - 0x7D4		EDDBUF (setup.S)
+0x600 - 0x800		EDDBUF (setup.S) for disk signature read sector
+0x600 - 0x7d4		EDDBUF (setup.S)
 
 0x800	string, 2K max	COMMAND_LINE, the kernel commandline as
 			copied using CL_OFFSET.
diff -Nru a/arch/i386/boot/setup.S b/arch/i386/boot/setup.S
--- a/arch/i386/boot/setup.S	Mon Sep 15 17:00:58 2003
+++ b/arch/i386/boot/setup.S	Mon Sep 15 17:00:58 2003
@@ -49,6 +49,8 @@
  * by Matt Domsch <Matt_Domsch@dell.com> October 2002
  * conformant to T13 Committee www.t13.org
  *   projects 1572D, 1484D, 1386D, 1226DT
+ * disk signature read by Matt Domsch <Matt_Domsch@dell.com>
+ *	and Andrew Wilks <Andrew_Wilks@dell.com> September 2003
  */
 
 #include <linux/config.h>
@@ -549,6 +551,25 @@
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
--- a/arch/i386/kernel/edd.c	Mon Sep 15 17:00:58 2003
+++ b/arch/i386/kernel/edd.c	Mon Sep 15 17:00:58 2003
@@ -1,7 +1,8 @@
 /*
  * linux/arch/i386/kernel/edd.c
- *  Copyright (C) 2002 Dell Computer Corporation
+ *  Copyright (C) 2002, 2003 Dell, Inc.
  *  by Matt Domsch <Matt_Domsch@dell.com>
+ *  disk80 signature by Matt Domsch, Andrew Wilks, and Sandeep K. Shandilya
  *
  * BIOS Enhanced Disk Drive Services (EDD)
  * conformant to T13 Committee www.t13.org
@@ -27,7 +28,6 @@
 /*
  * TODO:
  * - move edd.[ch] to better locations if/when one is decided
- * - keep current with 2.5 EDD code changes
  */
 
 #include <linux/module.h>
@@ -333,6 +333,18 @@
 }
 
 static int
+edd_show_disk80_sig(char *page, char **start, off_t off, int count, int *eof, void *data)
+{
+	char *p = page;
+	if ( !page || off) {
+		return proc_calc_metrics(page, start, off, count, eof, 0);
+	}
+
+	p += snprintf(p, left, "0x%08x\n", edd_disk80_sig);
+	return proc_calc_metrics(page, start, off, count, eof, (p - page));
+}
+
+static int
 edd_show_extensions(char *page, char **start, off_t off, int count, int *eof, void *data)
 {
 	struct edd_info *info = data;
@@ -491,6 +503,15 @@
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
 static EDD_DEVICE_ATTR(raw_data, edd_show_raw_data, NULL);
 static EDD_DEVICE_ATTR(version, edd_show_version, NULL);
 static EDD_DEVICE_ATTR(extensions, edd_show_extensions, NULL);
@@ -505,6 +526,7 @@
 		       edd_has_default_sectors_per_track);
 static EDD_DEVICE_ATTR(interface, edd_show_interface,edd_has_edd30);
 static EDD_DEVICE_ATTR(host_bus, edd_show_host_bus, edd_has_edd30);
+static EDD_DEVICE_ATTR(mbr_signature, edd_show_disk80_sig, edd_has_disk80_sig);
 
 static struct edd_attribute *def_attrs[] = {
 	&edd_attr_raw_data,
@@ -517,6 +539,7 @@
 	&edd_attr_default_sectors_per_track,
 	&edd_attr_interface,
 	&edd_attr_host_bus,
+	&edd_attr_mbr_signature,
 	NULL,
 };
 
diff -Nru a/arch/i386/kernel/i386_ksyms.c b/arch/i386/kernel/i386_ksyms.c
--- a/arch/i386/kernel/i386_ksyms.c	Mon Sep 15 17:00:58 2003
+++ b/arch/i386/kernel/i386_ksyms.c	Mon Sep 15 17:00:58 2003
@@ -185,4 +185,5 @@
 #ifdef CONFIG_EDD_MODULE
 EXPORT_SYMBOL(edd);
 EXPORT_SYMBOL(eddnr);
+EXPORT_SYMBOL(edd_disk80_sig);
 #endif
diff -Nru a/arch/i386/kernel/setup.c b/arch/i386/kernel/setup.c
--- a/arch/i386/kernel/setup.c	Mon Sep 15 17:00:58 2003
+++ b/arch/i386/kernel/setup.c	Mon Sep 15 17:00:58 2003
@@ -212,6 +212,7 @@
 #define KERNEL_START (*(unsigned long *) (PARAM+0x214))
 #define INITRD_START (*(unsigned long *) (PARAM+0x218))
 #define INITRD_SIZE (*(unsigned long *) (PARAM+0x21c))
+#define DISK80_SIGNATURE (*(unsigned int*) (PARAM+DISK80_SIG_BUFFER))
 #define EDD_NR     (*(unsigned char *) (PARAM+EDDNR))
 #define EDD_BUF     ((struct edd_info *) (PARAM+EDDBUF))
 #define COMMAND_LINE ((char *) (PARAM+2048))
@@ -721,6 +722,7 @@
 #if defined(CONFIG_EDD) || defined(CONFIG_EDD_MODULE)
 unsigned char eddnr;
 struct edd_info edd[EDDMAXNR];
+unsigned int edd_disk80_sig;
 /**
  * copy_edd() - Copy the BIOS EDD information
  *              from empty_zero_page into a safe place.
@@ -730,6 +732,7 @@
 {
      eddnr = EDD_NR;
      memcpy(edd, EDD_BUF, sizeof(edd));
+     edd_disk80_sig = DISK80_SIGNATURE;
 }
 #else
 static inline void copy_edd(void) {}
diff -Nru a/include/asm-i386/edd.h b/include/asm-i386/edd.h
--- a/include/asm-i386/edd.h	Mon Sep 15 17:00:58 2003
+++ b/include/asm-i386/edd.h	Mon Sep 15 17:00:58 2003
@@ -1,6 +1,6 @@
 /*
  * linux/include/asm-i386/edd.h
- *  Copyright (C) 2002 Dell Computer Corporation
+ *  Copyright (C) 2002, 2003 Dell, Inc.
  *  by Matt Domsch <Matt_Domsch@dell.com>
  *
  * structures and definitions for the int 13h, ax={41,48}h
@@ -41,6 +41,10 @@
 #define EDDMAGIC1 0x55AA
 #define EDDMAGIC2 0xAA55
 
+#define READ_SECTORS 0x02
+#define MBR_SIG_OFFSET 0x1B8
+#define DISK80_SIG_BUFFER 0x228
+
 #ifndef __ASSEMBLY__
 
 #define EDD_EXT_FIXED_DISK_ACCESS           (1 << 0)
@@ -167,6 +171,7 @@
 
 extern struct edd_info edd[EDDMAXNR];
 extern unsigned char eddnr;
+extern unsigned int edd_disk80_sig;
 #endif				/*!__ASSEMBLY__ */
 
 #endif				/* _ASM_I386_EDD_H */

