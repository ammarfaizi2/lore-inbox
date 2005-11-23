Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750903AbVKWPJ6@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750903AbVKWPJ6 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 23 Nov 2005 10:09:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750944AbVKWPJ5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 23 Nov 2005 10:09:57 -0500
Received: from mx1.redhat.com ([66.187.233.31]:12957 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S1750903AbVKWPJe (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 23 Nov 2005 10:09:34 -0500
Date: Wed, 23 Nov 2005 15:09:14 GMT
Message-Id: <200511231509.jANF9EwM000983@warthog.cambridge.redhat.com>
From: David Howells <dhowells@redhat.com>
To: torvalds@osdl.org, akpm@osdl.org
Cc: linux-kernel@vger.kernel.org, uclinux-dev@uclinux.org
Fcc: outgoing
Subject: [PATCH 3/3] FRV: Make futex code compilable on nommu
In-Reply-To: <dhowells1132758553@warthog.cambridge.redhat.com>
References: <dhowells1132758553@warthog.cambridge.redhat.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The attached patch makes the futex code compilable on nommu by making the
attempt to handle page faults conditional on CONFIG_MMU. If this is not
enabled, then we can assume that EFAULT returned from futex_atomic_op_inuser()
is not recoverable, and that the address lies outside of valid memory.

Signed-Off-By: David Howells <dhowells@redhat.com>
---
warthog>diffstat -p1 frv-futex-2615rc2.diff
 include/linux/mm.h |    3 +++
 kernel/futex.c     |   18 +++++++++++++++++-
 2 files changed, 20 insertions(+), 1 deletion(-)

diff -uNrp /warthog/kernels/linux-2.6.15-rc2/include/linux/mm.h linux-2.6.15-rc2-frv/include/linux/mm.h
--- /warthog/kernels/linux-2.6.15-rc2/include/linux/mm.h	2005-11-23 12:09:22.000000000 +0000
+++ linux-2.6.15-rc2-frv/include/linux/mm.h	2005-11-23 13:29:08.000000000 +0000
@@ -708,12 +708,15 @@ static inline void unmap_shared_mapping_
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
+#endif
 
 extern int make_pages_present(unsigned long addr, unsigned long end);
 extern int access_process_vm(struct task_struct *tsk, unsigned long addr, void *buf, int len, int write);
diff -uNrp /warthog/kernels/linux-2.6.15-rc2/kernel/futex.c linux-2.6.15-rc2-frv/kernel/futex.c
--- /warthog/kernels/linux-2.6.15-rc2/kernel/futex.c	2005-11-23 12:09:23.000000000 +0000
+++ linux-2.6.15-rc2-frv/kernel/futex.c	2005-11-23 13:41:33.000000000 +0000
@@ -335,9 +335,14 @@ static int futex_wake_op(unsigned long u
 	struct futex_hash_bucket *bh1, *bh2;
 	struct list_head *head;
 	struct futex_q *this, *next;
-	int ret, op_ret, attempt = 0;
+	int ret, op_ret;
+#ifdef CONFIG_MMU
+	int attempt = 0;
+#endif
 
+#ifdef CONFIG_MMU
 retryfull:
+#endif
 	down_read(&current->mm->mmap_sem);
 
 	ret = get_futex_key(uaddr1, &key1);
@@ -350,7 +355,9 @@ retryfull:
 	bh1 = hash_futex(&key1);
 	bh2 = hash_futex(&key2);
 
+#ifdef CONFIG_MMU
 retry:
+#endif
 	if (bh1 < bh2)
 		spin_lock(&bh1->lock);
 	spin_lock(&bh2->lock);
@@ -359,12 +366,15 @@ retry:
 
 	op_ret = futex_atomic_op_inuser(op, (int __user *)uaddr2);
 	if (unlikely(op_ret < 0)) {
+#ifdef CONFIG_MMU
 		int dummy;
+#endif
 
 		spin_unlock(&bh1->lock);
 		if (bh1 != bh2)
 			spin_unlock(&bh2->lock);
 
+#ifdef CONFIG_MMU
 		if (unlikely(op_ret != -EFAULT)) {
 			ret = op_ret;
 			goto out;
@@ -408,6 +418,12 @@ retry:
 			return ret;
 
 		goto retryfull;
+
+#else
+		/* we don't get EFAULT from MMU faults if we don't have an MMU,
+		 * but we might get them from range checking */
+		goto out;
+#endif
 	}
 
 	head = &bh1->chain;
