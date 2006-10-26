Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1752122AbWJZJCG@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752122AbWJZJCG (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 26 Oct 2006 05:02:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752123AbWJZJCG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 26 Oct 2006 05:02:06 -0400
Received: from mtagate6.de.ibm.com ([195.212.29.155]:1181 "EHLO
	mtagate6.de.ibm.com") by vger.kernel.org with ESMTP
	id S1752122AbWJZJCE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 26 Oct 2006 05:02:04 -0400
Date: Thu, 26 Oct 2006 11:02:01 +0200
From: Martin Schwidefsky <schwidefsky@de.ibm.com>
To: linux-kernel@vger.kernel.org, cornelia.huck@de.ibm.com
Subject: [S390] cio: css_probe_device() must be called enabled.
Message-ID: <20061026090201.GB16270@skybase>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Cornelia Huck <cornelia.huck@de.ibm.com>

[S390] cio: css_probe_device() must be called enabled.

Move css_probe_device() behind giving up the lock for the old subchannel
in css_evaluate_known_subchannel() so we aren't disabled when we call it.

Signed-off-by: Cornelia Huck <cornelia.huck@de.ibm.com>
Signed-off-by: Martin Schwidefsky <schwidefsky@de.ibm.com>
---

 drivers/s390/cio/css.c |    7 +++----
 1 files changed, 3 insertions(+), 4 deletions(-)

diff -urpN linux-2.6/drivers/s390/cio/css.c linux-2.6-patched/drivers/s390/cio/css.c
--- linux-2.6/drivers/s390/cio/css.c	2006-10-26 10:43:46.000000000 +0200
+++ linux-2.6-patched/drivers/s390/cio/css.c	2006-10-26 10:44:03.000000000 +0200
@@ -271,10 +271,6 @@ static int css_evaluate_known_subchannel
 		/* Reset intparm to zeroes. */
 		sch->schib.pmcw.intparm = 0;
 		cio_modify(sch);
-
-		/* Probe if necessary. */
-		if (action == UNREGISTER_PROBE)
-			ret = css_probe_device(sch->schid);
 		break;
 	case REPROBE:
 		device_trigger_reprobe(sch);
@@ -283,6 +279,9 @@ static int css_evaluate_known_subchannel
 		break;
 	}
 	spin_unlock_irqrestore(&sch->lock, flags);
+	/* Probe if necessary. */
+	if (action == UNREGISTER_PROBE)
+		ret = css_probe_device(sch->schid);
 
 	return ret;
 }
