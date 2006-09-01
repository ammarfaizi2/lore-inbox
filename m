Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751191AbWIAMm3@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751191AbWIAMm3 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 1 Sep 2006 08:42:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751165AbWIAMm3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 1 Sep 2006 08:42:29 -0400
Received: from mx1.redhat.com ([66.187.233.31]:35994 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S1751191AbWIAMm2 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 1 Sep 2006 08:42:28 -0400
From: David Howells <dhowells@redhat.com>
Subject: [PATCH 2/2] NOMMU: Check VMA protections
Date: Fri, 01 Sep 2006 13:42:10 +0100
To: torvalds@osdl.org, akpm@osdl.org
Cc: linux-kernel@vger.kernel.org, uclinux-dev@uclinux.org, dhowells@redhat.com
Message-Id: <20060901124210.26038.95789.stgit@warthog.cambridge.redhat.com>
In-Reply-To: <20060901124207.26038.24367.stgit@warthog.cambridge.redhat.com>
References: <20060901124207.26038.24367.stgit@warthog.cambridge.redhat.com>
Content-Type: text/plain; charset=utf-8; format=fixed
Content-Transfer-Encoding: 8bit
User-Agent: StGIT/0.10
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: David Howells <dhowells@redhat.com>

Check the VMA protections in get_user_pages() against what's being asked.

This checks to see that we don't accidentally write on a non-writable VMA or
permit an I/O mapping VMA to be accessed (which may lack page structs).

This should be applied on top of Sonic Zhang's patch to the same function.

Signed-Off-By: David Howells <dhowells@redhat.com>
---

 mm/nommu.c |   32 ++++++++++++++++++++++++++------
 1 files changed, 26 insertions(+), 6 deletions(-)

diff --git a/mm/nommu.c b/mm/nommu.c
index 2fe3fe4..fa6850e 100644
--- a/mm/nommu.c
+++ b/mm/nommu.c
@@ -122,20 +122,36 @@ unsigned int kobjsize(const void *objp)
 }
 
 /*
- * The nommu dodgy version :-)
+ * get a list of pages in an address range belonging to the specified process
+ * and indicate the VMA that covers each page
+ * - this is potentially dodgy as we may end incrementing the page count of a
+ *   slab page or a secondary page from a compound page
+ * - don't permit access to VMAs that don't support it, such as I/O mappings
  */
 int get_user_pages(struct task_struct *tsk, struct mm_struct *mm,
 	unsigned long start, int len, int write, int force,
 	struct page **pages, struct vm_area_struct **vmas)
 {
-	int i;
 	struct vm_area_struct *vma;
+	unsigned long vm_flags;
+	int i;
+
+	/* calculate required read or write permissions.
+	 * - if 'force' is set, we only require the "MAY" flags.
+	 */
+	vm_flags  = write ? (VM_WRITE | VM_MAYWRITE) : (VM_READ | VM_MAYREAD);
+	vm_flags &= force ? (VM_MAYREAD | VM_MAYWRITE) : (VM_READ | VM_WRITE);
 
 	for (i = 0; i < len; i++) {
 		vma = find_vma(mm, start);
-		if(!vma)
-			return i ? : -EFAULT;
-		
+		if (!vma)
+			goto finish_or_fault;
+
+		/* protect what we can, including chardevs */
+		if (vma->vm_flags & (VM_IO | VM_PFNMAP) ||
+		    !(vm_flags & vma->vm_flags))
+			goto finish_or_fault;
+
 		if (pages) {
 			pages[i] = virt_to_page(start);
 			if (pages[i])
@@ -145,7 +161,11 @@ int get_user_pages(struct task_struct *t
 			vmas[i] = vma;
 		start += PAGE_SIZE;
 	}
-	return(i);
+
+	return i;
+
+finish_or_fault:
+	return i ? : -EFAULT;
 }
 
 EXPORT_SYMBOL(get_user_pages);
