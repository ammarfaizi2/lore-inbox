Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265789AbUGTLSx@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265789AbUGTLSx (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 20 Jul 2004 07:18:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265792AbUGTLSx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 20 Jul 2004 07:18:53 -0400
Received: from aun.it.uu.se ([130.238.12.36]:28152 "EHLO aun.it.uu.se")
	by vger.kernel.org with ESMTP id S265789AbUGTLSu (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 20 Jul 2004 07:18:50 -0400
Date: Tue, 20 Jul 2004 13:18:38 +0200 (MEST)
Message-Id: <200407201118.i6KBIc1w021602@harpo.it.uu.se>
From: Mikael Pettersson <mikpe@csd.uu.se>
To: akpm@osdl.org
Subject: [PATCH][2.6.8-rc1-mm1] perfctr x86 init bug
Cc: linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrew,

This patch fixes a bug in perfctr's x86 driver, which
can cause it to clear one of the counter control registers
at driver initialisation time. At this point the HW is
either free or owned by the lapic NMI watchdog. In the
former case the bug is harmless, but in the latter case
the effect on P6 and AMD is that the watchdog stops ticking.

Signed-off-by: Mikael Pettersson <mikpe@csd.uu.se>

 drivers/perfctr/x86.c      |    2 +-
 include/asm-i386/perfctr.h |    9 ++++++++-
 2 files changed, 9 insertions(+), 2 deletions(-)

diff -ruN linux-2.6.8-rc1-mm1/drivers/perfctr/x86.c linux-2.6.8-rc1-mm1.stray-wrmsr-fix/drivers/perfctr/x86.c
--- linux-2.6.8-rc1-mm1/drivers/perfctr/x86.c	2004-07-19 18:26:57.000000000 +0200
+++ linux-2.6.8-rc1-mm1.stray-wrmsr-fix/drivers/perfctr/x86.c	2004-07-19 18:39:08.792750000 +0200
@@ -1142,7 +1142,7 @@
 	memset(&state, 0, sizeof state);
 	state.cstatus =
 		(perfctr_info.cpu_features & PERFCTR_FEATURE_PCINT)
-		? perfctr_mk_cstatus(0, 0, 1)
+		? __perfctr_mk_cstatus(0, 1, 0, 0)
 		: 0;
 	perfctr_cpu_sample(&state);
 	perfctr_cpu_resume(&state);
diff -ruN linux-2.6.8-rc1-mm1/include/asm-i386/perfctr.h linux-2.6.8-rc1-mm1.stray-wrmsr-fix/include/asm-i386/perfctr.h
--- linux-2.6.8-rc1-mm1/include/asm-i386/perfctr.h	2004-07-19 18:26:57.000000000 +0200
+++ linux-2.6.8-rc1-mm1.stray-wrmsr-fix/include/asm-i386/perfctr.h	2004-07-19 18:39:08.802750000 +0200
@@ -73,10 +73,17 @@
    which should have less overhead in most cases */
 
 static inline
+unsigned int __perfctr_mk_cstatus(unsigned int tsc_on, unsigned int have_ictrs,
+				  unsigned int nrictrs, unsigned int nractrs)
+{
+	return (tsc_on<<31) | (have_ictrs<<16) | ((nractrs+nrictrs)<<8) | nractrs;
+}
+
+static inline
 unsigned int perfctr_mk_cstatus(unsigned int tsc_on, unsigned int nractrs,
 				unsigned int nrictrs)
 {
-	return (tsc_on<<31) | (nrictrs<<16) | ((nractrs+nrictrs)<<8) | nractrs;
+	return __perfctr_mk_cstatus(tsc_on, nrictrs, nrictrs, nractrs);
 }
 
 static inline unsigned int perfctr_cstatus_enabled(unsigned int cstatus)
