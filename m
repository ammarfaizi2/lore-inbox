Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262615AbTHULlG (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 21 Aug 2003 07:41:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262635AbTHULlF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 21 Aug 2003 07:41:05 -0400
Received: from c210-49-248-224.thoms1.vic.optusnet.com.au ([210.49.248.224]:11458
	"EHLO mail.kolivas.org") by vger.kernel.org with ESMTP
	id S262615AbTHULje (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 21 Aug 2003 07:39:34 -0400
From: Con Kolivas <kernel@kolivas.org>
To: Mike Galbraith <efault@gmx.de>
Subject: Re: [PATCH] O17int
Date: Thu, 21 Aug 2003 21:46:14 +1000
User-Agent: KMail/1.5.3
Cc: Voluspa <lista1@comhem.se>,
       linux kernel mailing list <linux-kernel@vger.kernel.org>,
       Andrew Morton <akpm@osdl.org>
References: <200308210723.42789.kernel@kolivas.org> <5.2.1.1.2.20030821090657.00b45af8@pop.gmx.net>
In-Reply-To: <5.2.1.1.2.20030821090657.00b45af8@pop.gmx.net>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200308212146.14493.kernel@kolivas.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 21 Aug 2003 17:53, Mike Galbraith wrote:
> At 03:26 PM 8/21/2003 +1000, Con Kolivas wrote:
> >Unhappy with this latest O16.3-O17int patch I'm withdrawing it, and
> >recommending nothing on top of O16.3 yet.
> >
> >More and more it just seems to be a bandaid to the priority inverting spin
> > on waiters, and it does seem to be of detriment to general interacivity.
> > I can now reproduce some loss of interactive feel with O17.
> >
> >Something specific for the spin on waiters is required that doesn't affect
> >general performance. The fact that I can reproduce the same starvation in
> >vanilla 2.6.0-test3 but to a lesser extent means this is an intrinsic
> > problem that needs a specific solution.
>
> I can see only one possible answer to this - never allow a normal task to
> hold the cpu for long stretches (define) while there are other tasks
> runnable.  (see attachment)

I assume you mean the strace ? That was the only attachment, and it just looks 
like shiploads of schedule() from the get time of day. Yes?

>
> I think the _easiest_ fix for this particular starvation (without tossing
> baby out with bath water;) is to try to "down-shift" in schedule() when
> next == prev.  This you can do very cheaply with a find_next_bit().  That
> won't help the case where there are multiple tasks involved, but should fix
> the most common case for dirt cheap.  (another simple alternative is to
> globally "down-shift" periodically)

Err funny you should say that; that's what O17 did. But it hurt because it 
would never allow a task that used a full timeslice to be next==prev. The 
less I throttled that, the less effective the antistarvation was. However 
this is clearly a problem without using up full timeslices. I originally 
thought they weren't trying to schedule lots because of the drop in ctx 
during starvation but I forgot that rescheduling the same task doesnt count 
as a ctx. 

Also I recall that winegames got much better in O10 when everything was 
charged at least one jiffy (pre nanosecond timing) suggesting those that were 
waking up for minute amounts of time repeatedly were being penalised; thus 
taking out the possibility of the starving task staying high priority for 
long.

> The most generally effective form of the "down-shift" anti-starvation
> tactic that I've tried, is to periodically check the head of all queues
> below current position (can do very quickly), and actively select the
> oldest task who hasn't run since some defined deadline.  Queues are
> serviced based upon priority most of the time, and based upon age some of
> the time.

Hmm also sounds fudgy. 

> Everything I've tried along these lines has a common upside: works, and
> downside: butt ugly :)

Well if it works well who cares. My starvation throttler (O17) hurt 
interactivity though which is why I dropped it. 

I'm guessing I need to rewrite the O10 semantics to work with nanosecond 
timing instead. I'll have to give that a go.

Thanks for your comments Mike. Hopefully the munchkins can stack high enough 
;)

Con

