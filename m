Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964978AbWJWTrp@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964978AbWJWTrp (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 23 Oct 2006 15:47:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964984AbWJWTrp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 23 Oct 2006 15:47:45 -0400
Received: from e35.co.us.ibm.com ([32.97.110.153]:26034 "EHLO
	e35.co.us.ibm.com") by vger.kernel.org with ESMTP id S964978AbWJWTro
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 23 Oct 2006 15:47:44 -0400
Date: Mon, 23 Oct 2006 15:40:41 -0400
From: Vivek Goyal <vgoyal@in.ibm.com>
To: linux kernel mailing list <linux-kernel@vger.kernel.org>
Cc: Reloc Kernel List <fastboot@lists.osdl.org>, ebiederm@xmission.com,
       akpm@osdl.org, ak@suse.de, hpa@zytor.com, magnus.damm@gmail.com,
       lwang@redhat.com, dzickus@redhat.com, maneesh@in.ibm.com
Subject: [PATCH 9/11] i386: Warn upon absolute relocations being present
Message-ID: <20061023194041.GJ13263@in.ibm.com>
Reply-To: vgoyal@in.ibm.com
References: <20061023192456.GA13263@in.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20061023192456.GA13263@in.ibm.com>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



o Relocations generated w.r.t absolute symbols are not processed as by 
  definition, absolute symbols are not to be relocated. Explicitly warn
  user about absolutions relocations present at compile time. 

o These relocations get introduced either due to linker optimizations or
  some programming oversights.

o Also create a list of symbols which have been audited to be safe and 
  don't emit warnings for these.

Signed-off-by: Vivek Goyal <vgoyal@in.ibm.com>
---

 arch/i386/boot/compressed/Makefile |    2 
 arch/i386/boot/compressed/relocs.c |   82 ++++++++++++++++++++++++++++++++-----
 2 files changed, 73 insertions(+), 11 deletions(-)

diff -puN arch/i386/boot/compressed/Makefile~i386-explicitly-warn-about-absolute-symbols-during-compile arch/i386/boot/compressed/Makefile
--- linux-2.6.19-rc2-git7-reloc/arch/i386/boot/compressed/Makefile~i386-explicitly-warn-about-absolute-symbols-during-compile	2006-10-23 13:15:21.000000000 -0400
+++ linux-2.6.19-rc2-git7-reloc-root/arch/i386/boot/compressed/Makefile	2006-10-23 13:15:21.000000000 -0400
@@ -20,7 +20,7 @@ $(obj)/vmlinux.bin: vmlinux FORCE
 	$(call if_changed,objcopy)
 
 quiet_cmd_relocs = RELOCS  $@
-      cmd_relocs = $(obj)/relocs $< > $@
+      cmd_relocs = $(obj)/relocs $< > $@;$(obj)/relocs --abs-relocs $<
 $(obj)/vmlinux.relocs: vmlinux $(obj)/relocs FORCE
 	$(call if_changed,relocs)
 
diff -puN arch/i386/boot/compressed/relocs.c~i386-explicitly-warn-about-absolute-symbols-during-compile arch/i386/boot/compressed/relocs.c
--- linux-2.6.19-rc2-git7-reloc/arch/i386/boot/compressed/relocs.c~i386-explicitly-warn-about-absolute-symbols-during-compile	2006-10-23 13:15:21.000000000 -0400
+++ linux-2.6.19-rc2-git7-reloc-root/arch/i386/boot/compressed/relocs.c	2006-10-23 13:15:21.000000000 -0400
@@ -19,6 +19,33 @@ static char *strtab[MAX_SHDRS];
 static unsigned long reloc_count, reloc_idx;
 static unsigned long *relocs;
 
+/*
+ * Following symbols have been audited. There values are constant and do
+ * not change if bzImage is loaded at a different physical address than
+ * the address for which it has been compiled. Don't warn user about
+ * absolute relocations present w.r.t these symbols.
+ */
+static const char* safe_abs_relocs[] = {
+		"__kernel_vsyscall",
+		"__kernel_rt_sigreturn",
+		"__kernel_sigreturn",
+		"SYSENTER_RETURN",
+};
+
+static int is_safe_abs_reloc(const char* sym_name)
+{
+	int i, array_size;
+
+	array_size = sizeof(safe_abs_relocs)/sizeof(char*);
+
+	for(i = 0; i < array_size; i++) {
+		if (!strcmp(sym_name, safe_abs_relocs[i]))
+			/* Match found */
+			return 1;
+	}
+	return 0;
+}
+
 static void die(char *fmt, ...)
 {
 	va_list ap;
@@ -359,9 +386,8 @@ static void print_absolute_symbols(void)
 
 static void print_absolute_relocs(void)
 {
-	int i;
-	printf("Absolute relocations\n");
-	printf("Offset     Info     Type     Sym.Value Sym.Name\n");
+	int i, printed = 0;
+
 	for(i = 0; i < ehdr.e_shnum; i++) {
 		char *sym_strtab;
 		Elf32_Sym *sh_symtab;
@@ -387,6 +413,31 @@ static void print_absolute_relocs(void)
 			if (sym->st_shndx != SHN_ABS) {
 				continue;
 			}
+
+			/* Absolute symbols are not relocated if bzImage is
+			 * loaded at a non-compiled address. Display a warning
+			 * to user at compile time about the absolute
+			 * relocations present.
+			 *
+			 * User need to audit the code to make sure
+			 * some symbols which should have been section
+			 * relative have not become absolute because of some
+			 * linker optimization or wrong programming usage.
+			 *
+			 * Before warning check if this absolute symbol
+			 * relocation is harmless.
+			 */
+			if (is_safe_abs_reloc(name))
+				continue;
+
+			if (!printed) {
+				printf("WARNING: Absolute relocations"
+					" present\n");
+				printf("Offset     Info     Type     Sym.Value "
+					"Sym.Name\n");
+				printed = 1;
+			}
+
 			printf("%08x %08x %10s %08x  %s\n",
 				rel->r_offset,
 				rel->r_info,
@@ -395,7 +446,9 @@ static void print_absolute_relocs(void)
 				name);
 		}
 	}
-	printf("\n");
+
+	if (printed)
+		printf("\n");
 }
 
 static void walk_relocs(void (*visit)(Elf32_Rel *rel, Elf32_Sym *sym))
@@ -508,25 +561,31 @@ static void emit_relocs(int as_text)
 
 static void usage(void)
 {
-	die("i386_reloc [--abs | --text] vmlinux\n");
+	die("relocs [--abs-syms |--abs-relocs | --text] vmlinux\n");
 }
 
 int main(int argc, char **argv)
 {
-	int show_absolute;
+	int show_absolute_syms, show_absolute_relocs;
 	int as_text;
 	const char *fname;
 	FILE *fp;
 	int i;
 
-	show_absolute = 0;
+	show_absolute_syms = 0;
+	show_absolute_relocs = 0;
 	as_text = 0;
 	fname = NULL;
 	for(i = 1; i < argc; i++) {
 		char *arg = argv[i];
 		if (*arg == '-') {
-			if (strcmp(argv[1], "--abs") == 0) {
-				show_absolute = 1;
+			if (strcmp(argv[1], "--abs-syms") == 0) {
+				show_absolute_syms = 1;
+				continue;
+			}
+
+			if (strcmp(argv[1], "--abs-relocs") == 0) {
+				show_absolute_relocs = 1;
 				continue;
 			}
 			else if (strcmp(argv[1], "--text") == 0) {
@@ -553,8 +612,11 @@ int main(int argc, char **argv)
 	read_strtabs(fp);
 	read_symtabs(fp);
 	read_relocs(fp);
-	if (show_absolute) {
+	if (show_absolute_syms) {
 		print_absolute_symbols();
+		return 0;
+	}
+	if (show_absolute_relocs) {
 		print_absolute_relocs();
 		return 0;
 	}
_
