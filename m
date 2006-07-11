Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750949AbWGKUTq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750949AbWGKUTq (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 11 Jul 2006 16:19:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750948AbWGKUTq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 11 Jul 2006 16:19:46 -0400
Received: from nz-out-0102.google.com ([64.233.162.205]:43455 "EHLO
	nz-out-0102.google.com") by vger.kernel.org with ESMTP
	id S1750949AbWGKUTp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 11 Jul 2006 16:19:45 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:reply-to:to:subject:date:user-agent:cc:references:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:message-id:from;
        b=i6wuweSxY4fvxgGNKjn5XNNfzjKO/SiRcQI5ZSMul0p1+QMi7wUYsdXZ7dUD/gTpwg092/synazgLcxWmIVgi5URPG0Toeud4HIOpbQW6uTVtj3ub3sCTgk8LC2j//IGkCXNwwfI7lRmLHNUMcPkFphgQ9q89zL5ieDz3WFWu48=
Reply-To: ajwade@cpe001346162bf9-cm0011ae8cd564.cpe.net.cable.rogers.com
To: andrea@cpushare.com
Subject: Re: [2.6 patch] let CONFIG_SECCOMP default to n
Date: Tue, 11 Jul 2006 16:19:35 -0400
User-Agent: KMail/1.9.1
Cc: Lee Revell <rlrevell@joe-job.com>, "Randy.Dunlap" <rdunlap@xenotime.net>,
       Andrew Morton <akpm@osdl.org>, bunk@stusta.de,
       linux-kernel@vger.kernel.org, mingo@elte.hu
References: <20060629192121.GC19712@stusta.de> <200607102159.11994.ajwade@cpe001346162bf9-cm0011ae8cd564.cpe.net.cable.rogers.com> <20060711041600.GC7192@opteron.random>
In-Reply-To: <20060711041600.GC7192@opteron.random>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200607111619.37607.ajwade@cpe001346162bf9-cm0011ae8cd564.cpe.net.cable.rogers.com>
From: Andrew James Wade <andrew.j.wade@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

On Tuesday 11 July 2006 00:16, andrea@cpushare.com wrote:
> Hello,
> 
> On Mon, Jul 10, 2006 at 09:59:09PM -0400, Andrew James Wade wrote:
> > It's probably not worth the complication, but I suppose that could be
> > reduced to one cacheline by lazily enabling the TSC access.
> 
> Yep, OTOH lazily enabling means generating exception faults and
> enter/exit kernels that takes order of magnitude more time and stall the
> pipeline unlike the two cacheline touches.

But only if SECCOMP code runs, otherwise it's never needed. OTOH, if it
can't reduce the number of cacheline touches over a tuned seccomp common
case, there's no benefit either.

> > I disagree with this wording. First, for most users the worry isn't so
> > much covert channels, as it is side channels. In other words, the
> > worry is not so much that data is sent to the SECCOMP process
> > secretly, as that the data could be sensitive. Second, the feature
> 
> Well, this comes as a news because with covert channel I always meant
> your "side channel" and only in timing context. Perhaps it was just me
> misunderstanding ;).  But we obviously agree, I meant your side channel
> if you're the one right about the wording.

I'm not an expert, but I believe I'm using the terminology correctly.

> > closes one only one type of side-channel; others may still exist. It's
> > quite possible for cpu bugs or undefined behaviour to reveal internal
> 
> Well math guarantees and unpredictable hardware issues don't go well
> together.

Yes. By necessity any proofs about software must make assumptions that
aren't quite valid. Such proofs can still be useful of course. I think
we're in agreement.

> If there are cpu bugs the least thing anybody (not just the 
> seccomp users) can care about is the covert channel.
> 
> > cpu state (possibly affected by another process) without otherwise
> > being security risks. (In my uninformed opinion). I wouldn't worry
> 
> Any bug that affects seccomp security is always a security bug for
> everyone else too (in terms of multiuser security of course).

Yes. But it is possible for the only exploitable side-effect of a bug
to be the opening of a side-channel. The incorrect fp initialization
being almost a case in point; all programs outside the jail would
likely ignore initial values in mmx registers, but they would still be
vulnerable to their floating point state being read. That's probably
not useful information to an attacker. Many other side channels are
likely similar, in that the information revealed is not actually
useful to the attacker. f00f also has very limited security
implications, as I understand it.

The various software and hardware caches will open a plethora of
timing side channels, almost all useless to an attacker in that the
revealed information is uninteresting/useless. At least I would hope
so. The downside of security is that it is hard to be sure.

> The opposite isn't true, a security bug for everyone, is pratically
> never a bug for seccomp.

Ah, fail safe. Nice property to have. From my observation, userspace
does appear to have something of that property with regards to cpu
bugs as well. What I recall from the errata sheets is that many of the
bugs could only be triggered from privileged code.

...

> It's all a matter of probability,
> if it's more likely that you're being hit by an asteroid, then that your 
> CPU has a bug that allows an attacker to execute code outside seccomp, I
> think you should be fine ;).

And that's where fail-safe and simple design comes in. In this
application an oops is better than a jail-break by orders of
magnitude. But then that's why you wrote seccomp instead of using
ptrace in the first place.

Andrew Wade
