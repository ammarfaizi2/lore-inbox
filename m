Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262208AbVBKHJx@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262208AbVBKHJx (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 11 Feb 2005 02:09:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262218AbVBKHJj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 11 Feb 2005 02:09:39 -0500
Received: from smtp817.mail.sc5.yahoo.com ([66.163.170.3]:45406 "HELO
	smtp817.mail.sc5.yahoo.com") by vger.kernel.org with SMTP
	id S262208AbVBKHFg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 11 Feb 2005 02:05:36 -0500
From: Dmitry Torokhov <dtor_core@ameritech.net>
To: InputML <linux-input@atrey.karlin.mff.cuni.cz>
Subject: [PATCH 4/10] Gameport: prepare to dynamic allocation
Date: Fri, 11 Feb 2005 02:01:30 -0500
User-Agent: KMail/1.7.2
Cc: alsa-devel@alsa-project.org, LKML <linux-kernel@vger.kernel.org>,
       Vojtech Pavlik <vojtech@suse.cz>
References: <200502110158.47872.dtor_core@ameritech.net> <200502110200.28299.dtor_core@ameritech.net> <200502110201.00916.dtor_core@ameritech.net>
In-Reply-To: <200502110201.00916.dtor_core@ameritech.net>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200502110201.31239.dtor_core@ameritech.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


===================================================================


ChangeSet@1.2152, 2005-02-11 01:18:48-05:00, dtor_core@ameritech.net
  Input: prepare for dynamic gameport allocation:
         - provide functions to allocate and free gameports;
         - provide functions to properly set name and phys;
         - dynamically allocated gameports are automatically
           announced in kernel logs and freed when unregistered.
  
  Signed-off-by: Dmitry Torokhov <dtor@mail.ru>


 drivers/input/gameport/gameport.c |   24 ++++++++++++++++++++++++
 include/linux/gameport.h          |   38 +++++++++++++++++++++++++++++++-------
 2 files changed, 55 insertions(+), 7 deletions(-)


===================================================================



diff -Nru a/drivers/input/gameport/gameport.c b/drivers/input/gameport/gameport.c
--- a/drivers/input/gameport/gameport.c	2005-02-11 01:36:13 -05:00
+++ b/drivers/input/gameport/gameport.c	2005-02-11 01:36:13 -05:00
@@ -31,6 +31,8 @@
 EXPORT_SYMBOL(gameport_close);
 EXPORT_SYMBOL(gameport_rescan);
 EXPORT_SYMBOL(gameport_cooked_read);
+EXPORT_SYMBOL(gameport_set_name);
+EXPORT_SYMBOL(gameport_set_phys);
 
 static LIST_HEAD(gameport_list);
 static LIST_HEAD(gameport_driver_list);
@@ -117,10 +119,30 @@
 	gameport_find_driver(gameport);
 }
 
+void gameport_set_phys(struct gameport *gameport, const char *fmt, ...)
+{
+	va_list args;
+
+	va_start(args, fmt);
+	gameport->phys = gameport->phys_buf;
+	vsnprintf(gameport->phys_buf, sizeof(gameport->phys_buf), fmt, args);
+	va_end(args);
+}
+
 void gameport_register_port(struct gameport *gameport)
 {
 	list_add_tail(&gameport->node, &gameport_list);
 	gameport->speed = gameport_measure_speed(gameport);
+
+	if (gameport->dyn_alloc) {
+		if (gameport->io)
+			printk(KERN_INFO "gameport: %s is %s, io %#x, speed %d kHz\n",
+				gameport->name, gameport->phys, gameport->io, gameport->speed);
+		else
+			printk(KERN_INFO "gameport: %s is %s, speed %d kHz\n",
+				gameport->name, gameport->phys, gameport->speed);
+	}
+
 	gameport_find_driver(gameport);
 }
 
@@ -129,6 +151,8 @@
 	list_del_init(&gameport->node);
 	if (gameport->drv)
 		gameport->drv->disconnect(gameport);
+	if (gameport->dyn_alloc)
+		kfree(gameport);
 }
 
 void gameport_register_driver(struct gameport_driver *drv)
diff -Nru a/include/linux/gameport.h b/include/linux/gameport.h
--- a/include/linux/gameport.h	2005-02-11 01:36:13 -05:00
+++ b/include/linux/gameport.h	2005-02-11 01:36:13 -05:00
@@ -12,15 +12,16 @@
 #include <asm/io.h>
 #include <linux/input.h>
 #include <linux/list.h>
-
-struct gameport;
+#include <linux/device.h>
 
 struct gameport {
 
 	void *private;		/* Private pointer for joystick drivers */
 	void *port_data;	/* Private pointer for gameport drivers */
 	char *name;
+	char name_buf[32];
 	char *phys;
+	char phys_buf[32];
 
 	struct input_id id;
 
@@ -36,8 +37,12 @@
 	void (*close)(struct gameport *);
 
 	struct gameport_driver *drv;
+	struct device dev;
 
 	struct list_head node;
+
+	/* temporary, till sysfs transition is complete */
+	int dyn_alloc;
 };
 
 struct gameport_driver {
@@ -55,13 +60,32 @@
 void gameport_close(struct gameport *gameport);
 void gameport_rescan(struct gameport *gameport);
 
-#if defined(CONFIG_GAMEPORT) || defined(CONFIG_GAMEPORT_MODULE)
+static inline struct gameport *gameport_allocate_port(void)
+{
+	struct gameport *gameport = kcalloc(1, sizeof(struct gameport), GFP_KERNEL);
+
+	if (gameport)
+		gameport->dyn_alloc = 1;
+
+	return gameport;
+}
+
+static inline void gameport_free_port(struct gameport *gameport)
+{
+	kfree(gameport);
+}
+
+static inline void gameport_set_name(struct gameport *gameport, const char *name)
+{
+	gameport->name = gameport->name_buf;
+	strlcpy(gameport->name, name, sizeof(gameport->name_buf));
+}
+
+void gameport_set_phys(struct gameport *gameport, const char *fmt, ...)
+	__attribute__ ((format (printf, 2, 3)));
+
 void gameport_register_port(struct gameport *gameport);
 void gameport_unregister_port(struct gameport *gameport);
-#else
-static inline void gameport_register_port(struct gameport *gameport) { return; }
-static inline void gameport_unregister_port(struct gameport *gameport) { return; }
-#endif
 
 void gameport_register_driver(struct gameport_driver *drv);
 void gameport_unregister_driver(struct gameport_driver *drv);
