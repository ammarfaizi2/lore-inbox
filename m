Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261899AbTJGIyg (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 7 Oct 2003 04:54:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261901AbTJGIyg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 7 Oct 2003 04:54:36 -0400
Received: from mail12.speakeasy.net ([216.254.0.212]:59342 "EHLO
	mail.speakeasy.net") by vger.kernel.org with ESMTP id S261899AbTJGIyd
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 7 Oct 2003 04:54:33 -0400
Date: Tue, 7 Oct 2003 01:54:29 -0700
Message-Id: <200310070854.h978sTsY003001@magilla.sf.frob.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
From: Roland McGrath <roland@redhat.com>
To: Andrew Morton <akpm@osdl.org>, Linus Torvalds <torvalds@osdl.org>
X-Fcc: ~/Mail/linus
Cc: Ingo Molnar <mingo@redhat.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: [PATCH] report user-readable fixmap area in /proc/PID/maps
X-Windows: you'll envy the dead.
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This patch makes /proc/PID/maps report the range from FIXADDR_USER_START to
FIXADDR_USER_END as a final pseudo-vma.  This is consistent with the notion
that reading /proc/PID/maps tells you about every page containing data that
the process can in fact access, and with things such as ptrace allowing
access to this memory.  Without this, userland tools that want to look at
all of a process's accessible pages need special-case knowledge about
things such as the vsyscall DSO page.  With this change, existing code that
iterates over the /proc/PID/maps lines will cover those pages like any other.
For example, this lets gdb's "gcore" command synthesize a core file from a
live process that contains the vsyscall DSO page as a real core dump would,
using its existing generic iterator code and no new special cases.

If this change goes in, the fixmap_vma variable could be shared with the
get_user_pages code that has an identical static variable.


Thanks,
Roland


Index: linux-2.6/fs/proc/task_mmu.c
===================================================================
RCS file: /home/cvs/linux-2.5/fs/proc/task_mmu.c,v
retrieving revision 1.6
diff -p -b -u -r1.6 task_mmu.c
--- linux-2.6/fs/proc/task_mmu.c 31 Aug 2003 19:31:55 -0000 1.6
+++ linux-2.6/fs/proc/task_mmu.c 7 Oct 2003 06:54:56 -0000
@@ -2,6 +2,7 @@
 #include <linux/hugetlb.h>
 #include <linux/seq_file.h>
 #include <asm/uaccess.h>
+#include <asm/pgtable.h>
 
 char *task_mem(struct mm_struct *mm, char *buffer)
 {
@@ -111,6 +112,16 @@ static int show_map(struct seq_file *m, 
 	return 0;
 }
 
+#ifdef FIXADDR_USER_START
+static struct vm_area_struct fixmap_vma = {
+	.vm_mm = NULL,
+	.vm_start = FIXADDR_USER_START,
+	.vm_end = FIXADDR_USER_END,
+	.vm_page_prot = PAGE_READONLY,
+	.vm_flags = VM_READ | VM_EXEC,
+};
+#endif
+
 static void *m_start(struct seq_file *m, loff_t *pos)
 {
 	struct task_struct *task = m->private;
@@ -128,6 +139,10 @@ static void *m_start(struct seq_file *m,
 	if (!map) {
 		up_read(&mm->mmap_sem);
 		mmput(mm);
+#ifdef FIXADDR_USER_START
+		if (l == (loff_t) -1)
+			map = &fixmap_vma;
+#endif
 	}
 	return map;
 }
@@ -135,6 +150,10 @@ static void *m_start(struct seq_file *m,
 static void m_stop(struct seq_file *m, void *v)
 {
 	struct vm_area_struct *map = v;
+#ifdef FIXADDR_USER_START
+	if (map == &fixmap_vma)
+		return;
+#endif
 	if (map) {
 		struct mm_struct *mm = map->vm_mm;
 		up_read(&mm->mmap_sem);
@@ -149,6 +168,10 @@ static void *m_next(struct seq_file *m, 
 	if (map->vm_next)
 		return map->vm_next;
 	m_stop(m, v);
+#ifdef FIXADDR_USER_START
+	if (map != &fixmap_vma)
+		return &fixmap_vma;
+#endif
 	return NULL;
 }
