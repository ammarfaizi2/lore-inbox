Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750741AbWHBKLY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750741AbWHBKLY (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 2 Aug 2006 06:11:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750750AbWHBKLY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 2 Aug 2006 06:11:24 -0400
Received: from ns.oss.ntt.co.jp ([222.151.198.98]:31724 "EHLO
	serv1.oss.ntt.co.jp") by vger.kernel.org with ESMTP
	id S1750741AbWHBKLY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 2 Aug 2006 06:11:24 -0400
Subject: [PATCH] x86_64: Replace local_save_flags+local_irq_disable with
	local_irq_save.
From: Fernando Luis =?ISO-8859-1?Q?V=E1zquez?= Cao 
	<fernando@oss.ntt.co.jp>
To: Andi Kleen <ak@suse.de>
Cc: linux-kernel@vger.kernel.org
Content-Type: text/plain
Organization: =?UTF-8?Q?NTT=E3=82=AA=E3=83=BC=E3=83=97=E3=83=B3=E3=82=BD=E3=83=BC?=
	=?UTF-8?Q?=E3=82=B9=E3=82=BD=E3=83=95=E3=83=88=E3=82=A6=E3=82=A7?=
	=?UTF-8?Q?=E3=82=A2=E3=82=BB=E3=83=B3=E3=82=BF?=
Date: Wed, 02 Aug 2006 19:11:20 +0900
Message-Id: <1154513480.3268.21.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.2 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

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
---

diff -urNp linux-2.6.18-rc3/arch/x86_64/kernel/apic.c linux-2.6.18-rc3-orig/arch/x86_64/kernel/apic.c
--- linux-2.6.18-rc3/arch/x86_64/kernel/apic.c	2006-08-02 18:05:41.000000000 +0900
+++ linux-2.6.18-rc3-orig/arch/x86_64/kernel/apic.c	2006-08-02 18:08:24.000000000 +0900
@@ -527,8 +527,7 @@ static int lapic_suspend(struct sys_devi
 	apic_pm_state.apic_tmict = apic_read(APIC_TMICT);
 	apic_pm_state.apic_tdcr = apic_read(APIC_TDCR);
 	apic_pm_state.apic_thmr = apic_read(APIC_LVTTHMR);
-	local_save_flags(flags);
-	local_irq_disable();
+	local_irq_save(flags);
 	disable_local_APIC();
 	local_irq_restore(flags);
 	return 0;
diff -urNp linux-2.6.18-rc3/arch/x86_64/kernel/genapic_flat.c linux-2.6.18-rc3-orig/arch/x86_64/kernel/genapic_flat.c
--- linux-2.6.18-rc3/arch/x86_64/kernel/genapic_flat.c	2006-08-02 18:05:41.000000000 +0900
+++ linux-2.6.18-rc3-orig/arch/x86_64/kernel/genapic_flat.c	2006-08-02 18:09:18.000000000 +0900
@@ -49,8 +49,7 @@ static void flat_send_IPI_mask(cpumask_t
 	unsigned long cfg;
 	unsigned long flags;
 
-	local_save_flags(flags);
-	local_irq_disable();
+	local_irq_save(flags);
 
 	/*
 	 * Wait for idle.


