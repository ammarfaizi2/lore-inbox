Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751156AbWGLFpq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751156AbWGLFpq (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 12 Jul 2006 01:45:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751336AbWGLFpq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 12 Jul 2006 01:45:46 -0400
Received: from xenotime.net ([66.160.160.81]:24747 "HELO xenotime.net")
	by vger.kernel.org with SMTP id S1751156AbWGLFpo (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 12 Jul 2006 01:45:44 -0400
Date: Tue, 11 Jul 2006 22:46:46 -0700
From: "Randy.Dunlap" <rdunlap@xenotime.net>
To: lkml <linux-kernel@vger.kernel.org>
Cc: akpm <akpm@osdl.org>, axboe@suse.de
Subject: [PATCH -mm] block: handle subsystem_register init errors
Message-Id: <20060711224646.dc634553.rdunlap@xenotime.net>
Organization: YPO4
X-Mailer: Sylpheed version 2.2.6 (GTK+ 2.8.3; x86_64-unknown-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Randy Dunlap <rdunlap@xenotime.net>

Check and handle init errors.

Signed-off-by: Randy Dunlap <rdunlap@xenotime.net>
---
 block/genhd.c |    9 +++++++--
 1 files changed, 7 insertions(+), 2 deletions(-)

--- linux-2618-rc1mm1.orig/block/genhd.c
+++ linux-2618-rc1mm1/block/genhd.c
@@ -295,10 +295,15 @@ static struct kobject *base_probe(dev_t 
 
 static int __init genhd_device_init(void)
 {
+	int err;
+
 	bdev_map = kobj_map_init(base_probe, &block_subsys_lock);
 	blk_dev_init();
-	subsystem_register(&block_subsys);
-	return 0;
+	err = subsystem_register(&block_subsys);
+	if (err < 0)
+		printk(KERN_WARNING "%s: subsystem_register error: %d\n",
+			__FUNCTION__, err);
+	return err;
 }
 
 subsys_initcall(genhd_device_init);


---
