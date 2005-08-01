Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261249AbVHAVN0@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261249AbVHAVN0 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 1 Aug 2005 17:13:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261239AbVHAUeo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 1 Aug 2005 16:34:44 -0400
Received: from fmr17.intel.com ([134.134.136.16]:5844 "EHLO
	orsfmr002.jf.intel.com") by vger.kernel.org with ESMTP
	id S261232AbVHAUdR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 1 Aug 2005 16:33:17 -0400
Message-Id: <20050801203011.178499000@araj-em64t>
References: <20050801202017.043754000@araj-em64t>
Date: Mon, 01 Aug 2005 13:20:20 -0700
From: Ashok Raj <ashok.raj@intel.com>
To: Andrew Morton <akpm@osdl.org>
Cc: Ashok Raj <ashok.raj@intel.com>, Andi Kleen <ak@muc.de>,
       zwane@arm.linux.org.uk, linux-kernel@vger.kernel.org
Subject: [patch 3/8] x86_64:Dont call enforce_max_cpus when hotplug is enabled
Content-Disposition: inline; filename=fix-enforce-max-cpu
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

No need to enforce_max_cpus when hotplug code is enabled. This
nukes out cpu_present_map and cpu_possible_map making it impossible to add
new cpus in the system.

Signed-off-by: Ashok Raj <ashok.raj@intel.com>
------------------------------------------------
 arch/x86_64/kernel/smpboot.c |   40 +++++++++++++++++++++++-----------------
 1 files changed, 23 insertions(+), 17 deletions(-)

Index: linux-2.6.13-rc4-mm1/arch/x86_64/kernel/smpboot.c
===================================================================
--- linux-2.6.13-rc4-mm1.orig/arch/x86_64/kernel/smpboot.c
+++ linux-2.6.13-rc4-mm1/arch/x86_64/kernel/smpboot.c
@@ -893,23 +893,6 @@ static __init void disable_smp(void)
 	cpu_set(0, cpu_core_map[0]);
 }
 
-/*
- * Handle user cpus=... parameter.
- */
-static __init void enforce_max_cpus(unsigned max_cpus)
-{
-	int i, k;
-	k = 0;
-	for (i = 0; i < NR_CPUS; i++) {
-		if (!cpu_possible(i))
-			continue;
-		if (++k > max_cpus) {
-			cpu_clear(i, cpu_possible_map);
-			cpu_clear(i, cpu_present_map);
-		}
-	}
-}
-
 #ifdef CONFIG_HOTPLUG_CPU
 /*
  * cpu_possible_map should be static, it cannot change as cpu's
@@ -929,6 +912,29 @@ static void prefill_possible_map(void)
 	for (i = 0; i < NR_CPUS; i++)
 		cpu_set(i, cpu_possible_map);
 }
+
+/*
+ * Dont need this when we have hotplug enabled
+ */
+#define enforce_max_cpus(x)
+
+#else
+/*
+ * Handle user cpus=... parameter.
+ */
+static __init void enforce_max_cpus(unsigned max_cpus)
+{
+	int i, k;
+	k = 0;
+
+	for_each_cpu(i) {
+		if (++k > max_cpus) {
+			cpu_clear(i, cpu_possible_map);
+			cpu_clear(i, cpu_present_map);
+		}
+	}
+}
+
 #endif
 
 /*

--

