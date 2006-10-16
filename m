Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161223AbWJPIoB@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161223AbWJPIoB (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 16 Oct 2006 04:44:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161219AbWJPIn7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 16 Oct 2006 04:43:59 -0400
Received: from mtagate6.de.ibm.com ([195.212.29.155]:29689 "EHLO
	mtagate6.de.ibm.com") by vger.kernel.org with ESMTP id S964847AbWJPInf
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 16 Oct 2006 04:43:35 -0400
Date: Mon, 16 Oct 2006 10:44:10 +0200
From: Cornelia Huck <cornelia.huck@de.ibm.com>
To: Greg K-H <greg@kroah.com>
Cc: Alan Stern <stern@rowland.harvard.edu>,
       linux-kernel <linux-kernel@vger.kernel.org>
Subject: [Patch 2/3] Driver core: Change function call order in
 device_bind_driver().
Message-ID: <20061016104410.587cbc97@gondolin.boeblingen.de.ibm.com>
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
 1 files changed, 6 insertions(+), 2 deletions(-)

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
