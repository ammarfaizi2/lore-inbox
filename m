Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S291944AbSBYBZ7>; Sun, 24 Feb 2002 20:25:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S291948AbSBYBZt>; Sun, 24 Feb 2002 20:25:49 -0500
Received: from neon-gw-l3.transmeta.com ([63.209.4.196]:62472 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S291944AbSBYBZd>; Sun, 24 Feb 2002 20:25:33 -0500
Date: Sun, 24 Feb 2002 17:23:59 -0800 (PST)
From: Linus Torvalds <torvalds@transmeta.com>
To: Rusty Russell <rusty@rustcorp.com.au>
cc: <mingo@elte.hu>, Matthew Kirkwood <matthew@hairy.beasts.org>,
        Benjamin LaHaise <bcrl@redhat.com>, David Axmark <david@mysql.com>,
        William Lee Irwin III <wli@holomorphy.com>,
        <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] Lightweight userspace semaphores... 
In-Reply-To: <E16f9f0-0006N2-00@wagner.rustcorp.com.au>
Message-ID: <Pine.LNX.4.33.0202241719330.1420-100000@home.transmeta.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Mon, 25 Feb 2002, Rusty Russell wrote:
>
> Bugger.  How about:
>
> 	sys_sem_area(void *pagestart, size_t len)
> 	sys_unsem_area(void *pagestart, size_t len)
>
> Is that sufficient?  Is sys_unsem_area required at all?

The above is sufficient, but I would personally actually prefer an
interface more like

	fd = sem_initialize();
	mmap(fd, ...)
	..
	munmap(..)

which gives you a handle for the semaphore.

Note that getting a file descriptor is really quite useful - it means that
you can pass the file descriptor around through unix domain sockets, for
example, and allow sharing of the semaphore across unrelated processes
that way.

Also, the fd thus acts as an "anchor" for any in-kernel data structures
that the semaphore implementation may (or may not) want to use. Think of
it as your /dev/usem, except with a more explicit interface.

And make the initial mmap() only do a limited number of pages, so that
people don't start trying to allocate tons of memory this way.-

		Linus

