Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750933AbWCVGid@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750933AbWCVGid (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 22 Mar 2006 01:38:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750924AbWCVGic
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 22 Mar 2006 01:38:32 -0500
Received: from 216-99-217-87.dsl.aracnet.com ([216.99.217.87]:5507 "EHLO
	sorel.sous-sol.org") by vger.kernel.org with ESMTP id S1750909AbWCVGiZ
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 22 Mar 2006 01:38:25 -0500
Message-Id: <20060322063756.907350000@sorel.sous-sol.org>
References: <20060322063040.960068000@sorel.sous-sol.org>
Date: Tue, 21 Mar 2006 22:31:02 -0800
From: Chris Wright <chrisw@sous-sol.org>
To: linux-kernel@vger.kernel.org
Cc: xen-devel@lists.xensource.com, virtualization@lists.osdl.org,
       Ian Pratt <ian.pratt@xensource.com>,
       Christian Limpach <Christian.Limpach@cl.cam.ac.uk>
Subject: [RFC PATCH 22/35] subarch suport for idle loop (NO_IDLE_HZ for Xen)
Content-Disposition: inline; filename=21-i386-idle
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

--- xen-subarch-2.6.orig/drivers/xen/Kconfig
+++ xen-subarch-2.6/drivers/xen/Kconfig
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
--- xen-subarch-2.6.orig/include/asm-i386/mach-xen/setup_arch_post.h
+++ xen-subarch-2.6/include/asm-i386/mach-xen/setup_arch_post.h
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
@@ -74,4 +79,23 @@ static void __init machine_specific_arch
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
