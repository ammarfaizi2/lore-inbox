Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129427AbQJ0BMr>; Thu, 26 Oct 2000 21:12:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129472AbQJ0BMi>; Thu, 26 Oct 2000 21:12:38 -0400
Received: from cb58709-a.mdsn1.wi.home.com ([24.17.241.9]:17931 "EHLO
	prism.flugsvamp.com") by vger.kernel.org with ESMTP
	id <S129427AbQJ0BMZ>; Thu, 26 Oct 2000 21:12:25 -0400
Date: Thu, 26 Oct 2000 20:10:42 -0500
From: Jonathan Lemon <jlemon@flugsvamp.com>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: Jonathan Lemon <jlemon@flugsvamp.com>, Gideon Glass <gid@cisco.com>,
        Simon Kirby <sim@stormix.com>, Dan Kegel <dank@alumni.caltech.edu>,
        chat@freebsd.org, linux-kernel@vger.kernel.org
Subject: Re: kqueue microbenchmark results
Message-ID: <20001026201042.A38500@prism.flugsvamp.com>
In-Reply-To: <20001026115057.A22681@prism.flugsvamp.com> <E13oxjH-00041y-00@the-village.bc.nu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 1.0pre2i
In-Reply-To: <E13oxjH-00041y-00@the-village.bc.nu>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 27, 2000 at 01:50:40AM +0100, Alan Cox wrote:
> > kqueue currently does this; a close() on an fd will remove any pending
> > events from the queues that they are on which correspond to that fd.
> 
> This seems an odd thing to do. Surely what you need to do is to post a
> 'close completed' event to the queue. This also makes more sense when you
> have a threaded app and another thread may well currently be in say a read
> at the time it is closed

Actually, it makes sense when you think about it.  The `fd' is actually
a capability that the application uses to refer to the open file in the
kernel.  If the app does a close() on the fd, it destroys this naming.

The application then has no capability left which refers to the formerly
open socket, and conversly, the kernel has no capability (name) to notify
the application of a close event.  What can I say, "the fd formerly known
as X" is now gone?  It would be incorrect to say that "fd X was closed",
since X no longer refers to anything, and the application may have reused
that fd for another file.

As for the multi-thread case, this would be a bug; if one thread closes
the descriptor, the other thread is going to get an EBADF when it goes 
to perform the read.
--
Jonathan
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
