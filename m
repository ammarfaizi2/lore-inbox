Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1946130AbWBDQeF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1946130AbWBDQeF (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 4 Feb 2006 11:34:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1946124AbWBDQeF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 4 Feb 2006 11:34:05 -0500
Received: from sj-iport-4.cisco.com ([171.68.10.86]:4469 "EHLO
	sj-iport-4.cisco.com") by vger.kernel.org with ESMTP
	id S1946130AbWBDQeC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 4 Feb 2006 11:34:02 -0500
X-IronPort-AV: i="4.02,88,1139212800"; 
   d="scan'208"; a="1773422574:sNHT29029000"
Subject: [git patch review 1/2] IB/mad: Handle DR SMPs with a LID routed part
From: Roland Dreier <rolandd@cisco.com>
Date: Sat, 04 Feb 2006 16:33:57 +0000
To: linux-kernel@vger.kernel.org, openib-general@openib.org
X-Mailer: IB-patch-reviewer
Content-Transfer-Encoding: 8bit
Message-ID: <1139070837111-02eec52639fd6aed@cisco.com>
X-OriginalArrivalTime: 04 Feb 2006 16:33:57.0643 (UTC) FILETIME=[CBC2E5B0:01C629A8]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Fix handling of directed route SMPs with a beginning or ending LID
routed part.

Signed-off-by: Ralph Campbell <ralphc@pathscale.com>
Signed-off-by: Hal Rosenstock <halr@voltaire.com>
Signed-off-by: Roland Dreier <rolandd@cisco.com>

---

 drivers/infiniband/core/mad.c |   10 +++++++++-
 1 files changed, 9 insertions(+), 1 deletions(-)

8cf3f04f45694db0699f608c0e3fb550c607cc88
diff --git a/drivers/infiniband/core/mad.c b/drivers/infiniband/core/mad.c
index d393b50..c82f47a 100644
--- a/drivers/infiniband/core/mad.c
+++ b/drivers/infiniband/core/mad.c
@@ -665,7 +665,15 @@ static int handle_outgoing_dr_smp(struct
 	struct ib_wc mad_wc;
 	struct ib_send_wr *send_wr = &mad_send_wr->send_wr;
 
-	if (!smi_handle_dr_smp_send(smp, device->node_type, port_num)) {
+	/*
+	 * Directed route handling starts if the initial LID routed part of
+	 * a request or the ending LID routed part of a response is empty.
+	 * If we are at the start of the LID routed part, don't update the
+	 * hop_ptr or hop_cnt.  See section 14.2.2, Vol 1 IB spec.
+	 */
+	if ((ib_get_smp_direction(smp) ? smp->dr_dlid : smp->dr_slid) ==
+	     IB_LID_PERMISSIVE &&
+	    !smi_handle_dr_smp_send(smp, device->node_type, port_num)) {
 		ret = -EINVAL;
 		printk(KERN_ERR PFX "Invalid directed route\n");
 		goto out;
-- 
1.1.3
