Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262671AbTEVJwh (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 22 May 2003 05:52:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262703AbTEVJwg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 22 May 2003 05:52:36 -0400
Received: from dp.samba.org ([66.70.73.150]:41899 "EHLO lists.samba.org")
	by vger.kernel.org with ESMTP id S262671AbTEVJwH (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 22 May 2003 05:52:07 -0400
From: Rusty Russell <rusty@rustcorp.com.au>
To: Andrew Morton <akpm@digeo.com>
Cc: Ravikiran G Thirumalai <kiran@in.ibm.com>
Cc: Dipankar Sarma <dipankar@in.ibm.com>
Cc: linux-kernel@vger.kernel.org, David Mosberger-Tang <davidm@hpl.hp.com>
Subject: [PATCH] per-cpu support inside modules (minimal)
Date: Thu, 22 May 2003 20:04:08 +1000
Message-Id: <20030522100511.751E02C0F1@lists.samba.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

OK, this does the *minimum* required to support DEFINE_PER_CPU inside
modules.  If we decide to change kmalloc_percpu later, great, we can
turf this out.

Basically, overallocates the amount of per-cpu data at boot to at
least PERCPU_ENOUGH_ROOM if CONFIG_MODULES=y (arch-specific by default
16k: I have only 5700 bytes of percpu data in my kernel here, so makes
sense), and a special allocator in module.c dishes it out.

Comments welcome!
Rusty.
--
  Anyone who quotes me in their sig is an idiot. -- Rusty Russell.


Name: per-cpu support inside modules
Author: Rusty Russell
Status: Tested on 2.5.69-bk14

D: This adds percpu support for modules.

diff -urNp --exclude TAGS -X /home/rusty/current-dontdiff --minimal linux-2.5.69-bk14/include/asm-generic/percpu.h working-2.5.69-bk14-module-percpu/include/asm-generic/percpu.h
--- linux-2.5.69-bk14/include/asm-generic/percpu.h	2003-01-02 12:32:47.000000000 +1100
+++ working-2.5.69-bk14-module-percpu/include/asm-generic/percpu.h	2003-05-22 19:32:31.000000000 +1000
@@ -4,26 +4,28 @@
 
 #define __GENERIC_PER_CPU
 #ifdef CONFIG_SMP
-
 extern unsigned long __per_cpu_offset[NR_CPUS];
 
 /* Separate out the type, so (int[3], foo) works. */
-#ifndef MODULE
 #define DEFINE_PER_CPU(type, name) \
     __attribute__((__section__(".data.percpu"))) __typeof__(type) name##__per_cpu
-#endif
 
 /* var is in discarded region: offset to particular copy we want */
 #define per_cpu(var, cpu) (*RELOC_HIDE(&var##__per_cpu, __per_cpu_offset[cpu]))
 #define __get_cpu_var(var) per_cpu(var, smp_processor_id())
 
+static inline void percpu_modcopy(void *pcpudst, const void *src,
+				  unsigned long size)
+{
+	unsigned int i;
+	for (i = 0; i < NR_CPUS; i++)
+		if (cpu_possible(i))
+			memcpy(pcpudst + __per_cpu_offset[i], src, size);
+}
 #else /* ! SMP */
 
-/* Can't define per-cpu variables in modules.  Sorry --RR */
-#ifndef MODULE
 #define DEFINE_PER_CPU(type, name) \
     __typeof__(type) name##__per_cpu
-#endif
 
 #define per_cpu(var, cpu)			((void)cpu, var##__per_cpu)
 #define __get_cpu_var(var)			var##__per_cpu
diff -urNp --exclude TAGS -X /home/rusty/current-dontdiff --minimal linux-2.5.69-bk14/include/asm-ia64/percpu.h working-2.5.69-bk14-module-percpu/include/asm-ia64/percpu.h
--- linux-2.5.69-bk14/include/asm-ia64/percpu.h	2003-05-21 11:46:28.000000000 +1000
+++ working-2.5.69-bk14-module-percpu/include/asm-ia64/percpu.h	2003-05-21 18:38:28.000000000 +1000
@@ -19,15 +19,22 @@
 
 extern unsigned long __per_cpu_offset[NR_CPUS];
 
-#ifndef MODULE
 #define DEFINE_PER_CPU(type, name) \
     __attribute__((__section__(".data.percpu"))) __typeof__(type) name##__per_cpu
-#endif
 #define DECLARE_PER_CPU(type, name) extern __typeof__(type) name##__per_cpu
 
 #define __get_cpu_var(var)	(var##__per_cpu)
 #ifdef CONFIG_SMP
 # define per_cpu(var, cpu)	(*RELOC_HIDE(&var##__per_cpu, __per_cpu_offset[cpu]))
+
+static inline void percpu_modcopy(void *pcpudst, const void *src,
+				  unsigned long size)
+{
+	unsigned int i;
+	for (i = 0; i < NR_CPUS; i++)
+		if (cpu_possible(i))
+			memcpy(pcpudst + __per_cpu_offset[i], src, size);
+}
 #else
 # define per_cpu(var, cpu)	((void)cpu, __get_cpu_var(var))
 #endif
diff -urNp --exclude TAGS -X /home/rusty/current-dontdiff --minimal linux-2.5.69-bk14/include/linux/module.h working-2.5.69-bk14-module-percpu/include/linux/module.h
--- linux-2.5.69-bk14/include/linux/module.h	2003-05-05 12:37:12.000000000 +1000
+++ working-2.5.69-bk14-module-percpu/include/linux/module.h	2003-05-21 18:38:28.000000000 +1000
@@ -247,6 +247,9 @@ struct module
 	char *strtab;
 #endif
 
+	/* Per-cpu data. */
+	void *percpu;
+
 	/* The command line arguments (may be mangled).  People like
 	   keeping pointers to this stuff */
 	char *args;
diff -urNp --exclude TAGS -X /home/rusty/current-dontdiff --minimal linux-2.5.69-bk14/include/linux/percpu.h working-2.5.69-bk14-module-percpu/include/linux/percpu.h
--- linux-2.5.69-bk14/include/linux/percpu.h	2003-02-07 19:20:01.000000000 +1100
+++ working-2.5.69-bk14-module-percpu/include/linux/percpu.h	2003-05-22 17:00:37.000000000 +1000
@@ -1,9 +1,16 @@
 #ifndef __LINUX_PERCPU_H
 #define __LINUX_PERCPU_H
 #include <linux/spinlock.h> /* For preempt_disable() */
-#include <linux/slab.h> /* For kmalloc_percpu() */
+#include <linux/slab.h> /* For kmalloc() */
+#include <linux/smp.h>
+#include <linux/string.h>
 #include <asm/percpu.h>
 
+/* Enough to cover all DEFINE_PER_CPUs in kernel, including modules. */
+#ifndef PERCPU_ENOUGH_ROOM
+#define PERCPU_ENOUGH_ROOM 16384
+#endif
+
 /* Must be an lvalue. */
 #define get_cpu_var(var) (*({ preempt_disable(); &__get_cpu_var(var); }))
 #define put_cpu_var(var) preempt_enable()
diff -urNp --exclude TAGS -X /home/rusty/current-dontdiff --minimal linux-2.5.69-bk14/init/main.c working-2.5.69-bk14-module-percpu/init/main.c
--- linux-2.5.69-bk14/init/main.c	2003-05-21 11:46:31.000000000 +1000
+++ working-2.5.69-bk14-module-percpu/init/main.c	2003-05-21 18:38:28.000000000 +1000
@@ -318,14 +318,16 @@ static void __init setup_per_cpu_areas(v
 
 	/* Copy section for each CPU (we discard the original) */
 	size = ALIGN(__per_cpu_end - __per_cpu_start, SMP_CACHE_BYTES);
-	if (!size)
-		return;
+#ifdef CONFIG_MODULES
+	if (size < PERCPU_ENOUGH_ROOM)
+		size = PERCPU_ENOUGH_ROOM;
+#endif
 
 	ptr = alloc_bootmem(size * NR_CPUS);
 
 	for (i = 0; i < NR_CPUS; i++, ptr += size) {
 		__per_cpu_offset[i] = ptr - __per_cpu_start;
-		memcpy(ptr, __per_cpu_start, size);
+		memcpy(ptr, __per_cpu_start, __per_cpu_end - __per_cpu_start);
 	}
 }
 #endif /* !__GENERIC_PER_CPU */
diff -urNp --exclude TAGS -X /home/rusty/current-dontdiff --minimal linux-2.5.69-bk14/kernel/module.c working-2.5.69-bk14-module-percpu/kernel/module.c
--- linux-2.5.69-bk14/kernel/module.c	2003-05-21 11:46:31.000000000 +1000
+++ working-2.5.69-bk14-module-percpu/kernel/module.c	2003-05-22 19:57:38.000000000 +1000
@@ -421,6 +421,145 @@ static void restart_refcounts(void)
 	preempt_enable();
 	up(&cpucontrol);
 }
+
+/* Number of blocks used and allocated. */
+static unsigned int pcpu_num_used, pcpu_num_allocated;
+/* Size of each block.  -ve means used. */
+static int *pcpu_size;
+
+static int split_block(unsigned int i, unsigned short size)
+{
+	/* Reallocation required? */
+	if (pcpu_num_used + 1 > pcpu_num_allocated) {
+		int *new = kmalloc(sizeof(new[0]) * pcpu_num_allocated*2,
+				   GFP_KERNEL);
+		if (!new)
+			return 0;
+
+		memcpy(new, pcpu_size, sizeof(new[0])*pcpu_num_allocated);
+		pcpu_num_allocated *= 2;
+		kfree(pcpu_size);
+		pcpu_size = new;
+	}
+
+	/* Insert a new subblock */
+	memmove(&pcpu_size[i+1], &pcpu_size[i],
+		sizeof(pcpu_size[0]) * (pcpu_num_used - i));
+	pcpu_num_used++;
+
+	pcpu_size[i+1] -= size;
+	pcpu_size[i] = size;
+	return 1;
+}
+
+static inline unsigned int abs(int val)
+{
+	if (val < 0)
+		return -val;
+	return val;
+}
+
+/* Created by linker magic */
+extern char __per_cpu_start[], __per_cpu_end[];
+
+static void *percpu_modalloc(unsigned long size, unsigned long align)
+{
+	unsigned long extra;
+	unsigned int i;
+	void *ptr;
+
+	BUG_ON(align > SMP_CACHE_BYTES);
+
+	ptr = __per_cpu_start;
+	for (i = 0; i < pcpu_num_used; ptr += abs(pcpu_size[i]), i++) {
+		/* Extra for alignment requirement. */
+		extra = ALIGN((unsigned long)ptr, align) - (unsigned long)ptr;
+		BUG_ON(i == 0 && extra != 0);
+
+		if (pcpu_size[i] < 0 || pcpu_size[i] < extra + size)
+			continue;
+
+		/* Transfer extra to previous block. */
+		if (pcpu_size[i-1] < 0)
+			pcpu_size[i-1] -= extra;
+		else
+			pcpu_size[i-1] += extra;
+		pcpu_size[i] -= extra;
+		ptr += extra;
+
+		/* Split block if warranted */
+		if (pcpu_size[i] - size > sizeof(unsigned long))
+			if (!split_block(i, size))
+				return NULL;
+
+		/* Mark allocated */
+		pcpu_size[i] = -pcpu_size[i];
+		return ptr;
+	}
+
+	printk(KERN_WARNING "Could not allocate %lu bytes percpu data\n",
+	       size);
+	return NULL;
+}
+
+static void percpu_modfree(void *freeme)
+{
+	unsigned int i;
+	void *ptr = __per_cpu_start + abs(pcpu_size[0]);
+
+	/* First entry is core kernel percpu data. */
+	for (i = 1; i < pcpu_num_used; ptr += abs(pcpu_size[i]), i++) {
+		if (ptr == freeme) {
+			pcpu_size[i] = -pcpu_size[i];
+			goto free;
+		}
+	}
+	BUG();
+
+ free:
+	/* Merge with previous? */
+	if (pcpu_size[i-1] >= 0) {
+		pcpu_size[i-1] += pcpu_size[i];
+		pcpu_num_used--;
+		memmove(&pcpu_size[i], &pcpu_size[i+1],
+			(pcpu_num_used - i) * sizeof(pcpu_size[0]));
+		i--;
+	}
+	/* Merge with next? */
+	if (i+1 < pcpu_num_used && pcpu_size[i+1] >= 0) {
+		pcpu_size[i] += pcpu_size[i+1];
+		pcpu_num_used--;
+		memmove(&pcpu_size[i+1], &pcpu_size[i+2],
+			(pcpu_num_used - (i+1)) * sizeof(pcpu_size[0]));
+	}
+}
+
+static unsigned int find_pcpusec(Elf_Ehdr *hdr,
+				 Elf_Shdr *sechdrs,
+				 const char *secstrings)
+{
+	return find_sec(hdr, sechdrs, secstrings, ".data.percpu");
+}
+
+static int percpu_modinit(void)
+{
+	pcpu_num_used = 2;
+	pcpu_num_allocated = 2;
+	pcpu_size = kmalloc(sizeof(pcpu_size[0]) * pcpu_num_allocated,
+			    GFP_KERNEL);
+	/* Static in-kernel percpu data (used). */
+	pcpu_size[0] = -ALIGN(__per_cpu_end-__per_cpu_start, SMP_CACHE_BYTES);
+	/* Free room. */
+	pcpu_size[1] = PERCPU_ENOUGH_ROOM + pcpu_size[0];
+	if (pcpu_size[1] < 0) {
+		printk(KERN_ERR "No per-cpu room for modules.\n");
+		pcpu_num_used = 1;
+	}
+
+	return 0;
+}	
+__initcall(percpu_modinit);
+
 #else /* ...!SMP */
 static inline int stop_refcounts(void)
 {
@@ -431,6 +570,22 @@ static inline void restart_refcounts(voi
 {
 	local_irq_enable();
 }
+static inline void *percpu_modalloc(unsigned long size, unsigned long align)
+{
+	return NULL;
+}
+static inline unsigned int find_pcpusec(Elf_Ehdr *hdr,
+					Elf_Shdr *sechdrs,
+					const char *secstrings)
+{
+	return 0;
+}
+static inline void percpu_modcopy(void *pcpudst, const void *src,
+				  unsigned long size)
+{
+	/* pcpusec should be 0, and size of that section should be 0. */
+	BUG_ON(size != 0);
+}
 #endif
 
 unsigned int module_refcount(struct module *mod)
@@ -913,6 +1068,8 @@ static void free_module(struct module *m
 	/* This may be NULL, but that's OK */
 	module_free(mod, mod->module_init);
 	kfree(mod->args);
+	if (mod->percpu)
+		percpu_modfree(mod->percpu);
 
 	/* Finally, free the core (containing the module structure) */
 	module_free(mod, mod->module_core);
@@ -939,10 +1096,11 @@ static int simplify_symbols(Elf_Shdr *se
 			    unsigned int symindex,
 			    const char *strtab,
 			    unsigned int versindex,
+			    unsigned int pcpuindex,
 			    struct module *mod)
 {
 	Elf_Sym *sym = (void *)sechdrs[symindex].sh_addr;
-	
+	unsigned long secbase;
 	unsigned int i, n = sechdrs[symindex].sh_size / sizeof(Elf_Sym);
 	int ret = 0;
 
@@ -979,10 +1137,12 @@ static int simplify_symbols(Elf_Shdr *se
 			break;
 
 		default:
-			sym[i].st_value 
-				= (unsigned long)
-				(sechdrs[sym[i].st_shndx].sh_addr
-				 + sym[i].st_value);
+			/* Divert to percpu allocation if a percpu var. */
+			if (sym[i].st_shndx == pcpuindex)
+				secbase = (unsigned long)mod->percpu;
+			else
+				secbase = sechdrs[sym[i].st_shndx].sh_addr;
+			sym[i].st_value += secbase;
 			break;
 		}
 	}
@@ -1119,7 +1279,7 @@ static struct module *load_module(void _
 	char *secstrings, *args, *modmagic, *strtab = NULL;
 	unsigned int i, symindex = 0, strindex = 0, setupindex, exindex,
 		exportindex, modindex, obsparmindex, infoindex, gplindex,
-		crcindex, gplcrcindex, versindex;
+		crcindex, gplcrcindex, versindex, pcpuindex;
 	long arglen;
 	struct module *mod;
 	long err = 0;
@@ -1194,6 +1354,7 @@ static struct module *load_module(void _
 	obsparmindex = find_sec(hdr, sechdrs, secstrings, "__obsparm");
 	versindex = find_sec(hdr, sechdrs, secstrings, "__versions");
 	infoindex = find_sec(hdr, sechdrs, secstrings, ".modinfo");
+	pcpuindex = find_pcpusec(hdr, sechdrs, secstrings);
 
 	/* Don't keep modinfo section */
 	sechdrs[infoindex].sh_flags &= ~(unsigned long)SHF_ALLOC;
@@ -1250,6 +1411,17 @@ static struct module *load_module(void _
 	if (err < 0)
 		goto free_mod;
 
+	if (pcpuindex) {
+		/* We have a special allocation for this section. */
+		mod->percpu = percpu_modalloc(sechdrs[pcpuindex].sh_size,
+					      sechdrs[pcpuindex].sh_addralign);
+		if (!mod->percpu) {
+			err = -ENOMEM;
+			goto free_mod;
+		}
+		sechdrs[pcpuindex].sh_flags &= ~(unsigned long)SHF_ALLOC;
+	}
+
 	/* Determine total sizes, and put offsets in sh_entsize.  For now
 	   this is done generically; there doesn't appear to be any
 	   special cases for the architectures. */
@@ -1259,7 +1431,7 @@ static struct module *load_module(void _
 	ptr = module_alloc(mod->core_size);
 	if (!ptr) {
 		err = -ENOMEM;
-		goto free_mod;
+		goto free_percpu;
 	}
 	memset(ptr, 0, mod->core_size);
 	mod->module_core = ptr;
@@ -1303,7 +1475,8 @@ static struct module *load_module(void _
 	set_license(mod, get_modinfo(sechdrs, infoindex, "license"));
 
 	/* Fix up syms, so that st_value is a pointer to location. */
-	err = simplify_symbols(sechdrs, symindex, strtab, versindex, mod);
+	err = simplify_symbols(sechdrs, symindex, strtab, versindex, pcpuindex,
+			       mod);
 	if (err < 0)
 		goto cleanup;
 
@@ -1342,6 +1515,10 @@ static struct module *load_module(void _
 			goto cleanup;
 	}
 
+	/* Finally, copy percpu area over. */
+	percpu_modcopy(mod->percpu, (void *)sechdrs[pcpuindex].sh_addr,
+		       sechdrs[pcpuindex].sh_size);
+
 #ifdef CONFIG_KALLSYMS
 	mod->symtab = (void *)sechdrs[symindex].sh_addr;
 	mod->num_symtab = sechdrs[symindex].sh_size / sizeof(Elf_Sym);
@@ -1383,6 +1560,9 @@ static struct module *load_module(void _
 	module_free(mod, mod->module_init);
  free_core:
 	module_free(mod, mod->module_core);
+ free_percpu:
+	if (mod->percpu)
+		percpu_modfree(mod->percpu);
  free_mod:
 	kfree(args);
  free_hdr:
