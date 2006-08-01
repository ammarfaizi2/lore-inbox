Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751163AbWHAV7a@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751163AbWHAV7a (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 1 Aug 2006 17:59:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751172AbWHAV7a
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 1 Aug 2006 17:59:30 -0400
Received: from mga01.intel.com ([192.55.52.88]:53681 "EHLO
	fmsmga101-1.fm.intel.com") by vger.kernel.org with ESMTP
	id S1751163AbWHAV73 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 1 Aug 2006 17:59:29 -0400
X-IronPort-AV: i="4.07,203,1151910000"; 
   d="scan'208"; a="108731431:sNHT20796475"
Date: Tue, 1 Aug 2006 14:59:19 -0700
From: Kristen Carlson Accardi <kristen.c.accardi@intel.com>
To: "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>
Cc: len.brown@intel.com, greg@kroah.com, linux-kernel@vger.kernel.org
Subject: [PATCH] acpi/uevents: remove dock uevents
Message-Id: <20060801145919.1496fd83.kristen.c.accardi@intel.com>
X-Mailer: Sylpheed version 2.2.6 (GTK+ 2.8.20; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Remove uevent dock notifications.  There are no consumers
of these events at present, and uevents are likely not the
correct way to send this type of event anyway.

Until I get some kind of idea if anyone in userspace cares
about dock events, I will just not send any.

Signed-off-by: Kristen Carlson Accardi <kristen.c.accardi@intel.com>
---
 drivers/acpi/dock.c     |   13 ++++++-------
 include/linux/kobject.h |    2 --
 lib/kobject_uevent.c    |    4 ----
 3 files changed, 6 insertions(+), 13 deletions(-)

--- 2.6-git.orig/drivers/acpi/dock.c
+++ 2.6-git/drivers/acpi/dock.c
@@ -58,8 +58,8 @@ struct dock_dependent_device {
 };
 
 #define DOCK_DOCKING	0x00000001
-#define DOCK_EVENT	KOBJ_DOCK
-#define UNDOCK_EVENT	KOBJ_UNDOCK
+#define DOCK_EVENT	3
+#define UNDOCK_EVENT	2
 
 static struct dock_station *dock_station;
 
@@ -322,11 +322,10 @@ static void hotplug_dock_devices(struct 
 
 static void dock_event(struct dock_station *ds, u32 event, int num)
 {
-	struct acpi_device *device;
-
-	device = dock_create_acpi_device(ds->handle);
-	if (device)
-		kobject_uevent(&device->kobj, num);
+	/*
+	 * we don't do events until someone tells me that
+	 * they would like to have them.
+	 */
 }
 
 /**
--- 2.6-git.orig/include/linux/kobject.h
+++ 2.6-git/include/linux/kobject.h
@@ -46,8 +46,6 @@ enum kobject_action {
 	KOBJ_UMOUNT	= (__force kobject_action_t) 0x05,	/* umount event for block devices (broken) */
 	KOBJ_OFFLINE	= (__force kobject_action_t) 0x06,	/* device offline */
 	KOBJ_ONLINE	= (__force kobject_action_t) 0x07,	/* device online */
-	KOBJ_UNDOCK	= (__force kobject_action_t) 0x08, 	/* undocking */
-	KOBJ_DOCK	= (__force kobject_action_t) 0x09,	/* dock */
 };
 
 struct kobject {
--- 2.6-git.orig/lib/kobject_uevent.c
+++ 2.6-git/lib/kobject_uevent.c
@@ -50,10 +50,6 @@ static char *action_to_string(enum kobje
 		return "offline";
 	case KOBJ_ONLINE:
 		return "online";
-	case KOBJ_DOCK:
-		return "dock";
-	case KOBJ_UNDOCK:
-		return "undock";
 	default:
 		return NULL;
 	}
