Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267401AbUI0WRl@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267401AbUI0WRl (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 27 Sep 2004 18:17:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267403AbUI0WRl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 27 Sep 2004 18:17:41 -0400
Received: from omx3-ext.sgi.com ([192.48.171.20]:2542 "EHLO omx3.sgi.com")
	by vger.kernel.org with ESMTP id S267401AbUI0WRi (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 27 Sep 2004 18:17:38 -0400
From: Jesse Barnes <jbarnes@engr.sgi.com>
To: greg@kroah.com, linux-kernel@vger.kernel.org
Subject: [PATCH] handle usb host allocation failures
Date: Mon, 27 Sep 2004 15:17:32 -0700
User-Agent: KMail/1.7
MIME-Version: 1.0
Content-Type: Multipart/Mixed;
  boundary="Boundary-00=_8FJWBKQSwkd+jh4"
Message-Id: <200409271517.32192.jbarnes@engr.sgi.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--Boundary-00=_8FJWBKQSwkd+jh4
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

It looks like a host (like ohci or whatever) could try to allocate a new 
usb_device structure with usb_alloc_dev and get back a valid pointer even if 
the allocation of its private data failed.  I first saw this in the 2.4 
sources, but it looks like 2.6 has the same problem.  This patch attempts to 
fix it by freeing dev if the ->allocate() routine fails, and then returns 
NULL instead of a potentially dangerous dev pointer.

Signed-off-by: Jesse Barnes <jbarnes@sgi.com>

Thanks,
Jesse

--Boundary-00=_8FJWBKQSwkd+jh4
Content-Type: text/plain;
  charset="us-ascii";
  name="usb-alloc-dev-nomem.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename="usb-alloc-dev-nomem.patch"

===== drivers/usb/core/usb.c 1.174 vs edited =====
--- 1.174/drivers/usb/core/usb.c	2004-08-03 07:18:53 -07:00
+++ edited/drivers/usb/core/usb.c	2004-09-27 15:13:25 -07:00
@@ -759,7 +759,10 @@
 	init_MUTEX(&dev->serialize);
 
 	if (dev->bus->op->allocate)
-		dev->bus->op->allocate(dev);
+		if (dev->bus->op->allocate(dev)) {
+			kfree(dev);
+			return NULL;
+		}
 
 	return dev;
 }

--Boundary-00=_8FJWBKQSwkd+jh4--
