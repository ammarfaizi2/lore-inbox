Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262845AbVDAS2x@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262845AbVDAS2x (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 1 Apr 2005 13:28:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262843AbVDAS1P
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 1 Apr 2005 13:27:15 -0500
Received: from webmail.topspin.com ([12.162.17.3]:34971 "EHLO
	exch-1.topspincom.com") by vger.kernel.org with ESMTP
	id S262844AbVDASZI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 1 Apr 2005 13:25:08 -0500
Cc: linux-kernel@vger.kernel.org, openib-general@openib.org
Subject: [PATCH][5/6] IB: Fix user MAD registrations with class 0
In-Reply-To: <2005411023.5oEZz0iawuKxVyay@topspin.com>
X-Mailer: Roland's Patchbomber
Date: Fri, 1 Apr 2005 10:23:51 -0800
Message-Id: <2005411023.Wt2K1CXaZGIHp9sH@topspin.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
To: akpm@osdl.org
Content-Transfer-Encoding: 7BIT
From: Roland Dreier <roland@topspin.com>
X-OriginalArrivalTime: 01 Apr 2005 18:23:51.0457 (UTC) FILETIME=[F4565110:01C536E7]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Fix handling of MAD agent registrations with mgmt_class == 0.  In this
case ib_umad should pass a NULL registration request to the MAD core
rather than a request with mgmt_class set to 0.

Signed-off-by: Roland Dreier <roland@topspin.com>


--- linux-export.orig/drivers/infiniband/core/user_mad.c	2005-03-31 19:06:42.000000000 -0800
+++ linux-export/drivers/infiniband/core/user_mad.c	2005-04-01 10:09:01.250588043 -0800
@@ -389,15 +389,17 @@
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

