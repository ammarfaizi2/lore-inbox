Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263692AbTEOC2w (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 14 May 2003 22:28:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263727AbTEOC2w
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 14 May 2003 22:28:52 -0400
Received: from e31.co.us.ibm.com ([32.97.110.129]:28381 "EHLO
	e31.co.us.ibm.com") by vger.kernel.org with ESMTP id S263692AbTEOC2t
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 14 May 2003 22:28:49 -0400
Subject: [PATCH] linux-2.5.69_subarch-fix_A0.patch
From: john stultz <johnstul@us.ibm.com>
To: lkml <linux-kernel@vger.kernel.org>
Cc: Andrew Morton <akpm@digeo.com>, "Martin J. Bligh" <mbligh@aracnet.com>,
       Andi Kleen <ak@suse.de>
Content-Type: text/plain
Organization: 
Message-Id: <1052966228.9630.69.camel@w-jstultz2.beaverton.ibm.com>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.4 
Date: 14 May 2003 19:37:09 -0700
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

All,
	This patch fixes a circular dependency (a function in mach_apic.h
requires hard_smp_processor_id() and hard_smp_processor_id() requires
macros from mach_apic.h) that has been in the subarch code for a bit,
but was hacked around with some #ifdefs. 

With the inclusion of the generic-subarch the hack was dropped and
bigsmp and summit promptly broke. So this makes things compile again. 

thanks
-john


diff -Nru a/include/asm-i386/mach-bigsmp/mach_apic.h b/include/asm-i386/mach-bigsmp/mach_apic.h
--- a/include/asm-i386/mach-bigsmp/mach_apic.h	Wed May 14 18:21:20 2003
+++ b/include/asm-i386/mach-bigsmp/mach_apic.h	Wed May 14 18:21:20 2003
@@ -40,10 +40,18 @@
 
 #define apicid_cluster(apicid) (apicid & 0xF0)
 
+static inline unsigned get_apic_id(unsigned long x) 
+{ 
+	return (((x)>>24)&0x0F);
+} 
+
+#define		GET_APIC_ID(x)	get_apic_id(x)
+
 static inline unsigned long calculate_ldr(unsigned long old)
 {
 	unsigned long id;
-	id = xapic_phys_to_log_apicid(hard_smp_processor_id());
+	id = xapic_phys_to_log_apicid(
+			GET_APIC_LOGICAL_ID(*(unsigned long *)(APIC_BASE+APIC_LDR)));
 	return ((old & ~APIC_LDR_MASK) | SET_APIC_LOGICAL_ID(id));
 }
 
@@ -128,13 +136,6 @@
 }
 
 #define		APIC_ID_MASK		(0x0F<<24)
-
-static inline unsigned get_apic_id(unsigned long x) 
-{ 
-	return (((x)>>24)&0x0F);
-} 
-
-#define		GET_APIC_ID(x)	get_apic_id(x)
 
 static inline unsigned int cpu_mask_to_apicid (unsigned long cpumask)
 {
diff -Nru a/include/asm-i386/mach-summit/mach_apic.h b/include/asm-i386/mach-summit/mach_apic.h
--- a/include/asm-i386/mach-summit/mach_apic.h	Wed May 14 18:21:20 2003
+++ b/include/asm-i386/mach-summit/mach_apic.h	Wed May 14 18:21:20 2003
@@ -48,12 +48,20 @@
 
 extern u8 bios_cpu_apicid[];
 
+static inline unsigned get_apic_id(unsigned long x) 
+{ 
+	return (((x)>>24)&0xFF);
+} 
+
+#define		GET_APIC_ID(x)	get_apic_id(x)
+
 static inline void init_apic_ldr(void)
 {
 	unsigned long val, id;
 
 	if (x86_summit)
-		id = xapic_phys_to_log_apicid(hard_smp_processor_id());
+		id = xapic_phys_to_log_apicid(
+			GET_APIC_ID(*(unsigned long *)(APIC_BASE+APIC_ID)));
 	else
 		id = 1UL << smp_processor_id();
 	apic_write_around(APIC_DFR, APIC_DFR_VALUE);
@@ -136,13 +144,6 @@
 }
 
 #define		APIC_ID_MASK		(0xFF<<24)
-
-static inline unsigned get_apic_id(unsigned long x) 
-{ 
-	return (((x)>>24)&0xFF);
-} 
-
-#define		GET_APIC_ID(x)	get_apic_id(x)
 
 static inline unsigned int cpu_mask_to_apicid (unsigned long cpumask)
 {



