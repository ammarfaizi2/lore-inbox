Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261614AbULTTQi@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261614AbULTTQi (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 20 Dec 2004 14:16:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261616AbULTTQh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 20 Dec 2004 14:16:37 -0500
Received: from fsmlabs.com ([168.103.115.128]:1497 "EHLO fsmlabs.com")
	by vger.kernel.org with ESMTP id S261614AbULTTQe (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 20 Dec 2004 14:16:34 -0500
Date: Mon, 20 Dec 2004 12:16:02 -0700 (MST)
From: Zwane Mwaikambo <zwane@fsmlabs.com>
To: Anton Blanchard <anton@samba.org>
cc: Linux Kernel <linux-kernel@vger.kernel.org>, Andrew Morton <akpm@osdl.org>,
       Linux PPC64 <linuxppc64-dev@ozlabs.org>
Subject: [PATCH] Fix hotplug cpu on ppc64
Message-ID: <Pine.LNX.4.61.0412201212450.12296@montezuma.fsmlabs.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I seem to have broken this when i moved the clearing of the dying cpu to 
arch specific code.

Signed-off-by: Zwane Mwaikambo <zwane@fsmlabs.com>

Index: linux-2.6.10-rc3-mm1/arch/ppc64/kernel/pSeries_smp.c
===================================================================
RCS file: /home/cvsroot/linux-2.6.10-rc3-mm1/arch/ppc64/kernel/pSeries_smp.c,v
retrieving revision 1.1.1.1
diff -u -p -B -r1.1.1.1 pSeries_smp.c
--- linux-2.6.10-rc3-mm1/arch/ppc64/kernel/pSeries_smp.c	13 Dec 2004 14:26:53 -0000	1.1.1.1
+++ linux-2.6.10-rc3-mm1/arch/ppc64/kernel/pSeries_smp.c	20 Dec 2004 19:12:02 -0000
@@ -92,11 +92,13 @@ int __cpu_disable(void)
 {
 	/* FIXME: go put this in a header somewhere */
 	extern void xics_migrate_irqs_away(void);
+	int cpu = smp_processor_id();
 
+	cpu_clear(cpu, cpu_online_map);
 	systemcfg->processorCount--;
 
 	/*fix boot_cpuid here*/
-	if (smp_processor_id() == boot_cpuid)
+	if (cpu == boot_cpuid)
 		boot_cpuid = any_online_cpu(cpu_online_map);
 
 	/* FIXME: abstract this to not be platform specific later on */
