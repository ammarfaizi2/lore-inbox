Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129074AbQJ0IWl>; Fri, 27 Oct 2000 04:22:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129137AbQJ0IWb>; Fri, 27 Oct 2000 04:22:31 -0400
Received: from vger.timpanogas.org ([207.109.151.240]:58628 "EHLO
	vger.timpanogas.org") by vger.kernel.org with ESMTP
	id <S129074AbQJ0IWZ>; Fri, 27 Oct 2000 04:22:25 -0400
Date: Fri, 27 Oct 2000 02:17:50 -0600
From: "Jeff V. Merkey" <jmerkey@vger.timpanogas.org>
To: Alexander Viro <viro@math.psu.edu>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Negative scalability by removal of lock_kernel()?(Was: Strange performance behavior of 2.4.0-test9)
Message-ID: <20001027021750.A2944@vger.timpanogas.org>
In-Reply-To: <39F92187.A7621A09@timpanogas.org> <Pine.GSO.4.21.0010270257550.18660-100000@weyl.math.psu.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 1.0i
In-Reply-To: <Pine.GSO.4.21.0010270257550.18660-100000@weyl.math.psu.edu>; from viro@math.psu.edu on Fri, Oct 27, 2000 at 03:13:33AM -0400
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 27, 2000 at 03:13:33AM -0400, Alexander Viro wrote:
> 
> 
> On Fri, 27 Oct 2000, Jeff V. Merkey wrote:
> 
> > 
> > Linux has lots of n-sqared linear list searches all over the place, and
> > there's a ton of spots I've seen it go linear by doing fine grained
> > manipulation of lock_kernel() [like in BLOCK.C in NWFS for sending async
> > IO to ll_rw_block()].   I could see where there would be many spots
> > where playing with this would cause problems.  
> > 
> > 2.5 will be better.
> 
> fs/locks.c is one hell of a sick puppy. Nothing new about that. I'm kinda
> curious about "n-squared" searches in other places, though - mind showing
> them?


I've noticed in 2.2.X if I hold lock_kernel() over multiple calls to 
ll_rw_block() while feeding it chains of buffer heads > 100 at a time 
(one would think this would make the elevator get better numbers by 
feeding it a bunch of buffer heads at once rahter than feeding them in 
one at a time), performance gets slower rather than faster.  I did 
some profiling, and ll_rw_block() and functions beneath it was using a 
lot of cycles.  I think there may be cases where the code that 
does the merging and sorting is hitting (O)(N)**2 instead of (O)(N).   
When I compare the profile numbers to the buffer head window in 
between calls to ll_rw_block(), the relationship is not (O)(N).  

By default I just hold lock_kernel() over the calls to ll_rw_block() 
for each buffer head in 2.2.X.

2.4 does not need lock_kernel() to be called any longer since ll_rw_block()
is now multi-threaded.  The overall model of intereaction has not changed
in 2.4 from 2.2 much.  I just no longer have to provide the serialization
for ll_rw_block() because it's provided underneath now, but what I saw
indicates that as the request list gets full, some of the logic is 
not performing at a relationship of (O)(N) # requests vs. utilization.

This would indicate somewhere down in that code, there's a spot where 
we end up spinning sround a lot mucking with lists or something.

:-)

Jeff

> 
> BTW, what spinlocks get contention in variant without BKL? And what about
> comparison between the BKL and non-BKL versions? If it's something like
> 	BKL	no BKL
> 4-way	50	20
> 8-way	30	30
> - something is certainly wrong, but restoring the BKL is _not_ a win.
> 
> I didn't look into recent changes in fs/locks.c, but I have quite problem
> inventing a scenario when _adding_ BKL (without reverting other changes)
> might give an absolute improvement. Well, I see a couple of really perverted
> scenarios, but... Seriously, folks, could you compare the 4 variants above
> and gather the contention data for the -test9 on your loads? That would help
> a lot.
> 
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
