Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129505AbQKFSpT>; Mon, 6 Nov 2000 13:45:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129577AbQKFSpA>; Mon, 6 Nov 2000 13:45:00 -0500
Received: from isunix.it.ilstu.edu ([138.87.124.103]:1039 "EHLO
	isunix.it.ilstu.edu") by vger.kernel.org with ESMTP
	id <S129505AbQKFSoy>; Mon, 6 Nov 2000 13:44:54 -0500
From: Tim Hockin <thockin@isunix.it.ilstu.edu>
Message-Id: <200011061750.LAA10260@isunix.it.ilstu.edu>
Subject: Re: Can EINTR be handled the way BSD handles it? -- a plea from a
To: george@brain.moberg.com (George Talbot)
Date: Mon, 6 Nov 2000 11:50:29 -0600 (CST)
Cc: tytso@MIT.EDU (Theodore Y. Ts'o), linux-kernel@vger.kernel.org
In-Reply-To: <Pine.LNX.4.21.0011060824000.4984-100000@brain.moberg.com> from "George Talbot" at Nov 06, 2000 09:05:52 AM
X-Mailer: ELM [version 2.5 PL3]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> 	"THIS CHANGE CAUSED PROBLEMS FOR SOME APPLICATION CODE."
> 
> 	_Which_ applications?
> 
> 	_Why_ did they have a problem?  Was this due to a bug or were they
> 	designed to do stuff this way?

I, for one, have an app that relies on syscalls not being restarted:
	app goes into a blocking read on a socket
	signal interrupts blocking read
		signal handler sets a global flag
	read returns interrupted
	flag is checked - action may be taken

Now, this could be redone to use a select() with a small timeout (busy
loop), but the blocking read is more convenient, as there may be many
instances of this app running.  

> 	How hard would it be to change these programs to use
> 	sigaction() to enable the EINTR behavior?  We've got the source

Actually, you already have to specifically call sigaction to get the EINTR
behavior - glibc signal() (obsolete) sets SA_RESTART by default.  What this
suggests is that something in pthreads is unsetting SA_RESTART, or calling
sigaction without it.  grep?

> Moreover, I'm willing to bet money that a large percentage of user-land
> programmers aren't even _aware_ of the EINTR issue.  The Netscape people
> certainly weren't for Netscape 4.x.  Don't know if the Mozilla people are.

Then they have never read a decent UNIX programming text.  Page 275 of
"Advanced Programming in the UNIX Environment", W. Richard Stevens (a de
facto standard for texts in this area).  An entire section of the chapter
is spent on interrupted syscalls.  If I were the manager of a team of
people who didn't handle it, I'd be very disappointed.

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
