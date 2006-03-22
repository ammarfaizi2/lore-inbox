Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750954AbWCVGoz@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750954AbWCVGoz (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 22 Mar 2006 01:44:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750880AbWCVGh7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 22 Mar 2006 01:37:59 -0500
Received: from 216-99-217-87.dsl.aracnet.com ([216.99.217.87]:50306 "EHLO
	sorel.sous-sol.org") by vger.kernel.org with ESMTP id S1750879AbWCVGhj
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 22 Mar 2006 01:37:39 -0500
Message-Id: <20060322063754.876841000@sorel.sous-sol.org>
References: <20060322063040.960068000@sorel.sous-sol.org>
Date: Tue, 21 Mar 2006 22:31:00 -0800
From: Chris Wright <chrisw@sous-sol.org>
To: linux-kernel@vger.kernel.org
Cc: xen-devel@lists.xensource.com, virtualization@lists.osdl.org,
       Ian Pratt <ian.pratt@xensource.com>,
       Christian Limpach <Christian.Limpach@cl.cam.ac.uk>
Subject: [RFC PATCH 20/35] subarch stack pointer update
Content-Disposition: inline; filename=19-i386-tss
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Register the new kernel ('ring 0') stack pointer with the hypervisor
during context switch. 

Signed-off-by: Ian Pratt <ian.pratt@xensource.com>
Signed-off-by: Christian Limpach <Christian.Limpach@cl.cam.ac.uk>
Signed-off-by: Chris Wright <chrisw@sous-sol.org>
---
 include/asm-i386/mach-default/mach_processor.h |    8 ++++++++
 include/asm-i386/mach-xen/mach_processor.h     |    9 +++++++++
 include/asm-i386/processor.h                   |    3 +++
 3 files changed, 20 insertions(+)

--- xen-subarch-2.6.orig/include/asm-i386/processor.h
+++ xen-subarch-2.6/include/asm-i386/processor.h
@@ -472,6 +472,8 @@ struct thread_struct {
 	.io_bitmap_ptr = NULL,						\
 }
 
+#include <mach_processor.h>
+
 /*
  * Note that the .io_bitmap member must be extra-big. This is because
  * the CPU will access an additional byte beyond the end of the IO
@@ -494,6 +496,7 @@ static inline void load_esp0(struct tss_
 		tss->ss1 = thread->sysenter_cs;
 		wrmsr(MSR_IA32_SYSENTER_CS, thread->sysenter_cs, 0);
 	}
+	mach_load_esp0(tss, thread);
 }
 
 #define start_thread(regs, new_eip, new_esp) do {		\
--- /dev/null
+++ xen-subarch-2.6/include/asm-i386/mach-xen/mach_processor.h
@@ -0,0 +1,9 @@
+#ifndef __ASM_MACH_PROCESSOR_H
+#define __ASM_MACH_PROCESSOR_H
+
+static inline void mach_load_esp0(struct tss_struct *tss, struct thread_struct *thread)
+{
+	HYPERVISOR_stack_switch(tss->ss0, tss->esp0);
+}
+
+#endif /* __ASM_MACH_PROCESSOR_H */
--- /dev/null
+++ xen-subarch-2.6/include/asm-i386/mach-default/mach_processor.h
@@ -0,0 +1,8 @@
+#ifndef __ASM_MACH_PROCESSOR_H
+#define __ASM_MACH_PROCESSOR_H
+
+static inline void mach_load_esp0(struct tss_struct *tss, struct thread_struct *thread)
+{
+}
+
+#endif /* __ASM_MACH_PROCESSOR_H */

--
