Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261679AbVFPAbX@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261679AbVFPAbX (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 15 Jun 2005 20:31:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261680AbVFPAbX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 15 Jun 2005 20:31:23 -0400
Received: from titan.genwebhost.com ([209.9.226.66]:55474 "EHLO
	titan.genwebhost.com") by vger.kernel.org with ESMTP
	id S261679AbVFPAaY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 15 Jun 2005 20:30:24 -0400
Date: Wed, 15 Jun 2005 17:30:18 -0700
From: randy_dunlap <rdunlap@xenotime.net>
To: rusty@rustcorp.com.au
Cc: lkml <linux-kernel@vger.kernel.org>, helgehaf@aitel.hist.no
Subject: [patch] modinfo: check for module tainting
Message-Id: <20050615173018.1812138f.rdunlap@xenotime.net>
Organization: YPO4
X-Mailer: Sylpheed version 1.0.4 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - titan.genwebhost.com
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [0 0] / [47 12]
X-AntiAbuse: Sender Address Domain - xenotime.net
X-Source: 
X-Source-Args: 
X-Source-Dir: 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Helge Hafting suggested on lkml on 2004-april-28 that some program
check for module taintedness (without having to load each module).

Here's version 1 of that (extending 'modinfo'), along with another
fix to modinfo.

I've only tested this on x86-32 as that's all that I have access to.
If someone would test it on some other arch(es)....


Patches for module-init-tools 3.1 and 3.2-pre7 are also available at:

http://www.xenotime.net/linux/modinfo/modinfo-taint-31.patch
http://www.xenotime.net/linux/modinfo/modinfo-taint-32pre7.patch

Here's the patch to 3.2-pre7.

Comments?

---
~Randy



From: Randy Dunlap <rdunlap@xenotime.net>

a.  Fix --field to require an argument so that it works.

b.  Add 'taint' checking to modinfo.
Note:  symbol version checking is not implemented yet [compare
kernel/module.c::check_version()].

Signed-off-by: Randy Dunlap <rdunlap@xenotime.net>

diffstat:=
 Makefile.am   |    2 
 Makefile.in   |    2 
 modinfo.8     |   11 +++
 modinfo.c     |  184 ++++++++++++++++++++++++++++++++++++++++++++++++++++++++--
 modversions.h |    8 ++
 5 files changed, 200 insertions(+), 7 deletions(-)

diff -Naurp module-init-tools-3.2-pre7/modinfo.8~taint module-init-tools-3.2-pre7/modinfo.8
--- module-init-tools-3.2-pre7/modinfo.8~taint	2004-08-26 02:11:07.000000000 -0700
+++ module-init-tools-3.2-pre7/modinfo.8	2005-06-15 17:06:55.000000000 -0700
@@ -56,7 +56,7 @@
 modinfo \(em program to show information about a Linux Kernel module 
 .SH "SYNOPSIS" 
 .PP 
-\fBmodinfo\fR [\fB-0\fP]  [\fB-F \fIfield\fR\fP]  [modulename|filename \&...]  
+\fBmodinfo\fR [\fB-0\fP]  [\fB-F \fIfield\fR\fP]  [\fB-T \fIkernelfile\fR\fP]  [modulename|filename \&...]  
 .PP 
 \fBmodinfo -V\fR 
 .PP 
@@ -77,6 +77,11 @@ filename is listed the same way (althoug
 attribute). 
  
 .PP 
+\fBmodinfo\fR with \fB-T\fR checks for modules that would 'taint'
+the Linux kernel if the module were loaded.  A kernel image file
+must be specified to check against.
+ 
+.PP 
 This version of \fBmodinfo\fR can understand 
 modules of any Linux Kernel architecture. 
 .SH "OPTIONS" 
@@ -108,6 +113,10 @@ These are shortcuts for \fBauthor\fP, 
 transition from the old modutils 
 \fBmodinfo\fR. 
  
+.IP "\fB-T\fP \fB--taint\fP         " 10 
+Check the module(s) for characteristics that would taint the
+Linux kernel.
+ 
 .SH "BACKWARDS COMPATIBILITY" 
 .PP 
 This version of \fBmodinfo\fR is for kernel 
diff -Naurp module-init-tools-3.2-pre7/modinfo.c~taint module-init-tools-3.2-pre7/modinfo.c
--- module-init-tools-3.2-pre7/modinfo.c~taint	2005-01-17 19:25:23.000000000 -0800
+++ module-init-tools-3.2-pre7/modinfo.c	2005-06-15 17:06:55.000000000 -0700
@@ -14,6 +14,9 @@
 #include <sys/mman.h>
 #include "zlibsupport.h"
 #include "backwards_compat.c"
+#include "modversions.h"
+
+#define DEBUG_TAINT	0
 
 #define streq(a,b) (strcmp((a),(b)) == 0)
 #define strstarts(a,start) (strncmp((a),(start), strlen(start)) == 0)
@@ -24,6 +27,8 @@
 
 static int elf_endian;
 static int my_endian;
+static int elf_class_size;	/* 1 = 32-bit, 2 = 64-bit */
+static int elf_class_div;
 
 static inline void __endian(const void *src, void *dest, unsigned int size)
 {
@@ -47,6 +52,7 @@ static void *get_section32(void *file, u
 	const char *secnames;
 	unsigned int i;
 
+	*size = 0;
 	secnames = file
 		+ TO_NATIVE(sechdrs[TO_NATIVE(hdr->e_shstrndx)].sh_offset);
 	for (i = 1; i < TO_NATIVE(hdr->e_shnum); i++)
@@ -82,6 +88,14 @@ static int elf_ident(void *mod, unsigned
 	if (size < EI_CLASS || memcmp(mod, ELFMAG, SELFMAG) != 0)
 		return ELFCLASSNONE;
 	elf_endian = ident[EI_DATA];
+	if (!elf_class_size) {
+#if DEBUG_TAINT
+		fprintf(stderr, "*** init. elf_class_size to %d ***\n",
+			ident[EI_CLASS]);
+#endif
+		elf_class_div = ident[EI_CLASS] == 1 ? 4 : 8;
+	}
+	elf_class_size = ident[EI_CLASS];
 	return ident[EI_CLASS];
 }
 
@@ -220,7 +234,8 @@ static struct option options[] =
 	{"version", 0, 0, 'V'},
 	{"help", 0, 0, 'h'},
 	{"null", 0, 0, '0'},
-	{"field", 0, 0, 'F'},
+	{"field", 1, 0, 'F'},
+	{"taint", 1, 0, 'T'},
 	{0, 0, 0, 0}
 };
 
@@ -320,13 +335,113 @@ static void *grab_module(const char *nam
 	return NULL;
 }
 
+static char *get_modinfo(void *info,
+			 unsigned long infosize,
+			 const char *tag)
+{
+	char *p;
+	unsigned int taglen = strlen(tag);
+
+	for (p = (char *)info; p; p = (char *)next_string(p, &infosize)) {
+		if (strncmp(p, tag, taglen) == 0 && p[taglen] == '=')
+			return p + taglen + 1;
+	}
+	return NULL;
+}
+
+static inline int license_is_gpl_compatible(const char *license)
+{
+	return (strcmp(license, "GPL") == 0
+		|| strcmp(license, "GPL v2") == 0
+		|| strcmp(license, "GPL and additional rights") == 0
+		|| strcmp(license, "Dual BSD/GPL") == 0
+		|| strcmp(license, "Dual MPL/GPL") == 0);
+}
+
+static void check_license(const char *filename, const char *license)
+{
+	int license_gplok;
+
+	if (!license)
+		license = "unspecified";
+
+	license_gplok = license_is_gpl_compatible(license);
+	if (!license_gplok) {
+		printf("%s: module license '%s' taints kernel.\n",
+		       filename, license);
+	}
+}
+
+static int same_magic_modversions(const char *modmag, const char *kernmag)
+{
+	modmag += strcspn(modmag, " ");
+	kernmag += strcspn(kernmag, " ");
+	return strcmp(modmag, kernmag) == 0;
+}
+
+static void check_magic(const char *kernel, const char *filename, char *modmagic)
+{
+	char *buf;
+	ssize_t actual;
+	size_t n = 1024;
+	FILE *fkernel;
+	char kernel_magic[1024] = {0};
+
+	if (!modmagic) {
+		printf("%s: taint: No version magic\n",
+			filename);
+		return;
+	}
+
+	// check modmagic == vermagic (aka kernel_magic);
+
+	buf = malloc(1024);
+	if (!buf) {
+		fprintf(stderr, "modinfo: cannot malloc kernel image memory\n");
+		return;
+	}
+	fkernel = fopen(kernel, "r");
+	if (!fkernel) {
+		fprintf(stderr, "modinfo: could not open %s\n", kernel);
+		free (buf);
+		return;
+	}
+
+	for (;;) {
+		actual = getdelim(&buf, &n, 0, fkernel);
+		if (actual < 0)
+			break;
+		// sample kernel vermagic line to search for:
+		// "2.6.12-rc6 SMP PENTIUM4 gcc-3.3"
+		if (strncmp(buf, "2.6.", 4))
+			continue;
+		if (strstr(buf, "gcc-") == NULL)
+			continue;
+		strcpy(kernel_magic, buf);
+		break;
+	}
+#if DEBUG_TAINT
+	printf("*** got kernel_magic = [%s]\n", kernel_magic);
+#endif
+
+	// for CONFIG_MODVERSIONS=n:
+	if (strcmp(modmagic, kernel_magic))
+		printf("%s: taint: [for CONFIG_MODVERSIONS=n] version magic '%s' should be '%s'\n",
+			filename, modmagic, kernel_magic);
+	// and for CONFIG_MODVERSIONS=y:
+	if (!same_magic_modversions(modmagic, kernel_magic))
+		printf("%s: taint: [for CONFIG_MODVERSIONS=y] version magic '%s' should be '%s'\n",
+			filename, modmagic, kernel_magic);
+}
+
 static void usage(const char *name)
 {
-	fprintf(stderr, "Usage: %s [-0][-F field] module...\n"
+	fprintf(stderr, "Usage: %s [-0][-F field] [-T vmlinux] module...\n"
 		" Prints out the information about one or more module(s).\n"
 		" If a fieldname is given, just print out that field (or nothing if not found).\n"
 		" Otherwise, print all information out in a readable form\n"
-		" If -0 is given, separate with nul, not newline.\n",
+		" If -0 is given, separate with nul, not newline.\n"
+		" If -T is given, check the module for tainting the 'vmlinux' kernel.\n",
 		name);
 }
 
@@ -337,6 +452,8 @@ int main(int argc, char *argv[])
 	char sep = '\n';
 	unsigned long infosize;
 	int opt, ret = 0;
+	int check_taint = 0;
+	char *kernel = NULL;
 
 	if (!getenv("NEW_MODINFO"))
 		try_old_version("modinfo", argv);
@@ -347,7 +464,7 @@ int main(int argc, char *argv[])
 	else
 		abort();
 
-	while ((opt = getopt_long(argc,argv,"adlpVhn0F:",options,NULL)) >= 0){
+	while ((opt = getopt_long(argc,argv,"adlpVT:hn0F:",options,NULL)) >= 0){
 		switch (opt) {
 		case 'a': field = "author"; break;
 		case 'd': field = "description"; break;
@@ -355,6 +472,7 @@ int main(int argc, char *argv[])
 		case 'p': field = "parm"; break;
 		case 'n': field = "filename"; break;
 		case 'V': printf(PACKAGE " version " VERSION "\n"); exit(0);
+		case 'T': check_taint = 1; kernel = optarg; break;
 		case 'F': field = optarg; break;
 		case '0': sep = '\0'; break;
 		default:
@@ -368,6 +486,12 @@ int main(int argc, char *argv[])
 		void *info, *mod;
 		unsigned long modulesize;
 		char *filename;
+		void *exports, *gpls, *crc, *gplcrc,
+			*setup, *obs_parm, *versions;
+		unsigned long exports_size, gpls_size, crc_size,
+			gplcrc_size, setup_size, obs_parm_size, versions_size;
+		char *modmagic, *license;
+		int num_export_syms, num_gpl_syms, num_versions;
 
 		mod = grab_module(argv[opt], &modulesize, &filename);
 		if (!mod) {
@@ -382,6 +506,58 @@ int main(int argc, char *argv[])
 			print_tag(field, info, infosize, filename, sep);
 		else
 			print_all(info, infosize, filename, sep);
+
+		if (check_taint) {
+			exports = get_section(mod, modulesize, &exports_size,
+					"__ksymtab");
+			gpls = get_section(mod, modulesize, &gpls_size,
+					"__ksymtab_gpl");
+			crc = get_section(mod, modulesize, &crc_size,
+					"__kcrctab");
+			gplcrc = get_section(mod, modulesize, &gplcrc_size,
+					"__kcrctab_gpl");
+			setup = get_section(mod, modulesize, &setup_size,
+					"__param");
+			obs_parm = get_section(mod, modulesize, &obs_parm_size,
+					"__obsparm");
+			versions = get_section(mod, modulesize, &versions_size,
+					"__versions");
+			modmagic = get_modinfo(info, infosize, "vermagic");
+			license = get_modinfo(info, infosize, "license");
+
+			num_export_syms = exports_size / elf_class_div;
+			num_gpl_syms = gpls_size / elf_class_div;
+			num_versions = versions_size /
+					sizeof(struct modversion_info);
+
+#if DEBUG_TAINT
+			printf("*** export: %p, gpls: %p, crc: %p, gplcrc: %p, setup: %p, obs_parm: %p, versions: %p, modmagic: %p\n",
+				exports, gpls, crc, gplcrc,
+				setup, obs_parm, versions, modmagic);
+			printf("*** modmagic = [%s]\n", modmagic);
+			printf("*** license = [%s]\n", license);
+			printf("*** num_export_syms = %d\n", num_export_syms);
+			printf("*** num_gpl_syms = %d\n", num_gpl_syms);
+			printf("*** num_versions = %d\n", num_versions);
+#endif
+
+			check_license(filename, license);
+			check_magic(kernel, filename, modmagic);
+
+			if ((num_export_syms && !crc) ||
+			    (num_gpl_syms && !gplcrc))
+				printf("*** %s: taint [if CONFIG_MODVERSIONS=y]: "
+					"No versions for exported symbols.\n",
+					filename);
+			if (setup && obs_parm)
+				printf("*** %s: warning: ignoring new-style "
+					"parameters in presence of obsolete "
+					"ones\n", filename);
+			// TBD: check for symbol versions (crcs) as in
+			// check_version() [if CONFIG_MODVERSIONS];
+			fprintf(stderr, "%s: not checking symbol versions\n",
+				filename);
+		}
 		free(filename);
 	}
 	return ret;
diff -Naurp module-init-tools-3.2-pre7/modversions.h~taint module-init-tools-3.2-pre7/modversions.h
--- module-init-tools-3.2-pre7/modversions.h~taint	2005-06-15 17:06:07.000000000 -0700
+++ module-init-tools-3.2-pre7/modversions.h	2005-06-15 17:06:55.000000000 -0700
@@ -0,0 +1,8 @@
+
+#define MODULE_NAME_LEN (64 - sizeof(unsigned long))
+
+struct modversion_info
+{
+	unsigned long crc;
+	char name[MODULE_NAME_LEN];
+};
diff -Naurp module-init-tools-3.2-pre7/Makefile.am~taint module-init-tools-3.2-pre7/Makefile.am
--- module-init-tools-3.2-pre7/Makefile.am~taint	2005-05-26 19:32:55.000000000 -0700
+++ module-init-tools-3.2-pre7/Makefile.am	2005-06-15 17:06:55.000000000 -0700
@@ -3,7 +3,7 @@ lsmod_SOURCES = lsmod.c testing.h
 modprobe_SOURCES = modprobe.c zlibsupport.c testing.h zlibsupport.h
 rmmod_SOURCES = rmmod.c testing.h
 depmod_SOURCES = depmod.c moduleops.c tables.c zlibsupport.c depmod.h moduleops.h tables.h list.h testing.h  zlibsupport.h
-modinfo_SOURCES = modinfo.c zlibsupport.c testing.h zlibsupport.h
+modinfo_SOURCES = modinfo.c zlibsupport.c testing.h zlibsupport.h modversions.h
 
 insmod_static_SOURCES = insmod.c
 insmod_static_LDFLAGS = -static
diff -Naurp module-init-tools-3.2-pre7/Makefile.in~taint module-init-tools-3.2-pre7/Makefile.in
--- module-init-tools-3.2-pre7/Makefile.in~taint	2005-05-26 19:33:02.000000000 -0700
+++ module-init-tools-3.2-pre7/Makefile.in	2005-06-15 17:06:55.000000000 -0700
@@ -88,7 +88,7 @@ lsmod_SOURCES = lsmod.c testing.h
 modprobe_SOURCES = modprobe.c zlibsupport.c testing.h zlibsupport.h
 rmmod_SOURCES = rmmod.c testing.h
 depmod_SOURCES = depmod.c moduleops.c tables.c zlibsupport.c depmod.h moduleops.h tables.h list.h testing.h  zlibsupport.h
-modinfo_SOURCES = modinfo.c zlibsupport.c testing.h zlibsupport.h
+modinfo_SOURCES = modinfo.c zlibsupport.c testing.h zlibsupport.h modversions.h
 
 insmod_static_SOURCES = insmod.c
 insmod_static_LDFLAGS = -static
