Return-Path: <linux-kernel-owner+willy=40w.ods.org-S966117AbWKJVjs@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S966117AbWKJVjs (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 10 Nov 2006 16:39:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S966118AbWKJVjr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 10 Nov 2006 16:39:47 -0500
Received: from mx2.mail.elte.hu ([157.181.151.9]:1226 "EHLO mx2.mail.elte.hu")
	by vger.kernel.org with ESMTP id S966117AbWKJVjq (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 10 Nov 2006 16:39:46 -0500
Date: Fri, 10 Nov 2006 22:38:39 +0100
From: Ingo Molnar <mingo@elte.hu>
To: Christoph Lameter <clameter@sgi.com>
Cc: "Chen, Kenneth W" <kenneth.w.chen@intel.com>,
       "Siddha, Suresh B" <suresh.b.siddha@intel.com>, akpm@osdl.org,
       mm-commits@vger.kernel.org, nickpiggin@yahoo.com.au,
       linux-kernel@vger.kernel.org
Subject: Re: + sched-use-tasklet-to-call-balancing.patch added to -mm tree
Message-ID: <20061110213839.GA21928@elte.hu>
References: <000001c70490$01cea4b0$8bc8180a@amr.corp.intel.com> <Pine.LNX.4.64.0611101027100.25459@schroedinger.engr.sgi.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.64.0611101027100.25459@schroedinger.engr.sgi.com>
User-Agent: Mutt/1.4.2.2i
X-ELTE-SpamScore: -2.8
X-ELTE-SpamLevel: 
X-ELTE-SpamCheck: no
X-ELTE-SpamVersion: ELTE 2.0 
X-ELTE-SpamCheck-Details: score=-2.8 required=5.9 tests=ALL_TRUSTED,AWL,BAYES_50 autolearn=no SpamAssassin version=3.0.3
	-3.3 ALL_TRUSTED            Did not pass through any untrusted hosts
	0.5 BAYES_50               BODY: Bayesian spam probability is 40 to 60%
	[score: 0.5000]
	-0.0 AWL                    AWL: From: address is in the auto white-list
X-ELTE-VirusStatus: clean
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


* Christoph Lameter <clameter@sgi.com> wrote:

> I have done some testing on NUMA with 8p / 4n and 256 p / 128n which 
> seems to indicate that this is doing very well. Having a global 
> tasklet avoids concurrent load balancing from multiple nodes which 
> smoothes out the load balancing load over all nodes in a NUMA system. 
> It fixes the issues that we saw with contention during concurrent load 
> balancing.

ok, that's what i suspected - what made the difference wasnt the fact 
that it was moved out of irqs-off section, but that it was running 
globally, instead of in parallel on every cpu. I have no conceptual 
problem with single-threading the more invasive load-balancing bits. 
(since it has to touch every runqueue anyway there's probably little 
parallelism possible) But it's a scary change nevertheless, it 
materially affects every SMP system's balancing characteristics.

Also, tasklets are a pretty bad choice for scalable stuff - it's 
basically a shared resource between all CPUs and the tasklet-running 
cacheline will bounce between all the CPUs. Also, a tasklet can be 
'reactivated', which means that a CPU will do more rebalancing albeit 
it's /another/ CPU that wanted that.

So could you try another implementation perhaps, which would match the 
'single thread of rebalancing' model better? For example, try a global 
spinlock that is trylocked upon rebalance. If the trylock succeeds then 
do the rebalance and unlock. If the trylock fails, just skip the 
rebalance. (this roughly matches the tasklet logic but has lower 
overhead and doesnt cause false, repeat rebalancing)

	Ingo
