Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267204AbTAPT3k>; Thu, 16 Jan 2003 14:29:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267212AbTAPT3j>; Thu, 16 Jan 2003 14:29:39 -0500
Received: from mx2.elte.hu ([157.181.151.9]:23190 "HELO mx2.elte.hu")
	by vger.kernel.org with SMTP id <S267204AbTAPT3i>;
	Thu, 16 Jan 2003 14:29:38 -0500
Date: Thu, 16 Jan 2003 20:44:01 +0100 (CET)
From: Ingo Molnar <mingo@elte.hu>
Reply-To: Ingo Molnar <mingo@elte.hu>
To: Christoph Hellwig <hch@infradead.org>
Cc: Robert Love <rml@tech9.net>, Erich Focht <efocht@ess.nec.de>,
       "Martin J. Bligh" <mbligh@aracnet.com>,
       Michael Hohnbaum <hohnbaum@us.ibm.com>,
       Andrew Theurer <habanero@us.ibm.com>,
       linux-kernel <linux-kernel@vger.kernel.org>,
       lse-tech <lse-tech@lists.sourceforge.net>
Subject: Re: [PATCH 2.5.58] new NUMA scheduler: fix
In-Reply-To: <20030116191009.A25749@infradead.org>
Message-ID: <Pine.LNX.4.44.0301162025300.9563-100000@localhost.localdomain>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Thu, 16 Jan 2003, Christoph Hellwig wrote:

> > well, it needs to settle down a bit more, we are technically in a
> > codefreeze :-)
> 
> We're in feature freeze.  Not sure whether fixing the scheduler for one
> type of hardware supported by Linux is a feature 8)
> 
> Anyway, patch 1 should certainly merged ASAP, for the other we can wait
> a bit more to settle, but I don't think it's really worth the wait.

agreed, the patch is unintrusive, but by settling down i mean things like
this:

+/* XXX(hch): this should go into a struct sched_node_data */

should be decided one way or another.

i'm also not quite happy about the conceptual background of
rq->nr_balanced. This load-balancing rate-limit is arbitrary and not
neutral at all. The way this should be done is to move the inter-node
balancing conditional out of load_balance(), and only trigger it from the
timer interrupt, with a given rate. On basically all NUMA hardware i
suspect it's much better to do inter-node balancing only on a very slow
scale. Making it dependnet on an arbitrary portion of the idle-CPU
rebalancing act makes the frequency of inter-node rebalancing almost
arbitrarily high.

ie. there are two basic types of rebalancing acts in multiprocessor
environments: 'synchronous balancing' and 'asynchronous balancing'.  
Synchronous balancing is done whenever a CPU runs idle - this can happen
at a very high rate, so it needs to be low overhead and unintrusive. This
was already so when i did the SMP balancer. The asynchronous blancing
component (currently directly triggered from every CPU's own timer
interrupt), has a fixed frequency, and thus can be almost arbitrarily
complex. It's the one that is aware of the global scheduling picture. For
NUMA i'd suggest two asynchronous frequencies: one intra-node frequency,
and an inter-node frequency - configured by the architecture and roughly
in the same proportion to each other as cachemiss latencies.

(this all means that unless there's empirical data showing the opposite,
->nr_balanced can be removed completely, and fixed frequency balancing can
be done from the timer tick. This should further simplify the patch.)

	Ingo

