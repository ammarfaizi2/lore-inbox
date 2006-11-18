Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1755336AbWKRWnH@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755336AbWKRWnH (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 18 Nov 2006 17:43:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755340AbWKRWnH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 18 Nov 2006 17:43:07 -0500
Received: from mtaout03-winn.ispmail.ntl.com ([81.103.221.49]:38892 "EHLO
	mtaout03-winn.ispmail.ntl.com") by vger.kernel.org with ESMTP
	id S1755336AbWKRWnE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 18 Nov 2006 17:43:04 -0500
From: Catalin Marinas <catalin.marinas@gmail.com>
Subject: [PATCH 2.6.19-rc6] Fix device_attribute memory leak in device_del
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@suse.de>
Date: Sat, 18 Nov 2006 22:42:45 +0000
Message-ID: <20061118224011.6975.7433.stgit@localhost.localdomain>
User-Agent: StGIT/0.11
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

dev->devt_attr is allocated in device_add() but it is never freed in
device_del() in the drivers/base/core.c file (reported by kmemleak).

Signed-off-by: Catalin Marinas <catalin.marinas@gmail.com>
---

I sent this patch before for 2.6.18 but it probably got lost. Anyway,
I found the bug again while testing kmemleak.

 drivers/base/core.c |    4 +++-
 1 files changed, 3 insertions(+), 1 deletions(-)

diff --git a/drivers/base/core.c b/drivers/base/core.c
index 68ad11a..002fde4 100644
--- a/drivers/base/core.c
+++ b/drivers/base/core.c
@@ -591,8 +591,10 @@ void device_del(struct device * dev)
 
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
