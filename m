Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129704AbRAWJS0>; Tue, 23 Jan 2001 04:18:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129441AbRAWJQC>; Tue, 23 Jan 2001 04:16:02 -0500
Received: from Cantor.suse.de ([194.112.123.193]:11275 "HELO Cantor.suse.de")
	by vger.kernel.org with SMTP id <S129737AbRAWJIL>;
	Tue, 23 Jan 2001 04:08:11 -0500
Date: Tue, 23 Jan 2001 10:08:03 +0100
From: Andi Kleen <ak@suse.de>
To: Bernd Eckenfels <inka-user@lina.inka.de>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Turning off ARP in linux-2.4.0
Message-ID: <20010123100803.A24145@gruyere.muc.suse.de>
In-Reply-To: <E14KrfH-0001Mw-00@sites.inka.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <E14KrfH-0001Mw-00@sites.inka.de>; from inka-user@lina.inka.de on Tue, Jan 23, 2001 at 01:50:27AM +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 23, 2001 at 01:50:27AM +0100, Bernd Eckenfels wrote:
> Another option is to ifconfig -arp the eth0 interface. I browsed through the
> IPv4 code and did not find any other goto out which can be configured besides
> the input FIB, which messing with is a bad thing since it wont accept the
> packet at all.
> 
> so ifconfig -arp is the only option i could find which will help you. You need
> to hardcode the arp entries for the real ip's of those web servers to reach
> them.

-arp means that the kernel will not put in link layer to the packets.
It's probably not what you want. Yes the option is misnamed.

2.2 has arpfilter, which will hopefully end up in 2.4 soon too. Here is a 
patch. It allows to filter ARP replies based on the routing table.


-Andi



Index: include/linux/sysctl.h
===================================================================
RCS file: /cvs/linux/include/linux/sysctl.h,v
retrieving revision 1.110
diff -u -u -r1.110 sysctl.h
--- include/linux/sysctl.h	2000/11/15 00:13:57	1.110
+++ include/linux/sysctl.h	2001/01/21 10:52:39
@@ -320,9 +320,9 @@
 	NET_IPV4_CONF_SHARED_MEDIA=7,
 	NET_IPV4_CONF_RP_FILTER=8,
 	NET_IPV4_CONF_ACCEPT_SOURCE_ROUTE=9,
-	NET_IPV4_CONF_BOOTP_RELAY=10,
 	NET_IPV4_CONF_LOG_MARTIANS=11,
-	NET_IPV4_CONF_TAG=12
+	NET_IPV4_CONF_TAG=12,
+	NET_IPV4_CONF_ARPFILTER=13, 
 };
 
 /* /proc/sys/net/ipv6 */
Index: include/linux/inetdevice.h
===================================================================
RCS file: /cvs/linux/include/linux/inetdevice.h,v
retrieving revision 1.10
diff -u -u -r1.10 inetdevice.h
--- include/linux/inetdevice.h	1999/08/20 11:00:32	1.10
+++ include/linux/inetdevice.h	2001/01/21 10:52:40
@@ -12,11 +12,11 @@
 	int	accept_source_route;
 	int	rp_filter;
 	int	proxy_arp;
-	int	bootp_relay;
 	int	log_martians;
 	int	forwarding;
 	int	mc_forwarding;
 	int	tag;
+	int	arp_filter;
 	void	*sysctl;
 };
 
@@ -39,7 +39,6 @@
 #define IN_DEV_MFORWARD(in_dev)		(ipv4_devconf.mc_forwarding && (in_dev)->cnf.mc_forwarding)
 #define IN_DEV_RPFILTER(in_dev)		(ipv4_devconf.rp_filter && (in_dev)->cnf.rp_filter)
 #define IN_DEV_SOURCE_ROUTE(in_dev)	(ipv4_devconf.accept_source_route && (in_dev)->cnf.accept_source_route)
-#define IN_DEV_BOOTP_RELAY(in_dev)	(ipv4_devconf.bootp_relay && (in_dev)->cnf.bootp_relay)
 
 #define IN_DEV_LOG_MARTIANS(in_dev)	(ipv4_devconf.log_martians || (in_dev)->cnf.log_martians)
 #define IN_DEV_PROXY_ARP(in_dev)	(ipv4_devconf.proxy_arp || (in_dev)->cnf.proxy_arp)
@@ -47,6 +46,9 @@
 #define IN_DEV_TX_REDIRECTS(in_dev)	(ipv4_devconf.send_redirects || (in_dev)->cnf.send_redirects)
 #define IN_DEV_SEC_REDIRECTS(in_dev)	(ipv4_devconf.secure_redirects || (in_dev)->cnf.secure_redirects)
 #define IN_DEV_IDTAG(in_dev)		((in_dev)->cnf.tag)
+#define IN_DEV_ARPFILTER(in_dev)	(ipv4_devconf.arp_filter || \
+					 (in_dev)->cnf.arp_filter)
+
 
 #define IN_DEV_RX_REDIRECTS(in_dev) \
 	((IN_DEV_FORWARD(in_dev) && \
Index: net/ipv4/arp.c
===================================================================
RCS file: /cvs/linux/net/ipv4/arp.c,v
retrieving revision 1.95
diff -u -u -r1.95 arp.c
--- net/ipv4/arp.c	2001/01/10 18:26:53	1.95
+++ net/ipv4/arp.c	2001/01/21 10:52:42
@@ -311,6 +311,21 @@
 	kfree_skb(skb);
 }
 
+static int arp_filter(__u32 sip, __u32 tip, struct device *dev)
+{
+	struct rtable *rt;
+	int flag = 0; 
+
+	if (ip_route_output(&rt, sip, tip, 0, 0) < 0) 
+		return 1;
+	if (rt->u.dst.dev != dev) { 
+		SNMP_INC_STATS(net_statistics, ArpFilter); 
+		flag = 1; 
+	} 
+	ip_rt_put(rt); 
+	return flag; 
+} 
+
 static void arp_solicit(struct neighbour *neigh, struct sk_buff *skb)
 {
 	u32 saddr;
@@ -731,18 +746,25 @@
 
 		if (addr_type == RTN_LOCAL) {
 			n = neigh_event_ns(&arp_tbl, sha, &sip, dev);
-			if (n) {
+			if (!n)
+				goto out;
+			if (!(IN_DEV_ARPFILTER(in_dev)&&arp_filter(sip,tip,dev)))
 				arp_send(ARPOP_REPLY,ETH_P_ARP,sip,dev,tip,sha,dev->dev_addr,sha);
-				neigh_release(n);
-			}
+			neigh_release(n);
 			goto out;
 		} else if (IN_DEV_FORWARD(in_dev)) {
+			struct pneigh_enqueue *p = NULL; 
 			if ((rt->rt_flags&RTCF_DNAT) ||
 			    (addr_type == RTN_UNICAST  && rt->u.dst.dev != dev &&
-			     (IN_DEV_PROXY_ARP(in_dev) || pneigh_lookup(&arp_tbl, &tip, dev, 0)))) {
+			     (IN_DEV_PROXY_ARP(in_dev) || (p=pneigh_lookup(&arp_tbl, &tip, dev, 0))))) {
 				n = neigh_event_ns(&arp_tbl, sha, &sip, dev);
 				if (n)
 					neigh_release(n);
+
+				/* no arpfilter for explicit proxy arps */ 
+				if (!p && IN_DEV_ARPFILTER(in_dev)&&
+				    arp_filter(sip,tip,dev))
+					goto out; 
 
 				if (skb->stamp.tv_sec == 0 ||
 				    skb->pkt_type == PACKET_HOST ||
Index: net/ipv4/proc.c
===================================================================
RCS file: /cvs/linux/net/ipv4/proc.c,v
retrieving revision 1.44
diff -u -u -r1.44 proc.c
--- net/ipv4/proc.c	2000/08/09 11:59:04	1.44
+++ net/ipv4/proc.c	2001/01/21 10:52:42
@@ -194,10 +194,18 @@
 		      " TCPAbortOnMemory TCPAbortOnTimeout TCPAbortOnLinger"
 		      " TCPAbortFailed TCPMemoryPressures\n"
 		      "TcpExt:");
-	for (i=0; i<offsetof(struct linux_mib, __pad)/sizeof(unsigned long); i++)
+	for (i=0; i<offsetof(struct linux_mib, __tcp_pad)/sizeof(unsigned long); i++)
 		len += sprintf(buffer+len, " %lu", fold_field((unsigned long*)net_statistics, sizeof(struct linux_mib), i));
 
 	len += sprintf (buffer + len, "\n");
+
+	len += sprintf(buffer + len, 
+				"IpExt: ArpFilter\n"
+				"IpExt: %lu\n",
+			  fold_field((unsigned long *)net_statistics,
+				     sizeof(struct linux_mib), 
+				     offsetof(struct linux_mib,ArpFilter)/
+				     sizeof(unsigned long))); 
 
 	if (offset >= len)
 	{
Index: net/ipv4/devinet.c
===================================================================
RCS file: /cvs/linux/net/ipv4/devinet.c,v
retrieving revision 1.39
diff -u -u -r1.39 devinet.c
--- net/ipv4/devinet.c	2000/12/10 22:24:11	1.39
+++ net/ipv4/devinet.c	2001/01/21 10:52:43
@@ -773,7 +773,12 @@
 static int inetdev_event(struct notifier_block *this, unsigned long event, void *ptr)
 {
 	struct net_device *dev = ptr;
-	struct in_device *in_dev = __in_dev_get(dev);
+	struct in_device *in_dev;
+	
+	if (!dev) 
+		return NOTIFY_DONE; 
+
+	in_dev = __in_dev_get(dev);
 
 	ASSERT_RTNL();
 
@@ -817,13 +822,31 @@
 	case NETDEV_CHANGENAME:
 		if (in_dev->ifa_list) {
 			struct in_ifaddr *ifa;
-			for (ifa = in_dev->ifa_list; ifa; ifa = ifa->ifa_next)
+			for (ifa = in_dev->ifa_list; ifa; ifa = ifa->ifa_next) { 
+				char oldname[IFNAMSIZ]; 
+				char *alias; 
+				memcpy(oldname, ifa->ifa_label, IFNAMSIZ);
+				alias = strchr(oldname, ':');
 				memcpy(ifa->ifa_label, dev->name, IFNAMSIZ);
+				if (alias) {
+					strncat(ifa->ifa_label,alias,IFNAMSIZ-1-strlen(ifa->ifa_label));
+					ifa->ifa_label[IFNAMSIZ-1] = '\0';
+				} 
+			} 
 			/* Do not notify about label change, this event is
 			   not interesting to applications using netlink.
 			 */
 		}
 		break;
+#if 0		
+	case NETDEV_REBOOT:
+		if (dev->flags & IFF_DYNAMIC ) { 
+			for_primary_ifa(in_dev) {
+				notifier_call_chain(&inetaddr_chain, NETDEV_REBOOT, ifa); 
+			} endfor_ifa(in_dev); 
+ 		}
+ 		break;
+#endif		
 	}
 
 	return NOTIFY_DONE;
@@ -1053,16 +1076,16 @@
          &proc_dointvec},
 	{NET_IPV4_CONF_PROXY_ARP, "proxy_arp",
          &ipv4_devconf.proxy_arp, sizeof(int), 0644, NULL,
-         &proc_dointvec},
-	{NET_IPV4_CONF_BOOTP_RELAY, "bootp_relay",
-         &ipv4_devconf.bootp_relay, sizeof(int), 0644, NULL,
          &proc_dointvec},
-        {NET_IPV4_CONF_LOG_MARTIANS, "log_martians",
+	{NET_IPV4_CONF_LOG_MARTIANS, "log_martians",
          &ipv4_devconf.log_martians, sizeof(int), 0644, NULL,
          &proc_dointvec},
 	{NET_IPV4_CONF_TAG, "tag",
 	 &ipv4_devconf.tag, sizeof(int), 0644, NULL,
 	 &proc_dointvec},
+	{NET_IPV4_CONF_ARPFILTER, "arp_filter",
+          &ipv4_devconf.arp_filter, sizeof(int), 0644, NULL,
+          &proc_dointvec},
 	 {0}},
 
 	{{NET_PROTO_CONF_ALL, "all", NULL, 0, 0555, devinet_sysctl.devinet_vars},{0}},
Index: include/net/snmp.h
===================================================================
RCS file: /cvs/linux/include/net/snmp.h,v
retrieving revision 1.17
diff -u -u -r1.17 snmp.h
--- include/net/snmp.h	2000/09/21 01:31:50	1.17
+++ include/net/snmp.h	2001/01/21 10:52:43
@@ -254,6 +254,9 @@
 	unsigned long	TCPAbortOnLinger;
 	unsigned long	TCPAbortFailed;
 	unsigned long	TCPMemoryPressures;
+	unsigned long	__tcp_pad[0];
+	unsigned long	ArpFilter;
+	unsigned long	__ip_pad[0];
 	unsigned long   __pad[0];
 } ____cacheline_aligned;
 
Index: Documentation/networking/ip-sysctl.txt
===================================================================
RCS file: /cvs/linux/Documentation/networking/ip-sysctl.txt,v
retrieving revision 1.17
diff -u -u -r1.17 ip-sysctl.txt
--- Documentation/networking/ip-sysctl.txt	2000/11/06 07:15:36	1.17
+++ Documentation/networking/ip-sysctl.txt	2001/01/21 10:52:44
@@ -345,14 +345,6 @@
 send_redirects - BOOLEAN
 	Send redirects, if router. Default: TRUE
 
-bootp_relay - BOOLEAN
-	Accept packets with source address 0.b.c.d destined
-	not to this host as local ones. It is supposed, that
-	BOOTP relay daemon will catch and forward such packets.
-
-	default FALSE
-	Not Implemented Yet.
-
 accept_source_route - BOOLEAN
 	Accept packets with SRR option.
 	default TRUE (router)
@@ -369,6 +361,10 @@
 
 	Default value is 0. Note that some distributions enable it
 	in startip scripts.
+
+arp_filter - BOOLEAN
+	Only answer ARP requests on this device when the routing table would 
+	send packets to the source it to the same device.
 
 Alexey Kuznetsov.
 kuznet@ms2.inr.ac.ru

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
