Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268177AbTGLSCP (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 12 Jul 2003 14:02:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268198AbTGLSCP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 12 Jul 2003 14:02:15 -0400
Received: from ev2.cpe.orbis.net ([209.173.192.122]:26276 "EHLO srv.foo21.com")
	by vger.kernel.org with ESMTP id S268177AbTGLSCJ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 12 Jul 2003 14:02:09 -0400
Date: Sat, 12 Jul 2003 13:16:54 -0500
From: Eric Varsanyi <e0206@foo21.com>
To: linux-kernel@vger.kernel.org
Cc: davidel@xmailserver.org
Subject: [Patch][RFC] epoll and half closed TCP connections
Message-ID: <20030712181654.GB15643@srv.foo21.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I'm proposing adding a new POLL event type (POLLRDHUP) as way to solve
a new race introduced by having an edge triggered event mechanism
(epoll). The problem occurs when a client writes data and then does a
write side shutdown(). The server (using epoll) sees only one event for
the read data ready and the read EOF condition and has no way to tell
that an EOF occurred.

-Eric Varsanyi

Details
-----------
	- remote sends data and does a shutdown
	   [ we see a data bearing packet and FIN from client on the wire ]

	- user mode server gets around to doing accept() and registers
	  for EPOLLIN events (along with HUP and ERR which are forced on)

	- epoll_wait() returns a single EPOLLIN event on the FD representing
	  both the 1/2 shutdown state and data available

At this point there is no way the app can tell if there is a half closed
connection so it may issue a close() back to the client after writing
results. Normally the server would distinguish these events by assuming
EOF if it got a read ready indication and the first read returned 0 bytes,
or would issue read calls until less data was returned than was asked for.

In a level triggered world this all just works because the read ready
indication is driven back to the app as long as the socket state is half
closed. The event driven epoll mechanism folds these two indications
together and thus loses one 'edge'.

One would be tempted to issue an extra read() after getting back less than
expected, but this is an extra system call on every read event and you get
back the same '0' bytes that you get if the buffer is just empty. The only
sure bet seems to be CTL_MODding the FD to force a re-poll (which would
cost a syscall and hash-lookup in eventpoll for every read event).

The POLLHUP indication is specifically not used in this 1/2 closed state
since it is (by POSIX) not allowed to be masked and would interfere with
EPOLLOUT back to client if it were set.

I considered 2 possible ideas:

	1) have epoll return a count of events represented by a single
	   appearance in the list after an epoll_wait(); this could be
	   used as a hint to make some other (tbd) syscall to find out
	   if the socket was in half closed state and normally not have
	   to pay an extra syscall on every read; this seems like a lot of
	   tap dancing for a work around

	2) add a new 1/2 closed event type that a poll routine can return

The implementation is trivial, a patch is included below. If this idea sees
favor I'll fix the other architectures, ipv6, epoll.h, and make a 'real'
patch. I do not believe any drivers deserve to be modified to return this
new event.

This should not break existing programs, it still returns the read ready
indication as before and unless an app registers for this new event it won't
be woken up an extra time. Any epoll programs will not get the extra event
indicated unless they ask for it. I dislike extending such an established
API, but coopting any of the other event types just seems wrong.

Other ideas and comments would be appreciated,
-Eric Varsanyi

diff -Naur linux-2.4.20/include/asm-i386/poll.h linux-2.4.20_ev/include/asm-i386/poll.h
--- linux-2.4.20/include/asm-i386/poll.h	Thu Jan 23 13:01:28 1997
+++ linux-2.4.20_ev/include/asm-i386/poll.h	Sat Jul 12 12:29:11 2003
@@ -15,6 +15,7 @@
 #define POLLWRNORM	0x0100
 #define POLLWRBAND	0x0200
 #define POLLMSG		0x0400
+#define POLLRDHUP	0x0800
 
 struct pollfd {
 	int fd;
diff -Naur linux-2.4.20/net/ipv4/tcp.c linux-2.4.20_ev/net/ipv4/tcp.c
--- linux-2.4.20/net/ipv4/tcp.c	Tue Jul  8 09:40:42 2003
+++ linux-2.4.20_ev/net/ipv4/tcp.c	Sat Jul 12 12:29:56 2003
@@ -424,7 +424,7 @@
 	if (sk->shutdown == SHUTDOWN_MASK || sk->state == TCP_CLOSE)
 		mask |= POLLHUP;
 	if (sk->shutdown & RCV_SHUTDOWN)
-		mask |= POLLIN | POLLRDNORM;
+		mask |= POLLIN | POLLRDNORM | POLLRDHUP;
 
 	/* Connected? */
 	if ((1 << sk->state) & ~(TCPF_SYN_SENT|TCPF_SYN_RECV)) {
