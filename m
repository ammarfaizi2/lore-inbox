Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262424AbUJ0NEq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262424AbUJ0NEq (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 27 Oct 2004 09:04:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262429AbUJ0NEq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 27 Oct 2004 09:04:46 -0400
Received: from fep03fe.ttnet.net.tr ([212.156.4.134]:56532 "EHLO
	fep03.ttnet.net.tr") by vger.kernel.org with ESMTP id S262424AbUJ0NBB
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 27 Oct 2004 09:01:01 -0400
Message-ID: <417F9BA2.20602@ttnet.net.tr>
Date: Wed, 27 Oct 2004 15:59:14 +0300
From: "O.Sezer" <sezeroz@ttnet.net.tr>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.4.3) Gecko/20041003
X-Accept-Language: tr, en-us, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
CC: marcelo.tosatti@cyclades.com
Subject: 2.4.28-rc1, more lost patches [1/10]
Content-Type: multipart/mixed;
	boundary="------------040403040708010404000806"
X-ESAFE-STATUS: Mail clean
X-ESAFE-DETAILS: Clean
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------040403040708010404000806
Content-Type: text/plain;
	charset=us-ascii;
	format=flowed
Content-Transfer-Encoding: 7bit


(Resending to fix binary attachment)

[10/10] Krzysztof Halasa: AF_UNIX dgram select problem;
from (only in) -ac/redhat. To be reviewed.



--------------040403040708010404000806
Content-Type: text/plain;
	name="af_unix-dgram_poll.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
	filename="af_unix-dgram_poll.patch"

Krzysztof Halasa
first discussion/thread:
 http://marc.theaimsgroup.com/?t=105465240900005&r=1&w=2
Patch then posted at:
 http://marc.theaimsgroup.com/?l=linux-kernel&m=105560475819610&w=2

No further discussion seems to appear thereafter.

only in ac/redhat, _NOT_ in 2.6

diff -urN 28rc1/net/unix/af_unix.c 28rc1_aac/net/unix/af_unix.c
--- 28rc1/net/unix/af_unix.c	2002-11-29 01:53:16.000000000 +0200
+++ 28rc1_aac/net/unix/af_unix.c	2004-10-24 00:58:12.000000000 +0300
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

--------------040403040708010404000806--
