Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267571AbUHTGA5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267571AbUHTGA5 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 20 Aug 2004 02:00:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267575AbUHTGA4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 20 Aug 2004 02:00:56 -0400
Received: from imap.gmx.net ([213.165.64.20]:44974 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id S267571AbUHTGAx (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 20 Aug 2004 02:00:53 -0400
Date: Fri, 20 Aug 2004 08:00:52 +0200 (MEST)
From: "Michael Kerrisk" <mtk-lkml@gmx.net>
To: Roland McGrath <roland@redhat.com>
Cc: torvalds@osdl.org, akpm@osdl.org, drepper@redhat.com,
       linux-kernel@vger.kernel.org, michael.kerrisk@gmx.net
MIME-Version: 1.0
References: <200408192053.i7JKrE9g024895@magilla.sf.frob.com>
Subject: Re: [PATCH] waitid system call
X-Priority: 3 (Normal)
X-Authenticated: #23581172
Message-ID: <28571.1092981652@www22.gmx.net>
X-Mailer: WWW-Mail 1.6 (Global Message Exchange)
X-Flags: 0001
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Roland,

> > all seems well, with one possible doubt.  How can one 
> > distinguish "no children to wait for case" and the "child 
> > successfully waited for case" when using WNOHANG?
> 
> This is something I did consider in detail, though I overlooked 
> commenting
> on it.  The POSIX wording on this is not entirely unambiguous.  What it
> does say is, "If waitid() returns because a child process was found 
> [...],
> then the structure pointed to by infop shall be filled in by the system
> [...]"  It does not say that *infop is written in any other case.  So, I
> think a POSIX-compliant application must not assume that it will be.  

Agreed.  But nor does it prohibit it.  More below.

> Given that specification, I made the system call do just what it says and
> no more.  For a WNOHANG return without a child, it doesn't touch the
> structure.
> 
> The tst-waitid program intends to be POSIX-compliant (in its use of
> waitid), and so I wrote it to zero the si_signo field before the call and
> check whether it got set to SIGCHLD or not.  The POSIX specification for
> waitid specifically requires that si_signo be set to SIGCHLD when the
> siginfo_t is filled in.  Taking the standard as a whole, you can also
> conclude that it requires that si_pid be filled in and not zero.  So that
> is also a reasonable test--if you zeroed the structure (or at least the
> field you want to test) before the waitid call.
> 
> I think one could even construe the POSIX wording to mean that a WNOHANG
> return-without-child should not touch the structure at all.  However, I
> would not argue for that and say Solaris should not zero si_pid here.

That would certainly strain my powers of interpretation ;-).  

Anyway, as you noted recently in another thread, sometimes 
improvements on POSIX are worth having.  To that, I'd add: 
"especially if other systems also have them".

I did some more investigaton and testing:

-- Tru64 5.1 behaves like Solaris 8 -- si_pid == 0 for
   the WNOHANG with no children case.

-- HP-UX 11 is different -- not even POSIX compliant.  It
   returns -1 with ECHILD in this scenario.  

-- According to the man pages, waitid() is also present on
   Irix 6.5 and UnixWare 7, but I don't have access to 
   those systems to run a test (my earlier test program
   would be sufficient to test on those systems).

So, discounting the non-compliant HP-UX, on other 
implementations we have 2 out of 2 for the "si_pid == 0"
behavior.  (I will see if I can get access to other
systems for further testing.)  So, how about 
reconsidering the approach for Linux?

Cheers,

Michael

PS Perhaps it would be worth investigating this further on 
the Austin list?  I'm happy to start a thread there.

-- 
NEU: Bis zu 10 GB Speicher für e-mails & Dateien!
1 GB bereits bei GMX FreeMail http://www.gmx.net/de/go/mail

