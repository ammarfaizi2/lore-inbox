Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318552AbSHPQrb>; Fri, 16 Aug 2002 12:47:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318560AbSHPQrb>; Fri, 16 Aug 2002 12:47:31 -0400
Received: from neon-gw-l3.transmeta.com ([63.209.4.196]:48397 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S318552AbSHPQr3>; Fri, 16 Aug 2002 12:47:29 -0400
Date: Fri, 16 Aug 2002 09:54:16 -0700 (PDT)
From: Linus Torvalds <torvalds@transmeta.com>
To: Ingo Molnar <mingo@elte.hu>
cc: Jamie Lokier <lk@tantalophile.demon.co.uk>, <linux-kernel@vger.kernel.org>
Subject: Re: [patch] user-vm-unlock-2.5.31-A2
In-Reply-To: <Pine.LNX.4.44.0208161144040.3062-100000@localhost.localdomain>
Message-ID: <Pine.LNX.4.44.0208160936480.2243-100000@home.transmeta.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Fri, 16 Aug 2002, Ingo Molnar wrote:
> 
> okay, this is the misunderstanding then. If it fork()s and then uses some
> threading (which uses clone()) then in all cases i know about it must be
> linked against some threading library. Otherwise Y couldnt do a clone()  
> call and expect threading to work.

But of course it would. You can make your own async-io-like things by just 
using clone() directly, that's what all the original clone() users were.

>		 So right now 'threading' is a property that comes with the
> process image at exec()  time. But this must not be so from a conceptual
> angle, so i agree with you.

Even from a practical angle, it's not a "global" property. Sure, the code 
that does the clone() itself must have come in through the execve() (or 
through a loadable library later on), so in that sense you can think of it 
as a global thing - since the code must obviously be in the address space 
that the clone thing shares.

But a lot of the clone() decisions can be local, without anythign else 
really knowing about the fact that something started up a thread. The most 
trivial example is simply something like the appended, which just does a 
asynchronous read (yeah yeah, stupid example, but it's basically a 
threaded "cat").

Notice how none of this depends on any global state, so a library could do
the clone() without the caller even knowing that it does part of its work
in a local thread (it obviously wouldn't be doing anything this stupid,
but an async writer thread for sound output etc is not impossible to
imagine in a game library or something like that).

In fact, inside libraries there may well be reasons _not_ to use a global 
threading model like pthreads, because the library might want to take 
advantage of things like separate file descriptor address spaces etc that 
clone() can give it.

		Linus

---
#include <stdlib.h>
#include <unistd.h>
#include <signal.h>

#include <sched.h>

#define UNFINISHED (-1000)

struct iodesc {
	int fd, len, status;
	void *buffer;
};

int io_fn(void *_desc)
{
	struct iodesc *desc = _desc;

	desc->status = read(desc->fd, desc->buffer, desc->len);
	_exit(0);
}

int main()
{
	char buffer[4096];
	struct iodesc desc = { 0, sizeof(buffer), UNFINISHED, buffer };

	clone(io_fn, malloc(4096)+4096, CLONE_VM | CLONE_FILES | CLONE_FS | CLONE_DETACHED, &desc);
	while (desc.status == UNFINISHED)
		sched_yield();
	write(1, buffer, desc.status);
}

