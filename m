Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263100AbUHQGNZ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263100AbUHQGNZ (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 17 Aug 2004 02:13:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263204AbUHQGNZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 17 Aug 2004 02:13:25 -0400
Received: from imap.gmx.net ([213.165.64.20]:226 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id S263100AbUHQGNE (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 17 Aug 2004 02:13:04 -0400
X-Authenticated: #5874409
Message-ID: <4121A211.8080902@gmx.net>
Date: Tue, 17 Aug 2004 08:13:37 +0200
From: Jens Maurer <Jens.Maurer@gmx.net>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.4) Gecko/20030624 Netscape/7.1
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Linux Kernel <linux-kernel@vger.kernel.org>
Subject: [PATCH] Use x86 SSE instructions for clear_page, copy_page
Content-Type: multipart/mixed;
 boundary="------------090508040407040606040500"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------090508040407040606040500
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit

The attached patch (against kernel 2.6.8.1) enables using SSE
instructions for copy_page and clear_page.

A user-space test on my Pentium III 850 MHz shows a 3x speedup for
clear_page (compared to the default "rep stosl"), and a 50% speedup
for copy_page (compared to the default "rep movsl").  For a Pentium-4,
the speedup is about 50% in both the clear_page and copy_page cases.

The attached (admittedly perverse) user-space program
"malloc-fork-load.c" takes 30 sec with stock kernel 2.6.8.1, which
improves to about 15 sec when running a kernel with the attached
kernel patch applied.

Notes: I cannot replace clear_page and copy_page with their SSE
equivalents at compile-time, because clear_page is used before the CPU
is fully set up (in particular the CR4.OSFXSR bit, without which SSE
instructions kill the kernel with an invalid operand exception).  The
current function-pointer based approach could be extended to include
the current MMX-based improvements for AMD CPUs as well.  If a
function pointer is considered too wasteful for a boot-time
initialization issue, a "memcpy" approach similar to the
"apply_alternatives()" code modifications would be possible.

Please test.

Jens Maurer


diff -urN -X /home/jmaurer/Linux/excludes-for-diff.txt linux-2.6.8.1.orig/arch/i386/Kconfig linux-2.6.8.1/arch/i386/Kconfig
--- linux-2.6.8.1.orig/arch/i386/Kconfig	Mon Aug 16 22:02:03 2004
+++ linux-2.6.8.1/arch/i386/Kconfig	Mon Aug 16 21:56:09 2004
@@ -419,6 +419,11 @@
  	depends on MCYRIXIII || MK7
  	default y

+config X86_USE_SSE
+	bool
+	depends on MPENTIUMIII || MPENTIUMM || MPENTIUM4
+	default y
+
  config X86_OOSTORE
  	bool
  	depends on (MWINCHIP3D || MWINCHIP2 || MWINCHIPC6) && MTRR
diff -urN -X /home/jmaurer/Linux/excludes-for-diff.txt linux-2.6.8.1.orig/arch/i386/kernel/setup.c linux-2.6.8.1/arch/i386/kernel/setup.c
--- linux-2.6.8.1.orig/arch/i386/kernel/setup.c	Mon Aug 16 22:02:04 2004
+++ linux-2.6.8.1/arch/i386/kernel/setup.c	Mon Aug 16 21:56:14 2004
@@ -1241,13 +1241,46 @@
  }

  static int no_replacement __initdata = 0;
-
+
+#ifdef CONFIG_X86_USE_SSE
+
+static void std_clear_page(void *page)
+{
+	int d0, d1;
+	asm volatile("cld\n\t"
+		     "rep; stosl"
+		     : "=&c" (d0), "=&D" (d1)
+		     : "a" (0), "0" (PAGE_SIZE/4), "1" (page)
+		     : "memory");
+}
+
+static void std_copy_page(void *to, void *from)
+{
+	int d0, d1, d2;
+	asm volatile("cld\n\t"
+		     "rep; movsl"
+		     : "=&c" (d0), "=&D" (d1), "=&S" (d2)
+		     : "0" (PAGE_SIZE/4), "1" (to), "2" (from)
+		     : "memory");
+}
+
+void (*__sse_clear_page)(void *) = &std_clear_page;
+void (*__sse_copy_page)(void *, void *) = &std_copy_page;
+EXPORT_SYMBOL(__sse_clear_page);
+EXPORT_SYMBOL(__sse_copy_page);
+#endif
+
  void __init alternative_instructions(void)
  {
  	extern struct alt_instr __alt_instructions[], __alt_instructions_end[];
+	extern void activate_sse_replacements(void);
  	if (no_replacement)
  		return;
  	apply_alternatives(__alt_instructions, __alt_instructions_end);
+
+#ifdef CONFIG_X86_USE_SSE
+	activate_sse_replacements();
+#endif
  }

  static int __init noreplacement_setup(char *s)
diff -urN -X /home/jmaurer/Linux/excludes-for-diff.txt linux-2.6.8.1.orig/arch/i386/lib/Makefile linux-2.6.8.1/arch/i386/lib/Makefile
--- linux-2.6.8.1.orig/arch/i386/lib/Makefile	Mon Aug 16 22:02:05 2004
+++ linux-2.6.8.1/arch/i386/lib/Makefile	Mon Aug 16 21:56:15 2004
@@ -7,4 +7,5 @@
  	bitops.o

  lib-$(CONFIG_X86_USE_3DNOW) += mmx.o
+lib-$(CONFIG_X86_USE_SSE) += sse.o
  lib-$(CONFIG_HAVE_DEC_LOCK) += dec_and_lock.o
diff -urN -X /home/jmaurer/Linux/excludes-for-diff.txt linux-2.6.8.1.orig/arch/i386/lib/sse.c linux-2.6.8.1/arch/i386/lib/sse.c
--- linux-2.6.8.1.orig/arch/i386/lib/sse.c	Thu Jan  1 01:00:00 1970
+++ linux-2.6.8.1/arch/i386/lib/sse.c	Mon Aug  9 00:57:23 2004
@@ -0,0 +1,115 @@
+/*
+ * linux/arch/i386/lib/sse.c
+ *
+ * Copyright 2004 Jens Maurer
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License as published by
+ * the Free Software Foundation; either version 2 of the License, or
+ * (at your option) any later version.
+ *
+ * This program is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ * GNU General Public License for more details.
+ *
+ * You should have received a copy of the GNU General Public License
+ * along with this program; if not, write to the Free Software
+ * Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA  02111-1307  USA
+ *
+ * Send feedback to <Jens.Maurer@gmx.net>
+ */
+
+#include <linux/config.h>
+#include <linux/module.h>
+#include <linux/types.h>
+#include <linux/kernel.h>
+#include <linux/preempt.h>
+#include <asm/page.h>
+#include <asm/system.h>
+
+
+/*
+ *	SSE library helper functions
+ */
+
+#define SSE_START(cr0) do { \
+	preempt_disable(); \
+	cr0 = read_cr0(); \
+	clts(); \
+	} while(0)
+
+
+#define SSE_END(cr0) do { \
+	write_cr0(cr0); \
+	preempt_enable(); \
+	} while(0)
+
+static void sse_clear_page(void * page)
+{
+	unsigned char xmm_save[16];
+	unsigned int cr0;
+	int i;
+
+	SSE_START(cr0);
+	asm volatile("movups %%xmm0, (%0)\n\t"
+		     "xorps %%xmm0, %%xmm0"
+		     : : "r" (xmm_save));
+	for(i = 0; i < PAGE_SIZE/16/4; i++) {
+		asm volatile("movntps %%xmm0,   (%0)\n\t"
+			     "movntps %%xmm0, 16(%0)\n\t"
+			     "movntps %%xmm0, 32(%0)\n\t"
+			     "movntps %%xmm0, 48(%0)"
+			     : : "r"(page) : "memory");
+		page += 16*4;
+	}
+	asm volatile("sfence\n\t"
+		     "movups (%0), %%xmm0"
+		     : : "r" (xmm_save) : "memory");
+	SSE_END(cr0);
+}
+
+static void sse_copy_page(void *to, void *from)
+{
+	unsigned char tmp[16*4+15] __attribute__((aligned(16)));
+	/* gcc 3.4.x does not honor alignment requests for stack variables */
+	unsigned char * xmm_save =
+		(unsigned char *)ALIGN((unsigned long)tmp, 16);
+	unsigned int cr0;
+	int i;
+
+	SSE_START(cr0);
+	asm volatile("movaps %%xmm0,   (%0)\n\t"
+		     "movaps %%xmm1, 16(%0)\n\t"
+		     "movaps %%xmm2, 32(%0)\n\t"
+		     "movaps %%xmm3, 48(%0)"
+		     : : "r" (xmm_save));
+	for(i = 0; i < 4096/16/4; i++) {
+		asm volatile("movaps   (%0), %%xmm0\n\t"
+			     "movaps 16(%0), %%xmm1\n\t"
+			     "movaps 32(%0), %%xmm2\n\t"
+			     "movaps 48(%0), %%xmm3\n\t"
+			     "movntps %%xmm0,   (%1)\n\t"
+			     "movntps %%xmm1, 16(%1)\n\t"
+			     "movntps %%xmm2, 32(%1)\n\t"
+			     "movntps %%xmm3, 48(%1)"
+			     : : "r" (from), "r" (to) : "memory");
+		from += 16*4;
+		to += 16*4;
+	}
+	asm volatile("sfence\n"
+		     "movaps   (%0), %%xmm0\n\t"
+		     "movaps 16(%0), %%xmm1\n\t"
+		     "movaps 32(%0), %%xmm2\n\t"
+		     "movaps 48(%0), %%xmm3"
+		     : : "r" (xmm_save) : "memory");
+	SSE_END(cr0);
+}
+
+void activate_sse_replacements(void)
+{
+	if(cpu_has_xmm && (mmu_cr4_features & X86_CR4_OSFXSR)) {
+		__sse_clear_page = &sse_clear_page;
+		__sse_copy_page = &sse_copy_page;
+	}
+}
diff -urN -X /home/jmaurer/Linux/excludes-for-diff.txt linux-2.6.8.1.orig/include/asm-i386/page.h linux-2.6.8.1/include/asm-i386/page.h
--- linux-2.6.8.1.orig/include/asm-i386/page.h	Mon Aug 16 22:04:14 2004
+++ linux-2.6.8.1/include/asm-i386/page.h	Mon Aug 16 21:58:35 2004
@@ -21,6 +21,15 @@
  #define clear_page(page)	mmx_clear_page((void *)(page))
  #define copy_page(to,from)	mmx_copy_page(to,from)

+#elif defined(CONFIG_X86_USE_SSE)
+
+#include <asm/sse.h>
+
+extern void (*__sse_clear_page)(void *);
+extern void (*__sse_copy_page)(void *, void*);
+#define clear_page(page)	(*__sse_clear_page)(page)
+#define copy_page(to,from)	(*__sse_copy_page)(to,from)
+
  #else

  /*
diff -urN -X /home/jmaurer/Linux/excludes-for-diff.txt linux-2.6.8.1.orig/include/asm-i386/sse.h linux-2.6.8.1/include/asm-i386/sse.h
--- linux-2.6.8.1.orig/include/asm-i386/sse.h	Thu Jan  1 01:00:00 1970
+++ linux-2.6.8.1/include/asm-i386/sse.h	Sun Aug  8 22:21:36 2004
@@ -0,0 +1,34 @@
+/*
+ * linux/include/asm-i386/sse.h
+ *
+ * Copyright 2004 Jens Maurer
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License as published by
+ * the Free Software Foundation; either version 2 of the License, or
+ * (at your option) any later version.
+ *
+ * This program is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ * GNU General Public License for more details.
+ *
+ * You should have received a copy of the GNU General Public License
+ * along with this program; if not, write to the Free Software
+ * Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA  02111-1307  USA
+ *
+ */
+
+#ifndef _ASM_SSE_H
+#define _ASM_SSE_H
+
+/*
+ *	SSE helper operations
+ */
+
+#include <linux/types.h>
+
+extern void sse_clear_page(void *page);
+extern void sse_copy_page(void *to, void *from);
+
+#endif

--------------090508040407040606040500
Content-Type: text/plain;
 name="malloc-fork-load.c"
Content-Transfer-Encoding: base64
Content-Disposition: inline;
 filename="malloc-fork-load.c"

CiNpbmNsdWRlIDxzdGRsaWIuaD4KI2luY2x1ZGUgPHVuaXN0ZC5oPgojaW5jbHVkZSA8c3lz
L21tYW4uaD4KCgojZGVmaW5lIE4gMjAyNDAKI2RlZmluZSBTSVpFIDQwOTYKCmludCBtYWlu
KCkKewogIGludCBrOwogIGZvcihrID0gMDsgayA8IDEwOyBrKyspIHsKICAgIGludCBpID0g
MDsKICAgIGludCBwaWQ7CiAgICB1bnNpZ25lZCBjaGFyICptZW0gPSBtbWFwKDAsIE4qU0la
RSwgUFJPVF9SRUFEfFBST1RfV1JJVEUsCiAgCQkJTUFQX1BSSVZBVEV8TUFQX0FOT05ZTU9V
UywgMCwgMCk7CiAgICBpZihtZW0gPT0gTUFQX0ZBSUxFRCkKICAgICAgcGVycm9yKCJtbWFw
Iik7CiAgICBwcmludGYoInBhZ2VzaXplOiAlZFxuIiwgZ2V0cGFnZXNpemUoKSk7CiAgICBm
b3IoaSA9IDA7IGkgPCBOOyBpKyspCiAgICAgIG1lbVtpKlNJWkVdID0gaSoxMDAwMDAwMDA3
dWw7CiAgICBwcmludGYoInBhZ2VzIGFsbG9jYXRlZFxuIik7CiAgICBwaWQgPSBmb3JrKCk7
CiAgICBpZihwaWQgPT0gMCkgewogICAgICAvKiBjaGlsZCAqLwogICAgICBmb3IoaSA9IDA7
IGkgPCBOOyBpKyspCiAgICAgICAgbWVtW2kqU0laRSsxXSA9IGk7ICAgICAgICAgIC8qIGZv
cmNlIGNvcHkgKi8KICAgICAgcHJpbnRmKCJjb3B5IGNvbXBsZXRlXG4iKTsKICAgICAgZXhp
dCgwKTsKICAgIH0gZWxzZSBpZihwaWQgPT0gLTEpIHsKICAgICAgcGVycm9yKCJmb3JrIik7
CiAgICB9IGVsc2UgewogICAgICAvKiBwYXJlbnQgKi8KICAgICAgd2FpdHBpZChwaWQsIE5V
TEwsIDApOwogICAgfQogICAgbXVubWFwKG1lbSwgTipTSVpFKTsKICB9Cn0K
--------------090508040407040606040500--

