Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932258AbWGLXbU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932258AbWGLXbU (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 12 Jul 2006 19:31:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932472AbWGLXbG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 12 Jul 2006 19:31:06 -0400
Received: from cantor.suse.de ([195.135.220.2]:9101 "EHLO mx1.suse.de")
	by vger.kernel.org with ESMTP id S932258AbWGLXat (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 12 Jul 2006 19:30:49 -0400
From: Greg KH <greg@kroah.com>
To: linux-kernel@vger.kernel.org
Cc: Adrian Bunk <bunk@stusta.de>, Andrew Morton <akpm@osdl.org>,
       Greg Kroah-Hartman <gregkh@suse.de>
Subject: [PATCH 4/5] [PATCH] remove kernel/power/pm.c:pm_unregister_all()
Reply-To: Greg KH <greg@kroah.com>
Date: Wed, 12 Jul 2006 16:26:53 -0700
Message-Id: <11527468231110-git-send-email-greg@kroah.com>
X-Mailer: git-send-email 1.4.1
In-Reply-To: <11527468203373-git-send-email-greg@kroah.com>
References: <20060712232343.GA22672@kroah.com> <1152746814664-git-send-email-greg@kroah.com> <11527468173384-git-send-email-greg@kroah.com> <11527468203373-git-send-email-greg@kroah.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Adrian Bunk <bunk@stusta.de>

Remove the deprecated and no longer used pm_unregister_all().

Signed-off-by: Adrian Bunk <bunk@stusta.de>
Acked-by: Pavel Machek <pavel@suse.cz>
Signed-off-by: Andrew Morton <akpm@osdl.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@suse.de>
---
 include/linux/pm_legacy.h |    7 -------
 kernel/power/pm.c         |   37 -------------------------------------
 2 files changed, 0 insertions(+), 44 deletions(-)

diff --git a/include/linux/pm_legacy.h b/include/linux/pm_legacy.h
index 78027c5..514729a 100644
--- a/include/linux/pm_legacy.h
+++ b/include/linux/pm_legacy.h
@@ -15,11 +15,6 @@ struct pm_dev __deprecated *
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
@@ -35,8 +30,6 @@ static inline struct pm_dev *pm_register
 	return NULL;
 }
 
-static inline void pm_unregister_all(pm_callback callback) {}
-
 static inline int pm_send_all(pm_request_t rqst, void *data)
 {
 	return 0;
diff --git a/kernel/power/pm.c b/kernel/power/pm.c
index 84063ac..c50d152 100644
--- a/kernel/power/pm.c
+++ b/kernel/power/pm.c
@@ -75,42 +75,6 @@ struct pm_dev *pm_register(pm_dev_t type
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
@@ -239,7 +203,6 @@ int pm_send_all(pm_request_t rqst, void 
 }
 
 EXPORT_SYMBOL(pm_register);
-EXPORT_SYMBOL(pm_unregister_all);
 EXPORT_SYMBOL(pm_send_all);
 EXPORT_SYMBOL(pm_active);
 
-- 
1.4.1

