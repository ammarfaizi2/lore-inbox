Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262190AbSKOIlK>; Fri, 15 Nov 2002 03:41:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262201AbSKOIlK>; Fri, 15 Nov 2002 03:41:10 -0500
Received: from dp.samba.org ([66.70.73.150]:8414 "EHLO lists.samba.org")
	by vger.kernel.org with ESMTP id <S262190AbSKOIlC>;
	Fri, 15 Nov 2002 03:41:02 -0500
From: Rusty Russell <rusty@rustcorp.com.au>
To: Andi Kleen <ak@suse.de>
Cc: Richard Henderson <rth@twiddle.net>, linux-kernel@vger.kernel.org,
       davidm@hpl.hp.com
Subject: Re: in-kernel linking issues 
In-reply-to: Your message of "15 Nov 2002 05:13:23 BST."
             <p73wunfv5b0.fsf@oldwotan.suse.de> 
Date: Fri, 15 Nov 2002 19:44:40 +1100
Message-Id: <20021115084757.A640A2C145@lists.samba.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In message <p73wunfv5b0.fsf@oldwotan.suse.de> you write:
> Richard Henderson <rth@twiddle.net> writes:
> 
> >  These will affect at least Alpha, IA-64, and MIPS.
> > 
> >  (3) Alpha and MIPS64 absolutely require that the core and init allocations
> >      are "close" (within 2GB).  I don't see how this can be guaranteed with
> >      two different vmalloc calls.
> 
> In x86-64 (and I think sparc64) the modules (both data and code) also need
> to be within 2GB of the main kernel code. This is done to avoid needing
> a GOT for calls between main kernel and modules. In the old module code that
> is done with a custom module_map() function. I have not looked yet on how
> that could be implemented in the new code.

Ack, PPC64 same issue.  Several solutions:

1) Put everything in module_core and nothing in module_init.  Sure,
   you lose the discard-init stuff, but it's designed to work.

2) Use a magic allocator a-la Sparc64.

3) Best-effort: allocate both at alloc-core time (store init ptr in
   mod_arch_specific) and if they're too far apart, throw that away
   and fall back to one big alloc.

4) Implement jump stubs between the two sections.

See my kernel.org page for the PPC64 and ia64 implementations (they
were implemented and tested in userspace, and never actually compiled
as kernel code, so the linking code should be correct but there may be
typos and kernel-related ommissions, etc).

This is why I made sure I had half a dozen archs under my belt, I
still screwed up sparc64 (which needs __this_module to be withing
32-bits, too).

BTW, arch interface tweaked to fix sparc64 problem.  Linus hasn't
taken it yet, but it's below (with predecessor patch to alter includes
to avoid  pulling in elf.h everywhere which breaks xfs).

Cheers,
Rusty.
--
  Anyone who quotes me in their sig is an idiot. -- Rusty Russell.

Name: moduleloader.h
Author: Anders Gustafsson
Status: Experimental
Depends: Module/module-i386.patch.gz

D: Separates the module loading function prototypes (and elf.h) into
D: moduleloader.h.  AT_GID in elf.h clashes with xfs.h, but this also
D: makes module.h less cluttered.

diff -urpN --exclude TAGS -X /home/rusty/devel/kernel/kernel-patches/current-dontdiff --minimal linux-2.5-bk/arch/i386/kernel/module.c working-2.5-bk-noelf/arch/i386/kernel/module.c
--- linux-2.5-bk/arch/i386/kernel/module.c	2002-11-14 15:08:19.000000000 +1100
+++ working-2.5-bk-noelf/arch/i386/kernel/module.c	2002-11-14 16:30:13.000000000 +1100
@@ -15,7 +15,7 @@
     along with this program; if not, write to the Free Software
     Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA  02111-1307  USA
 */
-#include <linux/module.h>
+#include <linux/moduleloader.h>
 #include <linux/elf.h>
 #include <linux/vmalloc.h>
 #include <linux/fs.h>
diff -urpN --exclude TAGS -X /home/rusty/devel/kernel/kernel-patches/current-dontdiff --minimal linux-2.5-bk/arch/sparc/kernel/module.c working-2.5-bk-noelf/arch/sparc/kernel/module.c
--- linux-2.5-bk/arch/sparc/kernel/module.c	2002-11-14 15:08:20.000000000 +1100
+++ working-2.5-bk-noelf/arch/sparc/kernel/module.c	2002-11-14 16:30:55.000000000 +1100
@@ -4,7 +4,7 @@
  * Copyright (C) 2002 David S. Miller.
  */
 
-#include <linux/module.h>
+#include <linux/moduleloader.h>
 #include <linux/kernel.h>
 #include <linux/elf.h>
 #include <linux/vmalloc.h>
diff -urpN --exclude TAGS -X /home/rusty/devel/kernel/kernel-patches/current-dontdiff --minimal linux-2.5-bk/arch/sparc64/kernel/module.c working-2.5-bk-noelf/arch/sparc64/kernel/module.c
--- linux-2.5-bk/arch/sparc64/kernel/module.c	2002-11-14 15:08:21.000000000 +1100
+++ working-2.5-bk-noelf/arch/sparc64/kernel/module.c	2002-11-14 16:31:02.000000000 +1100
@@ -4,7 +4,7 @@
  * Copyright (C) 2002 David S. Miller.
  */
 
-#include <linux/module.h>
+#include <linux/moduleloader.h>
 #include <linux/kernel.h>
 #include <linux/elf.h>
 #include <linux/vmalloc.h>
diff -urpN --exclude TAGS -X /home/rusty/devel/kernel/kernel-patches/current-dontdiff --minimal linux-2.5-bk/include/linux/module.h working-2.5-bk-noelf/include/linux/module.h
--- linux-2.5-bk/include/linux/module.h	2002-11-14 15:08:25.000000000 +1100
+++ working-2.5-bk-noelf/include/linux/module.h	2002-11-14 16:28:51.000000000 +1100
@@ -10,7 +10,6 @@
 #include <linux/sched.h>
 #include <linux/spinlock.h>
 #include <linux/list.h>
-#include <linux/elf.h>
 #include <linux/stat.h>
 #include <linux/compiler.h>
 #include <linux/cache.h>
@@ -143,53 +142,6 @@ struct module
 	char args[0];
 };
 
-/* Helper function for arch-specific module loaders */
-unsigned long find_symbol_internal(Elf_Shdr *sechdrs,
-				   unsigned int symindex,
-				   const char *strtab,
-				   const char *name,
-				   struct module *mod,
-				   struct kernel_symbol_group **group);
-
-/* These must be implemented by the specific architecture */
-
-/* vmalloc AND zero for the non-releasable code; return ERR_PTR() on error. */
-void *module_core_alloc(const Elf_Ehdr *hdr,
-			const Elf_Shdr *sechdrs,
-			const char *secstrings,
-			struct module *mod);
-
-/* vmalloc and zero (if any) for sections to be freed after init.
-   Return ERR_PTR() on error. */
-void *module_init_alloc(const Elf_Ehdr *hdr,
-			const Elf_Shdr *sechdrs,
-			const char *secstrings,
-			struct module *mod);
-
-/* Apply the given relocation to the (simplified) ELF.  Return -error
-   or 0. */
-int apply_relocate(Elf_Shdr *sechdrs,
-		   const char *strtab,
-		   unsigned int symindex,
-		   unsigned int relsec,
-		   struct module *mod);
-
-/* Apply the given add relocation to the (simplified) ELF.  Return
-   -error or 0 */
-int apply_relocate_add(Elf_Shdr *sechdrs,
-		       const char *strtab,
-		       unsigned int symindex,
-		       unsigned int relsec,
-		       struct module *mod);
-
-/* Any final processing of module before access.  Return -error or 0. */
-int module_finalize(const Elf_Ehdr *hdr,
-		    const Elf_Shdr *sechdrs,
-		    struct module *mod);
-
-/* Free memory returned from module_core_alloc/module_init_alloc */
-void module_free(struct module *mod, void *module_region);
-
 #ifdef CONFIG_MODULE_UNLOAD
 
 void __symbol_put(const char *symbol);
diff -urpN --exclude TAGS -X /home/rusty/devel/kernel/kernel-patches/current-dontdiff --minimal linux-2.5-bk/include/linux/moduleloader.h working-2.5-bk-noelf/include/linux/moduleloader.h
--- linux-2.5-bk/include/linux/moduleloader.h	1970-01-01 10:00:00.000000000 +1000
+++ working-2.5-bk-noelf/include/linux/moduleloader.h	2002-11-14 16:29:33.000000000 +1100
@@ -0,0 +1,55 @@
+#ifndef _LINUX_MODULELOADER_H
+#define _LINUX_MODULELOADER_H
+/* The stuff needed for archs to support modules. */
+
+#include <linux/module.h>
+#include <linux/elf.h>
+
+/* Helper function for arch-specific module loaders */
+unsigned long find_symbol_internal(Elf_Shdr *sechdrs,
+				   unsigned int symindex,
+				   const char *strtab,
+				   const char *name,
+				   struct module *mod,
+				   struct kernel_symbol_group **group);
+
+/* These must be implemented by the specific architecture */
+
+/* vmalloc AND zero for the non-releasable code; return ERR_PTR() on error. */
+void *module_core_alloc(const Elf_Ehdr *hdr,
+			const Elf_Shdr *sechdrs,
+			const char *secstrings,
+			struct module *mod);
+
+/* vmalloc and zero (if any) for sections to be freed after init.
+   Return ERR_PTR() on error. */
+void *module_init_alloc(const Elf_Ehdr *hdr,
+			const Elf_Shdr *sechdrs,
+			const char *secstrings,
+			struct module *mod);
+
+/* Free memory returned from module_core_alloc/module_init_alloc */
+void module_free(struct module *mod, void *module_region);
+
+/* Apply the given relocation to the (simplified) ELF.  Return -error
+   or 0. */
+int apply_relocate(Elf_Shdr *sechdrs,
+		   const char *strtab,
+		   unsigned int symindex,
+		   unsigned int relsec,
+		   struct module *mod);
+
+/* Apply the given add relocation to the (simplified) ELF.  Return
+   -error or 0 */
+int apply_relocate_add(Elf_Shdr *sechdrs,
+		       const char *strtab,
+		       unsigned int symindex,
+		       unsigned int relsec,
+		       struct module *mod);
+
+/* Any final processing of module before access.  Return -error or 0. */
+int module_finalize(const Elf_Ehdr *hdr,
+		    const Elf_Shdr *sechdrs,
+		    struct module *mod);
+
+#endif
diff -urpN --exclude TAGS -X /home/rusty/devel/kernel/kernel-patches/current-dontdiff --minimal linux-2.5-bk/kernel/module.c working-2.5-bk-noelf/kernel/module.c
--- linux-2.5-bk/kernel/module.c	2002-11-14 15:08:25.000000000 +1100
+++ working-2.5-bk-noelf/kernel/module.c	2002-11-14 16:28:04.000000000 +1100
@@ -17,6 +17,7 @@
 */
 #include <linux/config.h>
 #include <linux/module.h>
+#include <linux/moduleloader.h>
 #include <linux/init.h>
 #include <linux/slab.h>
 #include <linux/vmalloc.h>
Name: Allocate struct module using special allocator
Author: Rusty Russell
Status: Experimental
Depends: Module/moduleloader_h.patch.gz

D: Sparc64 (and probably others) need all the kernel symbols within
D: 32-bits, which includes the manufactured "__this_module" which refers
D: to the struct module *.
D: 
D: This changes the interface back to its old style: the arch-specific code
D: manipulates the init and core sizes, and we call module_alloc() ourselves.

diff -urpN --exclude TAGS -X /home/rusty/devel/kernel/kernel-patches/current-dontdiff --minimal working-2.5-bk-moduleloader_h/arch/i386/kernel/module.c working-2.5-bk-sparcfixes/arch/i386/kernel/module.c
--- working-2.5-bk-moduleloader_h/arch/i386/kernel/module.c	2002-11-14 20:47:30.000000000 +1100
+++ working-2.5-bk-sparcfixes/arch/i386/kernel/module.c	2002-11-14 20:47:50.000000000 +1100
@@ -28,22 +28,15 @@
 #define DEBUGP(fmt , ...)
 #endif
 
-static void *alloc_and_zero(unsigned long size)
+void *module_alloc(unsigned long size)
 {
-	void *ret;
-
-	/* We handle the zero case fine, unlike vmalloc */
 	if (size == 0)
 		return NULL;
-
-	ret = vmalloc(size);
-	if (!ret) ret = ERR_PTR(-ENOMEM);
-	else memset(ret, 0, size);
-
-	return ret;
+	return vmalloc(size);
 }
 
-/* Free memory returned from module_core_alloc/module_init_alloc */
+
+/* Free memory returned from module_alloc */
 void module_free(struct module *mod, void *module_region)
 {
 	vfree(module_region);
@@ -51,20 +44,21 @@ void module_free(struct module *mod, voi
            table entries. */
 }
 
-void *module_core_alloc(const Elf32_Ehdr *hdr,
-			const Elf32_Shdr *sechdrs,
-			const char *secstrings,
-			struct module *module)
+/* We don't need anything special. */
+long module_core_size(const Elf32_Ehdr *hdr,
+		      const Elf32_Shdr *sechdrs,
+		      const char *secstrings,
+		      struct module *module)
 {
-	return alloc_and_zero(module->core_size);
+	return module->core_size;
 }
 
-void *module_init_alloc(const Elf32_Ehdr *hdr,
-			const Elf32_Shdr *sechdrs,
-			const char *secstrings,
-			struct module *module)
+long module_init_size(const Elf32_Ehdr *hdr,
+		      const Elf32_Shdr *sechdrs,
+		      const char *secstrings,
+		      struct module *module)
 {
-	return alloc_and_zero(module->init_size);
+	return module->init_size;
 }
 
 int apply_relocate(Elf32_Shdr *sechdrs,
diff -urpN --exclude TAGS -X /home/rusty/devel/kernel/kernel-patches/current-dontdiff --minimal working-2.5-bk-moduleloader_h/include/linux/moduleloader.h working-2.5-bk-sparcfixes/include/linux/moduleloader.h
--- working-2.5-bk-moduleloader_h/include/linux/moduleloader.h	2002-11-14 20:47:30.000000000 +1100
+++ working-2.5-bk-sparcfixes/include/linux/moduleloader.h	2002-11-14 20:47:50.000000000 +1100
@@ -15,20 +15,26 @@ unsigned long find_symbol_internal(Elf_S
 
 /* These must be implemented by the specific architecture */
 
-/* vmalloc AND zero for the non-releasable code; return ERR_PTR() on error. */
-void *module_core_alloc(const Elf_Ehdr *hdr,
-			const Elf_Shdr *sechdrs,
-			const char *secstrings,
-			struct module *mod);
+/* Total size to allocate for the non-releasable code; return len or
+   -error.  mod->core_size is the current generic tally. */
+long module_core_size(const Elf_Ehdr *hdr,
+		      const Elf_Shdr *sechdrs,
+		      const char *secstrings,
+		      struct module *mod);
 
-/* vmalloc and zero (if any) for sections to be freed after init.
-   Return ERR_PTR() on error. */
-void *module_init_alloc(const Elf_Ehdr *hdr,
-			const Elf_Shdr *sechdrs,
-			const char *secstrings,
-			struct module *mod);
+/* Total size of (if any) sections to be freed after init.  Return 0
+   for none, len, or -error. mod->init_size is the current generic
+   tally. */
+long module_init_size(const Elf_Ehdr *hdr,
+		      const Elf_Shdr *sechdrs,
+		      const char *secstrings,
+		      struct module *mod);
 
-/* Free memory returned from module_core_alloc/module_init_alloc */
+/* Allocator used for allocating struct module, core sections and init
+   sections.  Returns NULL on failure. */
+void *module_alloc(unsigned long size);
+
+/* Free memory returned from module_alloc. */
 void module_free(struct module *mod, void *module_region);
 
 /* Apply the given relocation to the (simplified) ELF.  Return -error
diff -urpN --exclude TAGS -X /home/rusty/devel/kernel/kernel-patches/current-dontdiff --minimal working-2.5-bk-moduleloader_h/kernel/module.c working-2.5-bk-sparcfixes/kernel/module.c
--- working-2.5-bk-moduleloader_h/kernel/module.c	2002-11-14 20:47:30.000000000 +1100
+++ working-2.5-bk-sparcfixes/kernel/module.c	2002-11-14 20:47:50.000000000 +1100
@@ -557,7 +557,7 @@ static void free_module(struct module *m
 	module_unload_free(mod);
 
 	/* Finally, free the module structure */
-	kfree(mod);
+	module_free(mod, mod);
 }
 
 void *__symbol_get(const char *symbol)
@@ -805,7 +805,7 @@ static struct module *load_module(void *
 	unsigned long common_length;
 	struct sizes sizes, used;
 	struct module *mod;
-	int err = 0;
+	long err = 0;
 	void *ptr = NULL; /* Stops spurious gcc uninitialized warning */
 
 	DEBUGP("load_module: umod=%p, len=%lu, uargs=%p\n",
@@ -894,7 +894,7 @@ static struct module *load_module(void *
 		goto free_hdr;
 	arglen = err;
 
-	mod = kmalloc(sizeof(*mod) + arglen+1, GFP_KERNEL);
+	mod = module_alloc(sizeof(*mod) + arglen+1);
 	if (!mod) {
 		err = -ENOMEM;
 		goto free_hdr;
@@ -925,20 +925,36 @@ static struct module *load_module(void *
 	common_length = read_commons(hdr, &sechdrs[symindex]);
 	sizes.core_size += common_length;
 
-	/* Set these up: arch's can add to them */
+	/* Set these up, and allow archs to manipulate them. */
 	mod->core_size = sizes.core_size;
 	mod->init_size = sizes.init_size;
 
-	/* Allocate (this is arch specific) */
-	ptr = module_core_alloc(hdr, sechdrs, secstrings, mod);
-	if (IS_ERR(ptr))
+	/* Allow archs to add to them. */
+	err = module_init_size(hdr, sechdrs, secstrings, mod);
+	if (err < 0)
+		goto free_mod;
+	mod->init_size = err;
+
+	err = module_core_size(hdr, sechdrs, secstrings, mod);
+	if (err < 0)
 		goto free_mod;
+	mod->core_size = err;
 
+	/* Do the allocs. */
+	ptr = module_alloc(mod->core_size);
+	if (!ptr) {
+		err = -ENOMEM;
+		goto free_mod;
+	}
+	memset(ptr, 0, mod->core_size);
 	mod->module_core = ptr;
 
-	ptr = module_init_alloc(hdr, sechdrs, secstrings, mod);
-	if (IS_ERR(ptr))
+	ptr = module_alloc(mod->init_size);
+	if (!ptr) {
+		err = -ENOMEM;
 		goto free_core;
+	}
+	memset(ptr, 0, mod->init_size);
 	mod->module_init = ptr;
 
 	/* Transfer each section which requires ALLOC, and set sh_offset
@@ -1015,7 +1031,7 @@ static struct module *load_module(void *
  free_core:
 	module_free(mod, mod->module_core);
  free_mod:
-	kfree(mod);
+	module_free(mod, mod);
  free_hdr:
 	vfree(hdr);
 	if (err < 0) return ERR_PTR(err);



