Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932467AbWEMQGa@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932467AbWEMQGa (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 13 May 2006 12:06:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932473AbWEMQGa
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 13 May 2006 12:06:30 -0400
Received: from mta07-winn.ispmail.ntl.com ([81.103.221.47]:11277 "EHLO
	mtaout01-winn.ispmail.ntl.com") by vger.kernel.org with ESMTP
	id S932467AbWEMQGW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 13 May 2006 12:06:22 -0400
From: Catalin Marinas <catalin.marinas@gmail.com>
Subject: [PATCH 2.6.17-rc4 5/6] Add kmemleak support for ARM
Date: Sat, 13 May 2006 17:06:18 +0100
To: linux-kernel@vger.kernel.org
Message-Id: <20060513160618.8848.53189.stgit@localhost.localdomain>
In-Reply-To: <20060513155757.8848.11980.stgit@localhost.localdomain>
References: <20060513155757.8848.11980.stgit@localhost.localdomain>
Content-Type: text/plain; charset=utf-8; format=fixed
Content-Transfer-Encoding: 8bit
User-Agent: StGIT/0.9
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
index 2b254e8..c6f038c 100644
--- a/arch/arm/kernel/vmlinux.lds.S
+++ b/arch/arm/kernel/vmlinux.lds.S
@@ -68,6 +68,11 @@ #endif
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
@@ -110,6 +115,7 @@ #endif
 
 	.data : AT(__data_loc) {
 		__data_start = .;	/* address in memory */
+		_sdata = .;
 
 		/*
 		 * first, the init task union, aligned
@@ -158,6 +164,7 @@ #endif
 		__bss_start = .;	/* BSS				*/
 		*(.bss)
 		*(COMMON)
+		__bss_stop = .;
 		_end = .;
 	}
 					/* Stabs debugging sections.	*/
diff --git a/include/asm-arm/processor.h b/include/asm-arm/processor.h
index 04f4d34..feaf017 100644
--- a/include/asm-arm/processor.h
+++ b/include/asm-arm/processor.h
@@ -121,6 +121,18 @@ #define spin_lock_prefetch(x) do { } whi
 
 #endif
 
+#ifdef CONFIG_FRAME_POINTER
+static inline unsigned long arch_call_address(void *frame)
+{
+	return *(unsigned long *) (frame - 4) - 4;
+}
+
+static inline void *arch_prev_frame(void *frame)
+{
+	return *(void **) (frame - 12);
+}
+#endif
+
 #endif
 
 #endif /* __ASM_ARM_PROCESSOR_H */
