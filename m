Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932398AbWCNVED@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932398AbWCNVED (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 14 Mar 2006 16:04:03 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932444AbWCNVED
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 14 Mar 2006 16:04:03 -0500
Received: from mx2.mail.elte.hu ([157.181.151.9]:6032 "EHLO mx2.mail.elte.hu")
	by vger.kernel.org with ESMTP id S932398AbWCNVEB (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 14 Mar 2006 16:04:01 -0500
Date: Tue, 14 Mar 2006 22:01:42 +0100
From: Ingo Molnar <mingo@elte.hu>
To: Hugh Dickins <hugh@veritas.com>
Cc: Lee Revell <rlrevell@joe-job.com>,
       linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: 2.6.16-rc1: 28ms latency when process with lots of swapped memory exits
Message-ID: <20060314210142.GA23458@elte.hu>
References: <1142352926.13256.117.camel@mindpipe> <Pine.LNX.4.61.0603141812400.5882@goblin.wat.veritas.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.61.0603141812400.5882@goblin.wat.veritas.com>
User-Agent: Mutt/1.4.2.1i
X-ELTE-SpamScore: -2.5
X-ELTE-SpamLevel: 
X-ELTE-SpamCheck: no
X-ELTE-SpamVersion: ELTE 2.0 
X-ELTE-SpamCheck-Details: score=-2.5 required=5.9 tests=ALL_TRUSTED,AWL,BAYES_50 autolearn=no SpamAssassin version=3.0.3
	-3.3 ALL_TRUSTED            Did not pass through any untrusted hosts
	0.0 BAYES_50               BODY: Bayesian spam probability is 40 to 60%
	[score: 0.4987]
	0.8 AWL                    AWL: From: address is in the auto white-list
X-ELTE-VirusStatus: clean
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


* Hugh Dickins <hugh@veritas.com> wrote:

> > It seems to trigger when a process with a large amount of memory swapped
> > out exits.
> > 
> > Can this be solved with a cond_resched?
> 
> Not that easily, I think.
> 
> Are you testing with CONFIG_PREEMPT=y, as I'd expect?  I thought 
> cond_resched() adds nothing to that case (and we keep on intending but 
> forgetting to make it compile away to nothing in that case). Or am I 
> confused?

it still has an effect: if PREEMPT_BKL is disabled it drops the BKL. But 
if PREEMPT_BKL is enabled too then cond_resched() has no effect. 
(cond_resched_locked() does though)

back to the problem reported by Lee:

> >     Xorg-18254 0dn.2    3us < (2110048)
> >     Xorg-18254 0dn.2    4us : preempt_schedule (free_swap_and_cache)
> >     Xorg-18254 0dn.2    5us : free_swap_and_cache (unmap_vmas)
> >     Xorg-18254 0dn.2    6us : swap_info_get (free_swap_and_cache)
> >     Xorg-18254 0dn.3    6us : swap_entry_free (free_swap_and_cache)
> >     Xorg-18254 0dn.3    7us : find_trylock_page (free_swap_and_cache)

hm, where does the latency come from? We do have a lockbreaker in 
unmap_vmas():

                        if (need_resched() ||
                                (i_mmap_lock && need_lockbreak(i_mmap_lock))) {
                                if (i_mmap_lock) {
                                        *tlbp = NULL;
                                        goto out;
                                }
                                cond_resched();
                        }


why doesnt this break up the 28ms latency?

	Ingo
