Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S293460AbSBYTya>; Mon, 25 Feb 2002 14:54:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S293470AbSBYTyV>; Mon, 25 Feb 2002 14:54:21 -0500
Received: from e1.ny.us.ibm.com ([32.97.182.101]:3507 "EHLO e1.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id <S293460AbSBYTyN>;
	Mon, 25 Feb 2002 14:54:13 -0500
Date: Mon, 25 Feb 2002 14:51:30 -0500
From: Hubertus Franke <frankeh@watson.ibm.com>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: Linus Torvalds <torvalds@transmeta.com>,
        Rusty Russell <rusty@rustcorp.com.au>, mingo@elte.hu,
        Matthew Kirkwood <matthew@hairy.beasts.org>,
        Benjamin LaHaise <bcrl@redhat.com>, David Axmark <david@mysql.com>,
        William Lee Irwin III <wli@holomorphy.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Lightweight userspace semaphores...
Message-ID: <20020225145130.B1537@elinux01.watson.ibm.com>
In-Reply-To: <Pine.LNX.4.33.0202250942110.8978-100000@penguin.transmeta.com> <E16fPWS-0005hU-00@the-village.bc.nu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <E16fPWS-0005hU-00@the-village.bc.nu>; from alan@lxorguk.ukuu.org.uk on Mon, Feb 25, 2002 at 06:06:48PM +0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Feb 25, 2002 at 06:06:48PM +0000, Alan Cox wrote:
> > The most common case for any fast semaphores are for _threaded_
> > applications. No shared memory, no nothing.

Well, but most threaded applications should actually take care of this
without having to ditch into the kernel.

> 
> Ok I see where you are coming from now -- that makes sense for a few cases.
> POSIX thread locks have to be able to work interprocess not just between
> threads though, so a full posix lock implementation couldn't be done without
> being able to put these things on shared pages (hence I was coming from
> the using shmfs as backing store angle).  Using a subset of shmfs also got
> me resource management which happens to be nice.

With respect to global POSIX locks:
I talked to Bill Abt of the NGPT team and we planned of introducing 
an asynchronous mechanism to the user level lock package that I submitted
some 2 weeks ago. The problem here is that in NGPT like packages
the underlying kernel thread can not be blocked on a wait call, because
it constitutes a virtual CPU on which multiple user level threads are 
run. So what we were thinking of is on a wait call to the kernel
a datastructure is put in place on which to wait rather than blocking
on the calling thread. On wakeup, the initial process will be signaled
that one of the locks is available again. The user level thread scheduler
can then pick up the lock (many mechanism possible) and continue
the user level thread waiting on it.
> 

> The other user of these kind of fast locks is databases. Oracle for example
> seems not to be a single mm threaded application.
> 
> If we are talking about being able to say "make this page semaphores" then I 
> agree - the namespace is a seperate problem and up to whoever allocated the
> backing store in the first place, and may well not involve a naming at all.

What I implemented is what Linus recommended, namely indicate whether
a memory region is capable of being utilized for user level locks.
We need this for cleanup, i.e., when a process exits or dies, and the 
vma area is closed/removed, we know when to call back the kernel subsystem
holding the kernel locks associated with user level locks and clean
up lingering objets.

This works quite nice. I did this in my implementation and it requires
basically 4 line changes in the kernel.
The flag MAP_SEMAPHORE is to be introduced for mmap and shmat.
One problem is that libc seems to mask out any flags that
is currently not exposed by the kernel.

-- Hubertus

> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
