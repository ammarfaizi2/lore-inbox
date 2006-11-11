Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1424483AbWKKBOM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1424483AbWKKBOM (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 10 Nov 2006 20:14:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1424482AbWKKBOM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 10 Nov 2006 20:14:12 -0500
Received: from omx2-ext.sgi.com ([192.48.171.19]:58844 "EHLO omx2.sgi.com")
	by vger.kernel.org with ESMTP id S1424478AbWKKBOL (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 10 Nov 2006 20:14:11 -0500
Date: Fri, 10 Nov 2006 17:14:01 -0800 (PST)
From: Christoph Lameter <clameter@sgi.com>
To: "Siddha, Suresh B" <suresh.b.siddha@intel.com>
cc: "Chen, Kenneth W" <kenneth.w.chen@intel.com>, Ingo Molnar <mingo@elte.hu>,
       akpm@osdl.org, mm-commits@vger.kernel.org, nickpiggin@yahoo.com.au,
       linux-kernel@vger.kernel.org
Subject: Re: + sched-use-tasklet-to-call-balancing.patch added to -mm tree
In-Reply-To: <20061110143214.A25478@unix-os.sc.intel.com>
Message-ID: <Pine.LNX.4.64.0611101709240.28516@schroedinger.engr.sgi.com>
References: <000001c70490$01cea4b0$8bc8180a@amr.corp.intel.com>
 <Pine.LNX.4.64.0611101027100.25459@schroedinger.engr.sgi.com>
 <20061110143214.A25478@unix-os.sc.intel.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 10 Nov 2006, Siddha, Suresh B wrote:

> Nick was suggesting another alternative, that we should increase the max
> interval and probably make it dependent on number of cpus that
> share the group. Today for NUMA domain, we already set max_interval
> based on online cpus. Perhaps we need to do that for other domains (SMP, MC)
> too and increase the max interval on NUMA for big systems?

I have been trying to run with this patch. We increase the min interval so 
that we can at least put one tick between each of the load balance actions 
of each processor. The cpu_offset can be modified to:

/* Don't have all balancing operations going off at once: */
static inline unsigned long cpu_offset(int cpu)
{
	if (NR_CPUS < HZ)
    		return jiffies + cpu * HZ / NR_CPUS;
	else
		return jiffies + cpu;
}

But exclusion in load balancing would take care of the above.




Index: linux-2.6.19-rc4-mm2/include/linux/topology.h
===================================================================
--- linux-2.6.19-rc4-mm2.orig/include/linux/topology.h	2006-11-07 16:43:43.084665449 -0600
+++ linux-2.6.19-rc4-mm2/include/linux/topology.h	2006-11-07 16:55:23.027245226 -0600
@@ -182,7 +182,7 @@
 	.parent			= NULL,			\
 	.child			= NULL,			\
 	.groups			= NULL,			\
-	.min_interval		= 64,			\
+	.min_interval		= max(64, jiffies_to_msec(num_online_cpus())),\
 	.max_interval		= 64*num_online_cpus(),	\
 	.busy_factor		= 128,			\
 	.imbalance_pct		= 133,			\
