Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262901AbTJYVok (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 25 Oct 2003 17:44:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262921AbTJYVok
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 25 Oct 2003 17:44:40 -0400
Received: from hera.cwi.nl ([192.16.191.8]:62963 "EHLO hera.cwi.nl")
	by vger.kernel.org with ESMTP id S262901AbTJYVoi (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 25 Oct 2003 17:44:38 -0400
From: Andries.Brouwer@cwi.nl
Date: Sat, 25 Oct 2003 23:44:19 +0200 (MEST)
Message-Id: <UTC200310252144.h9PLiJ502790.aeb@smtp.cwi.nl>
To: davem@redhat.com
Subject: [patch] posix compliance for send(to)
Cc: linux-kernel@vger.kernel.org, netdev@oss.sgi.com
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

POSIX 1003.1-2001, 2003 edition
(see http://www.opengroup.org/onlinepubs/007904975/toc.htm)
says about send():

  The send() function shall send a message only
  when the socket is connected

and gives the error returns

[ENOTCONN]
  The socket is not connected or otherwise has not had the peer
  pre-specified.
[EPIPE]
  The socket is shut down for writing, or the socket is connection-mode
  and is no longer connected. In the latter case, and if the socket is of
  type SOCK_STREAM, the SIGPIPE signal is generated to the calling thread.

However, currently (2.6.0-test6) I see EPIPE and SIGPIPE
for a send() on a fresh, non-connected socket.

I suppose the below patch fixes this, but have not checked
details of the state machine.

Andries

diff -u --recursive --new-file -X /linux/dontdiff a/net/ipv4/tcp.c b/net/ipv4/tcp.c
--- a/net/ipv4/tcp.c	Mon Jun 23 04:44:14 2003
+++ b/net/ipv4/tcp.c	Sat Oct 25 22:46:44 2003
@@ -1044,6 +1044,10 @@
 	flags = msg->msg_flags;
 	timeo = sock_sndtimeo(sk, flags & MSG_DONTWAIT);
 
+	err = -ENOTCONN;
+	if (sk->sk_state == TCP_CLOSE && !sock_flag(sk, SOCK_DONE))
+		goto out_err;
+
 	/* Wait for a connection to finish. */
 	if ((1 << sk->sk_state) & ~(TCPF_ESTABLISHED | TCPF_CLOSE_WAIT))
 		if ((err = wait_for_tcp_connect(sk, flags, &timeo)) != 0)
