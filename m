Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965198AbWH2SBW@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965198AbWH2SBW (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 29 Aug 2006 14:01:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965199AbWH2SBG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 29 Aug 2006 14:01:06 -0400
Received: from mx1.redhat.com ([66.187.233.31]:16096 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S965198AbWH2SBE (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 29 Aug 2006 14:01:04 -0400
From: David Howells <dhowells@redhat.com>
Subject: [PATCH 2/2] NOMMU: Check that access_process_vm() has a valid target
Date: Tue, 29 Aug 2006 18:59:51 +0100
To: torvalds@osdl.org, akpm@osdl.org
Cc: linux-kernel@vger.kernel.org, uclinux-dev@uclinux.org, dhowells@redhat.com
Message-Id: <20060829175951.32281.76850.stgit@warthog.cambridge.redhat.com>
In-Reply-To: <20060829175949.32281.21374.stgit@warthog.cambridge.redhat.com>
References: <20060829175949.32281.21374.stgit@warthog.cambridge.redhat.com>
Content-Type: text/plain; charset=utf-8; format=fixed
Content-Transfer-Encoding: 8bit
User-Agent: StGIT/0.10
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: David Howells <dhowells@redhat.com>

Check that access_process_vm() is accessing a valid mapping in the target
process.

This limits ptrace() accesses and accesses through /proc/<pid>/maps to only
those regions actually mapped by a program.

Signed-Off-By: David Howells <dhowells@redhat.com>
---

 kernel/ptrace.c |   54 ------------------------------------------------------
 mm/memory.c     |   53 +++++++++++++++++++++++++++++++++++++++++++++++++++++
 mm/nommu.c      |   47 +++++++++++++++++++++++++++++++++++++++++++++++
 3 files changed, 100 insertions(+), 54 deletions(-)

diff --git a/kernel/ptrace.c b/kernel/ptrace.c
index 9a111f7..8aad033 100644
--- a/kernel/ptrace.c
+++ b/kernel/ptrace.c
@@ -241,60 +241,6 @@ int ptrace_detach(struct task_struct *ch
 	return 0;
 }
 
-/*
- * Access another process' address space.
- * Source/target buffer must be kernel space, 
- * Do not walk the page table directly, use get_user_pages
- */
-
-int access_process_vm(struct task_struct *tsk, unsigned long addr, void *buf, int len, int write)
-{
-	struct mm_struct *mm;
-	struct vm_area_struct *vma;
-	struct page *page;
-	void *old_buf = buf;
-
-	mm = get_task_mm(tsk);
-	if (!mm)
-		return 0;
-
-	down_read(&mm->mmap_sem);
-	/* ignore errors, just check how much was sucessfully transfered */
-	while (len) {
-		int bytes, ret, offset;
-		void *maddr;
-
-		ret = get_user_pages(tsk, mm, addr, 1,
-				write, 1, &page, &vma);
-		if (ret <= 0)
-			break;
-
-		bytes = len;
-		offset = addr & (PAGE_SIZE-1);
-		if (bytes > PAGE_SIZE-offset)
-			bytes = PAGE_SIZE-offset;
-
-		maddr = kmap(page);
-		if (write) {
-			copy_to_user_page(vma, page, addr,
-					  maddr + offset, buf, bytes);
-			set_page_dirty_lock(page);
-		} else {
-			copy_from_user_page(vma, page, addr,
-					    buf, maddr + offset, bytes);
-		}
-		kunmap(page);
-		page_cache_release(page);
-		len -= bytes;
-		buf += bytes;
-		addr += bytes;
-	}
-	up_read(&mm->mmap_sem);
-	mmput(mm);
-	
-	return buf - old_buf;
-}
-
 int ptrace_readdata(struct task_struct *tsk, unsigned long src, char __user *dst, int len)
 {
 	int copied = 0;
diff --git a/mm/memory.c b/mm/memory.c
index 109e986..f915984 100644
--- a/mm/memory.c
+++ b/mm/memory.c
@@ -2505,3 +2505,56 @@ #endif
 }
 
 #endif	/* __HAVE_ARCH_GATE_AREA */
+
+/*
+ * Access another process' address space.
+ * Source/target buffer must be kernel space, 
+ * Do not walk the page table directly, use get_user_pages
+ */
+int access_process_vm(struct task_struct *tsk, unsigned long addr, void *buf, int len, int write)
+{
+	struct mm_struct *mm;
+	struct vm_area_struct *vma;
+	struct page *page;
+	void *old_buf = buf;
+
+	mm = get_task_mm(tsk);
+	if (!mm)
+		return 0;
+
+	down_read(&mm->mmap_sem);
+	/* ignore errors, just check how much was sucessfully transfered */
+	while (len) {
+		int bytes, ret, offset;
+		void *maddr;
+
+		ret = get_user_pages(tsk, mm, addr, 1,
+				write, 1, &page, &vma);
+		if (ret <= 0)
+			break;
+
+		bytes = len;
+		offset = addr & (PAGE_SIZE-1);
+		if (bytes > PAGE_SIZE-offset)
+			bytes = PAGE_SIZE-offset;
+
+		maddr = kmap(page);
+		if (write) {
+			copy_to_user_page(vma, page, addr,
+					  maddr + offset, buf, bytes);
+			set_page_dirty_lock(page);
+		} else {
+			copy_from_user_page(vma, page, addr,
+					    buf, maddr + offset, bytes);
+		}
+		kunmap(page);
+		page_cache_release(page);
+		len -= bytes;
+		buf += bytes;
+		addr += bytes;
+	}
+	up_read(&mm->mmap_sem);
+	mmput(mm);
+	
+	return buf - old_buf;
+}
diff --git a/mm/nommu.c b/mm/nommu.c
index c576df7..663ec1c 100644
--- a/mm/nommu.c
+++ b/mm/nommu.c
@@ -1206,3 +1206,50 @@ struct page *filemap_nopage(struct vm_ar
 	BUG();
 	return NULL;
 }
+
+/*
+ * Access another process' address space.
+ * - source/target buffer must be kernel space
+ */
+int access_process_vm(struct task_struct *tsk, unsigned long addr, void *buf, int len, int write)
+{
+	struct vm_list_struct *vml;
+	struct vm_area_struct *vma;
+	struct mm_struct *mm;
+
+	if (addr + len < addr)
+		return 0;
+
+	mm = get_task_mm(tsk);
+	if (!mm)
+		return 0;
+
+	down_read(&mm->mmap_sem);
+
+	/* the access must start within one of the target process's mappings */
+	for (vml = mm->context.vmlist; vml; vml = vml->next)
+		if (addr >= vml->vma->vm_start && addr < vml->vma->vm_end)
+			break;
+
+	if (vml) {
+		vma = vml->vma;
+
+		/* don't overrun this mapping */
+		if (addr + len >= vma->vm_end)
+			len = vma->vm_end - addr;
+
+		/* only read or write mappings where it is permitted */
+		if (write && vma->vm_flags & VM_WRITE)
+			len -= copy_to_user((void *) addr, buf, len);
+		else if (!write && vma->vm_flags & VM_READ)
+			len -= copy_from_user(buf, (void *) addr, len);
+		else
+			len = 0;
+	} else {
+		len = 0;
+	}
+
+	up_read(&mm->mmap_sem);
+	mmput(mm);
+	return len;
+}
