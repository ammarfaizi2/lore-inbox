Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932265AbVHKE60@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932265AbVHKE60 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 11 Aug 2005 00:58:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932267AbVHKE60
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 11 Aug 2005 00:58:26 -0400
Received: from mailout1.vmware.com ([65.113.40.130]:53254 "EHLO
	mailout1.vmware.com") by vger.kernel.org with ESMTP id S932266AbVHKE6Y
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 11 Aug 2005 00:58:24 -0400
Date: Wed, 10 Aug 2005 21:58:21 -0700
From: zach@vmware.com
Message-Id: <200508110458.j7B4wLq9019627@zach-dev.vmware.com>
To: akpm@osdl.org, chrisl@vmware.com, chrisw@osdl.org, hpa@zytor.com,
       Keir.Fraser@cl.cam.ac.uk, linux-kernel@vger.kernel.org,
       m+Ian.Pratt@cl.cam.ac.uk, mbligh@mbligh.org, pratap@vmware.com,
       virtualization@lists.osdl.org, zach@vmware.com, zwane@arm.linux.org.uk
Subject: [PATCH 13/14] i386 / Introduce hypervisor ldt hooks
X-OriginalArrivalTime: 11 Aug 2005 04:58:34.0795 (UTC) FILETIME=[53E3C7B0:01C59E31]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Add hooks that the hypervisor can use to establish writable and non-writable
pages for LDT pages.  I made these parallel the page flags as defined in
include/linux/page-flags.h, since the flag mechanism is very similar to the
hypercall page flagging, and extended easily later to include PT, PD, PDP,
GDT, etc.

Patch-against: 2.6.13-rc5-mm1
Patch-keys: i386 ldt paravirt xen
Signed-off-by: Zachary Amsden <zach@vmware.com>
Index: linux-2.6.13/arch/i386/kernel/ldt.c
===================================================================
--- linux-2.6.13.orig/arch/i386/kernel/ldt.c	2005-08-10 17:06:52.000000000 -0700
+++ linux-2.6.13/arch/i386/kernel/ldt.c	2005-08-10 17:11:38.000000000 -0700
@@ -18,6 +18,7 @@
 #include <asm/system.h>
 #include <asm/ldt.h>
 #include <asm/desc.h>
+#include <mach_pgalloc.h>
 
 #ifdef CONFIG_SMP /* avoids "defined but not used" warning */
 static void flush_ldt(void *null)
@@ -59,16 +60,19 @@
 #ifdef CONFIG_SMP
 		cpumask_t mask;
 		preempt_disable();
+		SetPagesLDT(pc->ldt, (pc->size * LDT_ENTRY_SIZE) / PAGE_SIZE);
 		load_LDT(pc);
 		mask = cpumask_of_cpu(smp_processor_id());
 		if (!cpus_equal(current->mm->cpu_vm_mask, mask))
 			smp_call_function(flush_ldt, NULL, 1, 1);
 		preempt_enable();
 #else
+		SetPagesLDT(pc->ldt, (pc->size * LDT_ENTRY_SIZE) / PAGE_SIZE);
 		load_LDT(pc);
 #endif
 	}
 	if (oldsize) {
+		ClearPagesLDT(oldldt, (oldsize * LDT_ENTRY_SIZE) / PAGE_SIZE);
 		if (oldsize*LDT_ENTRY_SIZE > PAGE_SIZE)
 			vfree(oldldt);
 		else
@@ -83,8 +87,10 @@
 
 	down(&old->sem);
 	err = alloc_ldt(new, 0, old->size, 0);
-	if (!err)
+	if (!err) {
 		memcpy(new->ldt, old->ldt, old->size*LDT_ENTRY_SIZE);
+		SetPagesLDT(new->ldt, (new->size * LDT_ENTRY_SIZE) / PAGE_SIZE);
+	}
 	up(&old->sem);
 	return err;
 }
@@ -93,6 +99,7 @@
 {
 	if (mm == current->active_mm)
 		clear_LDT();
+	ClearPagesLDT(mm->context.ldt, (mm->context.size * LDT_ENTRY_SIZE) / PAGE_SIZE);
 	if (mm->context.size*LDT_ENTRY_SIZE > PAGE_SIZE)
 		vfree(mm->context.ldt);
 	else
Index: linux-2.6.13/include/asm-i386/mach-default/mach_pgalloc.h
===================================================================
--- linux-2.6.13.orig/include/asm-i386/mach-default/mach_pgalloc.h	2005-08-10 17:11:38.000000000 -0700
+++ linux-2.6.13/include/asm-i386/mach-default/mach_pgalloc.h	2005-08-10 17:11:38.000000000 -0700
@@ -0,0 +1,7 @@
+#ifndef __ASM_MACH_PGALLOC_H
+#define __ASM_MACH_PGALLOC_H
+
+#define SetPagesLDT(_va, _pages)
+#define ClearPagesLDT(_va, _pages)
+
+#endif
