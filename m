Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261795AbVASRRI@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261795AbVASRRI (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 19 Jan 2005 12:17:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261793AbVASRRB
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 19 Jan 2005 12:17:01 -0500
Received: from fw.osdl.org ([65.172.181.6]:31673 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S261784AbVASROm (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 19 Jan 2005 12:14:42 -0500
Date: Wed, 19 Jan 2005 09:14:33 -0800 (PST)
From: Linus Torvalds <torvalds@osdl.org>
To: Larry McVoy <lm@bitmover.com>
cc: William Lee Irwin III <wli@holomorphy.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Make pipe data structure be a circular list of pages, rather
 than
In-Reply-To: <20050119162902.GA20656@work.bitmover.com>
Message-ID: <Pine.LNX.4.58.0501190843220.8178@ppc970.osdl.org>
References: <200501070313.j073DCaQ009641@hera.kernel.org>
 <20050107034145.GI9636@holomorphy.com> <Pine.LNX.4.58.0501062222500.2272@ppc970.osdl.org>
 <Pine.LNX.4.58.0501062236060.2272@ppc970.osdl.org> <20050119162902.GA20656@work.bitmover.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Wed, 19 Jan 2005, Larry McVoy wrote:
>
> I think you are going to regret making splice() a system call, it shouldn't
> be, you'll find cases where it won't work.  Make it a library call built
> out of pull() and push()

Actually, if you look at my current (ugly) test-patch, the one part of it
that isn't ugly is the actual "sys_splice()" + "do_splice()" part, and the
only thing they actually do is (a) do all the required "fd -> struct file"  
setup (including locking, testing readability vs writability etc), and
then (b) they check which side is a pipe, and split it up into "pull" vs 
"push" at that point.

Of course, the "pull" is actually called "do_splice_from()", and the 
"push" is called "do_splice_to()", but I can rename them if you want to ;)

So yes, internally it is actually a push/pull thing, with separate actions 
for both. I absolutely agree that you cannot have a "splice()" action, you 
need to have a _direction_. But that's actually exactly what the pipe 
gives you: since all data has to originate or end in a pipe, the direction 
is implicit by the file descriptors involved.

(The exception is a pipe->pipe transfer, but then the direction doesn't
matter, and you can choose whichever just ends up being easier. We happen
to consider it a "do_splice_from()" from the source pipe right now, but
that's purely a matter of "which way do you test first").

Could we show it as two system calls? Sure. It wouldn't give you anything,
though, since you need to do all the tests anyway - including the test
for whether the source or destination is a pipe which currently is the 
thing that splits up the "splice()" into two cases. So it's not even like 
you could optimize out the direction test - it would just become an 
error case test instead.

And having just one system call means that the user doesn't need to care
(other than making sure that one end _is_ a pipe), and also allows us to
share all the code that _is_ shared (namely the "struct file *" setups and
testing - not a whole lot, but it's cleaner that way).

I think you are perhaps confused about the fact that what makes this all
possible in the first place really is the _pipe_. You probably think of
"splice()" as going from one file descriptor to another. It's not. It goes
from one (generic) file descriptor into a _pipe_, or from one pipe into
another (generic) file descriptor. So the "push"/"pull" part really is 
there, but it's there in another form: if you want to copy from one file 
to another, you have to

	1) open a pipe - it's the splice equivalent of allocating a
	   temporary buffer.
   repeat:
	   2) "pull" from the fd into the pipe: splice(in, pipe[1], size)
	   3) "push" from the pipe into the fd: splice(pipe[0], out, size)

so it's all there. The above is 100% conceptually equivalent to

	 1) buf = malloc()
   repeat:
	   2) read(in, buf, size);
	   3) write(out, buf, size);

See? I think you'll find that the "push" and "pull" you look for really is 
there.

The advantage here is that if either the input or the output _already_ is
a pipe, you can optimize it to just do a loop of a single splice(), with
no new temporary buffer needed. So while the above three steps are the 
generic case, depending on how you do things the _common_ case may be just 
a simple

    repeat:
	  1) splice(in, out, maxsize);

which is why you do not want to _force_ the split. The determination of 
how to do this efficiently at run-time is also very easy:

	int copy_fd(int in, int out)
	{
		char *buf;
		int fds[2];

		for (;;) {
			int count = splice(in, out, ~0UL);
			if (count < 0) {
				if (errno == EAGAIN)
					continue;
				/* Old kernel without "splice()"? */
				if (errno == ENOSYS)
					goto read_write_case;
				/* No pipe involved? */
				if (errno == EINVAL)
					goto pipe_buffer_case;
				/* We found a pipe, but the other end cannot accept this splice */
				if (errno == ECANNOTSPLICE)
					goto read_write_case;
				return -1;
			}
			if (!count)
				return 0;
		}

	pipe_buffer_case:
		if (pipe(fds) < 0)
			goto read_write_case;
		for (;;) {
			int count = splice(in, fds[1], ~0UL);
			if (count < 0)
				if (errno == EAGAIN)
					continue;
				return -1;
			}
			if (!count)
				return 0;
			do {
				int n = splice(fds[0], out, count);
				if (n < 0) {
					if (errno == EAGAIN)
						continue;
					return -1;
				}
				if (!n) {
					errno = ENOSPC;
					return -1;
				}
			} while ((count -= n) > 0)
		}

	read_write_case:
		buf = malloc(BUFSIZE);
		for (;;) {
			int count = read(in, buf, BUFSIZE);
			...

See? THAT is the kind of library routine you want to have (btw, there's no 
"ECANNOTSPLICE" error code right now, my current example code incorrectly 
returns EINVAL for both the "no pipe" case and the "found pipe but not 
splicable" case).

			Linus
