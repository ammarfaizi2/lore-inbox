Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129793AbQJZQxA>; Thu, 26 Oct 2000 12:53:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129788AbQJZQwu>; Thu, 26 Oct 2000 12:52:50 -0400
Received: from cb58709-a.mdsn1.wi.home.com ([24.17.241.9]:53513 "EHLO
	prism.flugsvamp.com") by vger.kernel.org with ESMTP
	id <S129676AbQJZQwi>; Thu, 26 Oct 2000 12:52:38 -0400
Date: Thu, 26 Oct 2000 11:50:57 -0500
From: Jonathan Lemon <jlemon@flugsvamp.com>
To: Gideon Glass <gid@cisco.com>
Cc: Jonathan Lemon <jlemon@flugsvamp.com>, Simon Kirby <sim@stormix.com>,
        Dan Kegel <dank@alumni.caltech.edu>, chat@freebsd.org,
        linux-kernel@vger.kernel.org
Subject: Re: kqueue microbenchmark results
Message-ID: <20001026115057.A22681@prism.flugsvamp.com>
In-Reply-To: <20001024225637.A54554@prism.flugsvamp.com> <39F6655A.353FD236@alumni.caltech.edu> <20001025010246.B57913@prism.flugsvamp.com> <20001025112709.A1500@stormix.com> <20001025122307.B78130@prism.flugsvamp.com> <20001025114028.F12064@stormix.com> <20001025165626.B87091@prism.flugsvamp.com> <39F7F66C.55B158@cisco.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 1.0pre2i
In-Reply-To: <39F7F66C.55B158@cisco.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 26, 2000 at 02:16:28AM -0700, Gideon Glass wrote:
> Jonathan Lemon wrote:
> > 
> > Also, consider the following scenario for the proposed get_event():
> > 
> >    1. packet arrives, queues an event.
> >    2. user retrieves event.
> >    3. second packet arrives, queues event again.
> >    4. user reads() all data.
> > 
> > Now, next time around the loop, we get a notification for an event
> > when there is no data to read.  The application now must be prepared
> > to handle this case (meaning no blocking read() calls can be used).
> > 
> > Also, what happens if the user closes the socket after step 4 above?
> 
> Depends on the implementation.  If the item in the queue is the
> struct file (or whatever an fd indexes to), then the implementation
> can only queue the fd once.  This also avoids the problem with
> closing sockets - close() would naturally do a list_del() or whatever
> on the struct file.
> 
> At least I think it could be implemented this way...

kqueue currently does this; a close() on an fd will remove any pending
events from the queues that they are on which correspond to that fd.
I was trying to point out that it isn't as simple as it would seem at
first glance, as you have to consider an issues like this.  Also, if the 
implementation allows multiple event types per fd, (leading to multiple
queued events per fd) there no longer is a 1:1 mapping to something like
'struct file', and performing a list walk doesn't scale very well.
--
Jonathan
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
