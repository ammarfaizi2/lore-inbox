Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315946AbSGYUZe>; Thu, 25 Jul 2002 16:25:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316135AbSGYUZe>; Thu, 25 Jul 2002 16:25:34 -0400
Received: from [195.39.17.254] ([195.39.17.254]:19584 "EHLO Elf.ucw.cz")
	by vger.kernel.org with ESMTP id <S315946AbSGYUZ0>;
	Thu, 25 Jul 2002 16:25:26 -0400
Date: Thu, 25 Jul 2002 12:37:14 +0200
From: Pavel Machek <pavel@ucw.cz>
To: vojtech@ucw.cz, kernel list <linux-kernel@vger.kernel.org>
Subject: input: fix sleep support, kill bad ifdefs, cleanup comments
Message-ID: <20020725103713.GA522@elf.ucw.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.28i
X-Warning: Reading this can be dangerous to your mental health.
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

It is possible to kill few #ifdefs from input.c, so I did that.

Comments far to the left hurt readability in my eyes (I believe
input.c has *way* too much comments, too, but...).

Fixed serio.c so its sleep support actually works.
							Pavel

--- clean/drivers/input/input.c	Tue Jul  9 04:54:08 2002
+++ linux-swsusp/drivers/input/input.c	Thu Jul 25 12:21:55 2002
@@ -429,7 +429,10 @@
 	if (value != 0)
 		printk(KERN_WARNING "input.c: hotplug returned %d\n", value);
 }
-
+#else
+static void input_call_hotplug(char *verb, struct input_dev *dev)
+{
+}
 #endif
 
 void input_register_device(struct input_dev *dev)
@@ -438,9 +441,9 @@
 	struct input_handle *handle;
 	struct input_device_id *id;
 
-/*
- * Initialize repeat timer to default values.
- */
+	/*
+	 * Initialize repeat timer to default values.
+	 */
 
 	init_timer(&dev->timer);
 	dev->timer.data = (long) dev;
@@ -448,16 +451,16 @@
 	dev->rep[REP_DELAY] = HZ/4;
 	dev->rep[REP_PERIOD] = HZ/33;
 
-/*
- * Add the device.
- */
+	/*
+	 * Add the device.
+	 */
 
 	dev->next = input_dev;	
 	input_dev = dev;
 
-/*
- * Notify handlers.
- */
+	/*
+	 * Notify handlers.
+	 */
 
 	while (handler) {
 		if ((id = input_match_device(handler->id_table, dev)))
@@ -466,17 +469,15 @@
 		handler = handler->next;
 	}
 
-/*
- * Notify the hotplug agent.
- */
+	/*
+	 * Notify the hotplug agent.
+	 */
 
-#ifdef CONFIG_HOTPLUG
 	input_call_hotplug("add", dev);
-#endif
 
-/*
- * Notify /proc.
- */
+	/*
+	 * Notify /proc.
+	 */
 
 #ifdef CONFIG_PROC_FS
 	input_devices_state++;
@@ -491,21 +492,21 @@
 
 	if (!dev) return;
 
-/*
- * Turn off power management for the device.
- */
+	/*
+	 * Turn off power management for the device.
+	 */
 	if (dev->pm_dev)
 		pm_unregister(dev->pm_dev);
 
-/*
- * Kill any pending repeat timers.
- */
+	/*
+	 * Kill any pending repeat timers.
+	 */
 
 	del_timer(&dev->timer);
 
-/*
- * Notify handlers.
- */
+	/*
+	 * Notify handlers.
+	 */
 
 	while (handle) {
 		dnext = handle->dnext;
@@ -514,22 +515,20 @@
 		handle = dnext;
 	}
 
-/*
- * Notify the hotplug agent.
- */
+	/*
+	 * Notify the hotplug agent.
+	 */
 
-#ifdef CONFIG_HOTPLUG
 	input_call_hotplug("remove", dev);
-#endif
 
-/*
- * Remove the device.
- */
+	/*
+	 * Remove the device.
+	 */
 	input_find_and_remove(struct input_dev, input_dev, dev, next);
 
-/*
- * Notify /proc.
- */
+	/*
+	 * Notify /proc.
+	 */
 
 #ifdef CONFIG_PROC_FS
 	input_devices_state++;
@@ -545,23 +544,23 @@
 
 	if (!handler) return;
 
-/*
- * Add minors if needed.
- */
+	/*
+	 * Add minors if needed.
+	 */
 
 	if (handler->fops != NULL)
 		input_table[handler->minor >> 5] = handler;
 
-/*
- * Add the handler.
- */
+	/*
+	 * Add the handler.
+	 */
 
 	handler->next = input_handler;	
 	input_handler = handler;
 	
-/*
- * Notify it about all existing devices.
- */
+	/*
+	 * Notify it about all existing devices.
+	 */
 
 	while (dev) {
 		if ((id = input_match_device(handler->id_table, dev)))
@@ -570,9 +569,9 @@
 		dev = dev->next;
 	}
 
-/*
- * Notify /proc.
- */
+	/*
+	 * Notify /proc.
+	 */
 
 #ifdef CONFIG_PROC_FS
 	input_devices_state++;
@@ -585,9 +584,9 @@
 	struct input_handle *handle = handler->handle;
 	struct input_handle *hnext;
 
-/*
- * Tell the handler to disconnect from all devices it keeps open.
- */
+	/*
+	 * Tell the handler to disconnect from all devices it keeps open.
+	 */
 
 	while (handle) {
 		hnext = handle->hnext;
@@ -596,21 +595,21 @@
 		handle = hnext;
 	}
 
-/*
- * Remove it.
- */
+	/*
+	 * Remove it.
+	 */
 	input_find_and_remove(struct input_handler, input_handler, handler,
 				next);
 
-/*
- * Remove minors.
- */
+	/*
+	 * Remove minors.
+	 */
 	if (handler->fops != NULL)
 		input_table[handler->minor >> 5] = NULL;
 
-/*
- * Notify /proc.
- */
+	/*
+	 * Notify /proc.
+	 */
 
 #ifdef CONFIG_PROC_FS
 	input_devices_state++;
@@ -820,11 +819,9 @@
 
 static void __exit input_exit(void)
 {
-#ifdef CONFIG_PROC_FS
 	remove_proc_entry("devices", proc_bus_input_dir);
 	remove_proc_entry("handlers", proc_bus_input_dir);
 	remove_proc_entry("input", proc_bus);
-#endif
 	devfs_unregister(input_devfs_handle);
         if (devfs_unregister_chrdev(INPUT_MAJOR, "input"))
                 printk(KERN_ERR "input: can't unregister char major %d", INPUT_MAJOR);
--- clean/drivers/input/serio/serio.c	Tue Jul 23 10:40:01 2002
+++ linux-swsusp/drivers/input/serio/serio.c	Thu Jul 25 12:02:51 2002
@@ -94,9 +94,9 @@
 
 	do {
 		serio_handle_events();
+		interruptible_sleep_on(&serio_wait); 
 		if (current->flags & PF_FREEZE)
 			refrigerator(PF_IOTHREAD);
-		interruptible_sleep_on(&serio_wait); 
 	} while (!signal_pending(current));
 
 	printk(KERN_DEBUG "serio: kseriod exiting");

-- 
Worst form of spam? Adding advertisment signatures ala sourceforge.net.
What goes next? Inserting advertisment *into* email?
