Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261748AbVC1N3P@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261748AbVC1N3P (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 28 Mar 2005 08:29:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261786AbVC1N3O
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 28 Mar 2005 08:29:14 -0500
Received: from e5.ny.us.ibm.com ([32.97.182.145]:49068 "EHLO e5.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S261739AbVC1N0H (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 28 Mar 2005 08:26:07 -0500
Subject: [RFC/PATCH 2/17][kexec-tools-1.101] Backup region creation and
	contents copying
From: Vivek Goyal <vgoyal@in.ibm.com>
To: "Eric W. Biederman" <ebiederm@xmission.com>,
       fastboot <fastboot@lists.osdl.org>
Cc: Andrew Morton <akpm@osdl.org>, lkml <linux-kernel@vger.kernel.org>
Content-Type: multipart/mixed; boundary="=-hybxbtMUYUgWF8ulMPha"
Date: Mon, 28 Mar 2005 18:56:03 +0530
Message-Id: <1112016363.4001.73.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.2 (2.0.2-3) 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-hybxbtMUYUgWF8ulMPha
Content-Type: text/plain
Content-Transfer-Encoding: 7bit



--=-hybxbtMUYUgWF8ulMPha
Content-Disposition: attachment; filename=kexec-tools-crashdump-backup-x86.patch
Content-Type: text/x-patch; name=kexec-tools-crashdump-backup-x86.patch; charset=UTF-8
Content-Transfer-Encoding: 7bit


This patch adds support for reserving space for backup region. Also adds code 
in purgatory to copy the first 640K to backup region.

Signed-off-by: Vivek Goyal <vgoyal@in.ibm.com>
---

 kexec-tools-1.101-root/kexec/arch/i386/crashdump-x86.h        |    9 ++
 kexec-tools-1.101-root/kexec/arch/i386/kexec-beoboot-x86.c    |    2 
 kexec-tools-1.101-root/kexec/arch/i386/kexec-bzImage.c        |    2 
 kexec-tools-1.101-root/kexec/arch/i386/kexec-elf-x86.c        |   19 ++++
 kexec-tools-1.101-root/kexec/arch/i386/kexec-multiboot-x86.c  |    4 
 kexec-tools-1.101-root/kexec/arch/i386/kexec-x86.c            |   28 +++++-
 kexec-tools-1.101-root/kexec/arch/i386/kexec-x86.h            |    8 -
 kexec-tools-1.101-root/kexec/arch/i386/x86-linux-setup.c      |    3 
 kexec-tools-1.101-root/kexec/arch/ia64/kexec-elf-ia64.c       |    2 
 kexec-tools-1.101-root/kexec/arch/ia64/kexec-ia64.c           |    5 -
 kexec-tools-1.101-root/kexec/arch/ia64/kexec-ia64.h           |    2 
 kexec-tools-1.101-root/kexec/arch/ppc/kexec-dol-ppc.c         |    2 
 kexec-tools-1.101-root/kexec/arch/ppc/kexec-elf-ppc.c         |    2 
 kexec-tools-1.101-root/kexec/arch/ppc/kexec-ppc.c             |    5 -
 kexec-tools-1.101-root/kexec/arch/ppc/kexec-ppc.h             |    4 
 kexec-tools-1.101-root/kexec/arch/ppc64/kexec-elf-ppc64.c     |    2 
 kexec-tools-1.101-root/kexec/arch/ppc64/kexec-ppc64.h         |    2 
 kexec-tools-1.101-root/kexec/arch/x86_64/kexec-elf-x86_64.c   |    2 
 kexec-tools-1.101-root/kexec/arch/x86_64/kexec-x86_64.c       |    5 -
 kexec-tools-1.101-root/kexec/arch/x86_64/kexec-x86_64.h       |    2 
 kexec-tools-1.101-root/kexec/kexec.c                          |   20 ++--
 kexec-tools-1.101-root/kexec/kexec.h                          |   10 +-
 kexec-tools-1.101-root/purgatory/arch/i386/Makefile           |    1 
 kexec-tools-1.101-root/purgatory/arch/i386/crashdump_backup.c |   44 ++++++++++
 kexec-tools-1.101-root/purgatory/arch/i386/purgatory-x86.c    |    2 
 kexec-tools-1.101-root/purgatory/arch/i386/purgatory-x86.h    |    1 
 26 files changed, 150 insertions(+), 38 deletions(-)

diff -puN /dev/null kexec/arch/i386/crashdump-x86.h
--- /dev/null	2004-02-24 02:32:56.000000000 +0530
+++ kexec-tools-1.101-root/kexec/arch/i386/crashdump-x86.h	2005-03-21 16:44:03.000000000 +0530
@@ -0,0 +1,9 @@
+#ifndef CRASHDUMP_X86_H
+#define CRASHDUMP_X86_H
+
+/* Backup Region, First 640K of System RAM. */
+#define BACKUP_START	0x00000000
+#define BACKUP_END	0x0009ffff
+#define BACKUP_SIZE	(BACKUP_END - BACKUP_START + 1)
+
+#endif /* CRASHDUMP_X86_H */
diff -puN kexec/arch/i386/kexec-beoboot-x86.c~kexec-tools-crashdump-backup-x86 kexec/arch/i386/kexec-beoboot-x86.c
--- kexec-tools-1.101/kexec/arch/i386/kexec-beoboot-x86.c~kexec-tools-crashdump-backup-x86	2005-03-21 16:44:03.000000000 +0530
+++ kexec-tools-1.101-root/kexec/arch/i386/kexec-beoboot-x86.c	2005-03-21 16:44:03.000000000 +0530
@@ -76,7 +76,7 @@ void beoboot_usage(void)
 #define INITRD_BASE 0x1000000 /* 16MB */
 
 int beoboot_load(int argc, char **argv, const char *buf, off_t len,
-	struct kexec_info *info)
+	struct kexec_info *info, unsigned long kexec_flags)
 {
 	struct beoboot_header bb_header;
 	const unsigned char *command_line, *kernel, *initrd;
diff -puN kexec/arch/i386/kexec-bzImage.c~kexec-tools-crashdump-backup-x86 kexec/arch/i386/kexec-bzImage.c
--- kexec-tools-1.101/kexec/arch/i386/kexec-bzImage.c~kexec-tools-crashdump-backup-x86	2005-03-21 16:44:03.000000000 +0530
+++ kexec-tools-1.101-root/kexec/arch/i386/kexec-bzImage.c	2005-03-21 16:44:03.000000000 +0530
@@ -221,7 +221,7 @@ int do_bzImage_load(struct kexec_info *i
 }
 	
 int bzImage_load(int argc, char **argv, const char *buf, off_t len, 
-	struct kexec_info *info)
+	struct kexec_info *info, unsigned long kexec_flags)
 {
 	const char *command_line;
 	const char *ramdisk;
diff -puN kexec/arch/i386/kexec-elf-x86.c~kexec-tools-crashdump-backup-x86 kexec/arch/i386/kexec-elf-x86.c
--- kexec-tools-1.101/kexec/arch/i386/kexec-elf-x86.c~kexec-tools-crashdump-backup-x86	2005-03-21 16:44:03.000000000 +0530
+++ kexec-tools-1.101-root/kexec/arch/i386/kexec-elf-x86.c	2005-03-21 16:44:03.000000000 +0530
@@ -32,10 +32,12 @@
 #include <elf.h>
 #include <x86/x86-linux.h>
 #include "../../kexec.h"
+#include "../../kexec-syscall.h"
 #include "../../kexec-elf.h"
 #include "../../kexec-elf-boot.h"
 #include "x86-linux-setup.h"
 #include "kexec-x86.h"
+#include "crashdump-x86.h"
 #include <arch/options.h>
 
 static const int probe_debug = 0;
@@ -82,7 +84,7 @@ void elf_x86_usage(void)
 }
 
 int elf_x86_load(int argc, char **argv, const char *buf, off_t len, 
-	struct kexec_info *info)
+	struct kexec_info *info, unsigned long kexec_flags)
 {
 	struct mem_ehdr ehdr;
 	const char *command_line;
@@ -233,6 +235,21 @@ int elf_x86_load(int argc, char **argv, 
 			ramdisk_buf = slurp_file(ramdisk, &ramdisk_length);
 		}
 
+		/* If panic kernel is being loaded, additional segments need
+		 * to be created. */
+		if (kexec_flags & KEXEC_ON_CRASH) {
+			void *tmp;
+			unsigned long sz;
+			int nr_ranges, align = 1024;
+			/* Create a backup region segment to store first 638K
+			 * memory*/
+			sz = (BACKUP_SIZE + align - 1) & ~(align - 1);
+			tmp = xmalloc(sz);
+			memset(tmp, 0, sz);
+			info->backup_start = add_buffer(info, tmp, sz, sz, 1024,
+						0, max_addr, 1);
+		}
+
 		/* Tell the kernel what is going on */
 		setup_linux_bootloader_parameters(info, &hdr->hdr, param_base, 
 			offsetof(struct x86_linux_faked_param_header, command_line),
diff -puN kexec/arch/i386/kexec-multiboot-x86.c~kexec-tools-crashdump-backup-x86 kexec/arch/i386/kexec-multiboot-x86.c
--- kexec-tools-1.101/kexec/arch/i386/kexec-multiboot-x86.c~kexec-tools-crashdump-backup-x86	2005-03-21 16:44:03.000000000 +0530
+++ kexec-tools-1.101-root/kexec/arch/i386/kexec-multiboot-x86.c	2005-03-21 16:44:03.000000000 +0530
@@ -138,7 +138,7 @@ void multiboot_x86_usage(void)
 }
 
 int multiboot_x86_load(int argc, char **argv, const char *buf, off_t len,
-	struct kexec_info *info)
+	struct kexec_info *info, unsigned long kexec_flags)
 /* Marshal up a multiboot-style kernel */
 {
 	struct multiboot_info *mbi;
@@ -246,7 +246,7 @@ int multiboot_x86_load(int argc, char **
 	mbi->boot_loader_name = sizeof(*mbi) + command_line_len; 
 
 	/* Memory map */
-	if ((get_memory_ranges(&range, &ranges) < 0) || ranges == 0) {
+	if ((get_memory_ranges(&range, &ranges, kexec_flags) < 0) || ranges == 0) {
 		fprintf(stderr, "Cannot get memory information\n");
 		return -1;
 	}
diff -puN kexec/arch/i386/kexec-x86.c~kexec-tools-crashdump-backup-x86 kexec/arch/i386/kexec-x86.c
--- kexec-tools-1.101/kexec/arch/i386/kexec-x86.c~kexec-tools-crashdump-backup-x86	2005-03-21 16:44:03.000000000 +0530
+++ kexec-tools-1.101-root/kexec/arch/i386/kexec-x86.c	2005-03-21 16:44:03.000000000 +0530
@@ -37,7 +37,8 @@
 static struct memory_range memory_range[MAX_MEMORY_RANGES];
 
 /* Return a sorted list of memory ranges. */
-int get_memory_ranges(struct memory_range **range, int *ranges)
+int get_memory_ranges(struct memory_range **range, int *ranges,
+				unsigned long kexec_flags)
 {
 	const char iomem[]= "/proc/iomem";
 	int memory_ranges = 0;
@@ -79,6 +80,20 @@ int get_memory_ranges(struct memory_rang
 		else if (memcmp(str, "ACPI Non-volatile Storage\n", 26) == 0) {
 			type = RANGE_ACPI_NVS;
 		}
+		else if (memcmp(str, "Crash kernel\n", 13) == 0) {
+		/* Redefine the memory region boundaries if kernel
+		 * exports the limits and if it is panic kernel.
+		 * Override user values only if kernel exported values are
+		 * subset of user defined values.
+		 */
+			if (kexec_flags & KEXEC_ON_CRASH) {
+				if (start > mem_min)
+					mem_min = start;
+				if (end < mem_max)
+					mem_max = end;
+			}
+			continue;
+		}
 		else {
 			continue;
 		}
@@ -247,8 +262,10 @@ int arch_compat_trampoline(struct kexec_
 	return 0;
 }
 
-void arch_update_purgatory(struct kexec_info *info)
+void arch_update_purgatory(struct kexec_info *info, unsigned long kexec_flags)
 {
+	uint8_t panic_kernel = 0;
+
 	elf_rel_set_symbol(&info->rhdr, "reset_vga",
 		&arch_options.reset_vga, sizeof(arch_options.reset_vga));
 	elf_rel_set_symbol(&info->rhdr, "serial_base",
@@ -259,4 +276,11 @@ void arch_update_purgatory(struct kexec_
 		&arch_options.console_vga, sizeof(arch_options.console_vga));
 	elf_rel_set_symbol(&info->rhdr, "console_serial", 
 		&arch_options.console_serial, sizeof(arch_options.console_serial));
+	if (kexec_flags & KEXEC_ON_CRASH) {
+		panic_kernel = 1;
+		elf_rel_set_symbol(&info->rhdr, "backup_start",
+				&info->backup_start, sizeof(info->backup_start));
+	}
+	elf_rel_set_symbol(&info->rhdr, "panic_kernel",
+		&panic_kernel, sizeof(panic_kernel));
 }
diff -puN kexec/arch/i386/kexec-x86.h~kexec-tools-crashdump-backup-x86 kexec/arch/i386/kexec-x86.h
--- kexec-tools-1.101/kexec/arch/i386/kexec-x86.h~kexec-tools-crashdump-backup-x86	2005-03-21 16:44:03.000000000 +0530
+++ kexec-tools-1.101-root/kexec/arch/i386/kexec-x86.h	2005-03-21 16:44:03.000000000 +0530
@@ -37,17 +37,17 @@ struct entry16_regs {
 
 int multiboot_x86_probe(const char *buf, off_t len);
 int multiboot_x86_load(int argc, char **argv, const char *buf, off_t len,
-	struct kexec_info *info);
+	struct kexec_info *info, unsigned long kexec_flags);
 void multiboot_x86_usage(void);
 
 int elf_x86_probe(const char *buf, off_t len);
 int elf_x86_load(int argc, char **argv, const char *buf, off_t len,
-	struct kexec_info *info);
+	struct kexec_info *info, unsigned long kexec_flags);
 void elf_x86_usage(void);
 
 int bzImage_probe(const char *buf, off_t len);
 int bzImage_load(int argc, char **argv, const char *buf, off_t len, 
-	struct kexec_info *info);
+	struct kexec_info *info, unsigned long kexec_flags);
 void bzImage_usage(void);
 int do_bzImage_load(struct kexec_info *info,
 	const char *kernel, off_t kernel_len,
@@ -57,7 +57,7 @@ int do_bzImage_load(struct kexec_info *i
 
 int beoboot_probe(const char *buf, off_t len);
 int beoboot_load(int argc, char **argv, const char *buf, off_t len,
-	struct kexec_info *info);
+	struct kexec_info *info, unsigned long kexec_flags);
 void beoboot_usage(void);
 
 int nbi_probe(const char *buf, off_t len);
diff -puN kexec/arch/i386/x86-linux-setup.c~kexec-tools-crashdump-backup-x86 kexec/arch/i386/x86-linux-setup.c
--- kexec-tools-1.101/kexec/arch/i386/x86-linux-setup.c~kexec-tools-crashdump-backup-x86	2005-03-21 16:44:03.000000000 +0530
+++ kexec-tools-1.101-root/kexec/arch/i386/x86-linux-setup.c	2005-03-21 16:44:03.000000000 +0530
@@ -99,6 +99,7 @@ void setup_linux_system_parameters(struc
 	/* Fill in information the BIOS would usually provide */
 	struct memory_range *range;
 	int i, ranges;
+	unsigned long kexec_flags = 0;
 	
 	/* Default screen size */
 	real_mode->orig_x = 0;
@@ -135,7 +136,7 @@ void setup_linux_system_parameters(struc
 	real_mode->aux_device_info = 0;
 
 	/* Fill in the memory info */
-	if ((get_memory_ranges(&range, &ranges) < 0) || ranges == 0) {
+	if ((get_memory_ranges(&range, &ranges, kexec_flags) < 0) || ranges == 0) {
 		die("Cannot get memory information\n");
 	}
 	if (ranges > E820MAX) {
diff -puN kexec/arch/ia64/kexec-elf-ia64.c~kexec-tools-crashdump-backup-x86 kexec/arch/ia64/kexec-elf-ia64.c
--- kexec-tools-1.101/kexec/arch/ia64/kexec-elf-ia64.c~kexec-tools-crashdump-backup-x86	2005-03-21 16:44:03.000000000 +0530
+++ kexec-tools-1.101-root/kexec/arch/ia64/kexec-elf-ia64.c	2005-03-21 16:44:03.000000000 +0530
@@ -78,7 +78,7 @@ void elf_ia64_usage(void)
 }
 
 int elf_ia64_load(int argc, char **argv, const char *buf, off_t len,
-	struct kexec_info *info)
+	struct kexec_info *info, unsigned long kexec_flags)
 {
 	struct mem_ehdr ehdr;
 	const char *command_line;
diff -puN kexec/arch/ia64/kexec-ia64.c~kexec-tools-crashdump-backup-x86 kexec/arch/ia64/kexec-ia64.c
--- kexec-tools-1.101/kexec/arch/ia64/kexec-ia64.c~kexec-tools-crashdump-backup-x86	2005-03-21 16:44:03.000000000 +0530
+++ kexec-tools-1.101-root/kexec/arch/ia64/kexec-ia64.c	2005-03-21 16:44:03.000000000 +0530
@@ -38,7 +38,8 @@
 static struct memory_range memory_range[MAX_MEMORY_RANGES];
 
 /* Return a sorted list of available memory ranges. */
-int get_memory_ranges(struct memory_range **range, int *ranges)
+int get_memory_ranges(struct memory_range **range, int *ranges,
+				unsigned long kexec_flags)
 {
 	int memory_ranges;
 	/*
@@ -150,7 +151,7 @@ int arch_compat_trampoline(struct kexec_
 	return 0;
 }
 
-void arch_update_purgatory(struct kexec_info *info)
+void arch_update_purgatory(struct kexec_info *info, unsigned long kexec_flags)
 {
 }
 
diff -puN kexec/arch/ia64/kexec-ia64.h~kexec-tools-crashdump-backup-x86 kexec/arch/ia64/kexec-ia64.h
--- kexec-tools-1.101/kexec/arch/ia64/kexec-ia64.h~kexec-tools-crashdump-backup-x86	2005-03-21 16:44:03.000000000 +0530
+++ kexec-tools-1.101-root/kexec/arch/ia64/kexec-ia64.h	2005-03-21 16:44:03.000000000 +0530
@@ -3,7 +3,7 @@
 
 int elf_ia64_probe(const char *buf, off_t len);
 int elf_ia64_load(int argc, char **argv, const char *buf, off_t len,
-	struct kexec_info *info);
+	struct kexec_info *info, unsigned long kexec_flags);
 void elf_ia64_usage(void);
 
 #endif /* KEXEC_IA64_H */
diff -puN kexec/arch/ppc64/kexec-elf-ppc64.c~kexec-tools-crashdump-backup-x86 kexec/arch/ppc64/kexec-elf-ppc64.c
--- kexec-tools-1.101/kexec/arch/ppc64/kexec-elf-ppc64.c~kexec-tools-crashdump-backup-x86	2005-03-21 16:44:03.000000000 +0530
+++ kexec-tools-1.101-root/kexec/arch/ppc64/kexec-elf-ppc64.c	2005-03-21 16:44:03.000000000 +0530
@@ -95,7 +95,7 @@ int elf_ppc64_probe(const char *buf, off
 }
 
 int elf_ppc64_load(int argc, char **argv, const char *buf, off_t len, 
-	struct kexec_info *info)
+	struct kexec_info *info, unsigned long kexec_flags)
 {
 	struct mem_ehdr ehdr;
 
diff -puN kexec/arch/ppc64/kexec-ppc64.h~kexec-tools-crashdump-backup-x86 kexec/arch/ppc64/kexec-ppc64.h
--- kexec-tools-1.101/kexec/arch/ppc64/kexec-ppc64.h~kexec-tools-crashdump-backup-x86	2005-03-21 16:44:03.000000000 +0530
+++ kexec-tools-1.101-root/kexec/arch/ppc64/kexec-ppc64.h	2005-03-21 16:44:03.000000000 +0530
@@ -3,7 +3,7 @@
 
 int elf_ppc64_probe(const char *buf, off_t len);
 int elf_ppc64_load(int argc, char **argv, const char *buf, off_t len,
-	struct kexec_info *info);
+	struct kexec_info *info, unsigned long kexec_flags);
 void elf_ppc64_usage(void);
 
 #endif /* KEXEC_PPC_H */
diff -puN kexec/arch/ppc/kexec-dol-ppc.c~kexec-tools-crashdump-backup-x86 kexec/arch/ppc/kexec-dol-ppc.c
--- kexec-tools-1.101/kexec/arch/ppc/kexec-dol-ppc.c~kexec-tools-crashdump-backup-x86	2005-03-21 16:44:03.000000000 +0530
+++ kexec-tools-1.101-root/kexec/arch/ppc/kexec-dol-ppc.c	2005-03-21 16:44:03.000000000 +0530
@@ -320,7 +320,7 @@ void dol_ppc_usage(void)
 }
 
 int dol_ppc_load(int argc, char **argv, const char *buf, off_t len,
-	struct kexec_info *info)
+	struct kexec_info *info, unsigned long kexec_flags)
 {
 	dol_header header, *h;
 	unsigned long entry;
diff -puN kexec/arch/ppc/kexec-elf-ppc.c~kexec-tools-crashdump-backup-x86 kexec/arch/ppc/kexec-elf-ppc.c
--- kexec-tools-1.101/kexec/arch/ppc/kexec-elf-ppc.c~kexec-tools-crashdump-backup-x86	2005-03-21 16:44:03.000000000 +0530
+++ kexec-tools-1.101-root/kexec/arch/ppc/kexec-elf-ppc.c	2005-03-21 16:44:03.000000000 +0530
@@ -124,7 +124,7 @@ static void gamecube_hack_addresses(stru
 }
 
 int elf_ppc_load(int argc, char **argv,	const char *buf, off_t len, 
-	struct kexec_info *info)
+	struct kexec_info *info, unsigned long kexec_flags)
 {
 	struct mem_ehdr ehdr;
 	char *arg_buf;
diff -puN kexec/arch/ppc/kexec-ppc.c~kexec-tools-crashdump-backup-x86 kexec/arch/ppc/kexec-ppc.c
--- kexec-tools-1.101/kexec/arch/ppc/kexec-ppc.c~kexec-tools-crashdump-backup-x86	2005-03-21 16:44:03.000000000 +0530
+++ kexec-tools-1.101-root/kexec/arch/ppc/kexec-ppc.c	2005-03-21 16:44:03.000000000 +0530
@@ -23,7 +23,8 @@
 static struct memory_range memory_range[MAX_MEMORY_RANGES];
 
 /* Return a sorted list of memory ranges. */
-int get_memory_ranges(struct memory_range **range, int *ranges)
+int get_memory_ranges(struct memory_range **range, int *ranges,
+					unsigned long kexec_flags)
 {
 	int memory_ranges = 0;
 #ifdef CONFIG_GAMECUBE
@@ -145,7 +146,7 @@ int arch_compat_trampoline(struct kexec_
 	return 0;
 }
 
-void arch_update_purgatory(struct kexec_info *info)
+void arch_update_purgatory(struct kexec_info *info, unsigned long kexec_flags)
 {
 }
 
diff -puN kexec/arch/ppc/kexec-ppc.h~kexec-tools-crashdump-backup-x86 kexec/arch/ppc/kexec-ppc.h
--- kexec-tools-1.101/kexec/arch/ppc/kexec-ppc.h~kexec-tools-crashdump-backup-x86	2005-03-21 16:44:03.000000000 +0530
+++ kexec-tools-1.101-root/kexec/arch/ppc/kexec-ppc.h	2005-03-21 16:44:03.000000000 +0530
@@ -17,12 +17,12 @@ extern struct {
 
 int elf_ppc_probe(const char *buf, off_t len);
 int elf_ppc_load(int argc, char **argv, const char *buf, off_t len,
-	struct kexec_info *info);
+	struct kexec_info *info, unsigned long kexec_flags);
 void elf_ppc_usage(void);
 
 int dol_ppc_probe(const char *buf, off_t len);
 int dol_ppc_load(int argc, char **argv, const char *buf, off_t len,
-	struct kexec_info *info);
+	struct kexec_info *info, unsigned long kexec_flags);
 void dol_ppc_usage(void);
 
 #endif /* KEXEC_PPC_H */
diff -puN kexec/arch/x86_64/kexec-elf-x86_64.c~kexec-tools-crashdump-backup-x86 kexec/arch/x86_64/kexec-elf-x86_64.c
--- kexec-tools-1.101/kexec/arch/x86_64/kexec-elf-x86_64.c~kexec-tools-crashdump-backup-x86	2005-03-21 16:44:03.000000000 +0530
+++ kexec-tools-1.101-root/kexec/arch/x86_64/kexec-elf-x86_64.c	2005-03-21 16:44:03.000000000 +0530
@@ -81,7 +81,7 @@ void elf_x86_64_usage(void)
 }
 
 int elf_x86_64_load(int argc, char **argv, const char *buf, off_t len, 
-	struct kexec_info *info)
+	struct kexec_info *info, unsigned long kexec_flags)
 {
 	struct mem_ehdr ehdr;
 	const char *command_line;
diff -puN kexec/arch/x86_64/kexec-x86_64.c~kexec-tools-crashdump-backup-x86 kexec/arch/x86_64/kexec-x86_64.c
--- kexec-tools-1.101/kexec/arch/x86_64/kexec-x86_64.c~kexec-tools-crashdump-backup-x86	2005-03-21 16:44:03.000000000 +0530
+++ kexec-tools-1.101-root/kexec/arch/x86_64/kexec-x86_64.c	2005-03-21 16:44:03.000000000 +0530
@@ -37,7 +37,8 @@
 static struct memory_range memory_range[MAX_MEMORY_RANGES];
 
 /* Return a sorted list of memory ranges. */
-int get_memory_ranges(struct memory_range **range, int *ranges)
+int get_memory_ranges(struct memory_range **range, int *ranges,
+					unsigned long kexec_flags)
 {
 	const char iomem[]= "/proc/iomem";
 	int memory_ranges = 0;
@@ -232,7 +233,7 @@ int arch_compat_trampoline(struct kexec_
 	return 0;
 }
 
-void arch_update_purgatory(struct kexec_info *info)
+void arch_update_purgatory(struct kexec_info *info, unsigned long kexec_flags)
 {
 	elf_rel_set_symbol(&info->rhdr, "reset_vga",
 		&arch_options.reset_vga, sizeof(arch_options.reset_vga));
diff -puN kexec/arch/x86_64/kexec-x86_64.h~kexec-tools-crashdump-backup-x86 kexec/arch/x86_64/kexec-x86_64.h
--- kexec-tools-1.101/kexec/arch/x86_64/kexec-x86_64.h~kexec-tools-crashdump-backup-x86	2005-03-21 16:44:03.000000000 +0530
+++ kexec-tools-1.101-root/kexec/arch/x86_64/kexec-x86_64.h	2005-03-21 16:44:03.000000000 +0530
@@ -25,7 +25,7 @@ struct entry64_regs {
 
 int elf_x86_64_probe(const char *buf, off_t len);
 int elf_x86_64_load(int argc, char **argv, const char *buf, off_t len,
-	struct kexec_info *info);
+	struct kexec_info *info, unsigned long kexec_flags);
 void elf_x86_64_usage(void);
 
 #endif /* KEXEC_X86_64_H */
diff -puN kexec/kexec.c~kexec-tools-crashdump-backup-x86 kexec/kexec.c
--- kexec-tools-1.101/kexec/kexec.c~kexec-tools-crashdump-backup-x86	2005-03-21 16:44:03.000000000 +0530
+++ kexec-tools-1.101-root/kexec/kexec.c	2005-03-21 16:44:03.000000000 +0530
@@ -38,8 +38,8 @@
 #include "kexec-elf.h"
 #include "kexec-sha256.h"
 
-static unsigned long long mem_min = 0;
-static unsigned long long mem_max = ULONG_MAX;
+unsigned long long mem_min = 0;
+unsigned long long mem_max = ULONG_MAX;
 
 void die(char *fmt, ...)
 {
@@ -445,7 +445,7 @@ char *slurp_decompress_file(const char *
 }
 #endif
 
-static void update_purgatory(struct kexec_info *info)
+static void update_purgatory(struct kexec_info *info, unsigned long kexec_flags)
 {
 	static const uint8_t null_buf[256];
 	sha256_context ctx;
@@ -456,7 +456,7 @@ static void update_purgatory(struct kexe
 	if (!info->rhdr.e_shdr) {
 		return;
 	}
-	arch_update_purgatory(info);
+	arch_update_purgatory(info, kexec_flags);
 	memset(region, 0, sizeof(region));
 	sha256_starts(&ctx);
 	/* Compute a hash of the loaded kernel */
@@ -470,6 +470,10 @@ static void update_purgatory(struct kexe
 		if (info->segment[i].mem == (void *)info->rhdr.rel_addr) {
 			continue;
 		}
+		/* Don't include backup region in the checksum */
+		if (info->segment[i].mem == (void *)info->backup_start) {
+			continue;
+		}
 		sha256_update(&ctx, info->segment[i].buf, info->segment[i].bufsz);
 		nullsz = info->segment[i].memsz - info->segment[i].bufsz;
 		while(nullsz) {
@@ -507,6 +511,7 @@ static int my_load(const char *type, int
 	info.segment = NULL;
 	info.nr_segments = 0;
 	info.entry = NULL;
+	info.backup_start = 0;
 
 	result = 0;
 	if (argc - fileind <= 0) {
@@ -522,7 +527,7 @@ static int my_load(const char *type, int
 		kernel_buf, kernel_size);
 #endif
 
-	if (get_memory_ranges(&memory_range, &memory_ranges) < 0) {
+	if (get_memory_ranges(&memory_range, &memory_ranges, kexec_flags) < 0) {
 		fprintf(stderr, "Could not get memory layout\n");
 		return -1;
 	}
@@ -559,7 +564,8 @@ static int my_load(const char *type, int
 			}
 		}
 	}
-	if (file_type[i].load(argc, argv, kernel_buf, kernel_size, &info) < 0) {
+	if (file_type[i].load(argc, argv, kernel_buf, kernel_size, &info,
+				kexec_flags) < 0) {
 		fprintf(stderr, "Cannot load %s\n", kernel);
 		return -1;
 	}
@@ -582,7 +588,7 @@ static int my_load(const char *type, int
 		return -1;
 	}
 	/* if purgatory is loaded update it */
-	update_purgatory(&info);
+	update_purgatory(&info, kexec_flags);
 #if 0
 	fprintf(stderr, "kexec_load: entry = %p flags = %lx\n", 
 		info.entry, kexec_flags);
diff -puN kexec/kexec.h~kexec-tools-crashdump-backup-x86 kexec/kexec.h
--- kexec-tools-1.101/kexec/kexec.h~kexec-tools-crashdump-backup-x86	2005-03-21 16:44:03.000000000 +0530
+++ kexec-tools-1.101-root/kexec/kexec.h	2005-03-21 16:44:03.000000000 +0530
@@ -91,6 +91,8 @@ do { \
 } while(0)
 #endif
 
+extern unsigned long long mem_min, mem_max;
+
 struct kexec_segment {
 	const void *buf;
 	size_t bufsz;
@@ -112,10 +114,12 @@ struct kexec_info {
 	int nr_segments;
 	void *entry;
 	struct mem_ehdr rhdr;
+	unsigned long backup_start;
 };
 
 void usage(void);
-int get_memory_ranges(struct memory_range **range, int *ranges);
+int get_memory_ranges(struct memory_range **range, int *ranges,
+						unsigned long kexec_flags);
 int valid_memory_range(unsigned long sstart, unsigned long send);
 int valid_memory_segment(struct kexec_segment *segment);
 void print_segments(FILE *file, struct kexec_info *info);
@@ -128,7 +132,7 @@ unsigned long locate_hole(struct kexec_i
 typedef int (probe_t)(const char *kernel_buf, off_t kernel_size);
 typedef int (load_t )(int argc, char **argv,
 	const char *kernel_buf, off_t kernel_size, 
-	struct kexec_info *info);
+	struct kexec_info *info, unsigned long kexec_flags);
 typedef void (usage_t)(void);
 struct file_type {
 	const char *name;
@@ -189,6 +193,6 @@ extern size_t purgatory_size;
 void arch_usage(void);
 int arch_process_options(int argc, char **argv);
 int arch_compat_trampoline(struct kexec_info *info, unsigned long *flags);
-void arch_update_purgatory(struct kexec_info *info);
+void arch_update_purgatory(struct kexec_info *info, unsigned long kexec_flags);
 
 #endif /* KEXEC_H */
diff -puN /dev/null purgatory/arch/i386/crashdump_backup.c
--- /dev/null	2004-02-24 02:32:56.000000000 +0530
+++ kexec-tools-1.101-root/purgatory/arch/i386/crashdump_backup.c	2005-03-21 16:44:03.000000000 +0530
@@ -0,0 +1,44 @@
+/*
+ * kexec: Linux boots Linux
+ *
+ * Created by:  Vivek goyal (vgoyal@in.ibm.com)
+ * Copyright (C) IBM Corporation, 2005. All rights reserved
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License as published by
+ * the Free Software Foundation (version 2 of the License).
+ *
+ * This program is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ * GNU General Public License for more details.
+ *
+ * You should have received a copy of the GNU General Public License
+ * along with this program; if not, write to the Free Software
+ * Foundation, Inc., 675 Mass Ave, Cambridge, MA 02139, USA.
+ */
+
+#include <stdint.h>
+#include <string.h>
+
+#define BACKUP_REGION_SOURCE 0x00000000
+#define BACKUP_REGION_SIZE 0xa0000
+
+/* Backup region start gets set after /proc/iomem has been parsed. */
+uint32_t backup_start = 0;
+
+/* Backup first 640K of memory to backup region as reserved by kexec.
+ * Assuming first 640K has to be present on i386 machines and no address
+ * validity checks have to be performed. */
+
+void crashdump_backup_memory(void)
+{
+	void *dest, *src;
+
+	src = (void *) BACKUP_REGION_SOURCE;
+
+	if (backup_start) {
+		dest = (void *)(backup_start);
+		memcpy(dest, src, BACKUP_REGION_SIZE);
+	}
+}
diff -puN purgatory/arch/i386/Makefile~kexec-tools-crashdump-backup-x86 purgatory/arch/i386/Makefile
--- kexec-tools-1.101/purgatory/arch/i386/Makefile~kexec-tools-crashdump-backup-x86	2005-03-21 16:44:03.000000000 +0530
+++ kexec-tools-1.101-root/purgatory/arch/i386/Makefile	2005-03-21 16:44:03.000000000 +0530
@@ -12,3 +12,4 @@ PURGATORY_C_SRCS+= purgatory/arch/i386/p
 PURGATORY_C_SRCS+= purgatory/arch/i386/console-x86.c
 PURGATORY_C_SRCS+= purgatory/arch/i386/vga.c
 PURGATORY_C_SRCS+= purgatory/arch/i386/pic.c
+PURGATORY_C_SRCS+= purgatory/arch/i386/crashdump_backup.c
diff -puN purgatory/arch/i386/purgatory-x86.c~kexec-tools-crashdump-backup-x86 purgatory/arch/i386/purgatory-x86.c
--- kexec-tools-1.101/purgatory/arch/i386/purgatory-x86.c~kexec-tools-crashdump-backup-x86	2005-03-21 16:44:03.000000000 +0530
+++ kexec-tools-1.101-root/purgatory/arch/i386/purgatory-x86.c	2005-03-21 16:44:03.000000000 +0530
@@ -30,6 +30,7 @@ void x86_setup_cpu(void)
 uint8_t reset_vga = 0;
 uint8_t legacy_timer = 0;
 uint8_t legacy_pic   = 0;
+uint8_t panic_kernel = 0;
 
 void setup_arch(void)
 {
@@ -37,4 +38,5 @@ void setup_arch(void)
 	if (reset_vga)    x86_reset_vga();
 	if (legacy_pic)   x86_setup_legacy_pic();
 	/* if (legacy_timer) x86_setup_legacy_timer(); */
+	if (panic_kernel)   crashdump_backup_memory();
 }
diff -puN purgatory/arch/i386/purgatory-x86.h~kexec-tools-crashdump-backup-x86 purgatory/arch/i386/purgatory-x86.h
--- kexec-tools-1.101/purgatory/arch/i386/purgatory-x86.h~kexec-tools-crashdump-backup-x86	2005-03-21 16:44:03.000000000 +0530
+++ kexec-tools-1.101-root/purgatory/arch/i386/purgatory-x86.h	2005-03-21 16:44:03.000000000 +0530
@@ -4,5 +4,6 @@
 void x86_reset_vga(void);
 void x86_setup_legacy_pic(void);
 void x86_setup_legacy_timer(void);
+void crashdump_backup_memory(void);
 
 #endif /* PURGATORY_X86_H */
_

--=-hybxbtMUYUgWF8ulMPha--

