Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267090AbSKSF3F>; Tue, 19 Nov 2002 00:29:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267091AbSKSF3F>; Tue, 19 Nov 2002 00:29:05 -0500
Received: from pop.gmx.de ([213.165.65.60]:48406 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id <S267090AbSKSF3E>;
	Tue, 19 Nov 2002 00:29:04 -0500
Message-ID: <3DD9CDB2.2075CCB4@gmx.de>
Date: Tue, 19 Nov 2002 06:35:46 +0100
From: Edgar Toernig <froese@gmx.de>
MIME-Version: 1.0
To: Davide Libenzi <davidel@xmailserver.org>
CC: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [rfc] epoll interface change and glibc bits ...
References: <Pine.LNX.4.44.0211182000590.979-100000@blue1.dev.mcafeelabs.com>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Davide Libenzi wrote:
> 
> On Tue, 19 Nov 2002, Edgar Toernig wrote:
> > What about adding an fd twice to the epoll-set?  Do you get an
> > error, will it override the previous settings for that fd, will
> > it be ignored, or is it registered twice and you get two results
> > for that fd?
> 
> You get EEXIST
> Well, there's the remote possibility, trying very badly from two threads,
> to add the same fd twice. It is an harmless condition though.

Just IMHO: I would prefer a different behaviour:

	int epoll_ctl(int epfd, int fd, int events)

which registers interest for "events" on "fd" and retuns previous
registered events for that fd (implies that the fd is removed when
"events" is 0) or -1 for error.

If you don't like it, at least an EP_CTL_GET should be added though.

Btw, what errno for an invalid fd (not epfd)?

> > Is the epoll-fd itself poll/epoll/selectable?
> 
> Yes.

Fine.  I guess, only POLLIN/readable is generated.

> 
> > Can I build cluster of epoll-sets?
> 
> Uh ?!

The previous "yes" already answers this ;-)  What I meant, ie three
fd-sets - low, normal, high priority fds - and a fourth set consisting
of the three epfds for these sets.

> > What happens if the epollfd is put into its own fd set?
> 
> You might find your machine a little bit frozen :)
> Either 1) I remove the read lock from poll() or 2) I check the condition
> at insetion time to avoid it. I very much prefer 2)

Hehe, sure.  But could become tricky: someone may build a circular chain
of epoll-fd-sets.

> > Can I send the epoll-fd over a unix-socket to another
> > process?
> 
> I'd say yes. SCM_RIGHTS should simply do an in-kernel file* to remote task
> descriptor mapping.

And what happens then?  Will the set refers to the fds from the sender
process or of fds of the receiving process (which may not even have
all those fds open)?

Another btw, what happens on close of an fd?  Will it get removed from all
epoll-fd-sets automatically?

> > Then, please add more details of how events are generated.  You
> > say, that an inactive-to-active transition causes an event.  What
> > is the starting point of the collection?  (I guess, all transitions
> 
> The starting point are the bits found at insertion time.

... and then after each epoll_wait call, I assume?

> > Does an operation on an fd effect the already collected but not yet
> > reported events?
> 
> You can do two operations on an existing fd. Remove is meaninless for this
> case. Modify will re-read available bits.

Huh, sorry.  I meant read/write/poll style of operations.

Anyway, thanks for the information.  I hope they will find their way
into the man-pages ;-)   (Ok, they may become more like the posix docs
but IMHO new interfaces should be well documented.)

Ciao, ET.
