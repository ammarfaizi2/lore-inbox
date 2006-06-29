Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932282AbWF2TVX@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932282AbWF2TVX (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 29 Jun 2006 15:21:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932266AbWF2TUw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 29 Jun 2006 15:20:52 -0400
Received: from [141.84.69.5] ([141.84.69.5]:24336 "HELO mailout.stusta.mhn.de")
	by vger.kernel.org with SMTP id S932269AbWF2TUX (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 29 Jun 2006 15:20:23 -0400
Date: Thu, 29 Jun 2006 21:19:42 +0200
From: Adrian Bunk <bunk@stusta.de>
To: Andrew Morton <akpm@osdl.org>
Cc: pavel@suse.cz, linux-pm@osdl.org, linux-kernel@vger.kernel.org
Subject: [2.6 patch] remove kernel/power/pm.c:pm_unregister_all()
Message-ID: <20060629191942.GM19712@stusta.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.11+cvs20060403
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This patch removes the deprecated and no longer used pm_unregister_all().

Signed-off-by: Adrian Bunk <bunk@stusta.de>
Acked-by: Pavel Machek <pavel@suse.cz>

---

This patch was already sent on:
- 23 Jun 2006

 include/linux/pm_legacy.h |    7 -------
 kernel/power/pm.c         |   37 -------------------------------------
 2 files changed, 44 deletions(-)

--- linux-2.6.17-mm1-full/include/linux/pm_legacy.h.old	2006-06-22 17:55:29.000000000 +0200
+++ linux-2.6.17-mm1-full/include/linux/pm_legacy.h	2006-06-22 17:55:40.000000000 +0200
@@ -15,11 +15,6 @@
 pm_register(pm_dev_t type, unsigned long id, pm_callback callback);
 
 /*
- * Unregister all devices with matching callback
- */
-void __deprecated pm_unregister_all(pm_callback callback);
-
-/*
  * Send a request to all devices
  */
 int __deprecated pm_send_all(pm_request_t rqst, void *data);
@@ -35,8 +30,6 @@
 	return NULL;
 }
 
-static inline void pm_unregister_all(pm_callback callback) {}
-
 static inline int pm_send_all(pm_request_t rqst, void *data)
 {
 	return 0;
--- linux-2.6.17-mm1-full/kernel/power/pm.c.old	2006-06-22 17:56:18.000000000 +0200
+++ linux-2.6.17-mm1-full/kernel/power/pm.c	2006-06-22 18:10:14.000000000 +0200
@@ -75,42 +75,6 @@
 	return dev;
 }
 
-static void __pm_unregister(struct pm_dev *dev)
-{
-	if (dev) {
-		list_del(&dev->entry);
-		kfree(dev);
-	}
-}
-
-/**
- *	pm_unregister_all - unregister all devices with matching callback
- *	@callback: callback function pointer
- *
- *	Unregister every device that would call the callback passed. This
- *	is primarily meant as a helper function for loadable modules. It
- *	enables a module to give up all its managed devices without keeping
- *	its own private list.
- */
- 
-void pm_unregister_all(pm_callback callback)
-{
-	struct list_head *entry;
-
-	if (!callback)
-		return;
-
-	mutex_lock(&pm_devs_lock);
-	entry = pm_devs.next;
-	while (entry != &pm_devs) {
-		struct pm_dev *dev = list_entry(entry, struct pm_dev, entry);
-		entry = entry->next;
-		if (dev->callback == callback)
-			__pm_unregister(dev);
-	}
-	mutex_unlock(&pm_devs_lock);
-}
-
 /**
  *	pm_send - send request to a single device
  *	@dev: device to send to
@@ -239,7 +203,6 @@
 }
 
 EXPORT_SYMBOL(pm_register);
-EXPORT_SYMBOL(pm_unregister_all);
 EXPORT_SYMBOL(pm_send_all);
 EXPORT_SYMBOL(pm_active);
 

