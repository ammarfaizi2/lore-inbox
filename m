Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750849AbWDSJsZ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750849AbWDSJsZ (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 19 Apr 2006 05:48:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750852AbWDSJsZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 19 Apr 2006 05:48:25 -0400
Received: from mx2.mail.elte.hu ([157.181.151.9]:47243 "EHLO mx2.mail.elte.hu")
	by vger.kernel.org with ESMTP id S1750848AbWDSJsY (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 19 Apr 2006 05:48:24 -0400
Date: Wed, 19 Apr 2006 10:44:35 +0200
From: Ingo Molnar <mingo@elte.hu>
To: Linus Torvalds <torvalds@osdl.org>
Cc: linux-kernel@vger.kernel.org, Arjan van de Ven <arjan@infradead.org>
Subject: [patch] md: locking fix
Message-ID: <20060419084435.GA490@elte.hu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4.2.1i
X-ELTE-SpamScore: -2.8
X-ELTE-SpamLevel: 
X-ELTE-SpamCheck: no
X-ELTE-SpamVersion: ELTE 2.0 
X-ELTE-SpamCheck-Details: score=-2.8 required=5.9 tests=ALL_TRUSTED,AWL autolearn=no SpamAssassin version=3.0.3
	-2.8 ALL_TRUSTED            Did not pass through any untrusted hosts
	0.0 AWL                    AWL: From: address is in the auto white-list
X-ELTE-VirusStatus: clean
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

- fix mddev_lock() usage bugs in md_attr_show() and md_attr_store(). 
  [they did not anticipate the possibility of getting a signal]

- remove mddev_lock_uninterruptible() [unused]

Signed-off-by: Ingo Molnar <mingo@elte.hu>

----

 drivers/md/md.c |   24 ++++++++++++------------
 1 files changed, 12 insertions(+), 12 deletions(-)

Index: linux/drivers/md/md.c
===================================================================
--- linux.orig/drivers/md/md.c
+++ linux/drivers/md/md.c
@@ -279,11 +279,6 @@ static inline int mddev_lock(mddev_t * m
 	return mutex_lock_interruptible(&mddev->reconfig_mutex);
 }
 
-static inline void mddev_lock_uninterruptible(mddev_t * mddev)
-{
-	mutex_lock(&mddev->reconfig_mutex);
-}
-
 static inline int mddev_trylock(mddev_t * mddev)
 {
 	return mutex_trylock(&mddev->reconfig_mutex);
@@ -2458,9 +2453,11 @@ md_attr_show(struct kobject *kobj, struc
 
 	if (!entry->show)
 		return -EIO;
-	mddev_lock(mddev);
-	rv = entry->show(mddev, page);
-	mddev_unlock(mddev);
+	rv = mddev_lock(mddev);
+	if (!rv) {
+		rv = entry->show(mddev, page);
+		mddev_unlock(mddev);
+	}
 	return rv;
 }
 
@@ -2474,9 +2471,11 @@ md_attr_store(struct kobject *kobj, stru
 
 	if (!entry->store)
 		return -EIO;
-	mddev_lock(mddev);
-	rv = entry->store(mddev, page, length);
-	mddev_unlock(mddev);
+	rv = mddev_lock(mddev);
+	if (!rv) {
+		rv = entry->store(mddev, page, length);
+		mddev_unlock(mddev);
+	}
 	return rv;
 }
 
@@ -4341,8 +4340,9 @@ static int md_seq_show(struct seq_file *
 		return 0;
 	}
 
-	if (mddev_lock(mddev)!=0) 
+	if (mddev_lock(mddev))
 		return -EINTR;
+
 	if (mddev->pers || mddev->raid_disks || !list_empty(&mddev->disks)) {
 		seq_printf(seq, "%s : %sactive", mdname(mddev),
 						mddev->pers ? "" : "in");
