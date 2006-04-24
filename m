Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750843AbWDXPCs@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750843AbWDXPCs (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 24 Apr 2006 11:02:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750833AbWDXPCs
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 24 Apr 2006 11:02:48 -0400
Received: from mtagate4.de.ibm.com ([195.212.29.153]:58399 "EHLO
	mtagate4.de.ibm.com") by vger.kernel.org with ESMTP
	id S1750850AbWDXPCr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 24 Apr 2006 11:02:47 -0400
Date: Mon, 24 Apr 2006 17:02:50 +0200
From: Martin Schwidefsky <schwidefsky@de.ibm.com>
To: linux-kernel@vger.kernel.org, akpm@osdl.org, shbader@de.ibm.com
Subject: [patch 2/13] s390: enable interrupts on error path.
Message-ID: <20060424150250.GC15613@skybase>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.11+cvs20060403
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Stefan Bader <shbader@de.ibm.com>

[patch 2/13] s390: enable interrupts on error path.

Interrupts can stay disabled if an error occurred in _chp_add().
Use spin_unlock_irq on the error paths to reenable interrupts.

Signed-off-by: Stefan Bader <shbader@de.ibm.com>
Signed-off-by: Martin Schwidefsky <schwidefsky@de.ibm.com>
---

 drivers/s390/cio/chsc.c |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

diff -urpN linux-2.6/drivers/s390/cio/chsc.c linux-2.6-patched/drivers/s390/cio/chsc.c
--- linux-2.6/drivers/s390/cio/chsc.c	2006-04-24 16:47:19.000000000 +0200
+++ linux-2.6-patched/drivers/s390/cio/chsc.c	2006-04-24 16:47:19.000000000 +0200
@@ -635,13 +635,13 @@ __chp_add(struct subchannel_id schid, vo
 		if (sch->schib.pmcw.chpid[i] == chp->id) {
 			if (stsch(sch->schid, &sch->schib) != 0) {
 				/* Endgame. */
-				spin_unlock(&sch->lock);
+				spin_unlock_irq(&sch->lock);
 				return -ENXIO;
 			}
 			break;
 		}
 	if (i==8) {
-		spin_unlock(&sch->lock);
+		spin_unlock_irq(&sch->lock);
 		return 0;
 	}
 	sch->lpm = ((sch->schib.pmcw.pim &
