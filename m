Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S272612AbTHPFCe (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 16 Aug 2003 01:02:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S272615AbTHPFCd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 16 Aug 2003 01:02:33 -0400
Received: from fw.osdl.org ([65.172.181.6]:9620 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S272612AbTHPFCb (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 16 Aug 2003 01:02:31 -0400
Date: Fri, 15 Aug 2003 22:03:24 -0700
From: Andrew Morton <akpm@osdl.org>
To: Matt Mackall <mpm@selenic.com>
Cc: tytso@mit.edu, jmorris@intercode.com.au, jamie@shareable.org,
       linux-kernel@vger.kernel.org, davem@redhat.com
Subject: Re: [RFC][PATCH] Make cryptoapi non-optional?
Message-Id: <20030815220324.1be2950b.akpm@osdl.org>
In-Reply-To: <20030816043816.GC325@waste.org>
References: <20030809173329.GU31810@waste.org>
	<Mutt.LNX.4.44.0308102317470.7218-100000@excalibur.intercode.com.au>
	<20030810174528.GZ31810@waste.org>
	<20030813032038.GA1244@think>
	<20030813040614.GP31810@waste.org>
	<20030815221211.GA4306@think>
	<20030815235501.GB325@waste.org>
	<20030815170532.06e14e89.akpm@osdl.org>
	<20030816043816.GC325@waste.org>
X-Mailer: Sylpheed version 0.9.4 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Matt Mackall <mpm@selenic.com> wrote:
>
> a) extract_entropy (pool->lock)
> 
> ...
> 
>  [There was also a cute sleeping problem here with random_read.
>  random_read used old-style open-coded sleeping, marked itself
>  TASK_INTERRUPTIBLE, then called extract_entropy, which would do a
>  conditional reschedule, and fall asleep until the next wake up,
>  despite having enough entropy to fulfill the request.]

OK.  There was no description of all this in your initial patch, so I don't
know which patches solve these problems.

> ...
>  [By the way, whoever did the workqueue conversion for 2.5 changed this
>  code to wakeup the processing worker when the sample pool was half
>  full rather on every sample but got the test not quite right.

That would have been me.  The context switch rate due to
add_disk_randomness() was much too high (1000/sec iirc), so that was an
attempt to reduce the wakeup rate.

What we really should try to do is to not pass the work to keventd at all:
just do the entropy addition right there in interrupt context, with
appropriate locking.


> f) change_poolsize (queued for resend)

Queued for resend because I just didn't know what to do with the patches.

I do not understand the random driver, and judging from the past couple of
days discussions I'm not likely to.  I don't know how to test it and I
doubt if anyone else is testing it in sufficient depth.

And, to add to my dilemma, the random driver is security-related and
something which scary propellor-headed types get all emotional about :)

So getting these changes in will be hard.  It would help a lot if they
could be presented individually and that Ted, Jamie and/or other interested
parties were to review and ack them.

> g) urandom starves/races random (queued for resend)
> 
>  Readers of /dev/urandom and get_random_bytes (both nonblock) pull from
>  the same pool as /dev/random readers and without limit. As there are
>  numerous users of get_random_bytes as pointed out above, /dev/random
>  readers can easily be starved (and previously, race on wakeup), even
>  by remote readers. This is rather a problem for the classic
>  entropy-source-limited headless web server which may very well be
>  trying to use both in, for example, a departmental certificate
>  authority.
> 
>  My solution is to clean up the pool creation code and add a second
>  output pool for nonblocking users. The pool reseeding logic is
>  cleaned up to address a bunch of corner cases and has a low watermark
>  parameter so that the nonblocking users can avoid draining the input
>  pool entirely. The current default is to not let nonblocking readers
>  draw the input pool below the point where blocking readers can do two
>  catastrophic reseeds.
> 
>  The cleanup of the pool code lets this easily become per_cpu output
>  pools for the non-blocking readers with about 10 lines of code if the
>  above-mentioned contention is an issue. I haven't tried this yet, but
>  I already did per_cpu for the cryptoapi stuff and it should be about
>  the same.
> 
>  We could go completely lockless for the nonblocking pool also, but
>  that would require some code duplication.

hrm.  That's one which I actually understood.  There is yet hope.


