Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161258AbWF0ULm@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161258AbWF0ULm (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 27 Jun 2006 16:11:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161271AbWF0ULl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 27 Jun 2006 16:11:41 -0400
Received: from 216-99-217-87.dsl.aracnet.com ([216.99.217.87]:32128 "EHLO
	sous-sol.org") by vger.kernel.org with ESMTP id S1161258AbWF0ULi
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 27 Jun 2006 16:11:38 -0400
Message-Id: <20060627200920.623580000@sous-sol.org>
References: <20060627200745.771284000@sous-sol.org>
User-Agent: quilt/0.45-1
Date: Tue, 27 Jun 2006 00:00:03 -0700
From: Chris Wright <chrisw@sous-sol.org>
To: linux-kernel@vger.kernel.org, stable@kernel.org
Cc: Justin Forbes <jmforbes@linuxtx.org>,
       Zwane Mwaikambo <zwane@arm.linux.org.uk>,
       "Theodore Ts'o" <tytso@mit.edu>, Randy Dunlap <rdunlap@xenotime.net>,
       Dave Jones <davej@redhat.com>, Chuck Wolber <chuckw@quantumlinux.com>,
       Chris Wedgwood <reviews@ml.cw.f00f.org>, torvalds@osdl.org,
       akpm@osdl.org, alan@lxorguk.ukuu.org.uk,
       David Miller <davem@davemloft.net>,
       YOSHIFUJI Hideaki <yoshfuji@linux-ipv6.org>,
       Patrick McHardy <kaber@trash.net>
Subject: [PATCH 03/25] IPV6: Sum real space for RTAs.
Content-Disposition: inline; filename=ipv6-sum-real-space-for-rtas.patch
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-stable review patch.  If anyone has any objections, please let us know.
------------------

From: YOSHIFUJI Hideaki <yoshfuji@linux-ipv6.org>

This patch fixes RTNLGRP_IPV6_IFINFO netlink notifications.  Issue
pointed out by Patrick McHardy <kaber@trash.net>.

Signed-off-by: YOSHIFUJI Hideaki <yoshfuji@linux-ipv6.org>
Acked-by: Patrick McHardy <kaber@trash.net>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Chris Wright <chrisw@sous-sol.org>
---

 net/ipv6/addrconf.c |   28 ++++++++++++++++++++++++----
 1 file changed, 24 insertions(+), 4 deletions(-)

--- linux-2.6.17.1.orig/net/ipv6/addrconf.c
+++ linux-2.6.17.1/net/ipv6/addrconf.c
@@ -2860,6 +2860,11 @@ inet6_rtm_newaddr(struct sk_buff *skb, s
 	return inet6_addr_add(ifm->ifa_index, pfx, ifm->ifa_prefixlen);
 }
 
+/* Maximum length of ifa_cacheinfo attributes */
+#define INET6_IFADDR_RTA_SPACE \
+		RTA_SPACE(16) /* IFA_ADDRESS */ + \
+		RTA_SPACE(sizeof(struct ifa_cacheinfo)) /* CACHEINFO */
+
 static int inet6_fill_ifaddr(struct sk_buff *skb, struct inet6_ifaddr *ifa,
 			     u32 pid, u32 seq, int event, unsigned int flags)
 {
@@ -3092,7 +3097,7 @@ static int inet6_dump_ifacaddr(struct sk
 static void inet6_ifa_notify(int event, struct inet6_ifaddr *ifa)
 {
 	struct sk_buff *skb;
-	int size = NLMSG_SPACE(sizeof(struct ifaddrmsg)+128);
+	int size = NLMSG_SPACE(sizeof(struct ifaddrmsg) + INET6_IFADDR_RTA_SPACE);
 
 	skb = alloc_skb(size, GFP_ATOMIC);
 	if (!skb) {
@@ -3142,6 +3147,17 @@ static void inline ipv6_store_devconf(st
 #endif
 }
 
+/* Maximum length of ifinfomsg attributes */
+#define INET6_IFINFO_RTA_SPACE \
+		RTA_SPACE(IFNAMSIZ) /* IFNAME */ + \
+		RTA_SPACE(MAX_ADDR_LEN) /* ADDRESS */ +	\
+		RTA_SPACE(sizeof(u32)) /* MTU */ + \
+		RTA_SPACE(sizeof(int)) /* LINK */ + \
+		RTA_SPACE(0) /* PROTINFO */ + \
+		RTA_SPACE(sizeof(u32)) /* FLAGS */ + \
+		RTA_SPACE(sizeof(struct ifla_cacheinfo)) /* CACHEINFO */ + \
+		RTA_SPACE(sizeof(__s32[DEVCONF_MAX])) /* CONF */
+
 static int inet6_fill_ifinfo(struct sk_buff *skb, struct inet6_dev *idev, 
 			     u32 pid, u32 seq, int event, unsigned int flags)
 {
@@ -3235,8 +3251,7 @@ static int inet6_dump_ifinfo(struct sk_b
 void inet6_ifinfo_notify(int event, struct inet6_dev *idev)
 {
 	struct sk_buff *skb;
-	/* 128 bytes ?? */
-	int size = NLMSG_SPACE(sizeof(struct ifinfomsg)+128);
+	int size = NLMSG_SPACE(sizeof(struct ifinfomsg) + INET6_IFINFO_RTA_SPACE);
 	
 	skb = alloc_skb(size, GFP_ATOMIC);
 	if (!skb) {
@@ -3252,6 +3267,11 @@ void inet6_ifinfo_notify(int event, stru
 	netlink_broadcast(rtnl, skb, 0, RTNLGRP_IPV6_IFINFO, GFP_ATOMIC);
 }
 
+/* Maximum length of prefix_cacheinfo attributes */
+#define INET6_PREFIX_RTA_SPACE \
+		RTA_SPACE(sizeof(((struct prefix_info *)NULL)->prefix)) /* ADDRESS */ + \
+		RTA_SPACE(sizeof(struct prefix_cacheinfo)) /* CACHEINFO */
+
 static int inet6_fill_prefix(struct sk_buff *skb, struct inet6_dev *idev,
 			struct prefix_info *pinfo, u32 pid, u32 seq, 
 			int event, unsigned int flags)
@@ -3296,7 +3316,7 @@ static void inet6_prefix_notify(int even
 			 struct prefix_info *pinfo)
 {
 	struct sk_buff *skb;
-	int size = NLMSG_SPACE(sizeof(struct prefixmsg)+128);
+	int size = NLMSG_SPACE(sizeof(struct prefixmsg) + INET6_PREFIX_RTA_SPACE);
 
 	skb = alloc_skb(size, GFP_ATOMIC);
 	if (!skb) {

--
