Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932228AbWHLHfQ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932228AbWHLHfQ (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 12 Aug 2006 03:35:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932270AbWHLHfQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 12 Aug 2006 03:35:16 -0400
Received: from mtaout02-winn.ispmail.ntl.com ([81.103.221.48]:41886 "EHLO
	mtaout02-winn.ispmail.ntl.com") by vger.kernel.org with ESMTP
	id S932228AbWHLHfO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 12 Aug 2006 03:35:14 -0400
From: Catalin Marinas <catalin.marinas@gmail.com>
Subject: [PATCH 2.6.18-rc4] Fix device_attribute memory leak in device_del
Date: Sat, 12 Aug 2006 08:35:10 +0100
To: linux-kernel@vger.kernel.org
Message-Id: <20060812073510.8184.96897.stgit@localhost.localdomain>
Content-Type: text/plain; charset=utf-8; format=fixed
Content-Transfer-Encoding: 8bit
User-Agent: StGIT/0.10
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Catalin Marinas <catalin.marinas@gmail.com>

dev->devt_attr is allocated in device_add() but it is never freed in
device_del() in the drivers/base/core.c file (reported by kmemleak).

Signed-off-by: Catalin Marinas <catalin.marinas@gmail.com>
---

 drivers/base/core.c |    4 +++-
 1 files changed, 3 insertions(+), 1 deletions(-)

diff --git a/drivers/base/core.c b/drivers/base/core.c
index be6b5bc..5875196 100644
--- a/drivers/base/core.c
+++ b/drivers/base/core.c
@@ -452,8 +452,10 @@ void device_del(struct device * dev)
 
 	if (parent)
 		klist_del(&dev->knode_parent);
-	if (dev->devt_attr)
+	if (dev->devt_attr) {
 		device_remove_file(dev, dev->devt_attr);
+		kfree(dev->devt_attr);
+	}
 	if (dev->class) {
 		sysfs_remove_link(&dev->kobj, "subsystem");
 		sysfs_remove_link(&dev->class->subsys.kset.kobj, dev->bus_id);
