Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751239AbWIAGtu@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751239AbWIAGtu (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 1 Sep 2006 02:49:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964883AbWIAGt0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 1 Sep 2006 02:49:26 -0400
Received: from gw.goop.org ([64.81.55.164]:64965 "EHLO mail.goop.org")
	by vger.kernel.org with ESMTP id S1751226AbWIAGsr (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 1 Sep 2006 02:48:47 -0400
Message-Id: <20060901064823.195028649@goop.org>
References: <20060901064718.918494029@goop.org>
User-Agent: quilt/0.45-1
Date: Thu, 31 Aug 2006 23:47:20 -0700
From: Jeremy Fitzhardinge <jeremy@goop.org>
To: linux-kernel@vger.kernel.org
Cc: Chuck Ebbert <76306.1226@compuserve.com>, Zachary Amsden <zach@vmware.com>,
       Jan Beulich <jbeulich@novell.com>, Andi Kleen <ak@suse.de>,
       Andrew Morton <akpm@osdl.org>
Subject: [PATCH 2/8] Basic definitions for i386-pda
Content-Disposition: inline; filename=i386-pda-definitions.patch
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This patch has the basic definitions of struct i386_pda, and the
segment selector in the GDT.

asm-i386/pda.h is more or less a direct copy of asm-x86_64/pda.h.  The
most interesting difference is the use of _proxy_pda, which is used to
give gcc a model for the actual memory operations on the real pda
structure.  No actual reference is ever made to _proxy_pda, so it is
never defined.

Signed-off-by: Jeremy Fitzhardinge <jeremy@xensource.com>
Cc: Chuck Ebbert <76306.1226@compuserve.com>
Cc: Zachary Amsden <zach@vmware.com>
Cc: Jan Beulich <jbeulich@novell.com>
Cc: Andi Kleen <ak@suse.de>

---
 arch/i386/kernel/asm-offsets.c |    4 ++
 arch/i386/kernel/head.S        |    2 -
 include/asm-i386/pda.h         |   74 ++++++++++++++++++++++++++++++++++++++++
 include/asm-i386/segment.h     |    5 ++
 4 files changed, 83 insertions(+), 2 deletions(-)


===================================================================
--- a/arch/i386/kernel/asm-offsets.c
+++ b/arch/i386/kernel/asm-offsets.c
@@ -15,6 +15,7 @@
 #include <asm/processor.h>
 #include <asm/thread_info.h>
 #include <asm/elf.h>
+#include <asm/pda.h>
 
 #define DEFINE(sym, val) \
         asm volatile("\n->" #sym " %0 " #val : : "i" (val))
@@ -91,4 +92,7 @@ void foo(void)
 	DEFINE(VDSO_PRELINK, VDSO_PRELINK);
 
 	OFFSET(crypto_tfm_ctx_offset, crypto_tfm, __crt_ctx);
+
+	BLANK();
+	OFFSET(PDA_pcurrent, i386_pda, pcurrent);
 }
===================================================================
--- a/arch/i386/kernel/head.S
+++ b/arch/i386/kernel/head.S
@@ -585,7 +585,7 @@ ENTRY(cpu_gdt_table)
 	.quad 0x004092000000ffff	/* 0xc8 APM DS    data */
 
 	.quad 0x0000920000000000	/* 0xd0 - ESPFIX 16-bit SS */
-	.quad 0x0000000000000000	/* 0xd8 - unused */
+	.quad 0x0000000000000000	/* 0xd8 - PDA */
 	.quad 0x0000000000000000	/* 0xe0 - unused */
 	.quad 0x0000000000000000	/* 0xe8 - unused */
 	.quad 0x0000000000000000	/* 0xf0 - unused */
===================================================================
--- a/include/asm-i386/segment.h
+++ b/include/asm-i386/segment.h
@@ -39,7 +39,7 @@
  *  25 - APM BIOS support 
  *
  *  26 - ESPFIX small SS
- *  27 - unused
+ *  27 - PDA				[ per-cpu private data area ]
  *  28 - unused
  *  29 - unused
  *  30 - unused
@@ -73,6 +73,9 @@
 
 #define GDT_ENTRY_ESPFIX_SS		(GDT_ENTRY_KERNEL_BASE + 14)
 #define __ESPFIX_SS (GDT_ENTRY_ESPFIX_SS * 8)
+
+#define GDT_ENTRY_PDA			(GDT_ENTRY_KERNEL_BASE + 15)
+#define __KERNEL_PDA (GDT_ENTRY_PDA * 8)
 
 #define GDT_ENTRY_DOUBLEFAULT_TSS	31
 
===================================================================
--- /dev/null
+++ b/include/asm-i386/pda.h
@@ -0,0 +1,74 @@
+#ifndef _I386_PDA_H
+#define _I386_PDA_H
+
+struct i386_pda
+{
+	struct i386_pda *_pda;		/* pointer to self */
+
+	struct task_struct *pcurrent;	/* current process */
+	int cpu_number;
+};
+
+extern struct i386_pda *_cpu_pda[];
+
+#define cpu_pda(i)	(_cpu_pda[i])
+
+#define pda_offset(field) offsetof(struct i386_pda, field)
+
+extern void __bad_pda_field(void);
+
+extern struct i386_pda _proxy_pda;
+
+#define pda_to_op(op,field,val)						\
+	do {								\
+		typedef typeof(_proxy_pda.field) T__;			\
+		if (0) { T__ tmp__; tmp__ = (val); }			\
+		switch (sizeof(_proxy_pda.field)) {			\
+		case 2:							\
+			asm(op "w %1,%%gs:%P2"				\
+			    : "+m" (_proxy_pda.field)			\
+			    :"ri" ((T__)val),				\
+			     "i"(pda_offset(field)));			\
+			break;						\
+		case 4:							\
+			asm(op "l %1,%%gs:%P2"				\
+			    : "+m" (_proxy_pda.field)			\
+			    :"ri" ((T__)val),				\
+			     "i"(pda_offset(field)));			\
+			break;						\
+		default: __bad_pda_field();				\
+		}							\
+	} while (0)
+
+#define pda_from_op(op,field)						\
+	({								\
+		typeof(_proxy_pda.field) ret__;				\
+		switch (sizeof(_proxy_pda.field)) {			\
+		case 2:							\
+			asm(op "w %%gs:%P1,%0"				\
+			    : "=r" (ret__)				\
+			    : "i" (pda_offset(field)),			\
+			      "m" (_proxy_pda.field));			\
+			break;						\
+		case 4:							\
+			asm(op "l %%gs:%P1,%0"				\
+			    : "=r" (ret__)				\
+			    : "i" (pda_offset(field)),			\
+			      "m" (_proxy_pda.field));			\
+			break;						\
+		default: __bad_pda_field();				\
+		}							\
+		ret__; })
+
+/* Return a pointer to a pda field */
+#define pda_addr(field)							\
+	((typeof(_proxy_pda.field) *)((unsigned char *)read_pda(_pda) + \
+				      pda_offset(field)))
+
+#define read_pda(field) pda_from_op("mov",field)
+#define write_pda(field,val) pda_to_op("mov",field,val)
+#define add_pda(field,val) pda_to_op("add",field,val)
+#define sub_pda(field,val) pda_to_op("sub",field,val)
+#define or_pda(field,val) pda_to_op("or",field,val)
+
+#endif	/* _I386_PDA_H */

--

