Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751389AbVKIL4U@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751389AbVKIL4U (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 9 Nov 2005 06:56:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751387AbVKIL4T
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 9 Nov 2005 06:56:19 -0500
Received: from send.forptr.21cn.com ([202.105.45.51]:48125 "HELO 21cn.com")
	by vger.kernel.org with SMTP id S1751383AbVKIL4T (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 9 Nov 2005 06:56:19 -0500
Message-ID: <4371E45C.3020500@21cn.com>
Date: Wed, 09 Nov 2005 19:58:20 +0800
From: Yan Zheng <yanzheng@21cn.com>
User-Agent: Mozilla Thunderbird 1.0.2-6 (X11/20050513)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: netdev@vger.kernel.org, David Stevens <dlstevens@us.ibm.com>
CC: linux-kernel@vger.kernel.org
Subject: [PATCH 2/2][MCAST] Fix for add_grec(...)
Content-Type: multipart/mixed;
 boundary="------------060105020903070708040306"
X-AIMC-AUTH: yanzheng
X-AIMC-MAILFROM: yanzheng@21cn.com
X-AIMC-Msg-ID: oTAbo9OB
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------060105020903070708040306
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi

When ifmcaddr6's mca_sources is not NULL, but none of the sources in the list can be included in report,
(For example: when filter mode is exclude and the only source in the list has include count greater than zero.)
add_grec(...) may returns without add any data to the sk_buff. So MLD2_CHANGE_TO_EXCLUDE or MLD2_MODE_IS_EXCLUDE
report may be eliminated.

You can check this bug by test1.c in attachments. You will notice that there is no MLD2_CHANGE_TO_EXCLUDE report.

Regards

Signed-off-by: Yan Zheng<yanzheng@21cn.com>

Index:net/ipv6/mcast.c
==============================================================
--- linux-2.6.14/net/ipv6/mcast.c	2005-11-09 16:00:48.000000000 +0800
+++ linux/net/ipv6/mcast.c	2005-11-09 19:47:50.000000000 +0800
@@ -1445,18 +1445,21 @@ static struct sk_buff *add_grec(struct s
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
-		    type == MLD2_CHANGE_TO_EXCLUDE;
+		   type == MLD2_CHANGE_TO_EXCLUDE;
 
 	psf_list = sdeleted ? &pmc->mca_tomb : &pmc->mca_sources;
 
+#if 0
 	if (!*psf_list) {
 		if (type == MLD2_ALLOW_NEW_SOURCES ||
 		    type == MLD2_BLOCK_OLD_SOURCES)
@@ -1474,12 +1477,15 @@ static struct sk_buff *add_grec(struct s
 		}
 		return skb;
 	}
+#endif
 	pmr = skb ? (struct mld2_report *)skb->h.raw : NULL;
 
 	/* EX and TO_EX get a fresh packet, if needed */
-	if (truncate) {
-		if (pmr && pmr->ngrec &&
-		    AVAILABLE(skb) < grec_size(pmc, type, gdeleted, sdeleted)) {
+	if (truncate || ischange) {
+		int min_len;
+		min_len	= truncate ? grec_size(pmc, type, gdeleted, sdeleted) : 
+			  (sizeof(struct mld2_grec) + sizeof(struct in6_addr));
+		if (pmr && pmr->ngrec && AVAILABLE(skb) < min_len) {
 			if (skb)
 				mld_sendpack(skb);
 			skb = mld_newpack(dev, dev->mtu);
@@ -1488,6 +1494,10 @@ static struct sk_buff *add_grec(struct s
 	first = 1;
 	scount = 0;
 	psf_prev = NULL;
+	if (ischange || type == MLD2_MODE_IS_EXCLUDE) {
+		skb = add_grhead(skb, pmc, type, &pgr);
+		first = 0;
+	}
 	for (psf=*psf_list; psf; psf=psf_next) {
 		struct in6_addr *psrc;
 




--------------060105020903070708040306
Content-Type: text/x-csrc;
 name="test1.c"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="test1.c"

#include <stdio.h>
#include <unistd.h>
#include <netinet/in.h>
#include <arpa/inet.h>
#include <sys/socket.h>
#include <sys/types.h>
#define IFINDEX 5  //Please adjust me first.

int main(int argc, char argv[])
{
	int sockfds[2];
	struct ipv6_mreq req;
	struct group_filter filter;
	struct sockaddr_in6 *psin6;
	req.ipv6mr_interface = IFINDEX;
	inet_pton(PF_INET6, "FF02::2000", &req.ipv6mr_multiaddr);

	sockfds[0] = socket(PF_INET6, SOCK_DGRAM, 0);
	sockfds[1] = socket(PF_INET6, SOCK_DGRAM, 0);

	filter.gf_interface = IFINDEX;
	filter.gf_fmode = MCAST_INCLUDE;
	filter.gf_numsrc = 1;
	psin6 = (struct sockaddr_in6 *)&filter.gf_group;
	psin6->sin6_family = AF_INET6;
	inet_pton(PF_INET6, "FF02::2000", &psin6->sin6_addr);
	psin6 = (struct sockaddr_in6 *)&filter.gf_slist[0];
	psin6->sin6_family = AF_INET6;
	inet_pton(PF_INET6, "2002:de12:1780::1", &psin6->sin6_addr);

	setsockopt(sockfds[0], SOL_IPV6, IPV6_ADD_MEMBERSHIP, &req, sizeof(req));
	setsockopt(sockfds[0], SOL_IPV6, MCAST_MSFILTER, &filter, sizeof(filter));
	sleep(10); //wait state change reports
	printf("change mode to exclude\n");
	setsockopt(sockfds[1], SOL_IPV6, IPV6_ADD_MEMBERSHIP, &req, sizeof(req));

	pause();
	return 0;
}




--------------060105020903070708040306--
