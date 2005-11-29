Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750705AbVK2D4F@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750705AbVK2D4F (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 28 Nov 2005 22:56:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750712AbVK2D4F
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 28 Nov 2005 22:56:05 -0500
Received: from pop.ispwest.com ([216.52.245.18]:11780 "EHLO
	ispwest-email1.mdeinc.com") by vger.kernel.org with ESMTP
	id S1750705AbVK2D4E convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 28 Nov 2005 22:56:04 -0500
X-Modus-BlackList: 216.52.245.25=OK;kjak@ispwest.com=OK
X-Modus-Trusted: 216.52.245.25=YES
Message-ID: <9188864830a243e8a5ed8ce75d1b098f.kjak@ispwest.com>
X-EM-APIVersion: 2, 0, 1, 0
X-Priority: 3 (Normal)
Reply-To: "Kris Katterjohn" <kjak@users.sourceforge.net>
From: "Kris Katterjohn" <kjak@ispwest.com>
To: linux-kernel@vger.kernel.org
CC: torvalds@osdl.org
Subject: [PATCH] Resetting packet statistics
Date: Mon, 28 Nov 2005 19:55:52 -0800
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

These patches keep getsockopt(PACKET_STATISTICS) from resetting the packet
stats to zero and it creates PACKET_RESET_STATISTICS, which is used with
setsockopt(), to zero the packet stats.

Signed-off by: Kris Katterjohn <kjak@users.sourceforge.net>

---

Before I start: This is a diff from 2.6.14 and I am not subscribed so please CC
me on any replies.


I doubt I'm the only one who's a little annoyed that we have to keep track of the
packet count in userland after getsockopt(PACKET_STATISTICS). I did a little
searching but didn't find a patch similar to this so I'm not sure if I'm the only
one who thinks this is a generally Good Thing or not.

The ways these affect programs:

1) Programs can set the packet count to zero at anytime without having to make a
struct tpacket_stats just to reset it with getsockopt()

2) Programs don't need extra variables to hold packet counts (think libpcap),
they just call getsockopt(PACKET_STATISTICS) multiple times for updated stats.


NOTE:
The second patch adds PACKET_RESET_STATISTICS to include/linux/if_packet.h, but I
don't know if it's okay to #define it as "7" since that was PACKET_COPY_THRESH's
value. I did it so that the two PACKET*STATISTICS macros would be next to each
other. I checked the glibc header netpacket/packet.h and it doesn't even define
PACKET_COPY_THRESH so it shouldn't cause any problems (that I can see).


Thanks!

---

--- x/net/packet/af_packet.c	2005-10-27 19:02:08.000000000 -0500
+++ y/net/packet/af_packet.c	2005-11-28 21:49:37.000000000 -0600
@@ -41,6 +41,9 @@
  *					will simply extend the hardware address
  *					byte arrays at the end of sockaddr_ll 
  *					and packet_mreq.
+ *		Kris Katterjohn :	Added PACKET_RESET_STATISTICS setsockopt
+ *					option.	PACKET_STATISTICS no longer sets
+ *					stats to zero. 2005-11-28
  *
  *		This program is free software; you can redistribute it and/or
  *		modify it under the terms of the GNU General Public License
@@ -1352,6 +1355,17 @@ packet_setsockopt(struct socket *sock, i
 		return ret;
 	}
 #endif
+
+	case PACKET_RESET_STATISTICS:
+	{
+		struct packet_sock *po = pkt_sk(sk);
+
+		spin_lock_bh(&sk->sk_receive_queue.lock);
+		memset(&po->stats, 0, sizeof(po->stats));
+		spin_unlock_bh(&sk->sk_receive_queue.lock);
+		return 0;
+	}
+
 #ifdef CONFIG_PACKET_MMAP
 	case PACKET_RX_RING:
 	{
@@ -1406,7 +1420,6 @@ static int packet_getsockopt(struct sock
 			len = sizeof(struct tpacket_stats);
 		spin_lock_bh(&sk->sk_receive_queue.lock);
 		st = po->stats;
-		memset(&po->stats, 0, sizeof(st));
 		spin_unlock_bh(&sk->sk_receive_queue.lock);
 		st.tp_packets += st.tp_drops;


 
--- x/include/linux/if_packet.h	2005-10-27 19:02:08.000000000 -0500
+++ y/include/linux/if_packet.h	2005-11-28 21:49:37.000000000 -0600
@@ -38,7 +38,8 @@ struct sockaddr_ll
 /* Value 4 is still used by obsolete turbo-packet. */
 #define PACKET_RX_RING			5
 #define PACKET_STATISTICS		6
-#define PACKET_COPY_THRESH		7
+#define PACKET_RESET_STATISTICS		7
+#define PACKET_COPY_THRESH		8
 
 struct tpacket_stats
 {



