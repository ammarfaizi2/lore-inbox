Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264843AbUEYKgR@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264843AbUEYKgR (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 25 May 2004 06:36:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264846AbUEYKgR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 25 May 2004 06:36:17 -0400
Received: from mx2.elte.hu ([157.181.151.9]:46208 "EHLO mx2.elte.hu")
	by vger.kernel.org with ESMTP id S264843AbUEYKgP (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 25 May 2004 06:36:15 -0400
Date: Tue, 25 May 2004 14:25:40 +0200
From: Ingo Molnar <mingo@elte.hu>
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Help understanding slow down
Message-ID: <20040525122539.GA7673@elte.hu>
References: <20040524062754.GO1833@holomorphy.com> <20040524063959.5107.qmail@web90007.mail.scd.yahoo.com> <20040524005331.71465614.akpm@osdl.org> <20040525103238.GA4212@elte.hu> <20040525022941.62ab4cc4.akpm@osdl.org> <20040525114258.GA6674@elte.hu> <20040525025826.6c31c71f.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040525025826.6c31c71f.akpm@osdl.org>
User-Agent: Mutt/1.4.1i
X-ELTE-SpamVersion: MailScanner 4.26.8-itk2 (ELTE 1.1) SpamAssassin 2.63 ClamAV 0.65
X-ELTE-VirusStatus: clean
X-ELTE-SpamCheck: no
X-ELTE-SpamCheck-Details: score=-4.9, required 5.9,
	autolearn=not spam, BAYES_00 -4.90
X-ELTE-SpamLevel: 
X-ELTE-SpamScore: -4
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


* Andrew Morton <akpm@osdl.org> wrote:

> > it makes it a bit more plausible, but kernel profiling based on ticks in
> > a HT environment is still quite unreliable, even with idle=poll. The HT
> > cores will yield to each other on various occasions - like spinlock
> > loops. This disproportionatly increases the hits of various looping
> > functions, creating false impressions of lock contention where there's
> > only little contention. Plus idle=poll is a constant ~20% performance
> > drain on the non-idle HT core, further distorting the profile. HT makes
> > profiling really hard, no matter what.
> 
> But often one is looking for relativities rather than real absolute
> numbers.  (In which case the absent idle time doesn't matter, but it
> freaks me out...)

but it's the relativities that get skewed by HT, fundamentally - both
with and without idle=poll. A function that does not generate alot of
HT-yield activity will fare much less on the profiler histogram than a
function that happens to hit some contention point every now and then.
Also, cachemisses get far more prominent due to HT (they are a yield
point too) - suppressing other, possibly more important functions in the
list. So a kernel profile done under HT gives a rough idea but a
function could easily have half the overhead that the profiler credits
it to have. Profiling under HT magnifies the effect of lock-contention
and cache-misses, and shrinks the effect of algorithmic overhead. Plus
this skewing is not deterministic, it depends on the actual system
activity.

unfortunately i see no good way to do reliable time-based profiling
under HT, given the interaction of logical CPUs. The virtual CPUs break
the single-EIP notion of 'what is this physical CPU doing now'. Perhaps
it would be more reliable to not use time but use some of the other
triggers: e.g. # of uops retired?

	Ingo
