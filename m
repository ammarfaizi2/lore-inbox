Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262525AbSI0Q14>; Fri, 27 Sep 2002 12:27:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262526AbSI0Q14>; Fri, 27 Sep 2002 12:27:56 -0400
Received: from mx1.elte.hu ([157.181.1.137]:39861 "HELO mx1.elte.hu")
	by vger.kernel.org with SMTP id <S262525AbSI0Q1z>;
	Fri, 27 Sep 2002 12:27:55 -0400
Date: Fri, 27 Sep 2002 18:42:23 +0200 (CEST)
From: Ingo Molnar <mingo@elte.hu>
Reply-To: Ingo Molnar <mingo@elte.hu>
To: Linus Torvalds <torvalds@transmeta.com>
Cc: Andrew Morton <akpm@zip.com.au>, Rusty Russell <rusty@rustcorp.com.au>,
       <linux-kernel@vger.kernel.org>
Subject: Re: [patch] 'virtual => physical page mapping cache', vcache-2.5.38-B8
In-Reply-To: <Pine.LNX.4.44.0209270922340.2013-100000@home.transmeta.com>
Message-ID: <Pine.LNX.4.44.0209271836540.15550-100000@localhost.localdomain>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Fri, 27 Sep 2002, Linus Torvalds wrote:

> > I have fixed a new futex bug as well: pin_page() alone does not guarantee
> > that the mapping does not change magically, only taking the MM semaphore
> > in write-mode does.
> 
> And this makes no sense to me.
> 
> A read lock on the semaphore should give you all the same protection as
> a write lock does.
> 
> To protect against the swapper etc, you really need to get the mm
> spinlock, not the semaphore. And once you have the spinlock, you should
> be totally safe.  Please explain what you saw?

the futex code needs to 'get to the physical page', 'hash the futex queue'
and 'hash the vcache entry' atomically.

otherwise a physical page might magically change under us - eg. another
thread doing a fork(), which marks the futex's mapping COW, then the same
thread also hits the COW - all this after the get_user_page() call, but
before the 'hash futex and vcache' thing. I took the mm semaphore in
write-mode to exclude COWs [or parallel munmap()s].

The swapper is something i did not think about, but that makes things even
worse. So it appears that all 3 operations have to be done at once, with
the page_table_lock held? Ie. first a slow (and possibly blocking)  
get_user_pages() call, then we would take the page_table_lock, call a
(new) atomic version of get_user_pages() which just re-checks the virt =>
phys mapping without blocking or taking any spinlock, then if the page has
not changed meanwhile we hash the futex and the vcache. If the page has 
changed meanwhile then we re-try the slow get_user_pages() call.

am i missing something?

	Ingo

