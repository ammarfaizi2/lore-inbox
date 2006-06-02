Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932551AbWFBTwQ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932551AbWFBTwQ (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 2 Jun 2006 15:52:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932553AbWFBTwQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 2 Jun 2006 15:52:16 -0400
Received: from einhorn.in-berlin.de ([192.109.42.8]:43728 "EHLO
	einhorn.in-berlin.de") by vger.kernel.org with ESMTP
	id S932551AbWFBTwN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 2 Jun 2006 15:52:13 -0400
X-Envelope-From: stefanr@s5r6.in-berlin.de
Date: Fri, 2 Jun 2006 21:50:31 +0200 (CEST)
From: Stefan Richter <stefanr@s5r6.in-berlin.de>
Subject: [PATCH 2.6.17-rc5-mm2 04/18] Semaphore to mutex conversion.
To: Andrew Morton <akpm@osdl.org>
cc: linux-kernel@vger.kernel.org, linux1394-devel@lists.sourceforge.net,
       Jody McIntyre <scjody@modernduck.com>,
       Ben Collins <bcollins@ubuntu.com>
In-Reply-To: <tkrat.f22d0694697e6d7a@s5r6.in-berlin.de>
Message-ID: <tkrat.ecb0be3f1632e232@s5r6.in-berlin.de>
References: <tkrat.10011841414bfa88@s5r6.in-berlin.de>
 <tkrat.31172d1c0b7ae8e8@s5r6.in-berlin.de>
 <tkrat.51c50df7e692bbfa@s5r6.in-berlin.de>
 <tkrat.f22d0694697e6d7a@s5r6.in-berlin.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; CHARSET=us-ascii
Content-Disposition: INLINE
X-Spam-Score: (-0.036) AWL,BAYES_40
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Arjan van de Ven <arjan@infradead.org>

Semaphore to mutex conversion.

The conversion was generated via scripts, and the result was validated
automatically via a script as well.

Signed-off-by: Arjan van de Ven <arjan@infradead.org>
Signed-off-by: Ingo Molnar <mingo@elte.hu>
Cc: Ben Collins <bcollins@debian.org>
Cc: Jody McIntyre <scjody@modernduck.com>
Signed-off-by: Andrew Morton <akpm@osdl.org>

Index: linux-2.6.17-rc5-mm2/drivers/ieee1394/hosts.c
===================================================================
--- linux-2.6.17-rc5-mm2.orig/drivers/ieee1394/hosts.c	2006-06-01 20:55:05.000000000 +0200
+++ linux-2.6.17-rc5-mm2/drivers/ieee1394/hosts.c	2006-06-01 20:55:40.000000000 +0200
@@ -19,6 +19,7 @@
 #include <linux/pci.h>
 #include <linux/timer.h>
 #include <linux/jiffies.h>
+#include <linux/mutex.h>
 
 #include "csr1212.h"
 #include "ieee1394.h"
@@ -105,7 +106,7 @@ static int alloc_hostnum_cb(struct hpsb_
  * Return Value: a pointer to the &hpsb_host if succesful, %NULL if
  * no memory was available.
  */
-static DECLARE_MUTEX(host_num_alloc);
+static DEFINE_MUTEX(host_num_alloc);
 
 struct hpsb_host *hpsb_alloc_host(struct hpsb_host_driver *drv, size_t extra,
 				  struct device *dev)
@@ -148,7 +149,7 @@ struct hpsb_host *hpsb_alloc_host(struct
 	h->topology_map = h->csr.topology_map + 3;
 	h->speed_map = (u8 *)(h->csr.speed_map + 2);
 
-	down(&host_num_alloc);
+	mutex_lock(&host_num_alloc);
 
 	while (nodemgr_for_each_host(&hostnum, alloc_hostnum_cb))
 		hostnum++;
@@ -167,7 +168,7 @@ struct hpsb_host *hpsb_alloc_host(struct
 	class_device_register(&h->class_dev);
 	get_device(&h->device);
 
-	up(&host_num_alloc);
+	mutex_unlock(&host_num_alloc);
 
 	return h;
 }


