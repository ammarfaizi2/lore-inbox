Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261434AbUK1LDq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261434AbUK1LDq (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 28 Nov 2004 06:03:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261433AbUK1LDq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 28 Nov 2004 06:03:46 -0500
Received: from bay-bridge.veritas.com ([143.127.3.10]:58089 "EHLO
	MTVMIME03.enterprise.veritas.com") by vger.kernel.org with ESMTP
	id S261434AbUK1LDX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 28 Nov 2004 06:03:23 -0500
Date: Sun, 28 Nov 2004 11:02:57 +0000 (GMT)
From: Hugh Dickins <hugh@veritas.com>
X-X-Sender: hugh@localhost.localdomain
To: Andrew Morton <akpm@osdl.org>
cc: Sami Farin <7atbggg02@sneakemail.com>, William Irwin <wli@holomorphy.com>,
       <linux-kernel@vger.kernel.org>
Subject: [PATCH 2/2] VmLib wrapped: mprotect flags
In-Reply-To: <Pine.LNX.4.44.0411281057160.11877-100000@localhost.localdomain>
Message-ID: <Pine.LNX.4.44.0411281101410.11877-100000@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Sometimes /proc/<pid>/status shows VmLib: 42949..... kB.

mprotect_fixup must note oldflags on entry: if vma_merge is successful,
vma->vm_flags afterwards may be either the oldflags or the newflags,
and the extent of the change will be less than the extent of the vma.

And let's use unsigned long for these flags throughout.

Signed-off-by: Hugh Dickins <hugh@veritas.com>
Acked-by: William Lee Irwin III <wli@holomorphy.com>

--- 2.6.10-rc2-bk9/mm/mprotect.c	2004-11-15 16:21:24.000000000 +0000
+++ linux/mm/mprotect.c	2004-11-25 15:58:55.711365888 +0000
@@ -111,15 +111,17 @@ change_protection(struct vm_area_struct 
 
 static int
 mprotect_fixup(struct vm_area_struct *vma, struct vm_area_struct **pprev,
-	unsigned long start, unsigned long end, unsigned int newflags)
+	unsigned long start, unsigned long end, unsigned long newflags)
 {
 	struct mm_struct * mm = vma->vm_mm;
+	unsigned long oldflags = vma->vm_flags;
+	long nrpages = (end - start) >> PAGE_SHIFT;
 	unsigned long charged = 0;
 	pgprot_t newprot;
 	pgoff_t pgoff;
 	int error;
 
-	if (newflags == vma->vm_flags) {
+	if (newflags == oldflags) {
 		*pprev = vma;
 		return 0;
 	}
@@ -133,8 +135,8 @@ mprotect_fixup(struct vm_area_struct *vm
 	 * a MAP_NORESERVE private mapping to writable will now reserve.
 	 */
 	if (newflags & VM_WRITE) {
-		if (!(vma->vm_flags & (VM_ACCOUNT|VM_WRITE|VM_SHARED|VM_HUGETLB))) {
-			charged = (end - start) >> PAGE_SHIFT;
+		if (!(oldflags & (VM_ACCOUNT|VM_WRITE|VM_SHARED|VM_HUGETLB))) {
+			charged = nrpages;
 			if (security_vm_enough_memory(charged))
 				return -ENOMEM;
 			newflags |= VM_ACCOUNT;
@@ -176,11 +178,11 @@ success:
 	 * vm_flags and vm_page_prot are protected by the mmap_sem
 	 * held in write mode.
 	 */
-	vm_stat_unaccount(vma);
 	vma->vm_flags = newflags;
 	vma->vm_page_prot = newprot;
 	change_protection(vma, start, end, newprot);
-	vm_stat_account(vma);
+	__vm_stat_account(mm, oldflags, vma->vm_file, -nrpages);
+	__vm_stat_account(mm, newflags, vma->vm_file, nrpages);
 	return 0;
 
 fail:
@@ -246,7 +248,7 @@ sys_mprotect(unsigned long start, size_t
 		prev = vma;
 
 	for (nstart = start ; ; ) {
-		unsigned int newflags;
+		unsigned long newflags;
 
 		/* Here we know that  vma->vm_start <= nstart < vma->vm_end. */
 


