Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S135404AbREEVPU>; Sat, 5 May 2001 17:15:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S135380AbREEVPL>; Sat, 5 May 2001 17:15:11 -0400
Received: from cx97923-a.phnx3.az.home.com ([24.9.112.194]:45329 "EHLO
	grok.yi.org") by vger.kernel.org with ESMTP id <S135404AbREEVO4>;
	Sat, 5 May 2001 17:14:56 -0400
Message-ID: <3AF4720F.35574FDD@candelatech.com>
Date: Sat, 05 May 2001 14:35:11 -0700
From: Ben Greear <greearb@candelatech.com>
Organization: Candela Technologies
X-Mailer: Mozilla 4.76 [en] (X11; U; Linux 2.2.17-14 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: linux-kernel <linux-kernel@vger.kernel.org>,
        Alan Cox <alan@lxorguk.ukuu.org.uk>, Andi Kleen <ak@muc.de>,
        Linus Torvalds <torvalds@transmeta.com>
Subject: [PATCH] arp_filter patch for 2.4.4 kernel.
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This patch is ported from Andi Kleen's work for the 2.2.19 kernel (I think
it was his, at least...)

It adds the ability to run multiple interfaces on the same subnet,
on the same machine, and have the ARPs for each interface be answered
based on whether or not the kernel would route a packet from the ARP'd
IP out that interface.  When used with source-based routing, this
makes things work in an intuitive manner.

I find this a vital feature for one of my projects, and would welcome
it's inclusion into the 2.4 kernel series!

The code seems to be working on my two test machines..

Thanks,
Ben


diff -u -r -N -X /home/greear/exclude.list linux/include/linux/inetdevice.h linux.dev/include/linux/inetdevice.h
--- linux/include/linux/inetdevice.h	Mon Aug 23 10:01:02 1999
+++ linux.dev/include/linux/inetdevice.h	Wed May  2 23:04:58 2001
@@ -17,6 +17,7 @@
 	int	forwarding;
 	int	mc_forwarding;
 	int	tag;
+        int     arp_filter;
 	void	*sysctl;
 };
 
@@ -53,6 +54,9 @@
 	  (ipv4_devconf.accept_redirects && (in_dev)->cnf.accept_redirects)) \
 	 || (!IN_DEV_FORWARD(in_dev) && \
 	  (ipv4_devconf.accept_redirects || (in_dev)->cnf.accept_redirects)))
+
+#define IN_DEV_ARPFILTER(in_dev)       (ipv4_devconf.arp_filter || (in_dev)->cnf.arp_filter)
+
 
 struct in_ifaddr
 {
diff -u -r -N -X /home/greear/exclude.list linux/include/linux/sysctl.h linux.dev/include/linux/sysctl.h
--- linux/include/linux/sysctl.h	Fri Apr 27 15:48:20 2001
+++ linux.dev/include/linux/sysctl.h	Wed May  2 23:52:46 2001
@@ -324,7 +324,8 @@
 	NET_IPV4_CONF_ACCEPT_SOURCE_ROUTE=9,
 	NET_IPV4_CONF_BOOTP_RELAY=10,
 	NET_IPV4_CONF_LOG_MARTIANS=11,
-	NET_IPV4_CONF_TAG=12
+	NET_IPV4_CONF_TAG=12,
+        NET_IPV4_CONF_ARPFILTER=13
 };
 
 /* /proc/sys/net/ipv6 */
diff -u -r -N -X /home/greear/exclude.list linux/include/net/snmp.h linux.dev/include/net/snmp.h
--- linux/include/net/snmp.h	Fri Apr 27 15:48:20 2001
+++ linux.dev/include/net/snmp.h	Wed May  2 23:54:14 2001
@@ -198,7 +198,8 @@
 	unsigned long	RcvPruned;
 	unsigned long	OfoPruned;
 	unsigned long	OutOfWindowIcmps; 
-	unsigned long	LockDroppedIcmps; 
+	unsigned long	LockDroppedIcmps;
+        unsigned long   ArpFilter;
 	unsigned long	TimeWaited; 
 	unsigned long	TimeWaitRecycled; 
 	unsigned long	TimeWaitKilled; 
diff -u -r -N -X /home/greear/exclude.list linux/net/ipv4/arp.c linux.dev/net/ipv4/arp.c
--- linux/net/ipv4/arp.c	Thu Apr 12 12:11:39 2001
+++ linux.dev/net/ipv4/arp.c	Thu May  3 00:13:37 2001
@@ -343,6 +343,26 @@
 		read_unlock_bh(&neigh->lock);
 }
 
+static int arp_filter(__u32 sip, __u32 tip, struct net_device *dev)
+{
+       struct rtable *rt;
+       int flag = 0; 
+       /*unsigned long now; */
+
+       if (ip_route_output(&rt, sip, tip, 0, 0) < 0) 
+               return 1;
+       if (rt->u.dst.dev != dev) { 
+               /* TODO:  Figure out what this is supposed to do and re-insert it:
+                *
+                * net_statistics.ArpFilter++;
+                *
+                */
+               flag = 1; 
+       } 
+       ip_rt_put(rt); 
+       return flag; 
+} 
+
 /* OBSOLETE FUNCTIONS */
 
 /*
@@ -739,7 +759,13 @@
 		if (addr_type == RTN_LOCAL) {
 			n = neigh_event_ns(&arp_tbl, sha, &sip, dev);
 			if (n) {
-				arp_send(ARPOP_REPLY,ETH_P_ARP,sip,dev,tip,sha,dev->dev_addr,sha);
+                                int dont_send = 0;
+                                if (IN_DEV_ARPFILTER(in_dev)) {
+                                      dont_send |= arp_filter(sip,tip,dev); 
+                                }
+                                if (!dont_send) {
+                                      arp_send(ARPOP_REPLY,ETH_P_ARP,sip,dev,tip,sha,dev->dev_addr,sha);
+                                }
 				neigh_release(n);
 			}
 			goto out;
diff -u -r -N -X /home/greear/exclude.list linux/net/ipv4/devinet.c linux.dev/net/ipv4/devinet.c
--- linux/net/ipv4/devinet.c	Sun Mar 25 19:14:25 2001
+++ linux.dev/net/ipv4/devinet.c	Wed May  2 23:27:47 2001
@@ -1016,7 +1016,7 @@
 static struct devinet_sysctl_table
 {
 	struct ctl_table_header *sysctl_header;
-	ctl_table devinet_vars[13];
+	ctl_table devinet_vars[14];
 	ctl_table devinet_dev[2];
 	ctl_table devinet_conf_dir[2];
 	ctl_table devinet_proto_dir[2];
@@ -1059,7 +1059,10 @@
 	{NET_IPV4_CONF_TAG, "tag",
 	 &ipv4_devconf.tag, sizeof(int), 0644, NULL,
 	 &proc_dointvec},
-	 {0}},
+        {NET_IPV4_CONF_ARPFILTER, "arp_filter",
+         &ipv4_devconf.arp_filter, sizeof(int), 0644, NULL,
+         &proc_dointvec},
+        {0}},
 
 	{{NET_PROTO_CONF_ALL, "all", NULL, 0, 0555, devinet_sysctl.devinet_vars},{0}},
 	{{NET_IPV4_CONF, "conf", NULL, 0, 0555, devinet_sysctl.devinet_dev},{0}},
diff -u -r -N -X /home/greear/exclude.list linux/net/ipv4/proc.c linux.dev/net/ipv4/proc.c
--- linux/net/ipv4/proc.c	Thu Aug 10 13:01:26 2000
+++ linux.dev/net/ipv4/proc.c	Wed May  2 23:12:57 2001
@@ -170,7 +170,7 @@
 	len = sprintf(buffer,
 		      "TcpExt: SyncookiesSent SyncookiesRecv SyncookiesFailed"
 		      " EmbryonicRsts PruneCalled RcvPruned OfoPruned"
-		      " OutOfWindowIcmps LockDroppedIcmps"
+		      " OutOfWindowIcmps LockDroppedIcmps ArpFilter"
 		      " TW TWRecycled TWKilled"
 		      " PAWSPassive PAWSActive PAWSEstab"
 		      " DelayedACKs DelayedACKLocked DelayedACKLost"

-- 
Ben Greear <greearb@candelatech.com>          <Ben_Greear@excite.com>
President of Candela Technologies Inc      http://www.candelatech.com
ScryMUD:  http://scry.wanfear.com     http://scry.wanfear.com/~greear
