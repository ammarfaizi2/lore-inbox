Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965022AbVHJHQB@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965022AbVHJHQB (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 10 Aug 2005 03:16:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965027AbVHJHQB
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 10 Aug 2005 03:16:01 -0400
Received: from mx1.elte.hu ([157.181.1.137]:46777 "EHLO mx1.elte.hu")
	by vger.kernel.org with ESMTP id S965022AbVHJHQA (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 10 Aug 2005 03:16:00 -0400
Date: Wed, 10 Aug 2005 09:16:08 +0200
From: Ingo Molnar <mingo@elte.hu>
To: "Siddha, Suresh B" <suresh.b.siddha@intel.com>
Cc: nickpiggin@yahoo.com.au, akpm@osdl.org, linux-kernel@vger.kernel.org,
       steiner@sgi.com, dvhltc@us.ibm.com, mbligh@mbligh.org
Subject: Re: allow the load to grow upto its cpu_power (was Re: [Patch] don't kick ALB in the presence of pinned task)
Message-ID: <20050810071608.GC21052@elte.hu>
References: <20050801174221.B11610@unix-os.sc.intel.com> <20050802092717.GB20978@elte.hu> <20050809160813.B1938@unix-os.sc.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050809160813.B1938@unix-os.sc.intel.com>
User-Agent: Mutt/1.4.2.1i
X-ELTE-SpamVersion: MailScanner 4.31.6-itk1 (ELTE 1.2) SpamAssassin 2.63 ClamAV 0.73
X-ELTE-VirusStatus: clean
X-ELTE-SpamCheck: no
X-ELTE-SpamCheck-Details: score=-4.9, required 5.9,
	autolearn=not spam, BAYES_00 -4.90
X-ELTE-SpamLevel: 
X-ELTE-SpamScore: -4
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


* Siddha, Suresh B <suresh.b.siddha@intel.com> wrote:

> On Tue, Aug 02, 2005 at 11:27:17AM +0200, Ingo Molnar wrote:
> > 
> > * Siddha, Suresh B <suresh.b.siddha@intel.com> wrote:
> > 
> > > Jack Steiner brought this issue at my OLS talk.
> > > 
> > > Take a scenario where two tasks are pinned to two HT threads in a physical
> > > package. Idle packages in the system will keep kicking migration_thread
> > > on the busy package with out any success.
> > > 
> > > We will run into similar scenarios in the presence of CMP/NUMA.
> > > 
> > > Patch appended.
> > > 
> > > Signed-off-by: Suresh Siddha <suresh.b.siddha@intel.com>
> > 
> > nice catch!
> > 
> > fine for -mm, but i dont think we need this fix in 2.6.13, as the effect 
> > of the bug is an extra context-switch per 'CPU goes idle' event, in this 
> > very specific (and arguably broken) task binding scenario.
> 
> No. This is not a broken scenario. Its possible in NUMA case aswell.
> 
> For example, lets take two nodes each having two physical packages. 
> And assume that there are two tasks and both of them are on (may or 
> may n't be pinned) two packages in node-0
> 
> Todays load balance will detect that there is an imbalance between the 
> two nodes and will try to distribute the load between the nodes.
> 
> In general, we should allow the load of a group to grow upto its 
> cpu_power and stop preventing these costly movements.
> 
> Appended patch will fix this. I have done limited testing of this 
> patch. Guys with big NUMA boxes, please give this patch a try.

makes sense in general - we should not try to move things around when we 
are under-utilized. (In theory there could be heavily fluctuating 
workloads which do not produce an above 100% average utilization, and 
which could benefit from a perfectly even distribution of tasks - but i 
dont think the load-balancer should care, as load-balancing is mostly a 
"slow" mechanism.)

Again, 2.6.14 stuff.

Acked-by: Ingo Molnar <mingo@elte.hu>

	Ingo
