Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932310AbWCMSMY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932310AbWCMSMY (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 13 Mar 2006 13:12:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932305AbWCMSMX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 13 Mar 2006 13:12:23 -0500
Received: from mailout1.vmware.com ([65.113.40.130]:15621 "EHLO
	mailout1.vmware.com") by vger.kernel.org with ESMTP id S932310AbWCMSMV
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 13 Mar 2006 13:12:21 -0500
Date: Mon, 13 Mar 2006 10:12:16 -0800
Message-Id: <200603131812.k2DICGJE005747@zach-dev.vmware.com>
Subject: [RFC, PATCH 17/24] i386 Vmi msr patch
From: Zachary Amsden <zach@vmware.com>
To: Linus Torvalds <torvalds@osdl.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Virtualization Mailing List <virtualization@lists.osdl.org>,
       Xen-devel <xen-devel@lists.xensource.com>,
       Andrew Morton <akpm@osdl.org>, Zachary Amsden <zach@vmware.com>,
       Dan Hecht <dhecht@vmware.com>, Dan Arai <arai@vmware.com>,
       Anne Holler <anne@vmware.com>, Pratap Subrahmanyam <pratap@vmware.com>,
       Christopher Li <chrisl@vmware.com>, Joshua LeVasseur <jtl@ira.uka.de>,
       Chris Wright <chrisw@osdl.org>, Rik Van Riel <riel@redhat.com>,
       Jyothy Reddy <jreddy@vmware.com>, Jack Lo <jlo@vmware.com>,
       Kip Macy <kmacy@fsmware.com>, Jan Beulich <jbeulich@novell.com>,
       Ky Srinivasan <ksrinivasan@novell.com>,
       Wim Coekaerts <wim.coekaerts@oracle.com>,
       Leendert van Doorn <leendert@watson.ibm.com>,
       Zachary Amsden <zach@vmware.com>
X-OriginalArrivalTime: 13 Mar 2006 18:12:16.0336 (UTC) FILETIME=[A8F0C500:01C646C9]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Fairly straightforward code motion of MSR / TSC / PMC accessors
to the sub-arch level.  Note that rdmsr/wrmsr_safe functions are
not moved; Linux relies on the fault behavior here in the event
that certain MSRs are not supported on hardware, and combining
this with a VMI wrapper is overly complicated.  The instructions
are virtualizable with trap and emulate, not on critical code
paths, and only used as part of the MSR /proc device, which is
highly sketchy to use inside a virtual machine, but must be
allowed as part of the compile, since it is useful on native.

Signed-off-by: Zachary Amsden <zach@vmware.com>

Index: linux-2.6.16-rc5/include/asm-i386/msr.h
===================================================================
--- linux-2.6.16-rc5.orig/include/asm-i386/msr.h	2006-03-08 10:31:10.000000000 -0800
+++ linux-2.6.16-rc5/include/asm-i386/msr.h	2006-03-08 10:32:07.000000000 -0800
@@ -1,22 +1,14 @@
 #ifndef __ASM_MSR_H
 #define __ASM_MSR_H
 
+#include <mach_msr.h>
+
 /*
  * Access to machine-specific registers (available on 586 and better only)
  * Note: the rd* operations modify the parameters directly (without using
  * pointer indirection), this allows gcc to optimize better
  */
 
-#define rdmsr(msr,val1,val2) \
-	__asm__ __volatile__("rdmsr" \
-			  : "=a" (val1), "=d" (val2) \
-			  : "c" (msr))
-
-#define wrmsr(msr,val1,val2) \
-	__asm__ __volatile__("wrmsr" \
-			  : /* no outputs */ \
-			  : "c" (msr), "a" (val1), "d" (val2))
-
 #define rdmsrl(msr,val) do { \
 	unsigned long l__,h__; \
 	rdmsr (msr, l__, h__);  \
@@ -62,22 +54,6 @@ static inline void wrmsrl (unsigned long
 		     : "c" (msr), "i" (-EFAULT));\
 	ret__; })
 
-#define rdtsc(low,high) \
-     __asm__ __volatile__("rdtsc" : "=a" (low), "=d" (high))
-
-#define rdtscl(low) \
-     __asm__ __volatile__("rdtsc" : "=a" (low) : : "edx")
-
-#define rdtscll(val) \
-     __asm__ __volatile__("rdtsc" : "=A" (val))
-
-#define write_tsc(val1,val2) wrmsr(0x10, val1, val2)
-
-#define rdpmc(counter,low,high) \
-     __asm__ __volatile__("rdpmc" \
-			  : "=a" (low), "=d" (high) \
-			  : "c" (counter))
-
 /* symbolic names for some interesting MSRs */
 /* Intel defined MSRs. */
 #define MSR_IA32_P5_MC_ADDR		0
Index: linux-2.6.16-rc5/include/asm-i386/mach-vmi/mach_msr.h
===================================================================
--- linux-2.6.16-rc5.orig/include/asm-i386/mach-vmi/mach_msr.h	2006-03-08 10:32:07.000000000 -0800
+++ linux-2.6.16-rc5/include/asm-i386/mach-vmi/mach_msr.h	2006-03-08 10:32:30.000000000 -0800
@@ -0,0 +1,79 @@
+#ifndef MACH_MSR_H
+#define MACH_MSR_H
+
+#include <vmi.h>
+
+static inline u64 vmi_rdmsr(const u32 msr)
+{
+	u64 ret;
+	vmi_wrap_call(
+		RDMSR, "rdmsr",
+		VMI_OREG64 (ret),
+		1, "c" (msr),
+		VMI_CLOBBER(TWO_RETURNS));
+	return ret;
+}
+
+#define rdmsr(msr,val1,val2) \
+do { \
+	u64 _val = vmi_rdmsr(msr); \
+	val1 = (u32)_val; \
+	val2 = (u32)(_val >> 32); \
+} while (0)
+
+static inline void wrmsr(const u32 msr, const u32 valLo, const u32 valHi)
+{
+	vmi_wrap_call(
+		WRMSR, "wrmsr",
+		VMI_NO_OUTPUT,
+		3, XCONC("a"(valLo), "d"(valHi), "c"(msr)),
+		VMI_CLOBBER_EXTENDED(ZERO_RETURNS, "memory"));
+}
+
+static inline u64 vmi_rdtsc(void)
+{
+	u64 ret;
+	vmi_wrap_call(
+		RDTSC, "rdtsc",
+		VMI_OREG64 (ret),
+		0, VMI_NO_INPUT,
+		VMI_CLOBBER(TWO_RETURNS));
+	return ret;
+}
+
+#define rdtsc(low,high) \
+do { \
+	u64 _val = vmi_rdtsc(); \
+	low = (u32)_val; \
+	high = (u32)(_val >> 32); \
+} while (0)
+
+#define rdtscl(low) \
+do { \
+	u64 _val = vmi_rdtsc(); \
+	low = (u32)_val; \
+} while (0)
+
+#define rdtscll(val) do { val = vmi_rdtsc(); } while (0)
+
+#define write_tsc(val1,val2) wrmsr(0x10, val1, val2)
+
+static inline u64 vmi_rdpmc(const u32 counter)
+{
+	u64 ret;
+	vmi_wrap_call(
+		RDPMC, "rdpmc",
+		VMI_OREG64 (ret),
+		1, "c" (counter),
+		VMI_CLOBBER(TWO_RETURNS));
+	return ret;
+}
+
+#define rdpmc(counter,val1,val2) \
+do { \
+	u64 _val = vmi_rdpmc(counter); \
+	val1 = (u32)_val; \
+	val2 = (u32)(_val >> 32); \
+} while (0)
+
+#endif
Index: linux-2.6.16-rc5/include/asm-i386/mach-default/mach_msr.h
===================================================================
--- linux-2.6.16-rc5.orig/include/asm-i386/mach-default/mach_msr.h	2006-03-08 10:32:07.000000000 -0800
+++ linux-2.6.16-rc5/include/asm-i386/mach-default/mach_msr.h	2006-03-08 10:32:07.000000000 -0800
@@ -0,0 +1,30 @@
+#ifndef MACH_MSR_H
+#define MACH_MSR_H
+
+#define rdmsr(msr,val1,val2) \
+	__asm__ __volatile__("rdmsr" \
+			  : "=a" (val1), "=d" (val2) \
+			  : "c" (msr))
+
+#define wrmsr(msr,val1,val2) \
+	__asm__ __volatile__("wrmsr" \
+			  : /* no outputs */ \
+			  : "c" (msr), "a" (val1), "d" (val2))
+
+#define rdtsc(low,high) \
+     __asm__ __volatile__("rdtsc" : "=a" (low), "=d" (high))
+
+#define rdtscl(low) \
+     __asm__ __volatile__("rdtsc" : "=a" (low) : : "edx")
+
+#define rdtscll(val) \
+     __asm__ __volatile__("rdtsc" : "=A" (val))
+
+#define write_tsc(val1,val2) wrmsr(0x10, val1, val2)
+
+#define rdpmc(counter,low,high) \
+     __asm__ __volatile__("rdpmc" \
+			  : "=a" (low), "=d" (high) \
+			  : "c" (counter))
+
+#endif
