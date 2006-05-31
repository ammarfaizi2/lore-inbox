Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965246AbWEaXLc@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965246AbWEaXLc (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 31 May 2006 19:11:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965253AbWEaXLc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 31 May 2006 19:11:32 -0400
Received: from sccrmhc11.comcast.net ([63.240.77.81]:46057 "EHLO
	sccrmhc11.comcast.net") by vger.kernel.org with ESMTP
	id S965244AbWEaXLb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 31 May 2006 19:11:31 -0400
Date: Wed, 31 May 2006 16:14:05 -0700
From: Deepak Saxena <dsaxena@plexity.net>
To: Linus Torvalds <torvalds@osdl.org>
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH] ARM: Fix XScale PMD setting
Message-ID: <20060531231405.GA19573@plexity.net>
Reply-To: dsaxena@plexity.net
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Organization: Plexity Networks
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


The ARM Architecture Reference Manual lists bit 4 of the PMD as "implementation 
defined" and it must be set to zero on Intel XScale CPUs or the cache does
not behave properly. Found by Mike Rapoport while debugging a flash issue
on the PXA255: 

http://marc.10east.com/?l=linux-arm-kernel&m=114845287600782&w=1

Signed-off-by: Deepak Saxena <dsaxena@plexity.net>

diff --git a/arch/arm/mm/mm-armv.c b/arch/arm/mm/mm-armv.c
index f14b2d0..95273de 100644
--- a/arch/arm/mm/mm-armv.c
+++ b/arch/arm/mm/mm-armv.c
@@ -376,7 +376,7 @@ #endif
 		ecc_mask = 0;
 	}
 
-	if (cpu_arch <= CPU_ARCH_ARMv5TEJ) {
+	if (cpu_arch <= CPU_ARCH_ARMv5TEJ && !cpu_is_xscale()) {
 		for (i = 0; i < ARRAY_SIZE(mem_types); i++) {
 			if (mem_types[i].prot_l1)
 				mem_types[i].prot_l1 |= PMD_BIT4;
@@ -631,7 +631,7 @@ void setup_mm_for_reboot(char mode)
 		pgd = init_mm.pgd;
 
 	base_pmdval = PMD_SECT_AP_WRITE | PMD_SECT_AP_READ | PMD_TYPE_SECT;
-	if (cpu_architecture() <= CPU_ARCH_ARMv5TEJ)
+	if (cpu_architecture() <= CPU_ARCH_ARMv5TEJ && !cpu_is_xscale())
 		base_pmdval |= PMD_BIT4;
 
 	for (i = 0; i < FIRST_USER_PGD_NR + USER_PTRS_PER_PGD; i++, pgd++) {
diff --git a/include/asm-arm/system.h b/include/asm-arm/system.h
index 95b3abf..7c9568d 100644
--- a/include/asm-arm/system.h
+++ b/include/asm-arm/system.h
@@ -127,6 +127,12 @@ static inline int cpu_is_xsc3(void)
 }
 #endif
 
+#if !defined(CONFIG_CPU_XSCALE) && !defined(CONFIG_CPU_XSC3)
+#define	cpu_is_xscale()	0
+#else
+#define	cpu_is_xscale()	1
+#endif
+
 #define set_cr(x)					\
 	__asm__ __volatile__(				\
 	"mcr	p15, 0, %0, c1, c0, 0	@ set CR"	\

-- 
Deepak Saxena - dsaxena@plexity.net - http://www.plexity.net

In the end, they will not say, "those were dark times,"  they will ask
"why were their poets silent?" - Bertold Brecht
