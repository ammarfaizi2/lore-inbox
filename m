Return-Path: <linux-kernel-owner+w=401wt.eu-S1161072AbWLPPrN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161072AbWLPPrN (ORCPT <rfc822;w@1wt.eu>);
	Sat, 16 Dec 2006 10:47:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161074AbWLPPrM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 16 Dec 2006 10:47:12 -0500
Received: from queue02-winn.ispmail.ntl.com ([81.103.221.56]:11466 "EHLO
	queue02-winn.ispmail.ntl.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1161072AbWLPPrL (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 16 Dec 2006 10:47:11 -0500
X-Greylist: delayed 773 seconds by postgrey-1.27 at vger.kernel.org; Sat, 16 Dec 2006 10:47:09 EST
From: Catalin Marinas <catalin.marinas@gmail.com>
Subject: [PATCH 2.6.20-rc1 04/10] Modules support for kmemleak
To: linux-kernel@vger.kernel.org
Date: Sat, 16 Dec 2006 15:34:59 +0000
Message-ID: <20061216153459.18200.27076.stgit@localhost.localdomain>
In-Reply-To: <20061216153346.18200.51408.stgit@localhost.localdomain>
References: <20061216153346.18200.51408.stgit@localhost.localdomain>
User-Agent: StGIT/0.11
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This patch handles the kmemleak operations needed for modules loading so
that memory allocations from inside a module are properly tracked.

Signed-off-by: Catalin Marinas <catalin.marinas@gmail.com>
---

 kernel/module.c |   56 +++++++++++++++++++++++++++++++++++++++++++++++++++++++
 1 files changed, 56 insertions(+), 0 deletions(-)

diff --git a/kernel/module.c b/kernel/module.c
index b565eae..f1ff3f5 100644
--- a/kernel/module.c
+++ b/kernel/module.c
@@ -345,6 +345,7 @@ static void *percpu_modalloc(unsigned lo
 	unsigned long extra;
 	unsigned int i;
 	void *ptr;
+	int cpu;
 
 	if (align > SMP_CACHE_BYTES) {
 		printk(KERN_WARNING "%s: per-cpu alignment %li > %i\n",
@@ -374,6 +375,10 @@ static void *percpu_modalloc(unsigned lo
 			if (!split_block(i, size))
 				return NULL;
 
+		/* add the per-cpu scanning areas */
+		for_each_possible_cpu(cpu)
+			memleak_alloc(ptr + per_cpu_offset(cpu), size, 0);
+
 		/* Mark allocated */
 		pcpu_size[i] = -pcpu_size[i];
 		return ptr;
@@ -388,6 +393,7 @@ static void percpu_modfree(void *freeme)
 {
 	unsigned int i;
 	void *ptr = __per_cpu_start + block_size(pcpu_size[0]);
+	int cpu;
 
 	/* First entry is core kernel percpu data. */
 	for (i = 1; i < pcpu_num_used; ptr += block_size(pcpu_size[i]), i++) {
@@ -399,6 +405,10 @@ static void percpu_modfree(void *freeme)
 	BUG();
 
  free:
+	/* remove the per-cpu scanning areas */
+	for_each_possible_cpu(cpu)
+		memleak_free(freeme + per_cpu_offset(cpu));
+
 	/* Merge with previous? */
 	if (pcpu_size[i-1] >= 0) {
 		pcpu_size[i-1] += pcpu_size[i];
@@ -1529,6 +1539,42 @@ static inline void add_kallsyms(struct m
 }
 #endif /* CONFIG_KALLSYMS */
 
+#ifdef CONFIG_DEBUG_MEMLEAK
+static void memleak_load_module(struct module *mod, Elf_Ehdr *hdr,
+				Elf_Shdr *sechdrs, char *secstrings)
+{
+	unsigned int mloffindex, i;
+
+	/* insert any new pointer aliases */
+	mloffindex = find_sec(hdr, sechdrs, secstrings, ".init.memleak_offsets");
+	if (mloffindex)
+		memleak_insert_aliases((void *)sechdrs[mloffindex].sh_addr,
+				       (void *)sechdrs[mloffindex].sh_addr
+				       + sechdrs[mloffindex].sh_size);
+
+	/* only scan the sections containing data */
+	memleak_scan_area(mod->module_core,
+			  (unsigned long)mod - (unsigned long)mod->module_core,
+			  sizeof(struct module));
+
+	for (i = 1; i < hdr->e_shnum; i++) {
+		if (!(sechdrs[i].sh_flags & SHF_ALLOC))
+			continue;
+		if (strncmp(secstrings + sechdrs[i].sh_name, ".data", 5) != 0
+		    && strncmp(secstrings + sechdrs[i].sh_name, ".bss", 4) != 0)
+			continue;
+
+		memleak_scan_area(mod->module_core,
+				  sechdrs[i].sh_addr - (unsigned long)mod->module_core,
+				  sechdrs[i].sh_size);
+	}
+}
+#else
+static inline void memleak_load_module(struct module *mod, Elf_Ehdr *hdr,
+				       Elf_Shdr *sechdrs, char *secstrings)
+{ }
+#endif
+
 /* Allocate and load the module: note that size of section 0 is always
    zero, and we rely on this for optional sections. */
 static struct module *load_module(void __user *umod,
@@ -1724,6 +1770,10 @@ static struct module *load_module(void _
 
 	/* Do the allocs. */
 	ptr = module_alloc(mod->core_size);
+	/* the pointer to this block is stored in the module structure
+	 * which is inside the block. Just mark it as not being a
+	 * leak */
+	memleak_not_leak(ptr);
 	if (!ptr) {
 		err = -ENOMEM;
 		goto free_percpu;
@@ -1732,6 +1782,11 @@ static struct module *load_module(void _
 	mod->module_core = ptr;
 
 	ptr = module_alloc(mod->init_size);
+	/* the pointer to this block is stored in the module structure
+	 * which is inside the block. This block doesn't need to be
+	 * scanned as it contains data and code that will be freed
+	 * after the module is initialized */
+	memleak_ignore(ptr);
 	if (!ptr && mod->init_size) {
 		err = -ENOMEM;
 		goto free_core;
@@ -1762,6 +1817,7 @@ static struct module *load_module(void _
 	}
 	/* Module has been moved. */
 	mod = (void *)sechdrs[modindex].sh_addr;
+	memleak_load_module(mod, hdr, sechdrs, secstrings);
 
 	/* Now we've moved module, initialize linked lists, etc. */
 	module_unload_init(mod);
