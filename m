Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261262AbTKUVv0 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 21 Nov 2003 16:51:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261270AbTKUVv0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 21 Nov 2003 16:51:26 -0500
Received: from gprs149-119.eurotel.cz ([160.218.149.119]:45441 "EHLO
	amd.ucw.cz") by vger.kernel.org with ESMTP id S261262AbTKUVvU (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 21 Nov 2003 16:51:20 -0500
Date: Fri, 21 Nov 2003 22:32:51 +0100
From: Pavel Machek <pavel@suse.cz>
To: vojtech@suse.cz, kernel list <linux-kernel@vger.kernel.org>
Subject: How to properly suspend/resume i8042?
Message-ID: <20031121213251.GA1822@elf.ucw.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

I'm trying to find out how to properly resume i8042... Unfortunately I
can not find anything usefull.. What's the right thing to do?

This version is best I have, based on -mm patches. Unfortunately it
calls hotplug which is really bad.

Any ideas?
								Pavel

--- clean/drivers/input/mouse/psmouse-base.c	2003-09-28 22:05:48.000000000 +0200
+++ linux/drivers/input/mouse/psmouse-base.c	2003-11-21 22:27:04.000000000 +0100
@@ -532,20 +532,13 @@
 static int psmouse_pm_callback(struct pm_dev *dev, pm_request_t request, void *data)
 {
 	struct psmouse *psmouse = dev->data;
-	struct serio_dev *ser_dev = psmouse->serio->dev;
-
-	synaptics_disconnect(psmouse);
-
-	/* We need to reopen the serio port to reinitialize the i8042 controller */
-	serio_close(psmouse->serio);
-	serio_open(psmouse->serio, ser_dev);
-
-	/* Probe and re-initialize the mouse */
-	psmouse_probe(psmouse);
-	psmouse_initialize(psmouse);
-	synaptics_pt_init(psmouse);
-	psmouse_activate(psmouse);
 
+#if 0
+	if (request == PM_RESUME) {
+		psmouse->state = PSMOUSE_IGNORE;
+		serio_reconnect(psmouse->serio);
+	}
+#endif
 	return 0;
 }
 
--- clean/drivers/input/serio/i8042.c	2003-09-28 22:05:48.000000000 +0200
+++ linux/drivers/input/serio/i8042.c	2003-11-21 22:30:27.000000000 +0100
@@ -18,6 +18,7 @@
 #include <linux/reboot.h>
 #include <linux/init.h>
 #include <linux/serio.h>
+#include <linux/sysdev.h>
 
 #include <asm/io.h>
 
@@ -398,18 +399,15 @@
  * desired.
  */
 	
-static int __init i8042_controller_init(void)
+static int i8042_controller_init(void)
 {
-
 /*
  * Test the i8042. We need to know if it thinks it's working correctly
  * before doing anything else.
  */
 
 	i8042_flush();
-
 	if (i8042_reset) {
-
 		unsigned char param;
 
 		if (i8042_command(&param, I8042_CMD_CTL_TEST)) {
@@ -783,6 +781,46 @@
 	values->mux = index;
 }
 
+static int i8042_resume_port(struct serio *port)
+{
+	struct serio_dev *dev = port->dev;
+	if (dev) {
+#if 1
+		/* Causes calling of hotplug, very bad */
+		dev->disconnect(port);
+		dev->connect(port, dev);
+#endif
+#if 0
+		/* Mouse works after this one, keyboard does not!? */
+		serio_close(port);
+		serio_open(port, dev);
+#endif
+#if 0
+		/* Mouse works after this one, keyboard does not!? */
+		serio_reconnect(port);
+#endif
+	}	
+}
+
+static int i8042_resume(struct sys_device *dev)
+{
+	if (i8042_controller_init())
+		printk(KERN_ERR "i8042: resume failed\n");
+//	i8042_resume_port(&i8042_aux_port);
+	i8042_resume_port(&i8042_kbd_port);
+	return 0;
+}
+
+static struct sysdev_class kbc_sysclass = {
+	set_kset_name("i8042"),
+	.resume = i8042_resume,
+};
+
+static struct sys_device device_i8042 = {
+	.id	= 0,
+	.cls	= &kbc_sysclass,
+};
+
 int __init i8042_init(void)
 {
 	int i;
@@ -819,6 +857,14 @@
 
 	register_reboot_notifier(&i8042_notifier);
 
+	{
+		int error = sysdev_class_register(&kbc_sysclass);
+		if (!error)
+			error = sys_device_register(&device_i8042);
+		if (error)
+			printk(KERN_CRIT "Unable to register i8042 to driver model\n");
+	}
+
 	return 0;
 }
 
--- clean/drivers/input/serio/serio.c	2003-09-28 22:05:48.000000000 +0200
+++ linux/drivers/input/serio/serio.c	2003-11-21 16:58:04.000000000 +0100
@@ -83,6 +83,7 @@
 }
 
 #define SERIO_RESCAN	1
+#define SERIO_RECONNECT	2
 
 static DECLARE_WAIT_QUEUE_HEAD(serio_wait);
 static DECLARE_COMPLETION(serio_exited);
@@ -111,6 +112,38 @@
 	}
 }
 
+static void serio_invalidate_pending_events(struct serio *serio)
+{
+	struct serio_event *event;
+
+	list_for_each_entry(event, &serio_event_list, node)
+		if (event->serio == serio)
+			event->serio = NULL;
+}
+
+static void serio_queue_event(struct serio *serio, int event_type)
+{
+	struct serio_event *event;
+
+	if ((event = kmalloc(sizeof(struct serio_event), GFP_ATOMIC))) {
+		event->type = event_type;
+		event->serio = serio;
+
+		list_add_tail(&event->node, &serio_event_list);
+		wake_up(&serio_wait);
+	}
+}
+
+void serio_rescan(struct serio *serio)
+{
+	serio_queue_event(serio, SERIO_RESCAN);
+}
+
+void serio_reconnect(struct serio *serio)
+{
+	serio_queue_event(serio, SERIO_RECONNECT);
+}
+
 static int serio_thread(void *nothing)
 {
 	lock_kernel();
@@ -130,20 +163,6 @@
 	complete_and_exit(&serio_exited, 0);
 }
 
-void serio_rescan(struct serio *serio)
-{
-	struct serio_event *event;
-
-	if (!(event = kmalloc(sizeof(struct serio_event), GFP_ATOMIC)))
-		return;
-
-	event->type = SERIO_RESCAN;
-	event->serio = serio;
-
-	list_add_tail(&event->node, &serio_event_list);
-	wake_up(&serio_wait);
-}
-
 irqreturn_t serio_interrupt(struct serio *serio,
 		unsigned char data, unsigned int flags, struct pt_regs *regs)
 {

-- 
When do you have a heart between your knees?
[Johanka's followup: and *two* hearts?]
