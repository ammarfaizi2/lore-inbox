Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263550AbUJ3FiU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263550AbUJ3FiU (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 30 Oct 2004 01:38:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263555AbUJ3FiU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 30 Oct 2004 01:38:20 -0400
Received: from smtp809.mail.sc5.yahoo.com ([66.163.168.188]:27050 "HELO
	smtp809.mail.sc5.yahoo.com") by vger.kernel.org with SMTP
	id S263550AbUJ3FiG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 30 Oct 2004 01:38:06 -0400
From: Dmitry Torokhov <dtor_core@ameritech.net>
To: linux-kernel@vger.kernel.org
Subject: KVMs & psmouse losing sync
Date: Sat, 30 Oct 2004 00:38:02 -0500
User-Agent: KMail/1.6.2
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Message-Id: <200410300038.04193.dtor_core@ameritech.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

Here is my next attempt at resolving the problem with psmouse losing sync
when used with KVMs that suppress psmouse announcements when switching back
to linux box.

The new parameter psmouse.poll is used to have the driver periodically send
"enable" command to the mouse if there was no data from the device in last
<poll> msec. If the command errors or times out the driver assumes that the
mouse was disconnected and next time there is data on the same serio port
the driver will attempt to reconnect.

The advantages of this approach is that it should work well regardless of
the protocol (normally it is very hard to differentiate between bare PS/2
and PS2++) and driver will not pass any bad packets to userpace. The main
cpms is that we're toast if KVM ACKs the command even when mouse/kbd are
connected to another box. 

The patch is against vanilla 2.6.9, boot with psmouse.poll=500. I would
appreciate comments/testing. Thanks!

-- 
Dmitry

diff -urN --exclude-from=/usr/src/exclude 2.6.9/drivers/input/mouse/psmouse-base.c linux-2.6.9/drivers/input/mouse/psmouse-base.c
--- 2.6.9/drivers/input/mouse/psmouse-base.c	2004-10-18 16:53:43.000000000 -0500
+++ linux-2.6.9/drivers/input/mouse/psmouse-base.c	2004-10-29 22:06:34.000000000 -0500
@@ -49,6 +49,10 @@
 module_param_named(resetafter, psmouse_resetafter, uint, 0);
 MODULE_PARM_DESC(resetafter, "Reset device after so many bad packets (0 = never).");
 
+static unsigned int psmouse_poll;
+module_param_named(poll, psmouse_poll, uint, 0);
+MODULE_PARM_DESC(poll, "Poll interval to verify presence of the device (0 to disable).");
+
 __obsolete_setup("psmouse_noext");
 __obsolete_setup("psmouse_resolution=");
 __obsolete_setup("psmouse_smartscroll=");
@@ -139,6 +143,24 @@
 	if (psmouse->state == PSMOUSE_IGNORE)
 		goto out;
 
+	if (unlikely(psmouse->state == PSMOUSE_LOST_HEARTBIT)) {
+		printk(KERN_INFO "psmouse: new data after losing heartbit, reconnecting...\n");
+		psmouse->state = PSMOUSE_IGNORE;
+		serio_reconnect(psmouse->serio);
+		goto out;
+	}
+
+	if (unlikely(psmouse->state == PSMOUSE_WAIT_HEARTBIT)) {
+		if ((flags & (SERIO_PARITY|SERIO_TIMEOUT)) ||
+		    data != PSMOUSE_RET_ACK) {
+			printk(KERN_INFO "psmouse.c: %s at %s lost heartbit\n",
+				psmouse->name, psmouse->phys);
+			psmouse->state = PSMOUSE_LOST_HEARTBIT;
+		} else
+			psmouse->state = PSMOUSE_ACTIVATED;
+		goto out;
+	}
+
 	if (flags & (SERIO_PARITY|SERIO_TIMEOUT)) {
 		if (psmouse->state == PSMOUSE_ACTIVATED)
 			printk(KERN_WARNING "psmouse.c: bad data from KBC -%s%s\n",
@@ -266,6 +288,31 @@
 	return IRQ_HANDLED;
 }
 
+static void psmouse_heartbit(unsigned long p)
+{
+	struct psmouse *psmouse = (struct psmouse *)p;
+
+	if (!psmouse_poll || psmouse->state != PSMOUSE_ACTIVATED)
+		return;
+
+	if (time_before(jiffies, psmouse->last + msecs_to_jiffies(psmouse_poll))) {
+		/* we recently had some data, just reschedule timer */
+		mod_timer(&psmouse->heartbit, psmouse->last + msecs_to_jiffies(psmouse_poll));
+	} else {
+		/* last data was long ago, ping the mouse */
+		serio_pause_rx(psmouse->serio);
+		if (serio_write(psmouse->serio, PSMOUSE_CMD_ENABLE) < 0) {
+			psmouse->state = PSMOUSE_IGNORE;
+			serio_continue_rx(psmouse->serio);
+			serio_reconnect(psmouse->serio);
+			return;
+		}
+		psmouse->state = PSMOUSE_WAIT_HEARTBIT;
+		serio_continue_rx(psmouse->serio);
+		mod_timer(&psmouse->heartbit, jiffies + msecs_to_jiffies(psmouse_poll));
+	}
+}
+
 /*
  * psmouse_sendbyte() sends a byte to the mouse, and waits for acknowledge.
  * It doesn't handle retransmission, though it could - because when there would
@@ -674,6 +721,9 @@
 		printk(KERN_WARNING "psmouse.c: Failed to enable mouse on %s\n", psmouse->serio->phys);
 
 	psmouse_set_state(psmouse, PSMOUSE_ACTIVATED);
+
+	if (psmouse_poll)
+		mod_timer(&psmouse->heartbit, jiffies + msecs_to_jiffies(psmouse_poll));
 }
 
 
@@ -711,7 +761,9 @@
 	struct psmouse *psmouse, *parent;
 
 	psmouse = serio->private;
+
 	psmouse_set_state(psmouse, PSMOUSE_CMD_MODE);
+	del_timer_sync(&psmouse->heartbit);
 
 	if (serio->parent && (serio->type & SERIO_TYPE) == SERIO_PS_PSTHRU) {
 		parent = serio->parent->private;
@@ -756,6 +808,9 @@
 	memset(psmouse, 0, sizeof(struct psmouse));
 
 	init_waitqueue_head(&psmouse->wait);
+	init_timer(&psmouse->heartbit);
+	psmouse->heartbit.data = (unsigned long)psmouse;
+	psmouse->heartbit.function = psmouse_heartbit;
 	init_input_dev(&psmouse->dev);
 	psmouse->dev.evbit[0] = BIT(EV_KEY) | BIT(EV_REL);
 	psmouse->dev.keybit[LONG(BTN_MOUSE)] = BIT(BTN_LEFT) | BIT(BTN_MIDDLE) | BIT(BTN_RIGHT);
diff -urN --exclude-from=/usr/src/exclude 2.6.9/drivers/input/mouse/psmouse.h linux-2.6.9/drivers/input/mouse/psmouse.h
--- 2.6.9/drivers/input/mouse/psmouse.h	2004-10-18 16:55:06.000000000 -0500
+++ linux-2.6.9/drivers/input/mouse/psmouse.h	2004-10-29 21:31:06.000000000 -0500
@@ -28,6 +28,8 @@
 	PSMOUSE_INITIALIZING,
 	PSMOUSE_CMD_MODE,
 	PSMOUSE_ACTIVATED,
+	PSMOUSE_WAIT_HEARTBIT,
+	PSMOUSE_LOST_HEARTBIT,
 };
 
 /* psmouse protocol handler return codes */
@@ -61,6 +63,8 @@
 	/* Used to signal completion from interrupt handler */
 	wait_queue_head_t wait;
 
+	struct timer_list heartbit;
+
 	psmouse_ret_t (*protocol_handler)(struct psmouse *psmouse, struct pt_regs *regs);
 	int (*reconnect)(struct psmouse *psmouse);
 	void (*disconnect)(struct psmouse *psmouse);
