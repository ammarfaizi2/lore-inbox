Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261396AbUK1Dze@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261396AbUK1Dze (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 27 Nov 2004 22:55:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261397AbUK1Dze
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 27 Nov 2004 22:55:34 -0500
Received: from mail.ocs.com.au ([202.147.117.210]:15301 "EHLO mail.ocs.com.au")
	by vger.kernel.org with ESMTP id S261396AbUK1DzW (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 27 Nov 2004 22:55:22 -0500
X-Mailer: exmh version 2.6.3_20040314 03/14/2004 with nmh-1.0.4
From: Keith Owens <kaos@ocs.com.au>
To: linux-kernel@vger.kernel.org
Cc: sam@ravnborg.org
Subject: [patch 2/3] kallsyms: Add in_gate_area_no_task()
In-reply-to: Your message of "Sun, 28 Nov 2004 14:38:47 +1100."
             <28912.1101613127@ocs3.ocs.com.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Sun, 28 Nov 2004 14:55:15 +1100
Message-ID: <19457.1101614115@ocs3.ocs.com.au>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Add in_gate_area_no_task() for use in places where no task is valid
(e.g. kallsyms).  If you have a valid task, use in_gate_area() as
before.

Signed-off-by: Keith Owens <kaos@ocs.com.au>

Index: 2.6.10-rc2-bk11/arch/x86_64/mm/init.c
===================================================================
--- 2.6.10-rc2-bk11.orig/arch/x86_64/mm/init.c	2004-11-15 14:25:52.154487837 +1100
+++ 2.6.10-rc2-bk11/arch/x86_64/mm/init.c	2004-11-28 14:42:19.525997420 +1100
@@ -623,3 +623,13 @@ int in_gate_area(struct task_struct *tas
 	struct vm_area_struct *vma = get_gate_vma(task);
 	return (addr >= vma->vm_start) && (addr < vma->vm_end);
 }
+
+/* Use this when you have no reliable task/vma, typically from interrupt
+ * context.  It is less reliable than using the task's vma and may give
+ * false positives.
+ */
+int in_gate_area_no_task(unsigned long addr)
+{
+	return ((addr >= VSYSCALL_START) && (addr < VSYSCALL_END) ||
+		(addr >= VSYSCALL32_BASE) && (addr < VSYSCALL32_END));
+}
Index: 2.6.10-rc2-bk11/include/linux/mm.h
===================================================================
--- 2.6.10-rc2-bk11.orig/include/linux/mm.h	2004-11-28 14:42:13.868860636 +1100
+++ 2.6.10-rc2-bk11/include/linux/mm.h	2004-11-28 14:42:19.526997267 +1100
@@ -800,7 +800,13 @@ kernel_map_pages(struct page *page, int 
 #endif
 
 extern struct vm_area_struct *get_gate_vma(struct task_struct *tsk);
+#ifdef	__HAVE_ARCH_GATE_AREA
+int in_gate_area_no_task(unsigned long addr);
 int in_gate_area(struct task_struct *task, unsigned long addr);
+#else
+int in_gate_area_no_task(unsigned long addr);
+#define in_gate_area(task, addr) ({(void)task; in_gate_area_no_task(addr);})
+#endif	/* __HAVE_ARCH_GATE_AREA */
 
 #endif /* __KERNEL__ */
 #endif /* _LINUX_MM_H */
Index: 2.6.10-rc2-bk11/mm/memory.c
===================================================================
--- 2.6.10-rc2-bk11.orig/mm/memory.c	2004-11-28 14:42:13.870860331 +1100
+++ 2.6.10-rc2-bk11/mm/memory.c	2004-11-28 14:42:19.527997114 +1100
@@ -1837,7 +1837,7 @@ struct vm_area_struct *get_gate_vma(stru
 #endif
 }
 
-int in_gate_area(struct task_struct *task, unsigned long addr)
+int in_gate_area_no_task(unsigned long addr)
 {
 #ifdef AT_SYSINFO_EHDR
 	if ((addr >= FIXADDR_USER_START) && (addr < FIXADDR_USER_END))

