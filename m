Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261474AbUL3AqK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261474AbUL3AqK (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 29 Dec 2004 19:46:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261477AbUL3An4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 29 Dec 2004 19:43:56 -0500
Received: from terminus.zytor.com ([209.128.68.124]:33238 "EHLO
	terminus.zytor.com") by vger.kernel.org with ESMTP id S261474AbUL3Ajy
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 29 Dec 2004 19:39:54 -0500
Message-ID: <41D34E3A.3090708@zytor.com>
Date: Wed, 29 Dec 2004 16:39:22 -0800
From: "H. Peter Anvin" <hpa@zytor.com>
User-Agent: Mozilla Thunderbird 0.9 (X11/20041127)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-kernel <linux-kernel@vger.kernel.org>, Andrew Morton <akpm@osdl.org>,
       SYSLINUX@zytor.com
Subject: [PATCH] /proc/sys/kernel/bootloader_type
Content-Type: multipart/mixed;
 boundary="------------000709070200040702040002"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------000709070200040702040002
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

This patch exports to userspace the boot loader ID which has been 
exported by (b)zImage boot loaders since boot protocol version 2.

Tested on i386 and x86-64; as far as I know those are the only 
architectures which use zImage/bzImage format.

	-hpa


Signed-Off-By: H. Peter Anvin <hpa@zytor.com>


--------------000709070200040702040002
Content-Type: text/x-patch;
 name="bootloader_type.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="bootloader_type.patch"

Index: linux-2.5/arch/i386/Makefile
===================================================================
RCS file: /home/hpa/kernel/bkcvs/linux-2.5/arch/i386/Makefile,v
retrieving revision 1.73
diff -u -r1.73 Makefile
--- linux-2.5/arch/i386/Makefile	24 Dec 2004 21:09:54 -0000	1.73
+++ linux-2.5/arch/i386/Makefile	28 Dec 2004 04:56:17 -0000
@@ -20,6 +20,10 @@
 LDFLAGS_vmlinux :=
 CHECKFLAGS	+= -D__i386__
 
+# This allows compilation with an x86-64 compiler
+CC_M32		:= $(call cc-option,-m32)
+CC 		+= $(CC_M32)
+
 CFLAGS += -pipe -msoft-float
 
 # prevent gcc from keeping the stack 16 byte aligned
Index: linux-2.5/arch/i386/kernel/setup.c
===================================================================
RCS file: /home/hpa/kernel/bkcvs/linux-2.5/arch/i386/kernel/setup.c,v
retrieving revision 1.128
diff -u -r1.128 setup.c
--- linux-2.5/arch/i386/kernel/setup.c	27 Dec 2004 18:21:04 -0000	1.128
+++ linux-2.5/arch/i386/kernel/setup.c	29 Dec 2004 22:10:30 -0000
@@ -97,6 +97,9 @@
 /* For PCI or other memory-mapped resources */
 unsigned long pci_mem_start = 0x10000000;
 
+/* Boot loader ID as an integer, for the benefit of proc_dointvec */
+int bootloader_type;
+
 /* user-defined highmem size */
 static unsigned int highmem_pages = -1;
 
@@ -1338,6 +1341,7 @@
 		BIOS_revision = SYS_DESC_TABLE.table[2];
 	}
 	aux_device_present = AUX_DEVICE_INFO;
+	bootloader_type = LOADER_TYPE;
 
 #ifdef CONFIG_BLK_DEV_RAM
 	rd_image_start = RAMDISK_FLAGS & RAMDISK_IMAGE_START_MASK;
Index: linux-2.5/arch/x86_64/kernel/setup.c
===================================================================
RCS file: /home/hpa/kernel/bkcvs/linux-2.5/arch/x86_64/kernel/setup.c,v
retrieving revision 1.59
diff -u -r1.59 setup.c
--- linux-2.5/arch/x86_64/kernel/setup.c	2 Nov 2004 23:06:28 -0000	1.59
+++ linux-2.5/arch/x86_64/kernel/setup.c	29 Dec 2004 23:46:41 -0000
@@ -78,6 +78,9 @@
 /* For PCI or other memory-mapped resources */
 unsigned long pci_mem_start = 0x10000000;
 
+/* Boot loader ID as an integer, for the benefit of proc_dointvec */
+int bootloader_type;
+
 unsigned long saved_video_mode;
 
 #ifdef CONFIG_SWIOTLB
@@ -452,6 +455,7 @@
 	edid_info = EDID_INFO;
 	aux_device_present = AUX_DEVICE_INFO;
 	saved_video_mode = SAVED_VIDEO_MODE;
+	bootloader_type = LOADER_TYPE;
 
 #ifdef CONFIG_BLK_DEV_RAM
 	rd_image_start = RAMDISK_FLAGS & RAMDISK_IMAGE_START_MASK;
Index: linux-2.5/include/asm-i386/processor.h
===================================================================
RCS file: /home/hpa/kernel/bkcvs/linux-2.5/include/asm-i386/processor.h,v
retrieving revision 1.78
diff -u -r1.78 processor.h
--- linux-2.5/include/asm-i386/processor.h	27 Dec 2004 18:21:04 -0000	1.78
+++ linux-2.5/include/asm-i386/processor.h	29 Dec 2004 23:45:34 -0000
@@ -283,6 +283,9 @@
 extern unsigned int BIOS_revision;
 extern unsigned int mca_pentium_flag;
 
+/* Boot loader type from the setup header */
+extern int bootloader_type;
+
 /*
  * User space process size: 3GB (default).
  */
Index: linux-2.5/include/asm-x86_64/processor.h
===================================================================
RCS file: /home/hpa/kernel/bkcvs/linux-2.5/include/asm-x86_64/processor.h,v
retrieving revision 1.48
diff -u -r1.48 processor.h
--- linux-2.5/include/asm-x86_64/processor.h	27 Dec 2004 18:21:04 -0000	1.48
+++ linux-2.5/include/asm-x86_64/processor.h	29 Dec 2004 23:45:31 -0000
@@ -456,5 +456,7 @@
 #define cache_line_size() (boot_cpu_data.x86_cache_alignment)
 
 extern unsigned long boot_option_idle_override;
+/* Boot loader type from the setup header */
+extern int bootloader_type;
 
 #endif /* __ASM_X86_64_PROCESSOR_H */
Index: linux-2.5/include/linux/sysctl.h
===================================================================
RCS file: /home/hpa/kernel/bkcvs/linux-2.5/include/linux/sysctl.h,v
retrieving revision 1.82
diff -u -r1.82 sysctl.h
--- linux-2.5/include/linux/sysctl.h	20 Oct 2004 15:36:36 -0000	1.82
+++ linux-2.5/include/linux/sysctl.h	29 Dec 2004 22:11:14 -0000
@@ -134,6 +134,7 @@
 	KERN_SPARC_SCONS_PWROFF=64, /* int: serial console power-off halt */
 	KERN_HZ_TIMER=65,	/* int: hz timer on or off */
 	KERN_UNKNOWN_NMI_PANIC=66, /* int: unknown nmi panic flag */
+	KERN_BOOTLOADER_TYPE=67, /* int: boot loader type */
 };
 
 
Index: linux-2.5/kernel/sysctl.c
===================================================================
RCS file: /home/hpa/kernel/bkcvs/linux-2.5/kernel/sysctl.c,v
retrieving revision 1.96
diff -u -r1.96 sysctl.c
--- linux-2.5/kernel/sysctl.c	2 Nov 2004 23:04:07 -0000	1.96
+++ linux-2.5/kernel/sysctl.c	29 Dec 2004 22:10:41 -0000
@@ -624,6 +624,16 @@
 		.proc_handler   = &proc_unknown_nmi_panic,
 	},
 #endif
+#if defined(CONFIG_X86)
+	{
+		.ctl_name	= KERN_BOOTLOADER_TYPE,
+		.procname	= "bootloader_type",
+		.data		= &bootloader_type,
+		.maxlen		= sizeof (int),
+		.mode		= 0444,
+		.proc_handler	= &proc_dointvec,
+	},
+#endif
 	{ .ctl_name = 0 }
 };
 

--------------000709070200040702040002--
