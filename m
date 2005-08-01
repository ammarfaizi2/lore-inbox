Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261226AbVHAUgv@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261226AbVHAUgv (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 1 Aug 2005 16:36:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261241AbVHAUe5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 1 Aug 2005 16:34:57 -0400
Received: from fmr18.intel.com ([134.134.136.17]:37801 "EHLO
	orsfmr003.jf.intel.com") by vger.kernel.org with ESMTP
	id S261226AbVHAUdQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 1 Aug 2005 16:33:16 -0400
Message-Id: <20050801203011.290911000@araj-em64t>
References: <20050801202017.043754000@araj-em64t>
Date: Mon, 01 Aug 2005 13:20:21 -0700
From: Ashok Raj <ashok.raj@intel.com>
To: Andrew Morton <akpm@osdl.org>
Cc: Ashok Raj <ashok.raj@intel.com>, Andi Kleen <ak@muc.de>,
       zwane@arm.linux.org.uk, linux-kernel@vger.kernel.org
Subject: [patch 4/8] x86_64:Fix cluster mode send_IPI_allbutself to use get_cpu()/put_cpu()
Content-Disposition: inline; filename=fix-cluster-allbutself-ipi
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Need to ensure we dont get prempted when we clear ourself from mask when using
clustered mode genapic code.

Signed-off-by: Ashok Raj <ashok.raj@intel.com>
---------------------------------------------------------
 arch/x86_64/kernel/genapic_cluster.c |    6 +++++-
 1 files changed, 5 insertions(+), 1 deletion(-)

Index: linux-2.6.13-rc4-mm1/arch/x86_64/kernel/genapic_cluster.c
===================================================================
--- linux-2.6.13-rc4-mm1.orig/arch/x86_64/kernel/genapic_cluster.c
+++ linux-2.6.13-rc4-mm1/arch/x86_64/kernel/genapic_cluster.c
@@ -72,10 +72,14 @@ static void cluster_send_IPI_mask(cpumas
 static void cluster_send_IPI_allbutself(int vector)
 {
 	cpumask_t mask = cpu_online_map;
-	cpu_clear(smp_processor_id(), mask);
+	int me = get_cpu(); /* Ensure we are not preempted when we clear */
+
+	cpu_clear(me, mask);
 
 	if (!cpus_empty(mask))
 		cluster_send_IPI_mask(mask, vector);
+
+	put_cpu();
 }
 
 static void cluster_send_IPI_all(int vector)

--

