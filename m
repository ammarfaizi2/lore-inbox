Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261188AbVBFM32@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261188AbVBFM32 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 6 Feb 2005 07:29:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261193AbVBFM32
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 6 Feb 2005 07:29:28 -0500
Received: from yue.linux-ipv6.org ([203.178.140.15]:27918 "EHLO
	yue.st-paulia.net") by vger.kernel.org with ESMTP id S261188AbVBFM3U
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 6 Feb 2005 07:29:20 -0500
Date: Sun, 06 Feb 2005 21:30:18 +0900 (JST)
Message-Id: <20050206.213018.92031627.yoshfuji@linux-ipv6.org>
To: herbert@gondor.apana.org.au
Cc: davem@davemloft.net, mirko.parthey@informatik.tu-chemnitz.de,
       linux-kernel@vger.kernel.org, netdev@oss.sgi.com, shemminger@osdl.org,
       yoshfuji@linux-ipv6.org
Subject: Re: PROBLEM: 2.6.11-rc2 hangs on bridge shutdown (br0)
From: YOSHIFUJI Hideaki / =?iso-2022-jp?B?GyRCNUhGIzFRTEAbKEI=?= 
	<yoshfuji@linux-ipv6.org>
In-Reply-To: <20050206114145.GA20883@gondor.apana.org.au>
References: <20050205064643.GA29758@gondor.apana.org.au>
	<20050205104559.GA30981@gondor.apana.org.au>
	<20050206114145.GA20883@gondor.apana.org.au>
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

In article <20050206114145.GA20883@gondor.apana.org.au> (at Sun, 6 Feb 2005 22:41:45 +1100), Herbert Xu <herbert@gondor.apana.org.au> says:

> On Sat, Feb 05, 2005 at 09:45:59PM +1100, herbert wrote:
> > 
> > Although I still think this is a bug, I'm now starting to suspect
> > that there is another bug around as well.
> > 
> > There is probably an ifp leak which in turn leads to a split dst
> > leak that allows the first bug to make its mark.
> 
> Found it.  This is what happens:
> 
> lo goes down =>
> 	rt6_ifdown =>
> 		eth0's local address route gets deleted
> 
> eth0 goes down =>
> 	__ipv6_ifa_notify =>
> 		ip6_del_rt fails so we fall through to the
> 		dst_free path.  At this point the refcount
> 		taken by __ipv6_ifa_notify is leaked.

Oh, you're right! Thanks.

How about this; Ignore entries addrconf_dst_alloc'ed entries in rt6_ifdown()?

Signed-off-by: Hideaki YOSHIFUJI <yoshfuji@linux-ipv6.org>

===== include/linux/ipv6_route.h 1.6 vs edited =====
--- 1.6/include/linux/ipv6_route.h	2004-10-26 12:54:23 +09:00
+++ edited/include/linux/ipv6_route.h	2005-02-06 21:27:02 +09:00
@@ -26,6 +26,7 @@
 #define RTF_FLOW	0x02000000	/* flow significant route	*/
 #define RTF_POLICY	0x04000000	/* policy route			*/
 
+#define RTF_ANYCAST	0x40000000
 #define RTF_LOCAL	0x80000000
 
 struct in6_rtmsg {
===== net/ipv6/route.c 1.105 vs edited =====
--- 1.105/net/ipv6/route.c	2005-01-15 17:44:48 +09:00
+++ edited/net/ipv6/route.c	2005-02-06 21:26:35 +09:00
@@ -1408,7 +1408,9 @@
 	rt->u.dst.obsolete = -1;
 
 	rt->rt6i_flags = RTF_UP | RTF_NONEXTHOP;
-	if (!anycast)
+	if (anycast)
+		rt->rt6i_flags |= RTF_ANYCAST;
+	else
 		rt->rt6i_flags |= RTF_LOCAL;
 	rt->rt6i_nexthop = ndisc_get_neigh(rt->rt6i_dev, &rt->rt6i_gateway);
 	if (rt->rt6i_nexthop == NULL) {
@@ -1427,7 +1429,8 @@
 static int fib6_ifdown(struct rt6_info *rt, void *arg)
 {
 	if (((void*)rt->rt6i_dev == arg || arg == NULL) &&
-	    rt != &ip6_null_entry) {
+	    rt != &ip6_null_entry &&
+	    !(rt->rt6i_flags & (RTF_LOCAL|RTF_ANYCAST))) {
 		RT6_TRACE("deleted by ifdown %p\n", rt);
 		return -1;
 	}

-- 
Hideaki YOSHIFUJI @ USAGI Project <yoshfuji@linux-ipv6.org>
GPG FP: 9022 65EB 1ECF 3AD1 0BDF  80D8 4807 F894 E062 0EEA
