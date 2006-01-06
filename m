Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750824AbWAFHfK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750824AbWAFHfK (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 6 Jan 2006 02:35:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750912AbWAFHfK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 6 Jan 2006 02:35:10 -0500
Received: from 167.imtp.Ilyichevsk.Odessa.UA ([195.66.192.167]:19899 "HELO
	ilport.com.ua") by vger.kernel.org with SMTP id S1750824AbWAFHfI
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 6 Jan 2006 02:35:08 -0500
From: Denis Vlasenko <vda@ilport.com.ua>
To: Linus Torvalds <torvalds@osdl.org>
Subject: Re: [patch 00/21] mutex subsystem, -V14
Date: Fri, 6 Jan 2006 09:34:37 +0200
User-Agent: KMail/1.8.2
Cc: Ingo Molnar <mingo@elte.hu>, Nicolas Pitre <nico@cam.org>,
       Joel Schopp <jschopp@austin.ibm.com>,
       lkml <linux-kernel@vger.kernel.org>, Andrew Morton <akpm@osdl.org>,
       Arjan van de Ven <arjan@infradead.org>,
       Jes Sorensen <jes@trained-monkey.org>, Al Viro <viro@ftp.linux.org.uk>,
       Oleg Nesterov <oleg@tv-sign.ru>, David Howells <dhowells@redhat.com>,
       Alan Cox <alan@lxorguk.ukuu.org.uk>,
       Christoph Hellwig <hch@infradead.org>, Andi Kleen <ak@suse.de>,
       Russell King <rmk+lkml@arm.linux.org.uk>,
       Anton Blanchard <anton@samba.org>
References: <20060104144151.GA27646@elte.hu> <20060105144016.GB16816@elte.hu> <Pine.LNX.4.64.0601050810240.3169@g5.osdl.org>
In-Reply-To: <Pine.LNX.4.64.0601050810240.3169@g5.osdl.org>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200601060934.38155.vda@ilport.com.ua>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thursday 05 January 2006 18:21, Linus Torvalds wrote:
> On Thu, 5 Jan 2006, Ingo Molnar wrote:
> > 
> > the patch below adds the barriers to the asm-generic mutex routines, so 
> > it's not like i'm lazy ;), but i really think this is unnecessary.  
> > Adding this patch would add a second, unnecessary barrier for all the 
> > arches that have barrier-less atomic ops.
> > 
> > it also makes sense: the moment you are interested in the 'previous 
> > value' of the atomic counter in an atomic fashion, you very likely want 
> > to use it for a critical section. (e.g. all the put-the-resource ops 
> > that use atomic_dec_test() rely on this implicit barrier.)
>
> So I _think_ your argument is bogus, and your patch is bogus. The use of 
> "atomic_dec_return()" in a mutex is _not_ the same barrier as using it for 
> reference counting. Not at all. Memory barriers aren't just one thing: 
> they are semi-permeable things in two different directions and with two 
> different operations: there are several different kinds of them.
> 
> >  #define __mutex_fastpath_lock(count, fail_fn)				\
> >  do {									\
> > +	smp_mb__before_atomic_dec();					\
> >  	if (unlikely(atomic_dec_return(count) < 0))			\
> >  		fail_fn(count);						\
> >  } while (0)
> 
> So I think the barrier has to come _after_ the atomic decrement (or 
> exchange). 
> 
> Because as it is written now, any writes in the locked region could 
> percolate up to just before the atomic dec - ie _outside_ the region. 
> Which is against the whole point of a lock - it would allow another CPU to 
> see the write even before it sees that the lock was successful, as far as
> I can tell.
> 
> But memory ordering is subtle, so maybe I'm missing something..

We mere humans^W device driver people get more confused with barriers
every day, as CPUs get more subtle in their out-of-order-ness.

I think adding longer-named-but-self-explanatory aliases for memory and io
barrier functions can help.

mmiowb => barrier_memw_iow
.... => barrier_memw_memw (a store-store barrier to mem)
....

General template for the name may be something like 

	[smp]barrier_{mem,io,memio}{r,w,rw}_{mem,io,memio}{r,w,rw}

Are there even more subtle cases?
--
vda
