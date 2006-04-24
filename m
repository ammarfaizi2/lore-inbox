Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750849AbWDXPC2@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750849AbWDXPC2 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 24 Apr 2006 11:02:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750840AbWDXPC2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 24 Apr 2006 11:02:28 -0400
Received: from mtagate3.de.ibm.com ([195.212.29.152]:56398 "EHLO
	mtagate3.de.ibm.com") by vger.kernel.org with ESMTP
	id S1750833AbWDXPC1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 24 Apr 2006 11:02:27 -0400
Date: Mon, 24 Apr 2006 17:02:30 +0200
From: Martin Schwidefsky <schwidefsky@de.ibm.com>
To: linux-kernel@vger.kernel.org, akpm@osdl.org,
       peter.oberparleiter@de.ibm.com
Subject: [patch 1/13] s390: fix I/O termination race in cio.
Message-ID: <20060424150230.GB15613@skybase>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.11+cvs20060403
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Peter Oberparleiter <peter.oberparleiter@de.ibm.com>

[patch 1/13] s390: fix I/O termination race in cio.

Fix a race condition in the I/O termination logic. The race can
cause I/O to a dasd device to fail with no retry left after turning
one channel path to the device off and on multiple times. 

Signed-off-by: Peter Oberparleiter <peter.oberparleiter@de.ibm.com>
Signed-off-by: Martin Schwidefsky <schwidefsky@de.ibm.com>
---

 drivers/s390/cio/chsc.c |   26 ++++----------------------
 1 files changed, 4 insertions(+), 22 deletions(-)

diff -urpN linux-2.6/drivers/s390/cio/chsc.c linux-2.6-patched/drivers/s390/cio/chsc.c
--- linux-2.6/drivers/s390/cio/chsc.c	2006-04-24 16:47:00.000000000 +0200
+++ linux-2.6-patched/drivers/s390/cio/chsc.c	2006-04-24 16:47:18.000000000 +0200
@@ -242,28 +242,10 @@ s390_subchannel_remove_chpid(struct devi
 	if (sch->vpm == mask)
 		goto out_unreg;
 
-	if ((sch->schib.scsw.actl & (SCSW_ACTL_CLEAR_PEND |
-				     SCSW_ACTL_HALT_PEND |
-				     SCSW_ACTL_START_PEND |
-				     SCSW_ACTL_RESUME_PEND)) &&
-	    (sch->schib.pmcw.lpum == mask)) {
-		int cc = cio_cancel(sch);
-		
-		if (cc == -ENODEV)
-			goto out_unreg;
-
-		if (cc == -EINVAL) {
-			cc = cio_clear(sch);
-			if (cc == -ENODEV)
-				goto out_unreg;
-			/* Call handler. */
-			if (sch->driver && sch->driver->termination)
-				sch->driver->termination(&sch->dev);
-			goto out_unlock;
-		}
-	} else if ((sch->schib.scsw.actl & SCSW_ACTL_DEVACT) &&
-		   (sch->schib.scsw.actl & SCSW_ACTL_SCHACT) &&
-		   (sch->schib.pmcw.lpum == mask)) {
+	if ((sch->schib.scsw.actl & SCSW_ACTL_DEVACT) &&
+	    (sch->schib.scsw.actl & SCSW_ACTL_SCHACT) &&
+	    (sch->schib.pmcw.lpum == mask) &&
+	    (sch->vpm == 0)) {
 		int cc;
 
 		cc = cio_clear(sch);
