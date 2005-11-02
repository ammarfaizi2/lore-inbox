Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932646AbVKBI2F@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932646AbVKBI2F (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 2 Nov 2005 03:28:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932651AbVKBI2E
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 2 Nov 2005 03:28:04 -0500
Received: from send.forptr.21cn.com ([202.105.45.51]:30116 "HELO 21cn.com")
	by vger.kernel.org with SMTP id S932646AbVKBI2D (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 2 Nov 2005 03:28:03 -0500
Message-ID: <436878E7.3030303@21cn.com>
Date: Wed, 02 Nov 2005 16:29:27 +0800
From: Yan Zheng <yanzheng@21cn.com>
User-Agent: Mozilla Thunderbird 1.0.2-6 (X11/20050513)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: netdev@vger.kernel.org
CC: linux-kernel@vger.kernel.org, David Stevens <dlstevens@us.ibm.com>
Subject: [PATCH][MCAST]Two fix for implementation of MLDv2 .
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-AIMC-AUTH: yanzheng
X-AIMC-MAILFROM: yanzheng@21cn.com
X-AIMC-Msg-ID: MpZAO7OB
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi.
I find two bug yesterday when I was thinking whether ip6_mc_del_src(...) should be called in __ipv6_dev_mc_dec(...).


The first change in function is_in(...) is to make process Multicast Address and Source Specific Query same as Multicast Address Specific Query.
Although it still doesn't satisfy the requirement in rfc3810, but not at risk of losing multicast traffic.
For example:
A Node's filter for Multicast address M is EXCLUDE (X,Y) and receice a Multicast Address and Source Specific Query Q(M,Z).
Without the change No report will send to router, so the node may get multicast traffic from address Z lost.


The second change in function add_grec(...) is to make sure Mode Change Report send properly.
When A filter's source address list is not empty, but none of them can be included in report.


Regards


Signed-off-by: Yan Zheng <yanzheng@21cn.com>

Index:net/ipv6/mcast.c
============================================================
--- linux-2.6.14/net/ipv6/mcast.c	2005-10-30 23:09:33.000000000 +0800
+++ linux/net/ipv6/mcast.c	2005-11-02 15:01:28.000000000 +0800
@@ -1256,10 +1256,13 @@ static int is_in(struct ifmcaddr6 *pmc, 
 {
 	switch (type) {
 	case MLD2_MODE_IS_INCLUDE:
-	case MLD2_MODE_IS_EXCLUDE:
 		if (gdeleted || sdeleted)
 			return 0;
 		return !((pmc->mca_flags & MAF_GSQUERY) && !psf->sf_gsresp);
+	case MLD2_MODE_IS_EXCLUDE:
+		if (gdeleted || sdeleted)
+			return 0;
+		return 1;
 	case MLD2_CHANGE_TO_INCLUDE:
 		if (gdeleted || sdeleted)
 			return 0;
@@ -1428,13 +1431,15 @@ static struct sk_buff *add_grec(struct s
 	struct mld2_report *pmr;
 	struct mld2_grec *pgr = NULL;
 	struct ip6_sf_list *psf, *psf_next, *psf_prev, **psf_list;
-	int scount, first, isquery, truncate;
+	int scount, first, isquery, ischange, truncate;
 
 	if (pmc->mca_flags & MAF_NOREPORT)
 		return skb;
 
 	isquery = type == MLD2_MODE_IS_INCLUDE ||
 		  type == MLD2_MODE_IS_EXCLUDE;
+	ischange = type == MLD2_CHANGE_TO_INCLUDE ||
+		   type == MLD2_CHANGE_TO_EXCLUDE; 
 	truncate = type == MLD2_MODE_IS_EXCLUDE ||
 		    type == MLD2_CHANGE_TO_EXCLUDE;
 
@@ -1444,7 +1449,7 @@ static struct sk_buff *add_grec(struct s
 		if (type == MLD2_ALLOW_NEW_SOURCES ||
 		    type == MLD2_BLOCK_OLD_SOURCES)
 			return skb;
-		if (pmc->mca_crcount || isquery) {
+		if (ischange || isquery) {
 			/* make sure we have room for group header and at
 			 * least one source.
 			 */
@@ -1460,9 +1465,12 @@ static struct sk_buff *add_grec(struct s
 	pmr = skb ? (struct mld2_report *)skb->h.raw : NULL;
 
 	/* EX and TO_EX get a fresh packet, if needed */
-	if (truncate) {
-		if (pmr && pmr->ngrec &&
-		    AVAILABLE(skb) < grec_size(pmc, type, gdeleted, sdeleted)) {
+	if (truncate || ischange) {
+		int min_len;
+		min_len	= truncate ? grec_size(pmc, type, gdeleted, sdeleted) : 
+			  (sizeof(struct mld2_grec) + sizeof(struct in6_addr));
+		if (((pmr && pmr->ngrec) || ischange) &&
+		    AVAILABLE(skb) < min_len) {
 			if (skb)
 				mld_sendpack(skb);
 			skb = mld_newpack(dev, dev->mtu);
@@ -1471,6 +1479,10 @@ static struct sk_buff *add_grec(struct s
 	first = 1;
 	scount = 0;
 	psf_prev = NULL;
+	if (ischange) {
+		skb = add_grhead(skb, pmc, type, &pgr);
+		first = 0;
+	}
 	for (psf=*psf_list; psf; psf=psf_next) {
 		struct in6_addr *psrc;
 
