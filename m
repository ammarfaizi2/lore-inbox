Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267084AbSKWVzB>; Sat, 23 Nov 2002 16:55:01 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267085AbSKWVzA>; Sat, 23 Nov 2002 16:55:00 -0500
Received: from are.twiddle.net ([64.81.246.98]:37261 "EHLO are.twiddle.net")
	by vger.kernel.org with ESMTP id <S267084AbSKWVy1>;
	Sat, 23 Nov 2002 16:54:27 -0500
Date: Sat, 23 Nov 2002 14:01:28 -0800
From: Richard Henderson <rth@twiddle.net>
To: rusty@rustcorp.com.au
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH] modules as shared objects
Message-ID: <20021123140128.A699@twiddle.net>
Mail-Followup-To: rusty@rustcorp.com.au, linux-kernel@vger.kernel.org
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Attached is a first cut at loading modules from ET_DYN objects
(aka shared libraries) instead of ET_REL objects (.o files).

Implemented:

  * Use the dynamic symbol table (including hashed symbol lookup)
    as the exported symbol list for the module.

  * Use the DT_INIT and DT_FINI tags for module initialization
    and cleanup.

Not Implemented:

  * Per-arch shared library link script.  Needed to eliminate the
    unnecessary padding added by the linker for proper paging, which
    of course we don't do in the kernel.  On non-x86, this can be
    as large as 64k per segment.

  * Freeing the .init.* sections.  Also requires the link script.
    I believe the proper solution is to use a different program
    header with a different load tag:

	#define PT_INIT_LOAD	0x60000001

    In this way we don't make a mistake and discard a segment that
    we're not supposed to.

  * KALLSYMS.  The module's non-dynamic symbol table is present
    in the file provided by insmod, though it is present in the
    relocated image.  Merely need to copy the table into kernel
    memory and save it with the module.

Another point for discussion wrt freeing .init.* sections.  The way
I'd like to do this is to discard the pages mapped by vmalloc, but
to keep the vma in use.  In this way we don't have to worry about
exception table data pointing into other modules, kallsyms pointing
into other modules, etc.  There is not currently a function to drop
pages from a vmalloc area, but it would be trivial to write.  The
question is: does anyone have objections to this strategy?

Patch vs bk as of ChangeSet 1.857, lightly tested on x86 and alpha.
Requires the module-init-tools patch posted by dwmw2 that adds the
module name as a parameter to init_module syscall.


r~


ChangeSet@1.860, 2002-11-23 13:23:03-08:00, rth@dorothy.sfbay.redhat.com
  [MODULES] Three cleanups.
  (1) Alpha relocation simplification and binutils workaround.
  (2) Fix legacy module init/cleanup macros.
  (3) Fix core size computation typo.

ChangeSet@1.859, 2002-11-22 17:07:27-08:00, rth@dorothy.sfbay.redhat.com
  [MODULE] Install exception table for the module.

ChangeSet@1.858, 2002-11-22 16:00:37-08:00, rth@dorothy.sfbay.redhat.com
  Merge dorothy.sfbay.redhat.com:/dorothy/rth/linux/linus-2.5
  into dorothy.sfbay.redhat.com:/dorothy/rth/linux/mod-2.5

ChangeSet@1.853.2.3, 2002-11-22 15:48:49-08:00, rth@dorothy.sfbay.redhat.com
  [MODULES] Put module name as first argument to init_module.

ChangeSet@1.853.2.2, 2002-11-22 12:56:52-08:00, rth@dorothy.sfbay.redhat.com
  [ALPHA] Fix exception handling for new modules interfaces.

ChangeSet@1.853.2.1, 2002-11-21 18:28:08-08:00, rth@dorothy.sfbay.redhat.com
  Merge with mainline.

ChangeSet@1.842.31.1, 2002-11-21 18:16:28-08:00, rth@dorothy.sfbay.redhat.com
  [MODULES]: Initial draft of in-kernel module loader operating on
  ET_DYN objects instead of ET_REL objects.
  
  Missing still are exception handling, freeing init segment,
  KALLSYMS, parameter handling.

 Makefile                               |    3 
 arch/alpha/kernel/Makefile             |    1 
 arch/alpha/kernel/module.c             |  113 +++
 arch/alpha/kernel/traps.c              |    2 
 arch/alpha/lib/clear_user.S            |    2 
 arch/alpha/lib/copy_user.S             |    4 
 arch/alpha/lib/ev6-clear_user.S        |    2 
 arch/alpha/lib/ev6-copy_user.S         |    4 
 arch/alpha/lib/ev6-strncpy_from_user.S |    2 
 arch/alpha/lib/ev67-strlen_user.S      |    2 
 arch/alpha/lib/strlen_user.S           |    2 
 arch/alpha/lib/strncpy_from_user.S     |    2 
 arch/alpha/mm/extable.c                |   89 --
 arch/alpha/mm/fault.c                  |    2 
 arch/i386/kernel/module.c              |   90 +-
 include/asm-alpha/elf.h                |    5 
 include/asm-alpha/module.h             |    7 
 include/asm-alpha/uaccess.h            |   40 -
 include/asm-i386/module.h              |    7 
 include/linux/elf.h                    |   76 +-
 include/linux/init.h                   |   20 
 include/linux/module.h                 |   96 +-
 include/linux/moduleloader.h           |   44 -
 kernel/extable.c                       |   12 
 kernel/module.c                        | 1085 +++++++++++++--------------------
 scripts/Makefile.build                 |   26 
 scripts/Makefile.clean                 |    2 
 scripts/Makefile.lib                   |   12 
 scripts/Makefile.modinst               |    4 
 29 files changed, 775 insertions, 983 deletions


diff -Nur --exclude=RCS --exclude=CVS --exclude=SCCS --exclude=BitKeeper --exclude=ChangeSet linus-2.5/Makefile mod-2.5/Makefile
--- linus-2.5/Makefile	Sat Nov 23 14:35:20 2002
+++ mod-2.5/Makefile	Fri Nov 22 18:46:48 2002
@@ -706,7 +706,8 @@
 	$(call cmd,rmclean)
 	@find . $(RCS_FIND_IGNORE) \
 	 	\( -name '*.[oas]' -o -name '.*.cmd' -o -name '.*.d' \
-		-o -name '.*.tmp' \) -type f -print | xargs rm -f
+		-o -name '.*.tmp' -o -name '*.klm' \) \
+		-type f -print | xargs rm -f
 
 # mrproper - delete configuration + modules + core files
 #
diff -Nur --exclude=RCS --exclude=CVS --exclude=SCCS --exclude=BitKeeper --exclude=ChangeSet linus-2.5/arch/alpha/kernel/Makefile mod-2.5/arch/alpha/kernel/Makefile
--- linus-2.5/arch/alpha/kernel/Makefile	Sat Nov 23 14:35:25 2002
+++ mod-2.5/arch/alpha/kernel/Makefile	Fri Nov 22 16:02:07 2002
@@ -26,6 +26,7 @@
 obj-$(CONFIG_SMP)    += smp.o
 obj-$(CONFIG_PCI)    += pci.o pci_iommu.o
 obj-$(CONFIG_SRM_ENV)	+= srm_env.o
+obj-$(CONFIG_MODULES)	+= module.o
 
 ifdef CONFIG_ALPHA_GENERIC
 
diff -Nur --exclude=RCS --exclude=CVS --exclude=SCCS --exclude=BitKeeper --exclude=ChangeSet linus-2.5/arch/alpha/kernel/module.c mod-2.5/arch/alpha/kernel/module.c
--- linus-2.5/arch/alpha/kernel/module.c	Wed Dec 31 16:00:00 1969
+++ mod-2.5/arch/alpha/kernel/module.c	Sat Nov 23 14:36:39 2002
@@ -0,0 +1,113 @@
+/* Kernel module help for Alpha.
+   Copyright (C) 2002  Richard Henderson.
+
+   This program is free software; you can redistribute it and/or modify
+   it under the terms of the GNU General Public License as published by
+   the Free Software Foundation; either version 2 of the License, or
+   (at your option) any later version.
+
+   This program is distributed in the hope that it will be useful,
+   but WITHOUT ANY WARRANTY; without even the implied warranty of
+   MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+   GNU General Public License for more details.
+
+   You should have received a copy of the GNU General Public License along
+   with this program; if not, write to the Free Software Foundation, Inc.,
+   59 Temple Place, Suite 330, Boston, MA  02111-1307  USA  */
+
+#include <linux/moduleloader.h>
+#include <linux/elf.h>
+#include <linux/vmalloc.h>
+#include <linux/fs.h>
+#include <linux/string.h>
+#include <linux/kernel.h>
+
+#if 0
+#define DEBUGP printk
+#else
+#define DEBUGP(fmt , ...)
+#endif
+
+void *
+module_alloc(unsigned long size)
+{
+	if (size == 0)
+		return NULL;
+	return vmalloc(size);
+}
+
+void
+module_free(void *region)
+{
+	vfree(region);
+}
+
+long
+module_core_size(const ElfW(Ehdr) *hdr, struct module *module,
+		 unsigned long min_addr, unsigned long max_addr)
+{
+	return max_addr - min_addr;
+}
+
+int
+apply_relocate(const ElfW(Rel) *rel, unsigned long nrelocs,
+	       struct module *me)
+{
+	return -ENOEXEC;
+}
+
+int
+apply_relocate_add(const ElfW(Rela) *rela, unsigned long nrelocs,
+		   struct module *me)
+{
+	unsigned long i;
+
+	for (i = 0; i < nrelocs; i++) {
+		unsigned long r_type = ELFW(R_TYPE)(rela[i].r_info);
+		char *location = (void *)me->loadaddr + rela[i].r_offset;
+		unsigned int symnum;
+		unsigned long value = 0;
+
+		if (r_type == R_ALPHA_RELATIVE) {
+			/* Binutils before 2.12 or so are borken.  We should
+			   have the RELATIVE offset as the addend of the 
+			   relocation.  If it's not present, fall back to the
+			   value at the relocation address.  */
+			u64 addend = rela[i].r_addend;
+			if (addend == 0)
+				addend = *(u64 *)location;
+
+			*(u64 *)location = (u64)me->loadaddr + addend;
+			continue;
+		}
+
+		/* This is the symbol it is referring to.  */
+		symnum = ELFW(R_SYM)(rela[i].r_info);
+		if (symnum) {
+			value = (u64) resolve_symbol(me, symnum);
+			if (!value)
+				  return -ENOENT;
+		}
+		value += rela[i].r_addend;
+
+		switch (r_type) {
+		case R_ALPHA_GLOB_DAT:
+		case R_ALPHA_JMP_SLOT:
+		case R_ALPHA_REFQUAD:
+			*(u64 *)location = value;
+			break;
+		default:
+			printk(KERN_ERR "module %s: Unknown relocation: %lu\n",
+			       me->name, r_type);
+			return -ENOEXEC;
+		}
+	}
+
+	return 0;
+}
+
+int
+module_finalize(const ElfW(Ehdr) *hdr, struct module *me)
+{
+	return 0;
+}
diff -Nur --exclude=RCS --exclude=CVS --exclude=SCCS --exclude=BitKeeper --exclude=ChangeSet linus-2.5/arch/alpha/kernel/traps.c mod-2.5/arch/alpha/kernel/traps.c
--- linus-2.5/arch/alpha/kernel/traps.c	Sat Nov 23 14:35:25 2002
+++ mod-2.5/arch/alpha/kernel/traps.c	Fri Nov 22 16:02:07 2002
@@ -638,7 +638,7 @@
 got_exception:
 	/* Ok, we caught the exception, but we don't want it.  Is there
 	   someone to pass it along to?  */
-	if ((fixup = search_exception_table(pc, regs.gp)) != 0) {
+	if ((fixup = search_exception_table(pc)) != 0) {
 		unsigned long newpc;
 		newpc = fixup_exception(una_reg, fixup, pc);
 
diff -Nur --exclude=RCS --exclude=CVS --exclude=SCCS --exclude=BitKeeper --exclude=ChangeSet linus-2.5/arch/alpha/lib/clear_user.S mod-2.5/arch/alpha/lib/clear_user.S
--- linus-2.5/arch/alpha/lib/clear_user.S	Sat Nov 23 14:35:25 2002
+++ mod-2.5/arch/alpha/lib/clear_user.S	Fri Nov 22 16:02:07 2002
@@ -29,7 +29,7 @@
 #define EX(x,y...)			\
 	99: x,##y;			\
 	.section __ex_table,"a";	\
-	.gprel32 99b;			\
+	.long 99b - .;			\
 	lda $31, $exception-99b($31); 	\
 	.previous
 
diff -Nur --exclude=RCS --exclude=CVS --exclude=SCCS --exclude=BitKeeper --exclude=ChangeSet linus-2.5/arch/alpha/lib/copy_user.S mod-2.5/arch/alpha/lib/copy_user.S
--- linus-2.5/arch/alpha/lib/copy_user.S	Sat Nov 23 14:35:25 2002
+++ mod-2.5/arch/alpha/lib/copy_user.S	Fri Nov 22 16:02:07 2002
@@ -30,14 +30,14 @@
 #define EXI(x,y...)			\
 	99: x,##y;			\
 	.section __ex_table,"a";	\
-	.gprel32 99b;			\
+	.long 99b - .;			\
 	lda $31, $exitin-99b($31);	\
 	.previous
 
 #define EXO(x,y...)			\
 	99: x,##y;			\
 	.section __ex_table,"a";	\
-	.gprel32 99b;			\
+	.long 99b - .;			\
 	lda $31, $exitout-99b($31);	\
 	.previous
 
diff -Nur --exclude=RCS --exclude=CVS --exclude=SCCS --exclude=BitKeeper --exclude=ChangeSet linus-2.5/arch/alpha/lib/ev6-clear_user.S mod-2.5/arch/alpha/lib/ev6-clear_user.S
--- linus-2.5/arch/alpha/lib/ev6-clear_user.S	Sat Nov 23 14:35:25 2002
+++ mod-2.5/arch/alpha/lib/ev6-clear_user.S	Fri Nov 22 16:02:07 2002
@@ -47,7 +47,7 @@
 #define EX(x,y...)			\
 	99: x,##y;			\
 	.section __ex_table,"a";	\
-	.gprel32 99b;			\
+	.long 99b - .;			\
 	lda $31, $exception-99b($31); 	\
 	.previous
 
diff -Nur --exclude=RCS --exclude=CVS --exclude=SCCS --exclude=BitKeeper --exclude=ChangeSet linus-2.5/arch/alpha/lib/ev6-copy_user.S mod-2.5/arch/alpha/lib/ev6-copy_user.S
--- linus-2.5/arch/alpha/lib/ev6-copy_user.S	Sat Nov 23 14:35:25 2002
+++ mod-2.5/arch/alpha/lib/ev6-copy_user.S	Fri Nov 22 16:02:07 2002
@@ -41,14 +41,14 @@
 #define EXI(x,y...)			\
 	99: x,##y;			\
 	.section __ex_table,"a";	\
-	.gprel32 99b;			\
+	.long 99b - .;			\
 	lda $31, $exitin-99b($31);	\
 	.previous
 
 #define EXO(x,y...)			\
 	99: x,##y;			\
 	.section __ex_table,"a";	\
-	.gprel32 99b;			\
+	.long 99b - .;			\
 	lda $31, $exitout-99b($31);	\
 	.previous
 
diff -Nur --exclude=RCS --exclude=CVS --exclude=SCCS --exclude=BitKeeper --exclude=ChangeSet linus-2.5/arch/alpha/lib/ev6-strncpy_from_user.S mod-2.5/arch/alpha/lib/ev6-strncpy_from_user.S
--- linus-2.5/arch/alpha/lib/ev6-strncpy_from_user.S	Sat Nov 23 14:35:25 2002
+++ mod-2.5/arch/alpha/lib/ev6-strncpy_from_user.S	Fri Nov 22 16:02:07 2002
@@ -34,7 +34,7 @@
 #define EX(x,y...)			\
 	99: x,##y;			\
 	.section __ex_table,"a";	\
-	.gprel32 99b;			\
+	.long 99b - .;			\
 	lda $31, $exception-99b($0); 	\
 	.previous
 
diff -Nur --exclude=RCS --exclude=CVS --exclude=SCCS --exclude=BitKeeper --exclude=ChangeSet linus-2.5/arch/alpha/lib/ev67-strlen_user.S mod-2.5/arch/alpha/lib/ev67-strlen_user.S
--- linus-2.5/arch/alpha/lib/ev67-strlen_user.S	Sat Nov 23 14:35:25 2002
+++ mod-2.5/arch/alpha/lib/ev67-strlen_user.S	Fri Nov 22 16:02:07 2002
@@ -30,7 +30,7 @@
 #define EX(x,y...)			\
 	99: x,##y;			\
 	.section __ex_table,"a";	\
-	.gprel32 99b;			\
+	.long 99b - .;			\
 	lda v0, $exception-99b(zero);	\
 	.previous
 
diff -Nur --exclude=RCS --exclude=CVS --exclude=SCCS --exclude=BitKeeper --exclude=ChangeSet linus-2.5/arch/alpha/lib/strlen_user.S mod-2.5/arch/alpha/lib/strlen_user.S
--- linus-2.5/arch/alpha/lib/strlen_user.S	Sat Nov 23 14:35:25 2002
+++ mod-2.5/arch/alpha/lib/strlen_user.S	Fri Nov 22 16:02:07 2002
@@ -19,7 +19,7 @@
 #define EX(x,y...)			\
 	99: x,##y;			\
 	.section __ex_table,"a";	\
-	.gprel32 99b;			\
+	.long 99b - .;			\
 	lda v0, $exception-99b(zero);	\
 	.previous
 
diff -Nur --exclude=RCS --exclude=CVS --exclude=SCCS --exclude=BitKeeper --exclude=ChangeSet linus-2.5/arch/alpha/lib/strncpy_from_user.S mod-2.5/arch/alpha/lib/strncpy_from_user.S
--- linus-2.5/arch/alpha/lib/strncpy_from_user.S	Sat Nov 23 14:35:25 2002
+++ mod-2.5/arch/alpha/lib/strncpy_from_user.S	Fri Nov 22 16:02:07 2002
@@ -19,7 +19,7 @@
 #define EX(x,y...)			\
 	99: x,##y;			\
 	.section __ex_table,"a";	\
-	.gprel32 99b;			\
+	.long 99b - .;			\
 	lda $31, $exception-99b($0); 	\
 	.previous
 
diff -Nur --exclude=RCS --exclude=CVS --exclude=SCCS --exclude=BitKeeper --exclude=ChangeSet linus-2.5/arch/alpha/mm/extable.c mod-2.5/arch/alpha/mm/extable.c
--- linus-2.5/arch/alpha/mm/extable.c	Sat Nov 23 14:35:25 2002
+++ mod-2.5/arch/alpha/mm/extable.c	Fri Nov 22 16:02:07 2002
@@ -6,27 +6,23 @@
 #include <linux/module.h>
 #include <asm/uaccess.h>
 
-extern const struct exception_table_entry __start___ex_table[];
-extern const struct exception_table_entry __stop___ex_table[];
 
 static inline unsigned
 search_one_table(const struct exception_table_entry *first,
-		 const struct exception_table_entry *last,
-		 signed long value)
+		 unsigned int num_entries, unsigned long value)
 {
-	/* Abort early if the search value is out of range.  */
-	if (value != (signed int)value)
-		return 0;
+	const struct exception_table_entry *last = first + num_entries - 1;
 
         while (first <= last) {
 		const struct exception_table_entry *mid;
-		long diff;
+		unsigned long mid_value;
 
 		mid = (last - first) / 2 + first;
-		diff = mid->insn - value;
-                if (diff == 0)
+		mid_value = (u64)&mid->insn + mid->insn;
+
+                if (mid_value == value)
                         return mid->fixup.unit;
-                else if (diff < 0)
+                else if (mid_value < value)
                         first = mid+1;
                 else
                         last = mid-1;
@@ -34,79 +30,20 @@
         return 0;
 }
 
-register unsigned long gp __asm__("$29");
-
-static unsigned
-search_exception_table_without_gp(unsigned long addr)
-{
-	unsigned ret;
-
-#ifndef CONFIG_MODULES
-	/* There is only the kernel to search.  */
-	ret = search_one_table(__start___ex_table, __stop___ex_table - 1,
-			       addr - gp);
-#else
-	extern spinlock_t modlist_lock;
-	unsigned long flags;
-	/* The kernel is the last "module" -- no need to treat it special. */
-	struct module *mp;
-
-	ret = 0;
-	spin_lock_irqsave(&modlist_lock, flags);
-	for (mp = module_list; mp ; mp = mp->next) {
-		if (!mp->ex_table_start || !(mp->flags&(MOD_RUNNING|MOD_INITIALIZING)))
-			continue;
-		ret = search_one_table(mp->ex_table_start,
-				       mp->ex_table_end - 1, addr - mp->gp);
-		if (ret)
-			break;
-	}
-	spin_unlock_irqrestore(&modlist_lock, flags);
-#endif
-
-	return ret;
-}
-
 unsigned
-search_exception_table(unsigned long addr, unsigned long exc_gp)
+search_exception_table(unsigned long addr)
 {
-	unsigned ret;
-
-#ifndef CONFIG_MODULES
-	ret = search_one_table(__start___ex_table, __stop___ex_table - 1,
-			       addr - exc_gp);
-	if (ret) return ret;
-#else
-	extern spinlock_t modlist_lock;
 	unsigned long flags;
-	/* The kernel is the last "module" -- no need to treat it special. */
-	struct module *mp;
+	struct exception_table *et;
+	unsigned ret = 0;
 
-	ret = 0;
 	spin_lock_irqsave(&modlist_lock, flags);
-	for (mp = module_list; mp ; mp = mp->next) {
-		if (!mp->ex_table_start || !(mp->flags&(MOD_RUNNING|MOD_INITIALIZING)))
-			continue;
-		ret = search_one_table(mp->ex_table_start,
-				       mp->ex_table_end - 1, addr - exc_gp);
+	list_for_each_entry(et, &extables, list) {
+		ret = search_one_table(et->entry, et->num_entries, addr);
 		if (ret)
 			break;
 	}
 	spin_unlock_irqrestore(&modlist_lock, flags);
-	if (ret) return ret;
-#endif
-
-	/*
-	 * The search failed with the exception gp. To be safe, try the
-	 * old method before giving up.
-	 */
-	ret = search_exception_table_without_gp(addr);
-	if (ret) {
-		printk(KERN_ALERT "%s: [%lx] EX_TABLE search fail with"
-		       "exc frame GP, success with raw GP\n",
-		       current->comm, addr);
-		return ret;
-	}
 
-	return 0;
+	return ret;
 }
diff -Nur --exclude=RCS --exclude=CVS --exclude=SCCS --exclude=BitKeeper --exclude=ChangeSet linus-2.5/arch/alpha/mm/fault.c mod-2.5/arch/alpha/mm/fault.c
--- linus-2.5/arch/alpha/mm/fault.c	Sat Nov 23 14:35:25 2002
+++ mod-2.5/arch/alpha/mm/fault.c	Fri Nov 22 16:02:07 2002
@@ -176,7 +176,7 @@
 
  no_context:
 	/* Are we prepared to handle this fault as an exception?  */
-	if ((fixup = search_exception_table(regs->pc, regs->gp)) != 0) {
+	if ((fixup = search_exception_table(regs->pc)) != 0) {
 		unsigned long newpc;
 		newpc = fixup_exception(dpf_reg, fixup, regs->pc);
 		regs->pc = newpc;
diff -Nur --exclude=RCS --exclude=CVS --exclude=SCCS --exclude=BitKeeper --exclude=ChangeSet linus-2.5/arch/i386/kernel/module.c mod-2.5/arch/i386/kernel/module.c
--- linus-2.5/arch/i386/kernel/module.c	Sat Nov 23 14:35:26 2002
+++ mod-2.5/arch/i386/kernel/module.c	Fri Nov 22 16:02:08 2002
@@ -35,90 +35,66 @@
 	return vmalloc(size);
 }
 
-
-/* Free memory returned from module_alloc */
-void module_free(struct module *mod, void *module_region)
-{
-	vfree(module_region);
-	/* FIXME: If module_region == mod->init_region, trim exception
-           table entries. */
-}
-
-/* We don't need anything special. */
-long module_core_size(const Elf32_Ehdr *hdr,
-		      const Elf32_Shdr *sechdrs,
-		      const char *secstrings,
-		      struct module *module)
+void module_free(void *region)
 {
-	return module->core_size;
+	vfree(region);
 }
 
-long module_init_size(const Elf32_Ehdr *hdr,
-		      const Elf32_Shdr *sechdrs,
-		      const char *secstrings,
-		      struct module *module)
+long module_core_size(const ElfW(Ehdr) *hdr, struct module *module,
+		      unsigned long min_addr, unsigned long max_addr)
 {
-	return module->init_size;
+	return max_addr - min_addr;
 }
 
-int apply_relocate(Elf32_Shdr *sechdrs,
-		   const char *strtab,
-		   unsigned int symindex,
-		   unsigned int relsec,
+int apply_relocate(const ElfW(Rel) *rel, unsigned long nrelocs,
 		   struct module *me)
 {
 	unsigned int i;
-	Elf32_Rel *rel = (void *)sechdrs[relsec].sh_offset;
-	Elf32_Sym *sym;
-	uint32_t *location;
-
-	DEBUGP("Applying relocate section %u to %u\n", relsec,
-	       sechdrs[relsec].sh_info);
-	for (i = 0; i < sechdrs[relsec].sh_size / sizeof(*rel); i++) {
-		/* This is where to make the change */
-		location = (void *)sechdrs[sechdrs[relsec].sh_info].sh_offset
-			+ rel[i].r_offset;
-		/* This is the symbol it is referring to */
-		sym = (Elf32_Sym *)sechdrs[symindex].sh_offset
-			+ ELF32_R_SYM(rel[i].r_info);
-		if (!sym->st_value) {
-			printk(KERN_WARNING "%s: Unknown symbol %s\n",
-			       me->name, strtab + sym->st_name);
-			return -ENOENT;
+
+	for (i = 0; i < nrelocs; i++) {
+		unsigned long r_type = ELFW(R_TYPE)(rel[i].r_info);
+		u32 *location = (void *)me->loadaddr + rel[i].r_offset;
+		unsigned int symnum;
+		unsigned long value = 0;
+
+		if (r_type == R_386_RELATIVE) {
+			*location += (u32) me->loadaddr;
+			continue;
+		}
+
+		/* This is the symbol it is referring to.  */
+		symnum = ELFW(R_SYM)(rel[i].r_info);
+		if (symnum) {
+			value = (u32) resolve_symbol(me, symnum);
+			if (!value)
+				return -ENOENT;
 		}
 
-		switch (ELF32_R_TYPE(rel[i].r_info)) {
+		switch (r_type) {
 		case R_386_32:
-			/* We add the value into the location given */
-			*location += sym->st_value;
+			*location += value;
 			break;
 		case R_386_PC32:
-			/* Add the value, subtract its postition */
-			*location += sym->st_value - (uint32_t)location;
+			*location += value - (u32)location;
 			break;
 		default:
-			printk(KERN_ERR "module %s: Unknown relocation: %u\n",
-			       me->name, ELF32_R_TYPE(rel[i].r_info));
+			printk(KERN_ERR "module %s: Unknown relocation: %lu\n",
+			       me->name, r_type);
 			return -ENOEXEC;
 		}
 	}
+
 	return 0;
 }
 
-int apply_relocate_add(Elf32_Shdr *sechdrs,
-		       const char *strtab,
-		       unsigned int symindex,
-		       unsigned int relsec,
+int apply_relocate_add(const ElfW(Rela) *rela, unsigned long nrelocs,
 		       struct module *me)
 {
-	printk(KERN_ERR "module %s: ADD RELOCATION unsupported\n",
-	       me->name);
+	printk(KERN_ERR "module %s: ADD RELOCATION unsupported\n", me->name);
 	return -ENOEXEC;
 }
 
-int module_finalize(const Elf_Ehdr *hdr,
-		    const Elf_Shdr *sechdrs,
-		    struct module *me)
+int module_finalize(const ElfW(Ehdr) *hdr, struct module *me)
 {
 	return 0;
 }
diff -Nur --exclude=RCS --exclude=CVS --exclude=SCCS --exclude=BitKeeper --exclude=ChangeSet linus-2.5/include/asm-alpha/elf.h mod-2.5/include/asm-alpha/elf.h
--- linus-2.5/include/asm-alpha/elf.h	Sat Nov 23 14:35:47 2002
+++ mod-2.5/include/asm-alpha/elf.h	Fri Nov 22 16:02:26 2002
@@ -1,6 +1,11 @@
 #ifndef __ASM_ALPHA_ELF_H
 #define __ASM_ALPHA_ELF_H
 
+/* Once upon a time, the type of the hash table entry for Elf64 was unclear.
+   BFD got it wrong, and Alpha is stuck with the result.  */
+#define __HAVE_ARCH_ELF_SYMNDX
+typedef __u64 Elf_Symndx;
+
 /*
  * ELF register definitions..
  */
diff -Nur --exclude=RCS --exclude=CVS --exclude=SCCS --exclude=BitKeeper --exclude=ChangeSet linus-2.5/include/asm-alpha/module.h mod-2.5/include/asm-alpha/module.h
--- linus-2.5/include/asm-alpha/module.h	Sat Nov 23 14:35:47 2002
+++ mod-2.5/include/asm-alpha/module.h	Fri Nov 22 16:02:26 2002
@@ -1,6 +1,11 @@
 #ifndef _ASM_ALPHA_MODULE_H
 #define _ASM_ALPHA_MODULE_H
 
-/* Module rewrite still in progress.  */
+struct mod_arch_specific
+{
+};
+
+/* Turn code pointer into function pointer.  */
+#define adjust_initfini_address(mod, x)  x
 
 #endif /* _ASM_ALPHA_MODULE_H */
diff -Nur --exclude=RCS --exclude=CVS --exclude=SCCS --exclude=BitKeeper --exclude=ChangeSet linus-2.5/include/asm-alpha/uaccess.h mod-2.5/include/asm-alpha/uaccess.h
--- linus-2.5/include/asm-alpha/uaccess.h	Sat Nov 23 14:35:47 2002
+++ mod-2.5/include/asm-alpha/uaccess.h	Fri Nov 22 16:02:26 2002
@@ -126,7 +126,7 @@
 	__asm__("1: ldq %0,%2\n"			\
 	"2:\n"						\
 	".section __ex_table,\"a\"\n"			\
-	"	.gprel32 1b\n"				\
+	"	.long 1b - .\n"				\
 	"	lda %0, 2b-1b(%1)\n"			\
 	".previous"					\
 		: "=r"(__gu_val), "=r"(__gu_err)	\
@@ -136,7 +136,7 @@
 	__asm__("1: ldl %0,%2\n"			\
 	"2:\n"						\
 	".section __ex_table,\"a\"\n"			\
-	"	.gprel32 1b\n"				\
+	"	.long 1b - .\n"				\
 	"	lda %0, 2b-1b(%1)\n"			\
 	".previous"					\
 		: "=r"(__gu_val), "=r"(__gu_err)	\
@@ -149,7 +149,7 @@
 	__asm__("1: ldwu %0,%2\n"			\
 	"2:\n"						\
 	".section __ex_table,\"a\"\n"			\
-	"	.gprel32 1b\n"				\
+	"	.long 1b - .\n"				\
 	"	lda %0, 2b-1b(%1)\n"			\
 	".previous"					\
 		: "=r"(__gu_val), "=r"(__gu_err)	\
@@ -159,7 +159,7 @@
 	__asm__("1: ldbu %0,%2\n"			\
 	"2:\n"						\
 	".section __ex_table,\"a\"\n"			\
-	"	.gprel32 1b\n"				\
+	"	.long 1b - .\n"				\
 	"	lda %0, 2b-1b(%1)\n"			\
 	".previous"					\
 		: "=r"(__gu_val), "=r"(__gu_err)	\
@@ -178,10 +178,10 @@
 	"	or %0,%1,%0\n"						\
 	"3:\n"								\
 	".section __ex_table,\"a\"\n"					\
-	"	.gprel32 1b\n"						\
+	"	.long 1b - .\n"						\
 	"	lda %0, 3b-1b(%2)\n"					\
-	"	.gprel32 2b\n"						\
-	"	lda %0, 2b-1b(%2)\n"					\
+	"	.long 2b - .\n"						\
+	"	lda %0, 3b-2b(%2)\n"					\
 	".previous"							\
 		: "=&r"(__gu_val), "=&r"(__gu_tmp), "=r"(__gu_err)	\
 		: "r"(addr), "2"(__gu_err));				\
@@ -192,7 +192,7 @@
 	"	extbl %0,%2,%0\n"					\
 	"2:\n"								\
 	".section __ex_table,\"a\"\n"					\
-	"	.gprel32 1b\n"						\
+	"	.long 1b - .\n"						\
 	"	lda %0, 2b-1b(%1)\n"					\
 	".previous"							\
 		: "=&r"(__gu_val), "=r"(__gu_err)			\
@@ -240,7 +240,7 @@
 __asm__ __volatile__("1: stq %r2,%1\n"				\
 	"2:\n"							\
 	".section __ex_table,\"a\"\n"				\
-	"	.gprel32 1b\n"					\
+	"	.long 1b - .\n"					\
 	"	lda $31,2b-1b(%0)\n"				\
 	".previous"						\
 		: "=r"(__pu_err)				\
@@ -250,7 +250,7 @@
 __asm__ __volatile__("1: stl %r2,%1\n"				\
 	"2:\n"							\
 	".section __ex_table,\"a\"\n"				\
-	"	.gprel32 1b\n"					\
+	"	.long 1b - .\n"					\
 	"	lda $31,2b-1b(%0)\n"				\
 	".previous"						\
 		: "=r"(__pu_err)				\
@@ -263,7 +263,7 @@
 __asm__ __volatile__("1: stw %r2,%1\n"				\
 	"2:\n"							\
 	".section __ex_table,\"a\"\n"				\
-	"	.gprel32 1b\n"					\
+	"	.long 1b - .\n"					\
 	"	lda $31,2b-1b(%0)\n"				\
 	".previous"						\
 		: "=r"(__pu_err)				\
@@ -273,7 +273,7 @@
 __asm__ __volatile__("1: stb %r2,%1\n"				\
 	"2:\n"							\
 	".section __ex_table,\"a\"\n"				\
-	"	.gprel32 1b\n"					\
+	"	.long 1b - .\n"					\
 	"	lda $31,2b-1b(%0)\n"				\
 	".previous"						\
 		: "=r"(__pu_err)				\
@@ -298,13 +298,13 @@
 	"4:	stq_u %1,0(%5)\n"				\
 	"5:\n"							\
 	".section __ex_table,\"a\"\n"				\
-	"	.gprel32 1b\n"					\
+	"	.long 1b - .\n"					\
 	"	lda $31, 5b-1b(%0)\n"				\
-	"	.gprel32 2b\n"					\
+	"	.long 2b - .\n"					\
 	"	lda $31, 5b-2b(%0)\n"				\
-	"	.gprel32 3b\n"					\
+	"	.long 3b - .\n"					\
 	"	lda $31, 5b-3b(%0)\n"				\
-	"	.gprel32 4b\n"					\
+	"	.long 4b - .\n"					\
 	"	lda $31, 5b-4b(%0)\n"				\
 	".previous"						\
 		: "=r"(__pu_err), "=&r"(__pu_tmp1),		\
@@ -324,9 +324,9 @@
 	"2:	stq_u %1,0(%4)\n"				\
 	"3:\n"							\
 	".section __ex_table,\"a\"\n"				\
-	"	.gprel32 1b\n"					\
+	"	.long 1b - .\n"					\
 	"	lda $31, 3b-1b(%0)\n"				\
-	"	.gprel32 2b\n"					\
+	"	.long 2b - .\n"					\
 	"	lda $31, 3b-2b(%0)\n"				\
 	".previous"						\
 		: "=r"(__pu_err),				\
@@ -471,7 +471,7 @@
 /*
  * About the exception table:
  *
- * - insn is a 32-bit offset off of the kernel's or module's gp.
+ * - insn is a 32-bit pc-relative offset from the entry to the fault insn.
  * - nextinsn is a 16-bit offset off of the faulting instruction
  *   (not off of the *next* instruction as branches are).
  * - errreg is the register in which to place -EFAULT.
@@ -502,7 +502,7 @@
 };
 
 /* Returns 0 if exception not found and fixup.unit otherwise.  */
-extern unsigned search_exception_table(unsigned long, unsigned long);
+extern unsigned search_exception_table(unsigned long);
 
 /* Returns the new pc */
 #define fixup_exception(map_reg, fixup_unit, pc)		\
diff -Nur --exclude=RCS --exclude=CVS --exclude=SCCS --exclude=BitKeeper --exclude=ChangeSet linus-2.5/include/asm-i386/module.h mod-2.5/include/asm-i386/module.h
--- linus-2.5/include/asm-i386/module.h	Sat Nov 23 14:35:48 2002
+++ mod-2.5/include/asm-i386/module.h	Fri Nov 22 16:02:27 2002
@@ -1,11 +1,12 @@
 #ifndef _ASM_I386_MODULE_H
 #define _ASM_I386_MODULE_H
+
 /* x86 is simple */
 struct mod_arch_specific
 {
 };
 
-#define Elf_Shdr Elf32_Shdr
-#define Elf_Sym Elf32_Sym
-#define Elf_Ehdr Elf32_Ehdr
+/* Turn code pointer into function pointer.  */
+#define adjust_initfini_address(mod, x)  x
+
 #endif /* _ASM_I386_MODULE_H */
diff -Nur --exclude=RCS --exclude=CVS --exclude=SCCS --exclude=BitKeeper --exclude=ChangeSet linus-2.5/include/linux/elf.h mod-2.5/include/linux/elf.h
--- linus-2.5/include/linux/elf.h	Sat Nov 23 14:35:52 2002
+++ mod-2.5/include/linux/elf.h	Fri Nov 22 16:02:31 2002
@@ -21,6 +21,10 @@
 typedef __u64	Elf64_Xword;
 typedef __s64	Elf64_Sxword;
 
+#ifndef __HAVE_ARCH_ELF_SYMNDX
+typedef __u32	Elf_Symndx;
+#endif
+
 /* These constants are for the segment types stored in the image headers */
 #define PT_NULL    0
 #define PT_LOAD    1
@@ -347,34 +351,39 @@
 /*
  * Alpha ELF relocation types
  */
-#define R_ALPHA_NONE            0       /* No reloc */
-#define R_ALPHA_REFLONG         1       /* Direct 32 bit */
-#define R_ALPHA_REFQUAD         2       /* Direct 64 bit */
-#define R_ALPHA_GPREL32         3       /* GP relative 32 bit */
-#define R_ALPHA_LITERAL         4       /* GP relative 16 bit w/optimization */
-#define R_ALPHA_LITUSE          5       /* Optimization hint for LITERAL */
-#define R_ALPHA_GPDISP          6       /* Add displacement to GP */
-#define R_ALPHA_BRADDR          7       /* PC+4 relative 23 bit shifted */
-#define R_ALPHA_HINT            8       /* PC+4 relative 16 bit shifted */
-#define R_ALPHA_SREL16          9       /* PC relative 16 bit */
-#define R_ALPHA_SREL32          10      /* PC relative 32 bit */
-#define R_ALPHA_SREL64          11      /* PC relative 64 bit */
-#define R_ALPHA_OP_PUSH         12      /* OP stack push */
-#define R_ALPHA_OP_STORE        13      /* OP stack pop and store */
-#define R_ALPHA_OP_PSUB         14      /* OP stack subtract */
-#define R_ALPHA_OP_PRSHIFT      15      /* OP stack right shift */
-#define R_ALPHA_GPVALUE         16
-#define R_ALPHA_GPRELHIGH       17
-#define R_ALPHA_GPRELLOW        18
-#define R_ALPHA_IMMED_GP_16     19
-#define R_ALPHA_IMMED_GP_HI32   20
-#define R_ALPHA_IMMED_SCN_HI32  21
-#define R_ALPHA_IMMED_BR_HI32   22
-#define R_ALPHA_IMMED_LO32      23
-#define R_ALPHA_COPY            24      /* Copy symbol at runtime */
-#define R_ALPHA_GLOB_DAT        25      /* Create GOT entry */
-#define R_ALPHA_JMP_SLOT        26      /* Create PLT entry */
-#define R_ALPHA_RELATIVE        27      /* Adjust by program base */
+#define R_ALPHA_NONE		0	/* No reloc */
+#define R_ALPHA_REFLONG		1	/* Direct 32 bit */
+#define R_ALPHA_REFQUAD		2	/* Direct 64 bit */
+#define R_ALPHA_GPREL32		3	/* GP relative 32 bit */
+#define R_ALPHA_LITERAL		4	/* GP relative 16 bit w/optimization */
+#define R_ALPHA_LITUSE		5	/* Optimization hint for LITERAL */
+#define R_ALPHA_GPDISP		6	/* Add displacement to GP */
+#define R_ALPHA_BRADDR		7	/* PC+4 relative 23 bit shifted */
+#define R_ALPHA_HINT		8	/* PC+4 relative 16 bit shifted */
+#define R_ALPHA_SREL16		9	/* PC relative 16 bit */
+#define R_ALPHA_SREL32		10	/* PC relative 32 bit */
+#define R_ALPHA_SREL64		11	/* PC relative 64 bit */
+#define R_ALPHA_GPRELHIGH	17	/* GP relative 32 bit, high 16 bits */
+#define R_ALPHA_GPRELLOW	18	/* GP relative 32 bit, low 16 bits */
+#define R_ALPHA_GPREL16		19	/* GP relative 16 bit */
+#define R_ALPHA_COPY		24	/* Copy symbol at runtime */
+#define R_ALPHA_GLOB_DAT	25	/* Create GOT entry */
+#define R_ALPHA_JMP_SLOT	26	/* Create PLT entry */
+#define R_ALPHA_RELATIVE	27	/* Adjust by program base */
+#define R_ALPHA_BRSGP		28
+#define R_ALPHA_TLSGD		29
+#define R_ALPHA_TLSLDM		30
+#define R_ALPHA_DTPMOD64	31
+#define R_ALPHA_GOTDTPREL	32
+#define R_ALPHA_DTPREL64	33
+#define R_ALPHA_DTPRELHI	34
+#define R_ALPHA_DTPRELLO	35
+#define R_ALPHA_DTPREL16	36
+#define R_ALPHA_GOTTPREL	37
+#define R_ALPHA_TPREL64		38
+#define R_ALPHA_TPRELHI		39
+#define R_ALPHA_TPRELLO		40
+#define R_ALPHA_TPREL16		41
 
 /* PowerPC relocations defined by the ABIs */
 #define R_PPC_NONE		0
@@ -676,20 +685,19 @@
 } Elf64_Nhdr;
 
 #if ELF_CLASS == ELFCLASS32
-
-extern Elf32_Dyn _DYNAMIC [];
+#define ElfW(X)		Elf32_ ## X
+#define ELFW(X)		ELF32_ ## X
 #define elfhdr		elf32_hdr
 #define elf_phdr	elf32_phdr
 #define elf_note	elf32_note
-
 #else
-
-extern Elf64_Dyn _DYNAMIC [];
+#define ElfW(X)		Elf64_ ## X
+#define ELFW(X)		ELF64_ ## X
 #define elfhdr		elf64_hdr
 #define elf_phdr	elf64_phdr
 #define elf_note	elf64_note
-
 #endif
 
+extern ElfW(Dyn) _DYNAMIC [];
 
 #endif /* _LINUX_ELF_H */
diff -Nur --exclude=RCS --exclude=CVS --exclude=SCCS --exclude=BitKeeper --exclude=ChangeSet linus-2.5/include/linux/init.h mod-2.5/include/linux/init.h
--- linus-2.5/include/linux/init.h	Sat Nov 23 14:35:52 2002
+++ mod-2.5/include/linux/init.h	Fri Nov 22 16:02:31 2002
@@ -144,31 +144,25 @@
 #define device_initcall(fn)		module_init(fn)
 #define late_initcall(fn)		module_init(fn)
 
-/* Each module knows its own name. */
-#define __DEFINE_MODULE_NAME						\
-	char __module_name[] __attribute__((section(".modulename"))) =	\
-	__stringify(KBUILD_MODNAME)
-
 /* These macros create a dummy inline: gcc 2.9x does not count alias
- as usage, hence the `unused function' warning when __init functions
- are declared static. We use the dummy __*_module_inline functions
- both to kill the warning and check the type of the init/cleanup
- function. */
+   as usage, hence the `unused function' warning when __init functions
+   are declared static. We use the dummy __*_module_inline functions
+   both to kill the warning and check the type of the init/cleanup
+   function. */
 
 /* Each module must use one module_init(), or one no_module_init */
 #define module_init(initfn)					\
-	__DEFINE_MODULE_NAME;					\
 	static inline initcall_t __inittest(void)		\
 	{ return initfn; }					\
-	int __initfn(void) __attribute__((alias(#initfn)));
+	int _init(void) __attribute__((alias(#initfn)));
 
-#define no_module_init __DEFINE_MODULE_NAME
+#define no_module_init
 
 /* This is only required if you want to be unloadable. */
 #define module_exit(exitfn)					\
 	static inline exitcall_t __exittest(void)		\
 	{ return exitfn; }					\
-	void __exitfn(void) __attribute__((alias(#exitfn)));
+	void _fini(void) __attribute__((alias(#exitfn)));
 
 
 #define __setup(str,func) /* nothing */
diff -Nur --exclude=RCS --exclude=CVS --exclude=SCCS --exclude=BitKeeper --exclude=ChangeSet linus-2.5/include/linux/module.h mod-2.5/include/linux/module.h
--- linus-2.5/include/linux/module.h	Sat Nov 23 14:35:52 2002
+++ mod-2.5/include/linux/module.h	Sat Nov 23 14:36:47 2002
@@ -31,6 +31,7 @@
 #define MODULE_PARM_DESC(var,desc)
 #define print_modules()
 
+/* ??? Deprecated.  Still used for the kernel itself though.  */
 #define MODULE_NAME_LEN (64 - sizeof(unsigned long))
 struct kernel_symbol
 {
@@ -61,18 +62,6 @@
 #define MODULE_DEVICE_TABLE(type,name)		\
   MODULE_GENERIC_TABLE(type##_device,name)
 
-struct kernel_symbol_group
-{
-	/* Links us into the global symbol list */
-	struct list_head list;
-
-	/* Module which owns it (if any) */
-	struct module *owner;
-
-	unsigned int num_syms;
-	const struct kernel_symbol *syms;
-};
-
 struct exception_table
 {
 	struct list_head list;
@@ -88,11 +77,22 @@
 void *__symbol_get_gpl(const char *symbol);
 #define symbol_get(x) ((typeof(&x))(__symbol_get(#x)))
 
+#ifdef MODULE
+/* For every exported symbol, place its name in the .exports section.  */
+#define EXPORT_SYMBOL(sym)			\
+	asm (".section .exports\n\t"		\
+	     ".asciz \"" #sym "\"\n\t"		\
+	     ".protected " #sym "\n\t"		\
+	     ".previous")
+#else
 /* For every exported symbol, place a struct in the __ksymtab section */
+/* FIXME: trick the linker into creating a dynamic symbol table for
+   the kernel as well.  */
 #define EXPORT_SYMBOL(sym)				\
 	const struct kernel_symbol __ksymtab_##sym	\
 	__attribute__((section("__ksymtab")))		\
 	= { (unsigned long)&sym, #sym }
+#endif
 
 #define EXPORT_SYMBOL_NOVERS(sym) EXPORT_SYMBOL(sym)
 #define EXPORT_SYMBOL_GPL(sym) EXPORT_SYMBOL(sym)
@@ -104,35 +104,39 @@
 
 struct module
 {
-	/* Am I live (yet)? */
-	int live;
-
-	/* Member of list of modules */
+	/* Member of list of modules.  */
 	struct list_head list;
 
-	/* Unique handle for this module */
+	/* Unique handle for this module.  */
 	char name[MODULE_NAME_LEN];
 
-	/* Exported symbols */
-	struct kernel_symbol_group symbols;
-
-	/* Exception tables */
+	/* Exception tables. */
 	struct exception_table extable;
 
-	/* Startup function. */
-	int (*init)(void);
+	/* Arch-specific module values.  */
+	struct mod_arch_specific arch;
 
-	/* If this is non-NULL, vfree after init() returns */
-	void *module_init;
+	/* The memory allocated for the module text.  */
+	void *core;
 
-	/* Here is the actual code + data, vfree'd on unload. */
-	void *module_core;
+	/* The size of that memory.  */
+	unsigned long core_size;
 
-	/* Here are the sizes of the init and core sections */
-	unsigned long init_size, core_size;
+	/* The "base address" of the module.  Usually, but not always,
+	   the same as the above core address.  */
+	void *loadaddr;
+
+	/* The DYNAMIC segment.  */
+	const ElfW(Dyn) *dynamic;
+
+	/* Cached components of the dynamic symbol table,
+	   aka exported symbols.  */
+	const Elf_Symndx *dt_hash;
+	const ElfW(Sym) *dt_symtab;
+	const char *dt_strtab;
 
-	/* Arch-specific module values */
-	struct mod_arch_specific arch;
+	/* Am I live (yet)? */
+	int live;
 
 	/* Am I unsafe to unload? */
 	int unsafe;
@@ -146,20 +150,10 @@
 
 	/* Who is waiting for us to be unloaded */
 	struct task_struct *waiter;
-
-	/* Destruction function. */
-	void (*exit)(void);
-#endif
-
-#ifdef CONFIG_KALLSYMS
-	/* We keep the symbol and string tables for kallsyms. */
-	Elf_Sym *symtab;
-	unsigned long num_syms;
-	char *strtab;
 #endif
 
-	/* The command line arguments (may be mangled).  People like
-	   keeping pointers to this stuff */
+	/* The command line arguments (may be mangled).
+	   People like keeping pointers to this stuff */
 	char args[0];
 };
 
@@ -298,21 +292,15 @@
 (((a_start) >= (b_start) && (a_start) <= (b_start)+(b_len))	\
  || ((a_start)+(a_len) >= (b_start)				\
      && (a_start)+(a_len) <= (b_start)+(b_len)))
-#define mod_bound(p, n, m)					\
-(((m)->module_init						\
-  && __mod_between((p),(n),(m)->module_init,(m)->init_size))	\
- || __mod_between((p),(n),(m)->module_core,(m)->core_size))
+#define mod_bound(p, n, m) \
+  __mod_between((p),(n),(m)->core,(m)->core_size)
 
 /* Old-style "I'll just call it init_module and it'll be run at
    insert".  Use module_init(myroutine) instead. */
 #ifdef MODULE
-/* Used as "int init_module(void) { ... }".  Get funky to insert modname. */
-#define init_module(voidarg)						\
-	__initfn(void);							\
-	char __module_name[] __attribute__((section(".modulename"))) =	\
-	__stringify(KBUILD_MODNAME);					\
-	int __initfn(void)
-#define cleanup_module(voidarg) __exitfn(void)
+/* Used as "int init_module(void) { ... }".  */
+#define init_module(voidarg)	_init(voidarg)
+#define cleanup_module(voidarg)	_fini(voidarg)
 #endif
 
 /*
diff -Nur --exclude=RCS --exclude=CVS --exclude=SCCS --exclude=BitKeeper --exclude=ChangeSet linus-2.5/include/linux/moduleloader.h mod-2.5/include/linux/moduleloader.h
--- linus-2.5/include/linux/moduleloader.h	Sat Nov 23 14:35:52 2002
+++ mod-2.5/include/linux/moduleloader.h	Fri Nov 22 16:02:31 2002
@@ -5,57 +5,39 @@
 #include <linux/module.h>
 #include <linux/elf.h>
 
-/* Helper function for arch-specific module loaders */
-unsigned long find_symbol_internal(Elf_Shdr *sechdrs,
-				   unsigned int symindex,
-				   const char *strtab,
-				   const char *name,
-				   struct module *mod,
-				   struct kernel_symbol_group **group);
+/* Returns the address of dynamic symbol SYMNUM, and NULL on failure.  */
+void *resolve_symbol(struct module *mod, Elf_Symndx symnum);
 
-/* These must be implemented by the specific architecture */
+/* These must be implemented by the specific architecture.  */
 
 /* Total size to allocate for the non-releasable code; return len or
    -error.  mod->core_size is the current generic tally. */
-long module_core_size(const Elf_Ehdr *hdr,
-		      const Elf_Shdr *sechdrs,
-		      const char *secstrings,
-		      struct module *mod);
-
-/* Total size of (if any) sections to be freed after init.  Return 0
-   for none, len, or -error. mod->init_size is the current generic
-   tally. */
-long module_init_size(const Elf_Ehdr *hdr,
-		      const Elf_Shdr *sechdrs,
-		      const char *secstrings,
-		      struct module *mod);
+long module_core_size(const ElfW(Ehdr) *hdr,
+		      struct module *mod,
+		      unsigned long min_addr,
+		      unsigned long max_addr);
 
 /* Allocator used for allocating struct module, core sections and init
    sections.  Returns NULL on failure. */
 void *module_alloc(unsigned long size);
 
 /* Free memory returned from module_alloc. */
-void module_free(struct module *mod, void *module_region);
+void module_free(void *module_region);
 
 /* Apply the given relocation to the (simplified) ELF.  Return -error
    or 0. */
-int apply_relocate(Elf_Shdr *sechdrs,
-		   const char *strtab,
-		   unsigned int symindex,
-		   unsigned int relsec,
+int apply_relocate(const ElfW(Rel) *relocs,
+		   unsigned long nrelocs,
 		   struct module *mod);
 
 /* Apply the given add relocation to the (simplified) ELF.  Return
    -error or 0 */
-int apply_relocate_add(Elf_Shdr *sechdrs,
-		       const char *strtab,
-		       unsigned int symindex,
-		       unsigned int relsec,
+int apply_relocate_add(const ElfW(Rela) *relocs,
+		       unsigned long nrelocs,
 		       struct module *mod);
 
 /* Any final processing of module before access.  Return -error or 0. */
-int module_finalize(const Elf_Ehdr *hdr,
-		    const Elf_Shdr *sechdrs,
+int module_finalize(const ElfW(Ehdr) *hdr,
 		    struct module *mod);
 
 #endif
diff -Nur --exclude=RCS --exclude=CVS --exclude=SCCS --exclude=BitKeeper --exclude=ChangeSet linus-2.5/kernel/extable.c mod-2.5/kernel/extable.c
--- linus-2.5/kernel/extable.c	Sat Nov 23 14:35:53 2002
+++ mod-2.5/kernel/extable.c	Fri Nov 22 16:02:32 2002
@@ -22,8 +22,6 @@
 
 extern const struct exception_table_entry __start___ex_table[];
 extern const struct exception_table_entry __stop___ex_table[];
-extern const struct kernel_symbol __start___ksymtab[];
-extern const struct kernel_symbol __stop___ksymtab[];
 
 /* Protects extables and symbol tables */
 spinlock_t modlist_lock = SPIN_LOCK_UNLOCKED;
@@ -33,19 +31,11 @@
 LIST_HEAD(symbols);
 
 static struct exception_table kernel_extable;
-static struct kernel_symbol_group kernel_symbols;
 
 void __init extable_init(void)
 {
-	/* Add kernel symbols to symbol table */
-	kernel_symbols.num_syms = (__stop___ksymtab - __start___ksymtab);
-	kernel_symbols.syms = __start___ksymtab;
-	list_add(&kernel_symbols.list, &symbols);
-
 	/* Add kernel exception table to exception tables */
-	kernel_extable.num_entries = (__stop___ex_table -__start___ex_table);
+	kernel_extable.num_entries = (__stop___ex_table - __start___ex_table);
 	kernel_extable.entry = __start___ex_table;
 	list_add(&kernel_extable.list, &extables);
 }
-
-
diff -Nur --exclude=RCS --exclude=CVS --exclude=SCCS --exclude=BitKeeper --exclude=ChangeSet linus-2.5/kernel/module.c mod-2.5/kernel/module.c
--- linus-2.5/kernel/module.c	Sat Nov 23 14:35:53 2002
+++ mod-2.5/kernel/module.c	Sat Nov 23 14:36:48 2002
@@ -31,7 +31,7 @@
 #include <asm/pgalloc.h>
 #include <asm/cacheflush.h>
 
-#if 0
+#if 1
 #define DEBUGP printk
 #else
 #define DEBUGP(fmt , a...)
@@ -41,60 +41,101 @@
 static DECLARE_MUTEX(module_mutex);
 LIST_HEAD(modules); /* FIXME: Accessed w/o lock on oops by some archs */
 
-/* Convenient structure for holding init and core sizes */
-struct sizes
+extern const struct kernel_symbol __start___ksymtab[];
+extern const struct kernel_symbol __stop___ksymtab[];
+
+/* Search for module by name: must hold module_mutex. */
+static struct module *find_module(const char *name)
 {
-	unsigned long init_size;
-	unsigned long core_size;
-};
+	struct module *mod;
 
-/* Find a symbol, return value and the symbol group */
-static unsigned long __find_symbol(const char *name,
-				   struct kernel_symbol_group **group)
-{
-	struct kernel_symbol_group *ks;
- 
-	list_for_each_entry(ks, &symbols, list) {
- 		unsigned int i;
-
-		for (i = 0; i < ks->num_syms; i++) {
-			if (strcmp(ks->syms[i].name, name) == 0) {
-				*group = ks;
-				return ks->syms[i].value;
-			}
-		}
+	list_for_each_entry(mod, &modules, list) {
+		if (strcmp(mod->name, name) == 0)
+			return mod;
 	}
-	DEBUGP("Failed to find symbol %s\n", name);
- 	return 0;
+	return NULL;
 }
 
-/* Find a symbol in this elf symbol table */
-static unsigned long find_local_symbol(Elf_Shdr *sechdrs,
-				       unsigned int symindex,
-				       const char *strtab,
-				       const char *name)
+/* Standard ELF hashing function.  */
+
+static u32
+elf_hash(const char *name)
 {
-	unsigned int i;
-	Elf_Sym *sym = (void *)sechdrs[symindex].sh_offset;
+  u32 hash = 0;
 
-	/* Search (defined) internal symbols first. */
-	for (i = 1; i < sechdrs[symindex].sh_size/sizeof(*sym); i++) {
-		if (sym[i].st_shndx != SHN_UNDEF
-		    && strcmp(name, strtab + sym[i].st_name) == 0)
-			return sym[i].st_value;
-	}
-	return 0;
+  while (*name)
+    {
+      u32 hi;
+
+      hash = (hash << 4) + (u8)*name++;
+      hi = hash & 0xf0000000;
+
+      /* The algorithm specified in the ELF ABI is as follows:
+
+	 if (hi != 0)
+	   hash ^= hi >> 24;
+	 hash &= ~hi;
+
+	 But the following is equivalent and faster.  */
+      hash ^= hi;
+      hash ^= hi >> 24;
+    }
+
+  return hash;
 }
 
-/* Search for module by name: must hold module_mutex. */
-static struct module *find_module(const char *name)
+/* Find a symbol, return it and the module.  Must be holding the 
+   module list lock.  */
+
+static void *
+__find_symbol(const char *name, struct module **pmod)
 {
+	const struct kernel_symbol *ks;
 	struct module *mod;
+	u32 hash;
+
+	/* First check the kernel.  */
+	/* FIXME: Get dynamic symbol table from kernel as well.  */
+	for (ks = __start___ksymtab; ks < __stop___ksymtab; ks++)
+		if (strcmp(name, ks->name) == 0) {
+			*pmod = NULL;
+			return (void *)ks->value;
+		}
 
+	/* Next, try the dynamic symbol tables of the modules.  */
+
+	hash = elf_hash (name);
 	list_for_each_entry(mod, &modules, list) {
-		if (strcmp(mod->name, name) == 0)
-			return mod;
+		const Elf_Symndx *buckets, *chain, *dt_hash;
+		Elf_Symndx nbuckets, nchain, symidx;
+		const ElfW(Sym) *symtab, *sym;
+		const char *strtab;
+
+		dt_hash = mod->dt_hash;
+		if (!dt_hash)
+			continue;
+		nbuckets = dt_hash[0];
+		nchain = dt_hash[1];
+		buckets = dt_hash + 2;
+		chain = dt_hash + 2 + nbuckets;
+
+		symtab = mod->dt_symtab;
+		strtab = mod->dt_strtab;
+
+		for (symidx = buckets[hash % nbuckets];
+		     symidx != 0;
+		     symidx = chain[symidx]) {
+			sym = &symtab[symidx];
+
+			if (sym->st_shndx == SHN_UNDEF)
+				continue;
+			if (strcmp(name, strtab + sym->st_name) == 0) {
+				*pmod = mod;
+				return sym->st_value + mod->loadaddr;
+			}
+		}
 	}
+
 	return NULL;
 }
 
@@ -350,7 +391,8 @@
 {
 	struct module *mod;
 	char name[MODULE_NAME_LEN];
-	int ret, forced = 0;
+	void (*exit)(void);
+	int ret, forced = 0, i;
 
 	if (!capable(CAP_SYS_MODULE))
 		return -EPERM;
@@ -383,7 +425,16 @@
 		goto out;
 	}
 
-	if (!mod->exit || mod->unsafe) {
+	/* Scan for a DT_FINI entry.  */
+	exit = NULL;
+	for (i = 0; mod->dynamic[i].d_tag != DT_NULL; ++i)
+		if (mod->dynamic[i].d_tag == DT_FINI) {
+			exit = mod->loadaddr + mod->dynamic[i].d_un.d_ptr;
+			exit = adjust_initfini_address(mod, exit);
+			break;
+		}
+
+	if (!exit || mod->unsafe) {
 		forced = try_force(flags);
 		if (!forced) {
 			/* This module can't be removed */
@@ -430,8 +481,8 @@
 
  destroy:
 	/* Final destruction now noone is using it. */
-	if (mod->exit)
-		mod->exit();
+	if (exit)
+		exit();
 	free_module(mod);
 
  out:
@@ -442,6 +493,7 @@
 static void print_unload_info(struct seq_file *m, struct module *mod)
 {
 	struct module_use *use;
+	int has_exit, i;
 
 	seq_printf(m, " %u", module_refcount(mod));
 
@@ -451,7 +503,15 @@
 	if (mod->unsafe)
 		seq_printf(m, " [unsafe]");
 
-	if (!mod->exit)
+	/* Scan for a DT_FINI entry.  */
+	has_exit = 0;
+	for (i = 0; mod->dynamic[i].d_tag != DT_NULL; ++i)
+		if (mod->dynamic[i].d_tag == DT_FINI) {
+			has_exit = 1;
+			break;
+		}
+
+	if (!has_exit)
 		seq_printf(m, " [permanent]");
 
 	seq_printf(m, "\n");
@@ -459,29 +519,47 @@
 
 void __symbol_put(const char *symbol)
 {
-	struct kernel_symbol_group *ksg;
+	struct module *mod;
 	unsigned long flags;
 
 	spin_lock_irqsave(&modlist_lock, flags);
-	if (!__find_symbol(symbol, &ksg))
+	if (!__find_symbol(symbol, &mod))
 		BUG();
-	module_put(ksg->owner);
+	module_put(mod);
 	spin_unlock_irqrestore(&modlist_lock, flags);
 }
 EXPORT_SYMBOL(__symbol_put);
 
 void symbol_put_addr(void *addr)
 {
-	struct kernel_symbol_group *ks;
+	struct module *mod;
 	unsigned long flags;
 
 	spin_lock_irqsave(&modlist_lock, flags);
-	list_for_each_entry(ks, &symbols, list) {
- 		unsigned int i;
+	list_for_each_entry(mod, &modules, list) {
+		const Elf_Symndx *buckets, *dt_hash;
+		Elf_Symndx nbuckets, nchain, symidx, i;
+		const ElfW(Sym) *symtab, *sym;
 
-		for (i = 0; i < ks->num_syms; i++) {
-			if (ks->syms[i].value == (unsigned long)addr) {
-				module_put(ks->owner);
+		dt_hash = mod->dt_hash;
+		if (!dt_hash)
+			continue;
+		nbuckets = dt_hash[0];
+		nchain = dt_hash[1];
+		buckets = dt_hash + 2;
+
+		symtab = mod->dt_symtab;
+
+		for (i = 0; i < nbuckets + nchain; ++i) {
+			symidx = buckets[i];
+			if (symidx == 0)
+				continue;
+
+			sym = &symtab[symidx];
+			if (sym->st_shndx == SHN_UNDEF)
+				continue;
+			if (addr == sym->st_value + mod->loadaddr) {
+				module_put(mod);
 				spin_unlock_irqrestore(&modlist_lock, flags);
 				return;
 			}
@@ -519,600 +597,399 @@
 
 #endif /* CONFIG_MODULE_UNLOAD */
 
-/* Find an symbol for this module (ie. resolve internals first).
-   It we find one, record usage.  Must be holding module_mutex. */
-unsigned long find_symbol_internal(Elf_Shdr *sechdrs,
-				   unsigned int symindex,
-				   const char *strtab,
-				   const char *name,
-				   struct module *mod,
-				   struct kernel_symbol_group **ksg)
-{
-	unsigned long ret;
-
-	ret = find_local_symbol(sechdrs, symindex, strtab, name);
-	if (ret) {
-		*ksg = NULL;
-		return ret;
-	}
-	/* Look in other modules... */
-	spin_lock_irq(&modlist_lock);
-	ret = __find_symbol(name, ksg);
-	if (ret) {
-		/* This can fail due to OOM, or module unloading */
-		if (!use_module(mod, (*ksg)->owner))
-			ret = 0;
-	}
-	spin_unlock_irq(&modlist_lock);
-	return ret;
-}
-
 /* Free a module, remove from lists, etc (must hold module mutex). */
 static void free_module(struct module *mod)
 {
 	/* Delete from various lists */
 	list_del(&mod->list);
 	spin_lock_irq(&modlist_lock);
-	list_del(&mod->symbols.list);
-	list_del(&mod->extable.list);
 	spin_unlock_irq(&modlist_lock);
 
 	/* These may be NULL, but that's OK */
-	module_free(mod, mod->module_init);
-	module_free(mod, mod->module_core);
+	module_free(mod->core);
 
 	/* Module unload stuff */
 	module_unload_free(mod);
 
 	/* Finally, free the module structure */
-	module_free(mod, mod);
+	module_free(mod);
 }
 
 void *__symbol_get(const char *symbol)
 {
-	struct kernel_symbol_group *ksg;
-	unsigned long value, flags;
+	struct module *mod;
+	unsigned long flags;
+	void *value;
 
 	spin_lock_irqsave(&modlist_lock, flags);
-	value = __find_symbol(symbol, &ksg);
-	if (value && !try_module_get(ksg->owner))
-		value = 0;
+	value = __find_symbol(symbol, &mod);
+	if (value && mod && !try_module_get(mod))
+		value = NULL;
 	spin_unlock_irqrestore(&modlist_lock, flags);
 
-	return (void *)value;
+	return value;
 }
 EXPORT_SYMBOL_GPL(__symbol_get);
 
-/* Transfer one ELF section to the correct (init or core) area. */
-static void *copy_section(const char *name,
-			  void *base,
-			  Elf_Shdr *sechdr,
-			  struct module *mod,
-			  struct sizes *used)
-{
-	void *dest;
-	unsigned long *use;
-	unsigned long max;
-
-	/* Only copy to init section if there is one */
-	if (strstr(name, ".init") && mod->module_init) {
-		dest = mod->module_init;
-		use = &used->init_size;
-		max = mod->init_size;
-	} else {
-		dest = mod->module_core;
-		use = &used->core_size;
-		max = mod->core_size;
-	}
-
-	/* Align up */
-	*use = ALIGN(*use, sechdr->sh_addralign);
-	dest += *use;
-	*use += sechdr->sh_size;
-
-	if (*use > max)
-		return ERR_PTR(-ENOEXEC);
-
-	/* May not actually be in the file (eg. bss). */
-	if (sechdr->sh_type != SHT_NOBITS)
-		memcpy(dest, base + sechdr->sh_offset, sechdr->sh_size);
-
-	return dest;
-}
+/* Returns the address of dynamic symbol SYMNUM, and NULL on failure.  */
+/* ??? Doesn't handle weak symbols, and in particular, undef weak.  */
 
-/* Look for the special symbols */
-static int grab_private_symbols(Elf_Shdr *sechdrs,
-				unsigned int symbolsec,
-				const char *strtab,
-				struct module *mod)
+void *
+resolve_symbol(struct module *mod, Elf_Symndx symnum)
 {
-	Elf_Sym *sym = (void *)sechdrs[symbolsec].sh_offset;
-	unsigned int i;
-
-	for (i = 1; i < sechdrs[symbolsec].sh_size/sizeof(*sym); i++) {
-		if (strcmp("__initfn", strtab + sym[i].st_name) == 0)
-			mod->init = (void *)sym[i].st_value;
-#ifdef CONFIG_MODULE_UNLOAD
-		if (strcmp("__exitfn", strtab + sym[i].st_name) == 0)
-			mod->exit = (void *)sym[i].st_value;
-#endif
-	}
+	const ElfW(Sym) *sym = mod->dt_symtab + symnum;
+	struct module *def_mod;
+	const char *symbol;
+	void *value;
 
-	return 0;
-}
+	/* If the symbol is defined, nothing to do.  */
+	if (sym->st_shndx != SHN_UNDEF)
+		return sym->st_value + mod->loadaddr;
 
-/* Deal with the given section */
-static int handle_section(const char *name,
-			  Elf_Shdr *sechdrs,
-			  unsigned int strindex,
-			  unsigned int symindex,
-			  unsigned int i,
-			  struct module *mod)
-{
-	int ret;
-	const char *strtab = (char *)sechdrs[strindex].sh_offset;
+	symbol = mod->dt_strtab + sym->st_name;
 
-	switch (sechdrs[i].sh_type) {
-	case SHT_REL:
-		ret = apply_relocate(sechdrs, strtab, symindex, i, mod);
-		break;
-	case SHT_RELA:
-		ret = apply_relocate_add(sechdrs, strtab, symindex, i, mod);
-		break;
-	case SHT_SYMTAB:
-		ret = grab_private_symbols(sechdrs, i, strtab, mod);
-		break;
-	default:
-		DEBUGP("Ignoring section %u: %s\n", i,
-		       sechdrs[i].sh_type==SHT_NULL ? "NULL":
-		       sechdrs[i].sh_type==SHT_PROGBITS ? "PROGBITS":
-		       sechdrs[i].sh_type==SHT_SYMTAB ? "SYMTAB":
-		       sechdrs[i].sh_type==SHT_STRTAB ? "STRTAB":
-		       sechdrs[i].sh_type==SHT_RELA ? "RELA":
-		       sechdrs[i].sh_type==SHT_HASH ? "HASH":
-		       sechdrs[i].sh_type==SHT_DYNAMIC ? "DYNAMIC":
-		       sechdrs[i].sh_type==SHT_NOTE ? "NOTE":
-		       sechdrs[i].sh_type==SHT_NOBITS ? "NOBITS":
-		       sechdrs[i].sh_type==SHT_REL ? "REL":
-		       sechdrs[i].sh_type==SHT_SHLIB ? "SHLIB":
-		       sechdrs[i].sh_type==SHT_DYNSYM ? "DYNSYM":
-		       sechdrs[i].sh_type==SHT_NUM ? "NUM":
-		       "UNKNOWN");
-		ret = 0;
-	}
-	return ret;
-}
+	/* The symbol __this_module is special.  */
+	if (strcmp(symbol, "__this_module") == 0)
+		return mod;
 
-/* Figure out total size desired for the common vars */
-static unsigned long read_commons(void *start, Elf_Shdr *sechdr)
-{
-	unsigned long size, i, max_align;
-	Elf_Sym *sym;
-	
-	size = max_align = 0;
-
-	for (sym = start + sechdr->sh_offset, i = 0;
-	     i < sechdr->sh_size / sizeof(Elf_Sym);
-	     i++) {
-		if (sym[i].st_shndx == SHN_COMMON) {
-			/* Value encodes alignment. */
-			if (sym[i].st_value > max_align)
-				max_align = sym[i].st_value;
-			/* Pad to required alignment */
-			size = ALIGN(size, sym[i].st_value) + sym[i].st_size;
-		}
+	/* Otherwise we search other modules.  */
+	spin_lock_irq(&modlist_lock);
+	value = __find_symbol(symbol, &def_mod);
+	if (value) {
+		/* This can fail due to OOM, or module unloading.  */
+		if (!use_module(mod, def_mod))
+			value = NULL;
+	}
+	if (!value) {
+		printk(KERN_WARNING "%s: Unknown symbol %s\n",
+		       mod->name, symbol);
 	}
+	spin_unlock_irq(&modlist_lock);
 
-	/* Now, add in max alignment requirement (with align
-	   attribute, this could be large), so we know we have space
-	   whatever the start alignment is */
-	return size + max_align;
+	return value;
 }
 
-/* Change all symbols so that sh_value encodes the pointer directly. */
-static void simplify_symbols(Elf_Shdr *sechdrs,
-			     unsigned int symindex,
-			     unsigned int strindex,
-			     void *common,
-			     struct module *mod)
+/* Load and relocate the module.  */
+
+static int
+load_module(struct module *mod, void *umod, size_t umodlen)
 {
-	unsigned int i;
-	Elf_Sym *sym;
+	ElfW(Ehdr) *ehdr;
+	const ElfW(Phdr) *phdrs;
+	const ElfW(Shdr) *shdrs;
+	const char *shstrtab;
+	long err, core_size;
+	ElfW(Addr) min_addr, max_addr, dynamic_offset;
+	unsigned long i;
+	void *core, *loadaddr;
+	const ElfW(Dyn) *dynamic;
+	const void *dt_rela, *dt_rel, *dt_jmprel;
+	unsigned long dt_relasz, dt_relsz, dt_pltrelsz, dt_pltrel;
+
+	DEBUGP("load_module: umod=%p, len=%lu\n", umod, umodlen);
+	if (umodlen < sizeof(*ehdr))
+		return -ENOEXEC;
+
+	/* vmalloc barfs on "unusual" numbers.  Check here.  */
+	if (umodlen > 64 * 1024 * 1024 || (ehdr = vmalloc(umodlen)) == NULL)
+		return -ENOMEM;
+
+	/* Suck in entire file: we'll want most of it.  */
+	err = -EFAULT;
+	if (copy_from_user(ehdr, umod, umodlen) != 0)
+		goto free_file;
 
-	/* First simplify defined symbols, so if they become the
-           "answer" to undefined symbols, copying their st_value us
-           correct. */
-	for (sym = (void *)sechdrs[symindex].sh_offset, i = 0;
-	     i < sechdrs[symindex].sh_size / sizeof(Elf_Sym);
-	     i++) {
-		switch (sym[i].st_shndx) {
-		case SHN_COMMON:
-			/* Value encodes alignment. */
-			common = (void *)ALIGN((unsigned long)common,
-					       sym[i].st_value);
-			/* Change it to encode pointer */
-			sym[i].st_value = (unsigned long)common;
-			common += sym[i].st_size;
+	/* Sanity checks against insmoding binaries or wrong arch,
+	   or weird elf version.  */
+	err = -ENOEXEC;
+	if (memcmp(ehdr->e_ident, ELFMAG, 4) != 0
+	    || ehdr->e_type != ET_DYN
+	    || !elf_check_arch(ehdr)
+	    || ehdr->e_phentsize != sizeof(*phdrs)) {
+		DEBUGP("load_module: invalid magic.\n");
+		goto free_file;
+	}
+
+	phdrs = (void *)ehdr + ehdr->e_phoff;
+
+	/* Scan the program headers for the loadable segments, as well
+	   as locate the dynamic linking information.  */
+	min_addr = ~0UL;
+	max_addr = 0;
+	dynamic_offset = ~0UL;
+	for (i = 0; i < ehdr->e_phnum; ++i) {
+		if (phdrs[i].p_type == PT_LOAD) {
+			if (min_addr > phdrs[i].p_vaddr)
+				min_addr = phdrs[i].p_vaddr;
+			if (max_addr < phdrs[i].p_vaddr + phdrs[i].p_memsz)
+				max_addr = phdrs[i].p_vaddr + phdrs[i].p_memsz;
+		} else if (phdrs[i].p_type == PT_DYNAMIC)
+			dynamic_offset = phdrs[i].p_vaddr;
+	}
+
+	/* Can't continue if no loadable segments or no dynamic info.  */
+	if (min_addr == ~0UL || dynamic_offset == ~0UL) {
+		if (min_addr == ~0UL)
+			DEBUGP("load_module: no loadable segments.\n");
+		if (dynamic_offset == ~0UL)
+			DEBUGP("load_module: no dynamic segment.\n");
+		goto free_file;
+	}
+
+	/* Allow the architecture to allocate extra space.  E.g. non-pic jump
+	   tables might go here.  */
+	err = core_size = module_core_size(ehdr, mod, min_addr, max_addr);
+	if (core_size < 0) {
+		DEBUGP("load_module: module_core_size failed\n");
+		goto free_file;
+	}
+
+	/* Allocate the memory that the module data will occupy.  */
+	core = module_alloc (core_size);
+	err = -ENOMEM;
+	if (!core)
+		goto free_file;
+	loadaddr = core - min_addr;
+	DEBUGP("load_module: %s loadaddr %p\n", mod->name, loadaddr);
+
+	/* Install the segments from the file into the memory.  */
+	for (i = 0; i < ehdr->e_phnum; ++i)
+		if (phdrs[i].p_type == PT_LOAD) {
+			void *segstart = loadaddr + phdrs[i].p_vaddr;
+			memcpy(segstart, (void *)ehdr + phdrs[i].p_offset,
+			       phdrs[i].p_filesz);
+			if (phdrs[i].p_filesz < phdrs[i].p_memsz)
+				memset(segstart + phdrs[i].p_filesz, 0,
+				       phdrs[i].p_memsz - phdrs[i].p_filesz);
+		}
+
+	/* Populate the module struct with load addresses.  */
+	mod->core = core;
+	mod->core_size = core_size;
+	mod->loadaddr = loadaddr;
+	mod->dynamic = dynamic = loadaddr + dynamic_offset;
+
+	/* Scan the DYNAMIC segment for interesting data.  */
+	err = -ENOEXEC;
+	dt_rela = dt_rel = dt_jmprel = NULL;
+	dt_relasz = dt_relsz = dt_pltrelsz = dt_pltrel = 0;
+	for (i = 0; dynamic[i].d_tag != DT_NULL; ++i) {
+		void *addr = loadaddr + dynamic[i].d_un.d_ptr;
+		switch (dynamic[i].d_tag) {
+		case DT_HASH:	mod->dt_hash = addr;			break;
+		case DT_STRTAB: mod->dt_strtab = addr;			break;
+		case DT_STRSZ:	/* Store it?  */			break;
+		case DT_SYMTAB: mod->dt_symtab = addr;			break;
+		case DT_SYMENT:
+			if (dynamic[i].d_un.d_val != sizeof(ElfW(Sym))) {
+				DEBUGP("load_module: DT_SYMENT mismatch.\n");
+				goto free_mod;
+			}
 			break;
 
-		case SHN_ABS:
-			/* Don't need to do anything */
-			DEBUGP("Absolute symbol: 0x%08lx\n",
-			       (long)sym[i].st_value);
+		case DT_RELA:	dt_rela = addr;				break;
+		case DT_RELASZ:	dt_relasz = dynamic[i].d_un.d_val;	break;
+		case DT_RELAENT:
+			if (dynamic[i].d_un.d_val != sizeof(ElfW(Rela))) {
+				DEBUGP("load_module: DT_RELAENT mismatch.\n");
+				goto free_mod;
+			}
 			break;
 
-		case SHN_UNDEF:
+		case DT_REL:	dt_rel = addr;				break;
+		case DT_RELSZ:	dt_relsz = dynamic[i].d_un.d_val;	break;
+		case DT_RELENT:
+			if (dynamic[i].d_un.d_val != sizeof(ElfW(Rel))) {
+				DEBUGP("load_module: DT_RELENT mismatch.\n");
+				goto free_mod;
+			}
 			break;
 
-		default:
-			sym[i].st_value 
-				= (unsigned long)
-				(sechdrs[sym[i].st_shndx].sh_offset
-				 + sym[i].st_value);
-		}
-	}
-
-	/* Now try to resolve undefined symbols */
-	for (sym = (void *)sechdrs[symindex].sh_offset, i = 0;
-	     i < sechdrs[symindex].sh_size / sizeof(Elf_Sym);
-	     i++) {
-		if (sym[i].st_shndx == SHN_UNDEF) {
-			/* Look for symbol */
-			struct kernel_symbol_group *ksg = NULL;
-			const char *strtab 
-				= (char *)sechdrs[strindex].sh_offset;
-
-			sym[i].st_value
-				= find_symbol_internal(sechdrs,
-						       symindex,
-						       strtab,
-						       strtab + sym[i].st_name,
-						       mod,
-						       &ksg);
-			/* We fake up "__this_module" */
-			if (strcmp(strtab+sym[i].st_name, "__this_module")==0)
-				sym[i].st_value = (unsigned long)mod;
+		case DT_PLTREL:	dt_pltrel = dynamic[i].d_un.d_val;	break;
+		case DT_JMPREL:	dt_jmprel = addr;			break;
+		case DT_PLTRELSZ: dt_pltrelsz = dynamic[i].d_un.d_val;	break;
 		}
 	}
-}
 
-/* Get the total allocation size of the init and non-init sections */
-static struct sizes get_sizes(const Elf_Ehdr *hdr,
-			      const Elf_Shdr *sechdrs,
-			      const char *secstrings,
-			      unsigned long common_length)
-{
-	struct sizes ret = { 0, common_length };
-	unsigned i;
-
-	/* Everything marked ALLOC (this includes the exported
-           symbols) */
-	for (i = 1; i < hdr->e_shnum; i++) {
-		unsigned long *add;
-
-		/* If it's called *.init*, and we're init, we're interested */
-		if (strstr(secstrings + sechdrs[i].sh_name, ".init") != 0)
-			add = &ret.init_size;
-		else
-			add = &ret.core_size;
+	/* On some machines, DT_JMPREL is included within the DT_REL* range.
+	   Since we're not doing lazy binding, notice this and zap the pltrel
+	   sub-range.  Only bother cheking for perfect overlap.  */
+	if (dt_pltrel) {
+		const void *rel = (dt_pltrel == DT_REL ? dt_rel : dt_rela);
+		size_t sz = (dt_pltrel == DT_REL ? dt_relsz : dt_relasz);
 
-		if (sechdrs[i].sh_flags & SHF_ALLOC) {
-			/* Pad up to required alignment */
-			*add = ALIGN(*add, sechdrs[i].sh_addralign ?: 1);
-			*add += sechdrs[i].sh_size;
-		}
+		if (dt_jmprel >= rel && dt_jmprel+dt_pltrelsz <= rel+sz)
+			dt_pltrel = 0;
 	}
 
-	return ret;
-}
-
-/* Allocate and load the module */
-static struct module *load_module(void *umod,
-				  unsigned long len,
-				  const char *uargs)
-{
-	Elf_Ehdr *hdr;
-	Elf_Shdr *sechdrs;
-	char *secstrings;
-	unsigned int i, symindex, exportindex, strindex, setupindex, exindex,
-		modnameindex;
-	long arglen;
-	unsigned long common_length;
-	struct sizes sizes, used;
-	struct module *mod;
-	long err = 0;
-	void *ptr = NULL; /* Stops spurious gcc uninitialized warning */
-
-	DEBUGP("load_module: umod=%p, len=%lu, uargs=%p\n",
-	       umod, len, uargs);
-	if (len < sizeof(*hdr))
-		return ERR_PTR(-ENOEXEC);
-
-	/* Suck in entire file: we'll want most of it. */
-	/* vmalloc barfs on "unusual" numbers.  Check here */
-	if (len > 64 * 1024 * 1024 || (hdr = vmalloc(len)) == NULL)
-		return ERR_PTR(-ENOMEM);
-	if (copy_from_user(hdr, umod, len) != 0) {
-		err = -EFAULT;
-		goto free_hdr;
+	/* Relocate the module.  */
+	if (dt_rel) {
+		err = apply_relocate(dt_rel, dt_relsz/sizeof(ElfW(Rel)), mod);
+		if (err) {
+			DEBUGP("load_module: apply_relocate failed.\n");
+			goto free_mod;
+		}
 	}
-
-	/* Sanity checks against insmoding binaries or wrong arch,
-           weird elf version */
-	if (memcmp(hdr->e_ident, ELFMAG, 4) != 0
-	    || hdr->e_type != ET_REL
-	    || !elf_check_arch(hdr)
-	    || hdr->e_shentsize != sizeof(*sechdrs)) {
-		err = -ENOEXEC;
-		goto free_hdr;
-	}
-
-	/* Convenience variables */
-	sechdrs = (void *)hdr + hdr->e_shoff;
-	secstrings = (void *)hdr + sechdrs[hdr->e_shstrndx].sh_offset;
-
-	/* May not export symbols, or have setup params, so these may
-           not exist */
-	exportindex = setupindex = 0;
-
-	/* And these should exist, but gcc whinges if we don't init them */
-	symindex = strindex = exindex = modnameindex = 0;
-
-	/* Find where important sections are */
-	for (i = 1; i < hdr->e_shnum; i++) {
-		if (sechdrs[i].sh_type == SHT_SYMTAB) {
-			/* Internal symbols */
-			DEBUGP("Symbol table in section %u\n", i);
-			symindex = i;
-		} else if (strcmp(secstrings+sechdrs[i].sh_name, ".modulename")
-			   == 0) {
-			/* This module's name */
-			DEBUGP("Module name in section %u\n", i);
-			modnameindex = i;
-		} else if (strcmp(secstrings+sechdrs[i].sh_name, "__ksymtab")
-			   == 0) {
-			/* Exported symbols. */
-			DEBUGP("EXPORT table in section %u\n", i);
-			exportindex = i;
-		} else if (strcmp(secstrings + sechdrs[i].sh_name, ".strtab")
-			   == 0) {
-			/* Strings */
-			DEBUGP("String table found in section %u\n", i);
-			strindex = i;
-		} else if (strcmp(secstrings+sechdrs[i].sh_name, ".setup.init")
-			   == 0) {
-			/* Setup parameter info */
-			DEBUGP("Setup table found in section %u\n", i);
-			setupindex = i;
-		} else if (strcmp(secstrings+sechdrs[i].sh_name, "__ex_table")
-			   == 0) {
-			/* Exception table */
-			DEBUGP("Exception table found in section %u\n", i);
-			exindex = i;
+	if (dt_rela) {
+		err = apply_relocate_add(dt_rela,
+					 dt_relasz/sizeof(ElfW(Rela)), mod);
+		if (err) {
+			DEBUGP("load_module: apply_relocate_add failed.\n");
+			goto free_mod;
 		}
-#ifdef CONFIG_KALLSYMS
-		/* symbol and string tables for decoding later. */
-		if (sechdrs[i].sh_type == SHT_SYMTAB || i == hdr->e_shstrndx)
-			sechdrs[i].sh_flags |= SHF_ALLOC;
-#endif
-#ifndef CONFIG_MODULE_UNLOAD
-		/* Don't load .exit sections */
-		if (strstr(secstrings+sechdrs[i].sh_name, ".exit"))
-			sechdrs[i].sh_flags &= ~(unsigned long)SHF_ALLOC;
-#endif
 	}
-
-	if (!modnameindex) {
-		DEBUGP("Module has no name!\n");
-		err = -ENOEXEC;
-		goto free_hdr;
+	if (dt_pltrel == DT_REL) {
+		err = apply_relocate(dt_jmprel,
+				     dt_pltrelsz/sizeof(ElfW(Rel)), mod);
+		if (err) {
+			DEBUGP("load_module: apply_relocate failed.\n");
+			goto free_mod;
+		}
+	} else if (dt_pltrel == DT_RELA) {
+		err = apply_relocate_add(dt_jmprel,
+					 dt_pltrelsz/sizeof(ElfW(Rela)), mod);
+		if (err) {
+			DEBUGP("load_module: apply_relocate_add failed.\n");
+			goto free_mod;
+		}
 	}
 
-	/* Now allocate space for the module proper, and copy name and args. */
-	err = strlen_user(uargs);
-	if (err < 0)
-		goto free_hdr;
-	arglen = err;
+	/* Scan the section headers for special sections.  */
+	shdrs = (void *)ehdr + ehdr->e_shoff;
+	shstrtab = (void *)ehdr + shdrs[ehdr->e_shstrndx].sh_offset;
+	for (i = 0; i < ehdr->e_shnum; ++i) {
+		const char *secname = shstrtab + shdrs[i].sh_name;
 
-	mod = module_alloc(sizeof(*mod) + arglen+1);
-	if (!mod) {
-		err = -ENOMEM;
-		goto free_hdr;
-	}
-	memset(mod, 0, sizeof(*mod) + arglen+1);
-	if (copy_from_user(mod->args, uargs, arglen) != 0) {
-		err = -EFAULT;
-		goto free_mod;
+		if (strcmp (secname, "__ex_table") == 0) {
+			mod->extable.entry = loadaddr + shdrs[i].sh_addr;
+			mod->extable.num_entries
+			  = shdrs[i].sh_size / sizeof(struct exception_table_entry);
+		}
 	}
-	strncpy(mod->name, (char *)hdr + sechdrs[modnameindex].sh_offset,
-		sizeof(mod->name)-1);
 
-	if (find_module(mod->name)) {
-		err = -EEXIST;
+	/* Allow the architecture to finish up unfinished business.  */
+	err = module_finalize(ehdr, mod);
+	if (err < 0) {
+		DEBUGP("load_module: module_finalize failed.\n");
 		goto free_mod;
 	}
 
-	/* Initialize the lists, since they will be list_del'd if init fails */
-	INIT_LIST_HEAD(&mod->extable.list);
-	INIT_LIST_HEAD(&mod->list);
-	INIT_LIST_HEAD(&mod->symbols.list);
-	mod->symbols.owner = mod;
-	mod->live = 0;
-	module_unload_init(mod);
+	/* Flush the kernel Icache, since we've modified instructions.  */
+	flush_icache_range(core, core + coresz);
 
-	/* How much space will we need?  (Common area in first) */
-	common_length = read_commons(hdr, &sechdrs[symindex]);
-	sizes = get_sizes(hdr, sechdrs, secstrings, common_length);
-
-	/* Set these up, and allow archs to manipulate them. */
-	mod->core_size = sizes.core_size;
-	mod->init_size = sizes.init_size;
-
-	/* Allow archs to add to them. */
-	err = module_init_size(hdr, sechdrs, secstrings, mod);
-	if (err < 0)
-		goto free_mod;
-	mod->init_size = err;
+	/* Success.  Clean up.  */
+	vfree(ehdr);
+	return 0;
 
-	err = module_core_size(hdr, sechdrs, secstrings, mod);
-	if (err < 0)
-		goto free_mod;
-	mod->core_size = err;
+ free_mod:
+	module_free(core);
+ free_file:
+	vfree(ehdr);
+	return err;
+}
+
+/* Allocate the module structure.  Done with module_alloc so that the
+   __this_module symbol that maps the current module is "near" the
+   module code.  */
+/* ??? The suggestion was made to allocate the module struct contiguous
+   with the code.  This does not appear to be necessary for either sparc64
+   or x86-64 (which do have alloc arena restrictions), and would simply
+   complicate the code.  */
 
-	/* Do the allocs. */
-	ptr = module_alloc(mod->core_size);
-	if (!ptr) {
-		err = -ENOMEM;
-		goto free_mod;
-	}
-	memset(ptr, 0, mod->core_size);
-	mod->module_core = ptr;
+static struct module *
+alloc_module_struct (const char *uargs)
+{
+	long argslen = strlen_user(uargs);
+	struct module *mod;
 
-	ptr = module_alloc(mod->init_size);
-	if (!ptr && mod->init_size) {
-		err = -ENOMEM;
-		goto free_core;
-	}
-	memset(ptr, 0, mod->init_size);
-	mod->module_init = ptr;
-
-	/* Transfer each section which requires ALLOC, and set sh_offset
-	   fields to absolute addresses. */
-	used.core_size = common_length;
-	used.init_size = 0;
-	for (i = 1; i < hdr->e_shnum; i++) {
-		if (sechdrs[i].sh_flags & SHF_ALLOC) {
-			ptr = copy_section(secstrings + sechdrs[i].sh_name,
-					   hdr, &sechdrs[i], mod, &used);
-			if (IS_ERR(ptr))
-				goto cleanup;
-			sechdrs[i].sh_offset = (unsigned long)ptr;
-		} else {
-			sechdrs[i].sh_offset += (unsigned long)hdr;
-		}
-	}
-	/* Don't use more than we allocated! */
-	if (used.init_size > mod->init_size || used.core_size > mod->core_size)
-		BUG();
+	if (argslen < 0)
+		return ERR_PTR(argslen);
 
-	/* Fix up syms, so that st_value is a pointer to location. */
-	simplify_symbols(sechdrs, symindex, strindex, mod->module_core, mod);
+	mod = module_alloc(sizeof(*mod) + argslen + 1);
+	if (!mod)
+		return ERR_PTR(-ENOMEM);
 
-	/* Set up EXPORTed symbols */
-	if (exportindex) {
-		mod->symbols.num_syms = (sechdrs[exportindex].sh_size
-					/ sizeof(*mod->symbols.syms));
-		mod->symbols.syms = (void *)sechdrs[exportindex].sh_offset;
-	}
-
-	/* Set up exception table */
-	if (exindex) {
-		/* FIXME: Sort exception table. */
-		mod->extable.num_entries = (sechdrs[exindex].sh_size
-					    / sizeof(struct
-						     exception_table_entry));
-		mod->extable.entry = (void *)sechdrs[exindex].sh_offset;
-	}
-
-	/* Now handle each section. */
-	for (i = 1; i < hdr->e_shnum; i++) {
-		err = handle_section(secstrings + sechdrs[i].sh_name,
-				     sechdrs, strindex, symindex, i, mod);
-		if (err < 0)
-			goto cleanup;
-	}
-
-#ifdef CONFIG_KALLSYMS
-	mod->symtab = (void *)sechdrs[symindex].sh_offset;
-	mod->num_syms = sechdrs[symindex].sh_size / sizeof(Elf_Sym);
-	mod->strtab = (void *)sechdrs[strindex].sh_offset;
-#endif
-	err = module_finalize(hdr, sechdrs, mod);
-	if (err < 0)
-		goto cleanup;
-
-#if 0 /* Needs param support */
-	/* Size of section 0 is 0, so this works well */
-	err = parse_args(mod->args,
-			 (struct kernel_param *)
-			 sechdrs[setupindex].sh_offset,
-			 sechdrs[setupindex].sh_size
-			 / sizeof(struct kernel_param),
-			 NULL);
-	if (err < 0)
-		goto cleanup;
-#endif
+	memset(mod, 0, sizeof (*mod));
 
-	/* Get rid of temporary copy */
-	vfree(hdr);
+	if (copy_from_user(mod->args, uargs, argslen) != 0) {
+		module_free(mod);
+		return ERR_PTR(-EFAULT);
+	}
 
-	/* Done! */
 	return mod;
-
- cleanup:
-	module_unload_free(mod);
-	module_free(mod, mod->module_init);
- free_core:
-	module_free(mod, mod->module_core);
- free_mod:
-	module_free(mod, mod);
- free_hdr:
-	vfree(hdr);
-	if (err < 0) return ERR_PTR(err);
-	else return ptr;
 }
 
-/* This is where the real work happens */
+/* This is where the real work happens.  */
 asmlinkage long
-sys_init_module(void *umod,
-		unsigned long len,
-		const char *uargs)
+sys_init_module(const char *umodname, void *umod, size_t len, const char *uargs)
 {
 	struct module *mod;
+	unsigned long i;
 	int ret;
 
-	/* Must have permission */
+	/* Must have permission.  */
 	if (!capable(CAP_SYS_MODULE))
 		return -EPERM;
 
-	/* Only one module load at a time, please */
+	/* Only one module load at a time, please.  */
 	if (down_interruptible(&module_mutex) != 0)
 		return -EINTR;
 
-	/* Do all the hard work */
-	mod = load_module(umod, len, uargs);
-	if (IS_ERR(mod)) {
-		up(&module_mutex);
-		return PTR_ERR(mod);
-	}
+	/* Allocate a module struct.  */
+	mod = alloc_module_struct (uargs);
+	ret = PTR_ERR(mod);
+	if (IS_ERR(mod))
+		goto err_up;
+
+	/* Pull in the module name and check it for uniqueness.  */
+	ret = strncpy_from_user(mod->name, umodname, sizeof(mod->name)-1);
+	if (ret < 0)
+		goto err_mod;
+
+	ret = -EEXIST;
+	if (find_module(mod->name))
+		goto err_mod;
+
+	/* Load and relocate.  */
+	ret = load_module(mod, umod, len);
+	if (ret < 0)
+		goto err_mod;
 
-	/* Flush the instruction cache, since we've played with text */
-	if (mod->module_init)
-		flush_icache_range((unsigned long)mod->module_init,
-				   (unsigned long)mod->module_init
-				   + mod->init_size);
-	flush_icache_range((unsigned long)mod->module_core,
-			   (unsigned long)mod->module_core + mod->core_size);
+	/* Initialize the lists, since they will be list_del'd if init fails */
+	INIT_LIST_HEAD(&mod->extable.list);
+	INIT_LIST_HEAD(&mod->list);
+	module_unload_init(mod);
+
+	/* ??? Initialize parameters here.  */
 
-	/* Now sew it into exception list (just in case...). */
+	/* Sew it into exception list now, in case init faults.  */
 	spin_lock_irq(&modlist_lock);
 	list_add(&mod->extable.list, &extables);
 	spin_unlock_irq(&modlist_lock);
 
 	/* Note, setting the mod->live to 1 here is safe because we haven't
-	 * linked the module into the system's kernel symbol table yet,
-	 * which means that the only way any other kernel code can call
-	 * into this module right now is if this module hands out entry
-	 * pointers to the other code.  We assume that no module hands out
-	 * entry pointers to the rest of the kernel unless it is ready to
-	 * have them used.
-	 */
+	   linked the module into the system's kernel symbol table yet,
+	   which means that the only way any other kernel code can call
+	   into this module right now is if this module hands out entry
+	   pointers to the other code.  We assume that no module hands out
+	   entry pointers to the rest of the kernel unless it is ready to
+	   have them used.  */
 	mod->live = 1;
-	/* Start the module */
-	ret = mod->init ? mod->init() : 0;
+
+	/* Scan for a DT_INIT entry.  */
+	ret = 0;
+	for (i = 0; mod->dynamic[i].d_tag != DT_NULL; ++i)
+		if (mod->dynamic[i].d_tag == DT_INIT) {
+			int (*init)(void);
+			init = mod->loadaddr + mod->dynamic[i].d_un.d_ptr;
+			init = adjust_initfini_address(mod, init);
+			ret = init();
+			break;
+		}
+
+	/* If the init routine failed, abort.  */
 	if (ret < 0) {
-		/* Init routine failed: abort.  Try to protect us from
-                   buggy refcounters. */
+		/* Try to protect us from buggy refcounters. */
 		synchronize_kernel();
 		if (mod->unsafe) {
 			printk(KERN_ERR "%s: module is now stuck!\n",
@@ -1128,94 +1005,19 @@
 		return ret;
 	}
 
-	/* Now it's a first class citizen! */
-	spin_lock_irq(&modlist_lock);
-	list_add_tail(&mod->symbols.list, &symbols);
-	spin_unlock_irq(&modlist_lock);
+	/* Now it's a first class citizen!  */
 	list_add(&mod->list, &modules);
 
-	module_free(mod, mod->module_init);
-	mod->module_init = NULL;
-
-	/* All ok! */
+	/* All ok!  */
 	up(&module_mutex);
 	return 0;
-}
-
-#ifdef CONFIG_KALLSYMS
-static inline int inside_init(struct module *mod, unsigned long addr)
-{
-	if (mod->module_init
-	    && (unsigned long)mod->module_init <= addr
-	    && (unsigned long)mod->module_init + mod->init_size > addr)
-		return 1;
-	return 0;
-}
-
-static inline int inside_core(struct module *mod, unsigned long addr)
-{
-	if ((unsigned long)mod->module_core <= addr
-	    && (unsigned long)mod->module_core + mod->core_size > addr)
-		return 1;
-	return 0;
-}
 
-static const char *get_ksymbol(struct module *mod,
-			       unsigned long addr,
-			       unsigned long *size,
-			       unsigned long *offset)
-{
-	unsigned int i, next = 0, best = 0;
-
-	/* Scan for closest preceeding symbol, and next symbol. (ELF
-           starts real symbols at 1). */
-	for (i = 1; i < mod->num_syms; i++) {
-		if (mod->symtab[i].st_shndx == SHN_UNDEF)
-			continue;
-
-		if (mod->symtab[i].st_value <= addr
-		    && mod->symtab[i].st_value > mod->symtab[best].st_value)
-			best = i;
-		if (mod->symtab[i].st_value > addr
-		    && mod->symtab[i].st_value < mod->symtab[next].st_value)
-			next = i;
-	}
-
-	if (!best)
-		return NULL;
-
-	if (!next) {
-		/* Last symbol?  It ends at the end of the module then. */
-		if (inside_core(mod, addr))
-			*size = mod->module_core+mod->core_size - (void*)addr;
-		else
-			*size = mod->module_init+mod->init_size - (void*)addr;
-	} else
-		*size = mod->symtab[next].st_value - addr;
-
-	*offset = addr - mod->symtab[best].st_value;
-	return mod->strtab + mod->symtab[best].st_name;
-}
-
-/* For kallsyms to ask for address resolution.  NULL means not found.
-   We don't lock, as this is used for oops resolution and races are a
-   lesser concern. */
-const char *module_address_lookup(unsigned long addr,
-				  unsigned long *size,
-				  unsigned long *offset,
-				  char **modname)
-{
-	struct module *mod;
-
-	list_for_each_entry(mod, &modules, list) {
-		if (inside_core(mod, addr) || inside_init(mod, addr)) {
-			*modname = mod->name;
-			return get_ksymbol(mod, addr, size, offset);
-		}
-	}
-	return NULL;
+ err_mod:
+	module_free(mod);
+ err_up:
+	up(&module_mutex);
+	return ret;
 }
-#endif /* CONFIG_KALLSYMS */
 
 /* Called by the /proc file system to return a list of modules. */
 static void *m_start(struct seq_file *m, loff_t *pos)
@@ -1250,8 +1052,7 @@
 static int m_show(struct seq_file *m, void *p)
 {
 	struct module *mod = list_entry(p, struct module, list);
-	seq_printf(m, "%s %lu",
-		   mod->name, mod->init_size + mod->core_size);
+	seq_printf(m, "%s %lu", mod->name, mod->core_size);
 	print_unload_info(m, mod);
 	return 0;
 }
diff -Nur --exclude=RCS --exclude=CVS --exclude=SCCS --exclude=BitKeeper --exclude=ChangeSet linus-2.5/scripts/Makefile.build mod-2.5/scripts/Makefile.build
--- linus-2.5/scripts/Makefile.build	Sat Nov 23 14:35:55 2002
+++ mod-2.5/scripts/Makefile.build	Fri Nov 22 16:02:34 2002
@@ -44,7 +44,7 @@
 endif
 
 __build: $(if $(KBUILD_BUILTIN),$(O_TARGET) $(L_TARGET) $(EXTRA_TARGETS)) \
-	 $(if $(KBUILD_MODULES),$(obj-m)) \
+	 $(if $(KBUILD_MODULES),$(obj-m:.o=.klm)) \
 	 $(subdir-ym)
 	@:
 
@@ -72,18 +72,6 @@
 $(export-objs:.o=.s)  : export_flags   := $(EXPORT_FLAGS)
 $(export-objs:.o=.lst): export_flags   := $(EXPORT_FLAGS)
 
-# Default for not multi-part modules
-modname = $(*F)
-
-$(multi-objs-m)         : modname = $(modname-multi)
-$(multi-objs-m:.o=.i)   : modname = $(modname-multi)
-$(multi-objs-m:.o=.s)   : modname = $(modname-multi)
-$(multi-objs-m:.o=.lst) : modname = $(modname-multi)
-$(multi-objs-y)         : modname = $(modname-multi)
-$(multi-objs-y:.o=.i)   : modname = $(modname-multi)
-$(multi-objs-y:.o=.s)   : modname = $(modname-multi)
-$(multi-objs-y:.o=.lst) : modname = $(modname-multi)
-
 quiet_cmd_cc_s_c = CC $(quiet_modtag)  $@
 cmd_cc_s_c       = $(CC) $(c_flags) -S -o $@ $< 
 
@@ -186,6 +174,18 @@
 	$(call if_changed,link_multi)
 
 targets += $(multi-used-y) $(multi-used-m)
+
+#
+# Rule to build the .klm shared object from the .o module.
+#
+
+klm_ldflags = -shared --version-exports-section ""
+
+quiet_cmd_ld_klm_o = LD $(quiet_modtag)  $@
+cmd_ld_klm_o = $(LD) $(LDFLAGS) $(EXTRA_LDFLAGS) $(klm_ldflags) -o $@ $<
+
+%.klm: %.o FORCE
+	$(call if_changed,ld_klm_o)
 
 # Compile programs on the host
 # ===========================================================================
diff -Nur --exclude=RCS --exclude=CVS --exclude=SCCS --exclude=BitKeeper --exclude=ChangeSet linus-2.5/scripts/Makefile.clean mod-2.5/scripts/Makefile.clean
--- linus-2.5/scripts/Makefile.clean	Sat Nov 23 14:35:55 2002
+++ mod-2.5/scripts/Makefile.clean	Fri Nov 22 16:02:34 2002
@@ -14,7 +14,7 @@
 
 __subdir-y	:= $(patsubst %/,%,$(filter %/, $(obj-y)))
 subdir-y	+= $(__subdir-y)
-__subdir-m	:= $(patsubst %/,%,$(filter %/, $(obj-m)))
+__subdir-m	:= $(patsubst %/,%,$(filter %/, $(obj-m) $(obj-m:.o=.klm)))
 subdir-m	+= $(__subdir-m)
 __subdir-n	:= $(patsubst %/,%,$(filter %/, $(obj-n)))
 subdir-n	+= $(__subdir-n)
diff -Nur --exclude=RCS --exclude=CVS --exclude=SCCS --exclude=BitKeeper --exclude=ChangeSet linus-2.5/scripts/Makefile.lib mod-2.5/scripts/Makefile.lib
--- linus-2.5/scripts/Makefile.lib	Sat Nov 23 14:35:55 2002
+++ mod-2.5/scripts/Makefile.lib	Fri Nov 22 16:02:34 2002
@@ -118,20 +118,10 @@
 
 # These flags are needed for modversions and compiling, so we define them here
 # already
-# $(modname_flags) #defines KBUILD_MODNAME as the name of the module it will 
-# end up in (or would, if it gets compiled in)
-# Note: It's possible that one object gets potentially linked into more
-#       than one module. In that case KBUILD_MODNAME will be set to foo_bar,
-#       where foo and bar are the name of the modules.
 basename_flags = -DKBUILD_BASENAME=$(subst $(comma),_,$(subst -,_,$(*F)))
-modname_flags  = -DKBUILD_MODNAME=$(subst $(comma),_,$(subst -,_,$(modname)))
 c_flags        = -Wp,-MD,$(depfile) $(CFLAGS) $(NOSTDINC_FLAGS) \
 	         $(modkern_cflags) $(EXTRA_CFLAGS) $(CFLAGS_$(*F).o) \
-	         $(basename_flags) $(modname_flags) $(export_flags) 
-
-# Finds the multi-part object the current object will be linked into
-modname-multi = $(subst $(space),_,$(sort $(foreach m,$(multi-used),\
-		$(if $(filter $(subst $(obj)/,,$*.o), $($(m:.o=-objs)) $($(m:.o=-y))),$(m:.o=)))))
+	         $(basename_flags) $(export_flags) 
 
 # Shipped files
 # ===========================================================================
diff -Nur --exclude=RCS --exclude=CVS --exclude=SCCS --exclude=BitKeeper --exclude=ChangeSet linus-2.5/scripts/Makefile.modinst mod-2.5/scripts/Makefile.modinst
--- linus-2.5/scripts/Makefile.modinst	Sat Nov 23 14:35:55 2002
+++ mod-2.5/scripts/Makefile.modinst	Fri Nov 22 16:02:34 2002
@@ -15,9 +15,9 @@
 
 # ==========================================================================
 
-quiet_cmd_modules_install = INSTALL $(obj-m)
+quiet_cmd_modules_install = INSTALL $(obj-m:.o=.klm)
       cmd_modules_install = mkdir -p $(MODLIB)/kernel && \
-		      cp $(obj-m) $(MODLIB)/kernel/
+		      cp $(obj-m:.o=.klm) $(MODLIB)/kernel/
 
 modules_install: $(subdir-ym)
 ifneq ($(obj-m),)
