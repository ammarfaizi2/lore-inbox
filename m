Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261259AbUKSDNp@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261259AbUKSDNp (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 18 Nov 2004 22:13:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261263AbUKSDNo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 18 Nov 2004 22:13:44 -0500
Received: from mx1.redhat.com ([66.187.233.31]:42442 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S261259AbUKSDMY (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 18 Nov 2004 22:12:24 -0500
Date: Thu, 18 Nov 2004 22:12:13 -0500 (EST)
From: James Morris <jmorris@redhat.com>
X-X-Sender: jmorris@thoron.boston.redhat.com
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
cc: Ross Kendall Axe <ross.axe@blueyonder.co.uk>, <netdev@oss.sgi.com>,
       Stephen Smalley <sds@epoch.ncsc.mil>,
       lkml <linux-kernel@vger.kernel.org>, Chris Wright <chrisw@osdl.org>,
       "David S. Miller" <davem@davemloft.net>
Subject: Re: [PATCH] linux 2.9.10-rc1: Fix oops in unix_dgram_sendmsg when
 using SELinux and SOCK_SEQPACKET
In-Reply-To: <1100821144.6005.40.camel@localhost.localdomain>
Message-ID: <Xine.LNX.4.44.0411182207080.7831-100000@thoron.boston.redhat.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 18 Nov 2004, Alan Cox wrote:

> As to the other stuff I think the only change needed is to check the
> queued asynchronous error and report that before going on to the
> connected test

How about this?

(Also now ignores any supplied address per 
http://www.opengroup.org/onlinepubs/009695399/functions/sendto.html)


---

Signed-off-by: James Morris <jmorris@redhat.com>

diff -purN -X dontdiff linux-2.6.10-rc2.o/net/unix/af_unix.c linux-2.6.10-rc2.w3/net/unix/af_unix.c
--- linux-2.6.10-rc2.o/net/unix/af_unix.c	2004-11-15 13:18:56.000000000 -0500
+++ linux-2.6.10-rc2.w3/net/unix/af_unix.c	2004-11-18 21:54:12.650029672 -0500
@@ -466,6 +466,8 @@ static int unix_dgram_recvmsg(struct kio
 			      struct msghdr *, size_t, int);
 static int unix_dgram_connect(struct socket *, struct sockaddr *,
 			      int, int);
+static int unix_seqpacket_sendmsg(struct kiocb *, struct socket *,
+				  struct msghdr *, size_t);
 
 static struct proto_ops unix_stream_ops = {
 	.family =	PF_UNIX,
@@ -524,7 +526,7 @@ static struct proto_ops unix_seqpacket_o
 	.shutdown =	unix_shutdown,
 	.setsockopt =	sock_no_setsockopt,
 	.getsockopt =	sock_no_getsockopt,
-	.sendmsg =	unix_dgram_sendmsg,
+	.sendmsg =	unix_seqpacket_sendmsg,
 	.recvmsg =	unix_dgram_recvmsg,
 	.mmap =		sock_no_mmap,
 	.sendpage =	sock_no_sendpage,
@@ -1354,9 +1356,11 @@ restart:
 	if (other->sk_shutdown & RCV_SHUTDOWN)
 		goto out_unlock;
 
-	err = security_unix_may_send(sk->sk_socket, other->sk_socket);
-	if (err)
-		goto out_unlock;
+	if (sk->sk_type != SOCK_SEQPACKET) {
+		err = security_unix_may_send(sk->sk_socket, other->sk_socket);
+		if (err)
+			goto out_unlock;
+	}
 
 	if (unix_peer(other) != sk &&
 	    (skb_queue_len(&other->sk_receive_queue) >
@@ -1506,6 +1510,25 @@ out_err:
 	return sent ? : err;
 }
 
+static int unix_seqpacket_sendmsg(struct kiocb *kiocb, struct socket *sock,
+				  struct msghdr *msg, size_t len)
+{
+	int err;
+	struct sock *sk = sock->sk;
+	
+	err = sock_error(sk);
+	if (err)
+		return err;
+
+	if (sk->sk_state != TCP_ESTABLISHED)
+		return -ENOTCONN;
+
+	if (msg->msg_namelen)
+		msg->msg_namelen = 0;
+
+	return unix_dgram_sendmsg(kiocb, sock, msg, len);
+}
+                                                                                            
 static void unix_copy_addr(struct msghdr *msg, struct sock *sk)
 {
 	struct unix_sock *u = unix_sk(sk);



