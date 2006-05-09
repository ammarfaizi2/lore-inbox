Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751481AbWEIItI@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751481AbWEIItI (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 9 May 2006 04:49:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751533AbWEIIs7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 9 May 2006 04:48:59 -0400
Received: from 216-99-217-87.dsl.aracnet.com ([216.99.217.87]:50051 "EHLO
	sous-sol.org") by vger.kernel.org with ESMTP id S1751484AbWEIIss
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 9 May 2006 04:48:48 -0400
Message-Id: <20060509085156.694312000@sous-sol.org>
References: <20060509084945.373541000@sous-sol.org>
Date: Tue, 09 May 2006 00:00:22 -0700
From: Chris Wright <chrisw@sous-sol.org>
To: linux-kernel@vger.kernel.org
Cc: virtualization@lists.osdl.org, xen-devel@lists.xensource.com,
       Ian Pratt <ian.pratt@xensource.com>,
       Christian Limpach <Christian.Limpach@cl.cam.ac.uk>
Subject: [RFC PATCH 22/35] subarch suport for idle loop (NO_IDLE_HZ for Xen)
Content-Disposition: inline; filename=i386-idle
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Paravirtualize the idle loop to explicitly trap to the hypervisor when
blocking, and to use the NO_IDLE_HZ functionality introduced by s390
to inform the rcu subsystem that the CPU is quiescent.

Signed-off-by: Ian Pratt <ian.pratt@xensource.com>
Signed-off-by: Christian Limpach <Christian.Limpach@cl.cam.ac.uk>
Signed-off-by: Chris Wright <chrisw@sous-sol.org>
---
 drivers/xen/Kconfig                         |    8 ++++++++
 include/asm-i386/mach-xen/setup_arch_post.h |   24 ++++++++++++++++++++++++
 2 files changed, 32 insertions(+)

--- linus-2.6.orig/drivers/xen/Kconfig
+++ linus-2.6/drivers/xen/Kconfig
@@ -12,6 +12,14 @@ config XEN
 
 if XEN
 
+config NO_IDLE_HZ
+	bool
+	default y
+	help
+	  Switches the regular HZ timer off when the system is going idle.
+	  This helps Xen to detect that the Linux system is idle, reducing
+	  the overhead of idle systems.
+
 config XEN_SHADOW_MODE
 	bool
 	default y
--- linus-2.6.orig/include/asm-i386/mach-xen/setup_arch_post.h
+++ linus-2.6/include/asm-i386/mach-xen/setup_arch_post.h
@@ -8,6 +8,11 @@
 
 #include <xen/interface/physdev.h>
 
+extern void stop_hz_timer(void);
+extern void start_hz_timer(void);
+
+void xen_idle(void);
+
 static char * __init machine_specific_memory_setup(void)
 {
 	unsigned long max_pfn = xen_start_info->nr_pages;
@@ -65,4 +70,23 @@ static void __init machine_specific_arch
 		console_use_vt = 0;
 		conswitchp = NULL;
 	}
+
+	pm_idle = xen_idle;
+}
+
+void xen_idle(void)
+{
+	local_irq_disable();
+
+	if (need_resched())
+		local_irq_enable();
+	else {
+		clear_thread_flag(TIF_POLLING_NRFLAG);
+		smp_mb__after_clear_bit();
+		stop_hz_timer();
+		/* Blocking includes an implicit local_irq_enable(). */
+		HYPERVISOR_sched_op(SCHEDOP_block, 0);
+		start_hz_timer();
+		set_thread_flag(TIF_POLLING_NRFLAG);
+	}
 }

--
