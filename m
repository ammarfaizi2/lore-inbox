Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751228AbWBJK1u@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751228AbWBJK1u (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 10 Feb 2006 05:27:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751226AbWBJK1s
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 10 Feb 2006 05:27:48 -0500
Received: from mtagate4.de.ibm.com ([195.212.29.153]:40526 "EHLO
	mtagate4.de.ibm.com") by vger.kernel.org with ESMTP
	id S1751229AbWBJK13 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 10 Feb 2006 05:27:29 -0500
Date: Fri, 10 Feb 2006 11:27:20 +0100
From: Heiko Carstens <heiko.carstens@de.ibm.com>
To: Andrew Morton <akpm@osdl.org>
Cc: Cornelia Huck <cornelia.huck@de.ibm.com>, linux-kernel@vger.kernel.org
Subject: [patch 2/2] s390: fix locking in __chp_add() and s390_subchannel_remove_chpid()
Message-ID: <20060210102720.GC9307@osiris.boeblingen.de.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: mutt-ng/devel (Linux)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Cornelia Huck <cornelia.huck@de.ibm.com>

Fix locking in __chp_add() and s390_subchannel_remove_chpid():
Need to disable/enable because they are always called from a thread (and not
directly from a machine check...)

Signed-off-by: Cornelia Huck <cornelia.huck@de.ibm.com>
Signed-off-by: Heiko Carstens <heiko.carstens@de.ibm.com>
---

 drivers/s390/cio/chsc.c |   10 +++++-----
 1 files changed, 5 insertions(+), 5 deletions(-)

diff -urpN linux-2.6/drivers/s390/cio/chsc.c linux-2.6-patched/drivers/s390/cio/chsc.c
--- linux-2.6/drivers/s390/cio/chsc.c	2006-02-10 08:22:28.000000000 +0100
+++ linux-2.6-patched/drivers/s390/cio/chsc.c	2006-02-10 08:23:00.000000000 +0100
@@ -232,7 +232,7 @@ s390_subchannel_remove_chpid(struct devi
 		return 0;
 
 	mask = 0x80 >> j;
-	spin_lock(&sch->lock);
+	spin_lock_irq(&sch->lock);
 
 	stsch(sch->schid, &schib);
 	if (!schib.pmcw.dnv)
@@ -281,10 +281,10 @@ s390_subchannel_remove_chpid(struct devi
 	if (sch->driver && sch->driver->verify)
 		sch->driver->verify(&sch->dev);
 out_unlock:
-	spin_unlock(&sch->lock);
+	spin_unlock_irq(&sch->lock);
 	return 0;
 out_unreg:
-	spin_unlock(&sch->lock);
+	spin_unlock_irq(&sch->lock);
 	sch->lpm = 0;
 	if (css_enqueue_subchannel_slow(sch->schid)) {
 		css_clear_subchannel_slow_list();
@@ -652,7 +652,7 @@ __chp_add(struct subchannel_id schid, vo
 	if (!sch)
 		/* Check if the subchannel is now available. */
 		return __chp_add_new_sch(schid);
-	spin_lock(&sch->lock);
+	spin_lock_irq(&sch->lock);
 	for (i=0; i<8; i++)
 		if (sch->schib.pmcw.chpid[i] == chp->id) {
 			if (stsch(sch->schid, &sch->schib) != 0) {
@@ -674,7 +674,7 @@ __chp_add(struct subchannel_id schid, vo
 	if (sch->driver && sch->driver->verify)
 		sch->driver->verify(&sch->dev);
 
-	spin_unlock(&sch->lock);
+	spin_unlock_irq(&sch->lock);
 	put_device(&sch->dev);
 	return 0;
 }
