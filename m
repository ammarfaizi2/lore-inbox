Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261389AbULEUwd@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261389AbULEUwd (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 5 Dec 2004 15:52:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261384AbULEUwd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 5 Dec 2004 15:52:33 -0500
Received: from main.gmane.org ([80.91.229.2]:13775 "EHLO main.gmane.org")
	by vger.kernel.org with ESMTP id S261395AbULEUvO (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 5 Dec 2004 15:51:14 -0500
X-Injected-Via-Gmane: http://gmane.org/
To: linux-kernel@vger.kernel.org
From: "Joseph Seigh" <jseigh_02@xemaps.com>
Subject: Re: Proposal for a userspace "architecture portability" library
Date: Sun, 05 Dec 2004 14:48:16 -0500
Message-ID: <opsijvyqt8s29e3l@grunion>
References: <16818.23575.549824.733470@cargo.ozlabs.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
	format=flowed	delsp=yes
Content-Transfer-Encoding: 7BIT
X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: stenquists.ne.client2.attbi.com
User-Agent: Opera M2/7.54 (Win32, build 3865)
Cc: libc-alpha@sources.redhat.com
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 5 Dec 2004 11:53:43 +1100, Paul Mackerras <paulus@samba.org> wrote:

> Some of our kernel headers implement generally useful abstractions
> across all of the architectures we support.  I would like to make an
> "architecture portability" library, based on the kernel headers but as
> a separate project from the kernel, and intended for use in userspace.
>
> The headers that I want to base this on are:
>
> atomic.h
> bitops.h
> byteorder.h
> rwsem.h
> semaphore.h
> spinlock.h
> system.h (for mb et al., xchg, cmpxchg)
> unaligned.h
>

The atomics would be a good idea especially if they were cleaned up a  
little.
A list of functions that would be useful

atomic_set  -- atomically fetches a value
atomic_read -- atomically stores a value

These two exist but one should be renamed for consistancy, atomic_write or  
atomic_get.

fetch_and_add -- atomically add to an integer and return result.
fetch_and_increment -- atomically increment by one and return result
fetch_and_decrement -- atomically decrement by one and return result.

fetch_and_add could replace the numerous atomic_(add,sub,inc,dec)_xxxx  
which either don't
test for the right condition or don't test the result at all.   Also, get  
rid of atomic_t.  It doesn't
appear to be useful and is a pain to work around.  We probably need a way  
to define what
operands are atomic but that's not the way to do it.   The fetch and  
increment/decrement
aren't really needed but would allow optimization for some platforms.

Generic interlocked instructions such as compare and swap.  I prefer IBM  
style which returns
a sucessful/not successful w/ update of compare value over the Microsoft  
style which returns
the old value.   For hardware with LL/SC, compare and swap can be  
simulated.  Also
double wide compare and swap.  Not all platforms have it but it's  
imporatant enough to
provide even if you have to simulate it on the ones that don't.   Also an  
xchg/swap atomic
op would be a nice optimization for those platforms that have it.  You  
don't use it
a lot but when you do it's a nice optimization over simulating it using  
compare and swap.

Memory barriers also.  At a minimum, rmb(), wmb(), and mb().  If you're  
ambitious finer
granularity membars such as those on sparc.  You can use stronger membars  
on architectures
that don't have that granularity.   Also the dependent load barrier  
read_barrier_depends().
This would be used by many lock-free algorithms, not just RCU, which  
itself can have
multiple implementations for preemptive user threads.  I've done 3  
implementations of
RCU for preemtive user threads so far.

Read/write locks and semaphores already exist in userspace.  Spinlocks I  
personally
would avoid as they can have rather significant negative performance  
impact.  You can
usually get what you want with lock-free algorithms without the negative  
consequences
that spin-locks have.

These are fairly advanced interfaces and you really need to know what  
you're doing.
While defining these interfaces could be considered dangerous by enabling  
the the
unqualified to use them, not providing them won't stop them from doing  
dangerous
and stupid things which they'll do anyway.  With official headers, you  
could provide
man pages and header comments with appropiate warnings and pointers to  
faqs.
A common error is the incorrect impementation of DCL (double checked  
locking)
which has its own DangerWillRobisonDanger web page here
http://www.cs.umd.edu/~pugh/java/memoryModel/DoubleCheckedLocking.html
which has had little effect in dissuading people from using it.  If you  
had an official
load w/ read_barrier_depends() macro similar to RCU's, it would be hard  
for people
to ignore the fact of its existence when informed of such.  It'd be  
"official".

And these interfaces will help immensly those of us working with lock-free  
algorithms
who don't have the time or resources to implement yet another atomic  
operation on
every single platform.

Joe Seigh

