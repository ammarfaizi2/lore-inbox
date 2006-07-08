Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964830AbWGHNlx@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964830AbWGHNlx (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 8 Jul 2006 09:41:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964831AbWGHNlx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 8 Jul 2006 09:41:53 -0400
Received: from relay03.pair.com ([209.68.5.17]:50184 "HELO relay03.pair.com")
	by vger.kernel.org with SMTP id S964830AbWGHNlw (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 8 Jul 2006 09:41:52 -0400
X-pair-Authenticated: 71.197.50.189
From: Chase Venters <chase.venters@clientec.com>
Organization: Clientec, Inc.
To: Krzysztof Halasa <khc@pm.waw.pl>
Subject: Re: [patch] spinlocks: remove 'volatile'
Date: Sat, 8 Jul 2006 08:41:14 -0500
User-Agent: KMail/1.9.3
Cc: "linux-os \\\\(Dick Johnson\\\\)" <linux-os@analogic.com>,
       Linus Torvalds <torvalds@osdl.org>, Ingo Molnar <mingo@elte.hu>,
       Andrew Morton <akpm@osdl.org>,
       Linux kernel <linux-kernel@vger.kernel.org>, arjan@infradead.org
References: <20060705114630.GA3134@elte.hu> <Pine.LNX.4.64.0607071635130.23767@turbotaz.ourhouse> <m3wtaoe7rk.fsf@defiant.localdomain>
In-Reply-To: <m3wtaoe7rk.fsf@defiant.localdomain>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200607080841.38235.chase.venters@clientec.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Saturday 08 July 2006 04:59, Krzysztof Halasa wrote:
> Chase Venters <chase.venters@clientec.com> writes:
> > Locks are supposed to be syncronization points, which is why they
> > ALREADY HAVE "memory" on the clobber list! "memory" IS NECESSARY. The
> > fact that "=m" is changing to "+m" in Linus's patches is because "=m"
> > is in fact insufficient, because it would let the compiler believe
> > we're just going to over-write the value. "volatile" merely hides that
> > bug -- once that bug is _fixed_ (by going to "+m"), "volatile" is no
> > longer useful.
>
> This is a completely different story. "volatile", barrier() and "+m"/"=m"
> aren't sync points. If the variable access isn't atomic you must use
> locking even with volatiles, barriers etc.

You're mincing my words. The reason "memory" is on the clobber list is because 
a lock is supposed to synchronize all memory accesses up to that point. It's 
a fence / a barrier, because if the compiler re-orders your loads/stores 
across the lock, you're in trouble. That's exactly what I was pointing out. 

> > If "volatile" is in use elsewhere (other than locks), it's still
> > probably wrong. In these cases, you can use a barrier, a volatile
> > cast, or an inline asm with a specific clobber.
>
> A volatile cast is just a volatile, moved from data declaration to
> all access points. It doesn't buy you anything.
> barrier() is basically "all-volatile". All of them operate on the same,
> compiler level.

A volatile cast lets you prevent the compiler from always treating the 
variable as volatile.

> If the "volatile" is used the wrong way (which is probably true for most
> cases), then volatile cast and barrier() will be wrong as well. You need
> locks or atomic access, meaningful on hardware level.

No. Linus already described what some example invalid uses of "volatile" are. 
One example is the very one this whole thread is about - using 'volatile' on 
the declaration of the spinlock counter. That usage is _wrong_, and barrier() 
would not be. (Of course, it doesn't directly apply here, because barrier() 
already existed, by necessity, due to the "memory" clobber. And the lock's 
not done in pure C.)

Volatile originally existed to tell the compiler a variable could change at 
will. Because of reordering, it's almost never sufficient with our modern 
compilers and CPUs. That's precisely where barrier() (and/or its hardware 
equivalents) help in places where 'volatile' is wrong. Your statement is 
additionally wrong because one use-case of memory barriers is to safely write 
lock-free code.

Thanks,
Chase
