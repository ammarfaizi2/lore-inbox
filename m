Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263321AbTHWRAJ (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 23 Aug 2003 13:00:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263402AbTHWQ6N
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 23 Aug 2003 12:58:13 -0400
Received: from [203.145.184.221] ([203.145.184.221]:63499 "EHLO naturesoft.net")
	by vger.kernel.org with ESMTP id S263220AbTHWPOu (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 23 Aug 2003 11:14:50 -0400
Subject: [PATCH 2.6.0-test4][MTD] pcmciamtd.c: remove release timer
From: Vinay K Nallamothu <vinay-rc@naturesoft.net>
To: Linus Torvalds <torvalds@osdl.org>
Cc: LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.8 (1.0.8-11) 
Date: 23 Aug 2003 21:07:07 +0530
Message-Id: <1061653027.1121.62.camel@lima.royalchallenge.com>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus,

Hopefully the last of the release timer patches.

This patch removes the PCMCIA timer release functionality which is no
longer required.

Please apply.

Vinay

drivers/mtd/maps/pcmciamtd.c |   23 ++++++++---------------
 1 files changed, 8 insertions(+), 15 deletions(-)

diff -urN linux-2.6.0-test4/drivers/mtd/maps/pcmciamtd.c linux-2.6.0-test4-nvk/drivers/mtd/maps/pcmciamtd.c
--- linux-2.6.0-test4/drivers/mtd/maps/pcmciamtd.c	2003-07-15 17:22:39.000000000 +0530
+++ linux-2.6.0-test4-nvk/drivers/mtd/maps/pcmciamtd.c	2003-08-23 20:57:27.000000000 +0530
@@ -344,9 +344,8 @@
  * still open, this will be postponed until it is closed.
  */
 
-static void pcmciamtd_release(u_long arg)
+static void pcmciamtd_release(dev_link_t *link)
 {
-	dev_link_t *link = (dev_link_t *)arg;
 	struct pcmciamtd_dev *dev = link->priv;
 
 	DEBUG(3, "link = 0x%p", link);
@@ -564,7 +563,7 @@
 
 	if(!dev->win_size) {
 		err("Cant allocate memory window");
-		pcmciamtd_release((u_long)link);
+		pcmciamtd_release(link);
 		return;
 	}
 	DEBUG(1, "Allocated a window of %dKiB", dev->win_size >> 10);
@@ -576,7 +575,7 @@
 	dev->win_base = ioremap(req.Base, req.Size);
 	if(!dev->win_base) {
 		err("ioremap(%lu, %u) failed", req.Base, req.Size);
-		pcmciamtd_release((u_long)link);
+		pcmciamtd_release(link);
 		return;
 	}
 	DEBUG(1, "mapped window dev = %p req.base = 0x%lx base = %p size = 0x%x",
@@ -631,7 +630,7 @@
 	
 	if(!mtd) {
 		DEBUG(1, "Cant find an MTD");
-		pcmciamtd_release((u_long)link);
+		pcmciamtd_release(link);
 		return;
 	}
 
@@ -671,7 +670,7 @@
 		map_destroy(mtd);
 		dev->mtd_info = NULL;
 		err("Couldnt register MTD device");
-		pcmciamtd_release((u_long)link);
+		pcmciamtd_release(link);
 		return;
 	}
 	snprintf(dev->node.dev_name, sizeof(dev->node.dev_name), "mtd%d", mtd->index);
@@ -683,7 +682,7 @@
  cs_failed:
 	cs_error(link->handle, last_fn, last_ret);
 	err("CS Error, exiting");
-	pcmciamtd_release((u_long)link);
+	pcmciamtd_release(link);
 	return;
 }
 
@@ -710,7 +709,7 @@
 				del_mtd_device(dev->mtd_info);
 				info("mtd%d: Removed", dev->mtd_info->index);
 			}
-			mod_timer(&link->release, jiffies + HZ/20);
+			pcmciamtd_release(link);
 		}
 		break;
 	case CS_EVENT_CARD_INSERTION:
@@ -751,10 +750,8 @@
 {
 	DEBUG(3, "link=0x%p", link);
 
-	del_timer(&link->release);
-
 	if(link->state & DEV_CONFIG) {
-		pcmciamtd_release((u_long)link);
+		pcmciamtd_release(link);
 	}
 
 	if (link->handle) {
@@ -790,10 +787,6 @@
 	link = &dev->link;
 	link->priv = dev;
 
-	init_timer(&link->release);
-	link->release.function = &pcmciamtd_release;
-	link->release.data = (u_long)link;
-
 	link->conf.Attributes = 0;
 	link->conf.IntType = INT_MEMORY;
 

