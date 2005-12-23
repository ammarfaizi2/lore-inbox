Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161093AbVLWWtS@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161093AbVLWWtS (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 23 Dec 2005 17:49:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161094AbVLWWtR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 23 Dec 2005 17:49:17 -0500
Received: from mail.kroah.org ([69.55.234.183]:41935 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S1161093AbVLWWtR (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 23 Dec 2005 17:49:17 -0500
Date: Fri, 23 Dec 2005 14:48:33 -0800
From: Greg Kroah-Hartman <gregkh@suse.de>
To: linux-kernel@vger.kernel.org, stable@kernel.org
Cc: Justin Forbes <jmforbes@linuxtx.org>,
       Zwane Mwaikambo <zwane@arm.linux.org.uk>,
       "Theodore Ts'o" <tytso@mit.edu>, Randy Dunlap <rdunlap@xenotime.net>,
       Dave Jones <davej@redhat.com>, Chuck Wolber <chuckw@quantumlinux.com>,
       torvalds@osdl.org, akpm@osdl.org, alan@lxorguk.ukuu.org.uk,
       davem@davemloft.net, yoshfuji@linux-ipv6.org
Subject: [patch 13/19] [IPV6]: Fix route lifetime.
Message-ID: <20051223224833.GM19057@kroah.com>
References: <20051223221200.342826000@press.kroah.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline; filename="ipv6-fix-route-lifetime.patch"
In-Reply-To: <20051223224712.GA18975@kroah.com>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-stable review patch.  If anyone has any objections, please let us know.

------------------
From: YOSHIFUJI Hideaki <yoshfuji@linux-ipv6.org>

The route expiration time is stored in rt6i_expires in jiffies.
The argument of rt6_route_add() for adding a route is not the
expiration time in jiffies nor in clock_t, but the lifetime
(or time left before expiration) in clock_t.

Because of the confusion, we sometimes saw several strange errors
(FAILs) in TAHI IPv6 Ready Logo Phase-2 Self Test.
The symptoms were analyzed by Mitsuru Chinen <CHINEN@jp.ibm.com>.

Signed-off-by: YOSHIFUJI Hideaki <yoshfuji@linux-ipv6.org>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Chris Wright <chrisw@redhat.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@suse.de>
---
 net/ipv6/addrconf.c |   16 ++++++++++++----
 net/ipv6/route.c    |    2 +-
 2 files changed, 13 insertions(+), 5 deletions(-)

--- linux-2.6.14.4.orig/net/ipv6/addrconf.c
+++ linux-2.6.14.4/net/ipv6/addrconf.c
@@ -1456,9 +1456,17 @@ void addrconf_prefix_rcv(struct net_devi
 	   not good.
 	 */
 	if (valid_lft >= 0x7FFFFFFF/HZ)
-		rt_expires = 0;
+		rt_expires = 0x7FFFFFFF - (0x7FFFFFFF % HZ);
 	else
-		rt_expires = jiffies + valid_lft * HZ;
+		rt_expires = valid_lft * HZ;
+
+	/*
+	 * We convert this (in jiffies) to clock_t later.
+	 * Avoid arithmetic overflow there as well.
+	 * Overflow can happen only if HZ < USER_HZ.
+	 */
+	if (HZ < USER_HZ && rt_expires > 0x7FFFFFFF / USER_HZ)
+		rt_expires = 0x7FFFFFFF / USER_HZ;
 
 	if (pinfo->onlink) {
 		struct rt6_info *rt;
@@ -1470,12 +1478,12 @@ void addrconf_prefix_rcv(struct net_devi
 					ip6_del_rt(rt, NULL, NULL, NULL);
 					rt = NULL;
 				} else {
-					rt->rt6i_expires = rt_expires;
+					rt->rt6i_expires = jiffies + rt_expires;
 				}
 			}
 		} else if (valid_lft) {
 			addrconf_prefix_route(&pinfo->prefix, pinfo->prefix_len,
-					      dev, rt_expires, RTF_ADDRCONF|RTF_EXPIRES|RTF_PREFIX_RT);
+					      dev, jiffies_to_clock_t(rt_expires), RTF_ADDRCONF|RTF_EXPIRES|RTF_PREFIX_RT);
 		}
 		if (rt)
 			dst_release(&rt->u.dst);
--- linux-2.6.14.4.orig/net/ipv6/route.c
+++ linux-2.6.14.4/net/ipv6/route.c
@@ -829,7 +829,7 @@ int ip6_route_add(struct in6_rtmsg *rtms
 	}
 
 	rt->u.dst.obsolete = -1;
-	rt->rt6i_expires = clock_t_to_jiffies(rtmsg->rtmsg_info);
+	rt->rt6i_expires = jiffies + clock_t_to_jiffies(rtmsg->rtmsg_info);
 	if (nlh && (r = NLMSG_DATA(nlh))) {
 		rt->rt6i_protocol = r->rtm_protocol;
 	} else {

--
