Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750894AbWH3Ml3@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750894AbWH3Ml3 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 30 Aug 2006 08:41:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750899AbWH3Ml2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 30 Aug 2006 08:41:28 -0400
Received: from mtagate4.de.ibm.com ([195.212.29.153]:62445 "EHLO
	mtagate4.de.ibm.com") by vger.kernel.org with ESMTP
	id S1750898AbWH3Ml1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 30 Aug 2006 08:41:27 -0400
Date: Wed, 30 Aug 2006 14:41:24 +0200
From: Martin Schwidefsky <schwidefsky@de.ibm.com>
To: linux-kernel@vger.kernel.org, peter.oberparleiter@de.ibm.com
Subject: [S390] cio: no path after machine check.
Message-ID: <20060830124124.GB22276@skybase>
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
--- linux-2.6/drivers/s390/cio/chsc.c	2006-08-30 14:24:34.000000000 +0200
+++ linux-2.6-patched/drivers/s390/cio/chsc.c	2006-08-30 14:24:34.000000000 +0200
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
