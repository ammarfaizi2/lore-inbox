Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129930AbQL2TLq>; Fri, 29 Dec 2000 14:11:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130061AbQL2TLg>; Fri, 29 Dec 2000 14:11:36 -0500
Received: from mail-03-real.cdsnet.net ([63.163.68.110]:42760 "HELO
	mail-03-real.cdsnet.net") by vger.kernel.org with SMTP
	id <S129930AbQL2TLW>; Fri, 29 Dec 2000 14:11:22 -0500
Message-ID: <3A4CDA80.680350E3@mvista.com>
Date: Fri, 29 Dec 2000 10:40:00 -0800
From: george anzinger <george@mvista.com>
Organization: Monta Vista Software
X-Mailer: Mozilla 4.72 [en] (X11; I; Linux 2.2.12-20b i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Linus Torvalds <torvalds@transmeta.com>
CC: Nigel Gamble <nigel@mvista.com>,
        "linux-kernel@vger.redhat.com" <linux-kernel@vger.kernel.org>
Subject: Preemption exit code
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

As you know we at MontaVista are working on a preemptable kernel that
takes advantage of the spin_lock() macros.  One of the "tricks" we use
is to bump a preemption counter on a spin_lock() and to decrement it on
spin_unlock().  The question, here posed, has to do with the test that
needs to be done on the decrement.  If the result is zero AND
need_resched is set we want to set the preemption count to one (to avoid
an interrupt race to schedule()) and call schedule().  This test and set
needs to be atomic (again to avoid the interrupt race to schedule()).  I
have been thinking of putting the preemption count and the need_resched
flag in shorts with a long union to combine them into one word.  Leaving
the endian problem aside, this would then allow me to use the cmpxchg
instruction to test and set the required bit.  Thus the spin_unlock()
would generate something like:

	preempt_count--;
	if( __cmpxchg(&current->resched_preempt,
			RESCHED_ONLY,
			RESCHED_PREEMPT,
			4) == RESCHED_ONLY) {
              do_call_schedule();

Where __cmpxchg() is from .../include/asm/system.h and
do_call_schedule() would decrement the preemption count on return
(actually it would return to the decrement above).  (Note that I am
using C here but the actual code would most likely be in asm.)

And then I found the following on the l-k list today:

>Subject:  Re: test13-pre5
>    Date:      Thu, 28 Dec 2000 15:15:01 -0800 (PST)
>    From:        Linus Torvalds <torvalds@transmeta.com>
>
   snip
>FreeBSD doesn't try to be portable any more, but Linux does, and there 
>are architectures where 8- and 16-bit accesses aren't atomic but have to be 
>done with read-modify-write >cycles.

>And even for fields like "age", where we don't care whether the age 
>itself is 100% accurate, we _do_ care that the fields close-by don't get 
>strange effects from updating "age". We used to have exactly this problem on
>alpha back in the 2.1.x timeframe.

>This is why a lot of fields are 32-bit, even though we wouldn't need 
>more than 8 or 16 >bits of them.
   snip

So, what is recommended here?

Other considerations:  

We would like to not have to find and modify all accesses to
need_resched.  Currently it is set to one in several places and tested
for non-zero in quite a few more places.  Combining the two flags in one
word would change established usage, but would solve the problem.

The above exit code is fast and tight, being a dec a cmpxchg and a
conditional jump (inline) (in asm we can use the Z-flag that the cmpxchg
sets to eliminate the compare in used above).  Note that the atomic
requirement is with respect to an interrupt, not another cpu, so the
lock modifier is not needed.  If another cpu sets need_resched, it will
also set and interrupt for us so we can safely ignore it here.

George
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
