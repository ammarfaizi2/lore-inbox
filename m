Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262625AbUKLVsq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262625AbUKLVsq (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 12 Nov 2004 16:48:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262627AbUKLVru
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 12 Nov 2004 16:47:50 -0500
Received: from aun.it.uu.se ([130.238.12.36]:31190 "EHLO aun.it.uu.se")
	by vger.kernel.org with ESMTP id S262625AbUKLVpg (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 12 Nov 2004 16:45:36 -0500
Date: Fri, 12 Nov 2004 22:45:27 +0100 (MET)
Message-Id: <200411122145.iACLjRdJ004339@harpo.it.uu.se>
From: Mikael Pettersson <mikpe@csd.uu.se>
To: akpm@osdl.org
Subject: [PATCH][2.6.10-rc1-mm5][2/3] perfctr virtual cleanup
Cc: linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Per-process virtualised counters driver cleanup to be applied
on top of yesterday's perfctr interrupt fixes patches:
- Check for pending overflow via new API function. Skip
  clearing pending interrupt flag: the low-level driver
  takes care of that. Both changes are required for ppc32.

Signed-off-by: Mikael Pettersson <mikpe@csd.uu.se>

 drivers/perfctr/virtual.c |    3 +--
 1 files changed, 1 insertion(+), 2 deletions(-)

diff -rupN linux-2.6.10-rc1-mm5/drivers/perfctr/virtual.c linux-2.6.10-rc1-mm5.perfctr-virtual-update2/drivers/perfctr/virtual.c
--- linux-2.6.10-rc1-mm5/drivers/perfctr/virtual.c	2004-11-12 21:45:01.000000000 +0100
+++ linux-2.6.10-rc1-mm5.perfctr-virtual-update2/drivers/perfctr/virtual.c	2004-11-12 21:45:21.000000000 +0100
@@ -227,8 +227,7 @@ static inline void vperfctr_resume(struc
 static inline void vperfctr_resume_with_overflow_check(struct vperfctr *perfctr)
 {
 #ifdef CONFIG_PERFCTR_INTERRUPT_SUPPORT
-	if (perfctr->cpu_state.pending_interrupt) {
-		perfctr->cpu_state.pending_interrupt = 0;
+	if (perfctr_cpu_has_pending_interrupt(&perfctr->cpu_state)) {
 		vperfctr_handle_overflow(current, perfctr);
 		return;
 	}
