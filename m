Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932260AbVHKE5I@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932260AbVHKE5I (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 11 Aug 2005 00:57:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932261AbVHKE5I
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 11 Aug 2005 00:57:08 -0400
Received: from mailout1.vmware.com ([65.113.40.130]:45062 "EHLO
	mailout1.vmware.com") by vger.kernel.org with ESMTP id S932260AbVHKE5G
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 11 Aug 2005 00:57:06 -0400
Date: Wed, 10 Aug 2005 21:57:00 -0700
From: zach@vmware.com
Message-Id: <200508110457.j7B4v0l2019595@zach-dev.vmware.com>
To: akpm@osdl.org, chrisl@vmware.com, chrisw@osdl.org, hpa@zytor.com,
       Keir.Fraser@cl.cam.ac.uk, linux-kernel@vger.kernel.org,
       m+Ian.Pratt@cl.cam.ac.uk, mbligh@mbligh.org, pratap@vmware.com,
       virtualization@lists.osdl.org, zach@vmware.com, zwane@arm.linux.org.uk
Subject: [PATCH 9/14] i386 / Typecheck and optimize base and limit accessors
X-OriginalArrivalTime: 11 Aug 2005 04:57:14.0452 (UTC) FILETIME=[24006940:01C59E31]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Found some stray descriptor table accessors that had non-optimal assembler
constraints.  Use "q" to get word, high and low byte access without forcing
a specific register constraint.  Add desc as a memory output operand.

Also, get_base was completely unused.  Deprecate it.

The function get_limit is also unused, but I did not deprecate it; it could
be used in arch/i386/mm/fault.c.

Patch-base: 2.6.13-rc5-mm1
Patch-keys: i386 desc cleanup optimize
Signed-off-by: Zachary Amsden <zach@vmware.com>
Index: linux-2.6.13/include/asm-i386/system.h
===================================================================
--- linux-2.6.13.orig/include/asm-i386/system.h	2005-08-09 20:17:14.000000000 -0700
+++ linux-2.6.13/include/asm-i386/system.h	2005-08-10 20:41:03.000000000 -0700
@@ -29,49 +29,39 @@
 		      "2" (prev), "d" (next));				\
 } while (0)
 
-#define _set_base(addr,base) do { unsigned long __pr; \
-__asm__ __volatile__ ("movw %%dx,%1\n\t" \
-	"rorl $16,%%edx\n\t" \
-	"movb %%dl,%2\n\t" \
-	"movb %%dh,%3" \
-	:"=&d" (__pr) \
-	:"m" (*((addr)+2)), \
-	 "m" (*((addr)+4)), \
-	 "m" (*((addr)+7)), \
-         "0" (base) \
-        ); } while(0)
-
-#define _set_limit(addr,limit) do { unsigned long __lr; \
-__asm__ __volatile__ ("movw %%dx,%1\n\t" \
-	"rorl $16,%%edx\n\t" \
-	"movb %2,%%dh\n\t" \
-	"andb $0xf0,%%dh\n\t" \
-	"orb %%dh,%%dl\n\t" \
-	"movb %%dl,%2" \
-	:"=&d" (__lr) \
-	:"m" (*(addr)), \
-	 "m" (*((addr)+6)), \
-	 "0" (limit) \
-        ); } while(0)
+#define _set_base(desc,base) do {					\
+	unsigned long __tmp;						\
+	typecheck(struct desc_struct *, desc);				\
+	asm volatile("movw %w5,%2\n\t"					\
+		     "rorl $16,%5\n\t"					\
+		     "movb %b5,%3\n\t"					\
+		     "movb %h5,%4"					\
+		     :"=m"(*(desc)),					\
+		      "=&q" (__tmp)					\
+		     :"m" (*((char *)(desc)+2)),			\
+		      "m" (*((char *)(desc)+4)),			\
+		      "m" (*((char *)(desc)+7)),			\
+		      "1" (base));					\
+} while(0)
+
+#define _set_limit(desc,limit) do {					\
+	unsigned long __tmp;						\
+	typecheck(struct desc_struct *, desc);				\
+	asm volatile("movw %w4,%2\n\t"					\
+		     "rorl $16,%4\n\t"					\
+		     "movb %3,%h4\n\t"					\
+		     "andb $0xf0,%h4\n\t"				\
+		     "orb %h4,%b4\n\t"					\
+		     "movb %b4,%3"					\
+		     :"=m"(*(desc)),					\
+		      "=&q" (__tmp)					\
+		     :"m" (*(desc)),					\
+		      "m" (*((char *)(desc)+6)),			\
+		      "1" (limit));					\
+} while(0)
 
-#define set_base(ldt,base) _set_base( ((char *)&(ldt)) , (base) )
-#define set_limit(ldt,limit) _set_limit( ((char *)&(ldt)) , ((limit)-1)>>12 )
-
-static inline unsigned long _get_base(char * addr)
-{
-	unsigned long __base;
-	__asm__("movb %3,%%dh\n\t"
-		"movb %2,%%dl\n\t"
-		"shll $16,%%edx\n\t"
-		"movw %1,%%dx"
-		:"=&d" (__base)
-		:"m" (*((addr)+2)),
-		 "m" (*((addr)+4)),
-		 "m" (*((addr)+7)));
-	return __base;
-}
-
-#define get_base(ldt) _get_base( ((char *)&(ldt)) )
+#define set_base(desc,base) _set_base((desc), (base))
+#define set_limit(desc,limit) _set_limit((desc), ((limit)-1)>>12)
 
 /*
  * Load a segment. Fall back on loading the zero
Index: linux-2.6.13/arch/i386/kernel/apm.c
===================================================================
--- linux-2.6.13.orig/arch/i386/kernel/apm.c	2005-08-09 20:17:26.000000000 -0700
+++ linux-2.6.13/arch/i386/kernel/apm.c	2005-08-09 20:17:26.000000000 -0700
@@ -2291,40 +2291,40 @@
 	 * This is for buggy BIOS's that refer to (real mode) segment 0x40
 	 * even though they are called in protected mode.
 	 */
-	set_base(bad_bios_desc, __va((unsigned long)0x40 << 4));
-	_set_limit((char *)&bad_bios_desc, 4095 - (0x40 << 4));
+	set_base(&bad_bios_desc, __va((unsigned long)0x40 << 4));
+	_set_limit(&bad_bios_desc, 4095 - (0x40 << 4));
 
 	apm_bios_entry.offset = apm_info.bios.offset;
 	apm_bios_entry.segment = APM_CS;
 
 	for (i = 0; i < NR_CPUS; i++) {
 		struct desc_struct *gdt = get_cpu_gdt_table(i);
-		set_base(gdt[segment_index(APM_CS)],
+		set_base(&gdt[segment_index(APM_CS)],
 			 __va((unsigned long)apm_info.bios.cseg << 4));
-		set_base(gdt[segment_index(APM_CS_16)],
+		set_base(&gdt[segment_index(APM_CS_16)],
 			 __va((unsigned long)apm_info.bios.cseg_16 << 4));
-		set_base(gdt[segment_index(APM_DS)],
+		set_base(&gdt[segment_index(APM_DS)],
 			 __va((unsigned long)apm_info.bios.dseg << 4));
 #ifndef APM_RELAX_SEGMENTS
 		if (apm_info.bios.version == 0x100) {
 #endif
 			/* For ASUS motherboard, Award BIOS rev 110 (and others?) */
-			_set_limit((char *)&gdt[segment_index(APM_CS)], 64 * 1024 - 1);
+			_set_limit(&gdt[segment_index(APM_CS)], 64 * 1024 - 1);
 			/* For some unknown machine. */
-			_set_limit((char *)&gdt[segment_index(APM_CS_16)], 64 * 1024 - 1);
+			_set_limit(&gdt[segment_index(APM_CS_16)], 64 * 1024 - 1);
 			/* For the DEC Hinote Ultra CT475 (and others?) */
-			_set_limit((char *)&gdt[segment_index(APM_DS)], 64 * 1024 - 1);
+			_set_limit(&gdt[segment_index(APM_DS)], 64 * 1024 - 1);
 #ifndef APM_RELAX_SEGMENTS
 		} else {
-			_set_limit((char *)&gdt[segment_index(APM_CS)],
+			_set_limit(&gdt[segment_index(APM_CS)],
 				(apm_info.bios.cseg_len - 1) & 0xffff);
-			_set_limit((char *)&gdt[segment_index(APM_CS_16)],
+			_set_limit(&gdt[segment_index(APM_CS_16)],
 				(apm_info.bios.cseg_16_len - 1) & 0xffff);
-			_set_limit((char *)&gdt[segment_index(APM_DS)],
+			_set_limit(&gdt[segment_index(APM_DS)],
 				(apm_info.bios.dseg_len - 1) & 0xffff);
 		      /* workaround for broken BIOSes */
 	                if (apm_info.bios.cseg_len <= apm_info.bios.offset)
-        	                _set_limit((char *)&gdt[segment_index(APM_CS)], 64 * 1024 -1);
+        	                _set_limit(&gdt[segment_index(APM_CS)], 64 * 1024 -1);
                        if (apm_info.bios.dseg_len <= 0x40) { /* 0x40 * 4kB == 64kB */
                         	/* for the BIOS that assumes granularity = 1 */
                         	gdt[segment_index(APM_DS)].b |= 0x800000;
