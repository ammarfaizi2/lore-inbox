Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262108AbREQUQN>; Thu, 17 May 2001 16:16:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262119AbREQUQC>; Thu, 17 May 2001 16:16:02 -0400
Received: from adsl-63-199-104-197.dsl.lsan03.pacbell.net ([63.199.104.197]:7687
	"HELO mail.theoesters.com") by vger.kernel.org with SMTP
	id <S262108AbREQUPv>; Thu, 17 May 2001 16:15:51 -0400
From: "Phil Oester" <phil@theoesters.com>
To: <linux-kernel@vger.kernel.org>
Subject: [PATCH] Allow 'hidden' interfaces in 2.4.x
Date: Thu, 17 May 2001 13:15:49 -0700
Message-ID: <LAEOJKHJGOLOPJFMBEFEKEDMDKAA.phil@theoesters.com>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
X-Priority: 3 (Normal)
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook IMO, Build 9.0.2416 (9.0.2911.0)
X-MimeOLE: Produced By Microsoft MimeOLE V5.50.4522.1200
Importance: Normal
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The attached patch (against 2.4.4-ac10) adds the
/proc/sys/net/ipv4/conf/*/hidden option which is present in 2.2.x series.
This is somewhat similar to the arp-filter functionality which was added in
~2.4.4-ac10.  The difference is that this is not dependent upon the routing
table, it is simply configured using proc fs.

This is particularly useful in load-balanced server farms where loopback
addresses are configured for direct client-server traffic.  Without this
patch, Linux will respond to arp requests for the virtual IPs, making
effective load balancing difficult.

-Phil Oester


diff -r -u -x *~ -x *.rej
linux-2.4.4-ac10/Documentation/filesystems/proc.txt
linux-2.4.4-ac10-hidden/Documentation/filesystems/proc.txt
--- linux-2.4.4-ac10/Documentation/filesystems/proc.txt	Fri Apr  6 13:42:48
2001
+++ linux-2.4.4-ac10-hidden/Documentation/filesystems/proc.txt	Thu May 17
15:01:45 2001
@@ -1578,6 +1578,17 @@

 Determines whether to send ICMP redirects to other hosts.

+hidden
+------
+
+Hide addresses attached to this device from other devices.
+Such addresses will never be selected by source address autoselection
+mechanism.  Also, host will not answer broadcast ARP requests for them and
+will not announce it as source address of ARP requests.  The addresses are,
+however, still reachable via IP.  This is primarily useful in
load-balancing
+environments.  This flag is activated only if it is enabled both in
specific
+device section and in "all" section.
+
 Routing settings
 ----------------

diff -r -u -x *~ -x *.rej
linux-2.4.4-ac10/Documentation/networking/ip-sysctl.txt
linux-2.4.4-ac10-hidden/Documentation/networking/ip-sysctl.txt
--- linux-2.4.4-ac10/Documentation/networking/ip-sysctl.txt	Thu May 17
14:53:02 2001
+++ linux-2.4.4-ac10-hidden/Documentation/networking/ip-sysctl.txt	Thu May
17 15:02:47 2001
@@ -392,6 +392,15 @@
 	Default value is 0. Note that some distributions enable it
 	in startip scripts.

+hidden - BOOLEAN
+	Hide addresses attached to this device from other devices.
+	Such addresses will never be selected by source address autoselection
+	mechanism.  Also, host will not answer broadcast ARP requests for them and
+	will not announce it as source address of ARP requests.  The addresses
are,
+	however, still reachable via IP.  This is primarily useful in
load-balancing
+	environments.  This flag is activated only if it is enabled both in
specific
+	device section and in "all" section.
+
 Alexey Kuznetsov.
 kuznet@ms2.inr.ac.ru

diff -r -u -x *~ -x *.rej linux-2.4.4-ac10/include/linux/inetdevice.h
linux-2.4.4-ac10-hidden/include/linux/inetdevice.h
--- linux-2.4.4-ac10/include/linux/inetdevice.h	Thu May 17 14:53:07 2001
+++ linux-2.4.4-ac10-hidden/include/linux/inetdevice.h	Thu May 17 14:30:25
2001
@@ -18,6 +18,7 @@
 	int	mc_forwarding;
 	int	tag;
 	int     arp_filter;
+	int	hidden;
 	void	*sysctl;
 };

@@ -44,6 +45,7 @@

 #define IN_DEV_LOG_MARTIANS(in_dev)	(ipv4_devconf.log_martians ||
(in_dev)->cnf.log_martians)
 #define IN_DEV_PROXY_ARP(in_dev)	(ipv4_devconf.proxy_arp ||
(in_dev)->cnf.proxy_arp)
+#define IN_DEV_HIDDEN(in_dev)		((in_dev)->cnf.hidden &&
ipv4_devconf.hidden)
 #define IN_DEV_SHARED_MEDIA(in_dev)	(ipv4_devconf.shared_media ||
(in_dev)->cnf.shared_media)
 #define IN_DEV_TX_REDIRECTS(in_dev)	(ipv4_devconf.send_redirects ||
(in_dev)->cnf.send_redirects)
 #define IN_DEV_SEC_REDIRECTS(in_dev)	(ipv4_devconf.secure_redirects ||
(in_dev)->cnf.secure_redirects)
diff -r -u -x *~ -x *.rej linux-2.4.4-ac10/include/linux/sysctl.h
linux-2.4.4-ac10-hidden/include/linux/sysctl.h
--- linux-2.4.4-ac10/include/linux/sysctl.h	Thu May 17 14:53:07 2001
+++ linux-2.4.4-ac10-hidden/include/linux/sysctl.h	Thu May 17 14:32:40 2001
@@ -326,7 +326,8 @@
 	NET_IPV4_CONF_BOOTP_RELAY=10,
 	NET_IPV4_CONF_LOG_MARTIANS=11,
 	NET_IPV4_CONF_TAG=12,
-	NET_IPV4_CONF_ARPFILTER=13
+	NET_IPV4_CONF_ARPFILTER=13,
+	NET_IPV4_CONF_HIDDEN=14
 };

 /* /proc/sys/net/ipv6 */
diff -r -u -x *~ -x *.rej linux-2.4.4-ac10/net/ipv4/arp.c
linux-2.4.4-ac10-hidden/net/ipv4/arp.c
--- linux-2.4.4-ac10/net/ipv4/arp.c	Thu May 17 14:53:07 2001
+++ linux-2.4.4-ac10-hidden/net/ipv4/arp.c	Thu May 17 14:47:44 2001
@@ -66,7 +66,9 @@
  *		Alexey Kuznetsov:	new arp state machine;
  *					now it is in net/core/neighbour.c.
  *		Krzysztof Halasa:	Added Frame Relay ARP support.
- */
+ *		Julian Anastasov:	"hidden" flag: hide the
+ *					interface and don't reply for it
+*/

 #include <linux/types.h>
 #include <linux/string.h>
@@ -317,12 +319,23 @@
 static void arp_solicit(struct neighbour *neigh, struct sk_buff *skb)
 {
 	u32 saddr;
+	int from_skb;
+	struct in_device *in_dev2 = NULL;
+	struct net_device *dev2 = NULL;
 	u8  *dst_ha = NULL;
 	struct net_device *dev = neigh->dev;
 	u32 target = *(u32*)neigh->primary_key;
 	int probes = atomic_read(&neigh->probes);

-	if (skb && inet_addr_type(skb->nh.iph->saddr) == RTN_LOCAL)
+	from_skb = (skb &&
+		(dev2 = ip_dev_find(skb->nh.iph->saddr)) != NULL &&
+		(in_dev2 = in_dev_get(dev2)) != NULL &&
+		!IN_DEV_HIDDEN(in_dev2));
+	if (dev2) {
+		if (in_dev2) in_dev_put(in_dev2);
+		dev_put(dev2);
+	}
+	if (from_skb)
 		saddr = skb->nh.iph->saddr;
 	else
 		saddr = inet_select_addr(dev, target, RT_SCOPE_LINK);
@@ -742,9 +755,22 @@

 	/* Special case: IPv4 duplicate address detection packet (RFC2131) */
 	if (sip == 0) {
-		if (arp->ar_op == __constant_htons(ARPOP_REQUEST) &&
-		    inet_addr_type(tip) == RTN_LOCAL)
+		int reply;
+		struct net_device *dev2 = NULL;
+		struct in_device *in_dev2 = NULL;
+
+		reply =
+		    (arp->ar_op == __constant_htons(ARPOP_REQUEST) &&
+		    (dev2 = ip_dev_find(tip)) != NULL &&
+		    (dev2 == dev ||
+		    ((in_dev2 = in_dev_get(dev2)) != NULL &&
+		    !IN_DEV_HIDDEN(in_dev2))));
+		if (dev2) {
+		    if (in_dev2) in_dev_put(in_dev2);
+		    dev_put(dev2);
+		    if (reply)

arp_send(ARPOP_REPLY,ETH_P_ARP,tip,dev,tip,sha,dev->dev_addr,dev->dev_addr);
+		}
 		goto out;
 	}

@@ -760,10 +786,29 @@
 				int dont_send = 0;
 				if (IN_DEV_ARPFILTER(in_dev))
 					dont_send |= arp_filter(sip,tip,dev);
-				if (!dont_send)
+				if (!dont_send) {
+					if (ipv4_devconf.hidden && skb->pkt_type != PACKET_HOST) {
+						int skip;
+						struct net_device *dev2 = NULL;
+						struct in_device *in_dev2 = NULL;
+
+						skip =
+						((dev2 = ip_dev_find(tip)) != NULL &&
+							dev2 != dev &&
+						(in_dev2=in_dev_get(dev2)) != NULL &&
+							IN_DEV_HIDDEN(in_dev2));
+						if (dev2) {
+							if (in_dev2) in_dev_put(in_dev2);
+							dev_put(dev2);
+							if (skip) {
+								neigh_release(n);
+								goto out;
+							}
+						}
+					}
 					arp_send(ARPOP_REPLY,ETH_P_ARP,sip,dev,tip,sha,dev->dev_addr,sha);
-
-				neigh_release(n);
+					neigh_release(n);
+				}
 			}
 			goto out;
 		} else if (IN_DEV_FORWARD(in_dev)) {
diff -r -u -x *~ -x *.rej linux-2.4.4-ac10/net/ipv4/devinet.c
linux-2.4.4-ac10-hidden/net/ipv4/devinet.c
--- linux-2.4.4-ac10/net/ipv4/devinet.c	Thu May 17 14:53:07 2001
+++ linux-2.4.4-ac10-hidden/net/ipv4/devinet.c	Thu May 17 14:51:44 2001
@@ -736,7 +736,8 @@

 		read_lock(&in_dev->lock);
 		for_primary_ifa(in_dev) {
-			if (ifa->ifa_scope != RT_SCOPE_LINK &&
+			if (!IN_DEV_HIDDEN(in_dev) &&
+			    ifa->ifa_scope != RT_SCOPE_LINK &&
 			    ifa->ifa_scope <= scope) {
 				read_unlock(&in_dev->lock);
 				read_unlock(&inetdev_lock);
@@ -1016,7 +1017,7 @@
 static struct devinet_sysctl_table
 {
 	struct ctl_table_header *sysctl_header;
-	ctl_table devinet_vars[14];
+	ctl_table devinet_vars[15];
 	ctl_table devinet_dev[2];
 	ctl_table devinet_conf_dir[2];
 	ctl_table devinet_proto_dir[2];
@@ -1061,6 +1062,9 @@
 	 &proc_dointvec},
 	{NET_IPV4_CONF_ARPFILTER, "arp_filter",
 	 &ipv4_devconf.arp_filter, sizeof(int), 0644, NULL,
+	 &proc_dointvec},
+	{NET_IPV4_CONF_HIDDEN, "hidden",
+	 &ipv4_devconf.hidden, sizeof(int), 0644, NULL,
 	 &proc_dointvec},
 	 {0}},


