Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1422659AbWA0Wvq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422659AbWA0Wvq (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 27 Jan 2006 17:51:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1422651AbWA0Wv3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 27 Jan 2006 17:51:29 -0500
Received: from smtp3.pp.htv.fi ([213.243.153.36]:17616 "EHLO smtp3.pp.htv.fi")
	by vger.kernel.org with ESMTP id S1422650AbWA0WvT (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 27 Jan 2006 17:51:19 -0500
Date: Sat, 28 Jan 2006 00:51:18 +0200
From: Paul Mundt <lethal@linux-sh.org>
To: akpm@osdl.org, linux-kernel@vger.kernel.org
Subject: [PATCH 3/11] sh: Move TRA/EXPEVT/INTEVT definitions for reuse.
Message-ID: <20060127225118.GD30816@linux-sh.org>
Mail-Followup-To: Paul Mundt <lethal@linux-sh.org>, akpm@osdl.org,
	linux-kernel@vger.kernel.org
References: <20060127224919.GA30816@linux-sh.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060127224919.GA30816@linux-sh.org>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Currently entry.S is home to these definitions, so we move them
somewhere more sensible. IPR IRQ handling depends on being to
read from INTEVT.

Signed-off-by: Paul Mundt <lethal@linux-sh.org>

---

 arch/sh/kernel/entry.S               |   18 +-----------------
 include/asm-sh/cpu-sh3/mmu_context.h |   10 ++++++++++
 include/asm-sh/cpu-sh4/mmu_context.h |    8 ++++++++
 3 files changed, 19 insertions(+), 17 deletions(-)

93492826e1280557092be3ecd5159d85cc4f6e31
diff --git a/arch/sh/kernel/entry.S b/arch/sh/kernel/entry.S
index fb63681..a440d36 100644
--- a/arch/sh/kernel/entry.S
+++ b/arch/sh/kernel/entry.S
@@ -16,6 +16,7 @@
 #include <linux/config.h>
 #include <asm/asm-offsets.h>
 #include <asm/thread_info.h>
+#include <asm/cpu/mmu_context.h>
 #include <asm/unistd.h>
 
 #if !defined(CONFIG_NFSD) && !defined(CONFIG_NFSD_MODULE)
@@ -75,23 +76,6 @@
 ENOSYS = 38
 EINVAL = 22
 
-#if defined(CONFIG_CPU_SH3)
-TRA     = 0xffffffd0
-EXPEVT  = 0xffffffd4
-#if defined(CONFIG_CPU_SUBTYPE_SH7707) || defined(CONFIG_CPU_SUBTYPE_SH7709) || \
-    defined(CONFIG_CPU_SUBTYPE_SH7300) || defined(CONFIG_CPU_SUBTYPE_SH7705)
-INTEVT  = 0xa4000000		! INTEVTE2(0xa4000000)
-#else
-INTEVT  = 0xffffffd8
-#endif
-MMU_TEA = 0xfffffffc		! TLB Exception Address Register
-#elif defined(CONFIG_CPU_SH4)
-TRA     = 0xff000020
-EXPEVT  = 0xff000024
-INTEVT  = 0xff000028
-MMU_TEA = 0xff00000c		! TLB Exception Address Register
-#endif
-
 #if defined(CONFIG_KGDB_NMI)
 NMI_VEC = 0x1c0			! Must catch early for debounce
 #endif
diff --git a/include/asm-sh/cpu-sh3/mmu_context.h b/include/asm-sh/cpu-sh3/mmu_context.h
index 5cfaa6b..a844ea0 100644
--- a/include/asm-sh/cpu-sh3/mmu_context.h
+++ b/include/asm-sh/cpu-sh3/mmu_context.h
@@ -24,5 +24,15 @@
 #define MMU_NTLB_WAYS		4
 #define MMU_CONTROL_INIT	0x007	/* SV=0, TF=1, IX=1, AT=1 */
 
+#define TRA	0xffffffd0
+#define EXPEVT	0xffffffd4
+
+#if defined(CONFIG_CPU_SUBTYPE_SH7707) || defined(CONFIG_CPU_SUBTYPE_SH7709) || \
+    defined(CONFIG_CPU_SUBTYPE_SH7300) || defined(CONFIG_CPU_SUBTYPE_SH7705)
+#define INTEVT	0xa4000000	/* INTEVTE2(0xa4000000) */
+#else
+#define INTEVT	0xffffffd8
+#endif
+
 #endif /* __ASM_CPU_SH3_MMU_CONTEXT_H */
 
diff --git a/include/asm-sh/cpu-sh4/mmu_context.h b/include/asm-sh/cpu-sh4/mmu_context.h
index 5b64d04..ff4c5fb 100644
--- a/include/asm-sh/cpu-sh4/mmu_context.h
+++ b/include/asm-sh/cpu-sh4/mmu_context.h
@@ -23,7 +23,11 @@
 #define MMU_PAGE_ASSOC_BIT	0x80
 
 #define MMU_NTLB_ENTRIES	64	/* for 7750 */
+#ifdef CONFIG_SH_STORE_QUEUES
+#define MMU_CONTROL_INIT	0x05	/* SQMD=0, SV=0, TI=1, AT=1 */
+#else
 #define MMU_CONTROL_INIT	0x205	/* SQMD=1, SV=0, TI=1, AT=1 */
+#endif
 
 #define MMU_ITLB_DATA_ARRAY	0xF3000000
 #define MMU_UTLB_DATA_ARRAY	0xF7000000
@@ -35,5 +39,9 @@
 #define MMU_I_ENTRY_SHIFT	    8
 #define MMU_ITLB_VALID		0x100
 
+#define TRA	0xff000020
+#define EXPEVT	0xff000024
+#define INTEVT	0xff000028
+
 #endif /* __ASM_CPU_SH4_MMU_CONTEXT_H */
 
