Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S313243AbSDDQac>; Thu, 4 Apr 2002 11:30:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S313245AbSDDQaW>; Thu, 4 Apr 2002 11:30:22 -0500
Received: from e32.co.us.ibm.com ([32.97.110.130]:59813 "EHLO
	e32.esmtp.ibm.com") by vger.kernel.org with ESMTP
	id <S313243AbSDDQaI>; Thu, 4 Apr 2002 11:30:08 -0500
Content-Type: text/plain; charset=US-ASCII
From: Hubertus Franke <frankeh@watson.ibm.com>
Reply-To: frankeh@watson.ibm.com
Organization: IBM Research
To: Rusty Russell <rusty@rustcorp.com.au>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Futex Generalization Patch
Date: Thu, 4 Apr 2002 11:28:33 -0500
X-Mailer: KMail [version 1.3.1]
Cc: Peter =?iso-8859-1?q?W=E4chtler?= <pwaechtler@loewe-komp.de>,
        Martin Wirth <martin.wirth@dlr.de>, drepper@redhat.com,
        matthew@hairy.beasts.org
In-Reply-To: <E16t22q-0000d2-00@wagner.rustcorp.com.au>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Message-Id: <20020404162751.B0A253FE06@smtp.linux.ibm.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thursday 04 April 2002 02:52 am, Rusty Russell wrote:
> "This time for sure"
>
> I have a new primitive (thanks Paul Mackerras): sleep if the word at
> this address is equal to this value.  It also has an optional timeout.
> On top of this, I have made pthreads locking primitives and futexes
> (marginally slower than the completely-in-kernel version, but not
> much).
>
> Userspace stuff (including nonpthreads.c code):
>   http://www.kernel.org/pub/linux/kernel/people/rusty/futex-2.0.tar.gz
>
> Please complain now, or I'll send to Linus as is,
> Rusty.
> PS.  Will be on plane in 24 hours, for 40 hours.  Incommunicado.


Rusty, here are a few comments !

In futex_wait  we have
	kmap(page)
	schedule_timeout()
	kunmap()

Are there potential for deadlocks, the mappings can be held for a long time 
and the KMAPs are limited.
Otherwise, kernel patch looks good. Will run it this weekend through 
ulockflex.

Other changes proposed for FUTEX 2.0

---------------------
A) in futex_down_timeout
	get ride of woken, don't see why you need that.
	optimize the while statement. Unless there are some hidden gcc issues.


static inline int futex_down_timeout(struct futex *futx, struct timespec *rel)
{
        int val, woken = 0;

        /* Returns new value */
        while ((val = __futex_down(&futx->count)) != 0) {
                switch (__futex_down_slow(futx, val, rel)) {
                case -1: 
		return -1; /* error */
                case 0: 
		futx->count = -1; /* slept */
		/* fall through */
                case 1:
                        return 0; /* passed */	
                }
        }
}

---------------------
Still missing something on the futex_trydown !!

 	futex_trydown   ::=  futex_down == 1 ? 0 : -1

So P1 holds the lock, P2 runs "while (1) { futex_trydown }" will decrement 
the counter yielding at some point "1" and thus granting the lock.
At one GHz on 32 way system this only requires a lock hold time of a few 
seconds. Doesn't sound like a good idea.
This brings back the discussion on compare and swap. This would be trivial to 
do with compare and swap.
Another solution would be to sync through the kernel at wraparound, so that
the count variable reflects the number of waiting processes.

That's for now....
-- 
-- Hubertus Franke  (frankeh@watson.ibm.com)
