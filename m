Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751435AbWAEQWI@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751435AbWAEQWI (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 5 Jan 2006 11:22:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751469AbWAEQWI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 5 Jan 2006 11:22:08 -0500
Received: from smtp.osdl.org ([65.172.181.4]:4310 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1751435AbWAEQWG (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 5 Jan 2006 11:22:06 -0500
Date: Thu, 5 Jan 2006 08:21:03 -0800 (PST)
From: Linus Torvalds <torvalds@osdl.org>
To: Ingo Molnar <mingo@elte.hu>
cc: Nicolas Pitre <nico@cam.org>, Joel Schopp <jschopp@austin.ibm.com>,
       lkml <linux-kernel@vger.kernel.org>, Andrew Morton <akpm@osdl.org>,
       Arjan van de Ven <arjan@infradead.org>,
       Jes Sorensen <jes@trained-monkey.org>, Al Viro <viro@ftp.linux.org.uk>,
       Oleg Nesterov <oleg@tv-sign.ru>, David Howells <dhowells@redhat.com>,
       Alan Cox <alan@lxorguk.ukuu.org.uk>,
       Christoph Hellwig <hch@infradead.org>, Andi Kleen <ak@suse.de>,
       Russell King <rmk+lkml@arm.linux.org.uk>,
       Anton Blanchard <anton@samba.org>
Subject: Re: [patch 00/21] mutex subsystem, -V14
In-Reply-To: <20060105144016.GB16816@elte.hu>
Message-ID: <Pine.LNX.4.64.0601050810240.3169@g5.osdl.org>
References: <20060104144151.GA27646@elte.hu> <43BC5E15.207@austin.ibm.com>
 <Pine.LNX.4.64.0601042133230.27409@localhost.localdomain>
 <Pine.LNX.4.64.0601041847330.3279@g5.osdl.org> <20060105144016.GB16816@elte.hu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Thu, 5 Jan 2006, Ingo Molnar wrote:
> 
> the patch below adds the barriers to the asm-generic mutex routines, so 
> it's not like i'm lazy ;), but i really think this is unnecessary.  
> Adding this patch would add a second, unnecessary barrier for all the 
> arches that have barrier-less atomic ops.
> 
> it also makes sense: the moment you are interested in the 'previous 
> value' of the atomic counter in an atomic fashion, you very likely want 
> to use it for a critical section. (e.g. all the put-the-resource ops 
> that use atomic_dec_test() rely on this implicit barrier.)

Ok, fair enough. However, that still leaves the question of which way the 
barrier works. Traditionally, we have only cared about one thing: that all 
preceding writes have finished, because the "atomic_dec_return" thing is 
used as a _reference_counter_, and we're going to release the thing.

However, that's not the case in a mutex. A mutex locking operation works 
exactly the other way around: it doesn't really care about the previous 
writes at all, since those operations were unlocked. It cares about the 
_subsequent_ writes, since those have to be seen by others as being in the 
critical region, and never be seen as happening before the lock.

So I _think_ your argument is bogus, and your patch is bogus. The use of 
"atomic_dec_return()" in a mutex is _not_ the same barrier as using it for 
reference counting. Not at all. Memory barriers aren't just one thing: 
they are semi-permeable things in two different directions and with two 
different operations: there are several different kinds of them.

>  #define __mutex_fastpath_lock(count, fail_fn)				\
>  do {									\
> +	smp_mb__before_atomic_dec();					\
>  	if (unlikely(atomic_dec_return(count) < 0))			\
>  		fail_fn(count);						\
>  } while (0)

So I think the barrier has to come _after_ the atomic decrement (or 
exchange). 

Because as it is written now, any writes in the locked region could 
percolate up to just before the atomic dec - ie _outside_ the region. 
Which is against the whole point of a lock - it would allow another CPU to 
see the write even before it sees that the lock was successful, as far as
I can tell.

But memory ordering is subtle, so maybe I'm missing something..

		Linus
