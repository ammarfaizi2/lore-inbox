Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263094AbVCXL6M@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263094AbVCXL6M (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 24 Mar 2005 06:58:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263102AbVCXL6M
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 24 Mar 2005 06:58:12 -0500
Received: from yue.linux-ipv6.org ([203.178.140.15]:14852 "EHLO
	yue.st-paulia.net") by vger.kernel.org with ESMTP id S263094AbVCXL5V
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 24 Mar 2005 06:57:21 -0500
Date: Thu, 24 Mar 2005 20:59:02 +0900 (JST)
Message-Id: <20050324.205902.119922975.yoshfuji@linux-ipv6.org>
To: davem@davemloft.net, felix-linuxkernel@fefe.de
Cc: linux-kernel@vger.kernel.org, netdev@oss.sgi.com, yoshfuji@linux-ipv6.org
Subject: [PATCH] [IPV6] Fix address/interface handling according to the
 scoping architecture (is Re: 2.6.11: USB broken on nforce4, ipv6 still
 broken, centrino speedstep even more broken than in 2.6.10)
From: YOSHIFUJI Hideaki / =?iso-2022-jp?B?GyRCNUhGIzFRTEAbKEI=?= 
	<yoshfuji@linux-ipv6.org>
In-Reply-To: <20050311173308.7a076e8f.akpm@osdl.org>
References: <20050311202122.GA13205@fefe.de>
	<20050311173308.7a076e8f.akpm@osdl.org>
Organization: USAGI Project
X-URL: http://www.yoshifuji.org/%7Ehideaki/
X-Fingerprint: 9022 65EB 1ECF 3AD1 0BDF  80D8 4807 F894 E062 0EEA
X-PGP-Key-URL: http://www.yoshifuji.org/%7Ehideaki/hideaki@yoshifuji.org.asc
X-Face: "5$Al-.M>NJ%a'@hhZdQm:."qn~PA^gq4o*>iCFToq*bAi#4FRtx}enhuQKz7fNqQz\BYU]
 $~O_5m-9'}MIs`XGwIEscw;e5b>n"B_?j/AkL~i/MEa<!5P`&C$@oP>ZBLP
X-Mailer: Mew version 2.2 on Emacs 20.7 / Mule 4.1 (AOI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In article <20050311173308.7a076e8f.akpm@osdl.org> (at Fri, 11 Mar 2005 17:33:08 -0800), Andrew Morton <akpm@osdl.org> says:

> Felix von Leitner <felix-linuxkernel@fefe.de> wrote:
> >
> > Now about IPv6: npush and npoll are two applications I wrote.  npush
> > sends multicast announcements and opens a TCP socket.  npoll receives
> > the multicast announcement and connects to the source IP/port/scope_id
> > of the announcement.  If both are run on the same machine, npoll sees
> > the link local address of eth0 as source IP, and the interface number of
> > eth0 as scope_id.  So far so good.  Trying to connect() however hangs.
> > Since this has been broken in different ways for as long as I can
> > remember in Linux, and I keep complaining about it every half a year or
> > so.  Can't someone fix this once and for all?  IPv4 checks whether we
> > are connecting to our own address and reroutes through loopback, why
> > can't IPv6?

I think this has been there for long time (maybe since 2.4...).

With the following patch, I can connect local link-local address.
- Change incoming interface according to the scoping architecture
- Choose source address on appropriate interface, according to the
  scoping architecture.

Signed-off-by: Hideaki YOSHIFUJI <yoshfuji@linux-ipv6.org>

===== net/ipv6/ip6_input.c 1.23 vs edited =====
--- 1.23/net/ipv6/ip6_input.c	2005-03-10 14:12:11 +09:00
+++ edited/net/ipv6/ip6_input.c	2005-03-24 17:49:15 +09:00
@@ -71,10 +71,18 @@
 		goto out;
 	}
 
-	/* Store incoming device index. When the packet will
-	   be queued, we cannot refer to skb->dev anymore.
+	/*
+	 * Store incoming device index. When the packet will
+	 * be queued, we cannot refer to skb->dev anymore.
+	 * 
+	 * BTW, when we send a packet for our own local address on a
+	 * non-loopback interface (e.g. ethX), it is being delivered
+	 * via the loopback interface (lo) here; skb->dev = &loopback_dev.
+	 * It, however, should be considered as if it is being
+	 * arrived via the sending interface (ethX), because of the
+	 * nature of scoping architecture. --yoshfuji
 	 */
-	IP6CB(skb)->iif = dev->ifindex;
+	IP6CB(skb)->iif = skb->dst ? ((struct rt6_info *)skb->dst)->rt6i_idev->dev->ifindex : dev->ifindex;
 
 	if (skb->len < sizeof(struct ipv6hdr))
 		goto err;
===== net/ipv6/addrconf.c 1.134 vs edited =====
--- 1.134/net/ipv6/addrconf.c	2005-03-15 14:21:11 +09:00
+++ edited/net/ipv6/addrconf.c	2005-03-24 11:52:17 +09:00
@@ -942,7 +942,7 @@
 int ipv6_get_saddr(struct dst_entry *dst,
 		   struct in6_addr *daddr, struct in6_addr *saddr)
 {
-	return ipv6_dev_get_saddr(dst ? dst->dev : NULL, daddr, saddr);
+	return ipv6_dev_get_saddr(dst ? ((struct rt6_info *)dst)->rt6i_idev->dev : NULL, daddr, saddr);
 }
 
 

-- 
Hideaki YOSHIFUJI @ USAGI Project <yoshfuji@linux-ipv6.org>
GPG FP: 9022 65EB 1ECF 3AD1 0BDF  80D8 4807 F894 E062 0EEA
