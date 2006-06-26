Return-Path: <linux-kernel-owner+willy=40w.ods.org-S933152AbWFZXic@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933152AbWFZXic (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 26 Jun 2006 19:38:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S933148AbWFZWei
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 26 Jun 2006 18:34:38 -0400
Received: from cust9421.vic01.dataco.com.au ([203.171.70.205]:29599 "EHLO
	nigel.suspend2.net") by vger.kernel.org with ESMTP id S933136AbWFZWe2
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 26 Jun 2006 18:34:28 -0400
From: Nigel Cunningham <nigel@suspend2.net>
Subject: [Suspend2][ 4/9] [Suspend2] Mark a task as pageset 1.
Date: Tue, 27 Jun 2006 08:34:26 +1000
To: linux-kernel@vger.kernel.org
Message-Id: <20060626223425.3963.37085.stgit@nigel.suspend2.net>
In-Reply-To: <20060626223412.3963.1484.stgit@nigel.suspend2.net>
References: <20060626223412.3963.1484.stgit@nigel.suspend2.net>
Content-Type: text/plain; charset=utf-8; format=fixed
Content-Transfer-Encoding: 8bit
User-Agent: StGIT/0.9
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Mark a task's pages as for the atomic copy, even when they would normally
be saved as LRU pages. This is used for the userspace helpers, which need
to keep running during suspend, and not have their data overwritten by the
atomic copy.

Signed-off-by: Nigel Cunningham <nigel@suspend2.net>

 kernel/power/pagedir.c |   49 ++++++++++++++++++++++++++++++++++++++++++++++++
 1 files changed, 49 insertions(+), 0 deletions(-)

diff --git a/kernel/power/pagedir.c b/kernel/power/pagedir.c
index 76da2e5..b7fc3bc 100644
--- a/kernel/power/pagedir.c
+++ b/kernel/power/pagedir.c
@@ -129,3 +129,52 @@ int suspend_allocate_extra_pagedir_memor
 	return 0;
 }
 
+/*
+ * suspend_mark_task_as_pageset1
+ * Functionality   : Marks all the pages belonging to a given process as
+ *                   pageset 1 pages.
+ * Called From     : pagedir.c - mark_pages_for_pageset2
+ *
+ */
+extern struct page *suspend2_follow_page(struct mm_struct *mm, unsigned long address);
+
+void suspend_mark_task_as_pageset1(struct task_struct *t)
+{
+	struct vm_area_struct *vma;
+	struct mm_struct *mm;
+
+	mm = t->active_mm;
+
+	if (!mm || !mm->mmap) return;
+
+	/* Don't try to take the sem when processes are frozen, 
+	 * drivers are suspended and irqs are disabled. We're
+	 * not racing with anything anyway.  */
+	BUG_ON(in_atomic() && !irqs_disabled());
+
+	if (!irqs_disabled())
+		down_read(&mm->mmap_sem);
+	
+	for (vma = mm->mmap; vma; vma = vma->vm_next) {
+		if (vma->vm_flags & VM_PFNMAP)
+			continue;
+		if (vma->vm_start) {
+			unsigned long posn;
+			for (posn = vma->vm_start; posn < vma->vm_end;
+					posn += PAGE_SIZE) {
+				struct page *page = 
+					suspend2_follow_page(mm, posn);
+				if (page) {
+					ClearPagePageset2(page);
+					SetPagePageset1(page);
+				}
+			}
+		}
+	}
+
+	BUG_ON(in_atomic() && !irqs_disabled());
+
+	if (!irqs_disabled())
+		up_read(&mm->mmap_sem);
+}
+

--
Nigel Cunningham		nigel at suspend2 dot net
