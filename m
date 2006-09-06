Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751723AbWIFRF2@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751723AbWIFRF2 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 6 Sep 2006 13:05:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751725AbWIFRF1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 6 Sep 2006 13:05:27 -0400
Received: from einhorn.in-berlin.de ([192.109.42.8]:21402 "EHLO
	einhorn.in-berlin.de") by vger.kernel.org with ESMTP
	id S1751722AbWIFRF1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 6 Sep 2006 13:05:27 -0400
X-Envelope-From: stefanr@s5r6.in-berlin.de
Date: Wed, 6 Sep 2006 19:04:38 +0200 (CEST)
From: Stefan Richter <stefanr@s5r6.in-berlin.de>
Subject: [RFT PATCH 1/2] ieee1394: nodemgr: fix rwsem recursion
To: linux1394-devel@lists.sourceforge.net
cc: linux-kernel@vger.kernel.org, Andrew Morton <akpm@osdl.org>,
       Miles Lane <miles.lane@gmail.com>,
       Herbert Xu <herbert@gondor.apana.org.au>,
       Ben Collins <bcollins@ubuntu.com>, Greg KH <gregkh@suse.de>
In-Reply-To: <44FEFC68.90201@s5r6.in-berlin.de>
Message-ID: <tkrat.a76041f4792feb5b@s5r6.in-berlin.de>
References: <a44ae5cd0609051037k47d1ad7dsa8276dc0cec416bf@mail.gmail.com>
 <20060905111306.80398394.akpm@osdl.org> <44FDCEAD.5070905@s5r6.in-berlin.de>
 <44FE751E.4030505@s5r6.in-berlin.de> <44FEFC68.90201@s5r6.in-berlin.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; CHARSET=us-ascii
Content-Disposition: INLINE
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

nodemgr_update_pdrv grabbed an rw semaphore (as reader) which was
already taken by its caller's caller, nodemgr_probe_ne (as reader too).
Reported by Miles Lane, call path pointed out by Arjan van de Ven.

FIXME:
Shouldn't we rather use class->sem there, not class->subsys.rwsem?

Signed-off-by: Stefan Richter <stefanr@s5r6.in-berlin.de>
---
Index: linux/drivers/ieee1394/nodemgr.c
===================================================================
--- linux.orig/drivers/ieee1394/nodemgr.c	2006-08-30 20:47:57.000000000 +0200
+++ linux/drivers/ieee1394/nodemgr.c	2006-09-06 19:03:24.000000000 +0200
@@ -1316,6 +1316,7 @@ static void nodemgr_node_scan(struct hos
 }
 
 
+/* Caller needs to hold nodemgr_ud_class.subsys.rwsem as reader. */
 static void nodemgr_suspend_ne(struct node_entry *ne)
 {
 	struct class_device *cdev;
@@ -1368,15 +1369,14 @@ static void nodemgr_resume_ne(struct nod
 }
 
 
+/* Caller needs to hold nodemgr_ud_class.subsys.rwsem as reader. */
 static void nodemgr_update_pdrv(struct node_entry *ne)
 {
 	struct unit_directory *ud;
 	struct hpsb_protocol_driver *pdrv;
-	struct class *class = &nodemgr_ud_class;
 	struct class_device *cdev;
 
-	down_read(&class->subsys.rwsem);
-	list_for_each_entry(cdev, &class->children, node) {
+	list_for_each_entry(cdev, &nodemgr_ud_class.children, node) {
 		ud = container_of(cdev, struct unit_directory, class_dev);
 		if (ud->ne != ne || !ud->device.driver)
 			continue;
@@ -1389,7 +1389,6 @@ static void nodemgr_update_pdrv(struct n
 			up_write(&ud->device.bus->subsys.rwsem);
 		}
 	}
-	up_read(&class->subsys.rwsem);
 }
 
 
@@ -1420,6 +1419,8 @@ static void nodemgr_irm_write_bc(struct 
 }
 
 
+/* Caller needs to hold nodemgr_ud_class.subsys.rwsem as reader because the
+ * calls to nodemgr_update_pdrv() and nodemgr_suspend_ne() here require it. */
 static void nodemgr_probe_ne(struct host_info *hi, struct node_entry *ne, int generation)
 {
 	struct device *dev;


