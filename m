Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S268286AbTAMS4z>; Mon, 13 Jan 2003 13:56:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S268282AbTAMS4z>; Mon, 13 Jan 2003 13:56:55 -0500
Received: from are.twiddle.net ([64.81.246.98]:18823 "EHLO are.twiddle.net")
	by vger.kernel.org with ESMTP id <S268286AbTAMS4r>;
	Mon, 13 Jan 2003 13:56:47 -0500
Date: Mon, 13 Jan 2003 11:04:57 -0800
From: Richard Henderson <rth@twiddle.net>
To: rusty@rustcorp.com.au
Cc: linux-kernel@vger.kernel.org
Subject: [module-init-tools] fix weak symbol handling
Message-ID: <20030113110457.A936@twiddle.net>
Mail-Followup-To: rusty@rustcorp.com.au, linux-kernel@vger.kernel.org
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The pair to the kernel patch posted a moment ago.


r~



diff -rup module-init-tools-0.9.8/depmod.c module-init-tools-0.9.8-new/depmod.c
--- module-init-tools-0.9.8/depmod.c	Sat Jan 11 00:50:30 2003
+++ module-init-tools-0.9.8-new/depmod.c	Sun Jan 12 12:38:45 2003
@@ -98,7 +98,7 @@ void add_symbol(const char *name, struct
 
 static int print_unknown;
 
-struct module *find_symbol(const char *name, const char *modname)
+struct module *find_symbol(const char *name, const char *modname, int weak)
 {
 	struct symbol *s;
 
@@ -108,7 +108,7 @@ struct module *find_symbol(const char *n
 	}
 
 	/* Ignore __start_* and __stop_* like kernel might. */
-	if (print_unknown
+	if (print_unknown && !weak
 	    && (strncmp(name, "__start_", strlen("__start_")) != 0
 		|| strncmp(name, "__stop_", strlen("__stop_")) != 0))
 		warn("%s needs unknown symbol %s\n", modname, name);
diff -rup module-init-tools-0.9.8/depmod.h module-init-tools-0.9.8-new/depmod.h
--- module-init-tools-0.9.8/depmod.h	Thu Jan  2 02:25:07 2003
+++ module-init-tools-0.9.8-new/depmod.h	Sun Jan 12 12:39:09 2003
@@ -12,7 +12,7 @@ void *do_nofail(void *ptr, const char *f
 #define NOFAIL(ptr)	do_nofail((ptr), __FILE__, __LINE__, #ptr)
 
 void add_symbol(const char *name, struct module *owner);
-struct module *find_symbol(const char *name, const char *modname);
+struct module *find_symbol(const char *name, const char *modname, int weak);
 void add_dep(struct module *mod, struct module *depends_on);
 
 struct module
diff -rup module-init-tools-0.9.8/moduleops.c module-init-tools-0.9.8-new/moduleops.c
--- module-init-tools-0.9.8/moduleops.c	Wed Dec 25 22:04:55 2002
+++ module-init-tools-0.9.8-new/moduleops.c	Sun Jan 12 12:33:31 2003
@@ -10,10 +10,14 @@
 #include "tables.h"
 
 #define PERBIT(x) x##32
-#define ELFPERBIT(x) Elf32_##x
+#define ElfPERBIT(x) Elf32_##x
+#define ELFPERBIT(x) ELF32_##x
 #include "moduleops_core.c"
+
 #undef PERBIT
+#undef ElfPERBIT
 #undef ELFPERBIT
 #define PERBIT(x) x##64
-#define ELFPERBIT(x) Elf64_##x
+#define ElfPERBIT(x) Elf64_##x
+#define ELFPERBIT(x) ELF64_##x
 #include "moduleops_core.c"
diff -rup module-init-tools-0.9.8/moduleops_core.c module-init-tools-0.9.8-new/moduleops_core.c
--- module-init-tools-0.9.8/moduleops_core.c	Fri Jan 10 23:18:05 2003
+++ module-init-tools-0.9.8-new/moduleops_core.c	Mon Jan 13 10:46:06 2003
@@ -1,9 +1,9 @@
 /* Load the given section: NULL on error. */
-static void *PERBIT(load_section)(ELFPERBIT(Ehdr) *hdr,
+static void *PERBIT(load_section)(ElfPERBIT(Ehdr) *hdr,
 			    const char *secname,
 			    unsigned long *size)
 {
-	ELFPERBIT(Shdr) *sechdrs;
+	ElfPERBIT(Shdr) *sechdrs;
 	unsigned int i;
 	char *secnames;
 
@@ -64,7 +64,7 @@ static void PERBIT(calculate_deps)(struc
 	unsigned int i;
 	unsigned long size;
 	char *strings;
-	ELFPERBIT(Sym) *syms;
+	ElfPERBIT(Sym) *syms;
 
 	strings = PERBIT(load_section)(module->mmap, ".strtab", &size);
 	syms = PERBIT(load_section)(module->mmap, ".symtab", &size);
@@ -77,16 +77,15 @@ static void PERBIT(calculate_deps)(struc
 
 	module->num_deps = 0;
 	module->deps = NULL;
-	for (i = 0; i < size / sizeof(syms[0]); i++) {
+	for (i = 1; i < size / sizeof(syms[0]); i++) {
 		if (syms[i].st_shndx == SHN_UNDEF) {
 			/* Look for symbol */
 			const char *name = strings + syms[i].st_name;
 			struct module *owner;
+			int weak;
 
-			if (strcmp(name, "") == 0)
-				continue;
-
-			owner = find_symbol(name, module->pathname);
+			weak = ELFPERBIT(ST_BIND)(syms[i].st_info) == STB_WEAK;
+			owner = find_symbol(name, module->pathname, weak);
 			if (owner) {
 				if (verbose)
 					printf("%s needs \"%s\": %s\n",
@@ -98,13 +97,13 @@ static void PERBIT(calculate_deps)(struc
 	}
 }
 
-static void *PERBIT(deref_sym)(ELFPERBIT(Ehdr) *hdr, const char *name)
+static void *PERBIT(deref_sym)(ElfPERBIT(Ehdr) *hdr, const char *name)
 {
 	unsigned int i;
 	unsigned long size;
 	char *strings;
-	ELFPERBIT(Sym) *syms;
-	ELFPERBIT(Shdr) *sechdrs;
+	ElfPERBIT(Sym) *syms;
+	ElfPERBIT(Shdr) *sechdrs;
 
 	sechdrs = (void *)hdr + hdr->e_shoff;
 	strings = PERBIT(load_section)(hdr, ".strtab", &size);
