Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262356AbULOOUv@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262356AbULOOUv (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 15 Dec 2004 09:20:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262354AbULOOUv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 15 Dec 2004 09:20:51 -0500
Received: from mx1.redhat.com ([66.187.233.31]:29621 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S262356AbULOOTe (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 15 Dec 2004 09:19:34 -0500
From: David Howells <dhowells@redhat.com>
To: akpm@osdl.org
cc: linux-kernel@vger.kernel.org
Subject: [PATCH] Implement nommu find_vma()
X-Mailer: MH-E 7.82; nmh 1.0.4; GNU Emacs 21.3.50.3
Date: Wed, 15 Dec 2004 14:19:27 +0000
Message-ID: <24286.1103120367@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


The attached patch implements a nommu version of find_vma().

Signed-Off-By: David Howells <dhowells@redhat.com>
---
warthog>diffstat nommu-findvma-2610rc3.diff 
 nommu.c |   13 ++++++++++++-
 1 files changed, 12 insertions(+), 1 deletion(-)

diff -uNrp linux-2.6.10-rc3-mm1-base/mm/nommu.c linux-2.6.10-rc3-mm1-nommu-rb/mm/nommu.c
--- linux-2.6.10-rc3-mm1-base/mm/nommu.c	2004-12-13 17:34:22.000000000 +0000
+++ linux-2.6.10-rc3-mm1-nommu-rb/mm/nommu.c	2004-12-15 13:38:04.036799411 +0000
@@ -793,11 +793,22 @@ unsigned long do_mremap(unsigned long ad
 	return vml->vma->vm_start;
 }
 
-struct vm_area_struct * find_vma(struct mm_struct * mm, unsigned long addr)
+/*
+ * Look up the first VMA which satisfies  addr < vm_end,  NULL if none
+ */
+struct vm_area_struct *find_vma(struct mm_struct *mm, unsigned long addr)
 {
+	struct vm_list_struct *vml;
+
+	for (vml = mm->context.vmlist; vml; vml = vml->next)
+		if (addr >= vml->vma->vm_start && addr < vml->vma->vm_end)
+			return vml->vma;
+
 	return NULL;
 }
 
+EXPORT_SYMBOL(find_vma);
+
 struct page * follow_page(struct mm_struct *mm, unsigned long addr, int write)
 {
 	return NULL;
