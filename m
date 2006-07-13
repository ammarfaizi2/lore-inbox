Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030339AbWGMUBY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030339AbWGMUBY (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 13 Jul 2006 16:01:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030342AbWGMUBY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 13 Jul 2006 16:01:24 -0400
Received: from mx2.mail.elte.hu ([157.181.151.9]:7600 "EHLO mx2.mail.elte.hu")
	by vger.kernel.org with ESMTP id S1030339AbWGMUBX (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 13 Jul 2006 16:01:23 -0400
Date: Thu, 13 Jul 2006 21:55:46 +0200
From: Ingo Molnar <mingo@elte.hu>
To: Pekka Enberg <penberg@cs.helsinki.fi>
Cc: Andrew Morton <akpm@osdl.org>, sekharan@us.ibm.com, torvalds@osdl.org,
       linux-kernel@vger.kernel.org, nagar@watson.ibm.com, balbir@in.ibm.com,
       arjan@infradead.org
Subject: Re: [patch] lockdep: annotate mm/slab.c
Message-ID: <20060713195546.GB28317@elte.hu>
References: <1152763195.11343.16.camel@linuxchandra> <20060713071221.GA31349@elte.hu> <20060713002803.cd206d91.akpm@osdl.org> <20060713072635.GA907@elte.hu> <20060713004445.cf7d1d96.akpm@osdl.org> <20060713124603.GB18936@elte.hu> <84144f020607130845h223432f2y6f4117828dadb69c@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <84144f020607130845h223432f2y6f4117828dadb69c@mail.gmail.com>
User-Agent: Mutt/1.4.2.1i
X-ELTE-SpamScore: -3.1
X-ELTE-SpamLevel: 
X-ELTE-SpamCheck: no
X-ELTE-SpamVersion: ELTE 2.0 
X-ELTE-SpamCheck-Details: score=-3.1 required=5.9 tests=ALL_TRUSTED,AWL,BAYES_50 autolearn=no SpamAssassin version=3.0.3
	-3.3 ALL_TRUSTED            Did not pass through any untrusted hosts
	0.0 BAYES_50               BODY: Bayesian spam probability is 40 to 60%
	[score: 0.5277]
	0.2 AWL                    AWL: From: address is in the auto white-list
X-ELTE-VirusStatus: clean
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


* Pekka Enberg <penberg@cs.helsinki.fi> wrote:

> Hi,
> 
> On 7/13/06, Ingo Molnar <mingo@elte.hu> wrote:
> >mm/slab.c uses nested locking when dealing with 'off-slab'
> >caches, in that case it allocates the slab header from the
> >(on-slab) kmalloc caches. Teach the lock validator about
> >this by putting all on-slab caches into a separate class.
> 
> Which lock is that? This affects only caches that cache_grow() use, so 
> we are really only interested in annotating kmalloc() on-slab caches 
> (like in the patch), not _all_, right?

it's ->list_lock, and a sample nesting scenario is:

 [<c013a9a8>] lock_acquire+0x78/0xa0
 [<c0313e5a>] _spin_lock_nested+0x2a/0x40
 [<c0163024>] __cache_free+0x484/0x5c0
 [<c01632ad>] slab_destroy+0x14d/0x1e0
 [<c0162ac9>] free_block+0x189/0x1e0
 [<c01630f4>] __cache_free+0x554/0x5c0
 [<c0163653>] kmem_cache_free+0x73/0xc0
 [<c016a24f>] file_free_rcu+0xf/0x20
 [<c0130755>] __rcu_process_callbacks+0x75/0x1b0
 [<c0130bc7>] rcu_process_callbacks+0x27/0x50
 [<c0123f3a>] tasklet_action+0x6a/0xf0
 [<c012413b>] __do_softirq+0x8b/0x130
 [<c0106ba3>] do_softirq+0x73/0x100

(the off-slab nesting is perfectly correct locking code AFAICS - it just 
needs to be taught to lockdep - which the patch does. OTOH i'm less sure 
about the NUMA alien-cache-draining nesting.)

	Ingo
