Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130441AbQKDEYE>; Fri, 3 Nov 2000 23:24:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132063AbQKDEXx>; Fri, 3 Nov 2000 23:23:53 -0500
Received: from TSX-PRIME.MIT.EDU ([18.86.0.76]:49551 "HELO tsx-prime.MIT.EDU")
	by vger.kernel.org with SMTP id <S130441AbQKDEXk>;
	Fri, 3 Nov 2000 23:23:40 -0500
Date: Fri, 3 Nov 2000 23:23:20 -0500
Message-Id: <200011040423.XAA21508@tsx-prime.MIT.EDU>
From: "Theodore Y. Ts'o" <tytso@MIT.EDU>
To: george@moberg.com
CC: Tim Hockin <thockin@isunix.it.ilstu.edu>, linux-kernel@vger.kernel.org
In-Reply-To: george@moberg.com's message of Fri, 03 Nov 2000 14:44:17 -0500,
	<3A031591.EA24ABFA@moberg.com>
Subject: Re: Can EINTR be handled the way BSD handles it? -- a plea from a 
 user-land
Phone: (781) 391-3464
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

   Date: 	Fri, 03 Nov 2000 14:44:17 -0500
   From: george@moberg.com

   My problem is that pthread_create (glibc 2.1.3, kernel 2.2.17 i686) is
   failing because, deep inside glibc somewhere, nanosleep() is returning
   EINTR.

Sounds like it might be a bug in pthread_create.... although that's not
clear.  You haven't given enough information to be sure.

   My code is not using signals.  The threading library is, and there is
   obviously some subtle bug going on here.  Ever wonder why when browsing
   with Netscape and you click on a link and it says "Interrupted system
   call."?  This is it.  I'm arguing that the default behaviour should be
   SA_RESTART, and if some programmer is so studly that they actually know
   what the hell they are doing by disabling SA_RESTART, then they can do
   it explicitly.

Ok first of all, the behaviour of sigaction is specified by the POSIX
standards.  To quote from the POSIX Rationale for section 3.3 (B.3.3):

	"Unlike all previous historical implementations, 4.2 BSD
	restarts some interrupted system calls rather than returning on
	error with errno set to [EINTR] after the signal-catching
	function returns.  THIS CHANGE CAUSED PROBLEMS FOR SOME
	APPLICATION CODE.  (Emphasis mine.)  4.3 BSD and other systems
	derived from 4.2BSD allow the application to choose whether
	system calls are to be restarted.   POSIX.1 (in 3.3.4) does not
	require restart of functions because it was not clear that the
	semantics of system-call restart in any historical
	implementation to be of value in a standard.  Implementors are
	free to add such mechanisms as extensions."

In Linux, we (well, actually I) added this extension as the SA_RESTART
flag.  However, other parts of POSIX make it very clear that in absence
of any extension such as SA_RESTART, "If the signal catching function
executes a return, the behaviour of the interrupted function shall be as
described individually for that function" (POSIX.1, 3.3.1.4).  And for
most functions, it is specified that they return EINTR if they are
interrupted by a signal.

So the answer is that if you want this behaviour, you have to call
sigaction with the appropriate flags --- namely SA_RESTART.

					- Ted
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
