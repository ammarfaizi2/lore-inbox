Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261765AbVC1Nq7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261765AbVC1Nq7 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 28 Mar 2005 08:46:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261841AbVC1Npf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 28 Mar 2005 08:45:35 -0500
Received: from e2.ny.us.ibm.com ([32.97.182.142]:10207 "EHLO e2.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S261765AbVC1N0e (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 28 Mar 2005 08:26:34 -0500
Subject: [RFC/PATCH 5/17][kexec-tools-1.101] Add command line option
	"--crash-dump"
From: Vivek Goyal <vgoyal@in.ibm.com>
To: "Eric W. Biederman" <ebiederm@xmission.com>,
       fastboot <fastboot@lists.osdl.org>
Cc: Andrew Morton <akpm@osdl.org>, lkml <linux-kernel@vger.kernel.org>
Content-Type: multipart/mixed; boundary="=-WqtAPZNd1MI11npz0xSB"
Date: Mon, 28 Mar 2005 18:56:26 +0530
Message-Id: <1112016386.4001.76.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.2 (2.0.2-3) 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-WqtAPZNd1MI11npz0xSB
Content-Type: text/plain
Content-Transfer-Encoding: 7bit



--=-WqtAPZNd1MI11npz0xSB
Content-Disposition: attachment; filename=kexec-tools-enable-crash-dump.patch
Content-Type: text/x-patch; name=kexec-tools-enable-crash-dump.patch; charset=UTF-8
Content-Transfer-Encoding: 7bit


o Adds support for enabling crash dump from kexec command line.
o Kexec on panic case can now have either crash dump enabled or disabled. Core
  headers shall be generated based on option selected.
o This helps in keeping kexec on panic case (no core headers) separate which 
  might find some futuristic usage.

Signed-off-by: Vivek Goyal <vgoyal@in.ibm.com>
---

 kexec-tools-1.101-root/kexec/arch/i386/kexec-elf-x86.c     |   19 ++++++++-----
 kexec-tools-1.101-root/kexec/arch/i386/kexec-x86.c         |   11 ++-----
 kexec-tools-1.101-root/kexec/kexec.c                       |   12 ++++++--
 kexec-tools-1.101-root/kexec/kexec.h                       |    1 
 kexec-tools-1.101-root/purgatory/arch/i386/purgatory-x86.c |    4 +-
 5 files changed, 30 insertions(+), 17 deletions(-)

diff -puN kexec/arch/i386/kexec-elf-x86.c~kexec-tools-enable-crash-dump kexec/arch/i386/kexec-elf-x86.c
--- kexec-tools-1.101/kexec/arch/i386/kexec-elf-x86.c~kexec-tools-enable-crash-dump	2005-03-21 18:59:13.000000000 +0530
+++ kexec-tools-1.101-root/kexec/arch/i386/kexec-elf-x86.c	2005-03-21 18:59:13.000000000 +0530
@@ -81,6 +81,7 @@ void elf_x86_usage(void)
 		"    --ramdisk=FILE        Use FILE as the kernel's initial ramdisk.\n"
 		"    --args-linux          Pass linux kernel style options\n"
 		"    --args-elf            Pass elf boot notes\n"
+		"    --crash-dump          Enable core elf headers generation\n"
 		"    --elf32-core-headers  Prepare core headers in ELF32 format\n"
 		"    --elf64-core-headers  Prepare core headers in ELF64 format\n"
 		);
@@ -111,8 +112,9 @@ int elf_x86_load(int argc, char **argv, 
 #define OPT_ARGS_ELF    (OPT_ARCH_MAX+2)
 #define OPT_ARGS_LINUX  (OPT_ARCH_MAX+3)
 #define OPT_ARGS_NONE   (OPT_ARCH_MAX+4)
-#define OPT_ELF32_CORE  (OPT_ARCH_MAX+5)
-#define OPT_ELF64_CORE  (OPT_ARCH_MAX+6)
+#define OPT_CRASH_DUMP  (OPT_ARCH_MAX+5)
+#define OPT_ELF32_CORE  (OPT_ARCH_MAX+6)
+#define OPT_ELF64_CORE  (OPT_ARCH_MAX+7)
 
 	static const struct option options[] = {
 		KEXEC_ARCH_OPTIONS
@@ -123,6 +125,7 @@ int elf_x86_load(int argc, char **argv, 
 		{ "args-elf",		0, NULL, OPT_ARGS_ELF },
 		{ "args-linux",		0, NULL, OPT_ARGS_LINUX },
 		{ "args-none",		0, NULL, OPT_ARGS_NONE },
+		{ "crash-dump",		0, NULL, OPT_CRASH_DUMP },
 		{ "elf32-core-headers",	0, NULL, OPT_ELF32_CORE },
 		{ "elf64-core-headers",	0, NULL, OPT_ELF64_CORE },
 		{ 0, 			0, NULL, 0 },
@@ -168,6 +171,10 @@ int elf_x86_load(int argc, char **argv, 
 			die("--args-none only works on arch i386\n");
 #endif
 			break;
+		case OPT_CRASH_DUMP:
+			if (kexec_flags & KEXEC_ON_CRASH)
+				crash_dump_on = 1;
+			break;
 		case OPT_ELF32_CORE:
 			core_header_type = CORE_TYPE_ELF32;
 			break;
@@ -184,7 +191,7 @@ int elf_x86_load(int argc, char **argv, 
 	/* Need to append some command line parameters internally in case of
 	 * taking crash dumps.
 	 */
-	if (kexec_flags & KEXEC_ON_CRASH) {
+	if (crash_dump_on) {
 		modified_cmdline = xmalloc(COMMAND_LINE_SIZE);
 		memset((void *)modified_cmdline, 0, COMMAND_LINE_SIZE);
 		if (command_line) {
@@ -274,9 +281,9 @@ int elf_x86_load(int argc, char **argv, 
 			ramdisk_buf = slurp_file(ramdisk, &ramdisk_length);
 		}
 
-		/* If panic kernel is being loaded, additional segments need
-		 * to be created. */
-		if (kexec_flags & KEXEC_ON_CRASH) {
+		/* If panic kernel is being loaded, and crash dumps are
+		 * enabled, additional segments need to be created. */
+		if (crash_dump_on) {
 			rc = load_crashdump_segments(info, core_header_type,
 						modified_cmdline, max_addr,
 						min_param_base);
diff -puN kexec/arch/i386/kexec-x86.c~kexec-tools-enable-crash-dump kexec/arch/i386/kexec-x86.c
--- kexec-tools-1.101/kexec/arch/i386/kexec-x86.c~kexec-tools-enable-crash-dump	2005-03-21 18:59:13.000000000 +0530
+++ kexec-tools-1.101-root/kexec/arch/i386/kexec-x86.c	2005-03-21 18:59:13.000000000 +0530
@@ -264,8 +264,6 @@ int arch_compat_trampoline(struct kexec_
 
 void arch_update_purgatory(struct kexec_info *info, unsigned long kexec_flags)
 {
-	uint8_t panic_kernel = 0;
-
 	elf_rel_set_symbol(&info->rhdr, "reset_vga",
 		&arch_options.reset_vga, sizeof(arch_options.reset_vga));
 	elf_rel_set_symbol(&info->rhdr, "serial_base",
@@ -276,11 +274,10 @@ void arch_update_purgatory(struct kexec_
 		&arch_options.console_vga, sizeof(arch_options.console_vga));
 	elf_rel_set_symbol(&info->rhdr, "console_serial", 
 		&arch_options.console_serial, sizeof(arch_options.console_serial));
-	if (kexec_flags & KEXEC_ON_CRASH) {
-		panic_kernel = 1;
+	if (crash_dump_on) {
 		elf_rel_set_symbol(&info->rhdr, "backup_start",
-				&info->backup_start, sizeof(info->backup_start));
+			&info->backup_start, sizeof(info->backup_start));
+		elf_rel_set_symbol(&info->rhdr, "crash_dump_on",
+			&crash_dump_on, sizeof(crash_dump_on));
 	}
-	elf_rel_set_symbol(&info->rhdr, "panic_kernel",
-		&panic_kernel, sizeof(panic_kernel));
 }
diff -puN kexec/kexec.c~kexec-tools-enable-crash-dump kexec/kexec.c
--- kexec-tools-1.101/kexec/kexec.c~kexec-tools-enable-crash-dump	2005-03-21 18:59:13.000000000 +0530
+++ kexec-tools-1.101-root/kexec/kexec.c	2005-03-21 18:59:13.000000000 +0530
@@ -41,6 +41,12 @@
 unsigned long long mem_min = 0;
 unsigned long long mem_max = ULONG_MAX;
 
+/* Denotes whether crash dump is enabled or not. This is valid only if panic
+ * kernel is being loaded. Keeping this case seprate provides the flexibility
+ * to load and boot into a new kernel after panic, without preapring core
+ * headers. May be future use.... */
+uint8_t crash_dump_on;
+
 void die(char *fmt, ...)
 {
 	va_list args;
@@ -470,9 +476,11 @@ static void update_purgatory(struct kexe
 		if (info->segment[i].mem == (void *)info->rhdr.rel_addr) {
 			continue;
 		}
+		if (crash_dump_on) {
 		/* Don't include backup region in the checksum */
-		if (info->segment[i].mem == (void *)info->backup_start) {
-			continue;
+			if (info->segment[i].mem == (void*)info->backup_start) {
+				continue;
+			}
 		}
 		sha256_update(&ctx, info->segment[i].buf, info->segment[i].bufsz);
 		nullsz = info->segment[i].memsz - info->segment[i].bufsz;
diff -puN kexec/kexec.h~kexec-tools-enable-crash-dump kexec/kexec.h
--- kexec-tools-1.101/kexec/kexec.h~kexec-tools-enable-crash-dump	2005-03-21 18:59:13.000000000 +0530
+++ kexec-tools-1.101-root/kexec/kexec.h	2005-03-21 18:59:13.000000000 +0530
@@ -92,6 +92,7 @@ do { \
 #endif
 
 extern unsigned long long mem_min, mem_max;
+extern uint8_t crash_dump_on;
 
 struct kexec_segment {
 	const void *buf;
diff -puN purgatory/arch/i386/purgatory-x86.c~kexec-tools-enable-crash-dump purgatory/arch/i386/purgatory-x86.c
--- kexec-tools-1.101/purgatory/arch/i386/purgatory-x86.c~kexec-tools-enable-crash-dump	2005-03-21 18:59:13.000000000 +0530
+++ kexec-tools-1.101-root/purgatory/arch/i386/purgatory-x86.c	2005-03-21 18:59:13.000000000 +0530
@@ -30,7 +30,7 @@ void x86_setup_cpu(void)
 uint8_t reset_vga = 0;
 uint8_t legacy_timer = 0;
 uint8_t legacy_pic   = 0;
-uint8_t panic_kernel = 0;
+uint8_t crash_dump_on = 0;
 
 void setup_arch(void)
 {
@@ -38,5 +38,5 @@ void setup_arch(void)
 	if (reset_vga)    x86_reset_vga();
 	if (legacy_pic)   x86_setup_legacy_pic();
 	/* if (legacy_timer) x86_setup_legacy_timer(); */
-	if (panic_kernel)   crashdump_backup_memory();
+	if (crash_dump_on)   crashdump_backup_memory();
 }
_

--=-WqtAPZNd1MI11npz0xSB--

