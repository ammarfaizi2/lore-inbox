Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261813AbVAHKp5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261813AbVAHKp5 (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 8 Jan 2005 05:45:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261789AbVAHKok
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 8 Jan 2005 05:44:40 -0500
Received: from science.horizon.com ([192.35.100.1]:13120 "HELO
	science.horizon.com") by vger.kernel.org with SMTP id S261822AbVAHIZm
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 8 Jan 2005 03:25:42 -0500
Date: 8 Jan 2005 08:25:35 -0000
Message-ID: <20050108082535.24141.qmail@science.horizon.com>
From: linux@horizon.com
To: linux-kernel@vger.kernel.org, torvalds@osdl.org
Subject: Re: Make pipe data structure be a circular list of pages, rather
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>  - add a "tee(in, out1, out2)" system call that duplicates the pages 
>    (again, incrementing their reference count, not copying the data) from 
>    one pipe to two other pipes.

H'm... the version that seemed natural to me was an asymmetrical one-way
tee, such as "tee(in, out, len, flags)" might be better, where the next
<len> bytes are *both* readable on fd "in" *and* copied to fd "out".

You can make it a two-way tee with an additional "splice(in, out2, len)"
call, so you haven't lost expressiveness, and it makes three-way and
higher tees easier to construct.


But then I realized that I might be thinking about a completely different
implementation than you... I was thinking asynchronous, while perhaps
you were thinking synchronous.

A simple example of the difference:

int
main(void)
{
	fd *dest = open("/dev/null", O_WRONLY);
	FILE *src = popen("/usr/bin/yes", "r");
	splice(fileno(src), dest, SPLICE_INFINITY, 0);
	return 0;
}

Will this process exit without being killed?  I was imagining yes,
it would exit immediately, but perhaps "no" makes more sense.

Ding!  Oh, of course, it couldn't exit, or cleaning up after the following
mess would be far more difficult:

int
main(void)
{
	int fd[2];
	pipe(fd);
	write(fd[1], "Hello, world!\n", 14);
	splice(fd[0], fd[1], SPLICE_INFINITY, 0);
	return 0;
}

With the synchronous model, the two-output tee() call makes more sense, too.
Still, it would be nice to be able to produce n identical output streams
without needing n-1 processes to do it  Any ideas?  Perhaps

int
tee(int infd, int const *outfds, unsigned noutfds, loff_t size, unsigned flags)

As for the issue of coalescing:
> This is the main reason why I want to avoid coalescing if possible: if you
> never coalesce, then each "pipe_buffer" is complete in itself, and that
> simplifies locking enormously.
>
> (The other reason to potentially avoid coalescing is that I think it might
> be useful to allow the "sendmsg()/recvmsg()" interfaces that honour packet
> boundaries. The new pipe code _is_ internally "packetized" after all).

It is somewhat offensive that the minimum overhead for a 1-byte write
is a struct pipe_buffer plus a full page.

But yes, keeping a pipe_buffer simple is a BIG win.  So how about the
following coalescing strategy, which complicates the reader not at all:

- Each pipe writing fd holds a reference to a page and an offset within
  that page.
- When writing some data, see if the data will fit in the remaining
  portion of the page.
  - If it will not, then dump the page, allocate a fresh one, and set
    the offset to 0.
    - Possible optimization: If the page's refcount is 1 (nobody else
      still has a reference to the page, and we would free it if we
      dropped it), then just recycle it directly.
- Copy the written data (up to a maximum of 1 page) to the current write page.
- Bump the page's reference count (to account for the pipe_buffer pointer) and
  queue an appropriate pipe_buffer.
- Increment the offset by the amount of data written to the page.
- Decrement the amount of data remaining to be written and repeat if necessary.

This allocates one struct pipe_buffer (8 bytes) per write, but not a whole
page.  And it does so by exploiting the exact "we don't care what the rest
of the page is used for" semantics that make the abstraction useful.

The only waste is that, as written, every pipe writing fd keeps a page
allocated even if the pipe is empty.  Perhaps the vm could be taught to
reclaim those references if necessary?


It's also worth documenting atomicity guarantees and poll/select
semantics.  The above algorithm is careful to always queue the first
PAGE_SIZE bytes of any write atomically, which I believe is what is
historically expected.  It would be possible to have writes larger than
PIPE_BUF fill in the trailing end of any partial page as well.
