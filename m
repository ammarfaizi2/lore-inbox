Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262186AbTIRXoT (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 18 Sep 2003 19:44:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262185AbTIRXoS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 18 Sep 2003 19:44:18 -0400
Received: from smtp4.hy.skanova.net ([195.67.199.133]:29398 "EHLO
	smtp4.hy.skanova.net") by vger.kernel.org with ESMTP
	id S262243AbTIRXnU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 18 Sep 2003 19:43:20 -0400
Date: Fri, 19 Sep 2003 01:43:11 +0200 (CEST)
From: Peter Osterlund <petero2@telia.com>
X-X-Sender: petero@p4.localdomain
To: Linus Torvalds <torvalds@osdl.org>
cc: Vojtech Pavlik <vojtech@suse.cz>, <linux-kernel@vger.kernel.org>
Subject: Re: Broken synaptics mouse..
In-Reply-To: <Pine.LNX.4.44.0309110744030.28410-100000@home.osdl.org>
Message-ID: <Pine.LNX.4.44.0309190129170.32637-100000@telia.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 11 Sep 2003, Linus Torvalds wrote:

> Actually, I think I've changed my mind.
> 
> How hard would it be to have the "event" driver _notice_ when somebody is 
> trying to use it?
> 
> In particular, what about something that
>  - just keeps the touchpad in "ps/2 compatibility mode" by default
>  - moves to absolute mode only if somebody actually uses the 
>    /dev/input/event0 thing for it (and that would obviously disable the 
>    ps/2 mode).
> 
> That sounds like the simpler setup, especially since the touchpad does a 
> pretty good job of PS/2 emulation on its own..

What do you think about the following patch? This patch makes the touchpad
stay in compatibility mode until user space explicitly asks for absolute
mode by sending a SYN_CONFIG event with value != 0 to the synaptics event
device.

I think this patch will apply on top of Vojtech's private tree, but I have
lost track of what patches he said he has applied. Anyway, the whole patch
series (14 patches) is available here:

http://w1.894.telia.com/~u89404340/patches/touchpad/2.6.0-test5-bk5/v1/

I dropped the "synaptics_optional" patch, because there should not be any
need for the config option now that we have backwards compatibility by
default.


 linux-petero/drivers/input/mouse/psmouse-base.c |    2 
 linux-petero/drivers/input/mouse/psmouse.h      |    1 
 linux-petero/drivers/input/mouse/synaptics.c    |   62 ++++++++++++++++++++++--
 linux-petero/drivers/input/mouse/synaptics.h    |    4 +
 4 files changed, 63 insertions(+), 6 deletions(-)

diff -puN drivers/input/mouse/synaptics.c~synaptics-absolute-on-demand drivers/input/mouse/synaptics.c
--- linux/drivers/input/mouse/synaptics.c~synaptics-absolute-on-demand	2003-09-19 01:05:43.000000000 +0200
+++ linux-petero/drivers/input/mouse/synaptics.c	2003-09-19 01:05:43.000000000 +0200
@@ -223,9 +223,11 @@ static int synaptics_set_mode(struct psm
 		mode |= SYN_BIT_DISABLE_GESTURE;
 	if (SYN_CAP_EXTENDED(priv->capabilities))
 		mode |= SYN_BIT_W_MODE;
-	if (synaptics_mode_cmd(psmouse, mode))
-		return -1;
+	priv->abs_mode_bits = mode;
 
+	if (priv->abs_mode_enabled)
+		if (synaptics_mode_cmd(psmouse, mode))
+			return -1;
 	return 0;
 }
 
@@ -323,6 +325,33 @@ static inline void set_abs_params(struct
 	set_bit(axis, dev->absbit);
 }
 
+static int synaptics_event(struct input_dev *dev, unsigned int type, unsigned int code, int value)
+{
+	struct psmouse *psmouse = dev->private;
+	struct synaptics_data *priv = psmouse->private;
+
+	if ((type != EV_SYN) || (code != SYN_CONFIG))
+		return -1;
+
+	if (!value) {
+		priv->abs_mode_enabled = 0;
+		printk(KERN_INFO "synaptics: Enable relative mode\n");
+		if (synaptics_mode_cmd(psmouse, 0)) {
+			printk(KERN_ERR "synaptics: Couldn't enable relative mode.\n");
+			return -1;
+		}
+	} else {
+		priv->abs_mode_enabled = 1;
+		printk(KERN_INFO "synaptics: Enable absolute mode\n");
+		if (synaptics_set_mode(psmouse, priv->abs_mode_bits)) {
+			printk(KERN_ERR "synaptics: Couldn't enable absolute mode.\n");
+			return -1;
+		}
+	}
+
+	return 0;
+}
+
 static void set_input_params(struct input_dev *dev, struct synaptics_data *priv)
 {
 	/*
@@ -340,6 +369,7 @@ static void set_input_params(struct inpu
 
 	set_bit(EV_KEY, dev->evbit);
 	set_bit(BTN_LEFT, dev->keybit);
+	set_bit(BTN_MIDDLE, dev->keybit);
 	set_bit(BTN_RIGHT, dev->keybit);
 	set_bit(BTN_FORWARD, dev->keybit);
 	set_bit(BTN_BACK, dev->keybit);
@@ -367,9 +397,13 @@ static void set_input_params(struct inpu
 		}
 	}
 
-	clear_bit(EV_REL, dev->evbit);
-	clear_bit(REL_X, dev->relbit);
-	clear_bit(REL_Y, dev->relbit);
+	set_bit(EV_REL, dev->evbit);
+	set_bit(REL_X, dev->relbit);
+	set_bit(REL_Y, dev->relbit);
+
+	set_bit(BTN_TRIGGER, dev->keybit);  /* Makes mousedev.c ignore ABS events */
+
+	dev->event = synaptics_event;
 }
 
 static void synaptics_disconnect(struct psmouse *psmouse)
@@ -433,6 +467,12 @@ int synaptics_init(struct psmouse *psmou
 	psmouse->disconnect = synaptics_disconnect;
 	psmouse->reconnect = synaptics_reconnect;
 
+	/*
+	 * Now restore relative mode. To stay compatible with legacy user space
+	 * drivers, absolute mode is only enabled when explicitly asked for.
+	 */
+	synaptics_mode_cmd(psmouse, 0);
+
 	return 0;
 
  init_fail:
@@ -597,6 +637,18 @@ void synaptics_process_byte(struct psmou
 	unsigned char data = psmouse->packet[psmouse->pktcnt - 1];
 	int newabs = SYN_MODEL_NEWABS(priv->model_id);
 
+	if (!priv->abs_mode_enabled) {
+		/*
+		 * Touchpad is in relative mode. Parse packet using the standard
+		 * PS/2 protocol.
+		 */
+		if (psmouse->pktcnt == 3) {
+			psmouse_process_packet(psmouse, regs);
+			psmouse->pktcnt = 0;
+		}
+		return;
+	}
+
 	input_regs(dev, regs);
 
 	switch (psmouse->pktcnt) {
diff -puN drivers/input/mouse/psmouse-base.c~synaptics-absolute-on-demand drivers/input/mouse/psmouse-base.c
--- linux/drivers/input/mouse/psmouse-base.c~synaptics-absolute-on-demand	2003-09-19 01:05:43.000000000 +0200
+++ linux-petero/drivers/input/mouse/psmouse-base.c	2003-09-19 01:05:43.000000000 +0200
@@ -48,7 +48,7 @@ static char *psmouse_protocols[] = { "No
  * reports relevant events to the input module.
  */
 
-static void psmouse_process_packet(struct psmouse *psmouse, struct pt_regs *regs)
+void psmouse_process_packet(struct psmouse *psmouse, struct pt_regs *regs)
 {
 	struct input_dev *dev = &psmouse->dev;
 	unsigned char *packet = psmouse->packet;
diff -puN drivers/input/mouse/synaptics.h~synaptics-absolute-on-demand drivers/input/mouse/synaptics.h
--- linux/drivers/input/mouse/synaptics.h~synaptics-absolute-on-demand	2003-09-19 01:05:43.000000000 +0200
+++ linux-petero/drivers/input/mouse/synaptics.h	2003-09-19 01:05:43.000000000 +0200
@@ -100,6 +100,10 @@ struct synaptics_data {
 	unsigned long int ext_cap; 		/* Extended Capabilities */
 	unsigned long int identity;		/* Identification */
 
+	int abs_mode_enabled;			/* Non-zero when in absolute mode */
+	int abs_mode_bits;			/* The mode bits to send to the touchpad
+						 * when enabling absolute mode */
+
 	/* Data for normal processing */
 	unsigned int out_of_sync;		/* # of packets out of sync */
 	int old_w;				/* Previous w value */
diff -puN drivers/input/mouse/psmouse.h~synaptics-absolute-on-demand drivers/input/mouse/psmouse.h
--- linux/drivers/input/mouse/psmouse.h~synaptics-absolute-on-demand	2003-09-19 01:05:43.000000000 +0200
+++ linux-petero/drivers/input/mouse/psmouse.h	2003-09-19 01:05:43.000000000 +0200
@@ -64,6 +64,7 @@ struct psmouse {
 #define PSMOUSE_IMEX		6
 #define PSMOUSE_SYNAPTICS 	7
 
+void psmouse_process_packet(struct psmouse *psmouse, struct pt_regs *regs);
 int psmouse_command(struct psmouse *psmouse, unsigned char *param, int command);
 
 extern int psmouse_smartscroll;

_

-- 
Peter Osterlund - petero2@telia.com
http://w1.894.telia.com/~u89404340

