Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1946435AbWJ0LiE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1946435AbWJ0LiE (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 27 Oct 2006 07:38:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1946429AbWJ0Lgk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 27 Oct 2006 07:36:40 -0400
Received: from mtagate3.de.ibm.com ([195.212.29.152]:34862 "EHLO
	mtagate3.de.ibm.com") by vger.kernel.org with ESMTP
	id S1946427AbWJ0LgR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 27 Oct 2006 07:36:17 -0400
Date: Fri, 27 Oct 2006 13:36:53 +0200
From: Cornelia Huck <cornelia.huck@de.ibm.com>
To: Greg K-H <greg@kroah.com>
Cc: linux-kernel <linux-kernel@vger.kernel.org>, Andrew Morton <akpm@osdl.org>
Subject: [Patch 4/7] driver core: Don't stop probing on ->probe errors.
Message-ID: <20061027133653.13db9e8f@gondolin.boeblingen.de.ibm.com>
X-Mailer: Sylpheed-Claws 2.5.6 (GTK+ 2.8.20; i486-pc-linux-gnu)
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
 1 file changed, 6 insertions(+), 7 deletions(-)

--- linux-2.6.orig/drivers/base/dd.c
+++ linux-2.6/drivers/base/dd.c
@@ -133,18 +133,17 @@ probe_failed:
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
