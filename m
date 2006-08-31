Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932242AbWHaR1e@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932242AbWHaR1e (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 31 Aug 2006 13:27:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932227AbWHaR1e
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 31 Aug 2006 13:27:34 -0400
Received: from mx1.redhat.com ([66.187.233.31]:19420 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S932218AbWHaR1d (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 31 Aug 2006 13:27:33 -0400
From: David Howells <dhowells@redhat.com>
Subject: [PATCH] NOMMU: Use find_vma() rather than reimplementing a VMA search
Date: Thu, 31 Aug 2006 18:27:20 +0100
To: torvalds@osdl.org, akpm@osdl.org
Cc: linux-kernel@vger.kernel.org, uclinux-dev@uclinux.org, dhowells@redhat.com
Message-Id: <20060831172720.11210.7261.stgit@warthog.cambridge.redhat.com>
Content-Type: text/plain; charset=utf-8; format=fixed
Content-Transfer-Encoding: 8bit
User-Agent: StGIT/0.10
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: David Howells <dhowells@redhat.com>

Use find_vma() in the NOMMU version of access_process_vm() rather than
reimplementing it.

Signed-Off-By: David Howells <dhowells@redhat.com>
---

 mm/nommu.c |   11 +++--------
 1 files changed, 3 insertions(+), 8 deletions(-)

diff --git a/mm/nommu.c b/mm/nommu.c
index 663ec1c..51e17b9 100644
--- a/mm/nommu.c
+++ b/mm/nommu.c
@@ -1039,6 +1039,7 @@ unsigned long do_mremap(unsigned long ad
 
 /*
  * Look up the first VMA which satisfies  addr < vm_end,  NULL if none
+ * - should be called with mm->mmap_sem at least readlocked
  */
 struct vm_area_struct *find_vma(struct mm_struct *mm, unsigned long addr)
 {
@@ -1213,7 +1214,6 @@ struct page *filemap_nopage(struct vm_ar
  */
 int access_process_vm(struct task_struct *tsk, unsigned long addr, void *buf, int len, int write)
 {
-	struct vm_list_struct *vml;
 	struct vm_area_struct *vma;
 	struct mm_struct *mm;
 
@@ -1227,13 +1227,8 @@ int access_process_vm(struct task_struct
 	down_read(&mm->mmap_sem);
 
 	/* the access must start within one of the target process's mappings */
-	for (vml = mm->context.vmlist; vml; vml = vml->next)
-		if (addr >= vml->vma->vm_start && addr < vml->vma->vm_end)
-			break;
-
-	if (vml) {
-		vma = vml->vma;
-
+	vma = find_vma(mm, addr);
+	if (vma) {
 		/* don't overrun this mapping */
 		if (addr + len >= vma->vm_end)
 			len = vma->vm_end - addr;
