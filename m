Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264495AbTK0ML3 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 27 Nov 2003 07:11:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264503AbTK0ML2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 27 Nov 2003 07:11:28 -0500
Received: from yue.hongo.wide.ad.jp ([203.178.139.94]:61446 "EHLO
	yue.hongo.wide.ad.jp") by vger.kernel.org with ESMTP
	id S264495AbTK0MLW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 27 Nov 2003 07:11:22 -0500
Date: Thu, 27 Nov 2003 21:11:35 +0900 (JST)
Message-Id: <20031127.211135.09649297.yoshfuji@linux-ipv6.org>
To: davem@redhat.com
Cc: netdev@oss.sgi.com, linux-kernel@vger.kernel.org, yoshfuji@linux-ipv6.org,
       felix-kernel@fefe.de
Subject: Re: ipv4-mapped ipv4 connect() for UDP broken in test10
From: YOSHIFUJI Hideaki / =?iso-2022-jp?B?GyRCNUhGIzFRTEAbKEI=?= 
	<yoshfuji@linux-ipv6.org>
In-Reply-To: <20031126.190407.102714104.yoshfuji@linux-ipv6.org>
References: <20031126081745.GA31415@codeblau.de>
	<20031126.190407.102714104.yoshfuji@linux-ipv6.org>
Organization: USAGI Project
X-URL: http://www.yoshifuji.org/%7Ehideaki/
X-Fingerprint: 90 22 65 EB 1E CF 3A D1 0B DF 80 D8 48 07 F8 94 E0 62 0E EA
X-PGP-Key-URL: http://www.yoshifuji.org/%7Ehideaki/hideaki@yoshifuji.org.asc
X-Face: "5$Al-.M>NJ%a'@hhZdQm:."qn~PA^gq4o*>iCFToq*bAi#4FRtx}enhuQKz7fNqQz\BYU]
 $~O_5m-9'}MIs`XGwIEscw;e5b>n"B_?j/AkL~i/MEa<!5P`&C$@oP>ZBLP
X-Mailer: Mew version 2.2 on Emacs 20.7 / Mule 4.1 (AOI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=iso-2022-jp
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In article <20031126.190407.102714104.yoshfuji@linux-ipv6.org> (at Wed, 26 Nov 2003 19:04:07 +0900 (JST)), YOSHIFUJI Hideaki / 吉藤英明 <yoshfuji@linux-ipv6.org> says:

> (But I'm not sure this fix your problem...)

Well, let me clarify:

I'm sure the original code has a bug.
I do think that it is related to your report 
(but I don't have time to confirm it.)

s6_addr[3] should be s6_addr32[3] because the code is intended to extract 
IPv4 address from the IPv4-mapped address (::ffff:0.0.0.0/96)
to convert sockaddr_in6{} to sockaddr_in{}.

My analysis against the report is as follows:

Because the address is IPv4-mapped address (::ffff:0.0.0.0/96) at the point,
s6_addr[3] is always 0. The socket will be always connected to 0.0.0.0,
which means 127.0.0.1.

The patch is definitely logically correct.
Please apply this.  Thanks.

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

--yoshfuji
