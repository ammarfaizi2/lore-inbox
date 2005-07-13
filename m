Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261922AbVGMRj3@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261922AbVGMRj3 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 13 Jul 2005 13:39:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261994AbVGMRhh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 13 Jul 2005 13:37:37 -0400
Received: from silver.veritas.com ([143.127.12.111]:29313 "EHLO
	silver.veritas.com") by vger.kernel.org with ESMTP id S261922AbVGMRfA
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 13 Jul 2005 13:35:00 -0400
Date: Wed, 13 Jul 2005 18:36:20 +0100 (BST)
From: Hugh Dickins <hugh@veritas.com>
X-X-Sender: hugh@goblin.wat.veritas.com
To: Andrew Morton <akpm@osdl.org>
cc: David Howells <dhowells@redhat.com>, Christoph Hellwig <hch@infradead.org>,
       linux-kernel@vger.kernel.org
Subject: [PATCH 2/3] fix page-becoming-writable vm_page_prot
In-Reply-To: <Pine.LNX.4.61.0507131831100.5735@goblin.wat.veritas.com>
Message-ID: <Pine.LNX.4.61.0507131834230.5735@goblin.wat.veritas.com>
References: <Pine.LNX.4.61.0507131831100.5735@goblin.wat.veritas.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-OriginalArrivalTime: 13 Jul 2005 17:34:53.0628 (UTC) FILETIME=[2DCD6FC0:01C587D1]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The do_wp_page page_mkwrite breakage went unnoticed because do_no_page
was as usual giving write permission to the pte in handling a read fault
on a shared writable mapping, thus sneaking around page_mkwrite.

It could likewise be evaded by do_file_page->populate->install_page.  And
if those were to write protect the pte, mprotect back and forth could be
used to reinstate write permission without going through page_mkwrite.

No explicit change to those: deal with it by using the vm_page_prot
of a private mapping on any shared mapping which has a page_mkwrite.

Signed-off-by: Hugh Dickins <hugh@veritas.com>
---

 mm/mmap.c     |    9 +++++++--
 mm/mprotect.c |    8 ++++++--
 2 files changed, 13 insertions(+), 4 deletions(-)

--- 2.6.13-rc2-mm2/mm/mmap.c	2005-07-07 12:33:21.000000000 +0100
+++ linux/mm/mmap.c	2005-07-11 20:01:28.000000000 +0100
@@ -1051,7 +1051,8 @@ munmap_back:
 	vma->vm_start = addr;
 	vma->vm_end = addr + len;
 	vma->vm_flags = vm_flags;
-	vma->vm_page_prot = protection_map[vm_flags & 0x0f];
+	vma->vm_page_prot = protection_map[vm_flags &
+				(VM_READ|VM_WRITE|VM_EXEC|VM_SHARED)];
 	vma->vm_pgoff = pgoff;
 
 	if (file) {
@@ -1074,6 +1075,9 @@ munmap_back:
 		if (error)
 			goto free_vma;
 	}
+	if (vma->vm_ops && vma->vm_ops->page_mkwrite)
+		vma->vm_page_prot = protection_map[vm_flags &
+					(VM_READ|VM_WRITE|VM_EXEC)];
 
 	/* We set VM_ACCOUNT in a shared mapping's vm_flags, to inform
 	 * shmem_zero_setup (perhaps called through /dev/zero's ->mmap)
@@ -1910,7 +1914,8 @@ unsigned long do_brk(unsigned long addr,
 	vma->vm_end = addr + len;
 	vma->vm_pgoff = pgoff;
 	vma->vm_flags = flags;
-	vma->vm_page_prot = protection_map[flags & 0x0f];
+	vma->vm_page_prot = protection_map[flags &
+				(VM_READ|VM_WRITE|VM_EXEC|VM_SHARED)];
 	vma_link(mm, vma, prev, rb_link, rb_parent);
 out:
 	mm->total_vm += len >> PAGE_SHIFT;
--- 2.6.13-rc2-mm2/mm/mprotect.c	2005-06-17 20:48:29.000000000 +0100
+++ linux/mm/mprotect.c	2005-07-11 20:01:28.000000000 +0100
@@ -107,6 +107,7 @@ mprotect_fixup(struct vm_area_struct *vm
 	unsigned long oldflags = vma->vm_flags;
 	long nrpages = (end - start) >> PAGE_SHIFT;
 	unsigned long charged = 0;
+	unsigned int mask;
 	pgprot_t newprot;
 	pgoff_t pgoff;
 	int error;
@@ -133,8 +134,6 @@ mprotect_fixup(struct vm_area_struct *vm
 		}
 	}
 
-	newprot = protection_map[newflags & 0xf];
-
 	/*
 	 * First try to merge with previous and/or next vma.
 	 */
@@ -161,6 +160,11 @@ mprotect_fixup(struct vm_area_struct *vm
 	}
 
 success:
+	mask = VM_READ|VM_WRITE|VM_EXEC|VM_SHARED;
+	if (vma->vm_ops && vma->vm_ops->page_mkwrite)
+		mask &= ~VM_SHARED;
+	newprot = protection_map[newflags & mask];
+
 	/*
 	 * vm_flags and vm_page_prot are protected by the mmap_sem
 	 * held in write mode.
