Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266386AbSKUG0z>; Thu, 21 Nov 2002 01:26:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266387AbSKUG0z>; Thu, 21 Nov 2002 01:26:55 -0500
Received: from yue.hongo.wide.ad.jp ([203.178.139.94]:61712 "EHLO
	yue.hongo.wide.ad.jp") by vger.kernel.org with ESMTP
	id <S266386AbSKUG0y>; Thu, 21 Nov 2002 01:26:54 -0500
Date: Thu, 21 Nov 2002 01:32:03 -0500 (EST)
Message-Id: <20021121.013203.100868154.yoshfuji@linux-ipv6.org>
To: linux-kernel@vger.kernel.org, netdev@oss.sgi.com
CC: davem@redhat.com, kuznet@ms2.inr.ac.ru.ee.t.u-tokyo.ac.jp,
       usagi@linux-ipv6.org
Subject: [PATCH] IPv6: Fix BUG When Received Unknown Protocol
Organization: USAGI Project
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
From: YOSHIFUJI Hideaki / =?iso-2022-jp?B?GyRCNUhGIzFRTEAbKEI=?= 
	<yoshfuji@linux-ipv6.org>
X-URL: http://www.yoshifuji.org/%7Ehideaki/
X-Fingerprint: 90 22 65 EB 1E CF 3A D1 0B DF 80 D8 48 07 F8 94 E0 62 0E EA
X-PGP-Key-URL: http://www.yoshifuji.org/%7Ehideaki/hideaki@yoshifuji.org.asc
X-Face: "5$Al-.M>NJ%a'@hhZdQm:."qn~PA^gq4o*>iCFToq*bAi#4FRtx}enhuQKz7fNqQz\BYU]
 $~O_5m-9'}MIs`XGwIEscw;e5b>n"B_?j/AkL~i/MEa<!5P`&C$@oP>ZBLP
X-Mailer: Mew version 2.2 on Emacs 20.7 / Mule 4.1 (AOI)
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

Since 2.5.43, kernel panics by executing BUG() when
received unknown protocol in IPv6 packet. 
This is because ip6_input_finish() try to kfree_skb() 
while icmpv6_param_prob() has already kfree_skb()'ed the skb.

Thanks.

Patch-Name: Fix BUG When Received Unknown Protocol
Patch-Author: YOSHIFUJI Hideaki / USAGI Project <yoshfuji@linux-ipv6.org>
Index: net/ipv6/ip6_input.c
===================================================================
RCS file: /cvsroot/usagi/usagi/kernel/linux25/net/ipv6/ip6_input.c,v
retrieving revision 1.1.1.3
retrieving revision 1.2
diff -u -r1.1.1.3 -r1.2
--- net/ipv6/ip6_input.c	31 Oct 2002 03:58:27 -0000	1.1.1.3
+++ net/ipv6/ip6_input.c	21 Nov 2002 05:30:59 -0000	1.2
@@ -182,9 +182,10 @@
 		if (!raw_sk) {
 			IP6_INC_STATS_BH(Ip6InUnknownProtos);
 			icmpv6_param_prob(skb, ICMPV6_UNK_NEXTHDR, nhoff);
-		} else
+		} else {
 			IP6_INC_STATS_BH(Ip6InDelivers);
-		kfree_skb(skb);
+			kfree_skb(skb);
+		}
 	}
 
 	return 0;

-- 
Hideaki YOSHIFUJI @ USAGI Project <yoshfuji@linux-ipv6.org>
GPG FP: 9022 65EB 1ECF 3AD1 0BDF  80D8 4807 F894 E062 0EEA
