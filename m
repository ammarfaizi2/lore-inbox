Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261914AbVAaEpS@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261914AbVAaEpS (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 30 Jan 2005 23:45:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261917AbVAaEpS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 30 Jan 2005 23:45:18 -0500
Received: from yue.linux-ipv6.org ([203.178.140.15]:12811 "EHLO
	yue.st-paulia.net") by vger.kernel.org with ESMTP id S261914AbVAaEpM
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 30 Jan 2005 23:45:12 -0500
Date: Mon, 31 Jan 2005 13:45:59 +0900 (JST)
Message-Id: <20050131.134559.125426676.yoshfuji@linux-ipv6.org>
To: herbert@gondor.apana.org.au, davem@davemloft.net
Cc: kaber@trash.net, rmk+lkml@arm.linux.org.uk, Robert.Olsson@data.slu.se,
       akpm@osdl.org, torvalds@osdl.org, alexn@dsv.su.se, kas@fi.muni.cz,
       linux-kernel@vger.kernel.org, netdev@oss.sgi.com,
       yoshfuji@linux-ipv6.org
Subject: Re: Memory leak in 2.6.11-rc1?
From: YOSHIFUJI Hideaki / =?iso-2022-jp?B?GyRCNUhGIzFRTEAbKEI=?= 
	<yoshfuji@linux-ipv6.org>
In-Reply-To: <E1CvSuS-00056x-00@gondolin.me.apana.org.au>
References: <41FD2043.3070303@trash.net>
	<E1CvSuS-00056x-00@gondolin.me.apana.org.au>
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

In article <E1CvSuS-00056x-00@gondolin.me.apana.org.au> (at Mon, 31 Jan 2005 15:11:32 +1100), Herbert Xu <herbert@gondor.apana.org.au> says:

> Patrick McHardy <kaber@trash.net> wrote:
> > 
> > Ok, final decision: you are right :) conntrack also defragments locally
> > generated packets before they hit ip_fragment. In this case the fragments
> > have skb->dst set.
> 
> Well caught.  The same thing is needed for IPv6, right?

(not yet confirmed, but) yes, please.

Signed-off-by: Hideaki YOSHIFUJI <yoshfuji@linux-ipv6.org>

===== net/ipv6/ip6_output.c 1.82 vs edited =====
--- 1.82/net/ipv6/ip6_output.c	2005-01-25 09:40:10 +09:00
+++ edited/net/ipv6/ip6_output.c	2005-01-31 13:44:01 +09:00
@@ -463,6 +463,7 @@
 	to->priority = from->priority;
 	to->protocol = from->protocol;
 	to->security = from->security;
+	dst_release(to->dst);
 	to->dst = dst_clone(from->dst);
 	to->dev = from->dev;
 

--yoshfuji
