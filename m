Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266357AbUGUSag@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266357AbUGUSag (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 21 Jul 2004 14:30:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266557AbUGUSag
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 21 Jul 2004 14:30:36 -0400
Received: from host-65-117-135-105.timesys.com ([65.117.135.105]:32983 "EHLO
	yoda.timesys") by vger.kernel.org with ESMTP id S266357AbUGUSae
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 21 Jul 2004 14:30:34 -0400
Date: Wed, 21 Jul 2004 14:30:10 -0400
To: Ingo Molnar <mingo@elte.hu>
Cc: Lee Revell <rlrevell@joe-job.com>, Andrew Morton <akpm@osdl.org>,
       linux-audio-dev@music.columbia.edu, arjanv@redhat.com,
       linux-kernel <linux-kernel@vger.kernel.org>,
       "La Monte H.P. Yarroll" <piggy@timesys.com>
Subject: Re: [linux-audio-dev] Re: [announce] [patch] Voluntary Kernel Preemption Patch
Message-ID: <20040721183010.GA2206@yoda.timesys>
References: <1089673014.10777.42.camel@mindpipe> <20040712163141.31ef1ad6.akpm@osdl.org> <1089677823.10777.64.camel@mindpipe> <20040712174639.38c7cf48.akpm@osdl.org> <20040719102954.GA5491@elte.hu> <1090380467.1212.3.camel@mindpipe> <20040721000348.39dd3716.akpm@osdl.org> <20040721053007.GA8376@elte.hu> <1090389791.901.31.camel@mindpipe> <20040721082218.GA19013@elte.hu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040721082218.GA19013@elte.hu>
User-Agent: Mutt/1.5.4i
From: Scott Wood <scott@timesys.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 21, 2004 at 10:22:18AM +0200, Ingo Molnar wrote:
> we already 'daemonize' softirqs in the stock kernel if the load is high
> enough. (this is what ksoftirqd does) So the only question is a tunable
> to make this deferring of softirq load mandatory. Yarroll's patch is
> quite complex, i dont think that is necessary.

What aspects of it do you find unnecessary?  The second thread is
needed to maintain the current high/low priority semantics (without
that, you'll either starve regular tasks with a lot of softirqs, or
starve softirqs with a busy userspace, depending on how you set the
priority of the softirq thread).

> It also has at least one
> conceptual problem, the NOP-ing of local_bh_disable/enable in case of
> CONFIG_SOFTIRQ_THREADS is clearly wrong. Yarroll?

Why is it "clearly wrong"?  As far as I can tell, the only legitimate
use of it currently is to protect against deadlock (as in
spin_lock_bh()), which is not an issue if all softirqs run from a
thread.  Ksoftirqd already ignores such disabling (unless I'm missing
something?), so code that uses it to synchronize with a softirq is
already broken.

There's also the possibility of code relying on it also being
preempt_disable(); if that's happening, it could be left alone
(though IMHO it'd be better if such code made its dependence on such
behavior explicit), with preempt_disable() being the only real
effect.

> I've added a very simple solution to daemonize softirqs similar to
> Yarroll's patch to the -H5 version of voluntary-preempt:

BTW, it was my patch; Yarroll only submitted it to the list (as he
stated at the time).

-Scott
