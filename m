Return-Path: <linux-kernel-owner+willy=40w.ods.org-S966315AbWKTSIX@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S966315AbWKTSIX (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 20 Nov 2006 13:08:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S966298AbWKTSHt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 20 Nov 2006 13:07:49 -0500
Received: from moutng.kundenserver.de ([212.227.126.177]:35520 "EHLO
	moutng.kundenserver.de") by vger.kernel.org with ESMTP
	id S934293AbWKTSHY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 20 Nov 2006 13:07:24 -0500
Message-Id: <20061120180524.176650000@arndb.de>
References: <20061120174454.067872000@arndb.de>
User-Agent: quilt/0.45-1
Date: Mon, 20 Nov 2006 18:45:05 +0100
From: Arnd Bergmann <arnd@arndb.de>
To: cbe-oss-dev@ozlabs.org
Cc: linuxppc-dev@ozlabs.org, linux-kernel@vger.kernel.org,
       Paul Mackerras <paulus@samba.org>,
       Arnd Bergmann <arnd.bergmann@de.ibm.com>,
       Christoph Hellwig <chellwig@de.ibm.com>
Subject: [PATCH 11/22] spufs: avoid user-triggered oops in ptrace
Content-Disposition: inline; filename=spufs-vm-io-mappings.diff
X-Provags-ID: kundenserver.de abuse@kundenserver.de login:c48f057754fc1b1a557605ab9fa6da41
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Christoph Hellwig <hch@infradead.org>
When one of the spufs files is mapped into a process address
space, regular users can use ptrace to attempt accessing
them with access_process_vm(). With the way that the
mappings currently work, this likely causes an oops.

Setting the vm_flags to VM_IO makes sure that ptrace can
not access them but returns an error code. This is not
the perfect solution in case of the local store mapping,
but it fixes the oops in a well-defined way.

Also remove leftover VM_RESERVED flags in spufs.  The
VM_RESERVED flag is on it's way out and not checked by
the memory managment code anymore.

Signed-off-by: Arnd Bergmann <arnd.bergmann@de.ibm.com>
Signed-off-by: Christoph Hellwig <chellwig@de.ibm.com>

---

Index: linux-2.6/arch/powerpc/platforms/cell/spufs/file.c
===================================================================
--- linux-2.6.orig/arch/powerpc/platforms/cell/spufs/file.c
+++ linux-2.6/arch/powerpc/platforms/cell/spufs/file.c
@@ -132,7 +132,7 @@ spufs_mem_mmap(struct file *file, struct
 	if (!(vma->vm_flags & VM_SHARED))
 		return -EINVAL;
 
-	/* FIXME: */
+	vma->vm_flags |= VM_IO;
 	vma->vm_page_prot = __pgprot(pgprot_val(vma->vm_page_prot)
 				     | _PAGE_NO_CACHE);
 
@@ -201,7 +201,7 @@ static int spufs_cntl_mmap(struct file *
 	if (!(vma->vm_flags & VM_SHARED))
 		return -EINVAL;
 
-	vma->vm_flags |= VM_RESERVED;
+	vma->vm_flags |= VM_IO;
 	vma->vm_page_prot = __pgprot(pgprot_val(vma->vm_page_prot)
 				     | _PAGE_NO_CACHE | _PAGE_GUARDED);
 
@@ -791,7 +791,7 @@ static int spufs_signal1_mmap(struct fil
 	if (!(vma->vm_flags & VM_SHARED))
 		return -EINVAL;
 
-	vma->vm_flags |= VM_RESERVED;
+	vma->vm_flags |= VM_IO;
 	vma->vm_page_prot = __pgprot(pgprot_val(vma->vm_page_prot)
 				     | _PAGE_NO_CACHE | _PAGE_GUARDED);
 
@@ -889,8 +889,7 @@ static int spufs_signal2_mmap(struct fil
 	if (!(vma->vm_flags & VM_SHARED))
 		return -EINVAL;
 
-	/* FIXME: */
-	vma->vm_flags |= VM_RESERVED;
+	vma->vm_flags |= VM_IO;
 	vma->vm_page_prot = __pgprot(pgprot_val(vma->vm_page_prot)
 				     | _PAGE_NO_CACHE | _PAGE_GUARDED);
 
@@ -973,7 +972,7 @@ static int spufs_mss_mmap(struct file *f
 	if (!(vma->vm_flags & VM_SHARED))
 		return -EINVAL;
 
-	vma->vm_flags |= VM_RESERVED;
+	vma->vm_flags |= VM_IO;
 	vma->vm_page_prot = __pgprot(pgprot_val(vma->vm_page_prot)
 				     | _PAGE_NO_CACHE | _PAGE_GUARDED);
 
@@ -1015,7 +1014,7 @@ static int spufs_psmap_mmap(struct file 
 	if (!(vma->vm_flags & VM_SHARED))
 		return -EINVAL;
 
-	vma->vm_flags |= VM_RESERVED;
+	vma->vm_flags |= VM_IO;
 	vma->vm_page_prot = __pgprot(pgprot_val(vma->vm_page_prot)
 				     | _PAGE_NO_CACHE | _PAGE_GUARDED);
 
@@ -1056,7 +1055,7 @@ static int spufs_mfc_mmap(struct file *f
 	if (!(vma->vm_flags & VM_SHARED))
 		return -EINVAL;
 
-	vma->vm_flags |= VM_RESERVED;
+	vma->vm_flags |= VM_IO;
 	vma->vm_page_prot = __pgprot(pgprot_val(vma->vm_page_prot)
 				     | _PAGE_NO_CACHE | _PAGE_GUARDED);
 

--

