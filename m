Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030178AbWJVCSl@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030178AbWJVCSl (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 21 Oct 2006 22:18:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751756AbWJVCSl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 21 Oct 2006 22:18:41 -0400
Received: from mx2.rowland.org ([192.131.102.7]:40202 "HELO mx2.rowland.org")
	by vger.kernel.org with SMTP id S1750722AbWJVCSk (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 21 Oct 2006 22:18:40 -0400
Date: Sat, 21 Oct 2006 22:18:38 -0400 (EDT)
From: Alan Stern <stern@rowland.harvard.edu>
X-X-Sender: stern@netrider.rowland.org
To: "Paul E. McKenney" <paulmck@us.ibm.com>
cc: David Howells <dhowells@redhat.com>,
       Kernel development list <linux-kernel@vger.kernel.org>
Subject: Re: Uses for memory barriers
In-Reply-To: <20061021225228.GB17088@us.ibm.com>
Message-ID: <Pine.LNX.4.44L0.0610212201090.29992-100000@netrider.rowland.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 21 Oct 2006, Paul E. McKenney wrote:

> > This is identical to the previous version, since by definition
> > 
> > 	st_i(B) ==> ld_j(B)  is equivalent to  st_i(B) => ld_j(B) &&
> > 		not exist k: st_i(B) => st_k(B) => ld_j(B).
> 
> OK -- we were assuming slightly different definitions of "==>".  I as
> assuming that if st==>ld1==>ld2, that it is not the case that "st==>ld2".
> In this circumstance, your definition is certainly more convenient than
> is mine.  In the case of MMIO, the situation might be reversed.

MMIO of course is completely different.  For regular memory accesses I 
think we should never allow a load on the left side of "=>" or "==>".  
Keep them invisible!  :-)

Writing ld(A) => st(A) is bad because (1) it suggests that the store
somehow "sees" the load (which it doesn't; the load is invisible), and (2)  
it suggests that the store occurs "later" in some sense than the load
(which might not be true, since a load doesn't necessarily return the
value of the temporally most recent store).

My viewpoint is that "=>" really provides an ordering of stores only.  
Its use with loads is something of an artifact; it gives a convenient way
of expressing the fact that a load "sees" an initial segment of all the
stores to a variable (and the value it returns is that of the last store
in the segment).

> > (2) doesn't make sense, since loads aren't part of the global ordering of
> > accesses of B -- they are invisible.  (BTW, you don't need to assume as
> > well that stores are blind; it's enough just to have loads be invisible.)  
> > Each load sees an initial sequence of stores ending in the store whose
> > value is returned by the load, but this doesn't mean that the load occurs
> > between that store and the next one.
> 
> That is due to our difference in definition.  Perhaps the following
> definition:  "A==>B" means either that B sees the value stored by A
> or that B sees the same value as does A?
> 
> Some work will be required to see what is best.

How about this instead: "A==>B" means that B sees the value stored by A,
and "A==B" means that A and B are both loads and they see the value from
the same store.  That way we avoid putting a load on the left side of
"==>".


> > (3) The assumption should be that both accesses of B are atomic; it 
> > doesn't matter whether the accesses of A are.
> 
> Check out the i386 default definition of spin_unlock() -- no atomic
> operations.  So only the final access of B (the one corresponding to
> spin_lock()) would need to be atomic.

You are right.

Alan

