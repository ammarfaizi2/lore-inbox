Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264147AbTEWTJI (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 23 May 2003 15:09:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264148AbTEWTJI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 23 May 2003 15:09:08 -0400
Received: from e31.co.us.ibm.com ([32.97.110.129]:56751 "EHLO
	e31.co.us.ibm.com") by vger.kernel.org with ESMTP id S264147AbTEWTI6
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 23 May 2003 15:08:58 -0400
Subject: [PATCH] linux-2.5.69_subarch-fix_A1
From: john stultz <johnstul@us.ibm.com>
To: lkml <linux-kernel@vger.kernel.org>
Cc: Andrew Morton <akpm@digeo.com>, Andi Kleen <ak@suse.de>
Content-Type: text/plain
Organization: 
Message-Id: <1053717701.32091.73.camel@w-jstultz2.beaverton.ibm.com>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.4 
Date: 23 May 2003 12:21:41 -0700
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

All,
	I had meant to send this out earlier, but I got caught up in a customer
issue. However in the meantime my last revision of this patch, which
Andi had issues, with got in. 

So this patch (against bk-current) reverts my last revision, and fixes
the same circular dependency in a much cleaner way. Test-built on all
subarches (except Voyager, which looked unrelated). 

Andi: Does this look better to you?
Andrew: If Andi doesn't have issues with this, please consider adding it
to your tree.

thanks
-john


diff -Nru a/arch/i386/mach-generic/bigsmp.c b/arch/i386/mach-generic/bigsmp.c
--- a/arch/i386/mach-generic/bigsmp.c	Fri May 23 11:51:35 2003
+++ b/arch/i386/mach-generic/bigsmp.c	Fri May 23 11:51:35 2003
@@ -10,6 +10,7 @@
 #include <linux/smp.h>
 #include <linux/init.h>
 #include <asm/mach-bigsmp/mach_apic.h>
+#include <asm/mach-bigsmp/mach_apicdef.h>
 #include <asm/mach-bigsmp/mach_ipi.h>
 #include <asm/mach-default/mach_mpparse.h>
 
diff -Nru a/arch/i386/mach-generic/default.c b/arch/i386/mach-generic/default.c
--- a/arch/i386/mach-generic/default.c	Fri May 23 11:51:35 2003
+++ b/arch/i386/mach-generic/default.c	Fri May 23 11:51:35 2003
@@ -10,6 +10,7 @@
 #include <linux/smp.h>
 #include <linux/init.h>
 #include <asm/mach-default/mach_apic.h>
+#include <asm/mach-default/mach_apicdef.h>
 #include <asm/mach-default/mach_ipi.h>
 #include <asm/mach-default/mach_mpparse.h>
 
diff -Nru a/arch/i386/mach-generic/summit.c b/arch/i386/mach-generic/summit.c
--- a/arch/i386/mach-generic/summit.c	Fri May 23 11:51:35 2003
+++ b/arch/i386/mach-generic/summit.c	Fri May 23 11:51:35 2003
@@ -10,6 +10,7 @@
 #include <linux/smp.h>
 #include <linux/init.h>
 #include <asm/mach-summit/mach_apic.h>
+#include <asm/mach-summit/mach_apicdef.h>
 #include <asm/mach-summit/mach_ipi.h>
 #include <asm/mach-summit/mach_mpparse.h>
 
diff -Nru a/include/asm-i386/mach-bigsmp/mach_apic.h b/include/asm-i386/mach-bigsmp/mach_apic.h
--- a/include/asm-i386/mach-bigsmp/mach_apic.h	Fri May 23 11:51:35 2003
+++ b/include/asm-i386/mach-bigsmp/mach_apic.h	Fri May 23 11:51:35 2003
@@ -1,5 +1,6 @@
 #ifndef __ASM_MACH_APIC_H
 #define __ASM_MACH_APIC_H
+#include <asm/smp.h>
 
 #define SEQUENTIAL_APICID
 #ifdef SEQUENTIAL_APICID
@@ -40,18 +41,10 @@
 
 #define apicid_cluster(apicid) (apicid & 0xF0)
 
-static inline unsigned get_apic_id(unsigned long x) 
-{ 
-	return (((x)>>24)&0x0F);
-} 
-
-#define		GET_APIC_ID(x)	get_apic_id(x)
-
 static inline unsigned long calculate_ldr(unsigned long old)
 {
 	unsigned long id;
-	id = xapic_phys_to_log_apicid(
-			GET_APIC_LOGICAL_ID(*(unsigned long *)(APIC_BASE+APIC_LDR)));
+	id = xapic_phys_to_log_apicid(hard_smp_processor_id());
 	return ((old & ~APIC_LDR_MASK) | SET_APIC_LOGICAL_ID(id));
 }
 
@@ -134,8 +127,6 @@
 {
 	return (1);
 }
-
-#define		APIC_ID_MASK		(0x0F<<24)
 
 static inline unsigned int cpu_mask_to_apicid (unsigned long cpumask)
 {
diff -Nru a/include/asm-i386/mach-bigsmp/mach_apicdef.h b/include/asm-i386/mach-bigsmp/mach_apicdef.h
--- /dev/null	Wed Dec 31 16:00:00 1969
+++ b/include/asm-i386/mach-bigsmp/mach_apicdef.h	Fri May 23 11:51:35 2003
@@ -0,0 +1,13 @@
+#ifndef __ASM_MACH_APICDEF_H
+#define __ASM_MACH_APICDEF_H
+
+#define		APIC_ID_MASK		(0x0F<<24)
+
+static inline unsigned get_apic_id(unsigned long x) 
+{ 
+	return (((x)>>24)&0x0F);
+} 
+
+#define		GET_APIC_ID(x)	get_apic_id(x)
+
+#endif
diff -Nru a/include/asm-i386/mach-default/mach_apic.h b/include/asm-i386/mach-default/mach_apic.h
--- a/include/asm-i386/mach-default/mach_apic.h	Fri May 23 11:51:35 2003
+++ b/include/asm-i386/mach-default/mach_apic.h	Fri May 23 11:51:35 2003
@@ -1,6 +1,8 @@
 #ifndef __ASM_MACH_APIC_H
 #define __ASM_MACH_APIC_H
 
+#include <mach_apicdef.h>
+
 #define APIC_DFR_VALUE	(APIC_DFR_FLAT)
 
 static inline unsigned long target_cpus(void)
@@ -104,15 +106,6 @@
 {
 	return test_bit(boot_cpu_physical_apicid, &phys_cpu_present_map);
 }
-
-#define		APIC_ID_MASK		(0xF<<24)
-
-static inline unsigned get_apic_id(unsigned long x) 
-{ 
-	return (((x)>>24)&0xF);
-} 
-
-#define		GET_APIC_ID(x)	get_apic_id(x)
 
 static inline int apic_id_registered(void)
 {
diff -Nru a/include/asm-i386/mach-default/mach_apicdef.h b/include/asm-i386/mach-default/mach_apicdef.h
--- /dev/null	Wed Dec 31 16:00:00 1969
+++ b/include/asm-i386/mach-default/mach_apicdef.h	Fri May 23 11:51:35 2003
@@ -0,0 +1,13 @@
+#ifndef __ASM_MACH_APICDEF_H
+#define __ASM_MACH_APICDEF_H
+
+#define		APIC_ID_MASK		(0xF<<24)
+
+static inline unsigned get_apic_id(unsigned long x) 
+{ 
+	return (((x)>>24)&0xF);
+} 
+
+#define		GET_APIC_ID(x)	get_apic_id(x)
+
+#endif
diff -Nru a/include/asm-i386/mach-numaq/mach_apic.h b/include/asm-i386/mach-numaq/mach_apic.h
--- a/include/asm-i386/mach-numaq/mach_apic.h	Fri May 23 11:51:35 2003
+++ b/include/asm-i386/mach-numaq/mach_apic.h	Fri May 23 11:51:35 2003
@@ -107,15 +107,6 @@
 	return (1);
 }
 
-#define APIC_ID_MASK (0xF<<24)
-
-static inline unsigned get_apic_id(unsigned long x)
-{
-	        return (((x)>>24)&0x0F);
-}
-
-#define         GET_APIC_ID(x)  get_apic_id(x)
-
 static inline unsigned int cpu_mask_to_apicid (unsigned long cpumask)
 {
 	int num_bits_set;
diff -Nru a/include/asm-i386/mach-numaq/mach_apicdef.h b/include/asm-i386/mach-numaq/mach_apicdef.h
--- /dev/null	Wed Dec 31 16:00:00 1969
+++ b/include/asm-i386/mach-numaq/mach_apicdef.h	Fri May 23 11:51:35 2003
@@ -0,0 +1,14 @@
+#ifndef __ASM_MACH_APICDEF_H
+#define __ASM_MACH_APICDEF_H
+
+
+#define APIC_ID_MASK (0xF<<24)
+
+static inline unsigned get_apic_id(unsigned long x)
+{
+	        return (((x)>>24)&0x0F);
+}
+
+#define         GET_APIC_ID(x)  get_apic_id(x)
+
+#endif
diff -Nru a/include/asm-i386/mach-summit/mach_apic.h b/include/asm-i386/mach-summit/mach_apic.h
--- a/include/asm-i386/mach-summit/mach_apic.h	Fri May 23 11:51:35 2003
+++ b/include/asm-i386/mach-summit/mach_apic.h	Fri May 23 11:51:35 2003
@@ -2,6 +2,7 @@
 #define __ASM_MACH_APIC_H
 
 #include <linux/config.h>
+#include <asm/smp.h>
 
 #ifdef CONFIG_X86_GENERICARCH
 #define x86_summit 1	/* must be an constant expressiona for generic arch */
@@ -48,20 +49,12 @@
 
 extern u8 bios_cpu_apicid[];
 
-static inline unsigned get_apic_id(unsigned long x) 
-{ 
-	return (((x)>>24)&0xFF);
-} 
-
-#define		GET_APIC_ID(x)	get_apic_id(x)
-
 static inline void init_apic_ldr(void)
 {
 	unsigned long val, id;
 
 	if (x86_summit)
-		id = xapic_phys_to_log_apicid(
-			GET_APIC_ID(*(unsigned long *)(APIC_BASE+APIC_ID)));
+		id = xapic_phys_to_log_apicid(hard_smp_processor_id());
 	else
 		id = 1UL << smp_processor_id();
 	apic_write_around(APIC_DFR, APIC_DFR_VALUE);
@@ -142,8 +135,6 @@
 	else
 		return test_bit(boot_cpu_physical_apicid, &phys_cpu_present_map);
 }
-
-#define		APIC_ID_MASK		(0xFF<<24)
 
 static inline unsigned int cpu_mask_to_apicid (unsigned long cpumask)
 {
diff -Nru a/include/asm-i386/mach-summit/mach_apicdef.h b/include/asm-i386/mach-summit/mach_apicdef.h
--- /dev/null	Wed Dec 31 16:00:00 1969
+++ b/include/asm-i386/mach-summit/mach_apicdef.h	Fri May 23 11:51:35 2003
@@ -0,0 +1,13 @@
+#ifndef __ASM_MACH_APICDEF_H
+#define __ASM_MACH_APICDEF_H
+
+#define		APIC_ID_MASK		(0xFF<<24)
+
+static inline unsigned get_apic_id(unsigned long x) 
+{ 
+	return (((x)>>24)&0xFF);
+} 
+
+#define		GET_APIC_ID(x)	get_apic_id(x)
+
+#endif
diff -Nru a/include/asm-i386/mach-visws/mach_apic.h b/include/asm-i386/mach-visws/mach_apic.h
--- a/include/asm-i386/mach-visws/mach_apic.h	Fri May 23 11:51:35 2003
+++ b/include/asm-i386/mach-visws/mach_apic.h	Fri May 23 11:51:35 2003
@@ -19,14 +19,6 @@
 #define check_apicid_used(bitmap, apicid) (bitmap & (1 << apicid))
 #define check_apicid_present(bit) (phys_cpu_present_map & (1 << bit))
 
-#define         APIC_ID_MASK            (0xF<<24)
-
-static inline unsigned get_apic_id(unsigned long x)
-{
-	        return (((x)>>24)&0xF);
-}
-#define         GET_APIC_ID(x)  get_apic_id(x)
-
 static inline int apic_id_registered(void)
 {
 	return (test_bit(GET_APIC_ID(apic_read(APIC_ID)), 
diff -Nru a/include/asm-i386/mach-visws/mach_apicdef.h b/include/asm-i386/mach-visws/mach_apicdef.h
--- /dev/null	Wed Dec 31 16:00:00 1969
+++ b/include/asm-i386/mach-visws/mach_apicdef.h	Fri May 23 11:51:35 2003
@@ -0,0 +1,12 @@
+#ifndef __ASM_MACH_APICDEF_H
+#define __ASM_MACH_APICDEF_H
+
+#define         APIC_ID_MASK            (0xF<<24)
+
+static inline unsigned get_apic_id(unsigned long x)
+{
+	        return (((x)>>24)&0xF);
+}
+#define         GET_APIC_ID(x)  get_apic_id(x)
+
+#endif
diff -Nru a/include/asm-i386/smp.h b/include/asm-i386/smp.h
--- a/include/asm-i386/smp.h	Fri May 23 11:51:35 2003
+++ b/include/asm-i386/smp.h	Fri May 23 11:51:35 2003
@@ -91,7 +91,7 @@
 #ifdef APIC_DEFINITION
 extern int hard_smp_processor_id(void);
 #else
-#include <mach_apic.h>
+#include <mach_apicdef.h>
 static inline int hard_smp_processor_id(void)
 {
 	/* we don't want to mark this access volatile - bad code generation */



