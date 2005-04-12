Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262314AbVDLKwQ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262314AbVDLKwQ (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 12 Apr 2005 06:52:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262264AbVDLKvl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 12 Apr 2005 06:51:41 -0400
Received: from fire.osdl.org ([65.172.181.4]:35530 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S262268AbVDLKdT (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 12 Apr 2005 06:33:19 -0400
Message-Id: <200504121033.j3CAXBNC005801@shell0.pdx.osdl.net>
Subject: [patch 161/198] IB: Fix user MAD registrations with class 0
To: torvalds@osdl.org
Cc: linux-kernel@vger.kernel.org, akpm@osdl.org, roland@topspin.com
From: akpm@osdl.org
Date: Tue, 12 Apr 2005 03:33:05 -0700
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


From: Roland Dreier <roland@topspin.com>

Fix handling of MAD agent registrations with mgmt_class == 0.  In this case
ib_umad should pass a NULL registration request to the MAD core rather than a
request with mgmt_class set to 0.

Signed-off-by: Roland Dreier <roland@topspin.com>
Signed-off-by: Andrew Morton <akpm@osdl.org>
---

 25-akpm/drivers/infiniband/core/user_mad.c |   14 ++++++++------
 1 files changed, 8 insertions(+), 6 deletions(-)

diff -puN drivers/infiniband/core/user_mad.c~ib-fix-user-mad-registrations-with-class-0 drivers/infiniband/core/user_mad.c
--- 25/drivers/infiniband/core/user_mad.c~ib-fix-user-mad-registrations-with-class-0	2005-04-12 03:21:41.957758352 -0700
+++ 25-akpm/drivers/infiniband/core/user_mad.c	2005-04-12 03:21:41.960757896 -0700
@@ -389,15 +389,17 @@ static int ib_umad_reg_agent(struct ib_u
 	goto out;
 
 found:
-	req.mgmt_class         = ureq.mgmt_class;
-	req.mgmt_class_version = ureq.mgmt_class_version;
-	memcpy(req.method_mask, ureq.method_mask, sizeof req.method_mask);
-	memcpy(req.oui,         ureq.oui,         sizeof req.oui);
+	if (ureq.mgmt_class) {
+		req.mgmt_class         = ureq.mgmt_class;
+		req.mgmt_class_version = ureq.mgmt_class_version;
+		memcpy(req.method_mask, ureq.method_mask, sizeof req.method_mask);
+		memcpy(req.oui,         ureq.oui,         sizeof req.oui);
+	}
 
 	agent = ib_register_mad_agent(file->port->ib_dev, file->port->port_num,
 				      ureq.qpn ? IB_QPT_GSI : IB_QPT_SMI,
-				      &req, 0, send_handler, recv_handler,
-				      file);
+				      ureq.mgmt_class ? &req : NULL,
+				      0, send_handler, recv_handler, file);
 	if (IS_ERR(agent)) {
 		ret = PTR_ERR(agent);
 		goto out;
_
