Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S272136AbTHRPuL (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 18 Aug 2003 11:50:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S272132AbTHRPuL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 18 Aug 2003 11:50:11 -0400
Received: from tentacle.s2s.msu.ru ([193.232.119.109]:45548 "EHLO
	tentacle.sectorb.msk.ru") by vger.kernel.org with ESMTP
	id S272050AbTHRPtt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 18 Aug 2003 11:49:49 -0400
Date: Mon, 18 Aug 2003 19:49:46 +0400
From: "Vladimir B. Savkin" <master@sectorb.msk.ru>
To: Carlos Velasco <carlosev@newipnet.com>
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>, "David S. Miller" <davem@redhat.com>,
       Marcelo Tosatti <marcelo@conectiva.com.br>, netdev@oss.sgi.com,
       linux-net@vger.kernel.org,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: SRC IP selection in ARP request (Was: bugfix: ARP respond on all devices)
Message-ID: <20030818154945.GA32191@tentacle.sectorb.msk.ru>
References: <Pine.LNX.3.96.1030728222606.21100A-100000@gatekeeper.tmr.com> <20030728213933.F81299@coredump.scriptkiddie.org> <200308171509570955.003E4FEC@192.168.128.16> <200308171516090038.0043F977@192.168.128.16> <1061127715.21885.35.camel@dhcp23.swansea.linux.org.uk> <200308171555280781.0067FB36@192.168.128.16> <1061134091.21886.40.camel@dhcp23.swansea.linux.org.uk> <200308171759540391.00AA8CAB@192.168.128.16> <1061137577.21885.50.camel@dhcp23.swansea.linux.org.uk> <200308171827130739.00C3905F@192.168.128.16>
Mime-Version: 1.0
Content-Type: text/plain; charset=koi8-r
Content-Disposition: inline
In-Reply-To: <200308171827130739.00C3905F@192.168.128.16>
User-Agent: Mutt/1.3.28i
X-Organization: Moscow State Univ., Dept. of Mechanics and Mathematics
X-Operating-System: Linux 2.4.22-rc2
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Aug 17, 2003 at 06:27:13PM +0200, Carlos Velasco wrote:
> If you send a packet through dev eth0 to dev lo IP address or other
                                        ^^
	Did you mean "from"?

> interface, when Linux try to map the MAC address with the IP address of
> the default gateway (or the gateway to reach the packet Source IP
> address), it uses the lo IP address (or other dev) in the ARP Request.

I think I saw this problem, but in another situation:
Suppose we are the server and have TCP connection established,
using src address 10.0.0.1 (because the client have chosen this address 
to connect to). But the route to the client leads via gateway 10.1.0.1,
reachable through dev eth0. We have address 10.1.0.2/24 assigned to
eth0. All is fine until ARP table entry for 10.1.0.1 is expired and
we start to send ARP requests. We choose 10.0.0.1 for src ip in the
requests, because that's what upper layer uses, and gateway doesn't
respond because it's Cisco or BSD.

I didn't test arpfilter (I think it wasn't there when I met this
problem), but it can be solved with the following simple patch
(implemented as a new per-interface sysctl). I just tested it, works for
me. echo 1 > /proc/sys/net/ipv4/conf/all/arp_select_clean_src

diff -ur _orig_linux/include/linux/inetdevice.h linux/include/linux/inetdevice.h
--- _orig_linux/include/linux/inetdevice.h	Mon Aug 11 13:24:51 2003
+++ linux/include/linux/inetdevice.h	Mon Aug 18 18:21:30 2003
@@ -18,6 +18,7 @@
 	int	mc_forwarding;
 	int	tag;
 	int     arp_filter;
+	int 	arp_select_clean_src;
 	int	medium_id;
 	void	*sysctl;
 };
@@ -68,6 +69,7 @@
 	  (ipv4_devconf.accept_redirects || (in_dev)->cnf.accept_redirects)))
 
 #define IN_DEV_ARPFILTER(in_dev)	(ipv4_devconf.arp_filter || (in_dev)->cnf.arp_filter)
+#define IN_DEV_ARP_CLEAN_SRC(in_dev)	(ipv4_devconf.arp_select_clean_src || (in_dev)->cnf.arp_select_clean_src)
 
 struct in_ifaddr
 {
diff -ur _orig_linux/include/linux/sysctl.h linux/include/linux/sysctl.h
--- _orig_linux/include/linux/sysctl.h	Mon Aug 11 13:28:18 2003
+++ linux/include/linux/sysctl.h	Mon Aug 18 18:52:01 2003
@@ -349,6 +349,7 @@
 	NET_IPV4_CONF_TAG=12,
 	NET_IPV4_CONF_ARPFILTER=13,
 	NET_IPV4_CONF_MEDIUM_ID=14,
+	NET_IPV4_CONF_ARPSRC=15,
 };
 
 /* /proc/sys/net/ipv6 */
diff -ur _orig_linux/net/ipv4/arp.c linux/net/ipv4/arp.c
--- _orig_linux/net/ipv4/arp.c	Mon Aug 11 13:24:52 2003
+++ linux/net/ipv4/arp.c	Mon Aug 18 18:36:44 2003
@@ -322,8 +322,20 @@
 	struct net_device *dev = neigh->dev;
 	u32 target = *(u32*)neigh->primary_key;
 	int probes = atomic_read(&neigh->probes);
+	int inherit_src;
+	struct in_device *in_dev;
 
-	if (skb && inet_addr_type(skb->nh.iph->saddr) == RTN_LOCAL)
+	read_lock(&inetdev_lock);
+	in_dev = __in_dev_get(dev);
+	if (in_dev != NULL) {
+		inherit_src = !IN_DEV_ARP_CLEAN_SRC(in_dev);
+	} else {
+		inherit_src = 1;
+	}
+	read_unlock(&inetdev_lock);
+
+	if ( inherit_src &&
+		  skb && inet_addr_type(skb->nh.iph->saddr) == RTN_LOCAL)
 		saddr = skb->nh.iph->saddr;
 	else
 		saddr = inet_select_addr(dev, target, RT_SCOPE_LINK);
diff -ur _orig_linux/net/ipv4/devinet.c linux/net/ipv4/devinet.c
--- _orig_linux/net/ipv4/devinet.c	Fri Jun 13 18:51:39 2003
+++ linux/net/ipv4/devinet.c	Mon Aug 18 18:54:07 2003
@@ -1056,7 +1056,7 @@
 static struct devinet_sysctl_table
 {
 	struct ctl_table_header *sysctl_header;
-	ctl_table devinet_vars[15];
+	ctl_table devinet_vars[16];
 	ctl_table devinet_dev[2];
 	ctl_table devinet_conf_dir[2];
 	ctl_table devinet_proto_dir[2];
@@ -1104,6 +1104,9 @@
 	 &proc_dointvec},
 	{NET_IPV4_CONF_ARPFILTER, "arp_filter",
 	 &ipv4_devconf.arp_filter, sizeof(int), 0644, NULL,
+	 &proc_dointvec},
+	{NET_IPV4_CONF_ARPSRC, "arp_select_clean_src",
+	 &ipv4_devconf.arp_select_clean_src, sizeof(int), 0644, NULL,
 	 &proc_dointvec},
 	 {0}},
 

:wq
                                        With best regards, 
                                           Vladimir Savkin. 

