Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129115AbRCBNHu>; Fri, 2 Mar 2001 08:07:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129116AbRCBNHk>; Fri, 2 Mar 2001 08:07:40 -0500
Received: from nautilus.shore.net ([207.244.124.104]:63478 "EHLO
	nautilus.shore.net") by vger.kernel.org with ESMTP
	id <S129115AbRCBNH3>; Fri, 2 Mar 2001 08:07:29 -0500
To: linux-kernel@vger.kernel.org
Subject: PATCH for Multicast bug in RAW IP sockets 2.4.0
Message-Id: <E14YpHM-0002Kw-00@nautilus.shore.net>
From: Mark Clayton <clayton@shore.net>
Date: Fri, 02 Mar 2001 08:07:28 -0500
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


In ipv4 a call to the setsockopt() function with the optname set to 
IP_ADD_MEMBERSHIP and a raw ip socket adds the socket to the multicast 
group specified by the user. As a result the tcpip stack code does the 
following:
...
ip_setsockopt(_,_,IP_ADD_MEMBERSHIP,_,_) calls ip_mc_join_group(sock,_) 
function, which adds a multicast entry to the sock->protinfo.af_inet.mc_list 
and then adds a multicast entry to the bound device (if any) with a call 
to the ip_mc_inc_group() function.

When remote multicast packets that belong to the multicast group we just 
joined are received, the routing code recognizes the packets as multicast 
packet going to a local receiver, but the __raw_v4_lookup() function only 
examines the main sock address (sock->rcv_saddr) and totally forgets that 
this raw sock can a member of multiple multicast groups.

The following patch fixes the problem:

---[ PATCH STARTS ]--------------------------------------------------------

--- linux-2.4.2/net/ipv4/raw.c	Fri Feb  9 14:29:44 2001
+++ linux/net/ipv4/raw.c	Wed Feb 28 17:43:59 2001
@@ -54,6 +54,7 @@
 #include <linux/inet.h>
 #include <linux/netdevice.h>
 #include <linux/mroute.h>
+#include <linux/igmp.h>
 #include <net/ip.h>
 #include <net/protocol.h>
 #include <linux/skbuff.h>
@@ -107,6 +108,18 @@
 		   !(s->rcv_saddr && s->rcv_saddr != laddr)	&&
 		   !(s->bound_dev_if && s->bound_dev_if != dif))
 			break; /* gotcha */
+		if (LOCAL_MCAST(laddr)) {
+
+		    struct ip_mc_socklist *iml;
+		    struct ip_mreqn *imr;
+
+		    for (iml=sk->protinfo.af_inet.mc_list; iml; iml=iml->next) {
+		      imr = &(iml->multi);
+		      if ((imr->imr_multiaddr.s_addr == laddr) && !(imr->imr_ifindex && imr->imr_ifindex != dif))
+			        return s;
+		    }
+
+		}
 	}
 	return s;
 }

---[ PATCH ENDS ]-----------------------------------------------------------

Note: the same problem exists for UDP sockets also.


