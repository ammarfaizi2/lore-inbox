Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S270491AbTGNCKa (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 13 Jul 2003 22:10:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S270495AbTGNCKa
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 13 Jul 2003 22:10:30 -0400
Received: from mail.jlokier.co.uk ([81.29.64.88]:64148 "EHLO
	mail.jlokier.co.uk") by vger.kernel.org with ESMTP id S270491AbTGNCKO
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 13 Jul 2003 22:10:14 -0400
Date: Mon, 14 Jul 2003 03:24:12 +0100
From: Jamie Lokier <jamie@shareable.org>
To: Davide Libenzi <davidel@xmailserver.org>
Cc: "David S. Miller" <davem@redhat.com>, Eric Varsanyi <e0206@foo21.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       kuznet@ms2.inr.ac.ru
Subject: POLLRDONCE optimisation for epoll users (was: epoll and half closed TCP connections)
Message-ID: <20030714022412.GD22769@mail.jlokier.co.uk>
References: <20030712181654.GB15643@srv.foo21.com> <Pine.LNX.4.55.0307121256200.4720@bigblue.dev.mcafeelabs.com> <20030712222457.3d132897.davem@redhat.com> <20030713140758.GF19132@mail.jlokier.co.uk> <Pine.LNX.4.55.0307130956530.14680@bigblue.dev.mcafeelabs.com> <20030713191559.GA20573@mail.jlokier.co.uk> <Pine.LNX.4.55.0307131542000.15022@bigblue.dev.mcafeelabs.com> <20030714014135.GA22769@mail.jlokier.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030714014135.GA22769@mail.jlokier.co.uk>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jamie Lokier wrote:
> Anyway, there is a correct answer and I have made the patch so wait
> for next mail... :)

The patch is included below.  Note, it compiles and has been carefully
scrutinised by a team of master coders, but never actually run.  Eric,
you may want to try it out :)

The difference between this and POLLRDHUP is polarity, generality and
correctness :)

Eric, change the polarity of your test from

	if (events & POLLRDHUP)
		goto read_again;

to

	if (!(events & POLLRDONCE))
		goto read_again;

and it should (fingers crossed) work well.

Explanation
-----------

I wrote:

>    The critical thing with POLL_RDHUP is that it is set if read() would
>    return EOF after returning data.

I was mistaken.  That condition isn't strong enough for an
edge-triggered event loop.  Some kinds of fd return a short read when
there is more data pending, due to boundaries - not a HUP condition,
but read-until-EAGAIN is required nonetheless.  Ttys do it, some
devices do it, and TCP does it if there's urgent data (though POLLPRI
should also be set) and under some other conditions.

I strongly dislike the idea that an application should know anything
about the type of fd it is reading from, if all it's doing is reading.
Also having to check kernel version would be ugly - an app which
depended on POLLRDHUP would have to check the kernel version.

After much typing (my first kernel patch in aeons :), the answer follows...

              ----------------------------------

PATCH: POLLRDONCE optimisation for epoll users

The enclosed patch adds a POLLRDONCE condition.  This condition means
that it's _safe_ to read once before the next edge-triggered POLLIN event.

Otherwise, you must call read() repeatedly until you see EAGAIN, if
you are using edge-triggered epoll.  Simply calling read() once is not
guaranteed to re-arm the event.  (If you are using level-triggered
mode there is no problem, but edge-triggered mode is faster :)

This distinguishes the case where one read() is enough on a TCP
socket, from the case where a second read() is needed to fetch the EOF
condition.  Without this bit, applications must always call read()
twice in the very common case that the second will return -EAGAIN.

It is always safe for the application to ignore this bit, or if the
bit is not set.  So an application which looks for the bit will behave
correctly unmodified on older kernels or other kinds of fd.

This patch provides the optimisation for TCP sockets, pipes, fifos and
SOCK_STREAM AF_UNIX sockets, which are the common fd types for high
performance streaming applications.

Enjoy,
-- Jamie

diff -ur orig-2.5.75/fs/pipe.c pollrdonce-2.5.75/fs/pipe.c
--- orig-2.5.75/fs/pipe.c	2003-07-08 21:41:28.000000000 +0100
+++ pollrdonce-2.5.75/fs/pipe.c	2003-07-14 02:19:27.000000000 +0100
@@ -29,6 +29,9 @@
  *
  * pipe_read & write cleanup
  * -- Manfred Spraul <manfred@colorfullife.com> 2002-05-09
+ *
+ * Added POLLRDONCE.
+ * -- Jamie Lokier 2003-07-14
  */
 
 /* Drop the inode semaphore and wait for a pipe event, atomically */
@@ -250,6 +253,8 @@
 
 	/* Reading only -- no need for acquiring the semaphore.  */
 	mask = POLLIN | POLLRDNORM;
+	if (PIPE_WRITERS(*inode))
+		mask |= POLLRDONCE;
 	if (PIPE_EMPTY(*inode))
 		mask = POLLOUT | POLLWRNORM;
 	if (!PIPE_WRITERS(*inode) && filp->f_version != PIPE_WCOUNTER(*inode))
diff -ur orig-2.5.75/include/asm-alpha/poll.h pollrdonce-2.5.75/include/asm-alpha/poll.h
--- orig-2.5.75/include/asm-alpha/poll.h	2003-07-13 20:07:42.000000000 +0100
+++ pollrdonce-2.5.75/include/asm-alpha/poll.h	2003-07-13 22:35:21.000000000 +0100
@@ -13,6 +13,7 @@
 #define POLLWRBAND	(1 << 9)
 #define POLLMSG		(1 << 10)
 #define POLLREMOVE	(1 << 11)
+#define POLLRDONCE	(1 << 12)
 
 struct pollfd {
 	int fd;
diff -ur orig-2.5.75/include/asm-arm/poll.h pollrdonce-2.5.75/include/asm-arm/poll.h
--- orig-2.5.75/include/asm-arm/poll.h	2003-07-08 21:42:07.000000000 +0100
+++ pollrdonce-2.5.75/include/asm-arm/poll.h	2003-07-13 22:35:21.000000000 +0100
@@ -16,6 +16,7 @@
 #define POLLWRBAND	0x0200
 #define POLLMSG		0x0400
 #define POLLREMOVE	0x1000
+#define POLLRDONCE	0x2000
 
 struct pollfd {
 	int fd;
diff -ur orig-2.5.75/include/asm-arm26/poll.h pollrdonce-2.5.75/include/asm-arm26/poll.h
--- orig-2.5.75/include/asm-arm26/poll.h	2003-07-08 21:52:49.000000000 +0100
+++ pollrdonce-2.5.75/include/asm-arm26/poll.h	2003-07-13 22:35:21.000000000 +0100
@@ -15,6 +15,7 @@
 #define POLLWRNORM	0x0100
 #define POLLWRBAND	0x0200
 #define POLLMSG		0x0400
+#define POLLRDONCE	0x2000
 
 struct pollfd {
 	int fd;
diff -ur orig-2.5.75/include/asm-cris/poll.h pollrdonce-2.5.75/include/asm-cris/poll.h
--- orig-2.5.75/include/asm-cris/poll.h	2003-07-12 17:57:34.000000000 +0100
+++ pollrdonce-2.5.75/include/asm-cris/poll.h	2003-07-13 22:35:21.000000000 +0100
@@ -15,6 +15,7 @@
 #define POLLWRBAND	512
 #define POLLMSG		1024
 #define POLLREMOVE	4096
+#define POLLRDONCE	8192
 
 struct pollfd {
 	int fd;
diff -ur orig-2.5.75/include/asm-h8300/poll.h pollrdonce-2.5.75/include/asm-h8300/poll.h
--- orig-2.5.75/include/asm-h8300/poll.h	2003-07-08 21:42:18.000000000 +0100
+++ pollrdonce-2.5.75/include/asm-h8300/poll.h	2003-07-13 22:35:21.000000000 +0100
@@ -12,6 +12,7 @@
 #define POLLRDBAND	128
 #define POLLWRBAND	256
 #define POLLMSG		0x0400
+#define POLLRDONCE	2048
 
 struct pollfd {
 	int fd;
diff -ur orig-2.5.75/include/asm-i386/poll.h pollrdonce-2.5.75/include/asm-i386/poll.h
--- orig-2.5.75/include/asm-i386/poll.h	2003-07-08 21:42:26.000000000 +0100
+++ pollrdonce-2.5.75/include/asm-i386/poll.h	2003-07-13 22:35:21.000000000 +0100
@@ -16,6 +16,7 @@
 #define POLLWRBAND	0x0200
 #define POLLMSG		0x0400
 #define POLLREMOVE	0x1000
+#define POLLRDONCE	0x2000
 
 struct pollfd {
 	int fd;
diff -ur orig-2.5.75/include/asm-ia64/poll.h pollrdonce-2.5.75/include/asm-ia64/poll.h
--- orig-2.5.75/include/asm-ia64/poll.h	2003-07-08 21:42:30.000000000 +0100
+++ pollrdonce-2.5.75/include/asm-ia64/poll.h	2003-07-13 22:35:21.000000000 +0100
@@ -21,6 +21,7 @@
 #define POLLWRBAND	0x0200
 #define POLLMSG		0x0400
 #define POLLREMOVE	0x1000
+#define POLLRDONCE	0x2000
 
 struct pollfd {
 	int fd;
diff -ur orig-2.5.75/include/asm-m68k/poll.h pollrdonce-2.5.75/include/asm-m68k/poll.h
--- orig-2.5.75/include/asm-m68k/poll.h	2003-07-08 21:42:45.000000000 +0100
+++ pollrdonce-2.5.75/include/asm-m68k/poll.h	2003-07-13 22:35:21.000000000 +0100
@@ -13,6 +13,7 @@
 #define POLLWRBAND	256
 #define POLLMSG		0x0400
 #define POLLREMOVE	0x1000
+#define POLLRDONCE	0x2000
 
 struct pollfd {
 	int fd;
diff -ur orig-2.5.75/include/asm-mips/poll.h pollrdonce-2.5.75/include/asm-mips/poll.h
--- orig-2.5.75/include/asm-mips/poll.h	2003-07-08 21:55:30.000000000 +0100
+++ pollrdonce-2.5.75/include/asm-mips/poll.h	2003-07-13 22:35:21.000000000 +0100
@@ -17,6 +17,7 @@
 /* These seem to be more or less nonstandard ...  */
 #define POLLMSG		0x0400
 #define POLLREMOVE	0x1000
+#define POLLRDONCE	0x2000
 
 struct pollfd {
 	int fd;
diff -ur orig-2.5.75/include/asm-mips64/poll.h pollrdonce-2.5.75/include/asm-mips64/poll.h
--- orig-2.5.75/include/asm-mips64/poll.h	2003-07-08 21:55:33.000000000 +0100
+++ pollrdonce-2.5.75/include/asm-mips64/poll.h	2003-07-13 22:35:21.000000000 +0100
@@ -17,6 +17,7 @@
 /* These seem to be more or less nonstandard ...  */
 #define POLLMSG		0x0400
 #define POLLREMOVE	0x1000
+#define POLLRDONCE	0x2000
 
 struct pollfd {
 	int fd;
diff -ur orig-2.5.75/include/asm-parisc/poll.h pollrdonce-2.5.75/include/asm-parisc/poll.h
--- orig-2.5.75/include/asm-parisc/poll.h	2003-07-08 21:43:06.000000000 +0100
+++ pollrdonce-2.5.75/include/asm-parisc/poll.h	2003-07-13 22:35:21.000000000 +0100
@@ -16,6 +16,7 @@
 #define POLLWRBAND	0x0200
 #define POLLMSG		0x0400
 #define POLLREMOVE	0x1000
+#define POLLRDONCE	0x2000
 
 struct pollfd {
 	int fd;
diff -ur orig-2.5.75/include/asm-ppc/poll.h pollrdonce-2.5.75/include/asm-ppc/poll.h
--- orig-2.5.75/include/asm-ppc/poll.h	2003-07-08 21:43:15.000000000 +0100
+++ pollrdonce-2.5.75/include/asm-ppc/poll.h	2003-07-13 22:35:21.000000000 +0100
@@ -13,6 +13,7 @@
 #define POLLWRBAND	0x0200
 #define POLLMSG		0x0400
 #define POLLREMOVE	0x1000
+#define POLLRDONCE	0x2000
 
 struct pollfd {
 	int fd;
diff -ur orig-2.5.75/include/asm-ppc64/poll.h pollrdonce-2.5.75/include/asm-ppc64/poll.h
--- orig-2.5.75/include/asm-ppc64/poll.h	2003-07-08 21:43:15.000000000 +0100
+++ pollrdonce-2.5.75/include/asm-ppc64/poll.h	2003-07-13 22:35:21.000000000 +0100
@@ -22,6 +22,7 @@
 #define POLLWRBAND	0x0200
 #define POLLMSG		0x0400
 #define POLLREMOVE	0x1000
+#define POLLRDONCE	0x2000
 
 struct pollfd {
 	int fd;
diff -ur orig-2.5.75/include/asm-s390/poll.h pollrdonce-2.5.75/include/asm-s390/poll.h
--- orig-2.5.75/include/asm-s390/poll.h	2003-07-08 21:43:19.000000000 +0100
+++ pollrdonce-2.5.75/include/asm-s390/poll.h	2003-07-13 22:35:21.000000000 +0100
@@ -24,6 +24,7 @@
 #define POLLWRBAND	0x0200
 #define POLLMSG		0x0400
 #define POLLREMOVE	0x1000
+#define POLLRDONCE	0x2000
 
 struct pollfd {
 	int fd;
diff -ur orig-2.5.75/include/asm-sh/poll.h pollrdonce-2.5.75/include/asm-sh/poll.h
--- orig-2.5.75/include/asm-sh/poll.h	2003-07-08 21:55:36.000000000 +0100
+++ pollrdonce-2.5.75/include/asm-sh/poll.h	2003-07-13 22:35:21.000000000 +0100
@@ -16,6 +16,7 @@
 #define POLLWRBAND	0x0200
 #define POLLMSG		0x0400
 #define POLLREMOVE	0x1000
+#define POLLRDONCE	0x2000
 
 struct pollfd {
 	int fd;
diff -ur orig-2.5.75/include/asm-sparc/poll.h pollrdonce-2.5.75/include/asm-sparc/poll.h
--- orig-2.5.75/include/asm-sparc/poll.h	2003-07-08 21:43:28.000000000 +0100
+++ pollrdonce-2.5.75/include/asm-sparc/poll.h	2003-07-13 22:35:21.000000000 +0100
@@ -13,6 +13,7 @@
 #define POLLWRBAND	256
 #define POLLMSG		512
 #define POLLREMOVE	1024
+#define POLLRDONCE	2048
 
 struct pollfd {
 	int fd;
diff -ur orig-2.5.75/include/asm-sparc64/poll.h pollrdonce-2.5.75/include/asm-sparc64/poll.h
--- orig-2.5.75/include/asm-sparc64/poll.h	2003-07-08 21:43:33.000000000 +0100
+++ pollrdonce-2.5.75/include/asm-sparc64/poll.h	2003-07-13 22:35:21.000000000 +0100
@@ -13,6 +13,7 @@
 #define POLLWRBAND	256
 #define POLLMSG		512
 #define POLLREMOVE	1024
+#define POLLRDONCE	2048
 
 struct pollfd {
 	int fd;
diff -ur orig-2.5.75/include/asm-v850/poll.h pollrdonce-2.5.75/include/asm-v850/poll.h
--- orig-2.5.75/include/asm-v850/poll.h	2003-07-08 21:43:40.000000000 +0100
+++ pollrdonce-2.5.75/include/asm-v850/poll.h	2003-07-13 22:35:21.000000000 +0100
@@ -13,6 +13,7 @@
 #define POLLWRBAND	0x0100
 #define POLLMSG		0x0400
 #define POLLREMOVE	0x1000
+#define POLLRDONCE	0x2000
 
 struct pollfd {
 	int fd;
diff -ur orig-2.5.75/include/asm-x86_64/poll.h pollrdonce-2.5.75/include/asm-x86_64/poll.h
--- orig-2.5.75/include/asm-x86_64/poll.h	2003-07-08 21:43:45.000000000 +0100
+++ pollrdonce-2.5.75/include/asm-x86_64/poll.h	2003-07-13 22:35:21.000000000 +0100
@@ -16,6 +16,7 @@
 #define POLLWRBAND	0x0200
 #define POLLMSG		0x0400
 #define POLLREMOVE	0x1000
+#define POLLRDONCE	0x2000
 
 struct pollfd {
 	int fd;
diff -ur orig-2.5.75/net/ipv4/tcp.c pollrdonce-2.5.75/net/ipv4/tcp.c
--- orig-2.5.75/net/ipv4/tcp.c	2003-07-08 21:54:33.000000000 +0100
+++ pollrdonce-2.5.75/net/ipv4/tcp.c	2003-07-14 02:19:16.000000000 +0100
@@ -206,6 +206,7 @@
  *					lingertime == 0 (RFC 793 ABORT Call)
  *	Hirokazu Takahashi	:	Use copy_from_user() instead of
  *					csum_and_copy_from_user() if possible.
+ *		Jamie Lokier	:	Added POLLRDONCE.
  *
  *		This program is free software; you can redistribute it and/or
  *		modify it under the terms of the GNU General Public License
@@ -426,22 +427,39 @@
 	 *
 	 * NOTE. Check for TCP_CLOSE is added. The goal is to prevent
 	 * blocking on fresh not-connected or disconnected socket. --ANK
+	 *
+	 * NOTE. POLLRDONCE will be set _only_ if multiple read/recvmsg
+	 * calls are not required before the next edge-triggered epoll
+	 * wakeup.  Typically multiple calls are needed when data+EOF is
+	 * pending; then the first read() is not enough to re-arm the
+	 * POLLIN event.     -- Jamie Lokier
 	 */
 	if (sk->sk_shutdown == SHUTDOWN_MASK || sk->sk_state == TCP_CLOSE)
 		mask |= POLLHUP;
+	/*
+	 * RCV_SHUTDOWN is always set when an EOF condition becomes pending.
+	 */
 	if (sk->sk_shutdown & RCV_SHUTDOWN)
 		mask |= POLLIN | POLLRDNORM;
 
 	/* Connected? */
 	if ((1 << sk->sk_state) & ~(TCPF_SYN_SENT | TCPF_SYN_RECV)) {
+
+		if (tp->urg_data & TCP_URG_VALID)
+			mask |= POLLPRI;
+
 		/* Potential race condition. If read of tp below will
 		 * escape above sk->sk_state, we can be illegally awaken
 		 * in SYN_* states. */
 		if ((tp->rcv_nxt != tp->copied_seq) &&
 		    (tp->urg_seq != tp->copied_seq ||
 		     tp->rcv_nxt != tp->copied_seq + 1 ||
-		     sock_flag(sk, SOCK_URGINLINE) || !tp->urg_data))
-			mask |= POLLIN | POLLRDNORM;
+		     sock_flag(sk, SOCK_URGINLINE) || !tp->urg_data)) {
+			if (mask == 0 && sk->sk_rcvlowat == INT_MAX)
+				mask = POLLIN | POLLRDNORM | POLLRDONCE;
+			else
+				mask |= POLLIN | POLLRDNORM;
+		}
 
 		if (!(sk->sk_shutdown & SEND_SHUTDOWN)) {
 			if (tcp_wspace(sk) >= tcp_min_write_space(sk)) {
@@ -459,9 +477,6 @@
 					mask |= POLLOUT | POLLWRNORM;
 			}
 		}
-
-		if (tp->urg_data & TCP_URG_VALID)
-			mask |= POLLPRI;
 	}
 	return mask;
 }
diff -ur orig-2.5.75/net/unix/af_unix.c pollrdonce-2.5.75/net/unix/af_unix.c
--- orig-2.5.75/net/unix/af_unix.c	2003-07-12 17:57:39.000000000 +0100
+++ pollrdonce-2.5.75/net/unix/af_unix.c	2003-07-14 02:33:25.000000000 +0100
@@ -50,6 +50,7 @@
  *	     Arnaldo C. Melo	:	Remove MOD_{INC,DEC}_USE_COUNT,
  *	     				the core infrastructure is doing that
  *	     				for all net proto families now (2.5.69+)
+ *		Jamie Lokier	:	Added POLLRDONCE.
  *
  *
  * Known differences from reference BSD that was tested:
@@ -1784,15 +1785,21 @@
 	if (sk->sk_shutdown == SHUTDOWN_MASK)
 		mask |= POLLHUP;
 
-	/* readable? */
-	if (!skb_queue_empty(&sk->sk_receive_queue) ||
-	    (sk->sk_shutdown & RCV_SHUTDOWN))
-		mask |= POLLIN | POLLRDNORM;
-
 	/* Connection-based need to check for termination and startup */
 	if (sk->sk_type == SOCK_STREAM && sk->sk_state == TCP_CLOSE)
 		mask |= POLLHUP;
 
+	/* readable? */
+	if ((sk->sk_shutdown & RCV_SHUTDOWN))
+		mask |= POLLIN | POLLRDNORM;
+	else if (!skb_queue_empty(&sk->sk_receive_queue)) {
+		if (mask == 0 && sk->sk_type == SOCK_STREAM
+		    && sk->sk_rcvlowat == INT_MAX)
+			mask = POLLIN | POLLRDNORM | POLLRDONCE;
+		else
+			mask |= POLLIN | POLLRDNORM;
+	}
+
 	/*
 	 * we set writable also when the other side has shut down the
 	 * connection. This prevents stuck sockets.
