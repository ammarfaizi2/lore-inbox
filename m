Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262053AbVFHDOF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262053AbVFHDOF (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 7 Jun 2005 23:14:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262081AbVFHDOE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 7 Jun 2005 23:14:04 -0400
Received: from fmr17.intel.com ([134.134.136.16]:46782 "EHLO
	orsfmr002.jf.intel.com") by vger.kernel.org with ESMTP
	id S262053AbVFHDN6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 7 Jun 2005 23:13:58 -0400
Message-Id: <20050608031217.498798000@araj-em64t>
References: <20050608030901.001736000@araj-em64t>
Date: Tue, 07 Jun 2005 20:09:03 -0700
From: Ashok Raj <ashok.raj@intel.com>
To: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
Cc: Zwane Mwaikambo <zwane@arm.linux.org.uk>,
       Srivattsa Vaddagiri <vatsa@in.ibm.com>,
       Shaohua Li <shaohua.li@intel.com>,
       Rusty Russell <rusty@rustycorp.com.au>, Ashok Raj <ashok.raj@intel.com>
Subject: [patch 2/2] i386: hold call_lock when updating cpu_online_map
Content-Disposition: inline; filename=i386-hold-call-lock-when-adding-to-onlinemap.patch
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

We need to hold call-lock when updating cpu-online-map to ensure
the newly upcoming cpu is excluded in an ongoing smp_call_function.

Signed-off-by: Ashok Raj <ashok.raj@intel.com>
Acked-by: Shaohua Li <shaohua.li@intel.com>
-------------------------------------------------
 arch/i386/kernel/smp.c     |   10 ++++++++++
 arch/i386/kernel/smpboot.c |   10 ++++++++++
 include/asm-i386/smp.h     |    2 ++
 3 files changed, 22 insertions(+)

Index: linux-2.6.12-rc6-mm1/arch/i386/kernel/smp.c
===================================================================
--- linux-2.6.12-rc6-mm1.orig/arch/i386/kernel/smp.c
+++ linux-2.6.12-rc6-mm1/arch/i386/kernel/smp.c
@@ -506,6 +506,16 @@ struct call_data_struct {
 	int wait;
 };
 
+void lock_ipi_call_lock(void)
+{
+	spin_lock_irq(&call_lock);
+}
+
+void unlock_ipi_call_lock(void)
+{
+	spin_unlock_irq(&call_lock);
+}
+
 static struct call_data_struct * call_data;
 
 /*
Index: linux-2.6.12-rc6-mm1/include/asm-i386/smp.h
===================================================================
--- linux-2.6.12-rc6-mm1.orig/include/asm-i386/smp.h
+++ linux-2.6.12-rc6-mm1/include/asm-i386/smp.h
@@ -42,6 +42,8 @@ extern void smp_message_irq(int cpl, voi
 extern void smp_invalidate_rcv(void);		/* Process an NMI */
 extern void (*mtrr_hook) (void);
 extern void zap_low_mappings (void);
+extern void lock_ipi_call_lock(void);
+extern void unlock_ipi_call_lock(void);
 
 #define MAX_APICID 256
 extern u8 x86_cpu_to_apicid[];
Index: linux-2.6.12-rc6-mm1/arch/i386/kernel/smpboot.c
===================================================================
--- linux-2.6.12-rc6-mm1.orig/arch/i386/kernel/smpboot.c
+++ linux-2.6.12-rc6-mm1/arch/i386/kernel/smpboot.c
@@ -503,7 +503,17 @@ static void __devinit start_secondary(vo
 	set_cpu_sibling_map(raw_smp_processor_id());
 	wmb();
 
+	/*
+	 * We need to hold call_lock, so there is no inconsistency
+	 * between the time smp_call_function() determines number of
+	 * IPI receipients, and the time when the determination is made
+	 * for which cpus receive the IPI. Holding this
+	 * lock helps us to not include this cpu in a currently in progress
+	 * smp_call_function().
+	 */
+	lock_ipi_call_lock();
 	cpu_set(smp_processor_id(), cpu_online_map);
+	unlock_ipi_call_lock();
 
 	/* We can take interrupts now: we're officially "up". */
 	local_irq_enable();

--

