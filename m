Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262701AbSI1E3i>; Sat, 28 Sep 2002 00:29:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262709AbSI1E3h>; Sat, 28 Sep 2002 00:29:37 -0400
Received: from atlrel9.hp.com ([156.153.255.214]:3807 "HELO atlrel9.hp.com")
	by vger.kernel.org with SMTP id <S262701AbSI1E3e>;
	Sat, 28 Sep 2002 00:29:34 -0400
To: marcelo@conectiva.com.br
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH] AGPGART 3/5: support arches where CPU doesn't go through GART
Message-Id: <E17v9Je-0001mf-00@eeyore>
From: Bjorn Helgaas <helgaas@fc.hp.com>
Date: Fri, 27 Sep 2002 22:34:54 -0600
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On some architectures, CPU accesses aren't translated by the GART.
Currently only IA64 ZX1 and 460GX fall into this category, and they
set "cant_use_aperture = 1".  This patch adds infrastructure to
support them.  Behavior when "cant_use_aperture == 0" is unchanged.

# This is a BitKeeper generated patch for the following project:
# Project Name: Linux kernel tree
# This patch format is intended for GNU patch command version 2.5 or higher.
# This patch includes the following deltas:
#	           ChangeSet	1.685   -> 1.686  
#	drivers/char/agp/agpgart_be.c	1.37    -> 1.38   
#	include/linux/agp_backend.h	1.13    -> 1.14   
#
# The following is the BitKeeper ChangeSet Log
# --------------------------------------------
# 02/09/19	bjorn_helgaas@hp.com	1.686
# Add support for AGP bridges where CPU accesses don't go
# through the GART aperture.
# --------------------------------------------
#
diff -Nru a/drivers/char/agp/agpgart_be.c b/drivers/char/agp/agpgart_be.c
--- a/drivers/char/agp/agpgart_be.c	Thu Sep 19 13:15:48 2002
+++ b/drivers/char/agp/agpgart_be.c	Thu Sep 19 13:15:48 2002
@@ -43,6 +43,9 @@
 #include <asm/uaccess.h>
 #include <asm/io.h>
 #include <asm/page.h>
+#include <asm/pgalloc.h>
+#include <asm/pgtable.h>
+#include <asm/smplock.h>
 
 #include <linux/agp_backend.h>
 #include "agp.h"
@@ -207,10 +210,14 @@
 		agp_bridge.free_by_type(curr);
 		return;
 	}
-	if (curr->page_count != 0) {
-		for (i = 0; i < curr->page_count; i++) {
-			agp_bridge.agp_destroy_page((unsigned long)
-					 phys_to_virt(curr->memory[i]));
+	if (agp_bridge.cant_use_aperture) {
+		vfree(curr->vmptr);
+	} else {
+		if (curr->page_count != 0) {
+			for (i = 0; i < curr->page_count; i++) {
+				agp_bridge.agp_destroy_page((unsigned long)
+						 phys_to_virt(curr->memory[i]));
+			}
 		}
 	}
 	agp_free_key(curr->key);
@@ -219,6 +226,37 @@
 	MOD_DEC_USE_COUNT;
 }
 
+#define IN_VMALLOC(_x)	  (((_x) >= VMALLOC_START) && ((_x) < VMALLOC_END))
+
+/*
+ * Look up and return the pte corresponding to addr.  We only do this for
+ * agp_ioremap'ed addresses. 
+ */
+static pte_t *agp_lookup_pte(unsigned long addr)
+{ 
+	pgd_t			*dir;
+	pmd_t			*pmd;
+	pte_t			*pte;
+
+	if (!IN_VMALLOC(addr))
+		return NULL;
+
+	dir = pgd_offset_k(addr);
+	pmd = pmd_offset(dir, addr);
+
+	if (pmd) {
+		pte = pte_offset(pmd, addr);
+
+		if (pte) {
+			return pte;
+		} else {
+			return NULL;
+		}
+	} else {
+		return NULL;
+	}
+}
+
 #define ENTRIES_PER_PAGE		(PAGE_SIZE / sizeof(unsigned long))
 
 agp_memory *agp_allocate_memory(size_t page_count, u32 type)
@@ -253,18 +291,44 @@
 	      	MOD_DEC_USE_COUNT;
 		return NULL;
 	}
-	for (i = 0; i < page_count; i++) {
-		new->memory[i] = agp_bridge.agp_alloc_page();
 
-		if (new->memory[i] == 0) {
-			/* Free this structure */
-			agp_free_memory(new);
+	if (agp_bridge.cant_use_aperture) {
+		void *vmblock;
+		unsigned long vaddr;
+		pte_t *pte;
+
+		vmblock = __vmalloc(page_count << PAGE_SHIFT, GFP_KERNEL, PAGE_KERNEL);
+		if (vmblock == NULL) {
+			MOD_DEC_USE_COUNT;
 			return NULL;
 		}
-		new->memory[i] = virt_to_phys((void *) new->memory[i]);
-		new->page_count++;
-	}
 
+		new->vmptr = vmblock;
+		vaddr = (unsigned long) vmblock;
+
+		for (i = 0; i < page_count; i++, vaddr += PAGE_SIZE) {
+			pte = agp_lookup_pte(vaddr);
+			if (pte == NULL) {
+				MOD_DEC_USE_COUNT;
+				return NULL;
+			}
+			new->memory[i] = virt_to_phys(page_address(pte_page(*pte)));
+		}
+
+		new->page_count = page_count;
+	} else {
+		for (i = 0; i < page_count; i++) {
+			new->memory[i] = agp_bridge.agp_alloc_page();
+
+			if (new->memory[i] == 0) {
+				/* Free this structure */
+				agp_free_memory(new);
+				return NULL;
+			}
+			new->memory[i] = virt_to_phys((void *) new->memory[i]);
+			new->page_count++;
+		}
+	}
 	return new;
 }
 
diff -Nru a/include/linux/agp_backend.h b/include/linux/agp_backend.h
--- a/include/linux/agp_backend.h	Thu Sep 19 13:15:48 2002
+++ b/include/linux/agp_backend.h	Thu Sep 19 13:15:48 2002
@@ -120,6 +120,7 @@
 	size_t page_count;
 	int num_scratch_pages;
 	unsigned long *memory;
+	void *vmptr;
 	off_t pg_start;
 	u32 type;
 	u32 physical;
