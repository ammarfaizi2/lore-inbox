Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932235AbWAJQ4N@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932235AbWAJQ4N (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 10 Jan 2006 11:56:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932244AbWAJQ4M
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 10 Jan 2006 11:56:12 -0500
Received: from mx.pathscale.com ([64.160.42.68]:52377 "EHLO mx.pathscale.com")
	by vger.kernel.org with ESMTP id S932235AbWAJQ4L (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 10 Jan 2006 11:56:11 -0500
Subject: [PATCH] [RFC] Generic 32-bit MMIO copy, out of line
From: "Bryan O'Sullivan" <bos@pathscale.com>
To: Andrew Morton <akpm@osdl.org>, Roland Dreier <rdreier@cisco.com>
Cc: sam@ravnborg.org, linux-kernel@vger.kernel.org
In-Reply-To: <1136909276.32183.28.camel@serpentine.pathscale.com>
References: <patchbomb.1136579193@eng-12.pathscale.com>
	 <d286502c3b3cd6bcec7b.1136579194@eng-12.pathscale.com>
	 <20060110011844.7a4a1f90.akpm@osdl.org>  <adaslrw3zfu.fsf@cisco.com>
	 <1136909276.32183.28.camel@serpentine.pathscale.com>
Content-Type: text/plain
Organization: PathScale, Inc.
Date: Tue, 10 Jan 2006 08:56:05 -0800
Message-Id: <1136912166.32183.45.camel@serpentine.pathscale.com>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-2.fc4) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2006-01-10 at 08:07 -0800, Bryan O'Sullivan wrote:

> The only problem with this is that it's an unusual approach, so I don't
> have any obvious examples to copy.

It was easy to hack up a quick patch to try the idea out.

This single-arch patch is for review purposes only; I compile-tested it
on i386, and it has no obvious problems at compile- or link-time.

If it looks OK, I have a complete patch set that affects all arches.
The parts that affect arch/*/lib/Makefile and include/asm-*/io.h are
essentially identical in all cases.

	<b

diff -r 48616306e7bd include/asm-generic/raw_memcpy_toio32.h
--- /dev/null	Thu Jan  1 00:00:00 1970 +0000
+++ b/include/asm-generic/raw_memcpy_toio32.h	Tue Jan 10 08:44:30 2006 -0800
@@ -0,0 +1,16 @@
+#ifndef _ASM_GENERIC_RAW_MEMCPYTOIO32_H
+#define _ASM_GENERIC_RAW_MEMCPYTOIO32_H
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
+#endif // _ASM_GENERIC_RAW_MEMCPYTOIO32_H
--- /dev/null	Thu Jan  1 00:00:00 1970 +0000
+++ b/lib/raw_memcpy_toio32.c	Tue Jan 10 08:44:30 2006 -0800
@@ -0,0 +1,13 @@
+#include <linux/types.h>
+#include <asm/io.h>
+#include <asm-generic/raw_memcpy_toio32.h>
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
--- a/arch/i386/lib/Makefile	Tue Jan 10 08:44:35 2006 -0800
+++ b/arch/i386/lib/Makefile	Tue Jan 10 08:44:44 2006 -0800
@@ -5,5 +5,6 @@
 
 lib-y = checksum.o delay.o usercopy.o getuser.o putuser.o memcpy.o strstr.o \
 	bitops.o
+lib-y += ../../../lib/raw_memcpy_toio32.o
 
 lib-$(CONFIG_X86_USE_3DNOW) += mmx.o
--- a/include/asm-i386/io.h	Tue Jan 10 08:44:35 2006 -0800
+++ b/include/asm-i386/io.h	Tue Jan 10 08:44:44 2006 -0800
@@ -203,6 +203,8 @@
 {
 	__memcpy((void __force *) dst, src, count);
 }
+
+#include <asm-generic/raw_memcpy_toio32.h>
 
 /*
  * ISA space is 'always mapped' on a typical x86 system, no need to


