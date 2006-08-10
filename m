Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932174AbWHJTrj@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932174AbWHJTrj (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 10 Aug 2006 15:47:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932678AbWHJThY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 10 Aug 2006 15:37:24 -0400
Received: from ns.suse.de ([195.135.220.2]:8337 "EHLO mx1.suse.de")
	by vger.kernel.org with ESMTP id S932652AbWHJThB (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 10 Aug 2006 15:37:01 -0400
From: Andi Kleen <ak@suse.de>
References: <20060810 935.775038000@suse.de>
In-Reply-To: <20060810 935.775038000@suse.de>
Subject: [PATCH for review] [101/145] x86_64: Replace local_save_flags+local_irq_disable with
Message-Id: <20060810193659.26C3613C0B@wotan.suse.de>
Date: Thu, 10 Aug 2006 21:36:59 +0200 (CEST)
To: undisclosed-recipients:;
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

r

From: Fernando Luis =?ISO-8859-1?Q?V=E1zquez?= Cao <fernando@oss.ntt.co.jp>

The combination of "local_save_flags" and "local_irq_disable" seems to be
equivalent to "local_irq_save" (see code snips below). Consequently, replace
occurrences of local_save_flags+local_irq_disable with local_irq_save.

* local_irq_save
#define raw_local_irq_save(flags) \
                do { (flags) = __raw_local_irq_save(); } while (0)

static inline unsigned long __raw_local_irq_save(void)
{
        unsigned long flags = __raw_local_save_flags();

        raw_local_irq_disable();

        return flags;
}

* local_save_flags
#define raw_local_save_flags(flags) \
                do { (flags) = __raw_local_save_flags(); } while (0)

Signed-off-by: Fernando Vazquez <fernando@intellilink.co.jp>
Signed-off-by: Andi Kleen <ak@suse.de>

---

---
 arch/x86_64/kernel/apic.c         |    3 +--
 arch/x86_64/kernel/genapic_flat.c |    3 +--
 2 files changed, 2 insertions(+), 4 deletions(-)

Index: linux/arch/x86_64/kernel/apic.c
===================================================================
--- linux.orig/arch/x86_64/kernel/apic.c
+++ linux/arch/x86_64/kernel/apic.c
@@ -468,8 +468,7 @@ static int lapic_suspend(struct sys_devi
 	apic_pm_state.apic_tmict = apic_read(APIC_TMICT);
 	apic_pm_state.apic_tdcr = apic_read(APIC_TDCR);
 	apic_pm_state.apic_thmr = apic_read(APIC_LVTTHMR);
-	local_save_flags(flags);
-	local_irq_disable();
+	local_irq_save(flags);
 	disable_local_APIC();
 	local_irq_restore(flags);
 	return 0;
Index: linux/arch/x86_64/kernel/genapic_flat.c
===================================================================
--- linux.orig/arch/x86_64/kernel/genapic_flat.c
+++ linux/arch/x86_64/kernel/genapic_flat.c
@@ -49,8 +49,7 @@ static void flat_send_IPI_mask(cpumask_t
 	unsigned long cfg;
 	unsigned long flags;
 
-	local_save_flags(flags);
-	local_irq_disable();
+	local_irq_save(flags);
 
 	/*
 	 * Wait for idle.
