Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261489AbULTHYS@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261489AbULTHYS (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 20 Dec 2004 02:24:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261497AbULTHXF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 20 Dec 2004 02:23:05 -0500
Received: from umhlanga.stratnet.net ([12.162.17.40]:16565 "EHLO
	umhlanga.STRATNET.NET") by vger.kernel.org with ESMTP
	id S261451AbULTGPP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 20 Dec 2004 01:15:15 -0500
Cc: openib-general@openib.org, netdev@oss.sgi.com
In-Reply-To: <200412192215.vegmgBmv5xungHlQ@topspin.com>
X-Mailer: Roland's Patchbomber
Date: Sun, 19 Dec 2004 22:15:14 -0800
Message-Id: <200412192215.69tnzAhGIT1vQGLF@topspin.com>
Mime-Version: 1.0
To: linux-kernel@vger.kernel.org
From: Roland Dreier <roland@topspin.com>
X-SA-Exim-Connect-IP: 127.0.0.1
X-SA-Exim-Mail-From: roland@topspin.com
Subject: [PATCH][v4][18/24] IPoIB IPv6 support
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
X-SA-Exim-Version: 4.1 (built Tue, 17 Aug 2004 11:06:07 +0200)
X-SA-Exim-Scanned: Yes (on eddore)
X-OriginalArrivalTime: 20 Dec 2004 06:15:14.0926 (UTC) FILETIME=[451E90E0:01C4E65B]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Add ipv6_ib_mc_map() to convert IPv6 multicast addresses to IPoIB
hardware addresses, and add support for autoconfiguration for devices
with type ARPHRD_INFINIBAND.

The mapping for multicast addresses is described in
  http://www.ietf.org/internet-drafts/draft-ietf-ipoib-ip-over-infiniband-08.txt

Signed-off-by: Nitin Hande <Nitin.Hande@Sun.Com>
Signed-off-by: Roland Dreier <roland@topspin.com>


--- linux-bk.orig/include/net/if_inet6.h	2004-12-19 21:09:54.000000000 -0800
+++ linux-bk/include/net/if_inet6.h	2004-12-19 22:04:17.213162542 -0800
@@ -266,5 +266,20 @@
 {
 	buf[0] = 0x00;
 }
+
+static inline void ipv6_ib_mc_map(struct in6_addr *addr, char *buf)
+{
+	buf[0]  = 0;		/* Reserved */
+	buf[1]  = 0xff;		/* Multicast QPN */
+	buf[2]  = 0xff;
+	buf[3]  = 0xff;
+	buf[4]  = 0xff;
+	buf[5]  = 0x12;		/* link local scope */
+	buf[6]  = 0x60;		/* IPv6 signature */
+	buf[7]  = 0x1b;
+	buf[8]  = 0;		/* P_Key */
+	buf[9]  = 0;
+	memcpy(buf + 10, addr->s6_addr + 6, 10);
+}
 #endif
 #endif
--- linux-bk.orig/net/ipv6/addrconf.c	2004-12-19 21:09:51.000000000 -0800
+++ linux-bk/net/ipv6/addrconf.c	2004-12-19 22:04:17.215162248 -0800
@@ -48,6 +48,7 @@
 #include <linux/netdevice.h>
 #include <linux/if_arp.h>
 #include <linux/if_arcnet.h>
+#include <linux/if_infiniband.h>
 #include <linux/route.h>
 #include <linux/inetdevice.h>
 #include <linux/init.h>
@@ -1095,6 +1096,12 @@
 		memset(eui, 0, 7);
 		eui[7] = *(u8*)dev->dev_addr;
 		return 0;
+	case ARPHRD_INFINIBAND:
+		if (dev->addr_len != INFINIBAND_ALEN)
+			return -1;
+		memcpy(eui, dev->dev_addr + 12, 8);
+		eui[0] |= 2;
+		return 0;
 	}
 	return -1;
 }
@@ -1794,7 +1801,8 @@
 	if ((dev->type != ARPHRD_ETHER) && 
 	    (dev->type != ARPHRD_FDDI) &&
 	    (dev->type != ARPHRD_IEEE802_TR) &&
-	    (dev->type != ARPHRD_ARCNET)) {
+	    (dev->type != ARPHRD_ARCNET) &&
+	    (dev->type != ARPHRD_INFINIBAND)) {
 		/* Alas, we support only Ethernet autoconfiguration. */
 		return;
 	}
--- linux-bk.orig/net/ipv6/ndisc.c	2004-12-19 21:09:20.000000000 -0800
+++ linux-bk/net/ipv6/ndisc.c	2004-12-19 22:04:17.216162100 -0800
@@ -260,6 +260,9 @@
 	case ARPHRD_ARCNET:
 		ipv6_arcnet_mc_map(addr, buf);
 		return 0;
+	case ARPHRD_INFINIBAND:
+		ipv6_ib_mc_map(addr, buf);
+		return 0;
 	default:
 		if (dir) {
 			memcpy(buf, dev->broadcast, dev->addr_len);

