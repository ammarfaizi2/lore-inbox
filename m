Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261616AbULNTA7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261616AbULNTA7 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 14 Dec 2004 14:00:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261617AbULNTA6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 14 Dec 2004 14:00:58 -0500
Received: from rproxy.gmail.com ([64.233.170.193]:10344 "EHLO rproxy.gmail.com")
	by vger.kernel.org with ESMTP id S261616AbULNTAh (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 14 Dec 2004 14:00:37 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:references;
        b=SOJuNUasCSj1H7kqnJWOi+ZtKR3sUJjs7bw34El7NOWoiYyT0O5P45BCg8xIqUx9FwmPsoGw60UhE/aLpFzEspg9wQqVx01c1C0BCAke1JDcTwFVwU9XBjOCexNRA158Ds0mM319ZQvYhnGXz5eBoGyIcytq9ep04uR5IUd/YWc=
Message-ID: <29495f1d041214110076137f84@mail.gmail.com>
Date: Tue, 14 Dec 2004 11:00:36 -0800
From: Nish Aravamudan <nish.aravamudan@gmail.com>
Reply-To: Nish Aravamudan <nish.aravamudan@gmail.com>
To: Andrea Arcangeli <andrea@suse.de>
Subject: Re: dynamic-hz
Cc: linux-os@analogic.com, Andrew Morton <akpm@osdl.org>, kernel@kolivas.org,
       pavel@suse.cz, linux-kernel@vger.kernel.org
In-Reply-To: <20041214182900.GM16322@dualathlon.random>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
References: <20041212222312.GN16322@dualathlon.random>
	 <20041213030237.5b6f6178.akpm@osdl.org>
	 <20041213111741.GR16322@dualathlon.random>
	 <20041213032521.702efe2f.akpm@osdl.org>
	 <29495f1d041213195451677dab@mail.gmail.com>
	 <Pine.LNX.4.61.0412140914360.13406@chaos.analogic.com>
	 <29495f1d041214085457b8c725@mail.gmail.com>
	 <20041214171503.GG16322@dualathlon.random>
	 <29495f1d04121409422add6024@mail.gmail.com>
	 <20041214182900.GM16322@dualathlon.random>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 14 Dec 2004 19:29:00 +0100, Andrea Arcangeli <andrea@suse.de> wrote:
> On Tue, Dec 14, 2004 at 09:42:02AM -0800, Nish Aravamudan wrote:
> > Sorry for my lack of clarity :) I was referring more to the second
> > part of what you said, that the "meaning" of yield() changed for 2.6
> 
> The meaning of yield didn't really change. The behaviour changed a bit
> to allow scalability even if more than one task is polling for a
> resource (potentially even the _same_ resource) using yield().
> 
> But if you were using yield() in 2.4 you shouldn't change to anything
> different than yield() in 2.6. If you get bad latencies under load in
> 2.6, it's simply a gentle reminder that using yield() is always a bad
> idea ;).
> 
> NPTL converted the yield() loops in the slow path of the pthread_mutex to
> even driven futex, otherwise 2.6 behaviour would break a lot more than
> OOo.
> 
> In my 2.4-aa I've a sysctl to switch yield between two 2.4/2.6
> behaviours. The new behaviour broke OOo and all linthread apps for
> example, so it was necessary to use a sysctl to control it, even if the
> new yield() behaviour is more correct because it has a chance to scala
> under load.
> 
> Ingo may want to correct me if I remember wrong, I discussed this stuff
> with him at the time.
> 
> > and thus shouldn't be used to wait for short times (see kerneljanitors
> > TODO reference from Matthew Wilcox (search for yield in page):
> > http://www.kerneljanitors.org/TODO).
> 
> The 2.4 yield() could introduce significant latencies too if more than
> one task was looping in yield at the same time for different resources.
> 
> > From the context of the TODO, it seems yield() and schedule_timeout()
> > should not be considered alternatives for each other. Maybe someone
> > can clarify?
> 
> It depends what you're doing. yield() and __set_current_state(..);
> schedule_timeout(1) are similar. I don't think schedule_timeout(0) makes
> much sense (but in practice it works very similarly to
> schedule_timeout(1)). The former will pool ASAP by guaranteeing the CPU
> won't go idle. The latter will make the CPU go idle and it'll wait
> between 1/HZ sec and 2/HZ sec.
> 
> The point is that polling is wrong and you should register into a
> waitqueue and then __set_current_state(..); schedule(). This is exactly
> what NPTL did too, and as far as I can tell it's pratically the most
> noticeable feature for optimally written threaded apps. The
> yield/schedule_timeout(1)-without-registering-in-callbacks are just
> tricks for some special code.  For example I used myself
> schedule_timeout(1) in the oom killer patch a few days ago, but that
> code runs only when the machine is out of memory and several tasks will
> try to kill something at the same time. At that time the cpu load really
> doesn't matter. So tricks like that are ok in corner cases where
> performance cannot matter at all. For fast paths or regular code, yield
> should not be used (and schedule_timeout(1) used as as yield won't be
> much better).
> 
> Conceptually if you want to poll as soon as possible you should use
> yield(). If you want to wait and give some idle time to the cpu you
> should use schedule_timeout().
> 
> You should ignore the claim that yield isn't appropriate in 2.6 for
> waiting short periods of time, yield is still the API to use for polling
> while keeping the cpu busy. If the machine is overloaded then it will
> take a while to get back to the polling loop with 2.6, but then 2.4 had
> other corner cases with the machine overloaded by userspace tasks
> calling sched_yield too. So it's not really that much different in terms
> of the guarantees that yield can provide between 2.4/2.6. The only
> guarantee that yield can provide is that the cpu will remain busy, and
> that you'll be rescheduled if some other task is pending in the
> runqueue. It can't provide any guarantee on when you'll become running
> again.
> 
> > > I guess we could change schedule_timeout() to WARN_ON if 0 is being
> > > passed to it.
> >
> > I will see if anyone is actually calling with 0 -- I don't remember
> 
> It's not that bad, I mean schedule_timeout(0) works fine, but once in a
> while it may not wait anything and just return after invoking a timer
> callback. So if somebody uses schedule_timeout, it's because he wants
> always to make the cpu go idle for a little bit, and in turn it would be
> better to use 1 (0 doesn't guarantee to go idle).
> 
> > seeing this for my previous sets of patches, but it may happen if HZ
> > changes in value.
> 
> The HZ errors are just due the lack of roundup, and schedule_timeout
> can't do anything about it, only the caller can (it's a problem even for
> other HZ values that generate rounding errors, and that's why HZ=100 and
> HZ=1000 are the only two really supported frequencies to freely switch
> at boot time ;).

Great! Thanks a lot for all of the clarifications!

-Nish
