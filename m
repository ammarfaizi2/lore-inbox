Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S310146AbSCKXMf>; Mon, 11 Mar 2002 18:12:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S310153AbSCKXMZ>; Mon, 11 Mar 2002 18:12:25 -0500
Received: from e1.ny.us.ibm.com ([32.97.182.101]:2249 "EHLO e1.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id <S310146AbSCKXMR>;
	Mon, 11 Mar 2002 18:12:17 -0500
Content-Type: text/plain; charset=US-ASCII
From: Hubertus Franke <frankeh@watson.ibm.com>
Reply-To: frankeh@watson.ibm.com
Organization: IBM Research
To: Linus Torvalds <torvalds@transmeta.com>,
        Rusty Russell <rusty@rustcorp.com.au>
Subject: Re: [PATCH] Futexes IV (Fast Lightweight Userspace Semaphores)
Date: Mon, 11 Mar 2002 18:12:43 -0500
X-Mailer: KMail [version 1.3.1]
Cc: <linux-kernel@vger.kernel.org>
In-Reply-To: <Pine.LNX.4.33.0203111441120.17864-100000@penguin.transmeta.com>
In-Reply-To: <Pine.LNX.4.33.0203111441120.17864-100000@penguin.transmeta.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Message-Id: <20020311231150.22AF03FE06@smtp.linux.ibm.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Monday 11 March 2002 05:45 pm, Linus Torvalds wrote:
> On Sat, 9 Mar 2002, Rusty Russell wrote:
> > > So I would suggest making the size (and thus alignment check) of locks
> > > at least 8 bytes (and preferably 16). That makes it slightly harder to
> > > put locks on the stack, but gcc does support stack alignment, even if
> > > the code sucks right now.
> >
> > Actually, I disagree.
> >
> > 1) We've left wiggle room in the second arg to sys_futex() to add rwsems
> >    later if required.
> > 2) Someone needs to implement them and prove they are superior to the
> >    pure userspace solution.
>
> You've convinced me.
>
> Considering how long people argued about dubious cycle measurements on the
> rwsem implementation, and where the crrent one actually uses a spinlock
> for exclusion on the fast path, the kernel lock really probably doesn't
> need to be expanded, and as there is provable overhead to the expansion,
> I'll just agree with you.
>
> Applied.
>
> 		Linus

Great, now, that this is settled, let's go back to the compare and swap 
issues.

As far as I can tell, we need compare and swap on a single queue 
implementation for rwsems. Again most architectures provide something like
that today. As for those which don't, why not provide either of the following 
approaches

(a) spinlock around the update code in the kernel. We could provide multiple
spinlocks to avoid potential collision.
(b) only provide futex in the kernel and user library approach using 2 queues 
as shown by Rusty. The lack of cmpxchg support would be exported by the  
futex_region call.

- 
-- Hubertus Franke  (frankeh@watson.ibm.com)
