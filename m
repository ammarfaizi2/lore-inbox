Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129090AbQKFRAX>; Mon, 6 Nov 2000 12:00:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129377AbQKFRAE>; Mon, 6 Nov 2000 12:00:04 -0500
Received: from TSX-PRIME.MIT.EDU ([18.86.0.76]:61583 "HELO tsx-prime.MIT.EDU")
	by vger.kernel.org with SMTP id <S129090AbQKFQ7p>;
	Mon, 6 Nov 2000 11:59:45 -0500
Date: Mon, 6 Nov 2000 11:55:05 -0500
Message-Id: <200011061655.LAA21681@tsx-prime.MIT.EDU>
From: "Theodore Y. Ts'o" <tytso@MIT.EDU>
To: George Talbot <george@brain.moberg.com>
CC: Marc Lehmann <pcg@goof.com>, linux-kernel@vger.kernel.org
In-Reply-To: George Talbot's message of Mon, 6 Nov 2000 09:13:25 -0500 (EST),
	<Pine.LNX.4.21.0011060906280.4984-100000@brain.moberg.com>
Subject: Re: Can EINTR be handled the way BSD handles it? -- a plea from a
 user-land  programmer...
Phone: (781) 391-3464
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

   Date: 	Mon, 6 Nov 2000 09:13:25 -0500 (EST)
   From: George Talbot <george@brain.moberg.com>

   I respectfully disagree that programs which don't surround some of the
   most common system calls with

	   do
	   {
		   rv = __some_system_call__(...);
	   } while (rv == -1 && errno == EINTR);

   are broken.  Especially if those programs don't use signals.  The problem
   that I'm raising is that the default behavior of returning EINTR from
   system calls is, in my opinion, an application reliabilty problem.  The
   specific problem I'm having is that glibc uses signals to implement
   multiple threads, and because of the EINTR behavior, expose multithreaded
   programs to this behavior that weren't necessarily written to use
   signals.

Arguably though the bug is in glibc, in that if it's using signals
behinds the scenes, it should have passed SA_RESTART to sigaction.

However, from a portability point of view, you should *always* surround
certain system calls with while loops, since even if your program
doesn't use signals, if you run that program on a System-V derived Unix
system, and someone types ^Z at the wrong moment, you can also get an
EINTR.   Similarly, you should always check the return value from write
and make sure all of what you asked to be written, was actually
written.

What I normally do is have a full_write routine which looks something
like this:

static errcode_t full_write(int fd, void *buf, int count)
{
	char	*cp = buf;
	int	left = count, c;

	while (left) {
		c = write(fd, cp, left);
		if (c < 0) {
			if (errno == EINTR || errno == EAGAIN)
				continue;
			return errno;
		}
		left -= c;
		cp += c;
	}
	return 0;
}

It's like checking the return value from malloc().  Not everyone does
it, but even if it's not needed 99% of the time, it's a darned good idea
to do that.

					- Ted
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
