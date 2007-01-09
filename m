Return-Path: <linux-kernel-owner+w=401wt.eu-S932136AbXAIPGa@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932136AbXAIPGa (ORCPT <rfc822;w@1wt.eu>);
	Tue, 9 Jan 2007 10:06:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932138AbXAIPGa
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 9 Jan 2007 10:06:30 -0500
Received: from mtagate1.uk.ibm.com ([195.212.29.134]:45703 "EHLO
	mtagate1.uk.ibm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932136AbXAIPG3 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 9 Jan 2007 10:06:29 -0500
Date: Tue, 9 Jan 2007 16:06:15 +0100
From: Heiko Carstens <heiko.carstens@de.ibm.com>
To: Srivatsa Vaddagiri <vatsa@in.ibm.com>
Cc: Benjamin Gilbert <bgilbert@cs.cmu.edu>, linux-kernel@vger.kernel.org,
       Ingo Molnar <mingo@elte.hu>, Gautham shenoy <ego@in.ibm.com>,
       Andrew Morton <akpm@osdl.org>, Pekka Enberg <penberg@cs.helsinki.fi>
Subject: [patch -mm] slab: use CPU_LOCK_[ACQUIRE|RELEASE]
Message-ID: <20070109150615.GF9563@osiris.boeblingen.de.ibm.com>
References: <20070108120719.16d4674e.bgilbert@cs.cmu.edu> <20070109121738.GC9563@osiris.boeblingen.de.ibm.com> <20070109122740.GC22080@in.ibm.com> <20070109150351.GD9563@osiris.boeblingen.de.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20070109150351.GD9563@osiris.boeblingen.de.ibm.com>
User-Agent: mutt-ng/devel-r804 (Linux)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Heiko Carstens <heiko.carstens@de.ibm.com>

Looks like this was forgotten when CPU_LOCK_[ACQUIRE|RELEASE] was
introduced.

Cc: Pekka Enberg <penberg@cs.helsinki.fi>
Cc: Srivatsa Vaddagiri <vatsa@in.ibm.com>
Cc: Gautham Shenoy <ego@in.ibm.com>
Signed-off-by: Heiko Carstens <heiko.carstens@de.ibm.com>
---
 mm/slab.c |   13 +++++--------
 1 files changed, 5 insertions(+), 8 deletions(-)

Index: linux-2.6.20-rc3-mm1/mm/slab.c
===================================================================
--- linux-2.6.20-rc3-mm1.orig/mm/slab.c
+++ linux-2.6.20-rc3-mm1/mm/slab.c
@@ -1177,8 +1177,10 @@ static int __cpuinit cpuup_callback(stru
 	int memsize = sizeof(struct kmem_list3);
 
 	switch (action) {
-	case CPU_UP_PREPARE:
+	case CPU_LOCK_ACQUIRE:
 		mutex_lock(&cache_chain_mutex);
+		break;
+	case CPU_UP_PREPARE:
 		/*
 		 * We need to do this right in the beginning since
 		 * alloc_arraycache's are going to use this list.
@@ -1264,16 +1266,9 @@ static int __cpuinit cpuup_callback(stru
 		}
 		break;
 	case CPU_ONLINE:
-		mutex_unlock(&cache_chain_mutex);
 		start_cpu_timer(cpu);
 		break;
 #ifdef CONFIG_HOTPLUG_CPU
-	case CPU_DOWN_PREPARE:
-		mutex_lock(&cache_chain_mutex);
-		break;
-	case CPU_DOWN_FAILED:
-		mutex_unlock(&cache_chain_mutex);
-		break;
 	case CPU_DEAD:
 		/*
 		 * Even if all the cpus of a node are down, we don't free the
@@ -1344,6 +1339,8 @@ free_array_cache:
 				continue;
 			drain_freelist(cachep, l3, l3->free_objects);
 		}
+		break;
+	case CPU_LOCK_RELEASE:
 		mutex_unlock(&cache_chain_mutex);
 		break;
 	}
