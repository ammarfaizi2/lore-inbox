Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266006AbRG1A1G>; Fri, 27 Jul 2001 20:27:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266058AbRG1A0z>; Fri, 27 Jul 2001 20:26:55 -0400
Received: from neon-gw.transmeta.com ([209.10.217.66]:37385 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S266006AbRG1A0e>; Fri, 27 Jul 2001 20:26:34 -0400
Date: Fri, 27 Jul 2001 14:00:14 -0700 (PDT)
From: Linus Torvalds <torvalds@transmeta.com>
To: Matthew Dharm <mdharm-kernel@one-eyed-alien.net>
cc: Pavel Machek <pavel@suse.cz>,
        Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Alexander Viro <viro@math.psu.edu>,
        "David S. Miller" <davem@redhat.com>,
        Andrea Arcangeli <andrea@suse.de>, Alan Cox <alan@redhat.com>,
        David Woodhouse <dwmw2@redhat.com>, <linux-scsi@vger.kernel.org>,
        Andrew Morton <andrewm@uow.edu.au>
Subject: Re: 2.4.7-pre9..
In-Reply-To: <20010727124736.B12304@one-eyed-alien.net>
Message-ID: <Pine.LNX.4.31.0107271355250.977-100000@p4.transmeta.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org
Original-Recipient: rfc822;linux-kernel-outgoing



On Fri, 27 Jul 2001, Matthew Dharm wrote:
>
> Hrm... just to be clear, then... this only is a problem with semaphores
> that are declared on the local stack?

Yes.

In theory you can have the same problem on any allocation that is free'd
after the semaphore has been used, but most (hopefully all) other forms of
allocations should be using proper reference counting etc, so that it is
impossible for a semaphore user to have the semaphore disappear from under
it.

> IIRC, usb-storage only uses semaphores that are allocated via kfree, so I
> think we're okay.  Tho, I think the new semantics are probably better, and
> will probably switch to them.  Later.

If you're using kmalloc/kfree, just make sure that the kfree never happens
early (ie the "down()" does not protect the kfree, but some other
reference count or lock does).

If you have

	CPU #1					CPU #2

	down(mem->semaphore);			up(mem->semaphore);
	kfree(mem);

you can still have the same bug.

But if you have

	CPU #1					CPU #2

	down(mem->semaphore)			up(mem->semaphore);
	put(mem);				put(mem);

where "put(mem)" does something like

	if (atomic_dec_and_test(&mem->refcount))
		kfree(mem);

then you're obvoiusly ok, because now the free'ing of the data structure
cannot happen until all users have handed off on it.

		Linus

