Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S272489AbTGZOK3 (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 26 Jul 2003 10:10:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S272490AbTGZOK3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 26 Jul 2003 10:10:29 -0400
Received: from exchfe1.cs.cornell.edu ([128.84.97.27]:31696 "EHLO
	exchfe1.cs.cornell.edu") by vger.kernel.org with ESMTP
	id S272489AbTGZOK0 convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 26 Jul 2003 10:10:26 -0400
From: Eli Barzilay <eli@barzilay.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8BIT
Message-ID: <16162.36685.970735.562244@mojave.cs.cornell.edu>
Date: Sat, 26 Jul 2003 10:25:17 -0400
To: Marco Roeland <marco.roeland@xs4all.nl>,
       Ben Greear <greearb@candelatech.com>
Cc: Linux Kernel Development <linux-kernel@vger.kernel.org>
Subject: Re: Repost: Bug with select?
In-Reply-To: <20030725134155.GA19211@localhost>
References: <20030725134155.GA19211@localhost>
	<3F21C93D.6000005@candelatech.com>
	<20030726090523.GA25539@localhost>
	<16112.10166.989608.288954@mojave.cs.cornell.edu>
	<16159.28266.868297.372200@mojave.cs.cornell.edu>
X-Mailer: VM 7.15 under Emacs 21.1.1
X-OriginalArrivalTime: 26 Jul 2003 14:25:21.0634 (UTC) FILETIME=[BEF85C20:01C35381]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Jul 25, Marco Roeland wrote:
> >     len = select(fd + 1, NULL, &writefds, NULL, NULL);
> 
> A select with no timeout, so it will immediately return.

The man page says:

       timeout  is  an  upper bound on the amount of time elapsed
       before select returns. It may be zero, causing  select  to
       return immediately. (This is useful for polling.) If time­
       out is NULL (no timeout), select can block indefinitely.

But I did (obviously) try adding one just in case -- the problem does
not go away.


> >     if (!FD_ISSET(fd,&writefds)) exit(0);
> 
> This might be what Solaris does differently, by _not_ including '1'
> in the returned descriptors? Linux will say (rightly) that a
> following call will not block, which is something very different
> than 'will not fail'!

I just added that when trying to trace the problem and reading
somewhere that ISSET must be used...  It never had any effect -- never
exits and otherwise the program is still on a busy spin in Linux and
fine on Solaris.


> >     len = write(fd, "hi\n", 3);
> 
> You don't check the exit status here, but when you press Ctrl-C
> (stdout blocked) it will indicate an error here (exit status -1)
> with errno set to EAGAIN, meaning you should try again, which is the
> appropriate result for a non-blocking descriptor or socket
> here. Anyway, the call "succeeds" and we loop back into the
> while(1), indeed as you say creating a busy loop.  No surprises
> there I'd say.

Uh, that's just a stripped down example -- in the original the
returned value is checked and the write is retried if the result is
EINTR.  The problem is that AFAICT, select should wait until the fd is
writable, but then write fails with EAGAIN, only to have the next
select succeed as if there is no problems.


> >   }
> >   fcntl(fd, F_SETFL, flags);
> > }
> 
> You might start by checking for EAGAIN as result of the write, and
> then reacting according to your needs (waiting a while or exiting
> the program or whatever).

Yeah, when the problem occurs, write will result in an EAGAIN, but
the next select should block until writing is ok.

When I played with this now I saw another strange thing -- when there
is a timeout in place, the FD_ISSET *will* return 0 after some output
was done (probably when its waiting for output).  So I thought that it
might be a good place to put a sleep, but the problem is that 0 is not
returned when the output is stopped.

This is the program:
======================================================================
#include <unistd.h>
#include <fcntl.h>
#include <errno.h>
int main() {
  int flags, fd, len; fd_set writefds;
  struct timeval timeout; timeout.tv_sec = 1; timeout.tv_usec = 0;
  fd = 1;
  flags = fcntl(fd, F_GETFL, 0);
  fcntl(fd, F_SETFL, flags | O_NONBLOCK);
  while (1) {
    FD_ZERO(&writefds);
    FD_SET(fd, &writefds);
    len = select(fd + 1, NULL, &writefds, NULL, &timeout);
    if (len<0) exit(1);
    while (!FD_ISSET(fd,&writefds)) {
      sleep(1);
      FD_ZERO(&writefds);
      FD_SET(fd, &writefds);
      select(fd + 1, NULL, &writefds, NULL, &timeout);
      if (len<0) exit(1);
    }
    do {
      len = write(fd, "hi\n", 3);
    } while ((len == -1) && (errno == EINTR));
    if (len<0 && errno==EINTR) exit(2);
    /* if (len<0 && errno==EAGAIN) exit(3); */
  }
  fcntl(fd, F_SETFL, flags);
}
======================================================================


On Jul 25, Ben Greear wrote:
> I thought select is supposed to tell you when you can read/write at
> least something without failing.  Otherwise it would be worthless
> when doing non-blocking IO because you can both read and write w/out
> blocking at all times.

That was the point I was trying to make.


On Jul 26, Marco Roeland wrote:
> My 'analysis' was indeed based on experience with sockets, where you
> don't get the busy spin. It's indeed a bit baffling why select keeps
> insisting that fd 1 is writable. A quick test on kernel versions
> 2.2.12-20, 2.4.20 and 2.6.0-test1 all give the same results, so I
> suppose select itself is doing it's expected duty, and that in that
> case the special underlying mechanics of stdout require special
> mechanics to find out if it's blocked?! Beats me, but that's pretty
> easy... ;-)

This doesn't solve the problem, and as evidence, the code will look
ugly with special cases for terminal output.

-- 
          ((lambda (x) (x x)) (lambda (x) (x x)))          Eli Barzilay:
                  http://www.barzilay.org/                 Maze is Life!
