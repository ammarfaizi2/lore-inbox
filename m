Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267345AbTBSUa6>; Wed, 19 Feb 2003 15:30:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267346AbTBSUa6>; Wed, 19 Feb 2003 15:30:58 -0500
Received: from e32.co.us.ibm.com ([32.97.110.130]:52096 "EHLO
	e32.co.us.ibm.com") by vger.kernel.org with ESMTP
	id <S267345AbTBSUa4>; Wed, 19 Feb 2003 15:30:56 -0500
Subject: [PATCH] IPSec protocol application order
From: Tom Lendacky <toml@us.ibm.com>
To: linux-kernel@vger.kernel.org
Cc: davem@redhat.com, kuznet@ms2.inr.ac.ru, toml@us.ibm.com
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.8 (1.0.8-10) 
Date: 19 Feb 2003 14:42:19 -0600
Message-Id: <1045687340.3419.14.camel@tomlt2.austin.ibm.com>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The IPSec RFC (2401) and IPComp RFC (3173) specify the order in which
the COMP, ESP and AH protocols must be applied when being applied in
transport mode.  Specifically, COMP must be applied first, then ESP
and then AH.  Also, transport mode protocols must be applied before
tunnel mode protocols.

Here is a patch that creates the xfrm_tmpl structures in the order
required by the RFCs.  The patch requires that the application order
of new transformations/protocols be specified for transport mode
in order to have an xfrm_tmpl structure created.  If this is not
desired, an additional transport mode loop can be placed ahead of the
COMP/ESP/AH transport mode loops that creates xfrm_tmpl structures
for protocols other than COMP/ESP/AH.

Tom

--- linux-2.5.62-orig/net/key/af_key.c	2003-02-17 16:56:09.000000000 -0600
+++ linux-2.5.62/net/key/af_key.c	2003-02-19 09:00:53.000000000 -0600
@@ -1562,12 +1562,58 @@
 parse_ipsecrequests(struct xfrm_policy *xp, struct sadb_x_policy *pol)
 {
 	int err;
-	int len = pol->sadb_x_policy_len*8 - sizeof(struct sadb_x_policy);
-	struct sadb_x_ipsecrequest *rq = (void*)(pol+1);
+	int len;
+	struct sadb_x_ipsecrequest *rq;
 
+	/* The order of template creation is important (RFC2401/RFC3173):
+		Transport templates first
+			COMP then
+			ESP then
+			AH then
+		Tunnel templates in any order */
+	len = pol->sadb_x_policy_len*8 - sizeof(struct sadb_x_policy);
+	rq = (void*)(pol+1);
 	while (len >= sizeof(struct sadb_x_ipsecrequest)) {
-		if ((err = parse_ipsecrequest(xp, rq)) < 0)
-			return err;
+		if (rq->sadb_x_ipsecrequest_mode == IPSEC_MODE_TRANSPORT &&
+		    rq->sadb_x_ipsecrequest_proto == IPPROTO_COMP) {
+			if ((err = parse_ipsecrequest(xp, rq)) < 0)
+				return err;
+		}
+		len -= rq->sadb_x_ipsecrequest_len;
+		rq = (void*)((u8*)rq + rq->sadb_x_ipsecrequest_len);
+	}
+	
+	len = pol->sadb_x_policy_len*8 - sizeof(struct sadb_x_policy);
+	rq = (void*)(pol+1);
+	while (len >= sizeof(struct sadb_x_ipsecrequest)) {
+		if (rq->sadb_x_ipsecrequest_mode == IPSEC_MODE_TRANSPORT &&
+		    rq->sadb_x_ipsecrequest_proto == IPPROTO_ESP) {
+			if ((err = parse_ipsecrequest(xp, rq)) < 0)
+				return err;
+		}
+		len -= rq->sadb_x_ipsecrequest_len;
+		rq = (void*)((u8*)rq + rq->sadb_x_ipsecrequest_len);
+	}
+	
+	len = pol->sadb_x_policy_len*8 - sizeof(struct sadb_x_policy);
+	rq = (void*)(pol+1);
+	while (len >= sizeof(struct sadb_x_ipsecrequest)) {
+		if (rq->sadb_x_ipsecrequest_mode == IPSEC_MODE_TRANSPORT &&
+		    rq->sadb_x_ipsecrequest_proto == IPPROTO_AH) {
+			if ((err = parse_ipsecrequest(xp, rq)) < 0)
+				return err;
+		}
+		len -= rq->sadb_x_ipsecrequest_len;
+		rq = (void*)((u8*)rq + rq->sadb_x_ipsecrequest_len);
+	}
+	
+	len = pol->sadb_x_policy_len*8 - sizeof(struct sadb_x_policy);
+	rq = (void*)(pol+1);
+	while (len >= sizeof(struct sadb_x_ipsecrequest)) {
+		if (rq->sadb_x_ipsecrequest_mode != IPSEC_MODE_TRANSPORT) {
+			if ((err = parse_ipsecrequest(xp, rq)) < 0)
+				return err;
+		}
 		len -= rq->sadb_x_ipsecrequest_len;
 		rq = (void*)((u8*)rq + rq->sadb_x_ipsecrequest_len);
 	}

