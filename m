Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265978AbRF1Oq6>; Thu, 28 Jun 2001 10:46:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265977AbRF1Oqs>; Thu, 28 Jun 2001 10:46:48 -0400
Received: from smtp1.cern.ch ([137.138.128.38]:8206 "EHLO smtp1.cern.ch")
	by vger.kernel.org with ESMTP id <S265972AbRF1Oqc>;
	Thu, 28 Jun 2001 10:46:32 -0400
Date: Thu, 28 Jun 2001 16:46:16 +0200
From: Jamie Lokier <lk@tantalophile.demon.co.uk>
To: "Daniel R. Kegel" <dank@alumni.caltech.edu>
Cc: x@xman.org, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: A signal fairy tale
Message-ID: <20010628164616.B3342@pcep-jamie.cern.ch>
In-Reply-To: <200106280304.UAA07087@alumnus.caltech.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <200106280304.UAA07087@alumnus.caltech.edu>; from dank@alumni.caltech.edu on Wed, Jun 27, 2001 at 08:04:41PM -0700
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Daniel R. Kegel wrote:
> Christopher Smith <x@xman.org> wrote:
> > Jamie Lokier <lk@tantalophile.demon.co.uk> wrote:
> > > Btw, this functionality is already available using sigaction().  Just
> > > search for a signal whose handler is SIG_DFL.  If you then block that
> > > signal before changing, checking the result, and unblocking the signal,
> > > you can avoid race conditions too.  (This is what my programs do).
> > 
> > It's more than whether a signal is blocked or not, unfortunately. Lots of 
> > applications will invoke sigwaitinfo() on whatever the current signal mask 
> > is, which means you can't rely on sigaction to solve your problems. :-(
> 
> As Chris points out, allocating a signal by the scheme Jamie
> describes is neccessary but not sufficient.  The problem Chris
> ran into is that he allocated a signal fair and square, only to find
> the application picking it up via sigwaitinfo()!

I check that the handler is not SIG_DFL, but perhaps my assumption that
any sigwaitinfo() user of a signal would set SA_SIGINFO and set the
handler to non-SIG_DFL is mistaken?

> Yes, this is a bug in the application -- but it's interesting that this
> bug only shows up when you try to integrate a new, well-behaved, library 
> into the app.  It's a fragile part of the Unix API.  sigopen() is
> a way for libraries to defend themselves against misuse of sigwaitinfo()
> by big applications over which you have no control.
> 
> So sigopen() is a technological fix to a social problem, I guess.

Requiring all libraries to use the sigopen() as you specified it just
isn't going to work, because you would have to make big changes to the
libraries.

Sometimes you actually do need SIGRTxxx signals to be delivered using
signal handlers!

Also as it was specified, you are reduced to reading one type of signal
at a time, or using select().  Often you wish to check several signals.
For example, in my programs sigwaitinfo() calls check for SIGIO, SIGURG
and SIGRTxxx at least.  Therefore siginfo(), if implemented, should take
a sigset_t, not a signal number.

The problem of when you actually want to receive an allocated signal
through a handler is, IMHO, best solved by permitting sigaction() and
signal delivery on signals that have been opened with sigopen().

However, it would be ok to require a flag SA_SIGOPEN to sigaction() to
prevent it from returning EBUSY.

:-)
-- Jamie
