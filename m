Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268983AbUHZOUi@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268983AbUHZOUi (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 26 Aug 2004 10:20:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268980AbUHZORr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 26 Aug 2004 10:17:47 -0400
Received: from aun.it.uu.se ([130.238.12.36]:36513 "EHLO aun.it.uu.se")
	by vger.kernel.org with ESMTP id S268983AbUHZOQQ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 26 Aug 2004 10:16:16 -0400
From: Mikael Pettersson <mikpe@user.it.uu.se>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <16685.61603.854888.723403@alkaid.it.uu.se>
Date: Thu, 26 Aug 2004 16:16:03 +0200
To: akpm@osdl.org
Subject: [PATCH][2.6.9-rc1-mm1] Prescott fix for perfctr
CC: linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrew,

This eliminates a potential oops in perfctr's x86 initialisation
code when running on a P4 Model 3 Prescott processor. The P4M3
removed two control registers. I knew that and handled it in the
control setup validation code, but I forgot to also modify the
initialisation code to avoid clearing them.

Perfctr hasn't been hit by this problem on the P4M3 Noconas,
but people are reporting that oprofile and the NMI watchdog
oops due to this on P4M3 Prescotts.

Signed-off-by: Mikael Pettersson <mikpe@csd.uu.se>

diff -ruN linux-2.6.9-rc1-mm1/drivers/perfctr/x86.c linux-2.6.9-rc1-mm1.perfctr-p4m3-fix/drivers/perfctr/x86.c
--- linux-2.6.9-rc1-mm1/drivers/perfctr/x86.c	2004-08-26 14:33:03.000000000 +0200
+++ linux-2.6.9-rc1-mm1.perfctr-p4m3-fix/drivers/perfctr/x86.c	2004-08-26 15:26:28.000000000 +0200
@@ -865,7 +865,10 @@
 	/* clear PEBS_ENABLE and PEBS_MATRIX_VERT; they handle both PEBS
 	   and ReplayTagging, and should exist even if PEBS is disabled */
 	clear_msr_range(0x3F1, 2);
-	clear_msr_range(0x3A0, 31);
+	clear_msr_range(0x3A0, 26);
+	if (p4_IQ_ESCR_ok)
+		clear_msr_range(0x3BA, 2);
+	clear_msr_range(0x3BC, 3);
 	clear_msr_range(0x3C0, 6);
 	clear_msr_range(0x3C8, 6);
 	clear_msr_range(0x3E0, 2);
