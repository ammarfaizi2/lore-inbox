Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S311915AbSCTSSa>; Wed, 20 Mar 2002 13:18:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S311912AbSCTSSS>; Wed, 20 Mar 2002 13:18:18 -0500
Received: from e31.co.us.ibm.com ([32.97.110.129]:40188 "EHLO
	e31.co.us.ibm.com") by vger.kernel.org with ESMTP
	id <S293020AbSCTSSB>; Wed, 20 Mar 2002 13:18:01 -0500
Date: Wed, 20 Mar 2002 10:16:44 -0800
From: "Martin J. Bligh" <Martin.Bligh@us.ibm.com>
To: Andrea Arcangeli <andrea@suse.de>
cc: linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: Scalability problem (kmap_lock) with -aa kernels
Message-ID: <122510000.1016648204@flay>
In-Reply-To: <20020320173959.F4268@dualathlon.random>
X-Mailer: Mulberry/2.1.2 (Linux/x86)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--On Wednesday, March 20, 2002 17:39:59 +0100 Andrea Arcangeli <andrea@suse.de> wrote:

> On Wed, Mar 20, 2002 at 08:14:31AM -0800, Martin J. Bligh wrote:
>> I don't believe that kmap_high is really O(N) on the size of the pool.
> 
> It is O(N), that's the worst case. Of course assuming that the number of
> entries in the pool is N and that it is variable, for us it is variable
> at compile time.
> ...
> and if we didn't find anything we call flush_all_zero_pkmaps that does a
> whole O(N) scan on the pool to try to release the entries that aren't
> pinned and then we try again. In short if we increase the pool size, we
> linearly increase the time we spend on it (actually more than linearly
> because we'll run out of l1/l2/l3 while the pool size increases)

Worst case I agree is about is O(N), though you're forgetting the cost of
the global tlb_flush_all. Average case isn't by a long way, it's more like
O(1).

N = size of pool - number of permanent maps (makes the math readable)
F = cost of global tlbflush.

cost without flush = 1, which happens every time we do an alloc.
cost of flush = N + F (N to go through flush_all_pkmaps, zeroing)

=> average cost = 1/N + (N+F)/N = (1+F+N)/N = 1 + (1+F)/N

So the cost (on average) actually gets cheaper as the pool size increases.
Yes, I've simpilified things a little by ignoring the case of stepping over
the permanently allocated maps (this get less frequent as pool size is
increased, thus this actually helps), and by ignoring the cache effects
you mention, but I'm sure you see my point.

If you wanted to fix the worst case for latency issues, I would think it
would be possible to split the pool in half - we could still allocate out
of one half whilst we flush the other half (release the lock during a
half-flush, but mark in a current_half variable (protected by the lock) 
where newcomers should be currently allocating from). I haven't really
thought this last bit through, so it might be totally bogus.

But all this is moot, as what's killing me is really the global lock ;-)

>> If you could give me a patch to do that, I'd be happy to try it out.
> 
> I will do that in the next -aa. I've quite a lot of stuff pending

Cool - thanks.
 
> The only brainer problem with the total removal of the persistent kmaps
> are the copy-users, what's your idea about it? (and of course I'm not
> going to change that anyways in 2.4, it's not a showstopper)

Writing that up now ...

M.

