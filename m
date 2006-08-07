Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750984AbWHGPGV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750984AbWHGPGV (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 7 Aug 2006 11:06:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932123AbWHGPGV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 7 Aug 2006 11:06:21 -0400
Received: from mtagate5.de.ibm.com ([195.212.29.154]:20684 "EHLO
	mtagate5.de.ibm.com") by vger.kernel.org with ESMTP
	id S1750913AbWHGPGU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 7 Aug 2006 11:06:20 -0400
Date: Mon, 7 Aug 2006 17:06:19 +0200
From: Martin Schwidefsky <schwidefsky@de.ibm.com>
To: linux-kernel@vger.kernel.org, peter.oberparleiter@de.ibm.com
Subject: [patch] s390: lost interrupt after chpid vary off/on cycle.
Message-ID: <20060807150619.GC10416@skybase>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.12-2006-07-14
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Peter Oberparleiter <peter.oberparleiter@de.ibm.com>

[S390] lost interrupt after chpid vary off/on cycle.

I/O on a CCW device may stall if a channel path to that device is
logicaly varied off/on. A user I/O interrupt can get misinterpreted
as interrupt for an internal path verification operation due to a
missing check and is therefore never reported to the device driver.

Correct check for pending interruptions before starting path
verification.

Signed-off-by: Peter Oberparleiter <peter.oberparleiter@de.ibm.com>
Signed-off-by: Martin Schwidefsky <schwidefsky@de.ibm.com>
---

 drivers/s390/cio/device_fsm.c |    1 +
 1 files changed, 1 insertion(+)

diff -urpN linux-2.6/drivers/s390/cio/device_fsm.c linux-2.6-patched/drivers/s390/cio/device_fsm.c
--- linux-2.6/drivers/s390/cio/device_fsm.c	2006-08-07 14:14:29.000000000 +0200
+++ linux-2.6-patched/drivers/s390/cio/device_fsm.c	2006-08-07 14:14:44.000000000 +0200
@@ -772,6 +772,7 @@ ccw_device_online_verify(struct ccw_devi
 	stsch(sch->schid, &sch->schib);
 
 	if (sch->schib.scsw.actl != 0 ||
+	    (sch->schib.scsw.stctl & SCSW_STCTL_STATUS_PEND) ||
 	    (cdev->private->irb.scsw.stctl & SCSW_STCTL_STATUS_PEND)) {
 		/*
 		 * No final status yet or final status not yet delivered
