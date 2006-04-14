Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965146AbWDNULb@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965146AbWDNULb (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 14 Apr 2006 16:11:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965148AbWDNULJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 14 Apr 2006 16:11:09 -0400
Received: from mail.kroah.org ([69.55.234.183]:1933 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S965143AbWDNULG (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 14 Apr 2006 16:11:06 -0400
Cc: Jayachandran C <jchandra@digeo.com>,
       "Jayachandran C." <c.jayachandran@gmail.com>,
       Greg Kroah-Hartman <gregkh@suse.de>
Subject: [PATCH 4/7] driver core: fix unnecessary NULL check in drivers/base/class.c
In-Reply-To: <11450453961808-git-send-email-greg@kroah.com>
X-Mailer: git-send-email
Date: Fri, 14 Apr 2006 13:09:56 -0700
Message-Id: <11450453961756-git-send-email-greg@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Reply-To: Greg KH <greg@kroah.com>
To: linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 7BIT
From: Greg KH <greg@kroah.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This patch tries to fix an issue in drivers/base/class.c, please
review and apply if correct.

Patch Description:
  "parent_class" is checked for NULL already, so removed the unnecessary
  check.

Signed-off-by: Jayachandran C. <c.jayachandran@gmail.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@suse.de>

---

 drivers/base/class.c |   13 ++++++-------
 1 files changed, 6 insertions(+), 7 deletions(-)

a14388904ca67197c9a531dba2358d8131697865
diff --git a/drivers/base/class.c b/drivers/base/class.c
index df7fdab..0e71dff 100644
--- a/drivers/base/class.c
+++ b/drivers/base/class.c
@@ -562,14 +562,13 @@ int class_device_add(struct class_device
 	kobject_uevent(&class_dev->kobj, KOBJ_ADD);
 
 	/* notify any interfaces this device is now here */
-	if (parent_class) {
-		down(&parent_class->sem);
-		list_add_tail(&class_dev->node, &parent_class->children);
-		list_for_each_entry(class_intf, &parent_class->interfaces, node)
-			if (class_intf->add)
-				class_intf->add(class_dev, class_intf);
-		up(&parent_class->sem);
+	down(&parent_class->sem);
+	list_add_tail(&class_dev->node, &parent_class->children);
+	list_for_each_entry(class_intf, &parent_class->interfaces, node) {
+		if (class_intf->add)
+			class_intf->add(class_dev, class_intf);
 	}
+	up(&parent_class->sem);
 
  register_done:
 	if (error) {
-- 
1.2.6


