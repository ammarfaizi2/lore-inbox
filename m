Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264279AbTFPUn6 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 16 Jun 2003 16:43:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264272AbTFPUn6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 16 Jun 2003 16:43:58 -0400
Received: from e35.co.us.ibm.com ([32.97.110.133]:9635 "EHLO e35.co.us.ibm.com")
	by vger.kernel.org with ESMTP id S264279AbTFPUm2 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 16 Jun 2003 16:42:28 -0400
From: Kevin Corry <kevcorry@us.ibm.com>
To: Joe Thornber <thornber@sistina.com>
Subject: [PATCH] DM: 2.5.71: dm-ioctl.c: Unregister with devfs before renaming the device
Date: Mon, 16 Jun 2003 15:53:56 -0500
User-Agent: KMail/1.5
Cc: DevMapper <dm-devel@sistina.com>, LKML <linux-kernel@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200306161553.57000.kevcorry@us.ibm.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Unregister the previous name from devfs before renaming the device.

DM originally stored a devfs handle in the hash-cell, and performed the 
unregister based on that handle. These devfs handles have since been removed,
and devices are registered and unregistered simply based on their names. So
the device now needs to be unregistered before we lose the name.

See the following BK change for more details:
http://linux.bkbits.net:8080/linux-2.5/diffs/drivers/md/dm-ioctl.c@1.6?nav=index.html|src/|src/drivers|src/drivers/md|hist/drivers/md/dm-ioctl.c

--- linux-2.5.71a/drivers/md/dm-ioctl.c	16 Jun 2003 18:14:56 -0000
+++ linux-2.5.71b/drivers/md/dm-ioctl.c	16 Jun 2003 20:20:05 -0000
@@ -297,13 +297,14 @@
 	/*
 	 * rename and move the name cell.
 	 */
+	unregister_with_devfs(hc);
+
 	list_del(&hc->name_list);
 	old_name = hc->name;
 	hc->name = new_name;
 	list_add(&hc->name_list, _name_buckets + hash_str(new_name));
 
 	/* rename the device node in devfs */
-	unregister_with_devfs(hc);
 	register_with_devfs(hc);
 
 	up_write(&_hash_lock);


-- 
Kevin Corry
kevcorry@us.ibm.com
http://evms.sourceforge.net/

