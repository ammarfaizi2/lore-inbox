Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262315AbTH0WFq (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 27 Aug 2003 18:05:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262342AbTH0WFq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 27 Aug 2003 18:05:46 -0400
Received: from [62.241.33.80] ([62.241.33.80]:8198 "EHLO
	mx00.linux-systeme.com") by vger.kernel.org with ESMTP
	id S262315AbTH0WFh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 27 Aug 2003 18:05:37 -0400
From: Marc-Christian Petersen <m.c.p@wolk-project.de>
Organization: Working Overloaded Linux Kernel
To: James Morris <jmorris@intercode.com.au>, Tom Vier <tmv@comcast.net>
Subject: Re: cryptoapi doesn't build
Date: Thu, 28 Aug 2003 00:03:08 +0200
User-Agent: KMail/1.5.3
Cc: linux-kernel@vger.kernel.org, Marcelo Tosatti <marcelo@conectiva.com.br>
References: <Mutt.LNX.4.44.0308262023030.4908-100000@excalibur.intercode.com.au>
In-Reply-To: <Mutt.LNX.4.44.0308262023030.4908-100000@excalibur.intercode.com.au>
MIME-Version: 1.0
Content-Type: Multipart/Mixed;
  boundary="Boundary-00=_cqST/IFiNvU9O33"
Message-Id: <200308280003.08872.m.c.p@wolk-project.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--Boundary-00=_cqST/IFiNvU9O33
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

On Tuesday 26 August 2003 12:23, James Morris wrote:

Hi James, Tom,

> > In file included from api.c:21:
> > internal.h:19:28: asm/kmap_types.h: No such file or directory
> > In file included from api.c:21:
> > internal.h:24: error: return type is an incomplete type
> > internal.h: In function rypto_kmap_type':
> > internal.h:25: error: invalid use of undefined type num km_type'
> > internal.h:25: warning: eturn' with a value, in function returning void
> > iirc, 2.4.21 had the same problem.
> What architecture did you see this on?

the problem is clear. crypto/internal.h includes asm/kmap_types.h, but alpha 
does not have this.

I've sent a patch to fix this up and also cleanup the kmap_types.h mess around 
.22-pre7 time ... Here it is again.

Marcelo, please apply.

ciao, Marc

--Boundary-00=_cqST/IFiNvU9O33
Content-Type: text/x-diff;
  charset="iso-8859-1";
  name="2.4-kmap-types-cleanup.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename="2.4-kmap-types-cleanup.patch"

diff -Naurp a/crypto/internal.h b/crypto/internal.h
--- a/crypto/internal.h	2003-07-19 14:09:06.000000000 +0200
+++ b/crypto/internal.h	2003-07-19 14:18:58.000000000 +0200
@@ -14,9 +14,9 @@
 #include <linux/mm.h>
 #include <linux/highmem.h>
 #include <linux/init.h>
+#include <linux/kmap_types.h>
 #include <asm/hardirq.h>
 #include <asm/softirq.h>
-#include <asm/kmap_types.h>
 
 extern enum km_type crypto_km_types[];
 
diff -Naurp a/include/asm-i386/fixmap.h b/include/asm-i386/fixmap.h
--- a/include/asm-i386/fixmap.h	2003-07-19 14:09:31.000000000 +0200
+++ b/include/asm-i386/fixmap.h	2003-07-19 14:18:58.000000000 +0200
@@ -20,7 +20,7 @@
 #include <asm/page.h>
 #ifdef CONFIG_HIGHMEM
 #include <linux/threads.h>
-#include <asm/kmap_types.h>
+#include <linux/kmap_types.h>
 #endif
 
 /*
diff -Naurp a/include/asm-i386/highmem.h b/include/asm-i386/highmem.h
--- a/include/asm-i386/highmem.h	2003-07-15 10:28:54.000000000 +0200
+++ b/include/asm-i386/highmem.h	2003-07-19 14:18:58.000000000 +0200
@@ -23,7 +23,6 @@
 #include <linux/config.h>
 #include <linux/init.h>
 #include <linux/interrupt.h>
-#include <asm/kmap_types.h>
 #include <asm/pgtable.h>
 
 #ifdef CONFIG_DEBUG_HIGHMEM
diff -Naurp a/include/asm-i386/kmap_types.h b/include/asm-i386/kmap_types.h
--- a/include/asm-i386/kmap_types.h	2003-07-19 14:09:31.000000000 +0200
+++ b/include/asm-i386/kmap_types.h	1970-01-01 01:00:00.000000000 +0100
@@ -1,16 +0,0 @@
-#ifndef _ASM_KMAP_TYPES_H
-#define _ASM_KMAP_TYPES_H
-
-enum km_type {
-	KM_BOUNCE_READ,
-	KM_SKB_SUNRPC_DATA,
-	KM_SKB_DATA_SOFTIRQ,
-	KM_USER0,
-	KM_USER1,
-	KM_BH_IRQ,
-	KM_SOFTIRQ0,
-	KM_SOFTIRQ1,
-	KM_TYPE_NR
-};
-
-#endif
diff -Naurp a/include/asm-m68k/kmap_types.h b/include/asm-m68k/kmap_types.h
--- a/include/asm-m68k/kmap_types.h	2003-07-19 14:09:33.000000000 +0200
+++ b/include/asm-m68k/kmap_types.h	1970-01-01 01:00:00.000000000 +0100
@@ -1,18 +0,0 @@
-#ifdef __KERNEL__
-#ifndef _ASM_KMAP_TYPES_H
-#define _ASM_KMAP_TYPES_H
-
-enum km_type {
-	KM_BOUNCE_READ,
-	KM_SKB_SUNRPC_DATA,
-	KM_SKB_DATA_SOFTIRQ,
-	KM_USER0,
-	KM_USER1,
-	KM_BH_IRQ,
-	KM_SOFTIRQ0,
-	KM_SOFTIRQ1,
-	KM_TYPE_NR
-};
-
-#endif
-#endif /* __KERNEL__ */
diff -Naurp a/include/asm-mips/fixmap.h b/include/asm-mips/fixmap.h
--- a/include/asm-mips/fixmap.h	2002-09-27 23:26:03.000000000 +0200
+++ b/include/asm-mips/fixmap.h	2003-07-19 14:18:58.000000000 +0200
@@ -18,7 +18,7 @@
 #include <asm/page.h>
 #ifdef CONFIG_HIGHMEM
 #include <linux/threads.h>
-#include <asm/kmap_types.h>
+#include <linux/kmap_types.h>
 #endif
 
 /*
diff -Naurp a/include/asm-mips/highmem.h b/include/asm-mips/highmem.h
--- a/include/asm-mips/highmem.h	2002-12-18 01:03:59.000000000 +0100
+++ b/include/asm-mips/highmem.h	2003-07-19 14:18:58.000000000 +0200
@@ -22,7 +22,6 @@
 
 #include <linux/init.h>
 #include <linux/interrupt.h>
-#include <asm/kmap_types.h>
 #include <asm/pgtable.h>
 
 /* undef for production */
diff -Naurp a/include/asm-mips/kmap_types.h b/include/asm-mips/kmap_types.h
--- a/include/asm-mips/kmap_types.h	2002-12-18 01:03:59.000000000 +0100
+++ b/include/asm-mips/kmap_types.h	1970-01-01 01:00:00.000000000 +0100
@@ -1,16 +0,0 @@
-#ifndef _ASM_KMAP_TYPES_H
-#define _ASM_KMAP_TYPES_H
-
-enum km_type {
-	KM_BOUNCE_READ,
-	KM_SKB_SUNRPC_DATA,
-	KM_SKB_DATA_SOFTIRQ,
-	KM_USER0,
-	KM_USER1,
-	KM_BH_IRQ,
-	KM_SOFTIRQ0,
-	KM_SOFTIRQ1,
-	KM_TYPE_NR
-};
-
-#endif
diff -Naurp a/include/asm-ppc/highmem.h b/include/asm-ppc/highmem.h
--- a/include/asm-ppc/highmem.h	2003-07-19 14:09:33.000000000 +0200
+++ b/include/asm-ppc/highmem.h	2003-07-19 14:18:58.000000000 +0200
@@ -24,7 +24,7 @@
 
 #include <linux/init.h>
 #include <linux/interrupt.h>
-#include <asm/kmap_types.h>
+#include <linux/kmap_types.h>
 #include <asm/pgtable.h>
 
 /* undef for production */
diff -Naurp a/include/asm-ppc/kmap_types.h b/include/asm-ppc/kmap_types.h
--- a/include/asm-ppc/kmap_types.h	2003-07-19 14:09:33.000000000 +0200
+++ b/include/asm-ppc/kmap_types.h	1970-01-01 01:00:00.000000000 +0100
@@ -1,18 +0,0 @@
-#ifdef __KERNEL__
-#ifndef _ASM_KMAP_TYPES_H
-#define _ASM_KMAP_TYPES_H
-
-enum km_type {
-	KM_BOUNCE_READ,
-	KM_SKB_SUNRPC_DATA,
-	KM_SKB_DATA_SOFTIRQ,
-	KM_USER0,
-	KM_USER1,
-	KM_BH_IRQ,
-	KM_SOFTIRQ0,
-	KM_SOFTIRQ1,
-	KM_TYPE_NR
-};
-
-#endif
-#endif /* __KERNEL__ */
diff -Naurp a/include/asm-ppc64/kmap_types.h b/include/asm-ppc64/kmap_types.h
--- a/include/asm-ppc64/kmap_types.h	2003-07-19 14:09:35.000000000 +0200
+++ b/include/asm-ppc64/kmap_types.h	1970-01-01 01:00:00.000000000 +0100
@@ -1,23 +0,0 @@
-#ifdef __KERNEL__
-#ifndef _ASM_KMAP_TYPES_H
-#define _ASM_KMAP_TYPES_H
-
-enum km_type {
-	KM_BOUNCE_READ,
-	KM_SKB_SUNRPC_DATA,
-	KM_SKB_DATA_SOFTIRQ,
-	KM_USER0,
-	KM_USER1,
-	KM_BIO_SRC_IRQ,
-	KM_BIO_DST_IRQ,
-	KM_PTE0,
-	KM_PTE1,
-	KM_IRQ0,
-	KM_IRQ1,
-	KM_SOFTIRQ0,
-	KM_SOFTIRQ1,	
-	KM_TYPE_NR
-};
-
-#endif
-#endif /* __KERNEL__ */
diff -Naurp a/include/asm-sparc/highmem.h b/include/asm-sparc/highmem.h
--- a/include/asm-sparc/highmem.h	2003-07-15 10:28:56.000000000 +0200
+++ b/include/asm-sparc/highmem.h	2003-07-19 14:18:58.000000000 +0200
@@ -21,7 +21,7 @@
 #ifdef __KERNEL__
 
 #include <linux/interrupt.h>
-#include <asm/kmap_types.h>
+#include <linux/kmap_types.h>
 
 /* undef for production */
 #define HIGHMEM_DEBUG 1
diff -Naurp a/include/asm-sparc/kmap_types.h b/include/asm-sparc/kmap_types.h
--- a/include/asm-sparc/kmap_types.h	2003-07-19 14:09:37.000000000 +0200
+++ b/include/asm-sparc/kmap_types.h	1970-01-01 01:00:00.000000000 +0100
@@ -1,16 +0,0 @@
-#ifndef _ASM_KMAP_TYPES_H
-#define _ASM_KMAP_TYPES_H
-
-enum km_type {
-	KM_BOUNCE_READ,
-	KM_SKB_SUNRPC_DATA,
-	KM_SKB_DATA_SOFTIRQ,
-	KM_USER0,
-	KM_USER1,
-	KM_BH_IRQ,
-	KM_SOFTIRQ0,
-	KM_SOFTIRQ1,
-	KM_TYPE_NR
-};
-
-#endif
diff -Naurp a/include/asm-sparc64/kmap_types.h b/include/asm-sparc64/kmap_types.h
--- a/include/asm-sparc64/kmap_types.h	2003-07-19 14:09:37.000000000 +0200
+++ b/include/asm-sparc64/kmap_types.h	1970-01-01 01:00:00.000000000 +0100
@@ -1,20 +0,0 @@
-#ifndef _ASM_KMAP_TYPES_H
-#define _ASM_KMAP_TYPES_H
-
-/* Dummy header just to define km_type.  None of this
- * is actually used on sparc64.  -DaveM
- */
-
-enum km_type {
-	KM_BOUNCE_READ,
-	KM_SKB_SUNRPC_DATA,
-	KM_SKB_DATA_SOFTIRQ,
-	KM_USER0,
-	KM_USER1,
-	KM_BH_IRQ,
-	KM_SOFTIRQ0,
-	KM_SOFTIRQ1,
-	KM_TYPE_NR
-};
-
-#endif
diff -Naurp a/include/asm-x86_64/kmap_types.h b/include/asm-x86_64/kmap_types.h
--- a/include/asm-x86_64/kmap_types.h	2003-07-19 14:09:37.000000000 +0200
+++ b/include/asm-x86_64/kmap_types.h	1970-01-01 01:00:00.000000000 +0100
@@ -1,15 +0,0 @@
-#ifndef _ASM_KMAP_TYPES_H
-#define _ASM_KMAP_TYPES_H
-
-enum km_type {
-	KM_BOUNCE_READ,
-	KM_SKB_DATA,
-	KM_SKB_DATA_SOFTIRQ,
-	KM_USER0,
-	KM_USER1,
-	KM_SOFTIRQ0,
-	KM_SOFTIRQ1,
-	KM_TYPE_NR
-};
-
-#endif
diff -Naurp a/include/linux/highmem.h b/include/linux/highmem.h
--- a/include/linux/highmem.h	2003-07-19 14:09:37.000000000 +0200
+++ b/include/linux/highmem.h	2003-07-19 14:18:58.000000000 +0200
@@ -2,6 +2,7 @@
 #define _LINUX_HIGHMEM_H
 
 #include <linux/config.h>
+#include <linux/kmap_types.h>
 #include <asm/pgalloc.h>
 
 #ifdef CONFIG_HIGHMEM
diff -Naurp a/include/linux/kmap_types.h b/include/linux/kmap_types.h
--- a/include/linux/kmap_types.h	1970-01-01 01:00:00.000000000 +0100
+++ b/include/linux/kmap_types.h	2003-07-19 14:18:58.000000000 +0200
@@ -0,0 +1,16 @@
+#ifndef _LINUX_KMAP_TYPES_H
+#define _LINUX_KMAP_TYPES_H
+
+enum km_type {
+	KM_BOUNCE_READ,
+	KM_SKB_SUNRPC_DATA,
+	KM_SKB_DATA_SOFTIRQ,
+	KM_USER0,
+	KM_USER1,
+	KM_BH_IRQ,
+	KM_SOFTIRQ0,
+	KM_SOFTIRQ1,
+	KM_TYPE_NR
+};
+
+#endif

--Boundary-00=_cqST/IFiNvU9O33--

