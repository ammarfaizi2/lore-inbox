Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317737AbSFLQ1i>; Wed, 12 Jun 2002 12:27:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317738AbSFLQ1h>; Wed, 12 Jun 2002 12:27:37 -0400
Received: from mail.loewe-komp.de ([62.156.155.230]:11524 "EHLO
	mail.loewe-komp.de") by vger.kernel.org with ESMTP
	id <S317737AbSFLQ1f>; Wed, 12 Jun 2002 12:27:35 -0400
Message-ID: <3D0776EE.4040701@loewe-komp.de>
Date: Wed, 12 Jun 2002 18:29:34 +0200
From: Peter =?ISO-8859-1?Q?W=E4chtler?= <pwaechtler@loewe-komp.de>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:0.9.8) Gecko/20020204
X-Accept-Language: de, en
MIME-Version: 1.0
To: Linus Torvalds <torvalds@transmeta.com>
CC: Rusty Russell <rusty@rustcorp.com.au>, linux-kernel@vger.kernel.org,
        frankeh@watson.ibm.com
Subject: Re: [PATCH] Futex Asynchronous Interface
In-Reply-To: <Pine.LNX.4.33.0206120833470.23029-100000@penguin.transmeta.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Linus Torvalds wrote:
> On Wed, 12 Jun 2002, Peter Wächtler wrote:
> 
>>What are the plans on how to deal with a waiter when the lock holder
>>dies abnormally?
>>
> 
> That's why they are called FUTEX'es - they're fast. They're NOT SysV 
> semaphores, and they are done 99% in user space. The kernel doesn't even 
> _know_ about them until contention happens, and even then only in a rather 
> dim "somebody wants me to do this, but I don't know _what_ he is doing" 
> way.
> 
> 
>>What about sending a signal (SIGTRAP or SIGLOST), returning -1 and
>>setting errno to a reasonable value (EIO?)
>>
> 
> There's just nothing the kernel _can_ do. The common case (by far) is that
> the kernel has never seen the futex at all, since many uses are likely to
> not have much contention. So when a user program dies holding such a 
> uncontended lock, the kernel simply _cannot_ do anything.
> 
For the uncontended case: their is no blocked process...

Huh, I think you misunderstood me.

One (or more) process is blocked in a waitqueue in the kernel - waiting
for a futex to be released.

The lock holder crashes - say with SIGSEGV. Now if we don't release the
waiters, they wait until reboot or user/admin kills them with a signal -
assuming they are interruptible sleeping.

I know that the kernel can't do anything about the aborted critical section.
But the waiters should be "freed" - and now we can discuss if we kill them
or report an error and let them deal with that.

So we surely have a process_exit_cleanup function (where FDs are closed etc).
There we would have to add a check if that process is holding a futex, the
waitqueue for that and "release" all waiters.

Can't be done? I don't think that this would add a performance hit
since it's only done on exit (and especially "abnormal" exit).

There is no way to check if a process holds a futex and which processes
are blocked on the associated waitqueue?

The waitqueue is built upon linking a struct futex_q list on the blocked
processes stack.

The entries to these lists are in a static array
struct list_head futex_queues[1<<FUTEX_HASHBITS].
At least we could search them on "exit due to fatal signal" when exiting.
Perhaps spending a bit in task_struct WHEN they got a lock - so we don't
have to search on every process exit.

Yes, searching the hash array lists could last a long time, but:

Is process exit time that important?

> (The kernel also cannot do anything even for the contended locks, because 
> the whole interface is designed for speed and with the knowledge that the 
> kernel won't be able to fix stuff up, so the kernel doesn't actually have 
> enough information even in the contention case. See the "dim notion" 
> above).
> 
> Besides, if you have a threads package that uses some lock for mutual 
> exclusion, and a thread dies while holding the lock, there's nothign sane 
> anybody can do about it anyway. The data structures are likely to be in an 
> invalid state, and just making every other thread block on the lock until 
> you can attach a debugger is probably the closest to a _right_ thing you 
> can do.
> 
> In short: it's not a bug, it's a design feature, and it's very much 
> designed for efficiency.
> 

And leave dangling processes (lost futex zombies)?


