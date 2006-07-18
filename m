Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932127AbWGRJ0M@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932127AbWGRJ0M (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 18 Jul 2006 05:26:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932113AbWGRJ0I
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 18 Jul 2006 05:26:08 -0400
Received: from 216-99-217-87.dsl.aracnet.com ([216.99.217.87]:9601 "EHLO
	sous-sol.org") by vger.kernel.org with ESMTP id S932127AbWGRJVB
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 18 Jul 2006 05:21:01 -0400
Message-Id: <20060718091954.027734000@sous-sol.org>
References: <20060718091807.467468000@sous-sol.org>
User-Agent: quilt/0.45-1
Date: Tue, 18 Jul 2006 00:00:22 -0700
From: Chris Wright <chrisw@sous-sol.org>
To: linux-kernel@vger.kernel.org
Cc: virtualization@lists.osdl.org, xen-devel@lists.xensource.com,
       Jeremy Fitzhardinge <jeremy@goop.org>, Andi Kleen <ak@suse.de>,
       Andrew Morton <akpm@osdl.org>, Rusty Russell <rusty@rustcorp.com.au>,
       Zachary Amsden <zach@vmware.com>, Ian Pratt <ian.pratt@xensource.com>,
       Christian Limpach <Christian.Limpach@cl.cam.ac.uk>
Subject: [RFC PATCH 22/33] subarch stack pointer update
Content-Disposition: inline; filename=i386-tss
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Register the new kernel ('ring 0') stack pointer with the hypervisor
during context switch.

Signed-off-by: Ian Pratt <ian.pratt@xensource.com>
Signed-off-by: Christian Limpach <Christian.Limpach@cl.cam.ac.uk>
Signed-off-by: Chris Wright <chrisw@sous-sol.org>
---
 include/asm-i386/mach-default/mach_processor.h |    7 +++++++
 include/asm-i386/mach-xen/mach_processor.h     |    8 ++++++++
 include/asm-i386/processor.h                   |    1 +
 3 files changed, 16 insertions(+)

diff -r 60dd30eed8f3 include/asm-i386/mach-default/mach_processor.h
--- a/include/asm-i386/mach-default/mach_processor.h	Fri Mar 31 15:36:12 2006 +0100
+++ b/include/asm-i386/mach-default/mach_processor.h	Fri Mar 31 15:38:00 2006 +0100
@@ -4,4 +4,11 @@
 #define CPUID cpuid
 #define CPUID_STR "cpuid"
 
+#ifndef __ASSEMBLY__
+static inline void mach_update_kernel_stack(unsigned long esp0,
+					    unsigned short ss0)
+{
+}
+#endif
+
 #endif /* __ASM_MACH_PROCESSOR_H */
diff -r 60dd30eed8f3 include/asm-i386/mach-xen/mach_processor.h
--- a/include/asm-i386/mach-xen/mach_processor.h	Fri Mar 31 15:36:12 2006 +0100
+++ b/include/asm-i386/mach-xen/mach_processor.h	Fri Mar 31 15:38:00 2006 +0100
@@ -6,4 +6,12 @@
 #define CPUID XEN_CPUID
 #define CPUID_STR XEN_CPUID
 
+#ifndef __ASSEMBLY__
+static inline void mach_update_kernel_stack(unsigned long esp0,
+					    unsigned short ss0)
+{
+	HYPERVISOR_stack_switch(ss0, esp0);
+}
+#endif
+
 #endif /* __ASM_MACH_PROCESSOR_H */
diff -r 60dd30eed8f3 include/asm-i386/processor.h
--- a/include/asm-i386/processor.h	Fri Mar 31 15:36:12 2006 +0100
+++ b/include/asm-i386/processor.h	Fri Mar 31 15:38:00 2006 +0100
@@ -500,6 +500,7 @@ static inline void load_esp0(struct tss_
 		tss->ss1 = thread->sysenter_cs;
 		wrmsr(MSR_IA32_SYSENTER_CS, thread->sysenter_cs, 0);
 	}
+	mach_update_kernel_stack(tss->esp0, tss->ss0);
 }
 
 #define start_thread(regs, new_eip, new_esp) do {		\

--
