Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268135AbUHKRwh@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268135AbUHKRwh (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 11 Aug 2004 13:52:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268136AbUHKRwh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 11 Aug 2004 13:52:37 -0400
Received: from fed1rmmtao06.cox.net ([68.230.241.33]:32475 "EHLO
	fed1rmmtao06.cox.net") by vger.kernel.org with ESMTP
	id S268135AbUHKRwU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 11 Aug 2004 13:52:20 -0400
Date: Wed, 11 Aug 2004 10:52:17 -0700
From: Matt Porter <mporter@kernel.crashing.org>
To: akpm@osdl.org
Cc: linux-kernel@vger.kernel.org, linuxppc-dev@lists.linuxppc.org
Subject: [PATCH][PPC32] Make PPC40x large tlb mapping optional
Message-ID: <20040811105217.B8378@home.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This makes the PPC40x lowmem large tlb mapping selectable via
a cmdline option.  This allows use of the normal page-sized mapping
so that kernel text can be read only if desired.

Signed-off-by: Josh Boyer <jwboyer@charter.net>
Signed-off-by: Matt Porter <mporter@kernel.crashing.org>

diff -Naur -x '*.swp' linux-2.6.orig/arch/ppc/mm/4xx_mmu.c linux-2.6/arch/ppc/mm/4xx_mmu.c
--- linux-2.6.orig/arch/ppc/mm/4xx_mmu.c	2004-06-16 00:18:37.000000000 -0500
+++ linux-2.6/arch/ppc/mm/4xx_mmu.c	2004-08-11 08:25:11.000000000 -0500
@@ -52,6 +52,7 @@
 #include <asm/setup.h>
 #include "mmu_decl.h"
 
+extern int __map_without_ltlbs;
 /*
  * MMU_init_hw does the chip-specific initialization of the MMU hardware.
  */
@@ -102,6 +103,10 @@
 	p = PPC_MEMSTART;
 	s = 0;
 
+	if (__map_without_ltlbs) {
+		return s;
+	}
+
 	while (s <= (total_lowmem - LARGE_PAGE_SIZE_16M)) {
 		pmd_t *pmdp;
 		unsigned long val = p | _PMD_SIZE_16M | _PAGE_HWEXEC | _PAGE_HWWRITE;
diff -Naur -x '*.swp' linux-2.6.orig/arch/ppc/mm/init.c linux-2.6/arch/ppc/mm/init.c
--- linux-2.6.orig/arch/ppc/mm/init.c	2004-08-11 08:03:55.000000000 -0500
+++ linux-2.6/arch/ppc/mm/init.c	2004-08-11 08:11:24.000000000 -0500
@@ -104,6 +104,7 @@
  * -- Cort
  */
 int __map_without_bats;
+int __map_without_ltlbs;
 
 /* max amount of RAM to use */
 unsigned long __max_memory;
@@ -204,6 +205,10 @@
 		__map_without_bats = 1;
 	}
 
+	if (strstr(cmd_line, "noltlbs")) {
+		__map_without_ltlbs = 1;
+	}
+
 	/* Look for mem= option on command line */
 	if (strstr(cmd_line, "mem=")) {
 		char *p, *q;

