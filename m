Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262628AbVF2RHn@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262628AbVF2RHn (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 29 Jun 2005 13:07:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262644AbVF2RE0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 29 Jun 2005 13:04:26 -0400
Received: from sj-iport-5.cisco.com ([171.68.10.87]:37385 "EHLO
	sj-iport-5.cisco.com") by vger.kernel.org with ESMTP
	id S262635AbVF2RCC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 29 Jun 2005 13:02:02 -0400
X-IronPort-AV: i="3.93,242,1115017200"; 
   d="scan'208"; a="195311655:sNHT28444096"
To: akpm@osdl.org
Cc: Greg KH <greg@kroah.com>, linux-kernel@vger.kernel.org,
       openib-general@openib.org
Subject: Re: [PATCH 05/16] IB uverbs: core implementation
X-Message-Flag: Warning: May contain useful information
References: <2005628163.lUk0bfpO8VsSXUh5@cisco.com>
	<2005628163.jfSiMqRcI78iLMJP@cisco.com>
	<20050629002709.GB17805@kroah.com>
From: Roland Dreier <rolandd@cisco.com>
Date: Wed, 29 Jun 2005 10:01:53 -0700
In-Reply-To: <20050629002709.GB17805@kroah.com> (Greg KH's message of "Tue,
 28 Jun 2005 17:27:09 -0700")
Message-ID: <52slz1drlq.fsf@topspin.com>
User-Agent: Gnus/5.1006 (Gnus v5.10.6) XEmacs/21.4 (Jumbo Shrimp, linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

    Greg> This is no longer needed with the class device interface in
    Greg> the kernel today.  Please use the new api (basically just
    Greg> set dev_t in the class_device, and you get this for free.)

Here's a patch that applies on top of this patch set that fixes this:


Greg KH pointed out that with the new class device code, we can just
set class_dev.devt instead of having our own show_dev() function.

Signed-off-by: Roland Dreier <rolandd@cisco.com>

--- linux.orig/drivers/infiniband/core/uverbs_main.c	2005-06-28 15:20:04.000000000 -0700
+++ linux/drivers/infiniband/core/uverbs_main.c	2005-06-29 09:54:26.560138283 -0700
@@ -509,15 +509,6 @@
 	.remove = ib_uverbs_remove_one
 };
 
-static ssize_t show_dev(struct class_device *class_dev, char *buf)
-{
-	struct ib_uverbs_device *dev =
-		container_of(class_dev, struct ib_uverbs_device, class_dev);
-
-	return print_dev_t(buf, dev->dev.dev);
-}
-static CLASS_DEVICE_ATTR(dev, S_IRUGO, show_dev, NULL);
-
 static ssize_t show_ibdev(struct class_device *class_dev, char *buf)
 {
 	struct ib_uverbs_device *dev =
@@ -584,12 +575,11 @@
 
 	uverbs_dev->class_dev.class = &uverbs_class;
 	uverbs_dev->class_dev.dev   = device->dma_device;
+	uverbs_dev->class_dev.devt  = uverbs_dev->dev.dev;
 	snprintf(uverbs_dev->class_dev.class_id, BUS_ID_SIZE, "uverbs%d", uverbs_dev->devnum);
 	if (class_device_register(&uverbs_dev->class_dev))
 		goto err_cdev;
 
-	if (class_device_create_file(&uverbs_dev->class_dev, &class_device_attr_dev))
-		goto err_class;
 	if (class_device_create_file(&uverbs_dev->class_dev, &class_device_attr_ibdev))
 		goto err_class;
 
