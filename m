Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932586AbWGTO7O@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932586AbWGTO7O (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 20 Jul 2006 10:59:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932588AbWGTO7O
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 20 Jul 2006 10:59:14 -0400
Received: from mtagate3.de.ibm.com ([195.212.29.152]:6945 "EHLO
	mtagate3.de.ibm.com") by vger.kernel.org with ESMTP id S932586AbWGTO7O
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 20 Jul 2006 10:59:14 -0400
Date: Thu, 20 Jul 2006 16:59:11 +0200
From: Cornelia Huck <cornelia.huck@de.ibm.com>
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org
Subject: [Patch] [mm] Fix bus_rescan_devices() in -mm
Message-ID: <20060720165911.42603374@gondolin.boeblingen.de.ibm.com>
X-Mailer: Sylpheed-Claws 2.3.1 (GTK+ 2.8.18; i486-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


With the __must_check changes in the driver core,
bus_rescan_devices_helper() now returns the return code of its call to
device_attach(). device_attach() will return < 0 on error, 0 on no
match and 1 on match. This means that bus_rescan_devices() will stop
after the first successful match for a device, which is probably not
what we want. Stopping on error makes sense, however.

Signed-off-by: Cornelia Huck <cornelia.huck@de.ibm.com>

 bus.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff -Naurp linux-2.6.18-rc1-mm2/drivers/base/bus.c linux-2.6.18-rc1-mm2+CH/drivers/base/bus.c
--- linux-2.6.18-rc1-mm2/drivers/base/bus.c	2006-07-17 18:15:37.000000000 +0200
+++ linux-2.6.18-rc1-mm2+CH/drivers/base/bus.c	2006-07-17 18:17:51.000000000 +0200
@@ -572,7 +572,7 @@ static int __must_check bus_rescan_devic
 		if (dev->parent)
 			up(&dev->parent->sem);
 	}
-	return ret;
+	return ret < 0 ? ret : 0;
 }
 
 /**
