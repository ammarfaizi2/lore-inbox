Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263471AbTCNSku>; Fri, 14 Mar 2003 13:40:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263472AbTCNSku>; Fri, 14 Mar 2003 13:40:50 -0500
Received: from x35.xmailserver.org ([208.129.208.51]:30092 "EHLO
	x35.xmailserver.org") by vger.kernel.org with ESMTP
	id <S263471AbTCNSkt>; Fri, 14 Mar 2003 13:40:49 -0500
X-AuthUser: davidel@xmailserver.org
Date: Fri, 14 Mar 2003 11:01:04 -0800 (PST)
From: Davide Libenzi <davidel@xmailserver.org>
X-X-Sender: davide@blue1.dev.mcafeelabs.com
To: Tim Smith <tzs@tzs.net>
cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [patch, rfc] lt-epoll ( level triggered epoll ) ...
In-Reply-To: <Pine.LNX.4.44.0303140916300.9247-100000@tzs.net>
Message-ID: <Pine.LNX.4.50.0303141053180.1903-100000@blue1.dev.mcafeelabs.com>
References: <Pine.LNX.4.44.0303140916300.9247-100000@tzs.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 14 Mar 2003, Tim Smith wrote:

> On Fri, 14 Mar 2003, Davide Libenzi wrote:
> > See, this is a free world, and I very much respect your opinion. On the
> > other side you might want to actually *read* the kqueue man page and find
> > out of its 24590 flags, where 99% of its users will use only 1% of its
> > functionality. Talking about overbloating. You might also want to know
>
> Wow...that does sound overbloated.  Simpler is usually better in this kind
> of thing, because 99% of the users will be doing the same thing: a lot of
> TCP connections.  From what I've seen so far, I'm very much looking forward
> to your epoll stuff.
>
> However, just for the heck of it, let me throw out a (probably stupid) idea
> for the ultimate in non-overbloated interfaces for handling a ton of TCP
> connections in the (probably most) common case of those connections all
> being to the same port.  I've not looked into the kernel at all to see if
> this would actually be feasible...just speculating based on what I'd like
> as someone writing a server that I'd like to have handle 100k TCP
> connections on commodity hardware.

The only problem having 100K connections using epoll is RAM. You need to
have 100K socket buffers, 100K connection "status", ...



> How about an option to put a bound socket in a mode I'll call TCP Datagram
> Mode (TDM).  You can listen() on a TDM socket.  When you accept() on a TDM
> socket, you get a socket for the new connection, just like now.  However,
> that socket is only used for writing to the connection.
>
> When data is available to read on the connection, instead of getting POLLIN
> on the connection socket, you get a new event on the listen socket: POLLSDG
> (SDG == "stream datagram"...generalization of "TCP Datagram").  You can then
> use recvmsg on the listen socket, and that gives you a chunk of data from
> one of the connections.  The ancillary data tells you what connection the
> data is from.
>
> With this interface, plain old poll() should be good enough.  For reading,
> you are only poll()ing on the listen socket.  You only need to poll() on the
> write sockets if you fill up output buffers.  So, most of the time, poll()
> would only be used on one socket.  Even plain old poll() scales well
> to 1. :-)
>
> (Actually...it might even be reasonable to use sendmsg() on the listen
> socket to send data, too, and then get rid of the whole accept() thing for
> TDM sockets.  Basically, turn multiple TCP connections into a reliable form
> of UDP from the application's point of view)

This will work too. Sadly you have to abbandon POSIX semantics for those
sockets. The idea of detaching a new socket through an accept in to have
the abstraction on one file/socket per connection/client.




- Davide

