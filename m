Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751073AbWGVAN2@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751073AbWGVAN2 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 21 Jul 2006 20:13:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751018AbWGVAN2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 21 Jul 2006 20:13:28 -0400
Received: from ozlabs.tip.net.au ([203.10.76.45]:42464 "EHLO ozlabs.org")
	by vger.kernel.org with ESMTP id S1750952AbWGVAN1 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 21 Jul 2006 20:13:27 -0400
Subject: [PATCH 6/6] cpuid neatening.
From: Rusty Russell <rusty@rustcorp.com.au>
To: Andi Kleen <ak@muc.de>, Andrew Morton <akpm@osdl.org>
Cc: Keir Fraser <Keir.Fraser@cl.cam.ac.uk>,
       Jeremy Fitzhardinge <jeremy@goop.org>, Zachary Amsden <zach@vmware.com>,
       Pratap <pratap@vmware.com>, Chris Wright <chrisw@sous-sol.org>,
       lkml - Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <1153526798.13699.23.camel@localhost.localdomain>
References: <1153526643.13699.18.camel@localhost.localdomain>
	 <1153526798.13699.23.camel@localhost.localdomain>
Content-Type: text/plain
Date: Sat, 22 Jul 2006 10:13:14 +1000
Message-Id: <1153527194.13699.34.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.1 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Roll all the cpuid asm into one __cpuid call.  It's a little neater,
and also means only one place to patch for paravirtualization.

Signed-off-by: Rusty Russell <rusty@rustcorp.com.au>
Index: working-2.6.18-rc2-hg-paravirt/include/asm-i386/processor.h
===================================================================
--- working-2.6.18-rc2-hg-paravirt.orig/include/asm-i386/processor.h	2006-07-21 20:27:59.000000000 +1000
+++ working-2.6.18-rc2-hg-paravirt/include/asm-i386/processor.h	2006-07-21 21:50:49.000000000 +1000
@@ -143,6 +143,18 @@
 #define X86_EFLAGS_VIP	0x00100000 /* Virtual Interrupt Pending */
 #define X86_EFLAGS_ID	0x00200000 /* CPUID detection flag */
 
+static inline void __cpuid(unsigned int *eax, unsigned int *ebx,
+			   unsigned int *ecx, unsigned int *edx)
+{
+	/* ecx is often an input as well as an output. */
+	__asm__("cpuid"
+		: "=a" (*eax),
+		  "=b" (*ebx),
+		  "=c" (*ecx),
+		  "=d" (*edx)
+		: "0" (*eax), "2" (*ecx));
+}
+
 /*
  * Generic CPUID function
  * clear %ecx since some cpus (Cyrix MII) do not set or clear %ecx
@@ -150,24 +162,18 @@
  */
 static inline void cpuid(unsigned int op, unsigned int *eax, unsigned int *ebx, unsigned int *ecx, unsigned int *edx)
 {
-	__asm__("cpuid"
-		: "=a" (*eax),
-		  "=b" (*ebx),
-		  "=c" (*ecx),
-		  "=d" (*edx)
-		: "0" (op), "c"(0));
+	*eax = op;
+	*ecx = 0;
+	__cpuid(eax, ebx, ecx, edx);
 }
 
 /* Some CPUID calls want 'count' to be placed in ecx */
 static inline void cpuid_count(int op, int count, int *eax, int *ebx, int *ecx,
-	       	int *edx)
+			       int *edx)
 {
-	__asm__("cpuid"
-		: "=a" (*eax),
-		  "=b" (*ebx),
-		  "=c" (*ecx),
-		  "=d" (*edx)
-		: "0" (op), "c" (count));
+	*eax = op;
+	*ecx = count;
+	__cpuid(eax, ebx, ecx, edx);
 }
 
 /*
@@ -175,42 +181,30 @@
  */
 static inline unsigned int cpuid_eax(unsigned int op)
 {
-	unsigned int eax;
+	unsigned int eax, ebx, ecx, edx;
 
-	__asm__("cpuid"
-		: "=a" (eax)
-		: "0" (op)
-		: "bx", "cx", "dx");
+	cpuid(op, &eax, &ebx, &ecx, &edx);
 	return eax;
 }
 static inline unsigned int cpuid_ebx(unsigned int op)
 {
-	unsigned int eax, ebx;
+	unsigned int eax, ebx, ecx, edx;
 
-	__asm__("cpuid"
-		: "=a" (eax), "=b" (ebx)
-		: "0" (op)
-		: "cx", "dx" );
+	cpuid(op, &eax, &ebx, &ecx, &edx);
 	return ebx;
 }
 static inline unsigned int cpuid_ecx(unsigned int op)
 {
-	unsigned int eax, ecx;
+	unsigned int eax, ebx, ecx, edx;
 
-	__asm__("cpuid"
-		: "=a" (eax), "=c" (ecx)
-		: "0" (op)
-		: "bx", "dx" );
+	cpuid(op, &eax, &ebx, &ecx, &edx);
 	return ecx;
 }
 static inline unsigned int cpuid_edx(unsigned int op)
 {
-	unsigned int eax, edx;
+	unsigned int eax, ebx, ecx, edx;
 
-	__asm__("cpuid"
-		: "=a" (eax), "=d" (edx)
-		: "0" (op)
-		: "bx", "cx");
+	cpuid(op, &eax, &ebx, &ecx, &edx);
 	return edx;
 }
 

-- 
Help! Save Australia from the worst of the DMCA: http://linux.org.au/law

