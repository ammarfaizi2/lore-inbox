Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267932AbSIRSXS>; Wed, 18 Sep 2002 14:23:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S268261AbSIRSXS>; Wed, 18 Sep 2002 14:23:18 -0400
Received: from kweetal.tue.nl ([131.155.2.7]:65451 "EHLO kweetal.tue.nl")
	by vger.kernel.org with ESMTP id <S267932AbSIRSXQ>;
	Wed, 18 Sep 2002 14:23:16 -0400
Date: Wed, 18 Sep 2002 20:28:18 +0200
From: Andries Brouwer <aebr@win.tue.nl>
To: Ingo Molnar <mingo@elte.hu>
Cc: Linus Torvalds <torvalds@transmeta.com>,
       William Lee Irwin III <wli@holomorphy.com>,
       <linux-kernel@vger.kernel.org>
Subject: Re: [patch] lockless, scalable get_pid(), for_each_process() elimination, 2.5.35-BK
Message-ID: <20020918182818.GA14629@win.tue.nl>
References: <20020918123206.GA14595@win.tue.nl> <Pine.LNX.4.44.0209181452050.19672-100000@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.44.0209181452050.19672-100000@localhost.localdomain>
User-Agent: Mutt/1.3.25i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 18, 2002 at 02:56:19PM +0200, Ingo Molnar wrote:
> On Wed, 18 Sep 2002, Andries Brouwer wrote:
> 
> > I still don't understand the current obsession with this stuff. It is
> > easy to have pid_max 2^30 and a fast algorithm that does not take any
> > more kernel space.
> 
> it's only an if(unlikely()) branch in a 1:4096 slowpath to handle this, so
> why not? If it couldnt be done sanely then i wouldnt argue about this, but
> look at the code, it can be done cleanly and with very low cost.

In my opinion you are doing something that is entirely superfluous,
and at nonzero cost.

> > It seems to me you are first creating an unrealistic and unfavorable
> > situation (put pid_max at some artificially low value, [...]
> 
> we want the default to be low, so that compatibility with the older SysV
> APIs is preserved.

Do you know of any programs that would be affected?
Last I did a grep on all source rpm's in some SuSE or RedHat distribution,
there was not a single program.

> Also, why use a 128K bitmap to handle 1 million PIDs on
> a system that has at most 1000 tasks running? I'd rather use an algorithm
> that scales well from low pid_max to a larger pid_max as well.

Yes indeed. So I advertize not using any bitmap at all.

> > Please leave pid_max large.
> 
> why? For most desktop systems even 32K PIDs is probably too high. A large
> pid_max only increases the RAM footprint. (well not under the current
> allocation scheme but still.)

I have said it so many times, but let me repeat.
A large pid_max makes your system faster.

Collisions cost time. In a large space there are few collisions.

Now suppose you start 10^4 tasks at boot time and after 10^9 forks
you have to come back. Do you necessarily have to come across this
bunch of 10^4 tasks that are still sitting there?
That would be unfortunate.

But, you see, there are really many ways to avoid that.

Let me just invent one on the spot. Pick a random generator with
period 2^128 - 1 and each time you want a new pid pick the last
30 bits of its output. Why is that nice? Next time you come
around to the same pid, pids that were close together first
are far apart the second time.

You see, no data structures, no bitmaps, and very good behaviour
on average, even after 10^9 forks.

But there are lots of other solutions.

I would prefer to avoid talking about specific solutions as long as
this is not a problem that occurs in practice (with 30-bit pids).
I just want to stress: the larger the pid space, the faster your
computer forks.

Andries
