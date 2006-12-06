Return-Path: <linux-kernel-owner+willy=40w.ods.org-S936965AbWLFR4p@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S936965AbWLFR4p (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 6 Dec 2006 12:56:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S936964AbWLFR4p
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 6 Dec 2006 12:56:45 -0500
Received: from mx1.redhat.com ([66.187.233.31]:47644 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S936958AbWLFR4n (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 6 Dec 2006 12:56:43 -0500
From: David Howells <dhowells@redhat.com>
Subject: [PATCH] WorkStruct: Implement generic UP cmpxchg() where an arch doesn't support it [try #2]
Date: Wed, 06 Dec 2006 17:56:22 +0000
To: torvalds@osdl.org, akpm@osdl.org, linux-arm-kernel@lists.arm.linux.org.uk
Cc: linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org,
       dhowells@redhat.com
Message-Id: <20061206175622.31077.96046.stgit@warthog.cambridge.redhat.com>
Content-Type: text/plain; charset=utf-8; format=fixed
Content-Transfer-Encoding: 8bit
User-Agent: StGIT/0.10
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Implement generic UP cmpxchg() where an arch doesn't otherwise support it.
This assuming that the arch doesn't have support SMP without providing its own
cmpxchg() implementation.

This is required because cmpxchg() is used by the reduced work queue patches to
adjust the management data in a work_struct.

Also provide ARMv6 with a cmpxchg() implementation using LDREX/STREXEQ.  Pre-v6
ARM doesn't support SMP according to ARM's atomic.h, so the generic
IRQ-disablement based cmpxchg() is entirely adequate there (if it isn't, then
atomic_cmpxchg() is also broken on ARM).

Signed-Off-By: David Howells <dhowells@redhat.com>
---

 include/asm-arm/system.h      |   40 ++++++++++++++++++++++++++++++++++++
 include/asm-generic/cmpxchg.h |   46 +++++++++++++++++++++++++++++++++++++++++
 2 files changed, 86 insertions(+), 0 deletions(-)

diff --git a/include/asm-arm/system.h b/include/asm-arm/system.h
index f05fbe3..f16e42d 100644
--- a/include/asm-arm/system.h
+++ b/include/asm-arm/system.h
@@ -325,6 +325,46 @@ #endif
 extern void disable_hlt(void);
 extern void enable_hlt(void);
 
+/*
+ * We only implement cmpxchg in ASM on ARMv6 where we have LDREX/STREX
+ * available, and we only implement it for word-sized exchanges
+ */
+#if __LINUX_ARM_ARCH__ >= 6
+extern void __bad_cmpxchg(volatile void *, int);
+
+#define cmpxchg(ptr, old, new)						\
+({									\
+	__typeof__ (ptr) ____p = (ptr);					\
+	__typeof__(*ptr) ____old = (old);				\
+	__typeof__(*ptr) ____new = (new);				\
+	__typeof__(*ptr) ____oldval;					\
+	__typeof__(*ptr) ____res;					\
+									\
+	switch (sizeof(____res)) {					\
+	case 4:								\
+		do {							\
+			__asm__ __volatile__("@ cmpxchg\n"		\
+			"ldrex	%1, [%2]\n"				\
+			"mov	%0, #0\n"				\
+			"teq	%1, %3\n"				\
+			"strexeq %0, %4, [%2]\n"			\
+			: "=&r" (____res), "=&r" (____oldval)		\
+			: "r" (____p), "Ir" (____old), "r" (____new)	\
+			: "cc");					\
+		} while(____res);					\
+		break;							\
+	default:							\
+		__bad_cmpxchg(____p, sizeof(____res));			\
+		____oldval = 0;						\
+		break;							\
+	}								\
+	____oldval;							\
+})
+
+#else
+#include <asm-generic/cmpxchg.h>
+#endif
+
 #endif /* __ASSEMBLY__ */
 
 #define arch_align_stack(x) (x)
diff --git a/include/asm-generic/cmpxchg.h b/include/asm-generic/cmpxchg.h
new file mode 100644
index 0000000..be0da99
--- /dev/null
+++ b/include/asm-generic/cmpxchg.h
@@ -0,0 +1,46 @@
+/* Generic cmpxchg for those arches that don't implement it themselves
+ *
+ * Copyright (C) 2006 Red Hat, Inc. All Rights Reserved.
+ * Written by David Howells (dhowells@redhat.com)
+ *
+ * This program is free software; you can redistribute it and/or
+ * modify it under the terms of the GNU General Public License
+ * as published by the Free Software Foundation; either version
+ * 2 of the License, or (at your option) any later version.
+ */
+
+#ifndef _ASM_GENERIC_CMPXCHG_H
+#define _ASM_GENERIC_CMPXCHG_H
+
+#if !defined(cmpxchg) && !defined(CONFIG_SMP)
+
+/**
+ * cmpxchg - Atomically conditionally exchange one value for another.
+ * @ptr - Pointer to the value to be altered.
+ * @old - The value to change from.
+ * @new - The value to change to.
+ *
+ * This function atomically compares the current value at the word pointed to
+ * by @ptr, and if it's the same as @old, changes it to @new.  If it's not the
+ * same then it's left unchanged.
+ *
+ * The value that was in the word pointed to by @ptr is returned, whether or
+ * not it was changed to @new.
+ */
+#define cmpxchg(ptr, old, new)			\
+({						\
+	unsigned long ____flags;		\
+	__typeof__ (ptr) ____p = (ptr);		\
+	__typeof__(*ptr) ____old = (old);	\
+	__typeof__(*ptr) ____new = (new);	\
+	__typeof__(*ptr) ____res;		\
+	raw_local_irq_save(____flags);		\
+	____res = *____p;			\
+	if (likely(____res == (____old)))	\
+		*____p = (____new);		\
+	raw_local_irq_restore(____flags);	\
+	____res;				\
+})
+
+#endif /* !cmpxchg && !SMP */
+#endif /* _ASM_GENERIC_CMPXCHG_H */
