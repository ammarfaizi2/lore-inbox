Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261469AbUKSQZJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261469AbUKSQZJ (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 19 Nov 2004 11:25:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261460AbUKSQY7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 19 Nov 2004 11:24:59 -0500
Received: from mx1.redhat.com ([66.187.233.31]:61877 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S261472AbUKSQYU (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 19 Nov 2004 11:24:20 -0500
Date: Fri, 19 Nov 2004 11:24:03 -0500 (EST)
From: James Morris <jmorris@redhat.com>
X-X-Sender: jmorris@thoron.boston.redhat.com
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
cc: Ross Kendall Axe <ross.axe@blueyonder.co.uk>, <netdev@oss.sgi.com>,
       Stephen Smalley <sds@epoch.ncsc.mil>,
       lkml <linux-kernel@vger.kernel.org>, Chris Wright <chrisw@osdl.org>,
       "David S. Miller" <davem@davemloft.net>
Subject: Re: [PATCH] linux 2.9.10-rc1: Fix oops in unix_dgram_sendmsg when
 using SELinux and SOCK_SEQPACKET
In-Reply-To: <1100864358.8127.5.camel@localhost.localdomain>
Message-ID: <Xine.LNX.4.44.0411191122470.10340-100000@thoron.boston.redhat.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 19 Nov 2004, Alan Cox wrote:

> Looks right to me, the ECONNRESET is no longer being lost.

Ok, here is a relative patch for Dave.

Please apply.

Signed-off-by: James Morris <jmorris@redhat.com>

---

diff -purN -X dontdiff linux-2.6.10-rc2.w2/net/unix/af_unix.c linux-2.6.10-rc2.w3/net/unix/af_unix.c
--- linux-2.6.10-rc2.w2/net/unix/af_unix.c	2004-11-18 12:09:44.000000000 -0500
+++ linux-2.6.10-rc2.w3/net/unix/af_unix.c	2004-11-18 21:54:12.000000000 -0500
@@ -1513,13 +1513,18 @@ out_err:
 static int unix_seqpacket_sendmsg(struct kiocb *kiocb, struct socket *sock,
 				  struct msghdr *msg, size_t len)
 {
+	int err;
 	struct sock *sk = sock->sk;
 	
+	err = sock_error(sk);
+	if (err)
+		return err;
+
 	if (sk->sk_state != TCP_ESTABLISHED)
 		return -ENOTCONN;
 
-	if (msg->msg_name || msg->msg_namelen)
-		return -EINVAL;
+	if (msg->msg_namelen)
+		msg->msg_namelen = 0;
 
 	return unix_dgram_sendmsg(kiocb, sock, msg, len);
 }

