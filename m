Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129055AbQKFOGf>; Mon, 6 Nov 2000 09:06:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129247AbQKFOG0>; Mon, 6 Nov 2000 09:06:26 -0500
Received: from neuron.moberg.com ([209.152.208.195]:4870 "EHLO
	neuron.moberg.com") by vger.kernel.org with ESMTP
	id <S129055AbQKFOGL>; Mon, 6 Nov 2000 09:06:11 -0500
Date: Mon, 6 Nov 2000 09:05:52 -0500 (EST)
From: George Talbot <george@brain.moberg.com>
To: "Theodore Y. Ts'o" <tytso@MIT.EDU>
cc: Tim Hockin <thockin@isunix.it.ilstu.edu>, linux-kernel@vger.kernel.org
Subject: Re: Can EINTR be handled the way BSD handles it? -- a plea from a 
 user-land
In-Reply-To: <200011040423.XAA21508@tsx-prime.MIT.EDU>
Message-ID: <Pine.LNX.4.21.0011060824000.4984-100000@brain.moberg.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 3 Nov 2000, Theodore Y. Ts'o wrote:

>    Date: 	Fri, 03 Nov 2000 14:44:17 -0500
>    From: george@moberg.com
> 
>    My problem is that pthread_create (glibc 2.1.3, kernel 2.2.17 i686) is
>    failing because, deep inside glibc somewhere, nanosleep() is returning
>    EINTR.
> 
> Sounds like it might be a bug in pthread_create.... although that's not
> clear.  You haven't given enough information to be sure.

I'm still trying to figure this one out.  The problem with giving you a 
concrete example right now is the complexity of my test scenario.

So, I'm working on adding a whole bunch of debugging messages to my copy
of glibc so I can figure out where it's failing, as the crappy POSIX
standard (once again) specifies a single return code that maps to several
failure modes.

For all I know this is my bug, but I still want to raise the practicality
of returning EINTR as an issue...

>    My code is not using signals.  The threading library is, and there is
>    obviously some subtle bug going on here.  Ever wonder why when browsing
>    with Netscape and you click on a link and it says "Interrupted system
>    call."?  This is it.  I'm arguing that the default behaviour should be
>    SA_RESTART, and if some programmer is so studly that they actually know
>    what the hell they are doing by disabling SA_RESTART, then they can do
>    it explicitly.
> 
> Ok first of all, the behaviour of sigaction is specified by the POSIX
> standards.  To quote from the POSIX Rationale for section 3.3 (B.3.3):
> 
> 	"Unlike all previous historical implementations, 4.2 BSD
> 	restarts some interrupted system calls rather than returning on
> 	error with errno set to [EINTR] after the signal-catching
> 	function returns.  THIS CHANGE CAUSED PROBLEMS FOR SOME
> 	APPLICATION CODE.  (Emphasis mine.)  4.3 BSD and other systems
> 	derived from 4.2BSD allow the application to choose whether
> 	system calls are to be restarted.   POSIX.1 (in 3.3.4) does not
> 	require restart of functions because it was not clear that the
> 	semantics of system-call restart in any historical
> 	implementation to be of value in a standard.  Implementors are
> 	free to add such mechanisms as extensions."
> 
> In Linux, we (well, actually I) added this extension as the SA_RESTART
> flag.  However, other parts of POSIX make it very clear that in absence
> of any extension such as SA_RESTART, "If the signal catching function
> executes a return, the behaviour of the interrupted function shall be as
> described individually for that function" (POSIX.1, 3.3.1.4).  And for
> most functions, it is specified that they return EINTR if they are
> interrupted by a signal.
> 
> So the answer is that if you want this behaviour, you have to call
> sigaction with the appropriate flags --- namely SA_RESTART.
> 
> 					- Ted

I understand what you're saying here, and I do appreciate the explanation,
as there isn't much documentation out there for this stuff,
unless one actually has a copy of the POSIX specs.  However I have two
problems, one philosophical, and one practical.

Practical problem:

	_My_code_ is not using signals whatsoever, so I don't know _which_
	signals to call sigaction() on, nor am I quite sure that using
	sigaction() will have any effect, as the underlying library
	(glibc in this case) calls sigaction() itself on
	those same signals.  Considering the complexity of any large
	program, it can be nearly impossible to tell _which_ signals are
	being used in underlying libraries.  This is the main reason I am
	not in favor of the default POSIX behavior.

	The bottom line is that, on Linux, glibc uses signals to make
	threads work, and because of this, code that worked in a
	single-threaded case can fail because of this EINTR behavior, when
	the programmer is not expecting a failure because the programmer
	isn't using signals in their program.

	A programmer usability issue, if you will, because even if you
	know about this issue, it's very hard to figure out whether you 
	got it exactly right.  This is because although some of the
	windows for discovering this are large (blocking on select()),
	some aren't.  (blocking on read, write, sendmsg, etc.)

Philosophical problem:

	"THIS CHANGE CAUSED PROBLEMS FOR SOME APPLICATION CODE."

	_Which_ applications?

	_Why_ did they have a problem?  Was this due to a bug or were they
	designed to do stuff this way?

	How hard would it be to change these programs to use
	sigaction() to enable the EINTR behavior?  We've got the source
	for all this stuff, right?  Are the scenarios which require EINTR
	behavior easy to identify?

	Does this justify the difficulty in making programs work in the
	presence of signals that libraries use?

	The bottom line for me here is that I don't feel that this is
	_designed_ behavior and I feel that it might deserve some
	re-thinking considering that I don't feel that the POSIX people
	were considering the possibility that threads would be implemented
	using signals they way they are under Linux.

I spent the whole day Friday doing web searches to try to figure out what
situations programs would require this EINTR behavior and I couldn't
figure out a single scenario, so as I said, I _greatly_appreciate_ your &
Tim's feedback on this.  Especially considering that everyone else said
"many programs need this" without giving _any_ examples and "RTFM".  I did
"RTFM", and I still haven't been able to figure out where having this
as the _default_ behavior is a benefit.

Moreover, I'm willing to bet money that a large percentage of user-land
programmers aren't even _aware_ of the EINTR issue.  The Netscape people
certainly weren't for Netscape 4.x.  Don't know if the Mozilla people are.

--
George T. Talbot
<george@moberg.com>


-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
