Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964896AbWGEUu3@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964896AbWGEUu3 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 5 Jul 2006 16:50:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964908AbWGEUu3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 5 Jul 2006 16:50:29 -0400
Received: from mx2.mail.elte.hu ([157.181.151.9]:7813 "EHLO mx2.mail.elte.hu")
	by vger.kernel.org with ESMTP id S964896AbWGEUu0 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 5 Jul 2006 16:50:26 -0400
Date: Wed, 5 Jul 2006 22:45:50 +0200
From: Ingo Molnar <mingo@elte.hu>
To: Andrew Morton <akpm@osdl.org>
Cc: torvalds@osdl.org, linux-kernel@vger.kernel.org, arjan@infradead.org
Subject: Re: [patch] uninline init_waitqueue_*() functions
Message-ID: <20060705204550.GA15221@elte.hu>
References: <20060705084914.GA8798@elte.hu> <20060705023120.2b70add6.akpm@osdl.org> <20060705093259.GA11237@elte.hu> <20060705025349.eb88b237.akpm@osdl.org> <20060705102633.GA17975@elte.hu> <20060705113054.GA30919@elte.hu> <20060705114630.GA3134@elte.hu> <20060705101059.66a762bf.akpm@osdl.org> <20060705193551.GA13070@elte.hu> <20060705131824.52fa20ec.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060705131824.52fa20ec.akpm@osdl.org>
User-Agent: Mutt/1.4.2.1i
X-ELTE-SpamScore: -3.1
X-ELTE-SpamLevel: 
X-ELTE-SpamCheck: no
X-ELTE-SpamVersion: ELTE 2.0 
X-ELTE-SpamCheck-Details: score=-3.1 required=5.9 tests=ALL_TRUSTED,AWL,BAYES_50 autolearn=no SpamAssassin version=3.0.3
	-3.3 ALL_TRUSTED            Did not pass through any untrusted hosts
	0.0 BAYES_50               BODY: Bayesian spam probability is 40 to 60%
	[score: 0.5001]
	0.2 AWL                    AWL: From: address is in the auto white-list
X-ELTE-VirusStatus: clean
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


* Andrew Morton <akpm@osdl.org> wrote:

> Ingo Molnar <mingo@elte.hu> wrote:
> >
> > > > i also tried a config with the best size settings (disabling 
> > > > FRAME_POINTER, enabling CC_OPTIMIZE_FOR_SIZE), and this gives:
> > > > 
> > > >   text            data    bss     dec         filename
> > > >   20777768        6076042 3081864 29935674    vmlinux.x32.size.before
> > > >   20748140        6076178 3081864 29906182    vmlinux.x32.size.after
> > > > 
> > > > or a 34.8 bytes win per callsite (29K total).
> > > > 
> > > 
> > > With gcc-4.1.0 on i686, uninlining those three functions as per the 
> > > below patch _increases_ the allnoconfig vmlinux's .text from 833456 
> > > bytes to 833728.
> > 
> > that's just the effect of CONFIG_REGPARM and CONFIG_CC_OPTIMIZE_FOR_SIZE 
> > not being set in an allnoconfig. Once i set them the text size evens 
> > out:
> > 
> >  431348   60666   27276  519290   7ec7a vmlinux.x32.mini.before
> >  431359   60666   27276  519301   7ec85 vmlinux.x32.mini.after
> > 
> > compiling without CONFIG_REGPARM on i686 (if you care about text size) 
> > makes little sense. It penalizes function calls artificially.
> 
> OK, but what happened to the 35-bytes-per-callsite saving?

there are 3 effects i can see:

firstly, allnoconfig implies SMP off, so the spinlock init in 
init_waitqueue_head() is not done and it becomes a 2-instruction thing.

secondly, the savings depend on the function size. Uninlining from a 
small function (that makes use of the inlined function) can be a loss if 
the function call causes more register clobbering. For large functions 
we clobber all registers anyway so there's no extra stack saving, etc. 

the allnoconfig kernel makes use of these waitqueue ops in smaller 
kernel-core functions as well, where the uninlining is a loss. 
(sleep_on(), etc.) Furthermore, UP kernel tends to decrease function 
sizes too.

larger kernel configs include more non-core subsystems/drivers as well, 
which tend to have larger function sizes. There the uninlining win is 
larger.

there's a third, smaller effect too: gcc manages to do tail-merging of 
the init_waitqueue_head calls, in a handful of cases, further reducing 
the cost. I found no such tail-merges done for the 53 callsites in the 
allnoconfig kernel.

	Ingo
