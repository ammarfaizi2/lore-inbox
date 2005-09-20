Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965169AbVITWLt@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965169AbVITWLt (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 20 Sep 2005 18:11:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965167AbVITWI4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 20 Sep 2005 18:08:56 -0400
Received: from ams-iport-1.cisco.com ([144.254.224.140]:48177 "EHLO
	ams-iport-1.cisco.com") by vger.kernel.org with ESMTP
	id S965060AbVITWI2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 20 Sep 2005 18:08:28 -0400
Cc: linux-kernel@vger.kernel.org, openib-general@openib.org
Subject: [PATCH 08/10] IB: Fix data length for RMPP SA sends
In-Reply-To: <2005920158.JalL9e5rI88RbY2o@cisco.com>
X-Mailer: Roland's Patchbomber
Date: Tue, 20 Sep 2005 15:08:11 -0700
Message-Id: <2005920158.z5ALwijFYEKC7SAF@cisco.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
To: torvalds@osdl.org
Content-Transfer-Encoding: 7BIT
From: Roland Dreier <rolandd@cisco.com>
X-OriginalArrivalTime: 20 Sep 2005 22:08:12.0916 (UTC) FILETIME=[CB0AF340:01C5BE2F]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Subject: [PATCH] IB: Fix data length for RMPP SA sends
From: Hal Rosenstock <halr@voltaire.com>
Date: 1127163061 -0700

We need to subtract off the header length from our payload
length when sending multi-packet SA messages.

Signed-off-by: Hal Rosenstock <halr@voltaire.com>
Signed-off-by: Roland Dreier <rolandd@cisco.com>

---

 drivers/infiniband/core/user_mad.c |    5 +++--
 1 files changed, 3 insertions(+), 2 deletions(-)

eff4c654b1a4a5e5493fbdc3affa6dd48765c085
diff --git a/drivers/infiniband/core/user_mad.c b/drivers/infiniband/core/user_mad.c
--- a/drivers/infiniband/core/user_mad.c
+++ b/drivers/infiniband/core/user_mad.c
@@ -334,10 +334,11 @@ static ssize_t ib_umad_write(struct file
 			ret = -EINVAL;
 			goto err_ah;
 		}
-		/* Validate that management class can support RMPP */
+
+		/* Validate that the management class can support RMPP */
 		if (rmpp_mad->mad_hdr.mgmt_class == IB_MGMT_CLASS_SUBN_ADM) {
 			hdr_len = offsetof(struct ib_sa_mad, data);
-			data_len = length;
+			data_len = length - hdr_len;
 		} else if ((rmpp_mad->mad_hdr.mgmt_class >= IB_MGMT_CLASS_VENDOR_RANGE2_START) &&
 			    (rmpp_mad->mad_hdr.mgmt_class <= IB_MGMT_CLASS_VENDOR_RANGE2_END)) {
 				hdr_len = offsetof(struct ib_vendor_mad, data);
