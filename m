Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932273AbWE3OI5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932273AbWE3OI5 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 30 May 2006 10:08:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932283AbWE3OHt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 30 May 2006 10:07:49 -0400
Received: from cam-admin0.cambridge.arm.com ([193.131.176.58]:5015 "EHLO
	cam-admin0.cambridge.arm.com") by vger.kernel.org with ESMTP
	id S932285AbWE3OHd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 30 May 2006 10:07:33 -0400
From: Catalin Marinas <catalin.marinas@arm.com>
Reply-To: catalin.marinas@gmail.com
Subject: [PATCH 2.6.17-rc5 5/7] Add kmemleak support for ARM
Date: Tue, 30 May 2006 15:07:29 +0100
To: linux-kernel@vger.kernel.org
Message-Id: <20060530140729.21491.46432.stgit@localhost.localdomain>
In-Reply-To: <20060530135016.21491.34817.stgit@localhost.localdomain>
References: <20060530135016.21491.34817.stgit@localhost.localdomain>
Content-Type: text/plain; charset=utf-8; format=fixed
Content-Transfer-Encoding: 8bit
User-Agent: StGIT/0.9
X-OriginalArrivalTime: 30 May 2006 14:07:30.0024 (UTC) FILETIME=[636FE680:01C683F2]
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
