Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264110AbTKZKEA (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 26 Nov 2003 05:04:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264134AbTKZKEA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 26 Nov 2003 05:04:00 -0500
Received: from yue.hongo.wide.ad.jp ([203.178.139.94]:26387 "EHLO
	yue.hongo.wide.ad.jp") by vger.kernel.org with ESMTP
	id S264110AbTKZKD7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 26 Nov 2003 05:03:59 -0500
Date: Wed, 26 Nov 2003 19:04:07 +0900 (JST)
Message-Id: <20031126.190407.102714104.yoshfuji@linux-ipv6.org>
To: felix-kernel@fefe.de
Cc: netdev@oss.sgi.com, linux-kernel@vger.kernel.org, yoshfuji@linux-ipv6.org,
       davem@redhat.com
Subject: Re: ipv4-mapped ipv4 connect() for UDP broken in test10
From: YOSHIFUJI Hideaki / =?iso-2022-jp?B?GyRCNUhGIzFRTEAbKEI=?= 
	<yoshfuji@linux-ipv6.org>
In-Reply-To: <20031126081745.GA31415@codeblau.de>
References: <20031126081745.GA31415@codeblau.de>
Organization: USAGI Project
X-URL: http://www.yoshifuji.org/%7Ehideaki/
X-Fingerprint: 90 22 65 EB 1E CF 3A D1 0B DF 80 D8 48 07 F8 94 E0 62 0E EA
X-PGP-Key-URL: http://www.yoshifuji.org/%7Ehideaki/hideaki@yoshifuji.org.asc
X-Face: "5$Al-.M>NJ%a'@hhZdQm:."qn~PA^gq4o*>iCFToq*bAi#4FRtx}enhuQKz7fNqQz\BYU]
 $~O_5m-9'}MIs`XGwIEscw;e5b>n"B_?j/AkL~i/MEa<!5P`&C$@oP>ZBLP
X-Mailer: Mew version 2.2 on Emacs 20.7 / Mule 4.1 (AOI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In article <20031126081745.GA31415@codeblau.de> (at Wed, 26 Nov 2003 09:17:45 +0100), Felix von Leitner <felix-kernel@fefe.de> says:

> Some digging reveals that djbdns does this (with scope_id 0):
> 
>   socket(PF_INET6,...)
>   bind socket to ::
>   connect() socket to IP of peer (in this case, 210.81.13.179)
>   send() dns query
> 
> at this point, the query is not sent over ppp0 as it should, but it is
> sent to lo.  Not only that, but the queries are _received_ by the same
> djbdns (with servfail), although the destination IP is as said above
> 210.81.13.179 and none of my local IPs: 10.0.0.6, 127.0.0.1, or
> 217.88.123.45.

Please apply this patch.
(But I'm not sure this fix your problem...)

===== net/ipv6/udp.c 1.54 vs edited =====
--- 1.54/net/ipv6/udp.c	Tue Nov 18 11:41:56 2003
+++ edited/net/ipv6/udp.c	Wed Nov 26 19:01:15 2003
@@ -825,7 +825,7 @@
 			struct sockaddr_in sin;
 			sin.sin_family = AF_INET;
 			sin.sin_port = sin6 ? sin6->sin6_port : inet->dport;
-			sin.sin_addr.s_addr = daddr->s6_addr[3];
+			sin.sin_addr.s_addr = daddr->s6_addr32[3];
 			msg->msg_name = &sin;
 			msg->msg_namelen = sizeof(sin);
 do_udp_sendmsg:

-- 
Hideaki YOSHIFUJI @ USAGI Project <yoshfuji@linux-ipv6.org>
GPG FP: 9022 65EB 1ECF 3AD1 0BDF  80D8 4807 F894 E062 0EEA
