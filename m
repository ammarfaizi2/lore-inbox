Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262176AbUFEV41@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262176AbUFEV41 (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 5 Jun 2004 17:56:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262138AbUFEV41
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 5 Jun 2004 17:56:27 -0400
Received: from mx1.redhat.com ([66.187.233.31]:45495 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S262101AbUFEV4B (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 5 Jun 2004 17:56:01 -0400
Date: Sat, 5 Jun 2004 14:53:33 -0700
From: "David S. Miller" <davem@redhat.com>
To: Andreas Schwab <schwab@suse.de>
Cc: olh@suse.de, linux-kernel@vger.kernel.org, netdev@oss.sgi.com
Subject: Re: [PATCH] compat bug in sys_recvmsg, MSG_CMSG_COMPAT check
 missing
Message-Id: <20040605145333.11c80173.davem@redhat.com>
In-Reply-To: <jen03h7k45.fsf@sykes.suse.de>
References: <20040605204334.GA1134@suse.de>
	<20040605140153.6c5945a0.davem@redhat.com>
	<20040605140544.0de4034d.davem@redhat.com>
	<jer7st7lam.fsf@sykes.suse.de>
	<20040605143649.3fd6c22b.davem@redhat.com>
	<jen03h7k45.fsf@sykes.suse.de>
X-Mailer: Sylpheed version 0.9.11 (GTK+ 1.2.10; sparc-unknown-linux-gnu)
X-Face: "_;p5u5aPsO,_Vsx"^v-pEq09'CU4&Dc1$fQExov$62l60cgCc%FnIwD=.UF^a>?5'9Kn[;433QFVV9M..2eN.@4ZWPGbdi<=?[:T>y?SD(R*-3It"Vj:)"dP
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 05 Jun 2004 23:47:22 +0200
Andreas Schwab <schwab@suse.de> wrote:

> > Olaf's patch, it said:
> >
> > -	if (flags & ~(MSG_PEEK|MSG_DONTWAIT|MSG_TRUNC))
> > +	if (flags & ~(MSG_PEEK|MSG_DONTWAIT|MSG_TRUNC|MSG_CMSG_COMPAT))
> 
> Yes, and where is the problem?

If MSG_CMSG_COMPAT is "ZERO", which it will be if CONFIG_COMPAT is
not set, then "~0" is all bits, therefore if any bit (even the ones
we want to accept) is set we will return failure.  The test ends
up amounting to:

	if (flags & ~0)

which is true if any bit is set, that's not what we want.

Anyways, I'm going to fix the bug like so:

# This is a BitKeeper generated diff -Nru style patch.
#
# ChangeSet
#   2004/06/05 14:52:04-07:00 davem@nuts.davemloft.net 
#   [NET]: Fix bogus msg_flags checks, need to mask out MSG_CMSG_COMPAT.
# 
# net/wanrouter/af_wanpipe.c
#   2004/06/05 14:51:43-07:00 davem@nuts.davemloft.net +1 -1
#   [NET]: Fix bogus msg_flags checks, need to mask out MSG_CMSG_COMPAT.
# 
# net/netrom/af_netrom.c
#   2004/06/05 14:51:43-07:00 davem@nuts.davemloft.net +1 -1
#   [NET]: Fix bogus msg_flags checks, need to mask out MSG_CMSG_COMPAT.
# 
# net/econet/af_econet.c
#   2004/06/05 14:51:43-07:00 davem@nuts.davemloft.net +1 -1
#   [NET]: Fix bogus msg_flags checks, need to mask out MSG_CMSG_COMPAT.
# 
# net/decnet/af_decnet.c
#   2004/06/05 14:51:43-07:00 davem@nuts.davemloft.net +2 -1
#   [NET]: Fix bogus msg_flags checks, need to mask out MSG_CMSG_COMPAT.
# 
# net/x25/af_x25.c
#   2004/06/05 14:51:42-07:00 davem@nuts.davemloft.net +2 -1
#   [NET]: Fix bogus msg_flags checks, need to mask out MSG_CMSG_COMPAT.
# 
# net/rose/af_rose.c
#   2004/06/05 14:51:42-07:00 davem@nuts.davemloft.net +1 -1
#   [NET]: Fix bogus msg_flags checks, need to mask out MSG_CMSG_COMPAT.
# 
# net/packet/af_packet.c
#   2004/06/05 14:51:42-07:00 davem@nuts.davemloft.net +1 -1
#   [NET]: Fix bogus msg_flags checks, need to mask out MSG_CMSG_COMPAT.
# 
# net/key/af_key.c
#   2004/06/05 14:51:42-07:00 davem@nuts.davemloft.net +1 -1
#   [NET]: Fix bogus msg_flags checks, need to mask out MSG_CMSG_COMPAT.
# 
# net/irda/af_irda.c
#   2004/06/05 14:51:42-07:00 davem@nuts.davemloft.net +3 -3
#   [NET]: Fix bogus msg_flags checks, need to mask out MSG_CMSG_COMPAT.
# 
# net/ipx/af_ipx.c
#   2004/06/05 14:51:42-07:00 davem@nuts.davemloft.net +1 -1
#   [NET]: Fix bogus msg_flags checks, need to mask out MSG_CMSG_COMPAT.
# 
# net/ax25/af_ax25.c
#   2004/06/05 14:51:42-07:00 davem@nuts.davemloft.net +1 -2
#   [NET]: Fix bogus msg_flags checks, need to mask out MSG_CMSG_COMPAT.
# 
# net/appletalk/ddp.c
#   2004/06/05 14:51:42-07:00 davem@nuts.davemloft.net +1 -1
#   [NET]: Fix bogus msg_flags checks, need to mask out MSG_CMSG_COMPAT.
# 
# include/linux/socket.h
#   2004/06/05 14:51:42-07:00 davem@nuts.davemloft.net +2 -0
#   [NET]: Fix bogus msg_flags checks, need to mask out MSG_CMSG_COMPAT.
# 
diff -Nru a/include/linux/socket.h b/include/linux/socket.h
--- a/include/linux/socket.h	2004-06-05 14:53:34 -07:00
+++ b/include/linux/socket.h	2004-06-05 14:53:34 -07:00
@@ -241,8 +241,10 @@
 
 #if defined(CONFIG_COMPAT)
 #define MSG_CMSG_COMPAT	0x80000000	/* This message needs 32 bit fixups */
+#define MSG_FLAGS_USER(X)	((X) & ~MSG_CMSG_COMPAT)
 #else
 #define MSG_CMSG_COMPAT	0		/* We never have 32 bit fixups */
+#define MSG_FLAGS_USER(X)	(X)
 #endif
 
 
diff -Nru a/net/appletalk/ddp.c b/net/appletalk/ddp.c
--- a/net/appletalk/ddp.c	2004-06-05 14:53:35 -07:00
+++ b/net/appletalk/ddp.c	2004-06-05 14:53:35 -07:00
@@ -1567,7 +1567,7 @@
 	struct atalk_route *rt;
 	int err;
 
-	if (flags & ~MSG_DONTWAIT)
+	if (MSG_FLAGS_USER(flags) & ~MSG_DONTWAIT)
 		return -EINVAL;
 
 	if (len > DDP_MAXSZ)
diff -Nru a/net/ax25/af_ax25.c b/net/ax25/af_ax25.c
--- a/net/ax25/af_ax25.c	2004-06-05 14:53:34 -07:00
+++ b/net/ax25/af_ax25.c	2004-06-05 14:53:34 -07:00
@@ -1413,9 +1413,8 @@
 	size_t size;
 	int lv, err, addr_len = msg->msg_namelen;
 
-	if (msg->msg_flags & ~(MSG_DONTWAIT|MSG_EOR)) {
+	if (MSG_FLAGS_USER(msg->msg_flags) & ~(MSG_DONTWAIT|MSG_EOR))
 		return -EINVAL;
-	}
 
 	lock_sock(sk);
 	ax25 = ax25_sk(sk);
diff -Nru a/net/decnet/af_decnet.c b/net/decnet/af_decnet.c
--- a/net/decnet/af_decnet.c	2004-06-05 14:53:34 -07:00
+++ b/net/decnet/af_decnet.c	2004-06-05 14:53:34 -07:00
@@ -1905,7 +1905,8 @@
 	unsigned char fctype;
 	long timeo = sock_sndtimeo(sk, flags & MSG_DONTWAIT);
 
-	if (flags & ~(MSG_TRYHARD|MSG_OOB|MSG_DONTWAIT|MSG_EOR|MSG_NOSIGNAL|MSG_MORE))
+	if (MSG_FLAGS_USER(flags) &
+	    ~(MSG_TRYHARD|MSG_OOB|MSG_DONTWAIT|MSG_EOR|MSG_NOSIGNAL|MSG_MORE))
 		return -EOPNOTSUPP;
 
 	if (addr_len && (addr_len != sizeof(struct sockaddr_dn)))
diff -Nru a/net/econet/af_econet.c b/net/econet/af_econet.c
--- a/net/econet/af_econet.c	2004-06-05 14:53:34 -07:00
+++ b/net/econet/af_econet.c	2004-06-05 14:53:34 -07:00
@@ -274,7 +274,7 @@
 	 *	Check the flags. 
 	 */
 
-	if (msg->msg_flags&~MSG_DONTWAIT) 
+	if (MSG_FLAGS_USER(msg->msg_flags) & ~MSG_DONTWAIT) 
 		return(-EINVAL);
 
 	/*
diff -Nru a/net/ipx/af_ipx.c b/net/ipx/af_ipx.c
--- a/net/ipx/af_ipx.c	2004-06-05 14:53:34 -07:00
+++ b/net/ipx/af_ipx.c	2004-06-05 14:53:34 -07:00
@@ -1695,7 +1695,7 @@
 	/* Socket gets bound below anyway */
 /*	if (sk->sk_zapped)
 		return -EIO; */	/* Socket not bound */
-	if (flags & ~MSG_DONTWAIT)
+	if (MSG_FLAGS_USER(flags) & ~MSG_DONTWAIT)
 		goto out;
 
 	/* Max possible packet size limited by 16 bit pktsize in header */
diff -Nru a/net/irda/af_irda.c b/net/irda/af_irda.c
--- a/net/irda/af_irda.c	2004-06-05 14:53:34 -07:00
+++ b/net/irda/af_irda.c	2004-06-05 14:53:34 -07:00
@@ -1269,7 +1269,7 @@
 	IRDA_DEBUG(4, "%s(), len=%d\n", __FUNCTION__, len);
 
 	/* Note : socket.c set MSG_EOR on SEQPACKET sockets */
-	if (msg->msg_flags & ~(MSG_DONTWAIT | MSG_EOR))
+	if (MSG_FLAGS_USER(msg->msg_flags) & ~(MSG_DONTWAIT | MSG_EOR))
 		return -EINVAL;
 
 	if (sk->sk_shutdown & SEND_SHUTDOWN) {
@@ -1521,7 +1521,7 @@
 
 	IRDA_DEBUG(4, "%s(), len=%d\n", __FUNCTION__, len);
 
-	if (msg->msg_flags & ~MSG_DONTWAIT)
+	if (MSG_FLAGS_USER(msg->msg_flags) & ~MSG_DONTWAIT)
 		return -EINVAL;
 
 	if (sk->sk_shutdown & SEND_SHUTDOWN) {
@@ -1593,7 +1593,7 @@
 
 	IRDA_DEBUG(4, "%s(), len=%d\n", __FUNCTION__, len);
 
-	if (msg->msg_flags & ~MSG_DONTWAIT)
+	if (MSG_FLAGS_USER(msg->msg_flags) & ~MSG_DONTWAIT)
 		return -EINVAL;
 
 	if (sk->sk_shutdown & SEND_SHUTDOWN) {
diff -Nru a/net/key/af_key.c b/net/key/af_key.c
--- a/net/key/af_key.c	2004-06-05 14:53:34 -07:00
+++ b/net/key/af_key.c	2004-06-05 14:53:34 -07:00
@@ -2726,7 +2726,7 @@
 	int copied, err;
 
 	err = -EINVAL;
-	if (flags & ~(MSG_PEEK|MSG_DONTWAIT|MSG_TRUNC))
+	if (MSG_FLAGS_USER(flags) & ~(MSG_PEEK|MSG_DONTWAIT|MSG_TRUNC))
 		goto out;
 
 	msg->msg_namelen = 0;
diff -Nru a/net/netrom/af_netrom.c b/net/netrom/af_netrom.c
--- a/net/netrom/af_netrom.c	2004-06-05 14:53:34 -07:00
+++ b/net/netrom/af_netrom.c	2004-06-05 14:53:34 -07:00
@@ -1021,7 +1021,7 @@
 	unsigned char *asmptr;
 	int size;
 
-	if (msg->msg_flags & ~(MSG_DONTWAIT|MSG_EOR))
+	if (MSG_FLAGS_USER(msg->msg_flags) & ~(MSG_DONTWAIT|MSG_EOR))
 		return -EINVAL;
 
 	lock_sock(sk);
diff -Nru a/net/packet/af_packet.c b/net/packet/af_packet.c
--- a/net/packet/af_packet.c	2004-06-05 14:53:34 -07:00
+++ b/net/packet/af_packet.c	2004-06-05 14:53:34 -07:00
@@ -1037,7 +1037,7 @@
 	int copied, err;
 
 	err = -EINVAL;
-	if (flags & ~(MSG_PEEK|MSG_DONTWAIT|MSG_TRUNC))
+	if (MSG_FLAGS_USER(flags) & ~(MSG_PEEK|MSG_DONTWAIT|MSG_TRUNC))
 		goto out;
 
 #if 0
diff -Nru a/net/rose/af_rose.c b/net/rose/af_rose.c
--- a/net/rose/af_rose.c	2004-06-05 14:53:34 -07:00
+++ b/net/rose/af_rose.c	2004-06-05 14:53:34 -07:00
@@ -1021,7 +1021,7 @@
 	unsigned char *asmptr;
 	int n, size, qbit = 0;
 
-	if (msg->msg_flags & ~(MSG_DONTWAIT|MSG_EOR))
+	if (MSG_FLAGS_USER(msg->msg_flags) & ~(MSG_DONTWAIT|MSG_EOR))
 		return -EINVAL;
 
 	if (sk->sk_zapped)
diff -Nru a/net/wanrouter/af_wanpipe.c b/net/wanrouter/af_wanpipe.c
--- a/net/wanrouter/af_wanpipe.c	2004-06-05 14:53:34 -07:00
+++ b/net/wanrouter/af_wanpipe.c	2004-06-05 14:53:35 -07:00
@@ -552,7 +552,7 @@
 	if (sk->sk_state != WANSOCK_CONNECTED)
 		return -ENOTCONN;	
 
-	if (msg->msg_flags&~MSG_DONTWAIT) 
+	if (MSG_FLAGS_USER(msg->msg_flags) & ~MSG_DONTWAIT) 
 		return(-EINVAL);
 
 	/* it was <=, now one can send
diff -Nru a/net/x25/af_x25.c b/net/x25/af_x25.c
--- a/net/x25/af_x25.c	2004-06-05 14:53:34 -07:00
+++ b/net/x25/af_x25.c	2004-06-05 14:53:34 -07:00
@@ -922,7 +922,8 @@
 	size_t size;
 	int qbit = 0, rc = -EINVAL;
 
-	if (msg->msg_flags & ~(MSG_DONTWAIT | MSG_OOB | MSG_EOR))
+	if (MSG_FLAGS_USER(msg->msg_flags) &
+	    ~(MSG_DONTWAIT | MSG_OOB | MSG_EOR))
 		goto out;
 
 	/* we currently don't support segmented records at the user interface */
