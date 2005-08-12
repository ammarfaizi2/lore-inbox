Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750853AbVHLSQk@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750853AbVHLSQk (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 12 Aug 2005 14:16:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750852AbVHLSQj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 12 Aug 2005 14:16:39 -0400
Received: from mail-relay-4.tiscali.it ([213.205.33.44]:65189 "EHLO
	mail-relay-4.tiscali.it") by vger.kernel.org with ESMTP
	id S1750843AbVHLSQf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 12 Aug 2005 14:16:35 -0400
Subject: [patch 15/39] remap_file_pages protection support: add VM_NONUNIFORM to fix existing usage of mprotect()
To: akpm@osdl.org
Cc: jdike@addtoit.com, linux-kernel@vger.kernel.org,
       user-mode-linux-devel@lists.sourceforge.net, blaisorblade@yahoo.it
From: blaisorblade@yahoo.it
Date: Fri, 12 Aug 2005 20:21:36 +0200
Message-Id: <20050812182136.53D7D24E7E8@zion.home.lan>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


From: Paolo 'Blaisorblade' Giarrusso <blaisorblade@yahoo.it>

Distinguish between "normal" VMA and VMA with non-uniform protection. This
will be also useful for fault handling (we must ignore VM_{READ,WRITE,EXEC} in
the arch fault handler).

As said before, with remap-file-pages-prot, we must punt on private VMA even
when we're just changing protections.

Also, with the remap_file_pages protection support, we have indeed a
regression with remap_file_pages VS mprotect. mprotect alters the VMA
protections and walks each installed PTE.

Mprotect'ing a nonlinear VMA used to work, obviously, but now doesn't, because
we must now read the protections from the PTE which haven't been updated; so,
to avoid changing behaviour for old binaries, on uniform VMA's we ignore
protections in the PTE, like we did before.

On non-uniform VMA's, instead, mprotect is currently broken, however we've
never supported it so this is acceptable.

What it does is to split the VMA if needed, assign the new protection to the
VMA and enforce the new protections on all present pages, ignoring all absent
ones (including pte_file() ones), which will keep the current protections. So,
the application has no reliable way to know which pages would actually be
remapped.

What is more, there is IMHO no reason to support using mprotect on non-uniform
VMAs. The only exception is to change the VMA's default protection (which is
used for non-individually remapped pages), but it should still ignore the page
tables.

The only need for that is if I want to change protections without changing the
indexes, which with remap_file_pages you must do one page at a time and
re-specifying the indexes.

It is more reasonable to allow remap_file_pages to change protections on a PTE
range without changing the offsets. I've not implemented this, but if wanted I
can. For sure, UML doesn't need this interface.

However, for now I've implemented no change to mprotect(), I'd like to get
some feedback before about which way to go.

Signed-off-by: Paolo 'Blaisorblade' Giarrusso <blaisorblade@yahoo.it>
---

 linux-2.6.git-paolo/include/linux/mm.h |    7 +++++++
 linux-2.6.git-paolo/mm/fremap.c        |   13 +++++++++++++
 linux-2.6.git-paolo/mm/memory.c        |    2 +-
 3 files changed, 21 insertions(+), 1 deletion(-)

diff -puN mm/fremap.c~rfp-add-VM_NONUNIFORM mm/fremap.c
--- linux-2.6.git/mm/fremap.c~rfp-add-VM_NONUNIFORM	2005-08-11 23:03:51.000000000 +0200
+++ linux-2.6.git-paolo/mm/fremap.c	2005-08-11 23:03:51.000000000 +0200
@@ -252,6 +252,19 @@ retry:
 				spin_unlock(&mapping->i_mmap_lock);
 			}
 		}
+		if (pgprot_val(pgprot) != pgprot_val(vma->vm_page_prot)) {
+			if (!(vma->vm_flags & VM_SHARED))
+				goto out_unlock;
+			if (!(vma->vm_flags & VM_NONUNIFORM)) {
+				if (!has_write_lock) {
+					up_read(&mm->mmap_sem);
+					down_write(&mm->mmap_sem);
+					has_write_lock = 1;
+					goto retry;
+				}
+				vma->vm_flags |= VM_NONUNIFORM;
+			}
+		}
 
 		err = vma->vm_ops->populate(vma, start, size, pgprot, pgoff,
 				flags & MAP_NONBLOCK);
diff -puN include/linux/mm.h~rfp-add-VM_NONUNIFORM include/linux/mm.h
--- linux-2.6.git/include/linux/mm.h~rfp-add-VM_NONUNIFORM	2005-08-11 23:03:51.000000000 +0200
+++ linux-2.6.git-paolo/include/linux/mm.h	2005-08-11 23:03:51.000000000 +0200
@@ -160,7 +160,14 @@ extern unsigned int kobjsize(const void 
 #define VM_ACCOUNT	0x00100000	/* Is a VM accounted object */
 #define VM_HUGETLB	0x00400000	/* Huge TLB Page VM */
 #define VM_NONLINEAR	0x00800000	/* Is non-linear (remap_file_pages) */
+
+#ifndef CONFIG_MMU
 #define VM_MAPPED_COPY	0x01000000	/* T if mapped copy of data (nommu mmap) */
+#else
+#define VM_NONUNIFORM	0x01000000	/* The VM individual pages have
+					   different protections
+					   (remap_file_pages)*/
+#endif
 
 #ifndef VM_STACK_DEFAULT_FLAGS		/* arch can override this */
 #define VM_STACK_DEFAULT_FLAGS VM_DATA_DEFAULT_FLAGS
diff -puN mm/memory.c~rfp-add-VM_NONUNIFORM mm/memory.c
--- linux-2.6.git/mm/memory.c~rfp-add-VM_NONUNIFORM	2005-08-11 23:03:51.000000000 +0200
+++ linux-2.6.git-paolo/mm/memory.c	2005-08-11 23:03:51.000000000 +0200
@@ -1941,7 +1941,7 @@ static int do_file_page(struct mm_struct
 	}
 
 	pgoff = pte_to_pgoff(*pte);
-	pgprot = pte_to_pgprot(*pte);
+	pgprot = vma->vm_flags & VM_NONUNIFORM ? pte_to_pgprot(*pte): vma->vm_page_prot;
 
 	pte_unmap(pte);
 	spin_unlock(&mm->page_table_lock);
_
