Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261943AbVCUVB2@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261943AbVCUVB2 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 21 Mar 2005 16:01:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261910AbVCUU4m
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 21 Mar 2005 15:56:42 -0500
Received: from digitalimplant.org ([64.62.235.95]:18572 "HELO
	digitalimplant.org") by vger.kernel.org with SMTP id S261890AbVCUUsu
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 21 Mar 2005 15:48:50 -0500
Date: Mon, 21 Mar 2005 12:48:42 -0800 (PST)
From: Patrick Mochel <mochel@digitalimplant.org>
X-X-Sender: mochel@monsoon.he.net
To: linux-kernel@vger.kernel.org
cc: greg@kroah.com, "" <ambx1@neo.rr.com>
Subject: [4/9] [RFC] Steps to fixing the driver model locking
Message-ID: <Pine.LNX.4.50.0503211244190.20647-100000@monsoon.he.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


ChangeSet@1.2233, 2005-03-21 11:07:54-08:00, mochel@digitalimplant.org
  [pnp] Use driver_for_each_device() in drivers/pnp/driver.c instead of manually walking list.



  Signed-off-by: Patrick Mochel <mochel@digitalimplant.org>

diff -Nru a/drivers/pnp/driver.c b/drivers/pnp/driver.c
--- a/drivers/pnp/driver.c	2005-03-21 12:30:40 -08:00
+++ b/drivers/pnp/driver.c	2005-03-21 12:30:40 -08:00
@@ -160,10 +160,16 @@
 };


+static int count_devices(struct device * dev, void * c)
+{
+	int * count = c;
+	(*count)++;
+	return 0;
+}
+
 int pnp_register_driver(struct pnp_driver *drv)
 {
 	int count;
-	struct list_head *pos;

 	pnp_dbg("the driver '%s' has been registered", drv->name);

@@ -177,9 +183,7 @@
 	/* get the number of initial matches */
 	if (count >= 0){
 		count = 0;
-		list_for_each(pos,&drv->driver.devices){
-			count++;
-		}
+		driver_for_each_device(&drv->driver, NULL, &count, count_devices);
 	}
 	return count;
 }
