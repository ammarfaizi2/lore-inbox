Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262956AbVDBA2E@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262956AbVDBA2E (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 1 Apr 2005 19:28:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262978AbVDBAYg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 1 Apr 2005 19:24:36 -0500
Received: from fmr21.intel.com ([143.183.121.13]:32991 "EHLO
	scsfmr001.sc.intel.com") by vger.kernel.org with ESMTP
	id S262957AbVDBAVH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 1 Apr 2005 19:21:07 -0500
Date: Fri, 1 Apr 2005 16:20:40 -0800
From: "Siddha, Suresh B" <suresh.b.siddha@intel.com>
To: mingo@elte.hu, nickpiggin@yahoo.com.au
Cc: akpm@osdl.org, linux-kernel@vger.kernel.org
Subject: [Patch] sched: remove unnecessary sched domains
Message-ID: <20050401162039.A4320@unix-os.sc.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Appended patch removes the unnecessary scheduler domains(containing
only one sched group) setup during the sched-domain init.

For example on x86_64, we always have NUMA configured in. On Intel EM64T
systems, top most sched domain will be of NUMA and with only one sched_group in
it. 

With fork/exec balances(recent Nick's fixes in -mm tree), we always endup 
taking wrong decisions because of this topmost domain (as it contains only 
one group and find_idlest_group always returns NULL). We will endup loading 
HT package completely first, letting active load balance kickin and correct it.

In general, this patch also makes sense with out recent Nick's fixes
in -mm.

Signed-off-by: Suresh Siddha <suresh.b.siddha@intel.com>


--- linux-2.6.12-rc1-mm4/kernel/sched.c	2005-04-01 10:07:24.183605296 -0800
+++ linux/kernel/sched.c	2005-04-01 15:29:28.274896888 -0800
@@ -4748,6 +4748,21 @@
 	unsigned long flags;
 	runqueue_t *rq = cpu_rq(cpu);
 	int local = 1;
+	struct sched_domain *tmp = sd, *tmp1;
+
+	/* Remove the sched domains which has only one group
+	 */
+	while (tmp) {
+		tmp1 = tmp->parent;
+		if (!tmp1)
+			break;
+		if (tmp1->groups == tmp1->groups->next)
+			tmp->parent = tmp1->parent;
+		tmp = tmp->parent;
+	}
+
+	if (sd->parent && sd->groups && sd->groups == sd->groups->next)
+		sd = sd->parent;
 
 	sched_domain_debug(sd, cpu);
 
