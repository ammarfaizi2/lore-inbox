Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266981AbSKSEHb>; Mon, 18 Nov 2002 23:07:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267038AbSKSEHb>; Mon, 18 Nov 2002 23:07:31 -0500
Received: from x35.xmailserver.org ([208.129.208.51]:38286 "EHLO
	x35.xmailserver.org") by vger.kernel.org with ESMTP
	id <S266981AbSKSEHa>; Mon, 18 Nov 2002 23:07:30 -0500
X-AuthUser: davidel@xmailserver.org
Date: Mon, 18 Nov 2002 20:14:57 -0800 (PST)
From: Davide Libenzi <davidel@xmailserver.org>
X-X-Sender: davide@blue1.dev.mcafeelabs.com
To: Edgar Toernig <froese@gmx.de>
cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [rfc] epoll interface change and glibc bits ...
In-Reply-To: <3DD9B3F8.DC291106@gmx.de>
Message-ID: <Pine.LNX.4.44.0211182000590.979-100000@blue1.dev.mcafeelabs.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 19 Nov 2002, Edgar Toernig wrote:

> Davide Libenzi wrote:
> >
> > http://www.xmailserver.org/linux-patches/epoll.2
> > http://www.xmailserver.org/linux-patches/epoll_create.2
> > http://www.xmailserver.org/linux-patches/epoll_ctl.2
> > http://www.xmailserver.org/linux-patches/epoll_wait.2
> >
> > it is going to change though with the latest talks about the interface.

Yes, man pages needs some work after the interface will be fixed. I hope
to fix it this week.



> Remove the waitqueue stuff from epoll.2.  It has meaning only to
> linux kernel developers and noone else.

Sigh, I liked it :)


> What about adding an fd twice to the epoll-set?  Do you get an
> error, will it override the previous settings for that fd, will
> it be ignored, or is it registered twice and you get two results
> for that fd?

You get EEXIST
Well, there's the remote possibility, trying very badly from two threads,
to add the same fd twice. It is an harmless condition though.



> Can two epoll-sets wait for the same fd?

Yes. Not suggested though.


> Are events reported to both epoll-fds?

Yes.



> Is the epoll-fd itself poll/epoll/selectable?

Yes.



> Can I build cluster of epoll-sets?

Uh ?!



> What happens if the epollfd is put into its own fd set?

You might find your machine a little bit frozen :)
Either 1) I remove the read lock from poll() or 2) I check the condition
at insetion time to avoid it. I very much prefer 2)


> Can I send the epoll-fd over a unix-socket to another
> process?

I'd say yes. SCM_RIGHTS should simply do an in-kernel file* to remote task
descriptor mapping.



> Then, please add more details of how events are generated.  You
> say, that an inactive-to-active transition causes an event.  What
> is the starting point of the collection?  (I guess, all transitions

The starting point are the bits found at insertion time.



> between two epoll_wait calls.)  There could be a couple of transi-
> tions on an fd between two epoll_wait calls.  Are these events com-
> bined into a single reported event or is each single edge reported?

Yes, they'll be combined.



> Does an operation on an fd effect the already collected but not yet
> reported events?

You can do two operations on an existing fd. Remove is meaninless for this
case. Modify will re-read available bits.



> About epoll_wait: it looks like a "read with timeout" call.  Is that
> really necessary or wouldn't a normal read(2) work as well?  Similar
> for epoll_ctl: couldn't a write(2) to the epoll-fd do the same?

IMHO distinc functions are more clear than magic read/write operations.



- Davide


