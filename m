Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267683AbTBRGfe>; Tue, 18 Feb 2003 01:35:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267687AbTBRGfd>; Tue, 18 Feb 2003 01:35:33 -0500
Received: from TYO202.gate.nec.co.jp ([202.32.8.202]:18317 "EHLO
	TYO202.gate.nec.co.jp") by vger.kernel.org with ESMTP
	id <S267683AbTBRGfa>; Tue, 18 Feb 2003 01:35:30 -0500
To: Kai Germaschewski <kai@tp1.ruhr-uni-bochum.de>,
       Rusty Russell <rusty@rustcorp.com.au>
Subject: [PATCH]  Enhance script/modpost to handle "_" prefixed symbols
Cc: linux-kernel@vger.kernel.org
Reply-To: Miles Bader <miles@gnu.org>
Message-Id: <20030218064443.CA5BB3728@mcspd15.ucom.lsi.nec.co.jp>
Date: Tue, 18 Feb 2003 15:44:43 +0900 (JST)
From: miles@lsi.nec.co.jp (Miles Bader)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The decision to do so is made by having mk_elfconfig look at the elf
machine-type.  It would be better to actually examine a known symbol,
but that seems quite a bit more complicated.

diff -ruN -X../cludes linux-2.5.62-uc0.orig/scripts/mk_elfconfig.c linux-2.5.62-uc0/scripts/mk_elfconfig.c
--- linux-2.5.62-uc0.orig/scripts/mk_elfconfig.c	2003-02-18 10:13:36.000000000 +0900
+++ linux-2.5.62-uc0/scripts/mk_elfconfig.c	2003-02-18 14:44:52.000000000 +0900
@@ -3,11 +3,17 @@
 #include <string.h>
 #include <elf.h>
 
+/* Bogus old v850 magic number, used by old tools; it's not defined in most
+   <elf.h> files, so define it here.  */
+#define EM_CYGNUS_V850	0x9080
+
 int
 main(int argc, char **argv)
 {
 	unsigned char ei[EI_NIDENT];	
 	union { short s; char c[2]; } endian_test;
+	Elf32_Half mach_type;	/* 32- and 64-bit versions are the same. */
+	int host_little_endian;
 
 	if (fread(ei, 1, EI_NIDENT, stdin) != EI_NIDENT) {
 		fprintf(stderr, "Error: input truncated\n");
@@ -45,13 +51,56 @@
 	}
 
 	endian_test.s = 0x0102;
-	if (memcmp(endian_test.c, "\x01\x02", 2) == 0)
+	if (memcmp(endian_test.c, "\x01\x02", 2) == 0) {
 		printf("#define HOST_ELFDATA ELFDATA2MSB\n");
-	else if (memcmp(endian_test.c, "\x02\x01", 2) == 0)
+		host_little_endian = 0;
+	} else if (memcmp(endian_test.c, "\x02\x01", 2) == 0) {
 		printf("#define HOST_ELFDATA ELFDATA2LSB\n");
-	else
+		host_little_endian = 1;
+	} else
 		abort();
 
+	/* Read the rest of the elf header, and find out the machine type.  */
+	if (ei[EI_CLASS] == ELFCLASS32) {
+		Elf32_Ehdr ehdr;
+		if (fread((char *)&ehdr + EI_NIDENT,
+			  sizeof(Elf32_Ehdr) - EI_NIDENT,
+			  1, stdin) != 1)
+		{
+			fprintf(stderr, "Error: input truncated\n");
+			return 1;
+		}
+		mach_type = ehdr.e_machine;
+	} else {
+		Elf64_Ehdr ehdr;
+		if (fread((char *)&ehdr + EI_NIDENT,
+			  sizeof(Elf64_Ehdr) - EI_NIDENT,
+			  1, stdin) != 1)
+		{
+			fprintf(stderr, "Error: input truncated\n");
+			return 1;
+		}
+		mach_type = ehdr.e_machine;
+	}
+
+	/* Make sure the machine-type is in host byte-order.  */
+	if ((ei[EI_DATA] == ELFDATA2LSB) != host_little_endian)
+		mach_type =
+			((mach_type >> 8) & 0xFF) | ((mach_type & 0xFF) << 8);
+
+	/* Now output any machine-type-specific definitions.  */
+	switch (mach_type) {
+	case EM_V850:
+	case EM_CYGNUS_V850:
+		/* It would be nice to do this by actually examining an elf
+		   symbol -- then it needn't be machine specific -- but
+		   that seems a great deal more complicated.  I don't think
+		   many architectures have this stupid symbol prefix in elf
+		   files anyway.  */
+		printf ("#define KERNEL_SYMBOL_PREFIX \"_\"\n");
+		break;
+	}
+
 	return 0;
 }
 
diff -ruN -X../cludes linux-2.5.62-uc0.orig/scripts/modpost.c linux-2.5.62-uc0/scripts/modpost.c
--- linux-2.5.62-uc0.orig/scripts/modpost.c	2003-02-18 10:13:36.000000000 +0900
+++ linux-2.5.62-uc0/scripts/modpost.c	2003-02-18 14:42:50.000000000 +0900
@@ -13,6 +13,12 @@
 
 #include "modpost.h"
 
+/* Normally elf systems don't use any symbol prefix.  */
+#ifndef KERNEL_SYMBOL_PREFIX
+#define KERNEL_SYMBOL_PREFIX ""
+#endif
+#define KERNEL_SYMBOL_PREFIX_LEN ((sizeof KERNEL_SYMBOL_PREFIX) - 1)
+
 /* Are we using CONFIG_MODVERSIONS? */
 int modversions = 0;
 /* Do we have vmlinux? */
@@ -279,7 +285,7 @@
 		break;
 	case SHN_ABS:
 		/* CRC'd symbol */
-		if (memcmp(symname, "__crc_", 6) == 0) {
+		if (memcmp(symname, KERNEL_SYMBOL_PREFIX "__crc_", 6) == 0) {
 			crc = (unsigned int) sym->st_value;
 			add_exported_symbol(symname+6, mod, &crc);
 			modversions = 1;
@@ -297,8 +303,35 @@
 		break;
 	default:
 		/* All exported symbols */
-		if (memcmp(symname, "__ksymtab_", 10) == 0) {
-			add_exported_symbol(symname+10, mod, NULL);
+		if (memcmp(symname, KERNEL_SYMBOL_PREFIX "__ksymtab_",
+			   KERNEL_SYMBOL_PREFIX_LEN + 10) == 0)
+		{
+			const char *real_symname =
+				symname + KERNEL_SYMBOL_PREFIX_LEN + 10;
+
+			if (KERNEL_SYMBOL_PREFIX_LEN > 0) {
+				size_t len =
+				     strlen(symname) - KERNEL_SYMBOL_PREFIX_LEN + 1;
+				static char *symname_buf = 0;
+				static size_t symname_buf_len = 0;
+
+				if (! symname_buf) {
+					symname_buf_len = len * 2;
+					symname_buf =
+					       NOFAIL(malloc(symname_buf_len));
+				} else if (symname_buf_len < len) {
+					symname_buf_len = len * 2;
+					symname_buf =
+						NOFAIL(realloc(symname_buf,
+							     symname_buf_len));
+				}
+
+				strcpy (symname_buf, KERNEL_SYMBOL_PREFIX);
+				strcat (symname_buf, real_symname);
+				real_symname = symname_buf;
+			}
+
+			add_exported_symbol(real_symname, mod, NULL);
 		}
 		break;
 	}
