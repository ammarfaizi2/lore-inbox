Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750978AbWCVGrQ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750978AbWCVGrQ (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 22 Mar 2006 01:47:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750887AbWCVGqw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 22 Mar 2006 01:46:52 -0500
Received: from 216-99-217-87.dsl.aracnet.com ([216.99.217.87]:38273 "EHLO
	sorel.sous-sol.org") by vger.kernel.org with ESMTP id S1750891AbWCVGhz
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 22 Mar 2006 01:37:55 -0500
Message-Id: <20060322063806.845778000@sorel.sous-sol.org>
References: <20060322063040.960068000@sorel.sous-sol.org>
Date: Tue, 21 Mar 2006 22:31:12 -0800
From: Chris Wright <chrisw@sous-sol.org>
To: linux-kernel@vger.kernel.org
Cc: xen-devel@lists.xensource.com, virtualization@lists.osdl.org,
       Ian Pratt <ian.pratt@xensource.com>,
       Christian Limpach <Christian.Limpach@cl.cam.ac.uk>
Subject: [RFC PATCH 32/35] Add Xen driver utility functions.
Content-Disposition: inline; filename=31-driver-util
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
---
 drivers/xen/Makefile      |    2 +
 drivers/xen/util.c        |   70 ++++++++++++++++++++++++++++++++++++++++++++++
 include/xen/driver_util.h |   16 ++++++++++
 3 files changed, 88 insertions(+)

--- xen-subarch-2.6.orig/drivers/xen/Makefile
+++ xen-subarch-2.6/drivers/xen/Makefile
@@ -1,2 +1,4 @@
 
+obj-y	+= util.o
+
 obj-y	+= console/
--- /dev/null
+++ xen-subarch-2.6/drivers/xen/util.c
@@ -0,0 +1,70 @@
+#include <linux/config.h>
+#include <linux/mm.h>
+#include <linux/module.h>
+#include <linux/slab.h>
+#include <linux/vmalloc.h>
+#include <asm/uaccess.h>
+#include <xen/driver_util.h>
+
+static int f(pte_t *pte, struct page *pte_page, unsigned long addr, void *data)
+{
+	/* generic_page_range() does all the hard work. */
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
+	if (generic_page_range(&init_mm, (unsigned long)area->addr,
+			       area->size, f, NULL)) {
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
--- /dev/null
+++ xen-subarch-2.6/include/xen/driver_util.h
@@ -0,0 +1,16 @@
+
+#ifndef __ASM_XEN_DRIVER_UTIL_H__
+#define __ASM_XEN_DRIVER_UTIL_H__
+
+#include <linux/config.h>
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
