Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030403AbWCUOSU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030403AbWCUOSU (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 21 Mar 2006 09:18:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030402AbWCUOST
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 21 Mar 2006 09:18:19 -0500
Received: from mail16.syd.optusnet.com.au ([211.29.132.197]:39556 "EHLO
	mail16.syd.optusnet.com.au") by vger.kernel.org with ESMTP
	id S1030403AbWCUOSS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 21 Mar 2006 09:18:18 -0500
From: Con Kolivas <kernel@kolivas.org>
To: Mike Galbraith <efault@gmx.de>
Subject: Re: interactive task starvation
Date: Wed, 22 Mar 2006 01:17:54 +1100
User-Agent: KMail/1.9.1
Cc: Willy Tarreau <willy@w.ods.org>, Ingo Molnar <mingo@elte.hu>,
       lkml <linux-kernel@vger.kernel.org>, Andrew Morton <akpm@osdl.org>,
       bugsplatter@gmail.com
References: <200603090036.49915.kernel@kolivas.org> <200603220045.54736.kernel@kolivas.org> <1142949690.7807.80.camel@homer>
In-Reply-To: <1142949690.7807.80.camel@homer>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200603220117.54822.kernel@kolivas.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wednesday 22 March 2006 01:01, Mike Galbraith wrote:
> On Wed, 2006-03-22 at 00:45 +1100, Con Kolivas wrote:
> > I give up. Add as many tunables as you like in as many places as possible
> > that even less people will understand. You've already told me you'll be
> > running 0,0.
>
> Instead of giving up, how about look at the code and make a suggestion
> for improvement?  It's not an easy problem, as you're well aware.
>
> I really don't see why you're (seemingly) getting irate.  Tunables for
> this are no different that tunables like CHILD_PENALTY etc etc etc.  How
> many casual users know those exist, much less understand them?

Because I strongly believe that tunables for this sort of thing are wrong. 
CHILD_PENALTY and friends have never been exported apart from out-of-tree 
patches. These were meant to be tuned in the kernel and never exported. Ingo 
didn't want *any* tunables so I'm relatively flexible with an on/off switch 
which he doesn't like. I really do believe most users will only have it on or 
off though. 

Don't think I'm ignoring your code. You inspired me to do the original patches 
3 years ago. 

I have looked at your patch at length and basically what it does is variably 
convert the interactive estimator from full to zero over some timeframe 
choosable with your tunables. Since most users will use either full or zero I 
actually believe the same effect can be had by a tiny modification to 
enable/disable the estimator anyway. This is not to deny you've done a lot of 
work and confirmed that the estimator running indefinitely unthrottled is 
bad. What timeframe is correct to throttle is impossible to say 
though :-( Most desktop users would be quite happy with indefinite because 
they basically do not hit workloads that "exploit" it. Most server/hybrid 
setups are willing to sacrifice some interactivity for fairness, and the 
basic active->expired design gives them enough interactivity without 
virtually any boost anyway. Ironically, audio is fabulous on such a design 
since it virtually never consumes a full timeslice. 

So any value you place on the timeframe as the default ends up being a 
compromise, and this is what Ingo is suggesting. This is similar to when 
sleep_avg changed from 10 seconds to 30 seconds to 2 seconds at various 
times. Luckily the non linear decay of sleep_avg circumvents that being 
relevant... but it also leads to the exact issue you're trying to fix. Once 
again we're left with choosing some number, and as much as I'd like to help 
since I really care about the desktop, I don't think any compromise is 
correct. Just on or off.

Cheers,
Con
