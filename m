Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S272619AbTHPFkW (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 16 Aug 2003 01:40:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S272627AbTHPFkW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 16 Aug 2003 01:40:22 -0400
Received: from waste.org ([209.173.204.2]:32166 "EHLO waste.org")
	by vger.kernel.org with ESMTP id S272619AbTHPFkP (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 16 Aug 2003 01:40:15 -0400
Date: Sat, 16 Aug 2003 00:39:47 -0500
From: Matt Mackall <mpm@selenic.com>
To: Andrew Morton <akpm@osdl.org>
Cc: tytso@mit.edu, jmorris@intercode.com.au, jamie@shareable.org,
       linux-kernel@vger.kernel.org, davem@redhat.com
Subject: Re: [RFC][PATCH] Make cryptoapi non-optional?
Message-ID: <20030816053947.GE325@waste.org>
References: <20030809173329.GU31810@waste.org> <Mutt.LNX.4.44.0308102317470.7218-100000@excalibur.intercode.com.au> <20030810174528.GZ31810@waste.org> <20030813032038.GA1244@think> <20030813040614.GP31810@waste.org> <20030815221211.GA4306@think> <20030815235501.GB325@waste.org> <20030815170532.06e14e89.akpm@osdl.org> <20030816043816.GC325@waste.org> <20030815220324.1be2950b.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030815220324.1be2950b.akpm@osdl.org>
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Aug 15, 2003 at 10:03:24PM -0700, Andrew Morton wrote:
> Matt Mackall <mpm@selenic.com> wrote:
> >
> > a) extract_entropy (pool->lock)
> > 
> > ...
> > 
> >  [There was also a cute sleeping problem here with random_read.
> >  random_read used old-style open-coded sleeping, marked itself
> >  TASK_INTERRUPTIBLE, then called extract_entropy, which would do a
> >  conditional reschedule, and fall asleep until the next wake up,
> >  despite having enough entropy to fulfill the request.]
> 
> OK.  There was no description of all this in your initial patch, so I don't
> know which patches solve these problems.

Almost all of this was in the first locking patch, which was probably
shorter than this description.

> > ...
> >  [By the way, whoever did the workqueue conversion for 2.5 changed this
> >  code to wakeup the processing worker when the sample pool was half
> >  full rather on every sample but got the test not quite right.
> 
> That would have been me.  The context switch rate due to
> add_disk_randomness() was much too high (1000/sec iirc), so that was an
> attempt to reduce the wakeup rate.
> 
> What we really should try to do is to not pass the work to keventd at all:
> just do the entropy addition right there in interrupt context, with
> appropriate locking.

Agreed, will add to my list.

> > f) change_poolsize (queued for resend)
> 
> Queued for resend because I just didn't know what to do with the patches.
> 
> I do not understand the random driver, and judging from the past couple of
> days discussions I'm not likely to.  I don't know how to test it and I
> doubt if anyone else is testing it in sufficient depth.

Ok, well this piece remains oopsable by inspection, though it is root
only. See free_entropy_store:

        if (r->pool)
                kfree(r->pool);
        kfree(r);

..while r and r->pool are potentially being used concurrently.

> And, to add to my dilemma, the random driver is security-related and
> something which scary propellor-headed types get all emotional about :)
>
> So getting these changes in will be hard.  It would help a lot if they
> could be presented individually and that Ted, Jamie and/or other interested
> parties were to review and ack them.

Ok. I've significantly improved the instrumentation and will be happy
to post test cases along with my next fixes too. All the controversial
things are at the end of my queue, as well (the present controversy
was not about something I'd submitted for inclusion). 

If anyone's interested, I have a preliminary Debian package for NIST's
RNG statistical test suite too (though this is only good as a sanity
check).
 
> > g) urandom starves/races random (queued for resend)
> 
> hrm.  That's one which I actually understood.  There is yet hope.

I can probably break this into a bunch of pieces if the two its
already in don't seem obvious enough on their own.

-- 
Matt Mackall : http://www.selenic.com : of or relating to the moon
