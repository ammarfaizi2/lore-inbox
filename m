Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132555AbRDUKdw>; Sat, 21 Apr 2001 06:33:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132558AbRDUKdm>; Sat, 21 Apr 2001 06:33:42 -0400
Received: from quechua.inka.de ([212.227.14.2]:6210 "EHLO mail.inka.de")
	by vger.kernel.org with ESMTP id <S132557AbRDUKdW>;
	Sat, 21 Apr 2001 06:33:22 -0400
To: linux-kernel@vger.kernel.org
Subject: Re: light weight user level semaphores
In-Reply-To: <E14qHRp-0007Yc-00@the-village.bc.nu> <Pine.LNX.4.31.0104190944090.4074-100000@penguin.transmeta.com> <E14qXEU-0005xo-00@g212.hadiko.de> <9bqgvi$63q$1@penguin.transmeta.com>
Organization: private Linux site, southern Germany
Date: Sat, 21 Apr 2001 12:13:06 +0200
From: Olaf Titz <olaf@bigred.inka.de>
Message-Id: <E14quO3-0004RM-00@g212.hadiko.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> This is guaranteed behaviour of UNIX. You get file handles in order, or
> you don't get them at all.

You get the _next free_ file handle in order. What if your program
assumes they are all contiguous, and it is called by some other
program which forgot about FD_CLOEXEC and has some higher fds still
open? (xdm did this for ten years with its listening socket, just to
name a well-known example. So every program which asssumes contiguous
fd allocations would fail if started from an xdm session.)

If your program makes assumptions on its environment which are not
guaranteed it's broken.

What _is_ guaranteed is that after consecutive allocations of fds like
  for (i=0; i<n; ++i)
    fd[i]=open(...);
the following property holds:
    fd[i] > fd[j] if (i > j and fd[i]!=-1 and fd[j]!=-1).
What is absolutely nowhere guaranteed is that
    fd[i+1] = fd[i]+1.
It is not possible to guarantee this since any fd may be already open
before main() starts.

Of course you can guarantee that the fds are available like this:
  for (i=getdtablesize(); i>=0; --i)
    close(i);
and not calling library functions which may open fds.

> 	pid = fork();
> 	if (!pid) {
> 		close(0);
> 		close(1);
> 		dup(pipe[0]);	/* input pipe */
> 		dup(pipe[1]);	/* output pipe */
> 		execve("child");
> 		exit(1);
> 	}
>
> The above is absolutely _standard_ behaviour. It's required to work.

The reason why it works is that (a) the target fds are 0 and 1, and
(b) you close them explicitly. For less trivial uses, there is always
dup2().

> And btw, it's _still_ required to work even if there happens to be a
> "malloc()" in between the close() and the dup() calls.

I wouldn't count on that. It's clearly not required to work if there's
a getpwnam() in between. (I already had my share of problems with
syslog() in exactly this situation.)

Do we need a list of library functions which may open fds, like the
infamous "list of functions which may move or purge memory" on the Mac
(which grew longer with every OS release and Inside Mac supplement
issue)? Do we need to know for each library routine how it is
implemented?

> Trust me. You're arguing for clearly broken behaviour. malloc() and
> friends MUST NOT open file descriptors. It _will_ break programs that
> rely on traditional and documented features.

Traditional and documented is, in my view, the description as of the
open(2) man page:

       When the
       call is successful, the file descriptor returned  will  be
       the lowest file descriptor not currently open for the pro­
       cess.

which of course is exactly how it is implemented in the kernel.

Olaf
