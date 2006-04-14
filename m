Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965176AbWDNVTj@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965176AbWDNVTj (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 14 Apr 2006 17:19:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965171AbWDNVTP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 14 Apr 2006 17:19:15 -0400
Received: from ms-smtp-01.nyroc.rr.com ([24.24.2.55]:23202 "EHLO
	ms-smtp-01.nyroc.rr.com") by vger.kernel.org with ESMTP
	id S965170AbWDNVTL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 14 Apr 2006 17:19:11 -0400
Subject: [PATCH 02/05] percpu module insertion
From: Steven Rostedt <rostedt@goodmis.org>
To: LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain
Date: Fri, 14 Apr 2006 17:19:09 -0400
Message-Id: <1145049549.1336.130.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.4.2.1 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Simplify module.c handling of the per_cpu variables of modules.
Instead of copying the variables into a preallocated space in the
kernel, create the modules own area for per_cpu variables and update
the per_cpu_offset__##var section of the module to point to the
offset.

Signed-off-by: Steven Rostedt <rostedt@goodmis.org>

Index: linux-2.6.17-rc1/kernel/module.c
===================================================================
--- linux-2.6.17-rc1.orig/kernel/module.c	2006-04-13 22:37:57.000000000 -0400
+++ linux-2.6.17-rc1/kernel/module.c	2006-04-14 15:40:20.000000000 -0400
@@ -2,6 +2,10 @@
    Copyright (C) 2002 Richard Henderson
    Copyright (C) 2001 Rusty Russell, 2002 Rusty Russell IBM.
 
+   Modification of per_cpu variables such that modules contain
+   their own sections of these variables.
+     -  Copyright(C) 2006 Steven Rostedt, Kihon Technologies Inc.
+
     This program is free software; you can redistribute it and/or modify
     it under the terms of the GNU General Public License as published by
     the Free Software Foundation; either version 2 of the License, or
@@ -237,36 +241,6 @@ static struct module *find_module(const 
 }
 
 #ifdef CONFIG_SMP
-/* Number of blocks used and allocated. */
-static unsigned int pcpu_num_used, pcpu_num_allocated;
-/* Size of each block.  -ve means used. */
-static int *pcpu_size;
-
-static int split_block(unsigned int i, unsigned short size)
-{
-	/* Reallocation required? */
-	if (pcpu_num_used + 1 > pcpu_num_allocated) {
-		int *new = kmalloc(sizeof(new[0]) * pcpu_num_allocated*2,
-				   GFP_KERNEL);
-		if (!new)
-			return 0;
-
-		memcpy(new, pcpu_size, sizeof(new[0])*pcpu_num_allocated);
-		pcpu_num_allocated *= 2;
-		kfree(pcpu_size);
-		pcpu_size = new;
-	}
-
-	/* Insert a new subblock */
-	memmove(&pcpu_size[i+1], &pcpu_size[i],
-		sizeof(pcpu_size[0]) * (pcpu_num_used - i));
-	pcpu_num_used++;
-
-	pcpu_size[i+1] -= size;
-	pcpu_size[i] = size;
-	return 1;
-}
-
 static inline unsigned int block_size(int val)
 {
 	if (val < 0)
@@ -280,8 +254,6 @@ extern char __per_cpu_start[], __per_cpu
 static void *percpu_modalloc(unsigned long size, unsigned long align,
 			     const char *name)
 {
-	unsigned long extra;
-	unsigned int i;
 	void *ptr;
 
 	if (align > SMP_CACHE_BYTES) {
@@ -289,68 +261,65 @@ static void *percpu_modalloc(unsigned lo
 		       name, align, SMP_CACHE_BYTES);
 		align = SMP_CACHE_BYTES;
 	}
+	size = ALIGN(size, SMP_CACHE_BYTES);
+
+	ptr = kmalloc(size * NR_CPUS, GFP_KERNEL);
+	if (!ptr)
+		printk(KERN_WARNING "Could not allocate %lu bytes percpu data\n",
+		       size);
+	return ptr;
+}
 
-	ptr = __per_cpu_start;
-	for (i = 0; i < pcpu_num_used; ptr += block_size(pcpu_size[i]), i++) {
-		/* Extra for alignment requirement. */
-		extra = ALIGN((unsigned long)ptr, align) - (unsigned long)ptr;
-		BUG_ON(i == 0 && extra != 0);
+static void percpu_modfree(void *freeme, void *freemetoo)
+{
+	kfree(freeme);
+	kfree(freemetoo);
+}
 
-		if (pcpu_size[i] < 0 || pcpu_size[i] < extra + size)
-			continue;
+static void *percpu_offset_setup(void *dest,
+				 unsigned long var_size,
+				 unsigned long sect_size)
+{
+	unsigned long *ptr = dest;
+	unsigned long *per_cpu_offset;
+	int i;
 
-		/* Transfer extra to previous block. */
-		if (pcpu_size[i-1] < 0)
-			pcpu_size[i-1] -= extra;
-		else
-			pcpu_size[i-1] += extra;
-		pcpu_size[i] -= extra;
-		ptr += extra;
-
-		/* Split block if warranted */
-		if (pcpu_size[i] - size > sizeof(unsigned long))
-			if (!split_block(i, size))
-				return NULL;
-
-		/* Mark allocated */
-		pcpu_size[i] = -pcpu_size[i];
-		return ptr;
-	}
+	/* make sure everything is smp cache aligned */
+	var_size = ALIGN(var_size, SMP_CACHE_BYTES);
 
-	printk(KERN_WARNING "Could not allocate %lu bytes percpu data\n",
-	       size);
-	return NULL;
+	/* allocate the modules own per_cpu_offset pointer */
+	per_cpu_offset = kmalloc(sizeof(unsigned long) * NR_CPUS, GFP_KERNEL);
+	if (!per_cpu_offset)
+		return NULL;
+
+	/* Set the pointer to the index of each CPU area */
+	for (i = 0; i < NR_CPUS; i++)
+		per_cpu_offset[i] = (i * var_size);
+
+	/*
+	 * Now copy this offset to all of the percpu_offset pointers in the
+	 * percpu_offset section. This is how the per_cpu variables can find
+	 * the offset into this section from the per_cpu macros.
+	 */
+	for (i=0; i < sect_size; i++, ptr++)
+		*ptr = (unsigned long)per_cpu_offset;
+
+	return per_cpu_offset;
 }
 
-static void percpu_modfree(void *freeme)
+static void percpu_modcopy(void *pcpudst, const void *src,
+			   unsigned long size,
+			   unsigned long *per_cpu_offset)
 {
 	unsigned int i;
-	void *ptr = __per_cpu_start + block_size(pcpu_size[0]);
 
-	/* First entry is core kernel percpu data. */
-	for (i = 1; i < pcpu_num_used; ptr += block_size(pcpu_size[i]), i++) {
-		if (ptr == freeme) {
-			pcpu_size[i] = -pcpu_size[i];
-			goto free;
-		}
-	}
-	BUG();
+	if (!pcpudst)
+		return;
 
- free:
-	/* Merge with previous? */
-	if (pcpu_size[i-1] >= 0) {
-		pcpu_size[i-1] += pcpu_size[i];
-		pcpu_num_used--;
-		memmove(&pcpu_size[i], &pcpu_size[i+1],
-			(pcpu_num_used - i) * sizeof(pcpu_size[0]));
-		i--;
-	}
-	/* Merge with next? */
-	if (i+1 < pcpu_num_used && pcpu_size[i+1] >= 0) {
-		pcpu_size[i] += pcpu_size[i+1];
-		pcpu_num_used--;
-		memmove(&pcpu_size[i+1], &pcpu_size[i+2],
-			(pcpu_num_used - (i+1)) * sizeof(pcpu_size[0]));
+	for (i=0; i < NR_CPUS; i++) {
+		if (cpu_possible(i))
+			memcpy(pcpudst + per_cpu_offset[i],
+			       src, size);
 	}
 }
 
@@ -361,24 +330,13 @@ static unsigned int find_pcpusec(Elf_Ehd
 	return find_sec(hdr, sechdrs, secstrings, ".data.percpu");
 }
 
-static int percpu_modinit(void)
+static unsigned int find_pcpuoffsetsec(Elf_Ehdr *hdr,
+				       Elf_Shdr *sechdrs,
+				       const char *secstrings)
 {
-	pcpu_num_used = 2;
-	pcpu_num_allocated = 2;
-	pcpu_size = kmalloc(sizeof(pcpu_size[0]) * pcpu_num_allocated,
-			    GFP_KERNEL);
-	/* Static in-kernel percpu data (used). */
-	pcpu_size[0] = -ALIGN(__per_cpu_end-__per_cpu_start, SMP_CACHE_BYTES);
-	/* Free room. */
-	pcpu_size[1] = PERCPU_ENOUGH_ROOM + pcpu_size[0];
-	if (pcpu_size[1] < 0) {
-		printk(KERN_ERR "No per-cpu room for modules.\n");
-		pcpu_num_used = 1;
-	}
+	return find_sec(hdr, sechdrs, secstrings, ".data.percpu_offset");
+}
 
-	return 0;
-}	
-__initcall(percpu_modinit);
 #else /* ... !CONFIG_SMP */
 static inline void *percpu_modalloc(unsigned long size, unsigned long align,
 				    const char *name)
@@ -389,14 +347,29 @@ static inline void percpu_modfree(void *
 {
 	BUG();
 }
+
+static inline void *percpu_offset_setup(void *dest,
+					unsigned long var_size,
+					unsigned long sect_size)
+{
+	return NULL;
+}
+
 static inline unsigned int find_pcpusec(Elf_Ehdr *hdr,
 					Elf_Shdr *sechdrs,
 					const char *secstrings)
 {
 	return 0;
 }
+static inline unsigned int find_pcpuoffsetsec(Elf_Ehdr *hdr,
+					      Elf_Shdr *sechdrs,
+					      const char *secstrings)
+{
+	return 0;
+}
 static inline void percpu_modcopy(void *pcpudst, const void *src,
-				  unsigned long size)
+				  unsigned long size,
+				  unsigned long *per_cpu_offset)
 {
 	/* pcpusec should be 0, and size of that section should be 0. */
 	BUG_ON(size != 0);
@@ -1061,7 +1034,7 @@ static void free_module(struct module *m
 	module_free(mod, mod->module_init);
 	kfree(mod->args);
 	if (mod->percpu)
-		percpu_modfree(mod->percpu);
+		percpu_modfree(mod->percpu, mod->percpu_offset);
 
 	/* Finally, free the core (containing the module structure) */
 	module_free(mod, mod->module_core);
@@ -1411,13 +1384,14 @@ static struct module *load_module(void _
 	char *secstrings, *args, *modmagic, *strtab = NULL;
 	unsigned int i, symindex = 0, strindex = 0, setupindex, exindex,
 		exportindex, modindex, obsparmindex, infoindex, gplindex,
-		crcindex, gplcrcindex, versindex, pcpuindex, gplfutureindex,
-		gplfuturecrcindex;
+		crcindex, gplcrcindex, versindex, pcpuindex, pcpuoffsetindex,
+		gplfutureindex,	gplfuturecrcindex;
 	struct module *mod;
 	long err = 0;
 	void *percpu = NULL, *ptr = NULL; /* Stops spurious gcc warning */
 	struct exception_table_entry *extable;
 	mm_segment_t old_fs;
+	unsigned long *percpu_offset = NULL;
 
 	DEBUGP("load_module: umod=%p, len=%lu, uargs=%p\n",
 	       umod, len, uargs);
@@ -1502,6 +1476,7 @@ static struct module *load_module(void _
 	versindex = find_sec(hdr, sechdrs, secstrings, "__versions");
 	infoindex = find_sec(hdr, sechdrs, secstrings, ".modinfo");
 	pcpuindex = find_pcpusec(hdr, sechdrs, secstrings);
+	pcpuoffsetindex = find_pcpuoffsetsec(hdr, sechdrs, secstrings);
 
 	/* Don't keep modinfo section */
 	sechdrs[infoindex].sh_flags &= ~(unsigned long)SHF_ALLOC;
@@ -1550,6 +1525,7 @@ static struct module *load_module(void _
 		goto free_mod;
 
 	if (pcpuindex) {
+		BUG_ON(!pcpuoffsetindex);
 		/* We have a special allocation for this section. */
 		percpu = percpu_modalloc(sechdrs[pcpuindex].sh_size,
 					 sechdrs[pcpuindex].sh_addralign,
@@ -1598,9 +1574,20 @@ static struct module *load_module(void _
 		else
 			dest = mod->module_core + sechdrs[i].sh_entsize;
 
-		if (sechdrs[i].sh_type != SHT_NOBITS)
-			memcpy(dest, (void *)sechdrs[i].sh_addr,
-			       sechdrs[i].sh_size);
+		if (sechdrs[i].sh_type != SHT_NOBITS) {
+			if (i && i == pcpuoffsetindex) {
+				unsigned long *ret;
+				BUG_ON(!pcpuindex);
+				ret = percpu_offset_setup(dest,
+							  sechdrs[pcpuindex].sh_size,
+							  sechdrs[i].sh_size);
+				if (!ret)
+					goto cleanup; /* is this right? */
+				percpu_offset = ret;
+			} else
+				memcpy(dest, (void *)sechdrs[i].sh_addr,
+				       sechdrs[i].sh_size);
+		}
 		/* Update sh_addr to point to copy in image. */
 		sechdrs[i].sh_addr = (unsigned long)dest;
 		DEBUGP("\t0x%lx %s\n", sechdrs[i].sh_addr, secstrings + sechdrs[i].sh_name);
@@ -1608,6 +1595,9 @@ static struct module *load_module(void _
 	/* Module has been moved. */
 	mod = (void *)sechdrs[modindex].sh_addr;
 
+	/* Update the percpu_offset here since we might miss it when copying */
+	mod->percpu_offset = percpu_offset;
+
 	/* Now we've moved module, initialize linked lists, etc. */
 	module_unload_init(mod);
 
@@ -1688,7 +1678,7 @@ static struct module *load_module(void _
 
 	/* Finally, copy percpu area over. */
 	percpu_modcopy(mod->percpu, (void *)sechdrs[pcpuindex].sh_addr,
-		       sechdrs[pcpuindex].sh_size);
+		       sechdrs[pcpuindex].sh_size, mod->percpu_offset);
 
 	add_kallsyms(mod, sechdrs, symindex, strindex, secstrings);
 
@@ -1753,7 +1743,7 @@ static struct module *load_module(void _
 	module_free(mod, mod->module_core);
  free_percpu:
 	if (percpu)
-		percpu_modfree(percpu);
+		percpu_modfree(percpu, percpu_offset);
  free_mod:
 	kfree(args);
  free_hdr:
Index: linux-2.6.17-rc1/include/linux/module.h
===================================================================
--- linux-2.6.17-rc1.orig/include/linux/module.h	2006-04-13 22:37:57.000000000 -0400
+++ linux-2.6.17-rc1/include/linux/module.h	2006-04-13 22:38:07.000000000 -0400
@@ -319,6 +319,7 @@ struct module
 
 	/* Per-cpu data. */
 	void *percpu;
+	unsigned long *percpu_offset;
 
 	/* The command line arguments (may be mangled).  People like
 	   keeping pointers to this stuff */


