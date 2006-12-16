Return-Path: <linux-kernel-owner+w=401wt.eu-S1161083AbWLPPsK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161083AbWLPPsK (ORCPT <rfc822;w@1wt.eu>);
	Sat, 16 Dec 2006 10:48:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161078AbWLPPrm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 16 Dec 2006 10:47:42 -0500
Received: from queue04-winn.ispmail.ntl.com ([81.103.221.58]:42406 "EHLO
	queue04-winn.ispmail.ntl.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1161081AbWLPPrg (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 16 Dec 2006 10:47:36 -0500
From: Catalin Marinas <catalin.marinas@gmail.com>
Subject: [PATCH 2.6.20-rc1 05/10] Add kmemleak support for i386
To: linux-kernel@vger.kernel.org
Date: Sat, 16 Dec 2006 15:35:09 +0000
Message-ID: <20061216153509.18200.81391.stgit@localhost.localdomain>
In-Reply-To: <20061216153346.18200.51408.stgit@localhost.localdomain>
References: <20061216153346.18200.51408.stgit@localhost.localdomain>
User-Agent: StGIT/0.11
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This patch adds the kmemleak-related entries to the vmlinux.lds.S
linker script.

Signed-off-by: Catalin Marinas <catalin.marinas@gmail.com>
---

 arch/i386/kernel/vmlinux.lds.S |    6 ++++++
 include/asm-i386/thread_info.h |   18 ++++++++++++++++--
 2 files changed, 22 insertions(+), 2 deletions(-)

diff --git a/arch/i386/kernel/vmlinux.lds.S b/arch/i386/kernel/vmlinux.lds.S
index a53c8b1..2850bed 100644
--- a/arch/i386/kernel/vmlinux.lds.S
+++ b/arch/i386/kernel/vmlinux.lds.S
@@ -69,6 +69,7 @@ SECTIONS
 
   /* writeable */
   . = ALIGN(4096);
+  _sdata = .;			/* Start of data section */
   .data : AT(ADDR(.data) - LOAD_OFFSET) {	/* Data */
 	*(.data)
 	CONSTRUCTORS
@@ -193,6 +194,11 @@ SECTIONS
 	*(.data.percpu)
 	__per_cpu_end = .;
   }
+  .init.memleak_offsets : AT(ADDR(.init.memleak_offsets) - LOAD_OFFSET) {
+	__memleak_offsets_start = .;
+	*(.init.memleak_offsets)
+	__memleak_offsets_end = .;
+  }
   . = ALIGN(4096);
   /* freed after init ends here */
 	
diff --git a/include/asm-i386/thread_info.h b/include/asm-i386/thread_info.h
index 4b187bb..02f3457 100644
--- a/include/asm-i386/thread_info.h
+++ b/include/asm-i386/thread_info.h
@@ -95,9 +95,23 @@ static inline struct thread_info *curren
 
 /* thread information allocation */
 #ifdef CONFIG_DEBUG_STACK_USAGE
-#define alloc_thread_info(tsk) kzalloc(THREAD_SIZE, GFP_KERNEL)
+#define alloc_thread_info(tsk)					\
+	({							\
+		struct thread_info *ret;			\
+								\
+		ret = kzalloc(THREAD_SIZE, GFP_KERNEL);		\
+		memleak_ignore(ret);				\
+		ret;						\
+	})
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
