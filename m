Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S272065AbTGYN0v (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 25 Jul 2003 09:26:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S272069AbTGYN0u
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 25 Jul 2003 09:26:50 -0400
Received: from fiberbit.xs4all.nl ([213.84.224.214]:39815 "EHLO
	fiberbit.xs4all.nl") by vger.kernel.org with ESMTP id S272065AbTGYN0s
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 25 Jul 2003 09:26:48 -0400
Date: Fri, 25 Jul 2003 15:41:55 +0200
From: Marco Roeland <marco.roeland@xs4all.nl>
To: Linux Kernel Development <linux-kernel@vger.kernel.org>
Cc: Eli Barzilay <eli@barzilay.org>
Subject: Re: Repost: Bug with select?
Message-ID: <20030725134155.GA19211@localhost>
References: <16112.10166.989608.288954@mojave.cs.cornell.edu> <16159.28266.868297.372200@mojave.cs.cornell.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
In-Reply-To: <16159.28266.868297.372200@mojave.cs.cornell.edu>
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thursday July 24th 2003 at 01:28 uur Eli Barzilay wrote:

> When I run the following program, and block the terminal's output
> (C-s), the `select' doesn't seem to have any effect, resulting in a
> 100% cpu usage (this is on a RH8, with 2.4.18).  I wouldn't be
> surprised if I'm doing something stupid, but it does seem to work fine
> on Solaris.
> 
> Is there anything wrong with this, or is this some bug?
> 
> ======================================================================
> #include <unistd.h>
> #include <fcntl.h>
> int main() {
>   int flags, fd, len; fd_set writefds;
>   fd = 1;
>   flags = fcntl(fd, F_GETFL, 0);
>   fcntl(fd, F_SETFL, flags | O_NONBLOCK);

You use non-blocking mode here.

>   while (1) {
>     FD_ZERO(&writefds);
>     FD_SET(fd, &writefds);
>     len = select(fd + 1, NULL, &writefds, NULL, NULL);

A select with no timeout, so it will immediately return.

>     if (!FD_ISSET(fd,&writefds)) exit(0);

This might be what Solaris does differently, by _not_ including '1' in
the returned descriptors? Linux will say (rightly) that a following call
will not block, which is something very different than 'will not fail'!

>     len = write(fd, "hi\n", 3);

You don't check the exit status here, but when you press Ctrl-C (stdout
blocked) it will indicate an error here (exit status -1) with errno set
to EAGAIN, meaning you should try again, which is the appropriate result
for a non-blocking descriptor or socket here. Anyway, the call "succeeds" and
we loop back into the while(1), indeed as you say creating a busy loop.
No surprises there I'd say.

>   }
>   fcntl(fd, F_SETFL, flags);
> }

You might start by checking for EAGAIN as result of the write, and then
reacting according to your needs (waiting a while or exiting the
program or whatever).
