Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316342AbSH0Pel>; Tue, 27 Aug 2002 11:34:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316408AbSH0Pel>; Tue, 27 Aug 2002 11:34:41 -0400
Received: from bay-bridge.veritas.com ([143.127.3.10]:42127 "EHLO
	mtvmime01.veritas.com") by vger.kernel.org with ESMTP
	id <S316342AbSH0Pek>; Tue, 27 Aug 2002 11:34:40 -0400
Date: Tue, 27 Aug 2002 16:39:31 +0100 (BST)
From: Hugh Dickins <hugh@veritas.com>
X-X-Sender: hugh@localhost.localdomain
To: Linus Torvalds <torvalds@transmeta.com>
cc: Dave Jones <davej@suse.de>,
       Marc Dietrich <Marc.Dietrich@hrz.uni-giessen.de>,
       <linux-kernel@vger.kernel.org>
Subject: [PATCH] M386 flush_one_tlb invlpg
Message-ID: <Pine.LNX.4.44.0208271635050.2362-100000@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

CONFIG_M386 kernel running on PPro+ processor with X86_FEATURE_PGE may
set _PAGE_GLOBAL bit: then __flush_tlb_one must use invlpg instruction.

The need for this was shown by a recent HyperThreading discussion.
Marc Dietrich reported (LKML 22 Aug) that CONFIG_M386 CONFIG_SMP kernel
on P4 Xeon did not support HT: his dmesg showed acpi_tables_init failed
from bad table data due to unflushed TLB: he confirms patch fixes it.

No tears would be shed if CONFIG_M386 could not support HT, but bad TLB
is trouble.  Same CONFIG_M386 bug affects CONFIG_HIGHMEM's kmap_atomic,
and potentially dmi_scan (now using set_fixmap via bt_ioremap).  Though
it's true that none of these uses really needs _PAGE_GLOBAL bit itself.

I just sent the 2.4.20-pre4 asm-i386/pgtable.h patch to Marcelo:
here's patch against 2.5.31 or current BK: please apply.

Hugh

--- 2.5.31/include/asm-i386/tlbflush.h	Tue Jun  4 14:27:14 2002
+++ linux/include/asm-i386/tlbflush.h	Tue Aug 27 15:30:53 2002
@@ -45,11 +45,19 @@
 			__flush_tlb();					\
 	} while (0)
 
-#ifndef CONFIG_X86_INVLPG
-#define __flush_tlb_one(addr) __flush_tlb()
+#define __flush_tlb_single(addr) \
+	__asm__ __volatile__("invlpg %0": :"m" (*(char *) addr))
+
+#ifdef CONFIG_X86_INVLPG
+# define __flush_tlb_one(addr) __flush_tlb_single(addr)
 #else
-#define __flush_tlb_one(addr) \
-__asm__ __volatile__("invlpg %0": :"m" (*(char *) addr))
+# define __flush_tlb_one(addr)						\
+	do {								\
+		if (cpu_has_pge)					\
+			__flush_tlb_single(addr);			\
+		else							\
+			__flush_tlb();					\
+	} while (0)
 #endif
 
 /*

