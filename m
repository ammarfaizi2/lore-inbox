Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318172AbSG3BH4>; Mon, 29 Jul 2002 21:07:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318165AbSG3BH4>; Mon, 29 Jul 2002 21:07:56 -0400
Received: from penguin.e-mind.com ([195.223.140.120]:28458 "EHLO
	penguin.e-mind.com") by vger.kernel.org with ESMTP
	id <S317602AbSG3BHz>; Mon, 29 Jul 2002 21:07:55 -0400
Date: Tue, 30 Jul 2002 03:12:24 +0200
From: Andrea Arcangeli <andrea@suse.de>
To: Daniel McNeil <daniel@osdl.org>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.4.19rc2aa1 i_size atomic access
Message-ID: <20020730011224.GR1201@dualathlon.random>
References: <1026949132.20314.0.camel@joe2.pdx.osdl.net> <1026951041.2412.38.camel@IBM-C> <20020718103511.GG994@dualathlon.random> <1027037361.2424.73.camel@IBM-C> <20020719112305.A15517@oldwotan.suse.de> <1027119396.2629.16.camel@IBM-C> <20020723170807.GW1116@dualathlon.random> <1027989256.578.30.camel@IBM-C>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1027989256.578.30.camel@IBM-C>
User-Agent: Mutt/1.3.27i
X-GnuPG-Key-URL: http://e-mind.com/~andrea/aa.gnupg.asc
X-PGP-Key-URL: http://e-mind.com/~andrea/aa.asc
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 29, 2002 at 05:34:16PM -0700, Daniel McNeil wrote:
> Andrea,
> 
> Sorry I haven't responded, but I was on vacation all last week and
> was not near a computer.

No problem :)

> I like your code change.  Incrementing the v2 before the v1 in the
> i_size_write() is much better.  My code was definitely uglier -- but
> it was correct since the version1 and version2 where sampled before
> i_size was read and version1 and version2 where checked again after.
> It was excessive, but correct.

ok, so you had the dependency v1 == v2, so you were also implicitly
comparing v2 with the new version 1 ok.

> 
> On your patch, shouldn't non-smp preempt still use the 64-bit stuff?
> The comment says it should, but the #ifdef's are not checking for
> PREEMPT or did I miss something?

there's no preempt in 2.4, the comment was meant for anybody foward
porting it to 2.5.

> I would still be curious about the performance difference between the 
> version approach and the cmpxchg8 approach.  With SMP I'm a bit worried
> about the cacheline bouncing around and the memory bandwith wasted.

Randy didn't report any decrease in performance, so in normal loads 
shouldn't be noticeable.

> Any ideas on what kind of test would be appropriate?
> I've got access to 2-proc to 8-proc systems I could run some tests on,
> just not sure what test would be useful.  The fstat() test isn't
> realistic.

I would say dbench is a good candidate for this kind of change to verify
it's not noticeable.

then you could test two parallel reads on the same inode, for example
two parallel dd if=file of=/dev/null reading from cache, and see if
there's a difference of bandwidth with cmpxchg8b and ordered
read/writes (on a 4p you could try with 4 parallel dd).

> Increasing the versions to 32-bit is ok with -- I was just trying to
> not waste too much space.

ok, as said the int granularity is going to be atomic for all archs.

Andrea
