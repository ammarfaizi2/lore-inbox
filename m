Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261239AbVHAVN0@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261239AbVHAVN0 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 1 Aug 2005 17:13:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261235AbVHAUet
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 1 Aug 2005 16:34:49 -0400
Received: from fmr17.intel.com ([134.134.136.16]:5588 "EHLO
	orsfmr002.jf.intel.com") by vger.kernel.org with ESMTP
	id S261231AbVHAUdQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 1 Aug 2005 16:33:16 -0400
Message-Id: <20050801203011.403184000@araj-em64t>
References: <20050801202017.043754000@araj-em64t>
Date: Mon, 01 Aug 2005 13:20:22 -0700
From: Ashok Raj <ashok.raj@intel.com>
To: Andrew Morton <akpm@osdl.org>
Cc: Ashok Raj <ashok.raj@intel.com>, Andi Kleen <ak@muc.de>,
       zwane@arm.linux.org.uk, linux-kernel@vger.kernel.org
Subject: [patch 5/8] x86_64:Dont do broadcast IPIs when hotplug is enabled in flat mode.
Content-Disposition: inline; filename=fix-flat-mode-nobroadcast-again
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

the use of non-shortcut version of routines breaking CPU hotplug. The option
to select this via cmdline also is deleted with the physflat patch, hence
directly placing this code under CONFIG_HOTPLUG_CPU.

We dont want to use broadcast mode IPI's when hotplug is enabled. This causes
bad effects in send IPI to a cpu that is offline which can trip when the 
cpu is in the process of being kicked alive.

Signed-off-by: Ashok Raj <ashok.raj@intel.com>
-------------------------------------------------------
 arch/x86_64/kernel/genapic_flat.c |    8 ++++++++
 1 files changed, 8 insertions(+)

Index: linux-2.6.13-rc4-mm1/arch/x86_64/kernel/genapic_flat.c
===================================================================
--- linux-2.6.13-rc4-mm1.orig/arch/x86_64/kernel/genapic_flat.c
+++ linux-2.6.13-rc4-mm1/arch/x86_64/kernel/genapic_flat.c
@@ -78,8 +78,16 @@ static void flat_send_IPI_mask(cpumask_t
 
 static void flat_send_IPI_allbutself(int vector)
 {
+#ifndef CONFIG_HOTPLUG_CPU
 	if (((num_online_cpus()) - 1) >= 1)
 		__send_IPI_shortcut(APIC_DEST_ALLBUT, vector,APIC_DEST_LOGICAL);
+#else
+	cpumask_t allbutme = cpu_online_map;
+	int me = get_cpu(); /* Ensure we are not preempted when we clear */
+	cpu_clear(me, allbutme);
+	flat_send_IPI_mask(allbutme, vector);
+	put_cpu();
+#endif
 }
 
 static void flat_send_IPI_all(int vector)

--

