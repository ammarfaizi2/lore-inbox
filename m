Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317722AbSFLPU6>; Wed, 12 Jun 2002 11:20:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317723AbSFLPU5>; Wed, 12 Jun 2002 11:20:57 -0400
Received: from e31.co.us.ibm.com ([32.97.110.129]:26069 "EHLO
	e31.co.us.ibm.com") by vger.kernel.org with ESMTP
	id <S317722AbSFLPU4>; Wed, 12 Jun 2002 11:20:56 -0400
Content-Type: text/plain;
  charset="iso-8859-1"
From: Hubertus Franke <frankeh@watson.ibm.com>
Reply-To: frankeh@watson.ibm.com
Organization: IBM Research
To: Peter =?iso-8859-1?q?W=E4chtler?= <pwaechtler@loewe-komp.de>,
        Rusty Russell <rusty@rustcorp.com.au>
Subject: Re: [PATCH] Futex Asynchronous Interface
Date: Wed, 12 Jun 2002 10:19:22 -0400
X-Mailer: KMail [version 1.3.1]
Cc: Linus Torvalds <torvalds@transmeta.com>, linux-kernel@vger.kernel.org
In-Reply-To: <E17I0ji-0004xO-00@wagner.rustcorp.com.au> <3D071153.9020607@loewe-komp.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Message-Id: <20020612152042.27C463FE09@smtp.linux.ibm.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wednesday 12 June 2002 05:16 am, Peter Wächtler wrote:
> Rusty Russell wrote:
> > In message <Pine.LNX.4.44.0206110951380.2712-100000@home.transmeta.com>
> > you wri
> >
> > te:
> >>Rusty,
> >> this makes no sense:
> >>
> >>D: This changes the implementation so that the waker actually unpins
> >>D: the page.  This is preparation for the async interface, where the
> >>D: process which registered interest is not in the kernel.
> >>
> >>Whazzup? The closing of the fd will unpin the page, the waker has no
> >>reason to do so. It is very much against the linux philosophy (and a
> >>design disaster anyway) to have the waker muck with the data structures
> >> of anything waiting.
> >
> > Good catch: now the fd is a "one-shot" thing anyway, making close
> > unpin the page makes more sense.  Tested patch below (against 2.5.21).
> >
> > FYI: I already violate this philosophy as I remove the waiter from the
> > queue when I wake them: this allows them to tell that they were woken
> > (waker does a list_del_init() on the waiting entry, so waiting knows
> > if (list_empty()) I was woken).
> >
> > It would be more natural for the waiter to examine the futex value,
> > and if it's still unchanged go back to sleep.  But this makes
> > assumptions about what they're using the futex value for.  For
> > example, we "PASS_THIS_DIRECTLY" value into the futex.  This requires
> > that one (and ONLY one) process waiting actually wakes up.
> >
> > This is why coming up with a primitive which allowed us to build posix
> > threads and fair queueing as well as "normal" unfair semantics took so
> > damn long.
>
> What are the plans on how to deal with a waiter when the lock holder
> dies abnormally?
>
> What about sending a signal (SIGTRAP or SIGLOST), returning -1 and
> setting errno to a reasonable value (EIO?)
>
> I couldn't find anything in susv3

I thing this was decided some time ago that we won't deal with this situation.
If we need to, the following needs to happen.

A) we need to follow a protocol to register the PID/TID id within the lock.
    Example of this is described in 
	"Recoverable User-Level Mutual Exclusion" by Phiilip Bohannon
            Proceedings of the 7th IEEE Symposium on Parallel and Distributed 
            Systems, 1995.

B) this again requires that some entity (kernel ?) knows about all locks, 
whether waited on in the kernel or not.

C) I believe we need a deamon that occasinally identifies dead locks.

Is it worth all this trouble? Or do we need two versions of the ?

The paper describes that for a Sun SS20/61 the safe spin locks obtained
only 25% of the performance of spinlocks.


-- 
-- Hubertus Franke  (frankeh@watson.ibm.com)
