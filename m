Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932498AbWI1QIl@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932498AbWI1QIl (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 28 Sep 2006 12:08:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964932AbWI1QIG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 28 Sep 2006 12:08:06 -0400
Received: from mx.pathscale.com ([64.160.42.68]:63669 "EHLO mx.pathscale.com")
	by vger.kernel.org with ESMTP id S1751861AbWI1QBW (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 28 Sep 2006 12:01:22 -0400
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: [PATCH 10 of 28] IB/ipath - RC and UC should validate SLID and DLID
X-Mercurial-Node: f8c0eb9dc3b8ddcf8f4c69ce786ad3543404ce72
Message-Id: <f8c0eb9dc3b8ddcf8f4c.1159459206@eng-12.pathscale.com>
In-Reply-To: <patchbomb.1159459196@eng-12.pathscale.com>
Date: Thu, 28 Sep 2006 09:00:06 -0700
From: "Bryan O'Sullivan" <bos@pathscale.com>
To: rdreier@cisco.com
Cc: linux-kernel@vger.kernel.org, openib-general@openib.org
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is required for IB conformance (spec ch. 9.6.1.5).

Signed-off-by: Bryan O'Sullivan <bryan.osullivan@qlogic.com>

diff -r 934e5c1d6ade -r f8c0eb9dc3b8 drivers/infiniband/hw/ipath/ipath_rc.c
--- a/drivers/infiniband/hw/ipath/ipath_rc.c	Thu Sep 28 08:57:12 2006 -0700
+++ b/drivers/infiniband/hw/ipath/ipath_rc.c	Thu Sep 28 08:57:12 2006 -0700
@@ -1319,6 +1319,10 @@ void ipath_rc_rcv(struct ipath_ibdev *de
 	int diff;
 	struct ib_reth *reth;
 	int header_in_data;
+
+	/* Validate the SLID. See Ch. 9.6.1.5 */
+	if (unlikely(be16_to_cpu(hdr->lrh[3]) != qp->remote_ah_attr.dlid))
+		goto done;
 
 	/* Check for GRH */
 	if (!has_grh) {
diff -r 934e5c1d6ade -r f8c0eb9dc3b8 drivers/infiniband/hw/ipath/ipath_uc.c
--- a/drivers/infiniband/hw/ipath/ipath_uc.c	Thu Sep 28 08:57:12 2006 -0700
+++ b/drivers/infiniband/hw/ipath/ipath_uc.c	Thu Sep 28 08:57:12 2006 -0700
@@ -246,6 +246,10 @@ void ipath_uc_rcv(struct ipath_ibdev *de
 	struct ib_reth *reth;
 	int header_in_data;
 
+	/* Validate the SLID. See Ch. 9.6.1.5 */
+	if (unlikely(be16_to_cpu(hdr->lrh[3]) != qp->remote_ah_attr.dlid))
+		goto done;
+
 	/* Check for GRH */
 	if (!has_grh) {
 		ohdr = &hdr->u.oth;
