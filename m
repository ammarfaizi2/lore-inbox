Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129918AbQKKGVM>; Sat, 11 Nov 2000 01:21:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129916AbQKKGVB>; Sat, 11 Nov 2000 01:21:01 -0500
Received: from neon-gw.transmeta.com ([209.10.217.66]:23306 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S129918AbQKKGUv>; Sat, 11 Nov 2000 01:20:51 -0500
To: linux-kernel@vger.kernel.org
From: torvalds@transmeta.com (Linus Torvalds)
Subject: Re: [BUG] /proc/<pid>/stat access stalls badly for swapping 
 process,2.4.0-test10
Date: 10 Nov 2000 22:20:38 -0800
Organization: Transmeta Corporation
Message-ID: <8uiofm$1tr$1@penguin.transmeta.com>
In-Reply-To: <Pine.LNX.4.10.10011091005390.1909-100000@penguin.transmeta.com> <3A0C6BD6.A8F73950@dm.ultramaster.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In article <3A0C6BD6.A8F73950@dm.ultramaster.com>,
David Mansfield  <lkml@dm.ultramaster.com> wrote:
>Linus Torvalds wrote:
>...
>> 
>> And it has everything to do with the fact that the way Linux semaphores
>> are implemented, a non-blocking process has a HUGE advantage over a
>> blocking one. Linux kernel semaphores are extreme unfair in that way.
>>
>...
>> The original running process comes back faulting again, finds the
>> semaphore still unlocked (the "ps" process is awake but has not gotten to
>> run yet), gets the semaphore, and falls asleep on the IO for the next
>> page.
>> 
>> The "ps" process actually gets to run now, but it's a bit late. The
>> semaphore is locked again.
>> 
>> Repeat until luck breaks the bad circle.
>> 
>
>But doesn't __down have a fast path coded in assembly?  In other words,
>it only hits your patched code if there is already contention, which
>there isn't in this case, and therefore the bug...?

The __down() case should be hit if there's a waiter, even if that waiter
has not yet been able to pick up the lock (the waiter _will_ have
decremented the count to negative in order to trigger the proper logic
at release time).

But as I mentioned, the pseudo-patch was certainly untested, so
somebody should probably walk through the cases to check that I didn't
miss something.

		Linus
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
