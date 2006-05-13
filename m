Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932475AbWEMQGo@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932475AbWEMQGo (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 13 May 2006 12:06:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932473AbWEMQGb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 13 May 2006 12:06:31 -0400
Received: from mta08-winn.ispmail.ntl.com ([81.103.221.48]:2591 "EHLO
	mtaout02-winn.ispmail.ntl.com") by vger.kernel.org with ESMTP
	id S932469AbWEMQGQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 13 May 2006 12:06:16 -0400
From: Catalin Marinas <catalin.marinas@gmail.com>
Subject: [PATCH 2.6.17-rc4 4/6] Add kmemleak support for i386
Date: Sat, 13 May 2006 17:06:12 +0100
To: linux-kernel@vger.kernel.org
Message-Id: <20060513160612.8848.95311.stgit@localhost.localdomain>
In-Reply-To: <20060513155757.8848.11980.stgit@localhost.localdomain>
References: <20060513155757.8848.11980.stgit@localhost.localdomain>
Content-Type: text/plain; charset=utf-8; format=fixed
Content-Transfer-Encoding: 8bit
User-Agent: StGIT/0.9
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Catalin Marinas <catalin.marinas@arm.com>

This patch modifies the vmlinux.lds.S script and adds the backtrace support
for i386 to be used with kmemleak.

Signed-off-by: Catalin Marinas <catalin.marinas@arm.com>
---

 arch/i386/kernel/vmlinux.lds.S |    4 ++++
 include/asm-i386/processor.h   |   12 ++++++++++++
 2 files changed, 16 insertions(+), 0 deletions(-)

diff --git a/arch/i386/kernel/vmlinux.lds.S b/arch/i386/kernel/vmlinux.lds.S
index 8831303..370480e 100644
--- a/arch/i386/kernel/vmlinux.lds.S
+++ b/arch/i386/kernel/vmlinux.lds.S
@@ -38,6 +38,7 @@ SECTIONS
   RODATA
 
   /* writeable */
+  _sdata = .;			/* Start of data section */
   .data : AT(ADDR(.data) - LOAD_OFFSET) {	/* Data */
 	*(.data)
 	CONSTRUCTORS
@@ -140,6 +141,9 @@ SECTIONS
   __per_cpu_start = .;
   .data.percpu  : AT(ADDR(.data.percpu) - LOAD_OFFSET) { *(.data.percpu) }
   __per_cpu_end = .;
+  __memleak_offsets_start = .;
+  .init.memleak_offsets : AT(ADDR(.init.memleak_offsets) - LOAD_OFFSET) { *(.init.memleak_offsets) }
+  __memleak_offsets_end = .;
   . = ALIGN(4096);
   __init_end = .;
   /* freed after init ends here */
diff --git a/include/asm-i386/processor.h b/include/asm-i386/processor.h
index 805f0dc..9b6568a 100644
--- a/include/asm-i386/processor.h
+++ b/include/asm-i386/processor.h
@@ -743,4 +743,16 @@ #else
 #define mcheck_init(c) do {} while(0)
 #endif
 
+#ifdef CONFIG_FRAME_POINTER
+static inline unsigned long arch_call_address(void *frame)
+{
+	return *(unsigned long *) (frame + 4);
+}
+
+static inline void *arch_prev_frame(void *frame)
+{
+	return *(void **) frame;
+}
+#endif
+
 #endif /* __ASM_I386_PROCESSOR_H */
