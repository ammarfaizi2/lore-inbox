Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262248AbVAIE3f@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262248AbVAIE3f (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 8 Jan 2005 23:29:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262249AbVAIE3f
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 8 Jan 2005 23:29:35 -0500
Received: from fsmlabs.com ([168.103.115.128]:10115 "EHLO fsmlabs.com")
	by vger.kernel.org with ESMTP id S262248AbVAIE30 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 8 Jan 2005 23:29:26 -0500
Date: Sat, 8 Jan 2005 21:29:23 -0700 (MST)
From: Zwane Mwaikambo <zwane@arm.linux.org.uk>
To: Linux PPC64 <linuxppc64-dev@ozlabs.org>
cc: Linux Kernel <linux-kernel@vger.kernel.org>, Andrew Morton <akpm@osdl.org>,
       Anton Blanchard <anton@samba.org>
Subject: [PATCH] PPC64: Move hotplug cpu functions to smp_ops
Message-ID: <Pine.LNX.4.61.0501082114520.13639@montezuma.fsmlabs.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This should allow for easier adding of hotplug cpu support for other PPC64 
subarchs. The patch is untested but does compile with and without hotplug 
cpu on pSeries and G5 configs. What can get slightly confusing is the fact 
that both ppc_md and smp_ops have cpu_die members.

 arch/ppc64/kernel/pSeries_smp.c |    9 +++++++--
 arch/ppc64/kernel/smp.c         |   16 ++++++++++++++++
 include/asm-ppc64/machdep.h     |    2 ++
 3 files changed, 25 insertions(+), 2 deletions(-)

Signed-off-by: Zwane Mwaikambo <zwane@arm.linux.org.uk>

Index: linux-2.6.10-mm1-ppc64/arch/ppc64/kernel/pSeries_smp.c
===================================================================
RCS file: /home/cvsroot/linux-2.6.10-mm1/arch/ppc64/kernel/pSeries_smp.c,v
retrieving revision 1.1.1.1
diff -u -p -B -r1.1.1.1 pSeries_smp.c
--- linux-2.6.10-mm1-ppc64/arch/ppc64/kernel/pSeries_smp.c	4 Jan 2005 04:03:33 -0000	1.1.1.1
+++ linux-2.6.10-mm1-ppc64/arch/ppc64/kernel/pSeries_smp.c	9 Jan 2005 03:42:19 -0000
@@ -88,7 +88,7 @@ static int query_cpu_stopped(unsigned in
 
 #ifdef CONFIG_HOTPLUG_CPU
 
-int __cpu_disable(void)
+int pSeries_cpu_disable(void)
 {
 	/* FIXME: go put this in a header somewhere */
 	extern void xics_migrate_irqs_away(void);
@@ -106,7 +106,7 @@ int __cpu_disable(void)
 	return 0;
 }
 
-void __cpu_die(unsigned int cpu)
+void pSeries_cpu_die(unsigned int cpu)
 {
 	int tries;
 	int cpu_status;
@@ -355,6 +355,11 @@ void __init smp_init_pSeries(void)
 	else
 		smp_ops = &pSeries_xics_smp_ops;
 
+#ifdef CONFIG_HOTPLUG_CPU
+	smp_ops->cpu_disable = pSeries_cpu_disable;
+	smp_ops->cpu_die = pSeries_cpu_die;
+#endif
+
 	/* Start secondary threads on SMT systems; primary threads
 	 * are already in the running state.
 	 */
Index: linux-2.6.10-mm1-ppc64/arch/ppc64/kernel/smp.c
===================================================================
RCS file: /home/cvsroot/linux-2.6.10-mm1/arch/ppc64/kernel/smp.c,v
retrieving revision 1.1.1.1
diff -u -p -B -r1.1.1.1 smp.c
--- linux-2.6.10-mm1-ppc64/arch/ppc64/kernel/smp.c	4 Jan 2005 04:03:33 -0000	1.1.1.1
+++ linux-2.6.10-mm1-ppc64/arch/ppc64/kernel/smp.c	9 Jan 2005 03:48:56 -0000
@@ -557,3 +557,19 @@ void __init smp_cpus_done(unsigned int m
 	 */
 	cpu_present_map = cpu_possible_map;
 }
+
+#ifdef CONFIG_HOTPLUG_CPU
+int __cpu_disable(void)
+{
+	if (smp_ops->cpu_disable)
+		return smp_ops->cpu_disable();
+
+	return -ENOSYS;
+}
+
+void __cpu_die(unsigned int cpu)
+{
+	if (smp_ops->cpu_die)
+		smp_ops->cpu_die(cpu);
+}
+#endif
Index: linux-2.6.10-mm1-ppc64/include/asm-ppc64/machdep.h
===================================================================
RCS file: /home/cvsroot/linux-2.6.10-mm1/include/asm-ppc64/machdep.h,v
retrieving revision 1.1.1.1
diff -u -p -B -r1.1.1.1 machdep.h
--- linux-2.6.10-mm1-ppc64/include/asm-ppc64/machdep.h	4 Jan 2005 04:03:40 -0000	1.1.1.1
+++ linux-2.6.10-mm1-ppc64/include/asm-ppc64/machdep.h	9 Jan 2005 03:50:21 -0000
@@ -31,6 +31,8 @@ struct smp_ops_t {
 	void  (*late_setup_cpu)(int nr);
 	void  (*take_timebase)(void);
 	void  (*give_timebase)(void);
+	int   (*cpu_disable)(void);
+	void  (*cpu_die)(unsigned int nr);
 };
 #endif
 
