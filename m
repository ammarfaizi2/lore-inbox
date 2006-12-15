Return-Path: <linux-kernel-owner+w=401wt.eu-S1752828AbWLOQXe@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752828AbWLOQXe (ORCPT <rfc822;w@1wt.eu>);
	Fri, 15 Dec 2006 11:23:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752842AbWLOQXN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 15 Dec 2006 11:23:13 -0500
Received: from mtagate6.de.ibm.com ([195.212.29.155]:50842 "EHLO
	mtagate6.de.ibm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752831AbWLOQXK (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 15 Dec 2006 11:23:10 -0500
Date: Fri, 15 Dec 2006 17:23:01 +0100
From: Martin Schwidefsky <schwidefsky@de.ibm.com>
To: linux-kernel@vger.kernel.org, shbader@de.ibm.com
Subject: [S390] cio: css_register_subchannel race.
Message-ID: <20061215162301.GI4920@skybase>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Stefan Bader <shbader@de.ibm.com>

[S390] cio: css_register_subchannel race.

Asynchronous probe can release memory of a subchannel before
css_get_ssd_info is called. To fix this call css_get_ssd_info
before registering with driver core.

Signed-off-by: Stefan Bader <shbader@de.ibm.com>
Signed-off-by: Martin Schwidefsky <schwidefsky@de.ibm.com>
---

 drivers/s390/cio/css.c |    3 ++-
 1 files changed, 2 insertions(+), 1 deletion(-)

diff -urpN linux-2.6/drivers/s390/cio/css.c linux-2.6-patched/drivers/s390/cio/css.c
--- linux-2.6/drivers/s390/cio/css.c	2006-12-15 16:54:55.000000000 +0100
+++ linux-2.6-patched/drivers/s390/cio/css.c	2006-12-15 16:55:14.000000000 +0100
@@ -139,6 +139,8 @@ css_register_subchannel(struct subchanne
 	sch->dev.release = &css_subchannel_release;
 	sch->dev.groups = subch_attr_groups;
 
+	css_get_ssd_info(sch);
+
 	/* make it known to the system */
 	ret = css_sch_device_register(sch);
 	if (ret) {
@@ -146,7 +148,6 @@ css_register_subchannel(struct subchanne
 			__func__, sch->dev.bus_id);
 		return ret;
 	}
-	css_get_ssd_info(sch);
 	return ret;
 }
 
