Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030407AbVKIL40@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030407AbVKIL40 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 9 Nov 2005 06:56:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751387AbVKIL4Y
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 9 Nov 2005 06:56:24 -0500
Received: from send.forptr.21cn.com ([202.105.45.51]:48381 "HELO 21cn.com")
	by vger.kernel.org with SMTP id S1751365AbVKIL4X (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 9 Nov 2005 06:56:23 -0500
Message-ID: <4371E437.90306@21cn.com>
Date: Wed, 09 Nov 2005 19:57:43 +0800
From: Yan Zheng <yanzheng@21cn.com>
User-Agent: Mozilla Thunderbird 1.0.2-6 (X11/20050513)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: netdev@vger.kernel.org, David Stevens <dlstevens@us.ibm.com>
CC: linux-kernel@vger.kernel.org
Subject: [PATCH 1/2][MCAST] Fix for is_in(...)
Content-Type: multipart/mixed;
 boundary="------------040304070804000309000503"
X-AIMC-AUTH: yanzheng
X-AIMC-MAILFROM: yanzheng@21cn.com
X-AIMC-Msg-ID: oGmao9OB
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------040304070804000309000503
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi.


Include/exclude count of source filter also need check when type is MLD2_MODE_IS_INCLUDE or MLD2_MODE_IS_EXCLUDE.
If the check is ignored, MODE_IS_EXCLUDE report may include sources that have include count greater than zero.

You can check this bug by test.c and query.c in the attachments.

test.c create two socket and make both of them join multicast address M.
The first socket set it's filter mode to INCLUDE{X} and the second set it's filter mode to EXCLUDE{Y}.
Now the interface state for multicast address M should be EXCLUDE{Y}.


let's send a Multicast Address Specific Query by query.c. 
You will notice that both X and Y are included in the MODE_IS_EXCLUDE report's source address list.


I hope I provide enough information this time. :-)


Regards

Signed-off-by: Yan Zheng<yanzheng@21cn.com>

Index:net/ipv6/mcast.c
==============================================================
--- linux-2.6.14/net/ipv6/mcast.c	2005-11-09 16:00:48.000000000 +0800
+++ linux/net/ipv6/mcast.c	2005-11-09 18:44:37.000000000 +0800
@@ -1273,22 +1273,27 @@ static int is_in(struct ifmcaddr6 *pmc, 
 {
 	switch (type) {
 	case MLD2_MODE_IS_INCLUDE:
-	case MLD2_MODE_IS_EXCLUDE:
+	case MLD2_CHANGE_TO_INCLUDE: 
 		if (gdeleted || sdeleted)
 			return 0;
+		if (psf->sf_count[MCAST_INCLUDE] == 0)
+			return 0;    // maybe never happen
+		if (type == MLD2_CHANGE_TO_INCLUDE)
+			return 1;
 		return !((pmc->mca_flags & MAF_GSQUERY) && !psf->sf_gsresp);
-	case MLD2_CHANGE_TO_INCLUDE:
-		if (gdeleted || sdeleted)
-			return 0;
-		return psf->sf_count[MCAST_INCLUDE] != 0;
+	case MLD2_MODE_IS_EXCLUDE:
 	case MLD2_CHANGE_TO_EXCLUDE:
 		if (gdeleted || sdeleted)
 			return 0;
 		if (pmc->mca_sfcount[MCAST_EXCLUDE] == 0 ||
 		    psf->sf_count[MCAST_INCLUDE])
 			return 0;
-		return pmc->mca_sfcount[MCAST_EXCLUDE] ==
-			psf->sf_count[MCAST_EXCLUDE];
+		if (pmc->mca_sfcount[MCAST_EXCLUDE] !=
+			psf->sf_count[MCAST_EXCLUDE])
+			return 0;
+		if (type == MLD2_CHANGE_TO_EXCLUDE)
+			return 1;
+		return !((pmc->mca_flags & MAF_GSQUERY) && !psf->sf_gsresp);
 	case MLD2_ALLOW_NEW_SOURCES:
 		if (gdeleted || !psf->sf_crcount)
 			return 0;




--------------040304070804000309000503
Content-Type: text/x-csrc;
 name="test.c"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="test.c"

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

	filter.gf_fmode = MCAST_EXCLUDE;
	inet_pton(PF_INET6, "2002:de12:1780::2", &psin6->sin6_addr);
	setsockopt(sockfds[1], SOL_IPV6, IPV6_ADD_MEMBERSHIP, &req, sizeof(req));
	setsockopt(sockfds[1], SOL_IPV6, MCAST_MSFILTER, &filter, sizeof(filter));

	pause();
	return 0;
}



--------------040304070804000309000503
Content-Type: text/x-csrc;
 name="query.c"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="query.c"

#include <stdio.h>
#include <string.h>
#include <unistd.h>
#include <netinet/in.h>
#include <arpa/inet.h>
#include <sys/socket.h>
#include <sys/types.h>
#define IFINDEX 5 //Please adjust me first.

struct mld2_query {
	uint8_t   type;
	uint8_t   code;
	uint16_t  csum;
	uint16_t  mrc;
	uint16_t  resv1;
	struct in6_addr mca;
	uint8_t   qrv:3,
		  suppress:1,
		  resv2:4;
	uint8_t   qqic;
	uint16_t  nsrcs;
	struct in6_addr srcs[0];
};

int main(int argc ,char *argv[]) {
	
	int len, sockfd; 
	struct mld2_query query;
	struct sockaddr_in6 addr;

	memset(&addr, 0x00, sizeof(addr));
	addr.sin6_family = AF_INET6;
	addr.sin6_scope_id = IFINDEX;
	inet_pton(PF_INET6, "FF02::1", &addr.sin6_addr);
	memset(&query, 0x00, sizeof(query));
	query.type = 130;
	inet_pton(PF_INET6, "FF02::2000", &query.mca);

	sockfd = socket(PF_INET6, SOCK_RAW, IPPROTO_ICMPV6);
	sendto(sockfd, &query, sizeof(query), 0, 
			(struct sockaddr *)&addr, sizeof(addr));
}



--------------040304070804000309000503--
