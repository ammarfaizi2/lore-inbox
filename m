Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750709AbWGBXWp@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750709AbWGBXWp (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 2 Jul 2006 19:22:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750712AbWGBXWp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 2 Jul 2006 19:22:45 -0400
Received: from einhorn.in-berlin.de ([192.109.42.8]:28375 "EHLO
	einhorn.in-berlin.de") by vger.kernel.org with ESMTP
	id S1750709AbWGBXWo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 2 Jul 2006 19:22:44 -0400
X-Envelope-From: stefanr@s5r6.in-berlin.de
Date: Mon, 3 Jul 2006 01:22:17 +0200 (CEST)
From: Stefan Richter <stefanr@s5r6.in-berlin.de>
Subject: [PATCH 14/19] ieee1394: nodemgr: do not spawn kernel_thread for sysfs
 rescan
To: Ben Collins <bcollins@ubuntu.com>
cc: linux1394-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org
In-Reply-To: <tkrat.8d67352567e525c1@s5r6.in-berlin.de>
Message-ID: <tkrat.c3da7810cd1a6b8d@s5r6.in-berlin.de>
References: <tkrat.8d67352567e525c1@s5r6.in-berlin.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; CHARSET=us-ascii
Content-Disposition: INLINE
X-Spam-Score: (0.904) AWL,BAYES_50
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

nodemgr.c::fw_set_rescan() is used to re-run the driver core over
nodemgr's representation of unit directories in order to initiate
protocol driver probes.  It is initiated via write access to one of
nodemgr's sysfs attributes.  The purpose is to attach drivers to
units after switching a unit's ignore_driver attribute from 1 to 0.

It is not really necessary to fork a kernel_thread for this job.  The
call to kernel_thread() can be eliminated to avoid the deprecated API
and to simplify the code a bit.

Signed-off-by: Stefan Richter <stefanr@s5r6.in-berlin.de>
---
Index: linux/drivers/ieee1394/nodemgr.c
===================================================================
--- linux.orig/drivers/ieee1394/nodemgr.c	2006-07-01 21:11:53.000000000 +0200
+++ linux/drivers/ieee1394/nodemgr.c	2006-07-01 21:17:37.000000000 +0200
@@ -405,26 +405,11 @@ static ssize_t fw_get_destroy_node(struc
 }
 static BUS_ATTR(destroy_node, S_IWUSR | S_IRUGO, fw_get_destroy_node, fw_set_destroy_node);
 
-static int nodemgr_rescan_bus_thread(void *__unused)
-{
-	/* No userlevel access needed */
-	daemonize("kfwrescan");
-
-	bus_rescan_devices(&ieee1394_bus_type);
-
-	return 0;
-}
 
 static ssize_t fw_set_rescan(struct bus_type *bus, const char *buf, size_t count)
 {
-	int state = simple_strtoul(buf, NULL, 10);
-
-	/* Don't wait for this, or care about errors. Root could do
-	 * something stupid and spawn this a lot of times, but that's
-	 * root's fault. */
-	if (state == 1)
-		kernel_thread(nodemgr_rescan_bus_thread, NULL, CLONE_KERNEL);
-
+	if (simple_strtoul(buf, NULL, 10) == 1)
+		bus_rescan_devices(&ieee1394_bus_type);
 	return count;
 }
 static ssize_t fw_get_rescan(struct bus_type *bus, char *buf)


