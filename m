Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261987AbVDEXpu@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261987AbVDEXpu (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 5 Apr 2005 19:45:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261991AbVDEXpt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 5 Apr 2005 19:45:49 -0400
Received: from smtp206.mail.sc5.yahoo.com ([216.136.129.96]:24427 "HELO
	smtp206.mail.sc5.yahoo.com") by vger.kernel.org with SMTP
	id S261987AbVDEXpa (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 5 Apr 2005 19:45:30 -0400
Message-ID: <42532317.5000901@yahoo.com.au>
Date: Wed, 06 Apr 2005 09:45:27 +1000
From: Nick Piggin <nickpiggin@yahoo.com.au>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.5) Gecko/20050105 Debian/1.7.5-1
X-Accept-Language: en
MIME-Version: 1.0
To: Andrew Morton <akpm@osdl.org>
CC: linux-kernel <linux-kernel@vger.kernel.org>, Ingo Molnar <mingo@elte.hu>,
       "Siddha, Suresh B" <suresh.b.siddha@intel.com>
Subject: [patch 2/5] sched: NULL domains
References: <425322E0.9070307@yahoo.com.au>
In-Reply-To: <425322E0.9070307@yahoo.com.au>
Content-Type: multipart/mixed;
 boundary="------------090609000903040605000102"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------090609000903040605000102
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit

2/5

--------------090609000903040605000102
Content-Type: text/plain;
 name="sched-null-domains.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="sched-null-domains.patch"

The previous patch fixed the last 2 places that directly access a
runqueue's sched-domain and assume it cannot be NULL.

We can now use a NULL domain instead of a dummy domain to signify
no balancing is to happen. No functional changes.

Signed-off-by: Nick Piggin <nickpiggin@yahoo.com.au>

Index: linux-2.6/kernel/sched.c
===================================================================
--- linux-2.6.orig/kernel/sched.c	2005-04-05 16:38:40.000000000 +1000
+++ linux-2.6/kernel/sched.c	2005-04-05 18:39:08.000000000 +1000
@@ -4887,7 +4887,7 @@ void __devinit cpu_attach_domain(struct 
 			tmp->parent = parent->parent;
 	}
 
-	if (sd_degenerate(sd))
+	if (sd && sd_degenerate(sd))
 		sd = sd->parent;
 
 	sched_domain_debug(sd, cpu);
@@ -5054,7 +5054,7 @@ static void __devinit arch_init_sched_do
 	cpus_and(cpu_default_map, cpu_default_map, cpu_online_map);
 
 	/*
-	 * Set up domains. Isolated domains just stay on the dummy domain.
+	 * Set up domains. Isolated domains just stay on the NULL domain.
 	 */
 	for_each_cpu_mask(i, cpu_default_map) {
 		int group;
@@ -5167,18 +5167,11 @@ static void __devinit arch_destroy_sched
 
 #endif /* ARCH_HAS_SCHED_DOMAIN */
 
-/*
- * Initial dummy domain for early boot and for hotplug cpu. Being static,
- * it is initialized to zero, so all balancing flags are cleared which is
- * what we want.
- */
-static struct sched_domain sched_domain_dummy;
-
 #ifdef CONFIG_HOTPLUG_CPU
 /*
  * Force a reinitialization of the sched domains hierarchy.  The domains
  * and groups cannot be updated in place without racing with the balancing
- * code, so we temporarily attach all running cpus to a "dummy" domain
+ * code, so we temporarily attach all running cpus to the NULL domain
  * which will prevent rebalancing while the sched domains are recalculated.
  */
 static int update_sched_domains(struct notifier_block *nfb,
@@ -5190,7 +5183,7 @@ static int update_sched_domains(struct n
 	case CPU_UP_PREPARE:
 	case CPU_DOWN_PREPARE:
 		for_each_online_cpu(i)
-			cpu_attach_domain(&sched_domain_dummy, i);
+			cpu_attach_domain(NULL, i);
 		arch_destroy_sched_domains();
 		return NOTIFY_OK;
 
@@ -5253,7 +5246,7 @@ void __init sched_init(void)
 		rq->best_expired_prio = MAX_PRIO;
 
 #ifdef CONFIG_SMP
-		rq->sd = &sched_domain_dummy;
+		rq->sd = NULL;
 		for (j = 1; j < 3; j++)
 			rq->cpu_load[j] = 0;
 		rq->active_balance = 0;

--------------090609000903040605000102--

