Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129821AbQJ0QhA>; Fri, 27 Oct 2000 12:37:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129874AbQJ0Qgt>; Fri, 27 Oct 2000 12:36:49 -0400
Received: from mta6.snfc21.pbi.net ([206.13.28.240]:19184 "EHLO
	mta6.snfc21.pbi.net") by vger.kernel.org with ESMTP
	id <S129821AbQJ0Qgm>; Fri, 27 Oct 2000 12:36:42 -0400
Date: Fri, 27 Oct 2000 09:21:41 -0700
From: Dan Kegel <dank@alumni.caltech.edu>
Subject: Re: kqueue microbenchmark results
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: Jonathan Lemon <jlemon@flugsvamp.com>, Gideon Glass <gid@cisco.com>,
        Simon Kirby <sim@stormix.com>, chat@freebsd.org,
        linux-kernel@vger.kernel.org
Reply-to: dank@alumni.caltech.edu
Message-id: <39F9AB95.735E26A7@alumni.caltech.edu>
MIME-version: 1.0
X-Mailer: Mozilla 4.73 [en] (X11; U; Linux 2.2.14-5.0 i686)
Content-type: text/plain; charset=us-ascii
Content-transfer-encoding: 7bit
X-Accept-Language: en
In-Reply-To: <E13oyOE-00044z-00@the-village.bc.nu>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Alan Cox wrote:
> > > kqueue currently does this; a close() on an fd will remove any pending
> > > events from the queues that they are on which correspond to that fd.
> > 
> > the application of a close event.  What can I say, "the fd formerly known
> > as X" is now gone?  It would be incorrect to say that "fd X was closed",
> > since X no longer refers to anything, and the application may have reused
> > that fd for another file.
> 
> Which is precisely why you need to know where in the chain of events this
> happened. Otherwise if I see
> 
>         'read on fd 5'
>         'read on fd 5'
> 
> How do I know which read is for which fd in the multithreaded case

That can't happen, can it?  Let's say the following happens:
   close(5)
   accept() = 5
   call kevent() and rebind fd 5
The 'close(5)' would remove the old fd 5 events.  Therefore,
any fd 5 events you see returned from kevent are for the new fd 5.

(I suspect it helps that kevent() is both the only way to
bind events and the only way to pick them up; makes it harder
for one thread to sneak a new fd into the event list without
the thread calling kevent() noticing.)

- Dan
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
