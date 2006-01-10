Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932189AbWAJRtx@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932189AbWAJRtx (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 10 Jan 2006 12:49:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932312AbWAJRtx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 10 Jan 2006 12:49:53 -0500
Received: from mx.pathscale.com ([64.160.42.68]:54686 "EHLO mx.pathscale.com")
	by vger.kernel.org with ESMTP id S932292AbWAJRtv (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 10 Jan 2006 12:49:51 -0500
Subject: Re: [PATCH 1 of 3] Introduce __raw_memcpy_toio32
From: "Bryan O'Sullivan" <bos@pathscale.com>
To: Christoph Hellwig <hch@infradead.org>
Cc: Roland Dreier <rdreier@cisco.com>, sam@ravnborg.org,
       Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
In-Reply-To: <20060110170722.GA3187@infradead.org>
References: <patchbomb.1136579193@eng-12.pathscale.com>
	 <d286502c3b3cd6bcec7b.1136579194@eng-12.pathscale.com>
	 <20060110011844.7a4a1f90.akpm@osdl.org> <adaslrw3zfu.fsf@cisco.com>
	 <1136909276.32183.28.camel@serpentine.pathscale.com>
	 <20060110170722.GA3187@infradead.org>
Content-Type: text/plain
Organization: PathScale, Inc.
Date: Tue, 10 Jan 2006 09:49:46 -0800
Message-Id: <1136915386.6294.8.camel@serpentine.pathscale.com>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-2.fc4) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2006-01-10 at 17:07 +0000, Christoph Hellwig wrote:

> Or add a CONFIG_GENERIC_MEMCPY_IO that's non-uservisible and just set
> by all the architectures that don't provide their own version.

Here's another i386-only review patch that does essentially that.  It
looks cleaner to me than my previous patch from this morning.
(Copyrights and other arches omitted, for clarity.)

What do you think?

	<b

diff -r 48616306e7bd lib/Makefile
--- a/lib/Makefile	Tue Jan 10 10:41:42 2006 +0800
+++ b/lib/Makefile	Tue Jan 10 09:32:53 2006 -0800
@@ -21,6 +21,7 @@
 lib-$(CONFIG_RWSEM_XCHGADD_ALGORITHM) += rwsem.o
 lib-$(CONFIG_SEMAPHORE_SLEEPERS) += semaphore-sleepers.o
 lib-$(CONFIG_GENERIC_FIND_NEXT_BIT) += find_next_bit.o
+lib-$(CONFIG_GENERIC_RAW_MEMCPY_IO) += raw_memcpy_io.o
 obj-$(CONFIG_LOCK_KERNEL) += kernel_lock.o
 obj-$(CONFIG_DEBUG_PREEMPT) += smp_processor_id.o
 
--- /dev/null	Thu Jan  1 00:00:00 1970 +0000
+++ b/include/asm-generic/raw_memcpy_io.h	Tue Jan 10 09:32:53 2006 -0800
@@ -0,0 +1,16 @@
+#ifndef _ASM_GENERIC_RAW_MEMCPY_IO_H
+#define _ASM_GENERIC_RAW_MEMCPY_IO_H
+
+/*
+ * __raw_memcpy_toio32 - copy data to MMIO space, in 32-bit units
+ *
+ * Order of access is not guaranteed, nor is a memory barrier performed
+ * afterwards.  This is an arch-independent generic implementation.
+ *
+ * @to: destination, in MMIO space (must be 32-bit aligned)
+ * @from: source (must be 32-bit aligned)
+ * @count: number of 32-bit quantities to copy
+ */
+void __raw_memcpy_toio32(void __iomem *to, const void *from, size_t count);
+
+#endif // _ASM_GENERIC_RAW_MEMCPY_IO_H
diff -r 48616306e7bd lib/raw_memcpy_io.c
--- /dev/null	Thu Jan  1 00:00:00 1970 +0000
+++ b/lib/raw_memcpy_io.c	Tue Jan 10 09:32:53 2006 -0800
@@ -0,0 +1,13 @@
+#include <linux/types.h>
+#include <asm/io.h>
+#include <asm-generic/raw_memcpy_io.h>
+
+void __raw_memcpy_toio32(void __iomem *to, const void *from, size_t count)
+{
+	u32 __iomem *dst = to;
+	const u32 *src = from;
+	size_t i;
+
+	for (i = 0; i < count; i++)
+		__raw_writel(*src++, dst++);
+}
--- a/include/asm-i386/io.h	Tue Jan 10 09:32:58 2006 -0800
+++ b/include/asm-i386/io.h	Tue Jan 10 09:35:16 2006 -0800
@@ -203,6 +203,8 @@
 {
 	__memcpy((void __force *) dst, src, count);
 }
+
+#include <asm-generic/raw_memcpy_io.h>
 
 /*
  * ISA space is 'always mapped' on a typical x86 system, no need to
--- a/arch/i386/Kconfig	Tue Jan 10 09:32:58 2006 -0800
+++ b/arch/i386/Kconfig	Tue Jan 10 09:35:16 2006 -0800
@@ -34,6 +34,10 @@
 	default y
 
 config GENERIC_IOMAP
+	bool
+	default y
+
+config GENERIC_RAW_MEMCPY_IO
 	bool
 	default y
 


