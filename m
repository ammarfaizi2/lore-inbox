Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269843AbUJVHr6@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269843AbUJVHr6 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 22 Oct 2004 03:47:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269845AbUJSQpN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 19 Oct 2004 12:45:13 -0400
Received: from mail.kroah.org ([69.55.234.183]:58052 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S269802AbUJSQiu convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 19 Oct 2004 12:38:50 -0400
X-Donotread: and you are reading this why?
Subject: Re: [PATCH] Driver Core patches for 2.6.9
In-Reply-To: <10982038294134@kroah.com>
X-Patch: quite boring stuff, it's just source code...
Date: Tue, 19 Oct 2004 09:37:12 -0700
Message-Id: <10982038323021@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
To: linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 7BIT
From: Greg KH <greg@kroah.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

ChangeSet 1.1996, 2004/10/15 16:07:38-07:00, greg@kroah.com

kevent: add __bitwise kobject_action to help the compiler check for misusages

Signed-off-by: Greg Kroah-Hartman <greg@kroah.com>


 include/linux/kobject_uevent.h |   13 ++++++-------
 lib/kobject_uevent.c           |   28 +++++++++++++---------------
 2 files changed, 19 insertions(+), 22 deletions(-)


diff -Nru a/include/linux/kobject_uevent.h b/include/linux/kobject_uevent.h
--- a/include/linux/kobject_uevent.h	2004-10-19 09:20:20 -07:00
+++ b/include/linux/kobject_uevent.h	2004-10-19 09:20:20 -07:00
@@ -15,14 +15,13 @@
  * If you add an action here, you must also add the proper string to the
  * lib/kobject_uevent.c file.
  */
-
+typedef int __bitwise kobject_action_t;
 enum kobject_action {
-	KOBJ_ADD	= 0x00,	/* add event, for hotplug */
-	KOBJ_REMOVE	= 0x01,	/* remove event, for hotplug */
-	KOBJ_CHANGE	= 0x02,	/* a sysfs attribute file has changed */
-	KOBJ_MOUNT	= 0x03,	/* mount event for block devices */
-	KOBJ_UMOUNT	= 0x04,	/* umount event for block devices */
-	KOBJ_MAX_ACTION,	/* must be last action listed */
+	KOBJ_ADD	= (__force kobject_action_t) 0x01,	/* add event, for hotplug */
+	KOBJ_REMOVE	= (__force kobject_action_t) 0x02,	/* remove event, for hotplug */
+	KOBJ_CHANGE	= (__force kobject_action_t) 0x03,	/* a sysfs attribute file has changed */
+	KOBJ_MOUNT	= (__force kobject_action_t) 0x04,	/* mount event for block devices */
+	KOBJ_UMOUNT	= (__force kobject_action_t) 0x05,	/* umount event for block devices */
 };
 
 
diff -Nru a/lib/kobject_uevent.c b/lib/kobject_uevent.c
--- a/lib/kobject_uevent.c	2004-10-19 09:20:20 -07:00
+++ b/lib/kobject_uevent.c	2004-10-19 09:20:20 -07:00
@@ -23,24 +23,22 @@
 #include <linux/kobject.h>
 #include <net/sock.h>
 
-/* 
- * These must match up with the values for enum kobject_action
- * as found in include/linux/kobject_uevent.h
- */
-static char *actions[] = {
-	"add",		/* 0x00 */
-	"remove",	/* 0x01 */
-	"change",	/* 0x02 */
-	"mount",	/* 0x03 */
-	"umount",	/* 0x04 */
-};
-
 static char *action_to_string(enum kobject_action action)
 {
-	if (action >= KOBJ_MAX_ACTION)
+	switch (action) {
+	case KOBJ_ADD:
+		return "add";
+	case KOBJ_REMOVE:
+		return "remove";
+	case KOBJ_CHANGE:
+		return "change";
+	case KOBJ_MOUNT:
+		return "mount";
+	case KOBJ_UMOUNT:
+		return "umount";
+	default:
 		return NULL;
-	else
-		return actions[action];
+	}
 }
 
 #ifdef CONFIG_KOBJECT_UEVENT

