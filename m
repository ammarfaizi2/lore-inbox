Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318771AbSHLRif>; Mon, 12 Aug 2002 13:38:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318772AbSHLRif>; Mon, 12 Aug 2002 13:38:35 -0400
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:13843 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id <S318771AbSHLRid>;
	Mon, 12 Aug 2002 13:38:33 -0400
Message-ID: <3D57F5D6.C54F5A2A@zip.com.au>
Date: Mon, 12 Aug 2002 10:52:22 -0700
From: Andrew Morton <akpm@zip.com.au>
X-Mailer: Mozilla 4.79 [en] (X11; U; Linux 2.4.19-rc5 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Linus Torvalds <torvalds@transmeta.com>
CC: Robert Love <rml@tech9.net>, Skip Ford <skip.ford@verizon.net>,
       "Adam J. Richter" <adam@yggdrasil.com>, ryan.flanigan@intel.com,
       linux-kernel@vger.kernel.org
Subject: Re: 2.5.31: modules don't work at all
References: <3D574972.DD878928@zip.com.au> <Pine.LNX.4.44.0208121016001.2274-100000@home.transmeta.com>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Linus Torvalds wrote:
> 
> On Sun, 11 Aug 2002, Andrew Morton wrote:
> >
> > Yes, that's the problem.   qm_symbols() is performing copy_to_user()
> > inside lock_kernel() and that's an "atomic copy_to_user()" in 2.5.31.
> > But only if preempt is selected.  The copy_to_user() doesn't work.
> >
> > There's nothing illegal about copy_to_user() inside lock_kernel().
> >
> > Linus, we can back out the preempt_count() test in there and
> > perform the atomic copy_*_user via a current->flags bit, or
> > we can do something else?
> 
> Since I'm actually hoping that the kernel lock goes away some day, and I
> don't want to pollute the stuff that I hope will _not_ go away, I'd prefer
> a slightly different approach, namely make kernel_lock() special from a
> preempt_count() angle.
> 
> In particular, we already "sort" the preemtion count bits according to
> just how atomic we are, and lock_kernel is certainly "less atomic" than a
> spinlock. So the logical thing to do (I think) is to just make that more
> explicit, and make lock_kernel use the low bit of preempt_count, and make
> regular spinlocks do a "+= 2" instead of a "+= 1".

Gets tricky with nested lock_kernels.

We can do

	if (preempt_count() - current->lock_depth)

To ignore the bkl contribution to preempt_count.

I think that's even usable in generic code, because all architectures
use lock_depth in the same way.
