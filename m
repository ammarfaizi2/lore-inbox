Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265019AbSKNRDT>; Thu, 14 Nov 2002 12:03:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265012AbSKNRCA>; Thu, 14 Nov 2002 12:02:00 -0500
Received: from dp.samba.org ([66.70.73.150]:37317 "EHLO lists.samba.org")
	by vger.kernel.org with ESMTP id <S265019AbSKNQ75>;
	Thu, 14 Nov 2002 11:59:57 -0500
From: Rusty Russell <rusty@rustcorp.com.au>
To: torvalds@transmeta.com
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH] Fix sparc64 alloc problem.
Date: Fri, 15 Nov 2002 04:59:44 +1100
Message-Id: <20021114170651.8CD7A2C088@lists.samba.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Dave beat it into my head that sparc64 really needs the struct module
in the low 32-bits of the kernel (it's turned into the symbol
__this_module when linking), so tweak the arch interface slightly so
they provide a "module_alloc" routine.

Compiles on x86, compiles and works on ppc32.  On top of
moduleloader.h patch.

Rusty.
--
  Anyone who quotes me in their sig is an idiot. -- Rusty Russell.

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



