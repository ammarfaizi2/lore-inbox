Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1755649AbWKVQtJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755649AbWKVQtJ (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 22 Nov 2006 11:49:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755714AbWKVQtI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 22 Nov 2006 11:49:08 -0500
Received: from mtagate1.de.ibm.com ([195.212.29.150]:46402 "EHLO
	mtagate1.de.ibm.com") by vger.kernel.org with ESMTP
	id S1755649AbWKVQtG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 22 Nov 2006 11:49:06 -0500
Date: Wed, 22 Nov 2006 17:49:39 +0100
From: Cornelia Huck <cornelia.huck@de.ibm.com>
To: Kernel development list <linux-kernel@vger.kernel.org>
Cc: Greg K-H <greg@kroah.com>, Alan Stern <stern@rowland.harvard.edu>,
       Andrew Morton <akpm@osdl.org>
Subject: [Patch -mm] driver core: Use klist_remove() in device_move().
Message-ID: <20061122174939.64a10e31@gondolin.boeblingen.de.ibm.com>
In-Reply-To: <20061122174530.4efa1145@gondolin.boeblingen.de.ibm.com>
References: <Pine.LNX.4.44L0.0611221024340.3038-100000@iolanthe.rowland.org>
	<20061122174530.4efa1145@gondolin.boeblingen.de.ibm.com>
X-Mailer: Sylpheed-Claws 2.6.0 (GTK+ 2.8.20; i486-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Cornelia Huck <cornelia.huck@de.ibm.com>

As pointed out by Alan Stern, device_move needs to use klist_remove which waits
until removal is complete.

Signed-off-by: Cornelia Huck <cornelia.huck@de.ibm.com>

---
 drivers/base/core.c |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

--- linux-2.6-CH.orig/drivers/base/core.c
+++ linux-2.6-CH/drivers/base/core.c
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
