Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261225AbULRULf@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261225AbULRULf (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 18 Dec 2004 15:11:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261226AbULRULf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 18 Dec 2004 15:11:35 -0500
Received: from ylpvm01-ext.prodigy.net ([207.115.57.32]:43213 "EHLO
	ylpvm01.prodigy.net") by vger.kernel.org with ESMTP id S261225AbULRUL3
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 18 Dec 2004 15:11:29 -0500
From: David Brownell <david-b@pacbell.net>
To: Linux Kernel list <linux-kernel@vger.kernel.org>
Subject: [patch 2.6.10-rc3] handle bridged platform bus segments
Date: Sat, 18 Dec 2004 12:11:40 -0800
User-Agent: KMail/1.7.1
MIME-Version: 1.0
Content-Type: Multipart/Mixed;
  boundary="Boundary-00=_97IxBLAiDaxoP4z"
Message-Id: <200412181211.41018.david-b@pacbell.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--Boundary-00=_97IxBLAiDaxoP4z
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

There's an inappropriate assumption that platform_bus
has only one top-level segment; trivially fixed.

- Dave

--Boundary-00=_97IxBLAiDaxoP4z
Content-Type: text/x-diff;
  charset="us-ascii";
  name="platform.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename="platform.patch"

During setup to access platform bus segments through bridges, the current
platform_device_register() ignores the resource parent specified by the
bridge.  That means it'll always detect a (false) resource conflict with
the bridge, and fail the resource reservation step.

This patch makes that code use the specified parent resource, defaulting
to "iomem_resource" or "ioport_resource" only for a NULL parent (that is,
for devices that aren't accessed through a bridge).

Signed-off-by: David Brownell <dbrownell@users.sourceforge.net>

--- 1.23/drivers/base/platform.c	2004-09-24 11:46:18 -07:00
+++ edited/drivers/base/platform.c	2004-12-18 11:38:35 -08:00
@@ -105,11 +105,13 @@
 
 		r->name = pdev->dev.bus_id;
 
-		p = NULL;
-		if (r->flags & IORESOURCE_MEM)
-			p = &iomem_resource;
-		else if (r->flags & IORESOURCE_IO)
-			p = &ioport_resource;
+		p = r->parent;
+		if (!p) {
+			if (r->flags & IORESOURCE_MEM)
+				p = &iomem_resource;
+			else if (r->flags & IORESOURCE_IO)
+				p = &ioport_resource;
+		}
 
 		if (p && request_resource(p, r)) {
 			printk(KERN_ERR

--Boundary-00=_97IxBLAiDaxoP4z--
