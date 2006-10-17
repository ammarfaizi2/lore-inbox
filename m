Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1423043AbWJQLFk@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1423043AbWJQLFk (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 17 Oct 2006 07:05:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1422697AbWJQLFk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 17 Oct 2006 07:05:40 -0400
Received: from mtagate1.de.ibm.com ([195.212.29.150]:22954 "EHLO
	mtagate1.de.ibm.com") by vger.kernel.org with ESMTP
	id S1423043AbWJQLF3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 17 Oct 2006 07:05:29 -0400
Date: Tue, 17 Oct 2006 13:05:56 +0200
From: Cornelia Huck <cornelia.huck@de.ibm.com>
To: Greg K-H <greg@kroah.com>
Cc: Alan Stern <stern@rowland.harvard.edu>,
       Duncan Sands <duncan.sands@math.u-psud.fr>,
       linux-kernel <linux-kernel@vger.kernel.org>
Subject: [Patch 2/4] Driver core: Change function call order in
 device_bind_driver().
Message-ID: <20061017130556.60096290@gondolin.boeblingen.de.ibm.com>
X-Mailer: Sylpheed-Claws 2.5.5 (GTK+ 2.8.20; i486-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Cornelia Huck <cornelia.huck@de.ibm.com>

Change function call order in device_bind_driver().

If we create symlinks (which might fail) before adding the device to the list
we don't have to clean up afterwards (which we didn't).

Signed-off-by: Cornelia Huck <cornelia.huck@de.ibm.com>

---
 drivers/base/dd.c |    8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

--- linux-2.6.orig/drivers/base/dd.c
+++ linux-2.6/drivers/base/dd.c
@@ -80,8 +80,12 @@ static void driver_sysfs_remove(struct d
  */
 int device_bind_driver(struct device *dev)
 {
-	driver_bound(dev);
-	return driver_sysfs_add(dev);
+	int ret;
+
+	ret = driver_sysfs_add(dev);
+	if (!ret)
+		driver_bound(dev);
+	return ret;
 }
 
 struct stupid_thread_structure {
