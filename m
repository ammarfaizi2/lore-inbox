Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751475AbWEIIvr@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751475AbWEIIvr (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 9 May 2006 04:51:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751484AbWEIIv3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 9 May 2006 04:51:29 -0400
Received: from 216-99-217-87.dsl.aracnet.com ([216.99.217.87]:3968 "EHLO
	sous-sol.org") by vger.kernel.org with ESMTP id S1751475AbWEIIta
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 9 May 2006 04:49:30 -0400
Message-Id: <20060509085153.630700000@sous-sol.org>
References: <20060509084945.373541000@sous-sol.org>
Date: Tue, 09 May 2006 00:00:14 -0700
From: Chris Wright <chrisw@sous-sol.org>
To: linux-kernel@vger.kernel.org
Cc: virtualization@lists.osdl.org, xen-devel@lists.xensource.com,
       Ian Pratt <ian.pratt@xensource.com>,
       Christian Limpach <Christian.Limpach@cl.cam.ac.uk>
Subject: [RFC PATCH 14/35] Subarch support for CPUID instruction
Content-Disposition: inline; filename=i386-cpuid
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Allow subarchitectures to modify the CPUID instruction.  This allows
the subarch to provide a limited set of CPUID feature flags during CPU
identification.  Add a subarch implementation for Xen that traps to the
hypervisor where unsupported feature flags can be hidden from guests.

Signed-off-by: Ian Pratt <ian.pratt@xensource.com>
Signed-off-by: Christian Limpach <Christian.Limpach@cl.cam.ac.uk>
Signed-off-by: Chris Wright <chrisw@sous-sol.org>
---
 arch/i386/kernel/head-cpu.S                    |    4 ++--
 include/asm-i386/mach-default/mach_processor.h |    7 +++++++
 include/asm-i386/mach-xen/mach_processor.h     |    9 +++++++++
 include/asm-i386/processor.h                   |   13 +++++++------
 4 files changed, 25 insertions(+), 8 deletions(-)

--- linus-2.6.orig/include/asm-i386/processor.h
+++ linus-2.6/include/asm-i386/processor.h
@@ -21,6 +21,7 @@
 #include <linux/threads.h>
 #include <asm/percpu.h>
 #include <linux/cpumask.h>
+#include <mach_processor.h>
 
 /* flag for disabling the tsc */
 extern int tsc_disable;
@@ -148,7 +149,7 @@ static inline void detect_ht(struct cpui
  */
 static inline void cpuid(unsigned int op, unsigned int *eax, unsigned int *ebx, unsigned int *ecx, unsigned int *edx)
 {
-	__asm__("cpuid"
+	__asm__(CPUID_STR
 		: "=a" (*eax),
 		  "=b" (*ebx),
 		  "=c" (*ecx),
@@ -160,7 +161,7 @@ static inline void cpuid(unsigned int op
 static inline void cpuid_count(int op, int count, int *eax, int *ebx, int *ecx,
 	       	int *edx)
 {
-	__asm__("cpuid"
+	__asm__(CPUID_STR
 		: "=a" (*eax),
 		  "=b" (*ebx),
 		  "=c" (*ecx),
@@ -175,7 +176,7 @@ static inline unsigned int cpuid_eax(uns
 {
 	unsigned int eax;
 
-	__asm__("cpuid"
+	__asm__(CPUID_STR
 		: "=a" (eax)
 		: "0" (op)
 		: "bx", "cx", "dx");
@@ -185,7 +186,7 @@ static inline unsigned int cpuid_ebx(uns
 {
 	unsigned int eax, ebx;
 
-	__asm__("cpuid"
+	__asm__(CPUID_STR
 		: "=a" (eax), "=b" (ebx)
 		: "0" (op)
 		: "cx", "dx" );
@@ -195,7 +196,7 @@ static inline unsigned int cpuid_ecx(uns
 {
 	unsigned int eax, ecx;
 
-	__asm__("cpuid"
+	__asm__(CPUID_STR
 		: "=a" (eax), "=c" (ecx)
 		: "0" (op)
 		: "bx", "dx" );
@@ -205,7 +206,7 @@ static inline unsigned int cpuid_edx(uns
 {
 	unsigned int eax, edx;
 
-	__asm__("cpuid"
+	__asm__(CPUID_STR
 		: "=a" (eax), "=d" (edx)
 		: "0" (op)
 		: "bx", "cx");
--- linus-2.6.orig/arch/i386/kernel/head-cpu.S
+++ linus-2.6/arch/i386/kernel/head-cpu.S
@@ -59,7 +59,7 @@
 .macro CPUID_GET_VENDOR_INFO cpuid_level, x86_vendor_id
 	/* get vendor info */
 	xorl %eax,%eax			# call CPUID with 0 -> return vendor ID
-	cpuid
+	CPUID
 	movl %eax,\cpuid_level		# save CPUID level
 	movl %ebx,\x86_vendor_id	# lo 4 chars
 	movl %edx,\x86_vendor_id+4	# next 4 chars
@@ -75,7 +75,7 @@
  */
 .macro CPUID_GET_CPU_TYPE family, model, mask, capability
 	movl $1,%eax		# Use the CPUID instruction to get CPU type
-	cpuid
+	CPUID
 	movb %al,%cl		# save reg for future use
 	andb $0x0f,%ah		# mask processor family
 	movb %ah,\family
--- /dev/null
+++ linus-2.6/include/asm-i386/mach-default/mach_processor.h
@@ -0,0 +1,7 @@
+#ifndef __ASM_MACH_PROCESSOR_H
+#define __ASM_MACH_PROCESSOR_H
+
+#define CPUID cpuid
+#define CPUID_STR "cpuid"
+
+#endif /* __ASM_MACH_PROCESSOR_H */
--- /dev/null
+++ linus-2.6/include/asm-i386/mach-xen/mach_processor.h
@@ -0,0 +1,9 @@
+#ifndef __ASM_MACH_PROCESSOR_H
+#define __ASM_MACH_PROCESSOR_H
+
+#include <xen/interface/arch-x86_32.h>
+
+#define CPUID XEN_CPUID
+#define CPUID_STR XEN_CPUID
+
+#endif /* __ASM_MACH_PROCESSOR_H */

--
