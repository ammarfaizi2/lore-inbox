Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751769AbWB0Wai@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751769AbWB0Wai (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 27 Feb 2006 17:30:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751760AbWB0Wah
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 27 Feb 2006 17:30:37 -0500
Received: from 216-99-217-87.dsl.aracnet.com ([216.99.217.87]:35714 "EHLO
	sorel.sous-sol.org") by vger.kernel.org with ESMTP id S1751769AbWB0Wad
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 27 Feb 2006 17:30:33 -0500
Message-Id: <20060227223324.852289000@sorel.sous-sol.org>
References: <20060227223200.865548000@sorel.sous-sol.org>
Date: Mon, 27 Feb 2006 14:32:05 -0800
From: Chris Wright <chrisw@sous-sol.org>
To: linux-kernel@vger.kernel.org, stable@kernel.org
Cc: Justin Forbes <jmforbes@linuxtx.org>,
       Zwane Mwaikambo <zwane@arm.linux.org.uk>,
       "Theodore Ts'o" <tytso@mit.edu>, Randy Dunlap <rdunlap@xenotime.net>,
       Dave Jones <davej@redhat.com>, Chuck Wolber <chuckw@quantumlinux.com>,
       torvalds@osdl.org, akpm@osdl.org, alan@lxorguk.ukuu.org.uk,
       Andi Kleen <ak@suse.de>, Greg Kroah-Hartman <gregkh@suse.de>
Subject: [patch 05/39] [PATCH] i386: Move phys_proc_id/early intel workaround to correct function
Content-Disposition: inline; filename=i386-move-phys_proc_id-early-intel-workaround-to-correct-function.patch
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-stable review patch.  If anyone has any objections, please let us know.
------------------

early_cpu_detect only runs on the BP, but this code needs to run
on all CPUs. This will fix problems with the powernow-k8 driver
on dual core systems and general misdetection of AMD dual core.

Looks like a mismerge somewhere.  Also add a warning comment.

Signed-off-by: Andi Kleen <ak@suse.de>
Signed-off-by: Chris Wright <chrisw@sous-sol.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@suse.de>
---

 arch/i386/kernel/cpu/common.c |   17 ++++++++++-------
 1 files changed, 10 insertions(+), 7 deletions(-)

--- linux-2.6.15.4.orig/arch/i386/kernel/cpu/common.c
+++ linux-2.6.15.4/arch/i386/kernel/cpu/common.c
@@ -207,7 +207,10 @@ static int __devinit have_cpuid_p(void)
 
 /* Do minimum CPU detection early.
    Fields really needed: vendor, cpuid_level, family, model, mask, cache alignment.
-   The others are not touched to avoid unwanted side effects. */
+   The others are not touched to avoid unwanted side effects.
+
+   WARNING: this function is only called on the BP.  Don't add code here
+   that is supposed to run on all CPUs. */
 static void __init early_cpu_detect(void)
 {
 	struct cpuinfo_x86 *c = &boot_cpu_data;
@@ -239,12 +242,6 @@ static void __init early_cpu_detect(void
 		if (cap0 & (1<<19))
 			c->x86_cache_alignment = ((misc >> 8) & 0xff) * 8;
 	}
-
-	early_intel_workaround(c);
-
-#ifdef CONFIG_X86_HT
-	phys_proc_id[smp_processor_id()] = (cpuid_ebx(1) >> 24) & 0xff;
-#endif
 }
 
 void __devinit generic_identify(struct cpuinfo_x86 * c)
@@ -292,6 +289,12 @@ void __devinit generic_identify(struct c
 				get_model_name(c); /* Default name */
 		}
 	}
+
+	early_intel_workaround(c);
+
+#ifdef CONFIG_X86_HT
+	phys_proc_id[smp_processor_id()] = (cpuid_ebx(1) >> 24) & 0xff;
+#endif
 }
 
 static void __devinit squash_the_stupid_serial_number(struct cpuinfo_x86 *c)

--
