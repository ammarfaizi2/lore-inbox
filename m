Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262656AbVA0QbJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262656AbVA0QbJ (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 27 Jan 2005 11:31:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262655AbVA0QbJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 27 Jan 2005 11:31:09 -0500
Received: from umhlanga.stratnet.net ([12.162.17.40]:3171 "EHLO
	umhlanga.STRATNET.NET") by vger.kernel.org with ESMTP
	id S262654AbVA0Qau (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 27 Jan 2005 11:30:50 -0500
To: akmp@osdl.org
Cc: linux-kernel@vger.kernel.org, openib-general@openib.org
Subject: [PATCH] Use LANANA-assigned major in ib_umad
X-Message-Flag: Warning: May contain useful information
From: Roland Dreier <roland@topspin.com>
Date: Thu, 27 Jan 2005 08:30:44 -0800
Message-ID: <52r7k6yguj.fsf@topspin.com>
User-Agent: Gnus/5.1006 (Gnus v5.10.6) XEmacs/21.4 (Corporate Culture,
 linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-OriginalArrivalTime: 27 Jan 2005 16:30:47.0408 (UTC) FILETIME=[8E4A9700:01C5048D]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Update the ib_umad module to use major 231 instead of a dynamic major,
as assigned in the LANANA Linux 2.6+ Device List
(http://lanana.org/docs/device-list/devices-2.6+.txt).

Signed-off-by: Roland Dreier <roland@topspin.com>

--- linux-bk.orig/drivers/infiniband/core/user_mad.c	2005-01-23 21:51:46.000000000 -0800
+++ linux-bk/drivers/infiniband/core/user_mad.c	2005-01-27 08:27:35.157195600 -0800
@@ -56,7 +56,10 @@
 
 enum {
 	IB_UMAD_MAX_PORTS  = 64,
-	IB_UMAD_MAX_AGENTS = 32
+	IB_UMAD_MAX_AGENTS = 32,
+
+	IB_UMAD_MAJOR      = 231,
+	IB_UMAD_MINOR_BASE = 0
 };
 
 struct ib_umad_port {
@@ -97,7 +100,7 @@
 	DECLARE_PCI_UNMAP_ADDR(mapping)
 };
 
-static dev_t base_dev;
+static const dev_t base_dev = MKDEV(IB_UMAD_MAJOR, IB_UMAD_MINOR_BASE);
 static spinlock_t map_lock;
 static DECLARE_BITMAP(dev_map, IB_UMAD_MAX_PORTS * 2);
 
@@ -789,10 +792,10 @@
 
 	spin_lock_init(&map_lock);
 
-	ret = alloc_chrdev_region(&base_dev, 0, IB_UMAD_MAX_PORTS * 2,
-				  "infiniband_mad");
+	ret = register_chrdev_region(base_dev, IB_UMAD_MAX_PORTS * 2,
+				     "infiniband_mad");
 	if (ret) {
-		printk(KERN_ERR "user_mad: couldn't get device number\n");
+		printk(KERN_ERR "user_mad: couldn't register device number\n");
 		goto out;
 	}
 
