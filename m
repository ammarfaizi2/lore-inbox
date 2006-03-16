Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964870AbWCPWKR@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964870AbWCPWKR (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 16 Mar 2006 17:10:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964872AbWCPWKQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 16 Mar 2006 17:10:16 -0500
Received: from mx2.mail.elte.hu ([157.181.151.9]:38859 "EHLO mx2.mail.elte.hu")
	by vger.kernel.org with ESMTP id S964870AbWCPWKP (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 16 Mar 2006 17:10:15 -0500
Date: Thu, 16 Mar 2006 23:07:58 +0100
From: Ingo Molnar <mingo@elte.hu>
To: Hugh Dickins <hugh@veritas.com>
Cc: Andrew Morton <akpm@osdl.org>, Lee Revell <rlrevell@joe-job.com>,
       Nick Piggin <nickpiggin@yahoo.com.au>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] fix free swap cache latency
Message-ID: <20060316220758.GA27349@elte.hu>
References: <Pine.LNX.4.61.0603161853300.24463@goblin.wat.veritas.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.61.0603161853300.24463@goblin.wat.veritas.com>
User-Agent: Mutt/1.4.2.1i
X-ELTE-SpamScore: -2.5
X-ELTE-SpamLevel: 
X-ELTE-SpamCheck: no
X-ELTE-SpamVersion: ELTE 2.0 
X-ELTE-SpamCheck-Details: score=-2.5 required=5.9 tests=ALL_TRUSTED,AWL,BAYES_50 autolearn=no SpamAssassin version=3.0.3
	-3.3 ALL_TRUSTED            Did not pass through any untrusted hosts
	0.0 BAYES_50               BODY: Bayesian spam probability is 40 to 60%
	[score: 0.5000]
	0.7 AWL                    AWL: From: address is in the auto white-list
X-ELTE-VirusStatus: clean
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


* Hugh Dickins <hugh@veritas.com> wrote:

> Lee Revell reported 28ms latency when process with lots of swapped memory
> exits.
> 
> 2.6.15 introduced a latency regression when unmapping: in accounting the
> zap_work latency breaker, pte_none counted 1, pte_present PAGE_SIZE, but
> a swap entry counted nothing at all.  We think of pages present as the
> slow case, but Lee's trace shows that free_swap_and_cache's radix tree
> lookup can make a lot of work - and we could have been doing it many
> thousands of times without a latency break.
> 
> Move the zap_work update up to account swap entries like pages present.
> This does account non-linear pte_file entries, and unmap_mapping_range
> skipping over swap entries, by the same amount even though they're quick:
> but neither of those cases deserves complicating the code (and they're
> treated no worse than they were in 2.6.14).
> 
> Signed-off-by: Hugh Dickins <hugh@veritas.com>
> Acked-by: Nick Piggin <npiggin@suse.de>

i've added this patch to the 2.6.16-rc6 based -rt kernel yesterday and 
have ran an overnight stresstest on an SMP box (which creates heavy 
swapping too, amongst other things), which found no problems whatsoever.  
(not that we would expect any, but it's still nice to know.)

Acked-by: Ingo Molnar <mingo@elte.hu>

	Ingo
