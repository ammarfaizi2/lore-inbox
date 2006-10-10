Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932242AbWJJTMs@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932242AbWJJTMs (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 10 Oct 2006 15:12:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932240AbWJJTMs
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 10 Oct 2006 15:12:48 -0400
Received: from einhorn.in-berlin.de ([192.109.42.8]:7105 "EHLO
	einhorn.in-berlin.de") by vger.kernel.org with ESMTP
	id S932242AbWJJTMs (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 10 Oct 2006 15:12:48 -0400
X-Envelope-From: stefanr@s5r6.in-berlin.de
Date: Tue, 10 Oct 2006 21:11:43 +0200 (CEST)
From: Stefan Richter <stefanr@s5r6.in-berlin.de>
Subject: [PATCH 2.6.19-rc1 1/3] ieee1394: lock smaller region by
 host_num_alloc mutex
To: linux1394-devel@lists.sourceforge.net
cc: Jeff Garzik <jeff@garzik.org>, linux-kernel@vger.kernel.org
In-Reply-To: <452B979C.9030001@garzik.org>
Message-ID: <tkrat.f3f45c410340f9b2@s5r6.in-berlin.de>
References: <20061010064805.GA21310@havoc.gtf.org>
 <452B5BEE.4050407@s5r6.in-berlin.de> <452B979C.9030001@garzik.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; CHARSET=us-ascii
Content-Disposition: INLINE
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

We need the mutex only around the iteration over existing hosts.

Signed-off-by: Stefan Richter <stefanr@s5r6.in-berlin.de>
---
This prepares hosts.c for the following patch which adds checks of
driver core errors.

Index: linux-2.6.19-rc1/drivers/ieee1394/hosts.c
===================================================================
--- linux-2.6.19-rc1.orig/drivers/ieee1394/hosts.c	2006-10-10 19:06:06.000000000 +0200
+++ linux-2.6.19-rc1/drivers/ieee1394/hosts.c	2006-10-10 19:07:36.000000000 +0200
@@ -156,10 +156,9 @@ struct hpsb_host *hpsb_alloc_host(struct
 	h->speed_map = (u8 *)(h->csr.speed_map + 2);
 
 	mutex_lock(&host_num_alloc);
-
 	while (nodemgr_for_each_host(&hostnum, alloc_hostnum_cb))
 		hostnum++;
-
+	mutex_unlock(&host_num_alloc);
 	h->id = hostnum;
 
 	memcpy(&h->device, &nodemgr_dev_template_host, sizeof(h->device));
@@ -174,8 +173,6 @@ struct hpsb_host *hpsb_alloc_host(struct
 	class_device_register(&h->class_dev);
 	get_device(&h->device);
 
-	mutex_unlock(&host_num_alloc);
-
 	return h;
 }
 


