Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268095AbTGLTyK (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 12 Jul 2003 15:54:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268294AbTGLTyK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 12 Jul 2003 15:54:10 -0400
Received: from x35.xmailserver.org ([208.129.208.51]:57994 "EHLO
	x35.xmailserver.org") by vger.kernel.org with ESMTP id S268095AbTGLTyF
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 12 Jul 2003 15:54:05 -0400
X-AuthUser: davidel@xmailserver.org
Date: Sat, 12 Jul 2003 13:01:21 -0700 (PDT)
From: Davide Libenzi <davidel@xmailserver.org>
X-X-Sender: davide@bigblue.dev.mcafeelabs.com
To: Eric Varsanyi <e0206@foo21.com>
cc: David Miller <davem@redhat.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [Patch][RFC] epoll and half closed TCP connections
In-Reply-To: <20030712181654.GB15643@srv.foo21.com>
Message-ID: <Pine.LNX.4.55.0307121256200.4720@bigblue.dev.mcafeelabs.com>
References: <20030712181654.GB15643@srv.foo21.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


[Cc:ing DaveM ]


On Sat, 12 Jul 2003, Eric Varsanyi wrote:

> I'm proposing adding a new POLL event type (POLLRDHUP) as way to solve
> a new race introduced by having an edge triggered event mechanism
> (epoll). The problem occurs when a client writes data and then does a
> write side shutdown(). The server (using epoll) sees only one event for
> the read data ready and the read EOF condition and has no way to tell
> that an EOF occurred.
>
> -Eric Varsanyi
>
> Details
> -----------
> 	- remote sends data and does a shutdown
> 	   [ we see a data bearing packet and FIN from client on the wire ]
>
> 	- user mode server gets around to doing accept() and registers
> 	  for EPOLLIN events (along with HUP and ERR which are forced on)
>
> 	- epoll_wait() returns a single EPOLLIN event on the FD representing
> 	  both the 1/2 shutdown state and data available
>
> At this point there is no way the app can tell if there is a half closed
> connection so it may issue a close() back to the client after writing
> results. Normally the server would distinguish these events by assuming
> EOF if it got a read ready indication and the first read returned 0 bytes,
> or would issue read calls until less data was returned than was asked for.
>
> In a level triggered world this all just works because the read ready
> indication is driven back to the app as long as the socket state is half
> closed. The event driven epoll mechanism folds these two indications
> together and thus loses one 'edge'.
>
> One would be tempted to issue an extra read() after getting back less than
> expected, but this is an extra system call on every read event and you get
> back the same '0' bytes that you get if the buffer is just empty. The only
> sure bet seems to be CTL_MODding the FD to force a re-poll (which would
> cost a syscall and hash-lookup in eventpoll for every read event).
>

Yes, this is overhead that should be avoided. It is true that you could
use Level Triggered events, but if you structured your app on edge you
should be able to solve this w/out overhead.



> 	2) add a new 1/2 closed event type that a poll routine can return
>
> The implementation is trivial, a patch is included below. If this idea sees
> favor I'll fix the other architectures, ipv6, epoll.h, and make a 'real'
> patch. I do not believe any drivers deserve to be modified to return this
> new event.

This looks good to me. David what do you think ?



> diff -Naur linux-2.4.20/include/asm-i386/poll.h linux-2.4.20_ev/include/asm-i386/poll.h
> --- linux-2.4.20/include/asm-i386/poll.h	Thu Jan 23 13:01:28 1997
> +++ linux-2.4.20_ev/include/asm-i386/poll.h	Sat Jul 12 12:29:11 2003
> @@ -15,6 +15,7 @@
>  #define POLLWRNORM	0x0100
>  #define POLLWRBAND	0x0200
>  #define POLLMSG		0x0400
> +#define POLLRDHUP	0x0800
>
>  struct pollfd {
>  	int fd;
> diff -Naur linux-2.4.20/net/ipv4/tcp.c linux-2.4.20_ev/net/ipv4/tcp.c
> --- linux-2.4.20/net/ipv4/tcp.c	Tue Jul  8 09:40:42 2003
> +++ linux-2.4.20_ev/net/ipv4/tcp.c	Sat Jul 12 12:29:56 2003
> @@ -424,7 +424,7 @@
>  	if (sk->shutdown == SHUTDOWN_MASK || sk->state == TCP_CLOSE)
>  		mask |= POLLHUP;
>  	if (sk->shutdown & RCV_SHUTDOWN)
> -		mask |= POLLIN | POLLRDNORM;
> +		mask |= POLLIN | POLLRDNORM | POLLRDHUP;
>
>  	/* Connected? */
>  	if ((1 << sk->state) & ~(TCPF_SYN_SENT|TCPF_SYN_RECV)) {
>



- Davide

