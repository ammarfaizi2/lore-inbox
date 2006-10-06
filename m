Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161049AbWJFOyz@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161049AbWJFOyz (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 6 Oct 2006 10:54:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161058AbWJFOyz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 6 Oct 2006 10:54:55 -0400
Received: from mtagate5.de.ibm.com ([195.212.29.154]:50345 "EHLO
	mtagate5.de.ibm.com") by vger.kernel.org with ESMTP
	id S1161053AbWJFOyy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 6 Oct 2006 10:54:54 -0400
Date: Fri, 6 Oct 2006 16:54:55 +0200
From: Martin Schwidefsky <schwidefsky@de.ibm.com>
To: linux-kernel@vger.kernel.org, cornelia.huck@de.ibm.com
Subject: [S390] cio: 0 is a valid chpid.
Message-ID: <20061006145455.GC26371@skybase>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Cornelia Huck <cornelia.huck@de.ibm.com>

[S390] cio: 0 is a valid chpid.

In order to determine chpid validity, we need to check whether the
corresponding path is specified in the pim.

Signed-off-by: Cornelia Huck <cornelia.huck@de.ibm.com>
Signed-off-by: Martin Schwidefsky <schwidefsky@de.ibm.com>
---

 drivers/s390/cio/chsc.c |   25 ++++++++++++++++---------
 1 files changed, 16 insertions(+), 9 deletions(-)

diff -urpN linux-2.6/drivers/s390/cio/chsc.c linux-2.6-patched/drivers/s390/cio/chsc.c
--- linux-2.6/drivers/s390/cio/chsc.c	2006-10-06 16:29:35.000000000 +0200
+++ linux-2.6-patched/drivers/s390/cio/chsc.c	2006-10-06 16:29:57.000000000 +0200
@@ -200,11 +200,13 @@ css_get_ssd_info(struct subchannel *sch)
 	spin_unlock_irq(&sch->lock);
 	free_page((unsigned long)page);
 	if (!ret) {
-		int j, chpid;
+		int j, chpid, mask;
 		/* Allocate channel path structures, if needed. */
 		for (j = 0; j < 8; j++) {
+			mask = 0x80 >> j;
 			chpid = sch->ssd_info.chpid[j];
-			if (chpid && (get_chp_status(chpid) < 0))
+			if ((sch->schib.pmcw.pim & mask) &&
+			    (get_chp_status(chpid) < 0))
 			    new_channel_path(chpid);
 		}
 	}
@@ -222,13 +224,15 @@ s390_subchannel_remove_chpid(struct devi
 
 	sch = to_subchannel(dev);
 	chpid = data;
-	for (j = 0; j < 8; j++)
-		if (sch->schib.pmcw.chpid[j] == chpid->id)
+	for (j = 0; j < 8; j++) {
+		mask = 0x80 >> j;
+		if ((sch->schib.pmcw.pim & mask) &&
+		    (sch->schib.pmcw.chpid[j] == chpid->id))
 			break;
+	}
 	if (j >= 8)
 		return 0;
 
-	mask = 0x80 >> j;
 	spin_lock_irq(&sch->lock);
 
 	stsch(sch->schid, &schib);
@@ -620,7 +624,7 @@ __chp_add_new_sch(struct subchannel_id s
 static int
 __chp_add(struct subchannel_id schid, void *data)
 {
-	int i;
+	int i, mask;
 	struct channel_path *chp;
 	struct subchannel *sch;
 
@@ -630,8 +634,10 @@ __chp_add(struct subchannel_id schid, vo
 		/* Check if the subchannel is now available. */
 		return __chp_add_new_sch(schid);
 	spin_lock_irq(&sch->lock);
-	for (i=0; i<8; i++)
-		if (sch->schib.pmcw.chpid[i] == chp->id) {
+	for (i=0; i<8; i++) {
+		mask = 0x80 >> i;
+		if ((sch->schib.pmcw.pim & mask) &&
+		    (sch->schib.pmcw.chpid[i] == chp->id)) {
 			if (stsch(sch->schid, &sch->schib) != 0) {
 				/* Endgame. */
 				spin_unlock_irq(&sch->lock);
@@ -639,6 +645,7 @@ __chp_add(struct subchannel_id schid, vo
 			}
 			break;
 		}
+	}
 	if (i==8) {
 		spin_unlock_irq(&sch->lock);
 		return 0;
@@ -646,7 +653,7 @@ __chp_add(struct subchannel_id schid, vo
 	sch->lpm = ((sch->schib.pmcw.pim &
 		     sch->schib.pmcw.pam &
 		     sch->schib.pmcw.pom)
-		    | 0x80 >> i) & sch->opm;
+		    | mask) & sch->opm;
 
 	if (sch->driver && sch->driver->verify)
 		sch->driver->verify(&sch->dev);
