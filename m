Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129622AbQJ1ATf>; Fri, 27 Oct 2000 20:19:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129874AbQJ1ATZ>; Fri, 27 Oct 2000 20:19:25 -0400
Received: from mta5.snfc21.pbi.net ([206.13.28.241]:28382 "EHLO
	mta5.snfc21.pbi.net") by vger.kernel.org with ESMTP
	id <S129622AbQJ1ATR>; Fri, 27 Oct 2000 20:19:17 -0400
Date: Fri, 27 Oct 2000 17:24:56 -0700
From: Dan Kegel <dank@alumni.caltech.edu>
Subject: Re: kqueue microbenchmark results
To: Terry Lambert <tlambert@primenet.com>
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>, Jonathan Lemon <jlemon@flugsvamp.com>,
        Gideon Glass <gid@cisco.com>, Simon Kirby <sim@stormix.com>,
        chat@FreeBSD.ORG, linux-kernel@vger.kernel.org
Reply-to: dank@alumni.caltech.edu
Message-id: <39FA1CD8.6C6ABAEE@alumni.caltech.edu>
MIME-version: 1.0
X-Mailer: Mozilla 4.73 [en] (X11; U; Linux 2.2.14-5.0 i686)
Content-type: text/plain; charset=us-ascii
Content-transfer-encoding: 7bit
X-Accept-Language: en
In-Reply-To: <200010272308.QAA29462@usr01.primenet.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Terry Lambert wrote:
> 
> > > Which is precisely why you need to know where in the chain of events this
> > > happened. Otherwise if I see
> > >         'read on fd 5'
> > >         'read on fd 5'
> > > How do I know which read is for which fd in the multithreaded case
> >
> > That can't happen, can it?  Let's say the following happens:
> >    close(5)
> >    accept() = 5
> >    call kevent() and rebind fd 5
> > The 'close(5)' would remove the old fd 5 events.  Therefore,
> > any fd 5 events you see returned from kevent are for the new fd 5.
> 
> Strictly speaking, it can happen in two cases:
> 
> 1)      single acceptor thread, multiple worker threads
> 2)      multiple anonymous "work to do" threads
> 
> In both these cases, the incoming requests from a client are
> given to any thread, rather than a particular thread.
> 
> In the first case, we can have (id:executer order:event):
> 
> 1:1:open 5
> 2:2:read 5
> 3:4:read 5
> 2:3:close 5
> 
> If thread 2 processes the close event before thread 3 processes
> the read event, then when thread 3 attempts procssing, it will
> fail.

You're not talking about kqueue() / kevent() here, are you?
With that interface, thread 2 would not see a close event;
instead, the other events for fd 5 would vanish from the queue.
If you were indeed talking about kqueue() / kevent(), please flesh
out the example a bit more, showing who calls kevent().

(A race that *can* happen is fd 5 could be closed by another
thread after a 'read 5' event is pulled from the event queue and
before it is processed, but that could happen with any
readiness notification API at all.)

- Dan
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
