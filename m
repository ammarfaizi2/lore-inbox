Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265359AbUGDDOl@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265359AbUGDDOl (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 3 Jul 2004 23:14:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265376AbUGDDOl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 3 Jul 2004 23:14:41 -0400
Received: from mtvcafw.sgi.com ([192.48.171.6]:42691 "EHLO omx2.sgi.com")
	by vger.kernel.org with ESMTP id S265359AbUGDDOi (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 3 Jul 2004 23:14:38 -0400
Date: Sat, 3 Jul 2004 20:14:24 -0700 (PDT)
From: Paul Jackson <pj@sgi.com>
To: "David S. Miller" <davem@redhat.com>, Andrew Morton <akpm@osdl.org>,
       linux-kernel@vger.kernel.org
Cc: Paul Jackson <pj@sgi.com>
Message-Id: <20040704031424.9074.25825.72298@sam.engr.sgi.com>
Subject: [patch] sparc 32 cpumask bitop build fix
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

With the following changes, I was able to compile the "sparc" (32
bit) arch, using defconfig and crosstool.  There were still plenty
of warnings, but nothing else relating to bitops or cpumasks that
I noticed.  This is working with 2.6.7-mm5.

I have no way to boot test this, but these changes seem obvious
enough that I'd recommend including them.

Signed-off-by: Paul Jackson <pj@sgi.com>

Index: 267mm5cpusetv4sparc/include/asm-sparc/bitops.h
===================================================================
--- 267mm5cpusetv4sparc.orig/include/asm-sparc/bitops.h	2004-07-03 01:00:34.000000000 -0700
+++ 267mm5cpusetv4sparc/include/asm-sparc/bitops.h	2004-07-03 04:45:36.000000000 -0700
@@ -366,9 +366,9 @@ found_middle:
  *
  * Scheduler induced bitop, do not use.
  */
-static inline int find_next_bit(unsigned long *addr, int size, int offset)
+static inline int find_next_bit(const unsigned long *addr, int size, int offset)
 {
-	unsigned long *p = addr + (offset >> 5);
+	const unsigned long *p = addr + (offset >> 5);
 	int num = offset & ~0x1f;
 	unsigned long word;
 
@@ -384,6 +384,17 @@ static inline int find_next_bit(unsigned
 	return num;
 }
 
+/**
+ * find_first_bit - find the first set bit in a memory region
+ * @addr: The address to start the search at
+ * @size: The maximum size to search
+ *
+ * Returns the bit-number of the first set bit, not the number of the byte
+ * containing a bit.
+ */
+#define find_first_bit(addr, size) \
+	find_next_bit((addr), (size), 0)
+
 /*
  */
 static inline int test_le_bit(int nr, __const__ unsigned long * addr)
Index: 267mm5cpusetv4sparc/include/asm-sparc/system.h
===================================================================
--- 267mm5cpusetv4sparc.orig/include/asm-sparc/system.h	2004-07-03 01:00:35.000000000 -0700
+++ 267mm5cpusetv4sparc/include/asm-sparc/system.h	2004-07-03 05:06:03.000000000 -0700
@@ -126,7 +126,7 @@ extern void fpsave(unsigned long *fpregs
 #define switch_to(prev, next, last) do {						\
 	SWITCH_ENTER(prev);								\
 	SWITCH_DO_LAZY_FPU(next);							\
-	next->active_mm->cpu_vm_mask |= (1 << smp_processor_id());			\
+	cpu_set(smp_processor_id(), next->active_mm->cpu_vm_mask);			\
 	__asm__ __volatile__(								\
 	"sethi	%%hi(here - 0x8), %%o7\n\t"						\
 	"mov	%%g6, %%g3\n\t"								\

-- 
                          I won't rest till it's the best ...
                          Programmer, Linux Scalability
                          Paul Jackson <pj@sgi.com> 1.650.933.1373
