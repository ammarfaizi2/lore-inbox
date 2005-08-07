Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261411AbVHGBLx@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261411AbVHGBLx (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 6 Aug 2005 21:11:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261413AbVHGBJr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 6 Aug 2005 21:09:47 -0400
Received: from smtp.osdl.org ([65.172.181.4]:35284 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S261397AbVHGBGw (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 6 Aug 2005 21:06:52 -0400
Date: Sat, 6 Aug 2005 18:06:15 -0700
From: Chris Wright <chrisw@osdl.org>
To: Zachary Amsden <zach@vmware.com>
Cc: akpm@osdl.org, chrisw@osdl.org, linux-kernel@vger.kernel.org,
       davej@codemonkey.org.uk, hpa@zytor.com, Riley@Williams.Name,
       pratap@vmware.com, chrisl@vmware.com
Subject: Re: [PATCH 2/8] Move privileged processor operations to the subarch layer
Message-ID: <20050807010615.GG7762@shell0.pdx.osdl.net>
References: <42F46307.606@vmware.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <42F46307.606@vmware.com>
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

* Zachary Amsden (zach@vmware.com) wrote:
> i386 Transparent Paravirtualization Subarch Patch #2
> 
> This change encapsulates CPUID and debug register accessors and moves
> them into the sub-architecture layer. 

This one looks to be a superset of Xen version:

--- linux-2.6.12-xen0-arch.orig/include/asm-i386/processor.h
+++ linux-2.6.12-xen0-arch/include/asm-i386/processor.h
@@ -203,10 +203,6 @@ static inline unsigned int cpuid_edx(uns
 	return edx;
 }
 
-#define load_cr3(pgdir) \
-	asm volatile("movl %0,%%cr3": :"r" (__pa(pgdir)))
-
-
 /*
  * Intel CPU features in CR4
  */
@@ -230,15 +226,7 @@ static inline unsigned int cpuid_edx(uns
  */
 extern unsigned long mmu_cr4_features;
 
-static inline void set_in_cr4 (unsigned long mask)
-{
-	mmu_cr4_features |= mask;
-	__asm__("movl %%cr4,%%eax\n\t"
-		"orl %0,%%eax\n\t"
-		"movl %%eax,%%cr4\n"
-		: : "irg" (mask)
-		:"ax");
-}
+#include <mach_processor.h>
 
 static inline void clear_in_cr4 (unsigned long mask)
 {
@@ -453,6 +441,7 @@ struct thread_struct {
 	unsigned long		v86flags, v86mask, saved_esp0;
 	unsigned int		saved_fs, saved_gs;
 /* IO permissions */
+	unsigned long	io_pl;
 	unsigned long	*io_bitmap_ptr;
 /* max allowed port in the bitmap, in bytes: */
 	unsigned long	io_bitmap_max;
@@ -487,6 +476,7 @@ static inline void load_esp0(struct tss_
 		tss->ss1 = thread->sysenter_cs;
 		wrmsr(MSR_IA32_SYSENTER_CS, thread->sysenter_cs, 0);
 	}
+	mach_load_esp0(tss, thread);
 }
 
 #define start_thread(regs, new_eip, new_esp) do {		\
@@ -500,14 +490,6 @@ static inline void load_esp0(struct tss_
 	regs->esp = new_esp;					\
 } while (0)
 
-/*
- * This special macro can be used to load a debugging register
- */
-#define loaddebug(thread,register) \
-               __asm__("movl %0,%%db" #register  \
-                       : /* no output */ \
-                       :"r" ((thread)->debugreg[register]))
-
 /* Forward declaration, a strange C thing */
 struct task_struct;
 struct mm_struct;
--- /dev/null
+++ linux-2.6.12-xen0-arch/include/asm-i386/mach-default/mach_processor.h
@@ -0,0 +1,27 @@
+#ifndef __ASM_MACH_PROCESSOR_H
+#define __ASM_MACH_PROCESSOR_H
+
+#define load_cr3(pgdir) \
+	asm volatile("movl %0,%%cr3": :"r" (__pa(pgdir)))
+
+static inline void set_in_cr4 (unsigned long mask)
+{
+	mmu_cr4_features |= mask;
+	__asm__("movl %%cr4,%%eax\n\t"
+		"orl %0,%%eax\n\t"
+		"movl %%eax,%%cr4\n"
+		: : "irg" (mask)
+		:"ax");
+}
+
+#define mach_load_esp0(tss, thread) do {} while(0)
+
+/*
+ * This special macro can be used to load a debugging register
+ */
+#define loaddebug(thread,register) \
+               __asm__("movl %0,%%db" #register  \
+                       : /* no output */ \
+                       :"r" ((thread)->debugreg[register]))
+
+#endif
