Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266802AbUIITgn@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266802AbUIITgn (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 9 Sep 2004 15:36:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266758AbUIITgm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 9 Sep 2004 15:36:42 -0400
Received: from mx1.elte.hu ([157.181.1.137]:59041 "EHLO mx1.elte.hu")
	by vger.kernel.org with ESMTP id S266807AbUIIT2L (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 9 Sep 2004 15:28:11 -0400
Date: Thu, 9 Sep 2004 21:29:24 +0200
From: Ingo Molnar <mingo@elte.hu>
To: Lee Revell <rlrevell@joe-job.com>, Andrew Morton <akpm@osdl.org>
Cc: linux-kernel <linux-kernel@vger.kernel.org>, felipe_alfaro@linuxmail.org,
       Florian Schmidt <mista.tapas@gmx.net>, "K.R. Foley" <kr@cybsft.com>,
       Mark_H_Johnson@Raytheon.com
Subject: Re: [patch] voluntary-preempt-2.6.9-rc1-bk12-R6
Message-ID: <20040909192924.GA1672@elte.hu>
References: <20040903120957.00665413@mango.fruits.de> <20040904195141.GA6208@elte.hu> <20040905140249.GA23502@elte.hu> <20040906110626.GA32320@elte.hu> <1094626562.1362.99.camel@krustophenia.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1094626562.1362.99.camel@krustophenia.net>
User-Agent: Mutt/1.4.1i
X-ELTE-SpamVersion: MailScanner 4.31.6-itk1 (ELTE 1.2) SpamAssassin 2.63 ClamAV 0.73
X-ELTE-VirusStatus: clean
X-ELTE-SpamCheck: no
X-ELTE-SpamCheck-Details: score=-4.9, required 5.9,
	autolearn=not spam, BAYES_00 -4.90
X-ELTE-SpamLevel: 
X-ELTE-SpamScore: -4
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


* Lee Revell <rlrevell@joe-job.com> wrote:

> I get these latencies when I cause the machine to swap by compiling a
> kernel with make -j32.  They get bigger as the machine gets further
> into swap.
> 
> Every 2.0s: head -60 /proc/latency_trace                                                                                                                             Wed Sep  8 02:51:40 2004
> 
> preemption latency trace v1.0.6 on 2.6.9-rc1-bk12-VP-R6
> --------------------------------------------------
>  latency: 605 us, entries: 5 (5)  [VP:1 KP:1 SP:1 HP:1 #CPUS:1]
>     -----------------
>     | task: kswapd0/35, uid:0 nice:0 policy:0 rt_prio:0
>     -----------------
>  => started at: get_swap_page+0x23/0x490
>  => ended at:   get_swap_page+0x13f/0x490
> =======>
> 00000001 0.000ms (+0.606ms): get_swap_page (add_to_swap)
> 00000001 0.606ms (+0.000ms): sub_preempt_count (get_swap_page)
> 00000001 0.606ms (+0.000ms): update_max_trace (check_preempt_timing)
> 00000001 0.606ms (+0.000ms): _mmx_memcpy (update_max_trace)
> 00000001 0.607ms (+0.000ms): kernel_fpu_begin (_mmx_memcpy)

yep, the get_swap_page() latency. I can easily trigger 10+ msec
latencies on a box with alot of swap by just letting stuff swap out. I
had a quick look but there was no obvious way to break the lock. Maybe
Andrew has better ideas? get_swap_page() is pretty stupid, it does a
near linear search for a free slot in the swap bitmap - this not only is
a latency issue but also an overhead thing as we do it for every other
page that touches swap.

rationale: this is pretty much the only latency that we still having
during heavy VM load and it would Just Be Cool if we fixed this final
one. audio daemons and apps like jackd use mlockall() so they are not
affected by swapping.

	Ingo
