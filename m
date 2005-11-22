Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965188AbVKVVLX@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965188AbVKVVLX (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 22 Nov 2005 16:11:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965210AbVKVVKf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 22 Nov 2005 16:10:35 -0500
Received: from smtp.osdl.org ([65.172.181.4]:39839 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S965188AbVKVVJt (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 22 Nov 2005 16:09:49 -0500
Date: Tue, 22 Nov 2005 13:07:56 -0800
From: Chris Wright <chrisw@osdl.org>
To: linux-kernel@vger.kernel.org, stable@kernel.org
Cc: Justin Forbes <jmforbes@linuxtx.org>,
       Zwane Mwaikambo <zwane@arm.linux.org.uk>,
       "Theodore Ts'o" <tytso@mit.edu>, Randy Dunlap <rdunlap@xenotime.net>,
       Dave Jones <davej@redhat.com>, Chuck Wolber <chuckw@quantumlinux.com>,
       torvalds@osdl.org, akpm@osdl.org, alan@lxorguk.ukuu.org.uk,
       Harald Welte <laforge@netfilter.org>,
       Philip Craig <philipc@snapgear.com>
Subject: [patch 12/23] [PATCH] [NETFILTER] PPTP helper: fix PNS-PAC expectation call id
Message-ID: <20051122210756.GM28140@shell0.pdx.osdl.net>
References: <20051122205223.099537000@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline; filename="pptp-helper-fix-pns-pac-expectation-call-id.patch"
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-stable review patch.  If anyone has any objections, please let us know.
------------------

The reply tuple of the PNS->PAC expectation was using the wrong call id.

So we had the following situation:
- PNS behind NAT firewall
- PNS call id requires NATing
- PNS->PAC gre packet arrives first

then the PNS->PAC expectation is matched, and the other expectation
is deleted, but the PAC->PNS gre packets do not match the gre conntrack
because the call id is wrong.

We also cannot use ip_nat_follow_master().

Signed-off-by: Philip Craig <philipc@snapgear.com>
Signed-off-by: Harald Welte <laforge@netfilter.org>
Signed-off-by: Chris Wright <chrisw@osdl.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@suse.de>
---
 net/ipv4/netfilter/ip_nat_helper_pptp.c |   28 ++++++++++++++++++++++++++--
 1 file changed, 26 insertions(+), 2 deletions(-)

--- linux-2.6.14.2.orig/net/ipv4/netfilter/ip_nat_helper_pptp.c
+++ linux-2.6.14.2/net/ipv4/netfilter/ip_nat_helper_pptp.c
@@ -73,6 +73,7 @@ static void pptp_nat_expected(struct ip_
 	struct ip_conntrack_tuple t;
 	struct ip_ct_pptp_master *ct_pptp_info;
 	struct ip_nat_pptp *nat_pptp_info;
+	struct ip_nat_range range;
 
 	ct_pptp_info = &master->help.ct_pptp_info;
 	nat_pptp_info = &master->nat.help.nat_pptp_info;
@@ -110,7 +111,30 @@ static void pptp_nat_expected(struct ip_
 		DEBUGP("not found!\n");
 	}
 
-	ip_nat_follow_master(ct, exp);
+	/* This must be a fresh one. */
+	BUG_ON(ct->status & IPS_NAT_DONE_MASK);
+
+	/* Change src to where master sends to */
+	range.flags = IP_NAT_RANGE_MAP_IPS;
+	range.min_ip = range.max_ip
+		= ct->master->tuplehash[!exp->dir].tuple.dst.ip;
+	if (exp->dir == IP_CT_DIR_ORIGINAL) {
+		range.flags |= IP_NAT_RANGE_PROTO_SPECIFIED;
+		range.min = range.max = exp->saved_proto;
+	}
+	/* hook doesn't matter, but it has to do source manip */
+	ip_nat_setup_info(ct, &range, NF_IP_POST_ROUTING);
+
+	/* For DST manip, map port here to where it's expected. */
+	range.flags = IP_NAT_RANGE_MAP_IPS;
+	range.min_ip = range.max_ip
+		= ct->master->tuplehash[!exp->dir].tuple.src.ip;
+	if (exp->dir == IP_CT_DIR_REPLY) {
+		range.flags |= IP_NAT_RANGE_PROTO_SPECIFIED;
+		range.min = range.max = exp->saved_proto;
+	}
+	/* hook doesn't matter, but it has to do destination manip */
+	ip_nat_setup_info(ct, &range, NF_IP_PRE_ROUTING);
 }
 
 /* outbound packets == from PNS to PAC */
@@ -213,7 +237,7 @@ pptp_exp_gre(struct ip_conntrack_expect 
 
 	/* alter expectation for PNS->PAC direction */
 	invert_tuplepr(&inv_t, &expect_orig->tuple);
-	expect_orig->saved_proto.gre.key = htons(nat_pptp_info->pac_call_id);
+	expect_orig->saved_proto.gre.key = htons(ct_pptp_info->pns_call_id);
 	expect_orig->tuple.src.u.gre.key = htons(nat_pptp_info->pns_call_id);
 	expect_orig->tuple.dst.u.gre.key = htons(ct_pptp_info->pac_call_id);
 	inv_t.src.ip = reply_t->src.ip;

--
