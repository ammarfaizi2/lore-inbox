Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263552AbTETEto (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 20 May 2003 00:49:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263568AbTETEto
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 20 May 2003 00:49:44 -0400
Received: from dp.samba.org ([66.70.73.150]:6847 "EHLO lists.samba.org")
	by vger.kernel.org with ESMTP id S263552AbTETEtj (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 20 May 2003 00:49:39 -0400
From: Rusty Russell <rusty@rustcorp.com.au>
To: akpm@zip.com.au
Cc: linux-kernel@vger.kernel.org, David Mosberger-Tang <davidm@hpl.hp.com>,
       Dipankar Sarma <dipankar@in.ibm.com>
Subject: [PATCH 5/3] per-cpu sections inside modules
Date: Tue, 20 May 2003 15:01:30 +1000
Message-Id: <20030520050238.CEF8F2C09D@lists.samba.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Requires the last 4 patches.

Name: per-cpu support inside modules
Author: Rusty Russell
Status: Tested on 2.5.69-bk13
Depends: Misc/kmalloc_percpu-full.patch.gz

D: This adds percpu support for modules.

diff -urpN --exclude TAGS -X /home/rusty/devel/kernel/kernel-patches/current-dontdiff --minimal .22478-2.5.69-bk13-module-percpu.pre/include/asm-generic/percpu.h .22478-2.5.69-bk13-module-percpu/include/asm-generic/percpu.h
--- .22478-2.5.69-bk13-module-percpu.pre/include/asm-generic/percpu.h	2003-05-20 14:58:41.000000000 +1000
+++ .22478-2.5.69-bk13-module-percpu/include/asm-generic/percpu.h	2003-05-20 14:58:42.000000000 +1000
@@ -5,10 +5,8 @@
 #ifdef CONFIG_SMP
 
 /* Separate out the type, so (int[3], foo) works. */
-#ifndef MODULE
 #define DEFINE_PER_CPU(type, name) \
     __attribute__((__section__(".data.percpu"))) __typeof__(type) name##__per_cpu
-#endif
 
 #define __get_cpu_var(var) per_cpu(var, smp_processor_id())
 #define __get_cpu_ptr(ptr) per_cpu_ptr(ptr, smp_processor_id())
diff -urpN --exclude TAGS -X /home/rusty/devel/kernel/kernel-patches/current-dontdiff --minimal .22478-2.5.69-bk13-module-percpu.pre/include/asm-ia64/percpu.h .22478-2.5.69-bk13-module-percpu/include/asm-ia64/percpu.h
--- .22478-2.5.69-bk13-module-percpu.pre/include/asm-ia64/percpu.h	2003-05-20 14:58:41.000000000 +1000
+++ .22478-2.5.69-bk13-module-percpu/include/asm-ia64/percpu.h	2003-05-20 14:58:42.000000000 +1000
@@ -18,10 +18,8 @@
 #include <linux/threads.h>
 
 #ifdef CONFIG_SMP
-#ifndef MODULE
 #define DEFINE_PER_CPU(type, name) \
     __attribute__((__section__(".data.percpu"))) __typeof__(type) name##__per_cpu
-#endif
 
 #define __get_cpu_var(var)	(var##__per_cpu)
 #define __get_cpu_ptr(ptr)	(ptr)
diff -urpN --exclude TAGS -X /home/rusty/devel/kernel/kernel-patches/current-dontdiff --minimal .22478-2.5.69-bk13-module-percpu.pre/include/linux/module.h .22478-2.5.69-bk13-module-percpu/include/linux/module.h
--- .22478-2.5.69-bk13-module-percpu.pre/include/linux/module.h	2003-05-05 12:37:12.000000000 +1000
+++ .22478-2.5.69-bk13-module-percpu/include/linux/module.h	2003-05-20 14:58:42.000000000 +1000
@@ -247,6 +247,9 @@ struct module
 	char *strtab;
 #endif
 
+	/* Per-cpu data. */
+	void *percpu;
+
 	/* The command line arguments (may be mangled).  People like
 	   keeping pointers to this stuff */
 	char *args;
diff -urpN --exclude TAGS -X /home/rusty/devel/kernel/kernel-patches/current-dontdiff --minimal .22478-2.5.69-bk13-module-percpu.pre/include/linux/percpu.h .22478-2.5.69-bk13-module-percpu/include/linux/percpu.h
--- .22478-2.5.69-bk13-module-percpu.pre/include/linux/percpu.h	2003-05-20 14:58:41.000000000 +1000
+++ .22478-2.5.69-bk13-module-percpu/include/linux/percpu.h	2003-05-20 14:58:42.000000000 +1000
@@ -44,11 +44,8 @@ static inline void free_percpu(const voi
 	kfree(ptr);
 }
 
-/* Can't define per-cpu variables in modules.  Sorry --RR */
-#ifndef MODULE
 #define DEFINE_PER_CPU(type, name) \
     __typeof__(type) name##__per_cpu
-#endif
 
 #define per_cpu(var, cpu)			((void)cpu, var##__per_cpu)
 #define __get_cpu_var(var)			var##__per_cpu
diff -urpN --exclude TAGS -X /home/rusty/devel/kernel/kernel-patches/current-dontdiff --minimal .22478-2.5.69-bk13-module-percpu.pre/kernel/module.c .22478-2.5.69-bk13-module-percpu/kernel/module.c
--- .22478-2.5.69-bk13-module-percpu.pre/kernel/module.c	2003-05-19 10:53:51.000000000 +1000
+++ .22478-2.5.69-bk13-module-percpu/kernel/module.c	2003-05-20 14:58:42.000000000 +1000
@@ -913,6 +913,8 @@ static void free_module(struct module *m
 	/* This may be NULL, but that's OK */
 	module_free(mod, mod->module_init);
 	kfree(mod->args);
+	if (mod->percpu)
+		free_percpu(mod->percpu);
 
 	/* Finally, free the core (containing the module structure) */
 	module_free(mod, mod->module_core);
@@ -939,10 +941,11 @@ static int simplify_symbols(Elf_Shdr *se
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
 
@@ -979,10 +982,12 @@ static int simplify_symbols(Elf_Shdr *se
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
@@ -1119,7 +1124,7 @@ static struct module *load_module(void _
 	char *secstrings, *args, *modmagic, *strtab = NULL;
 	unsigned int i, symindex = 0, strindex = 0, setupindex, exindex,
 		exportindex, modindex, obsparmindex, infoindex, gplindex,
-		crcindex, gplcrcindex, versindex;
+		crcindex, gplcrcindex, versindex, pcpuindex;
 	long arglen;
 	struct module *mod;
 	long err = 0;
@@ -1194,6 +1199,7 @@ static struct module *load_module(void _
 	obsparmindex = find_sec(hdr, sechdrs, secstrings, "__obsparm");
 	versindex = find_sec(hdr, sechdrs, secstrings, "__versions");
 	infoindex = find_sec(hdr, sechdrs, secstrings, ".modinfo");
+	pcpuindex = find_sec(hdr, sechdrs, secstrings, ".data.percpu");
 
 	/* Don't keep modinfo section */
 	sechdrs[infoindex].sh_flags &= ~(unsigned long)SHF_ALLOC;
@@ -1272,6 +1278,17 @@ static struct module *load_module(void _
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
 	DEBUGP("final section addresses:\n");
 	for (i = 0; i < hdr->e_shnum; i++) {
@@ -1303,7 +1320,8 @@ static struct module *load_module(void _
 	set_license(mod, get_modinfo(sechdrs, infoindex, "license"));
 
 	/* Fix up syms, so that st_value is a pointer to location. */
-	err = simplify_symbols(sechdrs, symindex, strtab, versindex, mod);
+	err = simplify_symbols(sechdrs, symindex, strtab, versindex, pcpuindex,
+			       mod);
 	if (err < 0)
 		goto cleanup;
 
@@ -1342,6 +1360,15 @@ static struct module *load_module(void _
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
@@ -1380,6 +1407,9 @@ static struct module *load_module(void _
 
  cleanup:
 	module_unload_free(mod);
+	if (mod->percpu)
+		free_percpu(mod->percpu);
+ free_init:
 	module_free(mod, mod->module_init);
  free_core:
 	module_free(mod, mod->module_core);
diff -urpN --exclude TAGS -X /home/rusty/devel/kernel/kernel-patches/current-dontdiff --minimal .22478-2.5.69-bk13-module-percpu.pre/net/ipv4/netfilter/ip_conntrack_core.c .22478-2.5.69-bk13-module-percpu/net/ipv4/netfilter/ip_conntrack_core.c
--- .22478-2.5.69-bk13-module-percpu.pre/net/ipv4/netfilter/ip_conntrack_core.c	2003-05-19 10:53:53.000000000 +1000
+++ .22478-2.5.69-bk13-module-percpu/net/ipv4/netfilter/ip_conntrack_core.c	2003-05-20 14:58:42.000000000 +1000
@@ -1402,11 +1402,23 @@ void ip_conntrack_cleanup(void)
 static int hashsize = 0;
 MODULE_PARM(hashsize, "i");
 
+#include <linux/percpu.h>
+DEFINE_PER_CPU(int, percpu_int) = 7;
+
 int __init ip_conntrack_init(void)
 {
 	unsigned int i;
 	int ret;
 
+	for (i = 0; i < NR_CPUS; i++) {
+		if (!cpu_possible(i))
+			continue;
+		printk("cpu %u: value %p = %i\n", i, &per_cpu(percpu_int, i),
+		       per_cpu(percpu_int, i));
+		per_cpu(percpu_int, i) += i;
+		printk("cpu %u: value now %i\n", i, per_cpu(percpu_int, i));
+	}
+
 	/* Idea from tcp.c: use 1/16384 of memory.  On i386: 32MB
 	 * machine has 256 buckets.  >= 1GB machines have 8192 buckets. */
  	if (hashsize) {

--
  Anyone who quotes me in their sig is an idiot. -- Rusty Russell.
