Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965302AbWFIVI3@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965302AbWFIVI3 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 9 Jun 2006 17:08:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030489AbWFIVGh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 9 Jun 2006 17:06:37 -0400
Received: from AToulouse-252-1-74-163.w81-49.abo.wanadoo.fr ([81.49.44.163]:6867
	"EHLO localhost.localdomain") by vger.kernel.org with ESMTP
	id S1030488AbWFIVGg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 9 Jun 2006 17:06:36 -0400
Message-Id: <20060609210629.099136000@localhost.localdomain>
References: <20060609210202.215291000@localhost.localdomain>
Date: Fri, 09 Jun 2006 23:02:06 +0200
From: dlezcano@fr.ibm.com
To: linux-kernel@vger.kernel.org, netdev@vger.kernel.org
Cc: serue@us.ibm.com, haveblue@us.ibm.com, clg@fr.ibm.com, dlezcano@fr.ibm.com
Subject: [RFC] [patch 4/6] [Network namespace] Network inet devices isolation 
Content-Disposition: inline; filename=inetdev_isolation.patch
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The network isolation relies on the fact that an application can not
use IP addresses not belonging to the container in which it's
running. This patch isolates the inet device level by adding a
structure namespace pointer in the structure in_ifaddr. When an ip
address is set inside a network namespace, the structure in_ifaddr is
filled with the current namespace pointer. There is a special case
with loopback address which belongs to all the namespaces and its
particularity is to have the network namespace pointer set to NULL.
This patch isolates the ifconfig, ip addr commands, so when an IP
address is set, this one it is not visible by another network
namespaces.

Replace-Subject: [Network namespace] Network inet devices isolation 
Signed-off-by: Daniel Lezcano <dlezcano@fr.ibm.com> 
--
 include/linux/inetdevice.h |    1 +
 net/ipv4/devinet.c         |   28 +++++++++++++++++++++++++++-
 2 files changed, 28 insertions(+), 1 deletion(-)

Index: 2.6-mm/include/linux/inetdevice.h
===================================================================
--- 2.6-mm.orig/include/linux/inetdevice.h
+++ 2.6-mm/include/linux/inetdevice.h
@@ -99,6 +99,7 @@
 	unsigned char		ifa_flags;
 	unsigned char		ifa_prefixlen;
 	char			ifa_label[IFNAMSIZ];
+	struct net_namespace    *ifa_net_ns;
 };
 
 extern int register_inetaddr_notifier(struct notifier_block *nb);
Index: 2.6-mm/net/ipv4/devinet.c
===================================================================
--- 2.6-mm.orig/net/ipv4/devinet.c
+++ 2.6-mm/net/ipv4/devinet.c
@@ -54,6 +54,7 @@
 #include <linux/notifier.h>
 #include <linux/inetdevice.h>
 #include <linux/igmp.h>
+#include <linux/net_ns.h>
 #ifdef CONFIG_SYSCTL
 #include <linux/sysctl.h>
 #endif
@@ -257,6 +258,7 @@
 
 			if (!(ifa->ifa_flags & IFA_F_SECONDARY) ||
 			    ifa1->ifa_mask != ifa->ifa_mask ||
+			    ifa->ifa_net_ns != net_ns() ||
 			    !inet_ifa_match(ifa1->ifa_address, ifa)) {
 				ifap1 = &ifa->ifa_next;
 				prev_prom = ifa;
@@ -317,6 +319,8 @@
 	if (destroy) {
 		inet_free_ifa(ifa1);
 
+		put_net_ns(ifa1->ifa_net_ns);
+
 		if (!in_dev->ifa_list)
 			inetdev_destroy(in_dev);
 	}
@@ -343,6 +347,7 @@
 		    ifa->ifa_scope <= ifa1->ifa_scope)
 			last_primary = &ifa1->ifa_next;
 		if (ifa1->ifa_mask == ifa->ifa_mask &&
+		    ifa1->ifa_net_ns == ifa->ifa_net_ns &&
 		    inet_ifa_match(ifa1->ifa_address, ifa)) {
 			if (ifa1->ifa_local == ifa->ifa_local) {
 				inet_free_ifa(ifa);
@@ -437,6 +442,8 @@
 
 	for (ifap = &in_dev->ifa_list; (ifa = *ifap) != NULL;
 	     ifap = &ifa->ifa_next) {
+		if (ifa->ifa_net_ns != net_ns())
+			continue;
 		if ((rta[IFA_LOCAL - 1] &&
 		     memcmp(RTA_DATA(rta[IFA_LOCAL - 1]),
 			    &ifa->ifa_local, 4)) ||
@@ -497,6 +504,9 @@
 	ifa->ifa_scope = ifm->ifa_scope;
 	in_dev_hold(in_dev);
 	ifa->ifa_dev   = in_dev;
+	ifa->ifa_net_ns = net_ns();
+	get_net_ns(net_ns());
+
 	if (rta[IFA_LABEL - 1])
 		rtattr_strlcpy(ifa->ifa_label, rta[IFA_LABEL - 1], IFNAMSIZ);
 	else
@@ -631,10 +641,15 @@
 			for (ifap = &in_dev->ifa_list; (ifa = *ifap) != NULL;
 			     ifap = &ifa->ifa_next)
 				if (!strcmp(ifr.ifr_name, ifa->ifa_label))
-					break;
+					if (!ifa->ifa_net_ns ||
+					    ifa->ifa_net_ns == net_ns())
+						break;
 		}
 	}
 
+	if (ifa && ifa->ifa_net_ns && ifa->ifa_net_ns != net_ns())
+		goto done;
+
 	ret = -EADDRNOTAVAIL;
 	if (!ifa && cmd != SIOCSIFADDR && cmd != SIOCSIFFLAGS)
 		goto done;
@@ -678,6 +693,12 @@
 			ret = -ENOBUFS;
 			if ((ifa = inet_alloc_ifa()) == NULL)
 				break;
+			if (!LOOPBACK(sin->sin_addr.s_addr)) {
+				ifa->ifa_net_ns = net_ns();
+				get_net_ns(net_ns());
+			} else
+				ifa->ifa_net_ns = NULL;
+
 			if (colon)
 				memcpy(ifa->ifa_label, ifr.ifr_name, IFNAMSIZ);
 			else
@@ -782,6 +803,8 @@
 		goto out;
 
 	for (; ifa; ifa = ifa->ifa_next) {
+		if (ifa->ifa_net_ns && ifa->ifa_net_ns != net_ns())
+			continue;
 		if (!buf) {
 			done += sizeof(ifr);
 			continue;
@@ -1012,6 +1035,7 @@
 				  ifa->ifa_address = htonl(INADDR_LOOPBACK);
 				ifa->ifa_prefixlen = 8;
 				ifa->ifa_mask = inet_make_mask(8);
+				ifa->ifa_net_ns = NULL;
 				in_dev_hold(in_dev);
 				ifa->ifa_dev = in_dev;
 				ifa->ifa_scope = RT_SCOPE_HOST;
@@ -1110,6 +1134,8 @@
 
 		for (ifa = in_dev->ifa_list, ip_idx = 0; ifa;
 		     ifa = ifa->ifa_next, ip_idx++) {
+			if (ifa->ifa_net_ns && ifa->ifa_net_ns != net_ns())
+				continue;
 			if (ip_idx < s_ip_idx)
 				continue;
 			if (inet_fill_ifaddr(skb, ifa, NETLINK_CB(cb->skb).pid,

--
