Return-Path: <linux-kernel-owner+w=401wt.eu-S1751148AbXAFCgq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751148AbXAFCgq (ORCPT <rfc822;w@1wt.eu>);
	Fri, 5 Jan 2007 21:36:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751142AbXAFCdO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 5 Jan 2007 21:33:14 -0500
Received: from 216-99-217-87.dsl.aracnet.com ([216.99.217.87]:36880 "EHLO
	sous-sol.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751139AbXAFCcz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 5 Jan 2007 21:32:55 -0500
Message-Id: <20070106023702.617688000@sous-sol.org>
References: <20070106022753.334962000@sous-sol.org>
User-Agent: quilt/0.45-1
Date: Fri, 05 Jan 2007 18:28:40 -0800
From: Chris Wright <chrisw@sous-sol.org>
To: linux-kernel@vger.kernel.org, stable@kernel.org
Cc: Justin Forbes <jmforbes@linuxtx.org>,
       Zwane Mwaikambo <zwane@arm.linux.org.uk>,
       "Theodore Ts'o" <tytso@mit.edu>, Randy Dunlap <rdunlap@xenotime.net>,
       Dave Jones <davej@redhat.com>, Chuck Wolber <chuckw@quantumlinux.com>,
       Chris Wedgwood <reviews@ml.cw.f00f.org>,
       Michael Krufky <mkrufky@linuxtv.org>, torvalds@osdl.org, akpm@osdl.org,
       alan@lxorguk.ukuu.org.uk, "Paul Moore" <paul.moore@hp.com>
Subject: [patch 47/50] NetLabel: correctly fill in unused CIPSOv4 level and category mappings
Content-Disposition: inline; filename=netlabel-correctly-fill-in-unused-cipsov4-level-and-category-mappings.patch
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-stable review patch.  If anyone has any objections, please let us know.
------------------

From: Paul Moore <paul.moore@hp.com>

Back when the original NetLabel patches were being changed to use Netlink
attributes correctly some code was accidentially dropped which set all of the
undefined CIPSOv4 level and category mappings to a sentinel value.  The result
is the mappings data in the kernel contains bogus mappings which always map to
zero.  Having level and category mappings that map to zero could result in the
kernel assigning incorrect security attributes to packets.

This patch restores the old/correct behavior by initializing the mapping
data to the correct sentinel value.

Signed-off-by: Paul Moore <paul.moore@hp.com>
Signed-off-by: Chris Wright <chrisw@sous-sol.org>
---
 net/netlabel/netlabel_cipso_v4.c |    9 +++++++++
 1 file changed, 9 insertions(+)

--- linux-2.6.19.1.orig/net/netlabel/netlabel_cipso_v4.c
+++ linux-2.6.19.1/net/netlabel/netlabel_cipso_v4.c
@@ -162,6 +162,7 @@ static int netlbl_cipsov4_add_std(struct
 	struct nlattr *nla_b;
 	int nla_a_rem;
 	int nla_b_rem;
+	u32 iter;
 
 	if (!info->attrs[NLBL_CIPSOV4_A_TAGLST] ||
 	    !info->attrs[NLBL_CIPSOV4_A_MLSLVLLST])
@@ -223,6 +224,10 @@ static int netlbl_cipsov4_add_std(struct
 		ret_val = -ENOMEM;
 		goto add_std_failure;
 	}
+	for (iter = 0; iter < doi_def->map.std->lvl.local_size; iter++)
+		doi_def->map.std->lvl.local[iter] = CIPSO_V4_INV_LVL;
+	for (iter = 0; iter < doi_def->map.std->lvl.cipso_size; iter++)
+		doi_def->map.std->lvl.cipso[iter] = CIPSO_V4_INV_LVL;
 	nla_for_each_nested(nla_a,
 			    info->attrs[NLBL_CIPSOV4_A_MLSLVLLST],
 			    nla_a_rem)
@@ -296,6 +301,10 @@ static int netlbl_cipsov4_add_std(struct
 			ret_val = -ENOMEM;
 			goto add_std_failure;
 		}
+		for (iter = 0; iter < doi_def->map.std->cat.local_size; iter++)
+			doi_def->map.std->cat.local[iter] = CIPSO_V4_INV_CAT;
+		for (iter = 0; iter < doi_def->map.std->cat.cipso_size; iter++)
+			doi_def->map.std->cat.cipso[iter] = CIPSO_V4_INV_CAT;
 		nla_for_each_nested(nla_a,
 				    info->attrs[NLBL_CIPSOV4_A_MLSCATLST],
 				    nla_a_rem)

--
