Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266427AbUI0JCN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266427AbUI0JCN (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 27 Sep 2004 05:02:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266376AbUI0JCN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 27 Sep 2004 05:02:13 -0400
Received: from gate.crashing.org ([63.228.1.57]:28811 "EHLO gate.crashing.org")
	by vger.kernel.org with ESMTP id S266474AbUI0JBr (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 27 Sep 2004 05:01:47 -0400
Subject: [PATCH] ppc64: Remote some userland-only stuff from kernel header
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Andrew Morton <akpm@osdl.org>
Cc: Linus Torvalds <torvalds@osdl.org>,
       Linux Kernel list <linux-kernel@vger.kernel.org>
Content-Type: text/plain
Message-Id: <1096275593.1071.32.camel@gaston>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 
Date: Mon, 27 Sep 2004 18:59:54 +1000
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi !

include/asm-ppc64/systemcfg.h defines a structure that currently gets 
exposed to userland via /proc, and which I intend to deprecate in the
near future once I have better alternatives available. In the meantime,
this patch removes a bunch of stuff from this file that were only defined
for non-__KERNEL__, like an inline function for getting to that struture
via /proc, and some CPU & platform type definitions that were duplicates
of the ones in asm-ppc64/processor.h. These things have nothing to do in
a kernel header.

Signed-off-by: Benjamin Herrenschmidt <benh@kernel.crashing.org>

===== include/asm-ppc64/systemcfg.h 1.3 vs edited =====
--- 1.3/include/asm-ppc64/systemcfg.h	2004-06-27 17:19:24 +10:00
+++ edited/include/asm-ppc64/systemcfg.h	2004-09-27 18:15:45 +10:00
@@ -59,54 +59,7 @@
 
 #ifdef __KERNEL__
 extern struct systemcfg *systemcfg;
-#else
-
-/* Processor Version Register (PVR) field extraction */
-#define PVR_VER(pvr)  (((pvr) >>  16) & 0xFFFF) /* Version field */
-#define PVR_REV(pvr)  (((pvr) >>   0) & 0xFFFF) /* Revison field */
-
-/* Processor Version Numbers */
-#define PV_NORTHSTAR    0x0033
-#define PV_PULSAR       0x0034
-#define PV_POWER4       0x0035
-#define PV_ICESTAR      0x0036
-#define PV_SSTAR        0x0037
-#define PV_POWER4p      0x0038
-#define PV_GPUL		0x0039
-#define PV_POWER5	0x003a
-#define PV_970FX	0x003c
-#define PV_630          0x0040
-#define PV_630p         0x0041
-
-/* Platforms supported by PPC64 */
-#define PLATFORM_PSERIES      0x0100
-#define PLATFORM_PSERIES_LPAR 0x0101
-#define PLATFORM_ISERIES_LPAR 0x0201
-#define PLATFORM_POWERMAC     0x0400
-
-/* Compatibility with drivers coming from PPC32 world */
-#define _machine	(systemcfg->platform)
-#define _MACH_Pmac	PLATFORM_POWERMAC
-
-
-static inline volatile struct systemcfg *systemcfg_init(void)
-{
-	int fd = open("/proc/ppc64/systemcfg", O_RDONLY);
-	volatile struct systemcfg *ret;
-
-	if (fd == -1)
-		return 0;
-	ret = mmap(0, sizeof(struct systemcfg), PROT_READ, MAP_SHARED, fd, 0);
-	close(fd);
-	if (!ret)
-		return 0;
-	if (ret->version.major != SYSTEMCFG_MAJOR || ret->version.minor < SYSTEMCFG_MINOR) {
-		munmap((void *)ret, sizeof(struct systemcfg));
-		return 0;
-	}
-	return ret;
-}
-#endif /* __KERNEL__ */
+#endif
 
 #endif /* __ASSEMBLY__ */
 



