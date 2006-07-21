Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1160999AbWGUGSS@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1160999AbWGUGSS (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 21 Jul 2006 02:18:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161000AbWGUGSS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 21 Jul 2006 02:18:18 -0400
Received: from mga06.intel.com ([134.134.136.21]:51005 "EHLO
	orsmga101.jf.intel.com") by vger.kernel.org with ESMTP
	id S1160999AbWGUGSR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 21 Jul 2006 02:18:17 -0400
X-IronPort-AV: i="4.07,165,1151910000"; 
   d="scan'208"; a="68525622:sNHT38083017"
Date: Thu, 20 Jul 2006 23:09:09 -0700
From: "Siddha, Suresh B" <suresh.b.siddha@intel.com>
To: Paul Jackson <pj@sgi.com>
Cc: Suresh Siddha <suresh.b.siddha@intel.com>, Simon.Derr@bull.net,
       linux-kernel@vger.kernel.org, Dimitri Sivanich <sivanich@sgi.com>
Subject: Re: [BUG] Cpuset: dynamic sched domain crash on > 16 cpu systems.
Message-ID: <20060720230909.A4984@unix-os.sc.intel.com>
References: <20060720132959.31161.284.sendpatchset@v0>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <20060720132959.31161.284.sendpatchset@v0>; from pj@sgi.com on Thu, Jul 20, 2006 at 06:29:59AM -0700
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Paul,

I don't have these type of systems. So can you please check if the appended
patch fixes your issue.

thanks,
suresh

--

Use the correct groups while initializing sched groups power for
allnodes_domain. This fixes the crash observed while creating
exclusive cpusets.

Signed-off-by: Suresh Siddha <suresh.b.siddha@intel.com>

--- linux-2.6.18-rc1/kernel/sched.c~	2006-07-20 20:54:44.425601384 -0700
+++ linux-2.6.18-rc1/kernel/sched.c	2006-07-20 21:05:05.535178376 -0700
@@ -6457,7 +6457,12 @@ static int build_sched_domains(const cpu
 	for (i = 0; i < MAX_NUMNODES; i++)
 		init_numa_sched_groups_power(sched_group_nodes[i]);
 
-	init_numa_sched_groups_power(sched_group_allnodes);
+	if (sched_group_allnodes) {
+		int group = cpu_to_allnodes_group(first_cpu(*cpu_map));
+		struct sched_group *sg = &sched_group_allnodes[group];
+
+		init_numa_sched_groups_power(sg);
+	}
 #endif
 
 	/* Attach the domains */
