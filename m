Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261558AbUCBEYN (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 1 Mar 2004 23:24:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261561AbUCBEYN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 1 Mar 2004 23:24:13 -0500
Received: from bristol.phunnypharm.org ([65.207.35.130]:29074 "EHLO
	bristol.phunnypharm.org") by vger.kernel.org with ESMTP
	id S261558AbUCBEYK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 1 Mar 2004 23:24:10 -0500
Date: Mon, 1 Mar 2004 23:18:49 -0500
From: Ben Collins <bcollins@debian.org>
To: Dmitry Torokhov <dtor_core@ameritech.net>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.6.4-rc1: OOPS when daisy-chaining ieee1394 devices
Message-ID: <20040302041849.GQ1078@phunnypharm.org>
References: <200403012229.35742.dtor_core@ameritech.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200403012229.35742.dtor_core@ameritech.net>
User-Agent: Mutt/1.5.5.1+cvs20040105i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 01, 2004 at 10:29:34PM -0500, Dmitry Torokhov wrote:
> Hi,
> 
> Got the following oops when trying to power up DVD burner daisy chained to
> a WD hard drive. Reproducible with latest -bk as well as with ieee1394 patch
> from -mm tree. This is a regression as it was somewhat worked with earlier
> 2.6 kernels (well, earlier kernels could only log in into the last powered
> device, reconnecting to devices sitting earlier in chain was always failing),
> but there was no oopses.

Let me know if this patch works for you.

===== drivers/ieee1394/nodemgr.c 1.51 vs edited =====
--- 1.51/drivers/ieee1394/nodemgr.c	Wed Feb 25 09:41:45 2004
+++ edited/drivers/ieee1394/nodemgr.c	Mon Mar  1 23:15:10 2004
@@ -1286,18 +1286,19 @@
 }
 
 
-static void nodemgr_ud_update_pdrv(struct unit_directory *ud)
+static void nodemgr_update_pdrv(struct node_entry *ne)
 {
-	struct device *dev;
+	struct unit_directory *ud;
 	struct hpsb_protocol_driver *pdrv;
+	struct class *class = &nodemgr_ud_class;
+	struct class_device *cdev;
 
-	if (!get_device(&ud->device))
-		return;
-
-	list_for_each_entry(dev, &ud->device.children, node)
-		nodemgr_ud_update_pdrv(container_of(dev, struct unit_directory, device));
+	down_read(&class->subsys.rwsem);
+	list_for_each_entry(cdev, &class->children, node) {
+		ud = container_of(cdev, struct unit_directory, class_dev);
+		if (ud->ne != ne || !ud->device.driver)
+			continue;
 
-	if (ud->device.driver) {
 		pdrv = container_of(ud->device.driver, struct hpsb_protocol_driver, driver);
 
 		if (pdrv->update && pdrv->update(ud)) {
@@ -1306,14 +1307,13 @@
 			up_write(&ud->device.bus->subsys.rwsem);
 		}
 	}
-
-	put_device(&ud->device);
+	up_read(&class->subsys.rwsem);
 }
 
 
 static void nodemgr_probe_ne(struct host_info *hi, struct node_entry *ne, int generation)
 {
-	struct device *dev, *udev;
+	struct device *dev;
 
 	if (ne->host != hi->host || ne->in_limbo)
 		return;
@@ -1330,8 +1330,7 @@
 	if (ne->needs_probe)
 		nodemgr_process_root_directory(hi, ne);
 	else if (ne->generation == generation)
-		list_for_each_entry(udev, &dev->children, node)
-			nodemgr_ud_update_pdrv(container_of(udev, struct unit_directory, device));
+		nodemgr_update_pdrv(ne);
 	else
 		nodemgr_suspend_ne(ne);
 

-- 
Debian     - http://www.debian.org/
Linux 1394 - http://www.linux1394.org/
Subversion - http://subversion.tigris.org/
WatchGuard - http://www.watchguard.com/
