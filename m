Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751386AbWFBKaj@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751386AbWFBKaj (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 2 Jun 2006 06:30:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751387AbWFBKaj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 2 Jun 2006 06:30:39 -0400
Received: from mail22.syd.optusnet.com.au ([211.29.133.160]:26073 "EHLO
	mail22.syd.optusnet.com.au") by vger.kernel.org with ESMTP
	id S1751386AbWFBKaj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 2 Jun 2006 06:30:39 -0400
From: Con Kolivas <kernel@kolivas.org>
To: Nick Piggin <nickpiggin@yahoo.com.au>
Subject: Re: [PATCH RFC] smt nice introduces significant lock contention
Date: Fri, 2 Jun 2006 20:30:11 +1000
User-Agent: KMail/1.9.1
Cc: "Chen, Kenneth W" <kenneth.w.chen@intel.com>, linux-kernel@vger.kernel.org,
       "'Chris Mason'" <mason@suse.com>, Ingo Molnar <mingo@elte.hu>
References: <000201c6861f$6a2d4e20$0b4ce984@amr.corp.intel.com> <447FFD35.9020909@yahoo.com.au>
In-Reply-To: <447FFD35.9020909@yahoo.com.au>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200606022030.11481.kernel@kolivas.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Friday 02 June 2006 18:56, Nick Piggin wrote:
> Chen, Kenneth W wrote:
> > Ha, you beat me by one minute. It did cross my mind to use try lock there
> > as well, take a look at my version, I think I have a better inner loop.
>
> Actually you *have* to use trylocks I think, because the current runqueue
> is already locked.
>
> And why do we lock all siblings in the other case, for that matter? (not
> that it makes much difference except on niagara today).

If we spinlock (and don't trylock as you're proposing) we'd have to do a 
double rq lock for each sibling. I guess half the time double_rq_lock will 
only be locking one runqueue... with 32 runqueues we either try to lock all 
32 or lock 1.5 runqueues 32 times... ugh both are ugly.

> Rolled up patch with everyone's changes attached.

I'm still not sure that only doing trylock is adequate, and 
wake_sleeping_dependent is only called when a runqueue falls idle in 
schedule, not when it's busy so its cost (in my mind) is far less than 
dependent_sleeper.

-- 
-ck
