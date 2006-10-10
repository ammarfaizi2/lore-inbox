Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750883AbWJJPhu@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750883AbWJJPhu (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 10 Oct 2006 11:37:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750893AbWJJPhu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 10 Oct 2006 11:37:50 -0400
Received: from ironport-c10.fh-zwickau.de ([141.32.72.200]:15168 "EHLO
	ironport-c10.fh-zwickau.de") by vger.kernel.org with ESMTP
	id S1750877AbWJJPht (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 10 Oct 2006 11:37:49 -0400
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-Anti-Spam-Result: AQAAAPpaK0WMEgIN
X-IronPort-AV: i="4.09,291,1157320800"; 
   d="scan'208"; a="4088835:sNHT42469696"
Date: Tue, 10 Oct 2006 17:37:45 +0200
From: Joerg Roedel <joro-lkml@zlug.org>
To: netdev@vger.kernel.org, David Miller <davem@davemloft.net>,
       linux-kernel@vger.kernel.org
Subject: [PATCH 01/02 V3] net/ipv6: seperate sit driver to extra module
Message-ID: <20061010153745.GA27455@zlug.org>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="mYCpIKhGyMATD0i+"
Content-Disposition: inline
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--mYCpIKhGyMATD0i+
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

This patch removes the driver of the IPv6-in-IPv4 tunnel driver (sit)
from the IPv6 module. It adds an option to Kconfig which makes it
possible to compile it as a seperate module.

Signed-off-by: Joerg Roedel <joro-lkml@zlug.org>

--mYCpIKhGyMATD0i+
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename=patch_sit_as_module

diff -upr -X linux-2.6.18/Documentation/dontdiff linux-2.6.18-vanilla/net/ipv6/af_inet6.c linux-2.6.18/net/ipv6/af_inet6.c
--- linux-2.6.18-vanilla/net/ipv6/af_inet6.c	2006-09-20 05:42:06.000000000 +0200
+++ linux-2.6.18/net/ipv6/af_inet6.c	2006-10-05 16:55:02.000000000 +0200
@@ -849,7 +849,6 @@ static int __init inet6_init(void)
 	err = addrconf_init();
 	if (err)
 		goto addrconf_fail;
-	sit_init();
 
 	/* Init v6 extension headers. */
 	ipv6_rthdr_init();
@@ -920,7 +919,6 @@ static void __exit inet6_exit(void)
  	raw6_proc_exit();
 #endif
 	/* Cleanup code parts. */
-	sit_cleanup();
 	ip6_flowlabel_cleanup();
 	addrconf_cleanup();
 	ip6_route_cleanup();
diff -upr -X linux-2.6.18/Documentation/dontdiff linux-2.6.18-vanilla/net/ipv6/Kconfig linux-2.6.18/net/ipv6/Kconfig
--- linux-2.6.18-vanilla/net/ipv6/Kconfig	2006-09-20 05:42:06.000000000 +0200
+++ linux-2.6.18/net/ipv6/Kconfig	2006-10-09 11:16:37.000000000 +0200
@@ -126,6 +126,19 @@ config INET6_XFRM_MODE_TUNNEL
 
 	  If unsure, say Y.
 
+config IPV6_SIT
+	tristate "IPv6: IPv6-in-IPv4 tunnel (SIT driver)"
+	depends on IPV6
+	default y
+	---help---
+	  Tunneling means encapsulating data of one protocol type within
+	  another protocol and sending it over a channel that understands the
+	  encapsulating protocol. This driver implements encapsulation of IPv6
+	  into IPv4 packets. This is useful if you want to connect two IPv6
+	  networks over an IPv4-only path.
+
+	  Saying M here will produce a module called sit.ko. If unsure, say Y.
+
 config IPV6_TUNNEL
 	tristate "IPv6: IPv6-in-IPv6 tunnel"
 	select INET6_TUNNEL
diff -upr -X linux-2.6.18/Documentation/dontdiff linux-2.6.18-vanilla/net/ipv6/Makefile linux-2.6.18/net/ipv6/Makefile
--- linux-2.6.18-vanilla/net/ipv6/Makefile	2006-09-20 05:42:06.000000000 +0200
+++ linux-2.6.18/net/ipv6/Makefile	2006-10-05 17:10:42.000000000 +0200
@@ -4,7 +4,7 @@
 
 obj-$(CONFIG_IPV6) += ipv6.o
 
-ipv6-objs :=	af_inet6.o anycast.o ip6_output.o ip6_input.o addrconf.o sit.o \
+ipv6-objs :=	af_inet6.o anycast.o ip6_output.o ip6_input.o addrconf.o \
 		route.o ip6_fib.o ipv6_sockglue.o ndisc.o udp.o raw.o \
 		protocol.o icmp.o mcast.o reassembly.o tcp_ipv6.o \
 		exthdrs.o sysctl_net_ipv6.o datagram.o proc.o \
@@ -24,6 +24,7 @@ obj-$(CONFIG_INET6_XFRM_MODE_TRANSPORT) 
 obj-$(CONFIG_INET6_XFRM_MODE_TUNNEL) += xfrm6_mode_tunnel.o
 obj-$(CONFIG_NETFILTER)	+= netfilter/
 
+obj-$(CONFIG_IPV6_SIT) += sit.o
 obj-$(CONFIG_IPV6_TUNNEL) += ip6_tunnel.o
 
 obj-y += exthdrs_core.o
diff -upr -X linux-2.6.18/Documentation/dontdiff linux-2.6.18-vanilla/net/ipv6/sit.c linux-2.6.18/net/ipv6/sit.c
--- linux-2.6.18-vanilla/net/ipv6/sit.c	2006-09-20 05:42:06.000000000 +0200
+++ linux-2.6.18/net/ipv6/sit.c	2006-10-05 16:55:02.000000000 +0200
@@ -850,3 +850,6 @@ int __init sit_init(void)
 	inet_del_protocol(&sit_protocol, IPPROTO_IPV6);
 	goto out;
 }
+
+module_init(sit_init);
+module_exit(sit_cleanup);

--mYCpIKhGyMATD0i+--
