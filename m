Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262039AbTEEIG6 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 5 May 2003 04:06:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262041AbTEEIG6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 5 May 2003 04:06:58 -0400
Received: from dp.samba.org ([66.70.73.150]:60572 "EHLO lists.samba.org")
	by vger.kernel.org with ESMTP id S262039AbTEEIGy (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 5 May 2003 04:06:54 -0400
From: Rusty Russell <rusty@rustcorp.com.au>
To: akpm@zip.com.au
Cc: linux-kernel@vger.kernel.org, David Mosberger <davidm@hpl.hp.com>
Subject: [PATCH] per-cpu data in modules.
Date: Mon, 05 May 2003 18:14:26 +1000
Message-Id: <20030505081924.BC1912C016@lists.samba.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Andrew,

	This uses the previous __alloc_percpu patch, to allow per-cpu
data within modules.

Rusty.
--
  Anyone who quotes me in their sig is an idiot. -- Rusty Russell.

Name: per-cpu support inside modules
Author: Rusty Russell
Status: Tested on 2.5.69
Depends: Misc/kmalloc_percpu.patch.gz 

D: This adds percpu support for modules.

diff -urpN --exclude TAGS -X /home/rusty/devel/kernel/kernel-patches/current-dontdiff --minimal .12664-linux-2.5.69/include/linux/module.h .12664-linux-2.5.69.updated/include/linux/module.h
--- .12664-linux-2.5.69/include/linux/module.h	2003-05-05 12:37:12.000000000 +1000
+++ .12664-linux-2.5.69.updated/include/linux/module.h	2003-05-05 13:02:06.000000000 +1000
@@ -247,6 +247,9 @@ struct module
 	char *strtab;
 #endif
 
+	/* Per-cpu data. */
+	void *percpu;
+
 	/* The command line arguments (may be mangled).  People like
 	   keeping pointers to this stuff */
 	char *args;
diff -urpN --exclude TAGS -X /home/rusty/devel/kernel/kernel-patches/current-dontdiff --minimal .12664-linux-2.5.69/include/linux/percpu.h .12664-linux-2.5.69.updated/include/linux/percpu.h
--- .12664-linux-2.5.69/include/linux/percpu.h	2003-05-05 13:02:05.000000000 +1000
+++ .12664-linux-2.5.69.updated/include/linux/percpu.h	2003-05-05 13:02:41.000000000 +1000
@@ -31,10 +31,8 @@ extern void kfree_percpu(const void *);
 extern unsigned long __per_cpu_offset[NR_CPUS];
 
 /* Separate out the type, so (int[3], foo) works. */
-#ifndef MODULE
 #define DEFINE_PER_CPU(type, name) \
     __attribute__((__section__(".data.percpu"))) __typeof__(type) name##__per_cpu
-#endif
 
 /* var is in discarded region: offset to particular copy we want */
 #define per_cpu(var, cpu) (*RELOC_HIDE(&var##__per_cpu, __per_cpu_offset[cpu]))
@@ -43,11 +41,8 @@ extern unsigned long __per_cpu_offset[NR
 extern void setup_per_cpu_areas(void);
 #else /* !CONFIG_SMP */
 
-/* Can't define per-cpu variables in modules.  Sorry --RR */
-#ifndef MODULE
 #define DEFINE_PER_CPU(type, name) \
     __typeof__(type) name##__per_cpu
-#endif
 
 #define per_cpu(var, cpu)			((void)(cpu), var##__per_cpu)
 #define __get_cpu_var(var)			var##__per_cpu
diff -urpN --exclude TAGS -X /home/rusty/devel/kernel/kernel-patches/current-dontdiff --minimal .12664-linux-2.5.69/kernel/module.c .12664-linux-2.5.69.updated/kernel/module.c
--- .12664-linux-2.5.69/kernel/module.c	2003-05-05 12:37:13.000000000 +1000
+++ .12664-linux-2.5.69.updated/kernel/module.c	2003-05-05 13:02:06.000000000 +1000
@@ -916,6 +916,8 @@ static void free_module(struct module *m
 	/* This may be NULL, but that's OK */
 	module_free(mod, mod->module_init);
 	kfree(mod->args);
+	if (mod->percpu)
+		kfree_percpu(mod->percpu);
 
 	/* Finally, free the core (containing the module structure) */
 	module_free(mod, mod->module_core);
@@ -942,10 +944,11 @@ static int simplify_symbols(Elf_Shdr *se
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
 
@@ -982,10 +985,12 @@ static int simplify_symbols(Elf_Shdr *se
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
@@ -1122,7 +1127,7 @@ static struct module *load_module(void _
 	char *secstrings, *args, *modmagic, *strtab = NULL;
 	unsigned int i, symindex = 0, strindex = 0, setupindex, exindex,
 		exportindex, modindex, obsparmindex, infoindex, gplindex,
-		crcindex, gplcrcindex, versindex;
+		crcindex, gplcrcindex, versindex, pcpuindex;
 	long arglen;
 	struct module *mod;
 	long err = 0;
@@ -1197,6 +1202,7 @@ static struct module *load_module(void _
 	obsparmindex = find_sec(hdr, sechdrs, secstrings, "__obsparm");
 	versindex = find_sec(hdr, sechdrs, secstrings, "__versions");
 	infoindex = find_sec(hdr, sechdrs, secstrings, ".modinfo");
+	pcpuindex = find_sec(hdr, sechdrs, secstrings, ".data.percpu");
 
 	/* Don't keep modinfo section */
 	sechdrs[infoindex].sh_flags &= ~(unsigned long)SHF_ALLOC;
@@ -1275,6 +1281,17 @@ static struct module *load_module(void _
 	memset(ptr, 0, mod->init_size);
 	mod->module_init = ptr;
 
+	if (pcpuindex) {
+		/* We have a special allocation for this section. */
+		mod->percpu = __alloc_percpu(sechdrs[pcpuindex].sh_size,
+					     sechdrs[pcpuindex].sh_addralign);
+		if (!mod->percpu) {
+			err = -ENOMEM;
+			goto free_init;
+		}
+		sechdrs[i].sh_flags &= ~(unsigned long)SHF_ALLOC;
+	}
+
 	/* Transfer each section which specifies SHF_ALLOC */
 	for (i = 0; i < hdr->e_shnum; i++) {
 		void *dest;
@@ -1304,7 +1321,8 @@ static struct module *load_module(void _
 	set_license(mod, get_modinfo(sechdrs, infoindex, "license"));
 
 	/* Fix up syms, so that st_value is a pointer to location. */
-	err = simplify_symbols(sechdrs, symindex, strtab, versindex, mod);
+	err = simplify_symbols(sechdrs, symindex, strtab, versindex, pcpuindex,
+			       mod);
 	if (err < 0)
 		goto cleanup;
 
@@ -1343,6 +1361,15 @@ static struct module *load_module(void _
 			goto cleanup;
 	}
 
+	/* Finally, copy percpu area over. */
+	if (pcpuindex) {
+		for (i = 0; i < NR_CPUS; i++)
+			if (cpu_possible(i))
+				memcpy(per_cpu_ptr(mod->percpu, i),
+				       (void *)sechdrs[pcpuindex].sh_addr,
+				       sechdrs[pcpuindex].sh_size);
+	}
+
 #ifdef CONFIG_KALLSYMS
 	mod->symtab = (void *)sechdrs[symindex].sh_addr;
 	mod->num_symtab = sechdrs[symindex].sh_size / sizeof(Elf_Sym);
@@ -1381,6 +1408,9 @@ static struct module *load_module(void _
 
  cleanup:
 	module_unload_free(mod);
+	if (mod->percpu)
+		kfree_percpu(mod->percpu);
+ free_init:
 	module_free(mod, mod->module_init);
  free_core:
 	module_free(mod, mod->module_core);
