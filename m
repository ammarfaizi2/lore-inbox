Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932401AbWGLDwD@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932401AbWGLDwD (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 11 Jul 2006 23:52:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932399AbWGLDwD
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 11 Jul 2006 23:52:03 -0400
Received: from xenotime.net ([66.160.160.81]:9190 "HELO xenotime.net")
	by vger.kernel.org with SMTP id S932392AbWGLDv7 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 11 Jul 2006 23:51:59 -0400
Date: Tue, 11 Jul 2006 20:47:02 -0700
From: "Randy.Dunlap" <rdunlap@xenotime.net>
To: lkml <linux-kernel@vger.kernel.org>
Cc: dmitry.torokhov@gmail.com, akpm <akpm@osdl.org>
Subject: [PATCH -mm] input: must_check fixes
Message-Id: <20060711204702.9e2a324c.rdunlap@xenotime.net>
Organization: YPO4
X-Mailer: Sylpheed version 2.2.6 (GTK+ 2.8.3; x86_64-unknown-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Randy Dunlap <rdunlap@xenotime.net>

Check all __must_check warnings in gameport and serio.

Signed-off-by: Randy Dunlap <rdunlap@xenotime.net>
---
 drivers/input/gameport/gameport.c |   39 ++++++++++++++++++++++++--------
 drivers/input/serio/serio.c       |   46 ++++++++++++++++++++++++++++----------
 2 files changed, 65 insertions(+), 20 deletions(-)

--- linux-2618-rc1mm1.orig/drivers/input/gameport/gameport.c
+++ linux-2618-rc1mm1/drivers/input/gameport/gameport.c
@@ -211,9 +211,13 @@ static void gameport_release_driver(stru
 
 static void gameport_find_driver(struct gameport *gameport)
 {
+	int ret;
+
 	down_write(&gameport_bus.subsys.rwsem);
-	device_attach(&gameport->dev);
+	ret = device_attach(&gameport->dev);
 	up_write(&gameport_bus.subsys.rwsem);
+	if (ret < 0)
+		printk(KERN_WARNING "gameport: device_attach error: %d\n", ret);
 }
 
 
@@ -353,6 +357,7 @@ static void gameport_handle_event(void)
 	 * taking performance hit.
 	 */
 	if ((event = gameport_get_event())) {
+		int ret;
 
 		switch (event->type) {
 			case GAMEPORT_REGISTER_PORT:
@@ -370,7 +375,11 @@ static void gameport_handle_event(void)
 
 			case GAMEPORT_REGISTER_DRIVER:
 				gameport_drv = event->object;
-				driver_register(&gameport_drv->driver);
+				ret = driver_register(&gameport_drv->driver);
+				if (ret < 0)
+					printk(KERN_WARNING "gameport: "
+						"driver_register error: %d\n",
+						ret);
 				break;
 
 			default:
@@ -544,6 +553,8 @@ static void gameport_init_port(struct ga
  */
 static void gameport_add_port(struct gameport *gameport)
 {
+	int ret;
+
 	if (gameport->parent)
 		gameport->parent->child = gameport;
 
@@ -558,8 +569,11 @@ static void gameport_add_port(struct gam
 		printk(KERN_INFO "gameport: %s is %s, speed %dkHz\n",
 			gameport->name, gameport->phys, gameport->speed);
 
-	device_add(&gameport->dev);
-	gameport->registered = 1;
+	ret = device_add(&gameport->dev);
+	if (ret < 0)
+		printk(KERN_WARNING "gameport: device_add error: %d\n", ret);
+	else
+		gameport->registered = 1;
 }
 
 /*
@@ -778,17 +792,24 @@ void gameport_close(struct gameport *gam
 
 static int __init gameport_init(void)
 {
+	int ret;
+
+	gameport_bus.dev_attrs = gameport_device_attrs;
+	gameport_bus.drv_attrs = gameport_driver_attrs;
+	gameport_bus.match = gameport_bus_match;
+	ret = bus_register(&gameport_bus);
+	if (ret < 0) {
+		printk(KERN_WARNING "gameport: bus_register error: %d\n", ret);
+		return ret;
+	}
+
 	gameport_task = kthread_run(gameport_thread, NULL, "kgameportd");
 	if (IS_ERR(gameport_task)) {
 		printk(KERN_ERR "gameport: Failed to start kgameportd\n");
+		bus_unregister(&gameport_bus);
 		return PTR_ERR(gameport_task);
 	}
 
-	gameport_bus.dev_attrs = gameport_device_attrs;
-	gameport_bus.drv_attrs = gameport_driver_attrs;
-	gameport_bus.match = gameport_bus_match;
-	bus_register(&gameport_bus);
-
 	return 0;
 }
 
--- linux-2618-rc1mm1.orig/drivers/input/serio/serio.c
+++ linux-2618-rc1mm1/drivers/input/serio/serio.c
@@ -140,9 +140,13 @@ static void serio_release_driver(struct 
 
 static void serio_find_driver(struct serio *serio)
 {
+	int ret;
+
 	down_write(&serio_bus.subsys.rwsem);
-	device_attach(&serio->dev);
+	ret = device_attach(&serio->dev);
 	up_write(&serio_bus.subsys.rwsem);
+	if (ret < 0)
+		printk(KERN_WARNING "serio: device_attach error: %d\n", ret);
 }
 
 
@@ -283,6 +287,7 @@ static void serio_handle_event(void)
 	 * performance hit.
 	 */
 	if ((event = serio_get_event())) {
+		int ret;
 
 		switch (event->type) {
 			case SERIO_REGISTER_PORT:
@@ -305,7 +310,11 @@ static void serio_handle_event(void)
 
 			case SERIO_REGISTER_DRIVER:
 				serio_drv = event->object;
-				driver_register(&serio_drv->driver);
+				ret = driver_register(&serio_drv->driver);
+				if (ret < 0)
+					printk(KERN_WARNING "serio: "
+						"driver_register error: %d\n",
+						ret);
 				break;
 
 			default:
@@ -542,6 +551,8 @@ static void serio_init_port(struct serio
  */
 static void serio_add_port(struct serio *serio)
 {
+	int ret;
+
 	if (serio->parent) {
 		serio_pause_rx(serio->parent);
 		serio->parent->child = serio;
@@ -551,9 +562,15 @@ static void serio_add_port(struct serio 
 	list_add_tail(&serio->node, &serio_list);
 	if (serio->start)
 		serio->start(serio);
-	device_add(&serio->dev);
-	sysfs_create_group(&serio->dev.kobj, &serio_id_attr_group);
-	serio->registered = 1;
+	ret = device_add(&serio->dev);
+	if (ret < 0)
+		printk(KERN_WARNING "serio: device_add error: %d\n", ret);
+	else
+		serio->registered = 1;
+	ret = sysfs_create_group(&serio->dev.kobj, &serio_id_attr_group);
+	if (ret < 0)
+		printk(KERN_WARNING "serio: sysfs_create_group error: %d\n",
+			ret);
 }
 
 /*
@@ -903,18 +920,25 @@ irqreturn_t serio_interrupt(struct serio
 
 static int __init serio_init(void)
 {
-	serio_task = kthread_run(serio_thread, NULL, "kseriod");
-	if (IS_ERR(serio_task)) {
-		printk(KERN_ERR "serio: Failed to start kseriod\n");
-		return PTR_ERR(serio_task);
-	}
+	int ret;
 
 	serio_bus.dev_attrs = serio_device_attrs;
 	serio_bus.drv_attrs = serio_driver_attrs;
 	serio_bus.match = serio_bus_match;
 	serio_bus.uevent = serio_uevent;
 	serio_bus.resume = serio_resume;
-	bus_register(&serio_bus);
+	ret = bus_register(&serio_bus);
+	if (ret < 0) {
+		printk(KERN_WARNING "serio: bus_register error: %d\n", ret);
+		return ret;
+	}
+
+	serio_task = kthread_run(serio_thread, NULL, "kseriod");
+	if (IS_ERR(serio_task)) {
+		printk(KERN_ERR "serio: Failed to start kseriod\n");
+		bus_unregister(&serio_bus);
+		return PTR_ERR(serio_task);
+	}
 
 	return 0;
 }


---
