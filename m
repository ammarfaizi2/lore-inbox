Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268361AbVBFFtW@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268361AbVBFFtW (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 6 Feb 2005 00:49:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268369AbVBFFtW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 6 Feb 2005 00:49:22 -0500
Received: from yue.linux-ipv6.org ([203.178.140.15]:20750 "EHLO
	yue.st-paulia.net") by vger.kernel.org with ESMTP id S268284AbVBFFtJ
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 6 Feb 2005 00:49:09 -0500
Date: Sun, 06 Feb 2005 14:50:07 +0900 (JST)
Message-Id: <20050206.145007.34543324.yoshfuji@linux-ipv6.org>
To: davem@davemloft.net
Cc: herbert@gondor.apana.org.au, mirko.parthey@informatik.tu-chemnitz.de,
       linux-kernel@vger.kernel.org, netdev@oss.sgi.com, shemminger@osdl.org,
       yoshfuji@linux-ipv6.org
Subject: Re: PROBLEM: 2.6.11-rc2 hangs on bridge shutdown (br0)
From: YOSHIFUJI Hideaki / =?iso-2022-jp?B?GyRCNUhGIzFRTEAbKEI=?= 
	<yoshfuji@linux-ipv6.org>
In-Reply-To: <20050206.143107.39728239.yoshfuji@linux-ipv6.org>
References: <20050206.133723.124822665.yoshfuji@linux-ipv6.org>
	<20050205210411.7e18b8e6.davem@davemloft.net>
	<20050206.143107.39728239.yoshfuji@linux-ipv6.org>
Organization: USAGI Project
X-URL: http://www.yoshifuji.org/%7Ehideaki/
X-Fingerprint: 9022 65EB 1ECF 3AD1 0BDF  80D8 4807 F894 E062 0EEA
X-PGP-Key-URL: http://www.yoshifuji.org/%7Ehideaki/hideaki@yoshifuji.org.asc
X-Face: "5$Al-.M>NJ%a'@hhZdQm:."qn~PA^gq4o*>iCFToq*bAi#4FRtx}enhuQKz7fNqQz\BYU]
 $~O_5m-9'}MIs`XGwIEscw;e5b>n"B_?j/AkL~i/MEa<!5P`&C$@oP>ZBLP
X-Mailer: Mew version 2.2 on Emacs 20.7 / Mule 4.1 (AOI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=iso-2022-jp
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In article <20050206.143107.39728239.yoshfuji@linux-ipv6.org> (at Sun, 06 Feb 2005 14:31:07 +0900 (JST)), YOSHIFUJI Hideaki / 吉藤英明 <yoshfuji@linux-ipv6.org> says:

> The source of problem is entry (*) which still on routing entry,
> not on gc list. And, the owner of entry is not routing table but
> unicast/anycast address structure(s).
> We need to "kill" active address on the other interfaces.

Which means in addrconf_notiry(), if the dev == &loopback_dev,
call addrconf_ifdown for every device like this:

Signed-off-by: Hideaki YOSHIFUJI <yoshfuji@linux-ipv6.org>

===== net/ipv6/addrconf.c 1.129 vs edited =====
--- 1.129/net/ipv6/addrconf.c	2005-01-18 06:13:31 +09:00
+++ edited/net/ipv6/addrconf.c	2005-02-06 14:48:25 +09:00
@@ -1961,6 +1961,20 @@
 	case NETDEV_DOWN:
 	case NETDEV_UNREGISTER:
 		/*
+		 * If lo is doing down we need to kill
+		 * all addresses on the host because it owns
+		 * route on lo. --yoshfuji
+		 */
+		if (dev == &loopback_dev) {
+			struct net_device *dev1;
+			for (dev1 = dev_base; dev1; dev1 = dev->next) {
+				if (dev1 == &loopback_dev ||
+				    __in6_dev_get(dev1) == NULL)
+					continue;
+				addrconf_ifdown(dev1, event != NETDEV_DOWN);
+			}
+		}
+		/*
 		 *	Remove all addresses from this interface.
 		 */
 		addrconf_ifdown(dev, event != NETDEV_DOWN);


-- 
Hideaki YOSHIFUJI @ USAGI Project <yoshfuji@linux-ipv6.org>
GPG FP: 9022 65EB 1ECF 3AD1 0BDF  80D8 4807 F894 E062 0EEA
