Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932658AbWJIMth@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932658AbWJIMth (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 9 Oct 2006 08:49:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932652AbWJIMth
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 9 Oct 2006 08:49:37 -0400
Received: from mtaout02-winn.ispmail.ntl.com ([81.103.221.48]:58200 "EHLO
	mtaout02-winn.ispmail.ntl.com") by vger.kernel.org with ESMTP
	id S932647AbWJIMt3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 9 Oct 2006 08:49:29 -0400
From: Catalin Marinas <catalin.marinas@gmail.com>
Subject: [PATCH 2.6.19-rc1 05/10] Add kmemleak support for i386
Date: Mon, 09 Oct 2006 13:49:24 +0100
To: linux-kernel@vger.kernel.org
Message-Id: <20061009124924.2695.12650.stgit@localhost.localdomain>
In-Reply-To: <20061009124813.2695.8123.stgit@localhost.localdomain>
References: <20061009124813.2695.8123.stgit@localhost.localdomain>
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
 include/asm-i386/thread_info.h |   10 +++++++++-
 2 files changed, 13 insertions(+), 1 deletions(-)

diff --git a/arch/i386/kernel/vmlinux.lds.S b/arch/i386/kernel/vmlinux.lds.S
index 1e7ac1c..88495bb 100644
--- a/arch/i386/kernel/vmlinux.lds.S
+++ b/arch/i386/kernel/vmlinux.lds.S
@@ -51,6 +51,7 @@ SECTIONS
   __tracedata_end = .;
 
   /* writeable */
+  _sdata = .;			/* Start of data section */
   .data : AT(ADDR(.data) - LOAD_OFFSET) {	/* Data */
 	*(.data)
 	CONSTRUCTORS
@@ -162,6 +163,9 @@ #endif
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
