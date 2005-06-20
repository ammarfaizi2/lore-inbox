Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261738AbVFTXZl@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261738AbVFTXZl (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 20 Jun 2005 19:25:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261810AbVFTXYV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 20 Jun 2005 19:24:21 -0400
Received: from mail.kroah.org ([69.55.234.183]:229 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S261802AbVFTXAR convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 20 Jun 2005 19:00:17 -0400
Cc: gregkh@suse.de
Subject: [PATCH] Driver core: Fix up the driver and device iterators to be quieter
In-Reply-To: <11193083672883@kroah.com>
X-Mailer: gregkh_patchbomb
Date: Mon, 20 Jun 2005 15:59:27 -0700
Message-Id: <11193083671399@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Reply-To: Greg K-H <greg@kroah.com>
To: linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 7BIT
From: Greg KH <gregkh@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

[PATCH] Driver core: Fix up the driver and device iterators to be quieter

Also stops looping over the lists when a match is found.

Signed-off-by: Greg Kroah-Hartman <gregkh@suse.de

---
commit b86c1df1f98d16c999423a3907eb40a9423f481e
tree 02cf0b54f3c1d9b987268f2d4737af1a67dd4056
parent d0e2b4a0a9dd3eed71b56c47268bf4e40cff6d0f
author gregkh@suse.de <gregkh@suse.de> Thu, 31 Mar 2005 12:53:00 -0800
committer Greg Kroah-Hartman <gregkh@suse.de> Mon, 20 Jun 2005 15:15:27 -0700

 drivers/base/dd.c |   32 +++++++++++++++++++-------------
 1 files changed, 19 insertions(+), 13 deletions(-)

diff --git a/drivers/base/dd.c b/drivers/base/dd.c
--- a/drivers/base/dd.c
+++ b/drivers/base/dd.c
@@ -88,20 +88,23 @@ static int __device_attach(struct device
 	int error;
 
 	error = driver_probe_device(drv, dev);
-
-	if (error == -ENODEV && error == -ENXIO) {
-		/* Driver matched, but didn't support device
-		 * or device not found.
-		 * Not an error; keep going.
-		 */
-		error = 0;
-	} else {
-		/* driver matched but the probe failed */
-		printk(KERN_WARNING
-		       "%s: probe of %s failed with error %d\n",
-		       drv->name, dev->bus_id, error);
+	if (error) {
+		if ((error == -ENODEV) || (error == -ENXIO)) {
+			/* Driver matched, but didn't support device
+			 * or device not found.
+			 * Not an error; keep going.
+			 */
+			error = 0;
+		} else {
+			/* driver matched but the probe failed */
+			printk(KERN_WARNING
+			       "%s: probe of %s failed with error %d\n",
+			       drv->name, dev->bus_id, error);
+		}
+		return error;
 	}
-	return 0;
+	/* stop looking, this device is attached */
+	return 1;
 }
 
 /**
@@ -137,7 +140,10 @@ static int __driver_attach(struct device
 				       drv->name, dev->bus_id, error);
 			} else
 				error = 0;
+			return error;
 		}
+		/* stop looking, this driver is attached */
+		return 1;
 	}
 	return 0;
 }

