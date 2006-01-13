Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161653AbWAMDTu@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161653AbWAMDTu (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 12 Jan 2006 22:19:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161654AbWAMDTr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 12 Jan 2006 22:19:47 -0500
Received: from 216-99-217-87.dsl.aracnet.com ([216.99.217.87]:20098 "EHLO
	sorel.sous-sol.org") by vger.kernel.org with ESMTP id S1161650AbWAMDTY
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 12 Jan 2006 22:19:24 -0500
Message-Id: <20060113032245.187793000@sorel.sous-sol.org>
References: <20060113032102.154909000@sorel.sous-sol.org>
Date: Thu, 12 Jan 2006 18:37:48 -0800
From: Chris Wright <chrisw@sous-sol.org>
To: linux-kernel@vger.kernel.org, stable@kernel.org
Cc: Justin Forbes <jmforbes@linuxtx.org>,
       Zwane Mwaikambo <zwane@arm.linux.org.uk>,
       "Theodore Ts'o" <tytso@mit.edu>, Randy Dunlap <rdunlap@xenotime.net>,
       Dave Jones <davej@redhat.com>, Chuck Wolber <chuckw@quantumlinux.com>,
       torvalds@osdl.org, akpm@osdl.org, alan@lxorguk.ukuu.org.uk,
       Patrick McHardy <kaber@trash.net>
Subject: [PATCH 10/17] [NETFILTER]: Fix another crash in ip_nat_pptp
Content-Disposition: inline; filename=netfilter-fix-another-crash-in-ip_nat_pptp.patch
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-stable review patch.  If anyone has any objections, please let us know.
------------------

The PPTP NAT helper calculates the offset at which the packet needs
to be mangled as difference between two pointers to the header. With
non-linear skbs however the pointers may point to two seperate buffers
on the stack and the calculation results in a wrong offset beeing
used.

Signed-off-by: Patrick McHardy <kaber@trash.net>
Signed-off-by: Chris Wright <chrisw@sous-sol.org>
---
 net/ipv4/netfilter/ip_nat_helper_pptp.c |   57 +++++++++++++++-----------------
 1 file changed, 27 insertions(+), 30 deletions(-)

--- linux-2.6.15.y.orig/net/ipv4/netfilter/ip_nat_helper_pptp.c
+++ linux-2.6.15.y/net/ipv4/netfilter/ip_nat_helper_pptp.c
@@ -148,14 +148,14 @@ pptp_outbound_pkt(struct sk_buff **pskb,
 {
 	struct ip_ct_pptp_master *ct_pptp_info = &ct->help.ct_pptp_info;
 	struct ip_nat_pptp *nat_pptp_info = &ct->nat.help.nat_pptp_info;
-
-	u_int16_t msg, *cid = NULL, new_callid;
+	u_int16_t msg, new_callid;
+	unsigned int cid_off;
 
 	new_callid = htons(ct_pptp_info->pns_call_id);
 	
 	switch (msg = ntohs(ctlh->messageType)) {
 		case PPTP_OUT_CALL_REQUEST:
-			cid = &pptpReq->ocreq.callID;
+			cid_off = offsetof(union pptp_ctrl_union, ocreq.callID);
 			/* FIXME: ideally we would want to reserve a call ID
 			 * here.  current netfilter NAT core is not able to do
 			 * this :( For now we use TCP source port. This breaks
@@ -172,10 +172,10 @@ pptp_outbound_pkt(struct sk_buff **pskb,
 			ct_pptp_info->pns_call_id = ntohs(new_callid);
 			break;
 		case PPTP_IN_CALL_REPLY:
-			cid = &pptpReq->icreq.callID;
+			cid_off = offsetof(union pptp_ctrl_union, icreq.callID);
 			break;
 		case PPTP_CALL_CLEAR_REQUEST:
-			cid = &pptpReq->clrreq.callID;
+			cid_off = offsetof(union pptp_ctrl_union, clrreq.callID);
 			break;
 		default:
 			DEBUGP("unknown outbound packet 0x%04x:%s\n", msg,
@@ -197,18 +197,15 @@ pptp_outbound_pkt(struct sk_buff **pskb,
 
 	/* only OUT_CALL_REQUEST, IN_CALL_REPLY, CALL_CLEAR_REQUEST pass
 	 * down to here */
-
-	IP_NF_ASSERT(cid);
-
 	DEBUGP("altering call id from 0x%04x to 0x%04x\n",
-		ntohs(*cid), ntohs(new_callid));
+		ntohs(*(u_int16_t *)pptpReq + cid_off), ntohs(new_callid));
 
 	/* mangle packet */
 	if (ip_nat_mangle_tcp_packet(pskb, ct, ctinfo,
-		(void *)cid - ((void *)ctlh - sizeof(struct pptp_pkt_hdr)),
-				 	sizeof(new_callid), 
-					(char *)&new_callid,
-				 	sizeof(new_callid)) == 0)
+	                             cid_off + sizeof(struct pptp_pkt_hdr) +
+	                             sizeof(struct PptpControlHeader),
+	                             sizeof(new_callid), (char *)&new_callid,
+	                             sizeof(new_callid)) == 0)
 		return NF_DROP;
 
 	return NF_ACCEPT;
@@ -299,7 +296,8 @@ pptp_inbound_pkt(struct sk_buff **pskb,
 		 union pptp_ctrl_union *pptpReq)
 {
 	struct ip_nat_pptp *nat_pptp_info = &ct->nat.help.nat_pptp_info;
-	u_int16_t msg, new_cid = 0, new_pcid, *pcid = NULL, *cid = NULL;
+	u_int16_t msg, new_cid = 0, new_pcid;
+	unsigned int pcid_off, cid_off = 0;
 
 	int ret = NF_ACCEPT, rv;
 
@@ -307,23 +305,23 @@ pptp_inbound_pkt(struct sk_buff **pskb,
 
 	switch (msg = ntohs(ctlh->messageType)) {
 	case PPTP_OUT_CALL_REPLY:
-		pcid = &pptpReq->ocack.peersCallID;	
-		cid = &pptpReq->ocack.callID;
+		pcid_off = offsetof(union pptp_ctrl_union, ocack.peersCallID);
+		cid_off = offsetof(union pptp_ctrl_union, ocack.callID);
 		break;
 	case PPTP_IN_CALL_CONNECT:
-		pcid = &pptpReq->iccon.peersCallID;
+		pcid_off = offsetof(union pptp_ctrl_union, iccon.peersCallID);
 		break;
 	case PPTP_IN_CALL_REQUEST:
 		/* only need to nat in case PAC is behind NAT box */
 		return NF_ACCEPT;
 	case PPTP_WAN_ERROR_NOTIFY:
-		pcid = &pptpReq->wanerr.peersCallID;
+		pcid_off = offsetof(union pptp_ctrl_union, wanerr.peersCallID);
 		break;
 	case PPTP_CALL_DISCONNECT_NOTIFY:
-		pcid = &pptpReq->disc.callID;
+		pcid_off = offsetof(union pptp_ctrl_union, disc.callID);
 		break;
 	case PPTP_SET_LINK_INFO:
-		pcid = &pptpReq->setlink.peersCallID;
+		pcid_off = offsetof(union pptp_ctrl_union, setlink.peersCallID);
 		break;
 
 	default:
@@ -345,25 +343,24 @@ pptp_inbound_pkt(struct sk_buff **pskb,
 	 * WAN_ERROR_NOTIFY, CALL_DISCONNECT_NOTIFY pass down here */
 
 	/* mangle packet */
-	IP_NF_ASSERT(pcid);
 	DEBUGP("altering peer call id from 0x%04x to 0x%04x\n",
-		ntohs(*pcid), ntohs(new_pcid));
+		ntohs(*(u_int16_t *)pptpReq + pcid_off), ntohs(new_pcid));
 	
-	rv = ip_nat_mangle_tcp_packet(pskb, ct, ctinfo, 
-				      (void *)pcid - ((void *)ctlh - sizeof(struct pptp_pkt_hdr)),
+	rv = ip_nat_mangle_tcp_packet(pskb, ct, ctinfo,
+	                              pcid_off + sizeof(struct pptp_pkt_hdr) +
+				      sizeof(struct PptpControlHeader),
 				      sizeof(new_pcid), (char *)&new_pcid, 
 				      sizeof(new_pcid));
 	if (rv != NF_ACCEPT) 
 		return rv;
 
 	if (new_cid) {
-		IP_NF_ASSERT(cid);
 		DEBUGP("altering call id from 0x%04x to 0x%04x\n",
-			ntohs(*cid), ntohs(new_cid));
-		rv = ip_nat_mangle_tcp_packet(pskb, ct, ctinfo, 
-					      (void *)cid - ((void *)ctlh - sizeof(struct pptp_pkt_hdr)), 
-					      sizeof(new_cid),
-					      (char *)&new_cid, 
+			ntohs(*(u_int16_t *)pptpReq + cid_off), ntohs(new_cid));
+		rv = ip_nat_mangle_tcp_packet(pskb, ct, ctinfo,
+		                              cid_off + sizeof(struct pptp_pkt_hdr) +
+					      sizeof(struct PptpControlHeader),
+					      sizeof(new_cid), (char *)&new_cid, 
 					      sizeof(new_cid));
 		if (rv != NF_ACCEPT)
 			return rv;

--
