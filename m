Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751141AbWHXL3l@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751141AbWHXL3l (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 24 Aug 2006 07:29:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751145AbWHXL3l
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 24 Aug 2006 07:29:41 -0400
Received: from mtagate2.de.ibm.com ([195.212.29.151]:46677 "EHLO
	mtagate2.de.ibm.com") by vger.kernel.org with ESMTP
	id S1751141AbWHXL3k (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 24 Aug 2006 07:29:40 -0400
Date: Thu, 24 Aug 2006 13:29:38 +0200
From: Martin Schwidefsky <schwidefsky@de.ibm.com>
To: linux-kernel@vger.kernel.org, peter.oberparleiter@de.ibm.com
Subject: [patch] s390: cio: no path after machine check.
Message-ID: <20060824112938.GE7022@skybase>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Peter Oberparleiter <peter.oberparleiter@de.ibm.com>

[S390] cio: no path after machine check.

Devices enter no-path state after disabling a channel path
via the SE even though another path has been reenabled at the SE.
The devices are set into no-path state before triggering path
verification even though other paths may have become available.
To fix this trigger path verification before setting a device into
no-path state.

Signed-off-by: Peter Oberparleiter <peter.oberparleiter@de.ibm.com>
Signed-off-by: Martin Schwidefsky <schwidefsky@de.ibm.com>
---

 drivers/s390/cio/chsc.c |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

diff -urpN linux-2.6/drivers/s390/cio/chsc.c linux-2.6-patched/drivers/s390/cio/chsc.c
--- linux-2.6/drivers/s390/cio/chsc.c	2006-08-24 12:10:55.000000000 +0200
+++ linux-2.6-patched/drivers/s390/cio/chsc.c	2006-08-24 12:10:55.000000000 +0200
@@ -238,8 +238,6 @@ s390_subchannel_remove_chpid(struct devi
 	/* Check for single path devices. */
 	if (sch->schib.pmcw.pim == 0x80)
 		goto out_unreg;
-	if (sch->vpm == mask)
-		goto out_unreg;
 
 	if ((sch->schib.scsw.actl & SCSW_ACTL_DEVACT) &&
 	    (sch->schib.scsw.actl & SCSW_ACTL_SCHACT) &&
@@ -258,6 +256,8 @@ s390_subchannel_remove_chpid(struct devi
 	/* trigger path verification. */
 	if (sch->driver && sch->driver->verify)
 		sch->driver->verify(&sch->dev);
+	else if (sch->vpm == mask)
+		goto out_unreg;
 out_unlock:
 	spin_unlock_irq(&sch->lock);
 	return 0;
