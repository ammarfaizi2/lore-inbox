Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S289165AbSAMMjE>; Sun, 13 Jan 2002 07:39:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S289169AbSAMMiy>; Sun, 13 Jan 2002 07:38:54 -0500
Received: from sphinx.mythic-beasts.com ([195.82.107.246]:12553 "EHLO
	sphinx.mythic-beasts.com") by vger.kernel.org with ESMTP
	id <S289165AbSAMMiu>; Sun, 13 Jan 2002 07:38:50 -0500
Date: Sun, 13 Jan 2002 12:38:43 +0000 (GMT)
From: Matthew Kirkwood <matthew@hairy.beasts.org>
X-X-Sender: <matthew@sphinx.mythic-beasts.com>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
cc: Manfred Spraul <manfred@colorfullife.com>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH][RFC] Lightweight user-level semaphores
In-Reply-To: <E16P55l-0008Aq-00@the-village.bc.nu>
Message-ID: <Pine.LNX.4.33.0201131216230.24442-100000@sphinx.mythic-beasts.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 11 Jan 2002, Alan Cox wrote:

> > Rusty's idea is nice (though I think it'd be better
> > with a filesystem than a device, so you can share
> > names rather than file descriptors) but the page per
> > lock seems like rather too much overhead.
>
> I don't think its a big problem. A page gets you 256 locks or whatever
> the number ends up as. For the case where you have many fine grained
> locks between a group of threads thats great. You just parcel them
> out. If its two processes just wanting a lock between them, well they
> get a page with room for 256 lock objects, but they only want one.
> That doesn't matter.  Its one page, if they need two or two hundred
> locks its stil one page.

Yep, that'd be fine.  However, you then lose the neatness
of "lock==file descriptor", and need something other than
read/write for down/up.

So I think that the original idea of storing an opaque
cookie which, it happens, we can lookup to a kernel address,
is the way forward.  Linus' design had:

	/*
	 * Verify that it might be a valid kernel pointer
	 * before we even try to dereference it
	 */
	if ((unsigned long) kfs & 7)
		goto bad_sem;
	if (kfs < TASK_SIZE)
		goto bad_sem;
	if (kfs > TASK_SIZE+640k && kfs < TASK_SIZE + 1M)
		goto bad_sem;
	if (kfs > high_mem)
		goto bad_sem;

which is a bit magic (and, no doubt, non-portable), but
doesn't look entirely unreasonable.

I guess the alternative is to store them in a hash table
or tree but I don't know what that would do to the
contended case.

Matthew.

