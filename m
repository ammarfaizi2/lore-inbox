Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S273757AbRIQXk0>; Mon, 17 Sep 2001 19:40:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S273759AbRIQXkR>; Mon, 17 Sep 2001 19:40:17 -0400
Received: from neon-gw-l3.transmeta.com ([63.209.4.196]:4370 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S273757AbRIQXkH>; Mon, 17 Sep 2001 19:40:07 -0400
To: linux-kernel@vger.kernel.org
From: torvalds@transmeta.com (Linus Torvalds)
Subject: Re: Deadlock on the mm->mmap_sem
Date: Mon, 17 Sep 2001 23:39:05 +0000 (UTC)
Organization: Transmeta Corporation
Message-ID: <9o61ip$ctm$1@penguin.transmeta.com>
In-Reply-To: <001701c13fc2$cda19a90$010411ac@local>
X-Trace: palladium.transmeta.com 1000770002 13165 127.0.0.1 (17 Sep 2001 23:40:02 GMT)
X-Complaints-To: news@transmeta.com
NNTP-Posting-Date: 17 Sep 2001 23:40:02 GMT
Cache-Post-Path: palladium.transmeta.com!unknown@penguin.transmeta.com
X-Cache: nntpcache 2.4.0b5 (see http://www.nntpcache.org/)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

[ David, Andrea - can you check this out? ]

In article <001701c13fc2$cda19a90$010411ac@local>,
Manfred Spraul <manfred@colorfullife.com> wrote:
>> What happens is that proc_pid_read_maps grabs the mmap_sem as a
>> reader, and *while it holds the lock*, does a copy_to_user.  This can
>> of course page-fault, and the handler will also grab the mmap_sem
>> (if it is the same task).
>
>Ok, that's a bug.
>You must not call copy_to_user with the mmap semaphore acquired - linux
>semaphores are not recursive.

No, that's not the bug.

The mmap semaphore is a read-write semaphore, and it _is_ permissible to
call "copy_to_user()" and friends while holding the read lock.

The bug appears to be in the implementation of the write semaphore -
down_write() doesn't undestand that blocked writes must not block new
readers, exactly because of this situation. 

The situation wrt read-write spinlocks is exactly the same, btw, except
there we have "readers can have interrupts enabled even if interrupts
also take read locks" instead of having user-level faults.

Why do we want to explicitly allow this behaviour wrt mmap_sem? Because
some things are inherently racy without it (ie threaded processes that
read or write the address space - coredumping, ptrace etc).

		Linus
