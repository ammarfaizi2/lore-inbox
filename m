Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S268191AbTAMSxX>; Mon, 13 Jan 2003 13:53:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S268211AbTAMSxW>; Mon, 13 Jan 2003 13:53:22 -0500
Received: from are.twiddle.net ([64.81.246.98]:18567 "EHLO are.twiddle.net")
	by vger.kernel.org with ESMTP id <S267979AbTAMSw2>;
	Mon, 13 Jan 2003 13:52:28 -0500
Date: Mon, 13 Jan 2003 11:00:36 -0800
From: Richard Henderson <rth@twiddle.net>
To: rusty@rustcorp.com.au, torvalds@transmeta.com
Cc: linux-kernel@vger.kernel.org
Subject: [MODULES] fix weak symbol handling
Message-ID: <20030113110036.A873@twiddle.net>
Mail-Followup-To: rusty@rustcorp.com.au, torvalds@transmeta.com,
	linux-kernel@vger.kernel.org
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I discovered this while working on oprofile for Alpha.  I thought
I'd avoid a whole series of nested ifdefs by marking some symbols
weak, and so let them go undefined and resolve to null.  Except 
that we don't handle that in the new module loader.

Fixed thus.

I also correct a misconception in simplify_symbol.  It is pointless
to lookup an undefined symbol in the module in which it is undefined.

Pull from 

	bk://are.twiddle.net/mod-2.5

or apply the following patch.


r~


You can import this changeset into BK by piping this whole message to:
'| bk receive [path to repository]' or apply the patch as usual.

===================================================================


ChangeSet@1.945, 2003-01-13 09:47:35-08:00, rth@kanga.twiddle.net
  [MODULES] Centralize undefined symbol checks; handle undef weak.


 arch/alpha/kernel/module.c   |   11 +----
 arch/arm/kernel/module.c     |    5 --
 arch/i386/kernel/module.c    |    8 +---
 arch/ppc/kernel/module.c     |    8 +---
 arch/s390/kernel/module.c    |   10 +----
 arch/s390x/kernel/module.c   |    8 +---
 arch/sparc/kernel/module.c   |   10 +----
 arch/sparc64/kernel/module.c |   10 +----
 arch/v850/kernel/module.c    |   13 +------
 arch/x86_64/kernel/module.c  |    8 +---
 include/linux/elf.h          |   11 +++--
 include/linux/moduleloader.h |    8 ----
 kernel/module.c              |   79 +++++++++++++++++--------------------------
 13 files changed, 62 insertions, 127 deletions


diff -Nru a/arch/alpha/kernel/module.c b/arch/alpha/kernel/module.c
--- a/arch/alpha/kernel/module.c	Mon Jan 13 10:49:22 2003
+++ b/arch/alpha/kernel/module.c	Mon Jan 13 10:49:22 2003
@@ -190,15 +190,10 @@
 		/* This is where to make the change.  */
 		location = base + rela[i].r_offset;
 
-		/* This is the symbol it is referring to.  */
+		/* This is the symbol it is referring to.  Note that all
+		   unresolved symbols have been resolved.  */
 		sym = symtab + r_sym;
-		value = sym->st_value;
-		if (!value) {
-			printk(KERN_ERR "module %s: Unknown symbol %s\n",
-			       me->name, strtab + sym->st_name);
-			return -ENOENT;
-		}
-		value += rela[i].r_addend;
+		value = sym->st_value + rela[i].r_addend;
 
 		switch (r_type) {
 		case R_ALPHA_NONE:
diff -Nru a/arch/arm/kernel/module.c b/arch/arm/kernel/module.c
--- a/arch/arm/kernel/module.c	Mon Jan 13 10:49:22 2003
+++ b/arch/arm/kernel/module.c	Mon Jan 13 10:49:22 2003
@@ -98,11 +98,6 @@
 		}
 
 		sym = ((Elf32_Sym *)symsec->sh_addr) + offset;
-		if (!sym->st_value) {
-			printk(KERN_WARNING "%s: unknown symbol %s\n",
-				module->name, strtab + sym->st_name);
-			return -ENOENT;
-		}
 
 		if (rel->r_offset < 0 || rel->r_offset > dstsec->sh_size - sizeof(u32)) {
 			printk(KERN_ERR "%s: out of bounds relocation, "
diff -Nru a/arch/i386/kernel/module.c b/arch/i386/kernel/module.c
--- a/arch/i386/kernel/module.c	Mon Jan 13 10:49:22 2003
+++ b/arch/i386/kernel/module.c	Mon Jan 13 10:49:22 2003
@@ -70,14 +70,10 @@
 		/* This is where to make the change */
 		location = (void *)sechdrs[sechdrs[relsec].sh_info].sh_addr
 			+ rel[i].r_offset;
-		/* This is the symbol it is referring to */
+		/* This is the symbol it is referring to.  Note that all
+		   undefined symbols have been resolved.  */
 		sym = (Elf32_Sym *)sechdrs[symindex].sh_addr
 			+ ELF32_R_SYM(rel[i].r_info);
-		if (!sym->st_value) {
-			printk(KERN_WARNING "%s: Unknown symbol %s\n",
-			       me->name, strtab + sym->st_name);
-			return -ENOENT;
-		}
 
 		switch (ELF32_R_TYPE(rel[i].r_info)) {
 		case R_386_32:
diff -Nru a/arch/ppc/kernel/module.c b/arch/ppc/kernel/module.c
--- a/arch/ppc/kernel/module.c	Mon Jan 13 10:49:22 2003
+++ b/arch/ppc/kernel/module.c	Mon Jan 13 10:49:22 2003
@@ -197,14 +197,10 @@
 		/* This is where to make the change */
 		location = (void *)sechdrs[sechdrs[relsec].sh_info].sh_addr
 			+ rela[i].r_offset;
-		/* This is the symbol it is referring to */
+		/* This is the symbol it is referring to.  Note that all
+		   undefined symbols have been resolved.  */
 		sym = (Elf32_Sym *)sechdrs[symindex].sh_addr
 			+ ELF32_R_SYM(rela[i].r_info);
-		if (!sym->st_value) {
-			printk(KERN_WARNING "%s: Unknown symbol %s\n",
-			       module->name, strtab + sym->st_name);
-			return -ENOENT;
-		}
 		/* `Everything is relative'. */
 		value = sym->st_value + rela[i].r_addend;
 
diff -Nru a/arch/s390/kernel/module.c b/arch/s390/kernel/module.c
--- a/arch/s390/kernel/module.c	Mon Jan 13 10:49:22 2003
+++ b/arch/s390/kernel/module.c	Mon Jan 13 10:49:22 2003
@@ -1,5 +1,5 @@
 /*
- *  arch/s390x/kernel/module.c - Kernel module help for s390x.
+ *  arch/s390/kernel/module.c - Kernel module help for s390.
  *
  *  S390 version
  *    Copyright (C) 2002 IBM Deutschland Entwicklung GmbH, IBM Corporation
@@ -77,14 +77,10 @@
 		/* This is where to make the change */
 		location = (void *)sechdrs[sechdrs[relsec].sh_info].sh_addr
 			+ rel[i].r_offset;
-		/* This is the symbol it is referring to */
+		/* This is the symbol it is referring to.  Note that all
+		   undefined symbols have been resolved.  */
 		sym = (ElfW(Sym) *)sechdrs[symindex].sh_addr
 			+ ELFW(R_SYM)(rel[i].r_info);
-		if (!sym->st_value) {
-			printk(KERN_WARNING "%s: Unknown symbol %s\n",
-			       me->name, strtab + sym->st_name);
-			return -ENOENT;
-		}
 
 		switch (ELF_R_TYPE(rel[i].r_info)) {
 		case R_390_8:		/* Direct 8 bit.   */
diff -Nru a/arch/s390x/kernel/module.c b/arch/s390x/kernel/module.c
--- a/arch/s390x/kernel/module.c	Mon Jan 13 10:49:22 2003
+++ b/arch/s390x/kernel/module.c	Mon Jan 13 10:49:22 2003
@@ -78,14 +78,10 @@
 		/* This is where to make the change */
 		location = (void *)sechdrs[sechdrs[relsec].sh_info].sh_addr
 			+ rel[i].r_offset;
-		/* This is the symbol it is referring to */
+		/* This is the symbol it is referring to.  Note that all
+		   undefined symbols have been resolved.  */
 		sym = (ElfW(Sym) *)sechdrs[symindex].sh_addr
 			+ ELFW(R_SYM)(rel[i].r_info);
-		if (!sym->st_value) {
-			printk(KERN_WARNING "%s: Unknown symbol %s\n",
-			       me->name, strtab + sym->st_name);
-			return -ENOENT;
-		}
 
 		switch (ELF_R_TYPE(rel[i].r_info)) {
 		case R_390_8:		/* Direct 8 bit.   */
diff -Nru a/arch/sparc/kernel/module.c b/arch/sparc/kernel/module.c
--- a/arch/sparc/kernel/module.c	Mon Jan 13 10:49:22 2003
+++ b/arch/sparc/kernel/module.c	Mon Jan 13 10:49:22 2003
@@ -75,15 +75,11 @@
 		location = (u8 *)sechdrs[sechdrs[relsec].sh_info].sh_addr
 			+ rel[i].r_offset;
 		loc32 = (u32 *) location;
-		/* This is the symbol it is referring to */
+		/* This is the symbol it is referring to.  Note that all
+		   undefined symbols have been resolved.  */
 		sym = (Elf32_Sym *)sechdrs[symindex].sh_addr
 			+ ELF32_R_SYM(rel[i].r_info);
-		if (!(v = sym->st_value)) {
-			printk(KERN_WARNING "%s: Unknown symbol %s\n",
-			       me->name, strtab + sym->st_name);
-			return -ENOENT;
-		}
-		v += rel[i].r_addend;
+		v = sym->st_value + rel[i].r_addend;
 
 		switch (ELF32_R_TYPE(rel[i].r_info)) {
 		case R_SPARC_32:
diff -Nru a/arch/sparc64/kernel/module.c b/arch/sparc64/kernel/module.c
--- a/arch/sparc64/kernel/module.c	Mon Jan 13 10:49:22 2003
+++ b/arch/sparc64/kernel/module.c	Mon Jan 13 10:49:22 2003
@@ -185,15 +185,11 @@
 
 		BUG_ON(((u64)location >> (u64)32) != (u64)0);
 
-		/* This is the symbol it is referring to */
+		/* This is the symbol it is referring to.  Note that all
+		   undefined symbols have been resolved.  */
 		sym = (Elf64_Sym *)sechdrs[symindex].sh_addr
 			+ ELF64_R_SYM(rel[i].r_info);
-		if (!(v = sym->st_value)) {
-			printk(KERN_WARNING "%s: Unknown symbol %s\n",
-			       me->name, strtab + sym->st_name);
-			return -ENOENT;
-		}
-		v += rel[i].r_addend;
+		v = sym->st_value + rel[i].r_addend;
 
 		switch (ELF64_R_TYPE(rel[i].r_info) & 0xff) {
 		case R_SPARC_64:
diff -Nru a/arch/v850/kernel/module.c b/arch/v850/kernel/module.c
--- a/arch/v850/kernel/module.c	Mon Jan 13 10:49:22 2003
+++ b/arch/v850/kernel/module.c	Mon Jan 13 10:49:22 2003
@@ -184,19 +184,12 @@
 		uint32_t *loc
 			= ((void *)sechdrs[sechdrs[relsec].sh_info].sh_addr
 			   + rela[i].r_offset);
-		/* This is the symbol it is referring to */
+		/* This is the symbol it is referring to.  Note that all
+		   undefined symbols have been resolved.  */
 		Elf32_Sym *sym
 			= ((Elf32_Sym *)sechdrs[symindex].sh_addr
 			   + ELF32_R_SYM (rela[i].r_info));
-		uint32_t val = sym->st_value;
-
-		if (! val) {
-			printk (KERN_WARNING "%s: Unknown symbol %s\n",
-				mod->name, strtab + sym->st_name);
-			return -ENOENT;
-		}
-
-		val += rela[i].r_addend;
+		uint32_t val = sym->st_value + rela[i].r_addend;
 
 		switch (ELF32_R_TYPE (rela[i].r_info)) {
 		case R_V850_32:
diff -Nru a/arch/x86_64/kernel/module.c b/arch/x86_64/kernel/module.c
--- a/arch/x86_64/kernel/module.c	Mon Jan 13 10:49:22 2003
+++ b/arch/x86_64/kernel/module.c	Mon Jan 13 10:49:22 2003
@@ -53,14 +53,10 @@
 		loc = (void *)sechdrs[sechdrs[relsec].sh_info].sh_addr
 			+ rel[i].r_offset;
 
-		/* This is the symbol it is referring to */
+		/* This is the symbol it is referring to.  Note that all
+		   undefined symbols have been resolved.  */
 		sym = (Elf64_Sym *)sechdrs[symindex].sh_addr
 			+ ELF64_R_SYM(rel[i].r_info);
-		if (!sym->st_value) {
-			printk(KERN_WARNING "%s: Unknown symbol %s\n",
-			       me->name, strtab + sym->st_name);
-			return -ENOENT;
-		}
 
 	        DEBUGP("type %d st_value %Lx r_addend %Lx loc %Lx\n",
 		       (int)ELF64_R_TYPE(rel[i].r_info), 
diff -Nru a/include/linux/elf.h b/include/linux/elf.h
--- a/include/linux/elf.h	Mon Jan 13 10:49:22 2003
+++ b/include/linux/elf.h	Mon Jan 13 10:49:22 2003
@@ -156,11 +156,12 @@
 #define STT_SECTION 3
 #define STT_FILE    4
 
-#define ELF32_ST_BIND(x) ((x) >> 4)
-#define ELF32_ST_TYPE(x) (((unsigned int) x) & 0xf)
-
-#define ELF64_ST_BIND(x) ((x) >> 4)
-#define ELF64_ST_TYPE(x) (((unsigned int) x) & 0xf)
+#define ELF_ST_BIND(x)		((x) >> 4)
+#define ELF_ST_TYPE(x)		(((unsigned int) x) & 0xf)
+#define ELF32_ST_BIND(x)	ELF_ST_BIND(x)
+#define ELF32_ST_TYPE(x)	ELF_ST_TYPE(x)
+#define ELF64_ST_BIND(x)	ELF_ST_BIND(x)
+#define ELF64_ST_TYPE(x)	ELF_ST_TYPE(x)
 
 /* Symbolic values for the entries in the auxiliary table
    put on the initial stack */
diff -Nru a/include/linux/moduleloader.h b/include/linux/moduleloader.h
--- a/include/linux/moduleloader.h	Mon Jan 13 10:49:22 2003
+++ b/include/linux/moduleloader.h	Mon Jan 13 10:49:22 2003
@@ -5,14 +5,6 @@
 #include <linux/module.h>
 #include <linux/elf.h>
 
-/* Helper function for arch-specific module loaders */
-unsigned long find_symbol_internal(Elf_Shdr *sechdrs,
-				   unsigned int symindex,
-				   const char *strtab,
-				   const char *name,
-				   struct module *mod,
-				   struct kernel_symbol_group **group);
-
 /* These must be implemented by the specific architecture */
 
 /* Adjust arch-specific sections.  Return 0 on success.  */
diff -Nru a/kernel/module.c b/kernel/module.c
--- a/kernel/module.c	Mon Jan 13 10:49:22 2003
+++ b/kernel/module.c	Mon Jan 13 10:49:22 2003
@@ -722,28 +722,22 @@
 }
 #endif /* CONFIG_OBSOLETE_MODPARM */
 
-/* Find an symbol for this module (ie. resolve internals first).
-   It we find one, record usage.  Must be holding module_mutex. */
-unsigned long find_symbol_internal(Elf_Shdr *sechdrs,
-				   unsigned int symindex,
-				   const char *strtab,
-				   const char *name,
-				   struct module *mod,
-				   struct kernel_symbol_group **ksg)
+/* Resolve a symbol for this module.  I.e. if we find one, record usage.
+   Must be holding module_mutex. */
+static unsigned long resolve_symbol(Elf_Shdr *sechdrs,
+				    unsigned int symindex,
+				    const char *strtab,
+				    const char *name,
+				    struct module *mod)
 {
+	struct kernel_symbol_group *ksg;
 	unsigned long ret;
 
-	ret = find_local_symbol(sechdrs, symindex, strtab, name);
-	if (ret) {
-		*ksg = NULL;
-		return ret;
-	}
-	/* Look in other modules... */
 	spin_lock_irq(&modlist_lock);
-	ret = __find_symbol(name, ksg, mod->license_gplok);
+	ret = __find_symbol(name, &ksg, mod->license_gplok);
 	if (ret) {
 		/* This can fail due to OOM, or module unloading */
-		if (!use_module(mod, (*ksg)->owner))
+		if (!use_module(mod, ksg->owner))
 			ret = 0;
 	}
 	spin_unlock_irq(&modlist_lock);
@@ -832,21 +826,19 @@
 			    unsigned int strindex,
 			    struct module *mod)
 {
-	unsigned int i;
-	Elf_Sym *sym;
+	Elf_Sym *sym = (void *)sechdrs[symindex].sh_addr;
+	const char *strtab = (char *)sechdrs[strindex].sh_addr;
+	unsigned int i, n = sechdrs[symindex].sh_size / sizeof(Elf_Sym);
+	int ret = 0;
 
-	/* First simplify defined symbols, so if they become the
-           "answer" to undefined symbols, copying their st_value us
-           correct. */
-	for (sym = (void *)sechdrs[symindex].sh_addr, i = 0;
-	     i < sechdrs[symindex].sh_size / sizeof(Elf_Sym);
-	     i++) {
+	for (i = 1; i < n; i++) {
 		switch (sym[i].st_shndx) {
 		case SHN_COMMON:
 			/* We compiled with -fno-common.  These are not
 			   supposed to happen.  */
 			DEBUGP("Common symbol: %s\n", strtab + sym[i].st_name);
-			return -ENOEXEC;
+			ret = -ENOEXEC;
+			break;
 
 		case SHN_ABS:
 			/* Don't need to do anything */
@@ -855,6 +847,20 @@
 			break;
 
 		case SHN_UNDEF:
+			sym[i].st_value
+			  = resolve_symbol(sechdrs, symindex, strtab,
+					   strtab + sym[i].st_name, mod);
+
+			/* Ok if resolved.  */
+			if (sym[i].st_value != 0)
+				break;
+			/* Ok if weak.  */
+			if (ELF_ST_BIND(sym[i].st_info) == STB_WEAK)
+				break;
+
+			printk(KERN_WARNING "%s: Unknown symbol %s\n",
+			       mod->name, strtab + sym[i].st_name);
+			ret = -ENOENT;
 			break;
 
 		default:
@@ -862,30 +868,11 @@
 				= (unsigned long)
 				(sechdrs[sym[i].st_shndx].sh_addr
 				 + sym[i].st_value);
+			break;
 		}
 	}
 
-	/* Now try to resolve undefined symbols */
-	for (sym = (void *)sechdrs[symindex].sh_addr, i = 0;
-	     i < sechdrs[symindex].sh_size / sizeof(Elf_Sym);
-	     i++) {
-		if (sym[i].st_shndx == SHN_UNDEF) {
-			/* Look for symbol */
-			struct kernel_symbol_group *ksg = NULL;
-			const char *strtab 
-				= (char *)sechdrs[strindex].sh_addr;
-
-			sym[i].st_value
-				= find_symbol_internal(sechdrs,
-						       symindex,
-						       strtab,
-						       strtab + sym[i].st_name,
-						       mod,
-						       &ksg);
-		}
-	}
-
-	return 0;
+	return ret;
 }
 
 /* Update size with this section: return offset. */

===================================================================


This BitKeeper patch contains the following changesets:
+
## Wrapped with gzip_uu ##


begin 664 bkpatch854
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
AJO*35,5N>6=^*KP\I#P9'?DN[6'>LXW_`4TL]:MR+@``
`
end
