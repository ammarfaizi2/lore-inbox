Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1757618AbWK0Jfh@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757618AbWK0Jfh (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 27 Nov 2006 04:35:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757577AbWK0JfB
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 27 Nov 2006 04:35:01 -0500
Received: from mtagate5.de.ibm.com ([195.212.29.154]:47313 "EHLO
	mtagate5.de.ibm.com") by vger.kernel.org with ESMTP
	id S1757569AbWK0Jed (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 27 Nov 2006 04:34:33 -0500
Date: Mon, 27 Nov 2006 10:35:10 +0100
From: Cornelia Huck <cornelia.huck@de.ibm.com>
To: Greg K-H <greg@kroah.com>
Cc: Andrew Morton <akpm@osdl.org>, linux-kernel <linux-kernel@vger.kernel.org>
Subject: [Patch 4/7] driver core: Don't stop probing on ->probe errors.
Message-ID: <20061127103510.0fc9d002@gondolin.boeblingen.de.ibm.com>
X-Mailer: Sylpheed-Claws 2.6.0 (GTK+ 2.8.20; i486-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Cornelia Huck <cornelia.huck@de.ibm.com>

Don't stop on the first ->probe error that is not -ENODEV/-ENXIO.

There might be a driver registered returning an unresonable return code, and
this stops probing completely even though it may make sense to try the next
possible driver. At worst, we may end up with an unbound device.

Signed-off-by: Cornelia Huck <cornelia.huck@de.ibm.com>

---
 drivers/base/dd.c |   13 ++++++-------
 1 files changed, 6 insertions(+), 7 deletions(-)

--- linux-2.6-CH.orig/drivers/base/dd.c
+++ linux-2.6-CH/drivers/base/dd.c
@@ -136,18 +136,17 @@ probe_failed:
 	driver_sysfs_remove(dev);
 	dev->driver = NULL;
 
-	if (ret == -ENODEV || ret == -ENXIO) {
-		/* Driver matched, but didn't support device
-		 * or device not found.
-		 * Not an error; keep going.
-		 */
-		ret = 0;
-	} else {
+	if (ret != -ENODEV && ret != -ENXIO) {
 		/* driver matched but the probe failed */
 		printk(KERN_WARNING
 		       "%s: probe of %s failed with error %d\n",
 		       drv->name, dev->bus_id, ret);
 	}
+	/*
+	 * Ignore errors returned by ->probe so that the next driver can try
+	 * its luck.
+	 */
+	ret = 0;
 done:
 	kfree(data);
 	atomic_dec(&probe_count);
