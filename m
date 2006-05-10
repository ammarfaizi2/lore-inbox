Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964784AbWEJDcy@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964784AbWEJDcy (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 9 May 2006 23:32:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964786AbWEJDcy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 9 May 2006 23:32:54 -0400
Received: from ozlabs.org ([203.10.76.45]:3464 "EHLO ozlabs.org")
	by vger.kernel.org with ESMTP id S964784AbWEJDcw (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 9 May 2006 23:32:52 -0400
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <17505.24288.11207.982907@cargo.ozlabs.ibm.com>
Date: Wed, 10 May 2006 13:32:48 +1000
From: Paul Mackerras <paulus@samba.org>
To: akpm@osdl.org, linux-kernel@vger.kernel.org
CC: linux-arch@vger.kernel.org, rusty@rustcorp.com.au
Subject: [PATCH] Allow for per-cpu data being in .tdata and .tbss sections
X-Mailer: VM 7.19 under Emacs 21.4.1
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This lays the groundwork for using __thread for per-cpu variables.
The toolchain will put initialized __thread variables into a .tdata
section, and uninitialized __thread variables into a .tbss section.
Thus the module loader needs to cope with two per-cpu sections, of
which one is initialized and the other must be zeroed.

With this patch, the module loader looks for .tdata and .tbss, and if
it finds neither, falls back to the .data.percpu section that we
currently use.  This patch extends the various percpu_modcopy
implementations to take two size parameters: the first is the amount
to initialize and the second is the amount to zero following that.
At the moment all percpu_modcopy implementations simply check that
the amount to zero is zero.

I have a following patch that makes 64-bit powerpc use __thread for
per-cpu variables.

Signed-off-by: Paul Mackerras <paulus@samba.org>
---
diff --git a/arch/ia64/kernel/module.c b/arch/ia64/kernel/module.c
index 3a30cfc..88790f4 100644
--- a/arch/ia64/kernel/module.c
+++ b/arch/ia64/kernel/module.c
@@ -944,9 +944,11 @@ module_arch_cleanup (struct module *mod)
 
 #ifdef CONFIG_SMP
 void
-percpu_modcopy (void *pcpudst, const void *src, unsigned long size)
+percpu_modcopy (void *pcpudst, const void *src, unsigned long size,
+		unsigned long zero_size)
 {
 	unsigned int i;
+	BUG_ON(zero_size != 0);
 	for_each_possible_cpu(i) {
 		memcpy(pcpudst + __per_cpu_offset[i], src, size);
 	}
diff --git a/include/asm-ia64/percpu.h b/include/asm-ia64/percpu.h
index 4bfbeb4..f0a679e 100644
--- a/include/asm-ia64/percpu.h
+++ b/include/asm-ia64/percpu.h
@@ -45,7 +45,8 @@ #define per_cpu(var, cpu)  (*RELOC_HIDE(
 #define __get_cpu_var(var) (*RELOC_HIDE(&per_cpu__##var, __ia64_per_cpu_var(local_per_cpu_offset)))
 #define __raw_get_cpu_var(var) (*RELOC_HIDE(&per_cpu__##var, __ia64_per_cpu_var(local_per_cpu_offset)))
 
-extern void percpu_modcopy(void *pcpudst, const void *src, unsigned long size);
+extern void percpu_modcopy(void *pcpudst, const void *src,
+			   unsigned long init_sz, unsigned long zero_sz);
 extern void setup_per_cpu_areas (void);
 extern void *per_cpu_init(void);
 
diff --git a/include/asm-powerpc/percpu.h b/include/asm-powerpc/percpu.h
index faa1fc7..5d603ff 100644
--- a/include/asm-powerpc/percpu.h
+++ b/include/asm-powerpc/percpu.h
@@ -25,9 +25,10 @@ #define __get_cpu_var(var) (*RELOC_HIDE(
 #define __raw_get_cpu_var(var) (*RELOC_HIDE(&per_cpu__##var, __my_cpu_offset()))
 
 /* A macro to avoid #include hell... */
-#define percpu_modcopy(pcpudst, src, size)			\
+#define percpu_modcopy(pcpudst, src, size, zero_size)		\
 do {								\
 	unsigned int __i;					\
+	BUG_ON(zero_size != 0);					\
 	for_each_possible_cpu(__i)				\
 		memcpy((pcpudst)+__per_cpu_offset(__i),		\
 		       (src), (size));				\
diff --git a/include/asm-s390/percpu.h b/include/asm-s390/percpu.h
index d9a8cca..c443986 100644
--- a/include/asm-s390/percpu.h
+++ b/include/asm-s390/percpu.h
@@ -44,9 +44,10 @@ #define __raw_get_cpu_var(var) __reloc_h
 #define per_cpu(var,cpu) __reloc_hide(var,__per_cpu_offset[cpu])
 
 /* A macro to avoid #include hell... */
-#define percpu_modcopy(pcpudst, src, size)			\
+#define percpu_modcopy(pcpudst, src, size, zero_size)		\
 do {								\
 	unsigned int __i;					\
+	BUG_ON(zero_size != 0);					\
 	for_each_possible_cpu(__i)				\
 		memcpy((pcpudst)+__per_cpu_offset[__i],		\
 		       (src), (size));				\
diff --git a/include/asm-sparc64/percpu.h b/include/asm-sparc64/percpu.h
index a6ece06..21f9b01 100644
--- a/include/asm-sparc64/percpu.h
+++ b/include/asm-sparc64/percpu.h
@@ -24,9 +24,10 @@ #define __get_cpu_var(var) (*RELOC_HIDE(
 #define __raw_get_cpu_var(var) (*RELOC_HIDE(&per_cpu__##var, __local_per_cpu_offset))
 
 /* A macro to avoid #include hell... */
-#define percpu_modcopy(pcpudst, src, size)			\
+#define percpu_modcopy(pcpudst, src, size, zero_size)		\
 do {								\
 	unsigned int __i;					\
+	BUG_ON(zero_size != 0);					\
 	for_each_possible_cpu(__i)				\
 		memcpy((pcpudst)+__per_cpu_offset(__i),		\
 		       (src), (size));				\
diff --git a/include/asm-x86_64/percpu.h b/include/asm-x86_64/percpu.h
index 549eb92..0e6ffde 100644
--- a/include/asm-x86_64/percpu.h
+++ b/include/asm-x86_64/percpu.h
@@ -24,9 +24,10 @@ #define __get_cpu_var(var) (*RELOC_HIDE(
 #define __raw_get_cpu_var(var) (*RELOC_HIDE(&per_cpu__##var, __my_cpu_offset()))
 
 /* A macro to avoid #include hell... */
-#define percpu_modcopy(pcpudst, src, size)			\
+#define percpu_modcopy(pcpudst, src, size, zero_size)		\
 do {								\
 	unsigned int __i;					\
+	BUG_ON(zero_size != 0);					\
 	for_each_possible_cpu(__i)				\
 		memcpy((pcpudst)+__per_cpu_offset(__i),		\
 		       (src), (size));				\
diff --git a/kernel/module.c b/kernel/module.c
index d24deb0..4986e06 100644
--- a/kernel/module.c
+++ b/kernel/module.c
@@ -354,11 +354,28 @@ static void percpu_modfree(void *freeme)
 	}
 }
 
-static unsigned int find_pcpusec(Elf_Ehdr *hdr,
-				 Elf_Shdr *sechdrs,
-				 const char *secstrings)
-{
-	return find_sec(hdr, sechdrs, secstrings, ".data.percpu");
+static void find_pcpusecs(Elf_Ehdr *hdr,
+			  Elf_Shdr *sechdrs,
+			  const char *secstrings,
+			  unsigned int pcpuindex[2])
+{
+	/*
+	 * Some architectures use __thread for per-cpu variables,
+	 * and that generates .tdata and .tbss sections.
+	 */
+	pcpuindex[0] = find_sec(hdr, sechdrs, secstrings, ".tdata");
+	pcpuindex[1] = find_sec(hdr, sechdrs, secstrings, ".tbss");
+	if (pcpuindex[0])
+		return;
+	if (pcpuindex[1] && !pcpuindex[0]) {
+		/* move .tbss to pcpuindex[0], it makes things easier later */
+		pcpuindex[0] = pcpuindex[1];
+		pcpuindex[1] = 0;
+		return;
+	}
+
+	/* look for the generic .data.percpu if no .tdata */
+	pcpuindex[0] = find_sec(hdr, sechdrs, secstrings, ".data.percpu");
 }
 
 static int percpu_modinit(void)
@@ -389,17 +406,20 @@ static inline void percpu_modfree(void *
 {
 	BUG();
 }
-static inline unsigned int find_pcpusec(Elf_Ehdr *hdr,
-					Elf_Shdr *sechdrs,
-					const char *secstrings)
+static inline void find_pcpusecs(Elf_Ehdr *hdr,
+				 Elf_Shdr *sechdrs,
+				 const char *secstrings,
+				 unsigned int pcpuindex[2])
 {
-	return 0;
+	pcpuindex[0] = 0;
+	pcpuindex[1] = 0;
 }
 static inline void percpu_modcopy(void *pcpudst, const void *src,
-				  unsigned long size)
+				  unsigned long init_sz, unsigned long zero_sz)
 {
-	/* pcpusec should be 0, and size of that section should be 0. */
-	BUG_ON(size != 0);
+	/* there should be no per-cpu data to copy or clear */
+	BUG_ON(init_sz != 0);
+	BUG_ON(zero_sz != 0);
 }
 #endif /* CONFIG_SMP */
 
@@ -1121,7 +1141,7 @@ static int simplify_symbols(Elf_Shdr *se
 			    unsigned int symindex,
 			    const char *strtab,
 			    unsigned int versindex,
-			    unsigned int pcpuindex,
+			    unsigned int pcpuindex[2],
 			    struct module *mod)
 {
 	Elf_Sym *sym = (void *)sechdrs[symindex].sh_addr;
@@ -1165,9 +1185,13 @@ static int simplify_symbols(Elf_Shdr *se
 
 		default:
 			/* Divert to percpu allocation if a percpu var. */
-			if (sym[i].st_shndx == pcpuindex)
+			if (sym[i].st_shndx == pcpuindex[0])
 				secbase = (unsigned long)mod->percpu;
-			else
+			else if (sym[i].st_shndx == pcpuindex[1]) {
+				/* .tbss follows .tdata */
+				secbase = (unsigned long)mod->percpu
+					+ sechdrs[pcpuindex[0]].sh_size;
+			} else
 				secbase = sechdrs[sym[i].st_shndx].sh_addr;
 			sym[i].st_value += secbase;
 			break;
@@ -1411,8 +1435,9 @@ static struct module *load_module(void _
 	char *secstrings, *args, *modmagic, *strtab = NULL;
 	unsigned int i, symindex = 0, strindex = 0, setupindex, exindex,
 		exportindex, modindex, obsparmindex, infoindex, gplindex,
-		crcindex, gplcrcindex, versindex, pcpuindex, gplfutureindex,
+		crcindex, gplcrcindex, versindex, pcpuindex[2], gplfutureindex,
 		gplfuturecrcindex;
+	unsigned int pcpusize = 0, pcpuinitsize = 0;
 	struct module *mod;
 	long err = 0;
 	void *percpu = NULL, *ptr = NULL; /* Stops spurious gcc warning */
@@ -1501,7 +1526,7 @@ #endif
 	obsparmindex = find_sec(hdr, sechdrs, secstrings, "__obsparm");
 	versindex = find_sec(hdr, sechdrs, secstrings, "__versions");
 	infoindex = find_sec(hdr, sechdrs, secstrings, ".modinfo");
-	pcpuindex = find_pcpusec(hdr, sechdrs, secstrings);
+	find_pcpusecs(hdr, sechdrs, secstrings, pcpuindex);
 
 	/* Don't keep modinfo section */
 	sechdrs[infoindex].sh_flags &= ~(unsigned long)SHF_ALLOC;
@@ -1548,17 +1573,33 @@ #endif
 	err = module_frob_arch_sections(hdr, sechdrs, secstrings, mod);
 	if (err < 0)
 		goto free_mod;
+
+	if (pcpuindex[0]) {
+		/* We have a special allocation for these sections. */
+		unsigned int align = 0;
+		int i, j;
 
-	if (pcpuindex) {
-		/* We have a special allocation for this section. */
-		percpu = percpu_modalloc(sechdrs[pcpuindex].sh_size,
-					 sechdrs[pcpuindex].sh_addralign,
-					 mod->name);
+		i = pcpuindex[0];
+		pcpusize = sechdrs[i].sh_size;
+		align = sechdrs[i].sh_addralign;
+		sechdrs[i].sh_flags &= ~(unsigned long)SHF_ALLOC;
+		if (sechdrs[i].sh_type != SHT_NOBITS)
+			pcpuinitsize = pcpusize;
+		if (pcpuindex[1]) {
+			/* have both .tdata and .tbss */
+			j = pcpuindex[1];
+			pcpusize = ALIGN(pcpusize, sechdrs[j].sh_addralign);
+			sechdrs[i].sh_size = pcpusize;
+			if (sechdrs[j].sh_addralign > align)
+				align = sechdrs[j].sh_addralign;
+			pcpusize += sechdrs[j].sh_size;
+			sechdrs[j].sh_flags &= ~(unsigned long)SHF_ALLOC;
+		}
+		percpu = percpu_modalloc(pcpusize, align, mod->name);
 		if (!percpu) {
 			err = -ENOMEM;
 			goto free_mod;
 		}
-		sechdrs[pcpuindex].sh_flags &= ~(unsigned long)SHF_ALLOC;
 		mod->percpu = percpu;
 	}
 
@@ -1687,8 +1728,8 @@ #endif
 	sort_extable(extable, extable + mod->num_exentries);
 
 	/* Finally, copy percpu area over. */
-	percpu_modcopy(mod->percpu, (void *)sechdrs[pcpuindex].sh_addr,
-		       sechdrs[pcpuindex].sh_size);
+	percpu_modcopy(mod->percpu, (void *)sechdrs[pcpuindex[0]].sh_addr,
+		       pcpuinitsize, pcpusize - pcpuinitsize);
 
 	add_kallsyms(mod, sechdrs, symindex, strindex, secstrings);
 
