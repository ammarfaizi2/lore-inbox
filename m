Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268698AbUHYAC2@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268698AbUHYAC2 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 24 Aug 2004 20:02:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269119AbUHYAC2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 24 Aug 2004 20:02:28 -0400
Received: from holomorphy.com ([207.189.100.168]:22663 "EHLO holomorphy.com")
	by vger.kernel.org with ESMTP id S268698AbUHYABx (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 24 Aug 2004 20:01:53 -0400
Date: Tue, 24 Aug 2004 17:01:49 -0700
From: William Lee Irwin III <wli@holomorphy.com>
To: Albert Cahalan <albert@users.sf.net>,
       linux-kernel mailing list <linux-kernel@vger.kernel.org>
Subject: Re: fix text reporting in O(1) proc_pid_statm()
Message-ID: <20040825000149.GJ2793@holomorphy.com>
Mail-Followup-To: William Lee Irwin III <wli@holomorphy.com>,
	Albert Cahalan <albert@users.sf.net>,
	linux-kernel mailing list <linux-kernel@vger.kernel.org>
References: <1093388816.434.355.camel@cube> <20040824231236.GG2793@holomorphy.com> <20040824231841.GH2793@holomorphy.com> <20040824232424.GI2793@holomorphy.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040824232424.GI2793@holomorphy.com>
Organization: The Domain of Holomorphy
User-Agent: Mutt/1.5.6+20040722i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 24, 2004 at 04:18:41PM -0700, William Lee Irwin III wrote:
>> Account reserved memory properly as per acahalan's sepecified semantics.

On Tue, Aug 24, 2004 at 04:24:24PM -0700, William Lee Irwin III wrote:
> Unrelated fix. Unaccount VM_DONTCOPY vmas properly; the child inherits
> the whole of the parent's virtual accounting from the memcpy() in
> copy_mm(), but the VM_DONTCOPY check here is where a decision is made
> for the child not to inherit the vmas corresponding to some accounted
> memory usages. Hence, unaccount them when skipping over them here.

Unrelated improvement (not mandatory or a fix for a bug). Remove the
accounting overhead when CONFIG_PROC_FS is not defined.


Index: mm4-2.6.8.1/include/linux/mm.h
===================================================================
--- mm4-2.6.8.1.orig/include/linux/mm.h	2004-08-23 18:29:33.000000000 -0700
+++ mm4-2.6.8.1/include/linux/mm.h	2004-08-24 16:57:36.114920616 -0700
@@ -754,7 +754,15 @@
 		int write);
 extern int remap_page_range(struct vm_area_struct *vma, unsigned long from,
 		unsigned long to, unsigned long size, pgprot_t prot);
+
+#ifdef CONFIG_PROC_FS
 void __vm_stat_account(struct mm_struct *, unsigned long, struct file *, long);
+#else
+static inline void __vm_stat_account(struct mm_struct *mm,
+			unsigned long flags, struct file *file, long pages)
+{
+}
+#endif /* CONFIG_PROC_FS */
 
 static inline void vm_stat_account(struct vm_area_struct *vma)
 {
Index: mm4-2.6.8.1/mm/mmap.c
===================================================================
--- mm4-2.6.8.1.orig/mm/mmap.c	2004-08-24 16:13:14.139602376 -0700
+++ mm4-2.6.8.1/mm/mmap.c	2004-08-24 16:57:23.943770912 -0700
@@ -729,6 +729,7 @@
 	return NULL;
 }
 
+#ifdef CONFIG_PROC_FS
 void __vm_stat_account(struct mm_struct *mm, unsigned long flags,
 						struct file *file, long pages)
 {
@@ -752,6 +753,7 @@
 	if (flags & (VM_RESERVED|VM_IO))
 		mm->reserved_vm += pages;
 }
+#endif /* CONFIG_PROC_FS */
 
 /*
  * The caller must hold down_write(current->mm->mmap_sem).
