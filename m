Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S274832AbRIZFUR>; Wed, 26 Sep 2001 01:20:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S274833AbRIZFUK>; Wed, 26 Sep 2001 01:20:10 -0400
Received: from zok.sgi.com ([204.94.215.101]:47238 "EHLO zok.sgi.com")
	by vger.kernel.org with ESMTP id <S274832AbRIZFTz>;
	Wed, 26 Sep 2001 01:19:55 -0400
X-Mailer: exmh version 2.2 06/23/2000 with nmh-1.0.4
From: Keith Owens <kaos@ocs.com.au>
To: linux-kernel@vger.kernel.org
Cc: jakub@redhat.com
Subject: modutils 2.4.10 patch needs architecture testing
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Wed, 26 Sep 2001 15:20:11 +1000
Message-ID: <29558.1001481611@kao2.melbourne.sgi.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The patch below against modutils 2.4.9 is modutils 2.4.10 work in
progress.  I have added macro obj_find_relsym() as a standard method if
finding relocation symbols, to fix a problem reported by Jakub Jelinek.
It has been tested on i386 and ia64, it needs to be verified on sh,
alpha, arm, hppa, hppa64, ppc, s390 and s390x.  Unless I hear to the
contrary, this patch will go into modutils 2.4.10 in about 3 days.

The sh patch looks weird because it also removes duplicate code that
crept into 2.4.9.

diff -Nur modutils-2.4.9/ChangeLog modutils-2.4.10/ChangeLog
--- modutils-2.4.9/ChangeLog	Tue Sep 25 15:01:28 2001
+++ modutils-2.4.10/ChangeLog	Wed Sep 26 14:50:45 2001
@@ -1,3 +1,11 @@
+2001-09-26  Keith Owens  <kaos@ocs.com.au>
+
+	modutils 2.4.10
+
+	* Remove duplicate patch for sh, Tom Rini.
+	* Handle empty multi-line modinfo fields, reported by Bill Nottingham.
+	* Add obj_find_relsym(), standard method of finding relocation symbols.
+
 2001-09-25  Keith Owens  <kaos@ocs.com.au>
 
 	modutils 2.4.9
diff -Nur modutils-2.4.9/include/obj.h modutils-2.4.10/include/obj.h
--- modutils-2.4.9/include/obj.h	Sat Sep 22 20:06:32 2001
+++ modutils-2.4.10/include/obj.h	Wed Sep 26 14:50:45 2001
@@ -24,7 +24,7 @@
 #ifndef MODUTILS_OBJ_H
 #define MODUTILS_OBJ_H 1
 
-#ident "$Id: obj.h 1.5 Sat, 22 Sep 2001 20:06:32 +1000 kaos $"
+#ident "$Id: obj.h 1.6 Wed, 26 Sep 2001 14:50:45 +1000 kaos $"
 
 /* The relocatable object is manipulated using elfin types.  */
 
@@ -274,5 +274,23 @@
 void *obj_addr_to_native_ptr(ElfW(Addr));
 
 ElfW(Addr) obj_native_ptr_to_addr(void *);
+
+/* Standard method of finding relocation symbols, sets isym */
+#define obj_find_relsym(isym, f, find, rel, symtab, strtab) \
+	{ \
+		unsigned long symndx = ELFW(R_SYM)((rel)->r_info); \
+		ElfW(Sym) *extsym = (symtab)+symndx; \
+		if (ELFW(ST_BIND)(extsym->st_info) == STB_LOCAL) { \
+			isym = (typeof(isym)) (f)->local_symtab[symndx]; \
+		} \
+		else { \
+			const char *name; \
+			if (extsym->st_name) \
+				name = (strtab) + extsym->st_name; \
+			else \
+				name = (f)->sections[extsym->st_shndx]->name; \
+			isym = (typeof(isym)) obj_find_symbol((find), name); \
+		} \
+	}
 
 #endif /* obj.h */
diff -Nur modutils-2.4.9/include/version.h modutils-2.4.10/include/version.h
--- modutils-2.4.9/include/version.h	Sat Sep 22 15:51:06 2001
+++ modutils-2.4.10/include/version.h	Wed Sep 26 11:25:02 2001
@@ -1 +1 @@
-#define MODUTILS_VERSION "2.4.9"
+#define MODUTILS_VERSION "2.4.10"
diff -Nur modutils-2.4.9/insmod/modinfo.c modutils-2.4.10/insmod/modinfo.c
--- modutils-2.4.9/insmod/modinfo.c	Tue Sep 25 15:01:28 2001
+++ modutils-2.4.10/insmod/modinfo.c	Wed Sep 26 11:58:34 2001
@@ -35,7 +35,7 @@
  *   Keith Owens <kaos@ocs.com.au> September 2001.
  */
 
-#ident "$Id: modinfo.c 1.7 Tue, 25 Sep 2001 15:01:28 +1000 kaos $"
+#ident "$Id: modinfo.c 1.8 Wed, 26 Sep 2001 11:58:34 +1000 kaos $"
 
 #include <stdio.h>
 #include <stdlib.h>
@@ -168,7 +168,7 @@
 	if (strlen(p)+extra < n)
 		n = strlen(p)+extra;
 
-	if (!multi_line || n <= 2) {
+	if (!multi_line || n < 2) {
 		strncpy(*out_str, p, n);
 		*out_str += n;
 	}
diff -Nur modutils-2.4.9/man/modinfo.8 modutils-2.4.10/man/modinfo.8
--- modutils-2.4.9/man/modinfo.8	Tue Sep 25 15:01:28 2001
+++ modutils-2.4.10/man/modinfo.8	Wed Sep 26 12:00:28 2001
@@ -1,9 +1,9 @@
 .\" Copyright (c) 1996 Free Software Foundation, Inc.
 .\" This program is distributed according to the Gnu General Public License.
 .\" See the file COPYING in the kernel source directory
-.\" $Id: modinfo.8 1.3 Tue, 25 Sep 2001 15:01:28 +1000 kaos $
+.\" $Id: modinfo.8 1.4 Wed, 26 Sep 2001 12:00:28 +1000 kaos $
 .\"
-.TH MODINFO 8 "11 Nov 1997" Linux "Linux Module Support"
+.TH MODINFO 8 "26 September 2001" Linux "Linux Module Support"
 .SH NAME
 modinfo \- display information about a kernel module
 .SH SYNOPSIS
diff -Nur modutils-2.4.9/modutils.spec modutils-2.4.10/modutils.spec
--- modutils-2.4.9/modutils.spec	Sat Sep 22 15:51:06 2001
+++ modutils-2.4.10/modutils.spec	Wed Sep 26 11:25:02 2001
@@ -1,6 +1,6 @@
 Summary: Module utilities
 Name: modutils
-Version: 2.4.9
+Version: 2.4.10
 Release: 1
 Copyright: GPL
 Group: Utilities/System
diff -Nur modutils-2.4.9/obj/obj_alpha.c modutils-2.4.10/obj/obj_alpha.c
--- modutils-2.4.9/obj/obj_alpha.c	Sat Sep 22 20:06:32 2001
+++ modutils-2.4.10/obj/obj_alpha.c	Wed Sep 26 14:50:45 2001
@@ -19,7 +19,7 @@
    along with this program; if not, write to the Free Software Foundation,
    Inc., 59 Temple Place - Suite 330, Boston, MA 02111-1307, USA.  */
 
-#ident "$Id: obj_alpha.c 1.2 Sat, 22 Sep 2001 20:06:32 +1000 kaos $"
+#ident "$Id: obj_alpha.c 1.3 Wed, 26 Sep 2001 14:50:45 +1000 kaos $"
 
 #include <string.h>
 #include <assert.h>
@@ -264,19 +264,12 @@
       for (; rel < relend; ++rel)
 	{
 	  struct alpha_got_entry *ent;
-	  Elf64_Sym *extsym;
 	  struct alpha_symbol *intsym;
-	  const char *name;
 
 	  if (ELF64_R_TYPE(rel->r_info) != R_ALPHA_LITERAL)
 	    continue;
 
-	  extsym = &symtab[ELF64_R_SYM(rel->r_info)];
-	  if (extsym->st_name)
-	    name = strtab + extsym->st_name;
-	  else
-	    name = f->sections[extsym->st_shndx]->name;
-	  intsym = (struct alpha_symbol *)obj_find_symbol(&af->root, name);
+	  obj_find_relsym(intsym, f, &af->root, rel, symtab, strtab);
 
 	  for (ent = intsym->got_entries; ent ; ent = ent->next)
 	    if (ent->addend == rel->r_addend)
diff -Nur modutils-2.4.9/obj/obj_arm.c modutils-2.4.10/obj/obj_arm.c
--- modutils-2.4.9/obj/obj_arm.c	Sat Sep 22 20:06:32 2001
+++ modutils-2.4.10/obj/obj_arm.c	Wed Sep 26 14:50:45 2001
@@ -21,7 +21,7 @@
    along with this program; if not, write to the Free Software Foundation,
    Inc., 59 Temple Place - Suite 330, Boston, MA 02111-1307, USA.  */
 
-#ident "$Id: obj_arm.c 1.2 Sat, 22 Sep 2001 20:06:32 +1000 kaos $"
+#ident "$Id: obj_arm.c 1.3 Wed, 26 Sep 2001 14:50:45 +1000 kaos $"
 
 #include <string.h>
 #include <assert.h>
@@ -201,7 +201,7 @@
   struct obj_section *sec, *syms, *strs;
   ElfW(Rel) *rel, *relend;
   ElfW(Sym) *symtab, *extsym;
-  const char *strtab, *name;
+  const char *strtab;
   struct arm_symbol *intsym;
   struct arm_plt_entry *pe;
   struct arm_got_entry *ge;
@@ -227,11 +227,7 @@
 	  switch(ELF32_R_TYPE(rel->r_info)) {
 	  case R_ARM_PC24:
 	  case R_ARM_PLT32:
-	    if (extsym->st_name)
-	      name = strtab + extsym->st_name;
-	    else
-	      name = f->sections[extsym->st_shndx]->name;
-	    intsym = (struct arm_symbol *) obj_find_symbol(f, name);
+	    obj_find_relsym(intsym, f, f, rel, symtab, strtab);
 
 	    pe = &intsym->pltent;
 
@@ -252,11 +248,7 @@
 	    break;
 
 	  case R_ARM_GOT32:
-	    if (extsym->st_name)
-	      name = strtab + extsym->st_name;
-	    else
-	      name = f->sections[extsym->st_shndx]->name;
-	    intsym = (struct arm_symbol *) obj_find_symbol(f, name);
+	    obj_find_relsym(intsym, f, f, rel, symtab, strtab);
 
 	    ge = (struct arm_got_entry *) &intsym->gotent;
 	    if (! ge->allocated)
diff -Nur modutils-2.4.9/obj/obj_common.c modutils-2.4.10/obj/obj_common.c
--- modutils-2.4.9/obj/obj_common.c	Sat Sep 22 20:06:32 2001
+++ modutils-2.4.10/obj/obj_common.c	Wed Sep 26 11:58:34 2001
@@ -19,7 +19,7 @@
    along with this program; if not, write to the Free Software Foundation,
    Inc., 59 Temple Place - Suite 330, Boston, MA 02111-1307, USA.  */
 
-#ident "$Id: obj_common.c 1.3 Sat, 22 Sep 2001 20:06:32 +1000 kaos $"
+#ident "$Id: obj_common.c 1.4 Wed, 26 Sep 2001 11:58:34 +1000 kaos $"
 
 #include <stdlib.h>
 #include <string.h>
@@ -263,7 +263,7 @@
 	.bss    0 0  0  */
   if (strcmp (a->name, ".got") == 0) ac |= 2;
   if (af & ARCH_SHF_SHORT)
-    ac = ac & ~4 | 1;
+    ac = (ac & ~4) | 1;
 
   return ac;
 }
diff -Nur modutils-2.4.9/obj/obj_hppa.c modutils-2.4.10/obj/obj_hppa.c
--- modutils-2.4.9/obj/obj_hppa.c	Sat Sep 22 20:06:32 2001
+++ modutils-2.4.10/obj/obj_hppa.c	Wed Sep 26 14:50:45 2001
@@ -423,24 +423,10 @@
 
 	  if (need_stub)
 	    {
-	      Elf32_Sym *extsym;
 	      hppa_symbol_t *hsym;
-	      char const *name;
 	      int local;
-	      unsigned long symndx;
 
-	      symndx = ELF32_R_SYM(rel->r_info);
-	      extsym = symtab + symndx;
-	      if (ELF32_ST_BIND(extsym->st_info) == STB_LOCAL)
-		hsym = (hppa_symbol_t *) f->local_symtab[symndx];
-	      else
-		{
-		  if (extsym->st_name)
-		    name = strtab + extsym->st_name;
-		  else
-		    name = f->sections[extsym->st_shndx]->name;
-		  hsym = (hppa_symbol_t *)obj_find_symbol(f, name);
-		}
+	      obj_find_relsym(hsym, f, f, rel, symtab, strtab);
 	      local = hsym->root.secidx <= SHN_HIRESERVE;
 
 	      if (need_stub)
diff -Nur modutils-2.4.9/obj/obj_hppa64.c modutils-2.4.10/obj/obj_hppa64.c
--- modutils-2.4.9/obj/obj_hppa64.c	Sun May  6 15:09:08 2001
+++ modutils-2.4.10/obj/obj_hppa64.c	Wed Sep 26 14:50:45 2001
@@ -22,7 +22,7 @@
  * Inc., 59 Temple Place - Suite 330, Boston, MA 02111-1307, USA.
  */
 
-#ident "$Id: obj_hppa64.c 1.3 Sun, 06 May 2001 15:09:08 +1000 kaos $"
+#ident "$Id: obj_hppa64.c 1.4 Wed, 26 Sep 2001 14:50:45 +1000 kaos $"
 
 #include <string.h>
 #include <assert.h>
@@ -373,26 +373,10 @@
 
 	    if (need_got || need_opd || need_stub)
 	    {
-		Elf64_Sym     *extsym;
 		hppa64_symbol_t *isym;
-		const char    *name;
 		int            local;
-		unsigned long  symndx;
 
-		symndx = ELF64_R_SYM(rel->r_info);
-		extsym = &symtab[symndx];
-		if (ELF64_ST_BIND(extsym->st_info) == STB_LOCAL)
-		{
-		    isym = (hppa64_symbol_t *) f->local_symtab[symndx];
-		}
-		else
-		{
-		    if (extsym->st_name)
-			name = strtab + extsym->st_name;
-		    else
-			name = f->sections[extsym->st_shndx]->name;
-		    isym = (hppa64_symbol_t *)obj_find_symbol(f, name);
-		}
+		obj_find_relsym(isym, f, f, rel, symtab, strtab);
 		local = isym->root.secidx <= SHN_HIRESERVE;
 
 		if (need_stub)
diff -Nur modutils-2.4.9/obj/obj_i386.c modutils-2.4.10/obj/obj_i386.c
--- modutils-2.4.9/obj/obj_i386.c	Sat Sep 22 20:06:32 2001
+++ modutils-2.4.10/obj/obj_i386.c	Wed Sep 26 14:50:45 2001
@@ -19,7 +19,7 @@
    along with this program; if not, write to the Free Software Foundation,
    Inc., 59 Temple Place - Suite 330, Boston, MA 02111-1307, USA.  */
 
-#ident "$Id: obj_i386.c 1.2 Sat, 22 Sep 2001 20:06:32 +1000 kaos $"
+#ident "$Id: obj_i386.c 1.3 Wed, 26 Sep 2001 14:50:45 +1000 kaos $"
 
 #include <string.h>
 #include <assert.h>
@@ -183,9 +183,7 @@
 
       for (; rel < relend; ++rel)
 	{
-	  Elf32_Sym *extsym;
 	  struct i386_symbol *intsym;
-	  const char *name;
 
 	  switch (ELF32_R_TYPE(rel->r_info))
 	    {
@@ -199,12 +197,7 @@
 	      break;
 	    }
 
-	  extsym = &symtab[ELF32_R_SYM(rel->r_info)];
-	  if (extsym->st_name)
-	    name = strtab + extsym->st_name;
-	  else
-	    name = f->sections[extsym->st_shndx]->name;
-	  intsym = (struct i386_symbol *)obj_find_symbol(&ifile->root, name);
+	  obj_find_relsym(intsym, f, &ifile->root, rel, symtab, strtab);
 
 	  if (!intsym->gotent.offset_done)
 	    {
diff -Nur modutils-2.4.9/obj/obj_ia64.c modutils-2.4.10/obj/obj_ia64.c
--- modutils-2.4.9/obj/obj_ia64.c	Sat Sep 22 20:06:32 2001
+++ modutils-2.4.10/obj/obj_ia64.c	Wed Sep 26 14:50:45 2001
@@ -19,7 +19,7 @@
  * Inc., 59 Temple Place - Suite 330, Boston, MA 02111-1307, USA.
  */
 
-#ident "$Id: obj_ia64.c 1.2 Sat, 22 Sep 2001 20:06:32 +1000 kaos $"
+#ident "$Id: obj_ia64.c 1.3 Wed, 26 Sep 2001 14:50:45 +1000 kaos $"
 
 #include <string.h>
 #include <assert.h>
@@ -433,26 +433,10 @@
 
 	    if (need_got || need_opd || need_plt)
 	    {
-		Elf64_Sym     *extsym;
 		ia64_symbol_t *isym;
-		const char    *name;
 		int            local;
-		unsigned long  symndx;
 
-		symndx = ELF64_R_SYM(rel->r_info);
-		extsym = &symtab[symndx];
-		if (ELF64_ST_BIND(extsym->st_info) == STB_LOCAL)
-		{
-		    isym = (ia64_symbol_t *) f->local_symtab[symndx];
-		}
-		else
-		{
-		    if (extsym->st_name)
-			name = strtab + extsym->st_name;
-		    else
-			name = f->sections[extsym->st_shndx]->name;
-		    isym = (ia64_symbol_t *)obj_find_symbol(f, name);
-		}
+		obj_find_relsym(isym, f, f, rel, symtab, strtab);
 		local = isym->root.secidx <= SHN_HIRESERVE;
 
 		if (need_plt)
diff -Nur modutils-2.4.9/obj/obj_load.c modutils-2.4.10/obj/obj_load.c
--- modutils-2.4.9/obj/obj_load.c	Wed Aug 22 15:19:15 2001
+++ modutils-2.4.10/obj/obj_load.c	Wed Sep 26 14:50:45 2001
@@ -21,7 +21,7 @@
    along with this program; if not, write to the Free Software Foundation,
    Inc., 59 Temple Place - Suite 330, Boston, MA 02111-1307, USA.  */
 
-#ident "$Id: obj_load.c 1.3 Wed, 22 Aug 2001 15:19:15 +1000 kaos $"
+#ident "$Id: obj_load.c 1.4 Wed, 26 Sep 2001 14:50:45 +1000 kaos $"
 
 #include <alloca.h>
 #include <string.h>
@@ -279,7 +279,6 @@
 	    /* Save the relocate type in each symbol entry.  */
 	    for (j = 0; j < nrel; ++j, ++rel)
 	      {
-		ElfW(Sym) *extsym;
 		struct obj_symbol *intsym;
 		unsigned long symndx;
 		symndx = ELFW(R_SYM)(rel->r_info);
@@ -292,23 +291,7 @@
 			continue;
 		      }
 
-		    extsym = ((ElfW(Sym) *) symtab->contents) + symndx;
-		    if (ELFW(ST_BIND)(extsym->st_info) == STB_LOCAL)
-		      {
-			/* Local symbols we look up in the local table to be sure
-			   we get the one that is really intended.  */
-			intsym = f->local_symtab[symndx];
-		      }
-		    else
-		      {
-			/* Others we look up in the hash table.  */
-			const char *name;
-			if (extsym->st_name)
-			  name = strtab + extsym->st_name;
-			else
-			  name = f->sections[extsym->st_shndx]->name;
-			intsym = obj_find_symbol(f, name);
-		      }
+		    obj_find_relsym(intsym, f, f, rel, (ElfW(Sym) *)(symtab->contents), strtab);
 		    intsym->r_type = ELFW(R_TYPE)(rel->r_info);
 		  }
 	      }
diff -Nur modutils-2.4.9/obj/obj_ppc.c modutils-2.4.10/obj/obj_ppc.c
--- modutils-2.4.9/obj/obj_ppc.c	Sat Sep 22 20:06:32 2001
+++ modutils-2.4.10/obj/obj_ppc.c	Wed Sep 26 14:50:45 2001
@@ -20,7 +20,7 @@
    along with this program; if not, write to the Free Software Foundation,
    Inc., 59 Temple Place - Suite 330, Boston, MA 02111-1307, USA.  */
 
-#ident "$Id: obj_ppc.c 1.3 Sat, 22 Sep 2001 20:06:32 +1000 kaos $"
+#ident "$Id: obj_ppc.c 1.4 Wed, 26 Sep 2001 14:50:45 +1000 kaos $"
 
 #include <stddef.h>
 #include <module.h>
@@ -180,8 +180,8 @@
   int i, offset;
   struct obj_section *sec, *syms, *strs;
   ElfW(Rela) *rel, *relend;
-  ElfW(Sym) *symtab, *extsym;
-  const char *strtab, *name;
+  ElfW(Sym) *symtab;
+  const char *strtab;
   struct ppc_symbol *intsym;
   struct ppc_plt_entry *pe;
 
@@ -203,12 +203,7 @@
 	{
 	  if (ELF32_R_TYPE(rel->r_info) != R_PPC_REL24)
 	    continue;
-	  extsym = &symtab[ELF32_R_SYM(rel->r_info)];
-	  if (extsym->st_name)
-	    name = strtab + extsym->st_name;
-	  else
-	    name = f->sections[extsym->st_shndx]->name;
-	  intsym = (struct ppc_symbol *) obj_find_symbol(f, name);
+	  obj_find_relsym(intsym, f, f, rel, symtab, strtab);
 
 	  for (pe = intsym->plt_entries; pe != NULL; pe = pe->next)
 	    if (pe->addend == rel->r_addend)
diff -Nur modutils-2.4.9/obj/obj_reloc.c modutils-2.4.10/obj/obj_reloc.c
--- modutils-2.4.9/obj/obj_reloc.c	Sat Sep 22 20:06:32 2001
+++ modutils-2.4.10/obj/obj_reloc.c	Wed Sep 26 14:50:45 2001
@@ -19,7 +19,7 @@
    along with this program; if not, write to the Free Software Foundation,
    Inc., 59 Temple Place - Suite 330, Boston, MA 02111-1307, USA.  */
 
-#ident "$Id: obj_reloc.c 1.3 Sat, 22 Sep 2001 20:06:32 +1000 kaos $"
+#ident "$Id: obj_reloc.c 1.4 Wed, 26 Sep 2001 14:50:45 +1000 kaos $"
 
 #include <string.h>
 #include <assert.h>
@@ -308,7 +308,6 @@
 	  ElfW(Addr) value = 0;
 	  struct obj_symbol *intsym = NULL;
 	  unsigned long symndx;
-	  ElfW(Sym) *extsym = 0;
 	  const char *errmsg;
 
 	  /* Attempt to find a value to use for this relocation.  */
@@ -325,33 +324,11 @@
 		  continue;
 		}
 
-	      extsym = &symtab[symndx];
-	      if (ELFW(ST_BIND)(extsym->st_info) == STB_LOCAL)
-		{
-		  /* Local symbols we look up in the local table to be sure
-		     we get the one that is really intended.  */
-		  intsym = f->local_symtab[symndx];
-		}
-	      else
-		{
-		  /* Others we look up in the hash table.  */
-		  const char *name;
-		  if (extsym->st_name)
-		    name = strtab + extsym->st_name;
-		  else
-		    name = f->sections[extsym->st_shndx]->name;
-		  intsym = obj_find_symbol(f, name);
-		}
-
+	      obj_find_relsym(intsym, f, f, rel, symtab, strtab);
 	      value = obj_symbol_final_value(f, intsym);
 	    }
 
 #if SHT_RELM == SHT_RELA
-#if defined(__alpha__) && defined(AXP_BROKEN_GAS)
-	  /* Work around a nasty GAS bug, that is fixed as of 2.7.0.9.  */
-	  if (!extsym || !extsym->st_name ||
-	      ELFW(ST_BIND)(extsym->st_info) != STB_LOCAL)
-#endif
 	  value += rel->r_addend;
 #endif
 
diff -Nur modutils-2.4.9/obj/obj_s390.c modutils-2.4.10/obj/obj_s390.c
--- modutils-2.4.9/obj/obj_s390.c	Sat Sep 22 20:06:32 2001
+++ modutils-2.4.10/obj/obj_s390.c	Wed Sep 26 14:50:45 2001
@@ -23,7 +23,7 @@
    along with this program; if not, write to the Free Software Foundation,
    Inc., 59 Temple Place - Suite 330, Boston, MA 02111-1307, USA.  */
 
-#ident "$Id: obj_s390.c 1.4 Sat, 22 Sep 2001 20:06:32 +1000 kaos $"
+#ident "$Id: obj_s390.c 1.5 Wed, 26 Sep 2001 14:50:45 +1000 kaos $"
 
 #include <string.h>
 #include <assert.h>
@@ -243,23 +243,15 @@
 
       for (; rel < relend; ++rel)
 	{
-	  Elf32_Sym *extsym;
 	  struct s390_symbol *intsym;
           struct s390_plt_entry *pe;
           struct s390_got_entry *ge;
-	  const char *name;
-
-          extsym = &symtab[ELF32_R_SYM(rel->r_info)];
 
           switch (ELF32_R_TYPE(rel->r_info)) {
             /* These four relocations refer to a plt entry.  */
             case R_390_PLT16DBL:
             case R_390_PLT32:
-              if (extsym->st_name)
-                name = strtab + extsym->st_name;
-              else
-                name = f->sections[extsym->st_shndx]->name;
-              intsym = (struct s390_symbol *) obj_find_symbol(f, name);
+	      obj_find_relsym(intsym, f, f, rel, symtab, strtab);
               assert(intsym);
               pe = &intsym->pltent;
               if (!pe->allocated) {
@@ -278,11 +270,7 @@
             case R_390_GOT12:
             case R_390_GOT16:
 	    case R_390_GOT32:
-              if (extsym->st_name)
-                 name = strtab + extsym->st_name;
-              else
-                name = f->sections[extsym->st_shndx]->name;
-              intsym = (struct s390_symbol *) obj_find_symbol(f, name);
+	      obj_find_relsym(intsym, f, f, rel, symtab, strtab);
               assert(intsym);
               ge = (struct s390_got_entry *) &intsym->gotent;
               if (!ge->allocated) {
diff -Nur modutils-2.4.9/obj/obj_s390x.c modutils-2.4.10/obj/obj_s390x.c
--- modutils-2.4.9/obj/obj_s390x.c	Sat Sep 22 20:06:32 2001
+++ modutils-2.4.10/obj/obj_s390x.c	Wed Sep 26 14:50:45 2001
@@ -23,7 +23,7 @@
    along with this program; if not, write to the Free Software Foundation,
    Inc., 59 Temple Place - Suite 330, Boston, MA 02111-1307, USA.  */
 
-#ident "$Id: obj_s390x.c 1.2 Sat, 22 Sep 2001 20:06:32 +1000 kaos $"
+#ident "$Id: obj_s390x.c 1.3 Wed, 26 Sep 2001 14:50:45 +1000 kaos $"
 
 #include <string.h>
 #include <assert.h>
@@ -273,13 +273,9 @@
 
       for (; rel < relend; ++rel)
        {
-         Elf64_Sym *extsym;
          struct s390_symbol *intsym;
           struct s390_plt_entry *pe;
           struct s390_got_entry *ge;
-         const char *name;
-
-          extsym = &symtab[ELF64_R_SYM(rel->r_info)];
 
          switch (ELF64_R_TYPE(rel->r_info)) {
             /* These four relocations refer to a plt entry.  */
@@ -287,11 +283,7 @@
             case R_390_PLT32:
             case R_390_PLT32DBL:
             case R_390_PLT64:
-              if (extsym->st_name)
-                name = strtab + extsym->st_name;
-              else
-                name = f->sections[extsym->st_shndx]->name;
-              intsym = (struct s390_symbol *) obj_find_symbol(f, name);
+	      obj_find_relsym(intsym, f, f, rel, symtab, strtab);
               assert(intsym);
               pe = &intsym->pltent;
               if (!pe->allocated) {
@@ -313,11 +305,7 @@
            case R_390_GOT32:
             case R_390_GOT64:
             case R_390_GOTENT:
-              if (extsym->st_name)
-                name = strtab + extsym->st_name;
-              else
-                name = f->sections[extsym->st_shndx]->name;
-              intsym = (struct s390_symbol *) obj_find_symbol(f, name);
+	      obj_find_relsym(intsym, f, f, rel, symtab, strtab);
              assert(intsym);
               ge = (struct s390_got_entry *) &intsym->gotent;
               if (!ge->allocated) {
diff -Nur modutils-2.4.9/obj/obj_sh.c modutils-2.4.10/obj/obj_sh.c
--- modutils-2.4.9/obj/obj_sh.c	Sat Sep 22 20:06:32 2001
+++ modutils-2.4.10/obj/obj_sh.c	Wed Sep 26 14:50:45 2001
@@ -174,9 +174,7 @@
 
       for (; rel < relend; ++rel)
 	{
-	  Elf32_Sym *extsym;
 	  struct sh_symbol *intsym;
-	  const char *name;
 
 	  switch (ELF32_R_TYPE(rel->r_info))
 	    {
@@ -190,258 +188,7 @@
 	      break;
 	    }
 
-	  extsym = &symtab[ELF32_R_SYM(rel->r_info)];
-	  if (extsym->st_name)
-	    name = strtab + extsym->st_name;
-	  else
-	    name = f->sections[extsym->st_shndx]->name;
-	  intsym = (struct sh_symbol *)obj_find_symbol(&ifile->root, name);
-
-	  if (!intsym->gotent.offset_done)
-	    {
-	      intsym->gotent.offset_done = 1;
-	      intsym->gotent.offset = offset;
-	      offset += 4;
-	    }
-	}
-    }
-
-  if (offset > 0 || gotneeded)
-    ifile->got = obj_create_alloced_section(&ifile->root, ".got", 4, offset, SHF_WRITE);
-
-  return 1;
-}
-
-int
-arch_init_module (struct obj_file *f, struct module *mod)
-{
-  return 1;
-}
-
-int
-arch_finalize_section_address(struct obj_file *f, Elf32_Addr base)
-{
-  int  i, n = f->header.e_shnum;
-
-  f->baseaddr = base;
-  for (i = 0; i < n; ++i)
-    f->sections[i]->header.sh_addr += base;
-  return 1;
-}
-
-int
-arch_load_proc_section(struct obj_section *sec, int fp)
-{
-    /* Assume it's just a debugging section that we can safely
-       ignore ...  */
-    sec->contents = NULL;
-
-    return 0;
-}
-
-int
-arch_archdata (struct obj_file *fin, struct obj_section *sec)
-{
-  return 0;
-}
-/* SH specific support for Elf loading and relocation.
-   Copyright 1999 Linux International.
-
-   Contributed by Kazumoto Kojima <kkojima@rr.iij4u.or.jp>
-
-   This file is part of the Linux modutils.
-
-   This program is free software; you can redistribute it and/or modify it
-   under the terms of the GNU General Public License as published by the
-   Free Software Foundation; either version 2 of the License, or (at your
-   option) any later version.
-
-   This program is distributed in the hope that it will be useful, but
-   WITHOUT ANY WARRANTY; without even the implied warranty of
-   MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
-   General Public License for more details.
-
-   You should have received a copy of the GNU General Public License
-   along with this program; if not, write to the Free Software Foundation,
-   Inc., 59 Temple Place - Suite 330, Boston, MA 02111-1307, USA.  */
-
-#include <string.h>
-#include <assert.h>
-
-#include <module.h>
-#include <obj.h>
-#include <util.h>
-
-
-/*======================================================================*/
-
-struct sh_got_entry
-{
-  int offset;
-  unsigned offset_done : 1;
-  unsigned reloc_done : 1;
-};
-
-struct sh_file
-{
-  struct obj_file root;
-  struct obj_section *got;
-};
-
-struct sh_symbol
-{
-  struct obj_symbol root;
-  struct sh_got_entry gotent;
-};
-
-
-/*======================================================================*/
-
-struct obj_file *
-arch_new_file (void)
-{
-  struct sh_file *f;
-  f = xmalloc(sizeof(*f));
-  f->got = NULL;
-  return &f->root;
-}
-
-struct obj_section *
-arch_new_section (void)
-{
-  return xmalloc(sizeof(struct obj_section));
-}
-
-struct obj_symbol *
-arch_new_symbol (void)
-{
-  struct sh_symbol *sym;
-  sym = xmalloc(sizeof(*sym));
-  memset(&sym->gotent, 0, sizeof(sym->gotent));
-  return &sym->root;
-}
-
-enum obj_reloc
-arch_apply_relocation (struct obj_file *f,
-		       struct obj_section *targsec,
-		       struct obj_section *symsec,
-		       struct obj_symbol *sym,
-		       Elf32_Rela *rel,
-		       Elf32_Addr v)
-{
-  struct sh_file *ifile = (struct sh_file *)f;
-  struct sh_symbol *isym  = (struct sh_symbol *)sym;
-
-  Elf32_Addr *loc = (Elf32_Addr *)(targsec->contents + rel->r_offset);
-  Elf32_Addr dot = targsec->header.sh_addr + rel->r_offset;
-  Elf32_Addr got = ifile->got ? ifile->got->header.sh_addr : 0;
-
-  enum obj_reloc ret = obj_reloc_ok;
-
-  switch (ELF32_R_TYPE(rel->r_info))
-    {
-    case R_SH_NONE:
-      break;
-
-    case R_SH_DIR32:
-      *loc += v;
-      break;
-
-    case R_SH_REL32:
-      *loc += v - dot;
-      break;
-
-    case R_SH_PLT32:
-      *loc = v - dot;
-      break;
-
-    case R_SH_GLOB_DAT:
-    case R_SH_JMP_SLOT:
-      *loc = v;
-      break;
-
-    case R_SH_RELATIVE:
-      *loc = f->baseaddr + rel->r_addend;
-      break;
-
-    case R_SH_GOTPC:
-      assert(got != 0);
-      *loc = got - dot + rel->r_addend;
-      break;
-
-    case R_SH_GOT32:
-      assert(isym != NULL);
-      if (!isym->gotent.reloc_done)
-	{
-	  isym->gotent.reloc_done = 1;
-	  *(Elf32_Addr *)(ifile->got->contents + isym->gotent.offset) = v;
-	}
-      *loc = isym->gotent.offset + rel->r_addend;
-      break;
-
-    case R_SH_GOTOFF:
-      assert(got != 0);
-      *loc = v - got;
-      break;
-
-    default:
-      ret = obj_reloc_unhandled;
-      break;
-    }
-
-  return ret;
-}
-
-int
-arch_create_got (struct obj_file *f)
-{
-  struct sh_file *ifile = (struct sh_file *)f;
-  int i, n, offset = 0, gotneeded = 0;
-
-  n = ifile->root.header.e_shnum;
-  for (i = 0; i < n; ++i)
-    {
-      struct obj_section *relsec, *symsec, *strsec;
-      Elf32_Rela *rel, *relend;
-      Elf32_Sym *symtab;
-      const char *strtab;
-
-      relsec = ifile->root.sections[i];
-      if (relsec->header.sh_type != SHT_REL)
-	continue;
-
-      symsec = ifile->root.sections[relsec->header.sh_link];
-      strsec = ifile->root.sections[symsec->header.sh_link];
-
-      rel = (Elf32_Rela *)relsec->contents;
-      relend = rel + (relsec->header.sh_size / sizeof(Elf32_Rela));
-      symtab = (Elf32_Sym *)symsec->contents;
-      strtab = (const char *)strsec->contents;
-
-      for (; rel < relend; ++rel)
-	{
-	  Elf32_Sym *extsym;
-	  struct sh_symbol *intsym;
-	  const char *name;
-
-	  switch (ELF32_R_TYPE(rel->r_info))
-	    {
-	    case R_SH_GOTPC:
-	    case R_SH_GOTOFF:
-	      gotneeded = 1;
-	    default:
-	      continue;
-
-	    case R_SH_GOT32:
-	      break;
-	    }
-
-	  extsym = &symtab[ELF32_R_SYM(rel->r_info)];
-	  if (extsym->st_name)
-	    name = strtab + extsym->st_name;
-	  else
-	    name = f->sections[extsym->st_shndx]->name;
-	  intsym = (struct sh_symbol *)obj_find_symbol(&ifile->root, name);
+	  obj_find_relsym(intsym, f, &ifile->root, rel, symtab, strtab);
 
 	  if (!intsym->gotent.offset_done)
 	    {
diff -Nur modutils-2.4.9/include/elf_sh.h modutils-2.4.10/include/elf_sh.h
--- modutils-2.4.9/include/elf_sh.h	Sat Sep 22 19:54:04 2001
+++ modutils-2.4.10/include/elf_sh.h	Wed Sep 26 11:33:26 2001
@@ -1,19 +1,5 @@
-/* Machine-specific elf macros for the Sparc.  */
-#ident "$Id: elf_sh.h 1.1 Sat, 22 Sep 2001 19:54:04 +1000 kaos $"
-
-#define ELFCLASSM	ELFCLASS32
-#ifdef __LITTLE_ENDIAN__
-#define ELFDATAM	ELFDATA2LSB
-#else
-#define ELFDATAM	ELFDATA2MSB
-#endif
-
-#define MATCH_MACHINE(x)  (x == EM_SH)
-
-#define SHT_RELM	SHT_RELA
-#define Elf32_RelM	Elf32_Rela
-/* Machine-specific elf macros for the Sparc.  */
-#ident "$Id: elf_sh.h 1.1 Sat, 22 Sep 2001 19:54:04 +1000 kaos $"
+/* Machine-specific elf macros for the super-h.  */
+#ident "$Id: elf_sh.h 1.2 Wed, 26 Sep 2001 11:33:26 +1000 kaos $"
 
 #define ELFCLASSM	ELFCLASS32
 #ifdef __LITTLE_ENDIAN__

