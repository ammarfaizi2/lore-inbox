Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267687AbTBRHKJ>; Tue, 18 Feb 2003 02:10:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267690AbTBRHKJ>; Tue, 18 Feb 2003 02:10:09 -0500
Received: from dp.samba.org ([66.70.73.150]:15028 "EHLO lists.samba.org")
	by vger.kernel.org with ESMTP id <S267687AbTBRHKG>;
	Tue, 18 Feb 2003 02:10:06 -0500
From: Rusty Russell <rusty@rustcorp.com.au>
To: corbet@lwn.net (Jonathan Corbet)
Cc: linux-kernel@vger.kernel.org, rth@twiddle.net, davidm@hpl.hp.com,
       paulus@samba.org
Subject: Re: module changes 
In-reply-to: Your message of "Mon, 17 Feb 2003 14:32:21 PDT."
             <20030217213221.3103.qmail@eklektix.com> 
Date: Tue, 18 Feb 2003 18:19:38 +1100
Message-Id: <20030218072006.4C6502C054@lists.samba.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In message <20030217213221.3103.qmail@eklektix.com> you write:
> I had a quick question: is the inability to declare per-CPU variables in
> modules going to be permanent?

<sigh>

I'd really like to fix it, but that's *hard*.

<think think think, ask Paulus>

There might be a neater way, and there's definitely a more
space-efficient way, but this is a start (the wastage is small as long
as there are only a few per-cpu vars, as there are at the moment).

Rusty.
--
  Anyone who quotes me in their sig is an idiot. -- Rusty Russell.

Name: per-cpu support inside modules
Author: Rusty Russell
Status: Tested on 2.5.62

D: This adds percpu support for modules.  A module cannot have more
D: percpu data than the base kernel does (on my kernel 5636 bytes).
D: This version is quite wasteful: we could allocate them separately
D: in base-kernel-size chunks, and/or only allocate up to the max
D: cpu_possible() cpu, if we cared enough.

diff -urNp --exclude TAGS -X /home/rusty/current-dontdiff --minimal linux-2.5.62/include/asm-generic/percpu.h working-2.5.62-percpu-modules/include/asm-generic/percpu.h
--- linux-2.5.62/include/asm-generic/percpu.h	2003-01-02 12:32:47.000000000 +1100
+++ working-2.5.62-percpu-modules/include/asm-generic/percpu.h	2003-02-18 11:40:42.000000000 +1100
@@ -8,10 +8,8 @@
 extern unsigned long __per_cpu_offset[NR_CPUS];
 
 /* Separate out the type, so (int[3], foo) works. */
-#ifndef MODULE
 #define DEFINE_PER_CPU(type, name) \
     __attribute__((__section__(".data.percpu"))) __typeof__(type) name##__per_cpu
-#endif
 
 /* var is in discarded region: offset to particular copy we want */
 #define per_cpu(var, cpu) (*RELOC_HIDE(&var##__per_cpu, __per_cpu_offset[cpu]))
@@ -19,11 +17,8 @@ extern unsigned long __per_cpu_offset[NR
 
 #else /* ! SMP */
 
-/* Can't define per-cpu variables in modules.  Sorry --RR */
-#ifndef MODULE
 #define DEFINE_PER_CPU(type, name) \
     __typeof__(type) name##__per_cpu
-#endif
 
 #define per_cpu(var, cpu)			((void)cpu, var##__per_cpu)
 #define __get_cpu_var(var)			var##__per_cpu
diff -urNp --exclude TAGS -X /home/rusty/current-dontdiff --minimal linux-2.5.62/include/linux/module.h working-2.5.62-percpu-modules/include/linux/module.h
--- linux-2.5.62/include/linux/module.h	2003-02-18 11:18:56.000000000 +1100
+++ working-2.5.62-percpu-modules/include/linux/module.h	2003-02-18 13:43:06.000000000 +1100
@@ -264,6 +264,11 @@ struct module
 	char *strtab;
 #endif
 
+#ifdef CONFIG_SMP
+	/* How far into module_core is the per-cpu stuff (it's at the end) */
+	unsigned long percpu_offset;
+#endif
+
 	/* The command line arguments (may be mangled).  People like
 	   keeping pointers to this stuff */
 	char *args;
diff -urNp --exclude TAGS -X /home/rusty/current-dontdiff --minimal linux-2.5.62/kernel/module.c working-2.5.62-percpu-modules/kernel/module.c
--- linux-2.5.62/kernel/module.c	2003-02-18 11:18:57.000000000 +1100
+++ working-2.5.62-percpu-modules/kernel/module.c	2003-02-18 17:23:15.000000000 +1100
@@ -980,6 +980,66 @@ static long get_offset(unsigned long *si
 	return ret;
 }
 
+#ifdef CONFIG_SMP
+/* Created by linker magic */
+extern char __per_cpu_start[], __per_cpu_end[];
+
+static int add_percpu_area(Elf_Shdr *sechdrs,
+			   unsigned int pcpuindex,
+			   struct module *mod)
+{
+	unsigned long size;
+
+	if (!pcpuindex)
+		return 0;
+
+	/* We're stuck with the size used by the core kernel. */
+	size = ALIGN(__per_cpu_end - __per_cpu_start, SMP_CACHE_BYTES);
+	if (sechdrs[pcpuindex].sh_size > size) {
+		printk(KERN_ERR "%s: too much percpu data: %li vs %li\n",
+		       mod->name, (long)__per_cpu_end - (long)__per_cpu_start,
+		       (long)size);
+		return -EINVAL;
+	}
+	mod->core_size = ALIGN(mod->core_size, SMP_CACHE_BYTES);
+	mod->percpu_offset = mod->core_size;
+	mod->core_size += NR_CPUS * size;
+	return 0;
+}
+
+/* Size of section 0 is 0, so this is a noop if no percpu section */
+static void copy_percpu_area(Elf_Shdr *percpusec, struct module *mod)
+{
+	unsigned long i, size;
+
+	/* Duplicate the sections. */
+	size = ALIGN(__per_cpu_end - __per_cpu_start, SMP_CACHE_BYTES);
+	for (i = 0; i < NR_CPUS; i++)
+		memcpy(mod->module_core + mod->percpu_offset + size*i,
+		       (void *)percpusec->sh_addr,
+		       percpusec->sh_size);
+
+	/* Change address of per-cpu section so that address +
+           __per_cpu_offset[0] gives new location */
+	percpusec->sh_addr = (unsigned long)mod->module_core
+		+ mod->percpu_offset
+		- __per_cpu_offset[0];
+}
+#else
+static int add_percpu_area(Elf_Shdr *sechdrs,
+			   unsigned int pcpuindex,
+			   struct module *mod)
+{
+	/* Shouldn't be here on non-SMP, but act normally. */
+	if (pcpuindex)
+		sechdrs[pcpuindex].sh_flags |= SHF_ALLOC;
+	return 0;
+}
+static void copy_percpu_area(Elf_Shdr *percpusec, struct module *mod)
+{
+}
+#endif
+
 /* Lay out the SHF_ALLOC sections in a way not dissimilar to how ld
    might -- code, read-only data, read-write data, small data.  Tally
    sizes, and place the offsets into sh_entsize fields: high bit means it
@@ -1069,7 +1131,7 @@ static struct module *load_module(void *
 	char *secstrings, *args;
 	unsigned int i, symindex, exportindex, strindex, setupindex, exindex,
 		modindex, obsparmindex, licenseindex, gplindex, vmagindex,
-		crcindex, gplcrcindex, versindex;
+		crcindex, gplcrcindex, versindex, pcpuindex;
 	long arglen;
 	struct module *mod;
 	long err = 0;
@@ -1106,7 +1168,7 @@ static struct module *load_module(void *
 	/* May not export symbols, or have setup params, so these may
            not exist */
 	exportindex = setupindex = obsparmindex = gplindex = licenseindex 
-		= crcindex = gplcrcindex = versindex = 0;
+		= crcindex = gplcrcindex = versindex = pcpuindex = 0;
 
 	/* And these should exist, but gcc whinges if we don't init them */
 	symindex = strindex = exindex = modindex = vmagindex = 0;
@@ -1171,6 +1233,12 @@ static struct module *load_module(void *
 			licenseindex = i;
 			sechdrs[i].sh_flags &= ~(unsigned long)SHF_ALLOC;
 		} else if (strcmp(secstrings+sechdrs[i].sh_name,
+				  ".data.percpu") == 0) {
+			/* Per-cpu data. */
+			DEBUGP("Per-cpu data found in section %u\n", i);
+			pcpuindex = i;
+			sechdrs[i].sh_flags &= ~(unsigned long)SHF_ALLOC;
+		} else if (strcmp(secstrings+sechdrs[i].sh_name,
 				  "__vermagic") == 0 &&
 			   (sechdrs[i].sh_flags & SHF_ALLOC)) {
 			/* Version magic. */
@@ -1255,6 +1323,10 @@ static struct module *load_module(void *
 	   special cases for the architectures. */
 	layout_sections(mod, hdr, sechdrs, secstrings);
 
+	err = add_percpu_area(sechdrs, pcpuindex, mod);
+	if (err < 0)
+		goto free_mod;
+
 	/* Do the allocs. */
 	ptr = module_alloc(mod->core_size);
 	if (!ptr) {
@@ -1294,6 +1366,9 @@ static struct module *load_module(void *
 	/* Module has been moved. */
 	mod = (void *)sechdrs[modindex].sh_addr;
 
+	/* Copy the per-cpu variables across for each CPU. */
+	copy_percpu_area(&sechdrs[pcpuindex], mod);
+
 	/* Now we've moved module, initialize linked lists, etc. */
 	module_unload_init(mod);
 
