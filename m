Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750713AbWHRG3t@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750713AbWHRG3t (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 18 Aug 2006 02:29:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750735AbWHRG3t
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 18 Aug 2006 02:29:49 -0400
Received: from smtp.osdl.org ([65.172.181.4]:27783 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1750713AbWHRG3s (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 18 Aug 2006 02:29:48 -0400
Date: Thu, 17 Aug 2006 23:29:42 -0700
From: Andrew Morton <akpm@osdl.org>
To: David Chinner <dgc@sgi.com>
Cc: Neil Brown <neilb@suse.de>, linux-kernel@vger.kernel.org
Subject: Re: RFC - how to balance Dirty+Writeback in the face of slow
 writeback.
Message-Id: <20060817232942.c35b1371.akpm@osdl.org>
In-Reply-To: <20060818001102.GW51703024@melbourne.sgi.com>
References: <17633.2524.95912.960672@cse.unsw.edu.au>
	<20060815010611.7dc08fb1.akpm@osdl.org>
	<20060815230050.GB51703024@melbourne.sgi.com>
	<17635.60378.733953.956807@cse.unsw.edu.au>
	<20060816231448.cc71fde7.akpm@osdl.org>
	<20060818001102.GW51703024@melbourne.sgi.com>
X-Mailer: Sylpheed version 2.2.7 (GTK+ 2.8.17; x86_64-unknown-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 18 Aug 2006 10:11:02 +1000
David Chinner <dgc@sgi.com> wrote:

> 
> > Something like that covers the global dirty+writeback problem.  The other
> > major problem space is the multiple-backing-device problem:
> > 
> > a) One device is being written to heavily, another lightly
> > 
> > b) One device is fast, another is slow.
> 
> Once we are past the throttling threshold, the only thing that
> matters is whether we can write more data to the backing device(s).
> We should not realy be allowing the input rate to exceed the output
> rate one we are passed the throttle threshold.

True.

But it seems really sad to block some process which is doing a really small
dirtying (say, some dopey atime update) just because some other process is
doing a huge write.

Now, things _usually_ work out all right, if only because of
balance_dirty_pages_ratelimited()'s logic.  But it's more by happenstance
than by intent, and these sorts of interferences can happen.

> > To solve this properly we'd need to account for
> > dirty+writeback(+unstable?) pages on a per-backing-dev basis.
> 
> We'd still need to account for them globally because we still need
> to be able to globally limit the amount of dirty data in the
> machine.
> 
> FYI, I implemented a complex two-stage throttle on Irix a couple of
> years ago - it uses a per-device soft throttle threshold that is not
> enforced until the global dirty state passes a configurable limit.
> At that point, the per-device limits are enforced.
> 
> This meant that devices with no dirty state attached to them could
> continue to dirty pages up to their soft-threshold, whereas heavy
> writers would be stopped until their backing devices fell back below
> the soft thresholds.
> 
> Because the amount of dirty pages could continue to grow past safe
> limits if you had enough devices, there is also a global hard limit
> that cannot be exceeded and this throttles all incoming write
> requests regardless of the state of the device it was being written
> to.
> 
> The problem with this approach is that the code was complex and
> difficult to test properly. Also, working out the default config
> values was an exercise in trial, error, workload measurement and
> guesswork that took some time to get right.
> 
> The current linux code works as well as that two-stage throttle
> (better in some cases!) because of one main thing - bound request
> queue depth with feedback into the throttling control loop. Irix
> has neither of these so the throttle had to provide this accounting
> and limiting (soft throttle threshold).
> 
> Hence I'm not sure that per-backing-device accounting and making
> decisions based on that accounting is really going to buy us much
> apart from additional complexity....
> 

hm, interesting.

It seems that the many-writers-to-different-disks workloads don't happen
very often.  We know this because

a) The 2.4 performance is utterly awful, and I never saw anybody
   complain and

b) 2.6 has the risk of filling all memory with under-writeback pages,
   and nobdy has complained about that either (iirc).

Relying on that observation and the request-queue limits has got us this
far but yeah, we should plug that PageWriteback windup scenario.

btw, Neil, has the Pagewriteback windup actually been demonstrated?  If so,
how?
