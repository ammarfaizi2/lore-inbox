Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932141AbWJFJeH@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932141AbWJFJeH (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 6 Oct 2006 05:34:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751381AbWJFJeH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 6 Oct 2006 05:34:07 -0400
Received: from ironport-c10.fh-zwickau.de ([141.32.72.200]:49769 "EHLO
	ironport-c10.fh-zwickau.de") by vger.kernel.org with ESMTP
	id S1751375AbWJFJeE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 6 Oct 2006 05:34:04 -0400
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-Anti-Spam-Result: AQAAAOG/JUWMEA0
X-IronPort-AV: i="4.09,270,1157320800"; 
   d="scan'208"; a="3915841:sNHT49980468"
Date: Fri, 6 Oct 2006 11:34:02 +0200
From: Joerg Roedel <joro-lkml@zlug.org>
To: netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
       David Miller <davem@davemloft.net>
Subject: [PATCH 01/02] net/ipv6: seperate sit driver to extra module
Message-ID: <20061006093402.GA12460@zlug.org>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="FCuugMFkClbJLl1L"
Content-Disposition: inline
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--FCuugMFkClbJLl1L
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

this is the submit of the patch discussed yesterday to compile the sit
driver as a seperate module.

changes to yesterday:
- default select changed to y in Kconfig
- added ifdefs to net/ipv6/addrconf.c
  (this part is big, to keep the patches around 100 lines the
   addrconf.c changes are posted in a seperate patch)

Signed-off-by: Joerg Roedel <joro-lkml@zlug.org>

--FCuugMFkClbJLl1L
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
+++ linux-2.6.18/net/ipv6/Kconfig	2006-10-05 18:14:57.000000000 +0200
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

--FCuugMFkClbJLl1L--
