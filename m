Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S310387AbSCBOhN>; Sat, 2 Mar 2002 09:37:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S310388AbSCBOhE>; Sat, 2 Mar 2002 09:37:04 -0500
Received: from minus.inr.ac.ru ([193.233.7.97]:54542 "HELO ms2.inr.ac.ru")
	by vger.kernel.org with SMTP id <S310387AbSCBOgx>;
	Sat, 2 Mar 2002 09:36:53 -0500
From: kuznet@ms2.inr.ac.ru
Message-Id: <200203021436.RAA20557@ms2.inr.ac.ru>
Subject: Re: OOPS: Multipath routing 2.4.17
To: ja@ssi.bg (Julian Anastasov)
Date: Sat, 2 Mar 2002 17:36:26 +0300 (MSK)
Cc: kain@kain.org, linux-kernel@vger.kernel.org, ak@suse.de
In-Reply-To: <Pine.LNX.4.44.0203021519010.4102-100000@u.domain.uli> from "Julian Anastasov" at Mar 2, 2 03:28:34 pm
X-Mailer: ELM [version 2.4 PL24]
MIME-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello!

> 	What about the new scheduler (for 2.5?), of course, after
> replacing the wrong write_lock() with spin_lock_bh(&fib_nh_powers) ?

I do not see any reasons not to do this.
I remember your approach had some inacceptable issues, but 2.5 is exactly
the place to resolve them. :-)

But actually I would like to see a fix for 2.4 for beginning.
The failure with orphaned DEADs was hard bug yet. Minute...
I remember I did some work to make a minimalistic fix...

Aha! That's it. Please, look at this _carefully_. It is going
to be submitted to 2.4 and mistakes are not allowed here.
Look especially at the differences of your approach both about
medium_id and DEAD fault.

Alexey


diff -ur ../vger3-020202/linux/Documentation/networking/ip-sysctl.txt linux/Documentation/networking/ip-sysctl.txt
--- ../vger3-020202/linux/Documentation/networking/ip-sysctl.txt	Sat Dec 29 22:29:46 2001
+++ linux/Documentation/networking/ip-sysctl.txt	Sat Feb  2 22:58:40 2002
@@ -182,10 +188,7 @@
 	still did not receive an acknowledgement from connecting client.
 	Default value is 1024 for systems with more than 128Mb of memory,
 	and 128 for low memory machines. If server suffers of overload,
-	try to increase this number. Warning! If you make it greater
-	than 1024, it would be better to change TCP_SYNQ_HSIZE in
-	include/net/tcp.h to keep TCP_SYNQ_HSIZE*16<=tcp_max_syn_backlog
-	and to recompile kernel.
+	try to increase this number.
 
 tcp_window_scaling - BOOLEAN
 	Enable window scaling as defined in RFC1323.
@@ -357,6 +360,17 @@
 mc_forwarding - BOOLEAN
 	Do multicast routing. The kernel needs to be compiled with CONFIG_MROUTE
 	and a multicast routing daemon is required.
+
+medium_id - INTEGER
+	Integer value used to differentiate the devices by the medium they
+	are attached to. Two devices can have different id values when
+	the broadcast packets are received only on one of them.
+	The default value 0 means that the device is the only interface
+	to its medium, value of -1 means that medium is not known.
+	
+	Currently, it is used to change the proxy_arp behavior:
+	the proxy_arp feature is enabled for packets forwarded between
+	two devices attached to different media.
 
 proxy_arp - BOOLEAN
 	Do proxy arp.
diff -ur ../vger3-020202/linux/include/linux/inetdevice.h linux/include/linux/inetdevice.h
--- ../vger3-020202/linux/include/linux/inetdevice.h	Sat Jul 28 23:03:33 2001
+++ linux/include/linux/inetdevice.h	Sat Feb  2 22:58:40 2002
@@ -18,6 +18,7 @@
 	int	mc_forwarding;
 	int	tag;
 	int     arp_filter;
+	int	medium_id;
 	void	*sysctl;
 };
 
@@ -48,6 +49,7 @@
 #define IN_DEV_TX_REDIRECTS(in_dev)	(ipv4_devconf.send_redirects || (in_dev)->cnf.send_redirects)
 #define IN_DEV_SEC_REDIRECTS(in_dev)	(ipv4_devconf.secure_redirects || (in_dev)->cnf.secure_redirects)
 #define IN_DEV_IDTAG(in_dev)		((in_dev)->cnf.tag)
+#define IN_DEV_MEDIUM_ID(in_dev)	((in_dev)->cnf.medium_id)
 
 #define IN_DEV_RX_REDIRECTS(in_dev) \
 	((IN_DEV_FORWARD(in_dev) && \
diff -ur ../vger3-020202/linux/include/linux/sysctl.h linux/include/linux/sysctl.h
--- ../vger3-020202/linux/include/linux/sysctl.h	Mon Dec  3 20:24:00 2001
+++ linux/include/linux/sysctl.h	Sat Feb  2 22:58:40 2002
@@ -334,7 +336,8 @@
 	NET_IPV4_CONF_BOOTP_RELAY=10,
 	NET_IPV4_CONF_LOG_MARTIANS=11,
 	NET_IPV4_CONF_TAG=12,
-	NET_IPV4_CONF_ARPFILTER=13
+	NET_IPV4_CONF_ARPFILTER=13,
+	NET_IPV4_CONF_MEDIUM_ID=14,
 };
 
 /* /proc/sys/net/ipv6 */
diff -ur ../vger3-020202/linux/net/ipv4/arp.c linux/net/ipv4/arp.c
--- ../vger3-020202/linux/net/ipv4/arp.c	Sat Oct 13 20:56:37 2001
+++ linux/net/ipv4/arp.c	Sat Feb  2 22:58:40 2002
@@ -450,6 +450,32 @@
 }
 
 /*
+ * Check if we can use proxy ARP for this path
+ */
+
+static inline int arp_fwd_proxy(struct in_device *in_dev, struct rtable *rt)
+{
+	struct in_device *out_dev;
+	int imi, omi = -1;
+
+	if (!IN_DEV_PROXY_ARP(in_dev))
+		return 0;
+
+	if ((imi = IN_DEV_MEDIUM_ID(in_dev)) == 0)
+		return 1;
+	if (imi == -1)
+		return 0;
+
+	/* place to check for proxy_arp for routes */
+
+	if ((out_dev = in_dev_get(rt->u.dst.dev)) != NULL) {
+		omi = IN_DEV_MEDIUM_ID(out_dev);
+		in_dev_put(out_dev);
+	}
+	return (omi != imi && omi != -1);
+}
+
+/*
  *	Interface to link layer: send routine and receive handler.
  */
 
@@ -768,7 +794,7 @@
 		} else if (IN_DEV_FORWARD(in_dev)) {
 			if ((rt->rt_flags&RTCF_DNAT) ||
 			    (addr_type == RTN_UNICAST  && rt->u.dst.dev != dev &&
-			     (IN_DEV_PROXY_ARP(in_dev) || pneigh_lookup(&arp_tbl, &tip, dev, 0)))) {
+			     (arp_fwd_proxy(in_dev, rt) || pneigh_lookup(&arp_tbl, &tip, dev, 0)))) {
 				n = neigh_event_ns(&arp_tbl, sha, &sip, dev);
 				if (n)
 					neigh_release(n);
diff -ur ../vger3-020202/linux/net/ipv4/devinet.c linux/net/ipv4/devinet.c
--- ../vger3-020202/linux/net/ipv4/devinet.c	Thu Nov  1 23:35:22 2001
+++ linux/net/ipv4/devinet.c	Sat Feb  2 22:58:40 2002
@@ -1032,7 +1032,7 @@
 static struct devinet_sysctl_table
 {
 	struct ctl_table_header *sysctl_header;
-	ctl_table devinet_vars[14];
+	ctl_table devinet_vars[15];
 	ctl_table devinet_dev[2];
 	ctl_table devinet_conf_dir[2];
 	ctl_table devinet_proto_dir[2];
@@ -1065,6 +1065,9 @@
          &proc_dointvec},
 	{NET_IPV4_CONF_PROXY_ARP, "proxy_arp",
          &ipv4_devconf.proxy_arp, sizeof(int), 0644, NULL,
+         &proc_dointvec},
+	{NET_IPV4_CONF_MEDIUM_ID, "medium_id",
+         &ipv4_devconf.medium_id, sizeof(int), 0644, NULL,
          &proc_dointvec},
 	{NET_IPV4_CONF_BOOTP_RELAY, "bootp_relay",
          &ipv4_devconf.bootp_relay, sizeof(int), 0644, NULL,
diff -ur ../vger3-020202/linux/net/ipv4/fib_frontend.c linux/net/ipv4/fib_frontend.c
--- ../vger3-020202/linux/net/ipv4/fib_frontend.c	Thu Nov  1 23:35:22 2001
+++ linux/net/ipv4/fib_frontend.c	Sat Feb  2 22:58:40 2002
@@ -579,6 +579,9 @@
 	switch (event) {
 	case NETDEV_UP:
 		fib_add_ifaddr(ifa);
+#ifdef CONFIG_IP_ROUTE_MULTIPATH
+		fib_sync_up(ifa->ifa_dev->dev);
+#endif
 		rt_cache_flush(-1);
 		break;
 	case NETDEV_DOWN:
diff -ur ../vger3-020202/linux/net/ipv4/fib_semantics.c linux/net/ipv4/fib_semantics.c
--- ../vger3-020202/linux/net/ipv4/fib_semantics.c	Mon Jan 14 20:14:43 2002
+++ linux/net/ipv4/fib_semantics.c	Sat Feb  2 22:58:40 2002
@@ -871,6 +871,10 @@
 #ifdef CONFIG_IP_ROUTE_MULTIPATH
 					fi->fib_power -= nh->nh_power;
 					nh->nh_power = 0;
+					if (force && nh->nh_dev) {
+						dev_put(nh->nh_dev);
+						nh->nh_dev = NULL;
+					}
 #endif
 					dead++;
 				}
@@ -905,6 +909,10 @@
 			if (!(nh->nh_flags&RTNH_F_DEAD)) {
 				alive++;
 				continue;
+			}
+			if (nh->nh_dev == NULL && nh->nh_oif == dev->ifindex) {
+				dev_hold(dev);
+				nh->nh_dev = dev;
 			}
 			if (nh->nh_dev == NULL || !(nh->nh_dev->flags&IFF_UP))
 				continue;
