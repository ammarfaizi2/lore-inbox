Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265768AbUEZSap@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265768AbUEZSap (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 26 May 2004 14:30:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265769AbUEZSap
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 26 May 2004 14:30:45 -0400
Received: from gateway-1237.mvista.com ([12.44.186.158]:11516 "EHLO
	av.mvista.com") by vger.kernel.org with ESMTP id S265768AbUEZS37
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 26 May 2004 14:29:59 -0400
Date: Wed, 26 May 2004 11:29:55 -0700
From: Todd Poynor <tpoynor@mvista.com>
To: greg@kroah.com, mochel@digitalimplant.org, linux-kernel@vger.kernel.org,
       akpm@osdl.org
Subject: [PATCH] Device runtime suspend/resume fixes try #2
Message-ID: <20040526182955.GA7176@slurryseal.ddns.mvista.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrew Morton wrote:

> err, this function needs a bit of work in the return value department...

Sorry, I'm a moron, try #2 below.

--- linux-2.6.6-orig/drivers/base/power/suspend.c	2004-05-10 11:22:58.000000000 -0700
+++ linux-2.6.6-pm/drivers/base/power/suspend.c	2004-05-23 00:07:51.000000000 -0700
@@ -42,13 +42,6 @@
 	if (dev->bus && dev->bus->suspend)
 		error = dev->bus->suspend(dev,state);
 
-	if (!error) {
-		list_del(&dev->power.entry);
-		list_add(&dev->power.entry,&dpm_off);
-	} else if (error == -EAGAIN) {
-		list_del(&dev->power.entry);
-		list_add(&dev->power.entry,&dpm_off_irq);
-	}
 	return error;
 }
 
@@ -81,12 +74,16 @@
 	while(!list_empty(&dpm_active)) {
 		struct list_head * entry = dpm_active.prev;
 		struct device * dev = to_device(entry);
-		if ((error = suspend_device(dev,state))) {
-			if (error != -EAGAIN)
-				goto Error;
-			else
-				error = 0;
-		}
+		error = suspend_device(dev,state);
+
+		if (!error) {
+			list_del(&dev->power.entry);
+			list_add(&dev->power.entry,&dpm_off);
+		} else if (error == -EAGAIN) {
+			list_del(&dev->power.entry);
+			list_add(&dev->power.entry,&dpm_off_irq);
+		} else
+			goto Error;
 	}
  Done:
 	up(&dpm_sem);
--- linux-2.6.6-orig/drivers/base/power/runtime.c	2004-05-10 11:22:58.000000000 -0700
+++ linux-2.6.6-pm/drivers/base/power/runtime.c	2004-05-26 10:37:05.193449240 -0700
@@ -14,7 +14,10 @@
 {
 	if (!dev->power.power_state)
 		return;
-	resume_device(dev);
+	if (! resume_device(dev))
+		dev->power.power_state = 0;
+
+	return;
 }
 

-- 
Todd
