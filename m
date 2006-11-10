Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1946753AbWKJWzF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1946753AbWKJWzF (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 10 Nov 2006 17:55:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1946746AbWKJWzF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 10 Nov 2006 17:55:05 -0500
Received: from mga07.intel.com ([143.182.124.22]:43696 "EHLO
	azsmga101.ch.intel.com") by vger.kernel.org with ESMTP
	id S1946522AbWKJWzB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 10 Nov 2006 17:55:01 -0500
X-ExtLoop1: 1
X-IronPort-AV: i="4.09,411,1157353200"; 
   d="scan'208"; a="144433726:sNHT20680310"
Date: Fri, 10 Nov 2006 14:32:14 -0800
From: "Siddha, Suresh B" <suresh.b.siddha@intel.com>
To: Christoph Lameter <clameter@sgi.com>
Cc: "Chen, Kenneth W" <kenneth.w.chen@intel.com>, Ingo Molnar <mingo@elte.hu>,
       "Siddha, Suresh B" <suresh.b.siddha@intel.com>, akpm@osdl.org,
       mm-commits@vger.kernel.org, nickpiggin@yahoo.com.au,
       linux-kernel@vger.kernel.org
Subject: Re: + sched-use-tasklet-to-call-balancing.patch added to -mm tree
Message-ID: <20061110143214.A25478@unix-os.sc.intel.com>
References: <000001c70490$01cea4b0$8bc8180a@amr.corp.intel.com> <Pine.LNX.4.64.0611101027100.25459@schroedinger.engr.sgi.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <Pine.LNX.4.64.0611101027100.25459@schroedinger.engr.sgi.com>; from clameter@sgi.com on Fri, Nov 10, 2006 at 10:50:13AM -0800
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Nov 10, 2006 at 10:50:13AM -0800, Christoph Lameter wrote:
> Suresh noted at the Intel OS forum yesterday that we may be able to avoid 
> running load balancing of the larger sched domains from all processors. 
> That would reduce the overhead of scheduling and reduce the percentage of 
> time that load blancing is active even on very large systems.

I brought this up at OLS with Nick too. What happens today is, at a particular
domain, each cpu in the sched group will do a load balance at the frequency
of balance_interval. More the cores and threads, more the cpus will be
in each sched group at SMP and NUMA domain. And we endup spending
quite a bit of time doing load balancing in those domains.

One idea(old patch appended) is to make only one cpu in the sched group do
the load balance at that particular sched domain and this load will slowly
percolate down to the other cpus with in that group(when they do load balancing
at lower domains).

Nick was suggesting another alternative, that we should increase the max
interval and probably make it dependent on number of cpus that
share the group. Today for NUMA domain, we already set max_interval
based on online cpus. Perhaps we need to do that for other domains (SMP, MC)
too and increase the max interval on NUMA for big systems?

---

When busy, only the first cpu in the sched group will do the load balance.

--- linux-2.6.9/kernel/sched.c.1	2006-07-11 16:17:37.000000000 -0700
+++ linux-2.6.9/kernel/sched.c	2006-07-12 10:48:48.000000000 -0700
@@ -2329,12 +2329,15 @@
 			interval = 1;
 
 		if (j - sd->last_balance >= interval) {
-			sd->last_balance += interval;
+			sd->last_balance = j;
 			if (load_balance(this_cpu, this_rq, sd, idle)) {
 				/* We've pulled tasks over so no longer idle */
 				idle = NOT_IDLE;
 			}
 		}
+
+		if (idle != IDLE && this_cpu != first_cpu(sd->span))
+			break;
 	}
 }
 #else
