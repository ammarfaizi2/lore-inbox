Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S284386AbRLENfI>; Wed, 5 Dec 2001 08:35:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S284385AbRLENe6>; Wed, 5 Dec 2001 08:34:58 -0500
Received: from ezri.xs4all.nl ([194.109.253.9]:48599 "HELO ezri.xs4all.nl")
	by vger.kernel.org with SMTP id <S284386AbRLENeo>;
	Wed, 5 Dec 2001 08:34:44 -0500
Date: Wed, 5 Dec 2001 14:34:42 +0100 (CET)
From: Eric Lammerts <eric@lammerts.org>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
cc: Andrew Morton <akpm@zip.com.au>, Josh McKinney <forming@home.com>,
        <linux-kernel@vger.kernel.org>, Jeff Garzik <jgarzik@mandrakesoft.com>
Subject: Re: Fwd: binutils in debian unstable is broken.
In-Reply-To: <E16BXeV-0005Im-00@the-village.bc.nu>
Message-ID: <Pine.LNX.4.43.0112051424560.1157-100000@ally.lammerts.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Wed, 5 Dec 2001, Alan Cox wrote:

> > The problem appears to be that the linker is now actually doing what
> > we asked it to do, so the `remove_foo' entry in that table now points
> > at a function which isn't going to be linked into the kernel.  Oh dear.
>
> The ideal it seems would be for binutils to support passing a stub function
> to use in such cases. That would keep the kernel stuff working nicely and
> allow us to do panic("__exit code called"); if anyone actually did manage
> to call one.

We can get a panic() call (and remove the ugly #ifdef's) with
something like this:

in some .h file:

#ifdef DEVEXIT_LINKED
#define DEVEXIT_FUNC(a) (a)
#else
void panic_exit_code();
#define DEVEXIT_FUNC(a) ((typeof((a)) *)panic_exit_code)
#endif

in some .c file:

#ifndef DEVEXIT_LINKED
void panic_exit_code()
{
   panic("__exit code called");
}
#endif


change the drivers like this:

#ifdef DEVEXIT_LINKED
     remove:         firestream_remove_one,
#endif

to this:

     remove:         DEVEXIT_FUNC(firestream_remove_one),


Eric


