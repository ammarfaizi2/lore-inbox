Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317740AbSFLQsG>; Wed, 12 Jun 2002 12:48:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317742AbSFLQsG>; Wed, 12 Jun 2002 12:48:06 -0400
Received: from mail.loewe-komp.de ([62.156.155.230]:17924 "EHLO
	mail.loewe-komp.de") by vger.kernel.org with ESMTP
	id <S317740AbSFLQsE>; Wed, 12 Jun 2002 12:48:04 -0400
Message-ID: <3D077BBB.6090708@loewe-komp.de>
Date: Wed, 12 Jun 2002 18:50:03 +0200
From: Peter =?ISO-8859-1?Q?W=E4chtler?= <pwaechtler@loewe-komp.de>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:0.9.8) Gecko/20020204
X-Accept-Language: de, en
MIME-Version: 1.0
To: Hubertus Franke <frankeh@watson.ibm.com>
CC: Rusty Russell <rusty@rustcorp.com.au>,
        Linus Torvalds <torvalds@transmeta.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Futex Asynchronous Interface
In-Reply-To: <E17I0ji-0004xO-00@wagner.rustcorp.com.au> <3D071153.9020607@loewe-komp.de> <20020612152042.27C463FE09@smtp.linux.ibm.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hubertus Franke wrote:
> On Wednesday 12 June 2002 05:16 am, Peter Wächtler wrote:
> 
>>Rusty Russell wrote:
>>
>>>In message <Pine.LNX.4.44.0206110951380.2712-100000@home.transmeta.com>
>>>you wri
>>>
>>>te:
>>>
>>>>Rusty,
>>>>this makes no sense:
>>>>
>>>>D: This changes the implementation so that the waker actually unpins
>>>>D: the page.  This is preparation for the async interface, where the
>>>>D: process which registered interest is not in the kernel.
>>>>
>>>>Whazzup? The closing of the fd will unpin the page, the waker has no
>>>>reason to do so. It is very much against the linux philosophy (and a
>>>>design disaster anyway) to have the waker muck with the data structures
>>>>of anything waiting.
>>>>
>>>Good catch: now the fd is a "one-shot" thing anyway, making close
>>>unpin the page makes more sense.  Tested patch below (against 2.5.21).
>>>
>>>FYI: I already violate this philosophy as I remove the waiter from the
>>>queue when I wake them: this allows them to tell that they were woken
>>>(waker does a list_del_init() on the waiting entry, so waiting knows
>>>if (list_empty()) I was woken).
>>>
>>>It would be more natural for the waiter to examine the futex value,
>>>and if it's still unchanged go back to sleep.  But this makes
>>>assumptions about what they're using the futex value for.  For
>>>example, we "PASS_THIS_DIRECTLY" value into the futex.  This requires
>>>that one (and ONLY one) process waiting actually wakes up.
>>>
>>>This is why coming up with a primitive which allowed us to build posix
>>>threads and fair queueing as well as "normal" unfair semantics took so
>>>damn long.
>>>
>>What are the plans on how to deal with a waiter when the lock holder
>>dies abnormally?
>>
>>What about sending a signal (SIGTRAP or SIGLOST), returning -1 and
>>setting errno to a reasonable value (EIO?)
>>
>>I couldn't find anything in susv3
>>
> 
> I thing this was decided some time ago that we won't deal with this situation.
> If we need to, the following needs to happen.
> 
> A) we need to follow a protocol to register the PID/TID id within the lock.
>     Example of this is described in 
> 	"Recoverable User-Level Mutual Exclusion" by Phiilip Bohannon
>             Proceedings of the 7th IEEE Symposium on Parallel and Distributed 
>             Systems, 1995.
> 
> B) this again requires that some entity (kernel ?) knows about all locks, 
> whether waited on in the kernel or not.
> 
> C) I believe we need a deamon that occasinally identifies dead locks.
> 
> Is it worth all this trouble? Or do we need two versions of the ?
> 
> The paper describes that for a Sun SS20/61 the safe spin locks obtained
> only 25% of the performance of spinlocks.
> 

Oops, I see it already myself. We lack a way for saying who is/was owning
the futex and so we can hardly tell who is waiting on this "unknown" lock.
:-(







