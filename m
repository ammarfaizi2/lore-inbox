Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965262AbWGJWK4@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965262AbWGJWK4 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 10 Jul 2006 18:10:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965058AbWGJWKl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 10 Jul 2006 18:10:41 -0400
Received: from mta07-winn.ispmail.ntl.com ([81.103.221.47]:7121 "EHLO
	mtaout01-winn.ispmail.ntl.com") by vger.kernel.org with ESMTP
	id S965254AbWGJWKW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 10 Jul 2006 18:10:22 -0400
From: Catalin Marinas <catalin.marinas@gmail.com>
Subject: [PATCH 05/10] Add kmemleak support for i386
Date: Mon, 10 Jul 2006 23:10:19 +0100
To: linux-kernel@vger.kernel.org
Message-Id: <20060710221018.5191.60271.stgit@localhost.localdomain>
In-Reply-To: <20060710220901.5191.66488.stgit@localhost.localdomain>
References: <20060710220901.5191.66488.stgit@localhost.localdomain>
Content-Type: text/plain; charset=utf-8; format=fixed
Content-Transfer-Encoding: 8bit
User-Agent: StGIT/0.10
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Catalin Marinas <catalin.marinas@arm.com>

This patch modifies the vmlinux.lds.S script and adds the backtrace support
for i386 to be used with kmemleak.

Signed-off-by: Catalin Marinas <catalin.marinas@arm.com>
---

 arch/i386/kernel/vmlinux.lds.S |    4 ++++
 include/asm-i386/processor.h   |   12 ++++++++++++
 include/asm-i386/thread_info.h |   10 +++++++++-
 3 files changed, 25 insertions(+), 1 deletions(-)

diff --git a/arch/i386/kernel/vmlinux.lds.S b/arch/i386/kernel/vmlinux.lds.S
index 2d4f138..34fccf1 100644
--- a/arch/i386/kernel/vmlinux.lds.S
+++ b/arch/i386/kernel/vmlinux.lds.S
@@ -45,6 +45,7 @@ SECTIONS
   __tracedata_end = .;
 
   /* writeable */
+  _sdata = .;			/* Start of data section */
   .data : AT(ADDR(.data) - LOAD_OFFSET) {	/* Data */
 	*(.data)
 	CONSTRUCTORS
@@ -156,6 +157,9 @@ #endif
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
index b32346d..0884122 100644
--- a/include/asm-i386/processor.h
+++ b/include/asm-i386/processor.h
@@ -731,4 +731,16 @@ extern unsigned long boot_option_idle_ov
 extern void enable_sep_cpu(void);
 extern int sysenter_setup(void);
 
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
diff --git a/include/asm-i386/thread_info.h b/include/asm-i386/thread_info.h
index 2833fa2..80b9451 100644
--- a/include/asm-i386/thread_info.h
+++ b/include/asm-i386/thread_info.h
@@ -100,12 +100,20 @@ #define alloc_thread_info(tsk)					\
 		struct thread_info *ret;			\
 								\
 		ret = kmalloc(THREAD_SIZE, GFP_KERNEL);		\
+		memleak_ignore(ret);				\
 		if (ret)					\
 			memset(ret, 0, THREAD_SIZE);		\
 		ret;						\
 	})
 #else
-#define alloc_thread_info(tsk) kmalloc(THREAD_SIZE, GFP_KERNEL)
+#define alloc_thread_info(tsk)					\
+	({							\
+		struct thread_info *ret;			\
+								\
+		ret = kmalloc(THREAD_SIZE, GFP_KERNEL);		\
+		memleak_ignore(ret);				\
+		ret;						\
+	})
 #endif
 
 #define free_thread_info(info)	kfree(info)
