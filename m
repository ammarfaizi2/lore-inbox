Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S273495AbRJIJJN>; Tue, 9 Oct 2001 05:09:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S273789AbRJIJJD>; Tue, 9 Oct 2001 05:09:03 -0400
Received: from sydney1.au.ibm.com ([202.135.142.193]:2574 "EHLO
	haven.ozlabs.ibm.com") by vger.kernel.org with ESMTP
	id <S273495AbRJIJIv>; Tue, 9 Oct 2001 05:08:51 -0400
Date: Tue, 9 Oct 2001 19:03:37 +1000
From: Rusty Russell <rusty@rustcorp.com.au>
To: Richard Henderson <rth@twiddle.net>
Cc: pmckenne@us.ibm.com, lse-tech@lists.sourceforge.net,
        linux-kernel@vger.kernel.org
Subject: Re: RFC: patch to allow lock-free traversal of lists with insertion
Message-Id: <20011009190337.0009802c.rusty@rustcorp.com.au>
In-Reply-To: <20011008235208.A26109@twiddle.net>
In-Reply-To: <200110090155.f991tPt22329@eng4.beaverton.ibm.com>
	<20011008235208.A26109@twiddle.net>
X-Mailer: Sylpheed version 0.5.3 (GTK+ 1.2.10; powerpc-unknown-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 8 Oct 2001 23:52:08 -0700
Richard Henderson <rth@twiddle.net> wrote:

> On Mon, Oct 08, 2001 at 06:55:24PM -0700, Paul E. McKenney wrote:
> > This is a proposal to provide a wmb()-like primitive that enables
> > lock-free traversal of lists while elements are concurrently being
> > inserted into these lists.
> 
> I've discussed this with you before and you continue to have
> completely missed the point.
> 
> Alpha requires that you issue read-after-read memory barriers on
> the reader side if you require ordering between reads.  That is
> the extent of the weakness of the memory ordering.

Actually, I think you are missing the point.  On most architectures, a
writer can do:

	int *global_ptr = NULL;

	x = 1;
	wmb();
	global_ptr = &x;

And a reader can rely on the dereference as an implicit read barrier:

	if (global_ptr) {
		if (*global_ptr != 1)
			BUG();
	}

This is *not guarenteed* on the Alpha.  To quote an earlier offline mail
from Paul McKenney (cc'd to you):

> The case that they said can cause trouble is if the CPU 1's caches are
> partitioned.  In such cases, the partitions of the cache run pretty much
> independently.  If "p" is in a cacheline handled by one partition, and
> "*p" is in a cacheline handled by the other partition, it is possible
> for the invalidation of "p" (due to the "p = &a") to get processed before
> the invalidation of "*p" (which is just "a", due to the "a = 1").

Now, expecting every piece of code to insert an rmb() before dereferencing
a pointer in these cases, just so Alphas don't fail occasionally is NOT a
good solution.  Inventing a "rmb_me_harder()" macro for Alpha only is pretty
horrible too.  I don't *like* making Alpha's wmb() stronger, but it is the
only solution which doesn't touch common code.

Of course, we can continue to ignore it, which is my preferred solution.

Hope that helps,
Rusty.
PS.  This was used by Alan Cox for lock-free insertion into the firewall linked
     list in 2.0 - 2.2, and will become more common.
