Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261586AbUKVPlI@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261586AbUKVPlI (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 22 Nov 2004 10:41:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261460AbUKVPjS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 22 Nov 2004 10:39:18 -0500
Received: from umhlanga.stratnet.net ([12.162.17.40]:51139 "EHLO
	umhlanga.STRATNET.NET") by vger.kernel.org with ESMTP
	id S261370AbUKVPOA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 22 Nov 2004 10:14:00 -0500
Cc: openib-general@openib.org, netdev@oss.sgi.com
In-Reply-To: <20041122713.cSeT4UFKGqJDdZ8T@topspin.com>
X-Mailer: roland_patchbomb
Date: Mon, 22 Nov 2004 07:13:54 -0800
Message-Id: <20041122713.Md0y3UqVvYcRT3Zf@topspin.com>
Mime-Version: 1.0
To: linux-kernel@vger.kernel.org
From: Roland Dreier <roland@topspin.com>
X-SA-Exim-Connect-IP: 127.0.0.1
X-SA-Exim-Mail-From: roland@topspin.com
Subject: [PATCH][RFC/v1][6/12] IPoIB IPv4 multicast
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
X-SA-Exim-Version: 4.1 (built Tue, 17 Aug 2004 11:06:07 +0200)
X-SA-Exim-Scanned: Yes (on eddore)
X-OriginalArrivalTime: 22 Nov 2004 15:13:59.0540 (UTC) FILETIME=[E4863B40:01C4D0A5]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Add ip_ib_mc_map() to convert IPv4 multicast addresses to IPoIB
hardware addresses.  Also add <linux/if_infiniband.h> so INFINIBAND_ALEN
has a home.

The mapping for multicast addresses is described in
  http://www.ietf.org/internet-drafts/draft-ietf-ipoib-ip-over-infiniband-07.txt

Signed-off-by: Roland Dreier <roland@topspin.com>


Index: linux-bk/include/linux/if_infiniband.h
===================================================================
--- /dev/null	1970-01-01 00:00:00.000000000 +0000
+++ linux-bk/include/linux/if_infiniband.h	2004-11-21 21:25:56.078881371 -0800
@@ -0,0 +1,29 @@
+/*
+ * This software is available to you under a choice of one of two
+ * licenses.  You may choose to be licensed under the terms of the GNU
+ * General Public License (GPL) Version 2, available at
+ * <http://www.fsf.org/copyleft/gpl.html>, or the OpenIB.org BSD
+ * license, available in the LICENSE.TXT file accompanying this
+ * software.  These details are also available at
+ * <http://openib.org/license.html>.
+ *
+ * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND,
+ * EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF
+ * MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND
+ * NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS
+ * BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN
+ * ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN
+ * CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
+ * SOFTWARE.
+ *
+ * Copyright (c) 2004 Topspin Communications.  All rights reserved.
+ *
+ * $Id$
+ */
+
+#ifndef _LINUX_IF_INFINIBAND_H
+#define _LINUX_IF_INFINIBAND_H
+
+#define INFINIBAND_ALEN		20	/* Octets in IPoIB HW addr	*/
+
+#endif /* _LINUX_IF_INFINIBAND_H */
Index: linux-bk/include/net/ip.h
===================================================================
--- linux-bk.orig/include/net/ip.h	2004-11-21 21:07:12.110687532 -0800
+++ linux-bk/include/net/ip.h	2004-11-21 21:25:56.078881371 -0800
@@ -229,6 +229,39 @@
 	buf[3]=addr&0x7F;
 }
 
+/*
+ *	Map a multicast IP onto multicast MAC for type IP-over-InfiniBand.
+ *	Leave P_Key as 0 to be filled in by driver.
+ */
+
+static inline void ip_ib_mc_map(u32 addr, char *buf)
+{
+	buf[0]  = 0;		/* Reserved */
+	buf[1]  = 0xff;		/* Multicast QPN */
+	buf[2]  = 0xff;
+	buf[3]  = 0xff;
+	addr    = ntohl(addr);
+	buf[4]  = 0xff;
+	buf[5]  = 0x12;		/* link local scope */
+	buf[6]  = 0x40;		/* IPv4 signature */
+	buf[7]  = 0x1b;
+	buf[8]  = 0;		/* P_Key */
+	buf[9]  = 0;
+	buf[10] = 0;
+	buf[11] = 0;
+	buf[12] = 0;
+	buf[13] = 0;
+	buf[14] = 0;
+	buf[15] = 0;
+	buf[19] = addr & 0xff;
+	addr  >>= 8;
+	buf[18] = addr & 0xff;
+	addr  >>= 8;
+	buf[17] = addr & 0xff;
+	addr  >>= 8;
+	buf[16] = addr & 0x0f;
+}
+
 #if defined(CONFIG_IPV6) || defined(CONFIG_IPV6_MODULE)
 #include <linux/ipv6.h>
 #endif
Index: linux-bk/net/ipv4/arp.c
===================================================================
--- linux-bk.orig/net/ipv4/arp.c	2004-11-21 21:07:24.904787535 -0800
+++ linux-bk/net/ipv4/arp.c	2004-11-21 21:25:56.079881223 -0800
@@ -213,6 +213,9 @@
 	case ARPHRD_IEEE802_TR:
 		ip_tr_mc_map(addr, haddr);
 		return 0;
+	case ARPHRD_INFINIBAND:
+		ip_ib_mc_map(addr, haddr);
+		return 0;
 	default:
 		if (dir) {
 			memcpy(haddr, dev->broadcast, dev->addr_len);

