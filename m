Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265678AbTFNPRG (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 14 Jun 2003 11:17:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265680AbTFNPRG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 14 Jun 2003 11:17:06 -0400
Received: from hq.pm.waw.pl ([195.116.170.10]:62600 "EHLO hq.pm.waw.pl")
	by vger.kernel.org with ESMTP id S265678AbTFNPQ5 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 14 Jun 2003 11:16:57 -0400
To: <linux-kernel@vger.kernel.org>
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>, Andrea Arcangeli <andrea@suse.de>
Subject: [PATCH] select for UNIX sockets - 2.4 and 2.5
From: Krzysztof Halasa <khc@pm.waw.pl>
Date: 14 Jun 2003 17:29:43 +0200
Message-ID: <m3he6sd6e0.fsf@defiant.pm.waw.pl>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="=-=-="
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--=-=-=

Hi,

The attached patches aims to fix select(write) on connect()ed UNIX
datagram sockets. Without this patch, such select() is basically a NOP
i.e. it returns immediately indicating a datagram can be written.

As I don't know this part of the kernel very well I'd appreciate it if
you who know it better check the patch for correctness.

A simple test program is attached as well.

This patch doesn't fix select(write) on unconnect()ed sockets as there
is no obvious way to check for socket state.
-- 
Krzysztof Halasa
Network Administrator

--=-=-=
Content-Type: text/x-patch
Content-Disposition: attachment; filename=dgram-sockets-2.4.patch

--- linux-2.4.orig/net/unix/af_unix.c	2002-11-29 00:53:16.000000000 +0100
+++ linux-2.4/net/unix/af_unix.c	2003-06-14 17:04:26.000000000 +0200
@@ -1707,6 +1707,39 @@
 	return err;
 }
 
+static unsigned int dgram_poll(struct file * file, struct socket *sock,
+			       poll_table *wait)
+{
+        struct sock *sk = sock->sk;
+        unsigned int mask;
+	unix_socket *other;
+
+        poll_wait(file, sk->sleep, wait);
+        mask = 0;
+
+        /* exceptional events? */
+        if (sk->err || !skb_queue_empty(&sk->error_queue))
+                mask |= POLLERR;
+        if (sk->shutdown == SHUTDOWN_MASK)
+                mask |= POLLHUP;
+
+        /* readable? */
+        if (!skb_queue_empty(&sk->receive_queue) ||
+            (sk->shutdown & RCV_SHUTDOWN))
+                mask |= POLLIN | POLLRDNORM;
+
+        /* writable? */
+	other = unix_peer_get(sk);
+	if (sock_writeable(sk) &&
+	    (other == NULL ||
+	     skb_queue_len(&other->receive_queue) <= other->max_ack_backlog))
+                mask |= POLLOUT | POLLWRNORM | POLLWRBAND;
+        else
+                set_bit(SOCK_ASYNC_NOSPACE, &sk->socket->flags);
+
+	return mask;
+}
+
 static unsigned int unix_poll(struct file * file, struct socket *sock, poll_table *wait)
 {
 	struct sock *sk = sock->sk;
@@ -1836,7 +1869,7 @@
 	socketpair:	unix_socketpair,
 	accept:		sock_no_accept,
 	getname:	unix_getname,
-	poll:		datagram_poll,
+	poll:		dgram_poll,
 	ioctl:		unix_ioctl,
 	listen:		sock_no_listen,
 	shutdown:	unix_shutdown,

--=-=-=
Content-Type: text/x-patch
Content-Disposition: attachment; filename=dgram-sockets-2.5.patch

--- linux-2.5.orig/net/unix/af_unix.c	2003-05-27 03:00:41.000000000 +0200
+++ linux-2.5/net/unix/af_unix.c	2003-06-14 16:31:59.000000000 +0200
@@ -1784,6 +1784,39 @@
 	return err;
 }
 
+static unsigned int dgram_poll(struct file * file, struct socket *sock,
+			       poll_table *wait)
+{
+        struct sock *sk = sock->sk;
+        unsigned int mask;
+	unix_socket *other;
+
+        poll_wait(file, sk->sleep, wait);
+        mask = 0;
+
+        /* exceptional events? */
+        if (sk->err || !skb_queue_empty(&sk->error_queue))
+                mask |= POLLERR;
+        if (sk->shutdown == SHUTDOWN_MASK)
+                mask |= POLLHUP;
+
+        /* readable? */
+        if (!skb_queue_empty(&sk->receive_queue) ||
+            (sk->shutdown & RCV_SHUTDOWN))
+                mask |= POLLIN | POLLRDNORM;
+
+        /* writable? */
+	other = unix_peer_get(sk);
+	if (sock_writeable(sk) &&
+	    (other == NULL ||
+	     skb_queue_len(&other->receive_queue) <= other->max_ack_backlog))
+                mask |= POLLOUT | POLLWRNORM | POLLWRBAND;
+        else
+                set_bit(SOCK_ASYNC_NOSPACE, &sk->socket->flags);
+
+	return mask;
+}
+
 static unsigned int unix_poll(struct file * file, struct socket *sock, poll_table *wait)
 {
 	struct sock *sk = sock->sk;
@@ -1913,7 +1946,7 @@
 	.socketpair =	unix_socketpair,
 	.accept =	sock_no_accept,
 	.getname =	unix_getname,
-	.poll =		datagram_poll,
+	.poll =		dgram_poll,
 	.ioctl =	unix_ioctl,
 	.listen =	sock_no_listen,
 	.shutdown =	unix_shutdown,

--=-=-=
Content-Type: application/octet-stream
Content-Disposition: attachment; filename=sockets.c

#include <unistd.h>
#include <stdio.h>
#include <stdlib.h>
#include <sys/types.h>
#include <sys/socket.h>
#include <sys/un.h>
#include <fcntl.h>

#define DEST_SOCKET "/tmp/test"
#define CONNECT_FIRST 1
#define DEBUG 0

void sender()
{
	int fd;
	struct sockaddr_un addr;
	int addr_len;
	char datagram[1];
	fd_set set;

	fd = socket(PF_UNIX, SOCK_DGRAM, 0);
	if (fd < 0)
		perror("sender's socket() failed");

	addr.sun_family = AF_UNIX;
	strcpy(addr.sun_path, DEST_SOCKET);
	addr_len = sizeof(addr.sun_family) + strlen(addr.sun_path);

	sleep(1);

#if CONNECT_FIRST
	if (connect(fd, (struct sockaddr*)&addr, addr_len) < 0)
		perror("sender's connect failed");
#endif
	while(1) {
		FD_ZERO(&set);
		FD_SET(fd, &set);

		if (select(fd + 1, NULL, &set, NULL, NULL) < 0)
			perror("sender's select() failed");
		if (FD_ISSET(fd, &set)) {
#if DEBUG
			fprintf(stderr, "Sending...");
#endif
#if CONNECT_FIRST
			if (send(fd, &datagram, sizeof(datagram), 0) < 0)
				perror("\nsend() failed");
#else
			if (sendto(fd, &datagram, sizeof(datagram), 0,
				   (struct sockaddr*)&addr, addr_len) < 0)
				perror("\nsendto() failed");
#endif
#if DEBUG
			fprintf(stderr, "\n");
#endif
		}
	}
}


void receiver()
{

	int fd;
	struct sockaddr_un addr;
	int addr_len;
	char datagram[2000];

	fd = socket(PF_UNIX, SOCK_DGRAM, 0);
	if (fd < 0)
		perror("socket failed");

	addr.sun_family = AF_UNIX;
	strcpy(addr.sun_path, DEST_SOCKET);
	addr_len = sizeof(addr.sun_family) + strlen(addr.sun_path);
	if (bind(fd, (struct sockaddr*)&addr, addr_len) < 0)
		perror("receiver's bind() failed");

	while(1) {
		int i, size;
		sleep(10);

		for (i = 0; i < 5; i++) {
			size = recvfrom(fd, &datagram, sizeof(datagram), 0,
					NULL, NULL);
			if (size < 0)
				perror("recv failed");
#if DEBUG
			else
				fprintf(stderr, "recv %i byte(s)\n", size);
#endif
		}
	}
}


int main()
{
	unlink(DEST_SOCKET);

	int result = fork();
	if (result < 0) {
		perror("fork failed");
		exit(1);
	} else if (result == 0)
		receiver();
	else
		sender();

	exit(0);
}


--=-=-=--
