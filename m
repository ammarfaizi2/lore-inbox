Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S314095AbSDFJoj>; Sat, 6 Apr 2002 04:44:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S314097AbSDFJoi>; Sat, 6 Apr 2002 04:44:38 -0500
Received: from [213.105.179.75] ([213.105.179.75]:42120 "EHLO
	wagner.rustcorp.com.au") by vger.kernel.org with ESMTP
	id <S314095AbSDFJoh>; Sat, 6 Apr 2002 04:44:37 -0500
From: Rusty Russell <rusty@rustcorp.com.au>
To: frankeh@watson.ibm.com
Cc: linux-kernel@vger.kernel.org
Cc: Peter =?iso-8859-1?q?W=E4chtler?= <pwaechtler@loewe-komp.de>,
        Martin Wirth <martin.wirth@dlr.de>, drepper@redhat.com,
        matthew@hairy.beasts.org
Subject: Re: [PATCH] Futex Generalization Patch 
In-Reply-To: Your message of "Thu, 04 Apr 2002 11:28:33 EST."
             <20020404162751.B0A253FE06@smtp.linux.ibm.com> 
Date: Sat, 06 Apr 2002 19:48:11 +1000
Message-Id: <E16tmnr-0003BM-00@wagner.rustcorp.com.au>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In message <20020404162751.B0A253FE06@smtp.linux.ibm.com> you write:
> In futex_wait  we have
> 	kmap(page)
> 	schedule_timeout()
> 	kunmap()

Oops!  Good catch.,.. I've moved the kunmap to before the timeout...

> ---------------------
> A) in futex_down_timeout
> 	get ride of woken, don't see why you need that.
> 	optimize the while statement. Unless there are some hidden gcc issues.

We don't need to set to -1 if we never slept, that's why we have the
woken flag.

> static inline int futex_down_timeout(struct futex *futx, struct timespec *rel
)
> {
>         int val, woken = 0;
> 
>         /* Returns new value */
>         while ((val = __futex_down(&futx->count)) != 0) {
>                 switch (__futex_down_slow(futx, val, rel)) {
>                 case -1: 
> 		return -1; /* error */
>                 case 0: 
> 		futx->count = -1; /* slept */
> 		/* fall through */
>                 case 1:
>                         return 0; /* passed */	
>                 }
>         }
> }

case 0 does not return, it sleeps!  This is wrong...

> Still missing something on the futex_trydown !!
> 
>  	futex_trydown   ::=  futex_down == 1 ? 0 : -1
> 
> So P1 holds the lock, P2 runs "while (1) { futex_trydown }" will decrement 
> the counter yielding at some point "1" and thus granting the lock.
> At one GHz on 32 way system this only requires a lock hold time of a few 
> seconds. Doesn't sound like a good idea.

Look closer at __futex_down: it doesn't decrement if futx->count < 0.

> This brings back the discussion on compare and swap. This would be trivial to
> do with compare and swap.

Yes, this is what the PPC code does.

Cheers,
Rusty.
--
  Anyone who quotes me in their sig is an idiot. -- Rusty Russell.
