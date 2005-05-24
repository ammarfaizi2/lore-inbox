Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261360AbVEXPK1@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261360AbVEXPK1 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 24 May 2005 11:10:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261266AbVEXPK1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 24 May 2005 11:10:27 -0400
Received: from mx1.elte.hu ([157.181.1.137]:16066 "EHLO mx1.elte.hu")
	by vger.kernel.org with ESMTP id S261360AbVEXPKK (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 24 May 2005 11:10:10 -0400
Date: Tue, 24 May 2005 17:09:50 +0200
From: Ingo Molnar <mingo@elte.hu>
To: Christoph Hellwig <hch@infradead.org>, Andrew Morton <akpm@osdl.org>,
       Arjan van de Ven <arjanv@infradead.org>,
       Nick Piggin <nickpiggin@yahoo.com.au>, linux-kernel@vger.kernel.org
Subject: Re: [patch] Voluntary Kernel Preemption, 2.6.12-rc4-mm2
Message-ID: <20050524150950.GA10736@elte.hu>
References: <20050524121541.GA17049@elte.hu> <20050524132105.GA29477@elte.hu> <20050524145636.GA15943@infradead.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050524145636.GA15943@infradead.org>
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


* Christoph Hellwig <hch@infradead.org> wrote:

> I still disagree with this one violently. [...]

(then you must be disagreeing with CONFIG_PREEMPT too to a certain 
degree i guess?)

> [...] If you want a cond_resched() add it where nessecary, but don't 
> hide it behind might_sleep - there could be quite a lot might_sleeps 
> in common codepathes and they should stay purely a debug aid.

The recent prolifation of might_sleep() points was a direct result of 
the -VP patch. I _did_ measure and lay out the might_sleep()s so that 
key latency paths get cut. If we did what you propose we'd end up
duplicating 95% of the current might_sleep() invocations. So instead of
sprinking the source with cond_resched()s, we implicitly get them via
might_sleep().

there's another argument as well: if a function truly might sleep, it's 
in most cases complex enough to not worry about one extra need_resched() 
check. So might_sleep() and cond_resched() pair better than one would 
think.

(it is also a debugging helper: by actually sleeping at might_sleep() 
points we truly explore whether preemption at that point is safe.)

or if you think we can get away with using just a couple of 
cond_resched()s then you are my guest to prove me wrong: take the -RT 
kernel it has both -VP and the latency measurement tools integrated, and 
remove the cond_resched() from might_sleep() and try to find the points 
that are necessary to cut down latencies so that they fall into the 
1msec range on typical hw.

	Ingo
