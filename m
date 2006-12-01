Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1162325AbWLAXY5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1162325AbWLAXY5 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 1 Dec 2006 18:24:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1162257AbWLAXYO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 1 Dec 2006 18:24:14 -0500
Received: from ns2.suse.de ([195.135.220.15]:59629 "EHLO mx2.suse.de")
	by vger.kernel.org with ESMTP id S1162264AbWLAXYH (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 1 Dec 2006 18:24:07 -0500
From: Greg KH <greg@kroah.com>
To: linux-kernel@vger.kernel.org
Cc: Cornelia Huck <cornelia.huck@de.ibm.com>,
       Greg Kroah-Hartman <gregkh@suse.de>
Subject: [PATCH 33/36] driver core: Use klist_remove() in device_move()
Date: Fri,  1 Dec 2006 15:22:03 -0800
Message-Id: <11650154353407-git-send-email-greg@kroah.com>
X-Mailer: git-send-email 1.4.4.1
In-Reply-To: <11650154311175-git-send-email-greg@kroah.com>
References: <20061201231620.GA7560@kroah.com> <11650153262399-git-send-email-greg@kroah.com> <11650153293531-git-send-email-greg@kroah.com> <1165015333344-git-send-email-greg@kroah.com> <11650153362310-git-send-email-greg@kroah.com> <11650153392022-git-send-email-greg@kroah.com> <11650153432284-git-send-email-greg@kroah.com> <11650153463092-git-send-email-greg@kroah.com> <1165015349830-git-send-email-greg@kroah.com> <11650153522862-git-send-email-greg@kroah.com> <116501535622-git-send-email-greg@kroah.com> <11650153591876-git-send-email-greg@kroah.com> <11650153631070-git-send-email-greg@kroah.com> <1165015366759-git-send-email-greg@kroah.com> <11650153704007-git-send-email-greg@kroah.com> <11650153733277-git-send-email-greg@kroah.com> <11650153763330-git-send-email-greg@kroah.com> <11650153792132-git-send-email-greg@kroah.com> <11650153833896-git-send-email-greg@kroah.com> <11650153861854-git-send-email-greg@kroah.com> <11650153891878-git-send-email-greg@kroah.com> <11650153
 922117-git-send-email-greg@kroah.com> <11650153961479-git-send-email-greg@kroah.com> <11650154001320-git-send-email-greg@kroah.com> <11650154032080-git-send-email-greg@kroah.com> <11650154071138-git-send-email-greg@kroah.com> <11650154123942-git-send-email-greg@kroah.com> <1165015415131-git-send-email-greg@kroah.com> <11650154181661-git-send-email-greg@kroah.com> <11650154221716-git-send-email-greg@kroah.com> <11650154251022-git-send-email-greg@kroah.com> <11650154282911-git-send-email-greg@kroah.com> <11650154311175-git-send-email-greg@kroah.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Cornelia Huck <cornelia.huck@de.ibm.com>

As pointed out by Alan Stern, device_move needs to use klist_remove which waits
until removal is complete.

Signed-off-by: Cornelia Huck <cornelia.huck@de.ibm.com>
Cc: Alan Stern <stern@rowland.harvard.edu>
Signed-off-by: Greg Kroah-Hartman <gregkh@suse.de>
---
 drivers/base/core.c |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/base/core.c b/drivers/base/core.c
index e4eaf46..e4b530e 100644
--- a/drivers/base/core.c
+++ b/drivers/base/core.c
@@ -1022,7 +1022,7 @@ int device_move(struct device *dev, stru
 	old_parent = dev->parent;
 	dev->parent = new_parent;
 	if (old_parent)
-		klist_del(&dev->knode_parent);
+		klist_remove(&dev->knode_parent);
 	klist_add_tail(&dev->knode_parent, &new_parent->klist_children);
 	if (!dev->class)
 		goto out_put;
@@ -1031,7 +1031,7 @@ int device_move(struct device *dev, stru
 		/* We ignore errors on cleanup since we're hosed anyway... */
 		device_move_class_links(dev, new_parent, old_parent);
 		if (!kobject_move(&dev->kobj, &old_parent->kobj)) {
-			klist_del(&dev->knode_parent);
+			klist_remove(&dev->knode_parent);
 			if (old_parent)
 				klist_add_tail(&dev->knode_parent,
 					       &old_parent->klist_children);
-- 
1.4.4.1

