Return-Path: <linux-kernel-owner+akpm=40zip.com.au-S932282AbWFDWA5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932282AbWFDWA5 (ORCPT <rfc822;akpm@zip.com.au>);
	Sun, 4 Jun 2006 18:00:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932274AbWFDWA4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 4 Jun 2006 18:00:56 -0400
Received: from mta09-winn.ispmail.ntl.com ([81.103.221.49]:54792 "EHLO
	mtaout03-winn.ispmail.ntl.com") by vger.kernel.org with ESMTP
	id S932280AbWFDWAm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 4 Jun 2006 18:00:42 -0400
From: Catalin Marinas <catalin.marinas@gmail.com>
Subject: [PATCH 2.6.17-rc5 5/8] Add kmemleak support for i386
Date: Sun, 04 Jun 2006 23:00:38 +0100
To: linux-kernel@vger.kernel.org
Message-Id: <20060604220038.16277.18527.stgit@localhost.localdomain>
In-Reply-To: <20060604215636.16277.15454.stgit@localhost.localdomain>
References: <20060604215636.16277.15454.stgit@localhost.localdomain>
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
