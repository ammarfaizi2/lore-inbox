Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030507AbWCTWCL@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030507AbWCTWCL (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 20 Mar 2006 17:02:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030544AbWCTWBz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 20 Mar 2006 17:01:55 -0500
Received: from mail.kroah.org ([69.55.234.183]:52665 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S1030521AbWCTWBK (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 20 Mar 2006 17:01:10 -0500
Cc: Greg Kroah-Hartman <gregkh@suse.de>
Subject: [PATCH 16/23] Kobject: provide better warning messages when people do stupid things
In-Reply-To: <1142892038430-git-send-email-gregkh@suse.de>
X-Mailer: git-send-email
Date: Mon, 20 Mar 2006 14:00:38 -0800
Message-Id: <11428920383371-git-send-email-gregkh@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Reply-To: Greg Kroah-Hartman <gregkh@suse.de>
To: linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 7BIT
From: Greg Kroah-Hartman <gregkh@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Now that kobject_add() is used more than kobject_register() the kernel
wasn't always letting people know that they were doing something wrong.
This change fixes this.

Signed-off-by: Greg Kroah-Hartman <gregkh@suse.de>

---

 lib/kobject.c |   22 ++++++++++++++--------
 1 files changed, 14 insertions(+), 8 deletions(-)

dcd0da002122a70fe1c625c0ca9f58c95aa33ebe
diff --git a/lib/kobject.c b/lib/kobject.c
index efe67fa..36668c8 100644
--- a/lib/kobject.c
+++ b/lib/kobject.c
@@ -194,6 +194,17 @@ int kobject_add(struct kobject * kobj)
 		unlink(kobj);
 		if (parent)
 			kobject_put(parent);
+
+		/* be noisy on error issues */
+		if (error == -EEXIST)
+			printk("kobject_add failed for %s with -EEXIST, "
+			       "don't try to register things with the "
+			       "same name in the same directory.\n",
+			       kobject_name(kobj));
+		else
+			printk("kobject_add failed for %s (%d)\n",
+			       kobject_name(kobj), error);
+		dump_stack();
 	}
 
 	return error;
@@ -207,18 +218,13 @@ int kobject_add(struct kobject * kobj)
 
 int kobject_register(struct kobject * kobj)
 {
-	int error = 0;
+	int error = -EINVAL;
 	if (kobj) {
 		kobject_init(kobj);
 		error = kobject_add(kobj);
-		if (error) {
-			printk("kobject_register failed for %s (%d)\n",
-			       kobject_name(kobj),error);
-			dump_stack();
-		} else
+		if (!error)
 			kobject_uevent(kobj, KOBJ_ADD);
-	} else
-		error = -EINVAL;
+	}
 	return error;
 }
 
-- 
1.2.4


