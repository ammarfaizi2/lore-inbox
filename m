Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262822AbVG3EGq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262822AbVG3EGq (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 30 Jul 2005 00:06:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262871AbVG3EGq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 30 Jul 2005 00:06:46 -0400
Received: from mailout1.vmware.com ([65.113.40.130]:41741 "EHLO
	mailout1.vmware.com") by vger.kernel.org with ESMTP id S262822AbVG3EGm
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 30 Jul 2005 00:06:42 -0400
Date: Fri, 29 Jul 2005 21:04:16 -0700
From: zach@vmware.com
Message-Id: <200507300404.j6U44GSC005922@zach-dev.vmware.com>
To: akpm@osdl.org, chrisl@vmware.com, davej@codemonkey.org.uk, hpa@zytor.com,
       linux-kernel@vger.kernel.org, pratap@vmware.com, Riley@Williams.Name,
       zach@vmware.com
Subject: [PATCH] 2/6 i386 serialize-msr
X-OriginalArrivalTime: 30 Jul 2005 04:05:16.0265 (UTC) FILETIME=[E475D590:01C594BB]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

i386 arch cleanup.  Introduce the serialize macro to serialize processor state.
Why the microcode update needs it I am not quite sure, since wrmsr() is already
a serializing instruction, but it is a microcode update, so I will keep the
semantic the same, since this could be a timing workaround.  As far as I can
tell, this has always been there since the original microcode update source.

Signed-off-by: Zachary Amsden <zach@vmware.com>

Index: linux-2.6.13/arch/i386/kernel/microcode.c
===================================================================
--- linux-2.6.13.orig/arch/i386/kernel/microcode.c	2005-07-29 11:14:33.000000000 -0700
+++ linux-2.6.13/arch/i386/kernel/microcode.c	2005-07-29 11:16:18.000000000 -0700
@@ -164,7 +164,8 @@
 	}
 
 	wrmsr(MSR_IA32_UCODE_REV, 0, 0);
-	__asm__ __volatile__ ("cpuid" : : : "ax", "bx", "cx", "dx");
+	/* XXX needed? wrmsr should serialize unless a chip bug */
+	serialize(); 
 	/* get the current revision from MSR 0x8B */
 	rdmsr(MSR_IA32_UCODE_REV, val[0], uci->rev);
 	pr_debug("microcode: collect_cpu_info : sig=0x%x, pf=0x%x, rev=0x%x\n",
@@ -377,7 +378,9 @@
 		(unsigned long) uci->mc->bits >> 16 >> 16);
 	wrmsr(MSR_IA32_UCODE_REV, 0, 0);
 
-	__asm__ __volatile__ ("cpuid" : : : "ax", "bx", "cx", "dx");
+	/* XXX needed? wrmsr should serialize unless a chip bug */
+	serialize(); 
+
 	/* get the current revision from MSR 0x8B */
 	rdmsr(MSR_IA32_UCODE_REV, val[0], val[1]);
 
Index: linux-2.6.13/include/asm-i386/processor.h
===================================================================
--- linux-2.6.13.orig/include/asm-i386/processor.h	2005-07-29 11:16:10.000000000 -0700
+++ linux-2.6.13/include/asm-i386/processor.h	2005-07-29 11:16:28.000000000 -0700
@@ -277,6 +277,11 @@
 	outb((data), 0x23); \
 } while (0)
 
+static inline void serialize(void)
+{
+	 __asm__ __volatile__ ("cpuid" : : : "ax", "bx", "cx", "dx");
+}
+
 static inline void __monitor(const void *eax, unsigned long ecx,
 		unsigned long edx)
 {
