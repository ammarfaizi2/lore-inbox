Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262852AbUKXVMy@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262852AbUKXVMy (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 24 Nov 2004 16:12:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262853AbUKXVMy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 24 Nov 2004 16:12:54 -0500
Received: from pD9562327.dip.t-dialin.net ([217.86.35.39]:60716 "EHLO
	mail.linux-mips.net") by vger.kernel.org with ESMTP id S262852AbUKXVMr
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 24 Nov 2004 16:12:47 -0500
Date: Wed, 24 Nov 2004 18:51:55 +0100
From: Ralf Baechle <ralf@linux-mips.org>
To: Yoichi Yuasa <yuasa@hh.iij4u.or.jp>
Cc: Andrew Morton <akpm@osdl.org>, linux-kernel <linux-kernel@vger.kernel.org>,
       linux-mips@linux-mips.org
Subject: Re: [PATCH 2.6.10-rc2-mm3] mips: fixed memory mapped I/O of IDE on MIPS
Message-ID: <20041124175155.GE21039@linux-mips.org>
References: <20041124101809.77a1d877.yuasa@hh.iij4u.or.jp>
Mime-Version: 1.0
Content-Type: text/plain; charset=unknown-8bit
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20041124101809.77a1d877.yuasa@hh.iij4u.or.jp>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 24, 2004 at 10:18:09AM +0900, Yoichi Yuasa wrote:

> This patch fixes memory mapped I/O of IDE on MIPS.
> 
> The MMIO of IDE on MIPS, the read*()/write*() are correct methods for it.
>  
> Signed-off-by: Yoichi Yuasa <yuasa@hh.iij4u.or.jp>
> 
> diff -urN -X dontdiff a-orig/include/asm-mips/ide.h a/include/asm-mips/ide.h
> --- a-orig/include/asm-mips/ide.h	Mon Oct 11 11:58:23 2004
> +++ a/include/asm-mips/ide.h	Thu Oct 14 12:19:27 2004
> @@ -14,11 +14,7 @@
>  #ifdef __KERNEL__
>  
>  #include <ide.h>
> -
> -#define __ide_mm_insw   ide_insw
> -#define __ide_mm_insl   ide_insl
> -#define __ide_mm_outsw  ide_outsw
> -#define __ide_mm_outsl  ide_outsl
> +#include <asm-generic/ide_iops.h>

I wish things were that easy.  About once a week I'm mailed a patch to
"fix¨ MIPS IDE.  Fix for a particular platform breaking all others. Just
to maximize the fun factor on MIPS we have good old IDE attached via
MMIO, I/O ports (which on MIPS of course is just MMIO in disguise),
with the same and with different byte switching requirements that for
any devices in the system.  And then of course also completly crazy stuff.
Technically a bloody mess - and the software support no better.

End of rant.

Checkout rev. 1.11 of include/asm-mips/ide.h in CVS to see some of the
uglyness that was needed to get IDE to sort of work in the past.  Don't
look to close or your stomach will oops ;-)

I'm going to put the below patch into CVS; it will allow individual
platforms to override things will all the mad stuff they deem necessary.

  Ralf

Index: include/asm-mips/ide.h
===================================================================
RCS file: /home/cvs/linux/include/asm-mips/ide.h,v
retrieving revision 1.24
diff -u -r1.24 ide.h
--- include/asm-mips/ide.h	18 Nov 2003 01:17:47 -0000	1.24
+++ include/asm-mips/ide.h	24 Nov 2004 17:49:00 -0000
@@ -4,22 +4,10 @@
  * for more details.
  *
  * This file contains the MIPS architecture specific IDE code.
- *
- * Copyright (C) 1994-1996  Linus Torvalds & authors
  */
-
 #ifndef __ASM_IDE_H
 #define __ASM_IDE_H
 
-#ifdef __KERNEL__
-
 #include <ide.h>
 
-#define __ide_mm_insw   ide_insw
-#define __ide_mm_insl   ide_insl
-#define __ide_mm_outsw  ide_outsw
-#define __ide_mm_outsl  ide_outsl
-
-#endif /* __KERNEL__ */
-
 #endif /* __ASM_IDE_H */
Index: include/asm-mips/mach-generic/ide.h
===================================================================
RCS file: /home/cvs/linux/include/asm-mips/mach-generic/ide.h,v
retrieving revision 1.4
diff -u -r1.4 ide.h
--- include/asm-mips/mach-generic/ide.h	9 Jun 2004 14:12:13 -0000	1.4
+++ include/asm-mips/mach-generic/ide.h	24 Nov 2004 17:49:00 -0000
@@ -3,13 +3,18 @@
  * License.  See the file "COPYING" in the main directory of this archive
  * for more details.
  *
- * IDE routines for typical pc-like legacy IDE configurations.
+ * Copyright (C) 1994-1996  Linus Torvalds & authors
  *
- * Copyright (C) 1998, 1999, 2001, 2003 by Ralf Baechle
+ * Copied from i386; many of the especially older MIPS or ISA-based platforms
+ * are basically identical.  Using this file probably implies i8259 PIC
+ * support in a system but the very least interrupt numbers 0 - 15 need to
+ * be put aside for legacy devices.
  */
 #ifndef __ASM_MACH_GENERIC_IDE_H
 #define __ASM_MACH_GENERIC_IDE_H
 
+#ifdef __KERNEL__
+
 #include <linux/config.h>
 
 #ifndef MAX_HWIFS
@@ -22,7 +27,7 @@
 
 #define IDE_ARCH_OBSOLETE_DEFAULTS
 
-static inline int ide_default_irq(unsigned long base)
+static __inline__ int ide_default_irq(unsigned long base)
 {
 	switch (base) {
 		case 0x1f0: return 14;
@@ -36,11 +41,11 @@
 	}
 }
 
-static inline unsigned long ide_default_io_base(int index)
+static __inline__ unsigned long ide_default_io_base(int index)
 {
 	switch (index) {
-		case 0: return 0x1f0;
-		case 1: return 0x170;
+		case 0:	return 0x1f0;
+		case 1:	return 0x170;
 		case 2: return 0x1e8;
 		case 3: return 0x168;
 		case 4: return 0x1e0;
@@ -59,4 +64,8 @@
 #define ide_init_default_irq(base)	ide_default_irq(base)
 #endif
 
+#include <asm-generic/ide_iops.h>
+
+#endif /* __KERNEL__ */
+
 #endif /* __ASM_MACH_GENERIC_IDE_H */
