Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932308AbVJ3All@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932308AbVJ3All (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 29 Oct 2005 20:41:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932375AbVJ3All
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 29 Oct 2005 20:41:41 -0400
Received: from smtp205.mail.sc5.yahoo.com ([216.136.129.95]:32122 "HELO
	smtp205.mail.sc5.yahoo.com") by vger.kernel.org with SMTP
	id S932308AbVJ3Alk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 29 Oct 2005 20:41:40 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.com.au;
  h=Received:Message-ID:Date:From:User-Agent:X-Accept-Language:MIME-Version:To:Subject:References:In-Reply-To:Content-Type;
  b=f2QlQ+O86p4780DnkmEPX2AXwA5bcCCR6Vp2/E6aFqwpwbJcfxWhR0cGLV7usEM/MwOp7Qqq15o3H5JE1Z6EEGIeyEh+4ersiyTpODYnZsa9B4FoTr4XnT/sba4CkyoI5bhKSxJpB4XwZkciLlNXX9/pW06VNlQwgbPlm+V3IDY=  ;
Message-ID: <4364171C.7020103@yahoo.com.au>
Date: Sun, 30 Oct 2005 11:43:08 +1100
From: Nick Piggin <nickpiggin@yahoo.com.au>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.12) Gecko/20051007 Debian/1.7.12-1
X-Accept-Language: en
MIME-Version: 1.0
To: linux-kernel <linux-kernel@vger.kernel.org>
Subject: [patch 1/5] i386 generic cmpxchg
References: <436416AD.3050709@yahoo.com.au>
In-Reply-To: <436416AD.3050709@yahoo.com.au>
Content-Type: multipart/mixed;
 boundary="------------050704020804070905000204"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------050704020804070905000204
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit

1/5

-- 
SUSE Labs, Novell Inc.


--------------050704020804070905000204
Content-Type: text/plain;
 name="i386-generic-cmpxchg.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="i386-generic-cmpxchg.patch"

Changelog
        * Make cmpxchg generally available on the i386 platform.
        * Provide emulation of cmpxchg suitable for uniprocessor if
	  built and run on 386.

Signed-off-by: Christoph Lameter <clameter@sgi.com>

	* Cut down patch and small style changes.

Signed-off-by: Nick Piggin <npiggin@suse.de>

Index: linux-2.6/arch/i386/kernel/cpu/intel.c
===================================================================
--- linux-2.6.orig/arch/i386/kernel/cpu/intel.c
+++ linux-2.6/arch/i386/kernel/cpu/intel.c
@@ -6,6 +6,7 @@
 #include <linux/bitops.h>
 #include <linux/smp.h>
 #include <linux/thread_info.h>
+#include <linux/module.h>
 
 #include <asm/processor.h>
 #include <asm/msr.h>
@@ -264,5 +265,55 @@ __init int intel_cpu_init(void)
 	return 0;
 }
 
+#ifndef CONFIG_X86_CMPXCHG
+unsigned long cmpxchg_386_u8(volatile void *ptr, u8 old, u8 new)
+{
+	u8 prev;
+	unsigned long flags;
+
+	/* Poor man's cmpxchg for 386. Unsuitable for SMP */
+	local_irq_save(flags);
+	prev = *(u8 *)ptr;
+	if (prev == old)
+		*(u8 *)ptr = new;
+	local_irq_restore(flags);
+	return prev;
+}
+
+EXPORT_SYMBOL(cmpxchg_386_u8);
+
+unsigned long cmpxchg_386_u16(volatile void *ptr, u16 old, u16 new)
+{
+	u16 prev;
+	unsigned long flags;
+
+	/* Poor man's cmpxchg for 386. Unsuitable for SMP */
+	local_irq_save(flags);
+	prev = *(u16 *)ptr;
+	if (prev == old)
+		*(u16 *)ptr = new;
+	local_irq_restore(flags);
+	return prev;
+}
+
+EXPORT_SYMBOL(cmpxchg_386_u16);
+
+unsigned long cmpxchg_386_u32(volatile void *ptr, u32 old, u32 new)
+{
+	u32 prev;
+	unsigned long flags;
+
+	/* Poor man's cmpxchg for 386. Unsuitable for SMP */
+	local_irq_save(flags);
+	prev = *(u32 *)ptr;
+	if (prev == old)
+		*(u32 *)ptr = new;
+	local_irq_restore(flags);
+	return prev;
+}
+
+EXPORT_SYMBOL(cmpxchg_386_u32);
+#endif
+
 // arch_initcall(intel_cpu_init);
 
Index: linux-2.6/include/asm-i386/system.h
===================================================================
--- linux-2.6.orig/include/asm-i386/system.h
+++ linux-2.6/include/asm-i386/system.h
@@ -256,11 +256,6 @@ static inline unsigned long __xchg(unsig
  * store NEW in MEM.  Return the initial value in MEM.  Success is
  * indicated by comparing RETURN with OLD.
  */
-
-#ifdef CONFIG_X86_CMPXCHG
-#define __HAVE_ARCH_CMPXCHG 1
-#endif
-
 static inline unsigned long __cmpxchg(volatile void *ptr, unsigned long old,
 				      unsigned long new, int size)
 {
@@ -288,12 +283,53 @@ static inline unsigned long __cmpxchg(vo
 	return old;
 }
 
+#ifdef CONFIG_X86_CMPXCHG
+#define __HAVE_ARCH_CMPXCHG 1
 #define cmpxchg(ptr,o,n)\
-	((__typeof__(*(ptr)))__cmpxchg((ptr),(unsigned long)(o),\
-					(unsigned long)(n),sizeof(*(ptr))))
-    
+	((__typeof__(*(ptr)))__cmpxchg((ptr), (unsigned long)(o), \
+					(unsigned long)(n), sizeof(*(ptr))))
+
+#else
+
+/*
+ * Building a kernel capable running on 80386. It may be necessary to
+ * simulate the cmpxchg on the 80386 CPU. For that purpose we define
+ * a function for each of the sizes we support.
+ */
+
+extern unsigned long cmpxchg_386_u8(volatile void *, u8, u8);
+extern unsigned long cmpxchg_386_u16(volatile void *, u16, u16);
+extern unsigned long cmpxchg_386_u32(volatile void *, u32, u32);
+
+static inline unsigned long cmpxchg_386(volatile void *ptr, unsigned long old,
+				      unsigned long new, int size)
+{
+	switch (size) {
+	case 1:
+		return cmpxchg_386_u8(ptr, old, new);
+	case 2:
+		return cmpxchg_386_u16(ptr, old, new);
+	case 4:
+		return cmpxchg_386_u32(ptr, old, new);
+	}
+	return old;
+}
+
+#define cmpxchg(ptr,o,n)						\
+({									\
+	__typeof__(*(ptr)) __ret;					\
+	if (likely(boot_cpu_data.x86 > 3))				\
+		__ret = __cmpxchg((ptr), (unsigned long)(o),		\
+					(unsigned long)(n), sizeof(*(ptr))); \
+	else								\
+		__ret = cmpxchg_386((ptr), (unsigned long)(o),		\
+					(unsigned long)(n), sizeof(*(ptr))); \
+	__ret;								\
+})
+#endif
+
 #ifdef __KERNEL__
-struct alt_instr { 
+struct alt_instr {
 	__u8 *instr; 		/* original instruction */
 	__u8 *replacement;
 	__u8  cpuid;		/* cpuid bit set for replacement */

--------------050704020804070905000204--
Send instant messages to your online friends http://au.messenger.yahoo.com 
