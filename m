Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932618AbWHLWCp@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932618AbWHLWCp (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 12 Aug 2006 18:02:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932619AbWHLWAm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 12 Aug 2006 18:00:42 -0400
Received: from mtaout01-winn.ispmail.ntl.com ([81.103.221.47]:43736 "EHLO
	mtaout01-winn.ispmail.ntl.com") by vger.kernel.org with ESMTP
	id S932618AbWHLWAi (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 12 Aug 2006 18:00:38 -0400
From: Catalin Marinas <catalin.marinas@gmail.com>
Subject: [PATCH 2.6.18-rc4 06/10] Add kmemleak support for ARM
Date: Sat, 12 Aug 2006 23:00:34 +0100
To: linux-kernel@vger.kernel.org
Message-Id: <20060812220034.17709.46636.stgit@localhost.localdomain>
In-Reply-To: <20060812215857.17709.79502.stgit@localhost.localdomain>
References: <20060812215857.17709.79502.stgit@localhost.localdomain>
Content-Type: text/plain; charset=utf-8; format=fixed
Content-Transfer-Encoding: 8bit
User-Agent: StGIT/0.10
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Catalin Marinas <catalin.marinas@arm.com>

This patch modifies the vmlinux.lds.S script and adds the backtrace support
for ARM to be used with kmemleak.

Signed-off-by: Catalin Marinas <catalin.marinas@arm.com>
---

 arch/arm/kernel/vmlinux.lds.S |    7 +++++++
 include/asm-arm/processor.h   |   12 ++++++++++++
 2 files changed, 19 insertions(+), 0 deletions(-)

diff --git a/arch/arm/kernel/vmlinux.lds.S b/arch/arm/kernel/vmlinux.lds.S
index 3ca574e..59976b8 100644
--- a/arch/arm/kernel/vmlinux.lds.S
+++ b/arch/arm/kernel/vmlinux.lds.S
@@ -67,6 +67,11 @@ #endif
 		__per_cpu_start = .;
 			*(.data.percpu)
 		__per_cpu_end = .;
+#ifdef CONFIG_DEBUG_MEMLEAK
+		__memleak_offsets_start = .;
+			*(.init.memleak_offsets)
+		__memleak_offsets_end = .;
+#endif
 #ifndef CONFIG_XIP_KERNEL
 		__init_begin = _stext;
 		*(.init.data)
@@ -115,6 +120,7 @@ #endif
 
 	.data : AT(__data_loc) {
 		__data_start = .;	/* address in memory */
+		_sdata = .;
 
 		/*
 		 * first, the init task union, aligned
@@ -165,6 +171,7 @@ #endif
 		__bss_start = .;	/* BSS				*/
 		*(.bss)
 		*(COMMON)
+		__bss_stop = .;
 		_end = .;
 	}
 					/* Stabs debugging sections.	*/
diff --git a/include/asm-arm/processor.h b/include/asm-arm/processor.h
index 04f4d34..34a3bb3 100644
--- a/include/asm-arm/processor.h
+++ b/include/asm-arm/processor.h
@@ -121,6 +121,18 @@ #define spin_lock_prefetch(x) do { } whi
 
 #endif
 
+#ifdef CONFIG_FRAME_POINTER
+static inline unsigned long arch_call_address(void *frame)
+{
+	return *(unsigned long *)(frame - 4) - 4;
+}
+
+static inline void *arch_prev_frame(void *frame)
+{
+	return *(void **)(frame - 12);
+}
+#endif
+
 #endif
 
 #endif /* __ASM_ARM_PROCESSOR_H */
