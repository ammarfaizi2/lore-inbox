Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751418AbWIZFlb@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751418AbWIZFlb (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 26 Sep 2006 01:41:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751294AbWIZFlG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 26 Sep 2006 01:41:06 -0400
Received: from ns2.suse.de ([195.135.220.15]:61141 "EHLO mx2.suse.de")
	by vger.kernel.org with ESMTP id S1751418AbWIZFkN (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 26 Sep 2006 01:40:13 -0400
From: Greg KH <greg@kroah.com>
To: linux-kernel@vger.kernel.org
Cc: Brian Walsh <brian@walsh.ws>, Andrew Morton <akpm@osdl.org>,
       Greg Kroah-Hartman <gregkh@suse.de>
Subject: [PATCH 40/47] drivers/base: Platform notify needs to occur before drivers attach to the device
Date: Mon, 25 Sep 2006 22:38:00 -0700
Message-Id: <11592492123695-git-send-email-greg@kroah.com>
X-Mailer: git-send-email 1.4.2.1
In-Reply-To: <1159249209773-git-send-email-greg@kroah.com>
References: <20060926053728.GA8970@kroah.com> <1159249087369-git-send-email-greg@kroah.com> <11592490903867-git-send-email-greg@kroah.com> <11592490933346-git-send-email-greg@kroah.com> <1159249096460-git-send-email-greg@kroah.com> <11592490993970-git-send-email-greg@kroah.com> <11592491023995-git-send-email-greg@kroah.com> <1159249104512-git-send-email-greg@kroah.com> <11592491082990-git-send-email-greg@kroah.com> <1159249111668-git-send-email-greg@kroah.com> <11592491152668-git-send-email-greg@kroah.com> <115924911859-git-send-email-greg@kroah.com> <11592491211162-git-send-email-greg@kroah.com> <1159249124371-git-send-email-greg@kroah.com> <11592491274168-git-send-email-greg@kroah.com> <11592491303012-git-send-email-greg@kroah.com> <11592491342421-git-send-email-greg@kroah.com> <11592491371254-git-send-email-greg@kroah.com> <1159249140339-git-send-email-greg@kroah.com> <11592491451786-git-send-email-greg@kroah.com> <11592491482560-git-send-email-greg@kroah.com> <11592491512
 235-git-send-email-greg@kroah.com> <11592491551919-git-send-email-greg@kroah.com> <11592491581007-git-send-email-greg@kroah.com> <11592491611339-git-send-email-greg@kroah.com> <11592491643725-git-send-email-greg@kroah.com> <11592491672052-git-send-email-greg@kroah.com> <11592491704137-git-send-email-greg@kroah.com> <11592491744040-git-send-email-greg@kroah.com> <1159249177618-git-send-email-greg@kroah.com> <11592491803904-git-send-email-greg@kroah.com> <11592491833450-git-send-email-greg@kroah.com> <11592491862904-git-send-email-greg@kroah.com> <11592491901464-git-send-email-greg@kroah.com> <11592491924093-git-send-email-greg@kroah.com> <1159249196427-git-send-email-greg@kroah.com> <1159249200793-git-send-email-greg@kroah.com> <11592492023883-git-send-email-greg@kroah.com> <11592492061208-git-send-email-greg@kroah.com> <1159249209773-git-send-email-greg@kroah.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Brian Walsh <brian@walsh.ws>

The platform_notify call for Arm and PPC architectures needs to be called
before the driver attaches to the device.  The problem only presents itself
when hotplugging certain devices while the driver is already loaded.

Signed-off-by: Brian Walsh <brian@walsh.ws>
Signed-off-by: Andrew Morton <akpm@osdl.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@suse.de>
---
 drivers/base/core.c |    8 ++++----
 1 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/base/core.c b/drivers/base/core.c
index bc9f35c..b224bb4 100644
--- a/drivers/base/core.c
+++ b/drivers/base/core.c
@@ -424,6 +424,10 @@ int device_add(struct device *dev)
 	if ((error = kobject_add(&dev->kobj)))
 		goto Error;
 
+	/* notify platform of device entry */
+	if (platform_notify)
+		platform_notify(dev);
+
 	dev->uevent_attr.attr.name = "uevent";
 	dev->uevent_attr.attr.mode = S_IWUSR;
 	if (dev->driver)
@@ -488,10 +492,6 @@ int device_add(struct device *dev)
 				class_intf->add_dev(dev, class_intf);
 		up(&dev->class->sem);
 	}
-
-	/* notify platform of device entry */
-	if (platform_notify)
-		platform_notify(dev);
  Done:
  	kfree(class_name);
 	put_device(dev);
-- 
1.4.2.1

