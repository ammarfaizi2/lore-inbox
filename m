Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261662AbVFUC7v@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261662AbVFUC7v (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 20 Jun 2005 22:59:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261913AbVFUC4i
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 20 Jun 2005 22:56:38 -0400
Received: from mail.kroah.org ([69.55.234.183]:11748 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S261665AbVFTW7i convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 20 Jun 2005 18:59:38 -0400
Cc: mochel@digitalimplant.org
Subject: [PATCH] sn: fixes due to driver core changes
In-Reply-To: <1119308367755@kroah.com>
X-Mailer: gregkh_patchbomb
Date: Mon, 20 Jun 2005 15:59:27 -0700
Message-Id: <11193083672422@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Reply-To: Greg K-H <greg@kroah.com>
To: linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 7BIT
From: Greg KH <gregkh@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

[PATCH] sn: fixes due to driver core changes

Signed-off-by: Andrew Morton <akpm@osdl.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@suse.de>

---
commit 6623415687eaffef49429292ab062bb046ee3311
tree f969c9683cf152a2709ca00b558b2cc65b36f7dc
parent 273971bade8a6d37c1b162146de1a53965cdc245
author Patrick Mochel <mochel@digitalimplant.org> Thu, 28 Apr 2005 17:11:52 -0700
committer Greg Kroah-Hartman <gregkh@suse.de> Mon, 20 Jun 2005 15:15:28 -0700

 arch/ia64/sn/kernel/tiocx.c |   21 +++++++++------------
 1 files changed, 9 insertions(+), 12 deletions(-)

diff --git a/arch/ia64/sn/kernel/tiocx.c b/arch/ia64/sn/kernel/tiocx.c
--- a/arch/ia64/sn/kernel/tiocx.c
+++ b/arch/ia64/sn/kernel/tiocx.c
@@ -518,25 +518,22 @@ static int __init tiocx_init(void)
 	return 0;
 }
 
-static void __exit tiocx_exit(void)
+static int cx_remove_device(struct device * dev, void * data)
 {
-	struct device *dev;
-	struct device *tdev;
+	struct cx_dev *cx_dev = to_cx_dev(dev);
+	device_remove_file(dev, &dev_attr_cxdev_control);
+	cx_device_unregister(cx_dev);
+	return 0;
+}
 
+static void __exit tiocx_exit(void)
+{
 	DBG("tiocx_exit\n");
 
 	/*
 	 * Unregister devices.
 	 */
-	list_for_each_entry_safe(dev, tdev, &tiocx_bus_type.devices.list,
-				 bus_list) {
-		if (dev) {
-			struct cx_dev *cx_dev = to_cx_dev(dev);
-			device_remove_file(dev, &dev_attr_cxdev_control);
-			cx_device_unregister(cx_dev);
-		}
-	}
-
+	bus_for_each_dev(&tiocx_bus_type, NULL, NULL, cx_remove_device);
 	bus_unregister(&tiocx_bus_type);
 }
 

