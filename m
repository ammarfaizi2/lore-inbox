Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131976AbRDTXde>; Fri, 20 Apr 2001 19:33:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132027AbRDTXdY>; Fri, 20 Apr 2001 19:33:24 -0400
Received: from neon-gw.transmeta.com ([209.10.217.66]:38923 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S131976AbRDTXdR>; Fri, 20 Apr 2001 19:33:17 -0400
To: linux-kernel@vger.kernel.org
From: torvalds@transmeta.com (Linus Torvalds)
Subject: Re: light weight user level semaphores
Date: 20 Apr 2001 16:33:06 -0700
Organization: A poorly-installed InterNetNews site
Message-ID: <9bqgvi$63q$1@penguin.transmeta.com>
In-Reply-To: <E14qHRp-0007Yc-00@the-village.bc.nu> <Pine.LNX.4.31.0104190944090.4074-100000@penguin.transmeta.com> <E14qXEU-0005xo-00@g212.hadiko.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In article <E14qXEU-0005xo-00@g212.hadiko.de>,
Olaf Titz  <olaf@bigred.inka.de> wrote:
>> Ehh.. I will bet you $10 USD that if libc allocates the next file
>> descriptor on the first "malloc()" in user space (in order to use the
>> semaphores for mm protection), programs _will_ break.
>
>Of course, but this is a result from sloppy coding.

ABSOLUTELY NOT!

This is guaranteed behaviour of UNIX. You get file handles in order, or
you don't get them at all.

Sure, some library functions are allowed to use up file handles. But
most sure as hell are NOT.

>					 In general, open()
>can just return anything and about the only case where you can even
>think of ignoring its result is this:
> close(0); close(1); close(2);
> open("/dev/null", O_RDWR); dup(0); dup(0);

Which is quite common to do.

Imagine a server that starts up another process, which does exactly
something like the above: the _usual_ execve() case looks something like

	pid = fork();
	if (!pid) {
		close(0);
		close(1);
		dup(pipe[0]);	/* input pipe */
		dup(pipe[1]);	/* output pipe */
		execve("child");
		exit(1);
	}

The above is absolutely _standard_ behaviour. It's required to work.

And btw, it's _still_ required to work even if there happens to be a
"malloc()" in between the close() and the dup() calls.

Trust me. You're arguing for clearly broken behaviour. malloc() and
friends MUST NOT open file descriptors. It _will_ break programs that
rely on traditional and documented features.

		Linus

