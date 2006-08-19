Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751571AbWHSWUB@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751571AbWHSWUB (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 19 Aug 2006 18:20:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751577AbWHSWUB
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 19 Aug 2006 18:20:01 -0400
Received: from aun.it.uu.se ([130.238.12.36]:9920 "EHLO aun.it.uu.se")
	by vger.kernel.org with ESMTP id S1751559AbWHSWUA (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 19 Aug 2006 18:20:00 -0400
Date: Sun, 20 Aug 2006 00:19:06 +0200 (MEST)
Message-Id: <200608192219.k7JMJ6DQ012098@harpo.it.uu.se>
From: Mikael Pettersson <mikpe@it.uu.se>
To: wtarreau@hera.kernel.org
Subject: [PATCH 2.4.34-pre1] fix x86_64 etc build failure due to memchr change
Cc: ak@suse.de, linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

2.4.34-pre1 doesn't build on x86_64:

kernel/kernel.o(__ksymtab+0x1c10): multiple definition of `__ksymtab_memchr'
arch/x86_64/kernel/kernel.o(__ksymtab+0x3f0): first defined here
kernel/kernel.o(.kstrtab+0x3960): multiple definition of `__kstrtab_memchr'
arch/x86_64/kernel/kernel.o(.kstrtab+0x5fd): first defined here
ld: Warning: size of symbol `__kstrtab_memchr' changed from 7 in arch/x86_64/kernel/kernel.o to 17 in kernel/kernel.o
make: *** [vmlinux] Error 1

This is because the 'export memchr() which is used by smbfs and lp driver'
change in 2.4.34-pre1 added an EXPORT_SYMBOL of memchr to kernel/ksyms.c
without also removing the existing one in arch/x86_64/kernel/x8664_ksyms.c.
Alpha, ARM, ppc32, and SH also have EXPORTs of memchr so they probably
also broke.

This patch removes the EXPORTs of memchr under arch/, which fixes x86_64
and should fix the other architectures as well.

Signed-off-by: Mikael Pettersson <mikpe@it.uu.se>

diff -rupN linux-2.4.34-pre1/arch/alpha/kernel/alpha_ksyms.c linux-2.4.34-pre1.kill-arch-memchr-exports/arch/alpha/kernel/alpha_ksyms.c
--- linux-2.4.34-pre1/arch/alpha/kernel/alpha_ksyms.c	2003-06-14 13:30:18.000000000 +0200
+++ linux-2.4.34-pre1.kill-arch-memchr-exports/arch/alpha/kernel/alpha_ksyms.c	2006-08-20 00:10:15.000000000 +0200
@@ -268,7 +268,6 @@ EXPORT_SYMBOL_NOVERS(__remq);
 EXPORT_SYMBOL_NOVERS(__remqu);
 EXPORT_SYMBOL_NOVERS(memcpy);
 EXPORT_SYMBOL_NOVERS(memset);
-EXPORT_SYMBOL_NOVERS(memchr);
 
 EXPORT_SYMBOL(get_wchan);
 
diff -rupN linux-2.4.34-pre1/arch/arm/kernel/armksyms.c linux-2.4.34-pre1.kill-arch-memchr-exports/arch/arm/kernel/armksyms.c
--- linux-2.4.34-pre1/arch/arm/kernel/armksyms.c	2003-08-25 20:07:40.000000000 +0200
+++ linux-2.4.34-pre1.kill-arch-memchr-exports/arch/arm/kernel/armksyms.c	2006-08-20 00:10:15.000000000 +0200
@@ -193,7 +193,6 @@ EXPORT_SYMBOL_NOVERS(memcpy);
 EXPORT_SYMBOL_NOVERS(memmove);
 EXPORT_SYMBOL_NOVERS(memcmp);
 EXPORT_SYMBOL_NOVERS(memscan);
-EXPORT_SYMBOL_NOVERS(memchr);
 EXPORT_SYMBOL_NOVERS(__memzero);
 
 	/* user mem (segment) */
diff -rupN linux-2.4.34-pre1/arch/ia64/kernel/ia64_ksyms.c linux-2.4.34-pre1.kill-arch-memchr-exports/arch/ia64/kernel/ia64_ksyms.c
--- linux-2.4.34-pre1/arch/ia64/kernel/ia64_ksyms.c	2004-04-14 20:22:20.000000000 +0200
+++ linux-2.4.34-pre1.kill-arch-memchr-exports/arch/ia64/kernel/ia64_ksyms.c	2006-08-20 00:10:15.000000000 +0200
@@ -10,7 +10,6 @@ EXPORT_SYMBOL(pm_idle);
 #include <linux/string.h>
 
 EXPORT_SYMBOL_NOVERS(memset);
-EXPORT_SYMBOL(memchr);
 EXPORT_SYMBOL(memcmp);
 EXPORT_SYMBOL_NOVERS(memcpy);
 EXPORT_SYMBOL(memmove);
diff -rupN linux-2.4.34-pre1/arch/ppc/kernel/ppc_ksyms.c linux-2.4.34-pre1.kill-arch-memchr-exports/arch/ppc/kernel/ppc_ksyms.c
--- linux-2.4.34-pre1/arch/ppc/kernel/ppc_ksyms.c	2004-04-14 20:22:20.000000000 +0200
+++ linux-2.4.34-pre1.kill-arch-memchr-exports/arch/ppc/kernel/ppc_ksyms.c	2006-08-20 00:10:15.000000000 +0200
@@ -300,7 +300,6 @@ EXPORT_SYMBOL_NOVERS(memset);
 EXPORT_SYMBOL_NOVERS(memmove);
 EXPORT_SYMBOL_NOVERS(memscan);
 EXPORT_SYMBOL_NOVERS(memcmp);
-EXPORT_SYMBOL_NOVERS(memchr);
 
 EXPORT_SYMBOL(abs);
 
diff -rupN linux-2.4.34-pre1/arch/sh/kernel/sh_ksyms.c linux-2.4.34-pre1.kill-arch-memchr-exports/arch/sh/kernel/sh_ksyms.c
--- linux-2.4.34-pre1/arch/sh/kernel/sh_ksyms.c	2003-11-29 00:28:11.000000000 +0100
+++ linux-2.4.34-pre1.kill-arch-memchr-exports/arch/sh/kernel/sh_ksyms.c	2006-08-20 00:10:15.000000000 +0200
@@ -60,7 +60,6 @@ EXPORT_SYMBOL(pcibios_penalize_isa_irq);
 
 /* mem exports */
 EXPORT_SYMBOL(memscan);
-EXPORT_SYMBOL(memchr);
 EXPORT_SYMBOL(memcpy);
 EXPORT_SYMBOL(memcpy_fromio);
 EXPORT_SYMBOL(memcpy_toio);
diff -rupN linux-2.4.34-pre1/arch/x86_64/kernel/x8664_ksyms.c linux-2.4.34-pre1.kill-arch-memchr-exports/arch/x86_64/kernel/x8664_ksyms.c
--- linux-2.4.34-pre1/arch/x86_64/kernel/x8664_ksyms.c	2004-11-17 18:36:41.000000000 +0100
+++ linux-2.4.34-pre1.kill-arch-memchr-exports/arch/x86_64/kernel/x8664_ksyms.c	2006-08-20 00:10:15.000000000 +0200
@@ -171,7 +171,6 @@ EXPORT_SYMBOL_NOVERS(strchr);
 EXPORT_SYMBOL_NOVERS(strcat);
 EXPORT_SYMBOL_NOVERS(strcmp);
 EXPORT_SYMBOL_NOVERS(strncat);
-EXPORT_SYMBOL_NOVERS(memchr);
 EXPORT_SYMBOL_NOVERS(strrchr);
 EXPORT_SYMBOL_NOVERS(strnlen);
 EXPORT_SYMBOL_NOVERS(memcmp);
