Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262264AbUKXHRH@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262264AbUKXHRH (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 24 Nov 2004 02:17:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262316AbUKXHPt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 24 Nov 2004 02:15:49 -0500
Received: from smtp810.mail.sc5.yahoo.com ([66.163.170.80]:58469 "HELO
	smtp810.mail.sc5.yahoo.com") by vger.kernel.org with SMTP
	id S262321AbUKXHOw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 24 Nov 2004 02:14:52 -0500
From: Dmitry Torokhov <dtor_core@ameritech.net>
To: Vojtech Pavlik <vojtech@suse.cz>
Subject: [PATCH 2/11] Psmouse polling for KVMs
Date: Wed, 24 Nov 2004 02:06:35 -0500
User-Agent: KMail/1.6.2
Cc: LKML <linux-kernel@vger.kernel.org>
References: <200411240205.10502.dtor_core@ameritech.net> <200411240206.05955.dtor_core@ameritech.net>
In-Reply-To: <200411240206.05955.dtor_core@ameritech.net>
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Message-Id: <200411240206.45763.dtor_core@ameritech.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


===================================================================


ChangeSet@1.1939.3.35, 2004-11-14 02:02:02-05:00, dtor_core@ameritech.net
  Input: pmouse - periodically ping the mouse to verify that device
         is still present. If there was no response assume that the
         mouse was disconnected and next time data comes in force
         reconnect to reinitialize the mouse. It is useful with KVM
         swiches that supress new device announcements.
  
         Pining is controlled via psmouse.ping_interval=<msec> module
         parameter and through sysfs ping_interval per-device attribute.
         Setting attribute to 0 disables polling (default).
  
  Signed-off-by: Dmitry Torokhov <dtor@mail.ru>


 Documentation/kernel-parameters.txt |    4 +
 drivers/input/mouse/psmouse-base.c  |   91 +++++++++++++++++++++++++++++++++++-
 drivers/input/mouse/psmouse.h       |    5 +
 3 files changed, 99 insertions(+), 1 deletion(-)


===================================================================



diff -Nru a/Documentation/kernel-parameters.txt b/Documentation/kernel-parameters.txt
--- a/Documentation/kernel-parameters.txt	2004-11-24 01:44:52 -05:00
+++ b/Documentation/kernel-parameters.txt	2004-11-24 01:44:52 -05:00
@@ -1005,6 +1005,10 @@
 			before loading.
 			See Documentation/ramdisk.txt.
 
+	psmouse.ping_interval=
+			[HW,MOUSE] Controls how often the driver should ping
+			the mouse to verify that device is still connected.
+			Useful with KVM switches.
 	psmouse.proto=  [HW,MOUSE] Highest PS2 mouse protocol extension to
 			probe for (bare|imps|exps).
 	psmouse.rate=	[HW,MOUSE] Set desired mouse report rate, in reports
diff -Nru a/drivers/input/mouse/psmouse-base.c b/drivers/input/mouse/psmouse-base.c
--- a/drivers/input/mouse/psmouse-base.c	2004-11-24 01:44:52 -05:00
+++ b/drivers/input/mouse/psmouse-base.c	2004-11-24 01:44:52 -05:00
@@ -52,6 +52,11 @@
 module_param_named(resetafter, psmouse_resetafter, uint, 0);
 MODULE_PARM_DESC(resetafter, "Reset device after so many bad packets (0 = never).");
 
+static unsigned int psmouse_ping_interval;
+module_param_named(ping_interval, psmouse_ping_interval, uint, 0);
+MODULE_PARM_DESC(ping_interval, "Ping interval to verify presence of the device (0 to disable).");
+
+PSMOUSE_DEFINE_ATTR(ping_interval);
 PSMOUSE_DEFINE_ATTR(rate);
 PSMOUSE_DEFINE_ATTR(resolution);
 PSMOUSE_DEFINE_ATTR(resetafter);
@@ -148,7 +153,28 @@
 	if (psmouse->state == PSMOUSE_IGNORE)
 		goto out;
 
-	if (flags & (SERIO_PARITY|SERIO_TIMEOUT)) {
+	if (unlikely(psmouse->state == PSMOUSE_LOST_PING_ACK)) {
+		printk(KERN_INFO "psmouse: new data from %s at %s, reconnecting...\n",
+			psmouse->name, psmouse->phys);
+		psmouse->state = PSMOUSE_IGNORE;
+		serio_reconnect(serio);
+		goto out;
+	}
+
+	if (unlikely(psmouse->state == PSMOUSE_WAIT_PING_ACK)) {
+		if ((flags & (SERIO_PARITY|SERIO_TIMEOUT)) ||
+		    data != PSMOUSE_RET_ACK) {
+			printk(KERN_INFO "psmouse.c: %s at %s not responding to pings\n",
+				psmouse->name, psmouse->phys);
+			psmouse->state = PSMOUSE_LOST_PING_ACK;
+		} else {
+			psmouse->state = PSMOUSE_ACTIVATED;
+			psmouse->pktcnt = 0;
+		}
+		goto out;
+	}
+
+	if (unlikely(flags & (SERIO_PARITY|SERIO_TIMEOUT))) {
 		if (psmouse->state == PSMOUSE_ACTIVATED)
 			printk(KERN_WARNING "psmouse.c: bad data from KBC -%s%s\n",
 				flags & SERIO_TIMEOUT ? " timeout" : "",
@@ -254,6 +280,29 @@
 }
 
 
+static void psmouse_ping_device(unsigned long p)
+{
+	struct psmouse *psmouse = (struct psmouse *)p;
+
+	if (!psmouse->ping_interval || psmouse->state != PSMOUSE_ACTIVATED)
+		return;
+
+	serio_pause_rx(psmouse->ps2dev.serio);
+
+	if (time_before(jiffies, psmouse->last + msecs_to_jiffies(psmouse->ping_interval))) {
+		/* we recently had some data, just reschedule timer */
+		mod_timer(&psmouse->ping_timer, psmouse->last + msecs_to_jiffies(psmouse->ping_interval));
+	} else if (serio_write(psmouse->ps2dev.serio, PSMOUSE_CMD_ENABLE) < 0) {
+		psmouse->state = PSMOUSE_IGNORE;
+		serio_reconnect(psmouse->ps2dev.serio);
+	} else {
+		psmouse->state = PSMOUSE_WAIT_PING_ACK;
+		mod_timer(&psmouse->ping_timer, jiffies + msecs_to_jiffies(psmouse->ping_interval));
+	}
+
+	serio_continue_rx(psmouse->ps2dev.serio);
+}
+
 /*
  * psmouse_reset() resets the mouse into power-on state.
  */
@@ -608,6 +657,15 @@
 			psmouse->ps2dev.serio->phys);
 
 	psmouse_set_state(psmouse, PSMOUSE_ACTIVATED);
+
+	/*
+	 * Only activate pinging on the device connected to parent port as
+	 * children ports have complex write routines not suitable for
+	 * calling from a tasklet. Also at least Synaptics slave responds
+	 * to commands only if parent is command mode as well.
+	 */
+	if (psmouse->ping_interval && !psmouse->ps2dev.serio->parent)
+		mod_timer(&psmouse->ping_timer, jiffies + msecs_to_jiffies(psmouse->ping_interval));
 }
 
 
@@ -645,12 +703,16 @@
 {
 	struct psmouse *psmouse, *parent;
 
+	if (!serio->parent)
+		device_remove_file(&serio->dev, &psmouse_attr_ping_interval);
 	device_remove_file(&serio->dev, &psmouse_attr_rate);
 	device_remove_file(&serio->dev, &psmouse_attr_resolution);
 	device_remove_file(&serio->dev, &psmouse_attr_resetafter);
 
 	psmouse = serio->private;
+
 	psmouse_set_state(psmouse, PSMOUSE_CMD_MODE);
+	del_timer_sync(&psmouse->ping_timer);
 
 	if (serio->parent && (serio->type & SERIO_TYPE) == SERIO_PS_PSTHRU) {
 		parent = serio->parent->private;
@@ -695,6 +757,9 @@
 	memset(psmouse, 0, sizeof(struct psmouse));
 
 	ps2_init(&psmouse->ps2dev, serio);
+	init_timer(&psmouse->ping_timer);
+	psmouse->ping_timer.data = (unsigned long)psmouse;
+	psmouse->ping_timer.function = psmouse_ping_device;
 	psmouse->dev.evbit[0] = BIT(EV_KEY) | BIT(EV_REL);
 	psmouse->dev.keybit[LONG(BTN_MOUSE)] = BIT(BTN_LEFT) | BIT(BTN_MIDDLE) | BIT(BTN_RIGHT);
 	psmouse->dev.relbit[0] = BIT(REL_X) | BIT(REL_Y);
@@ -716,6 +781,7 @@
 		goto out;
 	}
 
+	psmouse->ping_interval = psmouse_ping_interval;
 	psmouse->rate = psmouse_rate;
 	psmouse->resolution = psmouse_resolution;
 	psmouse->resetafter = psmouse_resetafter;
@@ -750,6 +816,8 @@
 	if (parent && parent->pt_activate)
 		parent->pt_activate(parent);
 
+	if (!parent)
+		device_create_file(&serio->dev, &psmouse_attr_ping_interval);
 	device_create_file(&serio->dev, &psmouse_attr_rate);
 	device_create_file(&serio->dev, &psmouse_attr_resolution);
 	device_create_file(&serio->dev, &psmouse_attr_resetafter);
@@ -884,6 +952,27 @@
 out:
 	serio_unpin_driver(serio);
 	return retval;
+}
+
+static ssize_t psmouse_attr_show_ping_interval(struct psmouse *psmouse, char *buf)
+{
+	return sprintf(buf, "%d\n", psmouse->ping_interval);
+}
+
+static ssize_t psmouse_attr_set_ping_interval(struct psmouse *psmouse, const char *buf, size_t count)
+{
+	unsigned long value;
+	char *rest;
+
+	value = simple_strtoul(buf, &rest, 10);
+	if (*rest)
+		return -EINVAL;
+
+	del_timer_sync(&psmouse->ping_timer);
+	psmouse->ping_interval = value;
+	/* psmouse_activate will restart the timer */
+
+	return count;
 }
 
 static ssize_t psmouse_attr_show_rate(struct psmouse *psmouse, char *buf)
diff -Nru a/drivers/input/mouse/psmouse.h b/drivers/input/mouse/psmouse.h
--- a/drivers/input/mouse/psmouse.h	2004-11-24 01:44:52 -05:00
+++ b/drivers/input/mouse/psmouse.h	2004-11-24 01:44:52 -05:00
@@ -25,6 +25,8 @@
 	PSMOUSE_INITIALIZING,
 	PSMOUSE_CMD_MODE,
 	PSMOUSE_ACTIVATED,
+	PSMOUSE_WAIT_PING_ACK,
+	PSMOUSE_LOST_PING_ACK,
 };
 
 /* psmouse protocol handler return codes */
@@ -55,6 +57,9 @@
 	unsigned int resolution;
 	unsigned int resetafter;
 	unsigned int smartscroll;	/* Logitech only */
+	unsigned int ping_interval;
+
+	struct timer_list ping_timer;
 
 	psmouse_ret_t (*protocol_handler)(struct psmouse *psmouse, struct pt_regs *regs);
 	void (*set_rate)(struct psmouse *psmouse, unsigned int rate);
