Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750848AbWD2Xqb@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750848AbWD2Xqb (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 29 Apr 2006 19:46:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750852AbWD2Xnd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 29 Apr 2006 19:43:33 -0400
Received: from moutng.kundenserver.de ([212.227.126.186]:6893 "EHLO
	moutng.kundenserver.de") by vger.kernel.org with ESMTP
	id S1750831AbWD2XnN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 29 Apr 2006 19:43:13 -0400
Message-Id: <20060429233920.295209000@localhost.localdomain>
References: <20060429232812.825714000@localhost.localdomain>
Date: Sun, 30 Apr 2006 01:28:16 +0200
From: Arnd Bergmann <arnd@arndb.de>
To: paulus@samba.org
Cc: cbe-oss-dev@ozlabs.org, linuxppc-dev@ozlabs.org,
       linux-kernel@vger.kernel.org,
       Geoff Levand <geoffrey.levand@am.sony.com>,
       Arnd Bergmann <arnd.bergmann@de.ibm.com>
Subject: [PATCH 04/13] cell: remove broken __setup_cpu_be function
Content-Disposition: inline; filename=cell-remove-hid6-setup.diff
X-Provags-ID: kundenserver.de abuse@kundenserver.de login:bf0b512fe2ff06b96d9695102898be39
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

 From: Geoff Levand <geoffrey.levand@am.sony.com>

This patch removes the incorrect Cell processor setup routine
__setup_cpu_be.  This routine improperly accesses the hypervisor
page size configuration at SPR HID6.  The correct behavior is for
firmware, or if needed, platform setup code, to set the correct
page size.

Signed-off-by: Geoff Levand <geoffrey.levand@am.sony.com>
Signed-off-by: Arnd Bergmann <arnd.bergmann@de.ibm.com>
---
Index: linus-2.6/arch/powerpc/kernel/cpu_setup_power4.S
===================================================================
--- linus-2.6.orig/arch/powerpc/kernel/cpu_setup_power4.S	2006-04-29 22:47:55.000000000 +0200
+++ linus-2.6/arch/powerpc/kernel/cpu_setup_power4.S	2006-04-29 22:53:42.000000000 +0200
@@ -76,20 +76,6 @@
 _GLOBAL(__setup_cpu_power4)
 	blr
 
-_GLOBAL(__setup_cpu_be)
-        /* Set large page sizes LP=0: 16MB, LP=1: 64KB */
-        addi    r3, 0,  0
-        ori     r3, r3, HID6_LB
-        sldi    r3, r3, 32
-        nor     r3, r3, r3
-        mfspr   r4, SPRN_HID6
-        and     r4, r4, r3
-        addi    r3, 0, 0x02000
-        sldi    r3, r3, 32
-        or      r4, r4, r3
-        mtspr   SPRN_HID6, r4
-	blr
-
 _GLOBAL(__setup_cpu_ppc970)
 	mfspr	r0,SPRN_HID0
 	li	r11,5			/* clear DOZE and SLEEP */
Index: linus-2.6/arch/powerpc/kernel/cputable.c
===================================================================
--- linus-2.6.orig/arch/powerpc/kernel/cputable.c	2006-04-29 22:47:55.000000000 +0200
+++ linus-2.6/arch/powerpc/kernel/cputable.c	2006-04-29 22:53:42.000000000 +0200
@@ -33,7 +33,6 @@
 #ifdef CONFIG_PPC64
 extern void __setup_cpu_power3(unsigned long offset, struct cpu_spec* spec);
 extern void __setup_cpu_power4(unsigned long offset, struct cpu_spec* spec);
-extern void __setup_cpu_be(unsigned long offset, struct cpu_spec* spec);
 #else
 extern void __setup_cpu_603(unsigned long offset, struct cpu_spec* spec);
 extern void __setup_cpu_604(unsigned long offset, struct cpu_spec* spec);
@@ -289,7 +288,7 @@
 			PPC_FEATURE_SMT,
 		.icache_bsize		= 128,
 		.dcache_bsize		= 128,
-		.cpu_setup		= __setup_cpu_be,
+		.cpu_setup		= __setup_cpu_power4,
 		.platform		= "ppc-cell-be",
 	},
 	{	/* default match */

--

