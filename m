Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130647AbQKGOyw>; Tue, 7 Nov 2000 09:54:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129756AbQKGOym>; Tue, 7 Nov 2000 09:54:42 -0500
Received: from sith.mimuw.edu.pl ([193.0.97.1]:36359 "HELO sith.mimuw.edu.pl")
	by vger.kernel.org with SMTP id <S130650AbQKGOya>;
	Tue, 7 Nov 2000 09:54:30 -0500
Date: Tue, 7 Nov 2000 15:55:27 +0100
From: Jan Rekorajski <baggins@sith.mimuw.edu.pl>
To: kuznet@ms2.inr.ac.ru
Cc: davem@redhat.com, linux-kernel@vger.kernel.org
Subject: [PATCH] /proc/sys/net/ipv6/conf/*/autoconf_route
Message-ID: <20001107155527.F4686@sith.mimuw.edu.pl>
Mail-Followup-To: Jan Rekorajski <baggins@sith.mimuw.edu.pl>,
	kuznet@ms2.inr.ac.ru, davem@redhat.com,
	linux-kernel@vger.kernel.org
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="/WwmFnJnmDyWGHa4"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
User-Agent: Mutt/1.2.5i
X-Operating-System: Linux 2.4.0-test10 i686
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--/WwmFnJnmDyWGHa4
Content-Type: text/plain; charset=iso-8859-2
Content-Disposition: inline
Content-Transfer-Encoding: 8bit

Hi,
This patch adds /proc/sys/net/ipv6/conf/*/autoconf_route
that controls if default route is added or not if there are no routers
on the link, it also makes use of gcc struct initializers.
If putting new members inside a struct or enum is a wrong thing here
I can change it. The patch is against 2.4.0-test9,10.

Jan
-- 
Jan Rêkorajski            |  ALL SUSPECTS ARE GUILTY. PERIOD!
baggins<at>mimuw.edu.pl   |  OTHERWISE THEY WOULDN'T BE SUSPECTS, WOULD THEY?
BOFH, type MANIAC         |                   -- TROOPS by Kevin Rubio

--/WwmFnJnmDyWGHa4
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="autoconf_route.patch"

diff -ur linux.orig/include/linux/sysctl.h linux.v6/include/linux/sysctl.h
--- linux.orig/include/linux/sysctl.h	Fri Sep 22 23:21:22 2000
+++ linux.v6/include/linux/sysctl.h	Sat Oct 14 21:41:18 2000
@@ -342,10 +342,11 @@
 	NET_IPV6_ACCEPT_RA=4,
 	NET_IPV6_ACCEPT_REDIRECTS=5,
 	NET_IPV6_AUTOCONF=6,
-	NET_IPV6_DAD_TRANSMITS=7,
-	NET_IPV6_RTR_SOLICITS=8,
-	NET_IPV6_RTR_SOLICIT_INTERVAL=9,
-	NET_IPV6_RTR_SOLICIT_DELAY=10
+	NET_IPV6_AUTOCONF_ROUTE=7,
+	NET_IPV6_DAD_TRANSMITS=8,
+	NET_IPV6_RTR_SOLICITS=9,
+	NET_IPV6_RTR_SOLICIT_INTERVAL=10,
+	NET_IPV6_RTR_SOLICIT_DELAY=11
 };
 
 /* /proc/sys/net/<protocol>/neigh/<dev> */
diff -ur linux.orig/include/net/if_inet6.h linux.v6/include/net/if_inet6.h
--- linux.orig/include/net/if_inet6.h	Tue Sep 19 00:04:13 2000
+++ linux.v6/include/net/if_inet6.h	Sat Oct 14 21:38:40 2000
@@ -82,6 +82,7 @@
 	int		accept_ra;
 	int		accept_redirects;
 	int		autoconf;
+	int		autoconf_route;
 	int		dad_transmits;
 	int		rtr_solicits;
 	int		rtr_solicit_interval;
diff -ur linux.orig/net/ipv6/addrconf.c linux.v6/net/ipv6/addrconf.c
--- linux.orig/net/ipv6/addrconf.c	Wed May  3 10:48:03 2000
+++ linux.v6/net/ipv6/addrconf.c	Sun Oct 15 00:59:36 2000
@@ -21,6 +21,8 @@
  *	<chexum@bankinf.banki.hu>
  *	Andi Kleen			:	kill doube kfree on module
  *						unload.
+ *	Jan Rekorajski			:	added autoconf_route sysctl
+ *	<baggins@mimuw.edu.pl>
  */
 
 #include <linux/config.h>
@@ -96,30 +98,32 @@
 
 struct ipv6_devconf ipv6_devconf =
 {
-	0,				/* forwarding		*/
-	IPV6_DEFAULT_HOPLIMIT,		/* hop limit		*/
-	IPV6_MIN_MTU,			/* mtu			*/
-	1,				/* accept RAs		*/
-	1,				/* accept redirects	*/
-	1,				/* autoconfiguration	*/
-	1,				/* dad transmits	*/
-	MAX_RTR_SOLICITATIONS,		/* router solicits	*/
-	RTR_SOLICITATION_INTERVAL,	/* rtr solicit interval	*/
-	MAX_RTR_SOLICITATION_DELAY,	/* rtr solicit delay	*/
+	forwarding:		0,
+	hop_limit:		IPV6_DEFAULT_HOPLIMIT,
+	mtu6:			IPV6_MIN_MTU,
+	accept_ra:		1,
+	accept_redirects:	1,
+	autoconf:		1,
+	autoconf_route:		1,
+	dad_transmits:		1,
+	rtr_solicits:		MAX_RTR_SOLICITATIONS,
+	rtr_solicit_interval:	RTR_SOLICITATION_INTERVAL,
+	rtr_solicit_delay:	MAX_RTR_SOLICITATION_DELAY,
 };
 
 static struct ipv6_devconf ipv6_devconf_dflt =
 {
-	0,				/* forwarding		*/
-	IPV6_DEFAULT_HOPLIMIT,		/* hop limit		*/
-	IPV6_MIN_MTU,			/* mtu			*/
-	1,				/* accept RAs		*/
-	1,				/* accept redirects	*/
-	1,				/* autoconfiguration	*/
-	1,				/* dad transmits	*/
-	MAX_RTR_SOLICITATIONS,		/* router solicits	*/
-	RTR_SOLICITATION_INTERVAL,	/* rtr solicit interval	*/
-	MAX_RTR_SOLICITATION_DELAY,	/* rtr solicit delay	*/
+	forwarding:		0,
+	hop_limit:		IPV6_DEFAULT_HOPLIMIT,
+	mtu6:			IPV6_MIN_MTU,
+	accept_ra:		1,
+	accept_redirects:	1,
+	autoconf:		1,
+	autoconf_route:		1,
+	dad_transmits:		1,
+	rtr_solicits:		MAX_RTR_SOLICITATIONS,
+	rtr_solicit_interval:	RTR_SOLICITATION_INTERVAL,
+	rtr_solicit_delay:	MAX_RTR_SOLICITATION_DELAY,
 };
 
 int ipv6_addr_type(struct in6_addr *addr)
@@ -1430,15 +1434,17 @@
 		printk(KERN_DEBUG "%s: no IPv6 routers present\n",
 		       ifp->idev->dev->name);
 
-		memset(&rtmsg, 0, sizeof(struct in6_rtmsg));
-		rtmsg.rtmsg_type = RTMSG_NEWROUTE;
-		rtmsg.rtmsg_metric = IP6_RT_PRIO_ADDRCONF;
-		rtmsg.rtmsg_flags = (RTF_ALLONLINK | RTF_ADDRCONF | 
-				     RTF_DEFAULT | RTF_UP);
+		if (ifp->idev->cnf.autoconf_route) {
+			memset(&rtmsg, 0, sizeof(struct in6_rtmsg));
+			rtmsg.rtmsg_type = RTMSG_NEWROUTE;
+			rtmsg.rtmsg_metric = IP6_RT_PRIO_ADDRCONF;
+			rtmsg.rtmsg_flags = (RTF_ALLONLINK | RTF_ADDRCONF | 
+					     RTF_DEFAULT | RTF_UP);
 
-		rtmsg.rtmsg_ifindex = ifp->idev->dev->ifindex;
+			rtmsg.rtmsg_ifindex = ifp->idev->dev->ifindex;
 
-		ip6_route_add(&rtmsg);
+			ip6_route_add(&rtmsg);
+		}
 	}
 
 out:
@@ -1883,7 +1889,7 @@
 static struct addrconf_sysctl_table
 {
 	struct ctl_table_header *sysctl_header;
-	ctl_table addrconf_vars[11];
+	ctl_table addrconf_vars[12];
 	ctl_table addrconf_dev[2];
 	ctl_table addrconf_conf_dir[2];
 	ctl_table addrconf_proto_dir[2];
@@ -1912,6 +1918,10 @@
 
 	{NET_IPV6_AUTOCONF, "autoconf",
          &ipv6_devconf.autoconf, sizeof(int), 0644, NULL,
+         &proc_dointvec},
+
+	{NET_IPV6_AUTOCONF_ROUTE, "autoconf_route",
+         &ipv6_devconf.autoconf_route, sizeof(int), 0644, NULL,
          &proc_dointvec},
 
 	{NET_IPV6_DAD_TRANSMITS, "dad_transmits",

--/WwmFnJnmDyWGHa4--
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
