Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261769AbVFUAmE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261769AbVFUAmE (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 20 Jun 2005 20:42:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261770AbVFUAht
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 20 Jun 2005 20:37:49 -0400
Received: from mail.kroah.org ([69.55.234.183]:45796 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S261769AbVFTW7z convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 20 Jun 2005 18:59:55 -0400
Cc: gregkh@suse.de
Subject: [PATCH] Use device_for_each_child() to unregister devices in nodemgr_remove_host_dev()
In-Reply-To: <11193083662974@kroah.com>
X-Mailer: gregkh_patchbomb
Date: Mon, 20 Jun 2005 15:59:26 -0700
Message-Id: <11193083663947@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Reply-To: Greg K-H <greg@kroah.com>
To: linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 7BIT
From: Greg KH <gregkh@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

[PATCH] Use device_for_each_child() to unregister devices in nodemgr_remove_host_dev()

Signed-off-by: Greg Kroah-Hartman <gregkh@suse.de>

diff -Nru a/drivers/ieee1394/nodemgr.c b/drivers/ieee1394/nodemgr.c

---
commit 64360322ab3330d4881166380ad43a1eec2f123d
tree cfb876990acbe4669e9ba45d6252c75538288f24
parent ff710710eae73990dd484ea8e37dba636452502b
author gregkh@suse.de <gregkh@suse.de> Fri, 25 Mar 2005 11:45:31 -0800
committer Greg Kroah-Hartman <gregkh@suse.de> Mon, 20 Jun 2005 15:15:26 -0700

 drivers/ieee1394/nodemgr.c |   11 ++++++-----
 1 files changed, 6 insertions(+), 5 deletions(-)

diff --git a/drivers/ieee1394/nodemgr.c b/drivers/ieee1394/nodemgr.c
--- a/drivers/ieee1394/nodemgr.c
+++ b/drivers/ieee1394/nodemgr.c
@@ -695,14 +695,15 @@ static void nodemgr_remove_ne(struct nod
 	put_device(dev);
 }
 
+static int __nodemgr_remove_host_dev(struct device *dev, void *data)
+{
+	nodemgr_remove_ne(container_of(dev, struct node_entry, device));
+	return 0;
+}
 
 static void nodemgr_remove_host_dev(struct device *dev)
 {
-	struct device *ne_dev, *next;
-
-	list_for_each_entry_safe(ne_dev, next, &dev->children, node)
-		nodemgr_remove_ne(container_of(ne_dev, struct node_entry, device));
-
+	device_for_each_child(dev, NULL, __nodemgr_remove_host_dev);
 	sysfs_remove_link(&dev->kobj, "irm_id");
 	sysfs_remove_link(&dev->kobj, "busmgr_id");
 	sysfs_remove_link(&dev->kobj, "host_id");

