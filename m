Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1757574AbWK0Jex@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757574AbWK0Jex (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 27 Nov 2006 04:34:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757596AbWK0Jex
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 27 Nov 2006 04:34:53 -0500
Received: from mtagate1.de.ibm.com ([195.212.29.150]:29201 "EHLO
	mtagate1.de.ibm.com") by vger.kernel.org with ESMTP
	id S1757574AbWK0Jef (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 27 Nov 2006 04:34:35 -0500
Date: Mon, 27 Nov 2006 10:35:12 +0100
From: Cornelia Huck <cornelia.huck@de.ibm.com>
To: Greg K-H <greg@kroah.com>
Cc: Andrew Morton <akpm@osdl.org>, linux-kernel <linux-kernel@vger.kernel.org>
Subject: [Patch 5/7] driver core: Change function call order in
 device_bind_driver().
Message-ID: <20061127103512.5d0aebb2@gondolin.boeblingen.de.ibm.com>
X-Mailer: Sylpheed-Claws 2.6.0 (GTK+ 2.8.20; i486-pc-linux-gnu)
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

--- linux-2.6-CH.orig/drivers/base/dd.c
+++ linux-2.6-CH/drivers/base/dd.c
@@ -86,8 +86,12 @@ static void driver_sysfs_remove(struct d
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
