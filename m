Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1755874AbWKRCAY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755874AbWKRCAY (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 17 Nov 2006 21:00:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756130AbWKRCAX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 17 Nov 2006 21:00:23 -0500
Received: from mout2.freenet.de ([194.97.50.155]:34775 "EHLO mout2.freenet.de")
	by vger.kernel.org with ESMTP id S1755874AbWKRCAW (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 17 Nov 2006 21:00:22 -0500
From: Karsten Wiese <fzu@wemgehoertderstaat.de>
To: Andrew Morton <akpm@osdl.org>
Subject: [PATCH] Regard MSRs in lapic_suspend()/lapic_resume()
Date: Sat, 18 Nov 2006 03:00:18 +0100
User-Agent: KMail/1.9.5
Cc: linux-kernel@vger.kernel.org, Ingo Molnar <mingo@elte.hu>,
       Stephen Hemminger <shemminger@osdl.org>,
       "Rafael J. Wysocki" <rjw@sisk.pl>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200611180300.18581.fzu@wemgehoertderstaat.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Read/Write APIC_LVTPC and APIC_LVTTHMR only,
if get_maxlvt() returns certain values.
This is done like everywhere else in i386/kernel/apic.c,
so I guess its correct.
Suspends/Resumes to disk fine and eleminates an smp_error_interrupt()
here on a K8.

Signed-off-by: Karsten Wiese <fzu@wemgehoertderstaat.de>
---
 arch/i386/kernel/apic.c |   22 ++++++++++++++++++----
 1 files changed, 18 insertions(+), 4 deletions(-)

diff --git a/arch/i386/kernel/apic.c b/arch/i386/kernel/apic.c
index 2fd4b7d..776d9be 100644
--- a/arch/i386/kernel/apic.c
+++ b/arch/i386/kernel/apic.c
@@ -647,23 +647,30 @@ static struct {
 static int lapic_suspend(struct sys_device *dev, pm_message_t state)
 {
 	unsigned long flags;
+	int maxlvt;
 
 	if (!apic_pm_state.active)
 		return 0;
 
+	maxlvt = get_maxlvt();
+
 	apic_pm_state.apic_id = apic_read(APIC_ID);
 	apic_pm_state.apic_taskpri = apic_read(APIC_TASKPRI);
 	apic_pm_state.apic_ldr = apic_read(APIC_LDR);
 	apic_pm_state.apic_dfr = apic_read(APIC_DFR);
 	apic_pm_state.apic_spiv = apic_read(APIC_SPIV);
 	apic_pm_state.apic_lvtt = apic_read(APIC_LVTT);
-	apic_pm_state.apic_lvtpc = apic_read(APIC_LVTPC);
+	if (maxlvt >= 4)
+		apic_pm_state.apic_lvtpc = apic_read(APIC_LVTPC);
 	apic_pm_state.apic_lvt0 = apic_read(APIC_LVT0);
 	apic_pm_state.apic_lvt1 = apic_read(APIC_LVT1);
 	apic_pm_state.apic_lvterr = apic_read(APIC_LVTERR);
 	apic_pm_state.apic_tmict = apic_read(APIC_TMICT);
 	apic_pm_state.apic_tdcr = apic_read(APIC_TDCR);
-	apic_pm_state.apic_thmr = apic_read(APIC_LVTTHMR);
+#ifdef CONFIG_X86_MCE_P4THERMAL
+	if (maxlvt >= 5)
+		apic_pm_state.apic_thmr = apic_read(APIC_LVTTHMR);
+#endif
 	
 	local_irq_save(flags);
 	disable_local_APIC();
@@ -675,10 +682,13 @@ static int lapic_resume(struct sys_devic
 {
 	unsigned int l, h;
 	unsigned long flags;
+	int maxlvt;
 
 	if (!apic_pm_state.active)
 		return 0;
 
+	maxlvt = get_maxlvt();
+
 	local_irq_save(flags);
 
 	/*
@@ -700,8 +710,12 @@ static int lapic_resume(struct sys_devic
 	apic_write(APIC_SPIV, apic_pm_state.apic_spiv);
 	apic_write(APIC_LVT0, apic_pm_state.apic_lvt0);
 	apic_write(APIC_LVT1, apic_pm_state.apic_lvt1);
-	apic_write(APIC_LVTTHMR, apic_pm_state.apic_thmr);
-	apic_write(APIC_LVTPC, apic_pm_state.apic_lvtpc);
+#ifdef CONFIG_X86_MCE_P4THERMAL
+	if (maxlvt >= 5)
+		apic_write(APIC_LVTTHMR, apic_pm_state.apic_thmr);
+#endif
+	if (maxlvt >= 4)
+		apic_write(APIC_LVTPC, apic_pm_state.apic_lvtpc);
 	apic_write(APIC_LVTT, apic_pm_state.apic_lvtt);
 	apic_write(APIC_TDCR, apic_pm_state.apic_tdcr);
 	apic_write(APIC_TMICT, apic_pm_state.apic_tmict);
-- 
1.4.2.4
