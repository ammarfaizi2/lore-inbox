Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263257AbRF1ULz>; Thu, 28 Jun 2001 16:11:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264214AbRF1ULq>; Thu, 28 Jun 2001 16:11:46 -0400
Received: from alumnus.caltech.edu ([131.215.50.236]:26504 "EHLO
	alumnus.caltech.edu") by vger.kernel.org with ESMTP
	id <S263257AbRF1UL2>; Thu, 28 Jun 2001 16:11:28 -0400
Date: Thu, 28 Jun 2001 13:11:04 -0700 (PDT)
From: "Daniel R. Kegel" <dank@alumni.caltech.edu>
Message-Id: <200106282011.NAA21508@alumnus.caltech.edu>
To: lk@tantalophile.demon.co.uk
Cc: linux-kernel@vger.kernel.org, x@xman.org
Subject: Re: A signal fairy tale
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jamie wrote:
> Daniel R. Kegel wrote:
> > Christopher Smith <x@xman.org> wrote:
> > > Jamie Lokier <lk@tantalophile.demon.co.uk> wrote:
> > > > Btw, this functionality is already available using sigaction().  Just
> > > > search for a signal whose handler is SIG_DFL.  If you then block that
> > > > signal before changing, checking the result, and unblocking the signal,
> > > > you can avoid race conditions too.  (This is what my programs do).
> > > 
> > > It's more than whether a signal is blocked or not, unfortunately. Lots of 
> > > applications will invoke sigwaitinfo() on whatever the current signal mask 
> > > is, which means you can't rely on sigaction to solve your problems. :-(
> > 
> > As Chris points out, allocating a signal by the scheme Jamie
> > describes is neccessary but not sufficient.  The problem Chris
> > ran into is that he allocated a signal fair and square, only to find
> > the application picking it up via sigwaitinfo()!
> 
> I check that the handler is not SIG_DFL, but perhaps my assumption that
> any sigwaitinfo() user of a signal would set SA_SIGINFO and set the
> handler to non-SIG_DFL is mistaken?
 
I think your assumption is correct.  The problem is that the
application in question (Sun's JDK 1.4 beta) does something like this:
	sigprocmask(0, NULL, &oldset);
	sigwaitinfo(&oldset, &info);
So even though Chris did set the handler for his signal to non-SIG_DFL,
the application didn't care, and sucked all his signal notifications
away from him.

> > Yes, this is a bug in the application -- but it's interesting that this
> > bug only shows up when you try to integrate a new, well-behaved, library 
> > into the app.  It's a fragile part of the Unix API.  sigopen() is
> > a way for libraries to defend themselves against misuse of sigwaitinfo()
> > by big applications over which you have no control.
> > 
> > So sigopen() is a technological fix to a social problem, I guess.
> 
> Requiring all libraries to use the sigopen() as you specified it just
> isn't going to work, because you would have to make big changes to the
> libraries.

I didn't mean to require any library to change at all.  This is
an optional thing; a library can use this technique if it wants to
insulate itself from badly behaved applications.

> Sometimes you actually do need SIGRTxxx signals to be delivered using
> signal handlers!

No objection there, I agree.
 
> Also as it was specified, you are reduced to reading one type of signal
> at a time, or using select().  Often you wish to check several signals.
> For example, in my programs sigwaitinfo() calls check for SIGIO, SIGURG
> and SIGRTxxx at least.  Therefore siginfo(), if implemented, should take
> a sigset_t, not a signal number.
 
I have no objection to sigopen() taking a sigset_t *.

> The problem of when you actually want to receive an allocated signal
> through a handler is, IMHO, best solved by permitting sigaction() and
> signal delivery on signals that have been opened with sigopen().

sigopen() essentially installs a special signal handler (say, SIG_OPEN).
If sigaction() can override that, it should probably close the file descriptor, too.

I can buy that, perhaps, even though it makes libraries using sigopen()
somewhat more vulnerable to poorly behaved applications.  I think the
present application doesn't misbehave badly enough that it would try to
install a signal handler over Chris's.
 
> However, it would be ok to require a flag SA_SIGOPEN to sigaction() to
> prevent it from returning EBUSY.

That'd be ok.

Another issue someone raised: 

> would read() on this fd require the kernel to copy every byte of the siginfo_t?  

IMHO no; read() would leave undefined any bytes that would not have been set by 
sigwaitinfo().  The kernel could set them to zero or leave them untouched,
as desired.

Another issue:

AFAIK, there's no 'read with a timeout' system call for file descriptors, so
if you needed the equivalent of sigtimedwait(),
you might end up doing a select on the sigopen fd, which is an extra
system call.  (I wish Posix had invented sigopen() and readtimedwait() instead of 
sigtimedwait...)

- Dan
