Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161263AbWF0UM4@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161263AbWF0UM4 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 27 Jun 2006 16:12:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161265AbWF0UM4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 27 Jun 2006 16:12:56 -0400
Received: from 216-99-217-87.dsl.aracnet.com ([216.99.217.87]:35968 "EHLO
	sous-sol.org") by vger.kernel.org with ESMTP id S1161259AbWF0UMy
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 27 Jun 2006 16:12:54 -0400
Message-Id: <20060627201036.008604000@sous-sol.org>
References: <20060627200745.771284000@sous-sol.org>
User-Agent: quilt/0.45-1
Date: Tue, 27 Jun 2006 00:00:06 -0700
From: Chris Wright <chrisw@sous-sol.org>
To: linux-kernel@vger.kernel.org, stable@kernel.org
Cc: Justin Forbes <jmforbes@linuxtx.org>,
       Zwane Mwaikambo <zwane@arm.linux.org.uk>,
       "Theodore Ts'o" <tytso@mit.edu>, Randy Dunlap <rdunlap@xenotime.net>,
       Dave Jones <davej@redhat.com>, Chuck Wolber <chuckw@quantumlinux.com>,
       Chris Wedgwood <reviews@ml.cw.f00f.org>, torvalds@osdl.org,
       akpm@osdl.org, alan@lxorguk.ukuu.org.uk,
       David Miller <davem@davemloft.net>,
       Vlad Yasevich <vladislav.yasevich@hp.com>,
       Sridhar Samudrala <sri@us.ibm.com>
Subject: [PATCH 06/25] SCTP: Reject sctp packets with broadcast addresses.
Content-Disposition: inline; filename=reject-sctp-packets-with-broadcast-addresses.patch
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-stable review patch.  If anyone has any objections, please let us know.
------------------

From: Vlad Yasevich <vladislav.yasevich@hp.com>

Make SCTP handle broadcast properly

Signed-off-by: Vlad Yasevich <vladislav.yasevich@hp.com>
Signed-off-by: Sridhar Samudrala <sri@us.ibm.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Chris Wright <chrisw@sous-sol.org>
---

 include/net/sctp/structs.h |    3 ++-
 net/sctp/input.c           |    3 ++-
 net/sctp/ipv6.c            |    6 ++++--
 net/sctp/protocol.c        |    8 +++++++-
 net/sctp/socket.c          |    2 +-
 5 files changed, 16 insertions(+), 6 deletions(-)

--- linux-2.6.17.1.orig/include/net/sctp/structs.h
+++ linux-2.6.17.1/include/net/sctp/structs.h
@@ -555,7 +555,8 @@ struct sctp_af {
 	int		(*to_addr_param) (const union sctp_addr *,
 					  union sctp_addr_param *); 
 	int		(*addr_valid)	(union sctp_addr *,
-					 struct sctp_sock *);
+					 struct sctp_sock *,
+					 const struct sk_buff *);
 	sctp_scope_t	(*scope) (union sctp_addr *);
 	void		(*inaddr_any)	(union sctp_addr *, unsigned short);
 	int		(*is_any)	(const union sctp_addr *);
--- linux-2.6.17.1.orig/net/sctp/input.c
+++ linux-2.6.17.1/net/sctp/input.c
@@ -170,7 +170,8 @@ int sctp_rcv(struct sk_buff *skb)
 	 * IP broadcast addresses cannot be used in an SCTP transport
 	 * address."
 	 */
-	if (!af->addr_valid(&src, NULL) || !af->addr_valid(&dest, NULL))
+	if (!af->addr_valid(&src, NULL, skb) ||
+	    !af->addr_valid(&dest, NULL, skb))
 		goto discard_it;
 
 	asoc = __sctp_rcv_lookup(skb, &src, &dest, &transport);
--- linux-2.6.17.1.orig/net/sctp/ipv6.c
+++ linux-2.6.17.1/net/sctp/ipv6.c
@@ -523,7 +523,9 @@ static int sctp_v6_available(union sctp_
  * Return 0 - If the address is a non-unicast or an illegal address.
  * Return 1 - If the address is a unicast.
  */
-static int sctp_v6_addr_valid(union sctp_addr *addr, struct sctp_sock *sp)
+static int sctp_v6_addr_valid(union sctp_addr *addr,
+			      struct sctp_sock *sp,
+			      const struct sk_buff *skb)
 {
 	int ret = ipv6_addr_type(&addr->v6.sin6_addr);
 
@@ -537,7 +539,7 @@ static int sctp_v6_addr_valid(union sctp
 		if (sp && ipv6_only_sock(sctp_opt2sk(sp)))
 			return 0;
 		sctp_v6_map_v4(addr);
-		return sctp_get_af_specific(AF_INET)->addr_valid(addr, sp);
+		return sctp_get_af_specific(AF_INET)->addr_valid(addr, sp, skb);
 	}
 
 	/* Is this a non-unicast address */
--- linux-2.6.17.1.orig/net/sctp/protocol.c
+++ linux-2.6.17.1/net/sctp/protocol.c
@@ -365,12 +365,18 @@ static int sctp_v4_is_any(const union sc
  * Return 0 - If the address is a non-unicast or an illegal address.
  * Return 1 - If the address is a unicast.
  */
-static int sctp_v4_addr_valid(union sctp_addr *addr, struct sctp_sock *sp)
+static int sctp_v4_addr_valid(union sctp_addr *addr,
+			      struct sctp_sock *sp,
+			      const struct sk_buff *skb)
 {
 	/* Is this a non-unicast address or a unusable SCTP address? */
 	if (IS_IPV4_UNUSABLE_ADDRESS(&addr->v4.sin_addr.s_addr))
 		return 0;
 
+ 	/* Is this a broadcast address? */
+ 	if (skb && ((struct rtable *)skb->dst)->rt_flags & RTCF_BROADCAST)
+ 		return 0;
+
 	return 1;
 }
 
--- linux-2.6.17.1.orig/net/sctp/socket.c
+++ linux-2.6.17.1/net/sctp/socket.c
@@ -172,7 +172,7 @@ static inline int sctp_verify_addr(struc
 		return -EINVAL;
 
 	/* Is this a valid SCTP address?  */
-	if (!af->addr_valid(addr, sctp_sk(sk)))
+	if (!af->addr_valid(addr, sctp_sk(sk), NULL))
 		return -EINVAL;
 
 	if (!sctp_sk(sk)->pf->send_verify(sctp_sk(sk), (addr)))

--
