Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1756325AbWKRM5l@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756325AbWKRM5l (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 18 Nov 2006 07:57:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756332AbWKRM5l
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 18 Nov 2006 07:57:41 -0500
Received: from mout1.freenet.de ([194.97.50.132]:52448 "EHLO mout1.freenet.de")
	by vger.kernel.org with ESMTP id S1756325AbWKRM5k convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 18 Nov 2006 07:57:40 -0500
From: Karsten Wiese <fzu@wemgehoertderstaat.de>
To: Paolo Ornati <ornati@fastwebnet.it>
Subject: Re: sleeping functions called in invalid context during resume
Date: Sat, 18 Nov 2006 13:55:04 +0100
User-Agent: KMail/1.9.5
Cc: Stephen Hemminger <shemminger@osdl.org>, "Rafael J. Wysocki" <rjw@sisk.pl>,
       Ingo Molnar <mingo@elte.hu>, Andrew Morton <akpm@osdl.org>,
       linux-kernel@vger.kernel.org
References: <20061114223002.10c231bd@localhost.localdomain> <20061117083008.7758149a@localhost.localdomain> <20061118124349.16743124@localhost>
In-Reply-To: <20061118124349.16743124@localhost>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
Message-Id: <200611181355.04355.fzu@wemgehoertderstaat.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Am Samstag, 18. November 2006 12:43 schrieb Paolo Ornati:
> On Fri, 17 Nov 2006 08:30:08 -0800
> Stephen Hemminger <shemminger@osdl.org> wrote:
> 
> > > > > APIC error on CPU0: 00(00)
> > > > > 
> > > > > Is it an ACPI problem?
> > > > 
> > > > a 00 error code? Never seen that ... How frequently does it happen?
> > > 
> > > On my x86-64 boxes the "APIC error on CPU0" message appears on every resume,
> > > but it doesn't seem to be related to any visible problems.
> > > 
> > > It's been there forever, AFAICT.
> > 
> > Yes, it is there on every resume.
> 
> Here too... so it's common on x86_64   ;)
> 
> 
> 	$ dmesg | grep Suspending | wc -l
> 	9
> 
> 	$ dmesg | grep "APIC err" | wc -l
> 	9
> 
Could you try the following, as of yet untested patch?
It's i386 twin makes an APIC error vanish here on a K8.

      Karsten
-----------------------------------------------------------------------
>From 54248a43231de8d6d64354b51646c54121e3f395 Mon Sep 17 00:00:00 2001
From: Karsten Wiese <fzu@wemgehoertderstaat.de>
Date: Sat, 18 Nov 2006 13:44:14 +0100
Subject: [PATCH 1/1] x86_64: Regard MSRs in lapic_suspend()/lapic_resume()

Read/Write APIC_LVTPC and APIC_LVTTHMR only,
if get_maxlvt() returns certain values.
This is a port to x86_64 from an equaly titled patch against i386.

Signed-off-by: Karsten Wiese <fzu@wemgehoertderstaat.de>
---
 arch/x86_64/kernel/apic.c |   25 +++++++++++++++++++++----
 1 files changed, 21 insertions(+), 4 deletions(-)

diff --git a/arch/x86_64/kernel/apic.c b/arch/x86_64/kernel/apic.c
index 4d9d5ed..16d6755 100644
--- a/arch/x86_64/kernel/apic.c
+++ b/arch/x86_64/kernel/apic.c
@@ -452,23 +452,31 @@ static struct {
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
+
 	local_irq_save(flags);
 	disable_local_APIC();
 	local_irq_restore(flags);
@@ -479,15 +487,20 @@ static int lapic_resume(struct sys_devic
 {
 	unsigned int l, h;
 	unsigned long flags;
+	int maxlvt;
 
 	if (!apic_pm_state.active)
 		return 0;
 
+	maxlvt = get_maxlvt();
+
 	local_irq_save(flags);
+
 	rdmsr(MSR_IA32_APICBASE, l, h);
 	l &= ~MSR_IA32_APICBASE_BASE;
 	l |= MSR_IA32_APICBASE_ENABLE | mp_lapic_addr;
 	wrmsr(MSR_IA32_APICBASE, l, h);
+
 	apic_write(APIC_LVTERR, ERROR_APIC_VECTOR | APIC_LVT_MASKED);
 	apic_write(APIC_ID, apic_pm_state.apic_id);
 	apic_write(APIC_DFR, apic_pm_state.apic_dfr);
@@ -496,8 +509,12 @@ static int lapic_resume(struct sys_devic
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
