Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S288061AbSBDBKN>; Sun, 3 Feb 2002 20:10:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S288058AbSBDBKE>; Sun, 3 Feb 2002 20:10:04 -0500
Received: from relay1.pair.com ([209.68.1.20]:5636 "HELO relay.pair.com")
	by vger.kernel.org with SMTP id <S288061AbSBDBJ4>;
	Sun, 3 Feb 2002 20:09:56 -0500
X-pair-Authenticated: 24.126.75.99
Message-ID: <3C5DE0D2.77DDE891@kegel.com>
Date: Sun, 03 Feb 2002 17:16:02 -0800
From: Dan Kegel <dank@kegel.com>
X-Mailer: Mozilla 4.78 [en] (X11; U; Linux 2.4.7-10 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Aaron Sethman <androsyn@ratbox.org>
CC: Kev <klmitch@MIT.EDU>, Arjen Wolfs <arjen@euro.net>,
        coder-com@undernet.org, feedback@distributopia.com,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [Coder-Com] Re: PROBLEM: high system usage / poor SMPnetwork 
 performance
In-Reply-To: <Pine.LNX.4.44.0202031955480.3086-100000@simon.ratbox.org>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Aaron Sethman wrote:
> 
> On Sun, 3 Feb 2002, Dan Kegel wrote:
> 
> > Kev wrote:
> > >
> > > > The /dev/epoll patch is good, but the interface is different enough
> > > > from /dev/poll that ircd would need a new engine_epoll.c anyway.
> > > > (It would look like a cross between engine_devpoll.c and engine_rtsig.c,
> > > > as it would need to be notified by os_linux.c of any EWOULDBLOCK return values.
> > > > Both rtsigs and /dev/epoll only provide 'I just became ready' notification,
> > > > but no 'I'm not ready anymore' notification.)
> > >
> > > I don't understand what it is you're saying here.  The ircu server uses
> > > non-blocking sockets, and has since long before EfNet and Undernet branched,
> > > so it already handles EWOULDBLOCK or EAGAIN intelligently, as far as I know.
> >
> > Right.  poll() and Solaris /dev/poll are programmer-friendly; they give
> > you the current readiness status for each socket.  ircu handles them fine.
> 
> I would have to agree with this comment.  Hybrid-ircd deals with poll()
> and /dev/poll just fine.  We have attempted to make it use rtsig, but it
> just doesn't seem to agree with the i/o model we are using...

I'd like to know how it disagrees.
I believe rtsig requires you to tweak your I/O code in three ways:
1. you need to pick a realtime signal number to use for an event queue
2. you need to wrap your read()/write() calls on the socket with code
that notices EWOULDBLOCK
3. you need to fall back to poll() on signal queue overflow.

For what it's worth, my Poller library takes care of fallback to poll
transparantly, and makes the EWOULDBLOCK stuff fairly easy.  I gather
from the way you quoted my previous messsage, though, that you
consider rtsig too awful to even think about.

> I haven't played with /dev/epoll yet, but I pray it is nothing like rtsig.

Unfortunately, it is exactly like rtsig in how you need to handle
EWOULDBLOCK.

> Basically what we need is, something like poll() but not so nasty.
> /dev/poll is okay, but its a hack.  The best thing I've seen so far, but
> it too seems to take the idea so far is FreeBSD's kqueue stuff(which
> Hybrid-ircd handles quite nicely).

Yes, kqueue is quite easy to use, and doesn't require the gyrations
that rtsig or /dev/epoll require.  The only thing that makes rtsig or /dev/epoll
usable are user-space wrapper libraries that let you forget about the
gyrations (mostly).
- Dan
