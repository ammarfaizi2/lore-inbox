Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267961AbUJGWas@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267961AbUJGWas (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 7 Oct 2004 18:30:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269872AbUJGW2t
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 7 Oct 2004 18:28:49 -0400
Received: from e32.co.us.ibm.com ([32.97.110.130]:60105 "EHLO
	e32.co.us.ibm.com") by vger.kernel.org with ESMTP id S269851AbUJGW0a
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 7 Oct 2004 18:26:30 -0400
Subject: Re: [RFC PATCH] scheduler: Dynamic sched_domains
From: Matthew Dobson <colpatch@us.ibm.com>
Reply-To: colpatch@us.ibm.com
To: Nick Piggin <nickpiggin@yahoo.com.au>
Cc: Paul Jackson <pj@sgi.com>, "Martin J. Bligh" <mbligh@aracnet.com>,
       Andrew Morton <akpm@osdl.org>, ckrm-tech@lists.sourceforge.net,
       LSE Tech <lse-tech@lists.sourceforge.net>,
       LKML <linux-kernel@vger.kernel.org>, simon.derr@bull.net,
       frankeh@watson.ibm.com
In-Reply-To: <4164A664.9040005@yahoo.com.au>
References: <1097110266.4907.187.camel@arrakis>
	 <4164A664.9040005@yahoo.com.au>
Content-Type: text/plain
Organization: IBM LTC
Message-Id: <1097187605.17473.37.camel@arrakis>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.5 (1.4.5-7) 
Date: Thu, 07 Oct 2004 15:20:05 -0700
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2004-10-06 at 19:13, Nick Piggin wrote:
> This is what I did in my first (that nobody ever saw) implementation of
> sched domains. Ie. no sched_groups, just use sched_domains as the balancing
> object... I'm not sure this works too well.
> 
> For example, your bottom level domain is going to basically be a redundant,
> single CPU on most topologies, isn't it?

I forgot to respond to this part in my last mail... :(

My benchmarks haven't shown any real deviation in performance from stock
-mm.  Granted, my benchmarking has been very limited, pretty much just
running kernbench on a few different machines with different configs
(ie: SMT, SMP & NUMA on/off).  A performance NOOP is exactly what I was
hoping for, though.  I don't really expect these changes to be either a
performance win or loss, but a functionality improvement.

The patch is pretty dense because of all the renaming, but there are no
single CPU domains.  The lowest level domain would be:

1) Node domains, for NUMA w/ SMP
2) Sibling domains, for SMT or NUMA w/ SMT
3) System domain, for flat SMP

The pseudo code version of my arch_init_sched_domains() looks like:

cpu_usable_map = cpu_online_map & ~cpu_isolated_map
create system domain;
if NUMA
	for_each_node()
		create node domain, parented to system domain;
for_each_cpu(cpu_usable_map)
	if SCHED_SMT
		create sibling domain, parented to node domain;
		attach sibling cpu to it's domain;
	else
		attach cpu to either its node domain or system domain;

So there shouldn't be any redundant CPU domains.

-Matt

