Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262946AbVGNIjE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262946AbVGNIjE (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 14 Jul 2005 04:39:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262960AbVGNIjE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 14 Jul 2005 04:39:04 -0400
Received: from mx2.elte.hu ([157.181.151.9]:64167 "EHLO mx2.elte.hu")
	by vger.kernel.org with ESMTP id S262946AbVGNIjC (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 14 Jul 2005 04:39:02 -0400
Date: Thu, 14 Jul 2005 10:38:43 +0200
From: Ingo Molnar <mingo@elte.hu>
To: Linus Torvalds <torvalds@osdl.org>
Cc: Lee Revell <rlrevell@joe-job.com>,
       dean gaudet <dean-list-linux-kernel@arctic.org>,
       Chris Wedgwood <cw@f00f.org>, Andrew Morton <akpm@osdl.org>,
       "Brown, Len" <len.brown@intel.com>, dtor_core@ameritech.net,
       vojtech@suse.cz, david.lang@digitalinsight.com, davidsen@tmr.com,
       kernel@kolivas.org, linux-kernel@vger.kernel.org, mbligh@mbligh.org,
       diegocg@gmail.com, azarah@nosferatu.za.org, christoph@lameter.com
Subject: Re: [PATCH] i386: Selectable Frequency of the Timer Interrupt
Message-ID: <20050714083843.GA4851@elte.hu>
References: <1121282025.4435.70.camel@mindpipe> <d120d50005071312322b5d4bff@mail.gmail.com> <1121286258.4435.98.camel@mindpipe> <20050713134857.354e697c.akpm@osdl.org> <20050713211650.GA12127@taniwha.stupidest.org> <Pine.LNX.4.63.0507131639130.13193@twinlark.arctic.org> <20050714005106.GA16085@taniwha.stupidest.org> <Pine.LNX.4.63.0507131810430.13193@twinlark.arctic.org> <1121304825.4435.126.camel@mindpipe> <Pine.LNX.4.58.0507131847000.17536@g5.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.58.0507131847000.17536@g5.osdl.org>
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


* Linus Torvalds <torvalds@osdl.org> wrote:

> I suspect that it is impractical to reprogram the PIT on a very fine 
> granularity.

yes - reprogramming the PIT can take up to 10 usecs even on recent PCs.  
(in fact the cost is pretty much system-independent due to PIO.) On 
modern, PIT-less timesources (e.g. HPET) it can be faster.

> Btw, if somebody really gets excited about all this, let me say (once 
> again) what I think might be an acceptable situation.
> 
> First off, I'm _not_ a believer in "sub-HZ ticks". Quite the reverse. 
> I think we should have HZ be some high value, but we would _slow_down_ 
> the tick when not needed, and count by 2's, 3's or even 10's when 
> there's not a lot going on.

i think that would be an acceptable solution for high-precision timers, 
as long as two other problems are solved too:

 - there are real-time applications (robotic environments: fast rotating
   tools, media and mobile/phone applications, etc.) that want 10
   usecs precision. If such users increased HZ to 100,000 or even
   1000,000, the current timer implementation would start to creek: e.g.
   jiffies on 32-bit systems would wrap around in 11 hours or 1.1 hours.
   (To solve this cleanly, pretty much the only solution seems to be to
   increase the timeout to a 64 bit value. A non-issue for 64-bit
   systems, that's why i think we could eventually look at this 
   possibility, once all the other problems are hashed out.)

 - at very high HZ values the clustering of e.g. network timers is lost, 
   creating an artificially high number of timer interrupts. So likely 
   we'd still need some way to 'blur' timeouts and to round e.g. network 
   timers to the next 1 msec or 500 usecs boundary, to cluster up timers 
   for bulk processing. But in any case, such a solution does not sound 
   nearly as messy as the sub-jiffies method.

if the 'high precision' uses are not addressed [*] i fear the whole HRT 
game starts again: embedded folks trying to standardize on Linux for 
everything [**] will want HRT timers and will do addons and sub-jiffy 
approaches [***], and will push for inclusion. I think we could as well 
solve this whole problem area by making ridiculously high HZ values 
practical too!

	Ingo

[*]  there's also a third problem: timer prioritization. It's not 
     necessarily a problem the upstream kernel should care about, but 
     it's a problem for things that try to offer hard-real-time, like 
     PREEMPT_RT: HRT timers need to be prioritizable. If e.g. the system 
     is soaked handling network timers, it should still be possible for 
     that single mega-important HRT timer to run and wake up the 
     mega-high-priority RT task that will preempt all network activity 
     within 10 usecs worst-case. The sub-jiffies approach does this 
     prioritization in a natural way, because there HRT timers are 
     separate, so the prioritization of them is easy. With the grand 
     unified 'big HZ' scheme the HRT folks would have to implement a 
     mechanism to split off highprio timers from the stream of normal 
     timers. ]

[**] having high precision is also a perception and uniformity of 
     platform issue: most embedded developers will find 500 usecs 
     precision good enough for most uses, but it does not 'sound' good 
     enough, and there's no easy way out either. So _if_ there's the 
     occasional need for higher precision they'll have no easy solution 
     for Linux, and this prevents them from standardizing on Linux for 
    _everything_.


[***]
   a side-thought about sub-jiffies: the biggest conceptual problem 
   the sub-jiffy method has is the sorting needed when timers move from 
   the jiffy bucket into the HRT list which doesnt scale - but this is 
   really a HRT-timers-internal problem.  It could be further improved 
   by e.g.  dividing the last jiffy up into say 10 usec buckets - with a 
   1msec jiffy clock that's 100 buckets, and having a bitmap to see 
   which bucket is active. Then the 'get the next timer' act becomes a 
   matter of searching the bitmap for the next bit set - at pretty much 
   constant overhead. Even a 1 usec precision would mean only 1000 
   buckets for the last jiffy, with 1000 bits (128 bytes) to search, 
   still quite ok. But, in any case, it would be nice to avoid the 
   "conceptual dualness" of the HRT patch.
