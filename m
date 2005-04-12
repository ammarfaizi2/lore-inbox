Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262129AbVDLUXA@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262129AbVDLUXA (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 12 Apr 2005 16:23:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262960AbVDLUVm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 12 Apr 2005 16:21:42 -0400
Received: from fire.osdl.org ([65.172.181.4]:15560 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S262129AbVDLKbV (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 12 Apr 2005 06:31:21 -0400
Message-Id: <200504121031.j3CAVHVJ005276@shell0.pdx.osdl.net>
Subject: [patch 038/198] ppc32: Fix building 32bit kernel for 64bit machines
To: torvalds@osdl.org
Cc: linux-kernel@vger.kernel.org, akpm@osdl.org, trini@kernel.crashing.org
From: akpm@osdl.org
Date: Tue, 12 Apr 2005 03:31:10 -0700
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


From: Tom Rini <trini@kernel.crashing.org>

When building a ppc32 MULTIPLATFORM kernel for a 64bit pmac, we try and
build certain files or use certain functions that make no sense in that
context.  This catches the last of these.

Signed-off-by: Tom Rini <trini@kernel.crashing.org>
Signed-off-by: Andrew Morton <akpm@osdl.org>
---

 25-akpm/arch/ppc/boot/simple/Makefile   |    3 +++
 25-akpm/arch/ppc/platforms/pmac_cache.S |    4 ++++
 2 files changed, 7 insertions(+)

diff -puN arch/ppc/boot/simple/Makefile~ppc32-fix-building-32bit-kernel-for-64bit-machines arch/ppc/boot/simple/Makefile
--- 25/arch/ppc/boot/simple/Makefile~ppc32-fix-building-32bit-kernel-for-64bit-machines	2005-04-12 03:21:12.495237336 -0700
+++ 25-akpm/arch/ppc/boot/simple/Makefile	2005-04-12 03:21:12.500236576 -0700
@@ -123,10 +123,13 @@ zimageinitrd-$(pcore)			:= zImage.initrd
          end-$(pcore)			:= pcore
    cacheflag-$(pcore)			:= -include $(clear_L2_L3)
 
+# Really only valid if CONFIG_6xx=y
       zimage-$(CONFIG_PPC_PREP)		:= zImage-PPLUS
 zimageinitrd-$(CONFIG_PPC_PREP)		:= zImage.initrd-PPLUS
+ifeq ($(CONFIG_6xx),y)
      extra.o-$(CONFIG_PPC_PREP)		:= prepmap.o
         misc-$(CONFIG_PPC_PREP)		+= misc-prep.o mpc10x_memory.o
+endif
          end-$(CONFIG_PPC_PREP)		:= prep
 
          end-$(CONFIG_SANDPOINT)	:= sandpoint
diff -puN arch/ppc/platforms/pmac_cache.S~ppc32-fix-building-32bit-kernel-for-64bit-machines arch/ppc/platforms/pmac_cache.S
--- 25/arch/ppc/platforms/pmac_cache.S~ppc32-fix-building-32bit-kernel-for-64bit-machines	2005-04-12 03:21:12.497237032 -0700
+++ 25-akpm/arch/ppc/platforms/pmac_cache.S	2005-04-12 03:21:12.501236424 -0700
@@ -28,6 +28,9 @@
  */
 
 _GLOBAL(flush_disable_caches)
+#ifndef CONFIG_6xx
+	blr
+#else
 BEGIN_FTR_SECTION
 	b	flush_disable_745x
 END_FTR_SECTION_IFSET(CPU_FTR_SPEC7450)
@@ -323,3 +326,4 @@ END_FTR_SECTION_IFSET(CPU_FTR_L3CR)
 	mtmsr	r11		/* restore DR and EE */
 	isync
 	blr
+#endif	/* CONFIG_6xx */
_
