Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932184AbWCDBxt@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932184AbWCDBxt (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 3 Mar 2006 20:53:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932187AbWCDBxt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 3 Mar 2006 20:53:49 -0500
Received: from sj-iport-5.cisco.com ([171.68.10.87]:42895 "EHLO
	sj-iport-5.cisco.com") by vger.kernel.org with ESMTP
	id S932184AbWCDBxt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 3 Mar 2006 20:53:49 -0500
X-IronPort-AV: i="4.02,164,1139212800"; 
   d="scan'208"; a="259474475:sNHT30380308"
To: torvalds@osdl.org
Cc: linux-kernel@vger.kernel.org, openib-general@openib.org
Subject: [git pull] IB SRP fix for 2.6.16-rc5
X-Message-Flag: Warning: May contain useful information
From: Roland Dreier <rdreier@cisco.com>
Date: Fri, 03 Mar 2006 17:53:46 -0800
Message-ID: <adapsl30yc5.fsf@cisco.com>
User-Agent: Gnus/5.1007 (Gnus v5.10.7) XEmacs/21.4.18 (linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-OriginalArrivalTime: 04 Mar 2006 01:53:48.0283 (UTC) FILETIME=[7A7F0CB0:01C63F2E]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Linus, please pull from

    master.kernel.org:/pub/scm/linux/kernel/git/roland/infiniband.git for-linus

This tree is also available from kernel.org mirrors at:

    git://git.kernel.org/pub/scm/linux/kernel/git/roland/infiniband.git for-linus

The pull will get the following change, which fixes a potential crash
when a connection to an SRP storage target is lost:

Roland Dreier:
      IB/srp: Don't send task management commands after target removal

 drivers/infiniband/ulp/srp/ib_srp.c |    6 ++++++
 1 files changed, 6 insertions(+), 0 deletions(-)



--- a/drivers/infiniband/ulp/srp/ib_srp.c
+++ b/drivers/infiniband/ulp/srp/ib_srp.c
@@ -1155,6 +1155,12 @@ static int srp_send_tsk_mgmt(struct scsi
 
 	spin_lock_irq(target->scsi_host->host_lock);
 
+	if (target->state == SRP_TARGET_DEAD ||
+	    target->state == SRP_TARGET_REMOVED) {
+		scmnd->result = DID_BAD_TARGET << 16;
+		goto out;
+	}
+
 	if (scmnd->host_scribble == (void *) -1L)
 		goto out;
 
