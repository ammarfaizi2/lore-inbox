Return-Path: <linux-kernel-owner+w=401wt.eu-S1422858AbXAMXP3@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422858AbXAMXP3 (ORCPT <rfc822;w@1wt.eu>);
	Sat, 13 Jan 2007 18:15:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1422824AbXAMXLd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 13 Jan 2007 18:11:33 -0500
Received: from gw.goop.org ([64.81.55.164]:59939 "EHLO mail.goop.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1422802AbXAMXLO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 13 Jan 2007 18:11:14 -0500
Message-Id: <20070113014649.046041214@goop.org>
References: <20070113014539.408244126@goop.org>
User-Agent: quilt/0.46-1
Date: Fri, 12 Jan 2007 17:45:57 -0800
From: Jeremy Fitzhardinge <jeremy@goop.org>
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org, virtualization@lists.osdl.org,
       xen-devel@lists.xensource.com, Ian Pratt <ian.pratt@xensource.com>,
       Christian Limpach <Christian.Limpach@cl.cam.ac.uk>,
       Chris Wright <chrisw@sous-sol.org>, "Jan Beulich" <JBeulich@novell.com>
Subject: [patch 18/20] XEN-paravirt: Add Xen driver utility functions.
Content-Disposition: inline; filename=xen-driver-util.patch
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Allocate/destroy a 'vmalloc' VM area: alloc_vm_area and free_vm_area
The alloc function ensures that page tables are constructed for the
region of kernel virtual address space and mapped into init_mm.

Lock an area so that PTEs are accessible in the current address space:
lock_vm_area and unlock_vm_area
The lock function prevents context switches to a lazy mm that doesn't
have the area mapped into its page tables.  It also ensures that the
page tables are mapped into the current mm by causing the page fault
handler to copy the page directory pointers from init_mm into the
current mm.

Signed-off-by: Ian Pratt <ian.pratt@xensource.com>
Signed-off-by: Christian Limpach <Christian.Limpach@cl.cam.ac.uk>
Signed-off-by: Chris Wright <chrisw@sous-sol.org>
Cc: "Jan Beulich" <JBeulich@novell.com>
---

 drivers/xen/Makefile      |    2 +
 drivers/xen/util.c        |   70 ++++++++++++++++++++++++++++++++++++++++++++++
 include/xen/driver_util.h |   16 ++++++++++
 3 files changed, 88 insertions(+)

===================================================================
--- a/drivers/xen/Makefile
+++ b/drivers/xen/Makefile
@@ -1,2 +1,4 @@ obj-y	+= core/
+obj-y	+= util.o
+
 obj-y	+= core/
 obj-y	+= console/
===================================================================
--- /dev/null
+++ b/drivers/xen/util.c
@@ -0,0 +1,69 @@
+#include <linux/mm.h>
+#include <linux/module.h>
+#include <linux/slab.h>
+#include <linux/vmalloc.h>
+#include <asm/uaccess.h>
+#include <xen/driver_util.h>
+
+static int f(pte_t *pte, struct page *pmd_page, unsigned long addr, void *data)
+{
+	/* apply_to_page_range() does all the hard work. */
+	return 0;
+}
+
+struct vm_struct *alloc_vm_area(unsigned long size)
+{
+	struct vm_struct *area;
+
+	area = get_vm_area(size, VM_IOREMAP);
+	if (area == NULL)
+		return NULL;
+
+	/*
+	 * This ensures that page tables are constructed for this region
+	 * of kernel virtual address space and mapped into init_mm.
+	 */
+	if (apply_to_page_range(&init_mm, (unsigned long)area->addr,
+				area->size, f, NULL)) {
+		free_vm_area(area);
+		return NULL;
+	}
+
+	return area;
+}
+EXPORT_SYMBOL_GPL(alloc_vm_area);
+
+void free_vm_area(struct vm_struct *area)
+{
+	struct vm_struct *ret;
+	ret = remove_vm_area(area->addr);
+	BUG_ON(ret != area);
+	kfree(area);
+}
+EXPORT_SYMBOL_GPL(free_vm_area);
+
+void lock_vm_area(struct vm_struct *area)
+{
+	unsigned long i;
+	char c;
+
+	/*
+	 * Prevent context switch to a lazy mm that doesn't have this area
+	 * mapped into its page tables.
+	 */
+	preempt_disable();
+
+	/*
+	 * Ensure that the page tables are mapped into the current mm. The
+	 * page-fault path will copy the page directory pointers from init_mm.
+	 */
+	for (i = 0; i < area->size; i += PAGE_SIZE)
+		(void)__get_user(c, (char __user *)area->addr + i);
+}
+EXPORT_SYMBOL_GPL(lock_vm_area);
+
+void unlock_vm_area(struct vm_struct *area)
+{
+	preempt_enable();
+}
+EXPORT_SYMBOL_GPL(unlock_vm_area);
===================================================================
--- /dev/null
+++ b/include/xen/driver_util.h
@@ -0,0 +1,15 @@
+
+#ifndef __ASM_XEN_DRIVER_UTIL_H__
+#define __ASM_XEN_DRIVER_UTIL_H__
+
+#include <linux/vmalloc.h>
+
+/* Allocate/destroy a 'vmalloc' VM area. */
+extern struct vm_struct *alloc_vm_area(unsigned long size);
+extern void free_vm_area(struct vm_struct *area);
+
+/* Lock an area so that PTEs are accessible in the current address space. */
+extern void lock_vm_area(struct vm_struct *area);
+extern void unlock_vm_area(struct vm_struct *area);
+
+#endif /* __ASM_XEN_DRIVER_UTIL_H__ */

-- 

