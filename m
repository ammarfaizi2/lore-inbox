Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266737AbUGUVV0@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266737AbUGUVV0 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 21 Jul 2004 17:21:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266740AbUGUVV0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 21 Jul 2004 17:21:26 -0400
Received: from mx1.elte.hu ([157.181.1.137]:52875 "EHLO mx1.elte.hu")
	by vger.kernel.org with ESMTP id S266737AbUGUVVN (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 21 Jul 2004 17:21:13 -0400
Date: Wed, 21 Jul 2004 23:18:26 +0200
From: Ingo Molnar <mingo@elte.hu>
To: Scott Wood <scott@timesys.com>
Cc: Lee Revell <rlrevell@joe-job.com>, Andrew Morton <akpm@osdl.org>,
       linux-audio-dev@music.columbia.edu, arjanv@redhat.com,
       linux-kernel <linux-kernel@vger.kernel.org>,
       "La Monte H.P. Yarroll" <piggy@timesys.com>
Subject: Re: [linux-audio-dev] Re: [announce] [patch] Voluntary Kernel Preemption Patch
Message-ID: <20040721211826.GB30871@elte.hu>
References: <1089677823.10777.64.camel@mindpipe> <20040712174639.38c7cf48.akpm@osdl.org> <20040719102954.GA5491@elte.hu> <1090380467.1212.3.camel@mindpipe> <20040721000348.39dd3716.akpm@osdl.org> <20040721053007.GA8376@elte.hu> <1090389791.901.31.camel@mindpipe> <20040721082218.GA19013@elte.hu> <20040721183010.GA2206@yoda.timesys> <20040721210051.GA2744@yoda.timesys>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040721210051.GA2744@yoda.timesys>
User-Agent: Mutt/1.4.1i
X-ELTE-SpamVersion: MailScanner 4.31.6-itk1 (ELTE 1.2) SpamAssassin 2.63 ClamAV 0.73
X-ELTE-VirusStatus: clean
X-ELTE-SpamCheck: no
X-ELTE-SpamCheck-Details: score=-4.9, required 5.9,
	BAYES_00 -4.90
X-ELTE-SpamLevel: 
X-ELTE-SpamScore: -4
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


* Scott Wood <scott@timesys.com> wrote:

> It appears, though, that recent kernel versions do preempt_disable()
> in ksoftirqd, apparently to support CPU hotplugging[1].  When I
> originally made the patch (against 2.6.0), this wasn't the case. 
> Since it was done so recently, hopefully there are no cases since then
> that have started depending on this behavior.

do_softirq() always did a local_bh_disable() which stops preemption, so
softirq processing was always non-preemptible.

> If preempt-disabled softirqs (and thus a local_bh_disable() that works
> for mutual exclusion on the local CPU) become relied upon by random
> pieces of kernel code, [...]

believe me, as someone who took part in the discussions that designed
softirqs years ago and cleaned up some of it later on, i can tell you
that this property of softirqs was and is fully intentional. It's not
just some side-effect that got relied on by random code - it was used
from day one on. E.g. it enables exclusion against softirq contexts
without having to use cli/sti.

trying to make softirqs preemptible surely wont fly for 2.6 and it will
also overly complicate the softirq model. What's so terminally wrong
about adding preemption checks to the softirq paths? It should solve the
preemption problem for good. The unbound softirq paths are well-known
(mostly in the networking code) and already have preemption-alike
checks.

	Ingo
