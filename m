Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262120AbUKDHQS@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262120AbUKDHQS (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 4 Nov 2004 02:16:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262125AbUKDHPa
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 4 Nov 2004 02:15:30 -0500
Received: from [211.58.254.17] ([211.58.254.17]:6051 "EHLO hemosu.com")
	by vger.kernel.org with ESMTP id S262122AbUKDHFF (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 4 Nov 2004 02:05:05 -0500
Date: Thu, 4 Nov 2004 16:05:02 +0900
From: Tejun Heo <tj@home-tj.org>
To: mochel@osdl.org, greg@kroah.com
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2.6.10-rc1 5/5] driver-model: device_add() error path reference counting fix
Message-ID: <20041104070502.GF25567@home-tj.org>
References: <20041104070134.GA25567@home-tj.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20041104070134.GA25567@home-tj.org>
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

 df_05_device_add_ref_fix.patch

 In device_add(), @dev wan't put'd properly when it has zero length
bus_id (error path).  Fixed.


Signed-off-by: Tejun Heo <tj@home-tj.org>


Index: linux-export/drivers/base/core.c
===================================================================
--- linux-export.orig/drivers/base/core.c	2004-11-04 10:25:58.000000000 +0900
+++ linux-export/drivers/base/core.c	2004-11-04 11:04:14.000000000 +0900
@@ -209,12 +209,13 @@ void device_initialize(struct device *de
  */
 int device_add(struct device *dev)
 {
-	struct device * parent;
+	struct device * parent = NULL;
 	int error;
 
+	error = -EINVAL;
 	dev = get_device(dev);
 	if (!dev || !strlen(dev->bus_id))
-		return -EINVAL;
+		goto Error;
 
 	parent = get_device(dev->parent);
 
