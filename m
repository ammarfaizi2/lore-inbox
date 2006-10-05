Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932148AbWJEPmR@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932148AbWJEPmR (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 5 Oct 2006 11:42:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932147AbWJEPmR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 5 Oct 2006 11:42:17 -0400
Received: from ironport-c10.fh-zwickau.de ([141.32.72.200]:8070 "EHLO
	ironport-c10.fh-zwickau.de") by vger.kernel.org with ESMTP
	id S932140AbWJEPmP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 5 Oct 2006 11:42:15 -0400
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-Anti-Spam-Result: AQAAABnFJEWMDg0
X-IronPort-AV: i="4.09,266,1157320800"; 
   d="scan'208"; a="3886489:sNHT43297232"
Date: Thu, 5 Oct 2006 17:41:52 +0200
From: Joerg Roedel <joro-lkml@zlug.org>
To: netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH][RFC] net/ipv6: seperate sit driver to extra module
Message-ID: <20061005154152.GA2102@zlug.org>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="UugvWAfsgieZRqgk"
Content-Disposition: inline
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--UugvWAfsgieZRqgk
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Is there a reason why the tunnel driver for IPv6-in-IPv4 is currently
compiled into the ipv6 module? This driver is only needed in gateways
between different IPv6 networks. On all other hosts with ipv6 enabled it
is not required. To have this driver in a seperate module will save
memory on those machines.
I appended a small and trival patch to 2.6.18 which does exactly this.

Joerg

--UugvWAfsgieZRqgk
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
+++ linux-2.6.18/net/ipv6/Kconfig	2006-10-05 17:07:11.000000000 +0200
@@ -126,6 +126,19 @@ config INET6_XFRM_MODE_TUNNEL
 
 	  If unsure, say Y.
 
+config IPV6_SIT
+	tristate "IPv6: IPv6-in-IPv4 tunnel (SIT driver)"
+	depends on IPV6
+	default n
+	---help---
+	  Tunneling means encapsulating data of one protocol type within
+	  another protocol and sending it over a channel that understands the
+	  encapsulating protocol. This driver implements encapsulation of IPv6
+	  into IPv4 packets. This is usefull if you want to connect two IPv6
+	  networks over an IPv4-only path.
+
+	  Saying M here will produce a module called sit.ko. If unsure, say N.
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

--UugvWAfsgieZRqgk--
