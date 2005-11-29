Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932392AbVK2Um4@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932392AbVK2Um4 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 29 Nov 2005 15:42:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932386AbVK2Um4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 29 Nov 2005 15:42:56 -0500
Received: from mx1.redhat.com ([66.187.233.31]:19625 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S932392AbVK2Umz (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 29 Nov 2005 15:42:55 -0500
From: David Howells <dhowells@redhat.com>
In-Reply-To: <200511231509.jANF9EwM000983@warthog.cambridge.redhat.com> 
References: <200511231509.jANF9EwM000983@warthog.cambridge.redhat.com>  <dhowells1132758553@warthog.cambridge.redhat.com> 
To: torvalds@osdl.org, akpm@osdl.org
Cc: linux-kernel@vger.kernel.org,
       uClinux development list <uclinux-dev@uclinux.org>
Subject: [PATCH 3/3] FRV: Make futex code compilable on nommu [try #2]
X-Mailer: MH-E 7.84; nmh 1.1; GNU Emacs 22.0.50.1
Date: Tue, 29 Nov 2005 20:42:36 +0000
Message-ID: <5460.1133296956@warthog.cambridge.redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


The attached patch makes the futex code compilable and usable on NOMMU by
making the attempt to handle page faults conditional on CONFIG_MMU. If this is
not enabled, then we can assume that EFAULT returned from
futex_atomic_op_inuser() is not recoverable, and that the address lies outside
of valid memory.

handle_mm_fault() is made to BUG if called on NOMMU without attempting to
invoke the actual handler (__handle_mm_fault).

Signed-Off-By: David Howells <dhowells@redhat.com>
---
warthog>diffstat -p1 frv-futex-2615rc2-2.diff 
 include/linux/mm.h |   10 ++++++++++
 kernel/futex.c     |    7 +++++++
 2 files changed, 17 insertions(+)

diff -uNrp /warthog/kernels/linux-2.6.15-rc2/include/linux/mm.h linux-2.6.15-rc2-frv/include/linux/mm.h
--- /warthog/kernels/linux-2.6.15-rc2/include/linux/mm.h	2005-11-23 12:09:22.000000000 +0000
+++ linux-2.6.15-rc2-frv/include/linux/mm.h	2005-11-29 20:02:34.000000000 +0000
@@ -708,12 +708,22 @@ static inline void unmap_shared_mapping_
 extern int vmtruncate(struct inode * inode, loff_t offset);
 extern int install_page(struct mm_struct *mm, struct vm_area_struct *vma, unsigned long addr, struct page *page, pgprot_t prot);
 extern int install_file_pte(struct mm_struct *mm, struct vm_area_struct *vma, unsigned long addr, unsigned long pgoff, pgprot_t prot);
+
+#ifdef CONFIG_MMU
 extern int __handle_mm_fault(struct mm_struct *mm,struct vm_area_struct *vma, unsigned long address, int write_access);
 
 static inline int handle_mm_fault(struct mm_struct *mm, struct vm_area_struct *vma, unsigned long address, int write_access)
 {
 	return __handle_mm_fault(mm, vma, address, write_access) & (~VM_FAULT_WRITE);
 }
+#else
+static inline int handle_mm_fault(struct mm_struct *mm, struct vm_area_struct *vma, unsigned long address, int write_access)
+{
+	/* should never happen if there's no MMU */
+	BUG();
+	return VM_FAULT_SIGBUS;
+}
+#endif
 
 extern int make_pages_present(unsigned long addr, unsigned long end);
 extern int access_process_vm(struct task_struct *tsk, unsigned long addr, void *buf, int len, int write);
diff -uNrp /warthog/kernels/linux-2.6.15-rc2/kernel/futex.c linux-2.6.15-rc2-frv/kernel/futex.c
--- /warthog/kernels/linux-2.6.15-rc2/kernel/futex.c	2005-11-23 12:09:23.000000000 +0000
+++ linux-2.6.15-rc2-frv/kernel/futex.c	2005-11-29 20:01:07.000000000 +0000
@@ -365,6 +365,13 @@ retry:
 		if (bh1 != bh2)
 			spin_unlock(&bh2->lock);
 
+#ifndef CONFIG_MMU
+		/* we don't get EFAULT from MMU faults if we don't have an MMU,
+		 * but we might get them from range checking */
+		ret = op_ret;
+		goto out;
+#endif
+
 		if (unlikely(op_ret != -EFAULT)) {
 			ret = op_ret;
 			goto out;
