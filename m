Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265801AbRF2J0w>; Fri, 29 Jun 2001 05:26:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265803AbRF2J0m>; Fri, 29 Jun 2001 05:26:42 -0400
Received: from lsmls01.we.mediaone.net ([24.130.1.20]:63437 "EHLO
	lsmls01.we.mediaone.net") by vger.kernel.org with ESMTP
	id <S265801AbRF2J0Z>; Fri, 29 Jun 2001 05:26:25 -0400
Message-ID: <3B3C4A67.1D03A916@kegel.com>
Date: Fri, 29 Jun 2001 02:29:11 -0700
From: Dan Kegel <dank@kegel.com>
X-Mailer: Mozilla 4.76 [en] (X11; U; Linux 2.2.14-5.0 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Christopher Smith <x@xman.org>
CC: "Daniel R. Kegel" <dank@alumni.caltech.edu>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: A signal fairy tale
In-Reply-To: <5.1.0.14.0.20010629011855.00a98098@imap.xman.org>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Christopher Smith wrote:
> 
> At 07:57 PM 6/27/2001 -0700, Daniel R. Kegel wrote:
> >From: Christopher Smith <x@xman.org>
> > >I guess the main thing I'm thinking is this could require some significant
> > >changes to the way the kernel behaves. Still, it's worth taking a "try it
> > >and see approach". If anyone else thinks this is a good idea I may hack
> > >together a sample patch and give it a whirl.
> >
> >What's the biggest change you see?  From my (two-martini-lunch-tainted)
> >viewpoint, it's just another kind of signal masking, sorta...
> 
> Yeah, the more I think about it, the more I think this is just another
> branch in the signal delivery code. Not necessarily too huge a change. I'll
> hack on this over the weekend I think.

Cool, have fun!

Feature checklist for future reference:

If sigopen() has been called, and the file descriptor is still open,
sigaction(x, 0, &foo) should show foo != SIG_DFL for compatibility
with the traditional signal allocation scheme.

If sigopen() has been called, and the file descriptor is still open,
sending a signal to the thread (or if posix, the process) that called
sigopen() should cause the signal to stick until picked up by
read(), or until close() is called on the fd(), in which case it will
be delivered or picked up as normal.

sigaction(x, &foo, 0) should return EBUSY if fd=sigopen(x) has been
called but close(fd) has not yet been called.

Pseudocode:

  sigemptyset(&s);
  sigaddset(SIGUSR1, &s);
  fd=sigopen(&s);
  m=read(fd, buf, n*sizeof(siginfo_t)) 
  close(fd);

should probably be equivalent to

  sigemptyset(&s);
  sigaddset(SIGUSR1, &s);
  struct sigaction newaction, oldaction;
  newaction.sa_handler = dummy_handler;
  newaction.sa_flags = SA_SIGINFO;
  newaction.sa_mask = 0;
  sigaction(SIGUSR1, &newaction, &oldaction);
  for (i=0; i<n; i++)
     if (sigwaitinfo(&s, buf+i))
        break;
  m = n * sizeof(siginfo_t);
  sigaction(SIGUSR1, &oldaction, 0);

(apologies if any of the above is wrong)

But, um, Chris, could you check your library code to make sure you did
the sigaction stuff?  Could it be that you forgot that, and if you did
that properly, the main application would notice that you'd allocated
a signal, and not suck up your signals?

- Dan
