Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750937AbVK2JUk@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750937AbVK2JUk (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 29 Nov 2005 04:20:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750942AbVK2JUk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 29 Nov 2005 04:20:40 -0500
Received: from mail.ispwest.com ([216.52.245.18]:57093 "EHLO
	ispwest-email1.mdeinc.com") by vger.kernel.org with ESMTP
	id S1750906AbVK2JUk convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 29 Nov 2005 04:20:40 -0500
X-Modus-BlackList: 216.52.245.25=OK;kjak@ispwest.com=OK
X-Modus-Trusted: 216.52.245.25=YES
Message-ID: <82da9c5ea4034883941a054aedfc7a02.kjak@ispwest.com>
X-EM-APIVersion: 2, 0, 1, 0
X-Priority: 3 (Normal)
Reply-To: "Kris Katterjohn" <kjak@users.sourceforge.net>
From: "Kris Katterjohn" <kjak@ispwest.com>
To: linux-kernel@vger.kernel.org
CC: torvalds@osdl.org
Subject: Re: [PATCH] Resetting packet statistics
Date: Tue, 29 Nov 2005 01:20:37 -0800
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: David S. Miller
Sent: 11/28/2005 11:02:24 PM
> Or, you can create a new call that says "from now on, do not
> reset statistics on calls using this socket."  That's another
> clean, and backwards compatible way, to deal with this
> kind of issue.

I like that one. Here are the updated patches and descriptions:

PACKET_AUTO_STATISTICS (default) lets the kernel reset the stats with each call
of PACKET_STATISTICS and PACKET_MANUAL_STATISTICS won't reset them unless
PACKET_RESET_STATISTICS is called. AUTO and MANUAL can be called multiple times
to change the "state" if necessary.

I didn't check for auto_reset_stats under PACKET_RESET_STATISTICS so it can still
be used to reset the stats while in "auto mode".

Also, just to be sure, is changing PACKET_COPY_THRESH's value in if_packet.h
okay?


Thanks a lot!


--- x/net/packet/af_packet.c	2005-10-27 19:02:08.000000000 -0500
+++ y/net/packet/af_packet.c	2005-11-29 03:02:19.000000000 -0600
@@ -41,6 +41,12 @@
  *					will simply extend the hardware address
  *					byte arrays at the end of sockaddr_ll 
  *					and packet_mreq.
+ *		Kris Katterjohn :	Added setsockopt options:
+ *					PACKET_AUTO_STATISTICS,
+ *					PACKET_MANUAL_STATISTICS, and
+ *					PACKET_RESET_STATISTICS	to handle the
+ *					zero-ing of packet stats when using
+ *					PACKET_STATISTICS. 2005-11-29.
  *
  *		This program is free software; you can redistribute it and/or
  *		modify it under the terms of the GNU General Public License
@@ -189,6 +195,7 @@ struct packet_sock {
 	/* struct sock has to be the first member of packet_sock */
 	struct sock		sk;
 	struct tpacket_stats	stats;
+	int			auto_reset_stats;
 #ifdef CONFIG_PACKET_MMAP
 	char *			*pg_vec;
 	unsigned int		head;
@@ -1020,6 +1027,7 @@ static int packet_create(struct socket *
 	po = pkt_sk(sk);
 	sk->sk_family = PF_PACKET;
 	po->num = protocol;
+	po->auto_reset_stats = 1;
 
 	sk->sk_destruct = packet_sock_destruct;
 	atomic_inc(&packet_socks_nr);
@@ -1324,6 +1332,7 @@ static int
 packet_setsockopt(struct socket *sock, int level, int optname, char __user *optval, int optlen)
 {
 	struct sock *sk = sock->sk;
+	struct packet_sock *po = pkt_sk(sk);
 	int ret;
 
 	if (level != SOL_PACKET)
@@ -1352,6 +1361,21 @@ packet_setsockopt(struct socket *sock, i
 		return ret;
 	}
 #endif
+
+	case PACKET_AUTO_STATISTICS:
+		po->auto_reset_stats = 1;
+		return 0;
+
+	case PACKET_MANUAL_STATISTICS:
+		po->auto_reset_stats = 0;
+		return 0;
+
+	case PACKET_RESET_STATISTICS:
+		spin_lock_bh(&sk->sk_receive_queue.lock);
+		memset(&po->stats, 0, sizeof(po->stats));
+		spin_unlock_bh(&sk->sk_receive_queue.lock);
+		return 0;
+
 #ifdef CONFIG_PACKET_MMAP
 	case PACKET_RX_RING:
 	{
@@ -1406,7 +1430,8 @@ static int packet_getsockopt(struct sock
 			len = sizeof(struct tpacket_stats);
 		spin_lock_bh(&sk->sk_receive_queue.lock);
 		st = po->stats;
-		memset(&po->stats, 0, sizeof(st));
+		if (po->auto_reset_stats)
+			memset(&po->stats, 0, sizeof(po->stats));
 		spin_unlock_bh(&sk->sk_receive_queue.lock);
 		st.tp_packets += st.tp_drops;

 
--- x/include/linux/if_packet.h	2005-10-27 19:02:08.000000000 -0500
+++ y/include/linux/if_packet.h	2005-11-29 03:02:19.000000000 -0600
@@ -38,7 +38,10 @@ struct sockaddr_ll
 /* Value 4 is still used by obsolete turbo-packet. */
 #define PACKET_RX_RING			5
 #define PACKET_STATISTICS		6
-#define PACKET_COPY_THRESH		7
+#define PACKET_AUTO_STATISTICS		7
+#define PACKET_MANUAL_STATISTICS	8
+#define PACKET_RESET_STATISTICS		9
+#define PACKET_COPY_THRESH		10
 
 struct tpacket_stats
 {


