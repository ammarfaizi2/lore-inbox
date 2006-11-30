Return-Path: <linux-kernel-owner+willy=40w.ods.org-S967952AbWK3XBH@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S967952AbWK3XBH (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 30 Nov 2006 18:01:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S967949AbWK3XA7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 30 Nov 2006 18:00:59 -0500
Received: from mtaout01-winn.ispmail.ntl.com ([81.103.221.47]:34398 "EHLO
	mtaout01-winn.ispmail.ntl.com") by vger.kernel.org with ESMTP
	id S967952AbWK3XA5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 30 Nov 2006 18:00:57 -0500
From: Catalin Marinas <catalin.marinas@gmail.com>
Subject: [PATCH 2.6.19 05/10] Add kmemleak support for i386
To: linux-kernel@vger.kernel.org
Date: Thu, 30 Nov 2006 23:00:43 +0000
Message-ID: <20061130230043.5469.34508.stgit@localhost.localdomain>
In-Reply-To: <20061130225219.5469.2453.stgit@localhost.localdomain>
References: <20061130225219.5469.2453.stgit@localhost.localdomain>
User-Agent: StGIT/0.11
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This patch modifies the vmlinux.lds.S script and adds the backtrace support
for i386 to be used with kmemleak.

Signed-off-by: Catalin Marinas <catalin.marinas@gmail.com>
---

 arch/i386/kernel/vmlinux.lds.S |    4 ++++
 include/asm-i386/thread_info.h |   10 +++++++++-
 2 files changed, 13 insertions(+), 1 deletions(-)

diff --git a/arch/i386/kernel/vmlinux.lds.S b/arch/i386/kernel/vmlinux.lds.S
index c6f84a0..499c32b 100644
--- a/arch/i386/kernel/vmlinux.lds.S
+++ b/arch/i386/kernel/vmlinux.lds.S
@@ -52,6 +52,7 @@ SECTIONS
 
   /* writeable */
   . = ALIGN(4096);
+  _sdata = .;			/* Start of data section */
   .data : AT(ADDR(.data) - LOAD_OFFSET) {	/* Data */
 	*(.data)
 	CONSTRUCTORS
@@ -157,6 +158,9 @@ SECTIONS
   __per_cpu_start = .;
   .data.percpu  : AT(ADDR(.data.percpu) - LOAD_OFFSET) { *(.data.percpu) }
   __per_cpu_end = .;
+  __memleak_offsets_start = .;
+  .init.memleak_offsets : AT(ADDR(.init.memleak_offsets) - LOAD_OFFSET) { *(.init.memleak_offsets) }
+  __memleak_offsets_end = .;
   . = ALIGN(4096);
   __init_end = .;
   /* freed after init ends here */
diff --git a/include/asm-i386/thread_info.h b/include/asm-i386/thread_info.h
index 54d6d7a..054553f 100644
--- a/include/asm-i386/thread_info.h
+++ b/include/asm-i386/thread_info.h
@@ -100,12 +100,20 @@ static inline struct thread_info *curren
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
