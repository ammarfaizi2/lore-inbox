Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261888AbVCUVwu@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261888AbVCUVwu (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 21 Mar 2005 16:52:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261990AbVCUVtt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 21 Mar 2005 16:49:49 -0500
Received: from orb.pobox.com ([207.8.226.5]:16011 "EHLO orb.pobox.com")
	by vger.kernel.org with ESMTP id S262040AbVCUVps (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 21 Mar 2005 16:45:48 -0500
Date: Mon, 21 Mar 2005 15:45:37 -0600
From: Nathan Lynch <ntl@pobox.com>
To: Linus Torvalds <torvalds@osdl.org>
Cc: Andrew Morton <akpm@osdl.org>, Paul Mackerras <paulus@samba.org>,
       Anton Blanchard <anton@samba.org>, lkml <linux-kernel@vger.kernel.org>,
       linuxppc64-dev@ozlabs.org
Subject: ppc64 pSeries build broken in 2.6.12-rc1-bk1
Message-ID: <20050321214537.GC16469@otto>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi-

It seems that the "pSeries reconfig" patch series which Paul sent on
March 17th to Andrew on my behalf was incompletely merged into bk?  It
looks like only the last two of the series are in -bk as of today
(2.6.12-rc1-mm1 has them all).

Subject lines and URLs for the series in question:

[PATCH 1/8] PPC64 preliminary changes to OF fixup functions
       http://lkml.org/lkml/2005/3/17/41

[PATCH 2/8] PPC64 make OF node fixup code usable at runtime
       http://lkml.org/lkml/2005/3/17/40

[PATCH 3/8] PPC64 introduce pSeries_reconfig.[ch]
       http://lkml.org/lkml/2005/3/17/43

[PATCH 4/8] PPC64 prom.c: use pSeries reconfig notifier
       http://lkml.org/lkml/2005/3/17/56

[PATCH 5/8] PPC64 pci_dn.c: use pSeries reconfig notifier
       http://lkml.org/lkml/2005/3/17/57

[PATCH 6/8] PPC64 pSeries_iommu.c: use pSeries reconfig notifier
       http://lkml.org/lkml/2005/3/17/54

[PATCH 7/8] PPC64 use pSeries reconfig notifier for cpu DLPAR
       http://lkml.org/lkml/2005/3/17/44

[PATCH 8/8] PPC64 make cpu hotplug play well with maxcpus and smt-enabled
       http://lkml.org/lkml/2005/3/17/55

With 2.6.12-rc1-bk1, if CONFIG_PPC_PSERIES and CONFIG_SMP are enabled,
the build errors out:

  CC      arch/ppc64/kernel/pSeries_smp.o
arch/ppc64/kernel/pSeries_smp.c:47:34: asm/pSeries_reconfig.h: No such
file or directory

If people would like something to use in the meantime, below is a
throwaway patch to work around the breakage (not intended for
inclusion).  Disabling CONFIG_PPC_PSERIES should work around it also.
The real fix is to either revert patches 7 and 8, or merge 1-6 :)


Nathan



Index: linux-2.6.12-rc1-bk1/arch/ppc64/kernel/pSeries_smp.c
===================================================================
--- linux-2.6.12-rc1-bk1.orig/arch/ppc64/kernel/pSeries_smp.c	2005-03-21 20:28:22.000000000 +0000
+++ linux-2.6.12-rc1-bk1/arch/ppc64/kernel/pSeries_smp.c	2005-03-21 21:00:16.000000000 +0000
@@ -44,7 +44,7 @@
 #include <asm/system.h>
 #include <asm/rtas.h>
 #include <asm/plpar_wrappers.h>
-#include <asm/pSeries_reconfig.h>
+/* #include <asm/pSeries_reconfig.h> */
 
 #include "mpic.h"
 
@@ -135,6 +135,7 @@ void pSeries_cpu_die(unsigned int cpu)
  * the logical ids for sibling SMT threads x and y are adjacent, such
  * that x^1 == y and y^1 == x.
  */
+#if 0
 static int pSeries_add_processor(struct device_node *np)
 {
 	unsigned int cpu;
@@ -247,7 +248,7 @@ static int pSeries_smp_notifier(struct n
 static struct notifier_block pSeries_smp_nb = {
 	.notifier_call = pSeries_smp_notifier,
 };
-
+#endif /* 0 */
 #endif /* CONFIG_HOTPLUG_CPU */
 
 /**
@@ -421,9 +422,11 @@ void __init smp_init_pSeries(void)
 	smp_ops->cpu_die = pSeries_cpu_die;
 
 	/* Processors can be added/removed only on LPAR */
+#if 0
 	if (systemcfg->platform == PLATFORM_PSERIES_LPAR)
 		pSeries_reconfig_notifier_register(&pSeries_smp_nb);
 #endif
+#endif
 
 	/* Mark threads which are still spinning in hold loops. */
 	if (cur_cpu_spec->cpu_features & CPU_FTR_SMT)
