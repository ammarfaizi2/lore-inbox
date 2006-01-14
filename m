Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751765AbWANPSa@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751765AbWANPSa (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 14 Jan 2006 10:18:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751767AbWANPSa
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 14 Jan 2006 10:18:30 -0500
Received: from mx3.mail.elte.hu ([157.181.1.138]:43670 "EHLO mx3.mail.elte.hu")
	by vger.kernel.org with ESMTP id S1751765AbWANPSa (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 14 Jan 2006 10:18:30 -0500
Date: Sat, 14 Jan 2006 16:18:45 +0100
From: Ingo Molnar <mingo@elte.hu>
To: Andrew Morton <akpm@osdl.org>
Cc: Arjan van de Ven <arjan@infradead.org>, linux-kernel@vger.kernel.org,
       funaho@jurai.org
Subject: [patch 2.6.15-mm4] sem2mutex: drivers/macintosh/windfarm_core.c
Message-ID: <20060114151845.GA26231@elte.hu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4.2.1i
X-ELTE-SpamScore: 0.0
X-ELTE-SpamLevel: 
X-ELTE-SpamCheck: no
X-ELTE-SpamVersion: ELTE 2.0 
X-ELTE-SpamCheck-Details: score=0.0 required=5.9 tests=AWL autolearn=no SpamAssassin version=3.0.3
	0.0 AWL                    AWL: From: address is in the auto white-list
X-ELTE-VirusStatus: clean
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Ingo Molnar <mingo@elte.hu>

semaphore to mutex conversion.

the conversion was generated via scripts, and the result was validated
automatically via a script as well.

build and boot tested.

Signed-off-by: Ingo Molnar <mingo@elte.hu>
----

 drivers/macintosh/windfarm_core.c |   53 +++++++++++++++++++-------------------
 1 files changed, 27 insertions(+), 26 deletions(-)

Index: linux/drivers/macintosh/windfarm_core.c
===================================================================
--- linux.orig/drivers/macintosh/windfarm_core.c
+++ linux/drivers/macintosh/windfarm_core.c
@@ -33,6 +33,7 @@
 #include <linux/reboot.h>
 #include <linux/device.h>
 #include <linux/platform_device.h>
+#include <linux/mutex.h>
 
 #include "windfarm.h"
 
@@ -48,7 +49,7 @@
 
 static LIST_HEAD(wf_controls);
 static LIST_HEAD(wf_sensors);
-static DECLARE_MUTEX(wf_lock);
+static DEFINE_MUTEX(wf_lock);
 static struct notifier_block *wf_client_list;
 static int wf_client_count;
 static unsigned int wf_overtemp;
@@ -160,12 +161,12 @@ int wf_register_control(struct wf_contro
 {
 	struct wf_control *ct;
 
-	down(&wf_lock);
+	mutex_lock(&wf_lock);
 	list_for_each_entry(ct, &wf_controls, link) {
 		if (!strcmp(ct->name, new_ct->name)) {
 			printk(KERN_WARNING "windfarm: trying to register"
 			       " duplicate control %s\n", ct->name);
-			up(&wf_lock);
+			mutex_unlock(&wf_lock);
 			return -EEXIST;
 		}
 	}
@@ -175,7 +176,7 @@ int wf_register_control(struct wf_contro
 	DBG("wf: Registered control %s\n", new_ct->name);
 
 	wf_notify(WF_EVENT_NEW_CONTROL, new_ct);
-	up(&wf_lock);
+	mutex_unlock(&wf_lock);
 
 	return 0;
 }
@@ -183,9 +184,9 @@ EXPORT_SYMBOL_GPL(wf_register_control);
 
 void wf_unregister_control(struct wf_control *ct)
 {
-	down(&wf_lock);
+	mutex_lock(&wf_lock);
 	list_del(&ct->link);
-	up(&wf_lock);
+	mutex_unlock(&wf_lock);
 
 	DBG("wf: Unregistered control %s\n", ct->name);
 
@@ -197,16 +198,16 @@ struct wf_control * wf_find_control(cons
 {
 	struct wf_control *ct;
 
-	down(&wf_lock);
+	mutex_lock(&wf_lock);
 	list_for_each_entry(ct, &wf_controls, link) {
 		if (!strcmp(ct->name, name)) {
 			if (wf_get_control(ct))
 				ct = NULL;
-			up(&wf_lock);
+			mutex_unlock(&wf_lock);
 			return ct;
 		}
 	}
-	up(&wf_lock);
+	mutex_unlock(&wf_lock);
 	return NULL;
 }
 EXPORT_SYMBOL_GPL(wf_find_control);
@@ -250,12 +251,12 @@ int wf_register_sensor(struct wf_sensor 
 {
 	struct wf_sensor *sr;
 
-	down(&wf_lock);
+	mutex_lock(&wf_lock);
 	list_for_each_entry(sr, &wf_sensors, link) {
 		if (!strcmp(sr->name, new_sr->name)) {
 			printk(KERN_WARNING "windfarm: trying to register"
 			       " duplicate sensor %s\n", sr->name);
-			up(&wf_lock);
+			mutex_unlock(&wf_lock);
 			return -EEXIST;
 		}
 	}
@@ -265,7 +266,7 @@ int wf_register_sensor(struct wf_sensor 
 	DBG("wf: Registered sensor %s\n", new_sr->name);
 
 	wf_notify(WF_EVENT_NEW_SENSOR, new_sr);
-	up(&wf_lock);
+	mutex_unlock(&wf_lock);
 
 	return 0;
 }
@@ -273,9 +274,9 @@ EXPORT_SYMBOL_GPL(wf_register_sensor);
 
 void wf_unregister_sensor(struct wf_sensor *sr)
 {
-	down(&wf_lock);
+	mutex_lock(&wf_lock);
 	list_del(&sr->link);
-	up(&wf_lock);
+	mutex_unlock(&wf_lock);
 
 	DBG("wf: Unregistered sensor %s\n", sr->name);
 
@@ -287,16 +288,16 @@ struct wf_sensor * wf_find_sensor(const 
 {
 	struct wf_sensor *sr;
 
-	down(&wf_lock);
+	mutex_lock(&wf_lock);
 	list_for_each_entry(sr, &wf_sensors, link) {
 		if (!strcmp(sr->name, name)) {
 			if (wf_get_sensor(sr))
 				sr = NULL;
-			up(&wf_lock);
+			mutex_unlock(&wf_lock);
 			return sr;
 		}
 	}
-	up(&wf_lock);
+	mutex_unlock(&wf_lock);
 	return NULL;
 }
 EXPORT_SYMBOL_GPL(wf_find_sensor);
@@ -329,7 +330,7 @@ int wf_register_client(struct notifier_b
 	struct wf_control *ct;
 	struct wf_sensor *sr;
 
-	down(&wf_lock);
+	mutex_lock(&wf_lock);
 	rc = notifier_chain_register(&wf_client_list, nb);
 	if (rc != 0)
 		goto bail;
@@ -341,19 +342,19 @@ int wf_register_client(struct notifier_b
 	if (wf_client_count == 1)
 		wf_start_thread();
  bail:
-	up(&wf_lock);
+	mutex_unlock(&wf_lock);
 	return rc;
 }
 EXPORT_SYMBOL_GPL(wf_register_client);
 
 int wf_unregister_client(struct notifier_block *nb)
 {
-	down(&wf_lock);
+	mutex_lock(&wf_lock);
 	notifier_chain_unregister(&wf_client_list, nb);
 	wf_client_count++;
 	if (wf_client_count == 0)
 		wf_stop_thread();
-	up(&wf_lock);
+	mutex_unlock(&wf_lock);
 
 	return 0;
 }
@@ -361,23 +362,23 @@ EXPORT_SYMBOL_GPL(wf_unregister_client);
 
 void wf_set_overtemp(void)
 {
-	down(&wf_lock);
+	mutex_lock(&wf_lock);
 	wf_overtemp++;
 	if (wf_overtemp == 1) {
 		printk(KERN_WARNING "windfarm: Overtemp condition detected !\n");
 		wf_overtemp_counter = 0;
 		wf_notify(WF_EVENT_OVERTEMP, NULL);
 	}
-	up(&wf_lock);
+	mutex_unlock(&wf_lock);
 }
 EXPORT_SYMBOL_GPL(wf_set_overtemp);
 
 void wf_clear_overtemp(void)
 {
-	down(&wf_lock);
+	mutex_lock(&wf_lock);
 	WARN_ON(wf_overtemp == 0);
 	if (wf_overtemp == 0) {
-		up(&wf_lock);
+		mutex_unlock(&wf_lock);
 		return;
 	}
 	wf_overtemp--;
@@ -385,7 +386,7 @@ void wf_clear_overtemp(void)
 		printk(KERN_WARNING "windfarm: Overtemp condition cleared !\n");
 		wf_notify(WF_EVENT_NORMALTEMP, NULL);
 	}
-	up(&wf_lock);
+	mutex_unlock(&wf_lock);
 }
 EXPORT_SYMBOL_GPL(wf_clear_overtemp);
 
