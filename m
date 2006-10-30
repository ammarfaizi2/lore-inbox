Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751963AbWJ3SSf@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751963AbWJ3SSf (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 30 Oct 2006 13:18:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751965AbWJ3SSf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 30 Oct 2006 13:18:35 -0500
Received: from mga03.intel.com ([143.182.124.21]:4144 "EHLO mga03.intel.com")
	by vger.kernel.org with ESMTP id S1751694AbWJ3SSe (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 30 Oct 2006 13:18:34 -0500
X-ExtLoop1: 1
X-IronPort-AV: i="4.09,371,1157353200"; 
   d="scan'208"; a="138259472:sNHT22936263"
Date: Mon, 30 Oct 2006 11:18:45 -0800
From: Kristen Carlson Accardi <kristen.c.accardi@intel.com>
To: linux-acpi@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, len.brown@intel.com
Subject: [patch] acpi: use mutex instead of spinlock in dock driver
Message-Id: <20061030111845.7fdb6d37.kristen.c.accardi@intel.com>
X-Mailer: Sylpheed version 2.2.9 (GTK+ 2.8.20; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

http://bugzilla.kernel.org/show_bug.cgi?id=7303

Use a mutex instead of a spinlock for locking the
hotplug list because we need to call into the acpi
subsystem which might sleep.

Signed-off-by: Kristen Carlson Accardi <kristen.c.accardi@intel.com>
---
 drivers/acpi/dock.c |   16 ++++++++--------
 1 file changed, 8 insertions(+), 8 deletions(-)

--- 2.6-git.orig/drivers/acpi/dock.c
+++ 2.6-git/drivers/acpi/dock.c
@@ -44,7 +44,7 @@ struct dock_station {
 	unsigned long last_dock_time;
 	u32 flags;
 	spinlock_t dd_lock;
-	spinlock_t hp_lock;
+	struct mutex hp_lock;
 	struct list_head dependent_devices;
 	struct list_head hotplug_devices;
 };
@@ -114,9 +114,9 @@ static void
 dock_add_hotplug_device(struct dock_station *ds,
 			struct dock_dependent_device *dd)
 {
-	spin_lock(&ds->hp_lock);
+	mutex_lock(&ds->hp_lock);
 	list_add_tail(&dd->hotplug_list, &ds->hotplug_devices);
-	spin_unlock(&ds->hp_lock);
+	mutex_unlock(&ds->hp_lock);
 }
 
 /**
@@ -130,9 +130,9 @@ static void
 dock_del_hotplug_device(struct dock_station *ds,
 			struct dock_dependent_device *dd)
 {
-	spin_lock(&ds->hp_lock);
+	mutex_lock(&ds->hp_lock);
 	list_del(&dd->hotplug_list);
-	spin_unlock(&ds->hp_lock);
+	mutex_unlock(&ds->hp_lock);
 }
 
 /**
@@ -295,7 +295,7 @@ static void hotplug_dock_devices(struct 
 {
 	struct dock_dependent_device *dd;
 
-	spin_lock(&ds->hp_lock);
+	mutex_lock(&ds->hp_lock);
 
 	/*
 	 * First call driver specific hotplug functions
@@ -317,7 +317,7 @@ static void hotplug_dock_devices(struct 
 		else
 			dock_create_acpi_device(dd->handle);
 	}
-	spin_unlock(&ds->hp_lock);
+	mutex_unlock(&ds->hp_lock);
 }
 
 static void dock_event(struct dock_station *ds, u32 event, int num)
@@ -625,7 +625,7 @@ static int dock_add(acpi_handle handle)
 	INIT_LIST_HEAD(&dock_station->dependent_devices);
 	INIT_LIST_HEAD(&dock_station->hotplug_devices);
 	spin_lock_init(&dock_station->dd_lock);
-	spin_lock_init(&dock_station->hp_lock);
+	mutex_init(&dock_station->hp_lock);
 	ATOMIC_INIT_NOTIFIER_HEAD(&dock_notifier_list);
 
 	/* Find dependent devices */
