Return-Path: <owner-linux-kernel-outgoing@vger.rutgers.edu>
Received: by vger.rutgers.edu via listexpand id <S155146AbQD0TJD>; Thu, 27 Apr 2000 15:09:03 -0400
Received: by vger.rutgers.edu id <S154974AbQD0TIw>; Thu, 27 Apr 2000 15:08:52 -0400
Received: from [212.52.194.36] ([212.52.194.36]:1242 "EHLO vnserv.vianova.at") by vger.rutgers.edu with ESMTP id <S155142AbQD0TIj>; Thu, 27 Apr 2000 15:08:39 -0400
Message-ID: <39088DF8.EAA5AAAB@vianova.at>
Date: Thu, 27 Apr 2000 20:59:04 +0200
From: Rene Mayrhofer <rene.mayrhofer@vianova.at>
X-Mailer: Mozilla 4.72 [en] (X11; U; Linux 2.2.14 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: linux-kernel@vger.rutgers.edu
Subject: [Patch 2.2.14]: bugfix for advanced routing with masquerading (still  there in 2.3.99-pre5)
Content-Type: multipart/mixed; boundary="------------EEE02189C6B78B629DA852D8"
Sender: owner-linux-kernel@vger.rutgers.edu

This is a multi-part message in MIME format.
--------------EEE02189C6B78B629DA852D8
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi all

I have discovered a bug in the advanced routing / masquerading code 2 weeks ago
and have tried to make a patch since (patch attached after the bug description).
The bug is reproduceable:

1. you need 2 PCs (at minimum), each one with a network card
2. PC 1 acts as a source-based, masquerading router
3. PC 2 acts as the client, using PC 1 as default gateway

You should have something like this (both addresses of PC1 can be on one
interface without problems):

----- 10.0.3.2   10.0.3.1 ----- 10.0.1.2   10.0.1.1 ------
|PC2|---------------------|PC1|---------------------| GW |-...
-----                     -----                     ------

4. setup PC 1 as follows:
   ip addr add 10.0.1.2/24 dev eth0
   ip addr add 10.0.3.1/24 dev eth0
   ip rule add prio 1 table main
   ip route add table 2 default via 10.0.1.1 src 10.0.1.2 dev eth0
   ip rule add prio 102 iif eth0 from 10.0.3.0/24 nat 10.0.1.2 table 2
   ip rule add prio 32000 iif lo table 2
   ip route flush cache
   echo 1 > /proc/sys/net/ipv4/ip_forward
   echo 3 > /proc/sys/net/ipv4/ip_masq_debug
   for i in /proc/sys/net/ipv4/conf/*/log_martians; do
     echo 1 > $i
   done
   for i in /proc/sys/net/ipv4/conf/*/rp_filter; do
     echo 1 > $i
   done
   ipchains -I input -l
   ipchains -I output -l
   ipchains -I forward -l

5. setup PC 2 as follows:
   ip addr add 10.0.3.2/24 dev eth0
   ip route add default via 10.0.3.1

6. on PC 2, do
   ping 10.0.1.1 (or ping <whatever> if PC 1 is connected to others)
   You can see that the ping works and that PC 1 does masquerading.

7. on PC 1, do
   ip rule del prio 32000
   Now PC 1 has no default route (no default route for packets coming
   from iface lo), pings do not work from PC 1 - that's ok.

8. on PC 2, do
   ping 10.0.1.1 (or ping <whatever>)
   Now the ping does not work. If you look at the syslog on PC 1, you
   can see that it masquerades the packets coming from 10.0.3.2 as 
   10.0.1.2, which is perfectly ok. Then the packets come back from
   10.0.1.1 to 10.0.1.2 (they come through the input chain) and get
   thrown away. They do not appear in the output chain, just silently
   dropped (if log_martians is switched on, there is a message).

I was able to track the bug down to the following: In net/ipv4/route.c, function
ip_route_input_slow, line 1183, fib_validate_source is called. There, the
reverse fib_lookup in line 207 fails because there is no routing entry for
packets coming -from- iface lo. After that, fib_validate_source returns an error
in
line 234 when rp_filter is activated. This causes ip_route_input_slow to drop
the packet and log a "martian source".
I think this behaviour should be changed, because the kernel masqueraded the
packets in the forward direction, but does not allow them to be masqueraded.

This patch solves the problem for me, but I am completely unsure about the
performance impact of calling ip_fw_demasquerade and I am also unsure if it
changes
the packet in a bad way during the check. Please see this patch as an idea on
what should be changed. I do not understand the masquerading code fully and
therefore I do not claim that there aren't side-effects. Also this is my first
kernel patch, so please be patient with me :)

Please could somebody comment on the solution ? Would it be better to check this
in fib_validate_source ? I think so, but then I would need to change the
interface of fib_validate_source. 

The problem is still there in 2.3.99-pre5 (the codes are equal), but my patch
can't work on 2.3.99, since there is no ip_fw_demasquerade and I don't know
anything about how the netfilter framework does masquerading now. However, the
same procedure (with the ipchains module loaded of course) can be used to
reproduce the bug with 2.3.99-pre5.

Please reply directly to me, since I am not subscribed to the mailing list.

best greets,
Rene Mayrhofer
--------------EEE02189C6B78B629DA852D8
Content-Type: text/plain; charset=UTF-8;
 name="nat_masq_fix-2.2.14-2.diff"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="nat_masq_fix-2.2.14-2.diff"

--- linux-2.2.14/net/ipv4/route.c	Tue Jan  4 19:12:26 2000
+++ linux/net/ipv4/route.c	Thu Apr 27 16:30:23 2000
@@ -52,6 +52,7 @@
  *	Tobias Ringstrom	:	Uninitialized res.type in ip_route_output_slow.
  *	Vladimir V. Ivanov	:	IP rule info (flowid) is really useful.
  *		Marc Boucher	:	routing by fwmark
+ *		Rene Mayrhofer	:	valid packet rejected bug in ip_route_input_slow
  *
  *		This program is free software; you can redistribute it and/or
  *		modify it under the terms of the GNU General Public License
@@ -93,6 +94,9 @@
 #ifdef CONFIG_SYSCTL
 #include <linux/sysctl.h>
 #endif
+#ifdef CONFIG_IP_MASQUERADE
+#include <net/ip_masq.h>
+#endif
 
 #define IP_MAX_MTU	0xFFF0
 
@@ -1182,8 +1186,28 @@
 		int result;
 		result = fib_validate_source(saddr, daddr, tos, loopback_dev.ifindex,
 					     dev, &spec_dst, &itag);
-		if (result < 0)
+		if (result < 0) {
+#ifdef CONFIG_IP_MASQUERADE
+			/*
+			 * Is this packet going to be demasqueraded ? 
+			 * In that case, fib_validate_source returns an error when there is no
+			 * default route for packets coming from loopback and rp_filter is
+			 * activated for the interface that the returning packet has been 
+			 * recieved on.
+			 * But in such a special case (a combination of source-based routing
+			 * and masquerading), the returning packet is indeed valid. It will 
+			 * get demasqueraded later on.
+			 */
+			{
+				struct sk_buff *tmp = skb;
+				if(ip_fw_demasquerade(&tmp) <= 0) {
+					goto martian_source;
+				}
+			}
+#else
 			goto martian_source;
+#endif
+		}
 		if (result)
 			flags |= RTCF_DIRECTSRC;
 		spec_dst = daddr;


--------------EEE02189C6B78B629DA852D8--


-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.rutgers.edu
Please read the FAQ at http://www.tux.org/lkml/
