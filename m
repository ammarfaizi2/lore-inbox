Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S272170AbRHWK4q>; Thu, 23 Aug 2001 06:56:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S272229AbRHWK4g>; Thu, 23 Aug 2001 06:56:36 -0400
Received: from mailrelay.inpharmatica.co.uk ([193.115.214.5]:53006 "EHLO
	gallions-reach.inpharmatica.co.uk") by vger.kernel.org with ESMTP
	id <S272170AbRHWK4W>; Thu, 23 Aug 2001 06:56:22 -0400
Message-ID: <3B84E143.1030806@purplet.demon.co.uk>
Date: Thu, 23 Aug 2001 11:56:03 +0100
From: Mike Jagdis <jaggy@purplet.demon.co.uk>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:0.9.3) Gecko/20010801
X-Accept-Language: en, fr, de
MIME-Version: 1.0
To: David Schwartz <davids@webmaster.com>,
        Linus Torvalds <torvalds@transmeta.com>,
        Alan Cox <alan@lxorguk.ukuu.org.uk>
CC: linux-kernel@vger.kernel.org
Subject: [PATCH] select() says closed socket readable
In-Reply-To: <NOEJJDACGOHCKNCOGFOMAECLDGAA.davids@webmaster.com>
Content-Type: multipart/mixed;
 boundary="------------030702060801020906080904"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------030702060801020906080904
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit

Whoa! It isn't that select/poll is saying that a read wouldn't
block. It's saying that the socket has been hung up (POLLHUP
not POLLIN)! This is even worse - POLLHUP is always tested
for even of the user didn't ask for it. So if an unconnected
socket appears _anywhere_ in a select or poll we are heading
for spin city, regardless of whether we asked for read, write,
errors or even nothing (in the case of poll)!

Older Linux kernels (2.2.18 at least) blocked on unconnected
TCP sockets but returned POLLHUP on unix sockets. Current
kernels return POLLHUP in both cases. It looks like TCP was
fixed to match unix instead of vice-versa.

A quick poll (<grin>) of available machines here show that
both Sun and FreeBSD block for both TCP and unix unconnected
sockets.

The attached patch _should_ be applied :-).

				Mike

--------------030702060801020906080904
Content-Type: text/plain;
 name="poll.diff"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="poll.diff"

--- linux.old/net/ipv4/tcp.c	Fri Jul  6 13:50:00 2001
+++ linux/net/ipv4/tcp.c	Thu Aug 23 11:29:15 2001
@@ -415,11 +415,8 @@
 	 * then we could set it on SND_SHUTDOWN. BTW examples given
 	 * in Stevens' books assume exactly this behaviour, it explains
 	 * why PULLHUP is incompatible with POLLOUT.	--ANK
-	 *
-	 * NOTE. Check for TCP_CLOSE is added. The goal is to prevent
-	 * blocking on fresh not-connected or disconnected socket. --ANK
 	 */
-	if (sk->shutdown == SHUTDOWN_MASK || sk->state == TCP_CLOSE)
+	if (sk->shutdown == SHUTDOWN_MASK)
 		mask |= POLLHUP;
 	if (sk->shutdown & RCV_SHUTDOWN)
 		mask |= POLLIN | POLLRDNORM;
--- linux.old/net/unix/af_unix.c	Tue Jul 24 21:32:01 2001
+++ linux/net/unix/af_unix.c	Thu Aug 23 11:31:58 2001
@@ -1711,8 +1711,8 @@
 	if (!skb_queue_empty(&sk->receive_queue) || (sk->shutdown&RCV_SHUTDOWN))
 		mask |= POLLIN | POLLRDNORM;
 
-	/* Connection-based need to check for termination and startup */
-	if (sk->type == SOCK_STREAM && sk->state==TCP_CLOSE)
+	/* Connection-based need to check for termination */
+	if (sk->type == SOCK_STREAM)
 		mask |= POLLHUP;
 
 	/*

--------------030702060801020906080904--

