Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751122AbWIVJgw@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751122AbWIVJgw (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 22 Sep 2006 05:36:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751114AbWIVJgs
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 22 Sep 2006 05:36:48 -0400
Received: from mtagate6.de.ibm.com ([195.212.29.155]:21955 "EHLO
	mtagate6.de.ibm.com") by vger.kernel.org with ESMTP
	id S1751112AbWIVJgc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 22 Sep 2006 05:36:32 -0400
Date: Fri, 22 Sep 2006 11:36:55 +0200
From: Cornelia Huck <cornelia.huck@de.ibm.com>
To: Greg K-H <greg@kroah.com>
Cc: linux-kernel <linux-kernel@vger.kernel.org>
Subject: [2/9] driver core fixes: device_register() retval check in
 platform.c
Message-ID: <20060922113655.4306a1b5@gondolin.boeblingen.de.ibm.com>
X-Mailer: Sylpheed-Claws 2.5.0-rc3 (GTK+ 2.8.20; i486-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Cornelia Huck <cornelia.huck@de.ibm.com>

Check the return value of device_register() in platform_bus_init().

Signed-off-by: Cornelia Huck <cornelia.huck@de.ibm.com>

---
 drivers/base/platform.c |   11 +++++++++--
 1 file changed, 9 insertions(+), 2 deletions(-)

--- linux-2.6-CH.orig/drivers/base/platform.c
+++ linux-2.6-CH/drivers/base/platform.c
@@ -563,8 +563,15 @@ EXPORT_SYMBOL_GPL(platform_bus_type);
 
 int __init platform_bus_init(void)
 {
-	device_register(&platform_bus);
-	return bus_register(&platform_bus_type);
+	int error;
+
+	error = device_register(&platform_bus);
+	if (error)
+		return error;
+	error =  bus_register(&platform_bus_type);
+	if (error)
+		device_unregister(&platform_bus);
+	return error;
 }
 
 #ifndef ARCH_HAS_DMA_GET_REQUIRED_MASK
