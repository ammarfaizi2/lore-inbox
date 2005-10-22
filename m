Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750753AbVJVRED@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750753AbVJVRED (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 22 Oct 2005 13:04:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750754AbVJVREB
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 22 Oct 2005 13:04:01 -0400
Received: from ams-iport-1.cisco.com ([144.254.224.140]:4654 "EHLO
	ams-iport-1.cisco.com") by vger.kernel.org with ESMTP
	id S1750753AbVJVREA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 22 Oct 2005 13:04:00 -0400
To: torvalds@osdl.org, linux-kernel@vger.kernel.org
Cc: openib-general@openib.org
Subject: [git pull] InfiniBand fix for 2.6.14-rc5
X-Message-Flag: Warning: May contain useful information
From: Roland Dreier <rolandd@cisco.com>
Date: Sat, 22 Oct 2005 10:03:53 -0700
Message-ID: <52fyqta3gm.fsf@cisco.com>
User-Agent: Gnus/5.1007 (Gnus v5.10.7) XEmacs/21.4.17 (Jumbo Shrimp, linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
X-OriginalArrivalTime: 22 Oct 2005 17:03:54.0446 (UTC) FILETIME=[955D86E0:01C5D72A]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Linus, please pull from

    master.kernel.org:/pub/scm/linux/kernel/git/roland/infiniband.git for-linus

This tree is also available from kernel.org mirrors at:

    rsync://rsync.kernel.org/pub/scm/linux/kernel/git/roland/infiniband.git for-linus

This will get the following change, which fixes a subtle bug biting
some users:

    [IB] mthca: Always re-arm EQs in mthca_tavor_interrupt()
    
    We should always re-arm an event queue's interrupt in
    mthca_tavor_interrupt() if the corresponding bit is set in the event
    cause register (ECR), even if we didn't find any entries in the EQ.
    If we don't, then there's a window where we miss an EQ entry and then
    get stuck because we don't get another EQ event.
    
    Signed-off-by: Roland Dreier <rolandd@cisco.com>

 drivers/infiniband/hw/mthca/mthca_eq.c |   23 ++++++++++++-----------
 1 files changed, 12 insertions(+), 11 deletions(-)


diff --git a/drivers/infiniband/hw/mthca/mthca_eq.c b/drivers/infiniband/hw/mthca/mthca_eq.c
--- a/drivers/infiniband/hw/mthca/mthca_eq.c
+++ b/drivers/infiniband/hw/mthca/mthca_eq.c
@@ -396,20 +396,21 @@ static irqreturn_t mthca_tavor_interrupt
 		writel(dev->eq_table.clr_mask, dev->eq_table.clr_int);
 
 	ecr = readl(dev->eq_regs.tavor.ecr_base + 4);
-	if (ecr) {
-		writel(ecr, dev->eq_regs.tavor.ecr_base +
-		       MTHCA_ECR_CLR_BASE - MTHCA_ECR_BASE + 4);
-
-		for (i = 0; i < MTHCA_NUM_EQ; ++i)
-			if (ecr & dev->eq_table.eq[i].eqn_mask &&
-			    mthca_eq_int(dev, &dev->eq_table.eq[i])) {
+	if (!ecr)
+		return IRQ_NONE;
+
+	writel(ecr, dev->eq_regs.tavor.ecr_base +
+	       MTHCA_ECR_CLR_BASE - MTHCA_ECR_BASE + 4);
+
+	for (i = 0; i < MTHCA_NUM_EQ; ++i)
+		if (ecr & dev->eq_table.eq[i].eqn_mask) {
+			if (mthca_eq_int(dev, &dev->eq_table.eq[i]))
 				tavor_set_eq_ci(dev, &dev->eq_table.eq[i],
 						dev->eq_table.eq[i].cons_index);
-				tavor_eq_req_not(dev, dev->eq_table.eq[i].eqn);
-			}
-	}
+			tavor_eq_req_not(dev, dev->eq_table.eq[i].eqn);
+		}
 
-	return IRQ_RETVAL(ecr);
+	return IRQ_HANDLED;
 }
 
 static irqreturn_t mthca_tavor_msi_x_interrupt(int irq, void *eq_ptr,
