Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266738AbUGUVev@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266738AbUGUVev (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 21 Jul 2004 17:34:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266740AbUGUVev
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 21 Jul 2004 17:34:51 -0400
Received: from mx2.elte.hu ([157.181.151.9]:15521 "EHLO mx2.elte.hu")
	by vger.kernel.org with ESMTP id S266738AbUGUVes (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 21 Jul 2004 17:34:48 -0400
Date: Wed, 21 Jul 2004 20:43:08 +0200
From: Ingo Molnar <mingo@elte.hu>
To: Scott Wood <scott@timesys.com>
Cc: Lee Revell <rlrevell@joe-job.com>, Andrew Morton <akpm@osdl.org>,
       linux-audio-dev@music.columbia.edu, arjanv@redhat.com,
       linux-kernel <linux-kernel@vger.kernel.org>,
       "La Monte H.P. Yarroll" <piggy@timesys.com>
Subject: Re: [linux-audio-dev] Re: [announce] [patch] Voluntary Kernel Preemption Patch
Message-ID: <20040721184308.GA27034@elte.hu>
References: <20040712163141.31ef1ad6.akpm@osdl.org> <1089677823.10777.64.camel@mindpipe> <20040712174639.38c7cf48.akpm@osdl.org> <20040719102954.GA5491@elte.hu> <1090380467.1212.3.camel@mindpipe> <20040721000348.39dd3716.akpm@osdl.org> <20040721053007.GA8376@elte.hu> <1090389791.901.31.camel@mindpipe> <20040721082218.GA19013@elte.hu> <20040721183010.GA2206@yoda.timesys>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040721183010.GA2206@yoda.timesys>
User-Agent: Mutt/1.4.1i
X-ELTE-SpamVersion: MailScanner 4.31.6-itk1 (ELTE 1.2) SpamAssassin 2.63 ClamAV 0.73
X-ELTE-VirusStatus: clean
X-ELTE-SpamCheck: no
X-ELTE-SpamCheck-Details: score=-1.428, required 5.9,
	autolearn=not spam, BAYES_20 -1.43
X-ELTE-SpamLevel: 
X-ELTE-SpamScore: -1
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


* Scott Wood <scott@timesys.com> wrote:

> > we already 'daemonize' softirqs in the stock kernel if the load is high
> > enough. (this is what ksoftirqd does) So the only question is a tunable
> > to make this deferring of softirq load mandatory. Yarroll's patch is
> > quite complex, i dont think that is necessary.
> 
> What aspects of it do you find unnecessary?  The second thread is
> needed to maintain the current high/low priority semantics (without
> that, you'll either starve regular tasks with a lot of softirqs, or
> starve softirqs with a busy userspace, depending on how you set the
> priority of the softirq thread).

what high/low semantics do you mean, other than the ordering of softirq
sources? (which is currently implemented via the __do_softirq() loop
first looking at the highest prio softirq.) So splitting up ksoftirqd
into two pieces seems like a separate issue.

> > It also has at least one
> > conceptual problem, the NOP-ing of local_bh_disable/enable in case of
> > CONFIG_SOFTIRQ_THREADS is clearly wrong. Yarroll?
> 
> Why is it "clearly wrong"?  As far as I can tell, the only legitimate
> use of it currently is to protect against deadlock (as in
> spin_lock_bh()), which is not an issue if all softirqs run from a
> thread.

local_bh_disable() excludes all softirq processing. This means that such
a section must not be preempted. E.g. the networking layer manipulates
per-CPU lists from such sections, if you remove local_bh_disable() then
from the middle of such a section we could preempt into ksoftirqd which
would break the code.

> There's also the possibility of code relying on it also being
> preempt_disable(); if that's happening, it could be left alone (though
> IMHO it'd be better if such code made its dependence on such behavior
> explicit), with preempt_disable() being the only real effect.

yes, that's how softirqs are used. The patch changes these semantics.

> > I've added a very simple solution to daemonize softirqs similar to
> > Yarroll's patch to the -H5 version of voluntary-preempt:
> 
> BTW, it was my patch; Yarroll only submitted it to the list (as he
> stated at the time).

ok - sorry about the misattribution!

	Ingo
