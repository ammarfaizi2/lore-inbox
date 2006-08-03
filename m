Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751061AbWHCA0v@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751061AbWHCA0v (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 2 Aug 2006 20:26:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750911AbWHCAZ4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 2 Aug 2006 20:25:56 -0400
Received: from 207.47.60.101.static.nextweb.net ([207.47.60.101]:51161 "EHLO
	mail.goop.org") by vger.kernel.org with ESMTP id S1750955AbWHCAZu
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 2 Aug 2006 20:25:50 -0400
Message-Id: <20060803002518.436218773@xensource.com>
References: <20060803002510.634721860@xensource.com>
User-Agent: quilt/0.45-1
Date: Wed, 02 Aug 2006 17:25:15 -0700
From: Jeremy Fitzhardinge <jeremy@xensource.com>
To: akpm@osdl.org
Cc: linux-kernel@vger.kernel.org, virtualization@lists.osdl.org,
       xen-devel@lists.xensource.com, Jeremy Fitzhardinge <jeremy@goop.org>,
       Rusty Russell <rusty@rustcorp.com.au>
Subject: [patch 5/8] Roll all the cpuid asm into one __cpuid call.
Content-Disposition: inline; filename=005-cpuid-cleanup.patch
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

It's a little neater, and also means only one place to patch for
paravirtualization.

Signed-off-by: Rusty Russell <rusty@rustcorp.com.au>
Signed-off-by: Jeremy Fitzhardinge <jeremy@xensource.com>

---
 include/asm-i386/processor.h |   74 +++++++++++++++++++-----------------------
 1 file changed, 34 insertions(+), 40 deletions(-)


===================================================================
--- a/include/asm-i386/processor.h
+++ b/include/asm-i386/processor.h
@@ -143,31 +143,37 @@ static inline void detect_ht(struct cpui
 #define X86_EFLAGS_VIP	0x00100000 /* Virtual Interrupt Pending */
 #define X86_EFLAGS_ID	0x00200000 /* CPUID detection flag */
 
-/*
- * Generic CPUID function
- * clear %ecx since some cpus (Cyrix MII) do not set or clear %ecx
- * resulting in stale register contents being returned.
- */
-static inline void cpuid(unsigned int op, unsigned int *eax, unsigned int *ebx, unsigned int *ecx, unsigned int *edx)
-{
+static inline void __cpuid(unsigned int *eax, unsigned int *ebx,
+			   unsigned int *ecx, unsigned int *edx)
+{
+	/* ecx is often an input as well as an output. */
 	__asm__("cpuid"
 		: "=a" (*eax),
 		  "=b" (*ebx),
 		  "=c" (*ecx),
 		  "=d" (*edx)
-		: "0" (op), "c"(0));
+		: "0" (*eax), "2" (*ecx));
+}
+
+/*
+ * Generic CPUID function
+ * clear %ecx since some cpus (Cyrix MII) do not set or clear %ecx
+ * resulting in stale register contents being returned.
+ */
+static inline void cpuid(unsigned int op, unsigned int *eax, unsigned int *ebx, unsigned int *ecx, unsigned int *edx)
+{
+	*eax = op;
+	*ecx = 0;
+	__cpuid(eax, ebx, ecx, edx);
 }
 
 /* Some CPUID calls want 'count' to be placed in ecx */
 static inline void cpuid_count(int op, int count, int *eax, int *ebx, int *ecx,
-	       	int *edx)
-{
-	__asm__("cpuid"
-		: "=a" (*eax),
-		  "=b" (*ebx),
-		  "=c" (*ecx),
-		  "=d" (*edx)
-		: "0" (op), "c" (count));
+			       int *edx)
+{
+	*eax = op;
+	*ecx = count;
+	__cpuid(eax, ebx, ecx, edx);
 }
 
 /*
@@ -175,42 +181,30 @@ static inline void cpuid_count(int op, i
  */
 static inline unsigned int cpuid_eax(unsigned int op)
 {
-	unsigned int eax;
-
-	__asm__("cpuid"
-		: "=a" (eax)
-		: "0" (op)
-		: "bx", "cx", "dx");
+	unsigned int eax, ebx, ecx, edx;
+
+	cpuid(op, &eax, &ebx, &ecx, &edx);
 	return eax;
 }
 static inline unsigned int cpuid_ebx(unsigned int op)
 {
-	unsigned int eax, ebx;
-
-	__asm__("cpuid"
-		: "=a" (eax), "=b" (ebx)
-		: "0" (op)
-		: "cx", "dx" );
+	unsigned int eax, ebx, ecx, edx;
+
+	cpuid(op, &eax, &ebx, &ecx, &edx);
 	return ebx;
 }
 static inline unsigned int cpuid_ecx(unsigned int op)
 {
-	unsigned int eax, ecx;
-
-	__asm__("cpuid"
-		: "=a" (eax), "=c" (ecx)
-		: "0" (op)
-		: "bx", "dx" );
+	unsigned int eax, ebx, ecx, edx;
+
+	cpuid(op, &eax, &ebx, &ecx, &edx);
 	return ecx;
 }
 static inline unsigned int cpuid_edx(unsigned int op)
 {
-	unsigned int eax, edx;
-
-	__asm__("cpuid"
-		: "=a" (eax), "=d" (edx)
-		: "0" (op)
-		: "bx", "cx");
+	unsigned int eax, ebx, ecx, edx;
+
+	cpuid(op, &eax, &ebx, &ecx, &edx);
 	return edx;
 }
 

--

